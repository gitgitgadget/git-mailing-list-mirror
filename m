From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Switching from CVS to GIT
Date: Tue, 16 Oct 2007 13:04:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0710161201320.7638@iabervon.org>
References: <1192293466.17584.95.camel@homebase.localnet> <uy7e6keyv.fsf@gnu.org>
 <1192381040.4908.57.camel@homebase.localnet> <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr>
 <47125F74.9050600@op5.se> <Pine.LNX.4.64.0710141934310.25221@racer.site>
 <47126957.1020204@op5.se> <Pine.LNX.4.64.0710142112540.25221@racer.site>
 <20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org>
 <Pine.LNX.4.64.0710151859590.7638@iabervon.org> <uodezisvg.fsf@gnu.org>
 <Pine.LNX.4.64.0710160032020.7638@iabervon.org> <E1IhgT2-0000bg-O6@fencepost.gnu.org>
 <Pine.LNX.4.64.0710161335260.25221@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Eli Zaretskii <eliz@gnu.org>, raa.lkml@gmail.com, ae@op5.se,
	tsuna@lrde.epita.fr, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 16 19:05:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihpql-00008i-Sp
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 19:05:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755190AbXJPREY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 13:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754065AbXJPREY
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 13:04:24 -0400
Received: from iabervon.org ([66.92.72.58]:54113 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753958AbXJPREX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 13:04:23 -0400
Received: (qmail 31965 invoked by uid 1000); 16 Oct 2007 17:04:21 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Oct 2007 17:04:21 -0000
In-Reply-To: <Pine.LNX.4.64.0710161335260.25221@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61214>

On Tue, 16 Oct 2007, Johannes Schindelin wrote:

> Hi,
> 
> [culled make-w32, as per explicit request]
> 
> On Tue, 16 Oct 2007, Eli Zaretskii wrote:
> 
> > > Date: Tue, 16 Oct 2007 01:56:46 -0400 (EDT)
> > > From: Daniel Barkalow <barkalow@iabervon.org>
> > > cc: raa.lkml@gmail.com, Johannes.Schindelin@gmx.de, ae@op5.se, 
> > >     tsuna@lrde.epita.fr, git@vger.kernel.org, make-w32@gnu.org
> > > 
> > > Ah, that's helpful. We don't actually care too much about the 
> > > particular info in stat; we just want to know quickly if the file has 
> > > changed, so we can hash only the ones that have been touched and get 
> > > the actual content changes.
> > 
> > As I wrote in my other message, using native APIs improves performance 
> > by at least a factor of two.
> 
> Somehow this does not appeal to my "portability is good" side.  You know, 
> if we had to do such trickeries for every platform we support, we'd soon 
> be as big as Subversion *cough*.

I think that it would be a worthwhile project, from the point of view of 
making the code easier to follow and making the internal APIs clearer, to 
organize git's source to abstract the object database to read_sha1_file(), 
has_sha1_file(), hash_sha1_file(), and write_sha1_file() as the arbiters 
of what is in the local database (with other functions public as support 
for over-the-wire protocols, which may, by not-really-coincidence, by used 
for local storage as well); then Windows could have an entirely different 
storage mechanism that doesn't rely on filesystem metadata speed.

It would also be worthwhile to untangle the index's stat cache aspects and 
its tree-object-related aspects, so that there can be a platform- and 
repository-specific concept of how to handle the working area, and then 
Windows could do different stuff for the default case of setting up a 
directory on the local filesystem.

	-Daniel
*This .sig left intentionally blank*
