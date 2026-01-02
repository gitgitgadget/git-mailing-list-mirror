Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D20E3161AC
	for <git@vger.kernel.org>; Fri,  2 Jan 2026 18:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767379954; cv=none; b=ZTPxqTJJkkMuLGmN4N7uU+bwFAu6YequTEUhjL2bIvkIFO5KeCsJTsh8p0t18rcPq8Xgj6/uSPyjKOXYA0mjlQPFlxC2sYxSrKwNQUxPlh886QbCqaw1MwmQ7VmGNhf1RMDvco9zkpTX5G2Yd4vi3E0PHDrbASdBoorj6Gpw3Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767379954; c=relaxed/simple;
	bh=qdfTdmaVYpHZpXM58fp3VAHG4flGF4/tawarhSAVR4I=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gaVc5qJbTewPHFFxkR46plL9LBY9A872X7I4IKsbqPbgsTowKF48wFfAW3Tf0bMDdtF9D4nNiLnADyAESWQaOkVvBjrEA/STCAhyAuXkaaKhK15kPXJsjYWX3AWE+Vqn+fTLsvI+XUPiHmG5nqClPEBJIWx+nJd4tbDC1lt8KAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bEJf6w7x; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEJf6w7x"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c13771b2cf9so10432975a12.1
        for <git@vger.kernel.org>; Fri, 02 Jan 2026 10:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767379951; x=1767984751; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rfa+Z/dQIfTS0uUwCM7LJPTwZpn2pwL2+2BF++DZvGs=;
        b=bEJf6w7x/BmVg8mzU3YrMozUAerP/9U15KRmf2BJquvFGvoXD0mQMuDGzCzNsE/2WM
         cd2oMXTN79L95yKllNv8yLT2C0hitlQf03d8zhA4Htw+J7xSm1OUfl8bzRM31QMZOBFF
         SUXwXxmwcO4z4hNgkanR1fcs7k76OOsHQM1kGtbMy6hjs4eYEwtgG1qquEG9G+4FOojt
         fnMeWT/6HSa9jkW2xkG7c88msKgFmoik/Sor6BdukKwm4so0v4xRCKSaiL/OMJjpaAkO
         bs0tLgglNrLIUWMClgJ3vtQoCL/Db+axgnEQ/WkUVLDhK0S0iIMTu60wC6UqCo1ouUxm
         xnEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767379951; x=1767984751;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rfa+Z/dQIfTS0uUwCM7LJPTwZpn2pwL2+2BF++DZvGs=;
        b=H21lNbKociBLBvB1b3FGDubQmTBW6nBIq76kM7IyH5uogqVB6qfHxkBlTLZ5/cUbje
         KiXKeuqzX11aDgstUAS4ZddoQloYq3vt3vjPNGCNJ19U7GcGx13xclKxPiYE8aCiw7GT
         ERFceZHlJcsaDFwgB3tp5/+04GqPqFexFzJr+VbbsiPIhLITlqsnX7HrZDh19k94tx8z
         mUE7qIJODp0zqAD3tvDx71sWzSFIJkD3C6FrhzOXw2kdbhipnnISyAvDGXRXBN8xeVCE
         zc3C/SM+LpgwjMdNaw1VyDPyUdfCxjnJ2ohPwtcB0laEseSs6PcwlO5adRSqOhn1mbKv
         LSdQ==
X-Gm-Message-State: AOJu0Yy4wYBJmwardDJO1Ncbg2gqW72Vj2+/9IHHAU6L6KCt2ZPW9qON
	PqG6L2RFf4M84C3QZ/i6qMfne3wwSNhRJ/owf2Dd2sngoeMpMNerTzUKYbdneQ==
X-Gm-Gg: AY/fxX7xgDvL7KHUiPhbrxhRWR+JiGXgoK/dIU6ID6XYrQRGkzFeFKrUv48462LyltB
	hPlZyPtcyFmd6EO+f04IUOg9AqJIi4GMecHoUXoGx5oHCfqBrv8qZ/mZ89PQPTZjatFpeCO08EB
	7s50IPbUm+czPGj9tlrvyEqvy6lJkL2kzLkQUwPSXZJqaZftRv+eYQ6HzNCCxmPz+CkMDP+eK3e
	18Pb/hNekVJS+pV0zZHZa0YzzB5FuYEzIZSvQcAyqbdDc7gLeGV5UWhgBtp8XwqeZcFzmwaVSWU
	zX0DUon3TfnsnZWfcAu5dJ//5WoaPwJlaEqKJN+B+M9nVJShSr8GbmJUcyMBAb91/zq9RndNE6s
	XOuan+asx8N+E/B5zykhfx0ILZ1+yZ0hBJeOQfiKrII8wpbZ2qNAfha3z5txfEW9gdT1eIyyqIE
	ySJL7xdA0sH/lG0g==
X-Google-Smtp-Source: AGHT+IF7RRpJZmrHFnG4itUK2Cfr4WinVnb0gTIWWRvsLH4GqZ+5Ny9PqZmd8u7kuecdi6StDa+/8A==
X-Received: by 2002:a05:7301:fc05:b0:2ae:2bb8:a6fd with SMTP id 5a478bee46e88-2b05ec344dbmr33594699eec.24.1767379951170;
        Fri, 02 Jan 2026 10:52:31 -0800 (PST)
Received: from [127.0.0.1] ([57.151.128.130])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b140c42e5csm1577728eec.32.2026.01.02.10.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 10:52:30 -0800 (PST)
Message-Id: <70040ea1351451243be90d59d26cf1a403f3000a.1767379944.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 02 Jan 2026 18:52:18 +0000
Subject: [PATCH 04/10] xdiff: let patience and histogram benefit from
 xdl_trim_ends()
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

The patience diff is set up the exact same way as histogram, see
xdl_do_historgram_diff() in xhistogram.c. xdl_optimize_ctxs() is
redundant now, delete it.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xpatience.c |  4 +++-
 xdiff/xprepare.c  | 14 ++------------
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
index 9580d18032..2bce07cf48 100644
--- a/xdiff/xpatience.c
+++ b/xdiff/xpatience.c
@@ -373,5 +373,7 @@ static int patience_diff(xpparam_t const *xpp, xdfenv_t *env,
 
 int xdl_do_patience_diff(xpparam_t const *xpp, xdfenv_t *env)
 {
-	return patience_diff(xpp, env, 1, (int)env->xdf1.nrec, 1, (int)env->xdf2.nrec);
+	return patience_diff(xpp, env,
+		env->xdf1.dstart + 1, env->xdf1.dend - env->xdf1.dstart + 1,
+		env->xdf2.dstart + 1, env->xdf2.dend - env->xdf2.dstart + 1);
 }
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 96a32cc5e9..0d7d9f6146 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -366,17 +366,6 @@ static int xdl_trim_ends(xdfile_t *xdf1, xdfile_t *xdf2) {
 }
 
 
-static int xdl_optimize_ctxs(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2) {
-
-	if (xdl_trim_ends(xdf1, xdf2) < 0 ||
-	    xdl_cleanup_records(cf, xdf1, xdf2) < 0) {
-
-		return -1;
-	}
-
-	return 0;
-}
-
 int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 		    xdfenv_t *xe) {
 	xdlclassifier_t cf;
@@ -404,9 +393,10 @@ int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 		xdl_classify_record(2, &cf, rec);
 	}
 
+	xdl_trim_ends(&xe->xdf1, &xe->xdf2);
 	if ((XDF_DIFF_ALG(xpp->flags) != XDF_PATIENCE_DIFF) &&
 	    (XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF) &&
-	    xdl_optimize_ctxs(&cf, &xe->xdf1, &xe->xdf2) < 0) {
+	    xdl_cleanup_records(&cf, &xe->xdf1, &xe->xdf2) < 0) {
 
 		xdl_free_ctx(&xe->xdf2);
 		xdl_free_ctx(&xe->xdf1);
-- 
gitgitgadget

