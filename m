Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE5528750B
	for <git@vger.kernel.org>; Fri,  2 Jan 2026 18:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767379958; cv=none; b=dwWruUGCR5OpV4Q8tQDOBUT0XxYhf6ZDhcLTp3I4okF9IZw2ENttk08ToXWjvfNRXUDylWfdUZd0XXwD/IC6OOBaSzAWTHa8hgVXTNYqI9aXedPKzFmLYQxRUMBozbD+fzKg5tgOfxBQM6fzeqdN8WhLVf4OpZRkmJrTUjjUwVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767379958; c=relaxed/simple;
	bh=cKvn1nfW1xo3l9En9enLJsx6d5XsLu1GDRDk0Pg66zc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LjYCKfUIGNQ0+G4chG+NZKe6o/6LS2ewjO5bVVvJ+GmWS+GohE8TqlK3bwk6Wf4ZXD3YOGJVYxqeyxb2vAdsXFAOWi/sc+6okSFUzYNVQUBrNoyybyP1PZAmmxxCh1vBuoRT7LlUzdJihLGiERp8GXUFG0ra+C9zeGwLUW7cLGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbNL/O6D; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbNL/O6D"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c06cb8004e8so9706036a12.0
        for <git@vger.kernel.org>; Fri, 02 Jan 2026 10:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767379955; x=1767984755; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RSQx5hEPwZVO4ipId7pQ7Lr2LnSlwA+qROR+34+B3T8=;
        b=hbNL/O6DQ6XHdxkvFhoU9n9B7CIxKwksTSCgGXzHOE4p1Yj/aNn352xwrOqdOfI7jT
         xlXl9/GJPDnFcjeLee3sA4vs5ecsWoz3Hep206msDTogPVtW2/u9pVDdG4XW65EtONJG
         f37wZ/WILrYYr9ewFuKHs3vDaUsYPsscA8+Ae5wypkLXLYRj5xuy4O5g5s/apgQtqE7g
         F7C82koLUdDOOk6/Sy69uh8938rB8zdqMrNaIw53TAMpMdHDXYhXex444DZPJvu0nfkG
         vs3Gb/LbHjfgOHJGgcvVfuwT5LtIpTi65K4gr5pGaSdhFPk19eSlM+6aJq6ZgFgpfvjo
         ShUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767379955; x=1767984755;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RSQx5hEPwZVO4ipId7pQ7Lr2LnSlwA+qROR+34+B3T8=;
        b=VEzIKshjpDHwGSTFzXPGh3FPdZKzRvaeLdV+NfSEj5rSN+iGiKhfPNyGQOIFfPgz88
         9g/e65PzblfSOYvvT2p1kYcoeqQ3jsv/z6uT2oOJM6UJoVk0yPvYOMtEUGWV1t57sbdd
         2qagKCLpWJuXBVXp+nSea4dA730nqvUa5FP9Q4qfF9/8HkA4nHvzg1jQmHAq3Fnk6oUw
         Bmk+F2P0l+G5UZdNEBnv140spmB6kCD5wX6G2C4hszlEds4eUGm1/QGW/L3SJESSiSPQ
         77YgLsHPpfkGImJWIxr/0/G7Vk/W4OyVZSROzSJXFwBIiAXZoJToHaUg6HZgPj+dszp7
         vQhA==
X-Gm-Message-State: AOJu0YwF/Ds7AmJUPfkkOvIa8OSfxXtC80BaOUo45cyxPY9Gb8m7/Wqj
	G/yf2IzHbCioHF1VIFKItvsfCpXnOZCQ4aZUmzv1ZVTbxZaDPasU+rr53f92zQ==
X-Gm-Gg: AY/fxX59OnkTX0rJ9AsE0ZLxf5c4tWIg7iT6cN072dAci6lbgTzDu5OOoLboJHrmVDw
	jbLuqh0SWX05gZy++k+uoudWrFYXER8ZsxILHGTl+/d/Vnw/peyudXBAqoBNN1fihGOq1q9VpHt
	zhTQj4zNe3loZCbdLo2R6YFu9NMIftKFqUntwdB/8RY5BL9+e2D0GCAYSIV+hWpPuASBZjLXMNe
	1+LxWIDT8h/gcKIBeG+aIY75qb5O9YIXvJjWTSd7kw/MUq1u3aWyxPe9YwXpEFdGPhkYqm07d4v
	pss5Wrz9oBqn7qJeZQ8EJwKbANbSWWy6DRZLuYrZ6E1eo1zAs12tjn1QEab+Dpf6GTRltDbTqup
	SiDs7QXocRzXjIvSA98wDLM1g8RNAIO/xkQfqpm1wpAhKZvHz83autEiD4elgKxTNbUQUneTzIk
	4ElvmWAxNKEy0Mlg==
X-Google-Smtp-Source: AGHT+IFca4Mm8cE6dJbusoBSVJZdM8ZiqXKyniNrrsuQfUR1fs/d/0aAAmLi7g/BQs7CwvCS6hInTA==
X-Received: by 2002:a05:7301:fc09:b0:2ae:6146:37ab with SMTP id 5a478bee46e88-2b05ebd86camr23353306eec.1.1767379955199;
        Fri, 02 Jan 2026 10:52:35 -0800 (PST)
Received: from [127.0.0.1] ([57.151.128.130])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b140c42e8bsm1598246eec.26.2026.01.02.10.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 10:52:34 -0800 (PST)
Message-Id: <d74722538b693fb26e8684f9dd3fbc319a2a575e.1767379944.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 02 Jan 2026 18:52:21 +0000
Subject: [PATCH 07/10] xdiff: replace xdfile_t.dstart with
 xdfenv_t.delta_start
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

Placing delta_start in xdfenv_t instead of xdfile_t provides a more
appropriate context since this variable only makes sense with a pair
of files. View with --color-words.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xhistogram.c |  4 ++--
 xdiff/xpatience.c  |  4 ++--
 xdiff/xprepare.c   | 17 +++++++++--------
 xdiff/xtypes.h     |  3 ++-
 4 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
index 5ae1282c27..eb6a52d9ba 100644
--- a/xdiff/xhistogram.c
+++ b/xdiff/xhistogram.c
@@ -365,6 +365,6 @@ out:
 int xdl_do_histogram_diff(xpparam_t const *xpp, xdfenv_t *env)
 {
 	return histogram_diff(xpp, env,
-		env->xdf1.dstart + 1, env->xdf1.dend - env->xdf1.dstart + 1,
-		env->xdf2.dstart + 1, env->xdf2.dend - env->xdf2.dstart + 1);
+		env->delta_start + 1, env->xdf1.dend - env->delta_start + 1,
+		env->delta_start + 1, env->xdf2.dend - env->delta_start + 1);
 }
diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
index 2bce07cf48..bd0ffbb417 100644
--- a/xdiff/xpatience.c
+++ b/xdiff/xpatience.c
@@ -374,6 +374,6 @@ static int patience_diff(xpparam_t const *xpp, xdfenv_t *env,
 int xdl_do_patience_diff(xpparam_t const *xpp, xdfenv_t *env)
 {
 	return patience_diff(xpp, env,
-		env->xdf1.dstart + 1, env->xdf1.dend - env->xdf1.dstart + 1,
-		env->xdf2.dstart + 1, env->xdf2.dend - env->xdf2.dstart + 1);
+		env->delta_start + 1, env->xdf1.dend - env->delta_start + 1,
+		env->delta_start + 1, env->xdf2.dend - env->delta_start + 1);
 }
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 06b6a6f804..e88468e74c 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -173,7 +173,6 @@ static int xdl_prepare_ctx(mmfile_t *mf, xdfile_t *xdf, uint64_t flags) {
 
 	xdf->changed += 1;
 	xdf->nreff = 0;
-	xdf->dstart = 0;
 	xdf->dend = xdf->nrec - 1;
 
 	return 0;
@@ -287,7 +286,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfenv_t *xe) {
 	 */
 	if ((mlim = xdl_bogosqrt((long)xe->xdf1.nrec)) > XDL_MAX_EQLIMIT)
 		mlim = XDL_MAX_EQLIMIT;
-	for (i = xe->xdf1.dstart, recs = &xe->xdf1.recs[xe->xdf1.dstart]; i <= xe->xdf1.dend; i++, recs++) {
+	for (i = xe->delta_start, recs = &xe->xdf1.recs[xe->delta_start]; i <= xe->xdf1.dend; i++, recs++) {
 		rcrec = cf->rcrecs[recs->minimal_perfect_hash];
 		nm = rcrec ? rcrec->len2 : 0;
 		action1[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
@@ -295,7 +294,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfenv_t *xe) {
 
 	if ((mlim = xdl_bogosqrt((long)xe->xdf2.nrec)) > XDL_MAX_EQLIMIT)
 		mlim = XDL_MAX_EQLIMIT;
-	for (i = xe->xdf2.dstart, recs = &xe->xdf2.recs[xe->xdf2.dstart]; i <= xe->xdf2.dend; i++, recs++) {
+	for (i = xe->delta_start, recs = &xe->xdf2.recs[xe->delta_start]; i <= xe->xdf2.dend; i++, recs++) {
 		rcrec = cf->rcrecs[recs->minimal_perfect_hash];
 		nm = rcrec ? rcrec->len1 : 0;
 		action2[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
@@ -306,10 +305,10 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfenv_t *xe) {
 	 * false, or become true.
 	 */
 	xe->xdf1.nreff = 0;
-	for (i = xe->xdf1.dstart, recs = &xe->xdf1.recs[xe->xdf1.dstart];
+	for (i = xe->delta_start, recs = &xe->xdf1.recs[xe->delta_start];
 	     i <= xe->xdf1.dend; i++, recs++) {
 		if (action1[i] == KEEP ||
-		    (action1[i] == INVESTIGATE && !xdl_clean_mmatch(action1, i, xe->xdf1.dstart, xe->xdf1.dend))) {
+		    (action1[i] == INVESTIGATE && !xdl_clean_mmatch(action1, i, xe->delta_start, xe->xdf1.dend))) {
 			xe->xdf1.reference_index[xe->xdf1.nreff++] = i;
 			/* changed[i] remains false, i.e. keep */
 		} else
@@ -318,10 +317,10 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfenv_t *xe) {
 	}
 
 	xe->xdf2.nreff = 0;
-	for (i = xe->xdf2.dstart, recs = &xe->xdf2.recs[xe->xdf2.dstart];
+	for (i = xe->delta_start, recs = &xe->xdf2.recs[xe->delta_start];
 	     i <= xe->xdf2.dend; i++, recs++) {
 		if (action2[i] == KEEP ||
-		    (action2[i] == INVESTIGATE && !xdl_clean_mmatch(action2, i, xe->xdf2.dstart, xe->xdf2.dend))) {
+		    (action2[i] == INVESTIGATE && !xdl_clean_mmatch(action2, i, xe->delta_start, xe->xdf2.dend))) {
 			xe->xdf2.reference_index[xe->xdf2.nreff++] = i;
 			/* changed[i] remains false, i.e. keep */
 		} else
@@ -348,7 +347,7 @@ static void xdl_trim_ends(xdfenv_t *xe)
 		size_t mph1 = xe->xdf1.recs[i].minimal_perfect_hash;
 		size_t mph2 = xe->xdf2.recs[i].minimal_perfect_hash;
 		if (mph1 != mph2) {
-			xe->xdf1.dstart = xe->xdf2.dstart = (ssize_t)i;
+			xe->delta_start = (ssize_t)i;
 			lim -= i;
 			break;
 		}
@@ -370,6 +369,8 @@ int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 		    xdfenv_t *xe) {
 	xdlclassifier_t cf;
 
+	xe->delta_start = 0;
+
 	if (xdl_prepare_ctx(mf1, &xe->xdf1, xpp->flags) < 0) {
 
 		return -1;
diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index 979586f20a..bda1f85eb0 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -48,7 +48,7 @@ typedef struct s_xrecord {
 typedef struct s_xdfile {
 	xrecord_t *recs;
 	size_t nrec;
-	ptrdiff_t dstart, dend;
+	ptrdiff_t dend;
 	bool *changed;
 	size_t *reference_index;
 	size_t nreff;
@@ -56,6 +56,7 @@ typedef struct s_xdfile {
 
 typedef struct s_xdfenv {
 	xdfile_t xdf1, xdf2;
+	size_t delta_start;
 } xdfenv_t;
 
 
-- 
gitgitgadget

