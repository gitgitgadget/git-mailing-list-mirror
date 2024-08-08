Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226F7191F61
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 16:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723134846; cv=none; b=FiQEgHCD0tS4rKPZUPLzRe/6yq0CgJ6VyBGm/LleUv8F9xchvoQbY5PJwBoGD/GknQXE0Y7kFfmzcPj6DksanJtrAf6+YB7rr18Xpj/8ZByUfKvfAuyf98gDDcj99vudYYWlCCKV8FDQL13z6dRm8hyAuvk3CC+W174SvLzy9y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723134846; c=relaxed/simple;
	bh=BoQ0IAUos8x1kUByUP+3xBErycbQy5BCQM9YfcvaZBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q9b6NKHFhQ9D0X+REZ1UnqCqO9kONF2hpY7lM0PsAp32+gvUimQRl9iYT7iSVUV02dmGbovhxymWq1/gR1aMSvjgk/pAZPu+0sLbBcqRGX0yFuI8CmFkuujznNUSHircl7AHL2Gig/Eg4VjJRNZcTZHTrAd+JU7dZsLmDceTZpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/R914K2; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/R914K2"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-36868fcb919so721104f8f.2
        for <git@vger.kernel.org>; Thu, 08 Aug 2024 09:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723134842; x=1723739642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tmz1h4+VcqBpkCDYpWTREoovppaJQx36IZs7F77BpEo=;
        b=V/R914K2k25I+JDsZ0xikD1BehJQi36veAxoUDnyt7pK83aBKgyDU0LUTUSzvQCQx7
         /vP+QLpeic3o754VUDrmI0l5virux5BbnjVknyW6t6HXrj6Ednggrdk5z64RGTU4xFQh
         eue2C3wf9EuVEDZIp7on779zXYN0b4an17Mpx2gjJfglrfCi7w3nqxC4mEVVBhRXra1a
         rv5ta/iqFwgEvL4YHQ9LA1paqqQB2VvkTj7regCWgNTCp1POy69FXGSA2oghMjLeQoxB
         L0W8Slr3EwM1rp9RFVY404wReB3ketgzl5HWt5HwNYy8QrtxDFN4xotJ0pq4KXqbdvnd
         aI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723134842; x=1723739642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tmz1h4+VcqBpkCDYpWTREoovppaJQx36IZs7F77BpEo=;
        b=lo78v0HfGhTkPA9l3paxT56+mFfPTXd0b4M55UdPHxjfkpwlDMxqs/sE4k3O4TxkG/
         /F1EaA716S9PfW9QPpjobQHNs19Y2wWHwIyq446sitoCWK/bhmfgrUFbreZOkI56FHbR
         etGCGsZt6H7sulCm0TalPuobOlJBFpU5B7gZVUENU0MbhVg5OKkG1SSdMw5/N4dewPMl
         08JsMFnaMxufCCK4HcKcji2CzqpTX0b5krqr3iGI6tMpUweGbdgqxG/Zj7iG92OULNBO
         toiw23xNHohUJu7iKHnudWUBhPb9zvWdMTZyX4QJ3hlR5jXLF9a1qv+sc9SSx7zCr2vT
         iXaQ==
X-Gm-Message-State: AOJu0YxKzg6bRzc3wpn4AYP8Qrl0puj8oKhOuzMd1BMkz+MAHUol+6GF
	ggTKPfdOTfkEIv3/xhWAkInWzrwNbpydqZ/ywBUMHqyYZq1qdSSQsI+DCmkki8s=
X-Google-Smtp-Source: AGHT+IH6jMGWwOCaWTJU1U+b91wmDIRQtdka8tOFiMxwNo73FPIon3Xn5ZoaLY5YPmbO9JGGRf+z1Q==
X-Received: by 2002:a5d:6c6b:0:b0:367:4dbb:ed51 with SMTP id ffacd0b85a97d-36d27276865mr2142610f8f.0.1723134842054;
        Thu, 08 Aug 2024 09:34:02 -0700 (PDT)
Received: from abdobngad.. ([154.182.250.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d27229689sm2415765f8f.95.2024.08.08.09.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 09:34:01 -0700 (PDT)
From: AbdAlRahman Gad <abdobngad@gmail.com>
To: git@vger.kernel.org
Cc: AbdAlRahman Gad <abdobngad@gmail.com>
Subject: [PATCH v6 7/8] t7004: use single quotes instead of double quotes
Date: Thu,  8 Aug 2024 19:32:06 +0300
Message-ID: <20240808163302.17521-8-abdobngad@gmail.com>
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

Some test bodies and test description are surrounded with double
quotes instead of single quotes, violating our coding style.

Signed-off-by: AbdAlRahman Gad <abdobngad@gmail.com>
---
 t/t7004-tag.sh | 70 +++++++++++++++++++++++++-------------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 2b15ede1f3..046a5bd9bc 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1583,7 +1583,7 @@ test_expect_success 'creating third commit without tag' '
 
 # simple linear checks of --continue
 
-test_expect_success 'checking that first commit is in all tags (hash)' "
+test_expect_success 'checking that first commit is in all tags (hash)' '
 	hash3=$(git rev-parse HEAD) &&
 	cat >expected <<-\EOF &&
 	v0.2.1
@@ -1594,10 +1594,10 @@ test_expect_success 'checking that first commit is in all tags (hash)' "
 	EOF
 	git tag -l --contains $hash1 v* >actual &&
 	test_cmp expected actual
-"
+'
 
 # other ways of specifying the commit
-test_expect_success 'checking that first commit is in all tags (tag)' "
+test_expect_success 'checking that first commit is in all tags (tag)' '
 	cat >expected <<-\EOF &&
 	v0.2.1
 	v1.0
@@ -1607,9 +1607,9 @@ test_expect_success 'checking that first commit is in all tags (tag)' "
 	EOF
 	git tag -l --contains v1.0 v* >actual &&
 	test_cmp expected actual
-"
+'
 
-test_expect_success 'checking that first commit is in all tags (relative)' "
+test_expect_success 'checking that first commit is in all tags (relative)' '
 	cat >expected <<-\EOF &&
 	v0.2.1
 	v1.0
@@ -1619,33 +1619,33 @@ test_expect_success 'checking that first commit is in all tags (relative)' "
 	EOF
 	git tag -l --contains HEAD~2 v* >actual &&
 	test_cmp expected actual
-"
+'
 
 # All the --contains tests above, but with --no-contains
-test_expect_success 'checking that first commit is not listed in any tag with --no-contains  (hash)' "
+test_expect_success 'checking that first commit is not listed in any tag with --no-contains  (hash)' '
 	git tag -l --no-contains $hash1 v* >actual &&
 	test_must_be_empty actual
-"
+'
 
-test_expect_success 'checking that first commit is in all tags (tag)' "
+test_expect_success 'checking that first commit is in all tags (tag)' '
 	git tag -l --no-contains v1.0 v* >actual &&
 	test_must_be_empty actual
-"
+'
 
-test_expect_success 'checking that first commit is in all tags (relative)' "
+test_expect_success 'checking that first commit is in all tags (relative)' '
 	git tag -l --no-contains HEAD~2 v* >actual &&
 	test_must_be_empty actual
-"
+'
 
-test_expect_success 'checking that second commit only has one tag' "
+test_expect_success 'checking that second commit only has one tag' '
 	cat >expected <<-\EOF &&
 	v2.0
 	EOF
 	git tag -l --contains $hash2 v* >actual &&
 	test_cmp expected actual
-"
+'
 
-test_expect_success 'inverse of the last test, with --no-contains' "
+test_expect_success 'inverse of the last test, with --no-contains' '
 	cat >expected <<-\EOF &&
 	v0.2.1
 	v1.0
@@ -1654,14 +1654,14 @@ test_expect_success 'inverse of the last test, with --no-contains' "
 	EOF
 	git tag -l --no-contains $hash2 v* >actual &&
 	test_cmp expected actual
-"
+'
 
-test_expect_success 'checking that third commit has no tags' "
+test_expect_success 'checking that third commit has no tags' '
 	git tag -l --contains $hash3 v* >actual &&
 	test_must_be_empty actual
-"
+'
 
-test_expect_success 'conversely --no-contains on the third commit lists all tags' "
+test_expect_success 'conversely --no-contains on the third commit lists all tags' '
 	cat >expected <<-\EOF &&
 	v0.2.1
 	v1.0
@@ -1671,7 +1671,7 @@ test_expect_success 'conversely --no-contains on the third commit lists all tags
 	EOF
 	git tag -l --no-contains $hash3 v* >actual &&
 	test_cmp expected actual
-"
+'
 
 # how about a simple merge?
 
@@ -1692,7 +1692,7 @@ test_expect_success 'checking that branch head only has one tag' '
 	test_cmp expected actual
 '
 
-test_expect_success 'checking that branch head with --no-contains lists all but one tag' "
+test_expect_success 'checking that branch head with --no-contains lists all but one tag' '
 	cat >expected <<-\EOF &&
 	v0.2.1
 	v1.0
@@ -1702,22 +1702,22 @@ test_expect_success 'checking that branch head with --no-contains lists all but
 	EOF
 	git tag -l --no-contains $hash4 v* >actual &&
 	test_cmp expected actual
-"
+'
 
 test_expect_success 'merging original branch into this branch' '
 	git merge --strategy=ours main &&
         git tag v4.0
 '
 
-test_expect_success 'checking that original branch head has one tag now' "
+test_expect_success 'checking that original branch head has one tag now' '
 	cat >expected <<-\EOF &&
 	v4.0
 	EOF
 	git tag -l --contains $hash3 v* >actual &&
 	test_cmp expected actual
-"
+'
 
-test_expect_success 'checking that original branch head with --no-contains lists all but one tag now' "
+test_expect_success 'checking that original branch head with --no-contains lists all but one tag now' '
 	cat >expected <<-\EOF &&
 	v0.2.1
 	v1.0
@@ -1728,9 +1728,9 @@ test_expect_success 'checking that original branch head with --no-contains lists
 	EOF
 	git tag -l --no-contains $hash3 v* >actual &&
 	test_cmp expected actual
-"
+'
 
-test_expect_success 'checking that initial commit is in all tags' "
+test_expect_success 'checking that initial commit is in all tags' '
 	cat >expected <<-\EOF &&
 	v0.2.1
 	v1.0
@@ -1742,7 +1742,7 @@ test_expect_success 'checking that initial commit is in all tags' "
 	EOF
 	git tag -l --contains $hash1 v* >actual &&
 	test_cmp expected actual
-"
+'
 
 test_expect_success 'checking that --contains can be used in non-list mode' '
 	cat >expected <<-\EOF &&
@@ -1758,10 +1758,10 @@ test_expect_success 'checking that --contains can be used in non-list mode' '
 	test_cmp expected actual
 '
 
-test_expect_success 'checking that initial commit is in all tags with --no-contains' "
+test_expect_success 'checking that initial commit is in all tags with --no-contains' '
 	git tag -l --no-contains $hash1 v* >actual &&
 	test_must_be_empty actual
-"
+'
 
 # mixing modes and options:
 
@@ -1798,16 +1798,16 @@ test_expect_success 'mixing incompatibles modes and options is forbidden' '
 
 for option in --contains --with --no-contains --without --merged --no-merged --points-at
 do
-	test_expect_success "mixing incompatible modes with $option is forbidden" "
+	test_expect_success "mixing incompatible modes with $option is forbidden" '
 		test_must_fail git tag -d $option HEAD &&
 		test_must_fail git tag -d $option HEAD some-tag &&
 		test_must_fail git tag -v $option HEAD
-	"
-	test_expect_success "Doing 'git tag --list-like $option <commit> <pattern> is permitted" "
+	'
+	test_expect_success "Doing 'git tag --list-like $option <commit> <pattern> is permitted" '
 		git tag -n $option HEAD HEAD &&
 		git tag $option HEAD HEAD &&
 		git tag $option
-	"
+	'
 done
 
 # check points-at
@@ -2183,7 +2183,7 @@ test_expect_success 'git tag -l with --format="%(rest)" must fail' '
 	test_must_fail git tag -l --format="%(rest)" "v1*"
 '
 
-test_expect_success "set up color tests" '
+test_expect_success 'set up color tests' '
 	echo "<RED>v1.0<RESET>" >expect.color &&
 	echo "v1.0" >expect.bare &&
 	color_args="--format=%(color:red)%(refname:short) --list v1.0"
-- 
2.43.0

