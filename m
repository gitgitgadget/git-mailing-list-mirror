Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB791CCEE2
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 15:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742398191; cv=none; b=j8CNtexs0ch4BFGoAL9IADID6ZvLJBMkJx5ckMEzXtDUJgtyg+Ue5CLqCtBcJLnhibh992IA6Ucrs+pCcOtXxRsgqcGj5wmWY1g7aVR1LCOJeHiQ+jaJvzionKYRsCrfQM2WsTsrTr3MuwLPBXZ+7O2p1ujQvFZalmV6bcTiqnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742398191; c=relaxed/simple;
	bh=xCsELOKJo2yITodFA7dw4PRpeGmlM6nRVS4bmwdVDzc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HrD4SyuONDvr42bk13LBWZug81hZcfyrGB1YFN0rQ91vqWFDhjFCtmLx23rSbvsyBnys8+J3K9XK0XWA+9dNl7S12aDGMX/m+22F1kP4jkS37vsviOCQncQzYA++l39nx3U5D7E4qkwtQoLQ/ssp66Y3FIq061UK1qOUt0hkV80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bR/leRQc; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bR/leRQc"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2235189adaeso18625825ad.0
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 08:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742398188; x=1743002988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NdQ5HRVrF38ciU+o2i2T+yki11qh40uKQL0iG8b5D0U=;
        b=bR/leRQcKUB/yQoVCQmV+3AF+N2BcdVj/qoTi73lfapkfk7Om+eEJiB9A26Lr1AD26
         AgTQtwsNNiCUQpAvW3/34fyiLEkj6Vw+NoU6yNaQrcagElLBW4Ahvr0rfESWVXxRiQ/g
         1JgYh7ATi7dh3LGQ9HkVy1ahd7w+9FsTAB8+oOLx51kIyVliIoZIXJ3XC+UcWhX2Ejhg
         pRm6CTlsREPND/8/VxiTKJbch7GNv9ZcRGfjVYr0p8U4FcCRUMyAB701ZjOkiRCVsby6
         AOa3od8lYuMhRV+Ki5ZB29REDe/Vf541FA9V/lyUa27QSbiFeOMFFcsOF/MdRsGO6PYW
         gnaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742398188; x=1743002988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NdQ5HRVrF38ciU+o2i2T+yki11qh40uKQL0iG8b5D0U=;
        b=dF0Lr6l1ny/cqeRMV5mfIxmEMlNBHHbGGPHDe/c0rHA9vK6LW3ArX2oianrCF3lPMt
         sRnR8aYyWGqF50mop8Hj9gGq5lbiI/fQPT53puRj8VQMRa1p3yIx1dPlPf4+vLBmoPBQ
         KjsDZ6jn6YTT1nkM7psyazD8kxdZ+fFXc3AHJMpcftGy6b4OmyOjBRlraJkICdhjejGh
         LuWUzQwGvw7E0jcNgYPIuw1CaJVRi5L6BUlD+EBC06raCtDDmY9MkWs006i2rQfVBQ0J
         Vbo5IJxxEg8Y1uRbmKdu7rh/U7Mq2NOnqbxtJVVRnSYXAY51x8FOlTWkZ5TRvrdT8bz5
         pWfA==
X-Gm-Message-State: AOJu0Yx3QK/tTwY9bP7tUwCkdSr/OL2pEiiIzF3MPjEhAEdK/6tJXyws
	tDDqKbtOnP62Fh1AxMnDk3gfFUpTEmZUoNu/lAFuVeWE/jYE/wmaQ0bOTg==
X-Gm-Gg: ASbGncuPFJDGRfZgw4UduCYbNQ/Zlb1KvJner6vB62vAK/U8iII2+y79Zw54a6y9gvC
	I8hh38JioGkZZxmWcPWULsidderX0JiBr3uKbd/QtotfyEZZrY5hw+XukJiFTHULrex7NpmoJSb
	bIWiMY82BxA3YGIj5cRKQgETY+ctWeAwQFBTKPQnbVt5S0t4CaAxwuIyMoh0zgUbv+gd7lbltmf
	gr/xR9QViKfVBbJLpqvOPem1Itx/zztXw0JiVQJWyd8dMvEDpmU5IIZg0yh8tEnPnvgB2CKGmEX
	Vijdr4HtJOepQpFPhwIW5FtttP56kvrQrcVprJxO
X-Google-Smtp-Source: AGHT+IGzXDSg7GFoYtnMhQ2GjDaGz0sqykcQYCw3ayMv0GG3eruaDBWAihSMG2WjRcz3nnQWUySEjQ==
X-Received: by 2002:a17:902:f610:b0:21f:58fd:d215 with SMTP id d9443c01a7336-2262c9bf151mr125733875ad.11.1742398188497;
        Wed, 19 Mar 2025 08:29:48 -0700 (PDT)
Received: from meet.. ([103.86.19.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a6865sm115889305ad.75.2025.03.19.08.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 08:29:48 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC PATCH v5 2/3] reftable: adapt writer_add_record() to propagate block_writer_add() errors
Date: Wed, 19 Mar 2025 20:59:26 +0530
Message-Id: <20250319152927.1263033-3-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250319152927.1263033-1-meetsoni3017@gmail.com>
References: <20250319075943.28904-1-meetsoni3017@gmail.com>
 <20250319152927.1263033-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, writer_add_record() would flush the current block and retry
appending the record whenever block_writer_add() returned any nonzero
error. This forced an assumption that every failure meant the block was
full, even when errors such as memory allocation or I/O failures occurred.

Update the writer_add_record() to inspect the error code returned by
block_writer_add() and only flush and reinitialize the writer when the
error is REFTABLE_ENTRY_TOO_BIG_ERROR. For any other error, immediately
propagate it.

Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 reftable/writer.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/reftable/writer.c b/reftable/writer.c
index f3ab1035d6..94c97b7ac0 100644
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
@@ -329,16 +330,10 @@ static int writer_add_record(struct reftable_writer *w,
 	/*
 	 * Try to add the record to the writer again. If this still fails then
 	 * the record does not fit into the block size.
-	 *
-	 * TODO: it would be great to have `block_writer_add()` return proper
-	 *       error codes so that we don't have to second-guess the failure
-	 *       mode here.
 	 */
 	err = block_writer_add(w->block_writer, rec);
-	if (err) {
-		err = REFTABLE_ENTRY_TOO_BIG_ERROR;
+	if (err)
 		goto done;
-	}
 
 done:
 	return err;
-- 
2.34.1

