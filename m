Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36ACC377EB8
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 16:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784220961; cv=none; b=S6RYOtt93nYHL80IZPn93yj7itrZVY8yOO+u6LcQcqBM5WIxq8hIcPygxiTdEXy2dEM60WqQ7N+ZYjTRDR/j4pgHYg9o4tt0dhlbbNbHEwuyxxHFVFeeUOD5GxZp4SyknUR1ysZ/3D96dOpcOWKzVXYvlbbgVuw69Zqet9KlbCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784220961; c=relaxed/simple;
	bh=eVWIYNViU12a5Jk1xbS3OqR9N+4nM7eYr9aIcGXnYyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QTUVdrYgq5Lu/A1xPCVLGxET19TdcUkvPiAj2IvU/Q62TwVYc0lgvurW7TnFXGCdWstZVzfUOnbWoyPfmd++TMSEqyTCh/3mqVZk84yZ7ceNVVC8LMnZ8jM5AKLSPYPZFdjm3rysW+mN7lNTleYT2kXXYQsMjkSKOEcd/pA/pNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kdek4ls5; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kdek4ls5"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c15ba5b151dso471854066b.3
        for <git@vger.kernel.org>; Thu, 16 Jul 2026 09:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784220950; x=1784825750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gFcjiu5muoHTgE5++f1Qt8X4QrkI4kBwWI8zdu+VNWA=;
        b=Kdek4ls5sQtu+DqZejysF3zlfdV9NSalcJbbpkIJ/0BQQSwoXk0Ot+X1wPtd+dyUdE
         Qpa2b8VpU0dqfBJQECloe63e8vVnhMa69fg8OogMpEV5Zth8QWvduDUsGxfZi6geVi/p
         gJ6EMlX7XRLlKFVAz3rDY6X+3NjdsiVbedOW8L33thIn6XKF/9IG6WeO+PJ/Flgu81tz
         1wU75ubDuzAXrpp/6Fqvjs02qEOuCA5UGQA/zno0CC631/vILt2zfx8T4M+lOixB9atG
         bVdW+aQySocKOHkQfhK8z/oTDScofSZfA/HcD6bhqs51U23UyCADdEUUW97JZokQhscT
         R+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784220950; x=1784825750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gFcjiu5muoHTgE5++f1Qt8X4QrkI4kBwWI8zdu+VNWA=;
        b=lWICku2wj2DiWuZzuoxp581i2CMYpjtPe4dWQj70DW8fqq3/LRTWfaUYcLNwef6H5v
         lhMg+D7K+fDCHZPSmnrMpIJUmHBElKoC9qa5dO47pSsrwd2P99XllfbkFwxUmn83JFk6
         h5K2jGZQiChTXF/Do1wFIQpNBJkrqxVh3S0XTD/YukCzj67gdiR4YzOBn9EcJD203Kjy
         eh7xUSeTvP3lQb/yTH/C71HyUT6ggtENUW/FBKBNFwT/WBTIZmMxJLRAyC8X50oleznT
         28VxV2AojRB0q05K7XlQPvr3bj7LEieabmns4BBD0SZcmNNspBWEJeynm+cOc8r0gXic
         qAiA==
X-Gm-Message-State: AOJu0Yy31QiCQFlhA9N4uVJrZUDBM/726oElNUly1or4FFeoKEAaGqUR
	/mCqUQClGsZEDcWzBbK5Ksv9yp+dErIN2J/LZETHegHqiqxMbo7uYXFWl5xwBjPtDWE=
X-Gm-Gg: AfdE7clTguNAMqh1MsOHPKQLSh9Kc3uWOHVZKAcyhn2zMAtq8L6sy25/eFur6HUD550
	NrJhdYBarECzYT4T87xsCqMHxyTeFoZX8IYWWdwQUt+4mQYdSUb1qEh28I0G7aFfSKo8LZIvBkS
	Pg8nrvuckeDSHPCdnHP5ODX0f14iVEzOuigyxqWBKrhrrhr0V8sf4A51PA+PZgJ/yygWJpxyWML
	f2hHmc0/ybfEeHSBIbu16uu9opembYrnH5AWQKttvWG092hc9yJIcLpKGUwXfIfDlhRut7YdT0V
	32lgbcOGpar/42ogqhoTRKGQ1IXuZ88GJurkmjR/aAXytato0sA/fnbVEUgFAU7q3/BG2mP61/q
	SHzD62Atq8lcpt3FoI52OVfgj1lL+gkZ+NJvDXt8gHr/X7HtcUHuKHqze1l0gkumsHE8tyLO33c
	OCcxOojGtoTpKHWSBGOS1C3PoYAwWrwcIZWZpat6xIJcHfqLcNgUFvfuIB5qMACQrLrcC+ufib8
	r8hSSBaF8va7aWu9A==
X-Received: by 2002:a17:907:7245:b0:c15:eec3:28e with SMTP id a640c23a62f3a-c161f46792fmr1149396466b.61.1784220949752;
        Thu, 16 Jul 2026 09:55:49 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69cd2937527sm5017149a12.20.2026.07.16.09.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 09:55:47 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Justin Tobler <jltobler@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 4/7] fast-import: localize 'i' into the 'for' loops using it
Date: Thu, 16 Jul 2026 18:55:14 +0200
Message-ID: <20260716165517.433849-5-christian.couder@gmail.com>
X-Mailer: git-send-email 2.55.0.185.g9120d2b5c0
In-Reply-To: <20260716165517.433849-1-christian.couder@gmail.com>
References: <20260716165517.433849-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In cmd_fast_import(), a	local variable 'i' is defined as an
`unsigned int` and then used as a loop counter in four different
`for (i = ...; i < ...; i++) { ... }` loops.

But in three out of the four cases, `unsigned int` isn't the best type
to use.

To give each loop counter the type matching its bound
(int/unsigned/size_t), let's localize 'i' into each loop that uses it.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/fast-import.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index aa656c5195..fd4e13b7ca 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -3936,8 +3936,6 @@ int cmd_fast_import(int argc,
 		    const char *prefix,
 		    struct repository *repo)
 {
-	unsigned int i;
-
 	show_usage_if_asked(argc, argv, fast_import_usage);
 
 	reset_pack_idx_option(&pack_idx_opts);
@@ -3958,7 +3956,7 @@ int cmd_fast_import(int argc,
 	 * line to override stream data). But we must do an early parse of any
 	 * command-line options that impact how we interpret the feature lines.
 	 */
-	for (i = 1; i < argc; i++) {
+	for (int i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 		if (*arg != '-' || !strcmp(arg, "--"))
 			break;
@@ -3971,7 +3969,7 @@ int cmd_fast_import(int argc,
 	global_prefix = prefix;
 
 	rc_free = mem_pool_alloc(&fi_mem_pool, cmd_save * sizeof(*rc_free));
-	for (i = 0; i < (cmd_save - 1); i++)
+	for (unsigned int i = 0; i < (cmd_save - 1); i++)
 		rc_free[i].next = &rc_free[i + 1];
 	rc_free[cmd_save - 1].next = NULL;
 
@@ -4034,9 +4032,9 @@ int cmd_fast_import(int argc,
 
 	if (show_stats) {
 		uintmax_t total_count = 0, duplicate_count = 0;
-		for (i = 0; i < ARRAY_SIZE(object_count_by_type); i++)
+		for (size_t i = 0; i < ARRAY_SIZE(object_count_by_type); i++)
 			total_count += object_count_by_type[i];
-		for (i = 0; i < ARRAY_SIZE(duplicate_count_by_type); i++)
+		for (size_t i = 0; i < ARRAY_SIZE(duplicate_count_by_type); i++)
 			duplicate_count += duplicate_count_by_type[i];
 
 		fprintf(stderr, "%s statistics:\n", argv[0]);
-- 
2.55.0.185.g9120d2b5c0

