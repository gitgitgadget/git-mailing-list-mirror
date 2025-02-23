Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0C01E491B
	for <git@vger.kernel.org>; Sun, 23 Feb 2025 20:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740344199; cv=none; b=rg80W09YbGgPTQYWzyqKKXeY37hVoN2OcPo9pfc2HET51R1RpO6JUmvvskj6H3NctyJL1qZoa3QsuQ8PKWxHe/bn5S4V2d8dT6FBzx225/GiPogwvlYTmjh2ylk62vKvjnOKbqJvUCiNC/MTEgsQEMiDklyHs0idpqP0KHhrCWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740344199; c=relaxed/simple;
	bh=rtSkvmQReUV9/GmfAkdWIzj7NM0EBWRjyU7nXFBXHOc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=DdC5IZJQL6ZO3s6Twam1G2CKszfkTksvvgLXl8WxuoXmwD7ZruwedKxgOtVlSRwA6Q67tsJrpaZCQDWHJXceRL5FvUpAPeokTDaNU6fp8rrs/HqUHzziFssPq4Gn1tycadRVxKLRtUdZC+tqzYJf+ysCjJB2HQC0a4ZRQ9j5aGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XPQ17MA0; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPQ17MA0"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6fb6c36ba25so31727227b3.1
        for <git@vger.kernel.org>; Sun, 23 Feb 2025 12:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740344196; x=1740948996; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rtSkvmQReUV9/GmfAkdWIzj7NM0EBWRjyU7nXFBXHOc=;
        b=XPQ17MA0zwl0MRZE5TSyyc7UjIFuV3wkS6muKofxqSr+hUpp0X4vtRDhSIykDW+lpD
         xiGI2rgRxCf/2PshM5CP5U8zlaqhXqoxqa7JTti2MZldCYJZ513sgmMziUq5R94KLeqz
         ErXry0C5tHZKhnlikJdDbP8E5eiELuSZGQBnFu2dbbs0ZJTtSht30EUPKd+P1Auw4ERc
         TdDdgk+OvE2u0nL2ikJrNqWuz8K3em0z6+o2xDdwFyyA6W9fD/mLO0oYxhgjxDr+A6/X
         X1+mQmo94Ty19Ap7TaTLcgkIiFP4WFt/jMNkhEEwgYeZcXYSbQTwYhBBcoRgu2xEWqHa
         sJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740344196; x=1740948996;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rtSkvmQReUV9/GmfAkdWIzj7NM0EBWRjyU7nXFBXHOc=;
        b=eJbbM0K/tcvfSUa+3rNKRDc0jkjcQC2bT0niAmNY/UvocrYSOIN6HRL4yxD0b9AxBd
         xrASRGkzGaEtgN2k8wSzEqHuci9jwZV5BYGq7MZc/moVJFN7OlogHDiT+vmrQDnC5Yok
         DBve/rDcyTl2NTGCyJnziifz1ZsDkquZmQ4hoOp2oTGOoAqOJ7bkpvt/CpwQVSzqwtfT
         INqjFHcUSuv8IRyu+P6fXSi68ZkG0ZhantlO+J+gwHtQQNCzX98HJb+Siin1vXq6raLK
         +Fw+DcmzQIS8sM1vUN/r1MHKlUAE31ePkFBJ0385cflquysJjjY0IN1RfgbopJxjsjVl
         vUYg==
X-Gm-Message-State: AOJu0Yz8H0ya8j42QRGcHCO6WXW0qlX6Qhzbcb3iucPQwGp1rLvUH3FF
	i6SxUcjhq4X7HzzyaPU5uxbpNRVoHJCtD2F2Z+fyuOZVJB0inB21j/TyXCmD2HyFiSgrAGQ+m0w
	XVcfL8HDK/TSFMxc6eh9ji8AJeJaicqcLkx8=
X-Gm-Gg: ASbGncsL97IiQ6hiN4UrAeaEor1YfNHw9IYXwZ4TqvmEJhWwHeAg6XNUkIeW67NBQqX
	FWHE04YXH52lNYCZYdOiKwfpLN8/cBfEnsyU8qZlMfZFMDP3tIIMlk0B318dYMy6KWEjZDnli17
	tdfbdiKr0=
X-Google-Smtp-Source: AGHT+IE7mZjFsixBY4p30nfjUHzIWiFz0kbg8gxynQCWj4dTYTnRJU4fXmrDlUnlad1raJ6GkwqNjS07LCXWD2jtB5U=
X-Received: by 2002:a05:690c:a98:b0:6fa:fd85:a2b6 with SMTP id
 00721157ae682-6fbcbe0cc2cmr85687077b3.13.1740344196431; Sun, 23 Feb 2025
 12:56:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ruggero <giurrero@gmail.com>
Date: Sun, 23 Feb 2025 21:56:25 +0100
X-Gm-Features: AWEUYZkpX7nnsyBj7rc5qPre_HisPDy04Sm9aWg05UKgiTx9owU-oK9-IfudbhA
Message-ID: <CAFXmTzjQuZn_b-nQHkYo7KHs9__gc1ctoLx0KioTcPEkqak+9w@mail.gmail.com>
Subject: [PATCH] doc: fix typo in it.po
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch corrects a minor typographical error in the Italian
translation file (it.po).

Signed-off-by: Ruggero Turra <giurrero@gmail.com>


---
 po/it.po | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/po/it.po b/po/it.po
index c4af156c80..e43f0fea5e 100644
--- a/po/it.po
+++ b/po/it.po
@@ -17602,7 +17602,7 @@ msgstr "Controllo la ridenominazione di '%s' in '%s'\n"

 #: builtin/mv.c:185
 msgid "bad source"
-msgstr "sourgente errata"
+msgstr "sorgente errata"

 #: builtin/mv.c:188
 msgid "can not move directory into itself"
--
2.48.1
