Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678282F25E8
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 23:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758239805; cv=none; b=I+THbRQk1t1MrijVFyYOssCbPKEREi/mqaGVrze2vr0JA1VaHcd/d+YoOiOnM/AxRCZ7CAGDz+iitFNj/tlME1X3mSpsWuGnoSGYGmW41uA2cKXvhseZRGfUHpv0C28w9A2eKRnlRqjpwXfC7WhxqVjzH8Uo4vGAUc1Uw8Pdres=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758239805; c=relaxed/simple;
	bh=uIOjxkSjQMhtORk/LXq/CZ06lygjGPl9+YgHKr2p/b4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=sdNr6VuaWqzVy71xZ5T7fCoFg/YE2f4hTFm6q8Hcht/0kMS0ZCjXA72pDaGBmCG2wOB8cVb85EE2cIQrhrr9bDwYFsnHrzbLeRRTHvi/7ljXft6GxzExM4Abw/ZGyI7/Ll5xMoQx9voSMoiMSpNmYJaRe0pHQZwMk/OVMyKY02g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bb2mtL7G; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bb2mtL7G"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-791875a9071so15822926d6.1
        for <git@vger.kernel.org>; Thu, 18 Sep 2025 16:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758239802; x=1758844602; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUGxeWwiCbTLydwvVNwuYiY4zQ+m9lgJ4VzlvPBzyew=;
        b=Bb2mtL7G/Uk12I9iMJt/Ziw3AAMA5wIzljN+xewcisjgYh4KJ4Bplw93bJvFHLeYJi
         ToN0C3rb0b80wIu5h0cHjqiiyxprolNahYTxv/+YSe/HBOo53TF4gr8ab/BL+4bmbJs2
         E9dlxfLE4dtr8Hb5OakZqgO2fGeJ04WsG06edjRGQqGuNQynAVXFT3FLGHPRUgE0C4ZR
         Ix+FgHDj4zVRtvcF6Tf61/1DNWNZSbZV3KH7HNpNSmsaAIxw+OsFWcwoOvt+N2QW2/Bc
         N4VfQzp1D+4pRMpstgWzaMF7b/cgmLMSA92A3i+V0eCDGB1X05WbYO5rlp53/iZA+/QO
         PTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758239802; x=1758844602;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FUGxeWwiCbTLydwvVNwuYiY4zQ+m9lgJ4VzlvPBzyew=;
        b=Ot5wBdj0sUp9+75RQ0+xXmx+N2dvvxGiooON4g8M/ls9RsXaBy08UcC27f1UwwoCYo
         f6slBGaXkFhktDEM12++8d4zOe+B9CBhjxU+z/XOTL5lp4NRGgAFORkb/VrD8PjyAnqP
         oEcUoiTutMzHTgb0+eviPlHNJHkEQvZNuybAJIc8VjwBA7NJGpUGGcap3xlyVACgkuNT
         mG6AKDsOvklZLBhWMDZg2QAbp0XpS8VaL6XStl3NhGRg1Il7WxAcRha8TQq5bLgkKhr/
         2lRYaX+721J3caN9uW4cdVhfRSrnTmqQmucFfqmBSFqg6txIV6Cu295glTz6dBffrwht
         XM9w==
X-Gm-Message-State: AOJu0YxOR30XUInmoNHfbF2gbzXeZoyDGrI5+PVevlERqoX0ZI5CX84U
	KafjQg6irqUcF7id5Y1GPVvr938vhIPzO9UzLS54xqQ9K9GM72I7u2wscurfTnI4
X-Gm-Gg: ASbGncvaCy4hJAtV8TedAGSGQjyFQuAq3lM8FVYdAyTLIB1tzxbNm3s5rTC1572btAh
	zZpcP+Mjk64LMw+W/7YsFgDP4aWq9sY0z90LkrhP8SS8lA390sc+PgRRCxrFEAoBiaqtKVy0YlK
	RQX1ldM8lanZZ3Jm1sBcQzc41+a61QFTHXxXqQpYw30S7Y5obpn1/ethFDMZgZfxfpiHN2FMZCt
	6bxlOCUitbFhZg7AxAL5zs1W3ljRpEv/yeBIj94cBCEo+ryTT1997Yts4oaDexPvwruP9ffB9mv
	YM2fPjNoKyTPAJ4V1Mdc47ReVZbZBO5Ao4mB04E62KODZof3+fX2/8u+cLEjEdysvux3vqYp/sA
	/B3Lzv6x/Lf/LCvntShjlk0b8VWHZ4JX/QbzUzS/XbXLvB0FZtQmkUQ==
X-Google-Smtp-Source: AGHT+IFuExwTqh3ylA3N/MSincTajAsdJqdEOb1wW+qnZ9AevD/hT1qTkMZSb00wDqLwaLmLWOsPnA==
X-Received: by 2002:a05:6214:2429:b0:794:a05a:951c with SMTP id 6a1803df08f44-7991312e1admr18225336d6.27.1758239801845;
        Thu, 18 Sep 2025 16:56:41 -0700 (PDT)
Received: from [127.0.0.1] ([40.76.117.249])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-79346d05c93sm20837956d6.19.2025.09.18.16.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 16:56:41 -0700 (PDT)
Message-Id: <e1e94107c9722b751d6111460b17e02a7ffd96d1.1758239789.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v2.git.git.1758239789.gitgitgadget@gmail.com>
References: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com>
	<pull.2048.v2.git.git.1758239789.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Sep 2025 23:56:26 +0000
Subject: [PATCH v2 07/10] xdiff: delete fields ha, line, size in xdlclass_t in
 favor of an xrecord_t
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
Cc: Elijah Newren <newren@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Ben Knoble <ben.knoble@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

The fields from xdlclass_t are aliases of xrecord_t:
xdlclass_t.line -> xrecord_t.ptr
xdlclass_t.size -> xrecord_t.size
xdlclass_t.ha   -> xrecord_t.ha

Remove aliasing from xdlclass_t, to reduce future refactoring mistakes.

Best-viewed-with: --color-words
Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xprepare.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index c39b65fea9..43cebf6721 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -32,9 +32,7 @@
 
 typedef struct s_xdlclass {
 	struct s_xdlclass *next;
-	unsigned long ha;
-	char const *line;
-	long size;
+	xrecord_t rec;
 	long idx;
 	long len1, len2;
 } xdlclass_t;
@@ -93,14 +91,12 @@ static void xdl_free_classifier(xdlclassifier_t *cf) {
 
 static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t *rec) {
 	long hi;
-	char const *line;
 	xdlclass_t *rcrec;
 
-	line = rec->ptr;
 	hi = (long) XDL_HASHLONG(rec->ha, cf->hbits);
 	for (rcrec = cf->rchash[hi]; rcrec; rcrec = rcrec->next)
-		if (rcrec->ha == rec->ha &&
-				xdl_recmatch(rcrec->line, rcrec->size,
+		if (rcrec->rec.ha == rec->ha &&
+				xdl_recmatch(rcrec->rec.ptr, rcrec->rec.size,
 					rec->ptr, rec->size, cf->flags))
 			break;
 
@@ -113,9 +109,9 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
 		if (XDL_ALLOC_GROW(cf->rcrecs, cf->count, cf->alloc))
 				return -1;
 		cf->rcrecs[rcrec->idx] = rcrec;
-		rcrec->line = line;
-		rcrec->size = rec->size;
-		rcrec->ha = rec->ha;
+		rcrec->rec.ptr = rec->ptr;
+		rcrec->rec.size = rec->size;
+		rcrec->rec.ha = rec->ha;
 		rcrec->len1 = rcrec->len2 = 0;
 		rcrec->next = cf->rchash[hi];
 		cf->rchash[hi] = rcrec;
-- 
gitgitgadget

