Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB99C474262
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 21:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785275548; cv=none; b=i1Pox9aciPZB9knE7R0LfcVRCuopnS+gFcQGCwb3QdcHM3YxyXFAUDkHTWO7hfFrn+jc5lIUEaS0i3lMoGno+9h8DssBanjhOGqxHNCZ8wSwyjYgfMt+QMy5WcYG32x03LynDUMJdIq1winYxzaKezHwa0rZvNEDkp56szhZOr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785275548; c=relaxed/simple;
	bh=hzJ79u5b1zRETLrGe9Nc2BUFM0teAbYP0BXUN8lW4VQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IDqrDYfJH7p70ZLFrXsKDHxBGJhskqJ2QbC3DwvZE9w/1SVUjggkxWxugCRHx71d8ePIFs1ed6RCiPAcA5evWiPqq+B37OXKaXD+yhmnRdQuzyNJ1qLaklD5aOn/dK7/hu15+p+kanorPAw+qk972cv654lj95gDeAZCmWyOIc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NGs9nNBJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Tg+C4jMU; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NGs9nNBJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tg+C4jMU"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 18F2C7A0304;
	Tue, 28 Jul 2026 17:52:26 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 28 Jul 2026 17:52:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1785275545; x=
	1785361945; bh=Bd9OAMV+GMBgXcJMOd4NnBPjPrf227fAWEEOY781rx4=; b=N
	Gs9nNBJnc9InLOl5fTSV3HC43E/o8xSRtuuUnEAxao/JP2Nl2lnxVzJ/ckp9h6l/
	8EdZ/8IetzNb1LrOwyxHvkh2YclAs6fHfUKxCp+OIvHErqW8KaAzLE/x+yPuGMbe
	KLiPF0970/fPEKcbaOlFDVjpEmywUORysTIBjpO8pWzmzUp1+9iRMCkPc1+ELHfH
	7x2Q8345RGNXWPEGJYd2JWNYo3q9pB0LROYl09kUwLVEO0Sq11PKrkl9xITIPGR6
	E6n5cJLx0tu1J3l5LoerZSqg+XCPjouk7QQtuVXk3AQLCYODzniYeI5wjkAqmB3o
	uDkky5rgJI9ZZySBqdWWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1785275545; x=1785361945; bh=Bd9OAMV+GMBgXcJMOd4NnBPjPrf2
	27fAWEEOY781rx4=; b=Tg+C4jMUiz+NBU+mVoQUsY3ohW4tTZgmjWXwzu7X7UHC
	CZfqEux1bDD6ItziWztAbugW7YETaMDzUAYQljV0reHkj4o3FebmoPAoRmcub4lo
	HYC9XK7SCNR/sSgSNible4WQv0xKYngkeFo00UNGsF/L7QoJfi/CUthVS2Awh+Oc
	WSET0b5iwJbAL442m1n93aqeWlLGH1qbnrF2Q+glh3VB9SLdRcw35KV+q/AI32kk
	3eKrvdbkM2zTedNGb06VXiDtZTZD9hOR0CIsK+/vg+rKso+scPoalDJ19EnlPcLf
	woy3K+YsIwn3XWmHqUNFpVVx58xxWXr45XfXM2eOvQ==
X-ME-Sender: <xms:mSRparoM_I-DgjTNj54YD60zgWXkILgQhr8yhpFvzzAby9Kw4P-aRg>
    <xme:mSRparomzKF1r7yT5AsVXO_2q7jtnY7tG1_xe3c5DBDf13jT4dANtQAlg_NfyikdT
    rvOPFgGJejsBwKevQgOdbmfJrzx5fVnaOKZIIORO5UPIrsI5kHs_A>
X-ME-Received: <xmr:mSRpal2PeIKrLA1xi4K_UMqsJ42yue-aclza0wnkFkbsqFNhlPlmtWx5uxbTC-qyZqsFuyCqcnQkojZlUI2xdnPp5i2MlgG1bA>
X-ME-Proxy-Cause: dmFkZTGTYS8IyANUBlYljF2SsCM0nnk8PbnNwK1jgXzEI7WXK8nYIyBdHRiouorzz3/dqz
    IkihEPXnQxdbfn+YxooLy2l5ugLcCI3QdVwHOcC8rF5ak0o+J9KRensyBZutaRYeOJ1Un3
    YVuhuwJ23otYSY0fU+UTvdgGOPHcz4sf8NIE6ne306NH3IRwK55pQRKY0DvNOiEWpS8Z9s
    ohhNcFDJ30G9Mp8lcZFWUwO84cdqL6XlN3r9RiEDZG44UoghhWm36aZtyB/8iO2UYCg8jZ
    072u26Lt/Tma14AIAwFGlm1/EZeh2mwZi+2AOTvE+bgIC7d2pCR803xP2uNEeLpCQoh7H/
    +MTRFFqwN0sQyeBDcR5YLhpe1+UVRZVeRS+fRcrNaqdJGH/UhofmgYWTPG+1ZZLiMNGIR2
    tdFr712lk9tb0IPVX61+R7xGun2XQuh2tX63JpNnzMPRF8plta5v8lwHLHYA3uca5Z32R3
    7NuFg7NWECgWIaNoQuSKy7i0d+gGN3xDEpV0w1OokC2i+puj/ie4jisDvgpch3r5enAgQ6
    r21I/hPWJJ9Nf/qz9fDjeRTERH+CuQYBbm7aBp3ej+w2AFvssKzEOy4DnD8cygTBkfHOIT
    HejJ8P6I+YU73nNFU0dOrwwOaUvutJ93ar01kXwB9a5l5qmrdaJlw+DRfVeQ
X-ME-Proxy: <xmx:mSRpaqDhuNV2L9F9VQssqR9Xe6Grgi0IhrnIkDglW_A_olxQMzfsVw>
    <xmx:mSRpatdOtMODf4nESvCKmmd5duAyY6a6X5ImzOovji3ZC9VTik5tsQ>
    <xmx:mSRpavimZhCBnL7RgiTK1tFxeER491G8wMde28rikcze_xBGCO8A7g>
    <xmx:mSRpalqa7A1FWdsTBDbCwWfmg7JMzaBFXH2TxJO-tm5sfJ2wk6FqXw>
    <xmx:mSRpavD_h3F3XYmpX6-__h3Se54wB8EydERVW5sdrDsIVqmEtZmbH07n>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jul 2026 17:52:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 3/4] add: introduce '--resolved' option
Date: Tue, 28 Jul 2026 14:52:18 -0700
Message-ID: <20260728215219.753678-4-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-594-g42d2bf033e
In-Reply-To: <20260728215219.753678-1-gitster@pobox.com>
References: <20260728215219.753678-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During a conflicted merge, rebase, or cherry-pick, 'git add -u' is a
handy way to add modified paths to the index.  However, '-u'
indiscriminately adds all modified tracked paths, including unmerged
paths that may still contain unresolved conflict markers.  It also
adds tracked files modified in the worktree that are not involved in
the ongoing merge.

The latter is not a huge problem for "git rebase", which refuses to
start with any local changes, but is a problem for "git merge",
which is often run with local changes in maintainer workflows.

Introduce 'git add --resolved' to add only unmerged paths, limited
by an optional pathspec, where no conflict markers remain in the
working tree.

Before modifying the index, scan unmerged regular files for leftover
conflict markers using a new helper, has_conflict_markers(), defined
in merge-ll.c in terms of the is_conflict_marker_line() helper we
introduced earlier.  If any unmerged path still contains conflict
markers, show an error listing the conflicted paths and abort
without updating the index.  Otherwise, add these unmerged paths
that do not have conflict markers to the index.

Note that unmerged paths without conflict markers (such as binary
files and deletions) are added as resolved using add_file_to_index()
and remove_file_from_index_with_flags().  Tracked files that were
not in a conflicted state are ignored by '--resolved'.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-add.adoc |  10 +++-
 builtin/add.c              |  92 ++++++++++++++++++++++++++++---
 merge-ll.c                 |  22 ++++++++
 merge-ll.h                 |   1 +
 t/t2207-add-resolved.sh    | 108 +++++++++++++++++++++++++++++++++++++
 5 files changed, 226 insertions(+), 7 deletions(-)
 create mode 100755 t/t2207-add-resolved.sh

diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
index 941135dc63..16b06e38e1 100644
--- a/Documentation/git-add.adoc
+++ b/Documentation/git-add.adoc
@@ -11,7 +11,7 @@ SYNOPSIS
 git add [--verbose | -v] [--dry-run | -n] [--force | -f] [--interactive | -i] [--patch | -p]
 	[--edit | -e] [--[no-]all | -A | --[no-]ignore-removal | [--update | -u]] [--sparse]
 	[--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-missing] [--renormalize]
-	[--chmod=(+|-)x] [--pathspec-from-file=<file> [--pathspec-file-nul]]
+	[--resolved] [--chmod=(+|-)x] [--pathspec-from-file=<file> [--pathspec-file-nul]]
 	[--] [<pathspec>...]
 
 DESCRIPTION
@@ -195,6 +195,14 @@ for `git add --no-all <pathspec>...`, i.e. ignored removed files.
 	while a _CRLF_ cleans to _LF_, a _CRCRLF_ sequence is only partially
 	cleaned to _CRLF_.
 
+`--resolved`::
+	Update the index for unmerged paths matching _<pathspec>_ where
+	no conflict markers remain in the working tree. Unmerged paths
+	without conflict markers (including binary files and file
+	deletions) are staged as resolved, while any path with leftover
+	conflict markers causes the command to refuse to stage any files.
+	Cannot be combined with `-u` or `-A`.
+
 `--chmod=(+|-)x`::
 	Override the executable bit of the added files.  The executable
 	bit is only changed in the index, the files on disk are left
diff --git a/builtin/add.c b/builtin/add.c
index 60ffbede2b..6db57f5773 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -26,6 +26,7 @@
 #include "strvec.h"
 #include "submodule.h"
 #include "add-interactive.h"
+#include "merge-ll.h"
 
 static const char * const builtin_add_usage[] = {
 	N_("git add [<options>] [--] <pathspec>..."),
@@ -35,6 +36,7 @@ static int patch_interactive, add_interactive, edit_interactive;
 static struct interactive_options interactive_opts = INTERACTIVE_OPTIONS_INIT;
 static int take_worktree_changes;
 static int add_renormalize;
+static int add_resolved;
 static int pathspec_file_nul;
 static int include_sparse;
 static const char *pathspec_from_file;
@@ -265,6 +267,7 @@ static struct option builtin_add_options[] = {
 	OPT__FORCE(&ignored_too, N_("allow adding otherwise ignored files"), 0),
 	OPT_BOOL('u', "update", &take_worktree_changes, N_("update tracked files")),
 	OPT_BOOL(0, "renormalize", &add_renormalize, N_("renormalize EOL of tracked files (implies -u)")),
+	OPT_BOOL(0, "resolved", &add_resolved, N_("add conflict-resolved tracked files")),
 	OPT_BOOL('N', "intent-to-add", &intent_to_add, N_("record only the fact that the path will be added later")),
 	OPT_BOOL('A', "all", &addremove_explicit, N_("add changes from all tracked and untracked files")),
 	OPT_CALLBACK_F(0, "ignore-removal", &addremove_explicit,
@@ -379,6 +382,76 @@ static int add_files(struct repository *repo, struct dir_struct *dir, int flags)
 	return exit_status;
 }
 
+static int failed_to_add(int flags, const char *path)
+{
+	if (!(flags & ADD_CACHE_IGNORE_ERRORS))
+		die(_("updating file '%s' failed"), path);
+	return 1;
+}
+
+static int add_resolved_files(struct repository *repo,
+			      const struct pathspec *pathspec,
+			      int flags)
+{
+	struct index_state *istate = repo->index;
+	struct string_list unmerged_paths = STRING_LIST_INIT_DUP;
+	struct string_list unresolved_paths = STRING_LIST_INIT_DUP;
+	int exit_status = 0;
+	size_t i;
+
+	for (i = 0; i < istate->cache_nr; i++) {
+		struct cache_entry *ce = istate->cache[i];
+		if (!ce_stage(ce))
+			continue;
+		if (pathspec->nr && !ce_path_match(istate, ce, pathspec, NULL))
+			continue;
+		if (!unmerged_paths.nr ||
+		    strcmp(unmerged_paths.items[unmerged_paths.nr - 1].string, ce->name))
+			string_list_append(&unmerged_paths, ce->name);
+	}
+
+	if (!unmerged_paths.nr) {
+		string_list_clear(&unmerged_paths, 0);
+		return 0;
+	}
+
+	for (i = 0; i < unmerged_paths.nr; i++) {
+		const char *path = unmerged_paths.items[i].string;
+		struct stat st;
+
+		if (!lstat(path, &st) && S_ISREG(st.st_mode)) {
+			if (has_conflict_markers(istate, path))
+				string_list_append(&unresolved_paths, path);
+		}
+	}
+
+	if (unresolved_paths.nr) {
+		struct strbuf sb = STRBUF_INIT;
+		for (i = 0; i < unresolved_paths.nr; i++)
+			strbuf_addf(&sb, "\t%s\n", unresolved_paths.items[i].string);
+		die(_("the following paths still have conflict markers:\n%s"), sb.buf);
+	}
+
+	for (i = 0; i < unmerged_paths.nr; i++) {
+		const char *path = unmerged_paths.items[i].string;
+		struct stat st;
+
+		if (lstat(path, &st)) {
+			if (errno != ENOENT)
+				die_errno(_("cannot lstat: '%s'"), path);
+			if (remove_file_from_index_with_flags(istate, path, flags))
+				exit_status = failed_to_add(flags, path);
+		} else {
+			if (add_file_to_index(istate, path, flags))
+				exit_status = failed_to_add(flags, path);
+		}
+	}
+
+	string_list_clear(&unmerged_paths, 0);
+	string_list_clear(&unresolved_paths, 0);
+	return exit_status;
+}
+
 int cmd_add(int argc,
 	    const char **argv,
 	    const char *prefix,
@@ -438,8 +511,9 @@ int cmd_add(int argc,
 	else if (take_worktree_changes && ADDREMOVE_DEFAULT)
 		addremove = 0; /* "-u" was given but not "-A" */
 
-	if (addremove && take_worktree_changes)
-		die(_("options '%s' and '%s' cannot be used together"), "-A", "-u");
+	die_for_incompatible_opt3(take_worktree_changes, "-u/--update",
+				  0 <= addremove_explicit, "-A/--all",
+				  add_resolved, "--resolved");
 
 	if (!show_only && ignore_missing)
 		die(_("the option '%s' requires '%s'"), "--ignore-missing", "--dry-run");
@@ -448,8 +522,11 @@ int cmd_add(int argc,
 			  chmod_arg[1] != 'x' || chmod_arg[2]))
 		die(_("--chmod param '%s' must be either -x or +x"), chmod_arg);
 
-	add_new_files = !take_worktree_changes && !refresh_only && !add_renormalize;
-	require_pathspec = !(take_worktree_changes || (0 < addremove_explicit));
+	add_new_files = !take_worktree_changes && !refresh_only &&
+			!add_renormalize && !add_resolved;
+	require_pathspec = !(take_worktree_changes ||
+			     (0 < addremove_explicit) ||
+			     add_resolved);
 
 	repo_hold_locked_index(repo, &lock_file, LOCK_DIE_ON_ERROR);
 
@@ -481,7 +558,8 @@ int cmd_add(int argc,
 		return 0;
 	}
 
-	if (!take_worktree_changes && addremove_explicit < 0 && pathspec.nr)
+	if (!take_worktree_changes && !add_resolved &&
+	    addremove_explicit < 0 && pathspec.nr)
 		/* Turn "git add pathspec..." to "git add -A pathspec..." */
 		addremove = 1;
 
@@ -584,7 +662,9 @@ int cmd_add(int argc,
 	odb_transaction_begin_or_die(repo->objects, &transaction, 0);
 
 	ps_matched = xcalloc(pathspec.nr, 1);
-	if (add_renormalize)
+	if (add_resolved)
+		exit_status |= add_resolved_files(repo, &pathspec, flags);
+	else if (add_renormalize)
 		exit_status |= renormalize_tracked_files(repo, &pathspec, flags);
 	else
 		exit_status |= add_files_to_cache(repo, prefix,
diff --git a/merge-ll.c b/merge-ll.c
index 41c97fb90a..5e5044b9e3 100644
--- a/merge-ll.c
+++ b/merge-ll.c
@@ -499,3 +499,25 @@ int is_conflict_marker_line(const char *line, unsigned long len, int marker_size
 
 	return firstchar;
 }
+
+int has_conflict_markers(struct index_state *istate, const char *path)
+{
+	FILE *f;
+	struct strbuf sb = STRBUF_INIT;
+	int marker_size = ll_merge_marker_size(istate, path);
+	int has_markers = 0;
+
+	f = fopen(path, "r");
+	if (!f)
+		return 0;
+
+	while (strbuf_getwholeline(&sb, f, '\n') != EOF) {
+		if (is_conflict_marker_line(sb.buf, sb.len, marker_size)) {
+			has_markers = 1;
+			break;
+		}
+	}
+	fclose(f);
+	strbuf_release(&sb);
+	return has_markers;
+}
diff --git a/merge-ll.h b/merge-ll.h
index b348aee15d..f26aef238d 100644
--- a/merge-ll.h
+++ b/merge-ll.h
@@ -110,6 +110,7 @@ enum ll_merge_result ll_merge(mmbuffer_t *result_buf,
 
 int ll_merge_marker_size(struct index_state *istate, const char *path);
 int is_conflict_marker_line(const char *line, unsigned long len, int marker_size);
+int has_conflict_markers(struct index_state *istate, const char *path);
 void reset_merge_attributes(void);
 
 #endif
diff --git a/t/t2207-add-resolved.sh b/t/t2207-add-resolved.sh
new file mode 100755
index 0000000000..f88e3f413e
--- /dev/null
+++ b/t/t2207-add-resolved.sh
@@ -0,0 +1,108 @@
+#!/bin/sh
+
+test_description='git add --resolved
+
+Test that "git add --resolved" stages conflict-resolved paths and
+refuses to stage when conflict markers remain.'
+
+. ./test-lib.sh
+
+test_expect_success 'setup repo' '
+	echo base >file1.txt &&
+	echo base >file2.txt &&
+	echo base >file3.txt &&
+	echo base >file4.txt &&
+	git add file1.txt file2.txt file3.txt file4.txt &&
+	git commit -m initial &&
+
+	git branch topic &&
+	echo "ours 1" >file1.txt &&
+	echo "ours 2" >file2.txt &&
+	echo "ours 3" >file3.txt &&
+	git commit -a -m ours &&
+
+	git checkout topic &&
+	echo "theirs 1" >file1.txt &&
+	echo "theirs 2" >file2.txt &&
+	echo "theirs 3" >file3.txt &&
+	git commit -a -m theirs &&
+
+	git checkout master
+'
+
+test_expect_success 'git add --resolved refuses files with conflict markers' '
+	test_when_finished "git reset --hard HEAD" &&
+	test_must_fail git merge topic &&
+	echo "resolved 1" >file1.txt &&
+	test_must_fail git add --resolved 2>err &&
+	test_grep "the following paths still have conflict markers:" err &&
+	test_grep "file2.txt" err &&
+	test_grep "file3.txt" err &&
+	# Index should remain unmerged for all files
+	git ls-files -u file1.txt >unmerged &&
+	test_line_count = 3 unmerged
+'
+
+test_expect_success 'git add --resolved succeeds when all conflict markers are removed' '
+	test_when_finished "git reset --hard HEAD" &&
+	test_must_fail git merge topic &&
+	echo "resolved 1" >file1.txt &&
+	echo "resolved 2" >file2.txt &&
+	echo "resolved 3" >file3.txt &&
+	git add --resolved &&
+	git ls-files -u >unmerged &&
+	test_must_be_empty unmerged &&
+	git ls-files -s file1.txt file2.txt file3.txt >staged &&
+	test_line_count = 3 staged
+'
+
+test_expect_success 'git add --resolved ignores unconflicted modified files' '
+	test_when_finished "git reset --hard HEAD" &&
+	echo "unconflicted local change" >>file4.txt &&
+	test_must_fail git merge topic &&
+	echo "resolved 1" >file1.txt &&
+	echo "resolved 2" >file2.txt &&
+	echo "resolved 3" >file3.txt &&
+	git add --resolved &&
+	# file1, file2, file3 should be staged as resolved
+	git ls-files -u >unmerged &&
+	test_must_be_empty unmerged &&
+	# file4 should remain unstaged in working tree
+	git diff file4.txt >diff_out &&
+	test_grep "unconflicted local change" diff_out &&
+	git diff --cached file4.txt >cached_out &&
+	test_must_be_empty cached_out
+'
+
+test_expect_success 'git add --resolved handles file removals' '
+	test_when_finished "git reset --hard HEAD" &&
+	test_must_fail git merge topic &&
+	echo "resolved 1" >file1.txt &&
+	rm file2.txt &&
+	echo "resolved 3" >file3.txt &&
+	git add --resolved &&
+	git ls-files -s file2.txt >out &&
+	test_must_be_empty out
+'
+
+test_expect_success 'git add --resolved honors pathspec' '
+	test_when_finished "git reset --hard HEAD" &&
+	test_must_fail git merge topic &&
+	echo "resolved 1" >file1.txt &&
+	# file2.txt and file3.txt still have conflict markers,
+	# but pathspec targets only file1.txt
+	git add --resolved file1.txt &&
+	git ls-files -u file1.txt >unmerged1 &&
+	test_must_be_empty unmerged1 &&
+	git ls-files -u file2.txt >unmerged2 &&
+	test_line_count = 3 unmerged2
+'
+
+test_expect_success 'git add --resolved incompatibility with -u and -A' '
+	test_must_fail git add --resolved -u 2>err1 &&
+	test_grep "cannot be used together" err1 &&
+	test_must_fail git add --resolved -A 2>err2 &&
+	test_grep "cannot be used together" err2
+'
+
+test_done
-- 
2.55.0-594-g42d2bf033e

