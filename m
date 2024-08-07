Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088211E7A40
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 13:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723035818; cv=none; b=se2/ml/+JrQ/hOx4H9VhFqW8WS+a6RvuMRnreWGmlJDEogCPUJZrENoqw1XdxA/AuVx5ST15yo5wJgWBmD2XZKOKt+LRsKHwW51MZyZABG/w2BI6el6JvQO6x2KIZKgjl3ELXBpK0sZtofB1ZJ9+4cmE0qpACnAciHTrDGFMRBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723035818; c=relaxed/simple;
	bh=BoQ0IAUos8x1kUByUP+3xBErycbQy5BCQM9YfcvaZBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=emBCHTbEitZpAlqag1FqgxVjnf67XrZo6O3wZ7SgAw9uFQWvT/3+LwTdmTKoswujg7rsTzo49LqlHuBAigsCs7aryahg48ygI41U6vFZFQ3OMm+TX7xLyRfblS9nj8aXEo2vwo0ZKaZjMZAqsgxI0fYV+fvVHskCD9obHKombwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgOrBuTd; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgOrBuTd"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-428119da952so11977125e9.0
        for <git@vger.kernel.org>; Wed, 07 Aug 2024 06:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723035815; x=1723640615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tmz1h4+VcqBpkCDYpWTREoovppaJQx36IZs7F77BpEo=;
        b=lgOrBuTdlJseOPjfxFGknM+Hpun2FZy8AsgoH4qfcayyW/MBUiowCqj3Zc1tFUQyLy
         fKrw8XiG/r6zgh0AzPabzgONWfPs+wAIxIl1ZP6w2KnafTGvDQW/v2x4CrCW0qKRoTU6
         x2C63LKg/Lr6emMYBRauxxJVAv6VYaxmLAKZQIUrhDwh2/tpAtlNiZhEtvrvCzJ+AQMd
         GCBWVE0ZBjtd+SlsdmxwJH8YHF71x2u7l4jGcFFtTHzotEQBKTkzvosNuuF45Ha0Vsk0
         SqlSYOiq30S4N288W2sQpMxUIzz4VLBLBool3dyudZSNPjIcAbrVUDHcloIHPyYEroiN
         nMTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723035815; x=1723640615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tmz1h4+VcqBpkCDYpWTREoovppaJQx36IZs7F77BpEo=;
        b=G14GX7RZrXf0PRAU6y+9N3HM4dkwiJC8pNC9ft2DpWDG06mjY24pauShiSVeB7C4zp
         uKvXM5fICiywTv7B8ijQ0nTIVLixax+RCBZiFEbEOZh3FJ66NBCBVglnPzyfYrxUhjHV
         G6DKbU7VjPxACBhW4+RwaofeMd3N7lU2L3dLeJaNuyVhYJsNqzI9+Pf4XigB3iamp76Z
         Hcj/HTrpiTw/eKYeqNA/gkKKchx3A8O3vXE534hIIKmb/KBH3TMNi/4rLW8SZR7wYElh
         UzZtjqsHL5mKihJe0hKhoJEIhIV+4UxJoUA0JTMp0QP4d7s2vJ/uIhhlKx7ABTGWpvr6
         SWrQ==
X-Gm-Message-State: AOJu0YyPoxkbu0L2tQou2KIYQJ2C7S0zSRPby0Hm3yURRHiRy3KA3Xbs
	cRkOifpHlfSfHVj7obWL0YdtrOv5E2Uj1bSClnUQWjZoXcDZsHIXWVgNNATJ
X-Google-Smtp-Source: AGHT+IHA0cVSkvFQxhsz45bq94UYBFFoOUhDvSR4ke6AKnGMI050ZiplSA3W0dDcBrkctsFrwTCJSQ==
X-Received: by 2002:a05:600c:d5:b0:426:62a0:eb6b with SMTP id 5b1f17b1804b1-428e6b04666mr127820285e9.13.1723035814567;
        Wed, 07 Aug 2024 06:03:34 -0700 (PDT)
Received: from abdobngad.. ([154.182.238.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429057968d8sm29196825e9.9.2024.08.07.06.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 06:03:34 -0700 (PDT)
From: AbdAlRahman Gad <abdobngad@gmail.com>
To: git@vger.kernel.org
Cc: AbdAlRahman Gad <abdobngad@gmail.com>
Subject: [PATCH v5 7/8] t7004: use single quotes instead of double quotes
Date: Wed,  7 Aug 2024 15:58:43 +0300
Message-ID: <20240807130259.28381-8-abdobngad@gmail.com>
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

