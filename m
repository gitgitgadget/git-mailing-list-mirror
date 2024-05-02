Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52815374C2
	for <git@vger.kernel.org>; Thu,  2 May 2024 04:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714625686; cv=none; b=k6KRdgN8RDCIkGL+FeIfb9DvLXRTxuYKW9EzEmQvyIee4644iT5LaGxzuKVjKbqP7nKJcxsecUq03yHzRp2DgJ1pBcFA7KII2Rx22ufalmDSHMb+/RnMgRT5u4jpP/wYuspnAiNsIOLMlUqMFdqCF2b4M/zRWQWjGgbj8yKxGUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714625686; c=relaxed/simple;
	bh=8T+J6GkH4hjFOh0kdgWkfVP8Kv50fcLvA1QOL8zQ3xA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Sn/fGSpKZheTjNRaD5EUC4HxGaGbvBx264nOe1l0lns+NvMRpaQY24gw0GVTw6yzDHmD0gI70O5VMtXaG7WDdk2Xfh/NEhsXNYlLefOSD3oVo38MLIBdKWOEchyxctjVw05Agvi4CtBjsRe6oIcoqurDN8Yf1aoOxNOYJQV76y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ihjgDsMP; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihjgDsMP"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41bca450fa3so37388835e9.2
        for <git@vger.kernel.org>; Wed, 01 May 2024 21:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714625682; x=1715230482; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dyL7WRUnzbYgLmQBOx3pRS9AZoBS024alSRNjZT/554=;
        b=ihjgDsMPr2zHKI/bVuSlOUKjlkw5pIClN2eFliW68FZLc/FXd3N3kQ5JCrsmnVH1Nr
         UCAvVOga9+Li1dC1TVKtb/9MyIxXlRdGunFwkppWmbu/suD+HGUvwtT+AsYLfW1oSOTz
         03pdM5oFyseLURRkLaAoCfDF9cQgJfNvnvKwG8XJajef+FLzTWVa9Q0njVwR7h0qQ5sH
         ylZ7uIH0pA273ARDut0hPjZ6KSXBjynxxWues6KwxkG39c3+w1IJn5I9jZRArJJqZbr+
         shwRn0vUgSAcieHzlNP1mkSqE4/pzMien8yGVU3YPlCy+9Li3n+X0bv3XE+rs2hn7Wi+
         nJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714625682; x=1715230482;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dyL7WRUnzbYgLmQBOx3pRS9AZoBS024alSRNjZT/554=;
        b=AumPV7KGdJAQHOZ7iVq2LgKQ+vcHoV4Y+ycs2LVNfIuP4N5Pi3Gcbo7tSTXB/BofZt
         5lljKOEof489gFhihekfotBOP3iv+/0wRDm18pOsWJozTIYMWiYOuw40T4tTIbwX79cM
         BM4I9t1xAXFxddGMQDDVXT0z7HrbDItUuUVbmXgyLSIqqz1svXG/IZQthnI9EiDQ55UD
         Hg1ip+QSMQuR+hKj3OoE5V1tJxijrW4WczJcMRgv+eySQKsYPF3Hl4BaMoWMOqYLYTaO
         A9KkkU/3oSVaARzcME6Z4Wgr34hAJqX7Yaym4IH09xsZCEvadl5JxuH9e2shc3JB4lVc
         BVVg==
X-Gm-Message-State: AOJu0YxocKK4ZSWpiIj9oz4eM5rV+9xk7MoIZeRM9JHVUYdbGkRc9tAV
	ESHg4vqbFLk7i6BXkp/gd499/+v+wzhYci8FsmnQl05kWyAtNlfCfJZPqA==
X-Google-Smtp-Source: AGHT+IFbPYcakF4+2o5mNGZuFz8YEzIo4JH0Z2j7bgb0MNyyMiPSzH3FykFwW7r1zcfZoSJhl0v/dg==
X-Received: by 2002:a05:600c:510b:b0:416:2471:e102 with SMTP id o11-20020a05600c510b00b004162471e102mr3146389wms.37.1714625682310;
        Wed, 01 May 2024 21:54:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j14-20020a5d452e000000b0034dae1488ccsm248164wra.53.2024.05.01.21.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 21:54:41 -0700 (PDT)
Message-Id: <310b632ddfdeae3251c18690b1fe0b0113a602b6.1714625668.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1696.v4.git.1714625667.gitgitgadget@gmail.com>
References: <pull.1696.v3.git.1714091170.gitgitgadget@gmail.com>
	<pull.1696.v4.git.1714625667.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 02 May 2024 04:54:27 +0000
Subject: [PATCH v4 10/10] trailer unit tests: inspect iterator contents
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
    Linus Arver <linus@ucla.edu>,
    Linus Arver <linus@ucla.edu>

From: Linus Arver <linus@ucla.edu>

Previously we only checked whether we would iterate a certain (expected)
number of times.

Also check the parsed "raw", "key" and "val" fields during each
iteration.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Linus Arver <linus@ucla.edu>
---
 t/unit-tests/t-trailer.c | 161 +++++++++++++++++++++++++++++++++++----
 1 file changed, 148 insertions(+), 13 deletions(-)

diff --git a/t/unit-tests/t-trailer.c b/t/unit-tests/t-trailer.c
index 4f640d2a4b8..2ecca359d96 100644
--- a/t/unit-tests/t-trailer.c
+++ b/t/unit-tests/t-trailer.c
@@ -1,14 +1,27 @@
 #include "test-lib.h"
 #include "trailer.h"
 
-static void t_trailer_iterator(const char *msg, size_t num_expected)
+struct contents {
+	const char *raw;
+	const char *key;
+	const char *val;
+};
+
+static void t_trailer_iterator(const char *msg, size_t num_expected,
+			       struct contents *contents)
 {
 	struct trailer_iterator iter;
 	size_t i = 0;
 
 	trailer_iterator_init(&iter, msg);
-	while (trailer_iterator_advance(&iter))
+	while (trailer_iterator_advance(&iter)) {
+		if (num_expected) {
+			check_str(iter.raw, contents[i].raw);
+			check_str(iter.key.buf, contents[i].key);
+			check_str(iter.val.buf, contents[i].val);
+		}
 		i++;
+	}
 	trailer_iterator_release(&iter);
 
 	check_uint(i, ==, num_expected);
@@ -16,22 +29,26 @@ static void t_trailer_iterator(const char *msg, size_t num_expected)
 
 static void run_t_trailer_iterator(void)
 {
+
 	static struct test_cases {
 		const char *name;
 		const char *msg;
 		size_t num_expected;
+		struct contents contents[10];
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
-					tc[i].num_expected),
+					tc[i].num_expected,
+					tc[i].contents),
 		     "%s", tc[i].name);
 	}
 }
-- 
gitgitgadget
