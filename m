Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DED17C68
	for <git@vger.kernel.org>; Sun,  4 Aug 2024 07:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722755549; cv=none; b=bBzBFo5EyKx7bIhncrCyisbfxeKWY5RdRfXkcvPOVNPjdgqadB4fAYoD7p+cGX5luTMKqtFO8TYa9Z7RCI9RMlxLKx32ajLWNVjtjMfqR52xICRqwFZe9RYDdJPaxuSjAHwsreF2AYH7uHG30jHru+gkQC+8aieK51UwWGJAqkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722755549; c=relaxed/simple;
	bh=lPEGYsM4r9B/DDS2ryUgXtidzkDKslVbk5n1QHekN/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H6GaWWQWd7oX8e+e1X2bLuHwrVCTH7QloghfCqhpBTQ/2Dlu1/fwIANWVmu08TYIsrLBO1wQx2F26HYl6xno5kCdupoQnwrg4Dnos16lNiE3Xz3AYX3Yw0h82HK5StnX+Oji9DbE3C+u2TqD2967k6aT/AyerQh/ULEiNcHyYmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XwDqJ4J+; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwDqJ4J+"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-428119da952so61930785e9.0
        for <git@vger.kernel.org>; Sun, 04 Aug 2024 00:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722755546; x=1723360346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hN+iBjdl5VgJ+EDLodIxjuEzgYb5lXYzOh+5XxEOW2k=;
        b=XwDqJ4J+2m5kDmazzJZ8cnyBeb0vxAao6n1zY1BIVgZFpvjaEmqMkNCM01+D5SG1i9
         EB6A9Zm6C3nYUS3l/fVc13qIUvq7IUqztIUl7drVlONs+qej8V3x5y7x3g6cqYkHHEK7
         nI6g8pS/NJyg1Nb0PjcUgw4Jei6UwGdUeBcyRM70tzQn+T6CxiVddJ//s3mbjLwv5FQx
         tTNRe6zpcf4pRke6IUfkDs14SSfOn1NlInvriGWtI4GuHzJmuIbPEEzpGMpr0RpA7x+k
         RbHl3Wz8a2ofwFTZOn4ezzUYDpnJp40vcYOHeDWr0lrISzJ3Ew9XHSZTknYI78+Lxvxk
         00OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722755546; x=1723360346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hN+iBjdl5VgJ+EDLodIxjuEzgYb5lXYzOh+5XxEOW2k=;
        b=vSXIVhlL/OeI8iC3rjiCwX2ENJA/F5kvhJIPTCZtI1ux0XctXKpgRuJJMbgePJ4jm4
         S2wPvUe4AyOFawsxruCZ6GXup3yJ2/emuVAI3SsVPZp4tFab24ZU92SCjsHB2wcHugWP
         BCivKgmprTHZHbba6sBIYK4z7F8EwD2ZEMYHlr6Qw9UgaZVjq7kS0ObsDelRu1FaPtPi
         WGaCi7blZiXYEQrKO+MXrCRj2dhD07S/Yqat2WvqprQydsu63rs6VPR/Bl2hniD5L+WT
         Y3cvjYWlqvW1WujW5zDv3pEoOVB/rnt7SnR8v0b0t/rPV1V0pv4XM5OcDafI+EXLx01i
         267w==
X-Gm-Message-State: AOJu0YxWKaAOdC+xbSHBt+ym0By8OzctgG4AJKL7e84NygqefBkWBOkm
	G8uZUqnvyfmHeQ361eRDNcjFdKatnduo0Iqzml4Ttx8wJ34ztLsM/QWdm4LOwr8=
X-Google-Smtp-Source: AGHT+IEw8k17kuipSL8vMbbSgDRfmc1U8uAhaBJjtFmNcyu8vichIP2OmrRyfnPQeQmqEWdbewXNcQ==
X-Received: by 2002:a05:600c:5489:b0:428:1965:450d with SMTP id 5b1f17b1804b1-428e6b2f279mr56485265e9.17.1722755545970;
        Sun, 04 Aug 2024 00:12:25 -0700 (PDT)
Received: from abdobngad.. ([197.40.96.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6e3c0b7sm88477595e9.23.2024.08.04.00.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 00:12:25 -0700 (PDT)
From: AbdAlRahman Gad <abdobngad@gmail.com>
To: git@vger.kernel.org
Cc: AbdAlRahman Gad <abdobngad@gmail.com>
Subject: [PATCH v3 4/6] [Newcomer] t7004-tag: do not prepare except outside test_expect_success
Date: Sun,  4 Aug 2024 10:11:35 +0300
Message-ID: <20240804071137.30326-5-abdobngad@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240804071137.30326-1-abdobngad@gmail.com>
References: <20240804071137.30326-1-abdobngad@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

do not prepare expect outside test_expect_success

Signed-off-by: AbdAlRahman Gad <abdobngad@gmail.com>
---
 t/t7004-tag.sh | 224 +++++++++++++++++++++++++++----------------------
 1 file changed, 123 insertions(+), 101 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index cfe7653317..96aa908eaf 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -131,10 +131,10 @@ test_expect_success 'listing all tags if one exists should succeed' '
 	git tag
 '
 
-cat >expect <<EOF
-mytag
-EOF
 test_expect_success 'Multiple -l or --list options are equivalent to one -l option' '
+	cat >expect <<-\EOF &&
+	mytag
+	EOF
 	git tag -l -l >actual &&
 	test_cmp expect actual &&
 	git tag --list --list >actual &&
@@ -209,12 +209,12 @@ test_expect_success 'trying to delete an unknown tag should fail' '
 	test_must_fail git tag -d unknown-tag
 '
 
-cat >expect <<EOF
-myhead
-mytag
-EOF
 test_expect_success \
 	'trying to delete tags without params should succeed and do nothing' '
+	cat >expect <<-\EOF &&
+	myhead
+	mytag
+	EOF
 	git tag -l >actual &&
 	test_cmp expect actual &&
 	git tag -d &&
@@ -252,18 +252,18 @@ test_expect_success 'trying to delete an already deleted tag should fail' \
 
 # listing various tags with pattern matching:
 
-cat >expect <<EOF
-a1
-aa1
-cba
-t210
-t211
-v0.2.1
-v1.0
-v1.0.1
-v1.1.3
-EOF
 test_expect_success 'listing all tags should print them ordered' '
+	cat >expect <<-\EOF &&
+	a1
+	aa1
+	cba
+	t210
+	t211
+	v0.2.1
+	v1.0
+	v1.0.1
+	v1.1.3
+	EOF
 	git tag v1.0.1 &&
 	git tag t211 &&
 	git tag aa1 &&
@@ -279,62 +279,62 @@ test_expect_success 'listing all tags should print them ordered' '
 	test_cmp expect actual
 '
 
-cat >expect <<EOF
-a1
-aa1
-cba
-EOF
 test_expect_success \
 	'listing tags with substring as pattern must print those matching' '
+	cat >expect <<-\EOF &&
+	a1
+	aa1
+	cba
+	EOF
 	rm *a* &&
 	git tag -l "*a*" >current &&
 	test_cmp expect current
 '
 
-cat >expect <<EOF
-v0.2.1
-v1.0.1
-EOF
 test_expect_success \
 	'listing tags with a suffix as pattern must print those matching' '
+	cat >expect <<-\EOF &&
+	v0.2.1
+	v1.0.1
+	EOF
 	git tag -l "*.1" >actual &&
 	test_cmp expect actual
 '
 
-cat >expect <<EOF
-t210
-t211
-EOF
 test_expect_success \
 	'listing tags with a prefix as pattern must print those matching' '
+	cat >expect <<-\EOF &&
+	t210
+	t211
+	EOF
 	git tag -l "t21*" >actual &&
 	test_cmp expect actual
 '
 
-cat >expect <<EOF
-a1
-EOF
 test_expect_success \
 	'listing tags using a name as pattern must print that one matching' '
+	cat >expect <<-\EOF &&
+	a1
+	EOF
 	git tag -l a1 >actual &&
 	test_cmp expect actual
 '
 
-cat >expect <<EOF
-v1.0
-EOF
 test_expect_success \
 	'listing tags using a name as pattern must print that one matching' '
+	cat >expect <<-\EOF &&
+	v1.0
+	EOF
 	git tag -l v1.0 >actual &&
 	test_cmp expect actual
 '
 
-cat >expect <<EOF
-v1.0.1
-v1.1.3
-EOF
 test_expect_success \
 	'listing tags with ? in the pattern should print those matching' '
+	cat >expect <<-\EOF &&
+	v1.0.1
+	v1.1.3
+	EOF
 	git tag -l "v1.?.?" >actual &&
 	test_cmp expect actual
 '
@@ -345,19 +345,25 @@ test_expect_success \
 	test_must_be_empty actual
 '
 
-cat >expect <<EOF
-v0.2.1
-v1.0
-v1.0.1
-v1.1.3
-EOF
 test_expect_success \
 	'listing tags using v* should print only those having v' '
+	cat >expect <<-\EOF &&
+	v0.2.1
+	v1.0
+	v1.0.1
+	v1.1.3
+	EOF
 	git tag -l "v*" >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'tag -l can accept multiple patterns' '
+	cat >expect <<-\EOF &&
+	v0.2.1
+	v1.0
+	v1.0.1
+	v1.1.3
+	EOF
 	git tag -l "v1*" "v0*" >actual &&
 	test_cmp expect actual
 '
@@ -371,6 +377,12 @@ test_expect_success 'tag -l can accept multiple patterns' '
 # out if we're going to break this long-documented form of taking
 # multiple patterns.
 test_expect_success 'tag -l <pattern> -l <pattern> works, as our buggy documentation previously suggested' '
+	cat >expect <<-\EOF &&
+	v0.2.1
+	v1.0
+	v1.0.1
+	v1.1.3
+	EOF
 	git tag -l "v1*" -l "v0*" >actual &&
 	test_cmp expect actual
 '
@@ -1683,23 +1695,21 @@ test_expect_success 'checking that first commit is in all tags (relative)' "
 	test_must_be_empty actual
 "
 
-cat >expected <<EOF
-v2.0
-EOF
-
 test_expect_success 'checking that second commit only has one tag' "
+	cat >expected <<-\EOF &&
+	v2.0
+	EOF
 	git tag -l --contains $hash2 v* >actual &&
 	test_cmp expected actual
 "
 
-cat >expected <<EOF
-v0.2.1
-v1.0
-v1.0.1
-v1.1.3
-EOF
-
 test_expect_success 'inverse of the last test, with --no-contains' "
+	cat >expected <<-\EOF &&
+	v0.2.1
+	v1.0
+	v1.0.1
+	v1.1.3
+	EOF
 	git tag -l --no-contains $hash2 v* >actual &&
 	test_cmp expected actual
 "
@@ -1709,15 +1719,14 @@ test_expect_success 'checking that third commit has no tags' "
 	test_must_be_empty actual
 "
 
-cat >expected <<EOF
-v0.2.1
-v1.0
-v1.0.1
-v1.1.3
-v2.0
-EOF
-
 test_expect_success 'conversely --no-contains on the third commit lists all tags' "
+	cat >expected <<-\EOF &&
+	v0.2.1
+	v1.0
+	v1.0.1
+	v1.1.3
+	v2.0
+	EOF
 	git tag -l --no-contains $hash3 v* >actual &&
 	test_cmp expected actual
 "
@@ -1734,24 +1743,22 @@ test_expect_success 'creating simple branch' '
 
 hash4=$(git rev-parse HEAD)
 
-cat >expected <<EOF
-v3.0
-EOF
-
 test_expect_success 'checking that branch head only has one tag' "
+	cat >expected <<-\EOF &&
+	v3.0
+	EOF
 	git tag -l --contains $hash4 v* >actual &&
 	test_cmp expected actual
 "
 
-cat >expected <<EOF
-v0.2.1
-v1.0
-v1.0.1
-v1.1.3
-v2.0
-EOF
-
 test_expect_success 'checking that branch head with --no-contains lists all but one tag' "
+	cat >expected <<-\EOF &&
+	v0.2.1
+	v1.0
+	v1.0.1
+	v1.1.3
+	v2.0
+	EOF
 	git tag -l --no-contains $hash4 v* >actual &&
 	test_cmp expected actual
 "
@@ -1761,50 +1768,65 @@ test_expect_success 'merging original branch into this branch' '
         git tag v4.0
 '
 
-cat >expected <<EOF
-v4.0
-EOF
-
 test_expect_success 'checking that original branch head has one tag now' "
+	cat >expected <<-\EOF &&
+	v4.0
+	EOF
 	git tag -l --contains $hash3 v* >actual &&
 	test_cmp expected actual
 "
 
-cat >expected <<EOF
-v0.2.1
-v1.0
-v1.0.1
-v1.1.3
-v2.0
-v3.0
-EOF
-
 test_expect_success 'checking that original branch head with --no-contains lists all but one tag now' "
+	cat >expected <<-\EOF &&
+	v0.2.1
+	v1.0
+	v1.0.1
+	v1.1.3
+	v2.0
+	v3.0
+	EOF
 	git tag -l --no-contains $hash3 v* >actual &&
 	test_cmp expected actual
 "
 
-cat >expected <<EOF
-v0.2.1
-v1.0
-v1.0.1
-v1.1.3
-v2.0
-v3.0
-v4.0
-EOF
-
 test_expect_success 'checking that initial commit is in all tags' "
+	cat >expected <<-\EOF &&
+	v0.2.1
+	v1.0
+	v1.0.1
+	v1.1.3
+	v2.0
+	v3.0
+	v4.0
+	EOF
 	git tag -l --contains $hash1 v* >actual &&
 	test_cmp expected actual
 "
 
 test_expect_success 'checking that --contains can be used in non-list mode' '
+	cat >expected <<-\EOF &&
+	v0.2.1
+	v1.0
+	v1.0.1
+	v1.1.3
+	v2.0
+	v3.0
+	v4.0
+	EOF
 	git tag --contains $hash1 v* >actual &&
 	test_cmp expected actual
 '
 
 test_expect_success 'checking that initial commit is in all tags with --no-contains' "
+	cat >expected <<-\EOF &&
+	v0.2.1
+	v1.0
+	v1.0.1
+	v1.1.3
+	v2.0
+	v3.0
+	v4.0
+	EOF
 	git tag -l --no-contains $hash1 v* >actual &&
 	test_must_be_empty actual
 "
-- 
2.43.0

