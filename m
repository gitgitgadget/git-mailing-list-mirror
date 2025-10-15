Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F087E2FE066
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 21:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760563115; cv=none; b=NoRfHseyyk6VajLbphZCvPnwgYH6dt37i/9H0CHh5O+DIzbTUKbSSQR5gHzb/3GIXx3f4fcBb2MgY49xx4fkOh9KB+ufE21eiClBu3AmyKjjTy0caGdBckrg/nuJD8YewTqGdtmP1r0o9N5QF+PKhH5tQ3dvMU4L3ECp4e3bj6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760563115; c=relaxed/simple;
	bh=KcO5AuzvvpuKAAdC277I0f/HeKC+vCSdxlJeQYWTpC0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=UaqKPLrIjE75W9Xoq7trJQsV238o16dEj3QmimKA3K5M6QJuW99vHoMksgUP7WwG0shsUgILPekjVUOZzbraY2tYPnlLz/QINBmlLCaN/w/QHSgaTolJ8TJibJ6ccNlYr+Dwy3QbZkYOf380RGz7TNmAWMV8aUtiuw/KXjKqSrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUac7wNC; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUac7wNC"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b6093f8f71dso4497490a12.3
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 14:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760563113; x=1761167913; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fd//xFoTHnSoulKFQbR5COHcs0yeT5qrOI/gI/qfIQk=;
        b=TUac7wNCVBvAxmQm5XC6PvH4qHg8Zj2vOWPtdxhtMEDSsxio7LrakcALrcZKDdur77
         rmWQc5yLA49qGEaoNflW/LOVN7bSfQ6EKoXQR5ThEu4ZxyIzleevjgvGs612kfdo+MxC
         1TMEM4tze8FpwI/zcWiC6HDC5z0CGMrgHXr/SeimOTpxe6C0R6PRGwYnrjLWZhaALGZJ
         VdXz19c3wPcInzXc1uQPQRE0aA2M8mKBPkah9yhH7Su2BogrEurzHl2mZ/ZsO/enqMvV
         3L0aNCv/qk4cT2SXKDh933A6wnMTpi0yD2ArCyOfPB7adtOwPk7W9MjdnbH/rc8gIEBU
         GnfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760563113; x=1761167913;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fd//xFoTHnSoulKFQbR5COHcs0yeT5qrOI/gI/qfIQk=;
        b=eG24ojAdcr/bnpO4IxCxlx9fH6lrZM04n622oiY9/dvsGm1kHW4r1akLfan/mUoPNG
         TqklzeFJM5Pe2wii1GTc1C8b2HoPYOa1k3cmub8Pd+J0hDqkNSh5vcxDlsMZgBuNboXe
         FlnKAlSA0XIIzy7DF4SK/ar0jnGWTyG0RSTFcDUDXs3d80T1aDSFg5OZtriHlPubHHyG
         zg4hM0GwPBTCf4AT5VPjtPOtYAp0lqXj/8v5dilDEUAKJMOCAFm+zSAzApJV1Gq0bYay
         FHT2uwVTIrM+bbAJCsC6wWbuXymtkyMANt5z4ZNckxRtCM63WrZXOpTX4txVjj+TspS0
         8hHQ==
X-Gm-Message-State: AOJu0YxjmefLxu8yMCWaeeoruL10j70GYe0oDQGZVA6NojySDQSiy2ix
	3qpVWCYtmRl73k6aXl5dLTd689++VliQ2OwPva+bWyQxgsyZVNnCiUPOhvUB3Zu/
X-Gm-Gg: ASbGncvFeY1+TR9/uNQofBB9eYwN58xx3icEw8Sp3iJCjkQQnau4snys7hTX0kyex3g
	ED2+SsBLXETEBdlLvu4SSkFLKPapG14pZSc8FsR44Y6Rig96PF3RxzPtojkco0jgb/Cm+MiDqMk
	uH6IpEs+J1V8j8qWVoUvgBrYq4A6RFoufOmVXQYwJVI6aTW8r143XANp86eAAnEzxjr9KKfv494
	2GjGNwqplUonZ3tTs7bUDpPvx2hGIUKASB5gy7xHg1f1sSaOpo+cPn87LCGq0YENuS0xdEW/UY+
	VdzS5nOsp7bA2EwPgAPNA/Ugb3YX63brF8IQIwYQeJDoz0YxheBfqICp8PnReczRWgDIPvmq5vS
	xoIesGErH2oduTLRcMlQ0anxQ4tudFUe0xrsSOcrwoAxtKPsTgbWK0KPx/Huc3q012ZDhA6M3Q9
	AJ
X-Google-Smtp-Source: AGHT+IEP9g3F9c8Cp/V0qihHH7gvvF+zmmdFROfJL+NAZvh6pjzS9MFNa9oMfdwQqTl+3GYvBv1oww==
X-Received: by 2002:a17:903:2349:b0:290:56e7:8ca9 with SMTP id d9443c01a7336-29056e79048mr198465615ad.52.1760563112559;
        Wed, 15 Oct 2025 14:18:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.161.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099aba062sm5861425ad.98.2025.10.15.14.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 14:18:31 -0700 (PDT)
Message-Id: <4caa6a466977483c42f4e37bd0067dc1ca3b28aa.1760563101.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Oct 2025 21:18:19 +0000
Subject: [PATCH 7/9] xdiff: make xdfile_t.nreff a size_t instead of long
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

size_t is used because nreff describes the number of elements in memory
for rindex.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xprepare.c | 14 +++++++-------
 xdiff/xtypes.h   |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 4ee9fb60cd..c690bafeb1 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -264,7 +264,7 @@ static bool xdl_clean_mmatch(uint8_t const *action, long i, long s, long e) {
  * might be potentially discarded if they appear in a run of discardable.
  */
 static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2) {
-	long i, nm, nreff, mlim;
+	long i, nm, mlim;
 	xrecord_t *recs;
 	xdlclass_t *rcrec;
 	uint8_t *action1 = NULL, *action2 = NULL;
@@ -307,29 +307,29 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	 * Use temporary arrays to decide if changed[i] should remain
 	 * false, or become true.
 	 */
-	for (nreff = 0, i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart];
+	xdf1->nreff = 0;
+	for (i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart];
 	     i <= xdf1->dend; i++, recs++) {
 		if (action1[i] == KEEP ||
 		    (action1[i] == INVESTIGATE && !xdl_clean_mmatch(action1, i, xdf1->dstart, xdf1->dend))) {
-			xdf1->rindex[nreff++] = i;
+			xdf1->rindex[xdf1->nreff++] = i;
 			/* changed[i] remains false, i.e. keep */
 		} else
 			xdf1->changed[i] = true;
 			/* i.e. discard */
 	}
-	xdf1->nreff = nreff;
 
-	for (nreff = 0, i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart];
+	xdf2->nreff = 0;
+	for (i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart];
 	     i <= xdf2->dend; i++, recs++) {
 		if (action2[i] == KEEP ||
 		    (action2[i] == INVESTIGATE && !xdl_clean_mmatch(action2, i, xdf2->dstart, xdf2->dend))) {
-			xdf2->rindex[nreff++] = i;
+			xdf2->rindex[xdf2->nreff++] = i;
 			/* changed[i] remains false, i.e. keep */
 		} else
 			xdf2->changed[i] = true;
 			/* i.e. discard */
 	}
-	xdf2->nreff = nreff;
 
 cleanup:
 	xdl_free(action1);
diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index 179ae2ae89..e9473bfd45 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -50,7 +50,7 @@ typedef struct s_xdfile {
 	size_t nrec;
 	bool *changed;
 	long *rindex;
-	long nreff;
+	size_t nreff;
 	ssize_t dstart, dend;
 } xdfile_t;
 
-- 
gitgitgadget

