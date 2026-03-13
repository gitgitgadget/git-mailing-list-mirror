Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14952F532F
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 01:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773365987; cv=none; b=HCoKQAm+tPqX8gYP5tjW7/5JFnjkbNSGshEGRXZA4E9UJg9KwYWz7tSA/WO0jjzQ+E6aeoj3gW8cETXM92FAwtFcn8VEgejYUMVUboYzGhGiLSquedYCtgA5Vd8vOJsqyqHWvkGoGoYyZu4j3VxKAIe9j83rDbBursbLUVw19dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773365987; c=relaxed/simple;
	bh=gPg2DUyX0jrMmcnKGQQHcWfDW0Sq3uir/tTnh+Kx/CI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fjSR3euWbsiARwqOnTrFPW+o2AOP0bHga7UCAz16TkwYp57RL++KzlZGcASKrCy1RVY4pLQ2gml3ZLh08j70+e+TI+Q6WWHLrw+xqKCWMfacMpASkyXglq/1miuw9AAC/jvDwDzZK7Ol7aVjagK7tt4uuWXY3s80AbC91E8wP9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfHXzEIf; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfHXzEIf"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-466ec4c6852so1054018b6e.3
        for <git@vger.kernel.org>; Thu, 12 Mar 2026 18:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773365984; x=1773970784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sq/JRPtU0MTLf+/Ti+2/LwaOuMdoRQ8wcDY8mhZJy7s=;
        b=RfHXzEIfT2jKy28iNkOqM6KTuYi2M2L88CNSXKYdojO3UvlRsarfbU8nzZ6lRSRVU3
         ZHRnZSNZzyHuNkaC5lt/M/+lGtsMV9CM7HT7sFnP2JY4ngCrhZIMDs6CCXDZhc143/RV
         YLfShoECTqrSFFfzf/r78KGZh9HJML2K5k4+oTWgyfXmb7/erP7Sz9uQRQrjxGlBirQD
         RF06Ce/dt2I4re9GUCDvAt9owAVWelCDL4iXeenyvzhRSJCIdJYV+hxKv+qSxAHWIr/C
         aoAgnMZr4HgON7Pm1AoxaE2DT2Fxh34fq0Ms7JPWtbAZ8A0A2qqntYVZb/OBxMjDdx0n
         Q3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773365984; x=1773970784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sq/JRPtU0MTLf+/Ti+2/LwaOuMdoRQ8wcDY8mhZJy7s=;
        b=AsNdQa+StzkuAiFF6v5BW3ymWsxdzRlo6pQZ4mdbUAxvzc6GO2BQIFmatVCnxcgafd
         iOoLsL3KvTYQpmG3heZNKJ/E5pYux4phAtp2p/SzsijyKm3w5673sihmzNebiatNguIS
         MLtx1DpNpmB0s9WGmpiDg7Y9T7yIL+lcvoP10c3sU7TWdoNAXvRNnjthEU0Xr8uCb17A
         68n5yQ4IbehTRcRaZbkgsFDe3rPPBA9iNX+6xQD01pd9oAUNyygqMIr0fJzn9O8cj69I
         taSLcux9YY9aXkjy5d95na0mH2dAzHrG58VNioGTvGSabbkp9+mYJM+fAFypRQqlfVdg
         zB8Q==
X-Gm-Message-State: AOJu0YzvK8XtxoDAFZIS0Y2wBsJ7n9rDqGa0+YD17HvGmm3wkLnAijfu
	5wB8FyMIopLu78KupJv9ikXHc+kFEzUSR83mc8tvOVuV5V7sWkPuPkTYrmk1Pw==
X-Gm-Gg: ATEYQzxDjlzFpYGFyGxis0lms6VfCXMgsVXlTMLbY4WWdGjUlG1YI1veqVRFeCxoB5r
	nobfruobiOenYk2t4SmeBEXP5jqc26jVESYPEolYE4pJ4zncxCPJrfvy0fgzqdMdYMMUMJ6ZrwF
	pw2CwLuL1Wxr62A0pVXe3rfN21B/352tT2XEwT7f0Np8KVJ/1x+am2jtoPY5ytBuU+YSL+6TJa7
	TGIwm/r7ewU+taUAacsec9FYQIhs+0xSDdWnJOAS6QWNrEO8UzeGOzIClrFaXXB/FIJPSScZr/h
	+i0p7y8QKox3M2QwgKj4oBwOVI2Vx3vyqzKqM+ZmEtX/WnW3HMitt8xGX2du3gQLLJj5xYROt7a
	nQEHUPN8PvFrNcg7nA7t3Hcr4fnma5GYs3rPXOu7zIqdfIHhHCul3u7+IEGFdf6vdOKAJzGuljh
	CW2UxOzkGPOUP+hurOSTk3JNLYtzDbWQk=
X-Received: by 2002:a05:6808:1641:b0:462:d784:fc6e with SMTP id 5614622812f47-467575c7506mr809368b6e.53.1773365984129;
        Thu, 12 Mar 2026 18:39:44 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-467342c084asm3897154b6e.12.2026.03.12.18.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 18:39:43 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: sandals@crustytoothpaste.net,
	christian.couder@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	peff@peff.net,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v6 0/3] fast-import: add mode to re-sign invalid commit signatures
Date: Thu, 12 Mar 2026 20:39:35 -0500
Message-ID: <20260313013938.2742124-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0.381.g628a66ccf6
In-Reply-To: <20260312192228.481134-1-jltobler@gmail.com>
References: <20260312192228.481134-1-jltobler@gmail.com>
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

Changes since V5:
- Fixed a test that was incorrectly referencing the openpgp-signing
  branch when it should be using the ssh-signing branch.
- Changed warning message wording.
- Added some parentheses in a conditional statement to clarify operation
  order.

Changes since V4:
- Instead of introducing a separate `sign_buffer_with_key()` helper,
  extend `sign_buffer()` to support a SIGN_BUFFER_USE_DEFAULT_KEY flag.
- Fixed message in die().

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
  gpg-interface: allow sign_buffer() to use default signing key
  fast-import: add mode to sign commits with invalid signatures

 Documentation/git-fast-import.adoc |   4 +
 builtin/fast-export.c              |   8 +-
 builtin/fast-import.c              | 101 +++++++++++++++-----
 builtin/tag.c                      |   4 +-
 commit.c                           |  19 +---
 commit.h                           |   2 -
 gpg-interface.c                    |  36 ++++++--
 gpg-interface.h                    |  19 +++-
 send-pack.c                        |   2 +-
 t/t9305-fast-import-signatures.sh  | 144 ++++++++++++++++++-----------
 10 files changed, 231 insertions(+), 108 deletions(-)

Range-diff against v5:
1:  0d00b72ee0 = 1:  0d00b72ee0 commit: remove unused forward declaration
2:  7a0deed77b ! 2:  5224c1766f gpg-interface: allow sign_buffer() to use default signing key
    @@ gpg-interface.c: const char *gpg_trust_level_to_str(enum signature_trust_level l
      	gpg_interface_lazy_init();
      
     -	return use_format->sign_buffer(buffer, signature, signing_key);
    -+	if (flags & SIGN_BUFFER_USE_DEFAULT_KEY && (!signing_key || !*signing_key))
    ++	if ((flags & SIGN_BUFFER_USE_DEFAULT_KEY) && (!signing_key || !*signing_key))
     +		signing_key = keyid_to_free = get_signing_key();
     +
     +	ret = use_format->sign_buffer(buffer, signature, signing_key);
3:  e659971e84 ! 3:  d9ad73e05b fast-import: add mode to sign commits with invalid signatures
    @@ builtin/fast-import.c: static void handle_strip_if_invalid(struct strbuf *new_da
     +		break;
     +	case SIGN_SIGN_IF_INVALID:
     +		if (subject_len > 100)
    -+			warning(_("signing commit with invalid signature for '%.100s...'\n"
    ++			warning(_("replacing invalid signature for commit '%.100s...'\n"
     +				  "  allegedly by %s"), subject, signer);
     +		else if (subject_len > 0)
    -+			warning(_("signing commit with invalid signature for '%.*s'\n"
    ++			warning(_("replacing invalid signature for commit '%.*s'\n"
     +				  "  allegedly by %s"), subject_len, subject, signer);
     +		else
    -+			warning(_("signing commit with invalid signature\n"
    ++			warning(_("replacing invalid signature for commit\n"
     +				  "  allegedly by %s"), signer);
     +		break;
     +	default:
    @@ t/t9305-fast-import-signatures.sh: test_expect_success GPG 'strip both OpenPGP s
     +			test_grep "stripping invalid signature" log &&
     +			test_grep ! -E "^gpgsig" actual
     +		else
    -+			test_grep "signing commit with invalid signature" log &&
    ++			test_grep "replacing invalid signature" log &&
     +			test_grep -E "^gpgsig(-sha256)? " actual &&
     +			git -C new verify-commit "$IMPORTED"
     +		fi
    @@ t/t9305-fast-import-signatures.sh: test_expect_success GPG 'strip both OpenPGP s
      	rm -rf new &&
      	git init new &&
      
    -@@ t/t9305-fast-import-signatures.sh: test_expect_success GPG 'strip signature invalidated by message change with --si
    - 	# corresponding `data <length>` command would have to be changed too.
    - 	sed "s/OpenPGP signed commit/OpenPGP forged commit/" output >modified &&
    +-	git fast-export --signed-commits=verbatim openpgp-signing >output &&
    ++	git fast-export --signed-commits=verbatim ssh-signing >output &&
      
    + 	# Change the commit message, which invalidates the signature.
    + 	# The commit message length should not change though, otherwise the
    + 	# corresponding `data <length>` command would have to be changed too.
    +-	sed "s/OpenPGP signed commit/OpenPGP forged commit/" output >modified &&
    +-
     -	git -C new fast-import --quiet --signed-commits=strip-if-invalid <modified >log 2>&1 &&
    -+	# Configure the target repository with an invalid default signing key.
    -+	test_config -C new user.signingkey "not-a-real-key-id" &&
    -+	test_config -C new gpg.format ssh &&
    -+	test_config -C new gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
    -+	test_must_fail git -C new fast-import --quiet \
    -+		--signed-commits=sign-if-invalid <modified >/dev/null 2>&1 &&
    -+
    -+	# Import using explicitly provided signing key.
    -+	git -C new fast-import --quiet \
    -+		--signed-commits=sign-if-invalid="${GPGSSH_KEY_PRIMARY}" <modified &&
    - 
    - 	IMPORTED=$(git -C new rev-parse --verify refs/heads/openpgp-signing) &&
    - 	test $OPENPGP_SIGNING != $IMPORTED &&
    - 	git -C new cat-file commit "$IMPORTED" >actual &&
    +-
    +-	IMPORTED=$(git -C new rev-parse --verify refs/heads/openpgp-signing) &&
    +-	test $OPENPGP_SIGNING != $IMPORTED &&
    +-	git -C new cat-file commit "$IMPORTED" >actual &&
     -	test_grep ! -E "^gpgsig" actual &&
     -	test_grep "stripping invalid signature" log
     -'
    @@ t/t9305-fast-import-signatures.sh: test_expect_success GPG 'strip signature inva
     -	IMPORTED=$(git -C new rev-parse --verify refs/heads/x509-signing) &&
     -	test $X509_SIGNING = $IMPORTED &&
     -	git -C new cat-file commit "$IMPORTED" >actual &&
    - 	test_grep -E "^gpgsig(-sha256)? " actual &&
    +-	test_grep -E "^gpgsig(-sha256)? " actual &&
     -	test_must_be_empty log
     -'
     -
     -test_expect_success GPGSSH 'keep valid SSH signature with --signed-commits=strip-if-invalid' '
     -	rm -rf new &&
     -	git init new &&
    --
    --	test_config -C new gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
    --
    ++	sed "s/SSH signed commit/SSH forged commit/" output >modified &&
    + 
    ++	# Configure the target repository with an invalid default signing key.
    ++	test_config -C new user.signingkey "not-a-real-key-id" &&
    ++	test_config -C new gpg.format ssh &&
    + 	test_config -C new gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
    ++	test_must_fail git -C new fast-import --quiet \
    ++		--signed-commits=sign-if-invalid <modified >/dev/null 2>&1 &&
    ++
    ++	# Import using explicitly provided signing key.
    ++	git -C new fast-import --quiet \
    ++		--signed-commits=sign-if-invalid="${GPGSSH_KEY_PRIMARY}" <modified &&
    + 
     -	git fast-export --signed-commits=verbatim ssh-signing >output &&
     -	git -C new fast-import --quiet --signed-commits=strip-if-invalid <output >log 2>&1 &&
    --	IMPORTED=$(git -C new rev-parse --verify refs/heads/ssh-signing) &&
    + 	IMPORTED=$(git -C new rev-parse --verify refs/heads/ssh-signing) &&
     -	test $SSH_SIGNING = $IMPORTED &&
    --	git -C new cat-file commit "$IMPORTED" >actual &&
    --	test_grep -E "^gpgsig(-sha256)? " actual &&
    ++	test $SSH_SIGNING != $IMPORTED &&
    + 	git -C new cat-file commit "$IMPORTED" >actual &&
    + 	test_grep -E "^gpgsig(-sha256)? " actual &&
     -	test_must_be_empty log
     +	git -C new verify-commit "$IMPORTED"
      '

base-commit: 7c02d39fc2ed2702223c7674f73150d9a7e61ba4
-- 
2.53.0.381.g628a66ccf6

