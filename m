Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3932C2EA47C
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 09:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756804471; cv=none; b=fiesJU+yXXjloioJ6hkMSsy89LpQiOEPAvA54NjIcMrq0kXpi6dTsttd82b1VW+no2XoEITgEL0pZsuPKmX0aIvmRp1UMolsDYwZUQgNZfYZ5JzLyXy+0eMkE4+jmRxF+qRwRilZrCtn4AZJ+RylOFwtOmv5m9woLgoa4vQeTic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756804471; c=relaxed/simple;
	bh=l6UfE325+96Hr+KSf6vHKRkPhu7vrv5TheGB8SRmsHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GqrSIzsWeO7PGuid0X3iYX88eQ11rBjuyB1NRjyp58bUp+DnP8u33eT9cy7n5RLTzWC5WqUG6UUj1MhMYKVNXmXuIcmskV7DjBSBK6U6GFMT5kKxvTIrmJEkofhR6ppzUVAHCwBntCWMqECO/pM1kLx4sL7kizAQF1QTVjQY87U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0vbanyW; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0vbanyW"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61e8fdfd9b4so3890200a12.1
        for <git@vger.kernel.org>; Tue, 02 Sep 2025 02:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756804468; x=1757409268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6UfE325+96Hr+KSf6vHKRkPhu7vrv5TheGB8SRmsHg=;
        b=K0vbanyWcOqZw0rYW0akogxga+48vzZrnmmBVfZ2rY1fJd8r/gcT84F3mNiA2jQXYw
         wTFN+IvCUAmJlD+HMlyamE2CQr8icUEZSkoCj/OOQ1psbWU6Wfl5TM1n2Em7fNREnt+d
         Q+IsptxT6ddcz6deO+Rr2nF2AxF5kh3/wCynwnn8lfFW6CViMfwHQKyQxedcncBUjoQN
         eIjCP+gajAmEbVI2SumBvHuhixyEGBew3Bf4RrvtGmhfVT7glwaRK5Evjsd45YaWOy9Q
         eLdtEX3lvA2ii2Mu+83s99EciFKju/4hLLVZJ/+1AcJsNH1VkVuVe1ujIUbhmVWGIN6u
         52Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756804468; x=1757409268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l6UfE325+96Hr+KSf6vHKRkPhu7vrv5TheGB8SRmsHg=;
        b=VB7fVAz9VNHCjNHR5jX8CD3npMgmiTDlQpioTNMCk56cn6c86nQUjCBwFlXqw/EshB
         oSGjJNC5zHLIPtBKWe9MOqJJTmvYDQGjMA7zFayMZ/24ldi24IZjV1TokgYOfiWgz+YJ
         vjleWOHwEbdUKeQbk9+eeQ8Jwc90bKOM5avCEm32ih8uodH4M2W9J71VwIUSXYj1zVxG
         3/YULknFEZFy3XqSHUmcTNFZ4D80tdhxDpVApiTGVLUrQFCvyIrfN1NAtRf+AXUldXDA
         gB2THmyJZFE2w3RbVjAC4iDA6L2B0yHQOdtZwc/4XoM6gi2kZ/7q+1uBJN2lLZh6S29y
         58Tg==
X-Gm-Message-State: AOJu0YzMrLc/ipES2X9gSFuUlTMPFfS0xqf2DMwy4c8041Sz5qGQ+cU2
	3a5AxfY4XkxfsOgyqxWA/N/aUYoQy3NJEXskzlPP/UBv+wpIgwqqzBENCPkDU9Rbg0OJK8/hNO1
	aEuBrEqdYEQmA4EJQoCDtx/hkD+ZYBXs=
X-Gm-Gg: ASbGncvntMF8UgTSxKXTDMxkc5Ym304PH0d6k0ZmLBqagN7P7FrzrXa7WZUMTAtjjBq
	zHFumhwRILgrgORNXo5zpHYeyTqoeEAT++kcvlRmDmIOzXtVXfWT5wZ2oTVhH+7+PGb3nxeKs86
	xCm7/jmrskxfycRbr/tU5vd5Wtc9eVarVxecIr8TnffRLoXor4J3pSQjPa2LZCJ+Hc3jtnRWLo3
	TZulcyBEq7IGpJ/5Oe8lqzVd4IWMltXoJid8+mB
X-Google-Smtp-Source: AGHT+IHeslsmJAVsykvJ7yv21izWFo0lf2IXj7q38Tj3X5MgmUGSgp4jgbfUHcdJnRjkbs8Wt1ATy1WvxxkjQFdp5eo=
X-Received: by 2002:a05:6402:3494:b0:61d:9a4c:d03 with SMTP id
 4fb4d7f45d1cf-61d9a4c0e7cmr7366694a12.13.1756804468389; Tue, 02 Sep 2025
 02:14:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP8UFD0Lh8caRsMV0nUB5Oge_hwLO_WWMAqxTqd8eY7mqwA-9Q@mail.gmail.com>
 <417d5e7725eac11750468f064e1e4f8ca06155c7.camel@jansen-preisler.de>
In-Reply-To: <417d5e7725eac11750468f064e1e4f8ca06155c7.camel@jansen-preisler.de>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 2 Sep 2025 11:14:16 +0200
X-Gm-Features: Ac12FXyM2wWVQurQ1-Je-2KAsJ39bV-r00Oq3ExTHlweqptAenm18ArFGTbpW4Q
Message-ID: <CAP8UFD1nsPjhK0rEzCc5n5OCJ8y3Xs4D+GmdwZv3BANQZN7MsQ@mail.gmail.com>
Subject: Re: Draft of Git Rev News edition 126
To: "mja@jansen-preisler.de" <mja@jansen-preisler.de>
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>, 
	Jakub Narebski <jnareb@gmail.com>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, Bryan Lee <hi@looping.me>, 
	Lidong Yan <yldhome2d2@gmail.com>, Seyi Chamber <kuforiji98@gmail.com>, 
	Johannes Sixt <j6t@kdbg.org>, Ben Knoble <ben.knoble@gmail.com>, 
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 10:44=E2=80=AFAM mja@jansen-preisler.de
<mja@jansen-preisler.de> wrote:
>
> Supplied some fixes and rephrasings plus Bruno Brito's PR #794 in
> 408a216.

Thanks, it looks great to me!
