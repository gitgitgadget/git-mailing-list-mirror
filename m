Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 792891F45F
	for <e@80x24.org>; Tue, 28 Aug 2018 12:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbeH1QC7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 12:02:59 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:53066 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbeH1QC6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 12:02:58 -0400
Received: by mail-wm0-f50.google.com with SMTP id y139-v6so1660342wmc.2
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 05:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wy4PFWdkA9+aFNmAbEOsBKw4E6KjzYkMlN5JWOrBDxg=;
        b=UdpBqq3EAUJyp/fcUkRUIwjGlGDpaeNFKr84sBBifb+Xl5rJ7jsAk/d+IJ0uSsKI7i
         j5uEcY2i+r7jFbMQ0+4klp69kGoDSxTHSAEPPRYslhYkoZDRDUHRn5TxcFKAWpPR/jN3
         Uvx8rb3jgzbQWx1ETO3+hnggIzXojtFVsGyzvuGNHvNAnpjA9Geo9QDLThSuef4QZcUJ
         IKbExl0XwY+kTeTDEGJNh1/8QLqdoja7I5BJWGmxAtNWOzelw0huMCXZ50Y/Op7z496W
         ZJT2A5YHDf007dsgb68eDHc81Xkz38PsXj+8t6soqjTI7kiNiDT+YYSOoH8CuOBtt47k
         fl6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wy4PFWdkA9+aFNmAbEOsBKw4E6KjzYkMlN5JWOrBDxg=;
        b=bE9OWGB876wcKYpoDFH+14gCggAkTYVhG7V5eEr6Us0zwJwgp3ghhcFu8rV9SXUhhe
         kEcl9cLh8uf7yxv+Ko2tLT1S6ym2fzwZ/CqBH4txFnUEO4IzknT9tJrW88QpsSV5hs8g
         5pXu16wMu14RLFs+qrES6XiVrbKhs87WPNRlR8Je1D96TvpYm+UFzRTBPYTADHZxJe48
         PJyOwIY2u+EdZtfnPj9EbAQv0VHBv2NAbo3OuU224DZZuYFWriaEBzimJB7El1FwNrP9
         4rpy5k3UQDTv9YAjj/CmD2fl/3lmRJfRIeJYpWG6oIPvUJKDIhCmD+LxWpCWpaCNFHtk
         qC3Q==
X-Gm-Message-State: APzg51DrIvhzE5cpOo9U93BueGCUadq0Eq0fFVYA7hpXwGv0lEUg+pCm
        JREO+qk7Zf3z6h7c9VKkDHg14YKZ
X-Google-Smtp-Source: ANB0VdaiHJehTOGIU/yam44KD6vyfTyGf+9EVQ2SaQWGXtkc3xCdpuHAKp9l/fSnOtDP99Yb5z9QUg==
X-Received: by 2002:a1c:357:: with SMTP id 84-v6mr1171193wmd.8.1535458294190;
        Tue, 28 Aug 2018 05:11:34 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-33-140.w86-221.abo.wanadoo.fr. [86.221.112.140])
        by smtp.googlemail.com with ESMTPSA id y206-v6sm1702790wmg.14.2018.08.28.05.11.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 05:11:33 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v7 19/20] rebase -i: remove git-rebase--interactive.sh
Date:   Tue, 28 Aug 2018 14:10:44 +0200
Message-Id: <20180828121045.14933-20-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180828121045.14933-1-alban.gruin@gmail.com>
References: <20180810165147.4779-1-alban.gruin@gmail.com>
 <20180828121045.14933-1-alban.gruin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This removes git-rebase--interactive.sh, as its functionnality has been
replaced by git-rebase--interactive2.

git-rebase--interactive2.c is then renamed to git-rebase--interactive.c.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
No changes since v6.

 .gitignore                                    |  1 -
 Makefile                                      |  4 +-
 ...--interactive2.c => rebase--interactive.c} |  0
 git-rebase--interactive.sh                    | 84 -------------------
 git-rebase.sh                                 |  2 +-
 git.c                                         |  2 +-
 6 files changed, 3 insertions(+), 90 deletions(-)
 rename builtin/{rebase--interactive2.c => rebase--interactive.c} (100%)
 delete mode 100644 git-rebase--interactive.sh

diff --git a/.gitignore b/.gitignore
index 404c9a8472..3284a1e9b1 100644
--- a/.gitignore
+++ b/.gitignore
@@ -118,7 +118,6 @@
 /git-rebase--am
 /git-rebase--helper
 /git-rebase--interactive
-/git-rebase--interactive2
 /git-rebase--merge
 /git-rebase--preserve-merges
 /git-receive-pack
diff --git a/Makefile b/Makefile
index 71f8f45fe5..584834726d 100644
--- a/Makefile
+++ b/Makefile
@@ -619,7 +619,6 @@ SCRIPT_SH += git-web--browse.sh
 SCRIPT_LIB += git-mergetool--lib
 SCRIPT_LIB += git-parse-remote
 SCRIPT_LIB += git-rebase--am
-SCRIPT_LIB += git-rebase--interactive
 SCRIPT_LIB += git-rebase--preserve-merges
 SCRIPT_LIB += git-rebase--merge
 SCRIPT_LIB += git-sh-setup
@@ -1060,8 +1059,8 @@ BUILTIN_OBJS += builtin/prune.o
 BUILTIN_OBJS += builtin/pull.o
 BUILTIN_OBJS += builtin/push.o
 BUILTIN_OBJS += builtin/read-tree.o
-BUILTIN_OBJS += builtin/rebase--interactive2.o
 BUILTIN_OBJS += builtin/rebase--helper.o
+BUILTIN_OBJS += builtin/rebase--interactive.o
 BUILTIN_OBJS += builtin/receive-pack.o
 BUILTIN_OBJS += builtin/reflog.o
 BUILTIN_OBJS += builtin/remote.o
@@ -2400,7 +2399,6 @@ XGETTEXT_FLAGS_PERL = $(XGETTEXT_FLAGS) --language=Perl \
 LOCALIZED_C = $(C_OBJ:o=c) $(LIB_H) $(GENERATED_H)
 LOCALIZED_SH = $(SCRIPT_SH)
 LOCALIZED_SH += git-parse-remote.sh
-LOCALIZED_SH += git-rebase--interactive.sh
 LOCALIZED_SH += git-rebase--preserve-merges.sh
 LOCALIZED_SH += git-sh-setup.sh
 LOCALIZED_PERL = $(SCRIPT_PERL)
diff --git a/builtin/rebase--interactive2.c b/builtin/rebase--interactive.c
similarity index 100%
rename from builtin/rebase--interactive2.c
rename to builtin/rebase--interactive.c
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
deleted file mode 100644
index e87d708a4d..0000000000
--- a/git-rebase--interactive.sh
+++ /dev/null
@@ -1,84 +0,0 @@
-# This shell script fragment is sourced by git-rebase to implement
-# its interactive mode.  "git rebase --interactive" makes it easy
-# to fix up commits in the middle of a series and rearrange commits.
-#
-# Copyright (c) 2006 Johannes E. Schindelin
-#
-# The original idea comes from Eric W. Biederman, in
-# https://public-inbox.org/git/m1odwkyuf5.fsf_-_@ebiederm.dsl.xmission.com/
-#
-# The file containing rebase commands, comments, and empty lines.
-# This file is created by "git rebase -i" then edited by the user.  As
-# the lines are processed, they are removed from the front of this
-# file and written to the tail of $done.
-todo="$state_dir"/git-rebase-todo
-
-GIT_CHERRY_PICK_HELP="$resolvemsg"
-export GIT_CHERRY_PICK_HELP
-
-# Initiate an action. If the cannot be any
-# further action it  may exec a command
-# or exit and not return.
-#
-# TODO: Consider a cleaner return model so it
-# never exits and always return 0 if process
-# is complete.
-#
-# Parameter 1 is the action to initiate.
-#
-# Returns 0 if the action was able to complete
-# and if 1 if further processing is required.
-initiate_action () {
-	case "$1" in
-	continue)
-		exec git rebase--helper ${force_rebase:+--no-ff} $allow_empty_message \
-		     --continue
-		;;
-	skip)
-		git rerere clear
-		exec git rebase--helper ${force_rebase:+--no-ff} $allow_empty_message \
-		     --continue
-		;;
-	edit-todo)
-		exec git rebase--helper --edit-todo
-		;;
-	show-current-patch)
-		exec git show REBASE_HEAD --
-		;;
-	*)
-		return 1 # continue
-		;;
-	esac
-}
-
-git_rebase__interactive () {
-	initiate_action "$action"
-	ret=$?
-	if test $ret = 0; then
-		return 0
-	fi
-
-	test -n "$keep_empty" && keep_empty="--keep-empty"
-	test -n "$rebase_merges" && rebase_merges="--rebase-merges"
-	test -n "$rebase_cousins" && rebase_cousins="--rebase-cousins"
-	test -n "$autosquash" && autosquash="--autosquash"
-	test -n "$verbose" && verbose="--verbose"
-	test -n "$force_rebase" && force_rebase="--no-ff"
-	test -n "$restrict_revisions" && restrict_revisions="--restrict-revisions=^$restrict_revisions"
-	test -n "$upstream" && upstream="--upstream=$upstream"
-	test -n "$onto" && onto="--onto=$onto"
-	test -n "$squash_onto" && squash_onto="--squash-onto=$squash_onto"
-	test -n "$onto_name" && onto_name="--onto-name=$onto_name"
-	test -n "$head_name" && head_name="--head-name=$head_name"
-	test -n "$strategy" && strategy="--strategy=$strategy"
-	test -n "$strategy_opts" && strategy_opts="--strategy-opts=$strategy_opts"
-	test -n "$switch_to" && switch_to="--switch-to=$switch_to"
-	test -n "$cmd" && cmd="--cmd=$cmd"
-
-	exec git rebase--interactive2 "$keep_empty" "$rebase_merges" "$rebase_cousins" \
-		"$upstream" "$onto" "$squash_onto" "$restrict_revision" \
-		"$allow_empty_message" "$autosquash" "$verbose" \
-		"$force_rebase" "$onto_name" "$head_name" "$strategy" \
-		"$strategy_opts" "$cmd" "$switch_to" \
-		"$allow_rerere_autoupdate" "$gpg_sign_opt" "$signoff"
-}
diff --git a/git-rebase.sh b/git-rebase.sh
index 6e1e413cf2..3e7798e07b 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -223,7 +223,7 @@ run_interactive () {
 	test -n "$cmd" && cmd="--cmd=$cmd"
 	test -n "$action" && action="--$action"
 
-	exec git rebase--interactive2 "$action" "$keep_empty" "$rebase_merges" "$rebase_cousins" \
+	exec git rebase--interactive "$action" "$keep_empty" "$rebase_merges" "$rebase_cousins" \
 		"$upstream" "$onto" "$squash_onto" "$restrict_revision" \
 		"$allow_empty_message" "$autosquash" "$verbose" \
 		"$force_rebase" "$onto_name" "$head_name" "$strategy" \
diff --git a/git.c b/git.c
index 8309fb24a6..19d0b6e3b8 100644
--- a/git.c
+++ b/git.c
@@ -518,7 +518,7 @@ static struct cmd_struct commands[] = {
 	{ "pull", cmd_pull, RUN_SETUP | NEED_WORK_TREE },
 	{ "push", cmd_push, RUN_SETUP },
 	{ "read-tree", cmd_read_tree, RUN_SETUP | SUPPORT_SUPER_PREFIX},
-	{ "rebase--interactive2", cmd_rebase__interactive, RUN_SETUP | NEED_WORK_TREE },
+	{ "rebase--interactive", cmd_rebase__interactive, RUN_SETUP | NEED_WORK_TREE },
 	{ "rebase--helper", cmd_rebase__helper, RUN_SETUP | NEED_WORK_TREE },
 	{ "receive-pack", cmd_receive_pack },
 	{ "reflog", cmd_reflog, RUN_SETUP },
-- 
2.18.0

