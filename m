Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AF31E3CA9
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 13:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723035813; cv=none; b=uPGNFKOvwtNQeZ0Aa3yBdauL3ZV+WmwHn5fw5UMektGyBnJLQy689+czEgavv8rM4J2TxNLuCxK2iMhsbfBFiJDlJ1kNr+i8yEB4PQHeo7bCfJtQM1OhTHt+DJdQCPBlJDflr1ZmeWYExDBsYyBfVqUhQTr8Y5k3wP1x1v6w6yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723035813; c=relaxed/simple;
	bh=xKwIZVK66lsDU83PNp+xWIJYWNqMc6cT6W45zMb4u98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SJpkRnszkNRC5untrgL8pqcsLCsyZctc4a2xWIh/4tmwOf5CYssb0oeb5RlkcFaUZrAyixhnYiZ9wCpq8DqNps6fIOokQeiGyoIG5GkCxh277JZxM+vGnuN6JdtlKMSGMTmetnS6X0KPXpl+wQ2LNv4db3wmhSSgVM27XIeIUug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1EfahTZ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1EfahTZ"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42819654737so12297825e9.1
        for <git@vger.kernel.org>; Wed, 07 Aug 2024 06:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723035809; x=1723640609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JrEzJJG5ccbaqYyLJ3CO8YVIHjKscITYQpuiGCyug94=;
        b=l1EfahTZCGg8ZKNE18ineJHP9zQInA3CRWxFy9ZjwT6YB/ghFVxEgRJEStNRmzFovb
         ZZ8ONUFiY1vI07iQ7PQGuGkz8/co9LW8yLoeRNkmMHzZqOLUvQwKSY9PaWz3hMtexssp
         Yc1gf6QQomP/Fi+HMLYQd+pIsh4rYcyM47grE4mnrTtANcJmfVSwOf3ipGROurITr7bO
         kS9htLDaa23WPffpvYw5OwhRRMl06sD/Av21A6wgZf78Rvffvs1MI9zR+CboIeokzviC
         sVw263h8Wz6Mw1DsQRNd6kNcMhRnjzQ0IQEmIHvikBc2x7uJAvaLq2wdDx142UiYMSMW
         kDsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723035809; x=1723640609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JrEzJJG5ccbaqYyLJ3CO8YVIHjKscITYQpuiGCyug94=;
        b=G9AE9NU4ZsRhr+DKwzkHJsAq6XCL8OUwjevnGMjXCzX9E78yetYlmut3sojfLqJl/t
         jWSLveHVVcoLAN3EHA4p8uFsHMxOW3y0+jWo98zrDC9fscbKz1WJVGPLn9vRVBZ6Qx7C
         lD9/o6JP/QOnIm8zItyj1fMZ8LgBd05BT+CWvSxivej0X5L4qMR0lpOz+0liP771AG0j
         IOo5Ep34PCaO097VqGQOPse/aLsV0xvw40XdEKPfcD3BsA8V6ZiDjpC2RoiCsyrhfV6f
         3+CwWEFAm9K+pUEy0z2ENwPdvnDwl5AtRDqTtepYcctO66EleSDmTzSIIzzzLJff/67M
         cQ+w==
X-Gm-Message-State: AOJu0Yw90qe2iE4YXnTCJ5GU1HazB381wV6a8pKHEAOx6ayHMIEMKzP2
	PFgo3bqKI9PX9w2E19VsBQo67QzsPTDJ7Oq3FCYQ0KMBiyHsdaDSFav75ugC
X-Google-Smtp-Source: AGHT+IGIwKyUo1xk5Brf8W5nWgK7V3IndlXdHOZkE9BSJMHTtZcj1eXk6ya3SHwVGEDUIwUs4RSgIg==
X-Received: by 2002:a05:600c:3ba8:b0:426:5269:9827 with SMTP id 5b1f17b1804b1-428e6f88acfmr137862735e9.0.1723035808536;
        Wed, 07 Aug 2024 06:03:28 -0700 (PDT)
Received: from abdobngad.. ([154.182.238.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429057968d8sm29196825e9.9.2024.08.07.06.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 06:03:28 -0700 (PDT)
From: AbdAlRahman Gad <abdobngad@gmail.com>
To: git@vger.kernel.org
Cc: AbdAlRahman Gad <abdobngad@gmail.com>
Subject: [PATCH v5 1/8] t7004: remove space after redirect operators
Date: Wed,  7 Aug 2024 15:58:37 +0300
Message-ID: <20240807130259.28381-2-abdobngad@gmail.com>
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

Modernize 't7004' by removing whitespace after redirect operators.

Signed-off-by: AbdAlRahman Gad <abdobngad@gmail.com>
---
 t/t7004-tag.sh | 50 +++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index fa6336edf9..3100a4c219 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -213,9 +213,9 @@ mytag
 EOF
 test_expect_success \
 	'trying to delete tags without params should succeed and do nothing' '
-	git tag -l > actual && test_cmp expect actual &&
+	git tag -l >actual && test_cmp expect actual &&
 	git tag -d &&
-	git tag -l > actual && test_cmp expect actual
+	git tag -l >actual && test_cmp expect actual
 '
 
 test_expect_success \
@@ -269,9 +269,9 @@ test_expect_success 'listing all tags should print them ordered' '
 	git tag a1 &&
 	git tag v1.0 &&
 	git tag t210 &&
-	git tag -l > actual &&
+	git tag -l >actual &&
 	test_cmp expect actual &&
-	git tag > actual &&
+	git tag >actual &&
 	test_cmp expect actual
 '
 
@@ -283,7 +283,7 @@ EOF
 test_expect_success \
 	'listing tags with substring as pattern must print those matching' '
 	rm *a* &&
-	git tag -l "*a*" > current &&
+	git tag -l "*a*" >current &&
 	test_cmp expect current
 '
 
@@ -293,7 +293,7 @@ v1.0.1
 EOF
 test_expect_success \
 	'listing tags with a suffix as pattern must print those matching' '
-	git tag -l "*.1" > actual &&
+	git tag -l "*.1" >actual &&
 	test_cmp expect actual
 '
 
@@ -303,7 +303,7 @@ t211
 EOF
 test_expect_success \
 	'listing tags with a prefix as pattern must print those matching' '
-	git tag -l "t21*" > actual &&
+	git tag -l "t21*" >actual &&
 	test_cmp expect actual
 '
 
@@ -312,7 +312,7 @@ a1
 EOF
 test_expect_success \
 	'listing tags using a name as pattern must print that one matching' '
-	git tag -l a1 > actual &&
+	git tag -l a1 >actual &&
 	test_cmp expect actual
 '
 
@@ -321,7 +321,7 @@ v1.0
 EOF
 test_expect_success \
 	'listing tags using a name as pattern must print that one matching' '
-	git tag -l v1.0 > actual &&
+	git tag -l v1.0 >actual &&
 	test_cmp expect actual
 '
 
@@ -331,13 +331,13 @@ v1.1.3
 EOF
 test_expect_success \
 	'listing tags with ? in the pattern should print those matching' '
-	git tag -l "v1.?.?" > actual &&
+	git tag -l "v1.?.?" >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success \
 	'listing tags using v.* should print nothing because none have v.' '
-	git tag -l "v.*" > actual &&
+	git tag -l "v.*" >actual &&
 	test_must_be_empty actual
 '
 
@@ -349,7 +349,7 @@ v1.1.3
 EOF
 test_expect_success \
 	'listing tags using v* should print only those having v' '
-	git tag -l "v*" > actual &&
+	git tag -l "v*" >actual &&
 	test_cmp expect actual
 '
 
@@ -1171,7 +1171,7 @@ test_expect_success GPG \
 	git tag -v emptyfile-signed-tag
 '
 
-printf '\n\n  \n\t\nLeading blank lines\n' > sigblanksfile
+printf '\n\n  \n\t\nLeading blank lines\n' >sigblanksfile
 printf '\n\t \t  \nRepeated blank lines\n' >>sigblanksfile
 printf '\n\n\nTrailing spaces      \t  \n' >>sigblanksfile
 printf '\nTrailing blank lines\n\n\t \n\n' >>sigblanksfile
@@ -1569,7 +1569,7 @@ test_expect_success \
 
 test_expect_success \
 	'message in editor has initial comment' '
-	! (GIT_EDITOR=cat git tag -a initial-comment > actual)
+	! (GIT_EDITOR=cat git tag -a initial-comment >actual)
 '
 
 test_expect_success 'message in editor has initial comment: first line' '
@@ -1587,7 +1587,7 @@ test_expect_success \
 '
 
 get_tag_header reuse $commit commit $time >expect
-echo "An annotation to be reused" >> expect
+echo "An annotation to be reused" >>expect
 test_expect_success \
 	'overwriting an annotated tag should use its previous body' '
 	git tag -a -m "An annotation to be reused" reuse &&
@@ -1639,7 +1639,7 @@ hash3=$(git rev-parse HEAD)
 
 # simple linear checks of --continue
 
-cat > expected <<EOF
+cat >expected <<EOF
 v0.2.1
 v1.0
 v1.0.1
@@ -1679,7 +1679,7 @@ test_expect_success 'checking that first commit is in all tags (relative)' "
 	test_must_be_empty actual
 "
 
-cat > expected <<EOF
+cat >expected <<EOF
 v2.0
 EOF
 
@@ -1688,7 +1688,7 @@ test_expect_success 'checking that second commit only has one tag' "
 	test_cmp expected actual
 "
 
-cat > expected <<EOF
+cat >expected <<EOF
 v0.2.1
 v1.0
 v1.0.1
@@ -1705,7 +1705,7 @@ test_expect_success 'checking that third commit has no tags' "
 	test_must_be_empty actual
 "
 
-cat > expected <<EOF
+cat >expected <<EOF
 v0.2.1
 v1.0
 v1.0.1
@@ -1723,14 +1723,14 @@ test_expect_success 'conversely --no-contains on the third commit lists all tags
 test_expect_success 'creating simple branch' '
 	git branch stable v2.0 &&
         git checkout stable &&
-	echo foo-3.0 > foo &&
+	echo foo-3.0 >foo &&
 	git commit foo -m fourth &&
 	git tag v3.0
 '
 
 hash4=$(git rev-parse HEAD)
 
-cat > expected <<EOF
+cat >expected <<EOF
 v3.0
 EOF
 
@@ -1739,7 +1739,7 @@ test_expect_success 'checking that branch head only has one tag' "
 	test_cmp expected actual
 "
 
-cat > expected <<EOF
+cat >expected <<EOF
 v0.2.1
 v1.0
 v1.0.1
@@ -1757,7 +1757,7 @@ test_expect_success 'merging original branch into this branch' '
         git tag v4.0
 '
 
-cat > expected <<EOF
+cat >expected <<EOF
 v4.0
 EOF
 
@@ -1766,7 +1766,7 @@ test_expect_success 'checking that original branch head has one tag now' "
 	test_cmp expected actual
 "
 
-cat > expected <<EOF
+cat >expected <<EOF
 v0.2.1
 v1.0
 v1.0.1
@@ -1780,7 +1780,7 @@ test_expect_success 'checking that original branch head with --no-contains lists
 	test_cmp expected actual
 "
 
-cat > expected <<EOF
+cat >expected <<EOF
 v0.2.1
 v1.0
 v1.0.1
-- 
2.43.0

