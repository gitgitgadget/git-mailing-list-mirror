Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F419732B9AA
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 19:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762890168; cv=none; b=lX8rp8hvF6GvRUxcOStSX/Mce5BppEBaoFRicV3naDDaXScu4p4qL2Gazdn6+ZXuyoRF+3uKPkIykbSs7qM0M0nV7jkvfFIPzByPm+pEY0UH7AovYkmVuFsrOwmlaZFkDHhvH3/mvUD2FKt2XclHVQERCxgJYMDvf1uVY6B2TzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762890168; c=relaxed/simple;
	bh=igD3hAxGie9YL+jKOBBWZMT22QZa44cT77PLes3EIPU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VLXDrYLbs8p6u6EiTVuYu4HSl8OCcuIiqxAnWbyBJLOx/ThA21F1M5DN/nPpeNJIlrEWn1z7heac9xFeWjxaiJEboWgqY70xT9nObuUpoMO94gZfREPtBN+vIJtEHXf8hUWOEMt56KLwO+z+KMIPVpjaRyM7WWbq3XwQC0MmYaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZuUDIPuU; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZuUDIPuU"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-882475d8851so766096d6.2
        for <git@vger.kernel.org>; Tue, 11 Nov 2025 11:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762890166; x=1763494966; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6pAtM5xfeydKbpMgA4il9zMudvZmNqj0FuhX+2OXGek=;
        b=ZuUDIPuUmPuJbEbTUz/IT001hUrkSrqf0N5UVlP7j/sR4JUiITT/35Bz96q9D5Zn9n
         JkReI2dvkRiQONxQBuF1dcaCFi8aQaL1mkc2Z8PWofY0Vz+jlXmFpy8fdJBJoN5NXlBF
         KKxsFUAhZXRgDCKbj1r9Q8v5Iqjp+s67UBl8RqLc0q8alcvWzncfHnvYmpoVZEFPMjQ1
         erj3ERScPb/AdTjUGSKi05mKjQmiO+fVbgwwVQKVCO/HVzYP30wWXlFNh00BtpKdtbEl
         OqT53KhWOiKdlwxxdlGnAXxXmgSRNIwpKXeWwUwCU3kCGv2CeDwQEoQv64dkglklysvJ
         AsPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762890166; x=1763494966;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6pAtM5xfeydKbpMgA4il9zMudvZmNqj0FuhX+2OXGek=;
        b=hcWJ90k+N1rukd5YeVmFIf/nW59v4hMCQWJRgCClSvBGYKyNxjV0H/i23clit3DW3C
         4uWPN+lvbOzh6a3jsNcJIF8BiL1gptEGh84C1rYi8C/KxkawdBNOitLCtlXmj8Rr4otK
         0AESmNRZLMP2dn/lyomH7QYGNy6JDNI6jbwzJyLF33Z1K6bvSmJU0u8p2L1geLHqZDVP
         DMQ8WD4YLCN+SWYfxJVfKW3oPilUxLCH8LQercaPDC+2Z+zT2AN/7E9qwKNfyMqstR7g
         8zbZwwSzNXMNI55o47WJP59FZKef39sSDQtXMrPmItp8CAbxix3xOfz4VeVP/YK+9xcp
         Uv0A==
X-Gm-Message-State: AOJu0Yz4AEFhSf7gCdtVUc7hX8Q8mQXSduGCjSzyop1VwSRdpugyMhop
	q9KRtieU/+joOCasKZjL3lEMdLlj60mH6YrCICI/6Y7ifH44H+InZHqLSISE+g==
X-Gm-Gg: ASbGncsXGt2+Fe2n4qhnAKtyX+fubkjUXKnLNpWUNJhRHmH6bGtfVsp4KDpCYLQaNiT
	xOnDWHZTMPj3HpjDN+uZ/y13DmODIVNo8zcv/TQPEHN7bbKuX+55EB6qu4lyjis/ojYj3ioWsPv
	TwJPMQ/Oi8WmLs0DUG4gZP1Vat4LUZ4b4annqgomnKvBiVloS8GMHbhWXCC4+PG0zumNK3SMPy9
	7MrO4Ix0xICCH3LAZeptW4Qg6hlL+x0Px/bIJGIdhFLHJ1IYSjeSFyppIpwHrK3kxgHHnvwkD4M
	ou5fRFJSCiUeMr92qgmcJ/ExexAGKkSxFAFDCRZFa883AEoNVp0wRXrJdok/thMLqaTPjxZvQj7
	wzopigJqLgJiIFqoGK3wj1orq+mD53DNHyfEr98ku1NrV4id+fV/8HYKET5YTVok3kI7lUS/e0d
	toz3U=
X-Google-Smtp-Source: AGHT+IGC5JF0pV27cdkzd/BWs220WioOcyA9LnTx/ta/+oR0P0BL2zUFoK4E7tg0yubEDhfJsqzNgg==
X-Received: by 2002:ad4:5745:0:b0:880:4ac3:fbde with SMTP id 6a1803df08f44-88271a1ac9dmr9344266d6.46.1762890165639;
        Tue, 11 Nov 2025 11:42:45 -0800 (PST)
Received: from [127.0.0.1] ([172.208.127.36])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8823892a0f9sm78860596d6.11.2025.11.11.11.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 11:42:45 -0800 (PST)
Message-Id: <75c26fe16049122f35b4fffb15f15429ae55f8e7.1762890152.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.v3.git.git.1762890152.gitgitgadget@gmail.com>
References: <pull.2070.v2.git.git.1761776388.gitgitgadget@gmail.com>
	<pull.2070.v3.git.git.1762890152.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 11 Nov 2025 19:42:32 +0000
Subject: [PATCH v3 10/10] xdiff: rename rindex -> reference_index
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Chris Torek <chris.torek@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

The classic diff adds only the lines that it's going to consider,
during the diff, to an array. A mapping between the compacted
array, and the lines of the file that they reference, is
facilitated by this array.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xdiffi.c   |  6 +++---
 xdiff/xprepare.c | 10 +++++-----
 xdiff/xtypes.h   |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 759193fe5d..8eb664be3e 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -24,7 +24,7 @@
 
 static size_t get_hash(xdfile_t *xdf, long index)
 {
-	return xdf->recs[xdf->rindex[index]].minimal_perfect_hash;
+	return xdf->recs[xdf->reference_index[index]].minimal_perfect_hash;
 }
 
 #define XDL_MAX_COST_MIN 256
@@ -278,10 +278,10 @@ int xdl_recs_cmp(xdfile_t *xdf1, long off1, long lim1,
 	 */
 	if (off1 == lim1) {
 		for (; off2 < lim2; off2++)
-			xdf2->changed[xdf2->rindex[off2]] = true;
+			xdf2->changed[xdf2->reference_index[off2]] = true;
 	} else if (off2 == lim2) {
 		for (; off1 < lim1; off1++)
-			xdf1->changed[xdf1->rindex[off1]] = true;
+			xdf1->changed[xdf1->reference_index[off1]] = true;
 	} else {
 		xdpsplit_t spl;
 		spl.i1 = spl.i2 = 0;
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 39fd79d9d4..34c82e4f8e 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -128,7 +128,7 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
 
 static void xdl_free_ctx(xdfile_t *xdf)
 {
-	xdl_free(xdf->rindex);
+	xdl_free(xdf->reference_index);
 	xdl_free(xdf->changed - 1);
 	xdl_free(xdf->recs);
 }
@@ -141,7 +141,7 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 	uint8_t const *blk, *cur, *top, *prev;
 	xrecord_t *crec;
 
-	xdf->rindex = NULL;
+	xdf->reference_index = NULL;
 	xdf->changed = NULL;
 	xdf->recs = NULL;
 
@@ -169,7 +169,7 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 
 	if ((XDF_DIFF_ALG(xpp->flags) != XDF_PATIENCE_DIFF) &&
 	    (XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF)) {
-		if (!XDL_ALLOC_ARRAY(xdf->rindex, xdf->nrec + 1))
+		if (!XDL_ALLOC_ARRAY(xdf->reference_index, xdf->nrec + 1))
 			goto abort;
 	}
 
@@ -312,7 +312,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	     i <= xdf1->dend; i++, recs++) {
 		if (action1[i] == KEEP ||
 		    (action1[i] == INVESTIGATE && !xdl_clean_mmatch(action1, i, xdf1->dstart, xdf1->dend))) {
-			xdf1->rindex[xdf1->nreff++] = i;
+			xdf1->reference_index[xdf1->nreff++] = i;
 			/* changed[i] remains false, i.e. keep */
 		} else
 			xdf1->changed[i] = true;
@@ -324,7 +324,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	     i <= xdf2->dend; i++, recs++) {
 		if (action2[i] == KEEP ||
 		    (action2[i] == INVESTIGATE && !xdl_clean_mmatch(action2, i, xdf2->dstart, xdf2->dend))) {
-			xdf2->rindex[xdf2->nreff++] = i;
+			xdf2->reference_index[xdf2->nreff++] = i;
 			/* changed[i] remains false, i.e. keep */
 		} else
 			xdf2->changed[i] = true;
diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index 3bcc0920e0..5accbec284 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -49,7 +49,7 @@ typedef struct s_xdfile {
 	xrecord_t *recs;
 	size_t nrec;
 	bool *changed;
-	size_t *rindex;
+	size_t *reference_index;
 	size_t nreff;
 	ptrdiff_t dstart, dend;
 } xdfile_t;
-- 
gitgitgadget
