From: Jan Wielemaker <wielemak@science.uva.nl>
Subject: Re: git-cvsserver commit trouble (unexpected end of file in client)
Date: Thu, 4 Oct 2007 09:27:03 +0200
Message-ID: <200710040927.03977.wielemak@science.uva.nl>
References: <200710031348.50800.wielemak@science.uva.nl> <200710032325.55128.wielemak@science.uva.nl> <Pine.LNX.4.64.0710032311480.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 04 09:27:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdL7A-00016d-LR
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 09:27:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755734AbXJDH1K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 03:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755508AbXJDH1J
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 03:27:09 -0400
Received: from smtp-vbr6.xs4all.nl ([194.109.24.26]:4917 "EHLO
	smtp-vbr6.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754550AbXJDH1H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 03:27:07 -0400
Received: from ct.xs4all.nl (ct.xs4all.nl [82.92.39.12])
	by smtp-vbr6.xs4all.nl (8.13.8/8.13.8) with ESMTP id l947R4na059794;
	Thu, 4 Oct 2007 09:27:04 +0200 (CEST)
	(envelope-from wielemak@science.uva.nl)
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.64.0710032311480.28395@racer.site>
Content-Disposition: inline
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59927>

Hi Dscho,

Thanks for the comments.  I'll keep in on the list, just in case there is
someone else with a brilliant idea.

On Thursday 04 October 2007 00:14, you wrote:
> Hi,
>
> On Wed, 3 Oct 2007, Jan Wielemaker wrote:
> > On Wednesday 03 October 2007 20:55, you wrote:
> > > On Wed, 3 Oct 2007, Jan Wielemaker wrote:
> > > > On Wednesday 03 October 2007 18:11, Johannes Schindelin wrote:
> > > > > Hi,
> > > > >
> > > > > On Wed, 3 Oct 2007, Jan Wielemaker wrote:
> > > > > > 2007-10-03 12:25:16 : WARN - error 1 pserver cannot find the
> > > > > > current HEAD of module
> > > > >
> > > > > AFAIR we do not allow committing via pserver protocol.  Might that
> > > > > be your problem?
> > > >
> > > > Thanks, but no. I'm using CVS over SSH. I've been looking around in
> > > > git-cvsserver source a bit and it aborts quite quickly if you try a
> > > > commit through pserver. I get a bit further, but it cannot find the
> > > > HEAD revision for some reason and (from later message), if I try to
> > > > checkout master instead of HEAD it finds the revision but I get a
> > > > hash mismatch.
> > >
> > > Okay, another stab: is your HEAD detached?
> >
> > I'm a humble git beginner, though I think *my* head is still attached
> > :-) In any case, we are talking a fresh repository and I can perfectly
> > well clone it as well as pull and push from the clone using GIT
> > commands. How do I tell whether the HEAD is detached?
>
> You can tell by looking into .git/HEAD (on the side that runs the server).
> If it is a 40-character hex string, the HEAD is detached.  Otherwise, it
> should contain something like "refs/heads/master".

Its the latter, so my HEAD is still attached. I hope I understand this
correctly, but browsing the docs suggests a detached head is not really
a normal situation, so I'm fine.  Right?

> Other reasons for the failure could be:
>
> 	- your user does not have write access

Definitely ok (also put an strace -o logfile git-cvsserver "$@" script
around it.  No alarming permission or non-existence errors).

> 	- the uid under which git-cvsserver runs has no write access

See above

> 	- you found an error that only triggers with your repo

Great!  Its so damn simple and and tried with three repos created
in three different ways, that I'm either extremely unlucky or many
more should be faced with this or nobody uses git-cvsserver.

I'm hoping for a command-by-command sequence that gets me a definitely
fine repository, so at least I can see it running correctly once.  Then
maybe I can analyse traces in detail to see where they differ and what
is wrong.  Somebody?

	Thanks --- Jan
