Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756E461FED
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 16:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728231977; cv=none; b=KsJHrr2l8iJDwA1NJby7UbspTCJF79zU27KFYxA6SjQ0LyWoIoyWaydmPhA40FQndvOLlp4lzdfFkFa6FdyFmleS4QGwd1jFpHoRXMM0Cx3IjG7hjLcZyoV3zrEtcDOkLxAdbqhiDoKQcaCDtzFP3HDAELPwbqa26/SUob/d7FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728231977; c=relaxed/simple;
	bh=s3m1ftd4yCJzIzIKPr9gSRI6twL/qoD2nUf6tgjADb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qhtcSKIpf0j41b8SeB8dO8yS5oieIjoivFja6Q+Q8Ary688XKY/nLqbjQW3HOj04PUxD41NUjpPlAmflYEz1tBfIVP05lOGAwea8PxC6yKVMBm3MV1EgD7eb9zSqvgfhe6mehk+Pz5DoMiN3UMkyHWXHrxw+MmWUXUcoDMAeb6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VF4aIUny; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VF4aIUny"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-84ead864cd4so876234241.1
        for <git@vger.kernel.org>; Sun, 06 Oct 2024 09:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728231975; x=1728836775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hasvWKCxgZHFBTawc4lnXEIVolKAU2hh7QwDISB/3Kc=;
        b=VF4aIUnyK0sq90vF8zObd6Obogg9DMOuDnQFJLQK/HP/EhO105eYbvfhanVCdV5V6z
         NWAnAcRjqk0iANSLeSvgER28vKPAeTsdZeg9duL/07QO/BTum/RJ4fBYaTP4crEBnuG1
         C+PyY4g59knhEg9huVOXy+qFuQZPaN9nHzLXm9KdGRHu6Q6+vfBY4RfBnD4/Y/68ecyu
         dTjrDzd/nFNBuOmmeFTmfCeKi7EMV6LwXFV8TjqtFX4+41MPK14QIgnjnSwdtjs6Gkhx
         41BS0MbvtR4GHjCJlEV5DAe7IvzJIUcEhW2tCsOva/RXPRoXmGOAh8Ej40oIS8IvP3zo
         PfxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728231975; x=1728836775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hasvWKCxgZHFBTawc4lnXEIVolKAU2hh7QwDISB/3Kc=;
        b=YG4m7D9nVU9QlSSDX6mynd1YG9DC5swYkpIgjovzTKg8RU5oJ/8W+ksi1ScaB5lFTs
         IWahg+SvA2mq1nbWFprQFmoHumdClOSwllmjKIVxc7M2n0bqUFg4BQgiHCV02dwTsOI2
         hPDt/TzLEBNYVtd1IEclDnVQQE54wr0irMXLiYlNY6t8xsfVrIw/Ycda1UuGXlZ3H64K
         oCQv8t5toIJvoy7LY0cAzWq2j+vI8y5yp54+t0WEPNKQ4N9mk+7pYxfzpMEsP6oNAit1
         UzONzOVE0IfA1p8MRqfQ8uUKmLbONBmxKKYEQ7Z9DegGZrQRn+cGRqtPguk+Zz+8UQJt
         LN+w==
X-Forwarded-Encrypted: i=1; AJvYcCUUjH5PsrG1OaKtmsTRr1mW7wlLLy8wy1etJ5cBnn8GfpF72GxAnxWPepaTDPSayNzx6So=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAuy6rSW885O1Z39bwIAvcLzLjie0UR0vcgw7Xb6M78CAcCnrt
	jbNRdfeJhr7P5fKCHb+pYJdS8175WzP1HSjogCWKWyDPUzpQ3IbzteDx0hxjdSYx/YKKhXC91qj
	pX0HzL2q0mvypmwHTaXP3laZ21/0=
X-Google-Smtp-Source: AGHT+IExPeCNifLAQTmm7fv4BZ6fQNDGvRHS1s8fCQN0nQn/25kLwEuQz4PB7VI+y3irNtWXPp6nAOtxMA7aJSriyX0=
X-Received: by 2002:a05:6102:2ac6:b0:49a:1dd2:3cc8 with SMTP id
 ada2fe7eead31-4a405925bcamr5761569137.24.1728231975292; Sun, 06 Oct 2024
 09:26:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1805.v2.git.git.1728203495287.gitgitgadget@gmail.com>
 <pull.1805.v3.git.git.1728230769.gitgitgadget@gmail.com> <92496582-8414-4d5b-8883-8b0a0b3c0988@app.fastmail.com>
In-Reply-To: <92496582-8414-4d5b-8883-8b0a0b3c0988@app.fastmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Sun, 6 Oct 2024 16:26:03 +0000
Message-ID: <CAPSxiM-jKgsuqkF_aHDJxiTz0FWwuT==FYxJPKUP0O_wwDahEg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] [Outreachy][Patch v2] t3404: avoid losing exit
 status to pipes
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Josh Soref <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Christian Couder <christian.couder@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>, Eric Sunshine <sunshine@sunshineco.com>, 
	shejialuo <shejialuo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for this. I will definitely take note of this next time. Thank you.

On Sun, Oct 6, 2024 at 4:21=E2=80=AFPM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
> On Sun, Oct 6, 2024, at 18:06, Usman Akinyemi via GitGitGadget wrote:
> >
> > The root cause of the whitespace issue was quoting $count in the test
> > command, which led to the inclusion of whitespace in the comparison. By
> > removing the quotes around $count, the comparison works as expected wit=
hout
> > the need for tr -d.
> >
> > Signed-off-by: Usman Akinyemi
> >
> > Usman Akinyemi (2):
> >   t3404: avoid losing exit status with focus on `git show` and `git
> >     cat-files`
> >   [Outreachy][Patch v1] t3404: employing test_line_count() to replace
> >     test
>
> You don=E2=80=99t have to sign off on your cover letter.  Just the patche=
s. :)
>
> Of course do what you prefer.
