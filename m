Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DD61EB5C9
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 06:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745476102; cv=none; b=SuiH7l5hstNxz7Xv9giyBIuIeQWia1WkTfO8u7Kr56Fu5VBmr/NbDzem0fc/Feg5tYSPyck7MDso/ySKr/gZoZXq3OE42pzvB39u5smhq2KYSUqcx7pO22qc8ucI9RF9Fc0Kzzl9nxurwbc1WgFE5lKkI7WQvn7yobKI2RoWcvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745476102; c=relaxed/simple;
	bh=PwH2gO6J84rEpBGQn8tyx36tdKKy8/wz34pJL1xH1FA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YUlxUdToSK4/UawkErndTKRWxLFnVKsuaOWDbSBz97Alp+KU0YG6+8b0zA13O/KTwUMwy1ZRPL7l0taHE+j00dp0dadTqv7jWzskNc/Ukw2wBMFyrkVL1I7W9Hpa63BvP4I+KxyWAOjWUaceO0zHUDz2RWohagw7gIC6FfO5MZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBnQug25; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBnQug25"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e61da95244so1035190a12.2
        for <git@vger.kernel.org>; Wed, 23 Apr 2025 23:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745476097; x=1746080897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WyBfoh+fK2jmesLjoZf4vY4QDbPO4ZNKSEP/nIWgvIU=;
        b=QBnQug25zxirgNFMMU5wtGWYtt19sWzFEVs7VFJEveqpO8yg89uNVXguo9sDoUo5Eq
         ZO/nPAWOVbEWtX1TtBsRPoaej50M+liqMT48IUus71nbBUoaDJTG95sOMwG0KQD3LxNQ
         k84wsqwoo7Dd9odLQJ/e+yAyDJNCp3x+XOWypJU5W4jqGCvR+KKEMU75yJrCaJXz7lZI
         DrKmNkNiJRADv4j+1sYsQyECCP8PlBKnszWLyjBLsLXOor5mrnMA4nd7zmEPlDrvUp+P
         cIVjO9xrIRuGuh8rs4E9/8HuxqX5MjhHpoWrGDuXqz4S8/wFwfhPUP3yghDCPFLsgZ1C
         CLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745476097; x=1746080897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WyBfoh+fK2jmesLjoZf4vY4QDbPO4ZNKSEP/nIWgvIU=;
        b=s8JOFoonAmSPgCNZOJiILhneoJ2Qq4HTam3WZ5HTxAQHBlPMgpT5YwKbajTw8xrnFB
         VsTM+5VmCyRZO/DGvBHEtg0kO5E+ySFkO2m/gdfhdbznYE3HeAn6L8GKHguuks66nVUe
         OvSUBbMW0s4YLXb1L/bYwMs1UE9OMtUwLzqN+HOsoMT4vTNL+hkXLAFhK7zhOpsSt1Oz
         rHQhwe+CTrvil28GrNzFOq++bQHF/eWNmd6lPWNY3Fu6/tKSA0M9ibd+ua4vW0PD9Gon
         goLsEpXdbOrzOy0off4nm0R/ZNdX/qYukJRe8d9cv6v9z6TgHNoti42b6gKgZz4qRNsN
         qjPQ==
X-Gm-Message-State: AOJu0Yz18muoj1deAURqeuyI7UccO+o+30rj5F3wJpoYZsyWFi5NxMwV
	z4Lu5W9fl0+zK7ztS+m4kFJpRdKMOFAZ/VH6QrjN5jvuBPo/K+OC7sXPvkbI9CZkGhMXts1WMYa
	IxVbLXmblYPXBRzyfu5il3sUbcwH0tWEy
X-Gm-Gg: ASbGncuKMuE11k8n2zi86gKLmjSh3sveYw4vpv7kxSvksLMxuvkWpaUiUciwxDfR6t/
	7S3Zf/df9TO2BXnOxE4uibrJwn2JF2Z5+ddKaFjp3aczUXcItHQTnjqYRxYNZ005SlfXOHoEoi7
	wTdVOeLoY9UsC6ISLmlwiNIUz0T3ay0Kt6q02KwBerHXiOTD0kZfeM8Ouj
X-Google-Smtp-Source: AGHT+IHZaORtoMdxQKykASNVmRS9M2/l84Fs+lYFaa/h0d7vXELMF4cf/PSp7gGkRhSL6DfXMAclJaL5nRef/HZGrbw=
X-Received: by 2002:a05:6402:268c:b0:5e5:3643:c8b5 with SMTP id
 4fb4d7f45d1cf-5f6df53e3e1mr1532526a12.30.1745476097101; Wed, 23 Apr 2025
 23:28:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331-pks-meson-benchmarks-v1-0-b2ace85616a3@pks.im>
 <20250422-pks-meson-benchmarks-v3-0-7aad68bac6fd@pks.im> <CAP8UFD3Nr_f7WSzjv4AEKzH9Kpsf6soOd+VSO9ng=-ZSws6P3g@mail.gmail.com>
 <aAdK9gnXOO3ERq7w@pks.im> <CAP8UFD1zqAk1_Y0ECu4=iyeF4k4LagfLgHWkEr8iz8ZnwkVT8A@mail.gmail.com>
 <aAm-pcIfrFt6mjlV@pks.im>
In-Reply-To: <aAm-pcIfrFt6mjlV@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 24 Apr 2025 08:28:04 +0200
X-Gm-Features: ATxdqUGZEMei9ph-aXkj4v1u8WF1BohkFcJ2BGF94Nmadg3n8j9FzbuL-BgSyhI
Message-ID: <CAP8UFD26q4zDTN=NrCtYNFPh+H=f4yU-1+3HxEE-DZD+qO0_Mw@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] meson: wire up support for benchmarks
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 6:31=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Wed, Apr 23, 2025 at 04:44:20PM +0200, Christian Couder wrote:
> > On Tue, Apr 22, 2025 at 9:53=E2=80=AFAM Patrick Steinhardt <ps@pks.im> =
wrote:
> > >
> > > On Tue, Apr 22, 2025 at 09:27:57AM +0200, Christian Couder wrote:

> > if time.found()
> >   ...
> > else
> >   error('Benchmarking requires the `time` command')
> > endif
> >
> > in the same way as in meson.build elsewhere we have things like:
> >
> > if not msgfmt.found() and gettext_option.enabled()
> >   error('Internationalization via libintl requires msgfmt')
> > endif
>
> But erroring out by default doesn't really feel nice to the general
> developer. I'd claim that 99% of the time, developers will only end up
> running the test suite, never the benchmarks. So the default should
> match that and not require GNU time to be available, if you ask me.

Yeah, right.

> An alternative could be to have a 'benchmarks' feature option wired up.
> This feature would be set to 'auto', and then we can detect time like
> this:
>
>     time =3D find_program('time', dirs: program_path, required: get_optio=
n('benchmarks'))
>
> This will then auto-enable or -disable the feature depending on the
> availability of GNU time. But if the user passes `-Dbenchmarks=3Denabled`=
,
> we would fail the setup in case the program wasn't found.

Yeah, that would be great.

An alternative might be a placeholder benchmark that just reports an
error when run, like:

if time.found()
   ...
else
  benchmark('perf-benchmarks-require-time', shell, args: [
    '-c',
    'echo "ERROR: Benchmarks require the \"time\" command to be
available. Please install it and reconfigure." >&2; exit 1'
  ], env: test_environment, )
endif
