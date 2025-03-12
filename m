Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D3324169E
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 12:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741781558; cv=none; b=Jqdeg/zVgP8GK1Zc5X3jTUoqVzb6zRxqkXh8Z8XS5bhNRyCEIKBoZsKJq/CeMF/kjVnex9aeYSIYui0RVWI0nM5UGwUicUhJlC5iG8JjccdKxJeUgQbE7qHM4o1U1xr1jEcECntTdi1ZuICD/ocl4LqRLKy7I1xU7Ys50+RUiVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741781558; c=relaxed/simple;
	bh=yQBPSsotPStEspi1DHkEG/6pxRoDROf18aOUDtYkZgo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tZiobkadyxHdlozjitEPBTnhJnPWd5GykNcO2IQL/hB30NCCPTRz1Fp+SJ3IKRNVjYgF5rzvXKH3DWnXLqPD1yB/AGZZYeakxV19srrnrdqkMQYhumbr1XedP13ndS4i81wcfPgApeVBjaxym3jdC7wQo+91MCTyjv9OZnQyAOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEF74+db; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEF74+db"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-223a7065ff8so34219215ad.0
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 05:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741781556; x=1742386356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iC6W169/P4OhPjxWli8BVFAr/29nJHKipspPllUNlt0=;
        b=cEF74+dbpckRHlOjcjrixDNXt0NGNLg32MRkRWOPSO8brYhg+PWpmd6KBNDl/VVpf2
         R8WaVSl5ed61YtbsZoltbNKyueBFAhUfjhGZDeTwY6Lt1rPRdIITKJsna72s8k+avQ0l
         CpuXGkwM0alq2T0YnqQDh5JDhOK0Ky8UzpDdviXLuXtOG17FGlB8jSTmcqJpq57Q8xQJ
         NbamnGsLn4bG7kSqeCE5ID1kE7u8EiI3rKRMFURUkUws9kmqecC3Rx3b8Ggb0YfOU4dj
         uBlRBsQdPWEa1xGvM+N1SxUWZxiZeimMcXIjlXInpLgEAl1bHJb4IoJ0IYsZktP7RqKj
         gHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741781556; x=1742386356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iC6W169/P4OhPjxWli8BVFAr/29nJHKipspPllUNlt0=;
        b=VtkdAZV5PB6KiuBxq/lsxuvlkxagwDmgPP9MnQR1brkNhtjiFNtJ/Tw3TXNRPRfQcj
         MIPZ3+DqLRJ75aUo+7PhMnzkBED6CcfrAa6te0CEi/gt0DoYGgkrHYw57GMBD6zDFADC
         N6kw8QELuyTc5DMhdqd1SAMbu85JU9Cv7EW7sap9cCMq8CC4KrTOCqL7SIvpIuRUTOft
         wd1RkPedUqCVaiCn7ckX3SnPCKfUV4WjD0udBexmGDQelhbhla/58xmjarwnZc8xBGiP
         3bRi23HmZYbU3JZX0n4qwWTI7UUrb1WVqYZyYlaHRkalEbzgsxWJcCZKOlTTEJ7o/JPS
         it7A==
X-Gm-Message-State: AOJu0YzJFGOnC6kr/M17J/YPV0ZMXJGprmgaA5vV4EmTy1L7OkEouXjg
	EymaZ2nnAdqphGxHvWTnYVKZlDEk12rz2ED+n306zJzMN7eGcsyK47WEYA==
X-Gm-Gg: ASbGncsyUGkkIR6ilfXmuThpvmzbeWVljMaAmkpe+2xtskN+YBcDGGSNO/76mpfs5NV
	jfpei8bazS6wDvSZX/BjV04c/zOJIYuXXDnJIG+hbZSKFNCZ82qVRs3OSgO0zafnq9SEOcVln8X
	A4nyxcY9qRz/8e+nm+ralNr3XimGNgqS8snW8wxfk3Xw32wLXOA94s/fxq567UibBf+jkirfNcC
	ZvHVSE+pwSJcVwCV1usQoP5stoPsma8E1GmA5yK91Q/3M9y3FJ1kxRftqbS63gYYXJRe9CboMVg
	JJHqKaxhgXWg+f8BNHhIgoNFriexxdGfcYWWGkxF
X-Google-Smtp-Source: AGHT+IF1GgbIILFNEfGz7+e3B3N/pfJgQR1beVIbEt95ZtXOgwOc0lIP17Oc0JVt98TD2jb0Ue04Lg==
X-Received: by 2002:a17:902:eb81:b0:224:1609:a74a with SMTP id d9443c01a7336-22428ab78eemr361226085ad.34.1741781555709;
        Wed, 12 Mar 2025 05:12:35 -0700 (PDT)
Received: from meet.. ([103.86.19.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e974fsm114469035ad.78.2025.03.12.05.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 05:12:35 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [PATCH v3 2/2] reftable: adapt writer code to propagate block_writer_add() errors
Date: Wed, 12 Mar 2025 17:41:48 +0530
Message-Id: <20250312121148.1879604-3-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250312121148.1879604-1-meetsoni3017@gmail.com>
References: <20250308133349.1591331-1-meetsoni3017@gmail.com>
 <20250312121148.1879604-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, writer_add_record() and write_object_record() would flush the
current block and retry appending the record whenever block_writer_add()
returned any nonzero error. This forced an assumption that every failure
meant the block was full, even when errors such as memory allocation or
I/O failures occurred.

Update the writer code to inspect the error code returned by
block_writer_add() and only flush and reinitialize the writer when the
error is REFTABLE_ENTRY_TOO_BIG_ERROR. For any other error, immediately
propagate it.

All call sites now handle various error codes returned by
block_writer_add().

Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 reftable/writer.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/reftable/writer.c b/reftable/writer.c
index f3ab1035d6..0d8181e227 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -310,11 +310,12 @@ static int writer_add_record(struct reftable_writer *w,
 	 * done. Otherwise the block writer may have hit the block size limit
 	 * and needs to be flushed.
 	 */
-	if (!block_writer_add(w->block_writer, rec)) {
-		err = 0;
+	err = block_writer_add(w->block_writer, rec);
+	if (err == 0)
 		goto done;
-	}
 
+	if (err != REFTABLE_ENTRY_TOO_BIG_ERROR)
+		goto done;
 	/*
 	 * The current block is full, so we need to flush and reinitialize the
 	 * writer to start writing the next block.
@@ -327,18 +328,11 @@ static int writer_add_record(struct reftable_writer *w,
 		goto done;
 
 	/*
-	 * Try to add the record to the writer again. If this still fails then
-	 * the record does not fit into the block size.
-	 *
-	 * TODO: it would be great to have `block_writer_add()` return proper
-	 *       error codes so that we don't have to second-guess the failure
-	 *       mode here.
+	 * Try to add the record to the writer again.
 	 */
 	err = block_writer_add(w->block_writer, rec);
-	if (err) {
-		err = REFTABLE_ENTRY_TOO_BIG_ERROR;
+	if (err)
 		goto done;
-	}
 
 done:
 	return err;
@@ -625,10 +619,22 @@ static void write_object_record(void *void_arg, void *key)
 	if (arg->err < 0)
 		goto done;
 
+	/*
+	 * Try to add the record to the writer. If this succeeds then we're
+	 * done. Otherwise the block writer may have hit the block size limit
+	 * and needs to be flushed.
+	 */
 	arg->err = block_writer_add(arg->w->block_writer, &rec);
 	if (arg->err == 0)
 		goto done;
 
+	if (arg->err != REFTABLE_ENTRY_TOO_BIG_ERROR)
+		goto done;
+
+	/*
+	 * The current block is full, so we need to flush and reinitialize the
+	 * writer to start writing the next block.
+	 */
 	arg->err = writer_flush_block(arg->w);
 	if (arg->err < 0)
 		goto done;
-- 
2.34.1

