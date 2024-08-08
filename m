Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC06C190489
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 16:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723134834; cv=none; b=RtNDLQfRa4a3zmualyi/0pGRQ2qPEHpS8edkBoOXtv2uubquS7CztC4xY/9S2W8VmjI2OHhSfJo7xBns7FZVaSPP0y9FxUA2bK7MNYdMvsDj/Tfpdm6WQzCtH5gHKyw5MG17Pytk1e1aPj7j07MRfwXjmCSIgtsLbj/A8FQ6QCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723134834; c=relaxed/simple;
	bh=xKwIZVK66lsDU83PNp+xWIJYWNqMc6cT6W45zMb4u98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EFYc50bghUsQ1++YptEedYdhhUzBDecM5OdmPxvNA2oxWF0MLs/fepHezmnFhv6ftkeO5Mltb9r6z7yLYXC0dOWmxbmoGsQQGFzXDA/qdGGgm6cLyONUkJa6kPgmc5hPbXzGe2r737F6ZQHy8J/8c+m3hn0/bVWMEIxF4qx130c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTow8hK6; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTow8hK6"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42816ca782dso8772905e9.2
        for <git@vger.kernel.org>; Thu, 08 Aug 2024 09:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723134831; x=1723739631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JrEzJJG5ccbaqYyLJ3CO8YVIHjKscITYQpuiGCyug94=;
        b=aTow8hK6GZNiodDOglBBK6G+C5QKV1ugn64Dzm1QWRPTb1GNtFH3jxAHtAlBY6ddK8
         sgmT/fNeqekmpmeTGbqxickzcOnF6bswKyOOwHZyq1O2YxzbJjuJbqXQoXtjl3WxJr9l
         BZuZ/1TkXsCW/Cf4QAky6uebTb88WabzJjbJP8SAW5T8pU4AJ0x/M/Hol3+TZQYoVqCG
         w9GP0GfnrL4eEhStOXDKT5g99uysHvt6uqcg0jQi1fFKvi+V6IfL534lB6as9GFFdheV
         3jkO21KUnTBxk14t1BZJ7g7po4DM7eRZsu+XRAmnU0D5Uydublw8D1NKeK2azEOvOYKP
         Ksig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723134831; x=1723739631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JrEzJJG5ccbaqYyLJ3CO8YVIHjKscITYQpuiGCyug94=;
        b=F3BQwMEWqEVR0fsOonvc5LFWuJRuSMHRqdJcdzQ+bb1fphIDSPPsH8aZiBeD5rH9uh
         noOXRIeQvPN06bH9WhCQ3Or+5vH+fV69xFxJHG+5CWy565ffxltfILRW3CMsAR5Z19iK
         hUCXTR6MCgQlHuRBniBgzPY75yoEiDHZwjR+2/kVW2nv28iYpbYzCq14r1hwXVd0CG2i
         TK3r9dZWd4ZRGlfH4OXmwaSlEoHtC6BDmlFrjEN35K90NQJmSPNuKP/CMP2WPHbms7Q3
         RtyxYMRv9v53ZMlaSUXM5cvP6k8k7nRKi8Z+jhgQFfLHvmAcVc9fGda968ANt0j4iSLM
         WlYg==
X-Gm-Message-State: AOJu0Yw5ucdB2R2Cwf1zFEhBUnVD7WB/MXLurc3Jw2vaaa+RKQfhFhyH
	yPo/rEQr6180XEtbzYebTWz1W42D6LAcVwUu3yJfs/783J1u94KFUEyUVzbBXZc=
X-Google-Smtp-Source: AGHT+IE7fiWrRhybpHOIBq29vy2/BmQNonFlurYMC+Eu4inxA4dKc3/5UHU6NYTpfCkxvS+sS55Sqw==
X-Received: by 2002:a5d:40c5:0:b0:367:f05a:8f6c with SMTP id ffacd0b85a97d-36d2760a110mr1420308f8f.57.1723134830884;
        Thu, 08 Aug 2024 09:33:50 -0700 (PDT)
Received: from abdobngad.. ([154.182.250.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d27229689sm2415765f8f.95.2024.08.08.09.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 09:33:50 -0700 (PDT)
From: AbdAlRahman Gad <abdobngad@gmail.com>
To: git@vger.kernel.org
Cc: AbdAlRahman Gad <abdobngad@gmail.com>
Subject: [PATCH v6 1/8] t7004: remove space after redirect operators
Date: Thu,  8 Aug 2024 19:32:00 +0300
Message-ID: <20240808163302.17521-2-abdobngad@gmail.com>
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

