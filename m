Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5F43E51EE
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 17:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773250319; cv=none; b=ZbqWGUwfxaVjafcRPNHiIkw29GTaAKqVKUKXBkAnqGFgVyTEqsYsnn1fTJmAkL2jGwdjDCtnZKyLrp6uWb8VBhfNAgzRCvY0RlbfOWB+GUvYlFmt5bBRRbMoTqIBKIIImnoxLXNtCiMydy+bKGQZCC/93mtMTsNJV2VeUn6DfAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773250319; c=relaxed/simple;
	bh=ST59VTYs/QKztXuLw+gOK4LdHxHN+YCp5zcZHB+B7pQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UjXhGiwdAkbuO6wXEcoIPzlT0EYovDNqxG7IOr8Alqsvxdhk+vICnxHiBssELIu3WW6YrmNzBFEZGoDME78ktrXFzgVXD0MpouAChVTRMisyBC6YFTP1K/EQrMq3W7/9GrgMU9bV4WDb3LCSpIaz2Kn1Wlt9VKiDXxEdHPV/KYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gv9aRBuo; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gv9aRBuo"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-46703fb602fso79648b6e.0
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 10:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773250313; x=1773855113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hi8dO/LcsA2wyYXLnpBTLf6HsFP4uAY6LVcNGxJjJ2U=;
        b=gv9aRBuo2hH0Mg/3rvgsozICuE8eaw6JfNebPam876pPGIBYusxhI4sVmtij1jcj4D
         J9cunxLm9owzdQIPBRai+PyzmVjP1Hd7enUIJGGs+q3cHvIbv/IBjDi61CzYpuZySB5k
         9T5ipdXbgesIJJxPRznwyPhLeECxf1/MlHGxI23RqmsOJfn+vBxvI9p2Dx9GGyQkHkiI
         tfobu300fSYgnxomf4vM7+ekbY3l+hBQrUfS1M64MY/+iYUssGoHk04rMn24tYuX7ANZ
         o8IwKZfP7+6T8YzxfwK6Pu+ON4ezZuw8NAgBgneTYpbRqUwz5Podb/+GRn7QiJI0px0p
         PWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773250313; x=1773855113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hi8dO/LcsA2wyYXLnpBTLf6HsFP4uAY6LVcNGxJjJ2U=;
        b=IFxzeUnjo1wLu6sIlF4gPlGjxAzj6AxWlqI5zB+I4HS82XOBLTZonkP7OE4EGEf2wC
         Lz4n5hC4Cj7LNlOfoAOfk3501trESPzrKP+rwWLnlW3of6jPmCdtR2VLP2p5V3VS60g/
         zzqkV9WKvuopRXikSP07L9Z60ZoxUXzA11wI3H2J2lyRaR0ttTgnC2uE0Ma2Stl/BZbM
         KEPfh1h1gDHNFus2N+njiFMKgqNOubO6VO6gVj+CJr0PD1wsBEfNS2Vw7+OEWORYadcE
         gitxHz4jsFNalfOPTdZ4+2NKO73pidtoDMqyZEChKGSwcBpAoDGx3aQEMvW/DKpiZuDE
         X0Ig==
X-Gm-Message-State: AOJu0Yxu1CXX3eq4b/ZX43Wz186VK/Dhmu0gb5QznYDh2kCbjZQaFqAB
	v+ZBxQqsxaR5sC30jAaAKPrfjdmd6I1Yvd6KAFszZzkbAk9Q1v+4iFuo9oh+HA==
X-Gm-Gg: ATEYQzyfWIkaYgLT+IZzwnBpsssPW00j5X8TfG76LVoRCkRJSHAlWOZ/TDm9AzIJy5p
	zDqgGWDQ3AkkYbtnND88QfEh8Ae/2pM+VBU2RQ1HvEDBaOmrEKGk0b0eInkuCNX8O0rb1emn0Bu
	h5MxOL5AgBSV+5rlLocxJAvIofpZxyjgt7EdvgDFQNjq4NjUdTfiq+kOH+mAD7vd3Xx9MIbvOOz
	U7f28LL9gTkafq+pm/IynTrQq98Iy1KsvwkkrSMeEFL2GWG9EABhttm41YB1ZwhpzVv7XHCKO48
	U+FsCh/VsFeOAbABZrZBO5e0YqidyZKJ1ZPmOSxxceWOfdZHQ7K5dFx9yNZ0Mu4FACYamfObCv6
	u6Nl3jKUGnBIfoDhopMfrpxQ7Aj3MaTObXnLboJ3yW7VGVwWuXDMzvf6z2p6wLtcfySSPvWlUCo
	maZdLR5fI5UhgY8JEas01nu/0JE9lUudo=
X-Received: by 2002:a05:6808:f06:b0:467:29d2:1ea4 with SMTP id 5614622812f47-4673356766emr2227628b6e.35.1773250313050;
        Wed, 11 Mar 2026 10:31:53 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e26e2c6sm2826761fac.7.2026.03.11.10.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 10:31:52 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: sandals@crustytoothpaste.net,
	christian.couder@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 0/3] fast-import: add mode to re-sign invalid commit signatures
Date: Wed, 11 Mar 2026 12:31:44 -0500
Message-ID: <20260311173147.2336432-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0.381.g628a66ccf6
In-Reply-To: <20260310201116.1130160-1-jltobler@gmail.com>
References: <20260310201116.1130160-1-jltobler@gmail.com>
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
the `sign-if-invalid` mode to do so accordingly.

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

Changes since V3:
- Rename the `re-sign-if-invalid` mode to `sign-if-invalid`. The
  "if-invalid" already implies the signatures was previously signed
  making "re-sign" redundant.

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
  fast-import: add mode to sign commits with invalid signatures

 Documentation/git-fast-import.adoc |   4 +
 builtin/fast-export.c              |   8 +-
 builtin/fast-import.c              | 100 ++++++++++++++++-----
 commit.c                           |  16 +---
 commit.h                           |   2 -
 gpg-interface.c                    |  36 ++++++--
 gpg-interface.h                    |  14 ++-
 t/t9305-fast-import-signatures.sh  | 140 ++++++++++++++++++-----------
 8 files changed, 221 insertions(+), 99 deletions(-)

Range-diff against v3:
1:  0d00b72ee0 = 1:  0d00b72ee0 commit: remove unused forward declaration
2:  0b0a06347d ! 2:  87f590f1f8 gpg-interface: introduce sign_buffer_with_key()
    @@ Commit message
         provided and handles generating the commit signature accordingly. This
         signing operation is not really specific to commits as any arbitrary
         buffer can be signed. Also, in a subsequent commit, this same logic is
    -    reused by git-fast-import(1) when re-signing invalid commit signatures.
    +    reused by git-fast-import(1) when signing commits with invalid
    +    signatures.
     
         Move the `sign_commit_to_strbuf()` helper from "commit.c" to
         "gpg-interface.c" and rename it to `sign_buffer_with_key()`. Also export
3:  57a27ccc61 ! 3:  8b01ad1570 fast-import: add mode to re-sign invalid commit signatures
    @@ Metadata
     Author: Justin Tobler <jltobler@gmail.com>
     
      ## Commit message ##
    -    fast-import: add mode to re-sign invalid commit signatures
    +    fast-import: add mode to sign commits with invalid signatures
     
         With git-fast-import(1), handling of signed commits is controlled via
         the `--signed-commits=<mode>` option. When an invalid signature is
    -    encountered, a user may want the option to re-sign the commit as opposed
    -    to just stripping the signature. To facilitate this, introduce a
    -    "re-sign-if-invalid" mode for the `--signed-commits` option. Optionally,
    -    a key ID may be explicitly provided in the form
    -    `re-sign-if-invalid[=<keyid>]` to specify which signing key should be
    -    used when re-signing invalid commit signatures.
    +    encountered, a user may want the option to sign the commit again as
    +    opposed to just stripping the signature. To facilitate this, introduce a
    +    "sign-if-invalid" mode for the `--signed-commits` option. Optionally, a
    +    key ID may be explicitly provided in the form
    +    `sign-if-invalid[=<keyid>]` to specify which signing key should be used
    +    when signing invalid commit signatures.
     
    -    Note that to properly support interoperability mode when re-signing
    -    commit signatures, the commit buffer must be created in both the
    -    repository and compatability object formats to generate the appropriate
    -    signatures accordingly. As currently implemented, the commit buffer for
    -    the compatability object format is not reconstructed and thus re-signing
    +    Note that to properly support interoperability mode when signing commit
    +    signatures, the commit buffer must be created in both the repository and
    +    compatability object formats to generate the appropriate signatures
    +    accordingly. As currently implemented, the commit buffer for the
    +    compatability object format is not reconstructed and thus signing
         commits in interoperability mode is not yet supported. Support may be
         added in the future.
     
    @@ Documentation/git-fast-import.adoc: already trusted to run their own code.
      * `strip-if-invalid` will check signatures and, if they are invalid,
        will strip them and display a warning. The validation is performed
        in the same way as linkgit:git-verify-commit[1] does it.
    -+* `re-sign-if-invalid[=<keyid>]`, similar to `strip-if-invalid`, verifies
    ++* `sign-if-invalid[=<keyid>]`, similar to `strip-if-invalid`, verifies
     +  commit signatures and replaces invalid signatures with newly created ones.
     +  Valid signatures are left unchanged. If `<keyid>` is provided, that key is
    -+  used for re-signing; otherwise the configured default signing key is used.
    ++  used for signing; otherwise the configured default signing key is used.
      
      Options for Frontends
      ~~~~~~~~~~~~~~~~~~~~~
    @@ builtin/fast-export.c: static void handle_commit(struct commit *commit, struct r
      		case SIGN_STRIP_IF_INVALID:
      			die(_("'strip-if-invalid' is not a valid mode for "
      			      "git fast-export with --signed-commits=<mode>"));
    -+		case SIGN_RE_SIGN_IF_INVALID:
    -+			die(_("'re-sign-if-invalid' is not a valid mode for "
    ++		case SIGN_SIGN_IF_INVALID:
    ++			die(_("'sign-if-invalid' is not a valid mode for "
     +			      "git fast-export with --signed-commits=<mode>"));
      		default:
      			BUG("invalid signed_commit_mode value %d", signed_commit_mode);
    @@ builtin/fast-export.c: static void handle_tag(const char *name, struct tag *tag)
      			case SIGN_STRIP_IF_INVALID:
      				die(_("'strip-if-invalid' is not a valid mode for "
      				      "git fast-export with --signed-tags=<mode>"));
    -+			case SIGN_RE_SIGN_IF_INVALID:
    -+				die(_("'re-sign-if-invalid' is not a valid mode for "
    ++			case SIGN_SIGN_IF_INVALID:
    ++				die(_("'sign-if-invalid' is not a valid mode for "
     +				      "git fast-export with --signed-tags=<mode>"));
      			default:
      				BUG("invalid signed_commit_mode value %d", signed_commit_mode);
    @@ builtin/fast-import.c: static void handle_strip_if_invalid(struct strbuf *new_da
      			warning(_("stripping invalid signature for commit\n"
      				  "  allegedly by %s"), signer);
     +		break;
    -+	case SIGN_RE_SIGN_IF_INVALID:
    ++	case SIGN_SIGN_IF_INVALID:
     +		if (subject_len > 100)
    -+			warning(_("re-signing invalid signature for commit '%.100s...'\n"
    ++			warning(_("signing commit with invalid signature for '%.100s...'\n"
     +				  "  allegedly by %s"), subject, signer);
     +		else if (subject_len > 0)
    -+			warning(_("re-signing invalid signature for commit '%.*s'\n"
    ++			warning(_("signing commit with invalid signature for '%.*s'\n"
     +				  "  allegedly by %s"), subject_len, subject, signer);
     +		else
    -+			warning(_("re-signing invalid signature for commit\n"
    ++			warning(_("signing commit with invalid signature\n"
     +				  "  allegedly by %s"), signer);
     +		break;
     +	default:
    @@ builtin/fast-import.c: static void handle_strip_if_invalid(struct strbuf *new_da
     +	if (ret) {
     +		warn_invalid_signature(&signature_check, msg->buf, mode);
     +
    -+		if (mode == SIGN_RE_SIGN_IF_INVALID) {
    ++		if (mode == SIGN_SIGN_IF_INVALID) {
     +			struct strbuf signature = STRBUF_INIT;
     +			struct strbuf payload = STRBUF_INIT;
     +
     +			/*
     +			 * NEEDSWORK: To properly support interoperability mode
    -+			 * when re-signing commit signatures, the commit buffer
    ++			 * when signing commit signatures, the commit buffer
     +			 * must be provided in both the repository and
     +			 * compatibility object formats. As currently
     +			 * implemented, only the repository object format is
     +			 * considered meaning compatibility signatures cannot be
    -+			 * generated. Thus, attempting to re-sign commit
    -+			 * signatures in interoperability mode is currently
    -+			 * unsupported.
    ++			 * generated. Thus, attempting to sign commit signatures
    ++			 * in interoperability mode is currently unsupported.
     +			 */
     +			if (the_repository->compat_hash_algo)
    -+				die(_("re-signing signatures in interoperability mode is unsupported"));
    ++				die(_("signing signatures in interoperability mode is unsupported"));
     +
     +			strbuf_addstr(&payload, signature_check.payload);
     +			if (sign_buffer_with_key(&payload, &signature, signed_commit_keyid))
    @@ builtin/fast-import.c: static void parse_new_commit(const char *arg)
      			/* fallthru */
      		case SIGN_VERBATIM:
      		case SIGN_STRIP_IF_INVALID:
    -+		case SIGN_RE_SIGN_IF_INVALID:
    ++		case SIGN_SIGN_IF_INVALID:
      			import_one_signature(&sig_sha1, &sig_sha256, v);
      			break;
      
    @@ builtin/fast-import.c: static void parse_new_commit(const char *arg)
      
     -	if (signed_commit_mode == SIGN_STRIP_IF_INVALID &&
     +	if ((signed_commit_mode == SIGN_STRIP_IF_INVALID ||
    -+	     signed_commit_mode == SIGN_RE_SIGN_IF_INVALID) &&
    ++	     signed_commit_mode == SIGN_SIGN_IF_INVALID) &&
      	    (sig_sha1.hash_algo || sig_sha256.hash_algo))
     -		handle_strip_if_invalid(&new_data, &sig_sha1, &sig_sha256, &msg);
     +		handle_signature_if_invalid(&new_data, &sig_sha1, &sig_sha256,
    @@ builtin/fast-import.c: static void handle_tag_signature(struct strbuf *msg, cons
      	case SIGN_STRIP_IF_INVALID:
      		die(_("'strip-if-invalid' is not a valid mode for "
      		      "git fast-import with --signed-tags=<mode>"));
    -+	case SIGN_RE_SIGN_IF_INVALID:
    -+		die(_("'re-sign-if-invalid' is not a valid mode for "
    ++	case SIGN_SIGN_IF_INVALID:
    ++		die(_("'sign-if-invalid' is not a valid mode for "
     +		      "git fast-import with --signed-tags=<mode>"));
      	default:
      		BUG("invalid signed_tag_mode value %d from tag '%s'",
    @@ gpg-interface.c: static int sign_buffer_ssh(struct strbuf *buffer, struct strbuf
     +	} else if (!strcmp(arg, "strip-if-invalid")) {
      		*mode = SIGN_STRIP_IF_INVALID;
     -	else
    -+	} else if (!strcmp(arg, "re-sign-if-invalid")) {
    -+		*mode = SIGN_RE_SIGN_IF_INVALID;
    -+	} else if (skip_prefix(arg, "re-sign-if-invalid=", &arg)) {
    -+		*mode = SIGN_RE_SIGN_IF_INVALID;
    ++	} else if (!strcmp(arg, "sign-if-invalid")) {
    ++		*mode = SIGN_SIGN_IF_INVALID;
    ++	} else if (skip_prefix(arg, "sign-if-invalid=", &arg)) {
    ++		*mode = SIGN_SIGN_IF_INVALID;
     +		if (keyid)
     +			*keyid = arg;
     +	} else {
    @@ gpg-interface.h: enum sign_mode {
      	SIGN_WARN_STRIP,
      	SIGN_STRIP,
      	SIGN_STRIP_IF_INVALID,
    -+	SIGN_RE_SIGN_IF_INVALID,
    ++	SIGN_SIGN_IF_INVALID,
      };
      
      /*
       * Return 0 if `arg` can be parsed into an `enum sign_mode`. Return -1
     - * otherwise.
    -+ * otherwise. If the parsed mode is SIGN_RE_SIGN_IF_INVALID and GPG key provided
    -+ * in the arguments in the form `re-sign-if-invalid=<keyid>`, the key-ID is
    -+ * parsed into `char **keyid`.
    ++ * otherwise. If the parsed mode is SIGN_SIGN_IF_INVALID and GPG key provided in
    ++ * the arguments in the form `sign-if-invalid=<keyid>`, the key-ID is parsed
    ++ * into `char **keyid`.
       */
     -int parse_sign_mode(const char *arg, enum sign_mode *mode);
     +int parse_sign_mode(const char *arg, enum sign_mode *mode, const char **keyid);
    @@ t/t9305-fast-import-signatures.sh: test_expect_success GPG 'strip both OpenPGP s
     -'
     -
     -test_expect_success GPG 'strip signature invalidated by message change with --signed-commits=strip-if-invalid' '
    -+for mode in strip-if-invalid re-sign-if-invalid
    ++for mode in strip-if-invalid sign-if-invalid
     +do
     +	test_expect_success GPG "import commit with no signature with --signed-commits=$mode" '
     +		git fast-export main >output &&
    @@ t/t9305-fast-import-signatures.sh: test_expect_success GPG 'strip both OpenPGP s
     +			test_grep "stripping invalid signature" log &&
     +			test_grep ! -E "^gpgsig" actual
     +		else
    -+			test_grep "re-signing invalid signature" log &&
    ++			test_grep "signing commit with invalid signature" log &&
     +			test_grep -E "^gpgsig(-sha256)? " actual &&
     +			git -C new verify-commit "$IMPORTED"
     +		fi
    @@ t/t9305-fast-import-signatures.sh: test_expect_success GPG 'strip both OpenPGP s
     +	'
     +done
     +
    -+test_expect_success GPGSSH "re-sign invalid commit with explicit keyid" '
    ++test_expect_success GPGSSH "sign invalid commit with explicit keyid" '
      	rm -rf new &&
      	git init new &&
      
    @@ t/t9305-fast-import-signatures.sh: test_expect_success GPG 'strip signature inva
     +	test_config -C new gpg.format ssh &&
     +	test_config -C new gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
     +	test_must_fail git -C new fast-import --quiet \
    -+		--signed-commits=re-sign-if-invalid <modified >/dev/null 2>&1 &&
    ++		--signed-commits=sign-if-invalid <modified >/dev/null 2>&1 &&
     +
     +	# Import using explicitly provided signing key.
     +	git -C new fast-import --quiet \
    -+		--signed-commits=re-sign-if-invalid="${GPGSSH_KEY_PRIMARY}" <modified &&
    ++		--signed-commits=sign-if-invalid="${GPGSSH_KEY_PRIMARY}" <modified &&
      
      	IMPORTED=$(git -C new rev-parse --verify refs/heads/openpgp-signing) &&
      	test $OPENPGP_SIGNING != $IMPORTED &&

base-commit: 7c02d39fc2ed2702223c7674f73150d9a7e61ba4
-- 
2.53.0.381.g628a66ccf6

