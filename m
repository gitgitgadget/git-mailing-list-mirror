Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46763911AA
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 07:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782889478; cv=none; b=E8Sk2Ps2pwCPXIgpQb7y4HFJKiWLRhGwnQAfRPQ91Px59tMBxixqtyLQ2nO3uFYixAyj/Oyurfd1skXyagLneDWh1ClCTvzkq1ilSEWozhJC/jM34KI4RPzdAgn8qPcXbvqewCjCMpxyBakxOcLpStYi9+Ezbdj7X9IHJTomFT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782889478; c=relaxed/simple;
	bh=SH7RUcAeprlhAgqn+IgGxe+bI7bnWPn5+7K5rpamSx0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=kzlIBWUmpTkkABwA+a2qPdaXL+G8uaTIFUHzsCv1QEB7jhJShnd0Er/oJveRwEaBDIty0MmF+NQJii31YhZLmGHW8Lx8kBw9njjKyNjyj/YpeT2DbY8xgSciT84q+P9PEQ4E6c60QON3zwjT7LNqs7JPsb+hVyhMF4kkFddhpWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=exdYPqvU; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exdYPqvU"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92e4fd65b2bso18678585a.0
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 00:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782889476; x=1783494276; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YE/Sqd6Wfutjc4EGIS1/0UWCB2iaVBdEkdIPWyR9duw=;
        b=exdYPqvUe7OLET9bq/iBgXqydh9mvMYJOpsGQ/0hd2C3OfunGG9kivgN+rTUfNcSz2
         qzdXS62BYgo7qGpSCToGG6eCZqY6TttGh2AaoGo/yd70L/nhi6E1c6303H8QjlCVwxtr
         0rSodomcEkyEh2VBYC4AKwaTjSlj+Nmhdxw9r5lgKW79dZR+utDYTNaSAEVgXfiemVlx
         hjoTnFJBJWEqVUcmgOZqBIws7Vm3T0KmRJI37gQjPow0dVoH9L25gdDKIzXEDJPtLzFE
         qmFBPBkG84EcYRBxWu2Ml/A+/YjMu1HUlHiIblmibIaoi2l147AZUyDRz5lPXBqWRMlg
         McEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782889476; x=1783494276;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YE/Sqd6Wfutjc4EGIS1/0UWCB2iaVBdEkdIPWyR9duw=;
        b=iGVez7zxwLdCsZDIa5Ffejspso8MS+A/uIYGpoXuLQJJuFEwJ/F9Vf5DDOy5ho4j6a
         L3nNmYqug1vudhWV0c/aob/slxzIW5ZBYbUoV38NrENZxppEluHiE8Cn4alGZf1M65fh
         1bu3b7DRhWS4J9X0DQb7RbWJY+iNMkKUYXD5KcIU2Oh86crcfzSSsTfICScyw5zKw1DJ
         wqgCVt1L9FXwMBrXj9KtqjhCjFm/4tBspuedAQwfOmKwCZCKDyCNk//xpQZGEuzopUNd
         gwY//043GVbFoAERpwLecVRFvJn19NCYhJ8W8156hzstwrrdXyIGjdUERX8kxnid9AJS
         qXrQ==
X-Gm-Message-State: AOJu0YydaVzb76K0q8bLSkYfoZ9zj4W59nCUDphhiERJMtkO2OuOKCYE
	m8EDd4LakVFMryDHZFWUtGrtCRhBEJzPGVIWt6QSElMP2ZJexxqYM4IjDA37ig==
X-Gm-Gg: AfdE7cm1Q8ZOHpqipzy7nX0U2N007upN6EpW5lAaLq95ZZWxOUV2MufeIh3PGOtOJk/
	eW14uetBi34j+9vMUM4ssK7wu1ixhHzIV17N8Y16LzED0BguPGisEODVpi0cWpWmlsChKAilt4H
	DcvBm/Znz7sQtaqvN2VUAT6hwPz7SWkXvi4ik5ReWWlm2ZweDNcf6/ZsRDeAd14dDT2JMr1/MyA
	USVHuXxt+wU31qUmKCtcM3oGlC4/1LWnu/VNnlXPmhKVMsuBv/FH6zMh2PkSI6Al67ytnodBM73
	LoYfG3LIPlgRzr3v8m1d7kRvY+qvR4WJe3oWAXclvNlqRO9Hf1JRlw7oYODvgBYugH0Q19zcVVY
	+Iilm6VijjeRWqbrswx26ahnWa9nauLXDho4NPltGHDr1uc8IW5fsPh8o48+bFBkb+b63/OWdC8
	ShcsGqBX22/VQnEmFk
X-Received: by 2002:a05:620a:700a:b0:92e:5c57:1f1e with SMTP id af79cd13be357-92e78512a58mr58770085a.73.1782889475870;
        Wed, 01 Jul 2026 00:04:35 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.44.231])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e6234dc50sm480395285a.39.2026.07.01.00.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 00:04:35 -0700 (PDT)
Message-Id: <a1cd229e33c0ecf8ccbef9ab07b4b93896eae22e.1782889472.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2163.git.1782889472.gitgitgadget@gmail.com>
References: <pull.2163.git.1782889472.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 01 Jul 2026 07:04:20 +0000
Subject: [PATCH 02/13] loose: avoid closing invalid fd on error path
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

write_one_object() opens a file at line 186 and jumps to the
errout label on failure. The errout cleanup unconditionally calls
close(fd), but when open() itself failed, fd is -1. Calling
close(-1) is harmless on most platforms (returns EBADF) but is
undefined behavior per POSIX and can confuse fd tracking in
sanitizer builds.

Guard the close with fd >= 0.

Pointed out by Coverity.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 loose.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/loose.c b/loose.c
index 47b7f5ec38..2c6db45245 100644
--- a/loose.c
+++ b/loose.c
@@ -202,7 +202,8 @@ static int write_one_object(struct odb_source_loose *loose,
 	return 0;
 errout:
 	error_errno(_("failed to write loose object index %s"), path.buf);
-	close(fd);
+	if (fd >= 0)
+		close(fd);
 	rollback_lock_file(&lock);
 	strbuf_release(&buf);
 	strbuf_release(&path);
-- 
gitgitgadget

