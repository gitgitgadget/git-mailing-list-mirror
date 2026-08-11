Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF11741A77C
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 08:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786437220; cv=none; b=JD/XIwLjfXYKmG45xocGJARwNLsB5rY/dxSobzcvfF3uvahYp6BS7r0kCtxnRV0SqEy82boKqntTG3sfPMzEeDaPB8VP3dfLCG5G8u8wkfjO41rxxqG9tL9Bnu8Qfn0hMbQj+dZStG72DOA94LS7ZZX/iNimtU4WudY0UkShz/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786437220; c=relaxed/simple;
	bh=JVX1F/AadOdQDNDunVFG8DHcWW0aV4l72Fu3z2+iuXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GzoolPtegKbDxmGwkQCs3387OsUQNYAN5tZHofpRz7ohXzfej7szvI06ECDL2tgZiG9Zh++HBaEjUnCCFGLU+VyRd+kmZQM4Q+Ph3zXDd1jpW3WS6bfvKML8c0Sdn9/OQVFawgFYADgpo5h2qYlkOKZtkzsTBn73pV1eu1nRHnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p59Rnjel; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p59Rnjel"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49558ce01afso4410635e9.1
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 01:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786437217; x=1787042017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w4P4w3/xoRaac56TfcKhErmSqphJMGTq09k2248vngw=;
        b=p59RnjelGQ+mCB5cfSIvkvdP7Hlubnvp8AvCae8W6L+KouGwKd9jwmMpeLdI2bn5QR
         wKOBilwZiqGAzcdgfxWcTyJE/t3vsyo1MZzi3+cmrZj0YAEuB+Pt8nWieeZqBORslSCu
         bjFF6k3n9+swjUTTQWRiXhmz9IiXGaIDRo6zNbml/tguP3RGWG1rdwBV6nLo0MYI+Sgc
         dbQWk5f6vjE/MJL1CWjqlxOfUvq3ice6b+80OArhgvx8zRCWGUFQLlJwe5bCUjjFGymA
         VeckvYPUpK76nw+isgkujz8pUlazY0SeZ4Q6dSvEldeSsvuE3uAQSlhgXC7a2GIald8u
         2liQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786437217; x=1787042017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w4P4w3/xoRaac56TfcKhErmSqphJMGTq09k2248vngw=;
        b=TUw3HnNbsAJXU5fIkTgoXBDt0dc6G5T9UC232kVii3XnRt5YlhVRm9exhbt4KXotLK
         Wjr5OoYlj6JU247PQSRILkRyv0N/lLZxdqlqxX0hw2aYkoAZWdg9mfu9aaz83LwPS4Di
         qzUV/7z1Q3WtwQN6rFW1nl04Zh5g9Gplo0QNflbR5IodahVzXzvVFcZUPg5qTrCwZeu9
         oIwSJvFPg03g7rFqtEW0XXrENRKq+ObKwzgO8pWXJUV+4/0/VQDp2kkI2+w3Cnjc9SdW
         EHmGR9fdWpczMyVCW2sVAw2QV+LdsiDk2tKPUBVSnE3HEM26Qwb4hRa4pWQXdwAenLkp
         m2zA==
X-Gm-Message-State: AOJu0YyjMelcEONAEGmOVoeRu0TjdxAMWbPKRqq4Fvfxr3Ho3XbLDLfx
	PJ3QfwjN9onMqMtFqaPbkj7wx62DpV5+8rvDhJjTplsH2Sfc7xNUjv2H0v8duA==
X-Gm-Gg: AR+sD13ewUmBu5EFR1rxGr6TTC+zOZ5gG+izgyXrV7dorbUJkdythDj44NlWvCa/3Gc
	47kr27uRT8sdLUJzwrXRHn1Xfg9TKaaUWOatL0AHeeNpHRhKxxbO6EAPCkgRPI0Ot6uqqqLwsLq
	mCQQLRd+8oMi34CtantRBDbSd02wb3BBNNLQ0zhKzUTiJ+xVQWB6lS6Z4JyE0ep1w0xjJcuWcCI
	OLtqcqB67R8B1jbAyTUOiqxXQJBrxIXAq/RNX53kvJ/fHROqxsVjrLHVO74pziKvwmlWwJV1HOv
	wSpeVzXm1/vYDVqe2fOp69Lj9XCqdkKh5MFdD0S1U1u6rB/NaCBpLHR3fPHwlS0RYze+KTygaEG
	8k5s3/pOpOsxccRg9KqXzNr/k/0X6ysUFPf9atSYIf+oKp79WSdBvSTQ9tU1PcqfTlsDtQPuE6g
	WZ5BxJoE9U53mEDzyt1GB76TbfN7Xe69upr47t7aOd8Goefc2D9Q17wtrXylSZiwi3oU+Nz81gB
	SnNVYCzJvBK+1+RP6fdVqfEyDVulzb9kffQJzCw/033F/n4raJTZpH0UqdnNDj2vPwcLQuzJvil
	cRQ=
X-Received: by 2002:a05:600c:3b9e:b0:495:7a5a:d96c with SMTP id 5b1f17b1804b1-4997848c1d4mr25133625e9.18.1786437217031;
        Tue, 11 Aug 2026 01:33:37 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([2001:863:5c3:4d0d:8be2:b2d7:3667:a5fd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997889c302sm18728075e9.1.2026.08.11.01.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 01:33:36 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Justin Tobler <jltobler@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 04/12] fast-import: localize 'i' into the 'for' loops using it
Date: Tue, 11 Aug 2026 10:33:06 +0200
Message-ID: <20260811083314.2023489-5-christian.couder@gmail.com>
X-Mailer: git-send-email 2.55.0.530.gdb3615d990.dirty
In-Reply-To: <20260811083314.2023489-1-christian.couder@gmail.com>
References: <20260804100355.1299498-1-christian.couder@gmail.com>
 <20260811083314.2023489-1-christian.couder@gmail.com>
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

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 builtin/fast-import.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 6692f7cd81..9fc9ebe65a 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -3937,8 +3937,6 @@ int cmd_fast_import(int argc,
 		    const char *prefix,
 		    struct repository *repo)
 {
-	unsigned int i;
-
 	show_usage_if_asked(argc, argv, fast_import_usage);
 
 	reset_pack_idx_option(&pack_idx_opts);
@@ -3959,7 +3957,7 @@ int cmd_fast_import(int argc,
 	 * line to override stream data). But we must do an early parse of any
 	 * command-line options that impact how we interpret the feature lines.
 	 */
-	for (i = 1; i < argc; i++) {
+	for (int i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 		if (*arg != '-' || !strcmp(arg, "--"))
 			break;
@@ -3972,7 +3970,7 @@ int cmd_fast_import(int argc,
 	global_prefix = prefix;
 
 	rc_free = mem_pool_alloc(&fi_mem_pool, cmd_save * sizeof(*rc_free));
-	for (i = 0; i < (cmd_save - 1); i++)
+	for (unsigned int i = 0; i < (cmd_save - 1); i++)
 		rc_free[i].next = &rc_free[i + 1];
 	rc_free[cmd_save - 1].next = NULL;
 
@@ -4035,9 +4033,9 @@ int cmd_fast_import(int argc,
 
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
2.55.0.530.gdb3615d990.dirty

