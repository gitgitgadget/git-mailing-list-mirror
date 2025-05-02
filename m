Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CB51D554
	for <git@vger.kernel.org>; Fri,  2 May 2025 06:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746168781; cv=none; b=ljaGfHkTwMmDjoXkYIT7W4aRL5zaDQXJvwCcGyn7UzNy34LTHe2XzZvDtNXy+G8EzBL5Gh9wgocNkrwVSRhY25GS/pKuazOE361kMoL4NlvTz+s7cU4Jld4zO5D/WnJxWIxls3jBUZVem3ofR93iqTwWDJ57EK6qXmMn9H9R+hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746168781; c=relaxed/simple;
	bh=/g4a2C9wj9jk6VVSLe6/Q226dAmqfMCRhPEmRvdRyUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eEp/QMCYSqyGZpW6a4J2yV9x5c4JyigPErYEODqQz/af8NbhWXxTgoxZSa24BrrwKK+1E+nH4lYD0aOAiCButI1naZ/BvmjZ1VWy/sNdSgjeJ+LNoqWGmRfWhlBAE0MXiqqrdDiRJWvxsahZal9MaaKNc4r3JHffiLHa8bqG20g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c3xgDAwm; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3xgDAwm"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e5e22e6ed2so2534526a12.3
        for <git@vger.kernel.org>; Thu, 01 May 2025 23:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746168778; x=1746773578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/g4a2C9wj9jk6VVSLe6/Q226dAmqfMCRhPEmRvdRyUU=;
        b=c3xgDAwmGMNdI4aL0pxTSqrRI1MYM2uADj1xMduvT57QxZZEG5NSPEcV9QLIZEUjKl
         5DP3TrnvTs6Ue+zYIwOuntcBSBikR2/s652p0iDQjQrgeZwfQrtgeRObFJO2Yg/uML56
         h8mSCu00TtgPzftjEPR0gEEBp77uQGLm1z8V4v4EfSA9h6PtnCpByF75ul43w2E9StQ5
         WOMvjJx3H2ajKS7dhICss93MEFacJWRxLH8Re2ocAR9TOkEDmF+QPLpNiEmd+WyJBQP3
         DhPrN8P7zCuRWdWYedVF7TGQOs+LSyTkl2FEYo+e80rEr5eO6o4tUiyNzg7R/LG0p/mp
         yr9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746168778; x=1746773578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/g4a2C9wj9jk6VVSLe6/Q226dAmqfMCRhPEmRvdRyUU=;
        b=LdgyGFiGkYRopDICesXoaGhs1eZlTjlmAxjxNUQTxVZFW1a9q8HpsA1Sne2euXS+FW
         RNr4qddKSl+6heJVYksGTbBmYRzs1rl6h9uivzT50yAPSGVJT2PAPcQT91sZZHlmX2I/
         kyW2IxwgmXF/cKBUQ8OPfyFlcMJLdQKTBYOcBWnhtSGil7Djmc2o+PH82Jyck7bIipJa
         KFFUrusW119ctbyhzOOOsBxRBPMvlio2aN8yhJJGNK3HA2d4QFjpQxk/U32ZUaLye/Fu
         WUX3ddpq1pnV6/06/LDXUHnevpRF96105JaUYYHaq6Z8MyUvLaiXFunZ2mcy5HKadPut
         ErXQ==
X-Gm-Message-State: AOJu0Yww/KlfKfKxOS8l9Ss6txXY7QweT3XBrr6uDHNy7BHgK7J9B3MB
	ugz6XG1wtPo+y1/C5g/ucx3HpJ2dG23/n4KjGcrDvqbtNujecwRNBZiSCdXxD5Le1spDnQAwm4y
	MiEY25ynLgbCUCXmlndbeKE1/V9E=
X-Gm-Gg: ASbGncuxcczAQan674v4x8GfzmPrjzoLbWdHNCrkB7SNa5BkREYx1M7xXX6q+nH/9rU
	PxERLfhXJPuuDs7PTZJd3csvgKLYHxnyMeX2PyJOEr+HNhM3jZURECkivLbnPhjjhc4Qd78EwNs
	YnLfzydjldvdfZLvsZ8SYOcmVxWobFh5yeQTtEL95hxpKFA3eAzD6jyQ==
X-Google-Smtp-Source: AGHT+IE97gW5bkC9iRmEKWG4FTREgri885JdlVisjuJbfaba1tvWyUyPyeNOLUG842nvw5AjvFjiONVWtEyzF9TKhAs=
X-Received: by 2002:a05:6402:27cd:b0:5e6:17fb:d3c6 with SMTP id
 4fb4d7f45d1cf-5fa788e5bb1mr1290149a12.25.1746168777728; Thu, 01 May 2025
 23:52:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP8UFD3b8as+Qk8=TQACdXqCpNXxFtW15m4G76=r-WzsE3QbkQ@mail.gmail.com>
 <5aa98652c43928fd6f43533498e036816d3a518d.camel@netcologne.de>
In-Reply-To: <5aa98652c43928fd6f43533498e036816d3a518d.camel@netcologne.de>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 2 May 2025 08:52:45 +0200
X-Gm-Features: ATxdqUGFX20AyC4J8ytzPRphZg6iV26l3Hmi3HrEteqwHiQzyouJZKa8x6RszzA
Message-ID: <CAP8UFD3kxAH_CzUtsn+4nAuqgdviPyupvz2OudmCVeouei=VvQ@mail.gmail.com>
Subject: Re: Draft of Git Rev News edition 122
To: mja@jansen-preisler.de
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>, 
	Jakub Narebski <jnareb@gmail.com>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Daniel Barkalow <barkalow@iabervon.org>, 
	Catalin Marinas <catalin.marinas@gmail.com>, Martin Langhoff <martin.langhoff@gmail.com>, 
	Darrin Thompson <darrint@progeny.com>, Patrick Steinhardt <ps@pks.im>, Scott Chacon <schacon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 1, 2025 at 6:36=E2=80=AFPM Markus Jansen und Julia-Anna Preisle=
r
<jansen-preisler@netcologne.de> wrote:
>
> Supplied some tiny corrections and rephrasings in 1a1236f and merged Brun=
o's MR in 8a4a501.

Thanks Markus, the changes look good to me!
