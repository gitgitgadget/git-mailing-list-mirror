Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EBC1DFCF
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 14:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718805734; cv=none; b=O8rjoaRi928QcCyQipTLLjIg39vzJnQuHir6UcaOIQqcg9QjB3U57fdTAKr8cyiKmnoXKQlWkrTXaNqwFUtwb7bpxez6rZ8ltXLQ5Gsy+Fj+c1JhSy2yDkuxhgcoOLwz6JBHxthwQ2OlgmH/WmKdMa2mGSK+aXlrXJHiKPAmPPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718805734; c=relaxed/simple;
	bh=tu6UthmSf1luBuIGV/zfv9NXt+jEstTqBb3bw1uxWIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zp4zxmrQ6871LUxrz3ss2XKdj3Q0eCPdFf8EdDBt89a4zzOOQvT9d20bgYWOhOZv76ZzQ9VpWxE9QxNw2nyooZdG5ESyAgk//OwZn3BmwbNO/2aBr98ldMRuoel3e1ngy+wkgLHrMWUcVQgWgQSCWPuwYr/Z3A5LnHhcg/gU6Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TII3sTep; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TII3sTep"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e95a75a90eso71319771fa.2
        for <git@vger.kernel.org>; Wed, 19 Jun 2024 07:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718805730; x=1719410530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tu6UthmSf1luBuIGV/zfv9NXt+jEstTqBb3bw1uxWIU=;
        b=TII3sTepIYfpwrwnIiqLkgGuOwa27AqYMEhIQWPjd1cLlROSFywPDCvlWy6Sc7tcPy
         FVFLwavKIvrC7FU4cHHwgrSutBOTv+szvmouW3KID6KolAF8QVyUweN5VIOoyoBiR3KH
         SrKP2DEd6UYaOsifQ3g0ete5gwE7dvLDHB9ezD/+ehSiup4dZTck1+cLJ7FGQumg1c/J
         fJSvo1pZzEk7F7egdjrOvTk6g7medTiZ3HiURhYZdOYk/ZHdX4Ap+PYUiCHXkgF80IB+
         5ffNU5oct9VnLMEcim9hxybTwv96HyjiJ5dSGwDc+mMjGNOzvaEA+oO4d+ndUordPhC0
         7mmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718805730; x=1719410530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tu6UthmSf1luBuIGV/zfv9NXt+jEstTqBb3bw1uxWIU=;
        b=U9C9qcm7gS3UyEiKdupNTpuxehX3VjQNc+pWGJeMotjYrJj8zjDOz7n66KJqtsiXew
         lQ+QXJmN/cBw2aa4FbXFF8txBIzZnxAOYyvPDpeb/OnuEHGTSdc2p+ptU7Kcp/WpvoFW
         gRscfF+j8hVNnVWJParMFALoq0oD++eX7U+PoitVnJ+0m4vdgMSYDjy3e2VN63kJ9ar1
         yUmItwUDAgbW9zlYIE8Rm9Fg2Al7QOQB60/fRttOTn5bDZ6g7O5ofOdOKERpwcCrDSXC
         1KjEqCA0rGU8PePIaJ6488tkY3Yk6PhVRvOCzE8T8bOcefKv2N0u5Tzia1QLYIom67E7
         9BiQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5p3Vr5SiR2pm2TCogCBDgsdCJiQJ0MjiuYbXWBiMWoYaw2nmS4ozB/40QUdEb7EkhvY2fdcjmgdRzJCMpln9b/wX9
X-Gm-Message-State: AOJu0YysnBsmZMlEZOigVPDj3CjI3YMFiLwPwb29iZ6Yzoy5R2lbSaPw
	L818eLBgPLZFtWK6My04uS2x6+pNndn+ufh2GU7oW8qSx2ieR9Byiuv5HieqyvTZ4BfMch90LBM
	4rfh87DSL/x9WDAb/cmhNW6oO5QI=
X-Google-Smtp-Source: AGHT+IENleHRMkgs6ADeZT7sii5I6P9vEjFPTsMn1lVRf2K6pEPTjto4ecX2ndJYQEmqvnXkwg+RqH26sE5JKIRoV8Q=
X-Received: by 2002:a2e:9e97:0:b0:2ec:4300:3e02 with SMTP id
 38308e7fff4ca-2ec43004090mr2727601fa.14.1718805730004; Wed, 19 Jun 2024
 07:02:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619125708.3719150-1-christian.couder@gmail.com>
 <0448495385b009f25a66b0712afb28f1@manjaro.org> <20240619134533.GA943023@coredump.intra.peff.net>
 <04b714d3e949c30bae0e26231e923fc4@manjaro.org>
In-Reply-To: <04b714d3e949c30bae0e26231e923fc4@manjaro.org>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 19 Jun 2024 16:01:57 +0200
Message-ID: <CAP8UFD2k9YBoKf_=fj1UKNK+=J-2vMenwt8QyTXXSaf=uX6Otg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Advertise OS version
To: Dragan Simic <dsimic@manjaro.org>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Patrick Steinhardt <ps@pks.im>, John Cai <johncai86@gmail.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 3:50=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> w=
rote:

> > I don't mind if this is present but disabled by default, but then I
> > guess it is not really serving much of a purpose, as hardly anybody
> > would enable it. Which makes collecting large-scale statistics by
> > hosting providers pretty much useless (and I don't think it is all that
> > useful for debugging individual cases).
>
> I agree that it should actually be disabled by default, for privacy
> and security reasons, but that would actually defeat its purpose, so
> I'm not really sure should it be merged.

One possibility is to send just the `sysname`, described as 'Operating
system name (e.g., "Linux")', field of the struct utsname filled out
by uname(2) by default.

It should be the same as what `uname -s` prints, so "Linux" for a
Linux machine, and might be acceptable regarding privacy concerns.

And then there might be a knob to deactivate it completely or to make
it more verbose (which might be useful for example in a corporate
context).
