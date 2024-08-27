Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B1517C69
	for <git@vger.kernel.org>; Tue, 27 Aug 2024 16:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724774596; cv=none; b=rOdKjaGitf8If9Vd1F1ofGieZUQhWSZkpCt68LZz3L5D2r/M7FUgWsvY/2Md69jLRvFGUPbaKpuDuPDzXfWXFX5YLg1AuhCOv2r6h+LN0yPPcTgwLBzxDqQ19SUvZ5hzmD7lyxPu++so7z3tCiEYLvwKWXFaibwmDBi6rOV+jC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724774596; c=relaxed/simple;
	bh=gDf8DM/iK7+u3PbYmmlTzVgCdg+9L1Q6WdLcvbVF0pE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFHBx8OVK8gs5MP3/etqjPjcB+lcdN9vR4IWewbQAP8/E7lsNTdoBJKQQsPl2pQZuyXSJLomtqruuGppY3jg0SnCwXXMwY59HMQQL/iSqC7zlty6uCnPmkSOveqoPb02r5FTgUGqZA64WlNkka/gNVjgICCZswDrx3tAKBvqZ2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYEHVgM4; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYEHVgM4"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-714287e4083so5096456b3a.2
        for <git@vger.kernel.org>; Tue, 27 Aug 2024 09:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724774593; x=1725379393; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5M1HGaKZB6XU3fXuw29OPjliRDksspRHVMLxYT1ks8=;
        b=MYEHVgM4kGGniOKDTlZ4VM0S7cqZKGuMIZXqK6y1Qlbyvw8JVU9+PK9ZgpBf8Kebq5
         oKSIvMX/+rxqpeeC4eAJI8RfriRCu2pTltC/W8N9M4j/mEb4r92gNTyB7OuCObxAtYjR
         oIG0Hn9KCENoHCkxIxm52KrNMaB+8HtEgNMp9Ig07SkkR+I6DFXe+tskUq8MakQdPcv5
         JpirXB73KAzEJZuJVn+d32eqrexUKfojugVF8gmGWaCEQFRhUrcUqWTSaN0U370vw2LK
         +rGxDFFDFDKXftnIAwgvSzyclMT83GaxujUTYH8iuxEcKEynI+jPu48h+igNjazn4287
         OnHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724774593; x=1725379393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5M1HGaKZB6XU3fXuw29OPjliRDksspRHVMLxYT1ks8=;
        b=dEIJbQl1ft+0qnXWUAO8ijusRRKR6QI1nk/EzO/dJGw1naoy0S8ZUXM/PdUFYiqiPZ
         9Yo4gpy2cf8BH0bGrJFDg8snfBxGLMyDMk+9k/L4CnlK8UH4SQUA18lDK3TuieCCE2Df
         DugjInXfoqdg5sbJqNqUuJkr8QYV7bDFvbp9BG7Ge4Ti0fJ6zKafNhbQR2O6yc+hCkeh
         JCzPXmw7kQqizZdnr3jthdXTWEgLWuSG7EPcT/i2JfrU+OvWjDaZeluvgpEqEvMvuBqJ
         Q/+D2irBrbRpdA5bUFRh/+5k4b1sn/BbuLnh1f3gkNs24WlD2LwQ79aw8L2Mfk9RRWDm
         Yf1w==
X-Gm-Message-State: AOJu0YzfuOI42avQBAWoKe5sNWl9tVkTLswzw0TC/GAuRziD9JsJZHhc
	O0Ry2sZOlA8LqCSZapGomKTgRswVMELnCA+d5UqK0tIXFbKIFvIH1QYyzA==
X-Google-Smtp-Source: AGHT+IHVrdxdzyhp2nvBqJRIQeOcChscyDeXaiTWOI57bWYie3RTy4+Df3h3qVaekvOpiTsDagZFog==
X-Received: by 2002:a05:6a21:6b0c:b0:1c3:acd1:5cdd with SMTP id adf61e73a8af0-1cc8b615c35mr13979851637.47.1724774592486;
        Tue, 27 Aug 2024 09:03:12 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ad5589asm9381530a12.67.2024.08.27.09.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 09:03:11 -0700 (PDT)
Date: Wed, 28 Aug 2024 00:04:02 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/4] add ref content check for files backend
Message-ID: <Zs348uXMBdCuwF-2@ArchLinux>
References: <ZsIMc6cJ-kzMzW_8@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsIMc6cJ-kzMzW_8@ArchLinux>

Hi All:

This new version handles the following reviews:

1. According to the advice from the Junio, we should just use "{0}" to
initialize the zero structure "fsck_ref_report". This version handles
this in [PATCH v2 1/4].
2. According to the advice from the Patrick, use "strrchr" instead of
looping to make the code more clean in [PATCH v2 3/4].
3. Use "goto" to remove ident.

However, the most important thing for this patch is which fsck message
type I choose. I have recorded the reason in the commit message. But I
wanna explain the motivation in cover letter for making the reviewers
easy to understand.

Actually, in the review process of the first version. Junio thought we
should use "FSCK_INFO" and Patrick thought we should use "FSCK_WARN".
And I raised a question here, what is the difference between the
"FSCK_INFO" and "FSCK_WARN" because in "fsck.c::fsck_vreport" function,
we will convert "FSCK_INFO" to "FSCK_WARN" like the following:

    static int fsck_vreport(...)
    {
        enum fsck_msg_type msg_type = fsck_msg_type(msg_id, options);

        if (msg_type == FSCK_FATAL)
            msg_type = FSCK_ERROR;
        if (msg_type == FSCK_INFO)
             msg_type = FSCK_WARN;
        ...
    }

And I have gone back to the history. Actually the first time the fsck
message type was set up at f27d05b170 (fsck: allow upgrading fsck
warnings to errors, 2015-06-22):

  https://lore.kernel.org/git/cover.1418055173.git.johannes.schindelin@gmx.de/

And I have understood why we need "FSCK_INFO". This is because when
setting the "strict" filed in "fsck_options", all the fsck warns will
become fsck errors. For example, this change verifies my thinking:
4dd3b045f5 (fsck: downgrade tree badFilemode to "info", 2022-08-10).

As you can see, this restriction makes the code safer. So, I agree with
Junio, at now, we should use "FSCK_INFO" for trailing garbage and ref
content ends without newline.

But we should report fsck errors for the following two situations for
"git-fsck(1)" will report fsck errors by implicitly checking the ref
database consistency.

1. "parse_loose_ref_contents" fail.
2. symref content is bad (cannot parse).

Thanks,
Jialuo

shejialuo (4):
  ref: initialize "fsck_ref_report" with zero
  ref: add regular ref content check for files backend
  ref: add symbolic ref content check for files backend
  ref: add symlink ref check for files backend

 Documentation/fsck-msgids.txt |  12 +++
 fsck.h                        |   4 +
 refs.c                        |   2 +-
 refs/files-backend.c          | 179 +++++++++++++++++++++++++++++++-
 refs/refs-internal.h          |   2 +-
 t/t0602-reffiles-fsck.sh      | 185 ++++++++++++++++++++++++++++++++++
 6 files changed, 379 insertions(+), 5 deletions(-)

Range-diff against v1:
1:  9ed3026ac5 ! 1:  0367904c81 fsck: introduce "FSCK_REF_REPORT_DEFAULT" macro
    @@ Metadata
     Author: shejialuo <shejialuo@gmail.com>
     
      ## Commit message ##
    -    fsck: introduce "FSCK_REF_REPORT_DEFAULT" macro
    +    ref: initialize "fsck_ref_report" with zero
     
         In "fsck.c::fsck_refs_error_function", we need to tell whether "oid" and
         "referent" is NULL. So, we need to always initialize these parameters to
         NULL instead of letting them point to anywhere when creating a new
         "fsck_ref_report" structure.
     
    -    In order to conveniently create a new "fsck_ref_report", add a new macro
    -    "FSCK_REF_REPORT_DEFAULT".
    +    The original code explicitly specifies the ".path" field to initialize
    +    the "fsck_ref_report" structure. However, it introduces confusion how we
    +    initialize the other fields. In order to avoid this, initialize the
    +    "fsck_ref_report" with zero to make clear that everything in
    +    "fsck_ref_report" is zero initialized.
     
         Mentored-by: Patrick Steinhardt <ps@pks.im>
         Mentored-by: Karthik Nayak <karthik.188@gmail.com>
         Signed-off-by: shejialuo <shejialuo@gmail.com>
     
    - ## fsck.h ##
    -@@ fsck.h: struct fsck_ref_report {
    - 	const char *referent;
    - };
    - 
    -+#define FSCK_REF_REPORT_DEFAULT { \
    -+	.path = NULL, \
    -+	.oid = NULL, \
    -+	.referent = NULL, \
    -+}
    -+
    - struct fsck_options {
    - 	fsck_walk_func walk;
    - 	fsck_error error_func;
    -
      ## refs/files-backend.c ##
     @@ refs/files-backend.c: static int files_fsck_refs_name(struct ref_store *ref_store UNUSED,
      		goto cleanup;
      
      	if (check_refname_format(iter->basename, REFNAME_ALLOW_ONELEVEL)) {
     -		struct fsck_ref_report report = { .path = NULL };
    -+		struct fsck_ref_report report = FSCK_REF_REPORT_DEFAULT;
    ++		struct fsck_ref_report report = {0};
      
      		strbuf_addf(&sb, "%s/%s", refs_check_dir, iter->relative_path);
      		report.path = sb.buf;
2:  714284cf2b ! 2:  7b6f4145cd ref: add regular ref content check for files backend
    @@ Metadata
      ## Commit message ##
         ref: add regular ref content check for files backend
     
    -    We implicitly reply on "git-fsck(1)" to check the consistency of regular
    -    refs. However, when parsing the regular refs for files backend, we allow
    -    the ref content to end with no newline or contain some garbages. We
    -    should warn the user about above situations.
    +    We implicitly rely on "git-fsck(1)" to check the consistency of regular
    +    refs. However, when parsing the regular refs for files backend by using
    +    "files-backend.c::parse_loose_ref_contents", we allow the ref content to
    +    be end with no newline or contain some garbages.
     
    -    In order to provide above functionality, enhance the "git-refs verify"
    -    command by adding consistency check for regular refs for files backend.
    +    It may seem that we should report an error or warn fsck message to the
    +    user about above situations. However, there may be some third-party
    +    tools customizing the content of refs. We should not report an error
    +    fsck message.
     
    -    Add the following three fsck messages to represent the above situations:
    +    And we cannot either report a warn fsck message to the user. This is
    +    because for "git-receive-pack(1)" and "git-fetch-pack(1)", they will
    +    parse the fsck message type and check the message type by
    +    "fsck.c::is_valid_msg_type". Only the fsck infos are not valid. If we
    +    make the fsck message type to be warn, the user could upgrade the fsck
    +    warnings to errors. And the user can also set the "strict" field in
    +    "fsck_options" to upgrade the fsck warnings to errors.
     
    -    1. "badRefContent(ERROR)": A ref has a bad content.
    -    2. "refMissingNewline(WARN)": A valid ref does not end with newline.
    -    3. "trailingRefContent(WARN)": A ref has trailing contents.
    +    We should not allow the user to upgrade the fsck warnings to errors. It
    +    might cause compatibility issue which will break the legacy repository.
    +    So we add the following two fsck infos to represent the situation where
    +    the ref content ends without newline or has garbages:
    +
    +    1. "refMissingNewline(INFO)": A valid ref does not end with newline.
    +    2. "trailingRefContent(INFO)": A ref has trailing contents.
    +
    +    In "fsck.c::fsck_vreport", we will convert "FSCK_INFO" to "FSCK_WARN",
    +    and we can still warn the user about these situations when using
    +    "git-refs verify" without introducing compatibility issue.
    +
    +    In current "git-fsck(1)", it will report an error when the ref content
    +    is bad, so we should following this to report an error to the user when
    +    "parse_loose_ref_contents" fails. And we add a new fsck error message
    +    called "badRefContent(ERROR)" to represent that a ref has a bad content.
     
         In order to tell whether the ref has trailing content, add a new
         parameter "trailing" to "parse_loose_ref_contents". Then introduce a new
    -    function "files_fsck_refs_content" to check the regular refs.
    +    function "files_fsck_refs_content" to check the regular refs to enhance
    +    the "git-refs verify".
     
         Mentored-by: Patrick Steinhardt <ps@pks.im>
         Mentored-by: Karthik Nayak <karthik.188@gmail.com>
    @@ Documentation/fsck-msgids.txt
      	(WARN) Tree contains entries pointing to a null sha1.
      
     +`refMissingNewline`::
    -+	(WARN) A valid ref does not end with newline.
    ++	(INFO) A valid ref does not end with newline.
     +
     +`trailingRefContent`::
    -+	(WARN) A ref has trailing contents.
    ++	(INFO) A ref has trailing contents.
     +
      `treeNotSorted`::
      	(ERROR) A tree is not properly sorted.
    @@ fsck.h: enum fsck_msg_type {
      	FUNC(BAD_REF_NAME, ERROR) \
      	FUNC(BAD_TIMEZONE, ERROR) \
     @@ fsck.h: enum fsck_msg_type {
    - 	FUNC(HAS_DOTDOT, WARN) \
    - 	FUNC(HAS_DOTGIT, WARN) \
    - 	FUNC(NULL_SHA1, WARN) \
    -+	FUNC(REF_MISSING_NEWLINE, WARN) \
    -+	FUNC(TRAILING_REF_CONTENT, WARN) \
    - 	FUNC(ZERO_PADDED_FILEMODE, WARN) \
    - 	FUNC(NUL_IN_COMMIT, WARN) \
    - 	FUNC(LARGE_PATHNAME, WARN) \
    + 	FUNC(MAILMAP_SYMLINK, INFO) \
    + 	FUNC(BAD_TAG_NAME, INFO) \
    + 	FUNC(MISSING_TAGGER_ENTRY, INFO) \
    ++	FUNC(REF_MISSING_NEWLINE, INFO) \
    ++	FUNC(TRAILING_REF_CONTENT, INFO) \
    + 	/* ignored (elevated when requested) */ \
    + 	FUNC(EXTRA_HEADER_ENTRY, IGNORE)
    + 
     
      ## refs.c ##
     @@ refs.c: static int refs_read_special_head(struct ref_store *ref_store,
    @@ refs/files-backend.c: typedef int (*files_fsck_refs_fn)(struct ref_store *ref_st
     +				   const char *refs_check_dir,
     +				   struct dir_iterator *iter)
     +{
    -+	struct fsck_ref_report report = FSCK_REF_REPORT_DEFAULT;
     +	struct strbuf ref_content = STRBUF_INIT;
     +	struct strbuf referent = STRBUF_INIT;
     +	struct strbuf refname = STRBUF_INIT;
    ++	struct fsck_ref_report report = {0};
     +	const char *trailing = NULL;
     +	unsigned int type = 0;
     +	int failure_errno = 0;
    @@ refs/files-backend.c: typedef int (*files_fsck_refs_fn)(struct ref_store *ref_st
     +		}
     +
     +		if (parse_loose_ref_contents(ref_store->repo->hash_algo,
    -+					    ref_content.buf, &oid, &referent,
    -+					    &type, &trailing, &failure_errno)) {
    ++					     ref_content.buf, &oid, &referent,
    ++					     &type, &trailing, &failure_errno)) {
     +			ret = fsck_report_ref(o, &report,
     +					      FSCK_MSG_BAD_REF_CONTENT,
     +					      "invalid ref content");
    @@ refs/files-backend.c: typedef int (*files_fsck_refs_fn)(struct ref_store *ref_st
     +				goto cleanup;
     +			}
     +		}
    ++		goto cleanup;
     +	}
     +
     +cleanup:
3:  032b0d6a64 ! 3:  20d8556902 ref: add symbolic ref content check for files backend
    @@ Commit message
         3. "ref: refs/heads/master\n\n"
     
         But we do not allow any non-null trailing garbage. The following are bad
    -    symbolic contents.
    +    symbolic contents which will be reported as fsck error by "git-fsck(1)".
     
         1. "ref: refs/heads/master garbage\n"
         2. "ref: refs/heads/master \n\n\n garbage  "
     
    -    In order to provide above checks, we will traverse the "pointee" to
    -    report the user whether this is null-garbage or no newline. And if
    -    symbolic refs contain non-null garbage, we will report
    -    "FSCK_MSG_BAD_REF_CONTENT" to the user.
    -
    -    Then, we will check the name of the "pointee" is correct by using
    -    "check_refname_format". And then if we can access the "pointee_path" in
    -    the file system, we should ensure that the file type is correct.
    +    In order to provide above checks, we will use "strrchr" to check whether
    +    we have newline in the ref content. Then we will check the name of the
    +    "pointee" is correct by using "check_refname_format". If the function
    +    fails, we need to trim the "pointee" to see whether the null-garbage
    +    causes the function fails. If so, we need to report that there is
    +    null-garbage in the symref content. Otherwise, we should report the user
    +    the "pointee" is bad.
     
         Mentored-by: Patrick Steinhardt <ps@pks.im>
         Mentored-by: Karthik Nayak <karthik.188@gmail.com>
    @@ refs/files-backend.c: typedef int (*files_fsck_refs_fn)(struct ref_store *ref_st
     +				    struct strbuf *pointee_name,
     +				    struct strbuf *pointee_path)
     +{
    -+	unsigned int newline_num = 0;
    -+	unsigned int space_num = 0;
    ++	const char *newline_pos = NULL;
     +	const char *p = NULL;
     +	struct stat st;
     +	int ret = 0;
    @@ refs/files-backend.c: typedef int (*files_fsck_refs_fn)(struct ref_store *ref_st
     +		goto out;
     +	}
     +
    -+	while (*p != '\0') {
    -+		if ((space_num || newline_num) && !isspace(*p)) {
    -+			ret = fsck_report_ref(o, report,
    -+					      FSCK_MSG_BAD_REF_CONTENT,
    -+					      "contains non-null garbage");
    -+			goto out;
    -+		}
    -+
    -+		if (*p == '\n') {
    -+			newline_num++;
    -+		} else if (*p == ' ') {
    -+			space_num++;
    -+		}
    -+		p++;
    -+	}
    -+
    -+	if (space_num || newline_num > 1) {
    -+		ret = fsck_report_ref(o, report,
    -+				      FSCK_MSG_TRAILING_REF_CONTENT,
    -+				      "trailing null-garbage");
    -+	} else if (!newline_num) {
    ++	newline_pos = strrchr(p, '\n');
    ++	if (!newline_pos || *(newline_pos + 1)) {
     +		ret = fsck_report_ref(o, report,
     +				      FSCK_MSG_REF_MISSING_NEWLINE,
     +				      "missing newline");
     +	}
     +
    -+	strbuf_rtrim(pointee_name);
    -+
     +	if (check_refname_format(pointee_name->buf, 0)) {
    ++		/*
    ++		 * When containing null-garbage, "check_refname_format" will
    ++		 * fail, we should trim the "pointee" to check again.
    ++		 */
    ++		strbuf_rtrim(pointee_name);
    ++		if (!check_refname_format(pointee_name->buf, 0)) {
    ++			ret = fsck_report_ref(o, report,
    ++					      FSCK_MSG_TRAILING_REF_CONTENT,
    ++					      "trailing null-garbage");
    ++			goto out;
    ++		}
    ++
     +		ret = fsck_report_ref(o, report,
     +				      FSCK_MSG_BAD_SYMREF_POINTEE,
     +				      "points to refname with invalid format");
    @@ refs/files-backend.c: typedef int (*files_fsck_refs_fn)(struct ref_store *ref_st
      				   const char *refs_check_dir,
      				   struct dir_iterator *iter)
      {
    - 	struct fsck_ref_report report = FSCK_REF_REPORT_DEFAULT;
     +	struct strbuf pointee_path = STRBUF_INIT;
      	struct strbuf ref_content = STRBUF_INIT;
      	struct strbuf referent = STRBUF_INIT;
    @@ refs/files-backend.c: static int files_fsck_refs_content(struct ref_store *ref_s
     +						       &referent,
     +						       &pointee_path);
      		}
    + 		goto cleanup;
      	}
    - 
     @@ refs/files-backend.c: static int files_fsck_refs_content(struct ref_store *ref_store,
      	strbuf_release(&refname);
      	strbuf_release(&ref_content);
    @@ t/t0602-reffiles-fsck.sh: test_expect_success 'regular ref content should be che
     +	printf "ref: refs/heads/branch     " > $branch_dir_prefix/a/b/branch-trailing &&
     +	git refs verify 2>err &&
     +	cat >expect <<-EOF &&
    ++	warning: refs/heads/a/b/branch-trailing: refMissingNewline: missing newline
     +	warning: refs/heads/a/b/branch-trailing: trailingRefContent: trailing null-garbage
     +	EOF
     +	rm $branch_dir_prefix/a/b/branch-trailing &&
    @@ t/t0602-reffiles-fsck.sh: test_expect_success 'regular ref content should be che
     +	printf "ref: refs/heads/branch \n\n " > $branch_dir_prefix/a/b/branch-trailing &&
     +	git refs verify 2>err &&
     +	cat >expect <<-EOF &&
    ++	warning: refs/heads/a/b/branch-trailing: refMissingNewline: missing newline
     +	warning: refs/heads/a/b/branch-trailing: trailingRefContent: trailing null-garbage
     +	EOF
     +	rm $branch_dir_prefix/a/b/branch-trailing &&
4:  147a873958 ! 4:  d9867c5f87 ref: add symlink ref consistency check for files backend
    @@ Metadata
     Author: shejialuo <shejialuo@gmail.com>
     
      ## Commit message ##
    -    ref: add symlink ref consistency check for files backend
    +    ref: add symlink ref check for files backend
     
         We have already introduced "files_fsck_symref_target". We should reuse
         this function to handle the symrefs which are legacy symbolic links. We
    @@ refs/files-backend.c: typedef int (*files_fsck_refs_fn)(struct ref_store *ref_st
     +				    struct strbuf *pointee_path,
     +				    unsigned int symbolic_link)
      {
    - 	unsigned int newline_num = 0;
    - 	unsigned int space_num = 0;
    + 	const char *newline_pos = NULL;
    + 	const char *p = NULL;
     @@ refs/files-backend.c: static int files_fsck_symref_target(struct fsck_options *o,
      		goto out;
      	}
      
    --	while (*p != '\0') {
    --		if ((space_num || newline_num) && !isspace(*p)) {
    --			ret = fsck_report_ref(o, report,
    --					      FSCK_MSG_BAD_REF_CONTENT,
    --					      "contains non-null garbage");
    --			goto out;
    +-	newline_pos = strrchr(p, '\n');
    +-	if (!newline_pos || *(newline_pos + 1)) {
    +-		ret = fsck_report_ref(o, report,
    +-				      FSCK_MSG_REF_MISSING_NEWLINE,
    +-				      "missing newline");
     +	if (!symbolic_link) {
    -+		while (*p != '\0') {
    -+			if ((space_num || newline_num) && !isspace(*p)) {
    -+				ret = fsck_report_ref(o, report,
    -+						      FSCK_MSG_BAD_REF_CONTENT,
    -+						      "contains non-null garbage");
    -+				goto out;
    -+			}
    -+
    -+			if (*p == '\n') {
    -+				newline_num++;
    -+			} else if (*p == ' ') {
    -+				space_num++;
    -+			}
    -+			p++;
    - 		}
    - 
    --		if (*p == '\n') {
    --			newline_num++;
    --		} else if (*p == ' ') {
    --			space_num++;
    -+		if (space_num || newline_num > 1) {
    -+			ret = fsck_report_ref(o, report,
    -+					      FSCK_MSG_TRAILING_REF_CONTENT,
    -+					      "trailing null-garbage");
    -+		} else if (!newline_num) {
    ++		newline_pos = strrchr(p, '\n');
    ++		if (!newline_pos || *(newline_pos + 1)) {
     +			ret = fsck_report_ref(o, report,
     +					      FSCK_MSG_REF_MISSING_NEWLINE,
     +					      "missing newline");
    - 		}
    --		p++;
    --	}
    - 
    --	if (space_num || newline_num > 1) {
    --		ret = fsck_report_ref(o, report,
    --				      FSCK_MSG_TRAILING_REF_CONTENT,
    --				      "trailing null-garbage");
    --	} else if (!newline_num) {
    --		ret = fsck_report_ref(o, report,
    --				      FSCK_MSG_REF_MISSING_NEWLINE,
    --				      "missing newline");
    -+		strbuf_rtrim(pointee_name);
    ++		}
      	}
      
    --	strbuf_rtrim(pointee_name);
    --
      	if (check_refname_format(pointee_name->buf, 0)) {
    +-		/*
    +-		 * When containing null-garbage, "check_refname_format" will
    +-		 * fail, we should trim the "pointee" to check again.
    +-		 */
    +-		strbuf_rtrim(pointee_name);
    +-		if (!check_refname_format(pointee_name->buf, 0)) {
    +-			ret = fsck_report_ref(o, report,
    +-					      FSCK_MSG_TRAILING_REF_CONTENT,
    +-					      "trailing null-garbage");
    +-			goto out;
    ++		if (!symbolic_link) {
    ++			/*
    ++			* When containing null-garbage, "check_refname_format" will
    ++			* fail, we should trim the "pointee" to check again.
    ++			*/
    ++			strbuf_rtrim(pointee_name);
    ++			if (!check_refname_format(pointee_name->buf, 0)) {
    ++				ret = fsck_report_ref(o, report,
    ++						      FSCK_MSG_TRAILING_REF_CONTENT,
    ++						      "trailing null-garbage");
    ++				goto out;
    ++			}
    + 		}
    + 
      		ret = fsck_report_ref(o, report,
    - 				      FSCK_MSG_BAD_SYMREF_POINTEE,
     @@ refs/files-backend.c: static int files_fsck_refs_content(struct ref_store *ref_store,
    - 	struct fsck_ref_report report = FSCK_REF_REPORT_DEFAULT;
    + {
      	struct strbuf pointee_path = STRBUF_INIT;
      	struct strbuf ref_content = STRBUF_INIT;
     +	struct strbuf abs_gitdir = STRBUF_INIT;
      	struct strbuf referent = STRBUF_INIT;
      	struct strbuf refname = STRBUF_INIT;
    + 	struct fsck_ref_report report = {0};
    ++	const char *pointee_name = NULL;
     +	unsigned int symbolic_link = 0;
      	const char *trailing = NULL;
      	unsigned int type = 0;
    @@ refs/files-backend.c: static int files_fsck_refs_content(struct ref_store *ref_s
     -						       &pointee_path);
     +						       &pointee_path,
     +						       symbolic_link);
    -+		}
    -+	} else if (S_ISLNK(iter->st.st_mode)) {
    -+		const char *pointee_name = NULL;
    + 		}
    + 		goto cleanup;
    + 	}
    + 
    ++	symbolic_link = 1;
     +
    -+		symbolic_link = 1;
    ++	strbuf_add_real_path(&pointee_path, iter->path.buf);
    ++	strbuf_add_absolute_path(&abs_gitdir, ref_store->gitdir);
    ++	strbuf_normalize_path(&abs_gitdir);
    ++	if (!is_dir_sep(abs_gitdir.buf[abs_gitdir.len - 1]))
    ++		strbuf_addch(&abs_gitdir, '/');
     +
    -+		strbuf_add_real_path(&pointee_path, iter->path.buf);
    -+		strbuf_add_absolute_path(&abs_gitdir, ref_store->gitdir);
    -+		strbuf_normalize_path(&abs_gitdir);
    -+		if (!is_dir_sep(abs_gitdir.buf[abs_gitdir.len - 1]))
    -+			strbuf_addch(&abs_gitdir, '/');
    ++	if (!skip_prefix(pointee_path.buf, abs_gitdir.buf, &pointee_name)) {
    ++		ret = fsck_report_ref(o, &report,
    ++				      FSCK_MSG_BAD_SYMREF_POINTEE,
    ++				      "point to target outside gitdir");
    ++		goto cleanup;
    ++	}
     +
    -+		if (!skip_prefix(pointee_path.buf,
    -+				 abs_gitdir.buf, &pointee_name)) {
    -+			ret = fsck_report_ref(o, &report,
    -+					       FSCK_MSG_BAD_SYMREF_POINTEE,
    -+					       "point to target outside gitdir");
    -+			goto cleanup;
    - 		}
    ++	strbuf_addstr(&referent, pointee_name);
    ++	ret = files_fsck_symref_target(o, &report, refname.buf,
    ++				       &referent, &pointee_path,
    ++				       symbolic_link);
     +
    -+		strbuf_addstr(&referent, pointee_name);
    -+		ret = files_fsck_symref_target(o, &report, refname.buf,
    -+					       &referent, &pointee_path,
    -+					       symbolic_link);
    - 	}
    - 
      cleanup:
    -@@ refs/files-backend.c: static int files_fsck_refs_content(struct ref_store *ref_store,
    + 	strbuf_release(&refname);
      	strbuf_release(&ref_content);
      	strbuf_release(&referent);
      	strbuf_release(&pointee_path);
-- 
2.46.0

