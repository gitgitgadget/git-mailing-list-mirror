Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9849C13635F
	for <git@vger.kernel.org>; Sun, 29 Sep 2024 07:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727594150; cv=none; b=CtKpbLXKuwrqKoyc6PVt+sXXAD0XZZpixClbLk50z/Jrrb6Wc6L2onqyHoxT0+m0DXB5sGYp6kO8q9kmuWGnO9pl7/moAyj3LDp6llNarlF6vGsR+2GfigjbWI0Yj3Nnj+c8HrVUvNuC1OaeyNY/fhCXbh4AEmj64NabrnPGtz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727594150; c=relaxed/simple;
	bh=GqXZTTFiEm2fuNnDo8NDciaVdx10GU4ZyW8ITJKdci0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8GtBD4XL078v+EV2auBzRkh/HSRb8zoAex8oN8YAD7a6bNQ3mRLt1oAx62oUTdaZNX05veqSPIUAPE0nCITuVxaoL/byR8eKgJ95MwMNE3d4vrJEQC8wEdoYWTbqcPQYVlyXQLD9PrymDPzon5BieVxmftd0oqtU3hLxuj/jLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TXgr15+Z; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXgr15+Z"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2054feabfc3so32320265ad.1
        for <git@vger.kernel.org>; Sun, 29 Sep 2024 00:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727594147; x=1728198947; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hj5F+gEtyBRxz310G1FbgvC+oRcD5qK5T27Qn9rMPGI=;
        b=TXgr15+ZLSxc9rY/exwkxYTXbKw9DpcgnXFmmJ20EwncnVYhbwvlXJ+eXCLSF76n6D
         SIYQEtGK1amGc7S1PaK/YouGmSQuZbtyO0FhHidK6/oiXTHdSKIZsrDzIbyZep/VuiXn
         Samob8xq6Ibe6kyE8R4j88Ih97O7jfXmXLaX/3wm5jJl9voWpWFS6uTFB/PXZd+pQ2JE
         DXipFm0Tzn3u/vwzBpvgpG2xUkwaiH0EmyjCBDTgPTlx7fo1YJRIeMx1kH8syV8/+PoN
         zJfRgkWB1LMr4WQL4vJETHSWedsCJRHjFVL3mGp/nD2E6vwukrDL+t/J9uQABgrEJ43w
         KbOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727594147; x=1728198947;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hj5F+gEtyBRxz310G1FbgvC+oRcD5qK5T27Qn9rMPGI=;
        b=Hfqu4BGactE7GQSeIYjB6qHObsFQ3QGIojUwvwgdvfB1XIEoBmsB7S/wW6UzU2nSHg
         05ctkRQqnSHHYnn8l/yy10Zvs8H7YIESitN5fZztZMJF5TwBzJmYoTk/LGrMr3fYjSq+
         oP6yK6tFAE9BmCmu1hUIwaHOLRzut9X2XjmsOeUxbli9NyENvWLqbJmpyNns6WhhMDbl
         MRqjsopiGYp2uLmF7Y+IRQSBl8ih6PbJ0BoxseVyiS89B3/jK9lUOvWpSHEensAzTwIT
         TDLGEJ2hFJWzhmbYtofjnJL7aVnpVpyZSMxXa/q2FmP/Klisysk7YncxudszJ4tI8FA/
         Z8Rg==
X-Gm-Message-State: AOJu0YwwdfMa/LMFRiuZsQWy1c4/r/a2FagtlwTJisf6vTHqUpVm7WN2
	NgJEVIlRYqGcBBg6rD2nk6Ozdp1ZfOlDflk+QYEZQRB/j7AYyJheeRE98w==
X-Google-Smtp-Source: AGHT+IGTsUENLnnxoP4Q10wSZoxK78yyzBh7EI3v2sWqyqpOQAwgP8z2bccvdMhjyiE5Zd3SE9G1Eg==
X-Received: by 2002:a17:903:32cc:b0:20b:7e0d:8f with SMTP id d9443c01a7336-20b7e0d032bmr4830935ad.3.1727594147405;
        Sun, 29 Sep 2024 00:15:47 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e0ef3asm35656435ad.121.2024.09.29.00.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 00:15:46 -0700 (PDT)
Date: Sun, 29 Sep 2024 15:15:46 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 3/9] ref: port git-fsck(1) regular refs check for files
 backend
Message-ID: <Zvj-osCNDMrUQv83@ArchLinux>
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

"git-fsck(1)" has some consistency checks for regular refs. As we want
to align the checks "git refs verify" performs with them (and eventually
call the unified code that checks refs from both), port the logic
"git-fsck" has to "git refs verify".

"git-fsck(1)" will report an error when the ref content is invalid.
Following this, add a similar check to "git refs verify". Then add a new
fsck error message "badRefContent(ERROR)" to represent that a ref has an
invalid content.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Documentation/fsck-msgids.txt |  3 ++
 fsck.h                        |  1 +
 refs/files-backend.c          | 45 ++++++++++++++++++++++++
 t/t0602-reffiles-fsck.sh      | 66 +++++++++++++++++++++++++++++++++++
 4 files changed, 115 insertions(+)

diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
index 68a2801f15..22c385ea22 100644
--- a/Documentation/fsck-msgids.txt
+++ b/Documentation/fsck-msgids.txt
@@ -19,6 +19,9 @@
 `badParentSha1`::
 	(ERROR) A commit object has a bad parent sha1.
 
+`badRefContent`::
+	(ERROR) A ref has bad content.
+
 `badRefFiletype`::
 	(ERROR) A ref has a bad file type.
 
diff --git a/fsck.h b/fsck.h
index 500b4c04d2..0d99a87911 100644
--- a/fsck.h
+++ b/fsck.h
@@ -31,6 +31,7 @@ enum fsck_msg_type {
 	FUNC(BAD_NAME, ERROR) \
 	FUNC(BAD_OBJECT_SHA1, ERROR) \
 	FUNC(BAD_PARENT_SHA1, ERROR) \
+	FUNC(BAD_REF_CONTENT, ERROR) \
 	FUNC(BAD_REF_FILETYPE, ERROR) \
 	FUNC(BAD_REF_NAME, ERROR) \
 	FUNC(BAD_TIMEZONE, ERROR) \
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 57318b4c4e..35b3fa983e 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3504,6 +3504,50 @@ typedef int (*files_fsck_refs_fn)(struct ref_store *ref_store,
 				  const char *refs_check_dir,
 				  struct dir_iterator *iter);
 
+static int files_fsck_refs_content(struct ref_store *ref_store,
+				   struct fsck_options *o,
+				   const char *refs_check_dir,
+				   struct dir_iterator *iter)
+{
+	struct strbuf ref_content = STRBUF_INIT;
+	struct strbuf referent = STRBUF_INIT;
+	struct strbuf refname = STRBUF_INIT;
+	struct fsck_ref_report report = { 0 };
+	unsigned int type = 0;
+	int failure_errno = 0;
+	struct object_id oid;
+	int ret = 0;
+
+	strbuf_addf(&refname, "%s/%s", refs_check_dir, iter->relative_path);
+	report.path = refname.buf;
+
+	if (S_ISLNK(iter->st.st_mode))
+		goto cleanup;
+
+	if (strbuf_read_file(&ref_content, iter->path.buf, 0) < 0) {
+		ret = fsck_report_ref(o, &report,
+				      FSCK_MSG_BAD_REF_CONTENT,
+				      "cannot read ref file");
+		goto cleanup;
+	}
+
+	if (parse_loose_ref_contents(ref_store->repo->hash_algo,
+				     ref_content.buf, &oid, &referent,
+				     &type, &failure_errno)) {
+		strbuf_rtrim(&ref_content);
+		ret = fsck_report_ref(o, &report,
+				      FSCK_MSG_BAD_REF_CONTENT,
+				      "%s", ref_content.buf);
+		goto cleanup;
+	}
+
+cleanup:
+	strbuf_release(&refname);
+	strbuf_release(&ref_content);
+	strbuf_release(&referent);
+	return ret;
+}
+
 static int files_fsck_refs_name(struct ref_store *ref_store UNUSED,
 				struct fsck_options *o,
 				const char *refs_check_dir,
@@ -3586,6 +3630,7 @@ static int files_fsck_refs(struct ref_store *ref_store,
 {
 	files_fsck_refs_fn fsck_refs_fn[]= {
 		files_fsck_refs_name,
+		files_fsck_refs_content,
 		NULL,
 	};
 
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index 4c6cd6f7d0..628f9bcc46 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -148,4 +148,70 @@ test_expect_success 'ref name check should work for multiple worktrees' '
 	)
 '
 
+test_expect_success 'regular ref content should be checked (individual)' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	branch_dir_prefix=.git/refs/heads &&
+	tag_dir_prefix=.git/refs/tags &&
+	cd repo &&
+	test_commit default &&
+	mkdir -p "$branch_dir_prefix/a/b" &&
+
+	git refs verify 2>err &&
+	test_must_be_empty err &&
+
+	bad_content=$(git rev-parse main)x &&
+	printf "%s" $bad_content >$tag_dir_prefix/tag-bad-1 &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/tags/tag-bad-1: badRefContent: $bad_content
+	EOF
+	rm $tag_dir_prefix/tag-bad-1 &&
+	test_cmp expect err &&
+
+	bad_content=xfsazqfxcadas &&
+	printf "%s" $bad_content >$tag_dir_prefix/tag-bad-2 &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/tags/tag-bad-2: badRefContent: $bad_content
+	EOF
+	rm $tag_dir_prefix/tag-bad-2 &&
+	test_cmp expect err &&
+
+	bad_content=Xfsazqfxcadas &&
+	printf "%s" $bad_content >$branch_dir_prefix/a/b/branch-bad &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/heads/a/b/branch-bad: badRefContent: $bad_content
+	EOF
+	rm $branch_dir_prefix/a/b/branch-bad &&
+	test_cmp expect err
+'
+
+test_expect_success 'regular ref content should be checked (aggregate)' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	branch_dir_prefix=.git/refs/heads &&
+	tag_dir_prefix=.git/refs/tags &&
+	cd repo &&
+	test_commit default &&
+	mkdir -p "$branch_dir_prefix/a/b" &&
+
+	bad_content_1=$(git rev-parse main)x &&
+	bad_content_2=xfsazqfxcadas &&
+	bad_content_3=Xfsazqfxcadas &&
+	printf "%s" $bad_content_1 >$tag_dir_prefix/tag-bad-1 &&
+	printf "%s" $bad_content_2 >$tag_dir_prefix/tag-bad-2 &&
+	printf "%s" $bad_content_3 >$branch_dir_prefix/a/b/branch-bad &&
+
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/heads/a/b/branch-bad: badRefContent: $bad_content_3
+	error: refs/tags/tag-bad-1: badRefContent: $bad_content_1
+	error: refs/tags/tag-bad-2: badRefContent: $bad_content_2
+	EOF
+	sort err >sorted_err &&
+	test_cmp expect sorted_err
+'
+
 test_done
-- 
2.46.2

