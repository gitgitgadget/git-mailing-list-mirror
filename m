Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3501B813
	for <git@vger.kernel.org>; Sat,  8 Jun 2024 10:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717843429; cv=none; b=j7WZlb+ICY49r12VaK2NTC0OoBKNJVlemRlVVD1OcPTX6oXWd/2yrYa7kf94YQK8/WTHZUaQyeDxK4EBwy+swNuM2a0DMMPpMDSyIwuCmn9rkQczKIVkxoU285uVg0SqbF+qlPLw/uykg8P2/np3UOwpUyaMgCXAbGN+d0lksso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717843429; c=relaxed/simple;
	bh=FdjMecK8AmFnnT5zxNXC6JsyoK8tgdnc8g8GB/onb/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SKFMAxbUaNihq0vG2UQhluwCCvr1T3Ou+IxJ6DI4N9GQGcQVA6EYMdL6Onfi6nGXnatgJpamM8uMGn/nvWzQMlsPyLfkR3pEUGkEiUlAlFd8ukqgLW80itq092LMuM33xt7tMI9T04Z4tGSzGK2SaSlsgg4AjiW32UzOCEbQpTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lcWVBSie; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcWVBSie"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a6265d48ec3so350361366b.0
        for <git@vger.kernel.org>; Sat, 08 Jun 2024 03:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717843426; x=1718448226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdjMecK8AmFnnT5zxNXC6JsyoK8tgdnc8g8GB/onb/E=;
        b=lcWVBSieFuTsv52QPKWwb4wTcPtJr4Q7+pWkkD4lrhrVNSh82+Y9WurKcpPhNw4tl1
         PTNglGlhTIsKtTffd1g5to7Sde8/D+T6GPz130444V7jUAtBQ0hU9Rso3dABa0202OoD
         vjYMHcswj2/EBKtUnpcW3iFrCYNmTGDtBgMh6/5nmY8J3/YnxzHifcBOrEl25Zbih0M/
         IHgtVhaHc0QlrxX7xGggYNExYYWf+WgQzmPufv+NRMHlCZNVvQI3OlLFsMNyi3FWZNNq
         gkzTMUmRH5VGLrAIQxz5R4TPReR4S1abMr2lz5IYVSAANsIJ5H97qb4Nd7sw/kyrJIPD
         frIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717843426; x=1718448226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FdjMecK8AmFnnT5zxNXC6JsyoK8tgdnc8g8GB/onb/E=;
        b=RlyUX/JT1SQc+p2cYSj35ofUMvvMaUCf82ZP8QhuU3bXiTYIc5fK6R+sr8kMbwrtpp
         v1ny8jF8MTEJg+9rX+5UrEPpD51zrQX3m9VvFaV8sMQACrTLO4Vcl+5sPY7ukyHQ0xUV
         6aPM/6lKfewtfOZwHODCfq4eZYQnI7OnQdzfmvAdvymMuIUkF8qoMLLjIBjuLI/ZZtA8
         kzAp4KHPs5eL0wTRxsUWobL65eAGil3SSXUwZDNGpx4gRZjGp0cjygEVHzJX1/C24IXL
         Wjwwp9ScZJqlGIQn/VajRcu14qLbY1iTBFz9lQxMGEOdO5LjV58DPTbyWfAIHbHi50KW
         /rKw==
X-Gm-Message-State: AOJu0YyYvBVqIqnTOuyFKTiObky7dH0MhWk2jUg++KdzjmBC3h+jRHTL
	PRix/1HoDJ3fztDhUJt9TCFD96S9uXpw2hHwrF0blCCzVrfbsv6Be5PBOZlsmdpar5AhYTpT519
	D6leP0NHr6izLUKX4yeM9kuh2AVkiz1jb
X-Google-Smtp-Source: AGHT+IFwMEcdWJFbX6yTYynGIxRuGIxLzO1iBGwsCIigFTcRGv0G8OyfcoyFzmKv6vryDo9wSJwqrxAClHu8j+KPaXA=
X-Received: by 2002:a17:906:d7a2:b0:a6e:fe01:18cf with SMTP id
 a640c23a62f3a-a6efe011a09mr94751266b.25.1717843426263; Sat, 08 Jun 2024
 03:43:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607120530.74297526@yuvnserver>
In-Reply-To: <20240607120530.74297526@yuvnserver>
From: Christian Couder <christian.couder@gmail.com>
Date: Sat, 8 Jun 2024 12:43:33 +0200
Message-ID: <CAP8UFD3JM_h1BvK59R4wT1DeZyo6o-9T3GXGK8xE6vLnDMDCaQ@mail.gmail.com>
Subject: Re: Autosplit option for git add -p
To: Konstantin Tokarev <annulen@yandex.ru>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 7, 2024 at 11:06=E2=80=AFAM Konstantin Tokarev <annulen@yandex.=
ru> wrote:
>
> Hello all,
>
> Is there any option in git to make `git add -p` split hunks by
> default, just like 's' was pressed automatically? If no, how would one
> implement such an option?

It doesn't look like there is any option to do that. About
implementing it, it depends if it would be a command line option or a
config option.

Anyway I think you might want to take a look at the run_add_p()
function in "add-patch.c".

> My use case: I've recently started working with big LaTeX document
> having every paragraph as a single line. As a result, hunks quickly
> become larger than screen, so that splitting is highly desirable.

Best!
