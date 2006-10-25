X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix bad usage of mkpath in builtin-branch.sh
Date: Tue, 24 Oct 2006 21:46:37 -0700
Message-ID: <7vslhddmtu.fsf@assigned-by-dhcp.cox.net>
References: <1161655176461-git-send-email-hjemli@gmail.com>
	<7vlkn6qkh2.fsf@assigned-by-dhcp.cox.net>
	<20061024113806.GB20017@pasky.or.cz>
	<7vac3lf3jl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 25 Oct 2006 04:47:01 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vac3lf3jl.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 24 Oct 2006 21:00:14 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30031>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gcaf5-0001vn-5Q for gcvg-git@gmane.org; Wed, 25 Oct
 2006 06:46:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422969AbWJYEqk (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 00:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422971AbWJYEqj
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 00:46:39 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:42150 "EHLO
 fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP id S1422969AbWJYEqi
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 00:46:38 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061025044638.UTGK22977.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>; Wed, 25
 Oct 2006 00:46:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id eUmM1V00F1kojtg0000000 Wed, 25 Oct 2006
 00:46:21 -0400
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> Petr Baudis <pasky@suse.cz> writes:
>
>> I have made my fair share of inadverent mode changes as well (I don't
>> even know how that *happenned*), and I don't seem to be alone; since
>> this is something you are doing only rarely anyway, perhaps we should
>> try to make mode changes more visible?
>
> Well we already do and that's how I noticed.

Ah, sorry, I think I misunderstood you.
Did you mean something like this?

diff --git a/git-commit.sh b/git-commit.sh
index 5b1cf85..8bae734 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -629,4 +629,7 @@ if test -x "$GIT_DIR"/hooks/post-commit
 then
 	"$GIT_DIR"/hooks/post-commit
 fi
+
+test "$ret" = 0 && git-diff-tree --summary --root --no-commit-id HEAD
+
 exit "$ret"
