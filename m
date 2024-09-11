Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485A9184530
	for <git@vger.kernel.org>; Wed, 11 Sep 2024 10:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726050686; cv=none; b=V0Lk0IiC1JDt7KXWFlfhrUYM0W/LO3A5eJ9zj81cwpElK3dp/4ef/17rdIONwlAY1/10K4qW6YZ3VgPB5Q79Z/7oGxxUYD86SzLMIRN6p1+pMwnjr2NZ1gEcatO/xMp4Zu8Po33WalSzfzVxZhisGQm9qYg1WVSS4xL6f/qRPFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726050686; c=relaxed/simple;
	bh=Ekp8LomQXDCqDMS3BG+MY46KEUv/iAvBgpRRQ8rqKvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PWwZWRvySIm8aODUgP2d+0lF4QO1rGfjCo2QwuGuSyLxsL6Z1uHqkd8Xqac0ITcL9c7lAgcd9JieIHymdDds3AGRhDNJu5cs68bEODS5mn/XymLKNZ6N9/6M90N6OU/Cy5eWrbxq6MvO8k1jPAVpisMAvYDsgPHP0QSS7BdI5CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OV0XVXF7; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OV0XVXF7"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f75c56f16aso22715061fa.0
        for <git@vger.kernel.org>; Wed, 11 Sep 2024 03:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726050683; x=1726655483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WM9TQVT3TZDQVQtvbnXzD2RT9g2CidwjvvPlHATKXaw=;
        b=OV0XVXF7f0M4TMIG6Lg/rbTt5Vg19KXhrVaCCXUrvTEoG59gb6BjB5Gj9t7J1gNl8s
         vxdbag4ENWrKuT1gtJ16AKZZ2290x/hCMudLivwpIkQM+YPWmMtCbp8sCHvrNVRGq//M
         wUqfFoz/DH2wSRvqHLz2gKKKaCaPs8dY3CTq72uYcUKVkkMbNDBgx92J0s2gCxdD1ChI
         L0n05qibi14O+GqH5EIP4nbgXRy8YlnlAPhhSvCFUwuArWaLMjwM/kJB4bSvyuf6pN2p
         eZ0uwzNdM8yrLhoyHsWjn2x0UEYmvbQ9V5ZS0LGKL8Wwf66goCaVupiWdjC82+Ec5Dd7
         8P4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726050683; x=1726655483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WM9TQVT3TZDQVQtvbnXzD2RT9g2CidwjvvPlHATKXaw=;
        b=UTgfupvs6bdMVjButRMF2NuqKH0NC/zVVU+SFAEFglfElcVSmyNcs6Y0Jv1z+GWyON
         0LGUIGcXW1M+EMmpEAfwryMIBt6ne7NnqqOpvdkgnP5ZK/hE7zNzaO2Y0hWGOTiKaML9
         XJsnb3eAx4R4cs1bkhowPHdM1ZTLA++a6tv1FImXWxFb48Wj1qE+xYscZj/g2de0Vi4f
         fCxU0EpFRIaD61hhL/mxEhHRo7dPGDsM9yXOuyjTwdwgFmamG242r0FogvJ6Ubr6iSti
         9BeX5b3V3rAkjt/iMwRy33FDJ9Hj//4rxuSJFLjrNosdRpJy/bgdfpt/ZO2OIt4iPZU3
         XhRg==
X-Gm-Message-State: AOJu0Yx/A6H5KBTQfaM0wJtR0gXE3qzIUOTfdh0RpyFC7OCUvzGKVlZN
	6txSx7LpaBpYkaf2ALpk4g3Nqy+Hsjo8Jh3n8Pn+34/DnuSqSX41lFbpyw==
X-Google-Smtp-Source: AGHT+IHCik/1e3o9ONP8/N5AERbbm1Ub7e/QsaucJ2IBhkNFTDXfA9WTcPqH0OWd96eLOgo/2Xn7bg==
X-Received: by 2002:a2e:a98a:0:b0:2ef:1d8d:2201 with SMTP id 38308e7fff4ca-2f77b7781b0mr17281911fa.23.1726050682124;
        Wed, 11 Sep 2024 03:31:22 -0700 (PDT)
Received: from localhost.localdomain (78-67-21-133-no600.tbcn.telia.com. [78.67.21.133])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f75c07c81bsm14853871fa.76.2024.09.11.03.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 03:31:21 -0700 (PDT)
From: =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] t1517: add missing LIBCURL prereq
Date: Wed, 11 Sep 2024 12:30:59 +0200
Message-ID: <55d45be1d6775a630b9f61487b6b60efab9c7769.1726049108.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.46.0.733.g1eb83ef1a1
In-Reply-To: <cover.1726049108.git.martin.agren@gmail.com>
References: <cover.1726049108.git.martin.agren@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

After building Git with NO_LIBCURL, there is no `git remote-http`, so
it's not meaningful to test that it can run outside of a repository.
Indeed, that test will fail. Add the LIBCURL prereq to it.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 This is from b25ec8b8d5 (t1517: more coverage for commands that work
 without repository, 2024-05-31), which first appeared in 2.46.0.

 t/t1517-outside-repo.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index 990a036582..342defbb61 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -98,7 +98,7 @@ test_expect_success 'stripspace outside repository' '
 	nongit git stripspace -s </dev/null
 '
 
-test_expect_success 'remote-http outside repository' '
+test_expect_success LIBCURL 'remote-http outside repository' '
 	test_must_fail git remote-http 2>actual &&
 	test_grep "^error: remote-curl" actual &&
 	(
-- 
2.46.0.733.g1eb83ef1a1

