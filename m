Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB521E521B
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 09:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751966286; cv=none; b=FY2zeijHCXWZf76kPVS9seyPYnLNUdU2FWrMS3ITLkXW/zkc/89RApEvmFy0IKXUwJNaIMjr0O4TnCwllantxS1G4zCpQ1GzkpDC/Npl27bU5PYoUYNp55g3KsxIghjz5c+dW0kdcbHMCzHKEJTJz3cTWTJUcNVDwnecznoaxDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751966286; c=relaxed/simple;
	bh=iH5bqf8U1Qc6DoE+UBQIfNxUARkDuMVDQJgGlaICE0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EfOiz+18Rc5RtFloIS7CJS+icosuOW3LFQgNsHK10tKttrTqC+nbOE93HGMVy5D7xogZt5/KPCsEoieoGFopuc+ICNTZjj11rH37O398xSjH17p/eweK+WPQz1EI8t4d9dTKH0bgr+gbA1Puz9iqOnkFi/7krhMvdI2f2Ghyo3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CeNiWx45; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeNiWx45"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-450ce3a2dd5so37429505e9.3
        for <git@vger.kernel.org>; Tue, 08 Jul 2025 02:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751966281; x=1752571081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aV6VvDN4ATRB1e3SwEdqKXD3Yf5eqc4aUZC+p/nY5Jw=;
        b=CeNiWx45uiX5AbqMFrhP5jcQRD4IvHw2damX6liuy0Of/KNxl0HcUlTieBpbux8rML
         2ZKMe+PxThg42yS1YjTZWKs6YArAgdD1Wu8I91jWYl2Dr5Q/WsXNFUy6VdWzR74VRvxV
         vBEZ4PuXhHZU7B7iLWh7OdClypgVR3T0CiwcHsdu+Bry7Armebjo8AiVcWKruaSm5ro8
         9itTTHi84fIdo+LF/TR9Q0fDbQm3g/hZV0EL4kyGAUwEv/9tj71psJkWj8cOiW/7S5oc
         5eV4oODiwnz6X4LrQIiJY+GRX2sTnmMt89EH7EZwbcNy/r0qcBPDvmim9FoHQUI09Ecw
         q3jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751966281; x=1752571081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aV6VvDN4ATRB1e3SwEdqKXD3Yf5eqc4aUZC+p/nY5Jw=;
        b=i6GdPJjN8T0BwF8+hYSjaplYnF4bZzMA5QyYWKDANqgSkrb74ajIxBkbnQKYuJss/6
         tmqaM6eIFgxzrvSo9puvAW1BPvUcPGwVfPOxPkgO5p59+yn2QjRNmHDzfErFmdn9buRK
         9xGkKGVB6V1mmn/3Hp4myYcW87mVrBkwngI3LqmN+/XWczmogLzBiP63p6RDgsICPG3e
         DqKs/mVV40mQepLtIWS1cdkCJegBcuj/nn2XEoCiA91xksPqnPa6aPV5d1BSd6EvPgbI
         SXSbB/QaqooVHZ4hB1V9qyvjzpjrd2ch//C/c1f20X4tJz/ukIEFFbvjPf5IM2V87tj6
         8JVA==
X-Gm-Message-State: AOJu0YybIdRFe+rc+HeedeEXyrlnM1GiUBszilbYHqruTw57lXtTA60Z
	hWcvPi1/Qv8cmWBXjgSzKw0k2Eujs9SW66TLPiwwv1hcdna66+dMOpaYd6tf7g==
X-Gm-Gg: ASbGncvLp6LCaMR3LNlkm2rCTn7YjTRpHXctza2KgoiUmJ8MCnmehlCxKw5lY+eFBvl
	BWysLTDjseosnxZ60stgv5oJxT8+Ffa84J+L93ti52bSzeOt2nXxKZ6fuCDKo7HhCvRQ1Tskg8S
	ihlijafTT01QfQGDiupIjl6LaYaeATqZnQ9KsXddIAbhAP9lBI1oDOe3UZBQE7vbX3T9Hsy4rkS
	qb6lSm6NctwQh1Kp2mBPQFkWwg1MXS89x5AtdrRi8PaHBZQ4eToM9v4uEcMVQICLmmb420gR2eh
	qphQXIaYlQItIHDmszAuSNWfGvmj3ZtIBo4GM2uis3bdl8J0T+aKA6idEJLebYyRvDP4OysQ2nw
	Kg/LmH6QL3/eCJzkGHg==
X-Google-Smtp-Source: AGHT+IHeS2kkkedq3EXA6Z7lsV0zgCPEWf1ZRhS88G5PqY0gOqHAU98XM9vK8r1QUwwgji8pOtlXgw==
X-Received: by 2002:a05:600c:4686:b0:442:f12f:bd9f with SMTP id 5b1f17b1804b1-454b4eb82f0mr151124325e9.27.1751966280966;
        Tue, 08 Jul 2025 02:18:00 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([2a04:cec0:1939:8f30:3df9:bd7:e476:38d8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd3dd12bsm16259015e9.38.2025.07.08.02.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 02:18:00 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5] fast-(import|export): improve on commit signature output format
Date: Tue,  8 Jul 2025 11:17:38 +0200
Message-ID: <20250708091738.4072857-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.50.0.174.gcf836c1ec7
In-Reply-To: <20250619133630.727274-1-christian.couder@gmail.com>
References: <20250619133630.727274-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A recent commit, d9cb0e6ff8 (fast-export, fast-import: add support for
signed-commits, 2025-03-10), added support for signed commits to
fast-export and fast-import.

When a signed commit is processed, fast-export can output either
"gpgsig sha1" or "gpgsig sha256" depending on whether the signed
commit uses the SHA-1 or SHA-256 Git object format.

However, this implementation has a number of limitations:

  - the output format was not properly described in the documentation,
  - the output format is not very informative as it doesn't even say
    if the signature is an OpenPGP, an SSH, or an X509 signature,
  - the implementation doesn't support having both one signature on
    the SHA-1 object and one on the SHA-256 object.

Let's improve on these limitations by improving fast-export and
fast-import so that:

  - all the signatures are exported,
  - at most one signature on the SHA-1 object and one on the SHA-256
    are imported,
  - if there is more than one signature on the SHA-1 object or on
    the SHA-256 object, fast-import emits a warning for each
    additional signature,
  - the output format is "gpgsig <git-hash-algo> <signature-format>",
    where <git-hash-algo> is the Git object format as before, and
    <signature-format> is the signature type ("openpgp", "x509",
    "ssh" or "unknown"),
  - the output is properly documented.

About the output format:

  - <git-hash-algo> allows to know which representation of the commit
    was signed (the SHA-1 or the SHA-256 version) which helps with
    both signature verification and interoperability between repos
    with different hash functions,

  - <signature-format> helps tools that process the fast-export
    stream, so they don't have to parse the ASCII armor to identify
    the signature type.

It could be even better to be able to import more than one signature
on the SHA-1 object and on the SHA-256 object, but other parts of
Git don't handle that well for now, so this is left for future
improvements.

Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---

This v5 is similar in spirit to v4, especially the format of the
"gpgsig ..." command didn't change, but there are a number of
improvements:

  - All the signatures are now exported. On the import side, still at
    most one signature for SHA-1 and one for SHA-256 are imported (and
    a warning is still emitted for additional signatures) though.

  - The code makes sure each signature ends with a LF character. While
    this is not mandatory, it is encouraged and makes the output more
    human readable and 'grep'able.

  - A test with both a SHA-1 and a SHA-256 signature on the same
    commit has been added.

  - Some tests check that either "sha1" or "sha256" is in the "gpgsig
    ..."  command instead of matching "sha(1|256)".

  - The format of the "gpgsig ..." command is better explained both in
    the commit message and in the fast-import documentation.

  - There are some typo fixes, lines wrapped, and a few other such
    small changes.

Thanks to brian, Elijah and Junio who commented on the v1 and v2.

CI tests:

They have all passed:

https://github.com/chriscool/git/actions/runs/16136587558

Range-diff with v4:

1:  b3d8b13c0e ! 1:  5791617d7d fast-(import|export): improve on commit signature output format
    @@ Commit message
         Let's improve on these limitations by improving fast-export and
         fast-import so that:
     
    -      - both one signature on the SHA-1 object and one on the SHA-256
    -        object can be exported and imported,
    +      - all the signatures are exported,
    +      - at most one signature on the SHA-1 object and one on the SHA-256
    +        are imported,
           - if there is more than one signature on the SHA-1 object or on
    -        the SHA-256 object, a warning is emitted,
    +        the SHA-256 object, fast-import emits a warning for each
    +        additional signature,
           - the output format is "gpgsig <git-hash-algo> <signature-format>",
             where <git-hash-algo> is the Git object format as before, and
             <signature-format> is the signature type ("openpgp", "x509",
    -        "ssh" or "unknown",
    +        "ssh" or "unknown"),
           - the output is properly documented.
     
    -    Note that it could be even better to be able to export and import
    -    more than one signature on the SHA-1 object and on the SHA-256
    -    object, but other parts of Git don't handle that well for now, so
    -    this is left for future improvements.
    +    About the output format:
    +
    +      - <git-hash-algo> allows to know which representation of the commit
    +        was signed (the SHA-1 or the SHA-256 version) which helps with
    +        both signature verification and interoperability between repos
    +        with different hash functions,
    +
    +      - <signature-format> helps tools that process the fast-export
    +        stream, so they don't have to parse the ASCII armor to identify
    +        the signature type.
    +
    +    It could be even better to be able to import more than one signature
    +    on the SHA-1 object and on the SHA-256 object, but other parts of
    +    Git don't handle that well for now, so this is left for future
    +    improvements.
     
         Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
         Helped-by: Elijah Newren <newren@gmail.com>
    @@ Documentation/git-fast-export.adoc: resulting tag will have an invalid signature
     +`gpgsig sha1 openpgp`, while an SSH signature on a SHA-256 commit
     +starts with `gpgsig sha256 ssh`.
     ++
    -+Currently for a given commit, at most one signature for the SHA-1
    -+object and one signature for the SHA-256 object are exported, each
    -+with their respective <git-hash-algo> identifier. A warning is
    -+emitted for each additional signature found.
    ++While all the signatures of a commit are exported, an importer may
    ++choose to accept only some of them. For example
    ++linkgit:git-fast-import[1] currently stores at most one signature per
    ++Git hash algorithm in each commit.
     ++
      NOTE: This is highly experimental and the format of the data stream may
      change in the future without compatibility guarantees.
    @@ Documentation/git-fast-import.adoc: their syntax.
     +The `gpgsig` command takes two arguments:
     +
     +* `<git-hash-algo>` specifies which Git object format this signature
    -+  applies to, either `sha1` or `sha256`.
    ++  applies to, either `sha1` or `sha256`. This allows to know which
    ++  representation of the commit was signed (the SHA-1 or the SHA-256
    ++  version) which helps with both signature verification and
    ++  interoperability between repos with different hash functions.
     +
     +* `<signature-format>` specifies the type of signature, such as
    -+  `openpgp`, `x509`, `ssh`, or `unknown`.
    ++  `openpgp`, `x509`, `ssh`, or `unknown`. This is a convenience for
    ++  tools that process the stream, so they don't have to parse the ASCII
    ++  armor to identify the signature type.
     +
     +A commit may have at most one signature for the SHA-1 object format
     +(stored in the "gpgsig" header) and one for the SHA-256 object format
    @@ builtin/fast-export.c: static const char *find_commit_multiline_header(const cha
     +	if (!signature)
     +		return;
     +
    -+	printf("gpgsig %s %s\ndata %u\n%s",
    ++	printf("gpgsig %s %s\ndata %u\n%s\n",
     +	       object_hash,
     +	       get_signature_format(signature),
     +	       (unsigned)strlen(signature),
     +	       signature);
     +}
     +
    -+static void warn_on_extra_sig(const char **pos, struct commit *commit, int is_sha1)
    ++static const char *append_signatures_for_header(struct string_list *signatures,
    ++						const char *pos,
    ++						const char *header,
    ++						const char *object_hash)
     +{
    -+	const char *header = is_sha1 ? "gpgsig" : "gpgsig-sha256";
    -+	const char *extra_sig = find_commit_multiline_header(*pos + 1, header, pos);
    -+	if (extra_sig) {
    -+		const char *hash = is_sha1 ? "SHA-1" : "SHA-256";
    -+		warning("more than one %s signature found on commit %s, using only the first one",
    -+			hash, oid_to_hex(&commit->object.oid));
    -+		free((char *)extra_sig);
    ++	const char *signature;
    ++	const char *start = pos;
    ++	const char *end = pos;
    ++
    ++	while ((signature = find_commit_multiline_header(start + 1,
    ++							 header,
    ++							 &end))) {
    ++		string_list_append(signatures, signature)->util = (void *)object_hash;
    ++		free((char *)signature);
    ++		start = end;
     +	}
    ++
    ++	return end;
     +}
     +
      static void handle_commit(struct commit *commit, struct rev_info *rev,
    @@ builtin/fast-export.c: static void handle_commit(struct commit *commit, struct r
      	const char *encoding = NULL;
      	size_t encoding_len;
     -	const char *signature_alg = NULL, *signature = NULL;
    -+	const char *sig_sha1 = NULL;
    -+	const char *sig_sha256 = NULL;
    ++	struct string_list signatures = STRING_LIST_INIT_DUP;
      	const char *message;
      	char *reencoded = NULL;
      	struct commit_list *p;
    @@ builtin/fast-export.c: static void handle_commit(struct commit *commit, struct r
     -			signature_alg = "sha1";
     -		else if ((signature = find_commit_multiline_header(commit_buffer_cursor + 1, "gpgsig-sha256", &commit_buffer_cursor)))
     -			signature_alg = "sha256";
    -+		const char *sig_cursor = commit_buffer_cursor;
    -+		const char *after_sha1 = commit_buffer_cursor;
    -+		const char *after_sha256 = commit_buffer_cursor;
    -+
    -+		/*
    -+		 * Find the first signature for each hash algorithm.
    -+		 * The searches must start from the same position.
    -+		 */
    -+		sig_sha1 = find_commit_multiline_header(sig_cursor + 1,
    -+							"gpgsig",
    -+							&after_sha1);
    -+		sig_sha256 = find_commit_multiline_header(sig_cursor + 1,
    -+							  "gpgsig-sha256",
    -+							  &after_sha256);
    -+
    -+		/* Warn on any additional signatures, as they will be ignored. */
    -+		if (sig_sha1)
    -+			warn_on_extra_sig(&after_sha1, commit, 1);
    -+		if (sig_sha256)
    -+			warn_on_extra_sig(&after_sha256, commit, 0);
    -+
    ++		const char *after_sha1 = append_signatures_for_header(&signatures, commit_buffer_cursor,
    ++								      "gpgsig", "sha1");
    ++		const char *after_sha256 = append_signatures_for_header(&signatures, commit_buffer_cursor,
    ++									"gpgsig-sha256", "sha256");
     +		commit_buffer_cursor = (after_sha1 > after_sha256) ? after_sha1 : after_sha256;
      	}
      
    @@ builtin/fast-export.c: static void handle_commit(struct commit *commit, struct r
      	       (int)(author_end - author), author,
      	       (int)(committer_end - committer), committer);
     -	if (signature) {
    -+	if (sig_sha1 || sig_sha256) {
    ++	if (signatures.nr) {
      		switch (signed_commit_mode) {
      		case SIGN_ABORT:
      			die("encountered signed commit %s; use "
    -@@ builtin/fast-export.c: static void handle_commit(struct commit *commit, struct rev_info *rev,
    - 				oid_to_hex(&commit->object.oid));
    + 			    "--signed-commits=<mode> to handle it",
    + 			    oid_to_hex(&commit->object.oid));
    + 		case SIGN_WARN_VERBATIM:
    +-			warning("exporting signed commit %s",
    +-				oid_to_hex(&commit->object.oid));
    ++			warning("exporting %"PRIuMAX" signature(s) for commit %s",
    ++				(uintmax_t)signatures.nr, oid_to_hex(&commit->object.oid));
      			/* fallthru */
      		case SIGN_VERBATIM:
     -			printf("gpgsig %s\ndata %u\n%s",
     -			       signature_alg,
     -			       (unsigned)strlen(signature),
     -			       signature);
    -+			print_signature(sig_sha1, "sha1");
    -+			print_signature(sig_sha256, "sha256");
    ++			for (size_t i = 0; i < signatures.nr; i++) {
    ++				struct string_list_item *item = &signatures.items[i];
    ++				print_signature(item->string, item->util);
    ++			}
      			break;
      		case SIGN_WARN_STRIP:
     -			warning("stripping signature from commit %s",
    @@ builtin/fast-export.c: static void handle_commit(struct commit *commit, struct r
      			break;
      		}
     -		free((char *)signature);
    -+		free((char *)sig_sha1);
    -+		free((char *)sig_sha256);
    ++		string_list_clear(&signatures, 0);
      	}
      	if (!reencoded && encoding)
      		printf("encoding %.*s\n", (int)encoding_len, encoding);
    @@ builtin/fast-import.c: static struct hash_list *parse_merge(unsigned int *count)
     +			    const char *hash_type)
     +{
     +	if (stored_sig->hash_algo) {
    -+		warning("Multiple %s signatures found, ignoring additional signature",
    ++		warning("multiple %s signatures found, "
    ++			"ignoring additional signature",
     +			hash_type);
     +		strbuf_release(&new_sig->data);
     +		free(new_sig->hash_algo);
    @@ t/t9350-fast-export.sh: test_expect_success GPG 'signed-commits=abort' '
      
      	git fast-export --signed-commits=verbatim --reencode=no commit-signing >output &&
     -	grep "^gpgsig sha" output &&
    -+	test_grep -E "^gpgsig sha(1|256) openpgp" output &&
    ++	test_grep -E "^gpgsig $GIT_DEFAULT_HASH openpgp" output &&
      	grep "encoding ISO-8859-1" output &&
      	(
      		cd new &&
    @@ t/t9350-fast-export.sh: test_expect_success GPG 'signed-commits=verbatim' '
      
      	git fast-export --signed-commits=warn-verbatim --reencode=no commit-signing >output 2>err &&
     -	grep "^gpgsig sha" output &&
    -+	test_grep -E "^gpgsig sha(1|256) openpgp" output &&
    ++	test_grep -E "^gpgsig $GIT_DEFAULT_HASH openpgp" output &&
      	grep "encoding ISO-8859-1" output &&
      	test -s err &&
      	(
    @@ t/t9350-fast-export.sh: test_expect_success GPG 'signed-commits=warn-strip' '
     +test_expect_success GPGSM 'round-trip X.509 signed commit' '
     +
     +	git fast-export --signed-commits=verbatim x509-signing >output &&
    -+	test_grep -E "^gpgsig sha(1|256) x509" output &&
    ++	test_grep -E "^gpgsig $GIT_DEFAULT_HASH x509" output &&
     +	(
     +		cd new &&
     +		git fast-import &&
    @@ t/t9350-fast-export.sh: test_expect_success GPG 'signed-commits=warn-strip' '
     +test_expect_success GPGSSH 'round-trip SSH signed commit' '
     +
     +	git fast-export --signed-commits=verbatim ssh-signing >output &&
    -+	test_grep -E "^gpgsig sha(1|256) ssh" output &&
    ++	test_grep -E "^gpgsig $GIT_DEFAULT_HASH ssh" output &&
     +	(
     +		cd new &&
     +		git fast-import &&
    @@ t/t9350-fast-export.sh: test_expect_success GPG 'signed-commits=warn-strip' '
      test_expect_success 'setup submodule' '
      
      	test_config_global protocol.file.allow always &&
    +@@ t/t9350-fast-export.sh: test_expect_success 'fast-export handles --end-of-options' '
    + 	test_cmp expect actual
    + '
    + 
    ++test_expect_success GPG 'setup a commit with dual signatures on its SHA-1 and SHA-256 formats' '
    ++	# Create a signed SHA-256 commit
    ++	git init --object-format=sha256 explicit-sha256 &&
    ++	git -C explicit-sha256 config extensions.compatObjectFormat sha1 &&
    ++	git -C explicit-sha256 checkout -b dual-signed &&
    ++	test_commit -C explicit-sha256 A &&
    ++	echo B >explicit-sha256/B &&
    ++	git -C explicit-sha256 add B &&
    ++	test_tick &&
    ++	git -C explicit-sha256 commit -S -m "signed" B &&
    ++	SHA256_B=$(git -C explicit-sha256 rev-parse dual-signed) &&
    ++
    ++	# Create the corresponding SHA-1 commit
    ++	SHA1_B=$(git -C explicit-sha256 rev-parse --output-object-format=sha1 dual-signed) &&
    ++
    ++	# Check that the resulting SHA-1 commit has both signatures
    ++	echo $SHA1_B | git -C explicit-sha256 cat-file --batch >out &&
    ++	test_grep -E "^gpgsig " out &&
    ++	test_grep -E "^gpgsig-sha256 " out
    ++'
    ++
    ++test_expect_success GPG 'export and import of doubly signed commit' '
    ++	git -C explicit-sha256 fast-export --signed-commits=verbatim dual-signed >output &&
    ++	test_grep -E "^gpgsig sha1 openpgp" output &&
    ++	test_grep -E "^gpgsig sha256 openpgp" output &&
    ++
    ++	(
    ++		cd new &&
    ++		git fast-import &&
    ++		git cat-file commit refs/heads/dual-signed >actual &&
    ++		test_grep -E "^gpgsig " actual &&
    ++		test_grep -E "^gpgsig-sha256 " actual &&
    ++		IMPORTED=$(git rev-parse refs/heads/dual-signed) &&
    ++		if test "$GIT_DEFAULT_HASH" = "sha1"
    ++		then
    ++			test $SHA1_B = $IMPORTED
    ++		else
    ++			test $SHA256_B = $IMPORTED
    ++		fi
    ++	) <output
    ++'
    ++
    + test_done


 Documentation/git-fast-export.adoc |  17 +++++
 Documentation/git-fast-import.adoc |  36 +++++++--
 builtin/fast-export.c              |  62 +++++++++++----
 builtin/fast-import.c              | 118 +++++++++++++++++++++++------
 gpg-interface.c                    |  12 +++
 gpg-interface.h                    |  12 +++
 t/t9350-fast-export.sh             | 102 ++++++++++++++++++++++++-
 7 files changed, 315 insertions(+), 44 deletions(-)

diff --git a/Documentation/git-fast-export.adoc b/Documentation/git-fast-export.adoc
index 43bbb4f63c..297b57bb2e 100644
--- a/Documentation/git-fast-export.adoc
+++ b/Documentation/git-fast-export.adoc
@@ -50,6 +50,23 @@ resulting tag will have an invalid signature.
 	is the same as how earlier versions of this command without
 	this option behaved.
 +
+When exported, a signature starts with:
++
+gpgsig <git-hash-algo> <signature-format>
++
+where <git-hash-algo> is the Git object hash so either "sha1" or
+"sha256", and <signature-format> is the signature type, so "openpgp",
+"x509", "ssh" or "unknown".
++
+For example, an OpenPGP signature on a SHA-1 commit starts with
+`gpgsig sha1 openpgp`, while an SSH signature on a SHA-256 commit
+starts with `gpgsig sha256 ssh`.
++
+While all the signatures of a commit are exported, an importer may
+choose to accept only some of them. For example
+linkgit:git-fast-import[1] currently stores at most one signature per
+Git hash algorithm in each commit.
++
 NOTE: This is highly experimental and the format of the data stream may
 change in the future without compatibility guarantees.
 
diff --git a/Documentation/git-fast-import.adoc b/Documentation/git-fast-import.adoc
index 250d866652..89dec1108f 100644
--- a/Documentation/git-fast-import.adoc
+++ b/Documentation/git-fast-import.adoc
@@ -445,7 +445,7 @@ one).
 	original-oid?
 	('author' (SP <name>)? SP LT <email> GT SP <when> LF)?
 	'committer' (SP <name>)? SP LT <email> GT SP <when> LF
-	('gpgsig' SP <alg> LF data)?
+	('gpgsig' SP <algo> SP <format> LF data)?
 	('encoding' SP <encoding> LF)?
 	data
 	('from' SP <commit-ish> LF)?
@@ -518,13 +518,37 @@ their syntax.
 ^^^^^^^^
 
 The optional `gpgsig` command is used to include a PGP/GPG signature
-that signs the commit data.
+or other cryptographic signature that signs the commit data.
 
-Here <alg> specifies which hashing algorithm is used for this
-signature, either `sha1` or `sha256`.
+....
+	'gpgsig' SP <git-hash-algo> SP <signature-format> LF
+	data
+....
+
+The `gpgsig` command takes two arguments:
+
+* `<git-hash-algo>` specifies which Git object format this signature
+  applies to, either `sha1` or `sha256`. This allows to know which
+  representation of the commit was signed (the SHA-1 or the SHA-256
+  version) which helps with both signature verification and
+  interoperability between repos with different hash functions.
+
+* `<signature-format>` specifies the type of signature, such as
+  `openpgp`, `x509`, `ssh`, or `unknown`. This is a convenience for
+  tools that process the stream, so they don't have to parse the ASCII
+  armor to identify the signature type.
+
+A commit may have at most one signature for the SHA-1 object format
+(stored in the "gpgsig" header) and one for the SHA-256 object format
+(stored in the "gpgsig-sha256" header).
+
+See below for a detailed description of the `data` command which
+contains the raw signature data.
+
+Signatures are not yet checked in the current implementation though.
 
-NOTE: This is highly experimental and the format of the data stream may
-change in the future without compatibility guarantees.
+NOTE: This is highly experimental and the format of the `gpgsig`
+command may change in the future without compatibility guarantees.
 
 `encoding`
 ^^^^^^^^^^
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index fcf6b00d5f..7b4e6a6e41 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -29,6 +29,7 @@
 #include "quote.h"
 #include "remote.h"
 #include "blob.h"
+#include "gpg-interface.h"
 
 static const char *const fast_export_usage[] = {
 	N_("git fast-export [<rev-list-opts>]"),
@@ -652,6 +653,38 @@ static const char *find_commit_multiline_header(const char *msg,
 	return strbuf_detach(&val, NULL);
 }
 
+static void print_signature(const char *signature, const char *object_hash)
+{
+	if (!signature)
+		return;
+
+	printf("gpgsig %s %s\ndata %u\n%s\n",
+	       object_hash,
+	       get_signature_format(signature),
+	       (unsigned)strlen(signature),
+	       signature);
+}
+
+static const char *append_signatures_for_header(struct string_list *signatures,
+						const char *pos,
+						const char *header,
+						const char *object_hash)
+{
+	const char *signature;
+	const char *start = pos;
+	const char *end = pos;
+
+	while ((signature = find_commit_multiline_header(start + 1,
+							 header,
+							 &end))) {
+		string_list_append(signatures, signature)->util = (void *)object_hash;
+		free((char *)signature);
+		start = end;
+	}
+
+	return end;
+}
+
 static void handle_commit(struct commit *commit, struct rev_info *rev,
 			  struct string_list *paths_of_changed_objects)
 {
@@ -660,7 +693,7 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 	const char *author, *author_end, *committer, *committer_end;
 	const char *encoding = NULL;
 	size_t encoding_len;
-	const char *signature_alg = NULL, *signature = NULL;
+	struct string_list signatures = STRING_LIST_INIT_DUP;
 	const char *message;
 	char *reencoded = NULL;
 	struct commit_list *p;
@@ -700,10 +733,11 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 	}
 
 	if (*commit_buffer_cursor == '\n') {
-		if ((signature = find_commit_multiline_header(commit_buffer_cursor + 1, "gpgsig", &commit_buffer_cursor)))
-			signature_alg = "sha1";
-		else if ((signature = find_commit_multiline_header(commit_buffer_cursor + 1, "gpgsig-sha256", &commit_buffer_cursor)))
-			signature_alg = "sha256";
+		const char *after_sha1 = append_signatures_for_header(&signatures, commit_buffer_cursor,
+								      "gpgsig", "sha1");
+		const char *after_sha256 = append_signatures_for_header(&signatures, commit_buffer_cursor,
+									"gpgsig-sha256", "sha256");
+		commit_buffer_cursor = (after_sha1 > after_sha256) ? after_sha1 : after_sha256;
 	}
 
 	message = strstr(commit_buffer_cursor, "\n\n");
@@ -769,30 +803,30 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 	printf("%.*s\n%.*s\n",
 	       (int)(author_end - author), author,
 	       (int)(committer_end - committer), committer);
-	if (signature) {
+	if (signatures.nr) {
 		switch (signed_commit_mode) {
 		case SIGN_ABORT:
 			die("encountered signed commit %s; use "
 			    "--signed-commits=<mode> to handle it",
 			    oid_to_hex(&commit->object.oid));
 		case SIGN_WARN_VERBATIM:
-			warning("exporting signed commit %s",
-				oid_to_hex(&commit->object.oid));
+			warning("exporting %"PRIuMAX" signature(s) for commit %s",
+				(uintmax_t)signatures.nr, oid_to_hex(&commit->object.oid));
 			/* fallthru */
 		case SIGN_VERBATIM:
-			printf("gpgsig %s\ndata %u\n%s",
-			       signature_alg,
-			       (unsigned)strlen(signature),
-			       signature);
+			for (size_t i = 0; i < signatures.nr; i++) {
+				struct string_list_item *item = &signatures.items[i];
+				print_signature(item->string, item->util);
+			}
 			break;
 		case SIGN_WARN_STRIP:
-			warning("stripping signature from commit %s",
+			warning("stripping signature(s) from commit %s",
 				oid_to_hex(&commit->object.oid));
 			/* fallthru */
 		case SIGN_STRIP:
 			break;
 		}
-		free((char *)signature);
+		string_list_clear(&signatures, 0);
 	}
 	if (!reencoded && encoding)
 		printf("encoding %.*s\n", (int)encoding_len, encoding);
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index b2839c5f43..332073d0f6 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -29,6 +29,7 @@
 #include "commit-reach.h"
 #include "khash.h"
 #include "date.h"
+#include "gpg-interface.h"
 
 #define PACK_ID_BITS 16
 #define MAX_PACK_ID ((1<<PACK_ID_BITS)-1)
@@ -2718,15 +2719,87 @@ static struct hash_list *parse_merge(unsigned int *count)
 	return list;
 }
 
+struct signature_data {
+	char *hash_algo;      /* "sha1" or "sha256" */
+	char *sig_format;     /* "openpgp", "x509", "ssh", "unknown" */
+	struct strbuf data;   /* The actual signature data */
+};
+
+static void parse_one_signature(struct signature_data *sig, const char *v)
+{
+	char *args = xstrdup(v); /* Will be freed when sig->hash_algo is freed */
+	char *space = strchr(args, ' ');
+
+	if (!space)
+		die("Expected gpgsig format: 'gpgsig <hash-algo> <signature-format>', "
+		    "got 'gpgsig %s'", args);
+	*space++ = '\0';
+
+	sig->hash_algo = args;
+	sig->sig_format = space;
+
+	/* Remove any trailing newline from format */
+	space = strchr(sig->sig_format, '\n');
+	if (space)
+		*space = '\0';
+
+	/* Validate hash algorithm */
+	if (strcmp(sig->hash_algo, "sha1") &&
+	    strcmp(sig->hash_algo, "sha256"))
+		die("Unknown git hash algorithm in gpgsig: '%s'", sig->hash_algo);
+
+	/* Validate signature format */
+	if (!valid_signature_format(sig->sig_format))
+		die("Invalid signature format in gpgsig: '%s'", sig->sig_format);
+	if (!strcmp(sig->sig_format, "unknown"))
+		warning("'unknown' signature format in gpgsig");
+
+	/* Read signature data */
+	read_next_command();
+	parse_data(&sig->data, 0, NULL);
+}
+
+static void add_gpgsig_to_commit(struct strbuf *commit_data,
+				 const char *header,
+				 struct signature_data *sig)
+{
+	struct string_list siglines = STRING_LIST_INIT_NODUP;
+
+	if (!sig->hash_algo)
+		return;
+
+	strbuf_addstr(commit_data, header);
+	string_list_split_in_place(&siglines, sig->data.buf, "\n", -1);
+	strbuf_add_separated_string_list(commit_data, "\n ", &siglines);
+	strbuf_addch(commit_data, '\n');
+	string_list_clear(&siglines, 1);
+	strbuf_release(&sig->data);
+	free(sig->hash_algo);
+}
+
+static void store_signature(struct signature_data *stored_sig,
+			    struct signature_data *new_sig,
+			    const char *hash_type)
+{
+	if (stored_sig->hash_algo) {
+		warning("multiple %s signatures found, "
+			"ignoring additional signature",
+			hash_type);
+		strbuf_release(&new_sig->data);
+		free(new_sig->hash_algo);
+	} else {
+		*stored_sig = *new_sig;
+	}
+}
+
 static void parse_new_commit(const char *arg)
 {
-	static struct strbuf sig = STRBUF_INIT;
 	static struct strbuf msg = STRBUF_INIT;
-	struct string_list siglines = STRING_LIST_INIT_NODUP;
+	struct signature_data sig_sha1 = { NULL, NULL, STRBUF_INIT };
+	struct signature_data sig_sha256 = { NULL, NULL, STRBUF_INIT };
 	struct branch *b;
 	char *author = NULL;
 	char *committer = NULL;
-	char *sig_alg = NULL;
 	char *encoding = NULL;
 	struct hash_list *merge_list = NULL;
 	unsigned int merge_count;
@@ -2750,13 +2823,23 @@ static void parse_new_commit(const char *arg)
 	}
 	if (!committer)
 		die("Expected committer but didn't get one");
-	if (skip_prefix(command_buf.buf, "gpgsig ", &v)) {
-		sig_alg = xstrdup(v);
-		read_next_command();
-		parse_data(&sig, 0, NULL);
+
+	/* Process signatures (up to 2: one "sha1" and one "sha256") */
+	while (skip_prefix(command_buf.buf, "gpgsig ", &v)) {
+		struct signature_data sig = { NULL, NULL, STRBUF_INIT };
+
+		parse_one_signature(&sig, v);
+
+		if (!strcmp(sig.hash_algo, "sha1"))
+			store_signature(&sig_sha1, &sig, "SHA-1");
+		else if (!strcmp(sig.hash_algo, "sha256"))
+			store_signature(&sig_sha256, &sig, "SHA-256");
+		else
+			BUG("parse_one_signature() returned unknown hash algo");
+
 		read_next_command();
-	} else
-		strbuf_setlen(&sig, 0);
+	}
+
 	if (skip_prefix(command_buf.buf, "encoding ", &v)) {
 		encoding = xstrdup(v);
 		read_next_command();
@@ -2830,23 +2913,14 @@ static void parse_new_commit(const char *arg)
 		strbuf_addf(&new_data,
 			"encoding %s\n",
 			encoding);
-	if (sig_alg) {
-		if (!strcmp(sig_alg, "sha1"))
-			strbuf_addstr(&new_data, "gpgsig ");
-		else if (!strcmp(sig_alg, "sha256"))
-			strbuf_addstr(&new_data, "gpgsig-sha256 ");
-		else
-			die("Expected gpgsig algorithm sha1 or sha256, got %s", sig_alg);
-		string_list_split_in_place(&siglines, sig.buf, "\n", -1);
-		strbuf_add_separated_string_list(&new_data, "\n ", &siglines);
-		strbuf_addch(&new_data, '\n');
-	}
+
+	add_gpgsig_to_commit(&new_data, "gpgsig ", &sig_sha1);
+	add_gpgsig_to_commit(&new_data, "gpgsig-sha256 ", &sig_sha256);
+
 	strbuf_addch(&new_data, '\n');
 	strbuf_addbuf(&new_data, &msg);
-	string_list_clear(&siglines, 1);
 	free(author);
 	free(committer);
-	free(sig_alg);
 	free(encoding);
 
 	if (!store_object(OBJ_COMMIT, &new_data, NULL, &b->oid, next_mark))
diff --git a/gpg-interface.c b/gpg-interface.c
index 0896458de5..6f2d87475f 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -144,6 +144,18 @@ static struct gpg_format *get_format_by_sig(const char *sig)
 	return NULL;
 }
 
+const char *get_signature_format(const char *buf)
+{
+	struct gpg_format *format = get_format_by_sig(buf);
+	return format ? format->name : "unknown";
+}
+
+int valid_signature_format(const char *format)
+{
+       return (!!get_format_by_name(format) ||
+	       !strcmp(format, "unknown"));
+}
+
 void signature_check_clear(struct signature_check *sigc)
 {
 	FREE_AND_NULL(sigc->payload);
diff --git a/gpg-interface.h b/gpg-interface.h
index e09f12e8d0..60ddf8bbfa 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -47,6 +47,18 @@ struct signature_check {
 
 void signature_check_clear(struct signature_check *sigc);
 
+/*
+ * Return the format of the signature (like "openpgp", "x509", "ssh"
+ * or "unknown").
+ */
+const char *get_signature_format(const char *buf);
+
+/*
+ * Is the signature format valid (like "openpgp", "x509", "ssh" or
+ * "unknown")
+ */
+int valid_signature_format(const char *format);
+
 /*
  * Look at a GPG signed tag object.  If such a signature exists, store it in
  * signature and the signed content in payload.  Return 1 if a signature was
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 76619765fc..46700dbc40 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -314,7 +314,7 @@ test_expect_success GPG 'signed-commits=abort' '
 test_expect_success GPG 'signed-commits=verbatim' '
 
 	git fast-export --signed-commits=verbatim --reencode=no commit-signing >output &&
-	grep "^gpgsig sha" output &&
+	test_grep -E "^gpgsig $GIT_DEFAULT_HASH openpgp" output &&
 	grep "encoding ISO-8859-1" output &&
 	(
 		cd new &&
@@ -328,7 +328,7 @@ test_expect_success GPG 'signed-commits=verbatim' '
 test_expect_success GPG 'signed-commits=warn-verbatim' '
 
 	git fast-export --signed-commits=warn-verbatim --reencode=no commit-signing >output 2>err &&
-	grep "^gpgsig sha" output &&
+	test_grep -E "^gpgsig $GIT_DEFAULT_HASH openpgp" output &&
 	grep "encoding ISO-8859-1" output &&
 	test -s err &&
 	(
@@ -369,6 +369,62 @@ test_expect_success GPG 'signed-commits=warn-strip' '
 
 '
 
+test_expect_success GPGSM 'setup X.509 signed commit' '
+
+	git checkout -b x509-signing main &&
+	test_config gpg.format x509 &&
+	test_config user.signingkey $GIT_COMMITTER_EMAIL &&
+	echo "X.509 content" >file &&
+	git add file &&
+	git commit -S -m "X.509 signed commit" &&
+	X509_COMMIT=$(git rev-parse HEAD) &&
+	git checkout main
+
+'
+
+test_expect_success GPGSM 'round-trip X.509 signed commit' '
+
+	git fast-export --signed-commits=verbatim x509-signing >output &&
+	test_grep -E "^gpgsig $GIT_DEFAULT_HASH x509" output &&
+	(
+		cd new &&
+		git fast-import &&
+		git cat-file commit refs/heads/x509-signing >actual &&
+		grep "^gpgsig" actual &&
+		IMPORTED=$(git rev-parse refs/heads/x509-signing) &&
+		test $X509_COMMIT = $IMPORTED
+	) <output
+
+'
+
+test_expect_success GPGSSH 'setup SSH signed commit' '
+
+	git checkout -b ssh-signing main &&
+	test_config gpg.format ssh &&
+	test_config user.signingkey "${GPGSSH_KEY_PRIMARY}" &&
+	echo "SSH content" >file &&
+	git add file &&
+	git commit -S -m "SSH signed commit" &&
+	SSH_COMMIT=$(git rev-parse HEAD) &&
+	git checkout main
+
+'
+
+test_expect_success GPGSSH 'round-trip SSH signed commit' '
+
+	git fast-export --signed-commits=verbatim ssh-signing >output &&
+	test_grep -E "^gpgsig $GIT_DEFAULT_HASH ssh" output &&
+	(
+		cd new &&
+		git fast-import &&
+		git cat-file commit refs/heads/ssh-signing >actual &&
+		grep "^gpgsig" actual &&
+		IMPORTED=$(git rev-parse refs/heads/ssh-signing) &&
+		test $SSH_COMMIT = $IMPORTED
+	) <output
+
+'
+
 test_expect_success 'setup submodule' '
 
 	test_config_global protocol.file.allow always &&
@@ -905,4 +961,46 @@ test_expect_success 'fast-export handles --end-of-options' '
 	test_cmp expect actual
 '
 
+test_expect_success GPG 'setup a commit with dual signatures on its SHA-1 and SHA-256 formats' '
+	# Create a signed SHA-256 commit
+	git init --object-format=sha256 explicit-sha256 &&
+	git -C explicit-sha256 config extensions.compatObjectFormat sha1 &&
+	git -C explicit-sha256 checkout -b dual-signed &&
+	test_commit -C explicit-sha256 A &&
+	echo B >explicit-sha256/B &&
+	git -C explicit-sha256 add B &&
+	test_tick &&
+	git -C explicit-sha256 commit -S -m "signed" B &&
+	SHA256_B=$(git -C explicit-sha256 rev-parse dual-signed) &&
+
+	# Create the corresponding SHA-1 commit
+	SHA1_B=$(git -C explicit-sha256 rev-parse --output-object-format=sha1 dual-signed) &&
+
+	# Check that the resulting SHA-1 commit has both signatures
+	echo $SHA1_B | git -C explicit-sha256 cat-file --batch >out &&
+	test_grep -E "^gpgsig " out &&
+	test_grep -E "^gpgsig-sha256 " out
+'
+
+test_expect_success GPG 'export and import of doubly signed commit' '
+	git -C explicit-sha256 fast-export --signed-commits=verbatim dual-signed >output &&
+	test_grep -E "^gpgsig sha1 openpgp" output &&
+	test_grep -E "^gpgsig sha256 openpgp" output &&
+
+	(
+		cd new &&
+		git fast-import &&
+		git cat-file commit refs/heads/dual-signed >actual &&
+		test_grep -E "^gpgsig " actual &&
+		test_grep -E "^gpgsig-sha256 " actual &&
+		IMPORTED=$(git rev-parse refs/heads/dual-signed) &&
+		if test "$GIT_DEFAULT_HASH" = "sha1"
+		then
+			test $SHA1_B = $IMPORTED
+		else
+			test $SHA256_B = $IMPORTED
+		fi
+	) <output
+'
+
 test_done
-- 
2.50.0.174.gcf836c1ec7

