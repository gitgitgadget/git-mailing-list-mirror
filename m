Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DFB171E5F
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 23:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722902397; cv=none; b=IR7WFBE6mlFXN/KYhIv8W/TV2/wfTnP31rxhBwTQuWDyPE58b0ljGkltZyPv3kFq0xm1Pc+EKX/uWdy4zkt1K0h3Fwv4mlOdIE4lEkpITvaPzwE056L92YiSuDabf6XnQPnR+oU90kZkkSIXCJAKZEXv9Y925clfn57wn67W+Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722902397; c=relaxed/simple;
	bh=i7s8xi670FgFvwLuSBQ9fsq1/3J8V6Ht3tXnIEWyV6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ctGPTVFSLDGeuNdBiRazyuZMSpwTxJTSdofWsrIhtEyrhkGDSFf6AxN2AoglUpRzPRkZxswDSUK9klhheRjK/OHG4i7mqG13X7WDqs75wlBUO8wDsoOh35TmbcQJZX2gVsa0dp8/rF0YMlL7jTvnE5nsenpp2V83dzb3f92PXKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wxc8Gaw5; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wxc8Gaw5"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-36ba3b06186so3189052f8f.2
        for <git@vger.kernel.org>; Mon, 05 Aug 2024 16:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722902394; x=1723507194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jf9/6GuDTo3+VNry/KmF3EaQtXNlqBTPhf6IiTJY00k=;
        b=Wxc8Gaw574sn4ZzQapP4UPjjb1j3H/nLNJXI/ZgZgAOBxprDsYK8blrH74881FPpOw
         lFlOksAun216zGIU2iN5YqKGBSUNl60axyyYO6smYWn7Fv+QWJT8VoW2qmpJ8H6pVg8g
         3YQLZ9tNS+mKHA7mGySvPaUdNlgpxPL31mppdJjNvW1sN2TMud3RFtK8k1NCVQbPq9Q2
         EZJw0IPUFohFu7P28aO+moZv2i/rL01T5E6Y4eQ/IHOTb+lSPyAv6HeIOLtOpXEUb+RN
         +yUKVCGRWNaGJN+HIKmwuL1qLHUA+rascz1mRryfs8TkExbcwSKsDunMXmtdaiqjsOkw
         gliA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722902394; x=1723507194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jf9/6GuDTo3+VNry/KmF3EaQtXNlqBTPhf6IiTJY00k=;
        b=Kwd4QUkIpJhW/fQ2sN5z1ZEruth1yc5FQn6j5Dz0KEAcdgf74NglYErWtEU+pF4uVE
         +wVUiNrBvrGAKFHFuKDMa12BdGHDjsgacdQE8jmV2Z0r6NG+YA0UdYb4T6VGIUjaoXTg
         far63ke1LwNWjrRmJ97/UICcYmW+ZFCAzVFHgUQaATWNUUAts9hT2EpkgIIkB01u89n8
         Sj5xtKY2v/a7A6S2jiG1HwIjSedD0/l72rMGEcGLycHLN17qGpwolwDWUMgafZBeMAZg
         FWUt2ICgOSAeO3/tdGogtsXuJkdAlNQXlWleCqVTy/kAcHluOpZfvYO8UIqb4CBMtLs9
         QqTw==
X-Gm-Message-State: AOJu0YwBOHIWYAnB7Qrz/GxmBUIa4IETA4avUJHNBarnMXp4LCvxso/c
	Kt0S0ntdOcsPv+pcWMOuaKRnBXpsSZsNkknhNgr0jASRYjyY+TuuaoIWSFaT
X-Google-Smtp-Source: AGHT+IHydG20pmsexx5TAvH7UnNOLjV/VX8X0ZXsnnKTp36wOFGy7f8FRIFQTDYftsA5OCmjJ4D0mw==
X-Received: by 2002:a5d:5f86:0:b0:368:445e:91cc with SMTP id ffacd0b85a97d-36bbc0e40bcmr10157342f8f.21.1722902393632;
        Mon, 05 Aug 2024 16:59:53 -0700 (PDT)
Received: from abdobngad.. ([197.40.47.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd074583sm11219065f8f.108.2024.08.05.16.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 16:59:53 -0700 (PDT)
From: AbdAlRahman Gad <abdobngad@gmail.com>
To: git@vger.kernel.org
Cc: AbdAlRahman Gad <abdobngad@gmail.com>
Subject: [PATCH v4 7/8] [Newcomer] t7004: test Description and test body seperated with backslash
Date: Tue,  6 Aug 2024 02:59:16 +0300
Message-ID: <20240805235917.190699-8-abdobngad@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805235917.190699-1-abdobngad@gmail.com>
References: <20240805235917.190699-1-abdobngad@gmail.com>
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
index 6c93192d5d..a46f8141d4 100755
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
@@ -150,25 +151,31 @@ test_expect_success 'listing all tags if one exists should output that tag' '
 
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
@@ -238,8 +245,9 @@ test_expect_success 'trying to delete two tags, existing and not, should fail in
 	! tag_exists nonexistingtag
 '
 
-test_expect_success 'trying to delete an already deleted tag should fail' \
-	'test_must_fail git tag -d mytag'
+test_expect_success 'trying to delete an already deleted tag should fail' '
+	test_must_fail git tag -d mytag
+'
 
 # listing various tags with pattern matching:
 
@@ -419,14 +427,17 @@ test_expect_success 'a non-annotated tag created without parameters should point
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
 
@@ -1016,8 +1027,8 @@ test_expect_success GPG '-s implies annotated tag' '
 	test_cmp expect actual
 '
 
-test_expect_success GPG 'git tag -s implied if configured with tag.forcesignannotated' \
-	'get_tag_header forcesignannotated-implied-sign $commit commit $time >expect &&
+test_expect_success GPG 'git tag -s implied if configured with tag.forcesignannotated' '
+	get_tag_header forcesignannotated-implied-sign $commit commit $time >expect &&
 	echo "A message" >>expect &&
 	echo "-----BEGIN PGP SIGNATURE-----" >>expect &&
 	test_config tag.forcesignannotated true &&
@@ -1026,15 +1037,15 @@ test_expect_success GPG 'git tag -s implied if configured with tag.forcesignanno
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
@@ -1043,8 +1054,8 @@ test_expect_success GPG 'git tag -a disable configured tag.forcesignannotated' \
 	test_must_fail git tag -v forcesignannotated-annotate
 '
 
-test_expect_success GPG 'git tag --sign enable GPG sign' \
-	'get_tag_header forcesignannotated-disabled $commit commit $time >expect &&
+test_expect_success GPG 'git tag --sign enable GPG sign' '
+	get_tag_header forcesignannotated-disabled $commit commit $time >expect &&
 	echo "A message" >>expect &&
 	echo "-----BEGIN PGP SIGNATURE-----" >>expect &&
 	test_config tag.forcesignannotated false &&
@@ -1053,8 +1064,8 @@ test_expect_success GPG 'git tag --sign enable GPG sign' \
 	test_cmp expect actual
 '
 
-test_expect_success GPG 'git tag configured tag.gpgsign enables GPG sign' \
-	'get_tag_header gpgsign-enabled $commit commit $time >expect &&
+test_expect_success GPG 'git tag configured tag.gpgsign enables GPG sign' '
+	get_tag_header gpgsign-enabled $commit commit $time >expect &&
 	echo "A message" >>expect &&
 	echo "-----BEGIN PGP SIGNATURE-----" >>expect &&
 	test_config tag.gpgsign true &&
@@ -1063,8 +1074,8 @@ test_expect_success GPG 'git tag configured tag.gpgsign enables GPG sign' \
 	test_cmp expect actual
 '
 
-test_expect_success GPG 'git tag --no-sign configured tag.gpgsign skip GPG sign' \
-	'get_tag_header no-sign $commit commit $time >expect &&
+test_expect_success GPG 'git tag --no-sign configured tag.gpgsign skip GPG sign' '
+	get_tag_header no-sign $commit commit $time >expect &&
 	echo "A message" >>expect &&
 	test_config tag.gpgsign true &&
 	git tag -a --no-sign -m "A message" no-sign &&
@@ -1079,11 +1090,13 @@ test_expect_success GPG 'trying to create a signed tag with non-existing -F file
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
@@ -1453,14 +1466,16 @@ test_expect_success GPG,RFC1991 'reediting a signed tag body omits signature' '
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
@@ -1481,21 +1496,23 @@ test_expect_success GPG 'git verifies tag is valid with double signature' '
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

