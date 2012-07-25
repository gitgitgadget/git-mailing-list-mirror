From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v6 7/7] i18n: merge-recursive: mark strings for translation
Date: Wed, 25 Jul 2012 22:53:13 +0800
Message-ID: <3471633fab7274cd958d9324513c8f59c3d694fc.1343227806.git.worldhello.net@gmail.com>
References: <cover.1343227806.git.worldhello.net@gmail.com>
 <9f7ba1a0ce85184cc410bf7c2e8c3133f46f0237.1343227806.git.worldhello.net@gmail.com>
 <051a48c40cd144e36c4cd5798376d56bdc4705bf.1343227806.git.worldhello.net@gmail.com>
 <0aa19c8238587fc04616b67bc6dfa9c926fcfb5f.1343227806.git.worldhello.net@gmail.com>
 <6326c11afd7b4077f2aba27101fd9acc8e2f8b6a.1343227806.git.worldhello.net@gmail.com>
 <7483bb4c75600ac3ffd4f740040a4256ff70821f.1343227806.git.worldhello.net@gmail.com>
 <c44188f93823a8028086d8abf5c59250b877c25c.1343227806.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 16:56:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Su30C-0008Vz-4r
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 16:55:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030185Ab2GYOys (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 10:54:48 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:40079 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933385Ab2GYOy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 10:54:28 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so1526654pbb.19
        for <git@vger.kernel.org>; Wed, 25 Jul 2012 07:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=1X6q4dU3G2TjM0zRMMZg8SxRMFTB7azRo8v4YXiITo8=;
        b=xfmtH+pEQUYpp4iS6utSMM1nrlzzT8rEBeb47FgofYGWQ6104KCW1yMD1fPnfJvgTi
         YTryKmPVCMpV31o6eEuGHljfkQOJ3FY6x1ty9d4t2GxalLebqVkapD+958sWcX6dhx9E
         6Rq9e/Afi7iG3kyghjQxVlLZM4TcOGOeI4DZEQ7vMKdJHoQXdUr9LMMHo2RiCasixYsT
         9/ARBwjgH7U9gJu8jfpt8v2lt1pGuVbXnEC9Pc21SOOYq9vz4r9ELPXGlR0xxhwB+bqI
         Cdr3gQZyGFCo2o6Cv2GpeLOji9rftC+/ss5MNc98eWDA4YFmPkcewSE5cwClRVGA0Jum
         skqw==
Received: by 10.68.212.138 with SMTP id nk10mr54615719pbc.93.1343228067857;
        Wed, 25 Jul 2012 07:54:27 -0700 (PDT)
Received: from localhost.foo.bar ([123.116.228.123])
        by mx.google.com with ESMTPS id px1sm1886775pbb.49.2012.07.25.07.54.20
        (version=SSLv3 cipher=OTHER);
        Wed, 25 Jul 2012 07:54:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc0.16.gf4916ac
In-Reply-To: <c44188f93823a8028086d8abf5c59250b877c25c.1343227806.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1343227806.git.worldhello.net@gmail.com>
References: <cover.1343227806.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202165>

Mark strings in merge-recursive for translation.

Some tests would start to fail with GETTEXT_POISON turned on after
this update.  Use test_i18ncmp and test_i18ngrep where appropriate
to mark strings that should only be checked in the C locale output
to avoid such issues.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Reviewed-by: Stefano Lattarini <stefano.lattarini@gmail.com>
---
 merge-recursive.c                    | 148 +++++++++++++++++++----------------
 t/t6022-merge-rename.sh              |  16 ++--
 t/t6042-merge-rename-corner-cases.sh |   2 +-
 3 files changed, 88 insertions(+), 78 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 68093..8903 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -187,7 +187,7 @@ static void output_commit_title(struct merge_options *o, struct commit *commit)
 	else {
 		printf("%s ", find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV));
 		if (parse_commit(commit) != 0)
-			printf("(bad commit)\n");
+			printf(_("(bad commit)\n"));
 		else {
 			const char *title;
 			int len = find_commit_subject(commit->buffer, &title);
@@ -203,7 +203,7 @@ static int add_cacheinfo(unsigned int mode, const unsigned char *sha1,
 	struct cache_entry *ce;
 	ce = make_cache_entry(mode, sha1 ? sha1 : null_sha1, path, stage, refresh);
 	if (!ce)
-		return error("addinfo_cache failed for path '%s'", path);
+		return error(_("addinfo_cache failed for path '%s'"), path);
 	return add_cache_entry(ce, options);
 }
 
@@ -265,7 +265,7 @@ struct tree *write_tree_from_memory(struct merge_options *o)
 	if (!cache_tree_fully_valid(active_cache_tree) &&
 	    cache_tree_update(active_cache_tree,
 			      active_cache, active_nr, 0) < 0)
-		die("error building trees");
+		die(_("error building trees"));
 
 	result = lookup_tree(active_cache_tree->sha1);
 
@@ -494,7 +494,7 @@ static struct string_list *get_renames(struct merge_options *o,
 	opts.show_rename_progress = o->show_rename_progress;
 	opts.output_format = DIFF_FORMAT_NO_OUTPUT;
 	if (diff_setup_done(&opts) < 0)
-		die("diff setup failed");
+		die(_("diff setup failed"));
 	diff_tree_sha1(o_tree->object.sha1, tree->object.sha1, "", &opts);
 	diffcore_std(&opts);
 	if (opts.needed_rename_limit > o->needed_rename_limit)
@@ -624,7 +624,7 @@ static void flush_buffer(int fd, const char *buf, unsigned long size)
 				break;
 			die_errno("merge-recursive");
 		} else if (!ret) {
-			die("merge-recursive: disk full?");
+			die(_("merge-recursive: disk full?"));
 		}
 		size -= ret;
 		buf += ret;
@@ -687,7 +687,7 @@ static int would_lose_untracked(const char *path)
 static int make_room_for_path(struct merge_options *o, const char *path)
 {
 	int status, i;
-	const char *msg = "failed to create path '%s'%s";
+	const char *msg = _("failed to create path '%s'%s");
 
 	/* Unlink any D/F conflict files that are in the way */
 	for (i = 0; i < o->df_conflict_file_set.nr; i++) {
@@ -698,7 +698,7 @@ static int make_room_for_path(struct merge_options *o, const char *path)
 		    path[df_pathlen] == '/' &&
 		    strncmp(path, df_path, df_pathlen) == 0) {
 			output(o, 3,
-			       "Removing %s to make room for subdirectory\n",
+			       _("Removing %s to make room for subdirectory\n"),
 			       df_path);
 			unlink(df_path);
 			unsorted_string_list_delete_item(&o->df_conflict_file_set,
@@ -712,7 +712,7 @@ static int make_room_for_path(struct merge_options *o, const char *path)
 	if (status) {
 		if (status == -3) {
 			/* something else exists */
-			error(msg, path, ": perhaps a D/F conflict?");
+			error(msg, path, _(": perhaps a D/F conflict?"));
 			return -1;
 		}
 		die(msg, path, "");
@@ -723,7 +723,7 @@ static int make_room_for_path(struct merge_options *o, const char *path)
 	 * tracking it.
 	 */
 	if (would_lose_untracked(path))
-		return error("refusing to lose untracked file at '%s'",
+		return error(_("refusing to lose untracked file at '%s'"),
 			     path);
 
 	/* Successful unlink is good.. */
@@ -733,7 +733,7 @@ static int make_room_for_path(struct merge_options *o, const char *path)
 	if (errno == ENOENT)
 		return 0;
 	/* .. but not some other error (who really cares what?) */
-	return error(msg, path, ": perhaps a D/F conflict?");
+	return error(msg, path, _(": perhaps a D/F conflict?"));
 }
 
 static void update_file_flags(struct merge_options *o,
@@ -763,9 +763,9 @@ static void update_file_flags(struct merge_options *o,
 
 		buf = read_sha1_file(sha, &type, &size);
 		if (!buf)
-			die("cannot read object %s '%s'", sha1_to_hex(sha), path);
+			die(_("cannot read object %s '%s'"), sha1_to_hex(sha), path);
 		if (type != OBJ_BLOB)
-			die("blob expected for %s '%s'", sha1_to_hex(sha), path);
+			die(_("blob expected for %s '%s'"), sha1_to_hex(sha), path);
 		if (S_ISREG(mode)) {
 			struct strbuf strbuf = STRBUF_INIT;
 			if (convert_to_working_tree(path, buf, size, &strbuf)) {
@@ -788,7 +788,7 @@ static void update_file_flags(struct merge_options *o,
 				mode = 0666;
 			fd = open(path, O_WRONLY | O_TRUNC | O_CREAT, mode);
 			if (fd < 0)
-				die_errno("failed to open '%s'", path);
+				die_errno(_("failed to open '%s'"), path);
 			flush_buffer(fd, buf, size);
 			close(fd);
 		} else if (S_ISLNK(mode)) {
@@ -796,10 +796,10 @@ static void update_file_flags(struct merge_options *o,
 			safe_create_leading_directories_const(path);
 			unlink(path);
 			if (symlink(lnk, path))
-				die_errno("failed to symlink '%s'", path);
+				die_errno(_("failed to symlink '%s'"), path);
 			free(lnk);
 		} else
-			die("do not know what to do with %06o %s '%s'",
+			die(_("do not know what to do with %06o %s '%s'"),
 			    mode, sha1_to_hex(sha), path);
 		free(buf);
 	}
@@ -936,11 +936,11 @@ static struct merge_file_info merge_file_1(struct merge_options *o,
 						  branch1, branch2);
 
 			if ((merge_status < 0) || !result_buf.ptr)
-				die("Failed to execute internal merge");
+				die(_("Failed to execute internal merge"));
 
 			if (write_sha1_file(result_buf.ptr, result_buf.size,
 					    blob_type, result.sha))
-				die("Unable to add %s to database",
+				die(_("Unable to add %s to database"),
 				    a->path);
 
 			free(result_buf.ptr);
@@ -956,7 +956,7 @@ static struct merge_file_info merge_file_1(struct merge_options *o,
 			if (!sha_eq(a->sha1, b->sha1))
 				result.clean = 0;
 		} else {
-			die("unsupported object type in the tree");
+			die(_("unsupported object type in the tree"));
 		}
 	}
 
@@ -1034,22 +1034,32 @@ static void handle_change_delete(struct merge_options *o,
 		remove_file_from_cache(path);
 		update_file(o, 0, o_sha, o_mode, renamed ? renamed : path);
 	} else if (!a_sha) {
-		output(o, 1, "CONFLICT (%s/delete): %s deleted in %s "
-		       "and %s in %s. Version %s of %s left in tree%s%s.",
-		       change, path, o->branch1,
-		       change_past, o->branch2, o->branch2, path,
-		       NULL == renamed ? "" : " at ",
-		       NULL == renamed ? "" : renamed);
-		update_file(o, 0, b_sha, b_mode, renamed ? renamed : path);
+		if (!renamed) {
+			output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
+			       "and %s in %s. Version %s of %s left in tree."),
+			       change, path, o->branch1, change_past,
+			       o->branch2, o->branch2, path);
+			update_file(o, 0, b_sha, b_mode, path);
+		} else {
+			output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
+			       "and %s in %s. Version %s of %s left in tree at %s."),
+			       change, path, o->branch1, change_past,
+			       o->branch2, o->branch2, path, renamed);
+			update_file(o, 0, b_sha, b_mode, renamed);
+		}
 	} else {
-		output(o, 1, "CONFLICT (%s/delete): %s deleted in %s "
-		       "and %s in %s. Version %s of %s left in tree%s%s.",
-		       change, path, o->branch2,
-		       change_past, o->branch1, o->branch1, path,
-		       NULL == renamed ? "" : " at ",
-		       NULL == renamed ? "" : renamed);
-		if (renamed)
+		if (!renamed) {
+			output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
+			       "and %s in %s. Version %s of %s left in tree."),
+			       change, path, o->branch2, change_past,
+			       o->branch1, o->branch1, path);
+		} else {
+			output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
+			       "and %s in %s. Version %s of %s left in tree at %s."),
+			       change, path, o->branch2, change_past,
+			       o->branch1, o->branch1, path, renamed);
 			update_file(o, 0, a_sha, a_mode, renamed);
+		}
 		/*
 		 * No need to call update_file() on path when !renamed, since
 		 * that would needlessly touch path.  We could call
@@ -1085,7 +1095,7 @@ static void conflict_rename_delete(struct merge_options *o,
 			     orig->sha1, orig->mode,
 			     a_sha, a_mode,
 			     b_sha, b_mode,
-			     "rename", "renamed");
+			     _("rename"), _("renamed"));
 
 	if (o->call_depth) {
 		remove_file_from_cache(dest->path);
@@ -1141,7 +1151,7 @@ static void handle_file(struct merge_options *o,
 	} else {
 		if (dir_in_way(rename->path, !o->call_depth)) {
 			dst_name = unique_path(o, rename->path, cur_branch);
-			output(o, 1, "%s is a directory in %s adding as %s instead",
+			output(o, 1, _("%s is a directory in %s adding as %s instead"),
 			       rename->path, other_branch, dst_name);
 		}
 	}
@@ -1163,12 +1173,12 @@ static void conflict_rename_rename_1to2(struct merge_options *o,
 	struct diff_filespec *a = ci->pair1->two;
 	struct diff_filespec *b = ci->pair2->two;
 
-	output(o, 1, "CONFLICT (rename/rename): "
+	output(o, 1, _("CONFLICT (rename/rename): "
 	       "Rename \"%s\"->\"%s\" in branch \"%s\" "
-	       "rename \"%s\"->\"%s\" in \"%s\"%s",
+	       "rename \"%s\"->\"%s\" in \"%s\"%s"),
 	       one->path, a->path, ci->branch1,
 	       one->path, b->path, ci->branch2,
-	       o->call_depth ? " (left unresolved)" : "");
+	       o->call_depth ? _(" (left unresolved)") : "");
 	if (o->call_depth) {
 		struct merge_file_info mfi;
 		struct diff_filespec other;
@@ -1222,9 +1232,9 @@ static void conflict_rename_rename_2to1(struct merge_options *o,
 	struct merge_file_info mfi_c1;
 	struct merge_file_info mfi_c2;
 
-	output(o, 1, "CONFLICT (rename/rename): "
+	output(o, 1, _("CONFLICT (rename/rename): "
 	       "Rename %s->%s in %s. "
-	       "Rename %s->%s in %s",
+	       "Rename %s->%s in %s"),
 	       a->path, c1->path, ci->branch1,
 	       b->path, c2->path, ci->branch2);
 
@@ -1252,7 +1262,7 @@ static void conflict_rename_rename_2to1(struct merge_options *o,
 	} else {
 		char *new_path1 = unique_path(o, path, ci->branch1);
 		char *new_path2 = unique_path(o, path, ci->branch2);
-		output(o, 1, "Renaming %s to %s and %s to %s instead",
+		output(o, 1, _("Renaming %s to %s and %s to %s instead"),
 		       a->path, new_path1, b->path, new_path2);
 		remove_file(o, 0, path, 0);
 		update_file(o, 0, mfi_c1.sha, mfi_c1.mode, new_path1);
@@ -1451,8 +1461,8 @@ static int process_renames(struct merge_options *o,
 			} else if (!sha_eq(dst_other.sha1, null_sha1)) {
 				clean_merge = 0;
 				try_merge = 1;
-				output(o, 1, "CONFLICT (rename/add): Rename %s->%s in %s. "
-				       "%s added in %s",
+				output(o, 1, _("CONFLICT (rename/add): Rename %s->%s in %s. "
+				       "%s added in %s"),
 				       ren1_src, ren1_dst, branch1,
 				       ren1_dst, branch2);
 				if (o->call_depth) {
@@ -1461,12 +1471,12 @@ static int process_renames(struct merge_options *o,
 							 ren1->pair->two->sha1, ren1->pair->two->mode,
 							 dst_other.sha1, dst_other.mode,
 							 branch1, branch2);
-					output(o, 1, "Adding merged %s", ren1_dst);
+					output(o, 1, _("Adding merged %s"), ren1_dst);
 					update_file(o, 0, mfi.sha, mfi.mode, ren1_dst);
 					try_merge = 0;
 				} else {
 					char *new_path = unique_path(o, ren1_dst, branch2);
-					output(o, 1, "Adding as %s instead", new_path);
+					output(o, 1, _("Adding as %s instead"), new_path);
 					update_file(o, 0, dst_other.sha1, dst_other.mode, new_path);
 					free(new_path);
 				}
@@ -1517,10 +1527,10 @@ static int read_sha1_strbuf(const unsigned char *sha1, struct strbuf *dst)
 	unsigned long size;
 	buf = read_sha1_file(sha1, &type, &size);
 	if (!buf)
-		return error("cannot read object %s", sha1_to_hex(sha1));
+		return error(_("cannot read object %s"), sha1_to_hex(sha1));
 	if (type != OBJ_BLOB) {
 		free(buf);
-		return error("object %s is not a blob", sha1_to_hex(sha1));
+		return error(_("object %s is not a blob"), sha1_to_hex(sha1));
 	}
 	strbuf_attach(dst, buf, size, size + 1);
 	return 0;
@@ -1568,7 +1578,7 @@ static void handle_modify_delete(struct merge_options *o,
 			     o_sha, o_mode,
 			     a_sha, a_mode,
 			     b_sha, b_mode,
-			     "modify", "modified");
+			     _("modify"), _("modified"));
 }
 
 static int merge_content(struct merge_options *o,
@@ -1578,14 +1588,14 @@ static int merge_content(struct merge_options *o,
 			 unsigned char *b_sha, int b_mode,
 			 struct rename_conflict_info *rename_conflict_info)
 {
-	const char *reason = "content";
+	const char *reason = _("content");
 	const char *path1 = NULL, *path2 = NULL;
 	struct merge_file_info mfi;
 	struct diff_filespec one, a, b;
 	unsigned df_conflict_remains = 0;
 
 	if (!o_sha) {
-		reason = "add/add";
+		reason = _("add/add");
 		o_sha = (unsigned char *)null_sha1;
 	}
 	one.path = a.path = b.path = (char *)path;
@@ -1619,7 +1629,7 @@ static int merge_content(struct merge_options *o,
 	if (mfi.clean && !df_conflict_remains &&
 	    sha_eq(mfi.sha, a_sha) && mfi.mode == a_mode) {
 		int path_renamed_outside_HEAD;
-		output(o, 3, "Skipped %s (merged same as existing)", path);
+		output(o, 3, _("Skipped %s (merged same as existing)"), path);
 		/*
 		 * The content merge resulted in the same file contents we
 		 * already had.  We can return early if those file contents
@@ -1633,12 +1643,12 @@ static int merge_content(struct merge_options *o,
 			return mfi.clean;
 		}
 	} else
-		output(o, 2, "Auto-merging %s", path);
+		output(o, 2, _("Auto-merging %s"), path);
 
 	if (!mfi.clean) {
 		if (S_ISGITLINK(mfi.mode))
-			reason = "submodule";
-		output(o, 1, "CONFLICT (%s): Merge conflict in %s",
+			reason = _("submodule");
+		output(o, 1, _("CONFLICT (%s): Merge conflict in %s"),
 				reason, path);
 		if (rename_conflict_info && !df_conflict_remains)
 			update_stages(path, &one, &a, &b);
@@ -1664,7 +1674,7 @@ static int merge_content(struct merge_options *o,
 
 		}
 		new_path = unique_path(o, path, rename_conflict_info->branch1);
-		output(o, 1, "Adding as %s instead", new_path);
+		output(o, 1, _("Adding as %s instead"), new_path);
 		update_file(o, 0, mfi.sha, mfi.mode, new_path);
 		free(new_path);
 		mfi.clean = 0;
@@ -1728,7 +1738,7 @@ static int process_entry(struct merge_options *o,
 			/* Deleted in both or deleted in one and
 			 * unchanged in the other */
 			if (a_sha)
-				output(o, 2, "Removing %s", path);
+				output(o, 2, _("Removing %s"), path);
 			/* do not touch working file if it did not exist */
 			remove_file(o, 1, path, !a_sha);
 		} else {
@@ -1753,19 +1763,19 @@ static int process_entry(struct merge_options *o,
 			other_branch = o->branch2;
 			mode = a_mode;
 			sha = a_sha;
-			conf = "file/directory";
+			conf = _("file/directory");
 		} else {
 			add_branch = o->branch2;
 			other_branch = o->branch1;
 			mode = b_mode;
 			sha = b_sha;
-			conf = "directory/file";
+			conf = _("directory/file");
 		}
 		if (dir_in_way(path, !o->call_depth)) {
 			char *new_path = unique_path(o, path, add_branch);
 			clean_merge = 0;
-			output(o, 1, "CONFLICT (%s): There is a directory with name %s in %s. "
-			       "Adding %s as %s",
+			output(o, 1, _("CONFLICT (%s): There is a directory with name %s in %s. "
+			       "Adding %s as %s"),
 			       conf, path, other_branch, path, new_path);
 			if (o->call_depth)
 				remove_file_from_cache(path);
@@ -1774,7 +1784,7 @@ static int process_entry(struct merge_options *o,
 				remove_file_from_cache(path);
 			free(new_path);
 		} else {
-			output(o, 2, "Adding %s", path);
+			output(o, 2, _("Adding %s"), path);
 			/* do not overwrite file if already present */
 			update_file_flags(o, sha, mode, path, 1, !a_sha);
 		}
@@ -1791,7 +1801,7 @@ static int process_entry(struct merge_options *o,
 		 */
 		remove_file(o, 1, path, !a_mode);
 	} else
-		die("Fatal merge failure, shouldn't happen.");
+		die(_("Fatal merge failure, shouldn't happen."));
 
 	return clean_merge;
 }
@@ -1810,7 +1820,7 @@ int merge_trees(struct merge_options *o,
 	}
 
 	if (sha_eq(common->object.sha1, merge->object.sha1)) {
-		output(o, 0, "Already up-to-date!");
+		output(o, 0, _("Already up-to-date!"));
 		*result = head;
 		return 1;
 	}
@@ -1819,7 +1829,7 @@ int merge_trees(struct merge_options *o,
 
 	if (code != 0) {
 		if (show(o, 4) || o->call_depth)
-			die("merging of trees %s and %s failed",
+			die(_("merging of trees %s and %s failed"),
 			    sha1_to_hex(head->object.sha1),
 			    sha1_to_hex(merge->object.sha1));
 		else
@@ -1849,7 +1859,7 @@ int merge_trees(struct merge_options *o,
 		for (i = 0; i < entries->nr; i++) {
 			struct stage_data *e = entries->items[i].util;
 			if (!e->processed)
-				die("Unprocessed path??? %s",
+				die(_("Unprocessed path??? %s"),
 				    entries->items[i].string);
 		}
 
@@ -1894,7 +1904,7 @@ int merge_recursive(struct merge_options *o,
 	int clean;
 
 	if (show(o, 4)) {
-		output(o, 4, "Merging:");
+		output(o, 4, _("Merging:"));
 		output_commit_title(o, h1);
 		output_commit_title(o, h2);
 	}
@@ -1905,7 +1915,7 @@ int merge_recursive(struct merge_options *o,
 	}
 
 	if (show(o, 5)) {
-		output(o, 5, "found %u common ancestor(s):", commit_list_count(ca));
+		output(o, 5, _("found %u common ancestor(s):"), commit_list_count(ca));
 		for (iter = ca; iter; iter = iter->next)
 			output_commit_title(o, iter->item);
 	}
@@ -1941,7 +1951,7 @@ int merge_recursive(struct merge_options *o,
 		o->call_depth--;
 
 		if (!merged_common_ancestors)
-			die("merge returned no commit");
+			die(_("merge returned no commit"));
 	}
 
 	discard_cache();
@@ -1998,7 +2008,7 @@ int merge_recursive_generic(struct merge_options *o,
 		for (i = 0; i < num_base_list; ++i) {
 			struct commit *base;
 			if (!(base = get_ref(base_list[i], sha1_to_hex(base_list[i]))))
-				return error("Could not parse object '%s'",
+				return error(_("Could not parse object '%s'"),
 					sha1_to_hex(base_list[i]));
 			commit_list_insert(base, &ca);
 		}
@@ -2010,7 +2020,7 @@ int merge_recursive_generic(struct merge_options *o,
 	if (active_cache_changed &&
 			(write_cache(index_fd, active_cache, active_nr) ||
 			 commit_locked_index(lock)))
-		return error("Unable to write index.");
+		return error(_("Unable to write index."));
 
 	return clean ? 0 : 1;
 }
diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index 11042..c680f 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -242,10 +242,10 @@ test_expect_success 'merge of identical changes in a renamed file' '
 	rm -f A M N &&
 	git reset --hard &&
 	git checkout change+rename &&
-	GIT_MERGE_VERBOSITY=3 git merge change | grep "^Skipped B" &&
+	GIT_MERGE_VERBOSITY=3 git merge change | test_i18ngrep "^Skipped B" &&
 	git reset --hard HEAD^ &&
 	git checkout change &&
-	GIT_MERGE_VERBOSITY=3 git merge change+rename | grep "^Skipped B"
+	GIT_MERGE_VERBOSITY=3 git merge change+rename | test_i18ngrep "^Skipped B"
 '
 
 test_expect_success 'setup for rename + d/f conflicts' '
@@ -303,9 +303,9 @@ test_expect_success 'Rename+D/F conflict; renamed file merges but dir in way' '
 	git checkout -q renamed-file-has-no-conflicts^0 &&
 	test_must_fail git merge --strategy=recursive dir-in-way >output &&
 
-	grep "CONFLICT (modify/delete): dir/file-in-the-way" output &&
-	grep "Auto-merging dir" output &&
-	grep "Adding as dir~HEAD instead" output &&
+	test_i18ngrep "CONFLICT (modify/delete): dir/file-in-the-way" output &&
+	test_i18ngrep "Auto-merging dir" output &&
+	test_i18ngrep "Adding as dir~HEAD instead" output &&
 
 	test 3 -eq "$(git ls-files -u | wc -l)" &&
 	test 2 -eq "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
@@ -325,9 +325,9 @@ test_expect_success 'Same as previous, but merged other way' '
 	test_must_fail git merge --strategy=recursive renamed-file-has-no-conflicts >output 2>errors &&
 
 	! grep "error: refusing to lose untracked file at" errors &&
-	grep "CONFLICT (modify/delete): dir/file-in-the-way" output &&
-	grep "Auto-merging dir" output &&
-	grep "Adding as dir~renamed-file-has-no-conflicts instead" output &&
+	test_i18ngrep "CONFLICT (modify/delete): dir/file-in-the-way" output &&
+	test_i18ngrep "Auto-merging dir" output &&
+	test_i18ngrep "Adding as dir~renamed-file-has-no-conflicts instead" output &&
 
 	test 3 -eq "$(git ls-files -u | wc -l)" &&
 	test 2 -eq "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-rename-corner-cases.sh
index 466fa3..4115 100755
--- a/t/t6042-merge-rename-corner-cases.sh
+++ b/t/t6042-merge-rename-corner-cases.sh
@@ -380,7 +380,7 @@ test_expect_success 'handle rename/rename (2to1) conflict correctly' '
 	git checkout B^0 &&
 
 	test_must_fail git merge -s recursive C^0 >out &&
-	grep "CONFLICT (rename/rename)" out &&
+	test_i18ngrep "CONFLICT (rename/rename)" out &&
 
 	test 2 -eq $(git ls-files -s | wc -l) &&
 	test 2 -eq $(git ls-files -u | wc -l) &&
-- 
1.7.12.rc0.16.gf4916ac
