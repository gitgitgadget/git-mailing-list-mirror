Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B193E8C7E
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 20:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773173485; cv=none; b=MBTp1+1yCFbeFMFT1YmDJFoPyTw54nkPkUltfZ+D3pyibr8DB2Nogd3ZaaV7ILglspXjmXoOElHPt2QB36gb7w2Gk0aL2flSB4gsMfYu/CXHSzi0IDjtM94vzK5tqaHo1KHjWDKCxRH6X2YuTJf7PQkGlV8RRLr00B887hztRmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773173485; c=relaxed/simple;
	bh=bah1q9S+QOSwzEr6LkxImhvHr+DIYU2mevCjFOmLwoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gs8YUlrz8cbDhm9VEonTWlS1j191nOkPvktcM47nzM/j23Qd/QG4GsdT5+KAP8onEDpU4+VUOlWFbwInbw3ZH8H+Bp/MU4FqodgvrMAXH1l3vBjgVIS3hMvQQmqhM40iEQj/gYGmiUj+VSmeSsnRgiPFUowSTUjNNpx+tX8Gp08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PsFJyTWI; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsFJyTWI"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7d751ef36ccso1176906a34.0
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 13:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773173482; x=1773778282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33pkVS0z+zXGhIYn1dtGYnrXVbLIOJGuumh4hKG0DDw=;
        b=PsFJyTWIwm/QhnUET1cIgPpDJMGWXQ4WT6eoTuscXG6lB5SC8p4wHebDeKyEdVGwo/
         VFUIW/qZwQnAOYYAEG6wWYAZSluqAEYeNPinNkmrXVu4WfINu5rutwJqATlxKtW1vUOw
         cMvuwzpMm6hQ5qjfgOc0gjytktWH7P4VhTQlOUD8zXjDUd/N7HLkG2t3QSjvTonWNqL7
         uf5nykHDKDIKjNhhs6IXnK/a425RZ+D4MGQfyqrdJw4KENL9BOzVLUUhu/p/0ibqNG8f
         4xQDGqREI5ExJHxR12Q/G9DnnYXVzY+pACjOLSVMz9wh9JVIgDbzYe6ceJton79e/FPQ
         kS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773173482; x=1773778282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=33pkVS0z+zXGhIYn1dtGYnrXVbLIOJGuumh4hKG0DDw=;
        b=roXzhFeTEDPFOQRDPv16nvGFOufKuvzuA0dIWgwNW6pEI2oSYqwf+yJgCXK5aFY5Dl
         qk+N+bgxZ2YRtEdihHzZbF3lSa/T4SO5oyhaTirOnPjfOFDPzzC+jnqaXTqC7R2lq61w
         /nqldAJA1beMLXJiL7qa7XF25Aj4pN9yIpy7mfFRKJ1dO3/X2aia+exoGSFoVheW2UXi
         AcZIJGcPHEwsUo5HEbjJr+U/6EcTlSvJsv6LIhMhhy03UcnBmrnAw6pZEQMBTKCllbPq
         I2etWV1+kO/1x9+syuefRWk7pmbegss6AmJvIpLKQYbah0ay3798Hahrw4XahtfXD8WW
         sAnw==
X-Gm-Message-State: AOJu0YzfQ+HOBX4e0/fjMLmuoSVb6nzAQupbfldxZ4N12xxEWsbpPicd
	qdG9M6AOcrcWB7KUe+b1Zonq4ODJKgBCgmvvMjXxnZsFApSHD/103cktOqtUJw==
X-Gm-Gg: ATEYQzxWWS35rqVkIQrVfyLCLjKbPJPFunPPdVbS64dYb/G8MfOf+bXSK8qOcRLOunN
	eGdQDe5fxfkzVvlvGODHIRkL5FzcKbC6zgMsB9dfv4Y6Fj50dyHRRoASy3uHAFSYq5Obec/dREj
	Fw9xR7YdbtO/Zq8jaDFKPJJ9Dgc2f4moSjp0C7QKwMY46P3A7+kmSizNMWrCb2Lir8OFTAP2weo
	T0g7ZQm4ba5syDZCI6NblfmEsOr4uDxSXuwIswSuSSXqGK8zZLU4MCHUTdnDlf1paZLfPtoX1mE
	DSHOJyJjKRk2l1y/x5DrJRHwzNA3ADJDmRBWuc3sjYAxxbBg7XJj06qQjE7EKeHF3QVq3rryjxp
	hKInETXa+XQR8E9hU2uaDxdoiqmw1ISjm/y1lAhr1Ed2marDZ5U2LriYpGD7mIWbDAcfZiSFuic
	2KnfuIs1Blbi5OfaChhm7W8yaEc9QP1xU=
X-Received: by 2002:a05:6820:4c05:b0:67b:c5ef:abbf with SMTP id 006d021491bc7-67bc88b412dmr57273eaf.29.1773173482333;
        Tue, 10 Mar 2026 13:11:22 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67bacd85dd6sm6221066eaf.11.2026.03.10.13.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 13:11:21 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: sandals@crustytoothpaste.net,
	christian.couder@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 0/3] fast-import: add mode to re-sign invalid commit signatures
Date: Tue, 10 Mar 2026 15:11:13 -0500
Message-ID: <20260310201116.1130160-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0.381.g628a66ccf6
In-Reply-To: <20260306205359.1723254-1-jltobler@gmail.com>
References: <20260306205359.1723254-1-jltobler@gmail.com>
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

Changes since V2:
- Adapted commit message in second patch to improve clarity.
- Fixed typos.
- Renamed SIGN_RESIGN_IF_INVALID to SIGN_RE_SIGN_IF_INVALID.
- Created separate helper function to handle printing invalid signature
  warnings.

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
 builtin/fast-import.c              | 101 ++++++++++++++++-----
 commit.c                           |  16 +---
 commit.h                           |   2 -
 gpg-interface.c                    |  36 ++++++--
 gpg-interface.h                    |  14 ++-
 t/t9305-fast-import-signatures.sh  | 140 ++++++++++++++++++-----------
 8 files changed, 222 insertions(+), 99 deletions(-)

Range-diff against v2:
1:  0d00b72ee0 = 1:  0d00b72ee0 commit: remove unused forward declaration
2:  499025532c ! 2:  0b0a06347d gpg-interface: introduce sign_buffer_with_key()
    @@ Commit message
         provided and handles generating the commit signature accordingly. This
         signing operation is not really specific to commits as any arbitrary
         buffer can be signed. Also, in a subsequent commit, this same logic is
    -    reused by git-fast-import(1) when resigning invalid commit signatures.
    -    Introduce `sign_buffer_with_key()` to centralize signing key resolution
    -    in gpg-interface to allow callers to reuse the same behavior without
    -    duplicating logic.
    +    reused by git-fast-import(1) when re-signing invalid commit signatures.
    +
    +    Move the `sign_commit_to_strbuf()` helper from "commit.c" to
    +    "gpg-interface.c" and rename it to `sign_buffer_with_key()`. Also export
    +    this function so it can be used by "commit.c" and
    +    "builtin/fast-import.c" in the subsequent commit.
     
         Signed-off-by: Justin Tobler <jltobler@gmail.com>
     
3:  bea1a42eb9 ! 3:  57a27ccc61 fast-import: add mode to re-sign invalid commit signatures
    @@ builtin/fast-export.c: static void handle_commit(struct commit *commit, struct r
      		case SIGN_STRIP_IF_INVALID:
      			die(_("'strip-if-invalid' is not a valid mode for "
      			      "git fast-export with --signed-commits=<mode>"));
    -+		case SIGN_RESIGN_IF_INVALID:
    ++		case SIGN_RE_SIGN_IF_INVALID:
     +			die(_("'re-sign-if-invalid' is not a valid mode for "
     +			      "git fast-export with --signed-commits=<mode>"));
      		default:
    @@ builtin/fast-export.c: static void handle_tag(const char *name, struct tag *tag)
      			case SIGN_STRIP_IF_INVALID:
      				die(_("'strip-if-invalid' is not a valid mode for "
      				      "git fast-export with --signed-tags=<mode>"));
    -+			case SIGN_RESIGN_IF_INVALID:
    ++			case SIGN_RE_SIGN_IF_INVALID:
     +				die(_("'re-sign-if-invalid' is not a valid mode for "
     +				      "git fast-export with --signed-tags=<mode>"));
      			default:
    @@ builtin/fast-import.c: static void finalize_commit_buffer(struct strbuf *new_dat
     -				    struct signature_data *sig_sha1,
     -				    struct signature_data *sig_sha256,
     -				    struct strbuf *msg)
    ++static void warn_invalid_signature(struct signature_check *check,
    ++				   const char *msg, enum sign_mode mode)
    + {
    +-	struct strbuf tmp_buf = STRBUF_INIT;
    +-	struct signature_check signature_check = { 0 };
    +-	int ret;
    +-
    +-	/* Check signature in a temporary commit buffer */
    +-	strbuf_addbuf(&tmp_buf, new_data);
    +-	finalize_commit_buffer(&tmp_buf, sig_sha1, sig_sha256, msg);
    +-	ret = verify_commit_buffer(tmp_buf.buf, tmp_buf.len, &signature_check);
    +-
    +-	if (ret) {
    +-		const char *signer = signature_check.signer ?
    +-			signature_check.signer : _("unknown");
    +-		const char *subject;
    +-		int subject_len = find_commit_subject(msg->buf, &subject);
    ++	const char *signer = check->signer ? check->signer : _("unknown");
    ++	const char *subject;
    ++	int subject_len = find_commit_subject(msg, &subject);
    + 
    ++	switch (mode) {
    ++	case SIGN_STRIP_IF_INVALID:
    + 		if (subject_len > 100)
    + 			warning(_("stripping invalid signature for commit '%.100s...'\n"
    + 				  "  allegedly by %s"), subject, signer);
    +@@ builtin/fast-import.c: static void handle_strip_if_invalid(struct strbuf *new_data,
    + 		else
    + 			warning(_("stripping invalid signature for commit\n"
    + 				  "  allegedly by %s"), signer);
    ++		break;
    ++	case SIGN_RE_SIGN_IF_INVALID:
    ++		if (subject_len > 100)
    ++			warning(_("re-signing invalid signature for commit '%.100s...'\n"
    ++				  "  allegedly by %s"), subject, signer);
    ++		else if (subject_len > 0)
    ++			warning(_("re-signing invalid signature for commit '%.*s'\n"
    ++				  "  allegedly by %s"), subject_len, subject, signer);
    ++		else
    ++			warning(_("re-signing invalid signature for commit\n"
    ++				  "  allegedly by %s"), signer);
    ++		break;
    ++	default:
    ++		BUG("unsupported signing mode");
    ++	}
    ++}
    ++
     +static void handle_signature_if_invalid(struct strbuf *new_data,
     +					struct signature_data *sig_sha1,
     +					struct signature_data *sig_sha256,
     +					struct strbuf *msg,
     +					enum sign_mode mode)
    - {
    - 	struct strbuf tmp_buf = STRBUF_INIT;
    - 	struct signature_check signature_check = { 0 };
    -@@ builtin/fast-import.c: static void handle_strip_if_invalid(struct strbuf *new_data,
    - 		const char *subject;
    - 		int subject_len = find_commit_subject(msg->buf, &subject);
    - 
    --		if (subject_len > 100)
    --			warning(_("stripping invalid signature for commit '%.100s...'\n"
    --				  "  allegedly by %s"), subject, signer);
    --		else if (subject_len > 0)
    --			warning(_("stripping invalid signature for commit '%.*s'\n"
    --				  "  allegedly by %s"), subject_len, subject, signer);
    --		else
    --			warning(_("stripping invalid signature for commit\n"
    --				  "  allegedly by %s"), signer);
    -+		if (mode == SIGN_STRIP_IF_INVALID) {
    -+			if (subject_len > 100)
    -+				warning(_("stripping invalid signature for commit '%.100s...'\n"
    -+					  "  allegedly by %s"), subject, signer);
    -+			else if (subject_len > 0)
    -+				warning(_("stripping invalid signature for commit '%.*s'\n"
    -+					  "  allegedly by %s"), subject_len, subject, signer);
    -+			else
    -+				warning(_("stripping invalid signature for commit\n"
    -+					  "  allegedly by %s"), signer);
    -+		} else if (mode == SIGN_RESIGN_IF_INVALID) {
    ++{
    ++	struct strbuf tmp_buf = STRBUF_INIT;
    ++	struct signature_check signature_check = { 0 };
    ++	int ret;
    ++
    ++	/* Check signature in a temporary commit buffer */
    ++	strbuf_addbuf(&tmp_buf, new_data);
    ++	finalize_commit_buffer(&tmp_buf, sig_sha1, sig_sha256, msg);
    ++	ret = verify_commit_buffer(tmp_buf.buf, tmp_buf.len, &signature_check);
    ++
    ++	if (ret) {
    ++		warn_invalid_signature(&signature_check, msg->buf, mode);
    ++
    ++		if (mode == SIGN_RE_SIGN_IF_INVALID) {
     +			struct strbuf signature = STRBUF_INIT;
     +			struct strbuf payload = STRBUF_INIT;
     +
    -+			if (subject_len > 100)
    -+				warning(_("re-signing invalid signature for commit '%.100s...'\n"
    -+					  "  allegedly by %s"), subject, signer);
    -+			else if (subject_len > 0)
    -+				warning(_("re-signing invalid signature for commit '%.*s'\n"
    -+					  "  allegedly by %s"), subject_len, subject, signer);
    -+			else
    -+				warning(_("re-signing invalid signature for commit\n"
    -+					  "  allegedly by %s"), signer);
    -+
     +			/*
     +			 * NEEDSWORK: To properly support interoperability mode
     +			 * when re-signing commit signatures, the commit buffer
     +			 * must be provided in both the repository and
    -+			 * compatability object formats. As currently
    ++			 * compatibility object formats. As currently
     +			 * implemented, only the repository object format is
    -+			 * considered meaning compatability signatures cannot be
    ++			 * considered meaning compatibility signatures cannot be
     +			 * generated. Thus, attempting to re-sign commit
     +			 * signatures in interoperability mode is currently
     +			 * unsupported.
    @@ builtin/fast-import.c: static void parse_new_commit(const char *arg)
      			/* fallthru */
      		case SIGN_VERBATIM:
      		case SIGN_STRIP_IF_INVALID:
    -+		case SIGN_RESIGN_IF_INVALID:
    ++		case SIGN_RE_SIGN_IF_INVALID:
      			import_one_signature(&sig_sha1, &sig_sha256, v);
      			break;
      
    @@ builtin/fast-import.c: static void parse_new_commit(const char *arg)
      
     -	if (signed_commit_mode == SIGN_STRIP_IF_INVALID &&
     +	if ((signed_commit_mode == SIGN_STRIP_IF_INVALID ||
    -+	     signed_commit_mode == SIGN_RESIGN_IF_INVALID) &&
    ++	     signed_commit_mode == SIGN_RE_SIGN_IF_INVALID) &&
      	    (sig_sha1.hash_algo || sig_sha256.hash_algo))
     -		handle_strip_if_invalid(&new_data, &sig_sha1, &sig_sha256, &msg);
     +		handle_signature_if_invalid(&new_data, &sig_sha1, &sig_sha256,
    @@ builtin/fast-import.c: static void handle_tag_signature(struct strbuf *msg, cons
      	case SIGN_STRIP_IF_INVALID:
      		die(_("'strip-if-invalid' is not a valid mode for "
      		      "git fast-import with --signed-tags=<mode>"));
    -+	case SIGN_RESIGN_IF_INVALID:
    ++	case SIGN_RE_SIGN_IF_INVALID:
     +		die(_("'re-sign-if-invalid' is not a valid mode for "
     +		      "git fast-import with --signed-tags=<mode>"));
      	default:
    @@ gpg-interface.c: static int sign_buffer_ssh(struct strbuf *buffer, struct strbuf
      		*mode = SIGN_STRIP_IF_INVALID;
     -	else
     +	} else if (!strcmp(arg, "re-sign-if-invalid")) {
    -+		*mode = SIGN_RESIGN_IF_INVALID;
    ++		*mode = SIGN_RE_SIGN_IF_INVALID;
     +	} else if (skip_prefix(arg, "re-sign-if-invalid=", &arg)) {
    -+		*mode = SIGN_RESIGN_IF_INVALID;
    ++		*mode = SIGN_RE_SIGN_IF_INVALID;
     +		if (keyid)
     +			*keyid = arg;
     +	} else {
    @@ gpg-interface.h: enum sign_mode {
      	SIGN_WARN_STRIP,
      	SIGN_STRIP,
      	SIGN_STRIP_IF_INVALID,
    -+	SIGN_RESIGN_IF_INVALID,
    ++	SIGN_RE_SIGN_IF_INVALID,
      };
      
      /*
       * Return 0 if `arg` can be parsed into an `enum sign_mode`. Return -1
     - * otherwise.
    -+ * otherwise. If the parsed mode is SIGN_RESIGN_IF_INVALID and GPG key provided
    ++ * otherwise. If the parsed mode is SIGN_RE_SIGN_IF_INVALID and GPG key provided
     + * in the arguments in the form `re-sign-if-invalid=<keyid>`, the key-ID is
     + * parsed into `char **keyid`.
       */

base-commit: 7c02d39fc2ed2702223c7674f73150d9a7e61ba4
-- 
2.53.0.381.g628a66ccf6

