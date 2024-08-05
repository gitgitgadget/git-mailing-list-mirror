Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DF316F824
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 23:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722902399; cv=none; b=An13kjVqecPz4aDM/8Gh6TvrjNA3JuXQ8/tpvTnLfTEnOeVZp6MWtShBSL51oQhRnOeXkqs9YbLb7KPcGyfLioebuNP4lCRqL3bnAbNT9u8ZMM8ujtnV6XwUWCcG62Mx/ofVnarkkciqiH/2K9N+wGrXSLsoPFpzBVhVu4ZDEF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722902399; c=relaxed/simple;
	bh=tBDbdBNWBIEnsYUql9KLc64Ox2tPd3rxNefyVLXnRR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DwPc/QVzej0H1liUQCSSrIrXEyH8n63Afa6f7h0B2RJZNJOJwB2AyL6zQGQqD+FQs6v09BSKY6bFtXLthcQI/CfGJPCsdSwmcggVtpOYlv7eVtfcpObOcuFbdCX6KtCb7jw6MrcqCngLgi6F3ZoShXu1k0s/5YYpcjJEtvag26c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZ17Py9L; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZ17Py9L"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3683329f787so6267017f8f.1
        for <git@vger.kernel.org>; Mon, 05 Aug 2024 16:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722902395; x=1723507195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yM/HBqdzIvgUmVNjDkTW1BR+vB34fB2qe5Grt2ZpzmI=;
        b=QZ17Py9Lv6K7qO9lHUhWuucQ0j5ihpj9ex73UkaSwg4WgclLNbGr3s/dPskH7vZV/V
         WKuB+h4ZjYwmMbuf8qpvQNyA1KFbgkiF5dWpvtzZGR5PAC97lM1+gebz9Zc463dJVU9L
         ZSbdeWQ9vybujMY+izNNLoUF9Ge1FFx38Ie+nlmfTxR/rqY3Lgt85/mhF1wLstfk+sIU
         aEDmxFi+ptNFijK0kItb6S/RX3u/MqdTKMkLixAQNDqDHr0ehA8XZdaxjsCUnxijNHkc
         po43sdeUIPWz5LWkPPAFMIYYtDdbPt0XVXaRnir1FtT/Iq4VS0ehQV7NcjAIqBlqQRiR
         o07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722902395; x=1723507195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yM/HBqdzIvgUmVNjDkTW1BR+vB34fB2qe5Grt2ZpzmI=;
        b=cFBhvKpiH6xnlH4K0oXB30YamTds419VEb5fnHNLP62ta1nTjIwP9E+KwFsc3YT/VK
         wVYE3YFf7eLU9S6wOGY7AbgBJLySyIEmRxkW6zRsUbNiuJdR5Yepr3HvKPGBUWw1Od3c
         0DRsR190TzWRvCM3UcHu4csmdzJFrY4K5ZUdwM8rmx/R/XbrmtZtQDOdj7I4IF1Evzyd
         vJXw21+7TqR7QmrPxz+b8zTLLX82LAiFueQgsWulTLST2fooKK1bXbWyQ74BeNfMMHGf
         JZJ8HYzTg5IOR91374vzAIq8JuusRkbAkXZx8ejGLYWXi+tRnEw1Jm6+GoCtkhNwAv7i
         oQJw==
X-Gm-Message-State: AOJu0YzXDYwAKs6h8Q3vnmoFWHxK+qV+I2yB7VKw/3SS9jPTB0xRh4qX
	k2SiXYlzOeOjJd84k7mNceLR7ZI/Rvy31FtexFcFHxHMq3fhVreTqEVAbzXD
X-Google-Smtp-Source: AGHT+IETvcnFVZL25A3PZ6U7rwsBaVcK9E9kKB7AbOo8EZ9qA1rH4IN5jF/Kg4aJYiH/kAlXhkZypw==
X-Received: by 2002:a5d:5248:0:b0:368:319c:9a77 with SMTP id ffacd0b85a97d-36bbc0fff6cmr9069906f8f.29.1722902394844;
        Mon, 05 Aug 2024 16:59:54 -0700 (PDT)
Received: from abdobngad.. ([197.40.47.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd074583sm11219065f8f.108.2024.08.05.16.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 16:59:54 -0700 (PDT)
From: AbdAlRahman Gad <abdobngad@gmail.com>
To: git@vger.kernel.org
Cc: AbdAlRahman Gad <abdobngad@gmail.com>
Subject: [PATCH v4 8/8] [Newcomer] t7004: Use single quotes instead of double quotes
Date: Tue,  6 Aug 2024 02:59:17 +0300
Message-ID: <20240805235917.190699-9-abdobngad@gmail.com>
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

Some test bodies and test description are surrounded with double
quotes instead of single quotes, violating our coding style.

Signed-off-by: AbdAlRahman Gad <abdobngad@gmail.com>
---
 t/t7004-tag.sh | 70 +++++++++++++++++++++++++-------------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index a46f8141d4..06f07b5524 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1585,7 +1585,7 @@ test_expect_success 'creating third commit without tag' '
 
 # simple linear checks of --continue
 
-test_expect_success 'checking that first commit is in all tags (hash)' "
+test_expect_success 'checking that first commit is in all tags (hash)' '
 	hash3=$(git rev-parse HEAD) &&
 	cat >expected <<-\EOF &&
 	v0.2.1
@@ -1596,10 +1596,10 @@ test_expect_success 'checking that first commit is in all tags (hash)' "
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
@@ -1609,9 +1609,9 @@ test_expect_success 'checking that first commit is in all tags (tag)' "
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
@@ -1621,33 +1621,33 @@ test_expect_success 'checking that first commit is in all tags (relative)' "
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
@@ -1656,14 +1656,14 @@ test_expect_success 'inverse of the last test, with --no-contains' "
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
@@ -1673,7 +1673,7 @@ test_expect_success 'conversely --no-contains on the third commit lists all tags
 	EOF
 	git tag -l --no-contains $hash3 v* >actual &&
 	test_cmp expected actual
-"
+'
 
 # how about a simple merge?
 
@@ -1694,7 +1694,7 @@ test_expect_success 'checking that branch head only has one tag' '
 	test_cmp expected actual
 '
 
-test_expect_success 'checking that branch head with --no-contains lists all but one tag' "
+test_expect_success 'checking that branch head with --no-contains lists all but one tag' '
 	cat >expected <<-\EOF &&
 	v0.2.1
 	v1.0
@@ -1704,22 +1704,22 @@ test_expect_success 'checking that branch head with --no-contains lists all but
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
@@ -1730,9 +1730,9 @@ test_expect_success 'checking that original branch head with --no-contains lists
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
@@ -1744,7 +1744,7 @@ test_expect_success 'checking that initial commit is in all tags' "
 	EOF
 	git tag -l --contains $hash1 v* >actual &&
 	test_cmp expected actual
-"
+'
 
 test_expect_success 'checking that --contains can be used in non-list mode' '
 	cat >expected <<-\EOF &&
@@ -1760,10 +1760,10 @@ test_expect_success 'checking that --contains can be used in non-list mode' '
 	test_cmp expected actual
 '
 
-test_expect_success 'checking that initial commit is in all tags with --no-contains' "
+test_expect_success 'checking that initial commit is in all tags with --no-contains' '
 	git tag -l --no-contains $hash1 v* >actual &&
 	test_must_be_empty actual
-"
+'
 
 # mixing modes and options:
 
@@ -1800,16 +1800,16 @@ test_expect_success 'mixing incompatibles modes and options is forbidden' '
 
 for option in --contains --with --no-contains --without --merged --no-merged --points-at
 do
-	test_expect_success "mixing incompatible modes with $option is forbidden" "
+	test_expect_success 'mixing incompatible modes with $option is forbidden' '
 		test_must_fail git tag -d $option HEAD &&
 		test_must_fail git tag -d $option HEAD some-tag &&
 		test_must_fail git tag -v $option HEAD
-	"
-	test_expect_success "Doing 'git tag --list-like $option <commit> <pattern> is permitted" "
+	'
+	test_expect_success 'Doing "git tag --list-like $option <commit> <pattern> is permitted' '
 		git tag -n $option HEAD HEAD &&
 		git tag $option HEAD HEAD &&
 		git tag $option
-	"
+	'
 done
 
 # check points-at
@@ -2185,7 +2185,7 @@ test_expect_success 'git tag -l with --format="%(rest)" must fail' '
 	test_must_fail git tag -l --format="%(rest)" "v1*"
 '
 
-test_expect_success "set up color tests" '
+test_expect_success 'set up color tests' '
 	echo "<RED>v1.0<RESET>" >expect.color &&
 	echo "v1.0" >expect.bare &&
 	color_args="--format=%(color:red)%(refname:short) --list v1.0"
-- 
2.43.0

