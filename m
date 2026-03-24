Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA36B3AE18A
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 21:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774389335; cv=none; b=UkqIOdlbzYRry8pGMUovvBkxLq+4qkQlUBDeNhu55ncUHU5btGfAN1fo3L4ABrBTVncQz/kb1xhi3Q/n+lGVtZI/7ZWe+kafQ5k32URNPeu7x6x6MPZtFDq6GcX8SAB7rgmj3T0IJXeG/eSOMQuh1T4pc9EjfrxsFenMFnF0/yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774389335; c=relaxed/simple;
	bh=tbugs6sa3AjS47MIfGEx5VPEivdEYeESNdXmz6bgfVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UMtqQGJ70zNQO5HxHFxYGEc3fSpeO6Fi6cgzZuRWhA28MEQJg+IRyCGQhdU7HOhMW9Re4Vgn7AZDnYOLK1Pneyy1nDVT5lfLp4ian/ejwiPMRoarFUZlVEmja0TvXB3/unhOXtVbUwZTiAE5FBDUWbBs950k/xSASFG+zQU/aLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLrRsnce; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLrRsnce"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-41708f6c3feso1018492fac.3
        for <git@vger.kernel.org>; Tue, 24 Mar 2026 14:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774389332; x=1774994132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3HBtqWB2zmFg7q2d5AAzjaYR5GjVYUIWDTnh+Fo5Y+4=;
        b=nLrRsncerSyC9bMnFylN0CwzfHPj1Lae4qFDs5gkHxXWZ+SYR9abNNeq7EghNneV08
         g3Xp0wRz3UxTqTNH5jJ4eNGy3gR2oMqyBzpCXl79tW2ReRNARSlH726xo/tIAju2uy41
         R+joGkfRDSWUZAORHOdD8Tbu7xWlT+AwdD7fu5BD5S1yrUtX8u4u2poaNIwoVpqHYBXs
         6RJsEcgRD2JC39qZG2gPceMe5U8zrfznPuEBe3mcb4OszVBnExShOsxJj5zHncwH/yz9
         T086agxxM5E3GrSDBbFmUIA0E4rHox5lEpy9EAIUElEQLD9GLI41Wcd+TVb/W/vRrFUE
         /BMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774389332; x=1774994132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3HBtqWB2zmFg7q2d5AAzjaYR5GjVYUIWDTnh+Fo5Y+4=;
        b=fJzTdL0ATV1f9IcLZJSptvKpsZRl1RKYImLgtCGinKdQo9pbNoMlFX3BnYS1330/JD
         sO7HfZYmyBmJv+I/lmhkS27Ax65W/2ohNHiy3KtKEEo8cyNrTAStBe/H8qOan0qhHLIA
         +l2tJBFhb9ilKe6ygyIIMM5DJLUh2cc9Dkj1XLQN4Z4CIPJDXY/dm46Lwr90A/SeCgTZ
         zVs6aTBLVLGritJo+pP0s5U/2niYVYjsrPOpB3CvOwg0ebteMV78yNPtCBeyNnke3bVY
         iQ/ECnux0qmRwT5KLTaPQMWwtA1xVEOkToMs8bpK8pYRYtR6qhj42Fv53bLaygW+xQHg
         bpkQ==
X-Gm-Message-State: AOJu0YydZOuqfCrzjact7rwBiYWprLHQv2eMrUBkSNDW0XcsA8/S9TP4
	d2o+K7GwzNEWsn2e7q5T9/Aw2AwNXJIB9qzjpzFaM5tAAEJL9rp16dBlPkdSoA==
X-Gm-Gg: ATEYQzxX4AwCd2wDfxBlXlDXmUhOAd3Jpg1a5Zm+EudXjepWQZ0zkoKcV0dRMdEEMdi
	JShQG5lK19f/L+MgH+I3bT2dG9VbPL2X+ooSyZQdWFmafjLhZZw+OSQHST3UmtCz/2A/NIuQH8f
	zt5HDj3b7HAonLBsgu6ro3DgDFbtaokZxOzyS2dEJ+USjvEcbEKAQDmXkUuCqK9O/jhCD1nlpBJ
	U7Oga4VR+gljt90hzzpNAd6Yf8MTeycT4t3i/y21/8AwDl4o6KChI34sCOTTYu24FMzhIVVXVMc
	TU5OHKAeOtoYti4zI/GGsr85RdVyw6uQfX8iICVniTVWjOSXNHnZdMLqGpL9shLLn8h7wybw5Dz
	gNzMdh/8hyhrlVbm+qVLIQkcJgY6E30/ldsa4j657IW71pQKvT3HIvPdJ2hDxJ0clppgiUcVtoq
	5ldxAnoI59m4RDGtqR3WoKJtpoPlhmFZQ=
X-Received: by 2002:a05:6870:a713:b0:3e8:915b:41fb with SMTP id 586e51a60fabf-41ca70b29e5mr783972fac.41.1774389332397;
        Tue, 24 Mar 2026 14:55:32 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41c149103b0sm12391697fac.5.2026.03.24.14.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 14:55:32 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 3/4] fast-import: add 'sign-if-invalid' mode to '--signed-tags=<mode>'
Date: Tue, 24 Mar 2026 16:55:12 -0500
Message-ID: <20260324215513.764739-4-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0.381.g628a66ccf6
In-Reply-To: <20260324215513.764739-1-jltobler@gmail.com>
References: <20260324215513.764739-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With ee66c793f8 (fast-import: add mode to sign commits with invalid
signatures, 2026-03-12), git-fast-import(1) learned to verify commit
signatures during import and replace signatures that fail verification
with a newly generated one. Extend the same behavior to signed tag
objects by introducing a 'sign-if-invalid' mode for the '--signed-tags'
option.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/fast-import.c              | 20 ++++++++++++---
 t/t9306-fast-import-signed-tags.sh | 41 ++++++++++++++++++++++++++++--
 2 files changed, 55 insertions(+), 6 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 5e89829aea..783e0e7ab4 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -191,6 +191,7 @@ static const char *global_prefix;
 static enum sign_mode signed_tag_mode = SIGN_VERBATIM;
 static enum sign_mode signed_commit_mode = SIGN_VERBATIM;
 static const char *signed_commit_keyid;
+static const char *signed_tag_keyid;
 
 /* Memory pools */
 static struct mem_pool fi_mem_pool = {
@@ -3110,6 +3111,19 @@ static void handle_tag_signature_if_invalid(struct strbuf *buf,
 
 	strbuf_setlen(msg, sig_offset);
 
+	if (signed_tag_mode == SIGN_SIGN_IF_INVALID) {
+		strbuf_attach(&payload, sigc.payload, sigc.payload_len,
+			      sigc.payload_len + 1);
+		sigc.payload = NULL;
+		strbuf_reset(&signature);
+
+		if (sign_buffer(&payload, &signature, signed_tag_keyid,
+				SIGN_BUFFER_USE_DEFAULT_KEY))
+			die(_("failed to sign tag object"));
+
+		strbuf_addbuf(msg, &signature);
+	}
+
 out:
 	signature_check_clear(&sigc);
 	strbuf_release(&signature);
@@ -3142,6 +3156,7 @@ static void handle_tag_signature(struct strbuf *buf, struct strbuf *msg, const c
 		/* Truncate the buffer to remove the signature */
 		strbuf_setlen(msg, sig_offset);
 		break;
+	case SIGN_SIGN_IF_INVALID:
 	case SIGN_STRIP_IF_INVALID:
 		handle_tag_signature_if_invalid(buf, msg, sig_offset);
 		break;
@@ -3153,9 +3168,6 @@ static void handle_tag_signature(struct strbuf *buf, struct strbuf *msg, const c
 	case SIGN_ABORT_IF_INVALID:
 		die(_("'abort-if-invalid' is not a valid mode for "
 		      "git fast-import with --signed-tags=<mode>"));
-	case SIGN_SIGN_IF_INVALID:
-		die(_("'sign-if-invalid' is not a valid mode for "
-		      "git fast-import with --signed-tags=<mode>"));
 	default:
 		BUG("invalid signed_tag_mode value %d from tag '%s'",
 		    signed_tag_mode, name);
@@ -3749,7 +3761,7 @@ static int parse_one_option(const char *option)
 		if (parse_sign_mode(option, &signed_commit_mode, &signed_commit_keyid))
 			usagef(_("unknown --signed-commits mode '%s'"), option);
 	} else if (skip_prefix(option, "signed-tags=", &option)) {
-		if (parse_sign_mode(option, &signed_tag_mode, NULL))
+		if (parse_sign_mode(option, &signed_tag_mode, &signed_tag_keyid))
 			usagef(_("unknown --signed-tags mode '%s'"), option);
 	} else if (!strcmp(option, "quiet")) {
 		show_stats = 0;
diff --git a/t/t9306-fast-import-signed-tags.sh b/t/t9306-fast-import-signed-tags.sh
index fd43b0b52a..bb4c8008ef 100755
--- a/t/t9306-fast-import-signed-tags.sh
+++ b/t/t9306-fast-import-signed-tags.sh
@@ -77,7 +77,7 @@ test_expect_success GPGSSH 'import SSH signed tag with --signed-tags=strip' '
 	test_grep ! "SSH SIGNATURE" out
 '
 
-for mode in strip-if-invalid
+for mode in strip-if-invalid sign-if-invalid
 do
 	test_expect_success GPG "import tag with no signature with --signed-tags=$mode" '
 		test_when_finished rm -rf import &&
@@ -117,7 +117,15 @@ do
 		IMPORTED=$(git -C import rev-parse --verify refs/tags/openpgp-signed) &&
 		test $OPENPGP_SIGNED != $IMPORTED &&
 		git -C import cat-file tag "$IMPORTED" >actual &&
-		test_grep ! -E "^-----BEGIN PGP SIGNATURE-----" actual &&
+
+		if test "$mode" = strip-if-invalid
+		then
+			test_grep ! -E "^-----BEGIN PGP SIGNATURE-----" actual
+		else
+			test_grep -E "^-----BEGIN PGP SIGNATURE-----" actual &&
+			git -C import verify-tag "$IMPORTED"
+		fi &&
+
 		test_must_be_empty log
 	'
 
@@ -150,4 +158,33 @@ do
 	'
 done
 
+test_expect_success GPGSSH 'sign invalid tag with explicit keyid' '
+	test_when_finished rm -rf import &&
+	git init import &&
+
+	git fast-export --signed-tags=verbatim ssh-signed >output &&
+
+	# Change the tag message, which invalidates the signature. The tag
+	# message length should not change though, otherwise the corresponding
+	# `data <length>` command would have to be changed too.
+	sed "s/SSH signed tag/SSH forged tag/" output >modified &&
+
+	# Configure the target repository with an invalid default signing key.
+	test_config -C import user.signingkey "not-a-real-key-id" &&
+	test_config -C import gpg.format ssh &&
+	test_config -C import gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	test_must_fail git -C import fast-import --quiet \
+		--signed-tags=sign-if-invalid <modified >/dev/null 2>&1 &&
+
+	# Import using explicitly provided signing key.
+	git -C import fast-import --quiet \
+		--signed-tags=sign-if-invalid="${GPGSSH_KEY_PRIMARY}" <modified &&
+
+	IMPORTED=$(git -C import rev-parse --verify refs/tags/ssh-signed) &&
+	test $SSH_SIGNED != $IMPORTED &&
+	git -C import cat-file tag "$IMPORTED" >actual &&
+	test_grep -E "^-----BEGIN SSH SIGNATURE-----" actual &&
+	git -C import verify-tag "$IMPORTED"
+'
+
 test_done
-- 
2.53.0.381.g628a66ccf6

