Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198B13F4C0
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 22:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=initialcommit-io.20230601.gappssmtp.com header.i=@initialcommit-io.20230601.gappssmtp.com header.b="QN5cukgj"
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8236D1A7
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 15:46:44 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6b6f4c118b7so1457691b3a.0
        for <git@vger.kernel.org>; Thu, 26 Oct 2023 15:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=initialcommit-io.20230601.gappssmtp.com; s=20230601; t=1698360404; x=1698965204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ePENa1rEU8OP3HHuwxyawix2ePhdaJNAh62a9RCjcA=;
        b=QN5cukgjdyMv6BMtmcCttfQIx1Cevo+JIJmUlzVGZ0jbFbL+L+N3m45DRdrn58BTSG
         b8dEqqOiKS92gi7EkWGicJ/LffpeHIcvCYjNlwwmqNxLZ2e4gaquUK8trqgpMFvEnNQu
         lFvgdFVTvwbFw7+rOVZ5lOV4ysWY3z5yARHwWEthLC07jb5CfQQ6D7JCfdpzMuDgO0kq
         fCHYcMeldjBeF73oeiUMY8KPiuzcWAPbywG7RQoKPaEG2MpNUSoVqa9eqAZQVAOHkEIf
         idZqtmpP/n067gEyQuoaWB3MUkDToW9h0NvV7A6e9IQvZ+eEH1Pxmf6FlMolr9cYL1Qg
         bpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698360404; x=1698965204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ePENa1rEU8OP3HHuwxyawix2ePhdaJNAh62a9RCjcA=;
        b=DyMQMHdr+ssbJieqc3YCcYcJYDYamoXBLRIO/YMJO2cVOZmJl2TOepBOI0pNIvMgf/
         qfhsKCcXEs3Wkd0vngfHWlZVXGb98YPW0W2Kjv0HD2kF43xS8LZdsH7arlhRdMUpj43+
         tX6YJcQQc0bdqU7BXs9pkSoZJDHJkQc2SiUjqHKzhkvfTPqThBgyhzSWwGsUojRN3Jxy
         kYZFX8i90cDm1BeQpqnggc2CYRr0Xw07nK2p2CyR5tO6DOFaHdeFs464i58BoeVvgOdt
         SY11XUxYOQujncSLP9zA/Dou9iV89ek15g/KAiGPEivwwVxV2FG0Dw4LZcdOihFz1+df
         lg7w==
X-Gm-Message-State: AOJu0YymysolBuld7bjHO2QfbFa2oGb9TQHGBUuUAgwQGdcVUhG8wo8w
	1HKxcEdmEtQvcrpNIN+B6ynSU5ejpCpyslbN21o=
X-Google-Smtp-Source: AGHT+IFyVTzMNJR3m/FsdMoUIikKt1crrsMgy+xXUEi0QPZN7Q7FJpkaZhyaTl1tUjMBXUEy4gBo4g==
X-Received: by 2002:a05:6a00:24d2:b0:6b9:f641:272e with SMTP id d18-20020a056a0024d200b006b9f641272emr999250pfv.24.1698360403464;
        Thu, 26 Oct 2023 15:46:43 -0700 (PDT)
Received: from localhost.localdomain (mobile-166-170-45-225.mycingular.net. [166.170.45.225])
        by smtp.gmail.com with ESMTPSA id s194-20020a6377cb000000b0058ac101ad83sm112318pgc.33.2023.10.26.15.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 15:46:42 -0700 (PDT)
From: Jacob Stopak <jacob@initialcommit.io>
To: git@vger.kernel.org
Cc: Jacob Stopak <jacob@initialcommit.io>
Subject: [RFC PATCH v2 3/6] add: implement noob mode
Date: Thu, 26 Oct 2023 15:46:12 -0700
Message-ID: <20231026224615.675172-4-jacob@initialcommit.io>
X-Mailer: git-send-email 2.42.0.404.g2bcc23f3db
In-Reply-To: <20231026224615.675172-1-jacob@initialcommit.io>
References: <20231020183947.463882-1-jacob@initialcommit.io>
 <20231026224615.675172-1-jacob@initialcommit.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Jacob Stopak <jacob@initialcommit.io>
---
 Makefile         |   1 +
 builtin/add.c    |  47 ++++++++---
 builtin/commit.c | 163 +-------------------------------------
 commit.c         |   2 +
 noob.c           | 198 +++++++++++++++++++++++++++++++++++++++++++++++
 noob.h           |  21 +++++
 read-cache-ll.h  |   9 ++-
 read-cache.c     |  32 ++++++--
 table.c          |  92 +++++++++++++++++++---
 wt-status.c      |   1 +
 wt-status.h      |   1 +
 11 files changed, 381 insertions(+), 186 deletions(-)
 create mode 100644 noob.c
 create mode 100644 noob.h

diff --git a/Makefile b/Makefile
index a7399ca8f0..78acfaf14d 100644
--- a/Makefile
+++ b/Makefile
@@ -1070,6 +1070,7 @@ LIB_OBJS += name-hash.o
 LIB_OBJS += negotiator/default.o
 LIB_OBJS += negotiator/noop.o
 LIB_OBJS += negotiator/skipping.o
+LIB_OBJS += noob.o
 LIB_OBJS += notes-cache.o
 LIB_OBJS += notes-merge.o
 LIB_OBJS += notes-utils.o
diff --git a/builtin/add.c b/builtin/add.c
index c27254a5cd..dbb99d179e 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -27,6 +27,9 @@
 #include "strvec.h"
 #include "submodule.h"
 #include "add-interactive.h"
+#include "wt-status.h"
+#include "commit.h"
+#include "noob.h"
 
 static const char * const builtin_add_usage[] = {
 	N_("git add [<options>] [--] <pathspec>..."),
@@ -322,7 +325,7 @@ static void check_embedded_repo(const char *path)
 	strbuf_release(&name);
 }
 
-static int add_files(struct dir_struct *dir, int flags)
+static int add_files(struct dir_struct *dir, int flags, struct wt_status *status)
 {
 	int i, exit_status = 0;
 	struct string_list matched_sparse_paths = STRING_LIST_INIT_NODUP;
@@ -345,7 +348,7 @@ static int add_files(struct dir_struct *dir, int flags)
 					   dir->entries[i]->name);
 			continue;
 		}
-		if (add_file_to_index(&the_index, dir->entries[i]->name, flags)) {
+		if (add_file_to_index_with_status(&the_index, dir->entries[i]->name, flags, status)) {
 			if (!ignore_add_errors)
 				die(_("adding files failed"));
 			exit_status = 1;
@@ -374,8 +377,14 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	int require_pathspec;
 	char *seen = NULL;
 	struct lock_file lock_file = LOCK_INIT;
-
+	struct wt_status status;
+	unsigned int progress_flag = 0;
+	
+	wt_status_prepare(the_repository, &status);
 	git_config(add_config, NULL);
+	git_config(git_status_config, &status);
+	finalize_deferred_config(&status);
+	status.status_format = status_format;
 
 	argc = parse_options(argc, argv, prefix, builtin_add_options,
 			  builtin_add_usage, PARSE_OPT_KEEP_ARGV0);
@@ -459,7 +468,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		 (intent_to_add ? ADD_CACHE_INTENT : 0) |
 		 (ignore_add_errors ? ADD_CACHE_IGNORE_ERRORS : 0) |
 		 (!(addremove || take_worktree_changes)
-		  ? ADD_CACHE_IGNORE_REMOVAL : 0));
+		  ? ADD_CACHE_IGNORE_REMOVAL : 0) |
+		 (status.status_format == STATUS_FORMAT_NOOB ? ADD_CACHE_FORMAT_NOOB : 0));
 
 	if (repo_read_index_preload(the_repository, &pathspec, 0) < 0)
 		die(_("index file corrupt"));
@@ -551,15 +561,32 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	begin_odb_transaction();
 
-	if (add_renormalize)
+	if (status.status_format == STATUS_FORMAT_NOOB) {
+		/* Read index and populate status */
+		repo_read_index(the_repository);
+		refresh_index(&the_index,
+			      REFRESH_QUIET|REFRESH_UNMERGED|progress_flag,
+			      &status.pathspec, NULL, NULL);
+		status.show_branch = 0;
+		wt_status_collect(&status);
+	}
+
+	if (add_renormalize) {
 		exit_status |= renormalize_tracked_files(&pathspec, flags);
-	else
-		exit_status |= add_files_to_cache(the_repository, prefix,
+	} else {
+		exit_status |= add_files_to_cache_with_status(the_repository, prefix,
 						  &pathspec, include_sparse,
-						  flags);
+						  flags, &status);
+	}
 
-	if (add_new_files)
-		exit_status |= add_files(&dir, flags);
+	if (add_new_files) {
+		exit_status |= add_files(&dir, flags, &status);
+	}
+
+	if (status.status_format == STATUS_FORMAT_NOOB) {
+		wt_status_print(&status);
+		wt_status_collect_free_buffers(&status);
+	}
 
 	if (chmod_arg && pathspec.nr)
 		exit_status |= chmod_pathspec(&pathspec, chmod_arg[0], show_only);
diff --git a/builtin/commit.c b/builtin/commit.c
index 880c42f5b7..3f816c117d 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -46,6 +46,7 @@
 #include "commit-reach.h"
 #include "commit-graph.h"
 #include "pretty.h"
+#include "noob.h"
 
 static const char * const builtin_commit_usage[] = {
 	N_("git commit [-a | --interactive | --patch] [-s] [-v] [-u<mode>] [--amend]\n"
@@ -148,8 +149,6 @@ static int use_editor = 1, include_status = 1;
 static int have_option_m;
 static struct strbuf message = STRBUF_INIT;
 
-static enum wt_status_format status_format = STATUS_FORMAT_UNSPECIFIED;
-
 static int opt_pass_trailer(const struct option *opt, const char *arg, int unset)
 {
 	BUG_ON_OPT_NEG(unset);
@@ -310,7 +309,7 @@ static void add_remove_files(struct string_list *list)
 			continue;
 
 		if (!lstat(p->string, &st)) {
-			if (add_to_index(&the_index, p->string, &st, 0))
+			if (add_file_to_index(&the_index, p->string, 0))
 				die(_("updating files failed"));
 		} else
 			remove_file_from_index(&the_index, p->string);
@@ -1196,59 +1195,6 @@ static const char *read_commit_message(const char *name)
 	return repo_logmsg_reencode(the_repository, commit, NULL, out_enc);
 }
 
-/*
- * Enumerate what needs to be propagated when --porcelain
- * is not in effect here.
- */
-static struct status_deferred_config {
-	enum wt_status_format status_format;
-	int show_branch;
-	enum ahead_behind_flags ahead_behind;
-} status_deferred_config = {
-	STATUS_FORMAT_UNSPECIFIED,
-	-1, /* unspecified */
-	AHEAD_BEHIND_UNSPECIFIED,
-};
-
-static void finalize_deferred_config(struct wt_status *s)
-{
-	int use_deferred_config = (status_format != STATUS_FORMAT_PORCELAIN &&
-				   status_format != STATUS_FORMAT_PORCELAIN_V2 &&
-				   !s->null_termination);
-
-	if (s->null_termination) {
-		if (status_format == STATUS_FORMAT_NONE ||
-		    status_format == STATUS_FORMAT_UNSPECIFIED)
-			status_format = STATUS_FORMAT_PORCELAIN;
-		else if (status_format == STATUS_FORMAT_LONG)
-			die(_("options '%s' and '%s' cannot be used together"), "--long", "-z");
-	}
-
-	if (use_deferred_config && status_format == STATUS_FORMAT_UNSPECIFIED)
-		status_format = status_deferred_config.status_format;
-	if (status_format == STATUS_FORMAT_UNSPECIFIED)
-		status_format = STATUS_FORMAT_NONE;
-
-	if (use_deferred_config && s->show_branch < 0)
-		s->show_branch = status_deferred_config.show_branch;
-	if (s->show_branch < 0)
-		s->show_branch = 0;
-
-	/*
-	 * If the user did not give a "--[no]-ahead-behind" command
-	 * line argument *AND* we will print in a human-readable format
-	 * (short, long etc.) then we inherit from the status.aheadbehind
-	 * config setting.  In all other cases (and porcelain V[12] formats
-	 * in particular), we inherit _FULL for backwards compatibility.
-	 */
-	if (use_deferred_config &&
-	    s->ahead_behind_flags == AHEAD_BEHIND_UNSPECIFIED)
-		s->ahead_behind_flags = status_deferred_config.ahead_behind;
-
-	if (s->ahead_behind_flags == AHEAD_BEHIND_UNSPECIFIED)
-		s->ahead_behind_flags = AHEAD_BEHIND_FULL;
-}
-
 static void check_fixup_reword_options(int argc, const char *argv[]) {
 	if (whence != FROM_COMMIT) {
 		if (whence == FROM_MERGE)
@@ -1399,111 +1345,6 @@ static int dry_run_commit(const char **argv, const char *prefix,
 
 define_list_config_array_extra(color_status_slots, {"added"});
 
-static int parse_status_slot(const char *slot)
-{
-	if (!strcasecmp(slot, "added"))
-		return WT_STATUS_UPDATED;
-
-	return LOOKUP_CONFIG(color_status_slots, slot);
-}
-
-static int git_status_config(const char *k, const char *v,
-			     const struct config_context *ctx, void *cb)
-{
-	struct wt_status *s = cb;
-	const char *slot_name;
-
-	if (starts_with(k, "column."))
-		return git_column_config(k, v, "status", &s->colopts);
-	if (!strcmp(k, "status.submodulesummary")) {
-		int is_bool;
-		s->submodule_summary = git_config_bool_or_int(k, v, ctx->kvi,
-							      &is_bool);
-		if (is_bool && s->submodule_summary)
-			s->submodule_summary = -1;
-		return 0;
-	}
-	if (!strcmp(k, "status.short")) {
-		if (git_config_bool(k, v))
-			status_deferred_config.status_format = STATUS_FORMAT_SHORT;
-		else
-			status_deferred_config.status_format = STATUS_FORMAT_NONE;
-		return 0;
-	}
-	if (!strcmp(k, "status.noob")) {
-		if (git_config_bool(k, v))
-			status_deferred_config.status_format = STATUS_FORMAT_NOOB;
-		else
-			status_deferred_config.status_format = STATUS_FORMAT_NONE;
-		return 0;
-	}
-	if (!strcmp(k, "status.branch")) {
-		status_deferred_config.show_branch = git_config_bool(k, v);
-		return 0;
-	}
-	if (!strcmp(k, "status.aheadbehind")) {
-		status_deferred_config.ahead_behind = git_config_bool(k, v);
-		return 0;
-	}
-	if (!strcmp(k, "status.showstash")) {
-		s->show_stash = git_config_bool(k, v);
-		return 0;
-	}
-	if (!strcmp(k, "status.color") || !strcmp(k, "color.status")) {
-		s->use_color = git_config_colorbool(k, v);
-		return 0;
-	}
-	if (!strcmp(k, "status.displaycommentprefix")) {
-		s->display_comment_prefix = git_config_bool(k, v);
-		return 0;
-	}
-	if (skip_prefix(k, "status.color.", &slot_name) ||
-	    skip_prefix(k, "color.status.", &slot_name)) {
-		int slot = parse_status_slot(slot_name);
-		if (slot < 0)
-			return 0;
-		if (!v)
-			return config_error_nonbool(k);
-		return color_parse(v, s->color_palette[slot]);
-	}
-	if (!strcmp(k, "status.relativepaths")) {
-		s->relative_paths = git_config_bool(k, v);
-		return 0;
-	}
-	if (!strcmp(k, "status.showuntrackedfiles")) {
-		if (!v)
-			return config_error_nonbool(k);
-		else if (!strcmp(v, "no"))
-			s->show_untracked_files = SHOW_NO_UNTRACKED_FILES;
-		else if (!strcmp(v, "normal"))
-			s->show_untracked_files = SHOW_NORMAL_UNTRACKED_FILES;
-		else if (!strcmp(v, "all"))
-			s->show_untracked_files = SHOW_ALL_UNTRACKED_FILES;
-		else
-			return error(_("Invalid untracked files mode '%s'"), v);
-		return 0;
-	}
-	if (!strcmp(k, "diff.renamelimit")) {
-		if (s->rename_limit == -1)
-			s->rename_limit = git_config_int(k, v, ctx->kvi);
-		return 0;
-	}
-	if (!strcmp(k, "status.renamelimit")) {
-		s->rename_limit = git_config_int(k, v, ctx->kvi);
-		return 0;
-	}
-	if (!strcmp(k, "diff.renames")) {
-		if (s->detect_rename == -1)
-			s->detect_rename = git_config_rename(k, v);
-		return 0;
-	}
-	if (!strcmp(k, "status.renames")) {
-		s->detect_rename = git_config_rename(k, v);
-		return 0;
-	}
-	return git_diff_ui_config(k, v, ctx, NULL);
-}
-
 int cmd_status(int argc, const char **argv, const char *prefix)
 {
 	static int no_renames = -1;
diff --git a/commit.c b/commit.c
index b3223478bc..c08faf48fd 100644
--- a/commit.c
+++ b/commit.c
@@ -28,6 +28,8 @@
 #include "shallow.h"
 #include "tree.h"
 #include "hook.h"
+#include "column.h"
+#include "config.h"
 
 static struct commit_extra_header *read_commit_extra_header_lines(const char *buf, size_t len, const char **);
 
diff --git a/noob.c b/noob.c
new file mode 100644
index 0000000000..680d461698
--- /dev/null
+++ b/noob.c
@@ -0,0 +1,198 @@
+#include "git-compat-util.h"
+#include "tag.h"
+#include "commit.h"
+#include "commit-graph.h"
+#include "environment.h"
+#include "gettext.h"
+#include "hex.h"
+#include "repository.h"
+#include "object-name.h"
+#include "object-store-ll.h"
+#include "pkt-line.h"
+#include "utf8.h"
+#include "diff.h"
+#include "revision.h"
+#include "notes.h"
+#include "alloc.h"
+#include "gpg-interface.h"
+#include "mergesort.h"
+#include "commit-slab.h"
+#include "prio-queue.h"
+#include "hash-lookup.h"
+#include "wt-status.h"
+#include "advice.h"
+#include "refs.h"
+#include "commit-reach.h"
+#include "run-command.h"
+#include "setup.h"
+#include "shallow.h"
+#include "tree.h"
+#include "hook.h"
+#include "column.h"
+#include "config.h"
+#include "noob.h"
+
+static const char *color_status_slots[] = {
+	[WT_STATUS_HEADER]	  = "header",
+	[WT_STATUS_UPDATED]	  = "updated",
+	[WT_STATUS_CHANGED]	  = "changed",
+	[WT_STATUS_UNTRACKED]	  = "untracked",
+	[WT_STATUS_NOBRANCH]	  = "noBranch",
+	[WT_STATUS_UNMERGED]	  = "unmerged",
+	[WT_STATUS_LOCAL_BRANCH]  = "localBranch",
+	[WT_STATUS_REMOTE_BRANCH] = "remoteBranch",
+	[WT_STATUS_ONBRANCH]	  = "branch",
+};
+
+enum wt_status_format status_format = STATUS_FORMAT_UNSPECIFIED;
+
+struct status_deferred_config status_deferred_config = {
+	STATUS_FORMAT_UNSPECIFIED,
+	-1, /* unspecified */
+	AHEAD_BEHIND_UNSPECIFIED,
+};
+
+int parse_status_slot(const char *slot)
+{
+	if (!strcasecmp(slot, "added"))
+		return WT_STATUS_UPDATED;
+
+	return LOOKUP_CONFIG(color_status_slots, slot);
+}
+
+int git_status_config(const char *k, const char *v,
+		      const struct config_context *ctx, void *cb)
+{
+	struct wt_status *s = cb;
+	const char *slot_name;
+
+	if (starts_with(k, "column."))
+		return git_column_config(k, v, "status", &s->colopts);
+	if (!strcmp(k, "status.submodulesummary")) {
+		int is_bool;
+		s->submodule_summary = git_config_bool_or_int(k, v, ctx->kvi,
+							      &is_bool);
+		if (is_bool && s->submodule_summary)
+			s->submodule_summary = -1;
+		return 0;
+	}
+	if (!strcmp(k, "status.short")) {
+		if (git_config_bool(k, v))
+			status_deferred_config.status_format = STATUS_FORMAT_SHORT;
+		else
+			status_deferred_config.status_format = STATUS_FORMAT_NONE;
+		return 0;
+	}
+	if (!strcmp(k, "status.noob")) {
+		if (git_config_bool(k, v))
+			status_deferred_config.status_format = STATUS_FORMAT_NOOB;
+		else
+			status_deferred_config.status_format = STATUS_FORMAT_NONE;
+		return 0;
+	}
+	if (!strcmp(k, "status.branch")) {
+		status_deferred_config.show_branch = git_config_bool(k, v);
+		return 0;
+	}
+	if (!strcmp(k, "status.aheadbehind")) {
+		status_deferred_config.ahead_behind = git_config_bool(k, v);
+		return 0;
+	}
+	if (!strcmp(k, "status.showstash")) {
+		s->show_stash = git_config_bool(k, v);
+		return 0;
+	}
+	if (!strcmp(k, "status.color") || !strcmp(k, "color.status")) {
+		s->use_color = git_config_colorbool(k, v);
+		return 0;
+	}
+	if (!strcmp(k, "status.displaycommentprefix")) {
+		s->display_comment_prefix = git_config_bool(k, v);
+		return 0;
+	}
+	if (skip_prefix(k, "status.color.", &slot_name) ||
+		skip_prefix(k, "color.status.", &slot_name)) {
+		int slot = parse_status_slot(slot_name);
+		if (slot < 0)
+		       return 0;
+		if (!v)
+		       return config_error_nonbool(k);
+		return color_parse(v, s->color_palette[slot]);
+	}
+	if (!strcmp(k, "status.relativepaths")) {
+		s->relative_paths = git_config_bool(k, v);
+		return 0;
+	}
+	if (!strcmp(k, "status.showuntrackedfiles")) {
+		if (!v)
+		       return config_error_nonbool(k);
+		else if (!strcmp(v, "no"))
+		       s->show_untracked_files = SHOW_NO_UNTRACKED_FILES;
+		else if (!strcmp(v, "normal"))
+		       s->show_untracked_files = SHOW_NORMAL_UNTRACKED_FILES;
+		else if (!strcmp(v, "all"))
+		       s->show_untracked_files = SHOW_ALL_UNTRACKED_FILES;
+		else
+		       return error(_("Invalid untracked files mode '%s'"), v);
+		return 0;
+	}
+	if (!strcmp(k, "diff.renamelimit")) {
+		if (s->rename_limit == -1)
+		       s->rename_limit = git_config_int(k, v, ctx->kvi);
+		return 0;
+	}
+	if (!strcmp(k, "status.renamelimit")) {
+		s->rename_limit = git_config_int(k, v, ctx->kvi);
+		return 0;
+	}
+	if (!strcmp(k, "diff.renames")) {
+		if (s->detect_rename == -1)
+		       s->detect_rename = git_config_rename(k, v);
+		return 0;
+	}
+	if (!strcmp(k, "status.renames")) {
+		s->detect_rename = git_config_rename(k, v);
+		return 0;
+	}
+	return git_diff_ui_config(k, v, ctx, NULL);
+}
+
+void finalize_deferred_config(struct wt_status *s)
+{
+	int use_deferred_config = (status_format != STATUS_FORMAT_PORCELAIN &&
+				   status_format != STATUS_FORMAT_PORCELAIN_V2 &&
+				   !s->null_termination);
+
+	if (s->null_termination) {
+		if (status_format == STATUS_FORMAT_NONE ||
+		    status_format == STATUS_FORMAT_UNSPECIFIED)
+			status_format = STATUS_FORMAT_PORCELAIN;
+		else if (status_format == STATUS_FORMAT_LONG)
+			die(_("options '%s' and '%s' cannot be used together"), "--long", "-z");
+	}
+
+	if (use_deferred_config && status_format == STATUS_FORMAT_UNSPECIFIED) {
+		status_format = status_deferred_config.status_format;
+	}
+	if (status_format == STATUS_FORMAT_UNSPECIFIED)
+		status_format = STATUS_FORMAT_NONE;
+
+	if (use_deferred_config && s->show_branch < 0)
+		s->show_branch = status_deferred_config.show_branch;
+	if (s->show_branch < 0)
+		s->show_branch = 0;
+
+	/*
+	 * If the user did not give a "--[no]-ahead-behind" command
+	 * line argument *AND* we will print in a human-readable format
+	 * (short, long etc.) then we inherit from the status.aheadbehind
+	 * config setting.  In all other cases (and porcelain V[12] formats
+	 * in particular), we inherit _FULL for backwards compatibility.
+	 */
+	if (use_deferred_config &&
+	    s->ahead_behind_flags == AHEAD_BEHIND_UNSPECIFIED)
+		s->ahead_behind_flags = status_deferred_config.ahead_behind;
+
+	if (s->ahead_behind_flags == AHEAD_BEHIND_UNSPECIFIED)
+		s->ahead_behind_flags = AHEAD_BEHIND_FULL;
+}
diff --git a/noob.h b/noob.h
new file mode 100644
index 0000000000..d5bc073594
--- /dev/null
+++ b/noob.h
@@ -0,0 +1,21 @@
+#ifndef NOOB_H
+#define NOOB_H
+
+struct status_deferred_config {
+	enum wt_status_format status_format;
+	int show_branch;
+	enum ahead_behind_flags ahead_behind;
+};
+
+extern enum wt_status_format status_format;
+
+extern struct status_deferred_config status_deferred_config;
+
+int git_status_config(const char *k, const char *v,
+		      const struct config_context *ctx, void *cb);
+
+int parse_status_slot(const char *slot);
+
+void finalize_deferred_config(struct wt_status *s);
+
+#endif /* NOOB_H */
diff --git a/read-cache-ll.h b/read-cache-ll.h
index 9a1a7edc5a..302a075714 100644
--- a/read-cache-ll.h
+++ b/read-cache-ll.h
@@ -4,6 +4,7 @@
 #include "hash-ll.h"
 #include "hashmap.h"
 #include "statinfo.h"
+#include "wt-status.h"
 
 /*
  * Basic data structures for the directory cache
@@ -395,6 +396,7 @@ int remove_file_from_index(struct index_state *, const char *path);
 #define ADD_CACHE_IGNORE_ERRORS	4
 #define ADD_CACHE_IGNORE_REMOVAL 8
 #define ADD_CACHE_INTENT 16
+#define ADD_CACHE_FORMAT_NOOB 32
 /*
  * These two are used to add the contents of the file at path
  * to the index, marking the working tree up-to-date by storing
@@ -404,7 +406,8 @@ int remove_file_from_index(struct index_state *, const char *path);
  * the latter will do necessary lstat(2) internally before
  * calling the former.
  */
-int add_to_index(struct index_state *, const char *path, struct stat *, int flags);
+int add_to_index(struct index_state *, const char *path, struct stat *, int flags, struct wt_status *status);
+int add_file_to_index_with_status(struct index_state *, const char *path, int flags, struct wt_status *status);
 int add_file_to_index(struct index_state *, const char *path, int flags);
 
 int chmod_index_entry(struct index_state *, struct cache_entry *ce, char flip);
@@ -475,6 +478,10 @@ int add_files_to_cache(struct repository *repo, const char *prefix,
 		       const struct pathspec *pathspec, int include_sparse,
 		       int flags);
 
+int add_files_to_cache_with_status(struct repository *repo, const char *prefix,
+		       const struct pathspec *pathspec, int include_sparse,
+		       int flags, struct wt_status *status);
+
 void overlay_tree_on_index(struct index_state *istate,
 			   const char *tree_name, const char *prefix);
 
diff --git a/read-cache.c b/read-cache.c
index 080bd39713..319415430a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -45,6 +45,8 @@
 #include "csum-file.h"
 #include "promisor-remote.h"
 #include "hook.h"
+#include "wt-status.h"
+#include "string-list.h"
 
 /* Mask for the name length in ce_flags in the on-disk index */
 
@@ -664,7 +666,7 @@ void set_object_name_for_intent_to_add_entry(struct cache_entry *ce)
 	oidcpy(&ce->oid, &oid);
 }
 
-int add_to_index(struct index_state *istate, const char *path, struct stat *st, int flags)
+int add_to_index(struct index_state *istate, const char *path, struct stat *st, int flags, struct wt_status *status)
 {
 	int namelen, was_same;
 	mode_t st_mode = st->st_mode;
@@ -672,6 +674,7 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 	unsigned ce_option = CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE|CE_MATCH_RACY_IS_DIRTY;
 	int verbose = flags & (ADD_CACHE_VERBOSE | ADD_CACHE_PRETEND);
 	int pretend = flags & ADD_CACHE_PRETEND;
+	int noob = flags & ADD_CACHE_FORMAT_NOOB;
 	int intent_only = flags & ADD_CACHE_INTENT;
 	int add_option = (ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE|
 			  (intent_only ? ADD_CACHE_NEW_ONLY : 0));
@@ -760,17 +763,26 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 		discard_cache_entry(ce);
 		return error(_("unable to add '%s' to index"), path);
 	}
-	if (verbose && !was_same)
+	if (verbose && !was_same && !noob)
 		printf("add '%s'\n", path);
+	if (noob && !was_same) {
+		string_list_insert(&status->added, path);
+	}
 	return 0;
 }
 
-int add_file_to_index(struct index_state *istate, const char *path, int flags)
+int add_file_to_index_with_status(struct index_state *istate, const char *path, int flags, struct wt_status *status)
 {
 	struct stat st;
 	if (lstat(path, &st))
 		die_errno(_("unable to stat '%s'"), path);
-	return add_to_index(istate, path, &st, flags);
+	return add_to_index(istate, path, &st, flags, status);
+}
+
+int add_file_to_index(struct index_state *istate, const char *path, int flags)
+{
+	struct wt_status status;
+	return add_file_to_index_with_status(istate, path, flags, &status);
 }
 
 struct cache_entry *make_empty_cache_entry(struct index_state *istate, size_t len)
@@ -3872,6 +3884,7 @@ struct update_callback_data {
 	int include_sparse;
 	int flags;
 	int add_errors;
+	struct wt_status *status;
 };
 
 static int fix_unmerged_status(struct diff_filepair *p,
@@ -3914,7 +3927,7 @@ static void update_callback(struct diff_queue_struct *q,
 			die(_("unexpected diff status %c"), p->status);
 		case DIFF_STATUS_MODIFIED:
 		case DIFF_STATUS_TYPE_CHANGED:
-			if (add_file_to_index(data->index, path, data->flags)) {
+			if (add_file_to_index_with_status(data->index, path, data->flags, data->status)) {
 				if (!(data->flags & ADD_CACHE_IGNORE_ERRORS))
 					die(_("updating files failed"));
 				data->add_errors++;
@@ -3935,6 +3948,14 @@ static void update_callback(struct diff_queue_struct *q,
 int add_files_to_cache(struct repository *repo, const char *prefix,
 		       const struct pathspec *pathspec, int include_sparse,
 		       int flags)
+{
+	struct wt_status status;
+	return add_files_to_cache_with_status(repo, prefix, pathspec, include_sparse, flags, &status);
+}
+
+int add_files_to_cache_with_status(struct repository *repo, const char *prefix,
+		       const struct pathspec *pathspec, int include_sparse,
+		       int flags, struct wt_status *status)
 {
 	struct update_callback_data data;
 	struct rev_info rev;
@@ -3943,6 +3964,7 @@ int add_files_to_cache(struct repository *repo, const char *prefix,
 	data.index = repo->index;
 	data.include_sparse = include_sparse;
 	data.flags = flags;
+	data.status = status;
 
 	repo_init_revisions(repo, &rev, prefix);
 	setup_revisions(0, NULL, &rev, NULL);
diff --git a/table.c b/table.c
index d085f2a098..527e38c07d 100644
--- a/table.c
+++ b/table.c
@@ -65,18 +65,53 @@ static void build_table_entry(struct strbuf *buf, char *entry, int cols)
 		strbuf_addchars(buf, ' ', (cols / 3 - len - 1) / 2);
 }
 
-static void print_table_body_line(struct strbuf *buf1, struct strbuf *buf2, struct strbuf *buf3, struct wt_status *s)
+static void add_arrow_to_entry(struct strbuf *buf, int add_after_entry)
+{
+	struct strbuf empty = STRBUF_INIT;
+	struct strbuf trimmed = STRBUF_INIT;
+	struct strbuf holder = STRBUF_INIT;
+	int len = strlen(buf->buf);
+
+	strbuf_addstr(&trimmed, buf->buf);
+	strbuf_trim(&trimmed);
+
+	if (!strbuf_cmp(&trimmed, &empty) && !add_after_entry) {
+		strbuf_reset(buf);
+		strbuf_addchars(buf, '-', len + 1);
+	} else if (add_after_entry) {
+		strbuf_rtrim(buf);
+		strbuf_addchars(buf, ' ', 1);
+		strbuf_addchars(buf, '-', len - strlen(buf->buf) + 1);
+	} else if (!add_after_entry) {
+		strbuf_ltrim(buf);
+		strbuf_addchars(&holder, '-', len - strlen(buf->buf) - 2);
+		strbuf_addchars(&holder, '>', 1);
+		strbuf_addchars(&holder, ' ', 1);
+		strbuf_addstr(&holder, buf->buf);
+		strbuf_reset(buf);
+		strbuf_addstr(buf, holder.buf);
+	}
+}
+
+static void print_table_body_line(struct strbuf *buf1, struct strbuf *buf2, struct strbuf *buf3, struct wt_status *s, int hide_pipe)
 {
 	printf(_("|"));
 	color_fprintf(s->fp, color(WT_STATUS_UNTRACKED, s), "%s", buf1->buf);
-	printf(_("|"));
+	if (hide_pipe != 1 && hide_pipe != 3)
+		printf(_("|"));
 	color_fprintf(s->fp, color(WT_STATUS_CHANGED, s), "%s", buf2->buf);
-	printf(_("|"));
+	if (hide_pipe != 2 && hide_pipe != 3)
+		printf(_("|"));
 	color_fprintf(s->fp, color(WT_STATUS_UPDATED, s), "%s", buf3->buf);
 	printf(_("|\n"));
 }
 
-void print_noob_status(struct wt_status *s, int add_advice)
+static void print_table_body_line_(struct strbuf *buf1, struct strbuf *buf2, struct strbuf *buf3, struct wt_status *s)
+{
+	print_table_body_line(buf1, buf2, buf3, s, 0);
+}
+
+void print_noob_status(struct wt_status *s, int advice)
 {
 	struct winsize w;
 	int cols;
@@ -84,7 +119,7 @@ void print_noob_status(struct wt_status *s, int add_advice)
 	struct strbuf table_col_entry_1 = STRBUF_INIT;
 	struct strbuf table_col_entry_2 = STRBUF_INIT;
 	struct strbuf table_col_entry_3 = STRBUF_INIT;
-	struct string_list_item *item;
+	struct string_list_item *item, *item2;
 
 	/* Get terminal width */
 	ioctl(STDOUT_FILENO, TIOCGWINSZ, &w);
@@ -104,7 +139,7 @@ void print_noob_status(struct wt_status *s, int add_advice)
 	printf(_("%s\n"), table_border.buf);
 	printf(_("|%s|%s|%s|\n"), table_col_entry_1.buf, table_col_entry_2.buf, table_col_entry_3.buf);
 
-	if (add_advice) {
+	if (advice) {
 		build_table_entry(&table_col_entry_1, "(stage: git add <file>)", cols);
 		build_table_entry(&table_col_entry_2, "(stage: git add <file>)", cols);
 		build_table_entry(&table_col_entry_3, "(unstage: git restore --staged <file>)", cols);
@@ -122,14 +157,38 @@ void print_noob_status(struct wt_status *s, int add_advice)
 
 	/* Draw table body */
 	for_each_string_list_item(item, &s->untracked) {
-		build_table_entry(&table_col_entry_1, item->string, cols);
+		struct strbuf buf_1 = STRBUF_INIT;
+		struct strbuf buf_2 = STRBUF_INIT;
+		int is_arrow = 0;
+		strbuf_addstr(&buf_1, item->string);
+		build_table_entry(&table_col_entry_1, buf_1.buf, cols);
 		build_table_entry(&table_col_entry_2, "", cols);
 		build_table_entry(&table_col_entry_3, "", cols);
-		print_table_body_line(&table_col_entry_1, &table_col_entry_2, &table_col_entry_3, s);
+
+		for_each_string_list_item(item2, &s->added) {
+			strbuf_reset(&buf_2);
+			strbuf_addstr(&buf_2, item2->string);
+			if (!strbuf_cmp(&buf_1, &buf_2)) {
+				build_table_entry(&table_col_entry_3, buf_1.buf, cols);
+				add_arrow_to_entry(&table_col_entry_1, 1);
+				add_arrow_to_entry(&table_col_entry_2, 0);
+				add_arrow_to_entry(&table_col_entry_3, 0);
+				is_arrow = 1;
+			}
+		}
+
+		if (!is_arrow)
+			print_table_body_line_(&table_col_entry_1, &table_col_entry_2, &table_col_entry_3, s);
+		else
+			print_table_body_line(&table_col_entry_1, &table_col_entry_2, &table_col_entry_3, s, 3);
 	}
 
 	for_each_string_list_item(item, &s->change) {
 		struct wt_status_change_data *d = item->util;
+		struct strbuf buf_1 = STRBUF_INIT;
+		struct strbuf buf_2 = STRBUF_INIT;
+		int is_arrow = 0;
+		strbuf_addstr(&buf_1, item->string);
 		if (d->worktree_status && d->index_status) {
 			build_table_entry(&table_col_entry_1, "", cols);
 			build_table_entry(&table_col_entry_2, item->string, cols);
@@ -138,12 +197,27 @@ void print_noob_status(struct wt_status *s, int add_advice)
 			build_table_entry(&table_col_entry_1, "", cols);
 			build_table_entry(&table_col_entry_2, item->string, cols);
 			build_table_entry(&table_col_entry_3, "", cols);
+
+			for_each_string_list_item(item2, &s->added) {
+				strbuf_reset(&buf_2);
+				strbuf_addstr(&buf_2, item2->string);
+				if (!strbuf_cmp(&buf_1, &buf_2)) {
+					build_table_entry(&table_col_entry_3, buf_1.buf, cols);
+					add_arrow_to_entry(&table_col_entry_2, 1);
+					add_arrow_to_entry(&table_col_entry_3, 0);
+					is_arrow = 1;
+				}
+			}
 		} else if (d->index_status) {
 			build_table_entry(&table_col_entry_1, "", cols);
 			build_table_entry(&table_col_entry_2, "", cols);
 			build_table_entry(&table_col_entry_3, item->string, cols);
 		}
-		print_table_body_line(&table_col_entry_1, &table_col_entry_2, &table_col_entry_3, s);
+
+		if (!is_arrow)
+			print_table_body_line_(&table_col_entry_1, &table_col_entry_2, &table_col_entry_3, s);
+		else
+			print_table_body_line(&table_col_entry_1, &table_col_entry_2, &table_col_entry_3, s, 2);
 	}
 	
 	if (!s->untracked.nr && !s->change.nr) {
diff --git a/wt-status.c b/wt-status.c
index b5899dcc98..969f79f441 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -153,6 +153,7 @@ void wt_status_prepare(struct repository *r, struct wt_status *s)
 	s->change.strdup_strings = 1;
 	s->untracked.strdup_strings = 1;
 	s->ignored.strdup_strings = 1;
+	s->added.strdup_strings = 1;
 	s->show_branch = -1;  /* unspecified */
 	s->show_stash = 0;
 	s->ahead_behind_flags = AHEAD_BEHIND_UNSPECIFIED;
diff --git a/wt-status.h b/wt-status.h
index 3f08f0d72b..64551f3a75 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -142,6 +142,7 @@ struct wt_status {
 	struct string_list change;
 	struct string_list untracked;
 	struct string_list ignored;
+	struct string_list added;
 	uint32_t untracked_in_ms;
 };
 
-- 
2.42.0.404.g2bcc23f3db

