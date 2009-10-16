From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached HEAD
 was
Date: Fri, 16 Oct 2009 16:19:26 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0910161557500.20122@xanadu.home>
References: <76718490910141156g440ee455t2e1db72ad72b7049@mail.gmail.com>
 <alpine.LNX.2.00.0910141509200.32515@iabervon.org>
 <alpine.LFD.2.00.0910141616530.20122@xanadu.home>
 <7v7huxbtbk.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0910141647390.20122@xanadu.home>
 <7vws2xa9lu.fsf@alter.siamese.dyndns.org>
 <20091014230934.GC29664@coredump.intra.peff.net>
 <885649360910150036o72c3bd97ofad85d5316dc5b35@mail.gmail.com>
 <alpine.LNX.2.00.0910151523020.32515@iabervon.org>
 <alpine.LNX.2.00.0910161311460.28491@reaper.quantumfyre.co.uk>
 <20091016143041.GA11821@atjola.homenet>
 <alpine.LNX.2.00.0910161821230.30589@reaper.quantumfyre.co.uk>
 <7vvdiftb0d.fsf@alter.siamese.dyndns.org>
 <alpine.LNX.2.00.0910162029460.31673@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	James Pickens <jepicken@gmail.com>, Jeff King <peff@peff.net>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Fri Oct 16 23:14:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Myu7f-0005PN-Fj
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 23:14:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbZJPVNw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 17:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbZJPVNw
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 17:13:52 -0400
Received: from relais.videotron.ca ([24.201.245.36]:45841 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072AbZJPVNw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 17:13:52 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KRM00KCFJ4E9P10@VL-MR-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 16 Oct 2009 16:19:26 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LNX.2.00.0910162029460.31673@reaper.quantumfyre.co.uk>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130527>

On Fri, 16 Oct 2009, Julian Phillips wrote:

> My interest in this thread is solely that it might provide a mechanism to find
> out which tag was checked out.  So, I'm just chucking in my $0.02 as a user.

Try this:

$ git checkout v1.5.5
Note: moving to 'v1.5.5' which isn't a local branch
If you want to create a new branch from this checkout, you may do so
(now or later) by using -b with the checkout command again. Example:
  git checkout -b <new_branch_name>
HEAD is now at 1d2375d... GIT 1.5.5

[look around, and then ...]

$ git checkout HEAD~2
Previous HEAD position was 1d2375d... GIT 1.5.5
HEAD is now at f61cc48... git-svn: fix following renamed paths when tracking a single path

[go out for lunch ... and forget what this was about.]

$ git reflog -3
f61cc48 HEAD@{0}: checkout: moving from 1d2375d... to HEAD~2
1d2375d HEAD@{1}: checkout: moving from master to v1.5.5
c274db7 HEAD@{2}: pull : Fast forward

Here I have all the information to see what I did, and from what state.  
I even know that I did a pull on the master branch before moving away 
from it.  The -3 limits the log to 3 entries.  With no limit you get it 
all in your default pager.

So there is no need for another mechanism to find out what tag was 
actually checked out -- you have it all already.


Nicolas
