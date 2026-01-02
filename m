Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0528630F7F0
	for <git@vger.kernel.org>; Fri,  2 Jan 2026 18:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767379959; cv=none; b=cy0EAtaBGVhMzE44Ii30dlmLhFCIDRmGCOgxvXjD3IW6XcQ8G1Gp/SShpBADO9q5O2YPEhDkQeDg6hhjkOADGwrNpw908+mYQafJT/aLNW1g4qFj2MXF7ZCWZXhxLCknDGtFjmfr+j1vUjcVL+h/nOWkDHoLumNxbq05ZRXMz2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767379959; c=relaxed/simple;
	bh=rz186hU345Vk9q52PuK95ac9rPAaJ0487EpR+SWsiWc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uaXiKTCw7jp064v5IMDwxQ53EhWQCpvcwWII0oeShwckWk9i1cZY98xvrBZ0/+LFvZ1vNocCmpGn30vOeusyqrpwNXx/ak/D5Z0TXqDUfTMWeJL8PIJsfO4qx7uPBd10lSrUasMwrsPavrQ9lmBDDQB+OrQFjMZkwHNcSQLPHTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFF6S2eX; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFF6S2eX"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-bf5ac50827dso7918198a12.2
        for <git@vger.kernel.org>; Fri, 02 Jan 2026 10:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767379957; x=1767984757; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cal86+DZOrC7m/vSYbC15u0qpCuA1KJdsCoNFmNotJs=;
        b=hFF6S2eXUWXmij2iCnppwXU6lVLHUIi+1WpPRjqyNBJMWJgOAc87mIn6WL/8tTsh0W
         wVIp4OllGYRtysl8hNWRYSAP3p0PwEZxk5UPWpVp32ZNtpITgmc4TJS2bU2s5uC+uK2q
         0ntEhMU4k3wMNzjGTyFDPVRLF0FekyYLL8lVMiAKLFprcpvxnzB2ps5qRIcAWiqR9kmt
         w+qlQARKMTbhPoOmLxNc80uNgFVl1PCUjB6dXZXivwIemVZLoKv94kBfDE2ULlUiJ4HN
         bOnme96xX0yVXIg49XmRzou7XYZLA549xBcxWEe/Gr+eDhLyJuLUx0BNPn5Y/fZyKUaR
         xe8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767379957; x=1767984757;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cal86+DZOrC7m/vSYbC15u0qpCuA1KJdsCoNFmNotJs=;
        b=o35uHfeRQLnYvgccEN3Kgc9//mdFi2LfEm9jTYo/qStNg5oeVm35EKsqIEWOT0w1m1
         vfaoLrQjlglnL9bL75r6ZrUURM9aFDWg/v6CeKRK2Bpynf87/iYyy9Z3LR0tigBGE1oo
         Q0XvB32j3s4oTwJZ1TusQDmrddxQ/e6RbL9F6DDc5y9X5K+s+7lwN4KT0JMEhbRhvKmL
         EFbMEItvAkpyhoIXN1f40MvY6Q/SgxpTfq8LIvT30DREX5Ldk9F1UJJQFwketYHaMG2N
         iz7H1u65VzuJ5j6r3usReL7F+Xy3daMGNAlQbZNFCfGjwx7H9DD+YT9exY7t9I0B5c0t
         +wxQ==
X-Gm-Message-State: AOJu0YzLlm63xPOdnJoENnkRAATYajFrjltqQj9/RjpgL90aZFYcdpxY
	X3zyKPxVy8YMMJw2sfsAZEckTT6FTFnBeRpQ987H+bBsFlM8H4VAXlXNbSHt+A==
X-Gm-Gg: AY/fxX7xr7VsHRsgkHcyc3p81L8geVdSb3XTMcZ2Mrd0hWNczG1rHCz8hcKiznvAlxI
	GUBw0EnB5IFY92qgY8T7yr9C6/5eFPC56QqhTFeH6WRef1Y3mQIEKnlmzTTjPd/vSNCfMwY22ev
	o2pENPcc37dr2LSoKBIJRyK1I29LdBosdnC1omTOrSwZ87vG3zBb61g/HeIgrKHpsUBoz/UrKvP
	iH9lBgo1b3OpUexyX7yFVcasMBD8pWBxYoOZ5DnoKnmoaRgDJg+ON/L20UFVCK5JRgxgM10rme/
	w976ku8OP5MBoHWkLFt42k4vYKNBUFEyx6cO9oUl4QmxD+1K/3DNFQZGOODVfSky1qRQjP4hqEb
	JuKcKlKXWD3urtlYBqnd7MT/RMW9Al6jKHLxHG7W8rUkRRjlRuMzK+k7oGIeTOmFYGZPc9DZar/
	VaXUVxE5fLDMBBLA==
X-Google-Smtp-Source: AGHT+IFChSa1N5llYv8OOUZdNl8szHuTU4rVizBNxFMgzmU4X2OTkeapzgzYZg5/iKwetlhq5hJs1Q==
X-Received: by 2002:a05:7300:de07:b0:2ae:51ae:5cf3 with SMTP id 5a478bee46e88-2b05ebd0d80mr31712666eec.6.1767379956616;
        Fri, 02 Jan 2026 10:52:36 -0800 (PST)
Received: from [127.0.0.1] ([57.151.128.130])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b140c42d9esm1554623eec.11.2026.01.02.10.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 10:52:36 -0800 (PST)
Message-Id: <d0ef5b23c4483c32069594374489234d48050384.1767379944.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 02 Jan 2026 18:52:22 +0000
Subject: [PATCH 08/10] xdiff: replace xdfile_t.dend with xdfenv_t.delta_end
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

View with --color-words. Same argument as delta_start.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xhistogram.c |  7 +++++--
 xdiff/xpatience.c  |  7 +++++--
 xdiff/xprepare.c   | 19 ++++++++++---------
 xdiff/xtypes.h     |  3 +--
 4 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
index eb6a52d9ba..b4d6f88748 100644
--- a/xdiff/xhistogram.c
+++ b/xdiff/xhistogram.c
@@ -364,7 +364,10 @@ out:
 
 int xdl_do_histogram_diff(xpparam_t const *xpp, xdfenv_t *env)
 {
+	ptrdiff_t dend1 = env->xdf1.nrec - 1 - env->delta_end;
+	ptrdiff_t dend2 = env->xdf2.nrec - 1 - env->delta_end;
+
 	return histogram_diff(xpp, env,
-		env->delta_start + 1, env->xdf1.dend - env->delta_start + 1,
-		env->delta_start + 1, env->xdf2.dend - env->delta_start + 1);
+		env->delta_start + 1, dend1 - env->delta_start + 1,
+		env->delta_start + 1, dend2 - env->delta_start + 1);
 }
diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
index bd0ffbb417..5b8bb34d2b 100644
--- a/xdiff/xpatience.c
+++ b/xdiff/xpatience.c
@@ -373,7 +373,10 @@ static int patience_diff(xpparam_t const *xpp, xdfenv_t *env,
 
 int xdl_do_patience_diff(xpparam_t const *xpp, xdfenv_t *env)
 {
+	ptrdiff_t dend1 = env->xdf1.nrec - 1 - env->delta_end;
+	ptrdiff_t dend2 = env->xdf2.nrec - 1 - env->delta_end;
+
 	return patience_diff(xpp, env,
-		env->delta_start + 1, env->xdf1.dend - env->delta_start + 1,
-		env->delta_start + 1, env->xdf2.dend - env->delta_start + 1);
+		env->delta_start + 1, dend1 - env->delta_start + 1,
+		env->delta_start + 1, dend2 - env->delta_start + 1);
 }
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index e88468e74c..d3cdb6ac02 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -173,7 +173,6 @@ static int xdl_prepare_ctx(mmfile_t *mf, xdfile_t *xdf, uint64_t flags) {
 
 	xdf->changed += 1;
 	xdf->nreff = 0;
-	xdf->dend = xdf->nrec - 1;
 
 	return 0;
 
@@ -267,6 +266,8 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfenv_t *xe) {
 	uint8_t *action1 = NULL, *action2 = NULL;
 	bool need_min = !!(cf->flags & XDF_NEED_MINIMAL);
 	int ret = 0;
+	ptrdiff_t dend1 = xe->xdf1.nrec - 1 - xe->delta_end;
+	ptrdiff_t dend2 = xe->xdf2.nrec - 1 - xe->delta_end;
 
 	/*
 	 * Create temporary arrays that will help us decide if
@@ -286,7 +287,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfenv_t *xe) {
 	 */
 	if ((mlim = xdl_bogosqrt((long)xe->xdf1.nrec)) > XDL_MAX_EQLIMIT)
 		mlim = XDL_MAX_EQLIMIT;
-	for (i = xe->delta_start, recs = &xe->xdf1.recs[xe->delta_start]; i <= xe->xdf1.dend; i++, recs++) {
+	for (i = xe->delta_start, recs = &xe->xdf1.recs[xe->delta_start]; i <= dend1; i++, recs++) {
 		rcrec = cf->rcrecs[recs->minimal_perfect_hash];
 		nm = rcrec ? rcrec->len2 : 0;
 		action1[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
@@ -294,7 +295,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfenv_t *xe) {
 
 	if ((mlim = xdl_bogosqrt((long)xe->xdf2.nrec)) > XDL_MAX_EQLIMIT)
 		mlim = XDL_MAX_EQLIMIT;
-	for (i = xe->delta_start, recs = &xe->xdf2.recs[xe->delta_start]; i <= xe->xdf2.dend; i++, recs++) {
+	for (i = xe->delta_start, recs = &xe->xdf2.recs[xe->delta_start]; i <= dend2; i++, recs++) {
 		rcrec = cf->rcrecs[recs->minimal_perfect_hash];
 		nm = rcrec ? rcrec->len1 : 0;
 		action2[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
@@ -306,9 +307,9 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfenv_t *xe) {
 	 */
 	xe->xdf1.nreff = 0;
 	for (i = xe->delta_start, recs = &xe->xdf1.recs[xe->delta_start];
-	     i <= xe->xdf1.dend; i++, recs++) {
+	     i <= dend1; i++, recs++) {
 		if (action1[i] == KEEP ||
-		    (action1[i] == INVESTIGATE && !xdl_clean_mmatch(action1, i, xe->delta_start, xe->xdf1.dend))) {
+		    (action1[i] == INVESTIGATE && !xdl_clean_mmatch(action1, i, xe->delta_start, dend1))) {
 			xe->xdf1.reference_index[xe->xdf1.nreff++] = i;
 			/* changed[i] remains false, i.e. keep */
 		} else
@@ -318,9 +319,9 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfenv_t *xe) {
 
 	xe->xdf2.nreff = 0;
 	for (i = xe->delta_start, recs = &xe->xdf2.recs[xe->delta_start];
-	     i <= xe->xdf2.dend; i++, recs++) {
+	     i <= dend2; i++, recs++) {
 		if (action2[i] == KEEP ||
-		    (action2[i] == INVESTIGATE && !xdl_clean_mmatch(action2, i, xe->delta_start, xe->xdf2.dend))) {
+		    (action2[i] == INVESTIGATE && !xdl_clean_mmatch(action2, i, xe->delta_start, dend2))) {
 			xe->xdf2.reference_index[xe->xdf2.nreff++] = i;
 			/* changed[i] remains false, i.e. keep */
 		} else
@@ -357,8 +358,7 @@ static void xdl_trim_ends(xdfenv_t *xe)
 		size_t mph1 = xe->xdf1.recs[xe->xdf1.nrec - 1 - i].minimal_perfect_hash;
 		size_t mph2 = xe->xdf2.recs[xe->xdf2.nrec - 1 - i].minimal_perfect_hash;
 		if (mph1 != mph2) {
-			xe->xdf1.dend = xe->xdf1.nrec - 1 - i;
-			xe->xdf2.dend = xe->xdf2.nrec - 1 - i;
+			xe->delta_end = i;
 			break;
 		}
 	}
@@ -370,6 +370,7 @@ int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 	xdlclassifier_t cf;
 
 	xe->delta_start = 0;
+	xe->delta_end = 0;
 
 	if (xdl_prepare_ctx(mf1, &xe->xdf1, xpp->flags) < 0) {
 
diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index bda1f85eb0..a939396064 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -48,7 +48,6 @@ typedef struct s_xrecord {
 typedef struct s_xdfile {
 	xrecord_t *recs;
 	size_t nrec;
-	ptrdiff_t dend;
 	bool *changed;
 	size_t *reference_index;
 	size_t nreff;
@@ -56,7 +55,7 @@ typedef struct s_xdfile {
 
 typedef struct s_xdfenv {
 	xdfile_t xdf1, xdf2;
-	size_t delta_start;
+	size_t delta_start, delta_end;
 } xdfenv_t;
 
 
-- 
gitgitgadget

