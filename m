Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D9A16132F
	for <git@vger.kernel.org>; Wed, 29 May 2024 07:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716966283; cv=none; b=NZI03Ew4E56P8/Viji9a0lzgeGaQSe035+VEebtD7wnYZXQzBmrU2I1GAVaL2agVyE2fAJI3eBjL1wpESdbLeKUBJBoTZUL7WRrxWTwhK52/tt0PF6zOeckqnC3bceFaxk6yIt3e1I6oJc2RbAj1hk51g15JRul8Am87w7aWTI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716966283; c=relaxed/simple;
	bh=kSNssLn5S6lGUu4EoqYl362AzN0Z9SLkClAQ2miicgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W/qrk1+02BPFbSwGMSgoTfQcKLVLFAf/QqxcozY8pmtKMN8ld3rp9okJRjw2Jeu6AnORYyDHm4zT+K774kn6/3sBiJQbqxExrF2bR1kiECkVT8oZEOZ2w/YceUM9X+VabV8ryLc07KNhQ6/mk9piPevoStQMOSmGqFG11imS3yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBEgo1xS; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBEgo1xS"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3d1bdefedc0so880609b6e.1
        for <git@vger.kernel.org>; Wed, 29 May 2024 00:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716966281; x=1717571081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++G2t6HsCRl/XSEBFC/36t17LGbY11tjVUCaSDLrOKM=;
        b=KBEgo1xS4XOxGUV04HKtFScJ3mLFM5TAAeTaWcELIvSQBM4dYy9P/2LebOWglYJ5mz
         SZaYQ0PlNUkdlOFEY6EmWJAZhR/9F/A6O2xTjl5xZ6u/DKsAhaV7sD7nbu4TEtQD9LqN
         9DCAA4tOoWAx2h5agzPsW2OMuksILETg7LnS6zcAJt1cPjlsCPdRw2CTnrX20kfXNstN
         K3JkbtJSPUfSctsoXiw5tQq7MOVpdot1rLLeuzbNB/31WO8GyvQBdZhS3HUNW0fcNcdM
         4xIjFGvTkMinmqB1INPUoH8El6aQknYCX1Viur8NmRbr8vVXL8QkdCxPS838PZS3Xw4G
         gAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716966281; x=1717571081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=++G2t6HsCRl/XSEBFC/36t17LGbY11tjVUCaSDLrOKM=;
        b=sKA5c5vM8m8FFU7hlC2nl4dlscMEO5uPVdYWjpDi3z8lAbo19nQCDDKYPGHEQt4pju
         NMvZNrn9P6oOdqfg3i7Lm+r877D9pwp6hhaTlyPjFJJhMt2GSVrddBgtrNGK0ZoQ+gy8
         XTMFy42Ry6JH5gMMrWEeJTVs7PU7vNnI0FskBBo4//FQLqZ5M92m/kN3X7ikR2U8p7X+
         kY4YhF651olG89g8h/24eH4icse0Z/bEI4zBVSV6Jz/h491DloLG6k7pjVaCkZ5LNKGg
         n+NWEpAnTHg682SgKdR5LT4lLfJCUS22Tk2dK1rg3wRScGsKaYoYIVlqn6py2xuoXxok
         rs6w==
X-Gm-Message-State: AOJu0YxV61ys1a5wMhOxBaDgmIYHYVtyVKJT2xrpbErrrsGifbOlpwVP
	ATneP85BUQ0f+mFU+eih27fopZ3rtEw4wluf0uiStN9FBG4ZXxSQ3pRd8kI7NC8=
X-Google-Smtp-Source: AGHT+IHsvyN+udsgbj6J6OE0jvVIEjFsKW+qGmcl8cLbg2r+l3qdPr8Ovq7JlwPWV8K1hRmNsU6iMg==
X-Received: by 2002:a05:6808:1510:b0:3c3:de8e:5411 with SMTP id 5614622812f47-3d1a7646fb3mr18636353b6e.38.1716966280846;
        Wed, 29 May 2024 00:04:40 -0700 (PDT)
Received: from Ubuntu.. ([171.51.188.185])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-6f8fbd3ea03sm7473376b3a.39.2024.05.29.00.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 00:04:40 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [GSoC][PATCH v2 4/4] t: add test for put_be16() and improve test-case for parse_names()
Date: Wed, 29 May 2024 12:25:12 +0530
Message-ID: <20240529070341.4248-5-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240529070341.4248-1-chandrapratap3519@gmail.com>
References: <--in-reply-to=20240528113856.8348-1-chandrapratap3519@gmail.com>
 <20240529070341.4248-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

put_be16() is a function defined in reftable/basics.{c, h} for which
there are no tests in the current setup. Add a test for the same and
improve the existing test-case for parse_names().

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-basics.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/t/unit-tests/t-reftable-basics.c b/t/unit-tests/t-reftable-basics.c
index b02ca02040..8372faec8c 100644
--- a/t/unit-tests/t-reftable-basics.c
+++ b/t/unit-tests/t-reftable-basics.c
@@ -89,11 +89,13 @@ static void test_parse_names_normal(void)
 
 static void test_parse_names_drop_empty(void)
 {
-	char in[] = "a\n\n";
+	char in[] = "a\n\nb\n";
 	char **out = NULL;
 	parse_names(in, strlen(in), &out);
 	check_str(out[0], "a");
-	check(!out[1]);
+	/* simply '\n' should be dropped as empty string */
+	check_str(out[1], "b");
+	check(!out[2]);
 	free_names(out);
 }
 
@@ -123,14 +125,20 @@ static void test_common_prefix(void)
 	strbuf_release(&b);
 }
 
-static void test_u24_roundtrip(void)
+static void test_be_roundtrip(void)
 {
 	uint32_t in = 0x112233;
 	uint8_t dest[3];
 	uint32_t out;
+	/* test put_be24 and get_be24 roundtrip */
 	put_be24(dest, in);
 	out = get_be24(dest);
 	check_int(in, ==, out);
+	/* test put_be16 and get_be16 roundtrip */
+	in = 0xfef1;
+	put_be16(dest, in);
+	out = get_be16(dest);
+	check_int(in, ==, out);
 }
 
 int cmd_main(int argc, const char *argv[])
@@ -141,7 +149,7 @@ int cmd_main(int argc, const char *argv[])
 	TEST(test_binsearch(), "binary search with binsearch works");
 	TEST(test_names_length(), "names_length retuns size of a NULL-terminated string array");
 	TEST(test_names_equal(), "names_equal compares NULL-terminated string arrays");
-	TEST(test_u24_roundtrip(), "put_be24 and get_be24 work");
+	TEST(test_be_roundtrip(), "put_be24, get_be24 and put_be16 work");
 
 	return test_done();
 }
-- 
2.45.GIT

