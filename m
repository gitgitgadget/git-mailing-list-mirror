Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FD6A94C
	for <git@vger.kernel.org>; Fri, 26 Apr 2024 00:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714091186; cv=none; b=RxZi41HXM0YxU9xWA9DpaRt1gNRbGILHKeqsz6Qpcr0gbDTGuapqJAD05W1+pY2R1iHjLieaUjZNUbIPTbLqvN9N8nnk0laO3/RStAeoQZSvWIyxMiol40Q7CJHglT9ZXYVktGjEmtVORwBofGV1NiJ0ejBO3g8sQLp9IWCh+A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714091186; c=relaxed/simple;
	bh=XEwo4h2UPF0xHe+PphdJ8pueiFCV9X2Wlxv5hau+1Po=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=AGiNu2Xg2VXBJb/2Q9cIxEJ4HlG4DleJGV4CCwcNQAOgZlCkRCJOu30d+D89xN1YwelCn5NVAnYgRrPdfUkOc2pwt6Uv7U6KbZvDIxO9vBEoye6+noGvH8GKVp/3q0z5N9AR/EI/x/U6Vub6nBeS7REiESrmxDdn9zuaDYcLEvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JAGG4dqd; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAGG4dqd"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41a0979b9aeso10746745e9.3
        for <git@vger.kernel.org>; Thu, 25 Apr 2024 17:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714091182; x=1714695982; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KG2dQWLoDXnXfNteqRoRZCSu+qEJ8/rYfxAqyh9y6pc=;
        b=JAGG4dqd1xzfZM8fer89E7E/HlNgB6PpOMzFODW8Ii6aY1yNmmfzrxnZdgxsdkejDO
         hAiyRV8ArULXLPh142ewzlogVlctyLBxpTklcDPuWE/6vlejjfmsrloO3mAD2QpIV3B8
         njpkcOeP93jlge+3LYXMCpcDIM+90GsGUU0PJfYHAqtl3U+xHEy/22VgavW8liE66PiM
         qApkj54644K5DZj3F+MbnPsojlj7VqdJ8ruYXl40yCtTUJeZz4MEWLvwZ2INbvP/5LCm
         0AfACl1mKfG33UQCWUSxdw6FI5fVpJUJOrkUHh5ItLr4ylm7WT05M8PD4xvjEPC0DrK2
         UekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714091182; x=1714695982;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KG2dQWLoDXnXfNteqRoRZCSu+qEJ8/rYfxAqyh9y6pc=;
        b=WctkDw7BfFY/glcrfuCGgaXsYjrvKgiZwqLdcXn0qetWeFWTGsAR9pLFdXgDvdh5LH
         JA9foO9EUr0k7gkdsGsLAspVjGiNn9VWW6H9/J+cdy+SmNaIyLYmb9mAD9GzWCtkp+FY
         1THoz9VDK5SPe4o2us5Fne+U+zGK/6my8fEIPGpt0RhFS1Emf68QI44d5rwTjchva88O
         Bu2UbSOtQv4epmBkcXuuR1gtfdQR73J3rm65rYqoR1vQA5EGUmNGy3UiyOY+voEtZSYc
         b7rN36Svvb8ccOT6pyZOUo50m8PFBkeRcmFActUqKfBskEOlMfe1pWHjsnW8xc0cyzm1
         asPQ==
X-Gm-Message-State: AOJu0Yy2/SMRxdWyVB5QeGMJv6szZTHIP/8A7P9XMBCAcNgOyN/3/BYO
	jn1FOwTiUnr5xi+6HtUsquZhcJd476zu2F5YHRzL5OZ0NJVxwqtMJXR/Rw==
X-Google-Smtp-Source: AGHT+IF3czRREvayrS9COVbX9Iz1cfCDEX0qEHTUPtdDwgdSvbFuJT4zUKy9HVgphz8cAprwwec8vw==
X-Received: by 2002:a05:600c:5252:b0:41b:13d5:7da9 with SMTP id fc18-20020a05600c525200b0041b13d57da9mr743043wmb.38.1714091182585;
        Thu, 25 Apr 2024 17:26:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d4-20020a5d6dc4000000b00341ce80ea66sm20914498wrz.82.2024.04.25.17.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 17:26:22 -0700 (PDT)
Message-Id: <4d53707f83612111a150c326bf60ec04db96f852.1714091170.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1696.v3.git.1714091170.gitgitgadget@gmail.com>
References: <pull.1696.v2.git.1713504153.gitgitgadget@gmail.com>
	<pull.1696.v3.git.1714091170.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Apr 2024 00:26:10 +0000
Subject: [PATCH v3 10/10] trailer unit tests: inspect iterator contents
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>,
    Junio C Hamano <gitster@pobox.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Josh Steadmon <steadmon@google.com>,
    "Randall S. Becker" <rsbecker@nexbridge.com>,
    Christian Couder <christian.couder@gmail.com>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Linus Arver <linus@ucla.edu>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

Previously we only checked whether we would iterate a certain (expected)
number of times.

Also check the parsed "raw", "key" and "val" fields during each
iteration.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Linus Arver <linusa@google.com>
---
 t/unit-tests/t-trailer.c | 161 +++++++++++++++++++++++++++++++++++----
 1 file changed, 148 insertions(+), 13 deletions(-)

diff --git a/t/unit-tests/t-trailer.c b/t/unit-tests/t-trailer.c
index 262e2838273..2abba913d00 100644
--- a/t/unit-tests/t-trailer.c
+++ b/t/unit-tests/t-trailer.c
@@ -1,14 +1,27 @@
 #include "test-lib.h"
 #include "trailer.h"
 
-static void t_trailer_iterator(const char *msg, size_t num_expected_objects)
+struct trailer_assertions {
+	const char *raw;
+	const char *key;
+	const char *val;
+};
+
+static void t_trailer_iterator(const char *msg, size_t num_expected_objects,
+			       struct trailer_assertions *trailer_assertions)
 {
 	struct trailer_iterator iter;
 	size_t i = 0;
 
 	trailer_iterator_init(&iter, msg);
-	while (trailer_iterator_advance(&iter))
+	while (trailer_iterator_advance(&iter)) {
+		if (num_expected_objects) {
+			check_str(iter.raw, trailer_assertions[i].raw);
+			check_str(iter.key.buf, trailer_assertions[i].key);
+			check_str(iter.val.buf, trailer_assertions[i].val);
+		}
 		i++;
+	}
 	trailer_iterator_release(&iter);
 
 	check_uint(i, ==, num_expected_objects);
@@ -16,22 +29,26 @@ static void t_trailer_iterator(const char *msg, size_t num_expected_objects)
 
 static void run_t_trailer_iterator(void)
 {
+
 	static struct test_cases {
 		const char *name;
 		const char *msg;
 		size_t num_expected_objects;
+		struct trailer_assertions trailer_assertions[10];
 	} tc[] = {
 		{
 			"empty input",
 			"",
-			0
+			0,
+			{{0}},
 		},
 		{
 			"no newline at beginning",
 			"Fixes: x\n"
 			"Acked-by: x\n"
 			"Reviewed-by: x\n",
-			0
+			0,
+			{{0}},
 		},
 		{
 			"newline at beginning",
@@ -39,7 +56,27 @@ static void run_t_trailer_iterator(void)
 			"Fixes: x\n"
 			"Acked-by: x\n"
 			"Reviewed-by: x\n",
-			3
+			3,
+			{
+				{
+					.raw = "Fixes: x\n",
+					.key = "Fixes",
+					.val = "x",
+				},
+				{
+					.raw = "Acked-by: x\n",
+					.key = "Acked-by",
+					.val = "x",
+				},
+				{
+					.raw = "Reviewed-by: x\n",
+					.key = "Reviewed-by",
+					.val = "x",
+				},
+				{
+					0
+				},
+			},
 		},
 		{
 			"without body text",
@@ -48,7 +85,27 @@ static void run_t_trailer_iterator(void)
 			"Fixes: x\n"
 			"Acked-by: x\n"
 			"Reviewed-by: x\n",
-			3
+			3,
+			{
+				{
+					.raw = "Fixes: x\n",
+					.key = "Fixes",
+					.val = "x",
+				},
+				{
+					.raw = "Acked-by: x\n",
+					.key = "Acked-by",
+					.val = "x",
+				},
+				{
+					.raw = "Reviewed-by: x\n",
+					.key = "Reviewed-by",
+					.val = "x",
+				},
+				{
+					0
+				},
+			},
 		},
 		{
 			"with body text, without divider",
@@ -63,7 +120,32 @@ static void run_t_trailer_iterator(void)
 			"Acked-by: x\n"
 			"Reviewed-by: x\n"
 			"Signed-off-by: x\n",
-			4
+			4,
+			{
+				{
+					.raw = "Fixes: x\n",
+					.key = "Fixes",
+					.val = "x",
+				},
+				{
+					.raw = "Acked-by: x\n",
+					.key = "Acked-by",
+					.val = "x",
+				},
+				{
+					.raw = "Reviewed-by: x\n",
+					.key = "Reviewed-by",
+					.val = "x",
+				},
+				{
+					.raw = "Signed-off-by: x\n",
+					.key = "Signed-off-by",
+					.val = "x",
+				},
+				{
+					0
+				},
+			},
 		},
 		{
 			"with body text, without divider (second trailer block)",
@@ -85,7 +167,22 @@ static void run_t_trailer_iterator(void)
 			 */
 			"Helped-by: x\n"
 			"Signed-off-by: x\n",
-			2
+			2,
+			{
+				{
+					.raw = "Helped-by: x\n",
+					.key = "Helped-by",
+					.val = "x",
+				},
+				{
+					.raw = "Signed-off-by: x\n",
+					.key = "Signed-off-by",
+					.val = "x",
+				},
+				{
+					0
+				},
+			},
 		},
 		{
 			"with body text, with divider",
@@ -103,7 +200,17 @@ static void run_t_trailer_iterator(void)
 			 * always ignores the divider.
 			 */
 			"Signed-off-by: x\n",
-			1
+			1,
+			{
+				{
+					.raw = "Signed-off-by: x\n",
+					.key = "Signed-off-by",
+					.val = "x",
+				},
+				{
+					0
+				},
+			},
 		},
 		{
 			"with non-trailer lines in trailer block",
@@ -125,7 +232,32 @@ static void run_t_trailer_iterator(void)
 			 * because we still want to iterate through the entire
 			 * block.
 			 */
-			4
+			4,
+			{
+				{
+					.raw = "not a trailer line\n",
+					.key = "not a trailer line",
+					.val = "",
+				},
+				{
+					.raw = "not a trailer line\n",
+					.key = "not a trailer line",
+					.val = "",
+				},
+				{
+					.raw = "not a trailer line\n",
+					.key = "not a trailer line",
+					.val = "",
+				},
+				{
+					.raw = "Signed-off-by: x\n",
+					.key = "Signed-off-by",
+					.val = "x",
+				},
+				{
+					0
+				},
+			},
 		},
 		{
 			"with non-trailer lines (one too many) in trailer block",
@@ -140,7 +272,8 @@ static void run_t_trailer_iterator(void)
 			"not a trailer line\n"
 			"not a trailer line\n"
 			"Signed-off-by: x\n",
-			0
+			0,
+			{{0}},
 		},
 		{
 			"with non-trailer lines (only 1) in trailer block, but no Git-generated trailers",
@@ -162,13 +295,15 @@ static void run_t_trailer_iterator(void)
 			"Acked-by: x\n"
 			"Acked-by: x\n"
 			"not a trailer line\n",
-			0
+			0,
+			{{0}},
 		},
 	};
 
 	for (int i = 0; i < sizeof(tc) / sizeof(tc[0]); i++) {
 		TEST(t_trailer_iterator(tc[i].msg,
-					tc[i].num_expected_objects),
+					tc[i].num_expected_objects,
+					tc[i].trailer_assertions),
 		     "%s", tc[i].name);
 	}
 }
-- 
gitgitgadget
