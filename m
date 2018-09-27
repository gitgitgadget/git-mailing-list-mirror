Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 919AF1F453
	for <e@80x24.org>; Thu, 27 Sep 2018 22:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbeI1EVR (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 00:21:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44416 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbeI1EVR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 00:21:17 -0400
Received: by mail-wr1-f67.google.com with SMTP id v16-v6so4207107wro.11
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 15:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vmNw/zQOg0Fx67w0Nw5B+AYePyp3Wf3jF9HvJez+Xtw=;
        b=smotxBnwgsLkxmKyTJnMlEokGtCBWoNWRwCcMJbHfSqB8ltfFDBQoQ/SqE3jHDeduQ
         8rsLwExZPjDO4ikA1pTuV7yeSxTmKQnxMHz64OGbXuegIRfIYti1U9u7xGeq7RzD151H
         cO3NQMHDGRKyNU8fsTPO1/e1rT42DMMgQUe5lyKD4QXpCtjy01+xpIb05VLRewEF9umC
         sq2djR0NKXBgaLGR4nxFdqQQ4yoLs433ajMEJi4axTczTKYw3jw+uADcjMvJkmDsQO2T
         ww5XtMJwd4eHrrPWQ9oKnRaD77zqlvZwf2ROJ77n9BH4ZciDwe7/Aqwf7BEBmsbj6ky7
         R2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vmNw/zQOg0Fx67w0Nw5B+AYePyp3Wf3jF9HvJez+Xtw=;
        b=IJzM30b0n2t9wD5PA3mafeBe6bcRb5bV5YrOExDuLhhA+nPWMZDsB8Aok2d1FdnLKr
         hOKan7QC5ZWoJctiq4CoScplQDC06YdxaHCHfCQjhe341Ohcx1egXMTBZpau03ucPpAS
         hNstAqrwzDiHJjn/QMqUiuYxRwdlm4hs4Wq29pg0XK3hiLbIrj2cgn16S87HFkcP2i0a
         mvqemNWV54V41/cWYwM1G72T90KllP5am8PzMqSxB54DHt7qLDU203PbsQef30alqFlV
         9L2q9Sgm+mpzns22Uq4JDI30nrOGkc7vQ01rtHejI7CYiUT+xPfdPqO6M3y6Tr5xyTVH
         3aVw==
X-Gm-Message-State: ABuFfoi89SoAmtE5nDxe2F6bifXjn8mAMBUe2TvCE57vGQoyNOKrHR54
        47BOyMtcmIRjPLHBww/w7zcYcKdD
X-Google-Smtp-Source: ACcGV60poYTJn2YIWAmq9aUHY92UAvPOTVBEqZzYPLH5MT7EyFcglVLSfb8Tcpw3hrNJnPlQu0xEsQ==
X-Received: by 2002:adf:c08c:: with SMTP id d12-v6mr9884334wrf.268.1538085651269;
        Thu, 27 Sep 2018 15:00:51 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-28-140.w86-222.abo.wanadoo.fr. [86.222.27.140])
        by smtp.googlemail.com with ESMTPSA id h206-v6sm243153wmf.25.2018.09.27.15.00.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 15:00:50 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v8 18/20] rebase--interactive2: rewrite the submodes of interactive rebase in C
Date:   Thu, 27 Sep 2018 23:56:08 +0200
Message-Id: <20180927215610.32210-19-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927215610.32210-1-alban.gruin@gmail.com>
References: <20180828121045.14933-1-alban.gruin@gmail.com>
 <20180927215610.32210-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This rewrites the submodes of interactive rebase (`--continue`,
`--skip`, `--edit-todo`, and `--show-current-patch`) in C.

git-rebase.sh is then modified to call directly git-rebase--interactive2
instead of git-rebase--interactive.sh.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
No changes since v7.

 builtin/rebase--interactive2.c | 51 ++++++++++++++++++++++++++++++----
 git-rebase.sh                  | 45 +++++++++++++++++++++++++++---
 2 files changed, 86 insertions(+), 10 deletions(-)

diff --git a/builtin/rebase--interactive2.c b/builtin/rebase--interactive2.c
index 45336073a8..aaf13c9621 100644
--- a/builtin/rebase--interactive2.c
+++ b/builtin/rebase--interactive2.c
@@ -134,11 +134,14 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 {
 	struct replay_opts opts = REPLAY_OPTS_INIT;
 	unsigned flags = 0, keep_empty = 0, rebase_merges = 0, autosquash = 0;
-	int abbreviate_commands = 0, rebase_cousins = -1;
+	int abbreviate_commands = 0, rebase_cousins = -1, ret = 0;
 	const char *onto = NULL, *onto_name = NULL, *restrict_revision = NULL,
 		*squash_onto = NULL, *upstream = NULL, *head_name = NULL,
 		*switch_to = NULL, *cmd = NULL;
 	char *raw_strategies = NULL;
+	enum {
+		NONE = 0, CONTINUE, SKIP, EDIT_TODO, SHOW_CURRENT_PATCH
+	} command = 0;
 	struct option options[] = {
 		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
 		OPT_BOOL(0, "keep-empty", &keep_empty, N_("keep empty commits")),
@@ -151,6 +154,13 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 			 N_("move commits that begin with squash!/fixup!")),
 		OPT_BOOL(0, "signoff", &opts.signoff, N_("sign commits")),
 		OPT__VERBOSE(&opts.verbose, N_("be verbose")),
+		OPT_CMDMODE(0, "continue", &command, N_("continue rebase"),
+			    CONTINUE),
+		OPT_CMDMODE(0, "skip", &command, N_("skip commit"), SKIP),
+		OPT_CMDMODE(0, "edit-todo", &command, N_("edit the todo list"),
+			    EDIT_TODO),
+		OPT_CMDMODE(0, "show-current-patch", &command, N_("show the current patch"),
+			    SHOW_CURRENT_PATCH),
 		OPT_STRING(0, "onto", &onto, N_("onto"), N_("onto")),
 		OPT_STRING(0, "restrict-revision", &restrict_revision,
 			   N_("restrict-revision"), N_("restrict revision")),
@@ -198,10 +208,39 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 		warning(_("--[no-]rebase-cousins has no effect without "
 			  "--rebase-merges"));
 
-	if (!onto && !upstream)
-		die(_("a base commit must be provided with --upstream or --onto"));
+	switch (command) {
+	case NONE:
+		if (!onto && !upstream)
+			die(_("a base commit must be provided with --upstream or --onto"));
+
+		ret = do_interactive_rebase(&opts, flags, switch_to, upstream, onto,
+					    onto_name, squash_onto, head_name, restrict_revision,
+					    raw_strategies, cmd, autosquash);
+		break;
+	case SKIP: {
+		struct string_list merge_rr = STRING_LIST_INIT_DUP;
+
+		rerere_clear(&merge_rr);
+		/* fallthrough */
+	case CONTINUE:
+		ret = sequencer_continue(&opts);
+		break;
+	}
+	case EDIT_TODO:
+		ret = edit_todo_list(flags);
+		break;
+	case SHOW_CURRENT_PATCH: {
+		struct child_process cmd = CHILD_PROCESS_INIT;
+
+		cmd.git_cmd = 1;
+		argv_array_pushl(&cmd.args, "show", "REBASE_HEAD", "--", NULL);
+		ret = run_command(&cmd);
+
+		break;
+	}
+	default:
+		BUG("invalid command '%d'", command);
+	}
 
-	return !!do_interactive_rebase(&opts, flags, switch_to, upstream, onto,
-				       onto_name, squash_onto, head_name, restrict_revision,
-				       raw_strategies, cmd, autosquash);
+	return !!ret;
 }
diff --git a/git-rebase.sh b/git-rebase.sh
index 51a6db7daa..6e1e413cf2 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -200,19 +200,56 @@ finish_rebase () {
 	rm -rf "$state_dir"
 }
 
+run_interactive () {
+	GIT_CHERRY_PICK_HELP="$resolvemsg"
+	export GIT_CHERRY_PICK_HELP
+
+	test -n "$keep_empty" && keep_empty="--keep-empty"
+	test -n "$rebase_merges" && rebase_merges="--rebase-merges"
+	test -n "$rebase_cousins" && rebase_cousins="--rebase-cousins"
+	test -n "$autosquash" && autosquash="--autosquash"
+	test -n "$verbose" && verbose="--verbose"
+	test -n "$force_rebase" && force_rebase="--no-ff"
+	test -n "$restrict_revision" && \
+		restrict_revision="--restrict-revision=^$restrict_revision"
+	test -n "$upstream" && upstream="--upstream=$upstream"
+	test -n "$onto" && onto="--onto=$onto"
+	test -n "$squash_onto" && squash_onto="--squash-onto=$squash_onto"
+	test -n "$onto_name" && onto_name="--onto-name=$onto_name"
+	test -n "$head_name" && head_name="--head-name=$head_name"
+	test -n "$strategy" && strategy="--strategy=$strategy"
+	test -n "$strategy_opts" && strategy_opts="--strategy-opts=$strategy_opts"
+	test -n "$switch_to" && switch_to="--switch-to=$switch_to"
+	test -n "$cmd" && cmd="--cmd=$cmd"
+	test -n "$action" && action="--$action"
+
+	exec git rebase--interactive2 "$action" "$keep_empty" "$rebase_merges" "$rebase_cousins" \
+		"$upstream" "$onto" "$squash_onto" "$restrict_revision" \
+		"$allow_empty_message" "$autosquash" "$verbose" \
+		"$force_rebase" "$onto_name" "$head_name" "$strategy" \
+		"$strategy_opts" "$cmd" "$switch_to" \
+		"$allow_rerere_autoupdate" "$gpg_sign_opt" "$signoff"
+}
+
 run_specific_rebase () {
 	if [ "$interactive_rebase" = implied ]; then
 		GIT_EDITOR=:
 		export GIT_EDITOR
 		autosquash=
 	fi
-	. git-rebase--$type
 
-	if test -z "$preserve_merges"
+	if test -n "$interactive_rebase" -a -z "$preserve_merges"
 	then
-		git_rebase__$type
+		run_interactive
 	else
-		git_rebase__preserve_merges
+		. git-rebase--$type
+
+		if test -z "$preserve_merges"
+		then
+			git_rebase__$type
+		else
+			git_rebase__preserve_merges
+		fi
 	fi
 
 	ret=$?
-- 
2.19.0

