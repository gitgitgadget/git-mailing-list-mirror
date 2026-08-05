Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DCA386C3E
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 14:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785940011; cv=none; b=sUE6Wy+I3IZaj+BTmfXROH8S3RsQHxO3dCoDySraA8wB9X4iezvYijb3nAA+WfHv25OWiSxd3QMqwjmQ/xL4uFHmUnIv4nKwdTAiCdwkePjtDSiL3HOBm/R7+QcffXaGO4WzRbDvkilO/0XVitiggzw0OJ94iihVKpXaE80M+18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785940011; c=relaxed/simple;
	bh=CqzCJr/bYKQK7yz1Oqcth+9qT1z2kwrv7jBHJzzfJ8Y=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XezYM60QstdVNMsdgKRT7ZwrjP0M58z/B45QbjbCFQGyC+hmrMnMqSBUHmyxRd3Zj2A5xciba7eDtKaN1/VKVD7vg55ytFUbmM4hYVpBxqfJo/88YQwwOXXvSWEjDZ0FYuy2ScNOjskzYFCckvIhYptFoH1lfDEGprsB926iL8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOzDa9TF; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOzDa9TF"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-92e99ef0902so59845785a.2
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 07:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785940005; x=1786544805; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fiS3MKZxNfuXjpb0BW138Jso6uNlgcMNEe66vqL2lLA=;
        b=GOzDa9TFuFVlW5XMgsjbRipMtxIWmZc1ncUa0o/nHv9JAbNaU/Wre3zzZlImrFrGFR
         GxtFOIyRwe5HaorN4MTFz9qKRftlBapYC/1/mjsp0oCKZd75pLAPbyw3bEb2acpxhLpi
         Tu1j90mmbKMhlFh0Pe9XM3K1SDLHnCxuCPh3FMqrq2odWS4f52pCpvB/l3sumHy6BruD
         JAzVMjS4q/uipoMTdU6rciUzQznq86e5bQ8YdgEIioOOm7VnbUDmxu3VXLF5H7a4qsy+
         TiE8clmMiOH5Zu7wtdWw5DVTGIQBY+Ml5GF72mKSAg3G6NzC6UkL6wfU3VwXuPL9PJza
         b2zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785940005; x=1786544805;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fiS3MKZxNfuXjpb0BW138Jso6uNlgcMNEe66vqL2lLA=;
        b=fmNE3K5thPdftyAqt8UpreCgZ6pcP8JjO10D+acxFpE8k0KnedqxJcH0ME/c5wEGs7
         6gX/mCex5XpOaiJoWzNHm7lBwgZlAz6lJ8Xs3uIxJgdNwM6KSrA7IwJCjNr9LtGY9V3T
         GZ68kiWgAdvce5mkGh5lJj0axbxDKtg/4LpoN1yeXfcUSZLRcKPvis6H5FeCWHOSHvyy
         tggBxO7cDkrYGYcunFFJ5A7RXFguG1Jj+mnX2bSaXzlpgXK63crMTl6oJR8UULEXTlky
         Iob23XEqhSAi0VUM0bs6i/tkGIfOd1DU+Q3HG+7fQYUf1t7pVfvcqdDobRqy2l7v2EWT
         1aOg==
X-Gm-Message-State: AOJu0YwU2M3Nr3jDRYo5cTjw6Yqr0JPDX0E2xJfDkzppLxxd4+dzw02Z
	SuPKp2q0S2fDjP/2TjHfylgYluGUvnp+A6u5EtgKdoA91k/TUS4TjlhGii45ww==
X-Gm-Gg: AR+sD13zUni7JpFHb0mcofp33t3qoTgF4YqD0abuKNehf+nm3mkHYVs0dfLt8tjN7QR
	LlxjrUHX0Ky6QRy0VjV3zyEFaV0MOkvYOtvW8c2oy+p3TWopdc+8BnHoCgceQ0WZ6H+CoXWSQcn
	Mhb4QD0E+k3l+VA3n7KzuB3MVOStbIl5mQdB9g3SCl4gcqPr5wU3V3LPiHVBgi4tijdgrrzau5D
	YdXxTeLR38fZB8bS0PMuVT3/lcMqEYVB9ZdLS47hDqPxRJUnKwUPuegE+jN2ng4aSr5ma1875Bi
	K+aphhiaX8vzjoSJKfszJgSqR/T5bKnyGRKhCeDHeco0q3BeBCuXbm2f1jkQV7/kwG0e5n0vD2R
	NcYDsE5H1oIcSh8/qCydZ+d5vyVhSb9AkadzhbvftZG44tVo2pQKeqMBxx861vzw+vF2k+UqXTW
	KTLMay9g5mp5hCdjP5I22uyTS5NIqPbGloS8U0r2RfzlOxiuCExqhpOsfwGaVwpBGEa7D7g2sOX
	iY=
X-Received: by 2002:a05:620a:5ac1:b0:92e:683f:48e2 with SMTP id af79cd13be357-936491320bbmr394879385a.32.1785940005369;
        Wed, 05 Aug 2026 07:26:45 -0700 (PDT)
Received: from [127.0.0.1] ([74.249.78.162])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93657e1afefsm16384685a.30.2026.08.05.07.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 07:26:42 -0700 (PDT)
Message-Id: <47fc97458247529f9d2205cd7c0bdf5125ad8832.1785939999.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 05 Aug 2026 14:26:28 +0000
Subject: [PATCH 02/12] mingw: stop hard-coding `CC = gcc`
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

This is no longer true in general, not with supporting Clang out of the
box.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 1 -
 1 file changed, 1 deletion(-)

diff --git a/config.mak.uname b/config.mak.uname
index 8dd8acfaa5..a464b2009c 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -771,7 +771,6 @@ ifeq ($(uname_S),MINGW)
 		COMPAT_CFLAGS += -D_USE_32BIT_TIME_T
 		BASIC_LDFLAGS += -Wl,--large-address-aware
         endif
-	CC = gcc
 	COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO=0 -DDETECT_MSYS_TTY \
 		-fstack-protector-strong
 	EXTLIBS += -lntdll
-- 
gitgitgadget

