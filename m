Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757692B9BB
	for <git@vger.kernel.org>; Sun, 29 Sep 2024 07:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727594260; cv=none; b=Bx0gWPSCurrs/aC04WB3iqezGKwGrZkIVHeRxmjquKc1dSsypdDMnnRBQp6O0tFxmkelSEums/7hHpzvpbF5HnOdQ0Ts7duE8XiO4uh+KrFDwVA0bI1spD6isQAO6MxnWW66dSYOBAcSQv/CShlUEkiDnX6VOBsapagBwJhVpZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727594260; c=relaxed/simple;
	bh=SksFYVlGFykWr6RcyKhXT2JXUP1FQCT+NApR4NzgrRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qa8LnWcD9ST9npLRCSmiKnwY0q1f3CqhUFNpSeCswt7bNUIAhx50t8iaBUEpg252dGCmU9PJm32/hnHdiNEaP1BYu0A1aSEvYCiQbDUO5IrImBARC/okGza8kjfrtsLXBvi8kzcH0uZasZJjVo/q7kZEWnTwc2WxS/wbB45Bnss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZz0nJhQ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZz0nJhQ"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-207115e3056so29037575ad.2
        for <git@vger.kernel.org>; Sun, 29 Sep 2024 00:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727594257; x=1728199057; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WbjzJ6W6f2dDRq6ZRP9I+cPiZ/sENA99+TsujPV7mHg=;
        b=CZz0nJhQxd8jNArlyIhfLFxCwf+Wwe0bjnxB30SznbHEZJ2PDmGRn4oneLEX1zUIm+
         GGY0Nvo1aBA4rIhaQ6uPRFRHaoJSoZdSaItaZMHXpb6vsnpmOG9YwZt2t5GrLwsmfIgb
         uiOU6bQuT/Z5XfsP7ZMDe4xQhE9xkzmzuFVh6vSYo8/if/OQvanPFCMSZc9BdDQF0f7P
         7hTi8p2nz0oDsJfxLLITux1+8n5eazsl09B67tqwvid4NobCqU4KoIVLjJq1qI+Sn8Z/
         0eKYCXh7qpMmsF0dkrdqEZclTXhTqIG6Hkf3u9LW0TKHNlsaibH7++kFZunmZRmz5AGg
         Mxnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727594257; x=1728199057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbjzJ6W6f2dDRq6ZRP9I+cPiZ/sENA99+TsujPV7mHg=;
        b=KLHaYXAFjiKk5WIDKgBgW+rx7n3MJuyhSpGpsH8BKFMrx7typRhc/SNfR69iuBoPTF
         jzHVWNVmeHOMs37DtAwG0RR6XS5hFWiQu50RhlTVgCMKEE06RCbsjMKXRwlnDOdpBnCz
         ReyfAMl3XQt+IPhRXy0L7piQK5sRneX9dUIcuoxW7iSYJtK2AvqDXdOLzgmkQNrqIS1v
         Pphe6pkHBjEhLX5wOmZVrH+9V/1J//DAQ/MXbFpsYMM4oMGpFezQzF1wxIPhN37JETaP
         uoC3pvZy8pUZmPc4RLBjpta+eqHq5cfQX3YHfEO1o3Gy53AQDBuZP2WPyBekAk9Eqbs5
         a9bg==
X-Gm-Message-State: AOJu0Ywpk0hT5trqSidGh1XraPH78T1heRSpOfu+NqZvdTtAL0NnLvOu
	3O/t5lu+kDGISeeF7+ZK6UXXn/FRB05Hb80eUqARAjtgHm4+QZTjaLOO2Q==
X-Google-Smtp-Source: AGHT+IEUHCwctBjKX3StZJ3rTJVeyylZenu5Op/AuMHSiiAyfNEi5BfZaWiz9dN2/umuB5TlJKdTrw==
X-Received: by 2002:a17:903:32cc:b0:20b:7e0d:91 with SMTP id d9443c01a7336-20b7e0d0336mr4097365ad.50.1727594257166;
        Sun, 29 Sep 2024 00:17:37 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e64045sm35747165ad.272.2024.09.29.00.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 00:17:36 -0700 (PDT)
Date: Sun, 29 Sep 2024 15:17:36 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 9/9] ref: add symlink ref content check for files backend
Message-ID: <Zvj_EELQdMsN7j2w@ArchLinux>
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

We have already introduced "files_fsck_symref_target". We should reuse
this function to handle the symrefs which use legacy symbolic links. We
should not check the trailing garbage for symbolic refs. Add a new
parameter "symbolic_link" to disable some checks which should only be
executed for textual symrefs.

We firstly use the "strbuf_add_real_path" to resolve the symlink and
get the absolute path as the "ref_content" which the symlink ref points
to. Then we can use the absolute "abs_gitdir" of the "gitdir" and then
combine "ref_content" and "abs_gitdir" to extract the relative path
"referent". If "ref_content" is outside of "gitdir", we just use the
"ref_content" as the "referent". Thus, we can reuse
"files_fsck_symref_target" function to seamlessly check the symlink
refs.

Because we consider deprecating writing the symbolic links. We first
need to asses whether symbolic links may still be used. So, add a new
fsck message "symlinkRef(INFO)" to tell the user be aware of this
information.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Documentation/fsck-msgids.txt |  6 +++++
 fsck.h                        |  1 +
 refs/files-backend.c          | 43 ++++++++++++++++++++++++++++-----
 t/t0602-reffiles-fsck.sh      | 45 +++++++++++++++++++++++++++++++++++
 4 files changed, 89 insertions(+), 6 deletions(-)

diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
index 223974057d..ffe9d6a2f6 100644
--- a/Documentation/fsck-msgids.txt
+++ b/Documentation/fsck-msgids.txt
@@ -184,6 +184,12 @@
 `nullSha1`::
 	(WARN) Tree contains entries pointing to a null sha1.
 
+`symlinkRef`::
+	(INFO) A symbolic link is used as a symref.  Report to the
+	git@vger.kernel.org mailing list if you see this error, as we
+	are assessing the feasibility of dropping the support to drop
+	creating symblinks as symrefs.
+
 `treeNotSorted`::
 	(ERROR) A tree is not properly sorted.
 
diff --git a/fsck.h b/fsck.h
index 5ecee0fda5..f1da5c8a77 100644
--- a/fsck.h
+++ b/fsck.h
@@ -87,6 +87,7 @@ enum fsck_msg_type {
 	FUNC(MAILMAP_SYMLINK, INFO) \
 	FUNC(BAD_TAG_NAME, INFO) \
 	FUNC(MISSING_TAGGER_ENTRY, INFO) \
+	FUNC(SYMLINK_REF, INFO) \
 	FUNC(UNOFFICIAL_FORMATTED_REF, INFO) \
 	/* ignored (elevated when requested) */ \
 	FUNC(EXTRA_HEADER_ENTRY, IGNORE)
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 1182bca108..5a5327a146 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1,6 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "../git-compat-util.h"
+#include "../abspath.h"
 #include "../config.h"
 #include "../copy.h"
 #include "../environment.h"
@@ -3510,15 +3511,18 @@ typedef int (*files_fsck_refs_fn)(struct ref_store *ref_store,
 
 static int files_fsck_symref_target(struct fsck_options *o,
 				    struct fsck_ref_report *report,
-				    struct strbuf *referent)
+				    struct strbuf *referent,
+				    unsigned int symbolic_link)
 {
 	char orig_last_byte;
 	size_t orig_len;
 	int ret = 0;
 
-	orig_len = referent->len;
-	orig_last_byte = referent->buf[orig_len - 1];
-	strbuf_rtrim(referent);
+	if (!symbolic_link) {
+		orig_len = referent->len;
+		orig_last_byte = referent->buf[orig_len - 1];
+		strbuf_rtrim(referent);
+	}
 
 	if (!starts_with(referent->buf, "refs/") &&
 	    !starts_with(referent->buf, "worktrees/")) {
@@ -3535,6 +3539,9 @@ static int files_fsck_symref_target(struct fsck_options *o,
 		goto out;
 	}
 
+	if (symbolic_link)
+		goto out;
+
 
 	if (referent->len == orig_len ||
 	    (referent->len < orig_len && orig_last_byte != '\n')) {
@@ -3559,6 +3566,7 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 				   struct dir_iterator *iter)
 {
 	struct strbuf ref_content = STRBUF_INIT;
+	struct strbuf abs_gitdir = STRBUF_INIT;
 	struct strbuf referent = STRBUF_INIT;
 	struct strbuf refname = STRBUF_INIT;
 	struct fsck_ref_report report = { 0 };
@@ -3571,8 +3579,30 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 	strbuf_addf(&refname, "%s/%s", refs_check_dir, iter->relative_path);
 	report.path = refname.buf;
 
-	if (S_ISLNK(iter->st.st_mode))
+	if (S_ISLNK(iter->st.st_mode)) {
+		const char* relative_referent_path = NULL;
+
+		ret = fsck_report_ref(o, &report,
+				      FSCK_MSG_SYMLINK_REF,
+				      "use deprecated symbolic link for symref");
+
+		strbuf_add_absolute_path(&abs_gitdir, ref_store->gitdir);
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
+		ret += files_fsck_symref_target(o, &report, &referent, 1);
 		goto cleanup;
+	}
 
 	if (strbuf_read_file(&ref_content, iter->path.buf, 0) < 0) {
 		ret = fsck_report_ref(o, &report,
@@ -3605,7 +3635,7 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 			goto cleanup;
 		}
 	} else {
-		ret = files_fsck_symref_target(o, &report, &referent);
+		ret = files_fsck_symref_target(o, &report, &referent, 0);
 		goto cleanup;
 	}
 
@@ -3613,6 +3643,7 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 	strbuf_release(&refname);
 	strbuf_release(&ref_content);
 	strbuf_release(&referent);
+	strbuf_release(&abs_gitdir);
 	return ret;
 }
 
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index 97bbcd3f13..be4c064b3c 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -486,4 +486,49 @@ test_expect_success 'all textual symref checks should work with worktrees' '
 	rm $worktree2_refdir_prefix/branch-garbage
 '
 
+test_expect_success SYMLINKS 'symlink symref content should be checked (individual)' '
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
+	warning: refs/heads/branch-symbolic: escapeReferent: referent '\''logs/branch-escape'\'' is outside of refs/ or worktrees/
+	EOF
+	rm $branch_dir_prefix/branch-symbolic &&
+	test_cmp expect err &&
+
+	ln -sf ./"branch   space" $branch_dir_prefix/branch-symbolic-bad &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/branch-symbolic-bad: symlinkRef: use deprecated symbolic link for symref
+	error: refs/heads/branch-symbolic-bad: badReferent: points to invalid refname '\''refs/heads/branch   space'\''
+	EOF
+	rm $branch_dir_prefix/branch-symbolic-bad &&
+	test_cmp expect err &&
+
+	ln -sf ./".tag" $tag_dir_prefix/tag-symbolic-1 &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/tags/tag-symbolic-1: symlinkRef: use deprecated symbolic link for symref
+	error: refs/tags/tag-symbolic-1: badReferent: points to invalid refname '\''refs/tags/.tag'\''
+	EOF
+	rm $tag_dir_prefix/tag-symbolic-1 &&
+	test_cmp expect err
+'
+
 test_done
-- 
2.46.2

