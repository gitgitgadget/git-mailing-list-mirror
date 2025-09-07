Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B0229D267
	for <git@vger.kernel.org>; Sun,  7 Sep 2025 19:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757274332; cv=none; b=tuRlMJNPEKoRPOLbTDsWeH3tnGtHB/qa7KBJDi94aS58pP8Ws9kM26Y9JMOi795WD3HLpmjNWn6ejFg9f/zvSwElUSUnYnmMdbMqAvFSsdY9esqgZtDTHxcKK4HfuQjtTrB78VpFPl0XaqNgZVXA//7PoIHc7pnhBnBG0c/JjVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757274332; c=relaxed/simple;
	bh=YhKU4Dd6CseVzO/uR/JuVesLzZAOtAbsQ5/6TFjWZQs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nGqVDlA64+sIoaag3VHiOkWx/DhNa2fRAfteTi29T4wZQ/g4wrztIfEUO26cHZTWuOhp2mZcb3dgQV337J7FiPMbftN3CPbNNhL3nAx2S6vY1HUtCWYmJ2jidXNnQ2ByttwpFZx8k6GKAbSD+EJiWyx5U90fU4OnhmTYbWochBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=duAxkTzo; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duAxkTzo"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8173e8effa1so20063885a.0
        for <git@vger.kernel.org>; Sun, 07 Sep 2025 12:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757274329; x=1757879129; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9pdnK5krzEsFGQ/vixumX6Hueg6fYWhnywLbJlUUXwI=;
        b=duAxkTzojl6Ts9H5zmKFIJe/+wxFTTInlX1F5vj9mNl+85ahuuHmBJ+PYWM2vGk37m
         5khpR2g9lGRV7euVRZ7JGRBZ79yvqFEa0gir58hoIwyy6dC3f3E5ID1191tHulksXI1U
         cYWrdKXs4njRKb2NHeAQ4vnlqkEL9a3h1jJuJ0hRYbLZ/nQxUQObRwU5mIfXnx6mEzzB
         osJDV2zHJchp2SqAshMuFiuPvgnbOe7jP9P/bbZDye0p7owJ9CEmfHHh95QyzJD0qzTB
         n2wCajlVAXkSjgDAw87/kolnGwukLO37/dqewfaFRIp/WaDTAMOfesBatQcY/0rzwDq9
         BS4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757274329; x=1757879129;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9pdnK5krzEsFGQ/vixumX6Hueg6fYWhnywLbJlUUXwI=;
        b=lwQmoUckalqzL1UNScYCPE3i30jbNtBc1VwP9Tw5P1aQ2Ca8kpK7jyvftn9LgBNFLA
         Cb6yk0TjzR0ZRu9DT3y8sVZKddLJuywJ0yZVIOl3lSWmaK15o6Bxt6RK9rq57exiLz3L
         6bZrP/w2bbhFLi9vZU270XRBpEfX9tULOPQR8uYrNrbg+KbYvFdI26/q3d+2cO+tjbTd
         /HotATDG+YVkpq3U0mDpoUHffhxYLVmECws4SrUjKk7ti5CqCJ41GeDIs78o12j9/9QO
         0GLdReR4LIttlh1tMYWrq6iIQzwdeCVFfXRQC+IfUjT7r0ik9zb6SUuAvpZrU4xvOd0g
         ilOA==
X-Gm-Message-State: AOJu0YxkDbC8GBjiA8XdnB6VKTvy9D9k+ChoPM3WfL7xXf6PRn6RzCPI
	jVHuFv1SPlMDObRq+EXFhh0YtVEUNuCHgD9IkWcmND7QykG7PjIqrSv0xh2vMaLg
X-Gm-Gg: ASbGncuNiNgGeUSwsN9R5iaoopFMLCVlzW/gi6K/9RJ2O0FCF+rrOgu3ZLVqKikJBpm
	ew9wAks8mNs3armt8RXsK5raz3lnuBc4+thIpBnLclHuB9zDs1RojM87NOVDiZTkUtFAuFlNlT6
	QT1Gm+NTaIE9WWQ+Reewd2q5fbOdvdUQJTQiAeCVgH2WF+qsvBqiTZoLqosGAqgFlhmc3kjBvuN
	fDjtkH/5rvNAsFVC/pt+R+gXWNxiW9Do7b/dT1GAK5wyJVwuunQJ77QEjTwT8InvROw3agZH4uG
	LoSC+TCQx0s+kHV7/TgUh+eZoN00XNkTKEmxorqvfFX5ihYrVRx+89TCTcdivnsTePgjlOx/U2V
	mgGSRMligQVssRDMZ9BWgcR1ONVFKZDoHVg==
X-Google-Smtp-Source: AGHT+IFtvqRGFktJDn45aLXvds/dlX9yUiUHJJCnPOkSc/QnJUfPh9xz+JE29q4K+kPi8PUfSoS1UA==
X-Received: by 2002:a05:620a:a81a:b0:815:37b0:bc84 with SMTP id af79cd13be357-81537b0dde7mr422279385a.84.1757274328837;
        Sun, 07 Sep 2025 12:45:28 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.28.97])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-816be049587sm150467485a.70.2025.09.07.12.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 12:45:28 -0700 (PDT)
Message-Id: <bff456860268a833078b273ff34e3bc26a0c3975.1757274320.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com>
References: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 07 Sep 2025 19:45:09 +0000
Subject: [PATCH 06/17] xdiff: delete redundant array xdfile_t.ha
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

When 0 <= i < xdfile_t.nreff the following is true:
xdfile_t.ha[i] == xdfile_t.recs[xdfile_t.rindex[i]]

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xdiffi.c   | 24 ++++++++++++++----------
 xdiff/xprepare.c | 12 ++----------
 xdiff/xtypes.h   |  1 -
 3 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index bbf0161f84..11cd090b53 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -22,6 +22,11 @@
 
 #include "xinclude.h"
 
+static unsigned long get_hash(xdfile_t *xdf, long index)
+{
+	return xdf->recs[xdf->rindex[index]]->ha;
+}
+
 #define XDL_MAX_COST_MIN 256
 #define XDL_HEUR_MIN_COST 256
 #define XDL_LINE_MAX (long)((1UL << (CHAR_BIT * sizeof(long) - 1)) - 1)
@@ -42,8 +47,8 @@ typedef struct s_xdpsplit {
  * using this algorithm, so a little bit of heuristic is needed to cut the
  * search and to return a suboptimal point.
  */
-static long xdl_split(unsigned long const *ha1, long off1, long lim1,
-		      unsigned long const *ha2, long off2, long lim2,
+static long xdl_split(xdfile_t *xdf1, long off1, long lim1,
+		      xdfile_t *xdf2, long off2, long lim2,
 		      long *kvdf, long *kvdb, int need_min, xdpsplit_t *spl,
 		      xdalgoenv_t *xenv) {
 	long dmin = off1 - lim2, dmax = lim1 - off2;
@@ -87,7 +92,7 @@ static long xdl_split(unsigned long const *ha1, long off1, long lim1,
 				i1 = kvdf[d + 1];
 			prev1 = i1;
 			i2 = i1 - d;
-			for (; i1 < lim1 && i2 < lim2 && ha1[i1] == ha2[i2]; i1++, i2++);
+			for (; i1 < lim1 && i2 < lim2 && get_hash(xdf1, i1) == get_hash(xdf2, i2); i1++, i2++);
 			if (i1 - prev1 > xenv->snake_cnt)
 				got_snake = 1;
 			kvdf[d] = i1;
@@ -124,7 +129,7 @@ static long xdl_split(unsigned long const *ha1, long off1, long lim1,
 				i1 = kvdb[d + 1] - 1;
 			prev1 = i1;
 			i2 = i1 - d;
-			for (; i1 > off1 && i2 > off2 && ha1[i1 - 1] == ha2[i2 - 1]; i1--, i2--);
+			for (; i1 > off1 && i2 > off2 && get_hash(xdf1, i1 - 1) == get_hash(xdf2, i2 - 1); i1--, i2--);
 			if (prev1 - i1 > xenv->snake_cnt)
 				got_snake = 1;
 			kvdb[d] = i1;
@@ -159,7 +164,7 @@ static long xdl_split(unsigned long const *ha1, long off1, long lim1,
 				if (v > XDL_K_HEUR * ec && v > best &&
 				    off1 + xenv->snake_cnt <= i1 && i1 < lim1 &&
 				    off2 + xenv->snake_cnt <= i2 && i2 < lim2) {
-					for (k = 1; ha1[i1 - k] == ha2[i2 - k]; k++)
+					for (k = 1; get_hash(xdf1, i1 - k) == get_hash(xdf2, i2 - k); k++)
 						if (k == xenv->snake_cnt) {
 							best = v;
 							spl->i1 = i1;
@@ -183,7 +188,7 @@ static long xdl_split(unsigned long const *ha1, long off1, long lim1,
 				if (v > XDL_K_HEUR * ec && v > best &&
 				    off1 < i1 && i1 <= lim1 - xenv->snake_cnt &&
 				    off2 < i2 && i2 <= lim2 - xenv->snake_cnt) {
-					for (k = 0; ha1[i1 + k] == ha2[i2 + k]; k++)
+					for (k = 0; get_hash(xdf1, i1 + k) == get_hash(xdf2, i2 + k); k++)
 						if (k == xenv->snake_cnt - 1) {
 							best = v;
 							spl->i1 = i1;
@@ -260,13 +265,12 @@ static long xdl_split(unsigned long const *ha1, long off1, long lim1,
 int xdl_recs_cmp(xdfile_t *xdf1, long off1, long lim1,
 		 xdfile_t *xdf2, long off2, long lim2,
 		 long *kvdf, long *kvdb, int need_min, xdalgoenv_t *xenv) {
-	unsigned long const *ha1 = xdf1->ha, *ha2 = xdf2->ha;
 
 	/*
 	 * Shrink the box by walking through each diagonal snake (SW and NE).
 	 */
-	for (; off1 < lim1 && off2 < lim2 && ha1[off1] == ha2[off2]; off1++, off2++);
-	for (; off1 < lim1 && off2 < lim2 && ha1[lim1 - 1] == ha2[lim2 - 1]; lim1--, lim2--);
+	for (; off1 < lim1 && off2 < lim2 && get_hash(xdf1, off1) == get_hash(xdf2, off2); off1++, off2++);
+	for (; off1 < lim1 && off2 < lim2 && get_hash(xdf1, lim1 - 1) == get_hash(xdf2, lim2 - 1); lim1--, lim2--);
 
 	/*
 	 * If one dimension is empty, then all records on the other one must
@@ -285,7 +289,7 @@ int xdl_recs_cmp(xdfile_t *xdf1, long off1, long lim1,
 		/*
 		 * Divide ...
 		 */
-		if (xdl_split(ha1, off1, lim1, ha2, off2, lim2, kvdf, kvdb,
+		if (xdl_split(xdf1, off1, lim1, xdf2, off2, lim2, kvdf, kvdb,
 			      need_min, &spl, xenv) < 0) {
 
 			return -1;
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 91b0ed54e0..59730989a3 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -134,7 +134,6 @@ static void xdl_free_ctx(xdfile_t *xdf)
 
 	xdl_free(xdf->rindex);
 	xdl_free(xdf->rchg - 1);
-	xdl_free(xdf->ha);
 	xdl_free(xdf->recs);
 	xdl_cha_free(&xdf->rcha);
 }
@@ -147,7 +146,6 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 	char const *blk, *cur, *top, *prev;
 	xrecord_t *crec;
 
-	xdf->ha = NULL;
 	xdf->rindex = NULL;
 	xdf->rchg = NULL;
 	xdf->recs = NULL;
@@ -182,8 +180,6 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 	    (XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF)) {
 		if (!XDL_ALLOC_ARRAY(xdf->rindex, xdf->nrec + 1))
 			goto abort;
-		if (!XDL_ALLOC_ARRAY(xdf->ha, xdf->nrec + 1))
-			goto abort;
 	}
 
 	xdf->rchg += 1;
@@ -301,9 +297,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	     i <= xdf1->dend; i++, recs++) {
 		if (dis1[i] == 1 ||
 		    (dis1[i] == 2 && !xdl_clean_mmatch(dis1, i, xdf1->dstart, xdf1->dend))) {
-			xdf1->rindex[nreff] = i;
-			xdf1->ha[nreff] = (*recs)->ha;
-			nreff++;
+			xdf1->rindex[nreff++] = i;
 		} else
 			xdf1->rchg[i] = 1;
 	}
@@ -313,9 +307,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	     i <= xdf2->dend; i++, recs++) {
 		if (dis2[i] == 1 ||
 		    (dis2[i] == 2 && !xdl_clean_mmatch(dis2, i, xdf2->dstart, xdf2->dend))) {
-			xdf2->rindex[nreff] = i;
-			xdf2->ha[nreff] = (*recs)->ha;
-			nreff++;
+			xdf2->rindex[nreff++] = i;
 		} else
 			xdf2->rchg[i] = 1;
 	}
diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index 8b8467360e..85848f1685 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -52,7 +52,6 @@ typedef struct s_xdfile {
 	char *rchg;
 	long *rindex;
 	long nreff;
-	unsigned long *ha;
 } xdfile_t;
 
 typedef struct s_xdfenv {
-- 
gitgitgadget

