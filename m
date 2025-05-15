Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1E0299A95
	for <git@vger.kernel.org>; Thu, 15 May 2025 12:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313159; cv=none; b=Lz0rWGXGfUnnOpAx1HqN5UgjEJU93S/wMRajomjUqH1u0A4LwuiSTLG1/ScxbdaS/RLIqnfl9PMibqnRVj0RoyBCi5ryMY7o+07MBeb0LPeYpufVOvspKd5Ssh9Q56yGP/XXBJCANl76mf9s6XpGDb60U59woF7yfmphwqb5Ww8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313159; c=relaxed/simple;
	bh=Llg1qR48imnazvw/pV3Il9BMAtAEA4TR2rUN2vBrVL0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XUd/C+uR9HUFKWQBX6X58XLlZsRB071rjTt/jeAz5Ag6JADmQ2BgpFj3nseoqVgLgrYX6fmyVvWs6SJ2Wp2fr44tCB0zhm6HoDN5eY7BO9OPnPbK/1bU9THSMjDkEYEMUpQXHaWFcsDW8xhTUI1LeZR+qbDdw/i8eHAdXz2dA3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W6sY4EgI; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6sY4EgI"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so7074235e9.1
        for <git@vger.kernel.org>; Thu, 15 May 2025 05:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747313156; x=1747917956; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGvdt0HEzuGqkCu7sUyHeMtlejGUAB5lqBe8rN6lONU=;
        b=W6sY4EgIV/hDJjk9o07t0ENSvShURlQtvO4Vi/lXQgeCb/SFj/9RdcbzB9dM7RCQRn
         jWEwmovfS1Y383ckZ65u1w5YoaDp0mlKyIyf46rUWFvFEOlLYfeTTg72tgzchVLshF4z
         3qtJvjL/TtpE25dk2IaxWn8TUb24gq0YqCJMwbXp8PNnUO691Hk/DNc5GT+hZEff3ONJ
         HyMQCElglH+4si8GGGC2OLPab65oxINlq088ZOsNukFkii8WO8Id5YaJWoKZEY1GGhUj
         A8HmwcTmwbEVxdCh/Bb597qYCfucLrXrVmnYwm1WPrI/HX0vHL/D8UWpu6sayxEAhrMI
         WcTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747313156; x=1747917956;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pGvdt0HEzuGqkCu7sUyHeMtlejGUAB5lqBe8rN6lONU=;
        b=CfI+I0FcXsLMVelqvQl/L7GlYagSVRD06CPIQHL9Re1xvgQQ4UC0YCowJ2C4JW7Mkj
         H/btPXtect27bwBY/jGldGov7yo6TKMTJFusWMwnbvBle7F84nIlyDKfXUIZ7cSmcIsE
         7FQunknWUUvoHTLrmjzJ21EGn6xV0dc3CZ8wcvPmLT9s39KCOZMQd8DMpokAaXCp6zQQ
         YXCADD+BzXcTv2qF4ly8C2kA7u9VvZtU4FQuX146YpacBwM8SLYILVnTydTPY7xQSzMm
         vnz9/foSK4FzvhgTXw70+kDFYquzrXIIDDkj81QcpPCRVe2fRP4M2j1bFfuq4qraxoL9
         E/uQ==
X-Gm-Message-State: AOJu0Yyh5nfPzrZL/x4In35seIBNFi4qEMrezQRz72CWAzomp0ion3We
	pn9QteHepqTfpIk/IKIHcEJgc+i4O7jwBTOI5mxAZENuONyQFZmFTEAYDA==
X-Gm-Gg: ASbGncsuZsZXLCspA4gqRpOKaO2Y1wHUsuVU63HMRA1M2zmr+NMGmJk74aKt0EYhRoX
	PXRifeLT6vVnQ3dkbSlfy8EKeJSaAZ+c5HrD3T82xgESD3vp/W6eXpAxWMT+S4NGiGWQYqc6P/j
	RTNoeZl5/wO6M0SjQ9Chx23u+JgqqG6R3fz2XkExfpUuTRL6/jEb1zM8+41f44YjHdU8Qm+lBVu
	ws4pPiLHMpQJjPP2j9UpYH/2a9Zv6Cmec6hvQdlh1kSVMMJglQcISfPJwPkvUzeUt1YmnTx0y67
	fuTcOZnQ1WKjYsc5ZSgeyAMqdLFLJIhHZid0sq7/Dj+VfCwoLyRw
X-Google-Smtp-Source: AGHT+IEOEWnieBXkh8yHoiJv4uCG5NodcMt191Vz57GuKu6TeZoH/4v4uC1D/fsb/aKsRJs8UKO0JQ==
X-Received: by 2002:a05:600c:154a:b0:43d:17f1:2640 with SMTP id 5b1f17b1804b1-442f2160dccmr62920575e9.26.1747313155929;
        Thu, 15 May 2025 05:45:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f397926asm67324455e9.36.2025.05.15.05.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 05:45:55 -0700 (PDT)
Message-Id: <17e9e9ae0e426728cb22927a26bbaf7191bc37cb.1747313140.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1890.git.1747313139.gitgitgadget@gmail.com>
References: <pull.1890.git.1747313139.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 May 2025 12:45:39 +0000
Subject: [PATCH 14/14] shallow: handle missing shallow commits gracefully
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

As pointed out by CodeQL, `lookup_commit()` can return NULL.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 shallow.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/shallow.c b/shallow.c
index 4bd9342c9a74..011f262cc7d4 100644
--- a/shallow.c
+++ b/shallow.c
@@ -702,7 +702,8 @@ void assign_shallow_commits_to_refs(struct shallow_info *info,
 	for (i = 0; i < nr_shallow; i++) {
 		struct commit *c = lookup_commit(the_repository,
 						 &oid[shallow[i]]);
-		c->object.flags |= BOTTOM;
+		if (c)
+			c->object.flags |= BOTTOM;
 	}
 
 	for (i = 0; i < ref->nr; i++)
-- 
gitgitgadget
