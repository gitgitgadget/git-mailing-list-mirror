Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CBE274B2B
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 08:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753344901; cv=none; b=tE5C2lunk0l5kd7qcB8IV5kWWRJ9OsmG/rQOKG0bodZQZK+BkJ0P+EVvG3wG9czu+Cbdk3Qa0xh+6sxwp0F2GJvH6ZuN89Qjhav7gFoaw8Y7sBMLCdj6SfS5/OvM+2VaTno9rGQg5D4wQ+ZUfE317U9fkHTVVITDZgrAJnd0at4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753344901; c=relaxed/simple;
	bh=5jRNr6q2QClBMySbwgcdSysaE9b3vLpfo27DcCl1O40=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ry6pKIw9GlqRPh2YQLRTbQB6fQpNrufkpAfW7qjX16VweuSjrumZ2+z52+t3acWJSl95FT08sLkDtbFy2HB4y+qkRZ6x5tkk4PwIz8xaOhJV2fcMcQtBZ+HoGeTNNFfNZQuLWzepEorwfNZ7gpSZx9AnRKDVx3N6Fa1sVmk18tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJ3daxVf; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJ3daxVf"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-451d54214adso4264785e9.3
        for <git@vger.kernel.org>; Thu, 24 Jul 2025 01:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753344898; x=1753949698; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iTJT+OnrmcyFRdiQsNzSAEUQNIUIdNuIhE74sl95jMg=;
        b=YJ3daxVft3dCYDxsEc+UVfpnwglE0mt6nB6IucOT5aPirrz6I7oCpD8dodhMXhPUoE
         LZUEoIuDrqPkiuHF2R44ceOL+zq7J1wJguShVDXHxBh7rWAx49AOsO0/QGDeZrN1UMd4
         PdgPDwnstdsNhQ4a9Eegs1S6pRueTm+WfQM4l12cj+zWixwA4DajTbC4sAEy0oKs56ZK
         0B6MvDKXnPhNBBABJMauKwX+1Tkf4++vzHKEgxxI60lYLuLBJb+2swB5rvoudi6U3MI4
         rw9jC8zLUtPXKzB/0TeBS4uT/NEfO2RougBtr5QH9RcF6cO0dzBvSTSA+i/4dbM5LqyG
         D0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753344898; x=1753949698;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iTJT+OnrmcyFRdiQsNzSAEUQNIUIdNuIhE74sl95jMg=;
        b=ntfrGVqX94B7g/DAP311LhVunKLV4wieaIz4++6dW0/MY1WvIjbNQiWQjwLGX8X1l8
         Ma1agvYFhaq3/XSL7yP9iS0qcK4YYtwDm4xLyZzGmn3fnz/Z+peEFXNlrU/lOOQOygjd
         wRnsJMQBhfmXRzsbZsK3CMjznZEC3E9PNMZmJO8uiQIqWNSfZvHkxikZmmR7gYiscQS0
         whGyp9l/JnqgSCeLSCWXZnT4TnSA0c8fJDtFMIeTBDuopmuGJdu6wN8U+a+PqvwOwep9
         K5AbgyWNn0HAG1W3Ji74F1NMcwR5JKUcOQrovE28zfl8c6CwiqDAlCM4nWgc+JWWMc08
         TrJg==
X-Gm-Message-State: AOJu0Yx2JOArTWS2/r8s5MKMMx0v8GjNjLpFhAkS7maZCrrzVbZBO2Ld
	ImEIWpEJVGCg7bQtq3AXPQLQC60W43M4gR8epBR2M1YE/QNzpSxb4obVQkeJ/ICx
X-Gm-Gg: ASbGncuuhIkjJ4WuLzRzV2m+Vccy+OQ2VU6KZ4jVQymMptpMq40WtlofEVLVyaBQIew
	mNNIJefzyRgs/tGBcKVvhSZ+QcEu8qiQ0OxQ9WtNG0OkkdDbykh/np6ZmVt7dz5Q6aickGEU99Z
	7pkhu9jcMG0VVTT77cMVPtAbGxeWQ/Lf67DP68i/LYMiq7bpuzRLpv6edXytU02Op0GywbHGGfR
	mN0IqXYakVbJ10WgrwrQA4fdW4J4Hmh1RoGE5V6Bfq6Xua6ANcjH5cCGVprf3gzeLmyJrmaLvI/
	sjZR0FgMDUlf+Dd0H+u6dKYokFi+cYHohgGwMWTATsO/lnMI68E/iADdMjTcrVk8Pe6XBsX9ZKs
	=
X-Google-Smtp-Source: AGHT+IHQqYY584elAwvzro6sw19Mu1ZqxYXI9v4rZdoZ1Pj90DEfhUjYAHBuvpSovANtGx1L30s+kg==
X-Received: by 2002:a05:600c:4e56:b0:442:dc75:5625 with SMTP id 5b1f17b1804b1-45868c7afbbmr50356545e9.5.1753344897474;
        Thu, 24 Jul 2025 01:14:57 -0700 (PDT)
Received: from [127.0.0.2] ([82.163.201.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4586e7d1326sm14678865e9.0.2025.07.24.01.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 01:14:57 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 24 Jul 2025 10:14:44 +0200
Subject: [PATCH 3/5] for-each-ref: reword the documentation for
 '--start-after'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250724-kn-small-cleanups-v1-3-0c70f591de3e@gmail.com>
References: <20250724-kn-small-cleanups-v1-0-0c70f591de3e@gmail.com>
In-Reply-To: <20250724-kn-small-cleanups-v1-0-0c70f591de3e@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2068; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=5jRNr6q2QClBMySbwgcdSysaE9b3vLpfo27DcCl1O40=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGiB633EUkAB1TiKilS3P5JzPRUbbP8MYdPds
 eBPb9vre80SAokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoget9AAoJED7VnySO
 Rox/OnoL/A311dIiFNtXHBaBZukwiAJ2CJxte0/4ukPrwosb+0miSF7oDNvDJlx3py3C/OCPCb9
 YP+ozrCu0c1CCrbeaLwcoVlvJuzkJMVJgE660rt1Otji/YQTtKd3W/M3uShjmkFMRiInHmeLGEQ
 x8y5yPDQoj/iJ9AOgatZ0V1LLGeJgVKi1/VNtj0ANCyg8zMSMOnagHass5fGbzIKh10KzPuVB7f
 dk6FaRHxRACP4pMtathEv3SoymclWIrDgMJd61GRyW3jAbCch9RfiOl+YZ2/vBEt17iUMbXfnB4
 e86GH1Ioz/K6bZTtFKl86x8GbnfTFjGOE2QcYsejL2dQQmlmc/xfbkm2CUq2U95MaRaeKmNDQG8
 lfOdWw3JBU/RKuEky6LhinL91fcAnY0z1oXd9TCJeAlZPp4XEAsErKkkDBFmCdt85a6xpQrprZ9
 MWp5jGtxZIZnM5tt/iz8mnuEeQilPi/+s80aV/AeTwk75MY+2O61y7URnLAUIKKV3JFr1gyzDy3
 yo=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The documentation for '--start-after' states that the flag cannot be
used with general pattern matching. This is a bit vague, since there is
no clear understanding about what 'general' means here. Rewrite the
sentence to be more specific.

While here, fix a typo in the 'OPT_STRING'.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.adoc | 3 ++-
 builtin/for-each-ref.c              | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-for-each-ref.adoc b/Documentation/git-for-each-ref.adoc
index a170de4209..48af302a6f 100644
--- a/Documentation/git-for-each-ref.adoc
+++ b/Documentation/git-for-each-ref.adoc
@@ -114,7 +114,8 @@ TAB %(refname)`.
     deleted, modified or added between invocations. Output will only yield those
     references which follow the marker lexicographically. Output begins from the
     first reference that would come after the marker alphabetically. Cannot be
-    used with general pattern matching or custom sort options.
+    used with `--sort=<key>` or `--stdin` options, or the _<pattern>_ argument(s)
+    to limit the refs.
 
 FIELD NAMES
 -----------
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 3f21598046..79a79212c9 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -45,7 +45,7 @@ int cmd_for_each_ref(int argc,
 		OPT_GROUP(""),
 		OPT_INTEGER( 0 , "count", &format.array_opts.max_count, N_("show only <n> matched refs")),
 		OPT_STRING(  0 , "format", &format.format, N_("format"), N_("format to use for the output")),
-		OPT_STRING(  0 , "start-after", &filter.start_after, N_("start-start"), N_("start iteration after the provided marker")),
+		OPT_STRING(  0 , "start-after", &filter.start_after, N_("start-after"), N_("start iteration after the provided marker")),
 		OPT__COLOR(&format.use_color, N_("respect format colors")),
 		OPT_REF_FILTER_EXCLUDE(&filter),
 		OPT_REF_SORT(&sorting_options),

-- 
2.49.0

