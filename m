Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 856EE1F51C
	for <e@80x24.org>; Thu, 24 May 2018 11:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967338AbeEXLuk (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 07:50:40 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36969 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969279AbeEXLuO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 07:50:14 -0400
Received: by mail-wm0-f65.google.com with SMTP id l1-v6so4420805wmb.2
        for <git@vger.kernel.org>; Thu, 24 May 2018 04:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OzBhEEZQ3yuk5cHXISXbwZfSRiKx0XfKx2XBofoIgKE=;
        b=B041VJidexoDj/sCNe17vWzEoQXSwkSaj7tBVLVLD3Fw9IEtRO8G29/oONPHDWK9IL
         dn533LhiLQbTLX7t7XDLKp8Ez4EiozItbW0pDqv56PEZUov4T6+7P15LGPVj/EQRSdNM
         C2pAn/CVNSD0yYg5k3L+z83UsQEExli79oPzPeTLyzZy6pOy7ENw/Jhbg82O5HIR5sHM
         cYr4nbOl5CQXE2uq273llU85lnqdaE515mYFqGXxgWrZ2+HQDt3fhtlqvEYpV7R/wGSV
         8yRrR2uz4i8SwAmhPUIBver836ezYc5FDGFHLmbLOmRMNiEXN1Yt3ILsaIe7ZAgXNnew
         iv/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OzBhEEZQ3yuk5cHXISXbwZfSRiKx0XfKx2XBofoIgKE=;
        b=lmkMliywN7Z2Jm6WBySmKJhbnK9ZyKAaAKDb1P5Yf/QEw4N1AZFXEMiEG4dsz7Ef3i
         Wg+V1R9w4phc/hq/AT1V8CubnBLnfQQYn+f7usjgA4FzSs5/97CYU0gXCYdafQ6JWoYD
         WlJGy986JBm92gSrBess1SOprpdeJSNGAIeXKSsoWxWnEo7Dy0lBUJ3gcqflMgsQzw4y
         akgUHtBDevUcOe4LVHRe51rdBxeBU6D2H9+JNQhzz+NQ19cPVJTLYbUthIcDmr2cq8ap
         PkyVY+AWoeeQp0or/HmFqhA2xnCVJ9favNYQCjOVgWLCH6qla5GGUjqSKu1ACCAh6eBs
         EKHg==
X-Gm-Message-State: ALKqPwf/QcsXQtWiYXf9izbBkSMP0iifado7iLEASmBr1nb2FYqJiLlM
        9khmuF62urC/fVr6pYX3/pkPQq7sJzw=
X-Google-Smtp-Source: AB8JxZqOm0dwTzsHmx64SOOz6Fb5kPWyw3txPjLCswrGcKdTsc1j48AcMURO4dqgE1NcC95sI8uIAw==
X-Received: by 2002:a1c:b943:: with SMTP id j64-v6mr6435457wmf.30.1527162612724;
        Thu, 24 May 2018 04:50:12 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-38-64.w86-221.abo.wanadoo.fr. [86.221.117.64])
        by smtp.googlemail.com with ESMTPSA id o53-v6sm31494264wrc.96.2018.05.24.04.50.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 May 2018 04:50:11 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Wink Saville <wink@saville.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v3 2/4] rebase: strip unused code in git-rebase--preserve-merges.sh
Date:   Thu, 24 May 2018 13:49:56 +0200
Message-Id: <20180524114958.26521-3-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180524114958.26521-1-alban.gruin@gmail.com>
References: <20180522211625.23893-1-alban.gruin@gmail.com>
 <20180524114958.26521-1-alban.gruin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This removes the code coming from git-rebase--interactive.sh that is not needed
by preserve-merges.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 git-rebase--preserve-merges.sh | 65 +++---------------------------------------
 1 file changed, 4 insertions(+), 61 deletions(-)

diff --git a/git-rebase--preserve-merges.sh b/git-rebase--preserve-merges.sh
index 2f4941d0f..c51c7828e 100644
--- a/git-rebase--preserve-merges.sh
+++ b/git-rebase--preserve-merges.sh
@@ -1,12 +1,8 @@
-# This shell script fragment is sourced by git-rebase to implement
-# its interactive mode.  "git rebase --interactive" makes it easy
-# to fix up commits in the middle of a series and rearrange commits.
+# This shell script fragment is sourced by git-rebase to implement its
+# preserve-merges mode.
 #
 # Copyright (c) 2006 Johannes E. Schindelin
 #
-# The original idea comes from Eric W. Biederman, in
-# https://public-inbox.org/git/m1odwkyuf5.fsf_-_@ebiederm.dsl.xmission.com/
-#
 # The file containing rebase commands, comments, and empty lines.
 # This file is created by "git rebase -i" then edited by the user.  As
 # the lines are processed, they are removed from the front of this
@@ -287,17 +283,7 @@ pick_one () {
 		empty_args="--allow-empty"
 	fi
 
-	test -d "$rewritten" &&
-		pick_one_preserving_merges "$@" && return
-	output eval git cherry-pick $allow_rerere_autoupdate $allow_empty_message \
-			${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")} \
-			$signoff "$strategy_args" $empty_args $ff "$@"
-
-	# If cherry-pick dies it leaves the to-be-picked commit unrecorded. Reschedule
-	# previous task so this commit is not lost.
-	ret=$?
-	case "$ret" in [01]) ;; *) reschedule_last_action ;; esac
-	return $ret
+	pick_one_preserving_merges "$@"
 }
 
 pick_one_preserving_merges () {
@@ -761,11 +747,6 @@ get_missing_commit_check_level () {
 initiate_action () {
 	case "$1" in
 	continue)
-		if test ! -d "$rewritten"
-		then
-			exec git rebase--helper ${force_rebase:+--no-ff} $allow_empty_message \
-				--continue
-		fi
 		# do we have anything to commit?
 		if git diff-index --cached --quiet HEAD --
 		then
@@ -824,12 +805,6 @@ first and then run 'git rebase --continue' again.")"
 		;;
 	skip)
 		git rerere clear
-
-		if test ! -d "$rewritten"
-		then
-			exec git rebase--helper ${force_rebase:+--no-ff} $allow_empty_message \
-				--continue
-		fi
 		do_rest
 		return 0
 		;;
@@ -944,43 +919,11 @@ EOF
 	}
 
 	expand_todo_ids
-
-	test -d "$rewritten" || test -n "$force_rebase" ||
-	onto="$(git rebase--helper --skip-unnecessary-picks)" ||
-	die "Could not skip unnecessary pick commands"
-
 	checkout_onto
-	if test ! -d "$rewritten"
-	then
-		require_clean_work_tree "rebase"
-		exec git rebase--helper ${force_rebase:+--no-ff} $allow_empty_message \
-			--continue
-	fi
 	do_rest
 }
 
-git_rebase__interactive () {
-	initiate_action "$action"
-	ret=$?
-	if test $ret = 0; then
-		return 0
-	fi
-
-	setup_reflog_action
-	init_basic_state
-
-	init_revisions_and_shortrevisions
-
-	git rebase--helper --make-script ${keep_empty:+--keep-empty} \
-		${rebase_merges:+--rebase-merges} \
-		${rebase_cousins:+--rebase-cousins} \
-		$revisions ${restrict_revision+^$restrict_revision} >"$todo" ||
-	die "$(gettext "Could not generate todo list")"
-
-	complete_action
-}
-
-git_rebase__interactive__preserve_merges () {
+git_rebase__preserve_merges () {
 	initiate_action "$action"
 	ret=$?
 	if test $ret = 0; then
-- 
2.16.1

