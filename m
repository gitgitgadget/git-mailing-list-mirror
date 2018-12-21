Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F6851F405
	for <e@80x24.org>; Fri, 21 Dec 2018 13:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390566AbeLUNRo (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Dec 2018 08:17:44 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36848 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387590AbeLUNRl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Dec 2018 08:17:41 -0500
Received: by mail-ed1-f66.google.com with SMTP id f23so4659316edb.3
        for <git@vger.kernel.org>; Fri, 21 Dec 2018 05:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=S2WLcDxRJeQvMXUCxtIatjcMhVX4V3WUpxc3UjIXeho=;
        b=k3ZYD6eIfv808+RkTrJsZDuotHjVQTT+E2Xu2sMcd9NscSXyLeSZAJPSaGlEFI1MwW
         BYNhjXwrIr08QHtwR3TnydDHFB84YTaplm8j8zCQfqnkI3/OBfalU5C2y5/0G+1p6/Ei
         AFd2obFKRxx30Nbea1/QTvW1GXCuB6stI3KjuAezex43FfOMNO2zyKwYmKiz0naFIGg3
         eQ77OAg7LAfUmlLJotZ6lPLLCH/7sEa6zi/TGoIxLRi2aVvZJSlKaNDP9TE3/1o4iktD
         8auJsnhJkqUoPTva3Onrs7pLzxVUGgY1uOtuoZVj9RMqUez9sDJYPazHD3hHqi9/TEts
         1kHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=S2WLcDxRJeQvMXUCxtIatjcMhVX4V3WUpxc3UjIXeho=;
        b=V/Yq22eNB0Q4GuLA1OO8g35Y3EOZXsH40sMy88HKa1asy23TWJmndbW6L5ACOuOz+x
         mQkTT41eALSJZ7L72F1IHW37vXsSHq/INQIel+p+ZYQQaQgbT6Loa2QJoRiJXUU4YYGA
         W6f680/WyQC6+UwqXDC9QpuftSTwO5qQCigQt04tC4zZL206ycbawzIHfu9eYusYdSjH
         MmoBEqbmb9cy2kTNbvUzr/frGMLNiZ4ks1TH3sILNft+79bjXGDQ8id5rHHp6ag4YqzM
         3MIj61nG5b29VoFWwuJlk7QXpNBqJuqMLE/LJPrPGccXfaPCpwpIeGr1MXceX8mqHyW3
         jYRw==
X-Gm-Message-State: AA+aEWZdvC18SL2aPCN0FO3JFbs8/qJ6iNI9PBi5KTt1Zi5u85kOPvfy
        0C9UFCbodsdka3QK+CbQ+ct27tpFMZYY0g==
X-Google-Smtp-Source: AFSGD/X5KbY8TA2p5o5pFsGbdGah8MCGTPtn/JZalqX0nVuNRsohQ8rYSb2gJ+feZWitjm6qPYwDeQ==
X-Received: by 2002:a17:906:948d:: with SMTP id t13-v6mr2110005ejx.119.1545398259355;
        Fri, 21 Dec 2018 05:17:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w56sm7023097edb.72.2018.12.21.05.17.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 05:17:38 -0800 (PST)
Date:   Fri, 21 Dec 2018 05:17:38 -0800 (PST)
X-Google-Original-Date: Fri, 21 Dec 2018 13:17:34 GMT
Message-Id: <2b5ece8263936f0a7dfad864c0de43d784fdaf1f.1545398254.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.24.git.gitgitgadget@gmail.com>
References: <pull.24.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 4/4] built-in rebase: call `git am` directly
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

While the scripted `git rebase` still has to rely on the
`git-rebase--am.sh` script to implement the glue between the `rebase`
and the `am` commands, we can go a more direct route in the built-in
rebase and avoid using a shell script altogether.

This patch represents a straight-forward port of `git-rebase--am.sh` to
C, along with the glue code to call it directly from within
`builtin/rebase.c`.

This reduces the chances of Git for Windows running into trouble due to
problems with the POSIX emulation layer (known as "MSYS2 runtime",
itself a derivative of the Cygwin runtime): when no shell script is
called, the POSIX emulation layer is avoided altogether.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 183 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 183 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 303175fdf1..e327c30b6b 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -246,6 +246,37 @@ static int read_basic_state(struct rebase_options *opts)
 	return 0;
 }
 
+static int write_basic_state(struct rebase_options *opts)
+{
+	write_file(state_dir_path("head-name", opts), "%s",
+		   opts->head_name ? opts->head_name : "detached HEAD");
+	write_file(state_dir_path("onto", opts), "%s",
+		   opts->onto ? oid_to_hex(&opts->onto->object.oid) : "");
+	write_file(state_dir_path("orig-head", opts), "%s",
+		   oid_to_hex(&opts->orig_head));
+	write_file(state_dir_path("quiet", opts), "%s",
+		   opts->flags & REBASE_NO_QUIET ? "" : "t");
+	if (opts->flags & REBASE_VERBOSE)
+		write_file(state_dir_path("verbose", opts), "%s", "");
+	if (opts->strategy)
+		write_file(state_dir_path("strategy", opts), "%s",
+			   opts->strategy);
+	if (opts->strategy_opts)
+		write_file(state_dir_path("strategy_opts", opts), "%s",
+			   opts->strategy_opts);
+	if (opts->allow_rerere_autoupdate >= 0)
+		write_file(state_dir_path("allow_rerere_autoupdate", opts),
+			   "-%s-rerere-autoupdate",
+			   opts->allow_rerere_autoupdate ? "" : "-no");
+	if (opts->gpg_sign_opt)
+		write_file(state_dir_path("gpg_sign_opt", opts), "%s",
+			   opts->gpg_sign_opt);
+	if (opts->signoff)
+		write_file(state_dir_path("strategy", opts), "--signoff");
+
+	return 0;
+}
+
 static int apply_autostash(struct rebase_options *opts)
 {
 	const char *path = state_dir_path("autostash", opts);
@@ -459,6 +490,30 @@ static int reset_head(struct object_id *oid, const char *action,
 	return ret;
 }
 
+static int move_to_original_branch(struct rebase_options *opts)
+{
+	struct strbuf orig_head_reflog = STRBUF_INIT, head_reflog = STRBUF_INIT;
+	int ret;
+
+	if (!opts->head_name)
+		return 0; /* nothing to move back to */
+
+	if (!opts->onto)
+		BUG("move_to_original_branch without onto");
+
+	strbuf_addf(&orig_head_reflog, "rebase finished: %s onto %s",
+		    opts->head_name, oid_to_hex(&opts->onto->object.oid));
+	strbuf_addf(&head_reflog, "rebase finished: returning to %s",
+		    opts->head_name);
+	ret = reset_head(NULL, "checkout", opts->head_name,
+			 RESET_HEAD_REFS_ONLY,
+			 orig_head_reflog.buf, head_reflog.buf);
+
+	strbuf_release(&orig_head_reflog);
+	strbuf_release(&head_reflog);
+	return ret;
+}
+
 static const char *resolvemsg =
 N_("Resolve all conflicts manually, mark them as resolved with\n"
 "\"git add/rm <conflicted_files>\", then run \"git rebase --continue\".\n"
@@ -466,6 +521,129 @@ N_("Resolve all conflicts manually, mark them as resolved with\n"
 "To abort and get back to the state before \"git rebase\", run "
 "\"git rebase --abort\".");
 
+static int run_am(struct rebase_options *opts)
+{
+	struct child_process am = CHILD_PROCESS_INIT;
+	struct child_process format_patch = CHILD_PROCESS_INIT;
+	struct strbuf revisions = STRBUF_INIT;
+	int status;
+	char *rebased_patches;
+
+	am.git_cmd = 1;
+	argv_array_push(&am.args, "am");
+
+	if (opts->action && !strcmp("continue", opts->action)) {
+		argv_array_push(&am.args, "--resolved");
+		argv_array_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
+		if (opts->gpg_sign_opt)
+			argv_array_push(&am.args, opts->gpg_sign_opt);
+		status = run_command(&am);
+		if (status)
+			return status;
+
+		discard_cache();
+		return move_to_original_branch(opts);
+	}
+	if (opts->action && !strcmp("skip", opts->action)) {
+		argv_array_push(&am.args, "--skip");
+		argv_array_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
+		status = run_command(&am);
+		if (status)
+			return status;
+
+		discard_cache();
+		return move_to_original_branch(opts);
+	}
+	if (opts->action && !strcmp("show-current-patch", opts->action)) {
+		argv_array_push(&am.args, "--show-current-patch");
+		return run_command(&am);
+	}
+
+	strbuf_addf(&revisions, "%s...%s",
+		    oid_to_hex(opts->root ?
+			       /* this is now equivalent to ! -z "$upstream" */
+			       &opts->onto->object.oid :
+			       &opts->upstream->object.oid),
+		    oid_to_hex(&opts->orig_head));
+
+	rebased_patches = xstrdup(git_path("rebased-patches"));
+	format_patch.out = open(rebased_patches,
+				O_WRONLY | O_CREAT | O_TRUNC, 0666);
+	if (format_patch.out < 0) {
+		status = error_errno(_("could not write '%s'"),
+				     rebased_patches);
+		free(rebased_patches);
+		argv_array_clear(&am.args);
+		return status;
+	}
+
+	format_patch.git_cmd = 1;
+	argv_array_pushl(&format_patch.args, "format-patch", "-k", "--stdout",
+			 "--full-index", "--cherry-pick", "--right-only",
+			 "--src-prefix=a/", "--dst-prefix=b/", "--no-renames",
+			 "--no-cover-letter", "--pretty=mboxrd", NULL);
+	if (opts->git_format_patch_opt.len)
+		argv_array_split(&format_patch.args,
+				 opts->git_format_patch_opt.buf);
+	argv_array_push(&format_patch.args, revisions.buf);
+	if (opts->restrict_revision)
+		argv_array_pushf(&format_patch.args, "^%s",
+				 oid_to_hex(&opts->restrict_revision->object.oid));
+
+	status = run_command(&format_patch);
+	if (status) {
+		unlink(rebased_patches);
+		free(rebased_patches);
+		argv_array_clear(&am.args);
+
+		reset_head(&opts->orig_head, "checkout", opts->head_name, 0,
+			   "HEAD", NULL);
+		error(_("\ngit encountered an error while preparing the "
+			"patches to replay\n"
+			"these revisions:\n"
+			"\n    %s\n\n"
+			"As a result, git cannot rebase them."),
+		      opts->revisions);
+
+		strbuf_release(&revisions);
+		return status;
+	}
+	strbuf_release(&revisions);
+
+	am.in = open(rebased_patches, O_RDONLY);
+	if (am.in < 0) {
+		status = error_errno(_("could not read '%s'"),
+				     rebased_patches);
+		free(rebased_patches);
+		argv_array_clear(&am.args);
+		return status;
+	}
+
+	argv_array_pushv(&am.args, opts->git_am_opts.argv);
+	argv_array_push(&am.args, "--rebasing");
+	argv_array_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
+	argv_array_push(&am.args, "--patch-format=mboxrd");
+	if (opts->allow_rerere_autoupdate > 0)
+		argv_array_push(&am.args, "--rerere-autoupdate");
+	else if (opts->allow_rerere_autoupdate == 0)
+		argv_array_push(&am.args, "--no-rerere-autoupdate");
+	if (opts->gpg_sign_opt)
+		argv_array_push(&am.args, opts->gpg_sign_opt);
+	status = run_command(&am);
+	unlink(rebased_patches);
+	free(rebased_patches);
+
+	if (!status) {
+		discard_cache();
+		return move_to_original_branch(opts);
+	}
+
+	if (is_directory(opts->state_dir))
+		write_basic_state(opts);
+
+	return status;
+}
+
 static int run_specific_rebase(struct rebase_options *opts)
 {
 	const char *argv[] = { NULL, NULL };
@@ -546,6 +724,11 @@ static int run_specific_rebase(struct rebase_options *opts)
 		goto finished_rebase;
 	}
 
+	if (opts->type == REBASE_AM) {
+		status = run_am(opts);
+		goto finished_rebase;
+	}
+
 	add_var(&script_snippet, "GIT_DIR", absolute_path(get_git_dir()));
 	add_var(&script_snippet, "state_dir", opts->state_dir);
 
-- 
gitgitgadget
