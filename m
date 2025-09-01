Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB8625A322
	for <git@vger.kernel.org>; Mon,  1 Sep 2025 07:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756710623; cv=none; b=XizX2w31l1mdt2ADl1+ql56P8SWsnDV9zxIYDi9IgkFtLI934IYaWNOvnCfL7AoTrC2GBLxI+b+jPoEeLQc5uw4JlgfMRy+iPtABpbr0F3sSbnonKM+MzcFtNztgfQGE7BwvCB6xgTkQElN5V/sxDeQDSsSCjT1vWYV3h+Ce/Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756710623; c=relaxed/simple;
	bh=CYvdfo0vVEuzSBivix6UzixAf0fXxniUawiRm+G93nI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GOqQ6zbKaaIAPhN0+iGoJRkE5e7xodoR0s1U1x0U5caTEROyn8p1niHagKhHo0g4GOvXEkFoAF3OijwPHNm6QA/jXONolVj2BkB1Yye3N93hQDbK0a0ijcmBQzD7mUfXtsKWdwSG9gU5OwbHav/lZSV8we1yDCBqBMd2hLmUNYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4kjI0l/; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4kjI0l/"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b0411b83aafso196845866b.1
        for <git@vger.kernel.org>; Mon, 01 Sep 2025 00:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756710619; x=1757315419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYvdfo0vVEuzSBivix6UzixAf0fXxniUawiRm+G93nI=;
        b=H4kjI0l/DhRWYQe6LxB1eGKMD2PxIIdCzc16XL64siTt8ZQL5cZgMxHhbrOMcBnbiR
         XLKIObpEIdONuKgd0YB9+Xidwdp3rUPvQowEZH5mDo6NQBuRB35tgwUT5BrmL1eukh7s
         H0a3RoW0FCDSxUzHzEn8sHdZ61PdCvTEP7f95KKLrn19PVyW1KD6sFr8s46DQOzkS8hK
         ykZCepaRnC/33iK1ap+9lwk5EFyUyTUOAWKQtR+GTL8OAXnXwL5JoNV9XjZHrGGcr7O/
         qbl0IWCpDTZ1zz7a+eIG17BFoWHVIRrQ0Ns9BAqZyEQ2xg/Czjyu8zwzxXJYwxejpazG
         2E9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756710619; x=1757315419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CYvdfo0vVEuzSBivix6UzixAf0fXxniUawiRm+G93nI=;
        b=oR87h2/v0iC6coOjKm0twUpjh1+Q17npCzAN+1gkwuvCevG74Z9BwJkibApCzQ+TEY
         vcg6jdmbSFRTnNDlQEsUuvfATNz/9uwiyG9XauC9hWiGWisonqpNleqSPS3XKKiS95DC
         RDSAd8ZV8yxIrC8EYheKqFsvjQzuFHgVZR5K6UwbEch2jnFu/jdbb2jJgK+f/I9J8N5U
         KEkfKKLoTvYPkA5WPcFhNNLDiBvrX1X+jLabke5VjZOpUBispa5lmBTcbt8Sbqyqhswf
         pQQH3oxRJmMq5UGeIbdU4LJVxEgOdPYAHPCubSSPd7J20o9yOPXfJcQOYB8wUoS/JUVD
         jelw==
X-Gm-Message-State: AOJu0YwVT4dxEJviYidRLCbwICXvbjw149erGgLO2FLNjBVIDeHfE3Ga
	sJlP1qhg7IKD4pYZUq1Qz/Dm9OBwAd48XcBpzwBrDlVTaeiWg2q5HzjePYPt12HojzTVx+HFILW
	RhvZmMkSdxEWGv16oFcq22JbiF1zA7HFS9oh9
X-Gm-Gg: ASbGncu5hlp9+uDxDql69DMHWrYumW69qOZRa9XROzCBHzT/TYayofiCmDoyQLSLY+O
	JhmpzUXF+6Ir4AlvYIWjJkZr4N0dtzY8PwoK8ZNmihtDLtoZ8kBwEbgbDU19SxY+ha3/ttatYHZ
	wcLQCpO8W79A39yRpZ8fQ+Kzi06IRJyHG9EPwtUgjaeqKJqySsXCvSEFgifslcD7i+IDk41C5Ql
	u0RGPkTbPGYmW5qe3qmwR9X8twcV0yvKGwoiCOA3y325/+NDCU=
X-Google-Smtp-Source: AGHT+IGWGC1Wkrr1lKzhraUYE3lw199LDZx3SUtBK1k1llFNqx46Iosl/CwIw/3BpGSovSj23J57sHvFm+yLv2JUbiw=
X-Received: by 2002:a17:907:3d0c:b0:afe:c099:aea8 with SMTP id
 a640c23a62f3a-b01d8a266abmr613847166b.9.1756710619308; Mon, 01 Sep 2025
 00:10:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP8UFD0Lh8caRsMV0nUB5Oge_hwLO_WWMAqxTqd8eY7mqwA-9Q@mail.gmail.com>
In-Reply-To: <CAP8UFD0Lh8caRsMV0nUB5Oge_hwLO_WWMAqxTqd8eY7mqwA-9Q@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 1 Sep 2025 09:10:07 +0200
X-Gm-Features: Ac12FXz2Y_IALEzVqIqPJRxTsOnvtijqY-Z2tXcasF_lqUbs4jN7QOWC9BWw3hA
Message-ID: <CAP8UFD1emQueBtphHix-fHFFn31FfUDMMhBhciPcH2QQRc8dMw@mail.gmail.com>
Subject: Re: Draft of Git Rev News edition 126
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, Bryan Lee <hi@looping.me>, 
	Lidong Yan <yldhome2d2@gmail.com>, Seyi Chamber <kuforiji98@gmail.com>, 
	Johannes Sixt <j6t@kdbg.org>, Ben Knoble <ben.knoble@gmail.com>, 
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 12:28=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:

> Jakub, Markus, Kaartic and I plan to publish this edition on Thursday
> September 2nd, 2025.

Sorry I mean Tuesday, not Thursday.
