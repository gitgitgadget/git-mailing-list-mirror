X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: GIT - error: no such remote ref refs/heads/TestBranch
Date: Tue, 19 Dec 2006 14:06:03 -0800
Message-ID: <7v64c7pmlw.fsf@assigned-by-dhcp.cox.net>
References: <89b129c60612191233s5a7f36f2hd409c4b9a2bbbc5c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 19 Dec 2006 22:06:16 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <89b129c60612191233s5a7f36f2hd409c4b9a2bbbc5c@mail.gmail.com>
	(Sean Kelley's message of "Tue, 19 Dec 2006 14:33:07 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34856>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gwn6B-0008VX-D2 for gcvg-git@gmane.org; Tue, 19 Dec
 2006 23:06:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933036AbWLSWGH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 17:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933037AbWLSWGH
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 17:06:07 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:54593 "EHLO
 fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S933036AbWLSWGG (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 17:06:06 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061219220604.IGUP22053.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>; Tue, 19
 Dec 2006 17:06:04 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id 0m5N1W00g1kojtg0000000; Tue, 19 Dec 2006
 17:05:23 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

"Sean Kelley" <sean.v.kelley@gmail.com> writes:

> Hi,
>
> I was wondering if someone could help me.  I had a branch on our
> remote GIT server called TestBranch.  I logged into the Remote server
> and ran:
>
> <from remote server>
> git branch -D TestBranch
>
> But in my local clone:
>
> kelleys@oifig:~/Work/kernel$ git pull origin
> kelleys@git.example.com's password:
> error: no such remote ref refs/heads/TestBranch
> Fetch failure: git+ssh://git.example.com/data/git/proj/kernel/mh.git
> kelleys@oifig:~/Work/kernel$
>
> Any ideas how to correct this?

If you know remote does not have it, then probably not fetching
from it would be a good idea.

Look at your local $GIT_DIR/remotes/origin (or [remote "origin"]
section in $GIT_DIR/config) and remove the refspec that tells
git to fetch it.

In $GIT_DIR/remotes/origin, you may want to remove a like like this:

	Pull: refs/heads/TestBranch:<something>

If it is coming from $GIT_DIR/config, it would probably look
like:

	[remote "origin"]
        	fetch = refs/heads/TestBranch:<something>

and you would want to remove the "fetch = " line.
