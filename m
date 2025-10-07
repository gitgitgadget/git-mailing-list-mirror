Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E392DECA3
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 12:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759840248; cv=none; b=MNReR/jWDpv9rC1m/lx4M8ZXicRTFbHtov/czPbWU1i9EXssNFoOkMtGk3y3FB/5mvnxR7LjDp5dJ2RLMDSxt5IyhzNYflZeGNj20xvs4o1EwFNdKBMA+IVZQBSig994gwH+zsgNosVujFNAibe3SrSAqHQKgvrUQr4x5EN7W+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759840248; c=relaxed/simple;
	bh=WcsiyAIC8+Y4Tn9WjVaE4q5LWlLf9ItbAMPhL0QoPOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k3PV/5qal7M0rFwNExUdjwRnfZE4ZLfsFwziq8o8/f0ZITew9d27q3dCRiMCyS4Zl4hGLHqAi1Y4l2Dd9XUfEeSX97KZXlxdS4ccqD3aGrNL1B29H9oTMohU0KlBXKcZ3sdNFhS9Ap0Vb1oFVfLHrh8pVCn/hA0DdrYO+O13qZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPIy0P7h; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPIy0P7h"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3ee12807d97so5252288f8f.0
        for <git@vger.kernel.org>; Tue, 07 Oct 2025 05:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759840244; x=1760445044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BCO/olEVzo3/nEey0kBvphEVlcGSTxPAxEnVLXNsaq0=;
        b=FPIy0P7hljII9B12uC+20PFCSGdEhqfwHtyMC9rGnjfLsfwaG9LQsO4NAwzsXUp8ow
         a/CiXweRtUog9fu6HjWR9DHP/G/aVKGjVUiY/w5QY68F6R1wXEPaNuZm6MFCyVIp0iZB
         nQq5Lxhm88Ws1qrppl/Nzyv569os/QMvByWDQSxJ+1ic4ZP7pbxa+gkFg7VzEc1cLYRz
         sJggptm09Tdr3CUz79S7R/OmOzZALBJsXFBDOiG2HrM/7j0+BGqC3PDc1BpuxG63/oNA
         70JQzsWp9/vRtnFKT09yJa5ReRm/+/bPKxdkwJkdf+76vb3ExNpPAd/ucBwkygFOMVZz
         diVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759840244; x=1760445044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BCO/olEVzo3/nEey0kBvphEVlcGSTxPAxEnVLXNsaq0=;
        b=IiazXS7cBgVFL4WjB2ilueiZWH/xm/hX/c32jarOUQECl0Axzf1tY8RXuQtsQ3J/Pn
         VaN2gRH5I6O+NhWqGVABDz3lORlYbDUITrP3Fgnv6A3FrFhRuAgG2wvcZ1WamQIyJNhB
         WLYMbIWRZhrMVBpFHq+sApw7gICUe1MISxlgKhwq1mypONVlpPRO0QIQJFhk+kQ+Dl/b
         M9oz60NW98OwOMe8swVGoUEGon3AH08y2h7VZSHSpgslb2OTxoygc8PAGfW3pH4TGbwJ
         xi+q4jYbF3vhE+TylIdKUWAspf8oh49EyNhLAnIk+f9g8PcUNeDiyD+U+mh4TtGbwHhL
         2Amw==
X-Gm-Message-State: AOJu0YwDFXvSJ8hWq9aFtammJ98DVkE/21Uyaf71/rCpqjbJIH/l6wHE
	6sqG62aTRuDYabKNkfe5ZVEnOexfSrAtBLCgrhoXWIAiM9igsMEiqEhR2d4l8k43
X-Gm-Gg: ASbGncuJeLrkjkDgisszVqiGYCtTS+nsTHzmjbqkKDbcfVsK34U8585hjMuHOCBF8IR
	zjZ+plOhyWo5ghmuoQ27sA9f9aqyPhHAg+756vlv/Szq4eaFQWXahqqc2kEg8yvBa+U5o96LmvM
	/nvetqteB693NbfdziGvNdAQebc2ftjvDo1gVilzY+KT2I2LMN0Z/zziPDFPU5AhwjjiUZ4cq4T
	LV/iFKrkFkky/ZonicOVguj2mzanP8jB4I75XI1A+KAp4FGieHmHp4Cpx+dle9PVHkDRlF6Qwvh
	+sJSVCzg9yA7gQo0flY+t/kc22JW+6zMx8ovg9TYP3dNeCv03PDW1oTF4xXUm56uggdyBO5ea2U
	ll/3URhongb8P7GiRrmcdaH0H0rZp4r3h2R2KSR3Y/H7mnBU9M/RbiCABpdLfKwIW8098TOdywg
	==
X-Google-Smtp-Source: AGHT+IGVLmn5qRlr79f6lNFiL7TllLNllzI4Z/tlYlu4U2rqWplK4253A3ZtHKC3my5uZm8JJQsoog==
X-Received: by 2002:a05:6000:310d:b0:3eb:a237:a051 with SMTP id ffacd0b85a97d-425671c1ba2mr10034405f8f.58.1759840243954;
        Tue, 07 Oct 2025 05:30:43 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f083asm25476185f8f.43.2025.10.07.05.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 05:30:42 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 4/5] fast-export: handle all kinds of tag signatures
Date: Tue,  7 Oct 2025 14:29:57 +0200
Message-ID: <20251007122958.1089680-5-christian.couder@gmail.com>
X-Mailer: git-send-email 2.51.0.438.g6987fc0bae
In-Reply-To: <20251007122958.1089680-1-christian.couder@gmail.com>
References: <20251007122958.1089680-1-christian.couder@gmail.com>
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
 builtin/fast-export.c  |  7 +++---
 t/t9350-fast-export.sh | 48 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 4 deletions(-)

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
index 21ff26939c..5a46608f65 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -279,6 +279,54 @@ test_expect_success 'signed-tags=warn-strip' '
 	test -s err
 '
 
+test_expect_success GPGSM 'setup X.509 signed tag' '
+
+	test_config gpg.format x509 &&
+	test_config user.signingkey $GIT_COMMITTER_EMAIL &&
+
+	git tag -s -m "X.509 signed tag" x509-signed $(git rev-parse HEAD) &&
+	ANNOTATED_TAG_COUNT=$((ANNOTATED_TAG_COUNT + 1))
+
+'
+
+test_expect_success GPGSM 'signed-tags=verbatim with X.509' '
+
+	git fast-export --signed-tags=verbatim x509-signed > output &&
+	test_grep "SIGNED MESSAGE" output
+
+'
+
+test_expect_success GPGSM 'signed-tags=strip with X.509' '
+
+	git fast-export --signed-tags=strip x509-signed > output &&
+	test_grep ! "SIGNED MESSAGE" output
+
+'
+
+test_expect_success GPGSSH 'setup SSH signed tag' '
+
+	test_config gpg.format ssh &&
+	test_config user.signingkey "${GPGSSH_KEY_PRIMARY}" &&
+
+	git tag -s -m "SSH signed tag" ssh-signed $(git rev-parse HEAD) &&
+	ANNOTATED_TAG_COUNT=$((ANNOTATED_TAG_COUNT + 1))
+
+'
+
+test_expect_success GPGSSH 'signed-tags=verbatim with SSH' '
+
+	git fast-export --signed-tags=verbatim ssh-signed > output &&
+	test_grep "SSH SIGNATURE" output
+
+'
+
+test_expect_success GPGSSH 'signed-tags=strip with SSH' '
+
+	git fast-export --signed-tags=strip ssh-signed > output &&
+	test_grep ! "SSH SIGNATURE" output
+
+'
+
 test_expect_success GPG 'set up signed commit' '
 
 	# Generate a commit with both "gpgsig" and "encoding" set, so
-- 
2.51.0.438.g6987fc0bae

