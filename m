Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3872F2857C1
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 20:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775679996; cv=none; b=OG01v6IUIqWTj/82B91n5i9utQShSiXDX1v2pbiWwN5jFk+Jfjsnfybt9A3qT5o4bb5K1HaFlu7SdqjbF0EMH8asLorGyXSZKovj7EPsEvzwGlC1RxBJWsI7NFfxDaBG6Foj7chv6Y1YkLDJ5h3opy1HaySDbrm3hQBJnV49dKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775679996; c=relaxed/simple;
	bh=/tMhb1hF8evtEbXZhK5bKT9POH0y47YWJ6PEXp7J+P8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=d5BzW4t6+t9IN5r8H+fLrMylXHzPVGUKL+8UQShguTGwS8cCW9nI8TqgI+pR5H0eFAa0gkQh7vwfCUEay/rOoER+Si1yAURhShfMY0Lm84E9Xg9UY9kamMd3P8jkBat2WhjoB7ResHVbsJab/MIzodLDt7x85eEUNpS0fElcckk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LgcPk9l7; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgcPk9l7"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c742d4df00cso72728a12.1
        for <git@vger.kernel.org>; Wed, 08 Apr 2026 13:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775679994; x=1776284794; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aAh2YlWtHIQUSN4USii4XmZm0LRrKAOwgLHkCDgwEYY=;
        b=LgcPk9l7+g+5Svn+aZ+cu0ElKw2ZZmGjSF1TKikk8np/HaNbAYgLzDJIA5/LuOrUYR
         sqxj0wmfPjNFvo6OQY5F633bBLN17X4MR0vXVAGX/QmEuBsRKonqJauG+qsgVwXJEBix
         FFBZBVbuJmSsNHIAsfG+8lJqQDT3QSx3aW3/ArJXQUQ6ay1Mea0c4JHqwzw8gl55hURe
         UDoa/dRq7xhg9Gbemqf0p6W3AihE5hex+ZhSDlTA1L9rSCCk04AyBvm/TH6gApDlAf/u
         gUAJr9R0bdkQuw0ihwFn0uiqVGE8XU0Osf2UVJqx76eoo+ENzAfs1f+Jd1VC6oLIHmxk
         R/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775679994; x=1776284794;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aAh2YlWtHIQUSN4USii4XmZm0LRrKAOwgLHkCDgwEYY=;
        b=TqsJPKDtJIkhoRQl0mIKxrSJzk3DagQ18ke7aBvwSMTm2l6YfDJzAuDJerA/t8MSxK
         XQdvk9n2Jd3gDLIVvtDjb9ueQgarOhd3qq0fdNVBMa22qiL87UfqmtI7CYwQYAwEFqBA
         amJldMU4bhB/nbaL7Mz/ppHNtIfRaJNm4+fx/48cGqD126fdIbUv+O/zX3XX/9eLapqH
         9zPk5bE9/l23zim+7yxxrSsjIffZABfnHdjrJwNyaJbrfiyMZI6MiwNbnXIdq+YbFNV8
         VZmj8HG/YAtIshP92MdtjTU9i/HyWR2klHMcmI7nj7vTZwoiVP0odUwjBK4nRzc/VbJo
         P6Dg==
X-Gm-Message-State: AOJu0Ywtebp+YCev4NBnf9vUeQKZFs7kpJWPJN7t6IuM9OjMRB+/YL5G
	jV/LClGKbaTyXE38tiIseRwhbnEybS55gZqfFBYgVse0GsW4vILgBZgZLHuN0g==
X-Gm-Gg: AeBDiestyo6NzPevoDxm7tjORA+TtGkPCx+CjHOQwu+VNuajBm0f+j3I3oS5QoxjyEI
	1gmUx2bKw9t2R/vKDbGRptcf1xYyRr54PevyWxKXQ8TmqL5dSPHmf72ipe9iylDMwYhrmh6JI6Y
	5cXwvaqSNaE1SQo9sCEB0o7iUkjitEUX1mqRMbRigNdhpfPvr0OxzQr77ryo8reUNr7I64Q28L8
	vymiOG0MxjfYRBhBZUCwnRTP+DnhgbxxN7WGIzKF0meTrP+7Q6gDW4YGjdXuH0XHYlOXYIAvebU
	2ktNH4RSPAfNOKrH7HBlbC7kf0DBsTWpCvp+4IxRz+1tFbRmMa4HBVFec+iNZGVvNZtyBPJcw0X
	N5RmQZETG01IurRc8+67x9Kjv+Bjo16F6EWkVg3YIascfkF+2P/Tz8UE9hOviyRbYmUhkUEizdf
	xLJckrFpTT2GHkhmSoBkKqgdphFQvq
X-Received: by 2002:a05:7022:4381:b0:12c:8eb:80b9 with SMTP id a92af1059eb24-12c28bfed17mr427333c88.6.1775679993985;
        Wed, 08 Apr 2026 13:26:33 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.209.145])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bf90973b6sm22926364c88.9.2026.04.08.13.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 13:26:33 -0700 (PDT)
Message-Id: <1822166fef0c5dcafb4f3c717eff235db6404342.1775679988.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2156.v5.git.git.1775679988.gitgitgadget@gmail.com>
References: <pull.2156.v4.git.git.1774890003.gitgitgadget@gmail.com>
	<pull.2156.v5.git.git.1775679988.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 08 Apr 2026 20:26:24 +0000
Subject: [PATCH v5 2/6] xdiff: use unambiguous types in xdl_bogo_sqrt()
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
    SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

There is no real square root for a negative number and size_t may not
be large enough for certain applications, replace long with uint64_t.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xdiffi.c   | 2 +-
 xdiff/xprepare.c | 4 ++--
 xdiff/xutils.c   | 4 ++--
 xdiff/xutils.h   | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 4376f943db..88708c12a3 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -348,7 +348,7 @@ int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 	kvdf += xe->xdf2.nreff + 1;
 	kvdb += xe->xdf2.nreff + 1;
 
-	xenv.mxcost = xdl_bogosqrt(ndiags);
+	xenv.mxcost = (long)xdl_bogosqrt((uint64_t)ndiags);
 	if (xenv.mxcost < XDL_MAX_COST_MIN)
 		xenv.mxcost = XDL_MAX_COST_MIN;
 	xenv.snake_cnt = XDL_SNAKE_CNT;
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index d6e1901d2d..48fb5ce6fe 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -290,7 +290,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	/*
 	 * Initialize temporary arrays with DISCARD, KEEP, or INVESTIGATE.
 	 */
-	if ((mlim = xdl_bogosqrt((long)xdf1->nrec)) > XDL_MAX_EQLIMIT)
+	if ((mlim = (long)xdl_bogosqrt((uint64_t)xdf1->nrec)) > XDL_MAX_EQLIMIT)
 		mlim = XDL_MAX_EQLIMIT;
 	for (i = xdf1->dstart; i <= xdf1->dend; i++) {
 		size_t mph1 = xdf1->recs[i].minimal_perfect_hash;
@@ -299,7 +299,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 		action1[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
 	}
 
-	if ((mlim = xdl_bogosqrt((long)xdf2->nrec)) > XDL_MAX_EQLIMIT)
+	if ((mlim = (long)xdl_bogosqrt((uint64_t)xdf2->nrec)) > XDL_MAX_EQLIMIT)
 		mlim = XDL_MAX_EQLIMIT;
 	for (i = xdf2->dstart; i <= xdf2->dend; i++) {
 		size_t mph2 = xdf2->recs[i].minimal_perfect_hash;
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 77ee1ad9c8..9a999acdc0 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -23,8 +23,8 @@
 #include "xinclude.h"
 
 
-long xdl_bogosqrt(long n) {
-	long i;
+uint64_t xdl_bogosqrt(uint64_t n) {
+	uint64_t i;
 
 	/*
 	 * Classical integer square root approximation using shifts.
diff --git a/xdiff/xutils.h b/xdiff/xutils.h
index 615b4a9d35..58f9d74cda 100644
--- a/xdiff/xutils.h
+++ b/xdiff/xutils.h
@@ -25,7 +25,7 @@
 
 
 
-long xdl_bogosqrt(long n);
+uint64_t xdl_bogosqrt(uint64_t n);
 int xdl_emit_diffrec(char const *rec, long size, char const *pre, long psize,
 		     xdemitcb_t *ecb);
 int xdl_cha_init(chastore_t *cha, long isize, long icount);
-- 
gitgitgadget

