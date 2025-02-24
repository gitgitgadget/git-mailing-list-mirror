Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A77F13F43A
	for <git@vger.kernel.org>; Mon, 24 Feb 2025 14:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740407290; cv=none; b=lBpEImEzTeFbUR2yOn9Zu4xfqMyoBQ2PfUk0GcoXUv97gSgXBydGbqqD8cmlBPQgyCC4F2/xhES8G2aZtqkWRq8KfaTQFd0oGc+QlI3Yoyly0CkLdY6qqob86iCwROwxgx3Bfx6jTRTPSAvPd37Hg38DOYCj5wPoxYlsywKZbwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740407290; c=relaxed/simple;
	bh=EFwBsYBuueXDe1hd/XzfqnDK5aVmcBYtU/BK1BS0ayk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gh/fIC0vPgq1p4xn/zm50Rps7D6RhtKzHydWWY7oUQWkHWY51U4w5prb82W92Rg+CEUQQx0A2Z70I6VmhinjHLGff3HL0OpaezpRv1QdI0/yZH8fQJJmO083k6/4Q2ajs+hUkMN5OGqKYonjo6fX5EBufOUU5cMx6syKqFE0I/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B210gt0b; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B210gt0b"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-439846bc7eeso27613375e9.3
        for <git@vger.kernel.org>; Mon, 24 Feb 2025 06:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740407285; x=1741012085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O/q6MpUkmayKvJYkaThdNLb2r2rAKwf8LqoeY5sBMpA=;
        b=B210gt0bsjaub8csv8wjFBjPbHJhsf46XsUUJTOBQx8o3xnmf9qeZSryCpHjnpxOIN
         BPLX3HvoQWvexFaAboRMsQ2Ipfd1oEo/TuuNsW808O9NiizoDCmlGpZ7agg5sJs0Efvg
         0RddYUYDHY3rhheg3wq0Va/akvyU6HUal93/jwnUxXMhgxoriGmxiNtaJ9H+uzw1LBOX
         qIK81Po/pB6hnRmfU9b87IuJPU/xq2gKcMIGMy1rmlEVhN/TF9EEJDuKd+2tFnCWAYp1
         0vzWW+BrEHbt0pfqNYfwM07SLYLbtQGgdD6nW/k6wYb/zMfKP2jGBoak4TEV3VBA54jn
         MUew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740407285; x=1741012085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O/q6MpUkmayKvJYkaThdNLb2r2rAKwf8LqoeY5sBMpA=;
        b=txMDlAWc/zTQyHun78Epc4eYtgKfmrVwAd6CFKK5jOQOZVP9fZuelOnuXeI1maBckr
         x7ZBLc1X40+AHK04qmLZoHW3CL5079gcSFya45jD6YN5bpdmXZNBSo8uW4s1WvaxHCtC
         rXMlLbr49jL6JevZ+Gb2c5bmkFHBanEuWbZuLXhDu2wzN0R2+oLBtl+NT61bY65cDNTf
         8SxMzKlDfI1Y48AzdXGknoIiEJ3N+iiU6eB3Z0uilcUB2ZBeDfHI6ty9G2tqww2h42Cw
         T8lLtnsQ3Xq70tR96DznNobCY/y5dEJusk3BJ/GRxJ0MT3Kat3R0S9//ZewF7TpltUtk
         RB5w==
X-Gm-Message-State: AOJu0YxgjchnJBC/RjBFa5PXrRwgpXWlaWKOchYY5HcTldqrzu7MqLUH
	heSGMbZ2Kc+v/riVtXAHBU6PcUS2Gk7SUsHXS5kPWHf8n4UpCO3Uu8a1NA==
X-Gm-Gg: ASbGnctNqgNW1hQMrNXOjs5Yc/JB1DcQ51PgNDqZV7a3DkF3eL0V0lZlmp9n4J/O9hF
	qaSM8lwx7S0I2ZXH+KNM7/JhLlMr1TIVg5HERpQdQa/R7hN6tI2qqQ6kkEU83Kpm+MxjW/tSXHj
	+VqcITyjqW/rrfElSknOOyaQ9/1OmrX2ppZmSHjt8GZoshowWOyZwbmasIGOXtupl/0pJxNJ+x8
	HeYVwDiFOj618J44ZM3XIuP/PAAb2fMDa733H2N+gX133jXQ1tIvkkoE8/5l/TG10pzI4jb5514
	chHIqXG1n6o7t8qS7dRGbEeGF3nF110AXR682heffTm4Wfh5ZdF+1xQOXRlG
X-Google-Smtp-Source: AGHT+IHuou+4wI4qZqLFSmDj3xSxJHarFiTPf0ZgTlbHQZ+bFG++Y47emn75Af8Y9T1IpPJ9NKLoKg==
X-Received: by 2002:a05:600c:4e8c:b0:439:932c:e0d9 with SMTP id 5b1f17b1804b1-439ae1e62efmr123426155e9.10.1740407283328;
        Mon, 24 Feb 2025 06:28:03 -0800 (PST)
Received: from christian-Precision-5550.lan ([2001:861:2420:9770:29b9:ffdd:d750:1ffc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d58f3sm31713125f8f.73.2025.02.24.06.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 06:28:02 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Luke Shumaker <lukeshu@lukeshu.com>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Taylor Blau <me@ttaylorr.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v5 0/6] fast-export, fast-import: add support for signed-commits
Date: Mon, 24 Feb 2025 15:27:38 +0100
Message-ID: <20250224142744.279643-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.48.1.401.g48e0d4203c
In-Reply-To: <20210430232537.1131641-1-lukeshu@lukeshu.com>
References: <20210430232537.1131641-1-lukeshu@lukeshu.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Luke Shumaker sent the first 4 versions of this series in April 2021,
but it looks like he stopped before it got merged. Let's finish
polishing it.

Goal
~~~~

fast-export has an existing --signed-tags= option that controls how to
handle tag signatures.  However, there is no equivalent for commit
signatures; it just silently strips the signature out of the commit
(analogously to --signed-tags=strip).

So implement a --signed-commits= flag in fast-export, and implement
the receiving side of it in fast-import.

Overview of the changes since v4
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This revision addresses all the feedback from v4 and has a few small
improvements that I came accross when rebasing it on top of current
master and working on it.

This doesn't address the following (that weren't addressed either by
earlier versions of this series) though:

  - Elijah's suggestion to implement a flag on fast-import to validate
    signatures.  This could be a useful feature, but Luke considered
    it was beyond the scope of this work, and I agree with him.

  - The added tests still use `test -s err`, as that's still what's
    used by the other existing tests. I would be fine with adding a
    preparatory patch to address this, if people think it would be
    worth it. On the other hand, it could be part of a small separate
    series to modernize the whole "t/t9350-fast-export.sh".

Details of the changes since v4
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  - Rebased on top of b838bf1938 (Merge branch 'master' of
    https://github.com/j6t/gitk, 2025-02-20) to fix a few conflicts
    and avoid issues with file name changes, as v4 was based on
    v2.31.0 which is very old.

  - Added patch 2/6 (fast-export: fix missing whitespace after switch)
    as a preparatory patch to fix a style issue related to 'switch'
    statements in "builtin/fast-export.c".

  - In patch 3/6 (fast-export: rename --signed-tags='warn' to
    'warn-verbatim'), fixed an "a" vs "an" typo in
    "t9350-fast-export.sh".

  - In patch 4/6 (git-fast-export.txt: clarify why 'verbatim' may not
    be a good idea), fixed a "transformation" vs "transformations"
    typo in "git-fast-export.adoc".

  - In patch 5/6 (fast-export: do not modify memory from
    get_commit_buffer) there are a few small changes in
    "builtin/fast-export.c" that were suggested by Junio:

    * removed reencode_message() and instead put the encoding code in
      the `case REENCODE_YES:` in handle_commit(),

    * fixed multi-line comment style,

    * fixed potential past end of buffer read by surrounding some code
      with `if (*commit_buffer_cursor == '\n') { ... }`.

  - In patch 6/6 (fast-export, fast-import: add support for
    signed-commits) there are a number of small changes:

    * some typo fixes:

      - "changes" vs "change" in the commit message,
      - "the the" vs "the" in "git-fast-import.adoc",
      - "staticly" vs "statically" in a comment in "builtin/fast-export.c",

    * some code changes, all suggested by Junio except the last one,
      in "builtin/fast-export.c":

      - made a 'strbuf' non-static in anonymize_ident_line(),
      - fixed potential past end of buffer read by surrounding some code
        with `if (*commit_buffer_cursor == '\n') { ... }`,
      - added a `free((char *)signature)` call to avoid a memory leak
        found by the CI tests,

    * some test improvements suggested by Junio in
      "t/t9350-fast-export.sh":

      - removed whitespace between ">" and "file-sign",
      - replaced `unset` with `sane_unset`,
      - better indented lines where a `( ... )` subshell is used,
      - replaced `{ ... || true }` with `test_might_fail`.

CI tests
~~~~~~~~

All the CI tests passed, see:

https://github.com/chriscool/git/actions/runs/13496792476

Range diff compared to version 4
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1:  53d8dd60ce ! 1:  f97247e17d git-fast-import.txt: add missing LF in the BNF
    @@ Metadata
     Author: Luke Shumaker <lukeshu@datawire.io>
     
      ## Commit message ##
    -    git-fast-import.txt: add missing LF in the BNF
    +    git-fast-import.adoc: add missing LF in the BNF
     
         Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
    +    Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
     
    - ## Documentation/git-fast-import.txt ##
    -@@ Documentation/git-fast-import.txt: change to the project.
    + ## Documentation/git-fast-import.adoc ##
    +@@ Documentation/git-fast-import.adoc: change to the project.
      	original-oid?
      	('author' (SP <name>)? SP LT <email> GT SP <when> LF)?
      	'committer' (SP <name>)? SP LT <email> GT SP <when> LF
-:  ---------- > 2:  b71588563d fast-export: fix missing whitespace after switch
2:  454a58a398 ! 3:  947bc267e6 fast-export: rename --signed-tags='warn' to 'warn-verbatim'
    @@ Commit message
         deprecated synonym of 'warn-verbatim'.
     
         Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
    +    Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
     
    - ## Documentation/git-fast-export.txt ##
    -@@ Documentation/git-fast-export.txt: OPTIONS
    + ## Documentation/git-fast-export.adoc ##
    +@@ Documentation/git-fast-export.adoc: OPTIONS
      	Insert 'progress' statements every <n> objects, to be shown by
      	'git fast-import' during import.
      
    @@ Documentation/git-fast-export.txt: OPTIONS
      	Specify how to handle signed tags.  Since any transformation
      	after the export can change the tag names (which can also happen
      	when excluding revisions) the signatures will not match.
    -@@ Documentation/git-fast-export.txt: When asking to 'abort' (which is the default), this program will die
    +@@ Documentation/git-fast-export.adoc: When asking to 'abort' (which is the default), this program will die
      when encountering a signed tag.  With 'strip', the tags will silently
      be made unsigned, with 'warn-strip' they will be made unsigned but a
      warning will be displayed, with 'verbatim', they will be silently
    @@ builtin/fast-export.c: static const char *fast_export_usage[] = {
      };
      
      static int progress;
    --static enum { SIGNED_TAG_ABORT, VERBATIM, WARN, WARN_STRIP, STRIP } signed_tag_mode = SIGNED_TAG_ABORT;
    -+static enum { SIGNED_TAG_ABORT, VERBATIM, WARN_VERBATIM, WARN_STRIP, STRIP } signed_tag_mode = SIGNED_TAG_ABORT;
    - static enum { TAG_FILTERING_ABORT, DROP, REWRITE } tag_of_filtered_mode = TAG_FILTERING_ABORT;
    - static enum { REENCODE_ABORT, REENCODE_YES, REENCODE_NO } reencode_mode = REENCODE_ABORT;
    +-static enum signed_tag_mode { SIGNED_TAG_ABORT, VERBATIM, WARN, WARN_STRIP, STRIP } signed_tag_mode = SIGNED_TAG_ABORT;
    ++static enum signed_tag_mode { SIGNED_TAG_ABORT, VERBATIM, WARN_VERBATIM, WARN_STRIP, STRIP } signed_tag_mode = SIGNED_TAG_ABORT;
    + static enum tag_of_filtered_mode { TAG_FILTERING_ABORT, DROP, REWRITE } tag_of_filtered_mode = TAG_FILTERING_ABORT;
    + static enum reencode_mode { REENCODE_ABORT, REENCODE_YES, REENCODE_NO } reencode_mode = REENCODE_ABORT;
      static int fake_missing_tagger;
     @@ builtin/fast-export.c: static int parse_opt_signed_tag_mode(const struct option *opt,
    - 		signed_tag_mode = SIGNED_TAG_ABORT;
    + 		*val = SIGNED_TAG_ABORT;
      	else if (!strcmp(arg, "verbatim") || !strcmp(arg, "ignore"))
    - 		signed_tag_mode = VERBATIM;
    + 		*val = VERBATIM;
     -	else if (!strcmp(arg, "warn"))
    --		signed_tag_mode = WARN;
    +-		*val = WARN;
     +	else if (!strcmp(arg, "warn-verbatim") || !strcmp(arg, "warn"))
    -+		signed_tag_mode = WARN_VERBATIM;
    ++		*val = WARN_VERBATIM;
      	else if (!strcmp(arg, "warn-strip"))
    - 		signed_tag_mode = WARN_STRIP;
    + 		*val = WARN_STRIP;
      	else if (!strcmp(arg, "strip"))
     @@ builtin/fast-export.c: static void handle_tag(const char *name, struct tag *tag)
      				die("encountered signed tag %s; use "
    @@ t/t9350-fast-export.sh: test_expect_success 'signed-tags=verbatim' '
     +
     +'
     +
    -+# 'warn' is an backward-compatibility alias for 'warn-verbatim'; test
    ++# 'warn' is a backward-compatibility alias for 'warn-verbatim'; test
     +# that it keeps working.
     +test_expect_success 'signed-tags=warn' '
     +
3:  ee0d84c34a ! 4:  45087db345 git-fast-export.txt: clarify why 'verbatim' may not be a good idea
    @@ Commit message
         git-fast-export.txt: clarify why 'verbatim' may not be a good idea
     
         Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
    +    Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
     
    - ## Documentation/git-fast-export.txt ##
    -@@ Documentation/git-fast-export.txt: OPTIONS
    + ## Documentation/git-fast-export.adoc ##
    +@@ Documentation/git-fast-export.adoc: OPTIONS
      
      --signed-tags=(verbatim|warn-verbatim|warn-strip|strip|abort)::
      	Specify how to handle signed tags.  Since any transformation
    @@ Documentation/git-fast-export.txt: OPTIONS
     -they will be exported, but you will see a warning.
     +they will be exported, but you will see a warning.  'verbatim' and
     +'warn-verbatim' should only be used if you know that no
    -+transformations affecting tags will be performed, or if you do not
    ++transformation affecting tags will be performed, or if you do not
     +care that the resulting tag will have an invalid signature.
      
      --tag-of-filtered-object=(abort|drop|rewrite)::
4:  36463ee3a8 ! 5:  20f085a790 fast-export: do not modify memory from get_commit_buffer
    @@ Commit message
         `encoding ? encoding + encoding_len : committer_end` expression.
     
         Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
    +    Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
     
      ## builtin/fast-export.c ##
     @@ builtin/fast-export.c: static void show_filemodify(struct diff_queue_struct *q,
    @@ builtin/fast-export.c: static void show_filemodify(struct diff_queue_struct *q,
     -	return bol;
     -}
     -
    - static char *anonymize_ref_component(void *data)
    + static char *anonymize_ref_component(void)
      {
      	static int counter;
    -@@ builtin/fast-export.c: static void anonymize_ident_line(const char **beg, const char **end)
    - 	*end = out->buf + out->len;
    - }
    - 
    -+static char *reencode_message(const char *in_msg,
    -+			      const char *in_encoding, size_t in_encoding_len)
    -+{
    -+	static struct strbuf in_encoding_buf = STRBUF_INIT;
    -+
    -+	strbuf_reset(&in_encoding_buf);
    -+	strbuf_add(&in_encoding_buf, in_encoding, in_encoding_len);
    -+
    -+	return reencode_string(in_msg, "UTF-8", in_encoding_buf.buf);
    -+}
    -+
    - static void handle_commit(struct commit *commit, struct rev_info *rev,
    +@@ builtin/fast-export.c: static void handle_commit(struct commit *commit, struct rev_info *rev,
      			  struct string_list *paths_of_changed_objects)
      {
      	int saved_output_format = rev->diffopt.output_format;
    @@ builtin/fast-export.c: static void anonymize_ident_line(const char **beg, const
     +	const char *commit_buffer, *commit_buffer_cursor;
      	const char *author, *author_end, *committer, *committer_end;
     -	const char *encoding, *message;
    -+	const char *encoding;
    ++	const char *encoding = NULL;
     +	size_t encoding_len;
     +	const char *message;
      	char *reencoded = NULL;
    @@ builtin/fast-export.c: static void handle_commit(struct commit *commit, struct r
      	rev->diffopt.output_format = DIFF_FORMAT_CALLBACK;
      
      	parse_commit_or_die(commit);
    --	commit_buffer = get_commit_buffer(commit, NULL);
    +-	commit_buffer = repo_get_commit_buffer(the_repository, commit, NULL);
     -	author = strstr(commit_buffer, "\nauthor ");
    -+	commit_buffer_cursor = commit_buffer = get_commit_buffer(commit, NULL);
    ++	commit_buffer_cursor = commit_buffer = repo_get_commit_buffer(the_repository, commit, NULL);
     +
     +	author = strstr(commit_buffer_cursor, "\nauthor ");
      	if (!author)
    @@ builtin/fast-export.c: static void handle_commit(struct commit *commit, struct r
     -	encoding = find_encoding(committer_end, message);
     +	commit_buffer_cursor = committer_end = strchrnul(committer, '\n');
     +
    -+	/* find_commit_header() gets a `+ 1` because
    ++	/*
    ++	 * find_commit_header() gets a `+ 1` because
     +	 * commit_buffer_cursor points at the trailing "\n" at the end
     +	 * of the previous line, but find_commit_header() wants a
    -+	 * pointer to the beginning of the next line. */
    -+	encoding = find_commit_header(commit_buffer_cursor + 1, "encoding", &encoding_len);
    -+	if (encoding)
    -+		commit_buffer_cursor = encoding + encoding_len;
    ++	 * pointer to the beginning of the next line.
    ++	 */
    ++	if (*commit_buffer_cursor == '\n') {
    ++		encoding = find_commit_header(commit_buffer_cursor + 1, "encoding", &encoding_len);
    ++		if (encoding)
    ++			commit_buffer_cursor = encoding + encoding_len;
    ++	}
     +
     +	message = strstr(commit_buffer_cursor, "\n\n");
      	if (message)
      		message += 2;
      
     @@ builtin/fast-export.c: static void handle_commit(struct commit *commit, struct rev_info *rev,
    + 	if (anonymize) {
    + 		reencoded = anonymize_commit_message();
      	} else if (encoding) {
    - 		switch(reencode_mode) {
    ++		char *buf;
    + 		switch (reencode_mode) {
      		case REENCODE_YES:
     -			reencoded = reencode_string(message, "UTF-8", encoding);
    -+			reencoded = reencode_message(message, encoding, encoding_len);
    ++			buf = xstrfmt("%.*s", (int)encoding_len, encoding);
    ++			reencoded = reencode_string(message, "UTF-8", buf);
    ++			free(buf);
      			break;
      		case REENCODE_NO:
      			break;
5:  8ff33e2e88 ! 6:  48e0d4203c fast-export, fast-import: add support for signed-commits
    @@ Commit message
         option.
     
         On the fast-export side, try to be as much like signed-tags as possible,
    -    in both implementation and in user-interface.  This will changes the
    +    in both implementation and in user-interface.  This will change the
         default behavior to '--signed-commits=abort' from what is now
         '--signed-commits=strip'.  In order to provide an escape hatch for users
         of third-party tools that call fast-export and do not yet know of the
    @@ Commit message
         '--signed-commits=warn-strip'.
     
         Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
    +    Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
     
    - ## Documentation/git-fast-export.txt ##
    -@@ Documentation/git-fast-export.txt: they will be exported, but you will see a warning.  'verbatim' and
    - transformations affecting tags will be performed, or if you do not
    + ## Documentation/git-fast-export.adoc ##
    +@@ Documentation/git-fast-export.adoc: they will be exported, but you will see a warning.  'verbatim' and
    + transformation affecting tags will be performed, or if you do not
      care that the resulting tag will have an invalid signature.
      
     +--signed-commits=(verbatim|warn-verbatim|warn-strip|strip|abort)::
    @@ Documentation/git-fast-export.txt: they will be exported, but you will see a war
      	Specify how to handle tags whose tagged object is filtered out.
      	Since revisions and files to export can be limited by path,
     
    - ## Documentation/git-fast-import.txt ##
    -@@ Documentation/git-fast-import.txt: and control the current import process.  More detailed discussion
    + ## Documentation/git-fast-import.adoc ##
    +@@ Documentation/git-fast-import.adoc: and control the current import process.  More detailed discussion
      Create or update a branch with a new commit, recording one logical
      change to the project.
      
     +////
     +Yes, it's intentional that the 'gpgsig' line doesn't have a trailing
    -+`LF`; the the definition of `data` has a byte-count prefix, so it
    ++`LF`; the definition of `data` has a byte-count prefix, so it
     +doesn't need an `LF` to act as a terminator (and `data` also already
     +includes an optional trailing `LF?` just in case you want to include
     +one).
    @@ Documentation/git-fast-import.txt: and control the current import process.  More
      	('encoding' SP <encoding> LF)?
      	data
      	('from' SP <commit-ish> LF)?
    -@@ Documentation/git-fast-import.txt: that was selected by the --date-format=<fmt> command-line option.
    +@@ Documentation/git-fast-import.adoc: that was selected by the --date-format=<fmt> command-line option.
      See ``Date Formats'' above for the set of supported formats, and
      their syntax.
      
    @@ builtin/fast-export.c: static const char *fast_export_usage[] = {
     +enum sign_mode { SIGN_ABORT, SIGN_VERBATIM, SIGN_STRIP, SIGN_WARN_VERBATIM, SIGN_WARN_STRIP };
     +
      static int progress;
    --static enum { SIGNED_TAG_ABORT, VERBATIM, WARN_VERBATIM, WARN_STRIP, STRIP } signed_tag_mode = SIGNED_TAG_ABORT;
    +-static enum signed_tag_mode { SIGNED_TAG_ABORT, VERBATIM, WARN_VERBATIM, WARN_STRIP, STRIP } signed_tag_mode = SIGNED_TAG_ABORT;
     +static enum sign_mode signed_tag_mode = SIGN_ABORT;
     +static enum sign_mode signed_commit_mode = SIGN_ABORT;
    - static enum { TAG_FILTERING_ABORT, DROP, REWRITE } tag_of_filtered_mode = TAG_FILTERING_ABORT;
    - static enum { REENCODE_ABORT, REENCODE_YES, REENCODE_NO } reencode_mode = REENCODE_ABORT;
    + static enum tag_of_filtered_mode { TAG_FILTERING_ABORT, DROP, REWRITE } tag_of_filtered_mode = TAG_FILTERING_ABORT;
    + static enum reencode_mode { REENCODE_ABORT, REENCODE_YES, REENCODE_NO } reencode_mode = REENCODE_ABORT;
      static int fake_missing_tagger;
     @@ builtin/fast-export.c: static int anonymize;
      static struct hashmap anonymized_seeds;
    @@ builtin/fast-export.c: static int anonymize;
     +static int parse_opt_sign_mode(const struct option *opt,
      				     const char *arg, int unset)
      {
    +-	enum signed_tag_mode *val = opt->value;
    +-
     -	if (unset || !strcmp(arg, "abort"))
    --		signed_tag_mode = SIGNED_TAG_ABORT;
    -+	enum sign_mode *valptr = opt->value;
    +-		*val = SIGNED_TAG_ABORT;
    ++	enum sign_mode *val = opt->value;
     +	if (unset)
     +		return 0;
     +	else if (!strcmp(arg, "abort"))
    -+		*valptr = SIGN_ABORT;
    ++		*val = SIGN_ABORT;
      	else if (!strcmp(arg, "verbatim") || !strcmp(arg, "ignore"))
    --		signed_tag_mode = VERBATIM;
    -+		*valptr = SIGN_VERBATIM;
    +-		*val = VERBATIM;
    ++		*val = SIGN_VERBATIM;
      	else if (!strcmp(arg, "warn-verbatim") || !strcmp(arg, "warn"))
    --		signed_tag_mode = WARN_VERBATIM;
    -+		*valptr = SIGN_WARN_VERBATIM;
    +-		*val = WARN_VERBATIM;
    ++		*val = SIGN_WARN_VERBATIM;
      	else if (!strcmp(arg, "warn-strip"))
    --		signed_tag_mode = WARN_STRIP;
    -+		*valptr = SIGN_WARN_STRIP;
    +-		*val = WARN_STRIP;
    ++		*val = SIGN_WARN_STRIP;
      	else if (!strcmp(arg, "strip"))
    --		signed_tag_mode = STRIP;
    -+		*valptr = SIGN_STRIP;
    +-		*val = STRIP;
    ++		*val = SIGN_STRIP;
      	else
     -		return error("Unknown signed-tags mode: %s", arg);
     +		return error("Unknown %s mode: %s", opt->long_name, arg);
    @@ builtin/fast-export.c: static void anonymize_ident_line(const char **beg, const
     + * returning the first line of the header.
     + *
     + * The returned string has had the ' ' line continuation markers
    -+ * removed, and points to staticly allocated memory (not to memory
    ++ * removed, and points to statically allocated memory (not to memory
     + * within 'msg'), so it is only valid until the next call to
     + * find_commit_multiline_header.
     + *
    @@ builtin/fast-export.c: static void anonymize_ident_line(const char **beg, const
     +						const char *key,
     +						const char **end)
     +{
    -+	static struct strbuf val = STRBUF_INIT;
    ++	struct strbuf val = STRBUF_INIT;
     +	const char *bol, *eol;
     +	size_t len;
     +
    -+	strbuf_reset(&val);
    -+
     +	bol = find_commit_header(msg, key, &len);
     +	if (!bol)
     +		return NULL;
    @@ builtin/fast-export.c: static void anonymize_ident_line(const char **beg, const
     +	}
     +
     +	*end = eol;
    -+	return val.buf;
    ++	return strbuf_detach(&val, NULL);
     +}
     +
    - static char *reencode_message(const char *in_msg,
    - 			      const char *in_encoding, size_t in_encoding_len)
    + static void handle_commit(struct commit *commit, struct rev_info *rev,
    + 			  struct string_list *paths_of_changed_objects)
      {
     @@ builtin/fast-export.c: static void handle_commit(struct commit *commit, struct rev_info *rev,
      	const char *author, *author_end, *committer, *committer_end;
    - 	const char *encoding;
    + 	const char *encoding = NULL;
      	size_t encoding_len;
    -+	const char *signature_alg = NULL, *signature;
    ++	const char *signature_alg = NULL, *signature = NULL;
      	const char *message;
      	char *reencoded = NULL;
      	struct commit_list *p;
     @@ builtin/fast-export.c: static void handle_commit(struct commit *commit, struct rev_info *rev,
    - 	committer++;
      	commit_buffer_cursor = committer_end = strchrnul(committer, '\n');
      
    --	/* find_commit_header() gets a `+ 1` because
    + 	/*
    +-	 * find_commit_header() gets a `+ 1` because
     -	 * commit_buffer_cursor points at the trailing "\n" at the end
     -	 * of the previous line, but find_commit_header() wants a
    -+	/* find_commit_header() and find_commit_multiline_header() get
    ++	 * find_commit_header() and find_commit_multiline_header() get
     +	 * a `+ 1` because commit_buffer_cursor points at the trailing
     +	 * "\n" at the end of the previous line, but they want a
    - 	 * pointer to the beginning of the next line. */
    + 	 * pointer to the beginning of the next line.
    + 	 */
     +
    - 	encoding = find_commit_header(commit_buffer_cursor + 1, "encoding", &encoding_len);
    - 	if (encoding)
    - 		commit_buffer_cursor = encoding + encoding_len;
    + 	if (*commit_buffer_cursor == '\n') {
    + 		encoding = find_commit_header(commit_buffer_cursor + 1, "encoding", &encoding_len);
    + 		if (encoding)
    + 			commit_buffer_cursor = encoding + encoding_len;
    + 	}
      
    -+	if ((signature = find_commit_multiline_header(commit_buffer_cursor + 1, "gpgsig", &commit_buffer_cursor)))
    -+		signature_alg = "sha1";
    -+	else if ((signature = find_commit_multiline_header(commit_buffer_cursor + 1, "gpgsig-sha256", &commit_buffer_cursor)))
    -+		signature_alg = "sha256";
    ++	if (*commit_buffer_cursor == '\n') {
    ++		if ((signature = find_commit_multiline_header(commit_buffer_cursor + 1, "gpgsig", &commit_buffer_cursor)))
    ++			signature_alg = "sha1";
    ++		else if ((signature = find_commit_multiline_header(commit_buffer_cursor + 1, "gpgsig-sha256", &commit_buffer_cursor)))
    ++			signature_alg = "sha256";
    ++	}
     +
      	message = strstr(commit_buffer_cursor, "\n\n");
      	if (message)
    @@ builtin/fast-export.c: static void handle_commit(struct commit *commit, struct r
      	printf("%.*s\n%.*s\n",
      	       (int)(author_end - author), author,
      	       (int)(committer_end - committer), committer);
    -+	if (signature)
    -+		switch(signed_commit_mode) {
    ++	if (signature) {
    ++		switch (signed_commit_mode) {
     +		case SIGN_ABORT:
     +			die("encountered signed commit %s; use "
     +			    "--signed-commits=<mode> to handle it",
    @@ builtin/fast-export.c: static void handle_commit(struct commit *commit, struct r
     +		case SIGN_STRIP:
     +			break;
     +		}
    ++		free((char *)signature);
    ++	}
      	if (!reencoded && encoding)
      		printf("encoding %.*s\n", (int)encoding_len, encoding);
      	printf("data %u\n%s",
     @@ builtin/fast-export.c: static void handle_tag(const char *name, struct tag *tag)
      					       "\n-----BEGIN PGP SIGNATURE-----\n");
      		if (signature)
    - 			switch(signed_tag_mode) {
    + 			switch (signed_tag_mode) {
     -			case SIGNED_TAG_ABORT:
     +			case SIGN_ABORT:
      				die("encountered signed tag %s; use "
    @@ builtin/fast-export.c: static void handle_tag(const char *name, struct tag *tag)
      				message_size = signature + 1 - message;
      				break;
      			}
    -@@ builtin/fast-export.c: static int parse_opt_anonymize_map(const struct option *opt,
    - 
    - int cmd_fast_export(int argc, const char **argv, const char *prefix)
    +@@ builtin/fast-export.c: int cmd_fast_export(int argc,
    + 		    const char *prefix,
    + 		    struct repository *repo UNUSED)
      {
     +	const char *env_signed_commits_noabort;
      	struct rev_info revs;
    - 	struct object_array commits = OBJECT_ARRAY_INIT;
      	struct commit *commit;
    -@@ builtin/fast-export.c: int cmd_fast_export(int argc, const char **argv, const char *prefix)
    + 	char *export_filename = NULL,
    +@@ builtin/fast-export.c: int cmd_fast_export(int argc,
      			    N_("show progress after <n> objects")),
      		OPT_CALLBACK(0, "signed-tags", &signed_tag_mode, N_("mode"),
      			     N_("select handling of signed tags"),
    @@ builtin/fast-export.c: int cmd_fast_export(int argc, const char **argv, const ch
      		OPT_CALLBACK(0, "tag-of-filtered-object", &tag_of_filtered_mode, N_("mode"),
      			     N_("select handling of tags that tag filtered objects"),
      			     parse_opt_tag_of_filtered_mode),
    -@@ builtin/fast-export.c: int cmd_fast_export(int argc, const char **argv, const char *prefix)
    +@@ builtin/fast-export.c: int cmd_fast_export(int argc,
      	if (argc == 1)
      		usage_with_options (fast_export_usage, options);
      
    @@ builtin/fast-import.c: static void parse_new_commit(const char *arg)
     +			strbuf_addstr(&new_data, "gpgsig-sha256 ");
     +		else
     +			die("Expected gpgsig algorithm sha1 or sha256, got %s", sig_alg);
    -+		string_list_split_in_place(&siglines, sig.buf, '\n', -1);
    ++		string_list_split_in_place(&siglines, sig.buf, "\n", -1);
     +		strbuf_add_separated_string_list(&new_data, "\n ", &siglines);
     +		strbuf_addch(&new_data, '\n');
     +	}
    @@ t/t9350-fast-export.sh: test_expect_success 'signed-tags=warn-strip' '
     +	# between the two.
     +	test_config i18n.commitEncoding ISO-8859-1 &&
     +	git checkout -f -b commit-signing main &&
    -+	echo Sign your name > file-sign &&
    ++	echo Sign your name >file-sign &&
     +	git add file-sign &&
     +	git commit -S -m "signed commit" &&
     +	COMMIT_SIGNING=$(git rev-parse --verify commit-signing)
    @@ t/t9350-fast-export.sh: test_expect_success 'signed-tags=warn-strip' '
     +
     +test_expect_success GPG 'signed-commits default' '
     +
    -+	unset FAST_EXPORT_SIGNED_COMMITS_NOABORT &&
    ++	sane_unset FAST_EXPORT_SIGNED_COMMITS_NOABORT &&
     +	test_must_fail git fast-export --reencode=no commit-signing &&
     +
     +	FAST_EXPORT_SIGNED_COMMITS_NOABORT=1 git fast-export --reencode=no commit-signing >output 2>err &&
     +	! grep ^gpgsig output &&
     +	grep "^encoding ISO-8859-1" output &&
     +	test -s err &&
    -+	sed "s/commit-signing/commit-strip-signing/" output |
    -+		(cd new &&
    -+		 git fast-import &&
    -+		 test $COMMIT_SIGNING != $(git rev-parse --verify refs/heads/commit-strip-signing))
    ++	sed "s/commit-signing/commit-strip-signing/" output | (
    ++		cd new &&
    ++		git fast-import &&
    ++		STRIPPED=$(git rev-parse --verify refs/heads/commit-strip-signing) &&
    ++		test $COMMIT_SIGNING != $STRIPPED
    ++	)
     +
     +'
     +
    @@ t/t9350-fast-export.sh: test_expect_success 'signed-tags=warn-strip' '
     +	git fast-export --signed-commits=verbatim --reencode=no commit-signing >output &&
     +	grep "^gpgsig sha" output &&
     +	grep "encoding ISO-8859-1" output &&
    -+	(cd new &&
    -+	 git fast-import &&
    -+	 test $COMMIT_SIGNING = $(git rev-parse --verify refs/heads/commit-signing)) <output
    ++	(
    ++		cd new &&
    ++		git fast-import &&
    ++		STRIPPED=$(git rev-parse --verify refs/heads/commit-signing) &&
    ++		test $COMMIT_SIGNING = $STRIPPED
    ++	) <output
     +
     +'
     +
    @@ t/t9350-fast-export.sh: test_expect_success 'signed-tags=warn-strip' '
     +	grep "^gpgsig sha" output &&
     +	grep "encoding ISO-8859-1" output &&
     +	test -s err &&
    -+	(cd new &&
    -+	 git fast-import &&
    -+	 test $COMMIT_SIGNING = $(git rev-parse --verify refs/heads/commit-signing)) <output
    ++	(
    ++		cd new &&
    ++		git fast-import &&
    ++		STRIPPED=$(git rev-parse --verify refs/heads/commit-signing) &&
    ++		test $COMMIT_SIGNING = $STRIPPED
    ++	) <output
     +
     +'
     +
    @@ t/t9350-fast-export.sh: test_expect_success 'signed-tags=warn-strip' '
     +	git fast-export --signed-commits=strip --reencode=no commit-signing >output &&
     +	! grep ^gpgsig output &&
     +	grep "^encoding ISO-8859-1" output &&
    -+	sed "s/commit-signing/commit-strip-signing/" output |
    -+		(cd new &&
    -+		 git fast-import &&
    -+		 test $COMMIT_SIGNING != $(git rev-parse --verify refs/heads/commit-strip-signing))
    ++	sed "s/commit-signing/commit-strip-signing/" output | (
    ++		cd new &&
    ++		git fast-import &&
    ++		STRIPPED=$(git rev-parse --verify refs/heads/commit-strip-signing) &&
    ++		test $COMMIT_SIGNING != $STRIPPED
    ++	)
     +
     +'
     +
    @@ t/t9350-fast-export.sh: test_expect_success 'signed-tags=warn-strip' '
     +	! grep ^gpgsig output &&
     +	grep "^encoding ISO-8859-1" output &&
     +	test -s err &&
    -+	sed "s/commit-signing/commit-strip-signing/" output |
    -+		(cd new &&
    -+		 git fast-import &&
    -+		 test $COMMIT_SIGNING != $(git rev-parse --verify refs/heads/commit-strip-signing))
    ++	sed "s/commit-signing/commit-strip-signing/" output | (
    ++		cd new &&
    ++		git fast-import &&
    ++		STRIPPED=$(git rev-parse --verify refs/heads/commit-strip-signing) &&
    ++		test $COMMIT_SIGNING != $STRIPPED
    ++	)
     +
     +'
     +
      test_expect_success 'setup submodule' '
      
    + 	test_config_global protocol.file.allow always &&
      	git checkout -f main &&
    -+	{ git update-ref -d refs/heads/commit-signing || true; } &&
    ++	test_might_fail git update-ref -d refs/heads/commit-signing &&
      	mkdir sub &&
      	(
      		cd sub &&


Christian Couder (1):
  fast-export: fix missing whitespace after switch

Luke Shumaker (5):
  git-fast-import.adoc: add missing LF in the BNF
  fast-export: rename --signed-tags='warn' to 'warn-verbatim'
  git-fast-export.txt: clarify why 'verbatim' may not be a good idea
  fast-export: do not modify memory from get_commit_buffer
  fast-export, fast-import: add support for signed-commits

 Documentation/git-fast-export.adoc |  25 +++-
 Documentation/git-fast-import.adoc |  20 ++-
 builtin/fast-export.c              | 189 +++++++++++++++++++++--------
 builtin/fast-import.c              |  23 ++++
 t/t9350-fast-export.sh             | 116 ++++++++++++++++++
 5 files changed, 317 insertions(+), 56 deletions(-)

-- 
2.48.1.401.g48e0d4203c

