Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8894832C85
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 01:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738806221; cv=none; b=POD/UDGkDTkVJ9yX/iuoKNhiyXH+RBdhwXwh0ix5e1tFumarHFw5s10XCNXOOwQs08iMhLygA6i+Gvt8mPAMmktVpCNjLELrLzoWH9HMWGEnzcKxOdJcsZlZT/6a6vcKZCA9lPM2ZX0INeLxl5wACY12J+lJHWCIsIGlRwez2Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738806221; c=relaxed/simple;
	bh=Iw8Ay6nGEszhp2p6Gp8/bkPArTiWMWj+4KTCpmlW5iI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I9FjsDr04dDdOZaDxYzu9IWGy7mFFAY9FaOpx81Eeb/OIJO1tyn6grOzI0q97YXJb2kIeGCra5wIG5ggAGBkcu1JZNgB3eBNT+raP33RSvFEmFR+jGIcCluFqpGZWIl83aTneuFSG4ihDKL6lTPqkptqrOKFoASsYs0cXf2G0u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWS8W3Ak; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWS8W3Ak"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2f9bac7699aso471761a91.1
        for <git@vger.kernel.org>; Wed, 05 Feb 2025 17:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738806220; x=1739411020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bxyHbx8gHGtWcfJ4/nndNyYutDOnzGrQwn9U1D81eZI=;
        b=XWS8W3Ak4BxYgXvTyBxuInpyVuaEHQUbv1thAhz0m3Jd6Balg7uVMyJr1f5tSH1FRm
         t1qNaycSFnZulxWHrVCx0ODiElWseI8PEYfUdBx/AAyxNWpx3DoozkNrB/1/K36/t07V
         bxwTDVKlXAbJk/FNhvf1XmlhKHz9bipTbn2aujPbegfGVz3eZDHgnik8E/IHRCAV5xwm
         CWakvlj74Ic94bhrEyKlN181Go3JwRCp14Jy0E4rCtLbfB2daIsUZfF8fNRdsLuFcS6g
         kiFgWhXhpv/3Dc63PrvntLy5KS3Dtb2qLo45hCH6xMvza42oB1DbwVBs6187Fw4hil6b
         ANQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738806220; x=1739411020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bxyHbx8gHGtWcfJ4/nndNyYutDOnzGrQwn9U1D81eZI=;
        b=jFYB4GomTQTLUb2hQRriYxb58qIT0t943ttgVCvEkOLOSprz0j/xUt9wYeMHA6cygz
         Cvm/GOVLcdXoD5v6ydLjpMGi/0qYdViwDMUVA2SAtXdbtNv52FEbYjUmcP626ipdy5nC
         B2CfCgFvIPPima9SLbWcDwX6/B3SUVyovuVCwMFvpF7xFGIznpQG+mUGjpfXeRDv7sSc
         TFgOrovvoed8wwQ4Kty1RARhea6hm+hWHj4+PLgkkSXXJgTsa12SlZ9j8CRXjX+3CNLy
         OGLoUAsMfbu8Kf40Qa4KIYkjidEBCGDiF/DQBt5syMO8uagdL+hb/V76k1bB6Sm7/OqX
         NvNg==
X-Forwarded-Encrypted: i=1; AJvYcCXGPT6F4U62bj7JnXrLi3kHRyzv83RoAmMEDANzhHY82IT4Gw0tNCG9g896SvS0nxRdDjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyuB/wpzfP8z/1XrZ/GpeLk8VIdbyZwEEWAWCJgHim7ONcz5Yu
	7VKNhAFCv3ibdPyMGWIvbhAA1MPd0h1HNDwrv96kJe+UlAdVuKyd
X-Gm-Gg: ASbGncvS8aAUWn+J1WJn2rulb3TEZOOYSCur/ejyKeukAnMsDlxvWbD2RdBrSXaG8Q3
	xOtozJiSKhCI+48PYleuJ/tlPprLHSLe2dDH8U9lov6h79s63RSuH7iXcfWL8wL2C5uhF+mlS+3
	5EJ7xPPyeGYYf+E1FDfRPM993xBxVJtZzVwXqGG1LjP3LbphnNVM5z8I9tun40oPleXLcTrW7eh
	KY2gO7xm3jTd1OCqSqSD77ps1nZaG+511+pM/5QnDg+TAKDEzBbZGGaTIOjYGvMACsjB5Be326N
	nfep100VMtVqsmwlaEblzPBM8aGPPSoJvD43xXs=
X-Google-Smtp-Source: AGHT+IFT/7aRkA22KPnxJyIMMZVP8czuaR//RcuuijSIWtIuWcBYrTVzIo9BHBlrj0m0j73TgeS8KQ==
X-Received: by 2002:a05:6a00:8d6:b0:72f:d36e:7f4a with SMTP id d2e1a72fcca58-730351361c3mr8054581b3a.13.1738806219680;
        Wed, 05 Feb 2025 17:43:39 -0800 (PST)
Received: from gamma.hsd1.ca.comcast.net ([2601:647:5580:5760:c1bf:72b5:6aa3:f684])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048ae7e54sm130111b3a.76.2025.02.05.17.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 17:43:39 -0800 (PST)
From: Illia Bobyr <illia.bobyr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>
Cc: Illia Bobyr <illia.bobyr@gmail.com>,
	git@vger.kernel.org
Subject: [PATCH v3 0/1] Long names for `git log -S` and `git log -G`
Date: Wed,  5 Feb 2025 17:43:15 -0800
Message-ID: <20250206014324.1839232-1-illia.bobyr@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Same as PATCH v2[1], but removed gitk changes, as suggested by Johannes Sixt.

I'll send a separate patch for gitk, should this patch be accepted.
Or, I could include gitk changes into this chain, but just as a separate patch?

[1]: https://lore.kernel.org/git/20250205022422.2019929-1-illia.bobyr@gmail.com/

Illia Bobyr (1):
  diff: --patch-{modifies,grep} arg names for -S and -G

 Documentation/diff-options.txt |  36 +++++------
 Documentation/git-blame.txt    |   2 +-
 Documentation/gitdiffcore.txt  |  48 ++++++++-------
 diff.c                         |  18 +++---
 diff.h                         |  11 +++-
 t/t4062-diff-pickaxe.sh        |   8 +--
 t/t4209-log-pickaxe.sh         | 106 +++++++++++++++++++++++----------
 7 files changed, 142 insertions(+), 87 deletions(-)

-- 
2.45.2

