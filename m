Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E83259CBF
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 04:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763354115; cv=none; b=H8KnuSdDFDVRAwgSXxsId+JdvW9QgEwtGP30mIMUUHCtb7VwUTclkYjVO087xo/kyLUM0MhBTBpXM4XuBcaaBLXFlct8Keg6Wmr564UBg+OERqlk61Ia2dGu7XgIkgirwkurxGSh6kGAJNWI3gONG1Nj3SRlnknY6zVtM50aCNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763354115; c=relaxed/simple;
	bh=VgT9RrFG+jJOas9PifMrZhtvd0/ahmARgh8ORQemKgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HNmudpu1l10Dz/QOSQOQ6vuDQBDo99us10ehw0lF8LhUbXALHA/+eVL27VfyY0D7I87Iil8Lx0o+ojt4eu5rbW5iz+GHVNubaeWuDUnKdT9crZfPZwBNCiPY4jez5DfQtHmU/lTQnBDQ2/rdf1arROQZkzYxaRrh+Kooonsh3o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VdWXmaxH; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdWXmaxH"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42b2a0c18caso1924124f8f.1
        for <git@vger.kernel.org>; Sun, 16 Nov 2025 20:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763354111; x=1763958911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2JwE6XY2F+9c09fuSa6ZCi5ib6JsAqEoyK613g42lOM=;
        b=VdWXmaxHWu9Dce7aHTMjbujEgoZGanuVfWFzdnKTjvzfMfGsa5VRlCGWKBiOGKlzXi
         KcJbiU2GtUYeZl1ichd5763jdEG9hfD/wn9lHXUTeozi1GWxUdz3k5C0Il/nNJxtK0zq
         NKQvG51XSDL51P8KIL6Lb6/M+t3A/s9hgQEJ2YGG8hTNdjkA42SMzBlyDkClgtRVnupT
         ev+xcvs3odCJlyBQs3YV5Z2ZJ2H0A5P1xFRSqwEY87YBCaop1f4t5ADggvWXb/zPmxLL
         yg80uAMsQWIMJYQE1Hvn/YY3CswqnHdR+E/b3+fkdLdkYISWNI48Mg4pgrdj52MNj3Gq
         zveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763354111; x=1763958911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2JwE6XY2F+9c09fuSa6ZCi5ib6JsAqEoyK613g42lOM=;
        b=GhnCbQdz68piOPveiraTQQK4/JtjvdeTnYb/V3AqEzZ/CQphadxG7JcQSF8QpjXhCx
         Eo7I/4QwrG8Zpak/wMu9IdDOBrNtwi1BkTUUzxU72LU71QQYKbtKE/y0RTkDG465MORi
         L1Bmij781O0BFQByeQNpDG8z2a5h4bfy4poluHP0wqMaxOWaSJ55YW/nFgemI3T3mKwa
         hzgYCEeaXibCTHkgwlO8sd4ParU6lufsbVioYMb7ordMWTssUWfYf6n9nvFQrOWhlUr3
         10mtAgcd5dUPksmxFls9K/KZh5y3Loh+nhULQF9WsQA/JJyxv1uWz/FX+e4ZDwdAJDVN
         pGtg==
X-Gm-Message-State: AOJu0YyiOy/k2wtPdgtA22LuUT2T74qHMEOFHge/biX+Gd/cjAwcP6Xs
	t1moKZhF91qQZnK++veR60tBOwoV4SBfTtnCrbRLh02wI2x88wPrOlOXSUkQ3Q==
X-Gm-Gg: ASbGncuKdUzW1MYLHmFLG+vhcrdSssMXkuh0iXHMtmowZyFsoRJIiLAEb+DKr9djfx7
	rueSvBnBC+oQONyBbby3fUX2UIo4vwmxikWoeEG9xn8WUJW4TGxROCmTxd0R5x5sjJJU8MtqZtA
	1GfhaoYwNCsvY6N3Yb7GpiPWGMkMYjmPh2dc/tjYRGNCfWgq3r+V61vfQruEBgbNwt8qf92oTYa
	WVTKFimzS7khNzKfNtxVpyDLKpLQ6lLgEHGmEbKjdPdvJW73pnvnYa1bkHbEV/EIXRA45He2m5+
	IQw2rUCqyKE5FYuM6CF6NdwNywl7UXcKD1dlpwr7EMVvm7fmhQEeYHhuGuMXpBnuGr2pVTShgFb
	juHcQLlrv7XIyUegZZHE+9EMWQBiNMg0F9aFTKG4gqy3VSWOBxNxS0w7PsnWztTEq+ecmA+N1P9
	wWQmLne3zO9aJuPu1wFrlXk1ns2+I7zRgzawdA7w==
X-Google-Smtp-Source: AGHT+IHqS7XiVDPBCiPFTcVKe9cSBxN/ypHAmuw2HqUO00Z3bfBZU4OanSm4g0P278m2JBwQgTIDUg==
X-Received: by 2002:a05:6000:1ace:b0:3eb:d906:e553 with SMTP id ffacd0b85a97d-42b595bb7f6mr10261886f8f.55.1763354110881;
        Sun, 16 Nov 2025 20:35:10 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e85627sm25115284f8f.16.2025.11.16.20.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 20:35:09 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 0/3] fast-import: add 'strip-if-invalid' mode to --signed-commits=<mode>
Date: Mon, 17 Nov 2025 05:34:47 +0100
Message-ID: <20251117043450.322644-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.52.0.rc2.6.g1f299c9613
In-Reply-To: <20251105061918.3688870-1-christian.couder@gmail.com>
References: <20251105061918.3688870-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduction
============

Tools like `git filter-repo` are often used to rewrite recent
history. When there are tags or commit signatures, such signatures
related to the rewritten history would become invalid though. A way to
address this issue could be to strip signatures when they have become
invalid.

The `--signed-commits=<mode>` option in `git fast-import` allows users
to decide what should be done when commits with signatures are
imported.

So let's add a new 'strip-if-invalid' <mode> to that option.

Maybe this new mode should become the default mode, but this would be
breaking backward compatibility, and perhaps this could be decided
after other new modes that might be even better default modes have
been added. So we leave that for future work.

This 'strip-if-invalid' mode should also be added to
`--signed-tags=<mode>`, but we leave that for future work too.

Changes since v1
================

Thanks Junio and Elijah for reviewing and commenting on v1.

There are no code changes in this v2, only commit message,
documentation and test changes:

* Rebased on current 'master'. This avoids the need to mark some
  strings for translation as a recent series doing that has been
  recently merged to 'master'.

* In patch 3/3, improved the commit message to better justify the new
  feature using some sentences from Elijah.

* In patch 3/3, removed tests with dual signatures. This avoids a
  conflict with a separate series from brian carlson that adds a
  "RUST" prereq that is then needed to run tests with dual signatures.

* In patch 3/3, improved documentation of the new option to say that
  validation behaves as the validation performed by `git
  verify-commit`.

CI tests
========

They have all passed, see:

https://github.com/chriscool/git/actions/runs/19390756104

Range diff vs v1
================

1:  02ce924afd = 1:  ec2afd95d6 fast-import: refactor finalize_commit_buffer()
2:  1593adc7b2 = 2:  d22b753817 commit: refactor verify_commit_buffer()
3:  f264cd25e5 ! 3:  e325533de4 fast-import: add 'strip-if-invalid' mode to --signed-commits=<mode>
    @@ Commit message
         in the repository history made by the tool between the fast-export
         and the fast-import steps.
     
    +    Note that as far as signature handling goes:
    +
    +      * Since fast-export doesn't know what changes filter-repo may make
    +    to the stream, it can't know whether the signatures will still be
    +    valid.
    +
    +      * Since filter-repo doesn't know what history canonicalizations
    +    fast-export performed (and it performs a few), it can't know whether
    +    the signatures will still be valid.
    +
    +      * Therefore, fast-import is the only process in the pipeline that
    +    can know whether a specified signature remains valid.
    +
         Having invalid signatures in a rewritten repository could be
         confusing, so users rewritting history might prefer to simply
         discard signatures that are invalid at the fast-import step.
     
    +    For example a common use case is to rewrite only "recent" history.
    +    While specifying commit ranges corresponding to "recent" commits
    +    could work, users worry about getting it wrong and want to just
    +    automatically rewrite everything, expecting older commit signatures
    +    to be untouched.
    +
         To let them do that, let's add a new 'strip-if-invalid' mode to the
         `--signed-commits=<mode>` option of `git fast-import`.
     
    @@ Commit message
         For now let's just die() if 'strip-if-invalid' is passed to these
         options where it hasn't been implemented yet.
     
    -    While at it, let's also mark for translation some error messages
    -    linked to the `--signed-commits=<mode>` and `--signed-tags=<mode>`
    -    in `git fast-export`.
    -
         [1]: https://github.com/newren/git-filter-repo
     
    +    Helped-by: Elijah Newren <newren@gmail.com>
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
     
      ## Documentation/git-fast-import.adoc ##
    @@ Documentation/git-fast-import.adoc: fast-import stream! This option is enabled a
     +* `strip` will silently make the commits unsigned.
     +* `warn-strip` will make them unsigned, but will display a warning.
     +* `strip-if-invalid` will check signatures and, if they are invalid,
    -+  will strip them and display a warning.
    ++  will strip them and display a warning. The validation is performed
    ++  in the same way as linkgit:git-verify-commit[1] does it.
      
      Options for Frontends
      ~~~~~~~~~~~~~~~~~~~~~
    @@ builtin/fast-export.c: static void handle_commit(struct commit *commit, struct r
      	if (signatures.nr) {
      		switch (signed_commit_mode) {
     -		case SIGN_ABORT:
    --			die("encountered signed commit %s; use "
    --			    "--signed-commits=<mode> to handle it",
    +-			die(_("encountered signed commit %s; use "
    +-			      "--signed-commits=<mode> to handle it"),
     -			    oid_to_hex(&commit->object.oid));
     +
     +		/* Exporting modes */
      		case SIGN_WARN_VERBATIM:
    --			warning("exporting %"PRIuMAX" signature(s) for commit %s",
    -+			warning(_("exporting %"PRIuMAX" signature(s) for commit %s"),
    + 			warning(_("exporting %"PRIuMAX" signature(s) for commit %s"),
      				(uintmax_t)signatures.nr, oid_to_hex(&commit->object.oid));
    - 			/* fallthru */
    - 		case SIGN_VERBATIM:
     @@ builtin/fast-export.c: static void handle_commit(struct commit *commit, struct rev_info *rev,
      				print_signature(item->string, item->util);
      			}
    @@ builtin/fast-export.c: static void handle_commit(struct commit *commit, struct r
     +
     +		/* Stripping modes */
      		case SIGN_WARN_STRIP:
    --			warning("stripping signature(s) from commit %s",
    -+			warning(_("stripping signature(s) from commit %s"),
    + 			warning(_("stripping signature(s) from commit %s"),
      				oid_to_hex(&commit->object.oid));
      			/* fallthru */
      		case SIGN_STRIP:
    @@ builtin/fast-export.c: static void handle_tag(const char *name, struct tag *tag)
      		if (sig_offset < message_size)
      			switch (signed_tag_mode) {
     -			case SIGN_ABORT:
    --				die("encountered signed tag %s; use "
    --				    "--signed-tags=<mode> to handle it",
    +-				die(_("encountered signed tag %s; use "
    +-				      "--signed-tags=<mode> to handle it"),
     -				    oid_to_hex(&tag->object.oid));
     +
     +			/* Exporting modes */
      			case SIGN_WARN_VERBATIM:
    --				warning("exporting signed tag %s",
    -+				warning(_("exporting signed tag %s"),
    + 				warning(_("exporting signed tag %s"),
      					oid_to_hex(&tag->object.oid));
      				/* fallthru */
      			case SIGN_VERBATIM:
    @@ builtin/fast-export.c: static void handle_tag(const char *name, struct tag *tag)
     +
     +			/* Stripping modes */
      			case SIGN_WARN_STRIP:
    --				warning("stripping signature from tag %s",
    -+				warning(_("stripping signature from tag %s"),
    + 				warning(_("stripping signature from tag %s"),
      					oid_to_hex(&tag->object.oid));
    - 				/* fallthru */
    +@@ builtin/fast-export.c: static void handle_tag(const char *name, struct tag *tag)
      			case SIGN_STRIP:
      				message_size = sig_offset;
      				break;
    @@ t/t9305-fast-import-signatures.sh: test_expect_success GPG 'strip both OpenPGP s
     +	test_grep "stripping invalid signature" log
     +'
     +
    -+test_expect_success GPG 'keep valid dual OpenPGP signatures with --signed-commits=strip-if-invalid' '
    -+	rm -rf new &&
    -+	git init new &&
    -+
    -+	git -C explicit-sha256 fast-export --signed-commits=verbatim dual-signed >output &&
    -+	git -C new fast-import --quiet --signed-commits=strip-if-invalid <output >log 2>&1 &&
    -+
    -+	git -C new cat-file commit refs/heads/dual-signed >actual &&
    -+	test_grep -E "^gpgsig " actual &&
    -+	test_grep -E "^gpgsig-sha256 " actual &&
    -+	test_must_be_empty log &&
    -+
    -+	IMPORTED=$(git -C new rev-parse refs/heads/dual-signed) &&
    -+	if test "$GIT_DEFAULT_HASH" = "sha1"
    -+	then
    -+		test $SHA1_B = $IMPORTED
    -+	else
    -+		test $SHA256_B = $IMPORTED
    -+	fi
    -+'
    -+
    -+test_expect_success GPG 'strip both invalid dual OpenPGP signatures with --signed-commits=strip-if-invalid' '
    -+	rm -rf new &&
    -+	git init new &&
    -+
    -+	git -C explicit-sha256 fast-export --signed-commits=verbatim dual-signed >output &&
    -+
    -+	# Change the commit message, which invalidates the signature.
    -+	# The commit message length should not change though, otherwise the
    -+	# corresponding `data <length>` command would have to be changed too.
    -+	sed "s/signed commit/forged commit/" output >modified &&
    -+
    -+	git -C new fast-import --quiet --signed-commits=strip-if-invalid <modified >log 2>&1 &&
    -+
    -+	git -C new cat-file commit refs/heads/dual-signed >actual &&
    -+	test_grep ! -E "^gpgsig " actual &&
    -+	test_grep ! -E "^gpgsig-sha256 " actual &&
    -+
    -+	IMPORTED=$(git -C new rev-parse refs/heads/dual-signed) &&
    -+	if test "$GIT_DEFAULT_HASH" = "sha1"
    -+	then
    -+		test $SHA1_B != $IMPORTED
    -+	else
    -+		test $SHA256_B != $IMPORTED
    -+	fi &&
    -+
    -+	test_grep "stripping invalid signature" log
    -+'
    -+
     +test_expect_success GPGSM 'keep valid X.509 signature with --signed-commits=strip-if-invalid' '
     +	rm -rf new &&
     +	git init new &&


Christian Couder (3):
  fast-import: refactor finalize_commit_buffer()
  commit: refactor verify_commit_buffer()
  fast-import: add 'strip-if-invalid' mode to --signed-commits=<mode>

 Documentation/git-fast-import.adoc | 29 ++++++++----
 builtin/fast-export.c              | 38 +++++++++++----
 builtin/fast-import.c              | 74 ++++++++++++++++++++++++++----
 commit.c                           | 17 ++++++-
 commit.h                           |  7 +++
 gpg-interface.c                    |  2 +
 gpg-interface.h                    |  1 +
 t/t9305-fast-import-signatures.sh  | 69 +++++++++++++++++++++++++++-
 8 files changed, 208 insertions(+), 29 deletions(-)

-- 
2.52.0.rc2.6.g1f299c9613

