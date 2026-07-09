Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D5A39E185
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 16:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783615796; cv=none; b=e5lXeYY2VHWS4iBjphJ0vB3qcZe//sds8vtvcbgEx5AKN7BCmXWxUub+ADOW8pISsZaFIctrx+jCAj22uN9qMWl6lpiXtC7hw6XDT9a0LkPcm4l/5jEHgBN6+lUKJtP2gDeJ6efDna72Mg5Srj/LBh3jUcOb8uhLp91QHb5VRMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783615796; c=relaxed/simple;
	bh=tJSCgB6x0jbgExgdCRZ3qo+Hfof6AX9abMAJyj1FDgc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=UZg5JlPvIKdT+Sf/bVLBdMQcIeSgZYRYP4EkQpR4OgyjqqF8T/enoCvvErrmpbsGod1hupAL+y9JEXk4L/zqIA+3/R0RSq2ZYo2dkScvfS7EIALcP7AZRy4N9RH4kI3nsTSIXA/dJFr5xSV1JFyLrpEahHaXcgKSFNOVm9sonQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TkScPSIb; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkScPSIb"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso174955a91.2
        for <git@vger.kernel.org>; Thu, 09 Jul 2026 09:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783615795; x=1784220595; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4dCHkQjg/qVtExucbStgAUbSk9OouMFE3EvSXlZAN90=;
        b=TkScPSIbcqB0eRKPjwBc2BQ/07A4PbzhoqT5SNRFnGES9vWeWwLzGOAoupBICX8vGG
         wMc2PjlL87VJX8X8GsvUoH74khSyF67GFdCSBdilv0sTEwgtzPrUCZTDhVbPup0clTJM
         7ANe/KH1ydnXaD9vMp9WE/50jbvghCF+TAJtplhkU2QUaFaCBVWZ/EcfUOOyK1xtsfE/
         J6mfoVgan4rF0A3D3/vWurtmB7uV0LNctPPI0L2hGqbAc8Yq2Le/KdTH5Crwv47o6v40
         29JBStwZQUlte5CVh12oYe7/Vg1gcZC8TyhT+mccPH4/bPkDjt8OJwvuYUCt/19JFpTk
         1g7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783615795; x=1784220595;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4dCHkQjg/qVtExucbStgAUbSk9OouMFE3EvSXlZAN90=;
        b=BQVLZsCsXL2eGxhqXFF96X3FQUFIhFY3DnZTL7M0oWeLjbTKJXeU0jvawYBdUUennD
         hLK5VWkzdRJ3GmSp+59QcggzXvNmwUSgLxoQRS9tklI52xcHXjQKh70UcSgpGNOGRZKo
         PyLhpigflYlU/XpfnL+KInrFUftc+LqgSWI9ssm9v39lOzs3cFGzntr04G1G1tEZGTR3
         n0ltQze6sxAOfBRmC97lvBTCEyDrVBBGLYGj6fXRDYGndbUmiu3sRFxxcNMNepB2wj1G
         5xEwyJTyfLW5pMaw51nxcan362+PS4c3x0IgXMBci44ilC5QiozP+r9G+cXNte+bFImM
         kS3Q==
X-Gm-Message-State: AOJu0YzMs4fd0Xe5MXu1Mb4DunlvZn1P0XtxQKspTb4DpcDs8JoLLHaP
	7ILV5GEYFjfKJrl27GxaqMt7eyUdeh4JyYbUqanmvu66dUL+SHfFdYq0sNO9XQ==
X-Gm-Gg: AfdE7cmMgjdgPhax+RQxCaI1gaX5G7PwlIPw6sVL7lK+wNAOx2L+nzbQ7/Mkfsbs1XK
	O+8gCZcf7rc8o7FSeJgyeoq9FnCyoIpj+yuqsWL7rratJ7ltQOfK9hg/24BOSbrXCJ5sJEnGo0A
	RwII5n330pIf8HaCh9M+BtRfxZV4drVp7CKk8R737K3xFJ/uSzz4gm2ehOD+EJv3260zptkI+JQ
	qfTvNQBuk9QjBnCFkOiil3T+WNcv6i906oXk7Vx+rQy+FL7ouCpJShmgvD1y9DIzcLOGyMacfWP
	RYoxaAwZ/AP9YXQ2oCTeA5K+Cc0TCdMK7OvvL89fojSG3O9T52UVlSNP+vrtEo3+iRsH0/Lajv8
	UrdoYV//s6GF0spczPzvXxhQtYueB7YGQ0JAiqWMyGF46lAag5VVAhV9lphT2kZsfmIxz+fSsx7
	Rcr+HTTa3rgRDhSWA=
X-Received: by 2002:a17:90b:3891:b0:387:e0db:3fac with SMTP id 98e67ed59e1d1-38942798114mr8898048a91.37.1783615795080;
        Thu, 09 Jul 2026 09:49:55 -0700 (PDT)
Received: from [127.0.0.1] ([68.220.59.115])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a583bcsm37244176eec.19.2026.07.09.09.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 09:49:54 -0700 (PDT)
Message-Id: <acffd232acad12f31c6ea685dbc07712e097ecef.1783615780.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
References: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Jul 2026 16:49:35 +0000
Subject: [PATCH 08/12] archive-zip: widen `zlib_deflate_raw()`'s maxsize local
 to `size_t`
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Prep for the upcoming `git_deflate_bound()` widening to `size_t`: the
local that catches its return needs to be `size_t` too, otherwise the
widening would introduce a silent Windows narrowing here. No semantic
effect with the current unsigned-long-returning `git_deflate_bound()`
(`size_t == unsigned long` on this caller's platforms today).

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 archive-zip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/archive-zip.c b/archive-zip.c
index 97ea8d60d6..a487d4c041 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -206,7 +206,7 @@ static void *zlib_deflate_raw(void *data, unsigned long size,
 			      unsigned long *compressed_size)
 {
 	git_zstream stream;
-	unsigned long maxsize;
+	size_t maxsize;
 	void *buffer;
 	int result;
 
-- 
gitgitgadget

