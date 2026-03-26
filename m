Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604743976BB
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 19:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774552469; cv=none; b=CBRUVqIqqe9U/MJBBarycjlowlKu3Y+YNFuAgkglujyD7+VbH/Rkdd4OAn48WUGxer2jm8DoBpOxupLrh3a9fxINKqve/YuTmBNpxLJj4Z5LT5RqjFr0KIc0d/dmh0BWKoC0gZQnx70vo5Q9hlhQA9tSKH1pyEZo7ux05DJyIJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774552469; c=relaxed/simple;
	bh=k3GNZCP03lCA/aU+5eN0BMp2XgkXv3shORoRXtbAXdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pYOER+VB4j61DBRucwuT+m1uTemdj0cAEVadu+83b1KErV9sBOwYKS9M0E++/v52CPmDzDTFKvi7qxzlf4ma0saqIre99jMT7lbb37p/Dx7ZsHysmKOG6JzkW5KBt6QksS5UH7s3Lb8VIm9541WtBhzHQ1Bv4sZzIU/DITE43qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lI6NIoW6; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lI6NIoW6"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7d86eb7c854so727535a34.3
        for <git@vger.kernel.org>; Thu, 26 Mar 2026 12:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774552465; x=1775157265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iB7qEirQI68/xV7sM+xUMpBcaJxtFIUVbjqO6rW/1Oo=;
        b=lI6NIoW6Qs3UQyX9sutdwm/5GTiCehv0SuVjXCXvM+siWsO4z0DyEXzkcG/wZXGLCp
         zZScIAW4URPc4/TXPlkpqUT7B2Faz1UxKOsIXHlPzpCG/y1aOqnDc+15J3k91Qe6HMjd
         fkqyOOatPPsITsHGrV4WL9673vtuvb/BFhIMTS2MqgNLYE9H7RqSY8QleRwu5eniTOe0
         PzrH2w7G5EdfXUjjHE0TPBQHsnFyVCoNpWiIByXLfqVnSssTRSf9AK/GG5+X/3GjbYT6
         cvyLvXFHfkBAFIgteND2zjkbg/jqljXlJTWOHATJcOi3cxDlbTw8JI4cR8bSM348aZRS
         upvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774552465; x=1775157265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iB7qEirQI68/xV7sM+xUMpBcaJxtFIUVbjqO6rW/1Oo=;
        b=qvPGVFP6dqtP5UF2GE9Y66/5l7vEkpfk5tIVIBPbWJJnFT+dZErGUY5pd8oA6UP12o
         MVRqAyNQ/9ODsaNTyJ/keXe8mPbgXTWMOE2Nd5fm43LNRbtsyR5FRO5Z0kTItTzreHuE
         ApzLndYxTkpyIyKrEe4S3cnvVTJyDQsEEhx2gpDAIK/CNLEL9N+9uDUVz69K0KB/dI8c
         vuvRV1dACoGmIA7HqzpgkYsFG/oXQ/PXUoZr59JJAvdBk+GMGde5Rzr1HXg5uEFXwakI
         9LXq16FEzGZYh/FcR4iFTyJBi+0pZt/7UzKfU3e7yBjwV6IbpeOX9cbTr8pGv4NKUnvQ
         BcYw==
X-Gm-Message-State: AOJu0YxuznP1npNeLq4wAQ70pDwtX2pbPSvzGQ4V593KaTFoFyCZAR/d
	RkDqLILyvM+2TTm/i98YP4FwvbXKAJJkztRh6EHl7yD7ww1CvydI35GplP8M6g==
X-Gm-Gg: ATEYQzyHLxulv9MTRZSQR1ZJ5BF2LLiI7Jkmiuvz8nrmi4fRd0N1HMv9hV7+DaN0OjA
	aBxbZCfgAA8veOrt/YAcyoyd8H0WLI8H5878UxYqtncowGIVkwvtA7j/FTfM4wurnmUWnXdKoqg
	ZSgyD9DUjKSdaD9ML8L7eS3KVR6gzETqJdCeFK6rmpYy93qs3ypVTJQddatovw4EHMfkgOO/uiS
	zArOsbKNGhNznS1c/sXwDycX5Xtl62va/girb0VmAq2wrsmgHMhA2JbeVtKI9OFf2mhI0/ikeVS
	z8Xodpzh95+FcPubYg9TvVKU9qyZCXSaGe4W4p3rc7axkyPKq1ecSp2h6ruouaA1bAyh67d+GLt
	aqmz9ziOyoSZQGuyrxPXgp8zjgxtETGdEf+7mVxpdUf56dnSUDsG2C+rqqzxKrCxcb60ISEr+jL
	TCXuIk47L9OaSykvJlzb1JSZKHu/uEk7Aq7JfuuvdHDA==
X-Received: by 2002:a05:6830:6d25:b0:7d7:d097:96dc with SMTP id 46e09a7af769-7d9d64f3221mr4248883a34.5.1774552465146;
        Thu, 26 Mar 2026 12:14:25 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d9e71f5ab2sm2946689a34.18.2026.03.26.12.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 12:14:24 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 5/5] fast-import: add 'abort-if-invalid' mode to '--signed-tags=<mode>'
Date: Thu, 26 Mar 2026 14:14:14 -0500
Message-ID: <20260326191414.3783974-6-jltobler@gmail.com>
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

In git-fast-import(1), the 'abort-if-invalid' mode for the
'--signed-commits' option verifies commit signatures during import and
aborts the entire operation when verification fails. Extend the same
behavior to signed tag objects by introducing an 'abort-if-invalid' mode
for the '--signed-tags' option.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/fast-import.c              |  7 ++++---
 t/t9306-fast-import-signed-tags.sh | 10 +++++++++-
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 783e0e7ab4..cd1181023d 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -3109,6 +3109,9 @@ static void handle_tag_signature_if_invalid(struct strbuf *buf,
 	if (!check_signature(&sigc, signature.buf, signature.len))
 		goto out;
 
+	if (signed_tag_mode == SIGN_ABORT_IF_INVALID)
+		die(_("aborting due to invalid signature"));
+
 	strbuf_setlen(msg, sig_offset);
 
 	if (signed_tag_mode == SIGN_SIGN_IF_INVALID) {
@@ -3156,6 +3159,7 @@ static void handle_tag_signature(struct strbuf *buf, struct strbuf *msg, const c
 		/* Truncate the buffer to remove the signature */
 		strbuf_setlen(msg, sig_offset);
 		break;
+	case SIGN_ABORT_IF_INVALID:
 	case SIGN_SIGN_IF_INVALID:
 	case SIGN_STRIP_IF_INVALID:
 		handle_tag_signature_if_invalid(buf, msg, sig_offset);
@@ -3165,9 +3169,6 @@ static void handle_tag_signature(struct strbuf *buf, struct strbuf *msg, const c
 	case SIGN_ABORT:
 		die(_("encountered signed tag; use "
 		      "--signed-tags=<mode> to handle it"));
-	case SIGN_ABORT_IF_INVALID:
-		die(_("'abort-if-invalid' is not a valid mode for "
-		      "git fast-import with --signed-tags=<mode>"));
 	default:
 		BUG("invalid signed_tag_mode value %d from tag '%s'",
 		    signed_tag_mode, name);
diff --git a/t/t9306-fast-import-signed-tags.sh b/t/t9306-fast-import-signed-tags.sh
index bb4c8008ef..ec2b241cdb 100755
--- a/t/t9306-fast-import-signed-tags.sh
+++ b/t/t9306-fast-import-signed-tags.sh
@@ -77,7 +77,7 @@ test_expect_success GPGSSH 'import SSH signed tag with --signed-tags=strip' '
 	test_grep ! "SSH SIGNATURE" out
 '
 
-for mode in strip-if-invalid sign-if-invalid
+for mode in strip-if-invalid sign-if-invalid abort-if-invalid
 do
 	test_expect_success GPG "import tag with no signature with --signed-tags=$mode" '
 		test_when_finished rm -rf import &&
@@ -112,6 +112,14 @@ do
 		# `data <length>` command would have to be changed too.
 		sed "s/OpenPGP signed tag/OpenPGP forged tag/" output >modified &&
 
+		if test "$mode" = abort-if-invalid
+		then
+			test_must_fail git -C import fast-import --quiet \
+				--signed-tags=$mode <modified >log 2>&1 &&
+			test_grep "aborting due to invalid signature" log &&
+			return 0
+		fi &&
+
 		git -C import fast-import --quiet --signed-tags=$mode <modified >log 2>&1 &&
 
 		IMPORTED=$(git -C import rev-parse --verify refs/tags/openpgp-signed) &&
-- 
2.53.0.381.g628a66ccf6

