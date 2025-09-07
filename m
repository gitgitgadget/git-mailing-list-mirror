Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE1F29BD95
	for <git@vger.kernel.org>; Sun,  7 Sep 2025 19:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757274329; cv=none; b=uk8/3tb1Olpto+UXhMj45GEIS4DCUVHRNdQNQMsTWNV+3AdVLRT4Vp9ZGXARDvCjzDwjFRr5Uq2BwVCQXfX7FJjwe3egIAuW29hmy+6KkpS8n45c270uV5GmppajIUSlnZYaHgNgDH3jSRBEYshzduufamrC4ptYT8SWDBIoFVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757274329; c=relaxed/simple;
	bh=LulYTHOIoVWZQlPNGV0ofsf8NowW0L4RGDg7h2e7zRg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HtyDwF2W8xOMWDfkw9dA+yQtWCo/kv0PEqJxsUp+l1qu3Oy/GS2g6yxMucZ8XupA3nW3MPubwjc/2cmvPmmOpiD5C0MlMIzjTkO2UdHeubuKkm0mpl8MXb1pJ/yLG0CUCzsHbWg1XQVuz784+py63NSzzpXuwqFh+KagH36CVfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngTxqBe0; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngTxqBe0"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-81076e81aabso270249885a.3
        for <git@vger.kernel.org>; Sun, 07 Sep 2025 12:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757274326; x=1757879126; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nye84mA/syqyu01akUe0BPNIR+/SMK1wU+8YHsVp33M=;
        b=ngTxqBe0yI7CBLfnLqUGvNsduBofn1G+afvGbcekmhQAeW1Pqd4jddnTvrNAlJ95jl
         gE7BHyzFVFyHTlHaS/c5Wc2vp/31AK3EVS2qIC7gxPTwymOTYm07Xt6Ic6uDCfwy4x2t
         hZ1JYKTCOfTmKCLcTbM70osw+OqKzPKlD0YYzAG7/zn7VPUPrqFG8H5gBZUzg397R4b+
         pIr6iwLuWTyW3dPkfC/aXUUK2EaSiQwWw8gc0iQmgf5yLPv4q57jPOqJ213F/pDRkQOB
         k2m27n1kNSX/FJafCRUXzPyqHEGV558wuwiuEeYrMl223JA78bu2J/42vH/ku/ygvYI5
         +HSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757274326; x=1757879126;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nye84mA/syqyu01akUe0BPNIR+/SMK1wU+8YHsVp33M=;
        b=YWLEJufIBgVdBf5FxCu7kdAaCaqDvB+Y2fqiO3HTFf5MbVWk4/7jRzBNWK2D3tz8Xf
         56lTSYGnNBxEgil7OithMB7F0HvuQNvnU/e3R+HrUs1ROPri4ZcZuRgkJa0g36OJsGcF
         RK5+KKIwCivFd/LUsKvzm3pY4L3ITf/45phhnTqwG0mvUaTwCLtzRjjOGvuLkbe5LpDF
         84XWv12iugdFdUXbkxWefrvL2OnmBnGoBJsqDUxrXqFyJhWQhn1io8N6OatVSILnxjw5
         LsjjGXSSA3oFXogHo7JNvprGqoffNIExcoeW6QE7Svp7b2g/qCuBGManfqsemWPkdz0J
         StVw==
X-Gm-Message-State: AOJu0Yw1JEfzPxmeSia4dVQGqGEQYuG5qbO7veT2VpgCKy9Z/hNLyIsN
	h45+91/3ZN8F1N2BiXqQ7wsT3/ysgVbkSo0eijB5RtNka+kk5Vfd6DUVav7Ylp9j
X-Gm-Gg: ASbGncs1YFU0gU2+l/SSVewYqqFMeuKXcAqRJJfcNEHcRWLNlN2YWg67w3UH8fC50W+
	UBgW2Mi/UaeTAfSwDk1cJ/zyijmCwg1EZT3NAmybcvltLyDUyIE7afwIQX3tCvgRYr4IkaIu6in
	2X6E0tf16QSilg5hEybIrEDna6gpM1kboUIzudfRGpa6Zb0bC8zZxGd1YWpySTjfgwp6G6SfZrI
	2ATZy5EDt+642aqrjq2/tFejGOm2yjy8RjFBw9sxC/TvfLbIekkw4p+be4wDBmwgjRap2kC6ush
	5Wu/Z7yjFpaPR8ZiNCJAlDTmX0e3esg3L3rWy/JOfvGY+LdZz2SffGZCl0aS1ukoPrc96oOZnVq
	oMfHAngsaf3LwNbmKNGG6pqk=
X-Google-Smtp-Source: AGHT+IF+noAFsuQ+uXpOlPTMvxFhNq91smJkcrVlUJabqUwmWVmSabGyXI+mGF/Puo8waN1zIGsGTg==
X-Received: by 2002:a05:620a:170d:b0:811:9f4a:213d with SMTP id af79cd13be357-813c28398e7mr466023385a.63.1757274326436;
        Sun, 07 Sep 2025 12:45:26 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.28.97])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8122d0cdd43sm478200785a.67.2025.09.07.12.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 12:45:25 -0700 (PDT)
Message-Id: <ab17d8c23f0ca48374416ec1eb34128585795736.1757274320.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com>
References: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 07 Sep 2025 19:45:07 +0000
Subject: [PATCH 04/17] xdiff: delete xdl_get_rec() in xemit
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

This function aliases the fields of xrecord_t, which makes it harder
to track the usages of those fields. Delete it.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xemit.c | 38 +++++++++++++-------------------------
 1 file changed, 13 insertions(+), 25 deletions(-)

diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index 1d40c9cb40..2161ac3cd0 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -22,23 +22,13 @@
 
 #include "xinclude.h"
 
-static long xdl_get_rec(xdfile_t *xdf, long ri, char const **rec) {
 
-	*rec = xdf->recs[ri]->ptr;
-
-	return xdf->recs[ri]->size;
-}
-
-
-static int xdl_emit_record(xdfile_t *xdf, long ri, char const *pre, xdemitcb_t *ecb) {
-	long size, psize = strlen(pre);
-	char const *rec;
-
-	size = xdl_get_rec(xdf, ri, &rec);
-	if (xdl_emit_diffrec(rec, size, pre, psize, ecb) < 0) {
+static int xdl_emit_record(xdfile_t *xdf, long ri, char const *pre, xdemitcb_t *ecb)
+{
+	xrecord_t *rec = xdf->recs[ri];
 
+	if (xdl_emit_diffrec(rec->ptr, rec->size, pre, strlen(pre), ecb) < 0)
 		return -1;
-	}
 
 	return 0;
 }
@@ -120,11 +110,11 @@ static long def_ff(const char *rec, long len, char *buf, long sz)
 static long match_func_rec(xdfile_t *xdf, xdemitconf_t const *xecfg, long ri,
 			   char *buf, long sz)
 {
-	const char *rec;
-	long len = xdl_get_rec(xdf, ri, &rec);
+	xrecord_t *rec = xdf->recs[ri];
+
 	if (!xecfg->find_func)
-		return def_ff(rec, len, buf, sz);
-	return xecfg->find_func(rec, len, buf, sz, xecfg->find_func_priv);
+		return def_ff(rec->ptr, rec->size, buf, sz);
+	return xecfg->find_func(rec->ptr, rec->size, buf, sz, xecfg->find_func_priv);
 }
 
 static int is_func_rec(xdfile_t *xdf, xdemitconf_t const *xecfg, long ri)
@@ -160,14 +150,12 @@ static long get_func_line(xdfenv_t *xe, xdemitconf_t const *xecfg,
 
 static int is_empty_rec(xdfile_t *xdf, long ri)
 {
-	const char *rec;
-	long len = xdl_get_rec(xdf, ri, &rec);
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

