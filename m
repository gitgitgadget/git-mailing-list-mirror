Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA80918C31
	for <git@vger.kernel.org>; Sun,  4 Aug 2024 07:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722755550; cv=none; b=uQaixLpsVLXRbIMwP5BOcjkYmI07QZ/WFHiicYBbkbYdLeysK3/eohi/edqmbGtJu6OK3JiJ+0CuavpMH1fqGp62XjQ6Q5aGTbE/7647KpdYI0smHwvR3+uv2kMCtMbjEZlfWWPyRHwfu+P3BN2pK1E7ueAM52pnEc1fg4wr3o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722755550; c=relaxed/simple;
	bh=FIc7u7PSsd+p+82+8PYzQcxeYsciFYXr2gqaBleH2kI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IdtjKr35fVvSpvw7pBajZEhH1+VFr4ha+s/bcx2QnOLJd5zI0g+/GHZOKLcFZy4jreR3zUZpFW14JyYtksOzowG5rXkZr9gYo2UwtnyZHaWcsYdqoDgMRbS/uA/rm7qa5tLsqpuSjdDIU7njNAy0bWJP05S/GeTPQlrxeDYbXw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mRXbYDUW; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRXbYDUW"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f035ae0fe0so109097061fa.3
        for <git@vger.kernel.org>; Sun, 04 Aug 2024 00:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722755547; x=1723360347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qo1R8BdgvI9wUEpxG3oBxTMVnqqDYE+Qdl1PcKH0/xc=;
        b=mRXbYDUW0c2VlLgAJ4tAqSVq0+e0nZuZ59epKgFmWO3n8PPEE0jhEG/kFGCMwN+1f8
         LsYsRzJ2JoRBUCFxHsXgEqnv5S6SHNLc5zB/QkBCuDV1gYuTE114mZ4KjLBO9dgRh44L
         FTg3hdRVgh5u75pclOs1WtfFP+l3qC6HqZ1BMnrdFCtGBpCrZy37QoJKpPYufiYTGQOq
         NqQvmsqfRljxjUmM03p7pUcslGkX2Kaw7hJpR4HuZ1fKmj3+GWzof/Dbe+s806MLRNPO
         lu8lWCdVgosQsPJNJ5eZNgNntt6dKwi7KLCmxwGKprffBEu52eTWAqiQ0yrddI1y/2Dy
         Lp1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722755547; x=1723360347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qo1R8BdgvI9wUEpxG3oBxTMVnqqDYE+Qdl1PcKH0/xc=;
        b=VPX4oJI73OVsTv4awqATxhovBak7OlHhXF7Wp2Z3HIzQ4SXqJEN/T6bhhwSHgd7K3A
         7ufIfMNDnu9giN2qR01F/GsVh0tRfjxy+Y2EyeZZQkghRAYQJE+DqkViw4Fo9n7OPdfw
         wUtCRjqv/o8y0+rejtRGzcRh1/8YGrhBQCi72wUg07U7vy1gE9PhjWU0PUYn/jqQsEmW
         gLqhDrfK2aUNHUL8ALr7bBJqjTG8JCqMkSgPcfDMK5Qg2OMGvwFExZbUX22LuWvp6l9d
         whlM/PwgWy4m1CBcUUxGRF1vtaT5ygdq9OtbITaGUzJBlZsShUcYoRxg2mL+vNfC5kki
         oQrQ==
X-Gm-Message-State: AOJu0YzclVCH5l5/LRjYR5ZQ/HQfEzsGr8GWiaOhS9KnSlAke8O6DZFu
	AUpGWDw9qk+pTCVM6U8hV0GjXDSDRYrcCsJ3SMUVlsyNxxInkC+sa9phXRw6t4I=
X-Google-Smtp-Source: AGHT+IE95rCc8WTiMQOaGNGegRMYKlOC5d12XKImvsM8O8Y3yWIbcDiiagLTSbvqvi9XHM+P98xT7A==
X-Received: by 2002:a2e:979a:0:b0:2ef:2b53:c785 with SMTP id 38308e7fff4ca-2f15ab35233mr52075661fa.41.1722755546619;
        Sun, 04 Aug 2024 00:12:26 -0700 (PDT)
Received: from abdobngad.. ([197.40.96.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6e3c0b7sm88477595e9.23.2024.08.04.00.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 00:12:26 -0700 (PDT)
From: AbdAlRahman Gad <abdobngad@gmail.com>
To: git@vger.kernel.org
Cc: AbdAlRahman Gad <abdobngad@gmail.com>
Subject: [PATCH v3 5/6] [Newcomer] t7004-tag: here-doc modernization
Date: Sun,  4 Aug 2024 10:11:36 +0300
Message-ID: <20240804071137.30326-6-abdobngad@gmail.com>
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

use <<-\EOF to indent here-doc

Signed-off-by: AbdAlRahman Gad <abdobngad@gmail.com>
---
 t/t7004-tag.sh | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 96aa908eaf..c60167d6fd 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -389,10 +389,10 @@ test_expect_success 'tag -l <pattern> -l <pattern> works, as our buggy documenta
 
 test_expect_success 'listing tags in column' '
 	COLUMNS=41 git tag -l --column=row >actual &&
-	cat >expected <<\EOF &&
-a1      aa1     cba     t210    t211
-v0.2.1  v1.0    v1.0.1  v1.1.3
-EOF
+	cat >expected <<-\EOF &&
+	a1      aa1     cba     t210    t211
+	v0.2.1  v1.0    v1.0.1  v1.1.3
+	EOF
 	test_cmp expected actual
 '
 
@@ -400,10 +400,10 @@ test_expect_success 'listing tags in column with column.*' '
 	test_config column.tag row &&
 	test_config column.ui dense &&
 	COLUMNS=40 git tag -l >actual &&
-	cat >expected <<\EOF &&
-a1      aa1   cba     t210    t211
-v0.2.1  v1.0  v1.0.1  v1.1.3
-EOF
+	cat >expected <<-\EOF &&
+	a1      aa1   cba     t210    t211
+	v0.2.1  v1.0  v1.0.1  v1.1.3
+	EOF
 	test_cmp expected actual
 '
 
@@ -414,17 +414,17 @@ test_expect_success 'listing tag with -n --column should fail' '
 test_expect_success 'listing tags -n in column with column.ui ignored' '
 	test_config column.ui "row dense" &&
 	COLUMNS=40 git tag -l -n >actual &&
-	cat >expected <<\EOF &&
-a1              Foo
-aa1             Foo
-cba             Foo
-t210            Foo
-t211            Foo
-v0.2.1          Foo
-v1.0            Foo
-v1.0.1          Foo
-v1.1.3          Foo
-EOF
+	cat >expected <<-\EOF &&
+	a1              Foo
+	aa1             Foo
+	cba             Foo
+	t210            Foo
+	t211            Foo
+	v0.2.1          Foo
+	v1.0            Foo
+	v1.0.1          Foo
+	v1.1.3          Foo
+	EOF
 	test_cmp expected actual
 '
 
-- 
2.43.0

