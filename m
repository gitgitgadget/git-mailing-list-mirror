Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0315326AD0
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 13:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729517544; cv=none; b=Wsv1yQJT6kgPeRovAfnOQxjlJBLHXbEQVEL/vsrVFHdnMcdWKsFYy5Jh3F+07+kjk/NmyYG6kmHC2A+RojanL8U+NXgw7GFlY5TJncqJllLBnqH9M+3Kwjj095Cm9CQJd+d6QEJ+f7ga5MY8K745WNk9+4+6pVtt6GZdDzoI9To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729517544; c=relaxed/simple;
	bh=UpBtfe71+pjoSkZwwAbzSwoe486EkYXnOtD1VXJyqRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rac5VIRSZ2WAFpWvOb87JLEXQxE2swda3qw08dc8Al5cNIyFpfwoXKaQjP4+DGcUA6FyV/BUpx7H1j4HNt7+Kmu1g64ptGRX5diNqsMNPsNyIdbgZowgeKccXYIuT2fIr4tKPbtQsv8y7s13xIlvX57lJuq9huA+Jtw+uV7R7qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=isILaPa7; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isILaPa7"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7e6cbf6cd1dso2859521a12.3
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 06:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729517538; x=1730122338; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C8lnaKVX6g3LNzOkrOQu2FQOKwSn/bkcH+Q/Xtf/9oU=;
        b=isILaPa7fK1bBM6q+4AfNQbU+FQmH6qiBZgoPxtWZXSPtQNynR+tpajaHDTdvmUBt7
         FqbuowlanMY14nK1eL24xHwcqOkKpo7PIOAGOHBaKAQX/DTkjYyZIqqvMxqbnimCTBxZ
         w75o2PMAfWDoLJwuIleJRHvbmpx7PQpej0Qdd9owibDMQyVF5fLVwI7mFw1MG5OLsy08
         XWio8fqRlGDkfVGBpTAKPWPINXOaeRMEXz6Zo1k1hONU2H01nQCoTzPRu4Lpjoh/2poh
         SqouOQWm4BHnD5YHitSmPMvVnIVCIKwcxKqJDxgouPVvsrCxeQD79ABwuv0j9Xt8kBPo
         APKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729517538; x=1730122338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8lnaKVX6g3LNzOkrOQu2FQOKwSn/bkcH+Q/Xtf/9oU=;
        b=tF52x3Yg7/E76xWS2kCWE/wmlhdkMvi+7TG04i1oYZ8lmzWy68hyM9Ta0Cmt7RSRju
         BvLY4ov6ya3N8Q2K2dUp5HBEaHUGOv0+I66uoXcMldyzuvxDeiyN4Ofw/5eFRu0MZPx+
         xKM6D7pFYjSAnxZeN6aKsJGuuPOTCGoknt79jvQMvtEZ92ANHvwrkh0I7LJDzhf2EweU
         aG6MIYXSxC8QPPechfjDcpiFt2zR25k+6+kwAU/tXKXTQrvMJyg3NDQH7dIfs9Zl26HB
         ZOihrzzC7UfnvQ5kI1x4ZjaudKTxaVE71E0yHSBXXiWk/1NZA6dMv5Jj1R+qe2XYHEMb
         rhSQ==
X-Gm-Message-State: AOJu0YzqoIzcKvXw0A1T3SkF/JHcAjCO3emeIEQJ96JjNzjTrhwZSct9
	1VSm7/0kKbHhD/r8M4jJXVLWwUbcczzF2f9AO6kOTIkNSPareYHiLwB2zIa+
X-Google-Smtp-Source: AGHT+IFGIc1YaD/BlWLXhillz8fsBwm+6H7CW9HxGq5sFVYwjrH/219vzuE57lEQB1sx201Ypemnbg==
X-Received: by 2002:a05:6a21:78d:b0:1cf:53ea:7fbc with SMTP id adf61e73a8af0-1d92c4e166fmr15177262637.18.1729517537970;
        Mon, 21 Oct 2024 06:32:17 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13eaaafsm2935033b3a.170.2024.10.21.06.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 06:32:17 -0700 (PDT)
Date: Mon, 21 Oct 2024 21:32:20 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6 0/9] add ref content check for files backend
Message-ID: <ZxZX5HDdq_R0C77b@ArchLinux>
References: <Zvj-DgHqtC30KjJe@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zvj-DgHqtC30KjJe@ArchLinux>

Hi All:

This new version updates the following things.

First, I want to talk about the new things. [PATCH v6 2/9] and [PATCH v6
3/9] are used to solve a bug when I implemented the checks for refname
for the following code:

    if (check_refname_format(iter->basename, REFNAME_ALLOW_ONELEVEL)) {
          ret = fsck_report(...);
    }

So, the code will wrongly report an error for "refs/heads/@". And I fix
this issue by using two commits.

For the difference against the previous version

1. Split [PATCH v5 8/9] into every related commit.

2. In [PATCH v6 4/9], print the worktree ref fullname to avoid
ambiguous.

3. Use one-to-one mapping fsck message.

4. Enhance the commit message and the usage of "fsck_report_ref" to
provide more useful information.

5. Rename "escapeReferent" to "symrefTargetIsNotARef". I agree that we
should use this. "escpae" is not right. However, I cannot find an
elegant name. So I follow the advice from Patrick.

I provide the "interdiff" here which will be helpful for reviewers.

Thanks,
Jialuo

shejialuo (9):
  ref: initialize "fsck_ref_report" with zero
  ref: check the full refname instead of basename
  ref: initialize target name outside of check functions
  ref: support multiple worktrees check for refs
  ref: port git-fsck(1) regular refs check for files backend
  ref: add more strict checks for regular refs
  ref: add basic symref content check for files backend
  ref: check whether the target of the symref is a ref
  ref: add symlink ref content check for files backend

 Documentation/fsck-msgids.txt |  35 +++
 builtin/refs.c                |  12 +-
 fsck.h                        |   6 +
 refs.c                        |   7 +-
 refs.h                        |   3 +-
 refs/debug.c                  |   5 +-
 refs/files-backend.c          | 187 ++++++++++++--
 refs/packed-backend.c         |   8 +-
 refs/refs-internal.h          |   5 +-
 refs/reftable-backend.c       |   3 +-
 t/t0602-reffiles-fsck.sh      | 457 +++++++++++++++++++++++++++++++++-
 11 files changed, 693 insertions(+), 35 deletions(-)

Interdiff against v5:
diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
index ffe9d6a2f6..b14bc44ca4 100644
--- a/Documentation/fsck-msgids.txt
+++ b/Documentation/fsck-msgids.txt
@@ -28,8 +28,8 @@
 `badRefName`::
 	(ERROR) A ref has an invalid format.
 
-`badReferent`::
-	(ERROR) The referent of a ref is invalid.
+`badReferentName`::
+	(ERROR) The referent name of a symref is invalid.
 
 `badTagName`::
 	(INFO) A tag has an invalid format.
@@ -52,14 +52,6 @@
 `emptyName`::
 	(WARN) A path contains an empty name.
 
-`escapeReferent`::
-	(INFO) The referent of a symref is outside the "ref" directory.
-	Although we allow create a symref pointing to the referent which
-	is outside the "ref" by using `git symbolic-ref`, we may tighten
-	the rule in the future. Report to the git@vger.kernel.org
-	mailing list if you see this error, as we need to know what tools
-	created such a file.
-
 `extraHeaderEntry`::
 	(IGNORE) Extra headers found after `tagger`.
 
@@ -184,11 +176,34 @@
 `nullSha1`::
 	(WARN) Tree contains entries pointing to a null sha1.
 
+`refMissingNewline`::
+	(INFO) A loose ref that does not end with newline(LF). As
+	valid implementations of Git never created such a loose ref
+	file, it may become an error in the future. Report to the
+	git@vger.kernel.org mailing list if you see this error, as
+	we need to know what tools created such a file.
+
 `symlinkRef`::
-	(INFO) A symbolic link is used as a symref.  Report to the
+	(INFO) A symbolic link is used as a symref. Report to the
 	git@vger.kernel.org mailing list if you see this error, as we
 	are assessing the feasibility of dropping the support to drop
-	creating symblinks as symrefs.
+	creating symbolic links as symrefs.
+
+`symrefTargetIsNotARef`::
+	(INFO) The target of a symbolic reference points neither to
+	a root reference nor to a reference starting with "refs/".
+	Although we allow create a symref pointing to the referent which
+	is outside the "ref" by using `git symbolic-ref`, we may tighten
+	the rule in the future. Report to the git@vger.kernel.org
+	mailing list if you see this error, as we need to know what tools
+	created such a file.
+
+`trailingRefContent`::
+	(INFO) A loose ref has trailing content. As valid implementations
+	of Git never created such a loose ref file, it may become an
+	error in the future. Report to the git@vger.kernel.org mailing
+	list if you see this error, as we need to know what tools
+	created such a file.
 
 `treeNotSorted`::
 	(ERROR) A tree is not properly sorted.
@@ -196,14 +211,6 @@
 `unknownType`::
 	(ERROR) Found an unknown object type.
 
-`unofficialFormattedRef`::
-	(INFO) The content of a loose ref file is not in the official
-	format such as not having a LF at the end or having trailing
-	garbage. As valid implementations of Git never created such a
-	loose ref file, it may become an error in the future. Report
-	to the git@vger.kernel.org mailing list if you see this error,
-	as we need to know what tools created such a file.
-
 `unterminatedHeader`::
 	(FATAL) Missing end-of-line in the object header.
 
diff --git a/builtin/refs.c b/builtin/refs.c
index 3c492ea922..886c4ceae3 100644
--- a/builtin/refs.c
+++ b/builtin/refs.c
@@ -89,9 +89,10 @@ static int cmd_refs_verify(int argc, const char **argv, const char *prefix)
 	worktrees = get_worktrees();
 	for (p = worktrees; *p; p++) {
 		struct worktree *wt = *p;
-		ret += refs_fsck(get_worktree_ref_store(wt), &fsck_refs_options);
+		ret |= refs_fsck(get_worktree_ref_store(wt), &fsck_refs_options, wt);
 	}
 
+
 	fsck_options_clear(&fsck_refs_options);
 	free_worktrees(worktrees);
 	return ret;
diff --git a/fsck.h b/fsck.h
index f1da5c8a77..a44c231a5f 100644
--- a/fsck.h
+++ b/fsck.h
@@ -34,7 +34,7 @@ enum fsck_msg_type {
 	FUNC(BAD_REF_CONTENT, ERROR) \
 	FUNC(BAD_REF_FILETYPE, ERROR) \
 	FUNC(BAD_REF_NAME, ERROR) \
-	FUNC(BAD_REFERENT, ERROR) \
+	FUNC(BAD_REFERENT_NAME, ERROR) \
 	FUNC(BAD_TIMEZONE, ERROR) \
 	FUNC(BAD_TREE, ERROR) \
 	FUNC(BAD_TREE_SHA1, ERROR) \
@@ -80,7 +80,6 @@ enum fsck_msg_type {
 	FUNC(LARGE_PATHNAME, WARN) \
 	/* infos (reported as warnings, but ignored by default) */ \
 	FUNC(BAD_FILEMODE, INFO) \
-	FUNC(ESCAPE_REFERENT, INFO) \
 	FUNC(GITMODULES_PARSE, INFO) \
 	FUNC(GITIGNORE_SYMLINK, INFO) \
 	FUNC(GITATTRIBUTES_SYMLINK, INFO) \
@@ -88,7 +87,9 @@ enum fsck_msg_type {
 	FUNC(BAD_TAG_NAME, INFO) \
 	FUNC(MISSING_TAGGER_ENTRY, INFO) \
 	FUNC(SYMLINK_REF, INFO) \
-	FUNC(UNOFFICIAL_FORMATTED_REF, INFO) \
+	FUNC(REF_MISSING_NEWLINE, INFO) \
+	FUNC(SYMREF_TARGET_IS_NOT_A_REF, INFO) \
+	FUNC(TRAILING_REF_CONTENT, INFO) \
 	/* ignored (elevated when requested) */ \
 	FUNC(EXTRA_HEADER_ENTRY, IGNORE)
 
diff --git a/refs.c b/refs.c
index 6ba1bb1aa1..f88b32a633 100644
--- a/refs.c
+++ b/refs.c
@@ -318,9 +318,10 @@ int check_refname_format(const char *refname, int flags)
 	return check_or_sanitize_refname(refname, flags, NULL);
 }
 
-int refs_fsck(struct ref_store *refs, struct fsck_options *o)
+int refs_fsck(struct ref_store *refs, struct fsck_options *o,
+	      struct worktree *wt)
 {
-	return refs->be->fsck(refs, o);
+	return refs->be->fsck(refs, o, wt);
 }
 
 void sanitize_refname_component(const char *refname, struct strbuf *out)
diff --git a/refs.h b/refs.h
index 108dfc93b3..341d43239c 100644
--- a/refs.h
+++ b/refs.h
@@ -549,7 +549,8 @@ int check_refname_format(const char *refname, int flags);
  * reflogs are consistent, and non-zero otherwise. The errors will be
  * written to stderr.
  */
-int refs_fsck(struct ref_store *refs, struct fsck_options *o);
+int refs_fsck(struct ref_store *refs, struct fsck_options *o,
+	      struct worktree *wt);
 
 /*
  * Apply the rules from check_refname_format, but mutate the result until it
diff --git a/refs/debug.c b/refs/debug.c
index 45e2e784a0..72e80ddd6d 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -420,10 +420,11 @@ static int debug_reflog_expire(struct ref_store *ref_store, const char *refname,
 }
 
 static int debug_fsck(struct ref_store *ref_store,
-		      struct fsck_options *o)
+		      struct fsck_options *o,
+		      struct worktree *wt)
 {
 	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
-	int res = drefs->refs->be->fsck(drefs->refs, o);
+	int res = drefs->refs->be->fsck(drefs->refs, o, wt);
 	trace_printf_key(&trace_refs, "fsck: %d\n", res);
 	return res;
 }
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 5a5327a146..180f8e28b7 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -24,6 +24,7 @@
 #include "../dir.h"
 #include "../chdir-notify.h"
 #include "../setup.h"
+#include "../worktree.h"
 #include "../wrapper.h"
 #include "../write-or-die.h"
 #include "../revision.h"
@@ -3506,7 +3507,7 @@ static int files_ref_store_remove_on_disk(struct ref_store *ref_store,
  */
 typedef int (*files_fsck_refs_fn)(struct ref_store *ref_store,
 				  struct fsck_options *o,
-				  const char *refs_check_dir,
+				  const char *target_name,
 				  struct dir_iterator *iter);
 
 static int files_fsck_symref_target(struct fsck_options *o,
@@ -3514,27 +3515,29 @@ static int files_fsck_symref_target(struct fsck_options *o,
 				    struct strbuf *referent,
 				    unsigned int symbolic_link)
 {
+	int is_referent_root;
 	char orig_last_byte;
 	size_t orig_len;
 	int ret = 0;
 
-	if (!symbolic_link) {
-		orig_len = referent->len;
-		orig_last_byte = referent->buf[orig_len - 1];
+	orig_len = referent->len;
+	orig_last_byte = referent->buf[orig_len - 1];
+	if (!symbolic_link)
 		strbuf_rtrim(referent);
-	}
 
-	if (!starts_with(referent->buf, "refs/") &&
+	is_referent_root = is_root_ref(referent->buf);
+	if (!is_referent_root &&
+	    !starts_with(referent->buf, "refs/") &&
 	    !starts_with(referent->buf, "worktrees/")) {
 		ret = fsck_report_ref(o, report,
-				      FSCK_MSG_ESCAPE_REFERENT,
-				      "referent '%s' is outside of refs/ or worktrees/",
-				      referent->buf);
+				      FSCK_MSG_SYMREF_TARGET_IS_NOT_A_REF,
+				      "points to non-ref target '%s'", referent->buf);
+
 	}
 
-	if (check_refname_format(referent->buf, 0)) {
+	if (!is_referent_root && check_refname_format(referent->buf, 0)) {
 		ret = fsck_report_ref(o, report,
-				      FSCK_MSG_BAD_REFERENT,
+				      FSCK_MSG_BAD_REFERENT_NAME,
 				      "points to invalid refname '%s'", referent->buf);
 		goto out;
 	}
@@ -3542,17 +3545,16 @@ static int files_fsck_symref_target(struct fsck_options *o,
 	if (symbolic_link)
 		goto out;
 
-
 	if (referent->len == orig_len ||
 	    (referent->len < orig_len && orig_last_byte != '\n')) {
 		ret = fsck_report_ref(o, report,
-				      FSCK_MSG_UNOFFICIAL_FORMATTED_REF,
+				      FSCK_MSG_REF_MISSING_NEWLINE,
 				      "misses LF at the end");
 	}
 
 	if (referent->len != orig_len && referent->len != orig_len - 1) {
 		ret = fsck_report_ref(o, report,
-				      FSCK_MSG_UNOFFICIAL_FORMATTED_REF,
+				      FSCK_MSG_TRAILING_REF_CONTENT,
 				      "has trailing whitespaces or newlines");
 	}
 
@@ -3562,13 +3564,12 @@ static int files_fsck_symref_target(struct fsck_options *o,
 
 static int files_fsck_refs_content(struct ref_store *ref_store,
 				   struct fsck_options *o,
-				   const char *refs_check_dir,
+				   const char *target_name,
 				   struct dir_iterator *iter)
 {
 	struct strbuf ref_content = STRBUF_INIT;
 	struct strbuf abs_gitdir = STRBUF_INIT;
 	struct strbuf referent = STRBUF_INIT;
-	struct strbuf refname = STRBUF_INIT;
 	struct fsck_ref_report report = { 0 };
 	const char *trailing = NULL;
 	unsigned int type = 0;
@@ -3576,8 +3577,7 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 	struct object_id oid;
 	int ret = 0;
 
-	strbuf_addf(&refname, "%s/%s", refs_check_dir, iter->relative_path);
-	report.path = refname.buf;
+	report.path = target_name;
 
 	if (S_ISLNK(iter->st.st_mode)) {
 		const char* relative_referent_path = NULL;
@@ -3600,14 +3600,15 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 		else
 			strbuf_addbuf(&referent, &ref_content);
 
-		ret += files_fsck_symref_target(o, &report, &referent, 1);
+		ret |= files_fsck_symref_target(o, &report, &referent, 1);
 		goto cleanup;
 	}
 
 	if (strbuf_read_file(&ref_content, iter->path.buf, 0) < 0) {
 		ret = fsck_report_ref(o, &report,
 				      FSCK_MSG_BAD_REF_CONTENT,
-				      "cannot read ref file");
+				      "cannot read ref file '%s': (%s)",
+				      iter->path.buf, strerror(errno));
 		goto cleanup;
 	}
 
@@ -3624,13 +3625,13 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 	if (!(type & REF_ISSYMREF)) {
 		if (!*trailing) {
 			ret = fsck_report_ref(o, &report,
-					      FSCK_MSG_UNOFFICIAL_FORMATTED_REF,
+					      FSCK_MSG_REF_MISSING_NEWLINE,
 					      "misses LF at the end");
 			goto cleanup;
 		}
 		if (*trailing != '\n' || *(trailing + 1)) {
 			ret = fsck_report_ref(o, &report,
-					      FSCK_MSG_UNOFFICIAL_FORMATTED_REF,
+					      FSCK_MSG_TRAILING_REF_CONTENT,
 					      "has trailing garbage: '%s'", trailing);
 			goto cleanup;
 		}
@@ -3640,7 +3641,6 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 	}
 
 cleanup:
-	strbuf_release(&refname);
 	strbuf_release(&ref_content);
 	strbuf_release(&referent);
 	strbuf_release(&abs_gitdir);
@@ -3649,7 +3649,7 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 
 static int files_fsck_refs_name(struct ref_store *ref_store UNUSED,
 				struct fsck_options *o,
-				const char *refs_check_dir,
+				const char *target_name,
 				struct dir_iterator *iter)
 {
 	struct strbuf sb = STRBUF_INIT;
@@ -3662,11 +3662,10 @@ static int files_fsck_refs_name(struct ref_store *ref_store UNUSED,
 	if (iter->basename[0] != '.' && ends_with(iter->basename, ".lock"))
 		goto cleanup;
 
-	if (check_refname_format(iter->basename, REFNAME_ALLOW_ONELEVEL)) {
+	if (check_refname_format(target_name, 0)) {
 		struct fsck_ref_report report = { 0 };
 
-		strbuf_addf(&sb, "%s/%s", refs_check_dir, iter->relative_path);
-		report.path = sb.buf;
+		report.path = target_name;
 		ret = fsck_report_ref(o, &report,
 				      FSCK_MSG_BAD_REF_NAME,
 				      "invalid refname format");
@@ -3680,8 +3679,10 @@ static int files_fsck_refs_name(struct ref_store *ref_store UNUSED,
 static int files_fsck_refs_dir(struct ref_store *ref_store,
 			       struct fsck_options *o,
 			       const char *refs_check_dir,
+			       struct worktree *wt,
 			       files_fsck_refs_fn *fsck_refs_fn)
 {
+	struct strbuf target_name = STRBUF_INIT;
 	struct strbuf sb = STRBUF_INIT;
 	struct dir_iterator *iter;
 	int iter_status;
@@ -3700,11 +3701,18 @@ static int files_fsck_refs_dir(struct ref_store *ref_store,
 			continue;
 		} else if (S_ISREG(iter->st.st_mode) ||
 			   S_ISLNK(iter->st.st_mode)) {
+			strbuf_reset(&target_name);
+
+			if (!is_main_worktree(wt))
+				strbuf_addf(&target_name, "worktrees/%s/", wt->id);
+			strbuf_addf(&target_name, "%s/%s", refs_check_dir,
+				    iter->relative_path);
+
 			if (o->verbose)
-				fprintf_ln(stdout, "Checking %s/%s",
-					   refs_check_dir, iter->relative_path);
+				fprintf_ln(stderr, "Checking %s", target_name.buf);
+
 			for (size_t i = 0; fsck_refs_fn[i]; i++) {
-				if (fsck_refs_fn[i](ref_store, o, refs_check_dir, iter))
+				if (fsck_refs_fn[i](ref_store, o, target_name.buf, iter))
 					ret = -1;
 			}
 		} else {
@@ -3721,11 +3729,13 @@ static int files_fsck_refs_dir(struct ref_store *ref_store,
 
 out:
 	strbuf_release(&sb);
+	strbuf_release(&target_name);
 	return ret;
 }
 
 static int files_fsck_refs(struct ref_store *ref_store,
-			   struct fsck_options *o)
+			   struct fsck_options *o,
+			   struct worktree *wt)
 {
 	files_fsck_refs_fn fsck_refs_fn[]= {
 		files_fsck_refs_name,
@@ -3733,27 +3743,20 @@ static int files_fsck_refs(struct ref_store *ref_store,
 		NULL,
 	};
 
-	fprintf_ln(stdout, _("Checking references consistency in %s"),
-		   ref_store->gitdir);
-	return files_fsck_refs_dir(ref_store, o,  "refs", fsck_refs_fn);
+	if (o->verbose)
+		fprintf_ln(stderr, _("Checking references consistency"));
+	return files_fsck_refs_dir(ref_store, o, "refs", wt, fsck_refs_fn);
 }
 
 static int files_fsck(struct ref_store *ref_store,
-		      struct fsck_options *o)
+		      struct fsck_options *o,
+		      struct worktree *wt)
 {
 	struct files_ref_store *refs =
 		files_downcast(ref_store, REF_STORE_READ, "fsck");
 
-	int ret = files_fsck_refs(ref_store, o);
-
-	/*
-	 * packed-refs should only be checked once because it is shared
-	 * between all worktrees.
-	 */
-	if (!strcmp(ref_store->gitdir, ref_store->repo->gitdir))
-		ret += refs->packed_ref_store->be->fsck(refs->packed_ref_store, o);
-
-	return ret;
+	return files_fsck_refs(ref_store, o, wt) |
+	       refs->packed_ref_store->be->fsck(refs->packed_ref_store, o, wt);
 }
 
 struct ref_storage_be refs_be_files = {
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 07c57fd541..46dcaec654 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -13,6 +13,7 @@
 #include "../lockfile.h"
 #include "../chdir-notify.h"
 #include "../statinfo.h"
+#include "../worktree.h"
 #include "../wrapper.h"
 #include "../write-or-die.h"
 #include "../trace2.h"
@@ -1754,8 +1755,13 @@ static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_s
 }
 
 static int packed_fsck(struct ref_store *ref_store UNUSED,
-		       struct fsck_options *o UNUSED)
+		       struct fsck_options *o UNUSED,
+		       struct worktree *wt)
 {
+
+	if (!is_main_worktree(wt))
+		return 0;
+
 	return 0;
 }
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 73b05f971b..125f1fe735 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -653,7 +653,8 @@ typedef int read_symbolic_ref_fn(struct ref_store *ref_store, const char *refnam
 				 struct strbuf *referent);
 
 typedef int fsck_fn(struct ref_store *ref_store,
-		    struct fsck_options *o);
+		    struct fsck_options *o,
+		    struct worktree *wt);
 
 struct ref_storage_be {
 	const char *name;
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index f5f957e6de..b6a63c1015 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -2443,7 +2443,8 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
 }
 
 static int reftable_be_fsck(struct ref_store *ref_store UNUSED,
-			    struct fsck_options *o UNUSED)
+			    struct fsck_options *o UNUSED,
+			    struct worktree *wt UNUSED)
 {
 	return 0;
 }
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index be4c064b3c..aee7e04b82 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -25,6 +25,13 @@ test_expect_success 'ref name should be checked' '
 	git tag tag-2 &&
 	git tag multi_hierarchy/tag-2 &&
 
+	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/@ &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	EOF
+	test_must_be_empty err &&
+	rm $branch_dir_prefix/@ &&
+
 	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/.branch-1 &&
 	test_must_fail git refs verify 2>err &&
 	cat >expect <<-EOF &&
@@ -33,20 +40,20 @@ test_expect_success 'ref name should be checked' '
 	rm $branch_dir_prefix/.branch-1 &&
 	test_cmp expect err &&
 
-	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/@ &&
+	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/'\'' branch-1'\'' &&
 	test_must_fail git refs verify 2>err &&
 	cat >expect <<-EOF &&
-	error: refs/heads/@: badRefName: invalid refname format
+	error: refs/heads/ branch-1: badRefName: invalid refname format
 	EOF
-	rm $branch_dir_prefix/@ &&
+	rm $branch_dir_prefix/'\'' branch-1'\'' &&
 	test_cmp expect err &&
 
-	cp $tag_dir_prefix/multi_hierarchy/tag-2 $tag_dir_prefix/multi_hierarchy/@ &&
+	cp $tag_dir_prefix/multi_hierarchy/tag-2 $tag_dir_prefix/multi_hierarchy/'\''~tag-2'\'' &&
 	test_must_fail git refs verify 2>err &&
 	cat >expect <<-EOF &&
-	error: refs/tags/multi_hierarchy/@: badRefName: invalid refname format
+	error: refs/tags/multi_hierarchy/~tag-2: badRefName: invalid refname format
 	EOF
-	rm $tag_dir_prefix/multi_hierarchy/@ &&
+	rm $tag_dir_prefix/multi_hierarchy/'\''~tag-2'\'' &&
 	test_cmp expect err &&
 
 	cp $tag_dir_prefix/tag-1 $tag_dir_prefix/tag-1.lock &&
@@ -60,6 +67,15 @@ test_expect_success 'ref name should be checked' '
 	error: refs/tags/.lock: badRefName: invalid refname format
 	EOF
 	rm $tag_dir_prefix/.lock &&
+	test_cmp expect err &&
+
+	mkdir $tag_dir_prefix/'\''~new-feature'\'' &&
+	cp $tag_dir_prefix/tag-1 $tag_dir_prefix/'\''~new-feature'\''/tag-1 &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/tags/~new-feature/tag-1: badRefName: invalid refname format
+	EOF
+	rm -rf $tag_dir_prefix/'\''~new-feature'\'' &&
 	test_cmp expect err
 '
 
@@ -84,7 +100,7 @@ test_expect_success 'ref name check should be adapted into fsck messages' '
 	rm $branch_dir_prefix/.branch-1 &&
 	test_cmp expect err &&
 
-	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/@ &&
+	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/'\''~branch-1'\'' &&
 	git -c fsck.badRefName=ignore refs verify 2>err &&
 	test_must_be_empty err
 '
@@ -114,13 +130,13 @@ test_expect_success 'ref name check should work for multiple worktrees' '
 		git update-ref refs/worktree/branch-4 refs/heads/branch-3
 	) &&
 
-	cp $worktree1_refdir_prefix/branch-4 $worktree1_refdir_prefix/.branch-2 &&
-	cp $worktree2_refdir_prefix/branch-4 $worktree2_refdir_prefix/@ &&
+	cp $worktree1_refdir_prefix/branch-4 $worktree1_refdir_prefix/'\'' branch-5'\'' &&
+	cp $worktree2_refdir_prefix/branch-4 $worktree2_refdir_prefix/'\''~branch-6'\'' &&
 
 	test_must_fail git refs verify 2>err &&
 	cat >expect <<-EOF &&
-	error: refs/worktree/.branch-2: badRefName: invalid refname format
-	error: refs/worktree/@: badRefName: invalid refname format
+	error: worktrees/worktree-1/refs/worktree/ branch-5: badRefName: invalid refname format
+	error: worktrees/worktree-2/refs/worktree/~branch-6: badRefName: invalid refname format
 	EOF
 	sort err >sorted_err &&
 	test_cmp expect sorted_err &&
@@ -129,8 +145,8 @@ test_expect_success 'ref name check should work for multiple worktrees' '
 		cd worktree-1 &&
 		test_must_fail git refs verify 2>err &&
 		cat >expect <<-EOF &&
-		error: refs/worktree/.branch-2: badRefName: invalid refname format
-		error: refs/worktree/@: badRefName: invalid refname format
+		error: worktrees/worktree-1/refs/worktree/ branch-5: badRefName: invalid refname format
+		error: worktrees/worktree-2/refs/worktree/~branch-6: badRefName: invalid refname format
 		EOF
 		sort err >sorted_err &&
 		test_cmp expect sorted_err
@@ -140,8 +156,8 @@ test_expect_success 'ref name check should work for multiple worktrees' '
 		cd worktree-2 &&
 		test_must_fail git refs verify 2>err &&
 		cat >expect <<-EOF &&
-		error: refs/worktree/.branch-2: badRefName: invalid refname format
-		error: refs/worktree/@: badRefName: invalid refname format
+		error: worktrees/worktree-1/refs/worktree/ branch-5: badRefName: invalid refname format
+		error: worktrees/worktree-2/refs/worktree/~branch-6: badRefName: invalid refname format
 		EOF
 		sort err >sorted_err &&
 		test_cmp expect sorted_err
@@ -190,7 +206,7 @@ test_expect_success 'regular ref content should be checked (individual)' '
 	printf "%s" "$(git rev-parse main)" >$branch_dir_prefix/branch-no-newline &&
 	git refs verify 2>err &&
 	cat >expect <<-EOF &&
-	warning: refs/heads/branch-no-newline: unofficialFormattedRef: misses LF at the end
+	warning: refs/heads/branch-no-newline: refMissingNewline: misses LF at the end
 	EOF
 	rm $branch_dir_prefix/branch-no-newline &&
 	test_cmp expect err &&
@@ -198,7 +214,7 @@ test_expect_success 'regular ref content should be checked (individual)' '
 	printf "%s garbage" "$(git rev-parse main)" >$branch_dir_prefix/branch-garbage &&
 	git refs verify 2>err &&
 	cat >expect <<-EOF &&
-	warning: refs/heads/branch-garbage: unofficialFormattedRef: has trailing garbage: '\'' garbage'\''
+	warning: refs/heads/branch-garbage: trailingRefContent: has trailing garbage: '\'' garbage'\''
 	EOF
 	rm $branch_dir_prefix/branch-garbage &&
 	test_cmp expect err &&
@@ -206,7 +222,7 @@ test_expect_success 'regular ref content should be checked (individual)' '
 	printf "%s\n\n\n" "$(git rev-parse main)" >$tag_dir_prefix/tag-garbage-1 &&
 	git refs verify 2>err &&
 	cat >expect <<-EOF &&
-	warning: refs/tags/tag-garbage-1: unofficialFormattedRef: has trailing garbage: '\''
+	warning: refs/tags/tag-garbage-1: trailingRefContent: has trailing garbage: '\''
 
 
 	'\''
@@ -217,7 +233,7 @@ test_expect_success 'regular ref content should be checked (individual)' '
 	printf "%s\n\n\n  garbage" "$(git rev-parse main)" >$tag_dir_prefix/tag-garbage-2 &&
 	git refs verify 2>err &&
 	cat >expect <<-EOF &&
-	warning: refs/tags/tag-garbage-2: unofficialFormattedRef: has trailing garbage: '\''
+	warning: refs/tags/tag-garbage-2: trailingRefContent: has trailing garbage: '\''
 
 
 	  garbage'\''
@@ -228,16 +244,16 @@ test_expect_success 'regular ref content should be checked (individual)' '
 	printf "%s    garbage\na" "$(git rev-parse main)" >$tag_dir_prefix/tag-garbage-3 &&
 	git refs verify 2>err &&
 	cat >expect <<-EOF &&
-	warning: refs/tags/tag-garbage-3: unofficialFormattedRef: has trailing garbage: '\''    garbage
+	warning: refs/tags/tag-garbage-3: trailingRefContent: has trailing garbage: '\''    garbage
 	a'\''
 	EOF
 	rm $tag_dir_prefix/tag-garbage-3 &&
 	test_cmp expect err &&
 
 	printf "%s garbage" "$(git rev-parse main)" >$tag_dir_prefix/tag-garbage-4 &&
-	test_must_fail git -c fsck.unofficialFormattedRef=error refs verify 2>err &&
+	test_must_fail git -c fsck.trailingRefContent=error refs verify 2>err &&
 	cat >expect <<-EOF &&
-	error: refs/tags/tag-garbage-4: unofficialFormattedRef: has trailing garbage: '\'' garbage'\''
+	error: refs/tags/tag-garbage-4: trailingRefContent: has trailing garbage: '\'' garbage'\''
 	EOF
 	rm $tag_dir_prefix/tag-garbage-4 &&
 	test_cmp expect err
@@ -266,8 +282,8 @@ test_expect_success 'regular ref content should be checked (aggregate)' '
 	error: refs/heads/a/b/branch-bad: badRefContent: $bad_content_3
 	error: refs/tags/tag-bad-1: badRefContent: $bad_content_1
 	error: refs/tags/tag-bad-2: badRefContent: $bad_content_2
-	warning: refs/heads/branch-garbage: unofficialFormattedRef: has trailing garbage: '\'' garbage'\''
-	warning: refs/heads/branch-no-newline: unofficialFormattedRef: misses LF at the end
+	warning: refs/heads/branch-garbage: trailingRefContent: has trailing garbage: '\'' garbage'\''
+	warning: refs/heads/branch-no-newline: refMissingNewline: misses LF at the end
 	EOF
 	sort err >sorted_err &&
 	test_cmp expect sorted_err
@@ -287,10 +303,15 @@ test_expect_success 'textual symref content should be checked (individual)' '
 	rm $branch_dir_prefix/branch-good &&
 	test_must_be_empty err &&
 
+	printf "ref: HEAD\n" >$branch_dir_prefix/branch-head &&
+	git refs verify 2>err &&
+	rm $branch_dir_prefix/branch-head &&
+	test_must_be_empty err &&
+
 	printf "ref: refs/heads/branch" >$branch_dir_prefix/branch-no-newline-1 &&
 	git refs verify 2>err &&
 	cat >expect <<-EOF &&
-	warning: refs/heads/branch-no-newline-1: unofficialFormattedRef: misses LF at the end
+	warning: refs/heads/branch-no-newline-1: refMissingNewline: misses LF at the end
 	EOF
 	rm $branch_dir_prefix/branch-no-newline-1 &&
 	test_cmp expect err &&
@@ -298,8 +319,8 @@ test_expect_success 'textual symref content should be checked (individual)' '
 	printf "ref: refs/heads/branch     " >$branch_dir_prefix/a/b/branch-trailing-1 &&
 	git refs verify 2>err &&
 	cat >expect <<-EOF &&
-	warning: refs/heads/a/b/branch-trailing-1: unofficialFormattedRef: misses LF at the end
-	warning: refs/heads/a/b/branch-trailing-1: unofficialFormattedRef: has trailing whitespaces or newlines
+	warning: refs/heads/a/b/branch-trailing-1: refMissingNewline: misses LF at the end
+	warning: refs/heads/a/b/branch-trailing-1: trailingRefContent: has trailing whitespaces or newlines
 	EOF
 	rm $branch_dir_prefix/a/b/branch-trailing-1 &&
 	test_cmp expect err &&
@@ -307,7 +328,7 @@ test_expect_success 'textual symref content should be checked (individual)' '
 	printf "ref: refs/heads/branch\n\n" >$branch_dir_prefix/a/b/branch-trailing-2 &&
 	git refs verify 2>err &&
 	cat >expect <<-EOF &&
-	warning: refs/heads/a/b/branch-trailing-2: unofficialFormattedRef: has trailing whitespaces or newlines
+	warning: refs/heads/a/b/branch-trailing-2: trailingRefContent: has trailing whitespaces or newlines
 	EOF
 	rm $branch_dir_prefix/a/b/branch-trailing-2 &&
 	test_cmp expect err &&
@@ -315,7 +336,7 @@ test_expect_success 'textual symref content should be checked (individual)' '
 	printf "ref: refs/heads/branch \n" >$branch_dir_prefix/a/b/branch-trailing-3 &&
 	git refs verify 2>err &&
 	cat >expect <<-EOF &&
-	warning: refs/heads/a/b/branch-trailing-3: unofficialFormattedRef: has trailing whitespaces or newlines
+	warning: refs/heads/a/b/branch-trailing-3: trailingRefContent: has trailing whitespaces or newlines
 	EOF
 	rm $branch_dir_prefix/a/b/branch-trailing-3 &&
 	test_cmp expect err &&
@@ -323,8 +344,8 @@ test_expect_success 'textual symref content should be checked (individual)' '
 	printf "ref: refs/heads/branch \n  " >$branch_dir_prefix/a/b/branch-complicated &&
 	git refs verify 2>err &&
 	cat >expect <<-EOF &&
-	warning: refs/heads/a/b/branch-complicated: unofficialFormattedRef: misses LF at the end
-	warning: refs/heads/a/b/branch-complicated: unofficialFormattedRef: has trailing whitespaces or newlines
+	warning: refs/heads/a/b/branch-complicated: refMissingNewline: misses LF at the end
+	warning: refs/heads/a/b/branch-complicated: trailingRefContent: has trailing whitespaces or newlines
 	EOF
 	rm $branch_dir_prefix/a/b/branch-complicated &&
 	test_cmp expect err &&
@@ -332,7 +353,7 @@ test_expect_success 'textual symref content should be checked (individual)' '
 	printf "ref: refs/heads/.branch\n" >$branch_dir_prefix/branch-bad-1 &&
 	test_must_fail git refs verify 2>err &&
 	cat >expect <<-EOF &&
-	error: refs/heads/branch-bad-1: badReferent: points to invalid refname '\''refs/heads/.branch'\''
+	error: refs/heads/branch-bad-1: badReferentName: points to invalid refname '\''refs/heads/.branch'\''
 	EOF
 	rm $branch_dir_prefix/branch-bad-1 &&
 	test_cmp expect err
@@ -348,6 +369,7 @@ test_expect_success 'textual symref content should be checked (aggregate)' '
 	mkdir -p "$branch_dir_prefix/a/b" &&
 
 	printf "ref: refs/heads/branch\n" >$branch_dir_prefix/branch-good &&
+	printf "ref: HEAD\n" >$branch_dir_prefix/branch-head &&
 	printf "ref: refs/heads/branch" >$branch_dir_prefix/branch-no-newline-1 &&
 	printf "ref: refs/heads/branch     " >$branch_dir_prefix/a/b/branch-trailing-1 &&
 	printf "ref: refs/heads/branch\n\n" >$branch_dir_prefix/a/b/branch-trailing-2 &&
@@ -357,20 +379,20 @@ test_expect_success 'textual symref content should be checked (aggregate)' '
 
 	test_must_fail git refs verify 2>err &&
 	cat >expect <<-EOF &&
-	error: refs/heads/branch-bad-1: badReferent: points to invalid refname '\''refs/heads/.branch'\''
-	warning: refs/heads/a/b/branch-complicated: unofficialFormattedRef: has trailing whitespaces or newlines
-	warning: refs/heads/a/b/branch-complicated: unofficialFormattedRef: misses LF at the end
-	warning: refs/heads/a/b/branch-trailing-1: unofficialFormattedRef: has trailing whitespaces or newlines
-	warning: refs/heads/a/b/branch-trailing-1: unofficialFormattedRef: misses LF at the end
-	warning: refs/heads/a/b/branch-trailing-2: unofficialFormattedRef: has trailing whitespaces or newlines
-	warning: refs/heads/a/b/branch-trailing-3: unofficialFormattedRef: has trailing whitespaces or newlines
-	warning: refs/heads/branch-no-newline-1: unofficialFormattedRef: misses LF at the end
+	error: refs/heads/branch-bad-1: badReferentName: points to invalid refname '\''refs/heads/.branch'\''
+	warning: refs/heads/a/b/branch-complicated: refMissingNewline: misses LF at the end
+	warning: refs/heads/a/b/branch-complicated: trailingRefContent: has trailing whitespaces or newlines
+	warning: refs/heads/a/b/branch-trailing-1: refMissingNewline: misses LF at the end
+	warning: refs/heads/a/b/branch-trailing-1: trailingRefContent: has trailing whitespaces or newlines
+	warning: refs/heads/a/b/branch-trailing-2: trailingRefContent: has trailing whitespaces or newlines
+	warning: refs/heads/a/b/branch-trailing-3: trailingRefContent: has trailing whitespaces or newlines
+	warning: refs/heads/branch-no-newline-1: refMissingNewline: misses LF at the end
 	EOF
 	sort err >sorted_err &&
 	test_cmp expect sorted_err
 '
 
-test_expect_success 'textual symref should be checked whether it is escaped' '
+test_expect_success 'the target of the textual symref should be checked' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	branch_dir_prefix=.git/refs/heads &&
@@ -379,48 +401,71 @@ test_expect_success 'textual symref should be checked whether it is escaped' '
 	test_commit default &&
 	mkdir -p "$branch_dir_prefix/a/b" &&
 
+	printf "ref: HEAD\n" >$branch_dir_prefix/branch-good &&
+	git refs verify 2>err &&
+	rm $branch_dir_prefix/branch-good &&
+	test_must_be_empty err &&
+
+	printf "ref: refs/foo\n" >$branch_dir_prefix/branch-good &&
+	git refs verify 2>err &&
+	rm $branch_dir_prefix/branch-good &&
+	test_must_be_empty err &&
+
 	printf "ref: refs-back/heads/main\n" >$branch_dir_prefix/branch-bad-1 &&
 	git refs verify 2>err &&
 	cat >expect <<-EOF &&
-	warning: refs/heads/branch-bad-1: escapeReferent: referent '\''refs-back/heads/main'\'' is outside of refs/ or worktrees/
+	warning: refs/heads/branch-bad-1: symrefTargetIsNotARef: points to non-ref target '\''refs-back/heads/main'\''
 	EOF
 	rm $branch_dir_prefix/branch-bad-1 &&
 	test_cmp expect err
 '
 
-test_expect_success 'textual symref escape check should work with worktrees' '
+test_expect_success SYMLINKS 'symlink symref content should be checked' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
+	branch_dir_prefix=.git/refs/heads &&
+	tag_dir_prefix=.git/refs/tags &&
 	cd repo &&
 	test_commit default &&
-	git branch branch-1 &&
-	git branch branch-2 &&
-	git branch branch-3 &&
-	git worktree add ./worktree-1 branch-2 &&
-	git worktree add ./worktree-2 branch-3 &&
+	mkdir -p "$branch_dir_prefix/a/b" &&
 
-	(
-		cd worktree-1 &&
-		git branch refs/worktree/w1-branch &&
-		git symbolic-ref refs/worktree/branch-4 refs/heads/branch-1 &&
-		git symbolic-ref refs/worktree/branch-5 worktrees/worktree-2/refs/worktree/w2-branch
-	) &&
-	(
-		cd worktree-2 &&
-		git branch refs/worktree/w2-branch &&
-		git symbolic-ref refs/worktree/branch-4 refs/heads/branch-1 &&
-		git symbolic-ref refs/worktree/branch-5 worktrees/worktree-1/refs/worktree/w1-branch
-	) &&
+	ln -sf ./main $branch_dir_prefix/branch-symbolic-good &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/branch-symbolic-good: symlinkRef: use deprecated symbolic link for symref
+	EOF
+	rm $branch_dir_prefix/branch-symbolic-good &&
+	test_cmp expect err &&
 
+	ln -sf ../../logs/branch-escape $branch_dir_prefix/branch-symbolic &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/branch-symbolic: symlinkRef: use deprecated symbolic link for symref
+	warning: refs/heads/branch-symbolic: symrefTargetIsNotARef: points to non-ref target '\''logs/branch-escape'\''
+	EOF
+	rm $branch_dir_prefix/branch-symbolic &&
+	test_cmp expect err &&
 
-	git symbolic-ref refs/heads/branch-5 worktrees/worktree-1/refs/worktree/w1-branch &&
-	git symbolic-ref refs/heads/branch-6 worktrees/worktree-2/refs/worktree/w2-branch &&
+	ln -sf ./"branch   " $branch_dir_prefix/branch-symbolic-bad &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/branch-symbolic-bad: symlinkRef: use deprecated symbolic link for symref
+	error: refs/heads/branch-symbolic-bad: badReferentName: points to invalid refname '\''refs/heads/branch   '\''
+	EOF
+	rm $branch_dir_prefix/branch-symbolic-bad &&
+	test_cmp expect err &&
 
-	git refs verify 2>err &&
-	test_must_be_empty err
+	ln -sf ./".tag" $tag_dir_prefix/tag-symbolic-1 &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/tags/tag-symbolic-1: symlinkRef: use deprecated symbolic link for symref
+	error: refs/tags/tag-symbolic-1: badReferentName: points to invalid refname '\''refs/tags/.tag'\''
+	EOF
+	rm $tag_dir_prefix/tag-symbolic-1 &&
+	test_cmp expect err
 '
 
-test_expect_success 'all textual symref checks should work with worktrees' '
+test_expect_success 'ref content checks should work with worktrees' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	cd repo &&
@@ -449,7 +494,7 @@ test_expect_success 'all textual symref checks should work with worktrees' '
 	printf "%s" $bad_content_1 >$worktree1_refdir_prefix/bad-branch-1 &&
 	test_must_fail git refs verify 2>err &&
 	cat >expect <<-EOF &&
-	error: refs/worktree/bad-branch-1: badRefContent: $bad_content_1
+	error: worktrees/worktree-1/refs/worktree/bad-branch-1: badRefContent: $bad_content_1
 	EOF
 	rm $worktree1_refdir_prefix/bad-branch-1 &&
 	test_cmp expect err &&
@@ -457,7 +502,7 @@ test_expect_success 'all textual symref checks should work with worktrees' '
 	printf "%s" $bad_content_2 >$worktree2_refdir_prefix/bad-branch-2 &&
 	test_must_fail git refs verify 2>err &&
 	cat >expect <<-EOF &&
-	error: refs/worktree/bad-branch-2: badRefContent: $bad_content_2
+	error: worktrees/worktree-2/refs/worktree/bad-branch-2: badRefContent: $bad_content_2
 	EOF
 	rm $worktree2_refdir_prefix/bad-branch-2 &&
 	test_cmp expect err &&
@@ -465,7 +510,7 @@ test_expect_success 'all textual symref checks should work with worktrees' '
 	printf "%s" $bad_content_3 >$worktree1_refdir_prefix/bad-branch-3 &&
 	test_must_fail git refs verify 2>err &&
 	cat >expect <<-EOF &&
-	error: refs/worktree/bad-branch-3: badRefContent: $bad_content_3
+	error: worktrees/worktree-1/refs/worktree/bad-branch-3: badRefContent: $bad_content_3
 	EOF
 	rm $worktree1_refdir_prefix/bad-branch-3 &&
 	test_cmp expect err &&
@@ -473,61 +518,17 @@ test_expect_success 'all textual symref checks should work with worktrees' '
 	printf "%s" "$(git rev-parse HEAD)" >$worktree1_refdir_prefix/branch-no-newline &&
 	git refs verify 2>err &&
 	cat >expect <<-EOF &&
-	warning: refs/worktree/branch-no-newline: unofficialFormattedRef: misses LF at the end
+	warning: worktrees/worktree-1/refs/worktree/branch-no-newline: refMissingNewline: misses LF at the end
 	EOF
 	rm $worktree1_refdir_prefix/branch-no-newline &&
 	test_cmp expect err &&
 
-	printf "%s garbage" "$(git rev-parse HEAD)" >$worktree2_refdir_prefix/branch-garbage &&
-	git refs verify 2>err &&
-	cat >expect <<-EOF &&
-	warning: refs/worktree/branch-garbage: unofficialFormattedRef: has trailing garbage: '\'' garbage'\''
-	EOF
-	rm $worktree2_refdir_prefix/branch-garbage
-'
-
-test_expect_success SYMLINKS 'symlink symref content should be checked (individual)' '
-	test_when_finished "rm -rf repo" &&
-	git init repo &&
-	branch_dir_prefix=.git/refs/heads &&
-	tag_dir_prefix=.git/refs/tags &&
-	cd repo &&
-	test_commit default &&
-	mkdir -p "$branch_dir_prefix/a/b" &&
-
-	ln -sf ./main $branch_dir_prefix/branch-symbolic-good &&
-	git refs verify 2>err &&
-	cat >expect <<-EOF &&
-	warning: refs/heads/branch-symbolic-good: symlinkRef: use deprecated symbolic link for symref
-	EOF
-	rm $branch_dir_prefix/branch-symbolic-good &&
-	test_cmp expect err &&
-
-	ln -sf ../../logs/branch-escape $branch_dir_prefix/branch-symbolic &&
+	printf "%s garbage" "$(git rev-parse HEAD)" >$worktree1_refdir_prefix/branch-garbage &&
 	git refs verify 2>err &&
 	cat >expect <<-EOF &&
-	warning: refs/heads/branch-symbolic: symlinkRef: use deprecated symbolic link for symref
-	warning: refs/heads/branch-symbolic: escapeReferent: referent '\''logs/branch-escape'\'' is outside of refs/ or worktrees/
+	warning: worktrees/worktree-1/refs/worktree/branch-garbage: trailingRefContent: has trailing garbage: '\'' garbage'\''
 	EOF
-	rm $branch_dir_prefix/branch-symbolic &&
-	test_cmp expect err &&
-
-	ln -sf ./"branch   space" $branch_dir_prefix/branch-symbolic-bad &&
-	test_must_fail git refs verify 2>err &&
-	cat >expect <<-EOF &&
-	warning: refs/heads/branch-symbolic-bad: symlinkRef: use deprecated symbolic link for symref
-	error: refs/heads/branch-symbolic-bad: badReferent: points to invalid refname '\''refs/heads/branch   space'\''
-	EOF
-	rm $branch_dir_prefix/branch-symbolic-bad &&
-	test_cmp expect err &&
-
-	ln -sf ./".tag" $tag_dir_prefix/tag-symbolic-1 &&
-	test_must_fail git refs verify 2>err &&
-	cat >expect <<-EOF &&
-	warning: refs/tags/tag-symbolic-1: symlinkRef: use deprecated symbolic link for symref
-	error: refs/tags/tag-symbolic-1: badReferent: points to invalid refname '\''refs/tags/.tag'\''
-	EOF
-	rm $tag_dir_prefix/tag-symbolic-1 &&
+	rm $worktree1_refdir_prefix/branch-garbage &&
 	test_cmp expect err
 '
 
-- 
2.47.0

