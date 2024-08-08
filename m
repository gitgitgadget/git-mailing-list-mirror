Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549201917CE
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 16:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723134844; cv=none; b=hehNId05P7o0bLHcJsj3KKGtbzsVsa8JBb18yiTxAGohs4s1UFYgLHyAQSO370Az1rIx4aKhS6f1rQ232V8JQYSoSwGdO1cGyg6YwISyfZ59ZECEkkCYtWb0pmcdw2NG43NeS1bPZfbzE6t+UzJO6R2BUNSnjq9SiltY7bXRE2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723134844; c=relaxed/simple;
	bh=TqxR93We0Jzw3S+HgfcmOstzB9/095t878nhZEiDQEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oHrM9bXIriRQSJEyRaTR33weSfSKP3Hl2hNpYjCZs1IwAvaxyVz+j3hTKJhBjkMifHTXzsjlr/LXJTkWV/hxfxOgeyqOehVrgmWVMeqVE61p1UH6LAZ83lCpluzdOOGBrAe2PNk1UihTDkO78vT1EXPo7soR9zv2jOsdDxNvZqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EmwbJlP4; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmwbJlP4"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42809d6e719so8759745e9.3
        for <git@vger.kernel.org>; Thu, 08 Aug 2024 09:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723134840; x=1723739640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b8h7I8Bsuk9bxkpPbSf4fcRiRr8dxq6vFqTK5db6Qo0=;
        b=EmwbJlP4TcCEKgh7SMa/Jix+AjDZoOQLi1eruWyn8eK+KQmM1ZjXC8NmyY1qF1Rx3u
         AZ/xqBdx8PjG3GdgDe3Zdcc+++kehBhNk6NDJeuvcnpHqLq7M1BE/PLRPkeFLaZ1AIj2
         vthF2ILql2dL9YSVM+JHpAhD5jgulG2Q6krV/MqCCSVkTM3KF/RuGdnmisIzD0q+IxGL
         EzSmK9D5H/xMeFzv947bQcgDBphHXzAWN7/hjf9t4vPR4lyroPgAiw7udxtI9pEiliog
         Y/cSCzPbkz4hG4LSX1kIZCGZnbvFA2xzu35oPK3OUPWxzHRIbzza07ex9oOc0ejaFySY
         H+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723134840; x=1723739640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b8h7I8Bsuk9bxkpPbSf4fcRiRr8dxq6vFqTK5db6Qo0=;
        b=N0h0eUSp4cRDmr9DgOyPhkS+D0PHtPgKv3ohJ409SNK0edpfCxwvVyU6iNCgYoI6np
         NxjD7xz2xtybofSz0B4kUM2MbZomEGK9QE0ySxnSoZfQEQGE0bPK1EDacrijimO/M/EA
         vbC52UWGc+CKh/2WUiFuN3C2/4KqrwuPqQyuez3ZMui6NGaNY0JvPy67iYfzKr1iHbJw
         cp0itObPNobw0uW/BoHmMYKA0x646xIxHU42yKkPc2zRFX0FRumbx1JpQ+TtBar40Huq
         Lvb+QjuF6tGUJwePOKAQ4awDvGyfpMXzpOgn1bhJUMJsrNzvGQ+bDCs66FrK6ROMYGKu
         iVSg==
X-Gm-Message-State: AOJu0YwmIVwiFMdHZWV8Ioyr4mxt2y8dcRRALf1j8uV6FwxqJZcZIRMp
	z6c1ccUCQEg6wnPOa9OurBlYjB44Qa93UljOWTYjwQ3gDSl0FhRnWseAsPorq8k=
X-Google-Smtp-Source: AGHT+IFKaGiCMPvGZKtqnV5ydKY5wBHcVHVG1wih/COxPPxAJ9zXqS3iN6EhTa4edPVezr7B5K106A==
X-Received: by 2002:adf:b357:0:b0:368:4e28:47f7 with SMTP id ffacd0b85a97d-36d27525489mr1954710f8f.6.1723134840225;
        Thu, 08 Aug 2024 09:34:00 -0700 (PDT)
Received: from abdobngad.. ([154.182.250.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d27229689sm2415765f8f.95.2024.08.08.09.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 09:34:00 -0700 (PDT)
From: AbdAlRahman Gad <abdobngad@gmail.com>
To: git@vger.kernel.org
Cc: AbdAlRahman Gad <abdobngad@gmail.com>
Subject: [PATCH v6 6/8] t7004: begin the test body on the same line as test_expect_success
Date: Thu,  8 Aug 2024 19:32:05 +0300
Message-ID: <20240808163302.17521-7-abdobngad@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240808163302.17521-1-abdobngad@gmail.com>
References: <20240808163302.17521-1-abdobngad@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test body should begin with a single quote right after the test
description instead of backslash followed by new line.

Signed-off-by: AbdAlRahman Gad <abdobngad@gmail.com>
---
 t/t7004-tag.sh | 125 ++++++++++++++++++++++++++++---------------------
 1 file changed, 71 insertions(+), 54 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 5cbb13a603..2b15ede1f3 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -61,8 +61,9 @@ test_expect_success 'sort tags, ignore case' '
 	)
 '
 
-test_expect_success 'looking for a tag in an empty tree should fail' \
-	'! (tag_exists mytag)'
+test_expect_success 'looking for a tag in an empty tree should fail' '
+	! (tag_exists mytag)
+'
 
 test_expect_success 'creating a tag in an empty tree should fail' '
 	test_must_fail git tag mynotag &&
@@ -148,25 +149,31 @@ test_expect_success 'listing all tags if one exists should output that tag' '
 
 # pattern matching:
 
-test_expect_success 'listing a tag using a matching pattern should succeed' \
-	'git tag -l mytag'
+test_expect_success 'listing a tag using a matching pattern should succeed' '
+	git tag -l mytag
+'
 
-test_expect_success 'listing a tag with --ignore-case' \
-	'test $(git tag -l --ignore-case MYTAG) = mytag'
+test_expect_success 'listing a tag with --ignore-case' '
+	test $(git tag -l --ignore-case MYTAG) = mytag
+'
 
-test_expect_success 'listing a tag using a matching pattern should output that tag' \
-	'test $(git tag -l mytag) = mytag'
+test_expect_success 'listing a tag using a matching pattern should output that tag' '
+	test $(git tag -l mytag) = mytag
+'
 
-test_expect_success 'listing tags using a non-matching pattern should succeed' \
-	'git tag -l xxx'
+test_expect_success 'listing tags using a non-matching pattern should succeed' '
+	git tag -l xxx
+'
 
-test_expect_success 'listing tags using a non-matching pattern should output nothing' \
-	'test $(git tag -l xxx | wc -l) -eq 0'
+test_expect_success 'listing tags using a non-matching pattern should output nothing' '
+	test $(git tag -l xxx | wc -l) -eq 0
+'
 
 # special cases for creating tags:
 
-test_expect_success 'trying to create a tag with the name of one existing should fail' \
-	'test_must_fail git tag mytag'
+test_expect_success 'trying to create a tag with the name of one existing should fail' '
+	test_must_fail git tag mytag
+'
 
 test_expect_success 'trying to create a tag with a non-valid name should fail' '
 	test $(git tag -l | wc -l) -eq 1 &&
@@ -236,8 +243,9 @@ test_expect_success 'trying to delete two tags, existing and not, should fail in
 	! tag_exists nonexistingtag
 '
 
-test_expect_success 'trying to delete an already deleted tag should fail' \
-	'test_must_fail git tag -d mytag'
+test_expect_success 'trying to delete an already deleted tag should fail' '
+	test_must_fail git tag -d mytag
+'
 
 # listing various tags with pattern matching:
 
@@ -417,14 +425,17 @@ test_expect_success 'a non-annotated tag created without parameters should point
 	test $(git rev-parse non-annotated-tag) = $(git rev-parse HEAD)
 '
 
-test_expect_success 'trying to verify an unknown tag should fail' \
-	'test_must_fail git tag -v unknown-tag'
+test_expect_success 'trying to verify an unknown tag should fail' '
+	test_must_fail git tag -v unknown-tag
+'
 
-test_expect_success 'trying to verify a non-annotated and non-signed tag should fail' \
-	'test_must_fail git tag -v non-annotated-tag'
+test_expect_success 'trying to verify a non-annotated and non-signed tag should fail' '
+	test_must_fail git tag -v non-annotated-tag
+'
 
-test_expect_success 'trying to verify many non-annotated or unknown tags, should fail' \
-	'test_must_fail git tag -v unknown-tag1 non-annotated-tag unknown-tag2'
+test_expect_success 'trying to verify many non-annotated or unknown tags, should fail' '
+	test_must_fail git tag -v unknown-tag1 non-annotated-tag unknown-tag2
+'
 
 # creating annotated tags:
 
@@ -1014,8 +1025,8 @@ test_expect_success GPG '-s implies annotated tag' '
 	test_cmp expect actual
 '
 
-test_expect_success GPG 'git tag -s implied if configured with tag.forcesignannotated' \
-	'get_tag_header forcesignannotated-implied-sign $commit commit $time >expect &&
+test_expect_success GPG 'git tag -s implied if configured with tag.forcesignannotated' '
+	get_tag_header forcesignannotated-implied-sign $commit commit $time >expect &&
 	echo "A message" >>expect &&
 	echo "-----BEGIN PGP SIGNATURE-----" >>expect &&
 	test_config tag.forcesignannotated true &&
@@ -1024,15 +1035,15 @@ test_expect_success GPG 'git tag -s implied if configured with tag.forcesignanno
 	test_cmp expect actual
 '
 
-test_expect_success GPG 'lightweight with no message when configured with tag.forcesignannotated' \
-	'test_config tag.forcesignannotated true &&
+test_expect_success GPG 'lightweight with no message when configured with tag.forcesignannotated' '
+	test_config tag.forcesignannotated true &&
 	git tag forcesignannotated-lightweight &&
 	tag_exists forcesignannotated-lightweight &&
 	test_must_fail git tag -v forcesignannotated-no-message
 '
 
-test_expect_success GPG 'git tag -a disable configured tag.forcesignannotated' \
-	'get_tag_header forcesignannotated-annotate $commit commit $time >expect &&
+test_expect_success GPG 'git tag -a disable configured tag.forcesignannotated' '
+	get_tag_header forcesignannotated-annotate $commit commit $time >expect &&
 	echo "A message" >>expect &&
 	test_config tag.forcesignannotated true &&
 	git tag -a -m "A message" forcesignannotated-annotate &&
@@ -1041,8 +1052,8 @@ test_expect_success GPG 'git tag -a disable configured tag.forcesignannotated' \
 	test_must_fail git tag -v forcesignannotated-annotate
 '
 
-test_expect_success GPG 'git tag --sign enable GPG sign' \
-	'get_tag_header forcesignannotated-disabled $commit commit $time >expect &&
+test_expect_success GPG 'git tag --sign enable GPG sign' '
+	get_tag_header forcesignannotated-disabled $commit commit $time >expect &&
 	echo "A message" >>expect &&
 	echo "-----BEGIN PGP SIGNATURE-----" >>expect &&
 	test_config tag.forcesignannotated false &&
@@ -1051,8 +1062,8 @@ test_expect_success GPG 'git tag --sign enable GPG sign' \
 	test_cmp expect actual
 '
 
-test_expect_success GPG 'git tag configured tag.gpgsign enables GPG sign' \
-	'get_tag_header gpgsign-enabled $commit commit $time >expect &&
+test_expect_success GPG 'git tag configured tag.gpgsign enables GPG sign' '
+	get_tag_header gpgsign-enabled $commit commit $time >expect &&
 	echo "A message" >>expect &&
 	echo "-----BEGIN PGP SIGNATURE-----" >>expect &&
 	test_config tag.gpgsign true &&
@@ -1061,8 +1072,8 @@ test_expect_success GPG 'git tag configured tag.gpgsign enables GPG sign' \
 	test_cmp expect actual
 '
 
-test_expect_success GPG 'git tag --no-sign configured tag.gpgsign skip GPG sign' \
-	'get_tag_header no-sign $commit commit $time >expect &&
+test_expect_success GPG 'git tag --no-sign configured tag.gpgsign skip GPG sign' '
+	get_tag_header no-sign $commit commit $time >expect &&
 	echo "A message" >>expect &&
 	test_config tag.gpgsign true &&
 	git tag -a --no-sign -m "A message" no-sign &&
@@ -1077,11 +1088,13 @@ test_expect_success GPG 'trying to create a signed tag with non-existing -F file
 	! tag_exists nosigtag
 '
 
-test_expect_success GPG 'verifying a signed tag should succeed' \
-	'git tag -v signed-tag'
+test_expect_success GPG 'verifying a signed tag should succeed' '
+	git tag -v signed-tag
+'
 
-test_expect_success GPG 'verifying two signed tags in one command should succeed' \
-	'git tag -v signed-tag file-signed-tag'
+test_expect_success GPG 'verifying two signed tags in one command should succeed' '
+	git tag -v signed-tag file-signed-tag
+'
 
 test_expect_success GPG 'verifying many signed and non-signed tags should fail' '
 	test_must_fail git tag -v signed-tag annotated-tag &&
@@ -1451,14 +1464,16 @@ test_expect_success GPG,RFC1991 'reediting a signed tag body omits signature' '
 '
 
 # try to sign with bad user.signingkey
-test_expect_success GPG 'git tag -s fails if gpg is misconfigured (bad key)' \
-	'test_config user.signingkey BobTheMouse &&
-	test_must_fail git tag -s -m tail tag-gpg-failure'
+test_expect_success GPG 'git tag -s fails if gpg is misconfigured (bad key)' '
+	test_config user.signingkey BobTheMouse &&
+	test_must_fail git tag -s -m tail tag-gpg-failure
+'
 
 # try to produce invalid signature
-test_expect_success GPG 'git tag -s fails if gpg is misconfigured (bad signature format)' \
-	'test_config gpg.program echo &&
-	 test_must_fail git tag -s -m tail tag-gpg-failure'
+test_expect_success GPG 'git tag -s fails if gpg is misconfigured (bad signature format)' '
+	test_config gpg.program echo &&
+	test_must_fail git tag -s -m tail tag-gpg-failure
+'
 
 # try to produce invalid signature
 test_expect_success GPG 'git verifies tag is valid with double signature' '
@@ -1479,21 +1494,23 @@ test_expect_success GPG 'git verifies tag is valid with double signature' '
 '
 
 # try to sign with bad user.signingkey
-test_expect_success GPGSM 'git tag -s fails if gpgsm is misconfigured (bad key)' \
-	'test_config user.signingkey BobTheMouse &&
-	 test_config gpg.format x509 &&
-	 test_must_fail git tag -s -m tail tag-gpg-failure'
+test_expect_success GPGSM 'git tag -s fails if gpgsm is misconfigured (bad key)' '
+	test_config user.signingkey BobTheMouse &&
+	test_config gpg.format x509 &&
+	test_must_fail git tag -s -m tail tag-gpg-failure
+'
 
 # try to produce invalid signature
-test_expect_success GPGSM 'git tag -s fails if gpgsm is misconfigured (bad signature format)' \
-	'test_config gpg.x509.program echo &&
-	 test_config gpg.format x509 &&
-	 test_must_fail git tag -s -m tail tag-gpg-failure'
+test_expect_success GPGSM 'git tag -s fails if gpgsm is misconfigured (bad signature format)' '
+	test_config gpg.x509.program echo &&
+	test_config gpg.format x509 &&
+	test_must_fail git tag -s -m tail tag-gpg-failure
+'
 
 # try to verify without gpg:
 
-test_expect_success GPG 'verify signed tag fails when public key is not present' \
-	'rm -rf gpghome &&
+test_expect_success GPG 'verify signed tag fails when public key is not present' '
+	rm -rf gpghome &&
 	test_must_fail git tag -v signed-tag
 '
 
-- 
2.43.0

