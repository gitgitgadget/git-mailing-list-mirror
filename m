Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE8F3A5445
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 19:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774552467; cv=none; b=eMHuZa2/SFPC2JIxCiLDJUc42hXiYafZFbsq3WWXViRY5raCzf3xZ1A4wA87ErLjQPlp3acyuTs/TRolPX7LtkGfj73wvKoUCMuUK6acw78VMO8bS6nXqAlEnJteFbg8jw6bDyRZdKElsu2wBO02T3d/fv8d0NzcE5HzxPpkAEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774552467; c=relaxed/simple;
	bh=tbugs6sa3AjS47MIfGEx5VPEivdEYeESNdXmz6bgfVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H7xKX32ABomKkSExtXVQt6bIAk3dZo91hewNuVQJL+lKMs7UTfXYZdyCIqFQ6mwd+g7aeGh1pmShw9I47k+pg29eD0JQwzrT6AzQPJBBtRAtajx127y7wcHs/CIxWdj92K2yeqnO0fzFCqi3kXUM1xLtoiJe304Y+3nYhUkSA/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FlGc8e5P; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlGc8e5P"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d4c383f2fcso1223654a34.0
        for <git@vger.kernel.org>; Thu, 26 Mar 2026 12:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774552464; x=1775157264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3HBtqWB2zmFg7q2d5AAzjaYR5GjVYUIWDTnh+Fo5Y+4=;
        b=FlGc8e5PddZmxRslduKAYiqglyAEFaeLRCDjNNeuwL2DQjONFL/4F+bDI6ScrTaDBW
         RUtDJztVWLg1ePjOgIrKLHVkDg3XiRX1txWXoD/h/GxmvSYlHVRbok7TsmBJR8JogRbd
         MUrLWTTvSlIsLLCcy9CYzJIjyxb2he39jEzqCEmaQydnb0HVGhykvRfPM3xw4RfmAFKR
         3rlhnUwY254t08a08YpvUhcPifgQWYInUv6/MQWi+sUpl6rnyl7M5DxC4ez8fFohZOBm
         Q2oENYuH0tOgKto32ig+9XHhr+afMag+REx1BtGg+J4DuK8vfSm+NSOB+AmDSPv0wONd
         q4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774552464; x=1775157264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3HBtqWB2zmFg7q2d5AAzjaYR5GjVYUIWDTnh+Fo5Y+4=;
        b=mTtNTNeQThkWH0Dplt+dkQckosTb55NbjI6odZtS5C18x79Trp1cNjmO5Vci3oEPm6
         ACnpULESskbHEpoOyfh6wCUYlADw1OZ9Z5mC1FtiB18uVV+tcgLc2FwlQPrk1Un63ZIG
         ttiq6NFBYT/LrIlS2+DhKf7FhXP9Him87tHsJzldRbBzrrubOtOcIUt/ZlxvcMA2q+6M
         +qJAvZB3DBW+K0mPoJIxxklqKplAI8cRZim2cA9yzRrNy4bAfvc2I4WE0HEEy92hZfoM
         Ak9WwuTezSoBo///gJ/xhvTcGOB7XiY503hJprW5qTUosfG4COdHd61xhRTef7uuU8DK
         OhMA==
X-Gm-Message-State: AOJu0Yw2wWZ0qVv0+hyxGhIv78qxZ6blkSecdnT9VTw9Ks7upxSyIGgb
	KDqT6tyy4H9R2I0abn2qa2dAxKXaeytaBi6LFDHS1Qyi7qZy6DtbQwEZJZEjsQ==
X-Gm-Gg: ATEYQzxGcLFew0svDMvk/m9CoOCgOfLBOHbioKEd+oeouMOXU7HbvFLCpAHHze4Z2r0
	r09454+DeDppfj4lUP6W9FOJKnAKd7+oSIaBxGZWy6TftNbRf+8+ESZ2fCHR4C7kw8URUYZeuDV
	hU5UCe7QL7r8/G7HKEIv3ljEB7DQpjRMDYwL9fcX11j4mR6S0cc6e+xRh4NkGONrstjQKAefD3B
	E2f7TTQbd+0seitrVI6/7tG8KQQkW9ACwAzOcF1UDvwSbAlbs7ot5daC3JOiEdjsHnOTes58Wiq
	Rh7pGyYPYMg95zcLQYec8tHTXWeAr+7/crGGhpQu6l/Ts5PB0zj07fyF1Zo85ola0gfnaXzdJMQ
	rGI8Er8hn0bGAcstpMNEUVA25+E9V0R/iHJgC/dRpE/62AbhaQ5NSl+5A072vdz+Ia+J+o/jO+2
	hZsHYGbXEVxdmgw3hn/wQd3RFZvt+8XccmZLone8/Bfg==
X-Received: by 2002:a05:6830:2a8d:b0:7d7:455d:1003 with SMTP id 46e09a7af769-7d9d651a1f5mr4719576a34.4.1774552464017;
        Thu, 26 Mar 2026 12:14:24 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d9e71f5ab2sm2946689a34.18.2026.03.26.12.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 12:14:23 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 4/5] fast-import: add 'sign-if-invalid' mode to '--signed-tags=<mode>'
Date: Thu, 26 Mar 2026 14:14:13 -0500
Message-ID: <20260326191414.3783974-5-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0.381.g628a66ccf6
In-Reply-To: <20260326191414.3783974-1-jltobler@gmail.com>
References: <20260326191414.3783974-1-jltobler@gmail.com>
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

