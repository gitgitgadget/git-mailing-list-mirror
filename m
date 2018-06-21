Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFA121F516
	for <e@80x24.org>; Thu, 21 Jun 2018 14:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933161AbeFUObB (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 10:31:01 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40225 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933120AbeFUOa5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 10:30:57 -0400
Received: by mail-wm0-f67.google.com with SMTP id n5-v6so6498049wmc.5
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 07:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jf5hwzK6nDlpWXCi1nAfNLNq0NmfFYAl4IqhtwtCWAA=;
        b=vQbenvY56628WjoBTDE+GJlv04UvmtUJadlaKDsE0sZ2Nl+LxoA9SrnX+cdjz84Xr7
         OsuF+uGU+BiG3OG9zOmaGmEU9VaA5JtZEa9GE0hMKqYM9w1ZT/zH47qIdiP1Vxs1core
         D5TSD/WEDlOY2gLYwcfWFjyF7JXaAE+S9gd6tEViNa/hzJ81p1Iv1NvHzFBDwVyy+d4q
         L+9EShS/b6lTxnlN24NXh66LczfkxRRDleIPaUKF8/6rszef/GlpaRlWd+sc5uXWrLr3
         +j7a7S5AMMtPieK24E48od6JYhOEYdjU70tPFH61DVxFixWfVE+nqO6uy/x8HxwdazpF
         uFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jf5hwzK6nDlpWXCi1nAfNLNq0NmfFYAl4IqhtwtCWAA=;
        b=MV54EjraXqXV3TdfMfemxlsV8pf6lbhTN7ZZq1ZvHySdFa95Hd4Yy7xgsbHqSqvMBB
         KvD7INacrv/mQFQlVzFCdyf6tvAX0cgoK5fwlq4EjWzWJlLg7mnTWydp1lR6xrdcmpzT
         1Asw0M2qDSl1r228ebm2Pd/dXTnIJRMpQMNSPU+jL5PbAHwIDiwAf8oQ5yZru/h1f49O
         BOaWrvGoBdQbBNqdyu3hbiRuAOsf+T+gLTqBPFL4/by4PA0UBdR15RaXxkvVf4hwLFpd
         mxNxGiBWw1y8qIgIfyn79AvWKDKvnMTu7OkFT85s2C3PIn4ekO2//dwd6t+n4oOeN6Yc
         U6vA==
X-Gm-Message-State: APt69E2GzJ3qGMdC7sQojCO9rdj+apdpkwSVDJTGz8IW625/ERiTvzqU
        lAtMFK40XUjkclxq3BJOAFv4VM7u
X-Google-Smtp-Source: ADUXVKLJerkmGH5p9VOWb75k8ZfrhpxgRy64CsWPzasJvs3GYAy8IIqn8GeSTKUccx6Ekqa9IevwvQ==
X-Received: by 2002:a1c:206:: with SMTP id 6-v6mr5739188wmc.114.1529591455842;
        Thu, 21 Jun 2018 07:30:55 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-38-233.w86-221.abo.wanadoo.fr. [86.221.117.233])
        by smtp.googlemail.com with ESMTPSA id p17-v6sm1333591wrj.73.2018.06.21.07.30.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 07:30:54 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Elijah Newren <newren@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v3 3/3] rebase -i: rewrite checkout_onto() in C
Date:   Thu, 21 Jun 2018 16:17:32 +0200
Message-Id: <20180621141732.19952-4-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180621141732.19952-1-alban.gruin@gmail.com>
References: <20180619154421.14999-1-alban.gruin@gmail.com>
 <20180621141732.19952-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This rewrites checkout_onto() from shell to C.

A new command (“checkout-onto”) is added to rebase--helper.c. The shell
version is then stripped.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/rebase--helper.c   |  7 ++++++-
 git-rebase--interactive.sh | 25 ++++---------------------
 sequencer.c                | 19 +++++++++++++++++++
 sequencer.h                |  3 +++
 4 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index fb5996a2c..20dea4b3a 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -17,7 +17,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 	enum {
 		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_OIDS, EXPAND_OIDS,
 		CHECK_TODO_LIST, SKIP_UNNECESSARY_PICKS, REARRANGE_SQUASH,
-		ADD_EXEC, APPEND_TODO_HELP, EDIT_TODO, CHECKOUT_BASE
+		ADD_EXEC, APPEND_TODO_HELP, EDIT_TODO, CHECKOUT_BASE,
+		CHECKOUT_ONTO
 	} command = 0;
 	struct option options[] = {
 		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
@@ -53,6 +54,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 			    EDIT_TODO),
 		OPT_CMDMODE(0, "checkout-base", &command,
 			    N_("checkout the base commit"), CHECKOUT_BASE),
+		OPT_CMDMODE(0, "checkout-onto", &command,
+			    N_("checkout a commit"), CHECKOUT_ONTO),
 		OPT_END()
 	};
 
@@ -98,5 +101,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		return !!edit_todo_list(flags);
 	if (command == CHECKOUT_BASE && argc == 2)
 		return !!checkout_base_commit(&opts, argv[1], verbose);
+	if (command == CHECKOUT_ONTO && argc == 4)
+		return !!checkout_onto(&opts, argv[1], argv[2], argv[3], verbose);
 	usage_with_options(builtin_rebase_helper_usage, options);
 }
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index af46cf9c2..7b6142a76 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -28,17 +28,6 @@ case "$comment_char" in
 	;;
 esac
 
-orig_reflog_action="$GIT_REFLOG_ACTION"
-
-comment_for_reflog () {
-	case "$orig_reflog_action" in
-	''|rebase*)
-		GIT_REFLOG_ACTION="rebase -i ($1)"
-		export GIT_REFLOG_ACTION
-		;;
-	esac
-}
-
 die_abort () {
 	apply_autostash
 	rm -rf "$state_dir"
@@ -70,14 +59,6 @@ collapse_todo_ids() {
 	git rebase--helper --shorten-ids
 }
 
-# Switch to the branch in $into and notify it in the reflog
-checkout_onto () {
-	comment_for_reflog start
-	GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $onto_name"
-	output git checkout $onto || die_abort "$(gettext "could not detach HEAD")"
-	git update-ref ORIG_HEAD $orig_head
-}
-
 get_missing_commit_check_level () {
 	check_level=$(git config --get rebase.missingCommitsCheck)
 	check_level=${check_level:-ignore}
@@ -176,7 +157,8 @@ EOF
 
 	git rebase--helper --check-todo-list || {
 		ret=$?
-		checkout_onto
+		git rebase--helper --checkout-onto "$onto_name" "$onto" \
+		    "$orig_head" ${verbose:+--verbose}
 		exit $ret
 	}
 
@@ -186,7 +168,8 @@ EOF
 	onto="$(git rebase--helper --skip-unnecessary-picks)" ||
 	die "Could not skip unnecessary pick commands"
 
-	checkout_onto
+	git rebase--helper --checkout-onto "$onto_name" "$onto" "$orig_head" \
+	    ${verbose:+--verbose}
 	require_clean_work_tree "rebase"
 	exec git rebase--helper ${force_rebase:+--no-ff} $allow_empty_message \
 	     --continue
diff --git a/sequencer.c b/sequencer.c
index 27f8453fe..b3b1a2e18 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3159,6 +3159,25 @@ int checkout_base_commit(struct replay_opts *opts, const char *commit,
 	return 0;
 }
 
+int checkout_onto(struct replay_opts *opts,
+		  const char *onto_name, const char *onto,
+		  const char *orig_head, unsigned verbose)
+{
+	struct object_id oid;
+	const char *action = reflog_message(opts, "start", "checkout %s", onto_name);
+
+	if (get_oid(orig_head, &oid))
+		return error(_("%s: not a valid OID"), orig_head);
+
+	if (run_git_checkout(opts, onto, verbose, action)) {
+		apply_autostash(opts);
+		sequencer_remove_state(opts);
+		return error(_("could not detach HEAD"));
+	}
+
+	return update_ref(NULL, "ORIG_HEAD", &oid, NULL, 0, UPDATE_REFS_MSG_ON_ERR);
+}
+
 static const char rescheduled_advice[] =
 N_("Could not execute the todo command\n"
 "\n"
diff --git a/sequencer.h b/sequencer.h
index 42c3dda81..eda03ce32 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -102,6 +102,9 @@ void commit_post_rewrite(const struct commit *current_head,
 
 int checkout_base_commit(struct replay_opts *opts, const char *commit,
 			 int verbose);
+int checkout_onto(struct replay_opts *opts,
+		  const char *onto_name, const char *onto,
+		  const char *orig_head, unsigned verbose);
 
 #define SUMMARY_INITIAL_COMMIT   (1 << 0)
 #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
-- 
2.17.1

