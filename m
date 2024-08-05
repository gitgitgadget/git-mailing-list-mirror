Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2657415B55E
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 23:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722902387; cv=none; b=Zxv5F0+zbeggcB4iTI156/9YrvxWMbX/L/xx0KYwF5jr9cPDhobm7u5DvPFwpyMoenlsxwo2dNUtF7HPws4GSS9sIS5DUu8bau/aiC/mRkHCr0KZm5FT2P6f8iNoDOlbld2tKVNRm5xRc0OVkhIM7lWsCO7QIJmjx/iBU95bXB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722902387; c=relaxed/simple;
	bh=xKwIZVK66lsDU83PNp+xWIJYWNqMc6cT6W45zMb4u98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eBTeJv4aiZpyaae5DtQslONHpATCs8tVSV/6FbQH8VdimT6/xn1kZfLkG0CSgJ7JYNEe3G9yHNjaToOvuxEfFzHK5D6H2KhMlLqtK1QpkcURvGt3nfA7sPICmRAkDODodA0kfm9+kJODgzwW5OYIMvjudS6U+Hs7ScfKEEBHXRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KT3JKjpZ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KT3JKjpZ"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4280ca0791bso71497195e9.1
        for <git@vger.kernel.org>; Mon, 05 Aug 2024 16:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722902384; x=1723507184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JrEzJJG5ccbaqYyLJ3CO8YVIHjKscITYQpuiGCyug94=;
        b=KT3JKjpZvkBxhfg2f7oPGs1HbUd/UrXttENkZU7mKcOsAkEnwO2oKxwxC6d2BmR63/
         9ctRpn95XBREYKIDz+wdO+9EPR3r4rqfkqBMfqdLrM4179jNeD3dHZGg7els+m5/S6j0
         n/a+AwFeky+19B7Wod61+RCJVDbEJifDBDrn9P2WFUNtkkVlNKLQI4iJTFeh7gIM0WyR
         zG+5onSXdGxVbxRL74JqD3xCqBDM6MKGkcRDFv/1UU/pzhibcFkK/q69Qk8petAJLQZ1
         xrDfMl4H07Is8VOf7WGlClK99HZHI/9bQr7ze1wS0he9zosGSbYDZRsOwyy8op4LqCQm
         jniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722902384; x=1723507184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JrEzJJG5ccbaqYyLJ3CO8YVIHjKscITYQpuiGCyug94=;
        b=P12Ma8mqVMdyu1ujR+pbRNiy38i9sqWt6K0ZmK216SWq9FP64q6b4eLR8btduYVDgK
         Kb6EdBJVoQsLMdG/wkkN4i5VtYJeWsQ6+T8OrOG2SfvpKsdtmkznQXwudqnq3SeRqEfv
         itVSVAR9URNTDdyaPVNZKMROms7rd0jSwoSU4JdNljf67eWKzmRdn/9cUe0fr0xRTefj
         htla215i6+vriScjicwPRm5VdRbOuom+34POf+KxWCkV6eKfD+4qQx3cOneANsdHLsrw
         SbjVezSc9onRTXtkRwWJQHoVgIhHc3qTx68FxEpdIqZiKSEMIO8VZ8DlkkbKKzPdp7Z8
         voXw==
X-Gm-Message-State: AOJu0YzTD2m56wJcg0pe00qozK8EXcQJFPY7LNSp6kTD4ZE0O9zBNKFx
	wWlXsHPLBUrlkx9X7rVG2ynFBidGbKmUyXj9liJLK92Zsf8wTjqvzqEQa52r
X-Google-Smtp-Source: AGHT+IHS4JCIN5ZCjDks9Wy5hrrQJnWZy0qZGOSvFgo5maSCGqM50Hs06nCTkYhCLSl8aN1lbRH2Ow==
X-Received: by 2002:a05:600c:3587:b0:426:6ed5:fd5 with SMTP id 5b1f17b1804b1-428e6aebc45mr97389895e9.6.1722902384057;
        Mon, 05 Aug 2024 16:59:44 -0700 (PDT)
Received: from abdobngad.. ([197.40.47.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd074583sm11219065f8f.108.2024.08.05.16.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 16:59:43 -0700 (PDT)
From: AbdAlRahman Gad <abdobngad@gmail.com>
To: git@vger.kernel.org
Cc: AbdAlRahman Gad <abdobngad@gmail.com>
Subject: [PATCH v4 1/8] [Newcomer] t7004: Remove space after redirect operators
Date: Tue,  6 Aug 2024 02:59:10 +0300
Message-ID: <20240805235917.190699-2-abdobngad@gmail.com>
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

