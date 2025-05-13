Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DB8253F1B
	for <git@vger.kernel.org>; Tue, 13 May 2025 11:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747134356; cv=none; b=HE5PSljXkRPchrXlm5zlB58l7dJAKk+Zzh/SOLGIX8A97O/g38MpFobLHI3lpqjc53o1swMLEzOzJHMkZws5TTsOKuNDylsqb+QjG5NVXUpN0oOH57C3TL2Arh1B3odb5f/DbJ1g6S24yMU7+vsKc0lbbpBfPzWMiqW4B4MHry8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747134356; c=relaxed/simple;
	bh=2JYP0Y/WCGDgcvAty3oJd4uWQlOLtwIt/2s19qAsN2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nItvIx0sbUBXFDI2ZiZQ5iVXkISGHAkvQp+hNMlFsZ51IPplJCooKfcsZoQAmNaOtazaonj0UjrAcjEyQzjpNrkMifVIbcl22obmrkdIX/fKQg9ITuVzN6Dtd4Qjjm+4fNfHZ30Js8QXBu+Z1L8lqAcdLjhqyEyTFshHbhjouW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfQWF32R; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfQWF32R"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-74248a3359fso3295475b3a.2
        for <git@vger.kernel.org>; Tue, 13 May 2025 04:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747134353; x=1747739153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mtX7mM2XOLPT+20q/jHsrp9RPrIBt05rjLatlDYaYoQ=;
        b=dfQWF32RO6zc06R5/Nj5OJ0UIsUBOPj/mHfHNAnOanZXMx7Cgq1W/TGlGcIGWywW9u
         3NkxUUcJRb5GOcNdijMKIhtc89k6j2mlu0To13zmgqy2MGwLnTwkPDK1BlNXzVCnin8J
         YVpRP58RkH8jIcs/K7Tmli0W/SZxgAvMnhtdZEJrbEn9WK83MJ1xnZ8nTNoC2fgSiWiH
         wufQPGzpsDp30cdVVrliBIvtZXbKVuNppxBinlCVfQd8F/bqNccLSN25e9M1weTztyKX
         p6i5WlNEKwWf09qXtjHzrLzeDD3Bh0CrK2CdDX2rAyzdnz1/aGMzzN3dUF2WJGKipP4S
         zPJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747134353; x=1747739153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mtX7mM2XOLPT+20q/jHsrp9RPrIBt05rjLatlDYaYoQ=;
        b=M6HbARCurhvepfeKRY3H6uN5b+C1iquYsUC5h5fIHo8itqsMk88YxlpCakt3PYUMcO
         SSdPhuZl2TbirzB5FMq/5TqiSve1v08ZCc04kYUqsEgTsfwNDY5ixdrufap3KahBaTZE
         NN0zmj5w1+Yf2L4xoT63LEHW2Nn8t7XOKpGloRuBrJP5AisuHOjMLyX2NIN637gttspl
         /x6AwS6NW6Zy54+Z8EWXt/aLbuENIMhTc1ofuhVuVs7n/puSqLWm1hP5jr4zljhpJ7+u
         hwBimDHdNqPaAeC4NP/Ady02qrtTLwYvfdxuabwXtDXzwzP0YDiLcKNQWvsZK88HCWeG
         MG7Q==
X-Gm-Message-State: AOJu0YyCYUQhOdgQNeyVwVXDuIf9tKTQiQQu0dqxWMzYWjscxpIaonxC
	Vvymy2ReDWW7QHZowci+wA73CWBtBNxKd82lj4ZxvGEnbT08GI8WNfuVuQ==
X-Gm-Gg: ASbGnctuhXqWFRAE7ly3/wIDqSm8BLv0m8SmUtB8ze1hRO4dWAx8fWJjWQQRkeJcqxV
	EyNcdDevPMMGdsxZF5x60x5+CF6vjJK+Jt630aXOJLPRlpjDvMUFqeBHT9Z/rYldcBME+GSpYJr
	yDRz+9UGTFbTH9Knn+L+cLD/QDfE1kVLWAfuv86O2Wu+0TJQdAWppW+dOg9A/6NitU0PUrsvT1W
	xFFEDdMjV9ryVNuG683K0lKy3SLAYYKUN+06FhrxnnGiwITb//2mivy6kRRXBN0PaC6rWp8/yJB
	ed22hAzERaFGbGiztfJDlTudr1AytTolfYPrmwRnFoCaqFE=
X-Google-Smtp-Source: AGHT+IGFUtGWmNcqb/jI20y8KCgZrc/vuagDdjHI0x8GqvhcYPfI2wqweGiwqwKfmtDVRAGnUVLYPQ==
X-Received: by 2002:a05:6a21:1507:b0:215:ef08:5555 with SMTP id adf61e73a8af0-215ef0855famr2878803637.11.1747134353353;
        Tue, 13 May 2025 04:05:53 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b2349325e16sm7222478a12.1.2025.05.13.04.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 04:05:52 -0700 (PDT)
Date: Tue, 13 May 2025 19:06:23 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 0/3] align the behavior when opening "packed-refs"
Message-ID: <aCMnrwkoJ2WyqGZT@ArchLinux>
References: <aCCtQDnWII-knmEc@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCCtQDnWII-knmEc@ArchLinux>

Hi All:

As discussed in [1], we need to use mmap mechanism to open large
"packed_refs" file to save the memory usage. This patch mainly does the
following things:

1: Fix an issue that we would report an error when the "packed-refs"
file is empty, which does not align with the runtime behavior.
2-4: Extract some logic from the existing code and then use these
created helper functions to let fsck code to use mmap necessarily

[1] https://lore.kernel.org/git/20250503133158.GA4450@coredump.intra.peff.net

Really thank Peff and Patrick to suggest me to do above change.

---

Change in v2:

1. Update the commit message of [PATCH 1/4]. And use redirection to
create an empty file instead of using `touch`.
2. Don't use if for the refactored function in [PATCH 3/4] and then
update the commit message to align with the new function name.
3. Enhance the commit message of [PATCH 4/4].

---

Change in v3:

1. Drop the patch which creates a new function
"munmap_temporary_snapshot". As discussed, there is no need to munmap
the file during fsck.
2. Allocate snapshot variable in the stack instead of heap.
3. Fix rebase issue, remove unneeded code to check the file size
explicitly.

---

Change in v4:

1. Report the "emptyPackedRefsFile(INFO)" to the user when the
"packed-refs" is empty instead of ONLY skipping checking the content and
update the shell script and commit message.
2. Apply Peff's advice to make [PATCH v3 2/3] more clear.


Thanks,
Jialuo

shejialuo (3):
  packed-backend: fsck should warn when "packed-refs" file is empty
  packed-backend: extract snapshot allocation in `load_contents`
  packed-backend: mmap large "packed-refs" file during fsck

 Documentation/fsck-msgids.adoc |  6 +++
 fsck.h                         |  1 +
 refs/packed-backend.c          | 73 ++++++++++++++++++++--------------
 t/t0602-reffiles-fsck.sh       | 17 ++++++++
 4 files changed, 67 insertions(+), 30 deletions(-)

Range-diff against v3:
1:  26c3fd55a8 ! 1:  75636c9c85 packed-backend: fsck should allow an empty "packed-refs" file
    @@ Metadata
     Author: shejialuo <shejialuo@gmail.com>
     
      ## Commit message ##
    -    packed-backend: fsck should allow an empty "packed-refs" file
    +    packed-backend: fsck should warn when "packed-refs" file is empty
     
         During fsck, an empty "packed-refs" gives an error; this is unwarranted.
    -    We should just skip checking the content of "packed-refs" just like the
    -    runtime code paths such as "create_snapshot" which simply returns the
    -    "snapshot" without checking the content of "packed-refs".
    +    The runtime code paths would accept an empty "packed-refs" file, such as
    +    "create_snapshot" would simply return the "snapshot" without checking
    +    the content of "packed-refs".
    +
    +    And we should also skip checking the content of "packed-refs" when it is
    +    empty during fsck. However, we should think about whether we need to
    +    report something to the users in this case.
    +
    +    After 694b7a1999 (repack_without_ref(): write peeled refs in the
    +    rewritten file, 2013-04-22), we would always write a header into the
    +    "packed-refs" file where we would never create empty file since then.
    +    Because we only create empty "packed-refs" in the very early versions,
    +    we may tighten this rule in the future. In order to notify the users
    +    about this, we should at least report an warning to the users.
    +
    +    But we need to consider the fsck message type carefully, it is not
    +    appropriate that we use "FSCK_ERROR". This is because we would
    +    definitely break the compatibility. Let's create a "FSCK_INFO" message
    +    id EMPTY_PACKED_REFS_FILE" to indicate that "packed-refs" is empty.
     
         Signed-off-by: shejialuo <shejialuo@gmail.com>
     
    + ## Documentation/fsck-msgids.adoc ##
    +@@
    + `emptyName`::
    + 	(WARN) A path contains an empty name.
    + 
    ++`emptyPackedRefsFile`::
    ++	(INFO) "packed-refs" file is empty. Report to the
    ++	git@vger.kernel.org mailing list if you see this error. As only
    ++	very early versions of Git would create such an empty
    ++	"packed_refs" file, we might tighten this rule in the future.
    ++
    + `extraHeaderEntry`::
    + 	(IGNORE) Extra headers found after `tagger`.
    + 
    +
    + ## fsck.h ##
    +@@ fsck.h: enum fsck_msg_type {
    + 	FUNC(LARGE_PATHNAME, WARN) \
    + 	/* infos (reported as warnings, but ignored by default) */ \
    + 	FUNC(BAD_FILEMODE, INFO) \
    ++	FUNC(EMPTY_PACKED_REFS_FILE, INFO) \
    + 	FUNC(GITMODULES_PARSE, INFO) \
    + 	FUNC(GITIGNORE_SYMLINK, INFO) \
    + 	FUNC(GITATTRIBUTES_SYMLINK, INFO) \
    +
      ## refs/packed-backend.c ##
     @@ refs/packed-backend.c: static int packed_fsck(struct ref_store *ref_store,
      		goto cleanup;
      	}
      
    -+	if (!st.st_size)
    ++	if (!st.st_size) {
    ++		struct fsck_ref_report report = { 0 };
    ++		report.path = "packed-refs";
    ++		ret = fsck_report_ref(o, &report,
    ++				      FSCK_MSG_EMPTY_PACKED_REFS_FILE,
    ++				      "file is empty");
     +		goto cleanup;
    ++	}
     +
      	if (strbuf_read(&packed_ref_content, fd, 0) < 0) {
      		ret = error_errno(_("unable to read '%s'"), refs->path);
    @@ t/t0602-reffiles-fsck.sh: test_expect_success SYMLINKS 'the filetype of packed-r
      	)
      '
      
    -+test_expect_success 'empty packed-refs should not be reported' '
    ++test_expect_success 'empty packed-refs should be reported' '
     +	test_when_finished "rm -rf repo" &&
     +	git init repo &&
     +	(
    @@ t/t0602-reffiles-fsck.sh: test_expect_success SYMLINKS 'the filetype of packed-r
     +
     +		>.git/packed-refs &&
     +		git refs verify 2>err &&
    -+		test_must_be_empty err
    ++		cat >expect <<-EOF &&
    ++		warning: packed-refs: emptyPackedRefsFile: file is empty
    ++		EOF
    ++		rm .git/packed-refs &&
    ++		test_cmp expect err
     +	)
     +'
     +
2:  4604be8b51 ! 2:  1a5893379d packed-backend: extract snapshot allocation in `load_contents`
    @@ refs/packed-backend.c: static int refname_contains_nul(struct strbuf *refname)
      	struct stat st;
     -	size_t size;
     -	ssize_t bytes_read;
    -+	int ret = 1;
    ++	int ret;
     +	int fd;
      
      	fd = open(snapshot->refs->path, O_RDONLY);
    @@ refs/packed-backend.c: static int load_contents(struct snapshot *snapshot)
      
     -	snapshot->start = snapshot->buf;
     -	snapshot->eof = snapshot->buf + size;
    -+	if (!allocate_snapshot_buffer(snapshot, fd, &st))
    -+		ret = 0;
    ++	ret = allocate_snapshot_buffer(snapshot, fd, &st);
      
     -	return 1;
     +	close(fd);
3:  82e19a65c6 ! 3:  31e272db7e packed-backend: mmap large "packed-refs" file during fsck
    @@ refs/packed-backend.c: static int packed_fsck(struct ref_store *ref_store,
      		goto cleanup;
      	}
      
    --	if (!st.st_size)
    -+	if (!allocate_snapshot_buffer(&snapshot, fd, &st))
    +-	if (!st.st_size) {
    ++	if (!allocate_snapshot_buffer(&snapshot, fd, &st)) {
    + 		struct fsck_ref_report report = { 0 };
    + 		report.path = "packed-refs";
    + 		ret = fsck_report_ref(o, &report,
    +@@ refs/packed-backend.c: static int packed_fsck(struct ref_store *ref_store,
      		goto cleanup;
    + 	}
      
     -	if (strbuf_read(&packed_ref_content, fd, 0) < 0) {
     -		ret = error_errno(_("unable to read '%s'"), refs->path);
-- 
2.49.0

