Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976E71E6758
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 13:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723035815; cv=none; b=RaR+ARCGQ0jaw5bc1PQVGRYGacF8nI4GDWk2jlFFNEUxzLK0Bhelu08a7AO2sOcBXQ6ZYs7ieCzoklXOgOTMGrlLd467K2BKH1vzupDMDUQVONn0R6DdIazqukXAwpZJOo24SR8znNca0gee0XthVTfSnuyZzgwHw6TY+WjcK/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723035815; c=relaxed/simple;
	bh=oFYS2aOLX0gtC4AdpzGUage+IULhVMWpeCmmgC2RoFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AOLT6E0CG+NJ3lGZCl7Lrjc+PgXZQ6Qft8vmZJQOf6Mok3Y+ediOh33yNFiplGktpjtrR1bI/s/r6uzNjJNdXsLywZ7NWuARBh5jXrx/ob8qhdUjXPLi/ErzxTq/M64tXend2GJBipyBvmhA+HtI5+p4vHnJJitXAYEbsTepAgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HScZOAN2; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HScZOAN2"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4280b3a7efaso11918445e9.0
        for <git@vger.kernel.org>; Wed, 07 Aug 2024 06:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723035812; x=1723640612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YsP+fpx6wh7dK6VZ6gajPM0W75dy7xU0B9edgo9xG4Y=;
        b=HScZOAN2+rrN8RYbxJNRnFZT7KPcyoNaC3GXRSzo2cFEo8Y3ejQOByjIj3raEEIfMu
         1WdfapJAX1OL/ZJjAmtlh/mU1dqXV3U3D7XNi/TZM7TIQ7jEYB881EyoWcNuT++EZEot
         RIU8Y+GKzR8Wv2fXtSelyTWYZWNlv2HlfO1MxedAu5UJYxuOAOojIhRclvhWwez+nMBH
         alb3OL29ZoJRpYT17lnkAQEo47YmBVLiGOnyE7yA/Np0n/P+PDxpN0lC063nbGJGtben
         0aJ5Lcot00IZZ/Tkb63ngFYVbXAnGrzAQxla+ZGMxPJTJilyaBAVvBt9+AmOsJSWIhwc
         sz+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723035812; x=1723640612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YsP+fpx6wh7dK6VZ6gajPM0W75dy7xU0B9edgo9xG4Y=;
        b=xHkKbSRuzxgOJNckAJm9E5ES0gKNBLyc51BlObvrutq0fVFi3fYfeRr1LBwpW6cWPq
         rlFaxBA0ZtaZN6JDWgeaOXwgq5GCrj1vOjTD3n4fly52iRZm04+oobDJ+2Wbs3loXH9S
         jIP4NqvVly1Jj1RnYpwQvHpC+US2ePEqIMPUIXrMufpO/CabxqmdHGzYb9UUds1CPA/3
         vCX7r8IXuzZ4gaq7Z/MjcrWSzSu7IpJa4Qo3eE03pcFWrsjql3urd/7MfeIwLCR2Nvo+
         HJqB4HVfcDEGWEiTKi/Du8JIjtvydFU0oioyS68CGF37oApJTexgR0UukGOskF60N9sC
         d7vw==
X-Gm-Message-State: AOJu0YyjACONUdbLlMeQN7g5fnve1Iu23B4XXd3i8tM4oTQBo1oHNysm
	ex4VFCEigmkE1m09TZLKbNYX0Im7SjOEV5d/9o4lrwKgD8t9VRWSJ1YtJlMf
X-Google-Smtp-Source: AGHT+IHVjrlLSQK+YqVwpbXnSmxBvunJMGTi9K8WNwmkrg+/4gqwWnYOYm2JDUeaOIdOPobwrev6gA==
X-Received: by 2002:a05:600c:1393:b0:426:65bf:5cc2 with SMTP id 5b1f17b1804b1-428e6af1af1mr129201455e9.1.1723035811469;
        Wed, 07 Aug 2024 06:03:31 -0700 (PDT)
Received: from abdobngad.. ([154.182.238.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429057968d8sm29196825e9.9.2024.08.07.06.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 06:03:31 -0700 (PDT)
From: AbdAlRahman Gad <abdobngad@gmail.com>
To: git@vger.kernel.org
Cc: AbdAlRahman Gad <abdobngad@gmail.com>
Subject: [PATCH v5 4/8] t7004: use indented here-doc
Date: Wed,  7 Aug 2024 15:58:40 +0300
Message-ID: <20240807130259.28381-5-abdobngad@gmail.com>
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

