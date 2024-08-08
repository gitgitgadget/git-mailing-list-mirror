Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3D818EFDC
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 16:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723134840; cv=none; b=YArtOxMGZ3UOOIx75Fd74EJgE5JK5GmcjbqFC97syusYj//CyXxIgJMMtSKzCXEGwZdQh25zYntTNeyAm6QcOGdQsnl/NQVrXU5bVB1Z4C9Bn8gmSFHbA/XneTH42gRMVtuDvImdUPHxrQXdER43u3Wczz1OhUgbyVZXy/ap0YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723134840; c=relaxed/simple;
	bh=oFYS2aOLX0gtC4AdpzGUage+IULhVMWpeCmmgC2RoFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZPYpVQf73kZvSCdKFw59sDrBAyW40nhiC+qEoTLKbvMNrqw6SJ0wNPcXuTeLZ46OZHLex0ts0jsdBsBDK7jJRZq10TFrHjUqwTbS0kfvAIM3lWeu+qOtFUGFCRa1yHrpRArJuv8fIXW6HAOVgoZvXAt179oCwNV05mHQcEFnks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0Dl0UuD; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0Dl0UuD"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-368526b1333so1358101f8f.1
        for <git@vger.kernel.org>; Thu, 08 Aug 2024 09:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723134837; x=1723739637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YsP+fpx6wh7dK6VZ6gajPM0W75dy7xU0B9edgo9xG4Y=;
        b=G0Dl0UuDQPkbQ6AeM2No35R2O0laDfZf7tX9DxP7vnI3VJ4TphUTwH539Qn3GLfTsi
         n/rRMfBDdghAx1yGJqU5KMvdhbz+c4jiRKmkRi3qgGPWe9mLRZWObTWgMPrlX+5S0Hrb
         11BiRBvcfxJAPZFF4XCwRZPeFv0DgfJpMoV3Ukprp+GCgXalcxz2cytexiwKUH7q60e/
         oRW/hXu2EtY6Nk2lvZwoNzMBxqkAIo0znLdm0X5iOMUEXjTd0MO9VPox3oKbUZEi4fSM
         GYnHt47MI626vyjKWCvAuS0KKh5t7NNsLQPpVINNBGC7vhiPt6LW8uZXPg/5yMah21c6
         AzVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723134837; x=1723739637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YsP+fpx6wh7dK6VZ6gajPM0W75dy7xU0B9edgo9xG4Y=;
        b=Dzf6SlUyM3Mwrvw/X9ZSaS7WrYwXFLHuPolWe9lplDBqWjwL5cYktBe7BuauloYwmr
         zx1xwkTgDzcdigm7ARvxtV91LTFafrIXXGMTXix0+KvQpqX1PbD+MTbJT6Q34KpxNVO/
         l48FJIKtAOo4f/tYEjQmnb9e2ixp7NXJmkc4yrkNpsGfVSlZzkY1BxKEYkOUCzSadump
         qpUzNv/QxqgXCQEra2+4JtoPbF7uNHVkcENZbNVHlNf0k2ACxCY66Nh6z/axjxJ8GAwB
         hy8YHe0bG0Fcx0OSpYBOnW9udZEBsZ1V7RhG125y/58aROo07XWbkGxyx0KeeW5ealk8
         r5Vg==
X-Gm-Message-State: AOJu0YxWzJFPsXiy0aD/YpYs5UWTaPKcaAXqLRV1UC4MnVaPcCns3W1p
	xAR86ImlGDp8G1esik3IwX2BbtJ7FmitlsFJYc/+hGOy0xLTf1a8WzRwf4jP24U=
X-Google-Smtp-Source: AGHT+IEhjf10kVr02PFWs83K5CqtCEMAz62OiFIeJ070jJW9GstJgUeCdsf3nNRyu91ua+T4gyaluQ==
X-Received: by 2002:a05:6000:50:b0:360:866f:5083 with SMTP id ffacd0b85a97d-36d281d5433mr1962921f8f.32.1723134837146;
        Thu, 08 Aug 2024 09:33:57 -0700 (PDT)
Received: from abdobngad.. ([154.182.250.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d27229689sm2415765f8f.95.2024.08.08.09.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 09:33:56 -0700 (PDT)
From: AbdAlRahman Gad <abdobngad@gmail.com>
To: git@vger.kernel.org
Cc: AbdAlRahman Gad <abdobngad@gmail.com>
Subject: [PATCH v6 4/8] t7004: use indented here-doc
Date: Thu,  8 Aug 2024 19:32:03 +0300
Message-ID: <20240808163302.17521-5-abdobngad@gmail.com>
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

Use <<-\EOF instead of <<\EOF where the latter allows us to indent
the body of the here-doc.

Signed-off-by: AbdAlRahman Gad <abdobngad@gmail.com>
---
 t/t7004-tag.sh | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index a755d3be00..996020fd7c 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -387,10 +387,10 @@ test_expect_success 'tag -l <pattern> -l <pattern> works, as our buggy documenta
 
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
 
@@ -398,10 +398,10 @@ test_expect_success 'listing tags in column with column.*' '
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
 
@@ -412,17 +412,17 @@ test_expect_success 'listing tag with -n --column should fail' '
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

