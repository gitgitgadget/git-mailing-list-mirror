Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF233368BB
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 21:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774473077; cv=none; b=lOkDbURyNHfN6Q32E5Fv3tyg32BOlL0eXJQKT+a98EleGAsPe3OCPLCnhhJcAFJslujbvQXW6LTZAUNJXwdA2uaLRDEmIaZ0Be6gXiGEhUfQESwXo68yfxSswotu7pQopiF3f3TkmxGptamANP+Lz8+FDs9v6sIEjaycMcKCjw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774473077; c=relaxed/simple;
	bh=ShNh6JPbTuHX2w3XxpmtaSKNERxmpA90rkfyrp2l+ek=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=sCMLatyXXpMmravkXO47EeJ43SyNiNcTt2BtdMF0uc4frEt/S0zDyGf+rksk5VcT8R4cxSVkmMy+MmJdTZmaoizxV4ALPBDOZ0tbKgRJgzxcoMHASxB/wA9islk1UF9k/gcO3Lp5gil6gBXs26JGZN1JaT5JtOwJ8LWBsTxJ5zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pmDp7Sgp; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pmDp7Sgp"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-46805c4ae5dso121465b6e.1
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 14:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774473075; x=1775077875; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z84O3nfErHQ6rkdoA5Gk1rqkRyvIaPWVdhQykyfnEWg=;
        b=pmDp7SgpIKbeugYPVHOKGw7RTmq/JdAr68jf503r5a5pCVDfcELCEqUqxPL6Joolk/
         J+Lc+qxppHdWbe5rOgA+Ir30bIvDK1kfuiibe1R+OtEkU2xlkvVxxkuuPr8jTiNRgTfV
         alxScouSfALH2ATLV1lgWP5seEnB0gwvJD7lJJz+Icc3xUOT5UGn6GGWhfBtEjA408Zu
         F2ZqYUqjlsCubMi2ELAEDsxwjMUa+uqLkybWJHYkmKp1ivto5jbee9cts7KcDo24FaL+
         O+z2MJDujYvjQWTKj1YIJVNJfVMT9xqACfDTJqAyEja8vvi3e2bQ6/4JvEhe5ZnotJHr
         anFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774473075; x=1775077875;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z84O3nfErHQ6rkdoA5Gk1rqkRyvIaPWVdhQykyfnEWg=;
        b=Ip2VXWTDuESEadSPddLv9eORxnXZ+DY63liw8n9M7+MrmutWJM18Ygi+2PL4DXMkFD
         RTO+2e8fmpvVR+URLogMaQH0Eh0hw+uhfr5w/lKFWER8lG7BtaDFnjTGdhAawugAGJv2
         t+sDWrqBoRsRoPD1Y+tijb2nIYZSJ9fzvbPqf/IMC6XmnezL9YFEQ4kx48/dhPzw/eeq
         eP2gfbJIe33D1eO+q9oxo4ee/mGqrwAiI6E+wNmtCU/pc1raVMZlGjlvf00AAGFpnTZk
         dQ0paUrh95lrqZXQoWEwaS6sFla8I6Z2rx8VkAA1rbfm0XdCui8VeknSIRD3HPzGyuPW
         Pgug==
X-Gm-Message-State: AOJu0Yz1UDdXtdH3TOU21lzLXGzgdLxmNQEksiwdonzTfbcfEcOf67f4
	DPxLS+S5ziZatmgSyG8l29RwiGzS2nZckzaqRGPB8wu7WL5yNR3arTGK+vOKZA==
X-Gm-Gg: ATEYQzyq5GLGUuo7BWtEBNwxJx/UpX486vkJ+Ah752qkXdkgDnEW1xR1DKo6ot3CQ1R
	I9uTM7TSA+/HJOW7ZMAWd3Oddlb7MO/ktmbjjElwBrk+U3irBbm243d+fxw72y+mwo9MIyeW/zF
	zl85rzXL5nOoi3/XQT1JUMKjyJQZdq3703E3r7ggQ3eCuTGuz6Lcohg8N+LMI9yIu47Q9r4Zuno
	mr/IIKTOR4SHjsA8McOFEUu038Gk/xcK55d6aGILoxIxAypcl/HzuFa51rTjZbZDNxZUlgDsnTK
	AjajnZfvXcMNVkv2LCDH/CbP2/17GxzZZCccr5Mm8tn43T7D06yY+Jovp4stSrzUSpHtA2D5BtT
	eQeKq/3gSZrhYvB9xw7q89GfHzNSxinLIArBofTkDAQ1v0ZckmHZ/bRMG3qVmhUCjzj4f3dczS9
	KVbHMWsdNCqbmSRrQuvxOIAJuj/g==
X-Received: by 2002:a05:6808:4f4a:b0:45f:481c:e258 with SMTP id 5614622812f47-46a5c5cde49mr2449434b6e.16.1774473075064;
        Wed, 25 Mar 2026 14:11:15 -0700 (PDT)
Received: from [127.0.0.1] ([52.165.213.176])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46a7094243csm424258b6e.12.2026.03.25.14.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 14:11:14 -0700 (PDT)
Message-Id: <a52787f0194bf9f7d1e0abe024c423b8d93754fc.1774473065.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2156.v2.git.git.1774473065.gitgitgadget@gmail.com>
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
	<pull.2156.v2.git.git.1774473065.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Mar 2026 21:11:05 +0000
Subject: [PATCH v2 5/5] xdiff/xdl_cleanup_records: use unambiguous types
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

Change the parameters of xdl_clean_mmatch() and the local variables
i, nm in xdl_cleanup_records() to use unambiguous types. Best viewed
with --color-words.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xprepare.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index dd595cf8a1..39e48ad33a 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -197,8 +197,8 @@ void xdl_free_env(xdfenv_t *xe) {
 }
 
 
-static bool xdl_clean_mmatch(uint8_t const *action, long i, long s, long e) {
-	long r, rdis0, rpdis0, rdis1, rpdis1;
+static bool xdl_clean_mmatch(uint8_t const *action, ptrdiff_t i, ptrdiff_t s, ptrdiff_t e) {
+	ptrdiff_t r, rdis0, rpdis0, rdis1, rpdis1;
 
 	/*
 	 * Limits the window that is examined during the similar-lines
@@ -268,8 +268,8 @@ static bool xdl_clean_mmatch(uint8_t const *action, long i, long s, long e) {
  * might be potentially discarded if they appear in a run of discardable.
  */
 static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2) {
-	long i, nm;
-	size_t mlim1, mlim2;
+	ptrdiff_t i;
+	size_t nm, mlim1, mlim2;
 	xdlclass_t *rcrec;
 	uint8_t *action1 = NULL, *action2 = NULL;
 	bool need_min = !!(cf->flags & XDF_NEED_MINIMAL);
@@ -303,7 +303,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	for (i = xdf1->dstart; i <= xdf1->dend; i++) {
 		size_t mph1 = xdf1->recs[i].minimal_perfect_hash;
 		rcrec = cf->rcrecs[mph1];
-		nm = rcrec ? rcrec->len2 : 0;
+		nm = rcrec ? (size_t)rcrec->len2 : 0;
 		if (nm == 0)
 			action1[i] = DISCARD;
 		else if (nm < mlim1)
@@ -315,7 +315,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	for (i = xdf2->dstart; i <= xdf2->dend; i++) {
 		size_t mph2 = xdf2->recs[i].minimal_perfect_hash;
 		rcrec = cf->rcrecs[mph2];
-		nm = rcrec ? rcrec->len1 : 0;
+		nm = rcrec ? (size_t)rcrec->len1 : 0;
 		if (nm == 0)
 			action2[i] = DISCARD;
 		else if (nm < mlim2)
-- 
gitgitgadget
