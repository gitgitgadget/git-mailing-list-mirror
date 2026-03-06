Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97101371D13
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 20:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772830448; cv=none; b=uXpDoMyLtEOCUo9GrhB95aMtndN3WECAZ8Hcdtt+poTGkoSGSyyNw9KPXL4XetkWorcABoguzFx4r/20BqW06J3NrkO036g+KdymGvBPqBj7llFfqbzN6H1sJ6v/2eOKST5MFe/E9GF9sKpysFuHByy34g3hRStkvDalE16Ijj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772830448; c=relaxed/simple;
	bh=s60zJ87np8Nx/3d40p5v5OJtaK+JV9iR9LuxH01GNpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lcim0MoD9B2oZ1PhiaPpZN8rI8lOMamaksUlU9LrIp+1ivlZPBJXjNXRv6TCYJwh1USC+8pLTFk/sN8DYNJjB6RWlIf2f77n+Q72Mlu/8HDGA/QFt2+xbPtLa5cQSO3X7coMuC8+WSCX4vASCW4zzMbYDTr87h7XFjl3bl1cHXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8fSVU1a; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8fSVU1a"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-66307e10d1dso6108996eaf.0
        for <git@vger.kernel.org>; Fri, 06 Mar 2026 12:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772830445; x=1773435245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rwyLgg16qVYK1G7PHIA2hLJJy9aa9SHuR4U3wTKDO54=;
        b=P8fSVU1a0YXsI/+7SRILkyAPDOSieWjiNkC0S2UHzTL+s0FfBKEqLEDknUs1QWKxe5
         iLlniS9pgO89wiLmdN0AYjzhKu7yu1TKsgvmsyZQXQO48xXzL9uQTcun0VqiM1axm/Ll
         wsf9DF3IUAWNnnbomjYdxkt+T+H7Nz8r9/5jjsA6gyLUbij8tG+fIpF2EDGQm80xUCXT
         NEPxYdC8/fN2xqRx5AYlir025i79FZx0EqvRsLs3eK3LDE17mPJjZTofDdsm2iwl2/Jj
         kbwyl+/Xo+t1qwkNo9MON/DNOqWVF0B/LgTiuuqQo3yvmLzhSqs++Q5sOmjItrYu77/D
         aTUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772830445; x=1773435245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rwyLgg16qVYK1G7PHIA2hLJJy9aa9SHuR4U3wTKDO54=;
        b=eo2rXdk4fYLGBGUp+vbvwgUf7CsgmAvEsRfUPuk4pEvrqf+1Oz3z04MEeeNXzeScUQ
         b6pjXHO+faWzyQCiPQnaL2WYIsGirk90i/d+tNPjiNH/hZcM1EH2C6+f1oYnZReCsMMM
         8Po08MgCc6T8TYfxWudSDeNhF6iN0uUOgZOcP36kd44QhrDwY6/PtU511Av429+UbKQd
         xYgyIuUQLUwF04aTT9vaBK+48m+b/HZMpLYo+OZww4TWoUOjtl2l4y6wZOytZ/bFrsIl
         /WRmcy/gXGS7vjs80UfyvdjnDYFcMsaT9/MasSRjxC/1ZjrZjoU/r3Vckx4EaYmGqMuY
         bcnw==
X-Gm-Message-State: AOJu0Yy4cJLSG/3W5rJu7AU5Nm5lzLAaWP7JHYbk5r6ZKTOMiMygDClA
	uIUen394/XrgmfSdgd+M1PI6C0LUGP/ESew2oHk0kvYwfWJaHyQaxjHuucxq6g==
X-Gm-Gg: ATEYQzx4uqFtapDfAPGDiT6HFasQy3YE1E3beJD3OTCzZ06P6gwOVblSwGRwrOBXsaj
	QIeXiVdBj0Ctzo7m28OdA2NwGtQYXFLKs89u/MbVYC+Gw/oJttz8FnTJx6+2gqFNYWaA0z9rOLg
	lSJJSVV4sGMhK/QYRvd/oDSGnjUCcKsxH0whR0YTfaFXeWvyHznt3wB0JQ3jNfWcRLp1MWVVOPy
	IePxSW5LYk89jhuvwsmm3/9rEa+VBf26QsrnTV1Nks1DX+fJIwHej8ru96xvA/JMEMNZMfnX1nO
	yxtFjH9CyXeVTOlgR8G0WLFFlmtuFLuNty+sXKvy7rVIBcf+aUc0u9OKpenJCPhedtTsXddNhhF
	FqzWJwo2PM7DhldeLRASAeY+/iBYQ9FWAdhFtQhiH7g8ad9ZMxbB09UVewhuGLJTJC8CqxeUKWO
	VMSitjyn99+ttl4XGrYP9prXZkwC2/pYIQnLppxZFm3g==
X-Received: by 2002:a05:6820:822:b0:662:f61e:75a8 with SMTP id 006d021491bc7-67b9bd72721mr2298991eaf.65.1772830444950;
        Fri, 06 Mar 2026 12:54:04 -0800 (PST)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-416e688d5cdsm2278014fac.20.2026.03.06.12.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 12:54:04 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: sandals@crustytoothpaste.net,
	christian.couder@gmail.com,
	ps@pks.im,
	gister@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 0/3] fast-import: add mode to re-sign invalid commit signatures
Date: Fri,  6 Mar 2026 14:53:56 -0600
Message-ID: <20260306205359.1723254-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0.381.g628a66ccf6
In-Reply-To: <20260223194146.3476768-1-jltobler@gmail.com>
References: <20260223194146.3476768-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings,

With c20f112e51 (fast-import: add 'strip-if-invalid' mode to
--signed-commits=<mode>, 2025-11-17), it became possible to remove
invalid signatures from commits via git-fast-import(1) while maintaining
valid commit signatures. Building upon this functionality, a user may
want to re-sign these invalid commit signatures. This series introduces
the `re-sign-if-invalid` mode to do so accordingly.

The newly added mode in this series currently ignores
`extensions.compatObjectFormat` when generating the new signatures. From
my understanding, to generate the compatibility structure would also
require us to reconstruct the compatibility object for the object being
signed. I think this would be possible to do, but would require getting
the mapped OIDs for the commit parents and tree. I'm not completely sure
of a good way to go about this yet though. I'm also not completely
certain if this is something that should be addressed as part of this
series, or could be done later down the road. So for now I've opted to
delay its implementation. I'm open going down the other route if that is
preferred though.

The first commit is a simple cleanup for something I noticed while
reading though commit signing code. The second commit actually
introduces the new `--signed-commits` mode.

Changes since V1:
- Improved commit messages and comments to better explain why
  interoperability mode is not currently supported.
- Clarified documentation for re-sign-if-invalid mode.
- Renamed `handle_invalid_signature()` to `handle_signature_if_invalid()`.
- Added warning messages specific to commit resigning.
- Fixed some small typos.
- Added support for explicitly specifying the signing key ID via
  `--signed-commits=re-sign-if-invalid[=<keyid>]` similar to how it can
  specified in git-commit(1).
- We now die() as unsupported when attempting to re-sign an invalid
  commit signature in interoperability mode.
- We now die() when failing to re-sign a commit.

Thanks,
-Justin

Justin Tobler (3):
  commit: remove unused forward declaration
  gpg-interface: introduce sign_buffer_with_key()
  fast-import: add mode to re-sign invalid commit signatures

 Documentation/git-fast-import.adoc |   4 +
 builtin/fast-export.c              |   8 +-
 builtin/fast-import.c              |  79 ++++++++++++----
 commit.c                           |  16 +---
 commit.h                           |   2 -
 gpg-interface.c                    |  36 ++++++--
 gpg-interface.h                    |  14 ++-
 t/t9305-fast-import-signatures.sh  | 140 ++++++++++++++++++-----------
 8 files changed, 205 insertions(+), 94 deletions(-)

Range-diff against v1:
1:  0d00b72ee0 = 1:  0d00b72ee0 commit: remove unused forward declaration
-:  ---------- > 2:  499025532c gpg-interface: introduce sign_buffer_with_key()
2:  16e4022616 ! 3:  bea1a42eb9 fast-import: add mode to re-sign invalid commit signatures
    @@ Commit message
         With git-fast-import(1), handling of signed commits is controlled via
         the `--signed-commits=<mode>` option. When an invalid signature is
         encountered, a user may want the option to re-sign the commit as opposed
    -    to just stripping the signature. To faciliate this, introduce a
    -    "re-sign-if-invalid" mode for the `--signed-commits` option.
    +    to just stripping the signature. To facilitate this, introduce a
    +    "re-sign-if-invalid" mode for the `--signed-commits` option. Optionally,
    +    a key ID may be explicitly provided in the form
    +    `re-sign-if-invalid[=<keyid>]` to specify which signing key should be
    +    used when re-signing invalid commit signatures.
     
    -    Note that commits are re-signed using only the repository object format
    -    hash algorithm. If a commit has an additional signature due to the
    -    `compatObjectFormat` repository extension being set, the other signature
    -    is stripped.
    +    Note that to properly support interoperability mode when re-signing
    +    commit signatures, the commit buffer must be created in both the
    +    repository and compatability object formats to generate the appropriate
    +    signatures accordingly. As currently implemented, the commit buffer for
    +    the compatability object format is not reconstructed and thus re-signing
    +    commits in interoperability mode is not yet supported. Support may be
    +    added in the future.
     
         Signed-off-by: Justin Tobler <jltobler@gmail.com>
     
    @@ Documentation/git-fast-import.adoc: already trusted to run their own code.
      * `strip-if-invalid` will check signatures and, if they are invalid,
        will strip them and display a warning. The validation is performed
        in the same way as linkgit:git-verify-commit[1] does it.
    -+* `re-sign-if-invalid` is the same as `strip-if-invalid`, but additionally the
    -+  commits with invalid signatures are signed again, so that old invalid
    -+  signatures are replaced with new valid ones.
    ++* `re-sign-if-invalid[=<keyid>]`, similar to `strip-if-invalid`, verifies
    ++  commit signatures and replaces invalid signatures with newly created ones.
    ++  Valid signatures are left unchanged. If `<keyid>` is provided, that key is
    ++  used for re-signing; otherwise the configured default signing key is used.
      
      Options for Frontends
      ~~~~~~~~~~~~~~~~~~~~~
     
      ## builtin/fast-export.c ##
    +@@ builtin/fast-export.c: static int parse_opt_sign_mode(const struct option *opt,
    + 	if (unset)
    + 		return 0;
    + 
    +-	if (parse_sign_mode(arg, val))
    ++	if (parse_sign_mode(arg, val, NULL))
    + 		return error(_("unknown %s mode: %s"), opt->long_name, arg);
    + 
    + 	return 0;
     @@ builtin/fast-export.c: static void handle_commit(struct commit *commit, struct rev_info *rev,
      		case SIGN_STRIP_IF_INVALID:
      			die(_("'strip-if-invalid' is not a valid mode for "
    @@ builtin/fast-export.c: static void handle_tag(const char *name, struct tag *tag)
      			}
     
      ## builtin/fast-import.c ##
    +@@ builtin/fast-import.c: static const char *global_prefix;
    + 
    + static enum sign_mode signed_tag_mode = SIGN_VERBATIM;
    + static enum sign_mode signed_commit_mode = SIGN_VERBATIM;
    ++static const char *signed_commit_keyid;
    + 
    + /* Memory pools */
    + static struct mem_pool fi_mem_pool = {
     @@ builtin/fast-import.c: static void finalize_commit_buffer(struct strbuf *new_data,
      	strbuf_addbuf(new_data, msg);
      }
    @@ builtin/fast-import.c: static void finalize_commit_buffer(struct strbuf *new_dat
     -				    struct signature_data *sig_sha1,
     -				    struct signature_data *sig_sha256,
     -				    struct strbuf *msg)
    -+static void handle_invalid_signature(struct strbuf *new_data,
    -+				     struct signature_data *sig_sha1,
    -+				     struct signature_data *sig_sha256,
    -+				     struct strbuf *msg,
    -+				     enum sign_mode mode)
    ++static void handle_signature_if_invalid(struct strbuf *new_data,
    ++					struct signature_data *sig_sha1,
    ++					struct signature_data *sig_sha256,
    ++					struct strbuf *msg,
    ++					enum sign_mode mode)
      {
      	struct strbuf tmp_buf = STRBUF_INIT;
      	struct signature_check signature_check = { 0 };
     @@ builtin/fast-import.c: static void handle_strip_if_invalid(struct strbuf *new_data,
    - 			warning(_("stripping invalid signature for commit\n"
    - 				  "  allegedly by %s"), signer);
    + 		const char *subject;
    + 		int subject_len = find_commit_subject(msg->buf, &subject);
      
    -+		if (mode == SIGN_RESIGN_IF_INVALID) {
    +-		if (subject_len > 100)
    +-			warning(_("stripping invalid signature for commit '%.100s...'\n"
    +-				  "  allegedly by %s"), subject, signer);
    +-		else if (subject_len > 0)
    +-			warning(_("stripping invalid signature for commit '%.*s'\n"
    +-				  "  allegedly by %s"), subject_len, subject, signer);
    +-		else
    +-			warning(_("stripping invalid signature for commit\n"
    +-				  "  allegedly by %s"), signer);
    ++		if (mode == SIGN_STRIP_IF_INVALID) {
    ++			if (subject_len > 100)
    ++				warning(_("stripping invalid signature for commit '%.100s...'\n"
    ++					  "  allegedly by %s"), subject, signer);
    ++			else if (subject_len > 0)
    ++				warning(_("stripping invalid signature for commit '%.*s'\n"
    ++					  "  allegedly by %s"), subject_len, subject, signer);
    ++			else
    ++				warning(_("stripping invalid signature for commit\n"
    ++					  "  allegedly by %s"), signer);
    ++		} else if (mode == SIGN_RESIGN_IF_INVALID) {
     +			struct strbuf signature = STRBUF_INIT;
     +			struct strbuf payload = STRBUF_INIT;
    -+			char *key = get_signing_key();
    ++
    ++			if (subject_len > 100)
    ++				warning(_("re-signing invalid signature for commit '%.100s...'\n"
    ++					  "  allegedly by %s"), subject, signer);
    ++			else if (subject_len > 0)
    ++				warning(_("re-signing invalid signature for commit '%.*s'\n"
    ++					  "  allegedly by %s"), subject_len, subject, signer);
    ++			else
    ++				warning(_("re-signing invalid signature for commit\n"
    ++					  "  allegedly by %s"), signer);
     +
     +			/*
    -+			 * Commits are resigned using the repository object
    -+			 * format hash algorithm only. Consequently if
    -+			 * extensions.compatObjectFormat is set, the
    -+			 * compatability hash is not currently used to
    -+			 * additionally sign the commit. If the commit payload
    -+			 * were reconstructed in the compatability format, it
    -+			 * would be possible to generate the other signature
    -+			 * accordingly though.
    ++			 * NEEDSWORK: To properly support interoperability mode
    ++			 * when re-signing commit signatures, the commit buffer
    ++			 * must be provided in both the repository and
    ++			 * compatability object formats. As currently
    ++			 * implemented, only the repository object format is
    ++			 * considered meaning compatability signatures cannot be
    ++			 * generated. Thus, attempting to re-sign commit
    ++			 * signatures in interoperability mode is currently
    ++			 * unsupported.
     +			 */
    ++			if (the_repository->compat_hash_algo)
    ++				die(_("re-signing signatures in interoperability mode is unsupported"));
    ++
     +			strbuf_addstr(&payload, signature_check.payload);
    -+			sign_buffer(&payload, &signature, key);
    ++			if (sign_buffer_with_key(&payload, &signature, signed_commit_keyid))
    ++				die(_("failed to sign commit object"));
     +			add_header_signature(new_data, &signature, the_hash_algo);
     +
     +			strbuf_release(&signature);
     +			strbuf_release(&payload);
    -+			free(key);
     +		}
    -+
    + 
      		finalize_commit_buffer(new_data, NULL, NULL, msg);
      	} else {
    - 		strbuf_swap(new_data, &tmp_buf);
     @@ builtin/fast-import.c: static void parse_new_commit(const char *arg)
      			/* fallthru */
      		case SIGN_VERBATIM:
    @@ builtin/fast-import.c: static void parse_new_commit(const char *arg)
     +	     signed_commit_mode == SIGN_RESIGN_IF_INVALID) &&
      	    (sig_sha1.hash_algo || sig_sha256.hash_algo))
     -		handle_strip_if_invalid(&new_data, &sig_sha1, &sig_sha256, &msg);
    -+		handle_invalid_signature(&new_data, &sig_sha1, &sig_sha256, &msg,
    -+					 signed_commit_mode);
    ++		handle_signature_if_invalid(&new_data, &sig_sha1, &sig_sha256,
    ++					    &msg, signed_commit_mode);
      	else
      		finalize_commit_buffer(&new_data, &sig_sha1, &sig_sha256, &msg);
      
    @@ builtin/fast-import.c: static void handle_tag_signature(struct strbuf *msg, cons
      	default:
      		BUG("invalid signed_tag_mode value %d from tag '%s'",
      		    signed_tag_mode, name);
    +@@ builtin/fast-import.c: static int parse_one_option(const char *option)
    + 	} else if (skip_prefix(option, "export-pack-edges=", &option)) {
    + 		option_export_pack_edges(option);
    + 	} else if (skip_prefix(option, "signed-commits=", &option)) {
    +-		if (parse_sign_mode(option, &signed_commit_mode))
    ++		if (parse_sign_mode(option, &signed_commit_mode, &signed_commit_keyid))
    + 			usagef(_("unknown --signed-commits mode '%s'"), option);
    + 	} else if (skip_prefix(option, "signed-tags=", &option)) {
    +-		if (parse_sign_mode(option, &signed_tag_mode))
    ++		if (parse_sign_mode(option, &signed_tag_mode, NULL))
    + 			usagef(_("unknown --signed-tags mode '%s'"), option);
    + 	} else if (!strcmp(option, "quiet")) {
    + 		show_stats = 0;
     
      ## gpg-interface.c ##
    -@@ gpg-interface.c: int parse_sign_mode(const char *arg, enum sign_mode *mode)
    +@@ gpg-interface.c: static int sign_buffer_ssh(struct strbuf *buffer, struct strbuf *signature,
    + 	return ret;
    + }
    + 
    +-int parse_sign_mode(const char *arg, enum sign_mode *mode)
    ++int parse_sign_mode(const char *arg, enum sign_mode *mode, const char **keyid)
    + {
    +-	if (!strcmp(arg, "abort"))
    ++	if (!strcmp(arg, "abort")) {
    + 		*mode = SIGN_ABORT;
    +-	else if (!strcmp(arg, "verbatim") || !strcmp(arg, "ignore"))
    ++	} else if (!strcmp(arg, "verbatim") || !strcmp(arg, "ignore")) {
    + 		*mode = SIGN_VERBATIM;
    +-	else if (!strcmp(arg, "warn-verbatim") || !strcmp(arg, "warn"))
    ++	} else if (!strcmp(arg, "warn-verbatim") || !strcmp(arg, "warn")) {
    + 		*mode = SIGN_WARN_VERBATIM;
    +-	else if (!strcmp(arg, "warn-strip"))
    ++	} else if (!strcmp(arg, "warn-strip")) {
    + 		*mode = SIGN_WARN_STRIP;
    +-	else if (!strcmp(arg, "strip"))
    ++	} else if (!strcmp(arg, "strip")) {
      		*mode = SIGN_STRIP;
    - 	else if (!strcmp(arg, "strip-if-invalid"))
    +-	else if (!strcmp(arg, "strip-if-invalid"))
    ++	} else if (!strcmp(arg, "strip-if-invalid")) {
      		*mode = SIGN_STRIP_IF_INVALID;
    -+	else if (!strcmp(arg, "re-sign-if-invalid"))
    +-	else
    ++	} else if (!strcmp(arg, "re-sign-if-invalid")) {
     +		*mode = SIGN_RESIGN_IF_INVALID;
    - 	else
    ++	} else if (skip_prefix(arg, "re-sign-if-invalid=", &arg)) {
    ++		*mode = SIGN_RESIGN_IF_INVALID;
    ++		if (keyid)
    ++			*keyid = arg;
    ++	} else {
      		return -1;
    ++	}
      	return 0;
    + }
     
      ## gpg-interface.h ##
     @@ gpg-interface.h: enum sign_mode {
    @@ gpg-interface.h: enum sign_mode {
      };
      
      /*
    +  * Return 0 if `arg` can be parsed into an `enum sign_mode`. Return -1
    +- * otherwise.
    ++ * otherwise. If the parsed mode is SIGN_RESIGN_IF_INVALID and GPG key provided
    ++ * in the arguments in the form `re-sign-if-invalid=<keyid>`, the key-ID is
    ++ * parsed into `char **keyid`.
    +  */
    +-int parse_sign_mode(const char *arg, enum sign_mode *mode);
    ++int parse_sign_mode(const char *arg, enum sign_mode *mode, const char **keyid);
    + 
    + #endif
     
      ## t/t9305-fast-import-signatures.sh ##
     @@ t/t9305-fast-import-signatures.sh: test_expect_success GPG 'strip both OpenPGP signatures with --signed-commits=war
    @@ t/t9305-fast-import-signatures.sh: test_expect_success GPG 'strip both OpenPGP s
     -'
     -
     -test_expect_success GPG 'strip signature invalidated by message change with --signed-commits=strip-if-invalid' '
    --	rm -rf new &&
    --	git init new &&
    --
    --	git fast-export --signed-commits=verbatim openpgp-signing >output &&
    --
    --	# Change the commit message, which invalidates the signature.
    --	# The commit message length should not change though, otherwise the
    --	# corresponding `data <length>` command would have to be changed too.
    --	sed "s/OpenPGP signed commit/OpenPGP forged commit/" output >modified &&
    --
    --	git -C new fast-import --quiet --signed-commits=strip-if-invalid <modified >log 2>&1 &&
    --
    --	IMPORTED=$(git -C new rev-parse --verify refs/heads/openpgp-signing) &&
    --	test $OPENPGP_SIGNING != $IMPORTED &&
    --	git -C new cat-file commit "$IMPORTED" >actual &&
    --	test_grep ! -E "^gpgsig" actual &&
    --	test_grep "stripping invalid signature" log
    --'
    --
    --test_expect_success GPGSM 'keep valid X.509 signature with --signed-commits=strip-if-invalid' '
    --	rm -rf new &&
    --	git init new &&
    --
    --	git fast-export --signed-commits=verbatim x509-signing >output &&
    --	git -C new fast-import --quiet --signed-commits=strip-if-invalid <output >log 2>&1 &&
    --	IMPORTED=$(git -C new rev-parse --verify refs/heads/x509-signing) &&
    --	test $X509_SIGNING = $IMPORTED &&
    --	git -C new cat-file commit "$IMPORTED" >actual &&
    --	test_grep -E "^gpgsig(-sha256)? " actual &&
    --	test_must_be_empty log
    --'
    --
    --test_expect_success GPGSSH 'keep valid SSH signature with --signed-commits=strip-if-invalid' '
    --	rm -rf new &&
    --	git init new &&
    --
    --	test_config -C new gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
    --
    --	git fast-export --signed-commits=verbatim ssh-signing >output &&
    --	git -C new fast-import --quiet --signed-commits=strip-if-invalid <output >log 2>&1 &&
    --	IMPORTED=$(git -C new rev-parse --verify refs/heads/ssh-signing) &&
    --	test $SSH_SIGNING = $IMPORTED &&
    --	git -C new cat-file commit "$IMPORTED" >actual &&
    --	test_grep -E "^gpgsig(-sha256)? " actual &&
    --	test_must_be_empty log
    --'
     +for mode in strip-if-invalid re-sign-if-invalid
     +do
     +	test_expect_success GPG "import commit with no signature with --signed-commits=$mode" '
    @@ t/t9305-fast-import-signatures.sh: test_expect_success GPG 'strip both OpenPGP s
     +		test_must_be_empty log
     +	'
     +
    -+	test_expect_success GPG "strip signature invalidated by message change with --signed-commits=$mode" '
    ++	test_expect_success GPG "handle signature invalidated by message change with --signed-commits=$mode" '
     +		rm -rf new &&
     +		git init new &&
     +
    @@ t/t9305-fast-import-signatures.sh: test_expect_success GPG 'strip both OpenPGP s
     +		IMPORTED=$(git -C new rev-parse --verify refs/heads/openpgp-signing) &&
     +		test $OPENPGP_SIGNING != $IMPORTED &&
     +		git -C new cat-file commit "$IMPORTED" >actual &&
    -+		test_grep "stripping invalid signature" log &&
     +
     +		if test "$mode" = strip-if-invalid
     +		then
    ++			test_grep "stripping invalid signature" log &&
     +			test_grep ! -E "^gpgsig" actual
     +		else
    ++			test_grep "re-signing invalid signature" log &&
     +			test_grep -E "^gpgsig(-sha256)? " actual &&
     +			git -C new verify-commit "$IMPORTED"
     +		fi
    @@ t/t9305-fast-import-signatures.sh: test_expect_success GPG 'strip both OpenPGP s
     +		test_must_be_empty log
     +	'
     +done
    ++
    ++test_expect_success GPGSSH "re-sign invalid commit with explicit keyid" '
    + 	rm -rf new &&
    + 	git init new &&
    + 
    +@@ t/t9305-fast-import-signatures.sh: test_expect_success GPG 'strip signature invalidated by message change with --si
    + 	# corresponding `data <length>` command would have to be changed too.
    + 	sed "s/OpenPGP signed commit/OpenPGP forged commit/" output >modified &&
    + 
    +-	git -C new fast-import --quiet --signed-commits=strip-if-invalid <modified >log 2>&1 &&
    ++	# Configure the target repository with an invalid default signing key.
    ++	test_config -C new user.signingkey "not-a-real-key-id" &&
    ++	test_config -C new gpg.format ssh &&
    ++	test_config -C new gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
    ++	test_must_fail git -C new fast-import --quiet \
    ++		--signed-commits=re-sign-if-invalid <modified >/dev/null 2>&1 &&
    ++
    ++	# Import using explicitly provided signing key.
    ++	git -C new fast-import --quiet \
    ++		--signed-commits=re-sign-if-invalid="${GPGSSH_KEY_PRIMARY}" <modified &&
    + 
    + 	IMPORTED=$(git -C new rev-parse --verify refs/heads/openpgp-signing) &&
    + 	test $OPENPGP_SIGNING != $IMPORTED &&
    + 	git -C new cat-file commit "$IMPORTED" >actual &&
    +-	test_grep ! -E "^gpgsig" actual &&
    +-	test_grep "stripping invalid signature" log
    +-'
    +-
    +-test_expect_success GPGSM 'keep valid X.509 signature with --signed-commits=strip-if-invalid' '
    +-	rm -rf new &&
    +-	git init new &&
    +-
    +-	git fast-export --signed-commits=verbatim x509-signing >output &&
    +-	git -C new fast-import --quiet --signed-commits=strip-if-invalid <output >log 2>&1 &&
    +-	IMPORTED=$(git -C new rev-parse --verify refs/heads/x509-signing) &&
    +-	test $X509_SIGNING = $IMPORTED &&
    +-	git -C new cat-file commit "$IMPORTED" >actual &&
    + 	test_grep -E "^gpgsig(-sha256)? " actual &&
    +-	test_must_be_empty log
    +-'
    +-
    +-test_expect_success GPGSSH 'keep valid SSH signature with --signed-commits=strip-if-invalid' '
    +-	rm -rf new &&
    +-	git init new &&
    +-
    +-	test_config -C new gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
    +-
    +-	git fast-export --signed-commits=verbatim ssh-signing >output &&
    +-	git -C new fast-import --quiet --signed-commits=strip-if-invalid <output >log 2>&1 &&
    +-	IMPORTED=$(git -C new rev-parse --verify refs/heads/ssh-signing) &&
    +-	test $SSH_SIGNING = $IMPORTED &&
    +-	git -C new cat-file commit "$IMPORTED" >actual &&
    +-	test_grep -E "^gpgsig(-sha256)? " actual &&
    +-	test_must_be_empty log
    ++	git -C new verify-commit "$IMPORTED"
    + '
      
      test_done

base-commit: 7c02d39fc2ed2702223c7674f73150d9a7e61ba4
-- 
2.53.0.381.g628a66ccf6

