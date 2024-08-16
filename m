Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F211C5790
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 17:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723830900; cv=none; b=N2CqINZl5uB85bFQTHh/Wv5n0ugC5toVn9uI5YVEDyB9vlx4RWf2qYI4pLhuTeSQFd4pdcSMFplIewCYp3FDnBjpIv5JPveSkaqk09/3aU0kBAd9GuEswCTRbRE30vsozRck9EW/MCtiaHgRkFuWLf4hIY2GC6BIo/wPthWI3aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723830900; c=relaxed/simple;
	bh=61cKOBkwMaN3Pb6Bz8j2jjKcVO5mWqMNJZdQ2PWxCm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EO7UiDe267GijQUB1bcF0aVFrsswKRs6kJEqunH8iFIFKTN+jt1AfYjJMYhY1hxYb0DPshvieBha7ACHTdW3j45D9BiCUv9yqhOPTjS1HdIbDz73vxdmi6NsxQuLV8OcnKpzzqX+9gtNx4TwLk03QYdl0uEMh/5UHrICb/eFXrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FoOxM3Y4; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoOxM3Y4"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70d2b921c48so1786934b3a.1
        for <git@vger.kernel.org>; Fri, 16 Aug 2024 10:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723830898; x=1724435698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x/AOHJYi9/WQuiiiDcao3F43bozZGndvsf3LEuJHY1M=;
        b=FoOxM3Y4lm4Xm8V1ralixICR06SxUTf9VtXSLy+FTbp2LYePG0m4jjV265qpiwieI8
         PIPREsXOhMgvGbE1fTA1F6mCjN6HUURXIcfIkDQrjUIyKUoQD5UD46QibMBFivlNELXw
         zifhgs7M8i94mtcACQapUof2jtSeAIJBMj3MDJMhNdyhv66Okqhmh4Woc3l3n896IijX
         CTAkMHZAwS7FgcEz20oYcN+RCCp6vAbNoDZRpPKtoWXJFAJLXt8Ge48GT8JGyRts8Km/
         uGsKx8faatMrO2iToBTjUgzU28mFkgDdawRjtEtEyurVMX5gYnVLy4uYX4JB4qq9Zu26
         zm2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723830898; x=1724435698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x/AOHJYi9/WQuiiiDcao3F43bozZGndvsf3LEuJHY1M=;
        b=fVAU43SdMbJkzJ2oVeGA2DSUZe9e85bNTEzI9v6feEFmyEKWFTjfOOXEPfiw+XCmYS
         vFHvqLPZjxpc70iw2RtZAbHULId9+6Bl92/2FVHd7lzs0hCe8Y0OTWIlmSUwQP5XsxhP
         bCW1e9TAxTUBFTUh43v2j9VTXUxizjkQYE9EwiBItEuH2IXE7jx0/gDDI/mTwEB42EzN
         gCdL7B2A0abO6VrkYnaGBC6DPuuO8zwnv/atm4OKboHxbPCoi2x5/+Z056fUDLMRPYgI
         y/f/UXPXYnWDbNkhL5bz0+TrpwCYW6CaUO+umr7zFMP2UJ4YueUesvBm22Mh4HO2Cxm0
         9UnA==
X-Gm-Message-State: AOJu0YyQcsMLjkj7wKyrwLuXufLNb7jBwBE2ZczODlehexFze6mYMrqp
	2//sC7ZaGiO/HPalfZjJTAwtv3QUMVL4yOXu03i6/TsRiTYbeg/7MKI8kg==
X-Google-Smtp-Source: AGHT+IEpxzrRrrhRxgqy5ZiPcAN2Iwu7R/cEmHWycBxTe/GRn0Rt/usR4Lyiw12GtTis1vkp9xvk6w==
X-Received: by 2002:a05:6a00:6f06:b0:710:66ca:5e83 with SMTP id d2e1a72fcca58-713c4dbec26mr3970667b3a.5.1723830898025;
        Fri, 16 Aug 2024 10:54:58 -0700 (PDT)
Received: from Ubuntu.. ([117.99.60.209])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7127af1e907sm2985600b3a.173.2024.08.16.10.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 10:54:57 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 02/11] t: harmonize t-reftable-block.c with coding guidelines
Date: Fri, 16 Aug 2024 22:55:25 +0530
Message-ID: <20240816175414.5169-3-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240816175414.5169-1-chandrapratap3519@gmail.com>
References: <20240814121122.4642-1-chandrapratap3519@gmail.com>
 <20240816175414.5169-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Harmonize the newly ported test unit-tests/t-reftable-block.c
with the following guidelines:
- Single line 'for' statements must omit curly braces.
- Structs must be 0-initialized with '= { 0 }' instead of '= { NULL }'.
- Array sizes and indices should preferably be of type 'size_t'and
  not 'int'.
- Return code variable should preferably be named 'ret', not 'n'.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-block.c | 52 ++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/t/unit-tests/t-reftable-block.c b/t/unit-tests/t-reftable-block.c
index f2b9a8a6f4..b1b238ac2a 100644
--- a/t/unit-tests/t-reftable-block.c
+++ b/t/unit-tests/t-reftable-block.c
@@ -16,20 +16,20 @@ static void t_block_read_write(void)
 {
 	const int header_off = 21; /* random */
 	char *names[30];
-	const int N = ARRAY_SIZE(names);
-	const int block_size = 1024;
-	struct reftable_block block = { NULL };
+	const size_t N = ARRAY_SIZE(names);
+	const size_t block_size = 1024;
+	struct reftable_block block = { 0 };
 	struct block_writer bw = {
 		.last_key = STRBUF_INIT,
 	};
 	struct reftable_record rec = {
 		.type = BLOCK_TYPE_REF,
 	};
-	int i = 0;
-	int n;
+	size_t i = 0;
+	int ret;
 	struct block_reader br = { 0 };
 	struct block_iter it = BLOCK_ITER_INIT;
-	int j = 0;
+	size_t j = 0;
 	struct strbuf want = STRBUF_INIT;
 
 	REFTABLE_CALLOC_ARRAY(block.data, block_size);
@@ -40,26 +40,26 @@ static void t_block_read_write(void)
 
 	rec.u.ref.refname = (char *) "";
 	rec.u.ref.value_type = REFTABLE_REF_DELETION;
-	n = block_writer_add(&bw, &rec);
-	check_int(n, ==, REFTABLE_API_ERROR);
+	ret = block_writer_add(&bw, &rec);
+	check_int(ret, ==, REFTABLE_API_ERROR);
 
 	for (i = 0; i < N; i++) {
 		char name[100];
-		snprintf(name, sizeof(name), "branch%02d", i);
+		snprintf(name, sizeof(name), "branch%02"PRIuMAX, (uintmax_t)i);
 
 		rec.u.ref.refname = name;
 		rec.u.ref.value_type = REFTABLE_REF_VAL1;
 		memset(rec.u.ref.value.val1, i, GIT_SHA1_RAWSZ);
 
 		names[i] = xstrdup(name);
-		n = block_writer_add(&bw, &rec);
+		ret = block_writer_add(&bw, &rec);
 		rec.u.ref.refname = NULL;
 		rec.u.ref.value_type = REFTABLE_REF_DELETION;
-		check_int(n, ==, 0);
+		check_int(ret, ==, 0);
 	}
 
-	n = block_writer_finish(&bw);
-	check_int(n, >, 0);
+	ret = block_writer_finish(&bw);
+	check_int(ret, >, 0);
 
 	block_writer_release(&bw);
 
@@ -68,9 +68,10 @@ static void t_block_read_write(void)
 	block_iter_seek_start(&it, &br);
 
 	while (1) {
-		int r = block_iter_next(&it, &rec);
-		check_int(r, >=, 0);
-		if (r > 0) {
+		ret = block_iter_next(&it, &rec);
+		check_int(ret, >=, 0);
+		if (ret > 0) {
+			check_int(i, ==, N);
 			break;
 		}
 		check_str(names[j], rec.u.ref.refname);
@@ -85,20 +86,20 @@ static void t_block_read_write(void)
 		strbuf_reset(&want);
 		strbuf_addstr(&want, names[i]);
 
-		n = block_iter_seek_key(&it, &br, &want);
-		check_int(n, ==, 0);
+		ret = block_iter_seek_key(&it, &br, &want);
+		check_int(ret, ==, 0);
 
-		n = block_iter_next(&it, &rec);
-		check_int(n, ==, 0);
+		ret = block_iter_next(&it, &rec);
+		check_int(ret, ==, 0);
 
 		check_str(names[i], rec.u.ref.refname);
 
 		want.len--;
-		n = block_iter_seek_key(&it, &br, &want);
-		check_int(n, ==, 0);
+		ret = block_iter_seek_key(&it, &br, &want);
+		check_int(ret, ==, 0);
 
-		n = block_iter_next(&it, &rec);
-		check_int(n, ==, 0);
+		ret = block_iter_next(&it, &rec);
+		check_int(ret, ==, 0);
 		check_str(names[10 * (i / 10)], rec.u.ref.refname);
 
 		block_iter_close(&it);
@@ -107,9 +108,8 @@ static void t_block_read_write(void)
 	reftable_record_release(&rec);
 	reftable_block_done(&br.block);
 	strbuf_release(&want);
-	for (i = 0; i < N; i++) {
+	for (i = 0; i < N; i++)
 		reftable_free(names[i]);
-	}
 }
 
 int cmd_main(int argc, const char *argv[])
-- 
2.45.GIT

