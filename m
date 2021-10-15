Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B92DC433EF
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 15:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E7A361056
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 15:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240759AbhJOPGZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 11:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234241AbhJOPGZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 11:06:25 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BDAC061570
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 08:04:18 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id j21so43499384lfe.0
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 08:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WyJL9gBmTRco9kopOCRhN0tx7dMJbxokyE2WdQY2XFI=;
        b=OA7k6Ruj4e/m311gAi8roD0F3KUUjARrEYP6mRKpXDxpcek5SgSz6aCIYq4grUZZ+Q
         3CbvRnhzCbaxDablcyzJELO3MHooNEisjlOcCd1K7M95dhnTTppmBYde3X4+9dgPL/98
         /j52VPTRv794c8aesGnRydiEhkq+9dHdXyhSmhpWLwIf2yg4svE29sClyCUQmCMmSvXC
         Dev5gsLgbE3UEvd8K+Ono9km8p5Qwggd4G2qTHbcODEAYpzqdb6UMHFrn/X/jXYXaMl6
         d30/XAL0R8z/nVyQD+ctaiclS045r8w49gJierpaLD15gNMk2JC7hVtpMHsa7P/sH0Bi
         P0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=WyJL9gBmTRco9kopOCRhN0tx7dMJbxokyE2WdQY2XFI=;
        b=drmTAnJ6UXQEbaG3AaRujz+En3Vbxi5BZu8HkgGCxDqFtbw236mr4WxwzFcMXqhF2I
         1pmyC11GjFLx5jq60HhuW/70ZGqZPVkv7Mvg2d6wvMsrXXaA6/p8lSXdHrXLxP5G0ZZU
         acwmONysQodiJDNpgttuFUbIRlzPNHNyWvwCUwjtkqfICqzPJ+19DtcEnPUlSyDebDl1
         fOjU9S5YE78dE8YQ6koDUTmfcZjOWaONpddR8QS8LKrNlYI27JXRst1lPE9juvg8sHje
         DcIfj1R+A7DUSM0s6TNRNsoCJZgIUMrXod1Jk7JuEF4UKEH+iSsvaX72Qpeuj11l/EcK
         HgzA==
X-Gm-Message-State: AOAM531GSBbgzW7upguI6qtD2zOU1teL8E6n8t/FW7dkcCM4lLWo0F4b
        dLsjqryuXEHw+9Cu/JDXDvotk7LTyWY=
X-Google-Smtp-Source: ABdhPJxQXz3iS7z/iXVKTfMlV6YlKR1qixdbN0KmelDMvahlypDLBaz+kpw7q9LqjfOBqQI/R6UlJw==
X-Received: by 2002:a2e:a415:: with SMTP id p21mr12944220ljn.384.1634310255330;
        Fri, 15 Oct 2021 08:04:15 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id o9sm622143ljh.9.2021.10.15.08.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 08:04:14 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2] stash: implement '--staged' option for 'push' and 'save'
References: <875yugcs3l.fsf@osv.gnss.ru> <87lf2zz59w.fsf@osv.gnss.ru>
Date:   Fri, 15 Oct 2021 18:04:13 +0300
In-Reply-To: <87lf2zz59w.fsf@osv.gnss.ru> (Sergey Organov's message of "Mon,
        11 Oct 2021 23:16:11 +0300")
Message-ID: <87fst2gwia.fsf_-_@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Stash only the changes that are staged.

This mode allows to easily stash-out for later reuse some changes
unrelated to the current work in progress.

Unlike 'stash push --patch', --staged supports use of any tool to
select the changes to stash-out, including, but not limited to 'git
add --interactive'.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---

This operation that is essentially just a 'git commit', but to the stash
rather than to the current branch, is somehow missed, complicating the
task that is otherwise simple and natural. For example, see discussions
here:

https://stackoverflow.com/questions/14759748/stashing-only-staged-changes-in-git-is-it-possible

Changes in v2:

  * Fixed English grammar in commit message

  * Fixed copy-paste error in help description

Changes in v1:

  * Implement separate stash_staged() instead of re-using and changing
    stash_patch()

  * Add test

  * Minor documentation cleanup

 Documentation/git-stash.txt | 34 ++++++++++++++--
 builtin/stash.c             | 80 ++++++++++++++++++++++++++++++++-----
 t/t3903-stash.sh            | 11 +++++
 3 files changed, 113 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index be6084ccefbe..6e15f4752576 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 'git stash' drop [-q|--quiet] [<stash>]
 'git stash' ( pop | apply ) [--index] [-q|--quiet] [<stash>]
 'git stash' branch <branchname> [<stash>]
-'git stash' [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
+'git stash' [push [-p|--patch] [-S|--staged] [-k|--[no-]keep-index] [-q|--quiet]
 	     [-u|--include-untracked] [-a|--all] [-m|--message <message>]
 	     [--pathspec-from-file=<file> [--pathspec-file-nul]]
 	     [--] [<pathspec>...]]
@@ -47,7 +47,7 @@ stash index (e.g. the integer `n` is equivalent to `stash@{n}`).
 COMMANDS
 --------
 
-push [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [-m|--message <message>] [--pathspec-from-file=<file> [--pathspec-file-nul]] [--] [<pathspec>...]::
+push [-p|--patch] [-S|--staged] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [-m|--message <message>] [--pathspec-from-file=<file> [--pathspec-file-nul]] [--] [<pathspec>...]::
 
 	Save your local modifications to a new 'stash entry' and roll them
 	back to HEAD (in the working tree and in the index).
@@ -60,7 +60,7 @@ subcommand from making an unwanted stash entry.  The two exceptions to this
 are `stash -p` which acts as alias for `stash push -p` and pathspec elements,
 which are allowed after a double hyphen `--` for disambiguation.
 
-save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
+save [-p|--patch] [-S|--staged] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
 
 	This option is deprecated in favour of 'git stash push'.  It
 	differs from "stash push" in that it cannot take pathspec.
@@ -205,6 +205,16 @@ to learn how to operate the `--patch` mode.
 The `--patch` option implies `--keep-index`.  You can use
 `--no-keep-index` to override this.
 
+-S::
+--staged::
+	This option is only valid for `push` and `save` commands.
++
+Stash only the changes that are currently staged. This is similar to
+basic `git commit` except the state is committed to the stash instead
+of current branch.
++
+The `--patch` option has priority over this one.
+
 --pathspec-from-file=<file>::
 	This option is only valid for `push` command.
 +
@@ -341,6 +351,24 @@ $ edit/build/test remaining parts
 $ git commit foo -m 'Remaining parts'
 ----------------------------------------------------------------
 
+Saving unrelated changes for future use::
+
+When you are in the middle of massive changes and you find some
+unrelated issue that you don't want to forget to fix, you can do the
+change(s), stage them, and use `git stash push --staged` to stash them
+out for future use. This is similar to committing the staged changes,
+only the commit ends-up being in the stash and not on the current branch.
++
+----------------------------------------------------------------
+# ... hack hack hack ...
+$ git add --patch foo           # add unrelated changes to the index
+$ git stash push --staged       # save these changes to the stash
+# ... hack hack hack, finish curent changes ...
+$ git commit -m 'Massive'       # commit fully tested changes
+$ git switch fixup-branch       # switch to another branch
+$ git stash pop                 # to finish work on the saved changes
+----------------------------------------------------------------
+
 Recovering stash entries that were cleared/dropped erroneously::
 
 If you mistakenly drop or clear stash entries, they cannot be recovered
diff --git a/builtin/stash.c b/builtin/stash.c
index 8f42360ca913..cdc142f16602 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -27,11 +27,11 @@ static const char * const git_stash_usage[] = {
 	N_("git stash ( pop | apply ) [--index] [-q|--quiet] [<stash>]"),
 	N_("git stash branch <branchname> [<stash>]"),
 	"git stash clear",
-	N_("git stash [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
+	N_("git stash [push [-p|--patch] [-S|--staged] [-k|--[no-]keep-index] [-q|--quiet]\n"
 	   "          [-u|--include-untracked] [-a|--all] [-m|--message <message>]\n"
 	   "          [--pathspec-from-file=<file> [--pathspec-file-nul]]\n"
 	   "          [--] [<pathspec>...]]"),
-	N_("git stash save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
+	N_("git stash save [-p|--patch] [-S|--staged] [-k|--[no-]keep-index] [-q|--quiet]\n"
 	   "          [-u|--include-untracked] [-a|--all] [<message>]"),
 	NULL
 };
@@ -1116,6 +1116,38 @@ static int save_untracked_files(struct stash_info *info, struct strbuf *msg,
 	return ret;
 }
 
+static int stash_staged(struct stash_info *info, const struct pathspec *ps,
+		       struct strbuf *out_patch, int quiet)
+{
+	int ret = 0;
+	struct child_process cp_diff_tree = CHILD_PROCESS_INIT;
+	struct index_state istate = { NULL };
+
+	if (write_index_as_tree(&info->w_tree, &istate, the_repository->index_file,
+				0, NULL)) {
+		ret = -1;
+		goto done;
+	}
+
+	cp_diff_tree.git_cmd = 1;
+	strvec_pushl(&cp_diff_tree.args, "diff-tree", "-p", "-U1", "HEAD",
+		     oid_to_hex(&info->w_tree), "--", NULL);
+	if (pipe_command(&cp_diff_tree, NULL, 0, out_patch, 0, NULL, 0)) {
+		ret = -1;
+		goto done;
+	}
+
+	if (!out_patch->len) {
+		if (!quiet)
+			fprintf_ln(stderr, _("No changes selected"));
+		ret = 1;
+	}
+
+done:
+	discard_index(&istate);
+	return ret;
+}
+
 static int stash_patch(struct stash_info *info, const struct pathspec *ps,
 		       struct strbuf *out_patch, int quiet)
 {
@@ -1242,7 +1274,7 @@ static int stash_working_tree(struct stash_info *info, const struct pathspec *ps
 }
 
 static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_buf,
-			   int include_untracked, int patch_mode,
+			   int include_untracked, int patch_mode, int only_staged,
 			   struct stash_info *info, struct strbuf *patch,
 			   int quiet)
 {
@@ -1321,6 +1353,16 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
 		} else if (ret > 0) {
 			goto done;
 		}
+	} else if (only_staged) {
+		ret = stash_staged(info, ps, patch, quiet);
+		if (ret < 0) {
+			if (!quiet)
+				fprintf_ln(stderr, _("Cannot save the current "
+						     "staged state"));
+			goto done;
+		} else if (ret > 0) {
+			goto done;
+		}
 	} else {
 		if (stash_working_tree(info, ps)) {
 			if (!quiet)
@@ -1379,7 +1421,7 @@ static int create_stash(int argc, const char **argv, const char *prefix)
 	if (!check_changes_tracked_files(&ps))
 		return 0;
 
-	ret = do_create_stash(&ps, &stash_msg_buf, 0, 0, &info,
+	ret = do_create_stash(&ps, &stash_msg_buf, 0, 0, 0, &info,
 			      NULL, 0);
 	if (!ret)
 		printf_ln("%s", oid_to_hex(&info.w_commit));
@@ -1389,7 +1431,7 @@ static int create_stash(int argc, const char **argv, const char *prefix)
 }
 
 static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int quiet,
-			 int keep_index, int patch_mode, int include_untracked)
+			 int keep_index, int patch_mode, int include_untracked, int only_staged)
 {
 	int ret = 0;
 	struct stash_info info;
@@ -1407,6 +1449,17 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 		goto done;
 	}
 
+	/* --patch overrides --staged */
+	if (patch_mode)
+		only_staged = 0;
+
+	if (only_staged && include_untracked) {
+		fprintf_ln(stderr, _("Can't use --staged and --include-untracked"
+				     " or --all at the same time"));
+		ret = -1;
+		goto done;
+	}
+
 	read_cache_preload(NULL);
 	if (!include_untracked && ps->nr) {
 		int i;
@@ -1447,7 +1500,7 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 
 	if (stash_msg)
 		strbuf_addstr(&stash_msg_buf, stash_msg);
-	if (do_create_stash(ps, &stash_msg_buf, include_untracked, patch_mode,
+	if (do_create_stash(ps, &stash_msg_buf, include_untracked, patch_mode, only_staged,
 			    &info, &patch, quiet)) {
 		ret = -1;
 		goto done;
@@ -1464,7 +1517,7 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 		printf_ln(_("Saved working directory and index state %s"),
 			  stash_msg_buf.buf);
 
-	if (!patch_mode) {
+	if (!(patch_mode || only_staged)) {
 		if (include_untracked && !ps->nr) {
 			struct child_process cp = CHILD_PROCESS_INIT;
 
@@ -1581,6 +1634,7 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 {
 	int force_assume = 0;
 	int keep_index = -1;
+	int only_staged = 0;
 	int patch_mode = 0;
 	int include_untracked = 0;
 	int quiet = 0;
@@ -1591,6 +1645,8 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 	struct option options[] = {
 		OPT_BOOL('k', "keep-index", &keep_index,
 			 N_("keep index")),
+		OPT_BOOL('S', "staged", &only_staged,
+			 N_("stash staged changes only")),
 		OPT_BOOL('p', "patch", &patch_mode,
 			 N_("stash in patch mode")),
 		OPT__QUIET(&quiet, N_("quiet mode")),
@@ -1629,6 +1685,9 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 		if (patch_mode)
 			die(_("--pathspec-from-file is incompatible with --patch"));
 
+		if (only_staged)
+			die(_("--pathspec-from-file is incompatible with --staged"));
+
 		if (ps.nr)
 			die(_("--pathspec-from-file is incompatible with pathspec arguments"));
 
@@ -1640,12 +1699,13 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 	}
 
 	return do_push_stash(&ps, stash_msg, quiet, keep_index, patch_mode,
-			     include_untracked);
+			     include_untracked, only_staged);
 }
 
 static int save_stash(int argc, const char **argv, const char *prefix)
 {
 	int keep_index = -1;
+	int only_staged = 0;
 	int patch_mode = 0;
 	int include_untracked = 0;
 	int quiet = 0;
@@ -1656,6 +1716,8 @@ static int save_stash(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_BOOL('k', "keep-index", &keep_index,
 			 N_("keep index")),
+		OPT_BOOL('S', "staged", &only_staged,
+			 N_("stash staged changes only")),
 		OPT_BOOL('p', "patch", &patch_mode,
 			 N_("stash in patch mode")),
 		OPT__QUIET(&quiet, N_("quiet mode")),
@@ -1677,7 +1739,7 @@ static int save_stash(int argc, const char **argv, const char *prefix)
 
 	memset(&ps, 0, sizeof(ps));
 	ret = do_push_stash(&ps, stash_msg, quiet, keep_index,
-			    patch_mode, include_untracked);
+			    patch_mode, include_untracked, only_staged);
 
 	strbuf_release(&stash_msg_buf);
 	return ret;
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 873aa56e359d..18ea885412b8 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -288,6 +288,17 @@ test_expect_success 'stash --no-keep-index' '
 	test bar,bar2 = $(cat file),$(cat file2)
 '
 
+test_expect_success 'stash --staged' '
+	echo bar3 >file &&
+	echo bar4 >file2 &&
+	git add file2 &&
+	git stash --staged &&
+	test bar3,bar2 = $(cat file),$(cat file2) &&
+	git reset --hard &&
+	git stash pop &&
+	test bar,bar4 = $(cat file),$(cat file2)
+'
+
 test_expect_success 'dont assume push with non-option args' '
 	test_must_fail git stash -q drop 2>err &&
 	test_i18ngrep -e "subcommand wasn'\''t specified; '\''push'\'' can'\''t be assumed due to unexpected token '\''drop'\''" err
-- 
2.25.1

