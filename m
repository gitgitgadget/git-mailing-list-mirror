Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3804A3E9296
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 20:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773173488; cv=none; b=H9/KXaZLYNSxf7EJB6HdPn48dt2UjRxeAaNpr97qAJN7C2ijjskcGtlw5YD2B3cVQae0RPNUR1Dl97Bda1hDcgH+jq1bLjqNaeBS+0hwIlESbuSetpH7tzN6UQiEjJkQn+EBknsChOcQttAFrVDcqtLotq9I80d1MkS6u5qHRXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773173488; c=relaxed/simple;
	bh=sAojHPIU2As725OdGKi/jwVaZvhUfg3LTPtW5vWRhe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s9H2JH1sYcJOFe/VbYTiECEigbV1fwEtr3giLYNvDEcl6Jdoz65JWD32Hyq4iCFWglRiw7b3trWXZLCPEB0ew1Ejmvd6AVad4UWP3kFljCdRL0bvYFFbu5SOetBjmkToBMhw3LY/oZGC/wa6aBuWe5HHBV2yhEsMubHBL8oJpyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XlIVY7G0; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlIVY7G0"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-67bb5c2e0fdso963281eaf.0
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 13:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773173485; x=1773778285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pSZTAQ+du9nIaZVcSR0oAXxw7kCgdi6pOt2Q6/l6gvM=;
        b=XlIVY7G0BXwEJ6ZuZXLST5ICMtMgXRTp01e5WNR9owWWcUptW8Y4CjwMX32SHhj08h
         S0rtXaMdV/hDGUpuIfI+AU1ZQlb1nZBfQlZ2jrTGTkm55EML/1UOUZQJSyacUY8D5+n8
         islDW6bDsFo9+gK+BaTp209nyj50nZFl6hNqS6kDJ9aUpghNNuQgKeTfSdrs68HRiRz6
         1Mvf4eqqCmawfzLWHYLtEgK0I6iOD0GMLR0/yHEmt+CfsClCWSSDHKIupGvlpWehxEoa
         viA48cEiH2DcKdemf2u0E+kiddv1e6E+1aQ9N1nggyG6ed/GNuZ/+u2F/vAWrFd5C44S
         OmFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773173485; x=1773778285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pSZTAQ+du9nIaZVcSR0oAXxw7kCgdi6pOt2Q6/l6gvM=;
        b=mbI12U1GEztWYD88SCuUsqOPDly1e3bTHTZUpUWEP2EU5X8Ig49uXxrOd9qg5I9tLl
         FtbdYn6zfoaRfv49MDJKgwUjO3M6LX7o1FW9UAgvNGNsApP7r2oz19x2lppUMBhp6GF6
         giBQKb4RWZh1cplkCeja9oYyUFv4ww36oIUliFXkvt6f/7mKn0/jpSLLS1jkCOCiclbc
         qpgoi3/cSv00uwcRyxS9NQ0kqRS37N6yCUugDhRqkx4N7qnXa8kHSOpNiZHTt7jqL3KK
         0Cy/AEf+zIJ1tjeOg6O2zpAKP4bcITN8iUWqKi1cCCut0gkEB6/08WbBIDAuu+f0btMB
         GGlg==
X-Gm-Message-State: AOJu0YyL5hhGjqQtSS8bWlSd9rlYHzZQsc8m1nC1scq84FZv7rtBOOGa
	yyu7ugob/9rB5oBJ7ph9jW2JXbxF5AjFIuaGhIyEvN/KpcjjgQHbI4VKkty0ng==
X-Gm-Gg: ATEYQzybcjhKI7qMzZNK/M+h6pAZyTr+FhPUfaM4nI2C0jaeP6eY9hajv8wU5aajggR
	khLV7xGjTmr6C4IKasnocqSOokomZNs2vJzSkfuf7GadLdPwLVRGjELp6FuH6YgsAbO/u4eEEf6
	4N3o3xdEOyDFllaX8Jijh5NdZP/RuHx4n3Oy0jnrxUSmipSTjztoJ9RxiBFXJ9ujXrXSulzhko1
	JxL1yeB4XHVPgSkwcuZhn3itZ/lCqHkipzIfXf1DxrLgT71StOBWwHkDco0ApfD8cwwc45IgTNE
	fKn5id3Egd09CGwTtT113z1h48+qI8YXiTeNlQk/7sOJ01c4U+bNT7P0VRt7b8yvvKRrmJv93FN
	hJIabwYszge9skazGvbL38UD1XSJKV/FmqeL0rTz69rbr27bRhVuHtnxwig2ddBmp0gbD+MOXwq
	OwI7/Umhp23R1dXihCeuIe8+UbH91uJ0cDGpbjH5IMlg==
X-Received: by 2002:a05:6820:169e:b0:67b:c368:137c with SMTP id 006d021491bc7-67bc8908f49mr70405eaf.32.1773173484773;
        Tue, 10 Mar 2026 13:11:24 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67bacd85dd6sm6221066eaf.11.2026.03.10.13.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 13:11:24 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: sandals@crustytoothpaste.net,
	christian.couder@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 3/3] fast-import: add mode to re-sign invalid commit signatures
Date: Tue, 10 Mar 2026 15:11:16 -0500
Message-ID: <20260310201116.1130160-4-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0.381.g628a66ccf6
In-Reply-To: <20260310201116.1130160-1-jltobler@gmail.com>
References: <20260306205359.1723254-1-jltobler@gmail.com>
 <20260310201116.1130160-1-jltobler@gmail.com>
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
 builtin/fast-import.c              | 101 ++++++++++++++++-----
 gpg-interface.c                    |  23 +++--
 gpg-interface.h                    |   7 +-
 t/t9305-fast-import-signatures.sh  | 140 ++++++++++++++++++-----------
 6 files changed, 200 insertions(+), 83 deletions(-)

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
index 0c5d2386d8..2067613267 100644
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
+		case SIGN_RE_SIGN_IF_INVALID:
+			die(_("'re-sign-if-invalid' is not a valid mode for "
+			      "git fast-export with --signed-commits=<mode>"));
 		default:
 			BUG("invalid signed_commit_mode value %d", signed_commit_mode);
 		}
@@ -970,6 +973,9 @@ static void handle_tag(const char *name, struct tag *tag)
 			case SIGN_STRIP_IF_INVALID:
 				die(_("'strip-if-invalid' is not a valid mode for "
 				      "git fast-export with --signed-tags=<mode>"));
+			case SIGN_RE_SIGN_IF_INVALID:
+				die(_("'re-sign-if-invalid' is not a valid mode for "
+				      "git fast-export with --signed-tags=<mode>"));
 			default:
 				BUG("invalid signed_commit_mode value %d", signed_commit_mode);
 			}
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index b8a7757cfd..472d9ab712 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -190,6 +190,7 @@ static const char *global_prefix;
 
 static enum sign_mode signed_tag_mode = SIGN_VERBATIM;
 static enum sign_mode signed_commit_mode = SIGN_VERBATIM;
+static const char *signed_commit_keyid;
 
 /* Memory pools */
 static struct mem_pool fi_mem_pool = {
@@ -2836,26 +2837,15 @@ static void finalize_commit_buffer(struct strbuf *new_data,
 	strbuf_addbuf(new_data, msg);
 }
 
-static void handle_strip_if_invalid(struct strbuf *new_data,
-				    struct signature_data *sig_sha1,
-				    struct signature_data *sig_sha256,
-				    struct strbuf *msg)
+static void warn_invalid_signature(struct signature_check *check,
+				   const char *msg, enum sign_mode mode)
 {
-	struct strbuf tmp_buf = STRBUF_INIT;
-	struct signature_check signature_check = { 0 };
-	int ret;
-
-	/* Check signature in a temporary commit buffer */
-	strbuf_addbuf(&tmp_buf, new_data);
-	finalize_commit_buffer(&tmp_buf, sig_sha1, sig_sha256, msg);
-	ret = verify_commit_buffer(tmp_buf.buf, tmp_buf.len, &signature_check);
-
-	if (ret) {
-		const char *signer = signature_check.signer ?
-			signature_check.signer : _("unknown");
-		const char *subject;
-		int subject_len = find_commit_subject(msg->buf, &subject);
+	const char *signer = check->signer ? check->signer : _("unknown");
+	const char *subject;
+	int subject_len = find_commit_subject(msg, &subject);
 
+	switch (mode) {
+	case SIGN_STRIP_IF_INVALID:
 		if (subject_len > 100)
 			warning(_("stripping invalid signature for commit '%.100s...'\n"
 				  "  allegedly by %s"), subject, signer);
@@ -2865,6 +2855,67 @@ static void handle_strip_if_invalid(struct strbuf *new_data,
 		else
 			warning(_("stripping invalid signature for commit\n"
 				  "  allegedly by %s"), signer);
+		break;
+	case SIGN_RE_SIGN_IF_INVALID:
+		if (subject_len > 100)
+			warning(_("re-signing invalid signature for commit '%.100s...'\n"
+				  "  allegedly by %s"), subject, signer);
+		else if (subject_len > 0)
+			warning(_("re-signing invalid signature for commit '%.*s'\n"
+				  "  allegedly by %s"), subject_len, subject, signer);
+		else
+			warning(_("re-signing invalid signature for commit\n"
+				  "  allegedly by %s"), signer);
+		break;
+	default:
+		BUG("unsupported signing mode");
+	}
+}
+
+static void handle_signature_if_invalid(struct strbuf *new_data,
+					struct signature_data *sig_sha1,
+					struct signature_data *sig_sha256,
+					struct strbuf *msg,
+					enum sign_mode mode)
+{
+	struct strbuf tmp_buf = STRBUF_INIT;
+	struct signature_check signature_check = { 0 };
+	int ret;
+
+	/* Check signature in a temporary commit buffer */
+	strbuf_addbuf(&tmp_buf, new_data);
+	finalize_commit_buffer(&tmp_buf, sig_sha1, sig_sha256, msg);
+	ret = verify_commit_buffer(tmp_buf.buf, tmp_buf.len, &signature_check);
+
+	if (ret) {
+		warn_invalid_signature(&signature_check, msg->buf, mode);
+
+		if (mode == SIGN_RE_SIGN_IF_INVALID) {
+			struct strbuf signature = STRBUF_INIT;
+			struct strbuf payload = STRBUF_INIT;
+
+			/*
+			 * NEEDSWORK: To properly support interoperability mode
+			 * when re-signing commit signatures, the commit buffer
+			 * must be provided in both the repository and
+			 * compatibility object formats. As currently
+			 * implemented, only the repository object format is
+			 * considered meaning compatibility signatures cannot be
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
@@ -2927,6 +2978,7 @@ static void parse_new_commit(const char *arg)
 			/* fallthru */
 		case SIGN_VERBATIM:
 		case SIGN_STRIP_IF_INVALID:
+		case SIGN_RE_SIGN_IF_INVALID:
 			import_one_signature(&sig_sha1, &sig_sha256, v);
 			break;
 
@@ -3011,9 +3063,11 @@ static void parse_new_commit(const char *arg)
 			"encoding %s\n",
 			encoding);
 
-	if (signed_commit_mode == SIGN_STRIP_IF_INVALID &&
+	if ((signed_commit_mode == SIGN_STRIP_IF_INVALID ||
+	     signed_commit_mode == SIGN_RE_SIGN_IF_INVALID) &&
 	    (sig_sha1.hash_algo || sig_sha256.hash_algo))
-		handle_strip_if_invalid(&new_data, &sig_sha1, &sig_sha256, &msg);
+		handle_signature_if_invalid(&new_data, &sig_sha1, &sig_sha256,
+					    &msg, signed_commit_mode);
 	else
 		finalize_commit_buffer(&new_data, &sig_sha1, &sig_sha256, &msg);
 
@@ -3060,6 +3114,9 @@ static void handle_tag_signature(struct strbuf *msg, const char *name)
 	case SIGN_STRIP_IF_INVALID:
 		die(_("'strip-if-invalid' is not a valid mode for "
 		      "git fast-import with --signed-tags=<mode>"));
+	case SIGN_RE_SIGN_IF_INVALID:
+		die(_("'re-sign-if-invalid' is not a valid mode for "
+		      "git fast-import with --signed-tags=<mode>"));
 	default:
 		BUG("invalid signed_tag_mode value %d from tag '%s'",
 		    signed_tag_mode, name);
@@ -3649,10 +3706,10 @@ static int parse_one_option(const char *option)
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
index a72fa35061..2570b641f2 100644
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
+		*mode = SIGN_RE_SIGN_IF_INVALID;
+	} else if (skip_prefix(arg, "re-sign-if-invalid=", &arg)) {
+		*mode = SIGN_RE_SIGN_IF_INVALID;
+		if (keyid)
+			*keyid = arg;
+	} else {
 		return -1;
+	}
 	return 0;
 }
diff --git a/gpg-interface.h b/gpg-interface.h
index a32741aeda..e9f451f366 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -119,12 +119,15 @@ enum sign_mode {
 	SIGN_WARN_STRIP,
 	SIGN_STRIP,
 	SIGN_STRIP_IF_INVALID,
+	SIGN_RE_SIGN_IF_INVALID,
 };
 
 /*
  * Return 0 if `arg` can be parsed into an `enum sign_mode`. Return -1
- * otherwise.
+ * otherwise. If the parsed mode is SIGN_RE_SIGN_IF_INVALID and GPG key provided
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

