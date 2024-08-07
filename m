Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EC31E7A37
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 13:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723035818; cv=none; b=hrIb6CReQDfkMzh5cSoKRVpR2UjnyNETEFoYUz9+SWojCeEqfUVxlseVFvA2i5km5Q7gM8RXkvJg9ssoNZFI0fL3KHIQaHjq+vlWliJI6ZbcUTU67qJopMMhuJqMv5ZdXMG2+UEFRxWzjQiIG7iDqbn/VkQ/Xhafjc7RyiHaPQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723035818; c=relaxed/simple;
	bh=TqxR93We0Jzw3S+HgfcmOstzB9/095t878nhZEiDQEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ibDVtV5IUNFxvGX1SspjRCBeD6uJyZTiUhikYoOicL4LjLKTL9HmU0cSA15taq7lfSuLBKR87qarSjEgf8cmAji5sF6etfe0X33iOL8G5ENtidDuPt1cm7OxjsJ1pfC4A3jy6xYpqP40d1Ns1FUdMJl7w9XQ4gD4RbagwP4Fwe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHf3BzPm; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHf3BzPm"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f032cb782dso16535841fa.3
        for <git@vger.kernel.org>; Wed, 07 Aug 2024 06:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723035814; x=1723640614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b8h7I8Bsuk9bxkpPbSf4fcRiRr8dxq6vFqTK5db6Qo0=;
        b=bHf3BzPm/+fJahbWeFh6setyYWMT2HcgcL7JsxNH/jDEZK0bqoqAHXATuy69y7+cb4
         HvLdhvS4vy2VatjZFInmLS7hneS9pRjsbV9ZamldLl/jlLSFF1iPhC3DYIuP9B+xInyg
         NtGxT54fu6wMgbmfT5aOPwNnVoYzpVre4TPMy5+o7YQXxW0yJAHFHNFESyASu9aMZMzY
         zVFe79PGP3iG5yfywWcdK9y5dW4/bri2VT2jH7mbioFbDvyXLZIB43NY5ewZ93pI6y6o
         xsdJ6spV4dLXT9e4Gu7zzOdo7CX5KlNWU8hnF7WzxGg+bSZOQPyo/Ytj+i8n6hiR2+lp
         uyMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723035814; x=1723640614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b8h7I8Bsuk9bxkpPbSf4fcRiRr8dxq6vFqTK5db6Qo0=;
        b=YPPDouyinU2wHnLOdWtKcuZ8M75C3exyVkdELtruIMQwy6TlYaHDWSGcpDCyD/DkJy
         3ny3Ih56DMbB9CP+P/J4FCWElfeML+OUOgAhf3Ll7dQ65cnSy7v1V2HQaKi70+QBN7CN
         JBig2dByub6OMuBAiaYiUOhq8U53sImsUoUUHS23ib9g60z9udA9wunyVWqBwGr/kseJ
         Zc9yIHggAAdKHd1prhXKShjh0bHk5aQGl031C9FIahGQJwnzMs1uOfsrfgiVFytFWWvq
         LiYwCxDwEl3zwGrrcc+wE/jEEYGzQX+T/0CALo0IK3phwCDeoOWPJTgdcmKkkpay6dKo
         Sfvg==
X-Gm-Message-State: AOJu0YzH3DR9sDQwbdGodYYDva4p0wo4P2blOoLSOm3MXY/AC2JKsBOJ
	iYXr+YPTJ51Z7jx53WgkT8p11hvQY0umfcKYdr6rrLBpTQHBXMd9qRjfgrAu
X-Google-Smtp-Source: AGHT+IHw+zoz9URkk720L9cP7fN/sllRERjC7J8dTyNKZPgieQuCKZepqDFwaeXBhQ5PZWkhtksn7A==
X-Received: by 2002:a2e:3305:0:b0:2ef:2006:bfb1 with SMTP id 38308e7fff4ca-2f15aa934cfmr131862731fa.15.1723035813690;
        Wed, 07 Aug 2024 06:03:33 -0700 (PDT)
Received: from abdobngad.. ([154.182.238.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429057968d8sm29196825e9.9.2024.08.07.06.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 06:03:33 -0700 (PDT)
From: AbdAlRahman Gad <abdobngad@gmail.com>
To: git@vger.kernel.org
Cc: AbdAlRahman Gad <abdobngad@gmail.com>
Subject: [PATCH v5 6/8] t7004: test description and test body seperated with backslash
Date: Wed,  7 Aug 2024 15:58:42 +0300
Message-ID: <20240807130259.28381-7-abdobngad@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240807130259.28381-1-abdobngad@gmail.com>
References: <20240807130259.28381-1-abdobngad@gmail.com>
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

