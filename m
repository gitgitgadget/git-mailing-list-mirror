From: "Craig L. Ching" <cching@mqsoftware.com>
Subject: RE: Monotone workflow compared to Git workflow ( was RE: Git vs Monotone)
Date: Thu, 31 Jul 2008 15:37:30 -0500
Message-ID: <63BEA5E623E09F4D92233FB12A9F79430238A5FF@emailmn.mqsoftware.com>
References: <bd6139dc0807311113n50dda9f0t1aab46b724510de2@mail.gmail.com> <alpine.LFD.1.10.0807311211260.3277@nehalem.linux-foundation.org> <63BEA5E623E09F4D92233FB12A9F79430238A5EE@emailmn.mqsoftware.com> <alpine.LFD.1.10.0807311253140.3277@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "Git Mailinglist" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 31 22:39:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOew3-00022z-4p
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 22:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754227AbYGaUin (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 16:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754154AbYGaUin
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 16:38:43 -0400
Received: from emailmn.mqsoftware.com ([66.192.70.108]:58864 "EHLO
	emailmn.mqsoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753595AbYGaUil convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Jul 2008 16:38:41 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <alpine.LFD.1.10.0807311253140.3277@nehalem.linux-foundation.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Monotone workflow compared to Git workflow ( was RE: Git vs Monotone)
Thread-Index: AcjzSZ4Oxnscxd3+TMuEc424QVVH3wAAmgag
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90984>


> From: Linus Torvalds [mailto:torvalds@linux-foundation.org] 
> Sent: Thursday, July 31, 2008 3:09 PM
> 
> Sure, if you want to keep the build tree around, you would 
> probably not use branches. 
> 

I think we'd still use branches, but we just need to isolate their
workdirs from each other.

> But yes, then you'd likely do "git clone -s" with some single 
> "common point" or use "git worktree". And even if you don't 
> use "-s", you should _still_ effectively share at least all 
> the old history (which tends to be the bulk) thanks to even a 
> default "git clone" will just hardlink the pack-files.
> 
> So literally, if you do
> 
> 	git clone <cntral-repo-over-network> <local>
> 
> and then do
> 
> 	git clone <local> <otherlocal>
> 	git clone <local> <thirdlocal>
> 
> then all of those will all share the initial pack-file 
> on-disk. Try it.
> 
> (You may then want to edit the "origin" branch info in the 
> .git/config to point to the network one etc, of course).
> 

Yes, thank you for the explanation.  Having used git a fair amount now,
that makes perfect sense to me, in fact, it sounds a lot like
git-new-workdir, but I think I'll change our use of git-new-workdir to
something more "core" git.  It seems to me that maybe this is something
that could be documented more prominently?  Or maybe it is and I've just
missed it.  This would have saved me a lot of time originally to be
sure.

> Oh, and to make sure I'm not lying I actually did test this, 
> but I also noticed that "git clone" no longer marks the 
> initial pack-file with "keep", so it looks like "git gc" will 
> then break the link. That's sad. I wonder when that changed, 
> or maybe I'm just confused and it never did.
> 

What's the consequence of that then?  Because of that, would you say
"don't gc your master local repo until all derived repos are merged?"
If that link is broken is it just a loss of space? Or is it more?

> 		Linus
> 

Thanks again!

Cheers,
Craig
