Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835EA29E115
	for <git@vger.kernel.org>; Sun,  7 Sep 2025 19:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757274344; cv=none; b=XRV+t7vPrGUrhX3IgCi53yonoPZ6yblK4grQydwrwfgvGULFsRaDsmpR7ZpI+W5zfNBMtZDku9AYsx82exIsNU5nnuW5h/p6sMSunyj1KwclcT0nIXrScUp7AIoBK2QeigAS3Dl6HbpOPZ5EbEnQPuycATGdA281LbncztGB0RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757274344; c=relaxed/simple;
	bh=h/nYMDASiNdy4GBkmqwsrGfQIGx+l9t/AG3KPPAThYI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Zwub6xKlEjKoHW+HJvZCujuq/99mmC6N/eqKoKWsqc1R4GVn2SyJyT1YZzVyx+vvtw+QCFfdf+jsZq46hpN0zpEo5Fq0vecuX0wtKrzszoxj8r6aCTKqEIhYMCdWRFJ5TEXgBuyRp+monD6Vk6/VH7bYOU5VhtTLTk/AT9cOkis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWPxO104; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWPxO104"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8112c7d196eso207716285a.3
        for <git@vger.kernel.org>; Sun, 07 Sep 2025 12:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757274341; x=1757879141; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qjnVxb82nquebnLbMUwNobx/VfTbJCnDutHmEyeEPuU=;
        b=MWPxO104H0LwfKy3LRZoUFvJ17HlWa64oDgvPaEKGv5Q6NObA/Nsq9HQq6GT1XiR6/
         7jR8ShVFDFiBggsab1ClNtM89DeMym62hyEWQhYS1+v/LNGEl4av7oMuD7/qSdNaTSt0
         oAOJ98+h2uTVk7x/A81nEzhO4SalH0A5IwBdYOPDItXD35C1tRQFvrwSJ96vmnIeMH4h
         QEvKBCFpUO9XHbOzL6a0vBTExNs/qnDrlfUJYQXhla7tagraAXUqawQkC5CgFQVn0j4G
         n4KxQAvYsDt37FYz7dVjlYqt25BMKgZK2uU5Y9ozLyUfQT4Jjk0EF+RCJTfnXkSZG83b
         qK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757274341; x=1757879141;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qjnVxb82nquebnLbMUwNobx/VfTbJCnDutHmEyeEPuU=;
        b=gTi8onqqwvH1JmpTiaKCKXf2YtJyxYu6L00Z2GroQdGHWaZOx6rqPkWsFoNXLS7CTw
         9YTLHVY7I1lIok0c1LEBaA2YvCzGoEF9Fj+iCODZLqmued+7t6TF1Jani+PkGxsDCRuv
         LXY58XD7xPijLeypwJzLKYBaYisGhwT3zXLL/yMDBzFW+PzHy9Fbh0RTCOsw1giZouaU
         wCOUJyw4/Nr8/MHUNoDmTSr2gQIbLCibgS75YkHVoJQcwzpG2Ow44Oh8qCynC26Kchlo
         dx4k6cg8scTzE+IGX2YhaPkPdLtOCpJ66Gu2GTHzC9QZMFzbk0B3GMFfW+MvX2uEnGfZ
         AmtA==
X-Gm-Message-State: AOJu0Ywcnzg+kaXdtQ9bchHo0HFBFUfSL0QIrRu0vDIS/v8hsEhTCRKs
	epkbE6hmx7FxE8VNh7vIAtW7hryB0/Mhjy8XnV/4Pq0JZxn/tDU/eYn2UQDKXGvt
X-Gm-Gg: ASbGncvXOS8Yl1bdOjsCA6I5zkpDzhnZ9HDmVDqm6wzxrWI6gmUA+Vy3CuU6Mv+kxOG
	nPXGk05I3Q/yl3vdWcVINRzQw/mASyjRpcakXnj6ErhtQqROapmF7pQP52p5bXrP1aRaK7j8Wng
	umbEOYaeoSqc9FPhBZJ2Q6HML6Hp+SaWEnrJRAlICsDDwrnbuBR/fwpIYcRSGsica838ONQaE3F
	7AQEnCKHhfi8DalzXNMTeq8AVMW9IEPhlZbRusx4Gb6tCNOb5mcz/gX02ZjvJab5VXuSGMUAAmP
	2FcrMuOuEvM7A5Wttwes/khd7IBJvdBY0gRZKt4mrbwcyFjupih7VroAW7GcjG7z6zoW89k1Tdc
	QRRJk3/UM9c46e47ouXIkEvs=
X-Google-Smtp-Source: AGHT+IFC2qk+YqwB2AbR9eQc5kM0NJCORH0xS9Sv3w1neOtDhBWtV5aUxxPgvbALdg2zf0AeHoMzVg==
X-Received: by 2002:a05:620a:4050:b0:80f:378c:ded2 with SMTP id af79cd13be357-813c30f08c9mr677025185a.73.1757274341064;
        Sun, 07 Sep 2025 12:45:41 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.28.97])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7374ea4f28bsm38655166d6.12.2025.09.07.12.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 12:45:40 -0700 (PDT)
Message-Id: <f4eda35e2484d0702ea86cea39de2e62a5988d4a.1757274320.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com>
References: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 07 Sep 2025 19:45:19 +0000
Subject: [PATCH 16/17] xdiff: make xdfile_t.nreff a usize instead of long
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
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xprepare.c | 14 +++++++-------
 xdiff/xtypes.h   |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index d990fe1c9e..83355f036e 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -257,7 +257,7 @@ static int xdl_clean_mmatch(char const *dis, long i, long s, long e) {
  * might be potentially discarded if they happear in a run of discardable.
  */
 static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2) {
-	long i, nm, nreff, mlim;
+	long i, nm, mlim;
 	xrecord_t *recs;
 	xdlclass_t *rcrec;
 	char *dis, *dis1, *dis2;
@@ -284,25 +284,25 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 		dis2[i] = (nm == 0) ? NO: (nm >= mlim && !need_min) ? MAYBE: YES;
 	}
 
-	for (nreff = 0, i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart];
+	xdf1->nreff = 0;
+	for (i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart];
 	     i <= xdf1->dend; i++, recs++) {
 		if (dis1[i] == YES ||
 		    (dis1[i] == MAYBE && !xdl_clean_mmatch(dis1, i, xdf1->dstart, xdf1->dend))) {
-			xdf1->rindex[nreff++] = i;
+			xdf1->rindex[xdf1->nreff++] = i;
 		} else
 			xdf1->rchg[i] = YES;
 	}
-	xdf1->nreff = nreff;
 
-	for (nreff = 0, i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart];
+	xdf2->nreff = 0;
+	for (i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart];
 	     i <= xdf2->dend; i++, recs++) {
 		if (dis2[i] == YES ||
 		    (dis2[i] == MAYBE && !xdl_clean_mmatch(dis2, i, xdf2->dstart, xdf2->dend))) {
-			xdf2->rindex[nreff++] = i;
+			xdf2->rindex[xdf2->nreff++] = i;
 		} else
 			xdf2->rchg[i] = YES;
 	}
-	xdf2->nreff = nreff;
 
 	xdl_free(dis);
 
diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index 41986c6603..070674d7c4 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -51,7 +51,7 @@ typedef struct s_xdfile {
 	long dstart, dend;
 	char *rchg;
 	long *rindex;
-	long nreff;
+	usize nreff;
 } xdfile_t;
 
 typedef struct s_xdfenv {
-- 
gitgitgadget

