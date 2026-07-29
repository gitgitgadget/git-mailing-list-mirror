Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4DE37E5D4
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 17:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785345937; cv=none; b=DHYbgAaOLWAJ1b69uXWZimBdK4DNVkmI+aPzCcI3MPK7ACIA2NdkMz4A9NwHHK9GMehAomNaq0yIE00FiTx8umEQ+VW691oMC+ZFkead4CSAunbsdHwsfbevTebiD971emeOuKBxiNSPo/z4dVH+5oHgJEOVBglVJBgOjoLWJ6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785345937; c=relaxed/simple;
	bh=MCny3Xqwjhjn93H/Qpj9tA/WpfFkTImbuiu+9BnURnU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GM9H4kG4jx1lf8G3i37eQugyGRR/0pyHAFcuezYLHkb9tpcup/LyXFpPTWPnhXVTfr8/y2iQ7U2hhCTw0CyqwKEG/eiHK612P0evb/nhI8rZpwcR+a1spUSdS7Rq78hdrIJlNda0vVQr1kb0Z+sjdl6CsH07F39EAECMslDIpKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=N+5lhsCx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I3FTqxkv; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="N+5lhsCx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I3FTqxkv"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id CA0931D0010D;
	Wed, 29 Jul 2026 13:25:32 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 29 Jul 2026 13:25:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1785345932; x=
	1785432332; bh=tlUTH+UCG09QHVrtv1gOp1Oxrlh04E+TJtTyEPpllKo=; b=N
	+5lhsCxNxpQsazZiJkegdxr3kX4LQwvlzrc6aGNiqSui4qo7O4O9wm46FhP2OfPV
	DAy1Kk0vtLwnzFjt4w4/07hSsaPiD4bLaP91hAE3TPseb8eN/5JtTsP/3i1jzlTn
	a1yoy5hDwkNnJgTn+wJCDjzBAUcIAuB2OLPyF4eWtxpjbGBg2Nh8Sgma58JL9IHm
	m37SPR4bSe7SiSlwNbLQm6Eab/Zf8x3w/Xli95Ucu5SeDGtcI3kqjsdaVoWQDWGP
	vYj+kYkbA5RBzy4vIAoookwhKyIOmDI9eK12E06UTsu8UmYJ88BlJ4NgbJS2tMLv
	xc4O+DZkpgjkiaUC3pksg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1785345932; x=1785432332; bh=tlUTH+UCG09QHVrtv1gOp1Oxrlh0
	4E+TJtTyEPpllKo=; b=I3FTqxkv23ffl5LZEOIZKxMCUv2o9GFqYsO6VDaXdByt
	k+80A/ddfEA9XaeElpd7OqHDe39IVgOlxlku+lFd+y5lCNfmCmTDwhYOVye2sK/g
	BjqFcwmK47tAS/xnjSIdF0Z74hb/JMbgA0cx58llrY8SW/TU1gspNFpADT3aJvh5
	b7AonxXLi5rXFB0QZ/DWWi5cd1B3F+xtKHdsmWN23Yn48thLtMMicQFbGuXpP+cF
	mcbTItUr1twJ5i8LgpABd6iuR8n3lBScIKI+lOHXcK5KaoV3LdRNKIy9FgnV8S1u
	HOHHW7s/wi8ktVj6eO4n5m/wfam8XjWJzd2jSw2s3w==
X-ME-Sender: <xms:jDdqah7OpWVBusPAYJi8MK4qBhu0W75ltQAoEhRcE4_IQIBaSqBuxg>
    <xme:jDdqak5WAx-vkhJ6br5cReJtGHWu8TrS_1BTvG3kHlf0Wp7mhMfKSjOlkipjauQH2
    Bbr911RTHDjA8dwAV1xqBIq13YAi4TnwJQFxBp_j6znAboUhxJnWA>
X-ME-Received: <xmr:jDdqamHJJpygFVpbL0ObTmVoy7qZgSdzEo2z7V1NyY0QIsvuxuUV6YGU0lIfzare6PqS1yzMo-toDEeAeVGeQ195eLSZ7J7h2g>
X-ME-Proxy-Cause: dmFkZTF+v+8yG3Tp7laux+N+bhCyrwZdS2FgR4g3xpEOAGHKWfqhAMODsiWszA75kqxP/9
    Fayc9QP01a3DisyvMq0FGWpVVl8i3R6oRVrz6vlK9Z+nkPwIjptjUZNSSUaSToYBhXGvZk
    S/mHKX78l2YaOEuXV8pG+FXY6suTMo3h3UqO/BZ1EJTrv2l17NBrR5vnqFqH1PkwXAvTbA
    UyVI4NyU0dTTspyweKO3fW6qgIYNSuHOWE8pojZvtm5F0sUl407jfJbGk405m50cAnd1L6
    ai2FaFNN1gd7ip+kSmPfwxPYT1868V/k3b8PK2CdRoicSMMAgZmuEJdxhxtRKHF6ftZLXw
    6rJQ2p9cA3pJR4SnTdoBx2aXGrtWzq9yJT44v5Ku+AC/hOcDw2gaNd9raSU2Boh21974t0
    BSzZfgdEJeNqovh9K4Nb0qh+Lw87lEVRyBbz2WNMRUy7ohSDybwV/Iht/8WBKhjKfTJvnm
    +5bogwSlEInf1QnqTQdzVb+ECnu73mR7+bF/uKxdcWuWTj7Q/dA2RYhdiNMy1gNmVFL6b9
    2C4C6BTIEc1eVXHmDTk3BiQH41elTqFw46XdQzCCztvcsV3WBrWD1fQ2bt6oien3LJcDUj
    MSR0ldYvwxwVjVNO+nITg6iyKGaVfjaPABPhTk1VGN/oYO/EE59Ju+XZNeNw
X-ME-Proxy: <xmx:jDdqalQtt0C0O2adZsggNZuggWc_MlVbsY3DzOgBLv84xcIV0OAqRA>
    <xmx:jDdqantC7qumGfJUufCUZa7m9ADKTouwIzETVX6R5c7JPZZ4w_YzMQ>
    <xmx:jDdqasy7KNUl9PAWIKZ5zP_bK90a09LN_0L7lVSfu9vBhZui9j5LzQ>
    <xmx:jDdqap7wtT7qddwAEC9NZZCdukLfqm7uzdLARfWDP7BUHBNb1Hm8mA>
    <xmx:jDdqalRDwlAvyvNbQLs-r5TsgopPQe1O2qp7-oK2A-_IC7ZBGVvvzWSB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jul 2026 13:25:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 4/4] add: introduce '--resolved' option
Date: Wed, 29 Jul 2026 10:25:24 -0700
Message-ID: <20260729172524.4022621-5-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-609-g9a17695db7
In-Reply-To: <20260729172524.4022621-1-gitster@pobox.com>
References: <20260728215219.753678-1-gitster@pobox.com>
 <20260729172524.4022621-1-gitster@pobox.com>
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
 merge-ll.c                 |  25 +++++++++
 merge-ll.h                 |   1 +
 t/meson.build              |   1 +
 t/t2207-add-resolved.sh    | 108 +++++++++++++++++++++++++++++++++++++
 6 files changed, 230 insertions(+), 7 deletions(-)
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
index 60ffbede2b..eab8f03cad 100644
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
+				  0 < addremove_explicit, "-A/--all",
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
index 41c97fb90a..ef5287dee8 100644
--- a/merge-ll.c
+++ b/merge-ll.c
@@ -499,3 +499,28 @@ int is_conflict_marker_line(const char *line, unsigned long len, int marker_size
 
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
+		if (buffer_is_binary(sb.buf,
+				     ULONG_MAX <= sb.len ? ULONG_MAX : sb.len))
+			break;
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
diff --git a/t/meson.build b/t/meson.build
index 8ae6ab6c5f..e0f4b85ad5 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -304,6 +304,7 @@ integration_tests = [
   't2204-add-ignored.sh',
   't2205-add-worktree-config.sh',
   't2206-add-submodule-ignored.sh',
+  't2207-add-resolved.sh',
   't2300-cd-to-toplevel.sh',
   't2400-worktree-add.sh',
   't2401-worktree-prune.sh',
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
2.55.0-609-g9a17695db7

