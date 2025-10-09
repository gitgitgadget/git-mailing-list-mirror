Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8452E22AA
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 12:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760012721; cv=none; b=GaKIaeFUhgTRyrnBC07gHV2eSryas048L634hcChEZ35VgNqfCIqh0hw+nh1ZkRuYZONRtjaAw7Dw+lWGIIYjwEDNdodFBWE5539RuvJSHFmuEul3RYqTs+Jh+0d+VBCykkRlgEpjANC36DHZVnogcZkIgoIs0lXhkx58pxdm/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760012721; c=relaxed/simple;
	bh=n2Nw/QaI752DFSmIcDC96UIt2Ttvsxdo5sanCeHD/no=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WzlOX3k+hzV+W2k+CJtp75VRNCQnO9EEf5COLVAD9GoIEHr9gcTt3oT1cV7AkoaBu3di+yaat1okLIiqaeAM/XSRtdgahnx4CVz9GPUScGfdQTqmtSjhVROcBOflTdi3Ktl80eqHKXiHhvTu0oGFDiy96eepcGOHkkuo05bkxek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZhs7Mk2; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZhs7Mk2"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4060b4b1200so975119f8f.3
        for <git@vger.kernel.org>; Thu, 09 Oct 2025 05:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760012717; x=1760617517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Dfh+usPmbdzLjuB/iInn5Euoj9wrZnVaX/71DemamA=;
        b=QZhs7Mk2vFbcwyZJa459QZUgX3pKDNXcD1NctgrSj272fr9i2b3509lUO2OuQsx85e
         xAIrw9NlcPqRv30MZVBNNyHgrNGhrygT8UJ0cNKS+ngiJYO12aiQ7fqH7zO/h3L+nq05
         CafZg/yUSkNao7PgUI64ji6nBm0V80NrZlJkEAjlHiSWOjU1n3wlmLBwC9R/fk0Blhwf
         EvptqpGgd5xiyiAYcW4U0in8eAqhratar3mDiVwAmLb31Py/E2+j4Buv0zPcPa4gVBMa
         wGFY9ub8hoYhZkivAuJzoiR3rM5bKgKRP4eh6nn18md9BzxtG5Hsr0NEXffeLrHNoqAw
         ptRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760012717; x=1760617517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Dfh+usPmbdzLjuB/iInn5Euoj9wrZnVaX/71DemamA=;
        b=nkE2FotK8yZ4dOQocFX0AjhibJEyN6QJbcjuGOxz1AnqSXZ7MtxhqaF9H59I8VSC1U
         NWmTEgCA+qKjYEVQvfneE8pQxJWY5sp/0CTsuwClw88NmMlz29YrEJnmwGWIXPeLc6mf
         v2F+Rh3Qlr1A3jpFBXmA6i3+3wY7IIMIPxMcmQIvscjZuh22hhthSIEAZ/rgLde+LxwY
         /aShihMPyxmH26VQJCN29Zy31A0+UdaTmhaN7CIdD2r4Tgr1WtE/Kbur7zkbOVouM5jl
         IEuP1Xrk+wJUeD42T1WyhElYlZX15e/rWI/XqHugZ2ZsUjduPZNFTVc3tE7y9Zwy7hxa
         Koqw==
X-Gm-Message-State: AOJu0YwMs5XRxySI0mKu/rzyhJe/22HleMO8nnXQYJ5NWS8KHWISgO/q
	wxhWhnvzarb8pgz/G11Nvnhtug+EBlN2PR5FAwrFnH9ihpHahKa6ZJFcx85LJGt3
X-Gm-Gg: ASbGncup9T9mvsYQQcdrxcP7pj6WoMyWiL2vtzzN2ElLYQxrGfebM+vm9vagaul+L2D
	s6lRv9P88/BJhrErE8Sg6p/SRINH4jIUfMR3zvb2oT7PL+fSwPwIGXlJGUHQTfN2czrMeNO144A
	gSba5JMjp65EwamLiaMUNmQUfsbGp2MCqzWnfkkM1YPjlaQxgltANAVjrwofDh1oShw8zRswPqx
	lFo6epjo63ifwZLQLwEhS82PUQ77agtH31TttcjCdU3/Xz2lwLVIe2TJ0XZTJJG2iafuJ/Pw8zN
	F1Z+ka0xfLuSVLxBCsxQa0ULYG3WOFL3+Rfa3WV+QJsq0pglhZLMp6FdizzxYSU3eaddvEl33du
	GhBw+cIO2Y7NHaxCLPwA5Bz9YovxlKsmPb9nb5tp8KnMUPX8vfEBQDI8yQ9PMPoEW5G7usjbt6m
	ohn/T2mGP+
X-Google-Smtp-Source: AGHT+IHJU3SMEMQZgJevB8ANGO2cG680y2dWpeEYFYmJ2FoRJWVsHaz48szxoTjwM+RiUfRPoU0byg==
X-Received: by 2002:a5d:5c8a:0:b0:3e9:d54:19a0 with SMTP id ffacd0b85a97d-4267b3396eemr4544735f8f.57.1760012716814;
        Thu, 09 Oct 2025 05:25:16 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9c07cbasm84831475e9.7.2025.10.09.05.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 05:25:16 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Todd Zullinger <tmz@pobox.com>,
	Collin Funk <collin.funk1@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 4/5] fast-export: handle all kinds of tag signatures
Date: Thu,  9 Oct 2025 14:24:56 +0200
Message-ID: <20251009122457.1273701-5-christian.couder@gmail.com>
X-Mailer: git-send-email 2.51.0.438.g6987fc0bae
In-Reply-To: <20251009122457.1273701-1-christian.couder@gmail.com>
References: <20251007122958.1089680-1-christian.couder@gmail.com>
 <20251009122457.1273701-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the handle_tag() function in "builtin/fast-export.c" searches
only for "\n-----BEGIN PGP SIGNATURE-----\n" in the tag message to find
a tag signature.

This doesn't handle all kinds of OpenPGP signatures as some can start
with "-----BEGIN PGP MESSAGE-----" too, and this doesn't handle SSH and
X.509 signatures either as they use "-----BEGIN SSH SIGNATURE-----" and
"-----BEGIN SIGNED MESSAGE-----" respectively.

To handle all these kinds of tag signatures supported by Git, let's use
the parse_signed_buffer() function to properly find signatures in tag
messages.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/fast-export.c  |  7 +++----
 t/t9350-fast-export.sh | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index dc2486f9a8..7adbc55f0d 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -931,9 +931,8 @@ static void handle_tag(const char *name, struct tag *tag)
 
 	/* handle signed tags */
 	if (message) {
-		const char *signature = strstr(message,
-					       "\n-----BEGIN PGP SIGNATURE-----\n");
-		if (signature)
+		size_t sig_offset = parse_signed_buffer(message, message_size);
+		if (sig_offset < message_size)
 			switch (signed_tag_mode) {
 			case SIGN_ABORT:
 				die("encountered signed tag %s; use "
@@ -950,7 +949,7 @@ static void handle_tag(const char *name, struct tag *tag)
 					oid_to_hex(&tag->object.oid));
 				/* fallthru */
 			case SIGN_STRIP:
-				message_size = signature + 1 - message;
+				message_size = sig_offset;
 				break;
 			}
 	}
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 21ff26939c..3d153a4805 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -279,6 +279,42 @@ test_expect_success 'signed-tags=warn-strip' '
 	test -s err
 '
 
+test_expect_success GPGSM 'setup X.509 signed tag' '
+	test_config gpg.format x509 &&
+	test_config user.signingkey $GIT_COMMITTER_EMAIL &&
+
+	git tag -s -m "X.509 signed tag" x509-signed $(git rev-parse HEAD) &&
+	ANNOTATED_TAG_COUNT=$((ANNOTATED_TAG_COUNT + 1))
+'
+
+test_expect_success GPGSM 'signed-tags=verbatim with X.509' '
+	git fast-export --signed-tags=verbatim x509-signed > output &&
+	test_grep "SIGNED MESSAGE" output
+'
+
+test_expect_success GPGSM 'signed-tags=strip with X.509' '
+	git fast-export --signed-tags=strip x509-signed > output &&
+	test_grep ! "SIGNED MESSAGE" output
+'
+
+test_expect_success GPGSSH 'setup SSH signed tag' '
+	test_config gpg.format ssh &&
+	test_config user.signingkey "${GPGSSH_KEY_PRIMARY}" &&
+
+	git tag -s -m "SSH signed tag" ssh-signed $(git rev-parse HEAD) &&
+	ANNOTATED_TAG_COUNT=$((ANNOTATED_TAG_COUNT + 1))
+'
+
+test_expect_success GPGSSH 'signed-tags=verbatim with SSH' '
+	git fast-export --signed-tags=verbatim ssh-signed > output &&
+	test_grep "SSH SIGNATURE" output
+'
+
+test_expect_success GPGSSH 'signed-tags=strip with SSH' '
+	git fast-export --signed-tags=strip ssh-signed > output &&
+	test_grep ! "SSH SIGNATURE" output
+'
+
 test_expect_success GPG 'set up signed commit' '
 
 	# Generate a commit with both "gpgsig" and "encoding" set, so
-- 
2.51.0.438.g6987fc0bae

