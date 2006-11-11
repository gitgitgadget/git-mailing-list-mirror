X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: check if a commit is ascendent of a specific commit
Date: Sat, 11 Nov 2006 10:43:47 -0800
Message-ID: <7virhlken0.fsf@assigned-by-dhcp.cox.net>
References: <fcaeb9bf0611110308l577d70bfo5046d7d7eb09ac58@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 11 Nov 2006 18:44:00 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <fcaeb9bf0611110308l577d70bfo5046d7d7eb09ac58@mail.gmail.com>
	(Nguyen Thai Ngoc Duy's message of "Sat, 11 Nov 2006 18:08:56 +0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31236>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GixpY-0004Tn-V0 for gcvg-git@gmane.org; Sat, 11 Nov
 2006 19:43:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424601AbWKKSnu (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 11 Nov 2006
 13:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424602AbWKKSnt
 (ORCPT <rfc822;git-outgoing>); Sat, 11 Nov 2006 13:43:49 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:6840 "EHLO
 fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP id S1424601AbWKKSns
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 11 Nov 2006 13:43:48 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061111184348.MKVL5575.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>; Sat, 11
 Nov 2006 13:43:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id lWjt1V00R1kojtg0000000; Sat, 11 Nov 2006
 13:43:54 -0500
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Sender: git-owner@vger.kernel.org

"Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:

> Hi,
> I want to create "git-amend-commit" to be able to amend commits before
> HEAD. So I need to check whether the commit I'm going to amend is
> ascendent of HEAD. Is there any way to check that?

Ascendant is a word from astorology -- you mean ancestor ;-).

"git-merge-base A B === A" when A is an ancestor of B.

Provided if the history between A and B is linear, and you do
not have trouble making your co-workers adjusting to your
history change after A (including the cases where you do not
have any co-workers or you have not made history between A and B
public), you could do one of these three things:

 - use "stg uncommit" until you pop A, make a change there and
   "stg refresh", and then "stg push" everything back.

 - "git format-patch A && git reset --hard A", edit the patches
   and then "git am" them.

 - "git tag -f Anchor && git reset --hard A", edit and "git
   commit --amend".  Look at "git show-branch Anchor HEAD", and
   repeatedly "git cherry-pick Anchor~$n" from older to newer
   from Anchor, and then "git tag -d Anchor".





