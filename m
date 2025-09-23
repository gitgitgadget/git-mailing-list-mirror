Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6CB30EF67
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 21:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758662681; cv=none; b=HjRUi3UEvsdfIAJBLIr8rH6Z/TOfvU+IT1qD6AlFI54nJvbYz//OxvVjhdwG/GMDi3KhBML6Pj/3tmGQcdByH0NM7DNNhvedJCJEn7Ly9Q3TjNextdMtcsdjt0mr4+gmi8WJx6PJgVXPsRgQkj87jA4FuyukfIFyDdKpFYMGrjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758662681; c=relaxed/simple;
	bh=BTBkqOBo46HKLrO1JkXLChyVjl9VuzfjDtDRU8/t574=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bGj+4mfY06KzzUMHvnNNVh8Rgfcn4F+/KdRhLaXN4IOwZss00AcliE6ciVDtwUvn8DhtJB2Z0grxkpvZnkEP1t9Gmc/ys6xpq+pDh3gwJKQk8I7cpClntin7cj4fKFFQTQ8JSp8LaeCY+mJRabXNxo9Lb2c+DPZl5jFWbSqSSVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1dNpgwQ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1dNpgwQ"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-77f41086c11so2405190b3a.0
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 14:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758662678; x=1759267478; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5WErw3AydLrOKz0X239j3/jDTD9XruWWs5KcWhttI7Q=;
        b=S1dNpgwQtSJjZkQKEFbSTh/59zK1lLUJ4Az5/5PwVTe6ELYbLpHhqjsJ4OnBtbrSO7
         2JHTATMDrnJQdiZ5bRE/6RVecA4eO53rwXVETCHN3DETGZlkxD6yggvGATPcoaS8ruf0
         s+9nxOZfEUe4XAJEuUgCeSOb3enXaChC3uY9MSCxFa/EtmgJP9p4xhFT6tQC1uF3lRB6
         pPCL43nLsm/mXk0hmM9f9Y8Dau6vj941+hFq1bUNK+qw23QugzUfb4bNnuwx2aSaHpsf
         4LaIYRZnUpK4Ijqfo3XV/UHwAm+gkO/QqznV3kRYkvQ3ZLR2r7SIg0yU1lH5yz7nlxO5
         YNmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758662678; x=1759267478;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5WErw3AydLrOKz0X239j3/jDTD9XruWWs5KcWhttI7Q=;
        b=S/D7YdlvW6FJBE3dMvKBD102iQWNAOdCIdyqkFJYStpFeuRO48D2ON65M2UtgSmMxm
         d6n9o18kZs+xc2PAGRVh1iSmP0CDpevsSI3fL57yMEA56AfrHERmRfMT4goScmg7QoKg
         pD8lP2qfdhgElV9pZYB5H1GJXSTahaZE4V79vIgA5JcP0yY+RUrjZyLs0cmrUA8QH60g
         MaHBbrzWBuO3cF1yGVHc76ajk4rVcvQPJSHKeffMdeexzI3XihWA1Ywkq+BtwtHOpzEC
         cufLWsHCVeFEwq2Nv/sKA8nj39rXfaa0P5BCoQsUv5nmndjGizmepYL9tgIVY7p00m76
         zLYQ==
X-Gm-Message-State: AOJu0YyesDw8gxqHHLtKKKhhnYSx/XHO24qYhYAsrAE89NYNIpmAfQbZ
	5uDgs1hOZeT3M+8OEbYuHTR6OWqKjSRVRgsnPSoEDai+EL5xFhVoqYEYQ9NXZAuh
X-Gm-Gg: ASbGncsbpvjOuuzFQ9cBtFUqAFzr7Ei2csTMq5JvV0Ve+ceLWkAHjTEOvu9ECl5pMik
	1diKfRtXP14PytKeNH21WZxd/YDuS7lro2fb1u9VE3ZZiueIPS8nptJYvH3CcVl+oREsdNnub+L
	nvvW2bYd2bBF3bYklbEx8qnWy8D8ONcmIkr6XJmwo1KO+H9ye7vPi3AXnCJh9Brp7VTArWVmpGL
	/bTV565MeWOy+pboxgUN9zYbS7nVhT4dIKiwoVpQKmQMKx08i8PnCMIxj4zhgC8jyzmX2c/5JqL
	qx/nbqC2BilG16robYyf17nYAAgnf17UZ79K6BlgvgD0vi0cR6qMp1IG3rBEM3Nh1DawEXeIW69
	1wZcoMzudYFdaIVq50hmpNy6V44xbJxUWXy2Q
X-Google-Smtp-Source: AGHT+IFiRdvdlPR5W+yvIcE/Cqxsip6/qzcJS7kb6Kpk+xiSlICukEOq9Zzw9Qi2t4eLhl6oTeJNmQ==
X-Received: by 2002:a05:6a20:e212:b0:24a:96cb:fe55 with SMTP id adf61e73a8af0-2cffb31f0a3mr5980698637.43.1758662678571;
        Tue, 23 Sep 2025 14:24:38 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.128.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f097b60e7sm12207002b3a.1.2025.09.23.14.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 14:24:37 -0700 (PDT)
Message-Id: <7d3a7e617c68cba19e6ea1195bd6d753a5795a4d.1758662670.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com>
References: <pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
	<pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 23 Sep 2025 21:24:21 +0000
Subject: [PATCH v5 04/13] xdiff: delete superfluous function xdl_get_rec() in
 xemit
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

When xrecord_t was a linked list, and recs didn't exist, I assume this
function walked the list until it found the right record. Accessing
a contiguous array is so trival that this function is now superfluous.
Delete it.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xemit.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index 1d40c9cb40..40fc8154f3 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -22,23 +22,14 @@
 
 #include "xinclude.h"
 
-static long xdl_get_rec(xdfile_t *xdf, long ri, char const **rec) {
-
-	*rec = xdf->recs[ri]->ptr;
-
-	return xdf->recs[ri]->size;
-}
-
 
 static int xdl_emit_record(xdfile_t *xdf, long ri, char const *pre, xdemitcb_t *ecb) {
 	long size, psize = strlen(pre);
-	char const *rec;
-
-	size = xdl_get_rec(xdf, ri, &rec);
-	if (xdl_emit_diffrec(rec, size, pre, psize, ecb) < 0) {
+	char const *rec = xdf->recs[ri]->ptr;
 
+	size = xdf->recs[ri]->size;
+	if (xdl_emit_diffrec(rec, size, pre, psize, ecb) < 0)
 		return -1;
-	}
 
 	return 0;
 }
@@ -120,8 +111,8 @@ static long def_ff(const char *rec, long len, char *buf, long sz)
 static long match_func_rec(xdfile_t *xdf, xdemitconf_t const *xecfg, long ri,
 			   char *buf, long sz)
 {
-	const char *rec;
-	long len = xdl_get_rec(xdf, ri, &rec);
+	const char *rec = xdf->recs[ri]->ptr;
+	long len = xdf->recs[ri]->size;
 	if (!xecfg->find_func)
 		return def_ff(rec, len, buf, sz);
 	return xecfg->find_func(rec, len, buf, sz, xecfg->find_func_priv);
@@ -160,8 +151,8 @@ static long get_func_line(xdfenv_t *xe, xdemitconf_t const *xecfg,
 
 static int is_empty_rec(xdfile_t *xdf, long ri)
 {
-	const char *rec;
-	long len = xdl_get_rec(xdf, ri, &rec);
+	const char *rec = xdf->recs[ri]->ptr;
+	long len = xdf->recs[ri]->size;
 
 	while (len > 0 && XDL_ISSPACE(*rec)) {
 		rec++;
-- 
gitgitgadget

