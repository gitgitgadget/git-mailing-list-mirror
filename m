Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE1830C36F
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 21:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758662682; cv=none; b=OtIa78sAFfLNh8g6bpdPOnYuVuq7yv3LHKOhq672EevD4EwqBkrKiBgJwb0X4r8RdORb4GzZYDuam1vbwY+IPOBxsGFnsODqbxHnr61a1BjydxtCsXci4Lbx6r1W/SM74YXiO84ZG7OXQ06WepFdnk+qYSZiancdvQ1X2Vlmpcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758662682; c=relaxed/simple;
	bh=At1/Svq2Yi0nc+CCONz+TXyna2MMhEGmHRQLDwkPwic=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NOqYXff/3iwvxlFqQRutH0Hcmq1cTXUsMXA6AYeJlhKUuB7H+wEs+RU/jvoDZYUGKVc3y3VZSLGNOP+g5w4P+Fl9mlTHgz9RoXYtOvWs9duIk8HoHS7Bu1YfosUsWdNrCOSEx4b1jtXoqVGeV5rAk+SlByyE98GgKolDwvhSnCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eHpxV1Y5; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHpxV1Y5"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-77f605f22easo792181b3a.2
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 14:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758662680; x=1759267480; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qoiqsHfrzKTczLvwTrlXS/z94nduZIZMqlZcRTbrgVA=;
        b=eHpxV1Y5YwUkzRP8qM/SU2JBJZdihyUFyE1lSkife/qw1IoHk83aB5gWTM9VzfwBOr
         crXcnDskKEqK19RUdBjMYIQ2LeLEudKTT80jR51ln3welWuZ8NEE7jdG2W5JHX/qS8IT
         50Du8zN+KEVVAbnIZ9ikr6jCG04MPqRxm6dBsWy9CnMZAkLJGl+LNr+59SSrGZPAoLwI
         qKcEADvS7CHIHhSWMfdatJlfejPeLbld/gaSx3Cg2IhbncOJVcNAi3ngQQ00dZYwwcN0
         ONSNGLIiiFeD9zXSuGO8lt4HR9N93q5O7cITdjDxLrIiO2UEpLirK8ZFrQfZP+onRhVS
         khEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758662680; x=1759267480;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qoiqsHfrzKTczLvwTrlXS/z94nduZIZMqlZcRTbrgVA=;
        b=CaRtYPEJa9gZc1twypsMwHQLtXtjA4FLTVl5u34jvYS8d47HD+Xtupr4hrB1a9UTvd
         XF1TyNZwDreutdb8N0XxYUdGjazsd4NQaNzwfnq0KN/OUNf+sJC9MHqNJbPJZVXtv3yg
         YYT+Kmcg4H12dnnECiX/ab+BdLVuE8+G9JgRNADAevX8DcvCSjAi76oGVbIzSwq5ZEfs
         A/uZZk3NIDZKiwKU7RRcSbkRSftVkNien6DUooXvrQq/12CT66HqDOFuGIOeIQ9RINO3
         Bt5f/MDIROEXF9vk7aKVTpdZlJLNpndWbJqxYWVHf04m3g4aadJrJR7qNJCNeZ5Tcxlq
         AMug==
X-Gm-Message-State: AOJu0YwUwFr8NBNWCvf0NE1bc9HftCYmc6MEgrmyfgpWKFu6/9yGbXU/
	IUqWCnvzTDAennnLebEDseP7k5MGwSHoTDKLGLw0Y464ZAKwfHzkIquOG0QAcBnw
X-Gm-Gg: ASbGncuzTW2xjcviSWPCqquBeolt2hkzizQM+kMAS92MMhpStNxGkpsx/fqTGaNY4BI
	a3jBpAfKEYGI2cTOTGfUWcoifhwSopMh31haVJLqXTSwv0tGZ/sEkIl+XaxbEq7nwRtVzgNi3YP
	5kVmvZ7fomx8qIi3Af4vWcs2hOTxZFB67rVIuAAJUB5Fdov4drPFuw02w8YZLP0riRd0Ct9JkEZ
	buS0bLF7hawT9X+b4GoiEo/+n/jTuMm2uatcZVPqytPRDL+jO5t7a9Y3Cm/oS1avV3txe5q5xdJ
	Zcr0xCt2Xl6xuuXdiSBfwmseT7cv9SdRecuo+1sNEmMiHe21U1ajGmOpvgPiXZVO8bF5nv/vj+2
	rRyQ+86ZUEMqMM+aF8ucftF3J7Q==
X-Google-Smtp-Source: AGHT+IHm5y6Ba+2oAJV4QjmAMASH8UjjdHYIuDcDs8YmlekDXfzu4lWdHCooSnCwNyDz5cAhFDogHA==
X-Received: by 2002:a05:6a20:3b06:b0:2da:f4be:c8da with SMTP id adf61e73a8af0-2daf4bed07bmr1430275637.28.1758662680056;
        Tue, 23 Sep 2025 14:24:40 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.128.241])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b551be7cfadsm12801527a12.47.2025.09.23.14.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 14:24:39 -0700 (PDT)
Message-Id: <1d550cf308a189721ba089443f29678ead0344e5.1758662670.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com>
References: <pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
	<pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 23 Sep 2025 21:24:22 +0000
Subject: [PATCH v5 05/13] xdiff: delete superfluous local variables that alias
 fields in xrecord_t
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
    Jeff King <peff@peff.net>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Use the type xrecord_t as the local variable for the functions in the
file xdiff/xemit.c.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xemit.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index 40fc8154f3..2161ac3cd0 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -23,12 +23,11 @@
 #include "xinclude.h"
 
 
-static int xdl_emit_record(xdfile_t *xdf, long ri, char const *pre, xdemitcb_t *ecb) {
-	long size, psize = strlen(pre);
-	char const *rec = xdf->recs[ri]->ptr;
+static int xdl_emit_record(xdfile_t *xdf, long ri, char const *pre, xdemitcb_t *ecb)
+{
+	xrecord_t *rec = xdf->recs[ri];
 
-	size = xdf->recs[ri]->size;
-	if (xdl_emit_diffrec(rec, size, pre, psize, ecb) < 0)
+	if (xdl_emit_diffrec(rec->ptr, rec->size, pre, strlen(pre), ecb) < 0)
 		return -1;
 
 	return 0;
@@ -111,11 +110,11 @@ static long def_ff(const char *rec, long len, char *buf, long sz)
 static long match_func_rec(xdfile_t *xdf, xdemitconf_t const *xecfg, long ri,
 			   char *buf, long sz)
 {
-	const char *rec = xdf->recs[ri]->ptr;
-	long len = xdf->recs[ri]->size;
+	xrecord_t *rec = xdf->recs[ri];
+
 	if (!xecfg->find_func)
-		return def_ff(rec, len, buf, sz);
-	return xecfg->find_func(rec, len, buf, sz, xecfg->find_func_priv);
+		return def_ff(rec->ptr, rec->size, buf, sz);
+	return xecfg->find_func(rec->ptr, rec->size, buf, sz, xecfg->find_func_priv);
 }
 
 static int is_func_rec(xdfile_t *xdf, xdemitconf_t const *xecfg, long ri)
@@ -151,14 +150,12 @@ static long get_func_line(xdfenv_t *xe, xdemitconf_t const *xecfg,
 
 static int is_empty_rec(xdfile_t *xdf, long ri)
 {
-	const char *rec = xdf->recs[ri]->ptr;
-	long len = xdf->recs[ri]->size;
+	xrecord_t *rec = xdf->recs[ri];
+	long i = 0;
 
-	while (len > 0 && XDL_ISSPACE(*rec)) {
-		rec++;
-		len--;
-	}
-	return !len;
+	for (; i < rec->size && XDL_ISSPACE(rec->ptr[i]); i++);
+
+	return i == rec->size;
 }
 
 int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
-- 
gitgitgadget

