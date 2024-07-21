Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06F04414
	for <git@vger.kernel.org>; Sun, 21 Jul 2024 13:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721569724; cv=none; b=J0X1G40et/88qXpvsoxqyYYBysoYa7MdinYOX1x9EeVDlso9L3wHcp+9NfS/FIGT7iArt/18Rlgl5682u/33Q7Vx1czLJ0rcaVGXUhaY8SIjYSToewuD+gyyqRX/vE8ET5FTVQmKEa/rYSCD0z9ppj9VURrl2Q8FC2WABShilEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721569724; c=relaxed/simple;
	bh=9Oi9eHq2qZAqoe1NgASJauoDEGqBG3Ljc3yIghsInUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RV3LxiVoEtdwlTMDDSIwx17/Y5eFesEwetwFUS35Ifqr+mDjCtsd5Doq2J6rjmDHguvlgwruUyKyFToEt5VvOt9pqtqQ5sjSSFOKTzWaWeYP8i5h//ewgyU54+ORxbnXS+jNebX4MwJf+e4bHV4TMAALngeDUWxZ2XoatxKEm88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dinwoodie.org; spf=pass smtp.mailfrom=dinwoodie.org; dkim=pass (2048-bit key) header.d=dinwoodie.org header.i=@dinwoodie.org header.b=F04h2Aw8; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dinwoodie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dinwoodie.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dinwoodie.org header.i=@dinwoodie.org header.b="F04h2Aw8"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-59adf476c9dso382095a12.1
        for <git@vger.kernel.org>; Sun, 21 Jul 2024 06:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google; t=1721569719; x=1722174519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Oi9eHq2qZAqoe1NgASJauoDEGqBG3Ljc3yIghsInUg=;
        b=F04h2Aw8tmMrLOXcwWt2xoIhAQwBgyHUc8vgKC3vGbI1vkP8qqEpQ52E495ynnE14X
         lD3wV2w+Q2ws6Rv1cui9q35/ktZJ1KOZuHYiFmTCVEDzD6F7EB5LYUxhut8lObsO7MPV
         JpBDOf8i35Fpi8q5fkwbJ/iMlbCc/d4DwqRBLfUlGOPu2sGK5RCBAD9ozVFoGceDXhZr
         VakSxzhkSLmfo1eJ59jKqRrmsv4AU6lDIrApViKWRuVItmldyZvT7c1v+NFAxbB1y+tf
         sjmMQ9Cy3nkN5Me38MLizKxcTy3V0YS+bSnHlGNgtLNxFNKnB1meCWlEBoiod5PSYHkV
         5H6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721569719; x=1722174519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Oi9eHq2qZAqoe1NgASJauoDEGqBG3Ljc3yIghsInUg=;
        b=YkXLCKyzbKnci1S4SxBnO07HMP4+DVBEwR+gCahGVXV81+mHH5UCmXeTSJzdAqZ0xe
         0cJn/PbX+ko++3vBHxzkyaQTrkWybaRBNIEGHlaCwXhxv21lHf9zE8gFojapqiy8K0Mu
         qG+uDwI2FmeT8gJ3n8Kp3+34jwfzlOtD7SI664hS8gmMIDFyWmM+CVRr9eXE3g1bcYKF
         RYojwZke6qllmh5yPZF4ICq1LweOdeM35HllJj+wZ4lB2CJybijMlZ9bmOkicBHboNhc
         mAEofJqz6X+IcC0+k1WQw78Tc/RrjA8Kzwz1QwrhGH+AYH7UDpiVnNq2ObzEiGtTWJ9x
         30OA==
X-Forwarded-Encrypted: i=1; AJvYcCUhCQumm2Pdd9SlmLEesqS6IFiYZA1USNvxHemlDivtfiHgWawuDwhqLoDMH9MvjCMULodo+QlYmigqFGLvBITb3zrI
X-Gm-Message-State: AOJu0YweTWKcK+KQ/8NF71JmvncoVnddQw/QyxOaB4iLFydBlznB1ySE
	jX7tkq9+/xNJfPPRmmQtBxOLcEBtsrWnp2qtqFPHnguN+WQPlcAhXQYEhs35DPBTRxzXXrOVv0l
	YRJvlamu7cqH5kyaMkiCwrVEKsEfWsGt3x68E
X-Google-Smtp-Source: AGHT+IFZPQP/45ZdL+RSk0Hr2Z8XXB2V/qGgJ5WAIHQwBTuxF48TU+MfVVXzcxHYqiYQCN8kp2Ixw8D9UvJgb3ViTfE=
X-Received: by 2002:a05:6402:27c9:b0:5a1:6ed5:19aa with SMTP id
 4fb4d7f45d1cf-5a3ee7b2ef7mr2136242a12.1.1721569718879; Sun, 21 Jul 2024
 06:48:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aacb4067-a16b-4953-a72f-3c66efd3cf25@ramsayjones.plus.com>
 <20240717064241.GF547635@coredump.intra.peff.net> <3e6abe6c-2c15-47f9-89e8-3e8710802562@ramsayjones.plus.com>
 <20240718005723.GA675057@coredump.intra.peff.net> <f97198e1-bfcc-4f3c-ad0a-2dd27d4f20cf@ramsayjones.plus.com>
In-Reply-To: <f97198e1-bfcc-4f3c-ad0a-2dd27d4f20cf@ramsayjones.plus.com>
From: Adam Dinwoodie <adam@dinwoodie.org>
Date: Sun, 21 Jul 2024 14:48:03 +0100
Message-ID: <CA+kUOakUYURJN0O+jRHVKdN9O0MY01Ck_PYa3ewipqUrpKFaCA@mail.gmail.com>
Subject: Re: v2.46.0-rc0 test failures on cygwin
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Jeff King <peff@peff.net>, GIT Mailing-list <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Jul 2024 at 02:22, Ramsay Jones wrote:
> On 18/07/2024 01:57, Jeff King wrote:
> > On Wed, Jul 17, 2024 at 07:05:43PM +0100, Ramsay Jones wrote:
> [snip]
>
> >> I also don't know the code well enough to answer your question regardi=
ng
> >> the re-opening of the migrated ref-store, but it doesn't look like it =
would
> >> cause any problems (famous last words).
> >
> > Thanks for testing. This is new in the upcoming release, but I think
> > it's localized to the "git ref migrate" command. So aside from the
> > annoyance of the test failure for you, it is not too urgent. I'm tempte=
d
> > to put it off until Patrick has had a chance to weigh in, even if it
> > means missing the v2.46 cutoff.
>
> Yes, I think it would be better for Patrick to take a look. I added Adam =
to
> the CC list to keep him in the loop (because he is the cygwin git package
> maintainer); he may have a view on the timing issues.
>
> Personally, I would be fine with a post v2.46 fix, but it is not up to me=
. :)

Absolutely fine with a post-v2.46 fix for Cygwin's official packaging.
Real Life=E2=84=A2 has meant I'm not on top of the latest releases anyway, =
so
needing to wait a bit longer before taking v2.46 won't realistically
make much difference anyway.

Adam
