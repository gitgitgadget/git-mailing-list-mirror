Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CA222541C
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 09:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751966210; cv=none; b=mQspf012Gm+SXhgWLbrfKnL66uLM9TCpMdHnMop9U5Z7uiE47tUQLT3F5W8Xx4AT2sChZAoi9dpjQXEU5m4b0uSh243YRK0f1hIPY25SB+CJlbb1S0BQJUNQOYX2Dre63bDnwLxnvnB2lJwbifOx/yVXD2CtF8GwK9zuLxfxaxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751966210; c=relaxed/simple;
	bh=DsKOG8ptV1GQ7rJ5V6HdVvLcS/f2sMIZIKHnVHjRt/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L8GFQm6qG0o/MqQb1qInAnBacIoszWCb8DeqQexrmxXPLG+iDQq5s/qgFNjO4GWxU4CklOWOcetHFdNPYzXiqtc9glx8WVhN3GFNg7zpaKlyt2m7gEITI7pUnUa/bAtv7oOsDGBotgsCKO43RF5eGf5orknCdYLimjuV0I42tNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUDLIOIp; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUDLIOIp"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae04d3d63e6so685092166b.2
        for <git@vger.kernel.org>; Tue, 08 Jul 2025 02:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751966207; x=1752571007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSnL8I+nYCfQDf/ro9/qqyqOTnjNd67cTSDvM0f9lPE=;
        b=mUDLIOIpERRv40NsicyDr/kSJOIn1oXQkyaaKIiLQZMkVjyPwbWlXY8l3EWOll7WMJ
         4ylDNGDl05M6WoHByvjxoNKiJsn3aD4uyqLvaU2YhJKyS8O0nU+F6eR/ovuJbzvWK4Bc
         BqcWfe5Lsv9xncTo3abI9EYYeie3DAvwiOIF+v0ys+wMVOsH9szr+cS1746yDIan/6f6
         moGCaSPtALMbNBKKYqZaYlK289WpMqy4yp2gLQQe5beKBwbyQ6xWM01wnle3dmXtjhu5
         DroGM8P38X604U9+bb7uBT2B9z6H4kJ8uZXszVzTQxuLNT+3m68XeHyrm1Jcu5Y8ZYMx
         fVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751966207; x=1752571007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSnL8I+nYCfQDf/ro9/qqyqOTnjNd67cTSDvM0f9lPE=;
        b=rMi7Exe3hEpy6oJG98dVvNNeMJacdSdJioDt8yXUQ+dxWXDD3TRGZorcDnm52m5m7i
         DEl+PPMAHin2qCW7YbbcaK6WARHtpzz7irhyQGhBI35lit69kMviE5xbOwzuSdJXqNlY
         xFK5sBICLRSNzOcV9uDblW3f8foacRoLmMdyxeKJGO+qiksqbKUpoUCcT2eBYD0nUBsz
         eEbDRg4WtRzdamW9Ef/zzwSQoykse0ck/D1/bpUsKULaYOTjZmv1qkdZ86nuLGyPmL5N
         B87ooBvQDgHIxV0RllPYdIuKS7ftIM8nrBD53tVLp1vtjywacjojQo6Q2iCRzmXXNQnH
         ++Wg==
X-Gm-Message-State: AOJu0YwwNZhZNBwkp/5/fYOPwlVRsN96vAlb+3yGomXUlFXlzf+IscDK
	vwI/ebhpAVm2pxhdpt7ZuziN/r8mGYeAM87Vdx6XLlJj6sVKkca07ucLtM32LQtFXVBpj+2OZdC
	ulj1wFzSY6D93qIVqg6LSX/0sm6XUf8Q=
X-Gm-Gg: ASbGncs1LNivYFGHFupKFHb9hLpTprK/l/czQUiLNcpdkukmA9eVVWa61HiUj+xM5zv
	kqbKhXuwM07K83J1k5uI6XDTDKpaM0OkaxX0UTVhoKlrQDNJGRxLFwjX6f5Jul/mG8x8bziXibw
	LmXvleiigXUbPR6fxmjU2Fl/vpZsJEvXC3ZdkbQ8TwFbHsDEsFFLaaStJAy6m9sgjczuAoe1MQA
	JKs
X-Google-Smtp-Source: AGHT+IEj+zFArxzwAbL7kgZVdQU9p6xeHPbkVwvqJDg4Rdji4zyxGogh7kJ2FNf9Y+6HN/5YzcKn7y9K9RIuE8qLky8=
X-Received: by 2002:a17:907:dac:b0:adf:7740:9284 with SMTP id
 a640c23a62f3a-ae3fbda7a41mr1491760566b.57.1751966206748; Tue, 08 Jul 2025
 02:16:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618151821.528627-1-christian.couder@gmail.com>
 <20250619133630.727274-1-christian.couder@gmail.com> <xmqqbjqjdbmj.fsf@gitster.g>
In-Reply-To: <xmqqbjqjdbmj.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 8 Jul 2025 11:16:34 +0200
X-Gm-Features: Ac12FXxpQQSiWyqmFYeRP-pUzZLhW8M9v5wdV7Tny4e_UiuBS4mks5Vq7nl2qtA
Message-ID: <CAP8UFD0aXSvepjvwHu_dDcoEn5j6p=HxSEMgftotiZg3B1Hzmw@mail.gmail.com>
Subject: Re: [PATCH v4] fast-(import|export): improve on commit signature
 output format
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>, 
	Jeff King <peff@peff.net>, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 4:55=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > This v4 is just about fixing a few bugs in the tests using the SHA-256
> > object format compared to the v3. (I had issues with CI tests on v3,
> > so I sent it without waiting for the results.)
>
> Thanks.
>
> I am not sure if "I am happy is either 1 or 256" is what you really
> want, though.  The test presumably knows what algorithm is being
> used during its run, so wouldn't you want to say more like "I know I
> used sha256, and I expect seeing sha256, ah, I see sha256 and even
> better I see no sha1, so I am very happy"?

Yeah, I agree it's better to have tests say things like "I know I used
sha256, and I expect to see sha256". So in v5 tests now use:

  test_grep -E "^gpgsig $GIT_DEFAULT_HASH x509" output

as "$GIT_DEFAULT_HASH" should be either "sha1" or "sha256" depending
on the current hash.

I am not sure "and even better I see no sha1" is worth it then though,
so I haven't added that.

> > There are no tests in this v4 and in v3 with both a SHA-1 and a
> > SHA-256 signature on the same commit though, as I am not sure yet how
> > to best generate a commit with such signatures. Suggestions welcome!
>
> Good point to fill potential gaps.  If we had such a commit, then
> would these tests say "I know I want both 1 and 256, and I do see
> one instance each of 1 and 256, so I am happy"?

There is a test with such a commit in the v5 I am about to send and
yeah it checks that there is one instance of 1 and 256.
