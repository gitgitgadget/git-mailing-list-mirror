Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428951A01D4
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 11:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732103532; cv=none; b=ha4sfI13dB+XTAO5MZTZVo3o4D2Fx5BSk3EBQ/NLPsWVo3y2nFW3/TFBGr+2mu2tAfMh+I0jGFqVeiABku8nFzgDRkMqIHUYNynkfiRena0tGs50eZgIEMvnnFII5DhaI++cyNcfAlpDxQOxejXxsRqsAK4jk5xb2iWU20HBAdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732103532; c=relaxed/simple;
	bh=Ii92LAF0JIPuAo4gZX3jRN8De3iey6UerhVehKXOAx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=leR5cCh/tgXY0LNf+GZIzGKaC0IHf2tIqty8zA5Nh1kRWZpbAAl8chlk2cLz7UOEnLwFuoLFE6WcTyjUb2+ZhiPqM0TGOgR7bTdd6fUPvOO0s5J8Ix4atPU8nRusgy7hzqPZLSI9MjSOeMIkyH1E0NpwEz0q8dmnZ6CJ12UtJi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePKEBhqX; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePKEBhqX"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7edb6879196so1473133a12.3
        for <git@vger.kernel.org>; Wed, 20 Nov 2024 03:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732103529; x=1732708329; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GeWHLfS53DVdQjI9rauCGMiEsC9cKzziMR6yFX8GjjA=;
        b=ePKEBhqXbb5/0iK8rFTdyW6FIXCerd/jm+2m5O3bcbWsi2hqHgsYNdq0ATtHLJrdSK
         07FAr2VHhH7GCGc2oVWo3nQfb2xNuAt5H6Ik+ddcG7flWKCWfy2hGycj7xD7By10xmML
         P04lKXzGUVrOwwFweVNdxHlm8IyvmmJuIUhUGtmrNlRYoX7IgiAJpdci7HqSGQqSe345
         9hZZ8OlE72XyNbbXjvJ8FJ7xsjjexCWU4Jh3MiOb9Gj/7KqZ7Ro7G3VGmKXOvu9XViZh
         b0E81YeTPEJY0yuJoXNxWvEg/feoaOGxw6dHT9lPvJXv4voRgk0rbo4GS7LIZOAq4Eog
         hluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732103529; x=1732708329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GeWHLfS53DVdQjI9rauCGMiEsC9cKzziMR6yFX8GjjA=;
        b=xPBAgCc4VZTB0inhkBKxWv9Wy6X9seAJZRKUAqZJvhRz4y8jtPjl6PvNq6iJaqRCiZ
         F1ZabAGbZj5elogYD8HkhQ3PrvUmhGDCTiqIaiIDJiyH/J95NGsDDZMmlkosEHVykVYX
         ColRDOynY9MjZb1CEo+VIOz67cCOHT+6/WYCo9cxV3d/rQlGWpe3Gy6HqW3j2FaMGUhD
         lqiLxQW78ov0bGra9ypEaOVj/62drsbDX0iaqJBAXKylj6nZ+gKrcMCUXQKY0GjgCxtB
         Wnx98O5cYbVTrC9EJpw04D9fCYStJenAnFkJ/ShQApGcERJSeJJclS+720qSol8ViSYp
         01gQ==
X-Gm-Message-State: AOJu0Ywhu0G3VCUKg0ru6ORjkrYYiVvZGpV0aE8VVmHsFbqJ01xQYQdB
	R3lZGb2eixu6QTItIF+2xNn44rFipq39WEKQS8jwaN6mMVYEImaYkr3rAA==
X-Google-Smtp-Source: AGHT+IHJ5yRNDopre90JNrLqKzoAHTi+35+9ASYf+rhROSuf2KGmX48AHzhRc8Z8kAiQzsPwwz6L7g==
X-Received: by 2002:a05:6a20:12c6:b0:1db:ed4d:fa90 with SMTP id adf61e73a8af0-1ddae3eb113mr3408481637.10.1732103529040;
        Wed, 20 Nov 2024 03:52:09 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724befeaa4dsm1414956b3a.200.2024.11.20.03.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 03:52:08 -0800 (PST)
Date: Wed, 20 Nov 2024 19:52:18 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v9 9/9] ref: add symlink ref content check for files backend
Message-ID: <Zz3Ncs8RwsqTvj2K@ArchLinux>
References: <Zz3MON9_9DGD6nsy@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zz3MON9_9DGD6nsy@ArchLinux>

Besides the textual symref, we also allow symbolic links as the symref.
So, we should also provide the consistency check as what we have done
for textual symref. And also we consider deprecating writing the
symbolic links. We first need to access whether symbolic links still
be used. So, add a new fsck message "symlinkRef(INFO)" to tell the
user be aware of this information.

We have already introduced "files_fsck_symref_target". We should reuse
this function to handle the symrefs which use legacy symbolic links. We
should not check the trailing garbage for symbolic refs. Add a new
parameter "symbolic_link" to disable some checks which should only be
executed for textual symrefs.

And we need to also generate the "referent" parameter for reusing
"files_fsck_symref_target" by the following steps:

1. Use "strbuf_add_real_path" to resolve the symlink and get the
   absolute path "ref_content" which the symlink ref points to.
2. Generate the absolute path "abs_gitdir" of "gitdir" and combine
   "ref_content" and "abs_gitdir" to extract the relative path
   "relative_referent_path".
3. If "ref_content" is outside of "gitdir", we just set "referent" with
   "ref_content". Instead, we set "referent" with
   "relative_referent_path".

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Documentation/fsck-msgids.txt |   6 ++
 fsck.h                        |   1 +
 refs/files-backend.c          |  38 ++++++++-
 t/t0602-reffiles-fsck.sh      | 141 ++++++++++++++++++++++++++++++++++
 4 files changed, 182 insertions(+), 4 deletions(-)

diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
index f82ebc58e8..b14bc44ca4 100644
--- a/Documentation/fsck-msgids.txt
+++ b/Documentation/fsck-msgids.txt
@@ -183,6 +183,12 @@
 	git@vger.kernel.org mailing list if you see this error, as
 	we need to know what tools created such a file.
 
+`symlinkRef`::
+	(INFO) A symbolic link is used as a symref. Report to the
+	git@vger.kernel.org mailing list if you see this error, as we
+	are assessing the feasibility of dropping the support to drop
+	creating symbolic links as symrefs.
+
 `symrefTargetIsNotARef`::
 	(INFO) The target of a symbolic reference points neither to
 	a root reference nor to a reference starting with "refs/".
diff --git a/fsck.h b/fsck.h
index 53a47612e6..a44c231a5f 100644
--- a/fsck.h
+++ b/fsck.h
@@ -86,6 +86,7 @@ enum fsck_msg_type {
 	FUNC(MAILMAP_SYMLINK, INFO) \
 	FUNC(BAD_TAG_NAME, INFO) \
 	FUNC(MISSING_TAGGER_ENTRY, INFO) \
+	FUNC(SYMLINK_REF, INFO) \
 	FUNC(REF_MISSING_NEWLINE, INFO) \
 	FUNC(SYMREF_TARGET_IS_NOT_A_REF, INFO) \
 	FUNC(TRAILING_REF_CONTENT, INFO) \
diff --git a/refs/files-backend.c b/refs/files-backend.c
index c2b99fdf40..ea5961e48c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1,6 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "../git-compat-util.h"
+#include "../abspath.h"
 #include "../config.h"
 #include "../copy.h"
 #include "../environment.h"
@@ -3511,7 +3512,8 @@ typedef int (*files_fsck_refs_fn)(struct ref_store *ref_store,
 
 static int files_fsck_symref_target(struct fsck_options *o,
 				    struct fsck_ref_report *report,
-				    struct strbuf *referent)
+				    struct strbuf *referent,
+				    unsigned int symbolic_link)
 {
 	int is_referent_root;
 	char orig_last_byte;
@@ -3520,7 +3522,8 @@ static int files_fsck_symref_target(struct fsck_options *o,
 
 	orig_len = referent->len;
 	orig_last_byte = referent->buf[orig_len - 1];
-	strbuf_rtrim(referent);
+	if (!symbolic_link)
+		strbuf_rtrim(referent);
 
 	is_referent_root = is_root_ref(referent->buf);
 	if (!is_referent_root &&
@@ -3539,6 +3542,9 @@ static int files_fsck_symref_target(struct fsck_options *o,
 		goto out;
 	}
 
+	if (symbolic_link)
+		goto out;
+
 	if (referent->len == orig_len ||
 	    (referent->len < orig_len && orig_last_byte != '\n')) {
 		ret = fsck_report_ref(o, report,
@@ -3562,6 +3568,7 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 				   struct dir_iterator *iter)
 {
 	struct strbuf ref_content = STRBUF_INIT;
+	struct strbuf abs_gitdir = STRBUF_INIT;
 	struct strbuf referent = STRBUF_INIT;
 	struct fsck_ref_report report = { 0 };
 	const char *trailing = NULL;
@@ -3572,8 +3579,30 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 
 	report.path = target_name;
 
-	if (S_ISLNK(iter->st.st_mode))
+	if (S_ISLNK(iter->st.st_mode)) {
+		const char *relative_referent_path = NULL;
+
+		ret = fsck_report_ref(o, &report,
+				      FSCK_MSG_SYMLINK_REF,
+				      "use deprecated symbolic link for symref");
+
+		strbuf_add_absolute_path(&abs_gitdir, ref_store->repo->gitdir);
+		strbuf_normalize_path(&abs_gitdir);
+		if (!is_dir_sep(abs_gitdir.buf[abs_gitdir.len - 1]))
+			strbuf_addch(&abs_gitdir, '/');
+
+		strbuf_add_real_path(&ref_content, iter->path.buf);
+		skip_prefix(ref_content.buf, abs_gitdir.buf,
+			    &relative_referent_path);
+
+		if (relative_referent_path)
+			strbuf_addstr(&referent, relative_referent_path);
+		else
+			strbuf_addbuf(&referent, &ref_content);
+
+		ret |= files_fsck_symref_target(o, &report, &referent, 1);
 		goto cleanup;
+	}
 
 	if (strbuf_read_file(&ref_content, iter->path.buf, 0) < 0) {
 		/*
@@ -3611,13 +3640,14 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 			goto cleanup;
 		}
 	} else {
-		ret = files_fsck_symref_target(o, &report, &referent);
+		ret = files_fsck_symref_target(o, &report, &referent, 0);
 		goto cleanup;
 	}
 
 cleanup:
 	strbuf_release(&ref_content);
 	strbuf_release(&referent);
+	strbuf_release(&abs_gitdir);
 	return ret;
 }
 
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index 692b30727a..f8f27cfc6c 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -395,6 +395,147 @@ test_expect_success 'the target of the textual symref should be checked' '
 	done
 '
 
+test_expect_success SYMLINKS 'symlink symref content should be checked' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	branch_dir_prefix=.git/refs/heads &&
+	tag_dir_prefix=.git/refs/tags &&
+	cd repo &&
+	test_commit default &&
+	mkdir -p "$branch_dir_prefix/a/b" &&
+
+	ln -sf ./main $branch_dir_prefix/branch-symbolic-good &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/branch-symbolic-good: symlinkRef: use deprecated symbolic link for symref
+	EOF
+	rm $branch_dir_prefix/branch-symbolic-good &&
+	test_cmp expect err &&
+
+	ln -sf ../../logs/branch-escape $branch_dir_prefix/branch-symbolic &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/branch-symbolic: symlinkRef: use deprecated symbolic link for symref
+	warning: refs/heads/branch-symbolic: symrefTargetIsNotARef: points to non-ref target '\''logs/branch-escape'\''
+	EOF
+	rm $branch_dir_prefix/branch-symbolic &&
+	test_cmp expect err &&
+
+	ln -sf ./"branch   " $branch_dir_prefix/branch-symbolic-bad &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/branch-symbolic-bad: symlinkRef: use deprecated symbolic link for symref
+	error: refs/heads/branch-symbolic-bad: badReferentName: points to invalid refname '\''refs/heads/branch   '\''
+	EOF
+	rm $branch_dir_prefix/branch-symbolic-bad &&
+	test_cmp expect err &&
+
+	ln -sf ./".tag" $tag_dir_prefix/tag-symbolic-1 &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/tags/tag-symbolic-1: symlinkRef: use deprecated symbolic link for symref
+	error: refs/tags/tag-symbolic-1: badReferentName: points to invalid refname '\''refs/tags/.tag'\''
+	EOF
+	rm $tag_dir_prefix/tag-symbolic-1 &&
+	test_cmp expect err
+'
+
+test_expect_success SYMLINKS 'symlink symref content should be checked (worktree)' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	cd repo &&
+	test_commit default &&
+	git branch branch-1 &&
+	git branch branch-2 &&
+	git branch branch-3 &&
+	git worktree add ./worktree-1 branch-2 &&
+	git worktree add ./worktree-2 branch-3 &&
+	main_worktree_refdir_prefix=.git/refs/heads &&
+	worktree1_refdir_prefix=.git/worktrees/worktree-1/refs/worktree &&
+	worktree2_refdir_prefix=.git/worktrees/worktree-2/refs/worktree &&
+
+	(
+		cd worktree-1 &&
+		git update-ref refs/worktree/branch-4 refs/heads/branch-1
+	) &&
+	(
+		cd worktree-2 &&
+		git update-ref refs/worktree/branch-4 refs/heads/branch-1
+	) &&
+
+	ln -sf ../../../../refs/heads/good-branch $worktree1_refdir_prefix/branch-symbolic-good &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: worktrees/worktree-1/refs/worktree/branch-symbolic-good: symlinkRef: use deprecated symbolic link for symref
+	EOF
+	rm $worktree1_refdir_prefix/branch-symbolic-good &&
+	test_cmp expect err &&
+
+	ln -sf ../../../../worktrees/worktree-1/good-branch $worktree2_refdir_prefix/branch-symbolic-good &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: worktrees/worktree-2/refs/worktree/branch-symbolic-good: symlinkRef: use deprecated symbolic link for symref
+	EOF
+	rm $worktree2_refdir_prefix/branch-symbolic-good &&
+	test_cmp expect err &&
+
+	ln -sf ../../worktrees/worktree-2/good-branch $main_worktree_refdir_prefix/branch-symbolic-good &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/branch-symbolic-good: symlinkRef: use deprecated symbolic link for symref
+	EOF
+	rm $main_worktree_refdir_prefix/branch-symbolic-good &&
+	test_cmp expect err &&
+
+	ln -sf ../../../../logs/branch-escape $worktree1_refdir_prefix/branch-symbolic &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: worktrees/worktree-1/refs/worktree/branch-symbolic: symlinkRef: use deprecated symbolic link for symref
+	warning: worktrees/worktree-1/refs/worktree/branch-symbolic: symrefTargetIsNotARef: points to non-ref target '\''logs/branch-escape'\''
+	EOF
+	rm $worktree1_refdir_prefix/branch-symbolic &&
+	test_cmp expect err &&
+
+	for bad_referent_name in ".tag" "branch   "
+	do
+		ln -sf ./"$bad_referent_name" $worktree1_refdir_prefix/bad-symbolic &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		warning: worktrees/worktree-1/refs/worktree/bad-symbolic: symlinkRef: use deprecated symbolic link for symref
+		error: worktrees/worktree-1/refs/worktree/bad-symbolic: badReferentName: points to invalid refname '\''worktrees/worktree-1/refs/worktree/$bad_referent_name'\''
+		EOF
+		rm $worktree1_refdir_prefix/bad-symbolic &&
+		test_cmp expect err &&
+
+		ln -sf ../../../../refs/heads/"$bad_referent_name" $worktree1_refdir_prefix/bad-symbolic &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		warning: worktrees/worktree-1/refs/worktree/bad-symbolic: symlinkRef: use deprecated symbolic link for symref
+		error: worktrees/worktree-1/refs/worktree/bad-symbolic: badReferentName: points to invalid refname '\''refs/heads/$bad_referent_name'\''
+		EOF
+		rm $worktree1_refdir_prefix/bad-symbolic &&
+		test_cmp expect err &&
+
+		ln -sf ./"$bad_referent_name" $worktree2_refdir_prefix/bad-symbolic &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		warning: worktrees/worktree-2/refs/worktree/bad-symbolic: symlinkRef: use deprecated symbolic link for symref
+		error: worktrees/worktree-2/refs/worktree/bad-symbolic: badReferentName: points to invalid refname '\''worktrees/worktree-2/refs/worktree/$bad_referent_name'\''
+		EOF
+		rm $worktree2_refdir_prefix/bad-symbolic &&
+		test_cmp expect err &&
+
+		ln -sf ../../../../refs/heads/"$bad_referent_name" $worktree2_refdir_prefix/bad-symbolic &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		warning: worktrees/worktree-2/refs/worktree/bad-symbolic: symlinkRef: use deprecated symbolic link for symref
+		error: worktrees/worktree-2/refs/worktree/bad-symbolic: badReferentName: points to invalid refname '\''refs/heads/$bad_referent_name'\''
+		EOF
+		rm $worktree2_refdir_prefix/bad-symbolic &&
+		test_cmp expect err || return 1
+	done
+'
+
 test_expect_success 'ref content checks should work with worktrees' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
-- 
2.47.0

