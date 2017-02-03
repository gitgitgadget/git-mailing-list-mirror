Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E38F71F6BD
	for <e@80x24.org>; Fri,  3 Feb 2017 18:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751273AbdBCS2n (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Feb 2017 13:28:43 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35092 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751129AbdBCS2m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2017 13:28:42 -0500
Received: by mail-pg0-f66.google.com with SMTP id 204so2589866pge.2
        for <git@vger.kernel.org>; Fri, 03 Feb 2017 10:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Q8GaD8qSflXVheITieiyav9e/y73/iXB657tf3q1Lpw=;
        b=s2phBwWGxzAKAD15GdvwnqyskXnBDoScZDVTeJANnAbhyGaOqyrt2GXW+rfcxAAN30
         O7qY2pVbtU+ipd7UipBsPuYI068U5lShfkikPF/E1fUl518AaSfvyBHjrJWYtHKzxP9g
         5iF6JvyNYFGkvyD8y7HCZ2bs9y3vv5gyUzdv0GZhgGkeyfkSqG3tB+CthlmMe/Q46pwg
         tkRn/1EJchqK0vHF5b3vzKc93EzFYYlSxjpNpS+9vcCUcFeMxjSRJwF639w+ELx7h9HZ
         +TpvFfpi6BP4BQcbB9MJ+N1j8CO5I9iS7TBItdqAPnsnc/I9cOvnvHUb806obyBKKjUu
         jcYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Q8GaD8qSflXVheITieiyav9e/y73/iXB657tf3q1Lpw=;
        b=a02MHYNHS/FvSGe63PjlmYYdq70bMzw4I7nqu0qlVSlvhMOjVfEkXr1EgKT6vrHnM+
         J4NogzfLzOlzbKzKVPVwZ3xkHzkGnA3npJtGM4lhaL4aTXXrV6WGlfV1h4sri7tiuMIN
         atufq7O8oCPtZOU9iZLow3krG1He/0XCPnAFibkABKkXyqNCxeG4il+/8lJ24YuxC3II
         o4HBE9m9MQ73RMQIejnC+z/59PBYoxxPmT50AVO+RLo4b8Gi95X4P7HpqHhcADQ7BCw1
         wYQUV84CvMEou8ISu5rAz1CSFquW6We8s6rkU7mVnMSVFC983T1QyM3RPBFULldSPAgP
         h2rg==
X-Gm-Message-State: AIkVDXIE/pIlqCI3J4OZ+9IRyGIjYnpNt/QsR2pim5RiLBYK6q/L732T+EgVuX1p3p7JjQ==
X-Received: by 10.84.138.165 with SMTP id 34mr22968163plp.37.1486146521994;
        Fri, 03 Feb 2017 10:28:41 -0800 (PST)
Received: from localhost ([139.59.1.28])
        by smtp.gmail.com with ESMTPSA id p66sm68828508pfb.88.2017.02.03.10.28.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Feb 2017 10:28:41 -0800 (PST)
From:   Siddharth Kannan <kannan.siddharth12@gmail.com>
To:     git@vger.kernel.org
Cc:     Siddharth Kannan <kannan.siddharth12@gmail.com>
Subject: [PATCH] git-parse-remote.sh: Remove op_prep argument
Date:   Fri,  3 Feb 2017 18:28:09 +0000
Message-Id: <1486146489-8877-1-git-send-email-kannan.siddharth12@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

- Remove the third argument of error_on_missing_default_upstream that is no
  longer required
- FIXME to remove this argument was added in commit 045fac5845
- Run "grep" on the rest of the codebase to find and remove occurences of
  the third argument and fix the function calls appropriately

Signed-off-by: Siddharth Kannan <kannan.siddharth12@gmail.com>
---
The contrib/examples/git-pull.sh file also has a variable op_prep which is used
in one of the messages shown the user. Should I remove this variable as well?

 contrib/examples/git-pull.sh | 2 +-
 git-parse-remote.sh          | 3 +--
 git-rebase.sh                | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/contrib/examples/git-pull.sh b/contrib/examples/git-pull.sh
index 6b3a03f..1d51dc3 100755
--- a/contrib/examples/git-pull.sh
+++ b/contrib/examples/git-pull.sh
@@ -267,7 +267,7 @@ error_on_no_merge_candidates () {
 		echo "for your current branch, you must specify a branch on the command line."
 	elif [ -z "$curr_branch" -o -z "$upstream" ]; then
 		. git-parse-remote
-		error_on_missing_default_upstream "pull" $op_type $op_prep \
+		error_on_missing_default_upstream "pull" $op_type \
 			"git pull <remote> <branch>"
 	else
 		echo "Your configuration specifies to $op_type $op_prep the ref '${upstream#refs/heads/}'"
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index d3c3998..9698a05 100644
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -56,8 +56,7 @@ get_remote_merge_branch () {
 error_on_missing_default_upstream () {
 	cmd="$1"
 	op_type="$2"
-	op_prep="$3" # FIXME: op_prep is no longer used
-	example="$4"
+	example="$3"
 	branch_name=$(git symbolic-ref -q HEAD)
 	display_branch_name="${branch_name#refs/heads/}"
 	# If there's only one remote, use that in the suggestion
diff --git a/git-rebase.sh b/git-rebase.sh
index 04f6e44..b89f960 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -448,7 +448,7 @@ then
 		then
 			. git-parse-remote
 			error_on_missing_default_upstream "rebase" "rebase" \
-				"against" "git rebase $(gettext '<branch>')"
+				"git rebase $(gettext '<branch>')"
 		fi
 
 		test "$fork_point" = auto && fork_point=t
-- 
2.1.4


