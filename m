Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E5323C367
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 12:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741781530; cv=none; b=hZi5V1QGuc+s7gwcR4tP9eTAR4FkhCELkhc1SUC99D2Tp/jZ2xjt6JajY9Ou1xbsaxgk4EjsDt9rjB576gaS65x5dOSFB0wrvS/f1ZOZQCe4vavo9RJZSncEx/W/nsNowGBN8t6EMLlYCzfeM+CDs46dn+nfmIgPCk/gYsXfUUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741781530; c=relaxed/simple;
	bh=AmGpqohk10n9xMsFTbFeFzjbdIdrY84zgDeQMlqPELQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cbdLRQapwStLH5gwYr7/KxTIbWj32etsTuwgrQ7ujsl1PEDy3pGN5qfbP1Gp7UgjcBhoK6cVvcrcnTRLN+qJqzdiG5LKhAAZtIF0b+Isw7CTE9PWuSjW2jruvLqUxSzK9HGBIuiX71BqiEVmFvjIpJ//Jx3DJx3nmAJXER/sbwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iiI5DSYo; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiI5DSYo"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-225a28a511eso25664555ad.1
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 05:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741781528; x=1742386328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/LNEYcdEalPP9PdaKoapy+ZHukH9Xk6PXQ5MRXSXYc=;
        b=iiI5DSYoRyjqcJQsi5cEDKH/W8MVs6uoW70oEOnURf+Huj+Hc5deA0PW5rSKunk8S/
         2PxTq3YoSsaht9iDiQ9IiDPV02FvCuXDOhQ4Arl+j6T18q5dcljuRUvb/K+aSYDHdIsD
         5w1AK5k/gYOCjRMAN7Pnjd/rdT9iCiZn0860FBKfEBQBsPjE/wt2bXsKb7DWpL2lX9rm
         lBZ9giUvjbesbNHaED3qcIR5lINytU3fl9IMT1l+2Hd/u/7LbrDFZB95wfb37F+2L3U7
         pb1PSjPpWb8579pWFzdcgHbY6Tj3n+phFcTAMJFitMuwUgFXDe3icAuBizQiiWmmccUy
         sqdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741781528; x=1742386328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D/LNEYcdEalPP9PdaKoapy+ZHukH9Xk6PXQ5MRXSXYc=;
        b=fZO1zAZ4jy8foph8YpP88vSTtUa8ZiLAIdv+jwE0UyioeElZs7hiJWIn9suMJMxY++
         L+HZZ/1mO53plzaLG3QO93Ld+9kjt3W2MHVxCXOMyH7Pp1USFOVMSasH8esgL2QXbzOi
         vPX0Lv8Ch1aC9qLq7OdmD60XOLMrLCpQxTtZONiBhfyvMFnC5ORCQqDjdvL9ZxXnJOHD
         B0Yd435iMN8kCVZuELFF8MI39FuTwEc9svIu6vqhsowzMrUR+N2cVGmCLWxALR94jpui
         Nlfoihjaf8zeJmK7qGEqWhNSLFh6HVJn3yKs586AjNazRr/r62llmnZS3S+yXA4wNoS2
         xN0Q==
X-Gm-Message-State: AOJu0YyyrY/SroDk9yItJNARJYXVvoynMXZ3fobZ16AqwL921kw1PQfT
	CxBHOQb9WRvIJRzEYBrUyYJYfBG0OtkcXhb7ER98l/q5E01GDK1oZxDOEQ==
X-Gm-Gg: ASbGncsGyTXLeW7gr3VmGxp+w5CcF/h7+BWd1A2aX+4eI/q6FIz8EK1K+V0BtVvn0Wo
	QRcd2si+r5BpwgrF00OCIq5sPAy3D6sSNmuw/NGMV29V7BfFzWMRpM6JyvO/e6gOq7Dv1u/X+CH
	WlvXEXXfWaPmLamEenzoYuZIRxJxgGba6xctkHeNXQNlBF0TLQikBwJPSMlDhbSJximmQeOwcNX
	CjzEHGyStmWM8+1oCHKZ9TxvhtSo/lUuASKo4rB1CSMofmxOUSkuowGdAWtNszGeTAPlP5OVhnp
	gK15P7E/dc31aOiV2fEJ5SQ/xR/P+0XaK0ymwSAV
X-Google-Smtp-Source: AGHT+IFGUj3VjKbBbcqoxNVk+tB+DAZkyba/VYhbZW6yyrZtIDPvqbkf3T2Mr0so1Oimc8z6uzCa4Q==
X-Received: by 2002:a17:902:e88a:b0:21f:6fb9:9299 with SMTP id d9443c01a7336-22428aaad15mr336895335ad.27.1741781528149;
        Wed, 12 Mar 2025 05:12:08 -0700 (PDT)
Received: from meet.. ([103.86.19.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e974fsm114469035ad.78.2025.03.12.05.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 05:12:07 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC PATCH v3 0/2] reftable: return proper error codes from block_writer_add
Date: Wed, 12 Mar 2025 17:41:46 +0530
Message-Id: <20250312121148.1879604-1-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250308133349.1591331-1-meetsoni3017@gmail.com>
References: <20250308133349.1591331-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch attempts to avoid making an assumption regarding error codes
returned by block_writer_add().

Changes since v2:
    - Split the commit into two to separate transitively called function
      updates from writer call-site adaptations
    - Made formatting improvements in comments and code for better 
      readability.
    - Modified the writer logic to flush and retry only when a specific
      error occurs, while other errors are propagated as-is.

Meet Soni (2):
  reftable: propagate specific error codes in block_writer_add()
  reftable: adapt writer code to propagate block_writer_add() errors

 reftable/block.c  | 13 ++++++------
 reftable/block.h  |  2 +-
 reftable/record.c | 53 +++++++++++++++++++++--------------------------
 reftable/writer.c | 30 ++++++++++++++++-----------
 4 files changed, 50 insertions(+), 48 deletions(-)

Range-diff against v2:
1:  7cdc7ce0ce ! 1:  6ab35d569c reftable: return proper error code from block_writer_add()
    @@ Metadata
     Author: Meet Soni <meetsoni3017@gmail.com>
     
      ## Commit message ##
    -    reftable: return proper error code from block_writer_add()
    +    reftable: propagate specific error codes in block_writer_add()
     
    -    Previously, block_writer_add() used to return generic -1, which forced
    -    an assumption about the error type. Replace these generic -1 returns in
    -    block_writer_add() and related functions with defined error codes.
    +    Previously, functions block_writer_add() and related functions returned
    +    -1 when the record did not fit, forcing the caller to assume that any
    +    failure meant the entry was too big. Replace these generic -1 returns
    +    with defined error codes.
     
    -    Reviewed all call sites to ensure they check for nonzero error returns
    -    rather than strictly -1, confirming that this change is safe.
    +    This prepares the codebase for finer-grained error handling so that
    +    callers can distinguish between a block-full condition and other errors.
     
         Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
     
    @@ reftable/block.c: uint8_t block_writer_type(struct block_writer *bw)
     -/* Adds the reftable_record to the block. Returns -1 if it does not fit, 0 on
     -   success. Returns REFTABLE_API_ERROR if attempting to write a record with
     -   empty key. */
    -+/* Adds the reftable_record to the block. Returns 0 on success and
    ++/*
    ++ * Adds the reftable_record to the block. Returns 0 on success and
     + * appropriate error codes on failure.
     + */
      int block_writer_add(struct block_writer *w, struct reftable_record *rec)
    @@ reftable/block.h: int block_writer_init(struct block_writer *bw, uint8_t typ, ui
      uint8_t block_writer_type(struct block_writer *bw);
      
     -/* appends the record, or -1 if it doesn't fit. */
    -+/* attempts to append the record. returns 0 on success or error code on failure. */
    ++/* Attempts to append the record. Returns 0 on success or error code on failure. */
      int block_writer_add(struct block_writer *w, struct reftable_record *rec);
      
      /* appends the key restarts, and compress the block if necessary. */
    @@ reftable/record.c: static int reftable_log_record_encode(const void *rec, struct
      	string_view_consume(&s, n);
      
      	return start.len - s.len;
    -
    - ## reftable/writer.c ##
    -@@ reftable/writer.c: static int writer_add_record(struct reftable_writer *w,
    - 		goto done;
    - 
    - 	/*
    --	 * Try to add the record to the writer again. If this still fails then
    --	 * the record does not fit into the block size.
    --	 *
    --	 * TODO: it would be great to have `block_writer_add()` return proper
    --	 *       error codes so that we don't have to second-guess the failure
    --	 *       mode here.
    -+	 * Try to add the record to the writer again.
    - 	 */
    - 	err = block_writer_add(w->block_writer, rec);
    --	if (err) {
    --		err = REFTABLE_ENTRY_TOO_BIG_ERROR;
    -+	if (err)
    - 		goto done;
    --	}
    - 
    - done:
    - 	return err;
-:  ---------- > 2:  a54d440dd3 reftable: adapt writer code to propagate block_writer_add() errors
-- 
2.34.1

