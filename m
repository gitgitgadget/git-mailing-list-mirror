Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B31E2BE031
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 19:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774639440; cv=none; b=grhPL+guFmGLRHKTHlSfdmdf9fy8Z1PnV6wGgtHFmW7EsVw2Rxx331CAEW6eyhhyg2SY5JAg21EK9wy5N8Fr6vQKzKZbqt5TKc/vzytqvveO6NSzo8nyQSLSKa4WbU59/is6rHw50tCox4Akk/2TDzjxJ4+qx7uo6gLTw415v8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774639440; c=relaxed/simple;
	bh=Y0cyDhxL8l2KKDiWsH76aKyoj7SjddV5KFro/r4n4M4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=P/zyfCHm1icCfGxqnwc07Rj/nTyvf6wBnQ6i4+I2vu4cpwbuQqrpveBQ3yjPvERDv0SJa/HnVVLLuTGQdr404Az1yDafiiRylHJDvHBm9/7fDiowFNQDMiSI1kRsUvDLcvEFoIqTRT2CAnhVq4hDuQbWDuUzRnNTZi036wiERiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNxSWRGP; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNxSWRGP"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2b4520f6b32so2883381eec.0
        for <git@vger.kernel.org>; Fri, 27 Mar 2026 12:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774639438; x=1775244238; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5UDCBhlfZ3eeL1P4DW60HXe9wjOfRV5M4bIn1PRfvis=;
        b=PNxSWRGPeeitq9iOtFNz0E++k5Gx0HKQ2REVZgxmkWXUx7zZi9hMAgpqtTxnM6idHv
         AOxrp/DMay+jF37FO/aVresM+kMdzG9/UodSJ9mj/WeFPvr3hbM/k27gwZzHqHnL+bxM
         IOXidNsyBKiE0NE8ty8HKtxmyAx49X1ySr7uvHTatgMW7XRTLkUHqOJ63ReMTVEVPpd9
         SvYspwwdrAcjMSANXAe2KistfGik3thMUAy1iJU4tkFZN+O8WhLqB8cFPtKxXdq+dOdl
         9g5pS15vzP31LnTj7SLVchw8qxw4Tsh8BBU9aHNYadO7t8zrWcQY0+delGdvuDF6TtAu
         vC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774639438; x=1775244238;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5UDCBhlfZ3eeL1P4DW60HXe9wjOfRV5M4bIn1PRfvis=;
        b=Ks1ZpBFnMhMpRRRcTzDgEeE+/6AHoOge80w4kdZOIAg3T4fv33Yu3/sPCwd4tKCqIm
         aiwDod5HvS8U3xxUsCUKU65N/n5uPA+ZsaZ8CnF++1CoL4chHop810u18XVmIz0CwiN/
         PuhTW8u8aQmwW/r+xAxs+BzAgB/DpenKuJfhvS+jMMt3EHvSvivW3GlqsNl/anDmcjM2
         X/kPCx60j5p5ywGezCBISPjCzSxyO3CjFLeqPdA2xSkKSeOgmVR2SS7BzChF0Ju8WPHo
         0vGXcgYkyZLRnIRczeEzu+zhrBm2RlNlRmHCI7XfsGi9fTOZVQn+9fevupzwcDlkxpzD
         0ECQ==
X-Gm-Message-State: AOJu0Yw/LLt72BfZJz/7JFWqGjWgikaa+5k+rwCf/BfcxzHKzc5pqoK+
	gK0I0DrVti6/aMW+Lu8dZveliFvd7VlCtJrgrLnufKGGMXX778cFQHRHH6Kekg==
X-Gm-Gg: ATEYQzw6HQBH3cA0yQIT9j8IUgSdXe2EqUfmE6ehc8jJFojNQ8H/XuQgtVWAQPRaWn+
	t4vFptMAVIBekEJpXBce9uQsUchXkt1vithOLJb8j452H1Rkp0iyJLv34aYeZI92VnXgBrGLdUO
	AV9uwPxbVjMuifCumzMI8Nh1bikrf5oaDGYyhUsi288IJR0BHOmj+dx99w8sf5+gzowjbLCztqo
	bZy1jatLOAD/AFBYxEhK8chyqLVg5spO5Nt65T9agA6o58ek4Y57NnTm+CDzt07uVnUHnxD3SDK
	EOZgferQ3qbvms08tDtxUSSEUa/HYLFGtRLNA6OzCsg06WJUcrN8Lzf8TWHoWeOL6X05CiMZrMA
	wl1Dg78zDY945xqjbaoNujcu8aASxdJsMiW6raUmpg6IDlHMTUJwhNXSMFJztz7LAeLYBb5Xexl
	ceJTQCzsu6Qk3GoFpu4MU4TqyHEMc=
X-Received: by 2002:a05:7301:6781:b0:2c0:cd9d:e024 with SMTP id 5a478bee46e88-2c185f37df1mr2049953eec.28.1774639437758;
        Fri, 27 Mar 2026 12:23:57 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.247.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c4cbbc1fsm203853eec.13.2026.03.27.12.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 12:23:57 -0700 (PDT)
Message-Id: <da32a9747c7bde88b4fe33e43ae48c7092d57d9d.1774639433.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2156.v3.git.git.1774639433.gitgitgadget@gmail.com>
References: <pull.2156.v2.git.git.1774473065.gitgitgadget@gmail.com>
	<pull.2156.v3.git.git.1774639433.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 27 Mar 2026 19:23:48 +0000
Subject: [PATCH v3 1/6] xdiff/xdl_cleanup_records: delete local recs pointer
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
Cc: Yee Cheng Chin <ychin.git@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
    Jeff King <peff@peff.net>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Simplify the first 2 for loops by directly indexing the xdfile.recs.
recs is unused in the last 2 for loops, remove it. Best viewed with
--color-words.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xprepare.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index cd4fc405eb..d6e1901d2d 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -269,7 +269,6 @@ static bool xdl_clean_mmatch(uint8_t const *action, long i, long s, long e) {
  */
 static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2) {
 	long i, nm, mlim;
-	xrecord_t *recs;
 	xdlclass_t *rcrec;
 	uint8_t *action1 = NULL, *action2 = NULL;
 	bool need_min = !!(cf->flags & XDF_NEED_MINIMAL);
@@ -293,16 +292,18 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	 */
 	if ((mlim = xdl_bogosqrt((long)xdf1->nrec)) > XDL_MAX_EQLIMIT)
 		mlim = XDL_MAX_EQLIMIT;
-	for (i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart]; i <= xdf1->dend; i++, recs++) {
-		rcrec = cf->rcrecs[recs->minimal_perfect_hash];
+	for (i = xdf1->dstart; i <= xdf1->dend; i++) {
+		size_t mph1 = xdf1->recs[i].minimal_perfect_hash;
+		rcrec = cf->rcrecs[mph1];
 		nm = rcrec ? rcrec->len2 : 0;
 		action1[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
 	}
 
 	if ((mlim = xdl_bogosqrt((long)xdf2->nrec)) > XDL_MAX_EQLIMIT)
 		mlim = XDL_MAX_EQLIMIT;
-	for (i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart]; i <= xdf2->dend; i++, recs++) {
-		rcrec = cf->rcrecs[recs->minimal_perfect_hash];
+	for (i = xdf2->dstart; i <= xdf2->dend; i++) {
+		size_t mph2 = xdf2->recs[i].minimal_perfect_hash;
+		rcrec = cf->rcrecs[mph2];
 		nm = rcrec ? rcrec->len1 : 0;
 		action2[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
 	}
@@ -312,8 +313,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	 * false, or become true.
 	 */
 	xdf1->nreff = 0;
-	for (i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart];
-	     i <= xdf1->dend; i++, recs++) {
+	for (i = xdf1->dstart; i <= xdf1->dend; i++) {
 		if (action1[i] == KEEP ||
 		    (action1[i] == INVESTIGATE && !xdl_clean_mmatch(action1, i, xdf1->dstart, xdf1->dend))) {
 			xdf1->reference_index[xdf1->nreff++] = i;
@@ -324,8 +324,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	}
 
 	xdf2->nreff = 0;
-	for (i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart];
-	     i <= xdf2->dend; i++, recs++) {
+	for (i = xdf2->dstart; i <= xdf2->dend; i++) {
 		if (action2[i] == KEEP ||
 		    (action2[i] == INVESTIGATE && !xdl_clean_mmatch(action2, i, xdf2->dstart, xdf2->dend))) {
 			xdf2->reference_index[xdf2->nreff++] = i;
-- 
gitgitgadget

