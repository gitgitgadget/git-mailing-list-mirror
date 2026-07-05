Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078231A5B90
	for <git@vger.kernel.org>; Sun,  5 Jul 2026 08:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783239879; cv=none; b=S4mf6mfdmAapNd9mrrqy3Wvx0kgq4U7eiO70jRA3wSV/qomv80gAS/DnJ9hugeJ7Qy42jsE2yha5xHcoMa/Pxr5D4g5w56IynYbmmaCT9mwzh8fBc+6knIxsJjCZm8KqEoH/tKn08IpXuZKUFP9yP9bpVqU2C8gdvwjNYBVoTJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783239879; c=relaxed/simple;
	bh=DMCw3sBDajv3ZHeK83NBz2ewBUNE6DK9WPOuhCwb0f4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fx/9UfS4gxwz5IECDCnuu2Y1mM1bOfCNazt7VHz9psNAmKGiOZ6SaycBvWCOco2N4qE6JcBTN0F0o7USUr+iS3ZyCMkQj9eDNiWEyBxSdWxEjzGw+a2i52XFcSdFn9qBtb5XAnCCRjMt84YVo55sKXwzh5zhyKXz5qkxXecJKKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUEox3pe; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUEox3pe"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8ee43b3e5abso13617576d6.3
        for <git@vger.kernel.org>; Sun, 05 Jul 2026 01:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783239877; x=1783844677; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4WZXcMgh/PxoxPuKiz5qV/70WlivjvVfa5dacNmLqU=;
        b=TUEox3pepmQ4Kr2TCGPH72pFe1rW1rhJiuw346T+ImuILbCijBWo2FPLcA5EdUQWyp
         kio+e0mxGRi0SkpPourbP9IbhXttegXFS9qjBDCke95r2qiGfKdoIUQhsN4q1JseFbJY
         b0xHPIRbjL4uZAMTOdqvlDSpCB5DBroBzXU/Y/4nkoDJsY8WVTgaKg2YSoHxC3/vQ/oP
         wv3et+lpQDRrjL0LGOLu30ApWVVTPWXTaOACG6CPeSHcWgpScskPOpByPVNTPyepbAMe
         nKZtGm6RYAZMNnDI2xKz9GVOxaHoKr4Zw/RpFjR3JbBnMkM0/BklkVDYPM51ureh6JtM
         xM3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783239877; x=1783844677;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u4WZXcMgh/PxoxPuKiz5qV/70WlivjvVfa5dacNmLqU=;
        b=DQZjhvGAV488q6n7J6lm3HLy95HU840ZWpoI4hhzAWikPIit6GpbJqgBkpy5rZaGZe
         4Z3g4YIIWCQzJ04nnhL9p6F9qSr/PQt9SOdbQjv4gafzdaun37yeO0YRXjMzWG56iXxz
         lAv5Qr9pLGBfoRQ8nU5hO9pTOHakTJ53XhCCPWuJYGR9qtrr/j0ukvhdVgVOL89e0No/
         3iwKPOKIGVxp3G+jSihBoMsK3u7rkkd9YKL8lI+qoTffm7IK+KjEDUc+SzI9W+DGJ30q
         oC8ZoZqW+GWsv9U6X5D+1I2Jx//Fvip7+7ukV7AhEUY96dSbwZGYO4XS7U6dFvL9z0CT
         duFA==
X-Gm-Message-State: AOJu0YxFwzUaCe3ICXxYmR7aasKfLP8oj6KNHISVQVz4dyciQ6mC7WLg
	OsNlDa+QkfeSxl+l51jcelFGD5EfivylAx3ImF66S7Y9MBj4dQJ76J6gB0Y2Uw==
X-Gm-Gg: AfdE7cn6ZZvgeo6tNYtyRSZdj3MBd2Vw+2t9qWp6vL9l/I5B554iDP45pV+LWnQgsN4
	wHBRNKCbogp1kKE0g4YMzrnlAi+96QMIYTWQNPJb2zJk/Pj/7vpsYKDmfWXSFI4nCowbwDrV5bT
	pDxts0U+xvCjZzH0MwoFHTDbMJEnuFMmIuU9S8ev5I7rrgGsoHmeWNpRwiQSFswBgESsJaZ0Qqu
	nzAjOJ/No2nnYchIxNBewv9J6QnGkDrIhePkL498/PYXiHHAERbbSaiE9UaD/lgT20uio2b7/FQ
	/guYWRteFr8Xawlin0CLb60Er20Nu1NbZ4EbySsC7F4OZD4d1wtxwZX1D0YAcQPC6FrhMx653sw
	jSZJsC4oi4FEYV/0+RE1iGyKr1EbyOwOZkqRpsyWKBwQBEvxOpicP3ZsaZ2/GnrE2f/wxl1Ioab
	UVBACls+zXOVhu9IEUTA==
X-Received: by 2002:a05:6214:21e1:b0:8e9:e48b:9571 with SMTP id 6a1803df08f44-8f74c7af1e8mr77833706d6.41.1783239877048;
        Sun, 05 Jul 2026 01:24:37 -0700 (PDT)
Received: from [127.0.0.1] ([135.237.130.145])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f472a9b1c4sm103634366d6.48.2026.07.05.01.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 01:24:36 -0700 (PDT)
Message-Id: <17c3b4ce4f0051bf0c27ae157c25af97275ba742.1783239870.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2163.v2.git.1783239870.gitgitgadget@gmail.com>
References: <pull.2163.git.1782889472.gitgitgadget@gmail.com>
	<pull.2163.v2.git.1783239870.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 05 Jul 2026 08:24:20 +0000
Subject: [PATCH v2 03/12] download_https_uri_to_file(): do not leak fd upon
 failure
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

When the `git-remote-https` command fails, we do not want to leak
`child_out`.

Pointed out by Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 bundle-uri.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 3b2e347288..34fa452e76 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -378,7 +378,7 @@ cleanup:
 	if (child_in)
 		fclose(child_in);
 	if (finish_command(&cp))
-		return 1;
+		result = 1;
 	if (child_out)
 		fclose(child_out);
 	return result;
-- 
gitgitgadget

