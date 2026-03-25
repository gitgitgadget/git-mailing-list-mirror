Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886FA33B6C4
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 21:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774473075; cv=none; b=ddS+vl8egYu2C3JB087Xu5DV1Ctzyjc8rEGLGMzPTMVQc03+EMDRV0gkLCtSKHLv3w3q4qST/wFNRG8ivUwECQWkQUBLv67AajBwQa5lwRxQJlRh0X1ckXnQUVGCL7wCS1FoqnXRTTjM+1pN3hJulQ4Z4r1VPDf4jx9B7v5OWAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774473075; c=relaxed/simple;
	bh=Bi/bEFVNKObzrmEHGMNlHMddqVQVqRzW6BbgxUnjDik=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=U1k37uyKMCgOy4hvFdBlS0cIkIEVR1CQ5xKErJHwjvpkBr20KlFaZ9nm9gNCDWybr0q4G+x+61yM+zVgNnfoiU82NvaGP+lFA19KUNBIu4/2yIMOBmgv/FWf8d3c7FR0yV6nCJ3FydytX6t2OuOi3tke4Ysj8fpGHtrZdFXoc6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0XsiYjg; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0XsiYjg"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7d7d4ebccf7so217270a34.0
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 14:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774473073; x=1775077873; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pSeQnxXVfu/bca4r9cvwDCqEMxnZeqy/YYraDvHBaDU=;
        b=a0XsiYjg73HYSlvE1rqFkhWtN8K9tu2QMOvl60UofLGocNInFJWviklh9THeywg80F
         GWj2LiNTmsIb4YkDmHXMQUs49cfuRliEPxQl0G60ZS9V3NfvnE/hSHYWoVfGCJ9Zrrcg
         5C9uPu6KqYwEvZOf878ZapHhbFZRJzNMuZUWcR24IaJyq+fSf2vZ8oW+J11bCNSIGB+9
         giWMXuEvQgpCyAWBRZ4LhmjK8OPFVJJrhoipZFQoOQAg24JAQv6LZvbvVQwpmmkkCYCD
         j9S2t5KvYsGvGYJZd6L20IfIq4PXiwt6j0Wd+Tt54vL4jzKepPJBxCCUprDw7zkewGyU
         uaOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774473073; x=1775077873;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pSeQnxXVfu/bca4r9cvwDCqEMxnZeqy/YYraDvHBaDU=;
        b=WEYUceIl0PL0oaqTf2D5mFCHFL8f+R/UPiBWVbQKYltkG4bgaI/jNzZvkOajv5NQxk
         Dl8gLzQDH0keEVY7kCxKOuACgHqFtv8Deo8UeIcRZg+HcO8VIm7Bs6fzYLOV0jHtj+S4
         NPs91jboKhWqLQVDT1qT4eMPl8QHWq8Ep/k9qSIGmBHgPdSCnmxM5Ikp/1KQPdtI7hgE
         Opb06lDFUyH5jpwkEDX4ZOP3U0T+1qSw5Y7e7UjRgaboXjsrT+LWfBDqAxXv/p0f7NiW
         3dKYa/lvpSuSAIU+mbcJGtWiC6Qz7a/lVX4LSarGSXJ/gn2lIixOZWNEVC5Qm7G2tol8
         RW9w==
X-Gm-Message-State: AOJu0Yw3Tgn0cGj8/2+/HqnWxpR77iBMEb7gkdi/4Yj6mkiyXMfV83TL
	uIbmeFt/9qHMrMNzUuHNc4xqjVwJx2q5ClQ3UCLOnv8xc62+RI3KdK7jSi+2iA==
X-Gm-Gg: ATEYQzz9qUMMd5j67QqCohnTig8r+uepVNqkjLORHHvFv9detspGj5gxyP+Vk3tc4qZ
	bobeHKmuF30JpbaZnARiZ79L99lGzz1gyzwtuVH99wbemO6e6Gp4HGUawR37dv9Ygoh+fmAcxPh
	AGGSf8qr6F/3U9ZWHj4NKyvVn2wSM3O4zGQdUD8QrghvbbxiHPdqrWtasNYN2VdyWJPusufIPnK
	JCfiSh8ZYIMiHGxDeOmTVGifZavpzg3sXsFS7F/FqYuPilHSUKjRdQ9YCDznHrapjRsbNdT4blc
	Ef3zFlf9AlMkpEgZoEyw1yU+YxrrHnokpI8AY4tRyOqMOPAAbHRNflH0M7X4iuqU8KHTtFvAQLW
	qAxbpL6w42x1Z5kUQ9sSnqjX65BA7ZRDLTFbWFaU2h/+TuVvWhrBkcgL8gx0NWbIwNJOZ718LhY
	G1IdE1mrHCu4N34CEsE2PRdifmwQ==
X-Received: by 2002:a05:6830:6a89:b0:7d9:4337:2b8e with SMTP id 46e09a7af769-7d9d68af52dmr2713320a34.34.1774473073093;
        Wed, 25 Mar 2026 14:11:13 -0700 (PDT)
Received: from [127.0.0.1] ([52.165.213.176])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d9e680456bsm851171a34.0.2026.03.25.14.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 14:11:12 -0700 (PDT)
Message-Id: <6abd052c347025610d26197ba5de8cd11fc1b618.1774473065.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2156.v2.git.git.1774473065.gitgitgadget@gmail.com>
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
	<pull.2156.v2.git.git.1774473065.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Mar 2026 21:11:04 +0000
Subject: [PATCH v2 4/5] xdiff/xdl_cleanup_records: simplify INVESTIGATE
 handling for clarity
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

Make it clear that INVESTIGATE is turned into KEEP or DISCARD based on
the result of xdl_clean_mmatch() which reduces actionX[i] into a
boolean value.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xprepare.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 127848b764..dd595cf8a1 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -330,24 +330,38 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	 */
 	xdf1->nreff = 0;
 	for (i = xdf1->dstart; i <= xdf1->dend; i++) {
-		if (action1[i] == KEEP ||
-		    (action1[i] == INVESTIGATE && !xdl_clean_mmatch(action1, i, xdf1->dstart, xdf1->dend))) {
+		if (action1[i] == INVESTIGATE) {
+			if (!xdl_clean_mmatch(action1, i, xdf1->dstart, xdf1->dend))
+				action1[i] = KEEP;
+			else
+				action1[i] = DISCARD;
+		}
+
+		if (action1[i] == KEEP) {
 			xdf1->reference_index[xdf1->nreff++] = i;
-			/* changed[i] remains false, i.e. keep */
-		} else
+			/* changed[i] remains false */
+		} else if (action1[i] == DISCARD)
 			xdf1->changed[i] = true;
-			/* i.e. discard */
+		else
+			BUG("Illegal state for action1[i]");
 	}
 
 	xdf2->nreff = 0;
 	for (i = xdf2->dstart; i <= xdf2->dend; i++) {
-		if (action2[i] == KEEP ||
-		    (action2[i] == INVESTIGATE && !xdl_clean_mmatch(action2, i, xdf2->dstart, xdf2->dend))) {
+		if (action2[i] == INVESTIGATE) {
+			if (!xdl_clean_mmatch(action2, i, xdf2->dstart, xdf2->dend))
+				action2[i] = KEEP;
+			else
+				action2[i] = DISCARD;
+		}
+
+		if (action2[i] == KEEP) {
 			xdf2->reference_index[xdf2->nreff++] = i;
-			/* changed[i] remains false, i.e. keep */
-		} else
+			/* changed[i] remains false */
+		} else if (action2[i] == DISCARD)
 			xdf2->changed[i] = true;
-			/* i.e. discard */
+		else
+			BUG("Illegal state for action2[i]");
 	}
 
 cleanup:
-- 
gitgitgadget

