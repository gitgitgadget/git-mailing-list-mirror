Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE158214A93
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 14:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748875936; cv=none; b=rqE0ufrRlp5HaVJ5qScENARMgIK7k5NKHWPMtJitJ//RHSIv0k4RcXNtfX6uLUtxiXI2+OioV5EPOaadL5mNk/Yk0wZBrpm9rvbvFcpmf4MN4UicPqUhwc4jYebj/Og7Na95Faht7hdmoLFup4a64922LdIfYhNKjXgyGhOLbhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748875936; c=relaxed/simple;
	bh=vfznBefUuIh2h+fdWI3XkO+/op/zHj01EH6+0j6mOWg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=RsTUvBVRgNaDVIjDuc9l10CoMaZaibMiiM4eTHzIOZ22em8RkylU192kvAc9LbCL/HGu17fc0rzQRaoJLMnuBsEmxjZS/nIs0LOJ3+mDIyeimuAxEOBorJ93hT5IEGcUpsZPWNOlSJ5/cnYhiaAP/lvyeQea2Xt1qOsOxvndfMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKkIcOOR; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKkIcOOR"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-604e745b6fbso8799161a12.2
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 07:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748875933; x=1749480733; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gAzZ3D5X7LEERLgvvvoOlIyb1mlla8PmaU3FSXoVtrM=;
        b=NKkIcOORSc6ydi3hL6RZpz+z38m5JpqwzisSMgFZrzDzD3Rt+4eS5gl/bIy860JC8K
         78zCbjK13r2Wx43RK8c8QZdwWTqBJCJb6RzzARLw3ww+hrHFOTP7w88pAeIhxYS2SjE2
         8joGwadlG19+FW+Rxoi5WZgSFVmT+uWOzM8jBkhjo7YJmgLk4wfgcuKJcfwSundnPEvQ
         fXLrrAaLynm7+HyfFPb7s+iB3v1lr+0gixGo8qn3ll8ETkkdjRn5LS8AR8FxV2rcsTgm
         3JvJAVtm5iyHS96ve7w0gm0AotgkfHqhM3noya/mmAWu9I/ZCsQl+hb+AmOIvKzJlIuh
         E/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748875933; x=1749480733;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gAzZ3D5X7LEERLgvvvoOlIyb1mlla8PmaU3FSXoVtrM=;
        b=wk5eXrKOUrAQREP6A/GlwwiOv7RaYG0tkf3BYBd/TlZvXJi4xPy/RNd0LVvgU0eC4r
         +yjL1RolR6a1X7u9DjisQFGFmg3T5SeoZuseHNcEqg/kxzCGVXGK0ynMSyZgutWhGovX
         YJGetJbTL3cHmzyoNH5Bgkyn/jC2r+TiZC4254DNCMzVnlQrBvPUZeRp/t4ZwMN5hO4W
         h/egpvF6w//Fbddj8DyC9cLDRc4MBWsOp9ZWL450gqXUsH7W1W3aqrNZxF2j/RBcpt3X
         k1z2J4Uz2mhCynb7CxG2l+PVbT/+BAX3s5OgkqtjplUHhTb7OZfdEh8HNmxgU+O2lgrD
         zJEw==
X-Gm-Message-State: AOJu0YyzixajmGiLDBTpBlykHerEToyD2n9OCKjobdA6lS2f+/p9noe2
	1oYJtJFV5+kFD/YUX0XfOqKeIjWv7jji/sktomnKPKarzS/a2gdItbEkzBeNGoRJNptvBePq3X2
	wClaYglL2mweO2ImTUPJfXMKOrKoKwhQRpjgZ
X-Gm-Gg: ASbGncsY+Y2raDWOX3UeR6PDE+dZRWhVXuVVjgGSrWcKLPNjHx8wcq4+p6o28JzBC9h
	XWmaVKlRTYxBIFfEBd9EThkAIwrDsTC/OUGjVYo+z3Yc7EixE/bMr3k60cMdQxYfUR5QzMKvxss
	L2BiPVuoeLuNJ2kbbSvEmBI0XezeJwxRUIflk=
X-Google-Smtp-Source: AGHT+IETbRlt9oibdtEg8uvdE1DSXawq8Ful2UC/xKaAaoT9Z2MVRfgzq0D5upPsQDTfMCgorZc6+F02GrWzs2UTeMs=
X-Received: by 2002:a17:907:3f0b:b0:ad5:7bc4:84be with SMTP id
 a640c23a62f3a-adb32450118mr1135003166b.52.1748875932358; Mon, 02 Jun 2025
 07:52:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 2 Jun 2025 16:52:00 +0200
X-Gm-Features: AX0GCFsc93_DgprI0onw4RDvtq1RCScoNE6YQ0KZmxCn02NFGxOod4XWTnNcli4
Message-ID: <CAP8UFD0Ejo-xbafEAnuxoagGSZYFyWsP_AH0Qm+SBMQ49E7YKQ@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 123
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>, 
	Derrick Stolee <stolee@gmail.com>, Ayush Chandekar <ayu.chandekar@gmail.com>, 
	Meet Soni <meetsoni3017@gmail.com>, Ghanshyam Thakkar <shyamthakkar001@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, karthik nayak <karthik.188@gmail.com>, Jialuo She <shejialuo@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

The 123rd edition of Git Rev News is now published:

  https://git.github.io/rev_news/2025/05/31/edition-123/

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/780
