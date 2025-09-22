Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41ED311594
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 19:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758570718; cv=none; b=sMXCjpSqdv6gkcQuNDDGGFFXqoxdqQs9ntYAxqddW7lKUnx0eTg4/jU9+Rm6f0fqjcnxoTpbd39NMV9RCv0hAwZckwDG9P8pa5gRcLJVVAqmyy6AV9l63epL40hROhUgGM3xa5YdjG0QM6JA0OHCQHYaN4GroEPJBjfXNPSB3nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758570718; c=relaxed/simple;
	bh=4ffyndziyhHIuHeYG009hlUjNuYdogIWeR/9qL7mtsQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=TgrLRleUvW8p/gsm7sE4DrjLWsWF2+emSgpVPRW6eEUGo8VySPbbqXbLZMg8AWF1tqhC5jSu3Z/52F3Eqt+SEEIKGYdm6lMoO4FW89GPMuigxc+fuSjPmRjxWryvpHJPhYLrSJkzum41YYFzIKxVey5YEwyEk/iFCnDjhVFqq44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUa1X5u+; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUa1X5u+"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-424da17e309so29023855ab.2
        for <git@vger.kernel.org>; Mon, 22 Sep 2025 12:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758570715; x=1759175515; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tfMvptJJvfkRovwlo/33OdZap/BiQk4tTTuyNi1QMCY=;
        b=hUa1X5u+UBkTLT0cvl9bZFX4iZ6NT/PN4IpKBTYzXhyIA5D+q1ooRz6d3LzIV88qCl
         ftY/jlEqThOYbsL6VRK2ywi3ICxt7vRxwt7mqm7FiN9hQkwCwbbF092LlCF+CAb4i1hh
         TuRJ4jhm51hUo1ZCoDy2etv0FrORigjyTPDMZrQHz5aWjYn+FrUoiPj7h5BjbGGGIW8Z
         H9W6T2G3XIvFVSo7YDT9u4H52d+ZUvZbFLPxf0D/AolV2ZUtwCOjFB0dRhcCjg0x7XXO
         XWhSEpkn8kMlvKmHstbyYG6R+nGljrCcjnyElC5F4iDkRrIIwR+EDG6JBDhx3eVWPJJA
         4vyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758570715; x=1759175515;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tfMvptJJvfkRovwlo/33OdZap/BiQk4tTTuyNi1QMCY=;
        b=ev9TN4EfD7oGAw+U69Ojh6/FDtXPwHt6M55ZMY+qYVzE0MH6mG4ip1NhNOc2rvtnwJ
         Ba2eDlR7z7nLuwwasnHNP2UJc7yqv43YOfBLi8J/XmtuUhTisbtYLdzGZkbkfTmVPYfw
         6YN2sGR1NWyh+TX6SVRDKjzle7wyeXndEaw1r+wwOJheJxwppe21xl+qfCfbp84F0Bpq
         nbQtqr7WPjMDClN8GztvXAJg8TzcJ34c9qz1UIMk+kqWGoMIMXo+ZdPaj3KfmzU377Vj
         Hpchp7BTYiHgb4J5iHjX4Er8bzN8aCRyjOXK70IdZsQb9YgoLvBxC9T1kd9STyfGflDR
         oMJw==
X-Gm-Message-State: AOJu0YyQCOkkddwQCfUxB0nfA1pzZD9xMOZQnpBbPH0iuOmMq1RC4fqD
	qBxPEFyv96sco0vP5owVf2JakQ+4f1GuE+mgLgZzMRnujUlm1gdXq0UCQ9VvcA==
X-Gm-Gg: ASbGncsvs/cGCJtHxxcFxtuel4V0exRU+0F8s0GgZ4OuQjksH9lTGScB8fUug07IhO4
	Qajy/ogjhr2nzFvMdptiuyNHBEtwOaTic2/CrcNXdSG6fFEixSqp/gtdbisn9izWbgPb9vZXamL
	7eDV3/664ohbBBImiVCNZRGrG1nSil9EwHfYt9tLyScl8ry5x6CxYOonAhQo23sBRJzS7ZY2G9M
	NQaZ1dyjHSanIeIPhKg5d4VkxIwN5MgXGq2Lq3O82yt3y+K8SrkaZwz7GFtrQScMiAAjlNYiyDQ
	vjDtyugSSjIdZJy3akmFeH7+OZtp4xRTlDWaSPDwy8e+NbnCoKNfULg8LrLasOmDbmsHeashPc0
	VsFP8iUiI5Edy4oL0usIiiPr8Tw==
X-Google-Smtp-Source: AGHT+IE6Q4OI0dyWYT98Kt49zyGG+f1empPlskgawY1BmL+ytw/JIJEPUlA0bixSffnkdPNVo0262A==
X-Received: by 2002:a05:6e02:1487:b0:424:388:6ced with SMTP id e9e14a558f8ab-42581e3dfdamr2594885ab.14.1758570715431;
        Mon, 22 Sep 2025 12:51:55 -0700 (PDT)
Received: from [127.0.0.1] ([132.196.80.135])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-55e58af148esm1445620173.5.2025.09.22.12.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 12:51:54 -0700 (PDT)
Message-Id: <4ef7f243e9aca64f2deef0b5d578dc6c2788e4a8.1758570701.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
References: <pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com>
	<pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 22 Sep 2025 19:51:36 +0000
Subject: [PATCH v4 07/12] xdiff: delete redundant array xdfile_t.ha
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

When 0 <= i < xdfile_t.nreff the following is true:
xdfile_t.ha[i] == xdfile_t.recs[xdfile_t.rindex[i]]

This makes the code about 5% slower. The fields rindex and ha are
specific to the classic diff (myers and minimal). I plan on creating a
struct for classic diff, but there's a lot of cleanup that needs to be
done before that can happen and leaving ha in would make those cleanups
harder to follow.

A subsequent commit will delete the chastore cha from xdfile_t. That
later commit will investigate deleting ha and cha independently and
together.

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
index 3576415c85..22c44f0683 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -133,7 +133,6 @@ static void xdl_free_ctx(xdfile_t *xdf)
 {
 	xdl_free(xdf->rindex);
 	xdl_free(xdf->rchg - 1);
-	xdl_free(xdf->ha);
 	xdl_free(xdf->recs);
 	xdl_cha_free(&xdf->rcha);
 }
@@ -146,7 +145,6 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 	char const *blk, *cur, *top, *prev;
 	xrecord_t *crec;
 
-	xdf->ha = NULL;
 	xdf->rindex = NULL;
 	xdf->rchg = NULL;
 	xdf->recs = NULL;
@@ -181,8 +179,6 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 	    (XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF)) {
 		if (!XDL_ALLOC_ARRAY(xdf->rindex, xdf->nrec + 1))
 			goto abort;
-		if (!XDL_ALLOC_ARRAY(xdf->ha, xdf->nrec + 1))
-			goto abort;
 	}
 
 	xdf->rchg += 1;
@@ -300,9 +296,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
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
@@ -312,9 +306,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
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

