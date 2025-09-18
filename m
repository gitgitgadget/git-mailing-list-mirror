Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A552A2D662D
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 23:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758239802; cv=none; b=S5YADp4SuCgxN3VOXb63faIngcEY596inkZyb7aYDRG6QjUVetv/B9KT9u7OFcchlEOXbshv7Tifoj6zEYMB7ngHpy3llSNp87B0KrrtpECwKbVpUbPNI+SQLZO819FlTFUYMDgHXlEo8IeQ3Se5XrCOpE0+ZJBPkVvs3YnNFTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758239802; c=relaxed/simple;
	bh=zejrKiRM2CWHXswyfUP3N98+xfqSySoV4HBV8AsHsIw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZpUdkE6OSzZAlsUVnFec2BrbtAtLWKB6ezOkpPEmtcU3IU91QWDZSimHAQTbFvx5ae/Sd8TQVhfv361Jote7HrnWtyO+sJRDDWW/U/arMFq2juJaRJ8+ZBhB2zPIwK4/XaPp+anPCZKkiSol8ivkVkyh745ok3eRclc68Ma0U5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJ1/nip+; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJ1/nip+"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-78f15d5846dso17094606d6.0
        for <git@vger.kernel.org>; Thu, 18 Sep 2025 16:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758239799; x=1758844599; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fB5dXkFmZhV/7QB2sUSgNwH6HYy+KsDLd6IWSEcjAeo=;
        b=HJ1/nip+MD8zNm15jLFvnW/Gau/ePf+ehUQX7WTn9UrsnhxIBwtleme+1fJZWMlBHf
         0Hzfg3jJu1E2ZA1yJXrEKWT/g/TUaaVGNjNFfMUZ7UUXjUAGKQpTWktF/4kxaN4z6ROX
         J1F+yeVIj9BBp3NGq4bKDDc4eAhfxvsEKFGLqXcdKLrsm/vnhNKoifnJfMybeZquj9Fw
         Qb5waWbPadda7NSXf3M4sWsCHan+qI1mj+j28V6WBhuYw397eSzSBHQ+C/+F1Saray6g
         isduBvpy+SIn6CdkJgmSf5XGoZWqsG4XToMy4VuUU8DS4UooMQpmL+jzcRzkglNROjy2
         MIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758239799; x=1758844599;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fB5dXkFmZhV/7QB2sUSgNwH6HYy+KsDLd6IWSEcjAeo=;
        b=xQlYmas3Ka0FlIBEfHdUy6Qw7HYuSZfsmdU5umYvFF5cs5wx2H7vLvXVCm3XQtqOzU
         Gb3lPQnzT/WcXApYbZ20lhAqoG4owyIKdlEK9FpiyIVBkBsweeW1gWIK8S44FjqYi5ZA
         hW0eTAxNZmc3XNSIFSGZEEWaWFVk36SQm0B7Jqo8BEeprq46r6KbE3RpjnqdXEIi33Y1
         opUQDq4CB12EWncpIgGUNoj6EiRy3vZrXUgoSBmHacPH7B2hQpXh/iJk2sEKd3Sp5Hju
         0Vmj8fu1W3tMSyCc/6KA94pd13Qxu/QfjeO5WMsH1dKrQlMRHSruomoZeeBRWUO0r8s/
         AnmA==
X-Gm-Message-State: AOJu0Yw2wQ+22OOWmgnA0mf7bujNWbeJEgEejHOOpM9keO7502JIfayj
	uSergSnzIqj52bTE+kUNCAyhWI9DojPzgahW1/+Uc9zypg/gIgzkCiC0J/VOfFpZ
X-Gm-Gg: ASbGncvW7fgAss2VwSWp6Ncef4CjdYuA6PaxyJlq9kAAKweXJGvpLu2VKCHbhp7QJK5
	9N8YzTFyU9HFqS9qRiO5pz/pDlujj9+sy34R4pL4mBnDSlCX3iB10gAxKDlPeDHoGF8uT4ZmUJs
	fH3EC3HwhLb4cI8lXoqRUKYc7dZ7qMo2lqXET9LD+92BzQG2/UAkNfLCdeu72p+8zAW0SQfizBX
	cNr/EFh+TqYKivmwiucDPC0KAkbFSVtG5fUSJTci1v0leiB1hfQF2DtNCfn8VGFz1hwOUHwZBtp
	rgpcbiAeqiVuTicWjktkiul01xmmMwIFUTe8tDQay7v8ywwNNJThkloZb1XnaAYxw1aWJLbTVcB
	utkYa2qZe09F5MaE8gqOFm4Ws2uM4ewQ96gaWiky88U0=
X-Google-Smtp-Source: AGHT+IEWgz26ojO97nkS8oqioR5O8xVXqI4KGJyd94acJgcDrXbcsK5FoKhLxuS3TBPb2qre8c+wUg==
X-Received: by 2002:a05:6214:2a45:b0:764:6a24:312e with SMTP id 6a1803df08f44-7991f60677fmr13696386d6.57.1758239799133;
        Thu, 18 Sep 2025 16:56:39 -0700 (PDT)
Received: from [127.0.0.1] ([40.76.117.249])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-793548c63desm20366156d6.57.2025.09.18.16.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 16:56:38 -0700 (PDT)
Message-Id: <807ce3e5aae0253dd58c7a4d0bd04ca341b070c8.1758239789.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v2.git.git.1758239789.gitgitgadget@gmail.com>
References: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com>
	<pull.2048.v2.git.git.1758239789.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Sep 2025 23:56:24 +0000
Subject: [PATCH v2 05/10] xdiff: delete struct diffdata_t
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

Every field in this struct is an alias for a certain field in xdfile_t.

diffdata_t.nrec   -> xdfile_t.nreff
diffdata_t.ha     -> xdfile_t.ha
diffdata_t.rindex -> xdfile_t.rindex
diffdata_t.rchg   -> xdfile_t.rchg

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xdiffi.c | 32 ++++++++------------------------
 xdiff/xdiffi.h | 11 ++---------
 2 files changed, 10 insertions(+), 33 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 5a96e36dfb..bbf0161f84 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -257,10 +257,10 @@ static long xdl_split(unsigned long const *ha1, long off1, long lim1,
  * sub-boxes by calling the box splitting function. Note that the real job
  * (marking changed lines) is done in the two boundary reaching checks.
  */
-int xdl_recs_cmp(diffdata_t *dd1, long off1, long lim1,
-		 diffdata_t *dd2, long off2, long lim2,
+int xdl_recs_cmp(xdfile_t *xdf1, long off1, long lim1,
+		 xdfile_t *xdf2, long off2, long lim2,
 		 long *kvdf, long *kvdb, int need_min, xdalgoenv_t *xenv) {
-	unsigned long const *ha1 = dd1->ha, *ha2 = dd2->ha;
+	unsigned long const *ha1 = xdf1->ha, *ha2 = xdf2->ha;
 
 	/*
 	 * Shrink the box by walking through each diagonal snake (SW and NE).
@@ -273,17 +273,11 @@ int xdl_recs_cmp(diffdata_t *dd1, long off1, long lim1,
 	 * be obviously changed.
 	 */
 	if (off1 == lim1) {
-		char *rchg2 = dd2->rchg;
-		long *rindex2 = dd2->rindex;
-
 		for (; off2 < lim2; off2++)
-			rchg2[rindex2[off2]] = 1;
+			xdf2->rchg[xdf2->rindex[off2]] = 1;
 	} else if (off2 == lim2) {
-		char *rchg1 = dd1->rchg;
-		long *rindex1 = dd1->rindex;
-
 		for (; off1 < lim1; off1++)
-			rchg1[rindex1[off1]] = 1;
+			xdf1->rchg[xdf1->rindex[off1]] = 1;
 	} else {
 		xdpsplit_t spl;
 		spl.i1 = spl.i2 = 0;
@@ -300,9 +294,9 @@ int xdl_recs_cmp(diffdata_t *dd1, long off1, long lim1,
 		/*
 		 * ... et Impera.
 		 */
-		if (xdl_recs_cmp(dd1, off1, spl.i1, dd2, off2, spl.i2,
+		if (xdl_recs_cmp(xdf1, off1, spl.i1, xdf2, off2, spl.i2,
 				 kvdf, kvdb, spl.min_lo, xenv) < 0 ||
-		    xdl_recs_cmp(dd1, spl.i1, lim1, dd2, spl.i2, lim2,
+		    xdl_recs_cmp(xdf1, spl.i1, lim1, xdf2, spl.i2, lim2,
 				 kvdf, kvdb, spl.min_hi, xenv) < 0) {
 
 			return -1;
@@ -318,7 +312,6 @@ int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 	long ndiags;
 	long *kvd, *kvdf, *kvdb;
 	xdalgoenv_t xenv;
-	diffdata_t dd1, dd2;
 	int res;
 
 	if (xdl_prepare_env(mf1, mf2, xpp, xe) < 0)
@@ -357,16 +350,7 @@ int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 	xenv.snake_cnt = XDL_SNAKE_CNT;
 	xenv.heur_min = XDL_HEUR_MIN_COST;
 
-	dd1.nrec = xe->xdf1.nreff;
-	dd1.ha = xe->xdf1.ha;
-	dd1.rchg = xe->xdf1.rchg;
-	dd1.rindex = xe->xdf1.rindex;
-	dd2.nrec = xe->xdf2.nreff;
-	dd2.ha = xe->xdf2.ha;
-	dd2.rchg = xe->xdf2.rchg;
-	dd2.rindex = xe->xdf2.rindex;
-
-	res = xdl_recs_cmp(&dd1, 0, dd1.nrec, &dd2, 0, dd2.nrec,
+	res = xdl_recs_cmp(&xe->xdf1, 0, xe->xdf1.nreff, &xe->xdf2, 0, xe->xdf2.nreff,
 			   kvdf, kvdb, (xpp->flags & XDF_NEED_MINIMAL) != 0,
 			   &xenv);
 	xdl_free(kvd);
diff --git a/xdiff/xdiffi.h b/xdiff/xdiffi.h
index 126c9d8ff4..49e52c67f9 100644
--- a/xdiff/xdiffi.h
+++ b/xdiff/xdiffi.h
@@ -24,13 +24,6 @@
 #define XDIFFI_H
 
 
-typedef struct s_diffdata {
-	long nrec;
-	unsigned long const *ha;
-	long *rindex;
-	char *rchg;
-} diffdata_t;
-
 typedef struct s_xdalgoenv {
 	long mxcost;
 	long snake_cnt;
@@ -46,8 +39,8 @@ typedef struct s_xdchange {
 
 
 
-int xdl_recs_cmp(diffdata_t *dd1, long off1, long lim1,
-		 diffdata_t *dd2, long off2, long lim2,
+int xdl_recs_cmp(xdfile_t *xdf1, long off1, long lim1,
+		 xdfile_t *xdf2, long off2, long lim2,
 		 long *kvdf, long *kvdb, int need_min, xdalgoenv_t *xenv);
 int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 		xdfenv_t *xe);
-- 
gitgitgadget

