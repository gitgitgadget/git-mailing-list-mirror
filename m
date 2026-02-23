Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC87371056
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 19:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771875743; cv=none; b=SYUyAJtnZITbPpHEFeqsvXap4NWKwhYfqMlwGSCNNy/KgXRJo9e+Avcls6FOs4SnNjOZGMnInqzpMZUVmlO/tl8nnojQcye7JpZ/4EH+WWACZS7HzKPewqVOu0mrU5o/ZklcpoZtavN0XZygIk0/tUyNN50L/X5voHPt+4xehlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771875743; c=relaxed/simple;
	bh=GgnyW1MjfGCUavwkcIlHT2gpEm1qmQPGmiCgOaT4G1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lw5v7zyyHyElCXGFS3I0xP0GYY+C2ow/U9+w/dkz+mKr5pmkEUARnw6+6OqxHw9qhJkhJ9+IR/TrLEzUidaVo9j3zFCTHsokJXOjgC45Bsgy6MgOCvU8ddOfQejgUsKJN9XdINBsYKQUQTXnFgPJk+bOzaQMSVrXpT96BSKQ5oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCJjILCN; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCJjILCN"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-46394090d2fso1408865b6e.3
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 11:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771875740; x=1772480540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVlGAC6tM4/2gKKUV2RJldT3aH9nXpo2pe4PkFEnuuM=;
        b=cCJjILCN8bPHm+q7Ir21z1a+mxEZ97S3gs97DI+HhP8jkSq/fo1dr96zzzOZVpt3r1
         NJBd0+bC+qSBoP+AJ1vut1tISn1WYAvPT7Myrkj1E8X7BhO+xkZRF9Bt0ZpVF6dxZmSA
         RAaCktLzw4NwYqhDeEckxqAjmdEP2/C7iBJOTNbQ2bOi334O6R6jOsDhdGbhjXBD3eTn
         WiEKqpMLEhLDxcsNzjTzbw51DIlQfVBBqijV7XzmlUyN+QeMPkscEdEdumHQD9JzpVSP
         8iOuvbHlRxT2RR4ZK/7O27lZ7e/OmJQ4Xt1jHj4pgeGg9Z11A59QTkK8BY3aWpQazFUD
         UqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771875740; x=1772480540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eVlGAC6tM4/2gKKUV2RJldT3aH9nXpo2pe4PkFEnuuM=;
        b=uvLZC8N+IpCS45FgTugHJ9SNzLxgEQcgzY11cAe4LrhG0K2lWfYVa8r+PNbK7RW+X2
         Ey6fPSzrLFacgW4bf7/YJ912b7a2i5LfWEbZOG4TQfQaDNfHdq86wYxYkeDfno+jt6tL
         BJ0ErAFznbqrYgKxhP/YvY9LeQgJRsQOZ/6fR/dC2fzz9htbMIlzas1dSrh2I+mgB5e+
         q14QPPfGqt6fYwo9ZaX7vIcDVMHbRzyyN1UY8KwCT/UKOcXd2DmO8DOp0WuPN+UuR4mv
         BOImvHw5/894ytRj5ClIuNUfl8jHm5XQiYtJc9TCb/zA643UogHcdTbDPvyAj8e56k8Q
         yJwA==
X-Gm-Message-State: AOJu0YytQ0uKw/JDeQINbKI3/IOh6gWyiIkjPK7R3VOHKnas1daCtqPc
	Cj40r+E01lDtZvkR6dGtbsiVgtkoNWEOq1LUkyHiK0OVCfZ7YHGjEjq4wUVyYg==
X-Gm-Gg: AZuq6aLNAj6/AxgZavklbMoJaitcBPI7QZcB9ldJD/pE6ikknpqZ1nXwaNiCRLaPLD5
	ylxcX0utYyWuYsu7BLeGamS5QE+i+3dzgTM5awFhnmZToVZPKEFz3vcS85wt5xEPTueeOmAtc4s
	8ubBzPwmNJRg7/B5Kr/Z9KDiYxqfXX+C55fVQ+NiLnuvYbWXXKNVpIThur7Y/DWC52YqXvRgeDH
	VpJ/4n30E3p9v0Y+9t6JoT2UWNeGkZ13QEiEYXyb90S+nP50zo436Hyx0dZsdOPenPEaSAlF4MG
	2Tzmv8bbaUHamtCaHQ0zkusH+IiWBIoHGUYpj90ATGB2gWgr7bPGYCITOVO22RlMPjT28ME2ktw
	WII+DGK9zYnTK+zy1VHP7u6X4I1/nzd9co5pflddyKYlE7nKS5PuWxi3zYdjh5ZMAwRAzC259Oe
	UB5dUypAd2WYtHu8+9B4sHMAgtIVfg4Cg=
X-Received: by 2002:a05:6808:1641:b0:45f:21a:4995 with SMTP id 5614622812f47-46446196631mr5673608b6e.23.1771875739913;
        Mon, 23 Feb 2026 11:42:19 -0800 (PST)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4157d3a9121sm8051179fac.19.2026.02.23.11.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 11:42:19 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: sandals@crustytoothpaste.net,
	christian.couder@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 2/2] fast-import: add mode to re-sign invalid commit signatures
Date: Mon, 23 Feb 2026 13:41:46 -0600
Message-ID: <20260223194146.3476768-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260223194146.3476768-1-jltobler@gmail.com>
References: <20260223194146.3476768-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With git-fast-import(1), handling of signed commits is controlled via
the `--signed-commits=<mode>` option. When an invalid signature is
encountered, a user may want the option to re-sign the commit as opposed
to just stripping the signature. To faciliate this, introduce a
"re-sign-if-invalid" mode for the `--signed-commits` option.

Note that commits are re-signed using only the repository object format
hash algorithm. If a commit has an additional signature due to the
`compatObjectFormat` repository extension being set, the other signature
is stripped.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 Documentation/git-fast-import.adoc |   3 +
 builtin/fast-export.c              |   6 ++
 builtin/fast-import.c              |  43 +++++++--
 gpg-interface.c                    |   2 +
 gpg-interface.h                    |   1 +
 t/t9305-fast-import-signatures.sh  | 142 +++++++++++++++--------------
 6 files changed, 125 insertions(+), 72 deletions(-)

diff --git a/Documentation/git-fast-import.adoc b/Documentation/git-fast-import.adoc
index 479c4081da..b902a6e2b0 100644
--- a/Documentation/git-fast-import.adoc
+++ b/Documentation/git-fast-import.adoc
@@ -86,6 +86,9 @@ already trusted to run their own code.
 * `strip-if-invalid` will check signatures and, if they are invalid,
   will strip them and display a warning. The validation is performed
   in the same way as linkgit:git-verify-commit[1] does it.
+* `re-sign-if-invalid` is the same as `strip-if-invalid`, but additionally the
+  commits with invalid signatures are signed again, so that old invalid
+  signatures are replaced with new valid ones.
 
 Options for Frontends
 ~~~~~~~~~~~~~~~~~~~~~
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 0c5d2386d8..76fad1dec5 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -825,6 +825,9 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 		case SIGN_STRIP_IF_INVALID:
 			die(_("'strip-if-invalid' is not a valid mode for "
 			      "git fast-export with --signed-commits=<mode>"));
+		case SIGN_RESIGN_IF_INVALID:
+			die(_("'re-sign-if-invalid' is not a valid mode for "
+			      "git fast-export with --signed-commits=<mode>"));
 		default:
 			BUG("invalid signed_commit_mode value %d", signed_commit_mode);
 		}
@@ -970,6 +973,9 @@ static void handle_tag(const char *name, struct tag *tag)
 			case SIGN_STRIP_IF_INVALID:
 				die(_("'strip-if-invalid' is not a valid mode for "
 				      "git fast-export with --signed-tags=<mode>"));
+			case SIGN_RESIGN_IF_INVALID:
+				die(_("'re-sign-if-invalid' is not a valid mode for "
+				      "git fast-export with --signed-tags=<mode>"));
 			default:
 				BUG("invalid signed_commit_mode value %d", signed_commit_mode);
 			}
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index b8a7757cfd..e34a373d2f 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -2836,10 +2836,11 @@ static void finalize_commit_buffer(struct strbuf *new_data,
 	strbuf_addbuf(new_data, msg);
 }
 
-static void handle_strip_if_invalid(struct strbuf *new_data,
-				    struct signature_data *sig_sha1,
-				    struct signature_data *sig_sha256,
-				    struct strbuf *msg)
+static void handle_invalid_signature(struct strbuf *new_data,
+				     struct signature_data *sig_sha1,
+				     struct signature_data *sig_sha256,
+				     struct strbuf *msg,
+				     enum sign_mode mode)
 {
 	struct strbuf tmp_buf = STRBUF_INIT;
 	struct signature_check signature_check = { 0 };
@@ -2866,6 +2867,30 @@ static void handle_strip_if_invalid(struct strbuf *new_data,
 			warning(_("stripping invalid signature for commit\n"
 				  "  allegedly by %s"), signer);
 
+		if (mode == SIGN_RESIGN_IF_INVALID) {
+			struct strbuf signature = STRBUF_INIT;
+			struct strbuf payload = STRBUF_INIT;
+			char *key = get_signing_key();
+
+			/*
+			 * Commits are resigned using the repository object
+			 * format hash algorithm only. Consequently if
+			 * extensions.compatObjectFormat is set, the
+			 * compatability hash is not currently used to
+			 * additionally sign the commit. If the commit payload
+			 * were reconstructed in the compatability format, it
+			 * would be possible to generate the other signature
+			 * accordingly though.
+			 */
+			strbuf_addstr(&payload, signature_check.payload);
+			sign_buffer(&payload, &signature, key);
+			add_header_signature(new_data, &signature, the_hash_algo);
+
+			strbuf_release(&signature);
+			strbuf_release(&payload);
+			free(key);
+		}
+
 		finalize_commit_buffer(new_data, NULL, NULL, msg);
 	} else {
 		strbuf_swap(new_data, &tmp_buf);
@@ -2927,6 +2952,7 @@ static void parse_new_commit(const char *arg)
 			/* fallthru */
 		case SIGN_VERBATIM:
 		case SIGN_STRIP_IF_INVALID:
+		case SIGN_RESIGN_IF_INVALID:
 			import_one_signature(&sig_sha1, &sig_sha256, v);
 			break;
 
@@ -3011,9 +3037,11 @@ static void parse_new_commit(const char *arg)
 			"encoding %s\n",
 			encoding);
 
-	if (signed_commit_mode == SIGN_STRIP_IF_INVALID &&
+	if ((signed_commit_mode == SIGN_STRIP_IF_INVALID ||
+	     signed_commit_mode == SIGN_RESIGN_IF_INVALID) &&
 	    (sig_sha1.hash_algo || sig_sha256.hash_algo))
-		handle_strip_if_invalid(&new_data, &sig_sha1, &sig_sha256, &msg);
+		handle_invalid_signature(&new_data, &sig_sha1, &sig_sha256, &msg,
+					 signed_commit_mode);
 	else
 		finalize_commit_buffer(&new_data, &sig_sha1, &sig_sha256, &msg);
 
@@ -3060,6 +3088,9 @@ static void handle_tag_signature(struct strbuf *msg, const char *name)
 	case SIGN_STRIP_IF_INVALID:
 		die(_("'strip-if-invalid' is not a valid mode for "
 		      "git fast-import with --signed-tags=<mode>"));
+	case SIGN_RESIGN_IF_INVALID:
+		die(_("'re-sign-if-invalid' is not a valid mode for "
+		      "git fast-import with --signed-tags=<mode>"));
 	default:
 		BUG("invalid signed_tag_mode value %d from tag '%s'",
 		    signed_tag_mode, name);
diff --git a/gpg-interface.c b/gpg-interface.c
index 87fb6605fb..e7eb42d9d6 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -1156,6 +1156,8 @@ int parse_sign_mode(const char *arg, enum sign_mode *mode)
 		*mode = SIGN_STRIP;
 	else if (!strcmp(arg, "strip-if-invalid"))
 		*mode = SIGN_STRIP_IF_INVALID;
+	else if (!strcmp(arg, "re-sign-if-invalid"))
+		*mode = SIGN_RESIGN_IF_INVALID;
 	else
 		return -1;
 	return 0;
diff --git a/gpg-interface.h b/gpg-interface.h
index 789d1ffac4..2ab2a21e1a 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -112,6 +112,7 @@ enum sign_mode {
 	SIGN_WARN_STRIP,
 	SIGN_STRIP,
 	SIGN_STRIP_IF_INVALID,
+	SIGN_RESIGN_IF_INVALID,
 };
 
 /*
diff --git a/t/t9305-fast-import-signatures.sh b/t/t9305-fast-import-signatures.sh
index 022dae02e4..b52fb75976 100755
--- a/t/t9305-fast-import-signatures.sh
+++ b/t/t9305-fast-import-signatures.sh
@@ -103,71 +103,81 @@ test_expect_success GPG 'strip both OpenPGP signatures with --signed-commits=war
 	test_line_count = 2 out
 '
 
-test_expect_success GPG 'import commit with no signature with --signed-commits=strip-if-invalid' '
-	git fast-export main >output &&
-	git -C new fast-import --quiet --signed-commits=strip-if-invalid <output >log 2>&1 &&
-	test_must_be_empty log
-'
-
-test_expect_success GPG 'keep valid OpenPGP signature with --signed-commits=strip-if-invalid' '
-	rm -rf new &&
-	git init new &&
-
-	git fast-export --signed-commits=verbatim openpgp-signing >output &&
-	git -C new fast-import --quiet --signed-commits=strip-if-invalid <output >log 2>&1 &&
-	IMPORTED=$(git -C new rev-parse --verify refs/heads/openpgp-signing) &&
-	test $OPENPGP_SIGNING = $IMPORTED &&
-	git -C new cat-file commit "$IMPORTED" >actual &&
-	test_grep -E "^gpgsig(-sha256)? " actual &&
-	test_must_be_empty log
-'
-
-test_expect_success GPG 'strip signature invalidated by message change with --signed-commits=strip-if-invalid' '
-	rm -rf new &&
-	git init new &&
-
-	git fast-export --signed-commits=verbatim openpgp-signing >output &&
-
-	# Change the commit message, which invalidates the signature.
-	# The commit message length should not change though, otherwise the
-	# corresponding `data <length>` command would have to be changed too.
-	sed "s/OpenPGP signed commit/OpenPGP forged commit/" output >modified &&
-
-	git -C new fast-import --quiet --signed-commits=strip-if-invalid <modified >log 2>&1 &&
-
-	IMPORTED=$(git -C new rev-parse --verify refs/heads/openpgp-signing) &&
-	test $OPENPGP_SIGNING != $IMPORTED &&
-	git -C new cat-file commit "$IMPORTED" >actual &&
-	test_grep ! -E "^gpgsig" actual &&
-	test_grep "stripping invalid signature" log
-'
-
-test_expect_success GPGSM 'keep valid X.509 signature with --signed-commits=strip-if-invalid' '
-	rm -rf new &&
-	git init new &&
-
-	git fast-export --signed-commits=verbatim x509-signing >output &&
-	git -C new fast-import --quiet --signed-commits=strip-if-invalid <output >log 2>&1 &&
-	IMPORTED=$(git -C new rev-parse --verify refs/heads/x509-signing) &&
-	test $X509_SIGNING = $IMPORTED &&
-	git -C new cat-file commit "$IMPORTED" >actual &&
-	test_grep -E "^gpgsig(-sha256)? " actual &&
-	test_must_be_empty log
-'
-
-test_expect_success GPGSSH 'keep valid SSH signature with --signed-commits=strip-if-invalid' '
-	rm -rf new &&
-	git init new &&
-
-	test_config -C new gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
-
-	git fast-export --signed-commits=verbatim ssh-signing >output &&
-	git -C new fast-import --quiet --signed-commits=strip-if-invalid <output >log 2>&1 &&
-	IMPORTED=$(git -C new rev-parse --verify refs/heads/ssh-signing) &&
-	test $SSH_SIGNING = $IMPORTED &&
-	git -C new cat-file commit "$IMPORTED" >actual &&
-	test_grep -E "^gpgsig(-sha256)? " actual &&
-	test_must_be_empty log
-'
+for mode in strip-if-invalid re-sign-if-invalid
+do
+	test_expect_success GPG "import commit with no signature with --signed-commits=$mode" '
+		git fast-export main >output &&
+		git -C new fast-import --quiet --signed-commits=$mode <output >log 2>&1 &&
+		test_must_be_empty log
+	'
+
+	test_expect_success GPG "keep valid OpenPGP signature with --signed-commits=$mode" '
+		rm -rf new &&
+		git init new &&
+
+		git fast-export --signed-commits=verbatim openpgp-signing >output &&
+		git -C new fast-import --quiet --signed-commits=$mode <output >log 2>&1 &&
+		IMPORTED=$(git -C new rev-parse --verify refs/heads/openpgp-signing) &&
+		test $OPENPGP_SIGNING = $IMPORTED &&
+		git -C new cat-file commit "$IMPORTED" >actual &&
+		test_grep -E "^gpgsig(-sha256)? " actual &&
+		test_must_be_empty log
+	'
+
+	test_expect_success GPG "strip signature invalidated by message change with --signed-commits=$mode" '
+		rm -rf new &&
+		git init new &&
+
+		git fast-export --signed-commits=verbatim openpgp-signing >output &&
+
+		# Change the commit message, which invalidates the signature.
+		# The commit message length should not change though, otherwise the
+		# corresponding `data <length>` command would have to be changed too.
+		sed "s/OpenPGP signed commit/OpenPGP forged commit/" output >modified &&
+
+		git -C new fast-import --quiet --signed-commits=$mode <modified >log 2>&1 &&
+
+		IMPORTED=$(git -C new rev-parse --verify refs/heads/openpgp-signing) &&
+		test $OPENPGP_SIGNING != $IMPORTED &&
+		git -C new cat-file commit "$IMPORTED" >actual &&
+		test_grep "stripping invalid signature" log &&
+
+		if test "$mode" = strip-if-invalid
+		then
+			test_grep ! -E "^gpgsig" actual
+		else
+			test_grep -E "^gpgsig(-sha256)? " actual &&
+			git -C new verify-commit "$IMPORTED"
+		fi
+	'
+
+	test_expect_success GPGSM "keep valid X.509 signature with --signed-commits=$mode" '
+		rm -rf new &&
+		git init new &&
+
+		git fast-export --signed-commits=verbatim x509-signing >output &&
+		git -C new fast-import --quiet --signed-commits=$mode <output >log 2>&1 &&
+		IMPORTED=$(git -C new rev-parse --verify refs/heads/x509-signing) &&
+		test $X509_SIGNING = $IMPORTED &&
+		git -C new cat-file commit "$IMPORTED" >actual &&
+		test_grep -E "^gpgsig(-sha256)? " actual &&
+		test_must_be_empty log
+	'
+
+	test_expect_success GPGSSH "keep valid SSH signature with --signed-commits=$mode" '
+		rm -rf new &&
+		git init new &&
+
+		test_config -C new gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+
+		git fast-export --signed-commits=verbatim ssh-signing >output &&
+		git -C new fast-import --quiet --signed-commits=$mode <output >log 2>&1 &&
+		IMPORTED=$(git -C new rev-parse --verify refs/heads/ssh-signing) &&
+		test $SSH_SIGNING = $IMPORTED &&
+		git -C new cat-file commit "$IMPORTED" >actual &&
+		test_grep -E "^gpgsig(-sha256)? " actual &&
+		test_must_be_empty log
+	'
+done
 
 test_done
-- 
2.53.0

