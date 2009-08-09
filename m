From: Nicolas Pitre <nico@cam.org>
Subject: Re: git gc expanding packed data?
Date: Sat, 08 Aug 2009 22:56:57 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908082246020.440@xanadu.home>
References: <m2tz0j154o.fsf@igel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Hin-Tak Leung <hintak.leung@gmail.com>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sun Aug 09 04:57:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZyay-0005FK-Ng
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 04:57:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753226AbZHIC5F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 22:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753081AbZHIC5E
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 22:57:04 -0400
Received: from relais.videotron.ca ([24.201.245.36]:26212 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752715AbZHIC5B (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 22:57:01 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KO300G3V9IXOV30@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 08 Aug 2009 22:56:57 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <m2tz0j154o.fsf@igel.home>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125318>

On Sat, 8 Aug 2009, Andreas Schwab wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > It appears that the git installation serving clone requests for
> > git://gcc.gnu.org/git/gcc.git generates lots of unreferenced objects. I
> > just cloned it and the pack I was sent contains 1383356 objects (can be
> > determined with 'git show-index < .git/objects/pack/*.idx | wc -l').
> > However, there are only 978501 actually referenced objects in that
> > cloned repository ( 'git rev-list --all --objects | wc -l').  That makes
> > for 404855 useless objects in the cloned repository.
> 
> Those objects are not useless.  They are referenced by the remote refs
> on the remote side, which are not fetched by default.  If you clone a
> mirror of the repository you'll see no unreferenced objects.

If you do a clone using the git:// protocol and the server sends you 
only the ref for the trunk branch, then it should send you only objects 
reachable from that branch.  Any extra objects sent by the server are 
useless to me and wastes my and everyone else's bandwidth, and on my 
next repack those objects are pruned anyway.  The point of the git 
protocol is _not_ necessarily to send a copy of the remote pack file 
over, even during a clone.


Nicolas
