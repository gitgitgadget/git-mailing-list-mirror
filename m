Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26ABF481670
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 20:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772830451; cv=none; b=VaBnwsAQTRrNIKYGO+nzs6MQvSCyTswVo4vOnBAzowdkmVyIznBFjz05F53b5Lu3ao1ZqcGlVFSdWytS8CKBgdl2avregdUKgPerHcWEqw7aNL1VDVxP09HOK7iNmnbHFAosnlwHWZ7yEmCBU0NAn4/hiukrq9huENk5ZSwYYPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772830451; c=relaxed/simple;
	bh=1UqWiRJFkcZFJKzLornia4tCq8Tw1U8pTR1cHUWv9QA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QCUTzjt9TwNOBqfgnrdmURkStdBgEzv7jwKFBYcNLMpZr1rXgTCiPcRry1jbkNfVW9V2ZzTEJLA+IZK6aq335iE363yrBtcdW2bcnsHZOdlsebplJSfcOCI72jHYw0nV3rxocfNKDkLttjGnmfIlQNtfDiropfvCm7qM4x2jZq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQNWflwa; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQNWflwa"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-40ee8b4f925so3322401fac.3
        for <git@vger.kernel.org>; Fri, 06 Mar 2026 12:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772830448; x=1773435248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1JX5xeh1TOiCqp3wlkOdEPXHjBd4Tnucg/yAaa37z0=;
        b=WQNWflwaC6EGDUN+XRqUQs7zjYeNuJDpEWR78hwuC9JdJyfvKX4RTzeTTh2Rd/Npim
         sxzGtzPgQwXOUS5rUFzodn/ofRSxtmHRQ9SaJ3oO+hhRJ7vqS12d459eaOVKd4xV6a3e
         L8EsXp78nmLz/4jPtgT+JYY0ESsi2vI9yBhrihNtiHV1xQJL8FI/lJPBbkCWLEqAjFI5
         LIlqcHnV4QEAAgmkx1zdnxepuoalNlmk95NOWlsFkQ37VXAU+oJX/1Cc5s0zz9zV5UO8
         TLAdndaapLIy5F5bSk73+A3ov5hWjjBaSvhDyaXtvNvNN0N/frBiezJx7YFAqMrCiZYk
         WBsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772830448; x=1773435248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T1JX5xeh1TOiCqp3wlkOdEPXHjBd4Tnucg/yAaa37z0=;
        b=ZZ13nfbpIcTyA5L7upgohA5PCaOzyAu9aqmjd4IU80xOfbOTKIlIZf6XmIqplq17f+
         8iCtzq9XTfX9G6sa0Aj36mGJhwTsROEfN6hq7jOqc7gkKG4me88NJPRPbSZHxlUd3oto
         S1dmUxdS3/yBMphRCDWvQ906Y1etUeuUGMPxrtBjXf1u8+TVAZr0Vx4RbONoSiAMTKm8
         VBN8Xb4BFuta1jCePiErDDctmCgCTwP9TnD7nBI3w+qPVLPT/68av+4e28UTfk0/HuLu
         alX5NMXpN7PbnlyF/0KcLAotQbyKp4bFRWUUYgQNLz2FJN65K39hyRauaBWlDamL9+PY
         dBig==
X-Gm-Message-State: AOJu0Yw7tRfUmOXf4H9bhjETRQ7pxB43gD7Bfr4QUf8slkxo/G3QFODu
	ImhmpvzDx76PvCEtaJcZc/e+bgKhGzFA5uS5tjePpsTt77M2z+1UyZPOLkOqAg==
X-Gm-Gg: ATEYQzzdSO2uPi3GqPkFUHHmopGBgD1lzsvRlimnaPgDOFX8mvmev6tDmWvILLWqDT7
	QsRCtiBQfaOp4trHCdS7CPCDMF+HHzxbuKLdLK0yu8gqF4dWuozxcOfie0K84hO+ZYQCwEdbZ3k
	8Sravz6pJO1OpiUwNEPG13C3fiakooUDxuBlKpUW6g1KMMjNpcXYJhEFEO/pzVJTjQicFf+QlKP
	YbtXZftTpy8Q8mSPl48XYS6bEK1c/wO73dywm1un7RnGdzKFnrXf4i26J0CwGJycVIcBxbEHOn9
	HZzUGsr/wDJ+N4EbCzkSpRA1S6dFoMUpZkgMNVlX13gCkg2a0+4gqvH/7DFdA9rGy6CmFUAzOG5
	L8CN3RJBRsU7dFkbEe9QH1ZqvaV8dInoaoiBuAWHbsBmvpuC8KELw099dR3EfQjoxnLxn9pPubQ
	y0DYnnoI5qVPMgG8W/lKF/hQ33KRNo530=
X-Received: by 2002:a05:6870:720a:b0:315:b768:bd1d with SMTP id 586e51a60fabf-416e3e91162mr2077095fac.6.1772830447488;
        Fri, 06 Mar 2026 12:54:07 -0800 (PST)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-416e688d5cdsm2278014fac.20.2026.03.06.12.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 12:54:06 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: sandals@crustytoothpaste.net,
	christian.couder@gmail.com,
	ps@pks.im,
	gister@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 3/3] fast-import: add mode to re-sign invalid commit signatures
Date: Fri,  6 Mar 2026 14:53:59 -0600
Message-ID: <20260306205359.1723254-4-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0.381.g628a66ccf6
In-Reply-To: <20260306205359.1723254-1-jltobler@gmail.com>
References: <20260223194146.3476768-1-jltobler@gmail.com>
 <20260306205359.1723254-1-jltobler@gmail.com>
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
to just stripping the signature. To facilitate this, introduce a
"re-sign-if-invalid" mode for the `--signed-commits` option. Optionally,
a key ID may be explicitly provided in the form
`re-sign-if-invalid[=<keyid>]` to specify which signing key should be
used when re-signing invalid commit signatures.

Note that to properly support interoperability mode when re-signing
commit signatures, the commit buffer must be created in both the
repository and compatability object formats to generate the appropriate
signatures accordingly. As currently implemented, the commit buffer for
the compatability object format is not reconstructed and thus re-signing
commits in interoperability mode is not yet supported. Support may be
added in the future.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 Documentation/git-fast-import.adoc |   4 +
 builtin/fast-export.c              |   8 +-
 builtin/fast-import.c              |  79 ++++++++++++----
 gpg-interface.c                    |  23 +++--
 gpg-interface.h                    |   7 +-
 t/t9305-fast-import-signatures.sh  | 140 ++++++++++++++++++-----------
 6 files changed, 183 insertions(+), 78 deletions(-)

diff --git a/Documentation/git-fast-import.adoc b/Documentation/git-fast-import.adoc
index 479c4081da..08f7d5d89a 100644
--- a/Documentation/git-fast-import.adoc
+++ b/Documentation/git-fast-import.adoc
@@ -86,6 +86,10 @@ already trusted to run their own code.
 * `strip-if-invalid` will check signatures and, if they are invalid,
   will strip them and display a warning. The validation is performed
   in the same way as linkgit:git-verify-commit[1] does it.
+* `re-sign-if-invalid[=<keyid>]`, similar to `strip-if-invalid`, verifies
+  commit signatures and replaces invalid signatures with newly created ones.
+  Valid signatures are left unchanged. If `<keyid>` is provided, that key is
+  used for re-signing; otherwise the configured default signing key is used.
 
 Options for Frontends
 ~~~~~~~~~~~~~~~~~~~~~
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 0c5d2386d8..0ab8465ae3 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -64,7 +64,7 @@ static int parse_opt_sign_mode(const struct option *opt,
 	if (unset)
 		return 0;
 
-	if (parse_sign_mode(arg, val))
+	if (parse_sign_mode(arg, val, NULL))
 		return error(_("unknown %s mode: %s"), opt->long_name, arg);
 
 	return 0;
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
index b8a7757cfd..f6bd8556f5 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -190,6 +190,7 @@ static const char *global_prefix;
 
 static enum sign_mode signed_tag_mode = SIGN_VERBATIM;
 static enum sign_mode signed_commit_mode = SIGN_VERBATIM;
+static const char *signed_commit_keyid;
 
 /* Memory pools */
 static struct mem_pool fi_mem_pool = {
@@ -2836,10 +2837,11 @@ static void finalize_commit_buffer(struct strbuf *new_data,
 	strbuf_addbuf(new_data, msg);
 }
 
-static void handle_strip_if_invalid(struct strbuf *new_data,
-				    struct signature_data *sig_sha1,
-				    struct signature_data *sig_sha256,
-				    struct strbuf *msg)
+static void handle_signature_if_invalid(struct strbuf *new_data,
+					struct signature_data *sig_sha1,
+					struct signature_data *sig_sha256,
+					struct strbuf *msg,
+					enum sign_mode mode)
 {
 	struct strbuf tmp_buf = STRBUF_INIT;
 	struct signature_check signature_check = { 0 };
@@ -2856,15 +2858,52 @@ static void handle_strip_if_invalid(struct strbuf *new_data,
 		const char *subject;
 		int subject_len = find_commit_subject(msg->buf, &subject);
 
-		if (subject_len > 100)
-			warning(_("stripping invalid signature for commit '%.100s...'\n"
-				  "  allegedly by %s"), subject, signer);
-		else if (subject_len > 0)
-			warning(_("stripping invalid signature for commit '%.*s'\n"
-				  "  allegedly by %s"), subject_len, subject, signer);
-		else
-			warning(_("stripping invalid signature for commit\n"
-				  "  allegedly by %s"), signer);
+		if (mode == SIGN_STRIP_IF_INVALID) {
+			if (subject_len > 100)
+				warning(_("stripping invalid signature for commit '%.100s...'\n"
+					  "  allegedly by %s"), subject, signer);
+			else if (subject_len > 0)
+				warning(_("stripping invalid signature for commit '%.*s'\n"
+					  "  allegedly by %s"), subject_len, subject, signer);
+			else
+				warning(_("stripping invalid signature for commit\n"
+					  "  allegedly by %s"), signer);
+		} else if (mode == SIGN_RESIGN_IF_INVALID) {
+			struct strbuf signature = STRBUF_INIT;
+			struct strbuf payload = STRBUF_INIT;
+
+			if (subject_len > 100)
+				warning(_("re-signing invalid signature for commit '%.100s...'\n"
+					  "  allegedly by %s"), subject, signer);
+			else if (subject_len > 0)
+				warning(_("re-signing invalid signature for commit '%.*s'\n"
+					  "  allegedly by %s"), subject_len, subject, signer);
+			else
+				warning(_("re-signing invalid signature for commit\n"
+					  "  allegedly by %s"), signer);
+
+			/*
+			 * NEEDSWORK: To properly support interoperability mode
+			 * when re-signing commit signatures, the commit buffer
+			 * must be provided in both the repository and
+			 * compatability object formats. As currently
+			 * implemented, only the repository object format is
+			 * considered meaning compatability signatures cannot be
+			 * generated. Thus, attempting to re-sign commit
+			 * signatures in interoperability mode is currently
+			 * unsupported.
+			 */
+			if (the_repository->compat_hash_algo)
+				die(_("re-signing signatures in interoperability mode is unsupported"));
+
+			strbuf_addstr(&payload, signature_check.payload);
+			if (sign_buffer_with_key(&payload, &signature, signed_commit_keyid))
+				die(_("failed to sign commit object"));
+			add_header_signature(new_data, &signature, the_hash_algo);
+
+			strbuf_release(&signature);
+			strbuf_release(&payload);
+		}
 
 		finalize_commit_buffer(new_data, NULL, NULL, msg);
 	} else {
@@ -2927,6 +2966,7 @@ static void parse_new_commit(const char *arg)
 			/* fallthru */
 		case SIGN_VERBATIM:
 		case SIGN_STRIP_IF_INVALID:
+		case SIGN_RESIGN_IF_INVALID:
 			import_one_signature(&sig_sha1, &sig_sha256, v);
 			break;
 
@@ -3011,9 +3051,11 @@ static void parse_new_commit(const char *arg)
 			"encoding %s\n",
 			encoding);
 
-	if (signed_commit_mode == SIGN_STRIP_IF_INVALID &&
+	if ((signed_commit_mode == SIGN_STRIP_IF_INVALID ||
+	     signed_commit_mode == SIGN_RESIGN_IF_INVALID) &&
 	    (sig_sha1.hash_algo || sig_sha256.hash_algo))
-		handle_strip_if_invalid(&new_data, &sig_sha1, &sig_sha256, &msg);
+		handle_signature_if_invalid(&new_data, &sig_sha1, &sig_sha256,
+					    &msg, signed_commit_mode);
 	else
 		finalize_commit_buffer(&new_data, &sig_sha1, &sig_sha256, &msg);
 
@@ -3060,6 +3102,9 @@ static void handle_tag_signature(struct strbuf *msg, const char *name)
 	case SIGN_STRIP_IF_INVALID:
 		die(_("'strip-if-invalid' is not a valid mode for "
 		      "git fast-import with --signed-tags=<mode>"));
+	case SIGN_RESIGN_IF_INVALID:
+		die(_("'re-sign-if-invalid' is not a valid mode for "
+		      "git fast-import with --signed-tags=<mode>"));
 	default:
 		BUG("invalid signed_tag_mode value %d from tag '%s'",
 		    signed_tag_mode, name);
@@ -3649,10 +3694,10 @@ static int parse_one_option(const char *option)
 	} else if (skip_prefix(option, "export-pack-edges=", &option)) {
 		option_export_pack_edges(option);
 	} else if (skip_prefix(option, "signed-commits=", &option)) {
-		if (parse_sign_mode(option, &signed_commit_mode))
+		if (parse_sign_mode(option, &signed_commit_mode, &signed_commit_keyid))
 			usagef(_("unknown --signed-commits mode '%s'"), option);
 	} else if (skip_prefix(option, "signed-tags=", &option)) {
-		if (parse_sign_mode(option, &signed_tag_mode))
+		if (parse_sign_mode(option, &signed_tag_mode, NULL))
 			usagef(_("unknown --signed-tags mode '%s'"), option);
 	} else if (!strcmp(option, "quiet")) {
 		show_stats = 0;
diff --git a/gpg-interface.c b/gpg-interface.c
index a72fa35061..e028984546 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -1155,21 +1155,28 @@ static int sign_buffer_ssh(struct strbuf *buffer, struct strbuf *signature,
 	return ret;
 }
 
-int parse_sign_mode(const char *arg, enum sign_mode *mode)
+int parse_sign_mode(const char *arg, enum sign_mode *mode, const char **keyid)
 {
-	if (!strcmp(arg, "abort"))
+	if (!strcmp(arg, "abort")) {
 		*mode = SIGN_ABORT;
-	else if (!strcmp(arg, "verbatim") || !strcmp(arg, "ignore"))
+	} else if (!strcmp(arg, "verbatim") || !strcmp(arg, "ignore")) {
 		*mode = SIGN_VERBATIM;
-	else if (!strcmp(arg, "warn-verbatim") || !strcmp(arg, "warn"))
+	} else if (!strcmp(arg, "warn-verbatim") || !strcmp(arg, "warn")) {
 		*mode = SIGN_WARN_VERBATIM;
-	else if (!strcmp(arg, "warn-strip"))
+	} else if (!strcmp(arg, "warn-strip")) {
 		*mode = SIGN_WARN_STRIP;
-	else if (!strcmp(arg, "strip"))
+	} else if (!strcmp(arg, "strip")) {
 		*mode = SIGN_STRIP;
-	else if (!strcmp(arg, "strip-if-invalid"))
+	} else if (!strcmp(arg, "strip-if-invalid")) {
 		*mode = SIGN_STRIP_IF_INVALID;
-	else
+	} else if (!strcmp(arg, "re-sign-if-invalid")) {
+		*mode = SIGN_RESIGN_IF_INVALID;
+	} else if (skip_prefix(arg, "re-sign-if-invalid=", &arg)) {
+		*mode = SIGN_RESIGN_IF_INVALID;
+		if (keyid)
+			*keyid = arg;
+	} else {
 		return -1;
+	}
 	return 0;
 }
diff --git a/gpg-interface.h b/gpg-interface.h
index a32741aeda..8f1fad43e9 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -119,12 +119,15 @@ enum sign_mode {
 	SIGN_WARN_STRIP,
 	SIGN_STRIP,
 	SIGN_STRIP_IF_INVALID,
+	SIGN_RESIGN_IF_INVALID,
 };
 
 /*
  * Return 0 if `arg` can be parsed into an `enum sign_mode`. Return -1
- * otherwise.
+ * otherwise. If the parsed mode is SIGN_RESIGN_IF_INVALID and GPG key provided
+ * in the arguments in the form `re-sign-if-invalid=<keyid>`, the key-ID is
+ * parsed into `char **keyid`.
  */
-int parse_sign_mode(const char *arg, enum sign_mode *mode);
+int parse_sign_mode(const char *arg, enum sign_mode *mode, const char **keyid);
 
 #endif
diff --git a/t/t9305-fast-import-signatures.sh b/t/t9305-fast-import-signatures.sh
index 022dae02e4..2a3f04b42d 100755
--- a/t/t9305-fast-import-signatures.sh
+++ b/t/t9305-fast-import-signatures.sh
@@ -103,26 +103,85 @@ test_expect_success GPG 'strip both OpenPGP signatures with --signed-commits=war
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
+	test_expect_success GPG "handle signature invalidated by message change with --signed-commits=$mode" '
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
+
+		if test "$mode" = strip-if-invalid
+		then
+			test_grep "stripping invalid signature" log &&
+			test_grep ! -E "^gpgsig" actual
+		else
+			test_grep "re-signing invalid signature" log &&
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
+
+test_expect_success GPGSSH "re-sign invalid commit with explicit keyid" '
 	rm -rf new &&
 	git init new &&
 
@@ -133,41 +192,22 @@ test_expect_success GPG 'strip signature invalidated by message change with --si
 	# corresponding `data <length>` command would have to be changed too.
 	sed "s/OpenPGP signed commit/OpenPGP forged commit/" output >modified &&
 
-	git -C new fast-import --quiet --signed-commits=strip-if-invalid <modified >log 2>&1 &&
+	# Configure the target repository with an invalid default signing key.
+	test_config -C new user.signingkey "not-a-real-key-id" &&
+	test_config -C new gpg.format ssh &&
+	test_config -C new gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	test_must_fail git -C new fast-import --quiet \
+		--signed-commits=re-sign-if-invalid <modified >/dev/null 2>&1 &&
+
+	# Import using explicitly provided signing key.
+	git -C new fast-import --quiet \
+		--signed-commits=re-sign-if-invalid="${GPGSSH_KEY_PRIMARY}" <modified &&
 
 	IMPORTED=$(git -C new rev-parse --verify refs/heads/openpgp-signing) &&
 	test $OPENPGP_SIGNING != $IMPORTED &&
 	git -C new cat-file commit "$IMPORTED" >actual &&
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
 	test_grep -E "^gpgsig(-sha256)? " actual &&
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
+	git -C new verify-commit "$IMPORTED"
 '
 
 test_done
-- 
2.53.0.381.g628a66ccf6

