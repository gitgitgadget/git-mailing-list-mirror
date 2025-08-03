Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A0E3207
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 01:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754184404; cv=none; b=e4wa78rSq7zh/6aLMvwXzgjyGLmSY7xFD30AMNStuSJujIzhqzNB7Om7SywtCKN56GXV8kZFWEh+NLDZl2tJakzIaoUzqnsfruMW0dYsCDHd18w1IBuzRb9MKJX0aPCPelX+NAgsPURTfm71lZCWbF16e7on6wySfT4RC45BoUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754184404; c=relaxed/simple;
	bh=Dg9zc54oMoX20/C6vF8EEob4naRHAaUNvZT4KJjPMNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ddSAGbOTArRsSfb2IhpWrbGhiDqqccJ0vRuYiUHRKM3uuVqkUOxjSQchrNMy/DClXRHYPwN/7Sjk0T/rqVZFonmHXnunqNqP784PZAQcg7teDTiNurh6ARjiIXUs3zIFyM1CEZZBmSd9SkSDeIUoLEqMAdHaz6iJmvTNsLLILrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRxPu8yG; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRxPu8yG"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e8fdbd45e10so2143419276.1
        for <git@vger.kernel.org>; Sat, 02 Aug 2025 18:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754184401; x=1754789201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MpQKir5hSSQpeiL4dFe/KN/CM50S+1/dfoVy6t6aA1I=;
        b=ZRxPu8yG3rj5EdcwBBSWobMN721w+3o7xAJNM/ozrngnEWJQv6EDrU2O3ujGg1/eAC
         Hun2JlYCGNftfcMkR8JD76Kb26BjU4c4Ll0bgol5j0Bf37cmTMMSxBQK1Nf8vSvgno25
         wyXqLq7PyabKh6mARFgIMjG8ekwjLYzUa/0SR2tkIMlT1asi51YQdfaPE97Qq3Kp5k8P
         JeFoalmy7aX6P2Oo+0ROkumAuusywSyzaS512NuYOFIgKkklCHSikQvy8ux5NWp0w8b3
         2B7neM24tISxyZsOskOTOAp5111JiudbcqaWo5v+tuL1NkqHWOWV5PkmkG3rL9pv4iIu
         pSPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754184401; x=1754789201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MpQKir5hSSQpeiL4dFe/KN/CM50S+1/dfoVy6t6aA1I=;
        b=bqfxxUY8+8RTpb+zW33HZRXl9hxklWhiLA7Yb3hO2JttoD3bCW3By4T5aS7w5tfp0T
         h/mYdnDRqWTxzqsGhMpE9+zKs4uaEdU4GqbrS4amGTdG3QdLyB6LzxvyGElpJZKParhg
         m9/Sv3ZFSQF1xUz1tggnj2hazhEZBK19A6ajW2OZQtZr/tiz/eCD/wM3BQ4vNJc99PnL
         slrwnMw185lyB08iylOhcecZPzTtE8ySg/OJ+12QjB+fBnBMxgd+7b1By+jqH5gxFVmV
         ZJzg8ZC29zSG6edCkJL9srCYrp7j+rAzwPCwJzITF54EycSMyc6lo14UcWds5lWtrk2e
         F91g==
X-Gm-Message-State: AOJu0YyPFxxdvEBMKwpK5eWfpX/7gfUy6edJz+p7nCVSnz3Vc01WlOgy
	vHIT65u6htVhLyztfsKV0qf/EmoAx7tRFJ071rQDp47flH0Qg4juTES/G8UEN+dP
X-Gm-Gg: ASbGncvCaKYDJOughdKoFBA6Wp+cD3kCBoUWVCpRDTGjl3kJuAEjQdm3QXdLPGLRDv3
	rI0Y6gxLbIynPn4hqSmPz7EhmoniZ88G2SHCJpVgiLH4tHE7qtVdI2vpYH6GgHxUw91SUc03qin
	qqNKoOccgf/Dkj8ekcPtQrKFn/L2eGaWOMXa2k8mTIEjuqwXZpGilXa4tygxde68xb2V/Q9qiKX
	rGu7WpA2bJJ5DURotu7EhaZkptHTgvk5IvwKV++w/+py7LFIS2XqidprlTWGROxNlq+rH0RUr8L
	LW0JOyLoV/J7oTZese+3fqE9n7VwnHwfLKZOpkSjg370izuJbJKWrR7aj5XO0Kc+lllKlZe1fA+
	ICfdUPsig6KvCpXi5wkcWKawxZSQ3Zw5bv2WAWocSxuT6BGyyKkh5F6W0hrknKzYuseo=
X-Google-Smtp-Source: AGHT+IGNo52rwe/fxFOb8cE8G1lym3UCndgtEFGwwzPKm6Fnc45XfIFtCO0LyJj9aHbcPpfrNPubIA==
X-Received: by 2002:a05:6902:188c:b0:e8f:d2cb:5a1b with SMTP id 3f1490d57ef6-e8ffefb8345mr287600276.13.1754184401517;
        Sat, 02 Aug 2025 18:26:41 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a8:8b00:88ae:3d99:b445:935b])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8fd38ba780sm2673602276.43.2025.08.02.18.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 18:26:41 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Usman Akinyemi <usmanakinyemi202@gmail.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Andrzej Hunt <ajrhunt@google.com>
Subject: [PATCH v2 2/3] parse-options: refactor flags for usage_with_options_internal
Date: Sat,  2 Aug 2025 21:26:03 -0400
Message-ID: <20250803012613.54086-3-ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250726165320.4039-1-ben.knoble+github@gmail.com>
References: <20250726165320.4039-1-ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When reading or editing calls to usage_with_options_internal, it is
difficult to tell what trailing "0, 0", "0, 1", "1, 0" arguments mean
(NB there is never a "1, 1" case).

Give the flags readable names to improve call-sites without changing any
behavior.

Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---

I went with a slightly more verbose approach here: Junio argued that the "0"
case is common so deserves to be short, but it's still hard IMO to tell what "0"
represents when reading only the function calls (say, in a patch with minimal
context).

Unfortunately, the deep rightward indent is also a bit challenging on my eyes :/

 parse-options.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 5224203ffe..169d76fb65 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -953,10 +953,16 @@ static void free_preprocessed_options(struct option *options)
 	free(options);
 }
 
+#define USAGE_NORMAL 0
+#define USAGE_FULL 1
+#define USAGE_TO_STDOUT 0
+#define USAGE_TO_STDERR 1
+
 static enum parse_opt_result usage_with_options_internal(struct parse_opt_ctx_t *,
 							 const char * const *,
 							 const struct option *,
-							 int, int);
+							 int full_usage,
+							 int usage_to_stderr);
 
 enum parse_opt_result parse_options_step(struct parse_opt_ctx_t *ctx,
 					 const struct option *options,
@@ -1088,7 +1094,8 @@ enum parse_opt_result parse_options_step(struct parse_opt_ctx_t *ctx,
 		}
 
 		if (internal_help && !strcmp(arg + 2, "help-all"))
-			return usage_with_options_internal(ctx, usagestr, options, 1, 0);
+			return usage_with_options_internal(ctx, usagestr, options,
+							   USAGE_FULL, USAGE_TO_STDOUT);
 		if (internal_help && !strcmp(arg + 2, "help"))
 			goto show_usage;
 		switch (parse_long_opt(ctx, arg + 2, options)) {
@@ -1129,7 +1136,8 @@ enum parse_opt_result parse_options_step(struct parse_opt_ctx_t *ctx,
 	return PARSE_OPT_DONE;
 
  show_usage:
-	return usage_with_options_internal(ctx, usagestr, options, 0, 0);
+	return usage_with_options_internal(ctx, usagestr, options,
+					   USAGE_NORMAL, USAGE_TO_STDOUT);
 }
 
 int parse_options_end(struct parse_opt_ctx_t *ctx)
@@ -1444,7 +1452,8 @@ static enum parse_opt_result usage_with_options_internal(struct parse_opt_ctx_t
 void NORETURN usage_with_options(const char * const *usagestr,
 			const struct option *opts)
 {
-	usage_with_options_internal(NULL, usagestr, opts, 0, 1);
+	usage_with_options_internal(NULL, usagestr, opts,
+				    USAGE_NORMAL, USAGE_TO_STDERR);
 	exit(129);
 }
 
@@ -1453,7 +1462,8 @@ void show_usage_with_options_if_asked(int ac, const char **av,
 				      const struct option *opts)
 {
 	if (ac == 2 && !strcmp(av[1], "-h")) {
-		usage_with_options_internal(NULL, usagestr, opts, 0, 0);
+		usage_with_options_internal(NULL, usagestr, opts,
+					    USAGE_NORMAL, USAGE_TO_STDOUT);
 		exit(129);
 	}
 }
-- 
2.48.1

