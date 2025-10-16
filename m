Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFD0B665
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 21:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760649379; cv=none; b=vBaCR2m9NVoVFPs4Ch4AzSbDtnbm4FaQgR6rIdW1K/QQeAgh8U2Anm7lBjV1ZmdDgEpiuaEgF2RyZu1jOvYlNQ4dMXHWpOqXcp/aUfpqp6keloetcmIdz2kXyKFW8UNUM60hefzq8gTUlFLGFLLx/qi4zdoFVtG27vrbAn3uE1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760649379; c=relaxed/simple;
	bh=y0B7unR9/MJ16lC7wLFtIqLa/azPiOLlOjDd3il5fLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EmQYVDkbLULubgixdYqKRofmZWSpAu1Lt7r69G6KLjlJpprTHJb5akHrBlV04ftifTLMyJOyjSwGSAD3gSorRG0svjtNgXGID2FEsaVp1QSlM9rwijzu1UCCUKdn8dJuEic6u+jwpbUNSmVUZJ65AAFcTYDd3cxpzuWaLkkNi38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wff11O30; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wff11O30"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b3d50882cc2so217632766b.2
        for <git@vger.kernel.org>; Thu, 16 Oct 2025 14:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760649375; x=1761254175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y0B7unR9/MJ16lC7wLFtIqLa/azPiOLlOjDd3il5fLc=;
        b=Wff11O30ua1446xFteiHQhR7j9ft/3gkQZJcUoI/0RLSuAetEOYltf1N+RLjw+03SJ
         5qK4nhDXyWsgXQX+ZF9I0h92RTY1Ia7SLfKZL9Sav9yM6DAw6kdhF2NUJflFICPFEio9
         +HsCOhDIthhgKyPwdfLar0lK8QTxRKqEkonsGzSQaYZ5blrdqn8ynnSRYsi34Ayf7Zzw
         AR2uGy6LF0ft5uXgVpIYbbd208HPYcjC06/G2rqS3NqeJgf3GxPDgHhPJiklVq3OuwG1
         1k1yELtlVRWxYZLpOMSS3ELc9XZII9Cxr1yPObnDBxS+bmRdLc39BHTkKe3E7b06wbn/
         yzgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760649375; x=1761254175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y0B7unR9/MJ16lC7wLFtIqLa/azPiOLlOjDd3il5fLc=;
        b=mp3rqtSAFyd7LlLys93UwfvcykPBsBFeQGuAgs/3OChySh1duU6ElwnXeAjPljDn10
         rsTEDW86jdHQI95ntgrcqw5nkvBeSmEvI/nQrvGFDcv2YxPwJptZi1/tVMZwmemSU/IO
         4RmAWCsVq3nmLt/pa+zSof92WM+OT5WSxuVWjw+utvTKDWeynMK83SfysayDrrBZ+s/T
         LRIk15k9TS9M1sHDG5xngOLIJq9bFO3fTnykcRk3oTCkq7y+wVXVYjBtcu5jad4TGpx6
         ysU4WWLaS8OU3wcYS0IGrlOHl8joDrjft+Xuird4Wnj+N8RQ13XrXh0UHQlCTtl6Fil9
         TdcA==
X-Gm-Message-State: AOJu0YxDMIzPCD7ZdpEuqpczBpNAYLNbBpXY4KPYfPpqv4KNmDMsJeEe
	yIr2pyrI5g6H2KO1/Ob+2YzYwOZwo1foJXoNiVQfks1E9p6fmGf26/kIfpa62iXLjMV3gDpbrcz
	2YfWRnwrqX4W8MVgouscSzp9sJH41SLM=
X-Gm-Gg: ASbGncukV7Af7pKvidGoDX0crfXr7Jv2xDKFod4KdpuErEwxsSUUq2LrfsUBML85hak
	4sh/VrOaRJNyUX20eZNr0+bNdb8Al5vMJu421R5b5g8bVLVzSy6azCZfnQkSOt55e/oKtEgw/tL
	Lao43BtwPKhZio7L9Zg9CasyJg7jWFezkQ7Ng6vgRPxeixLQzDBivsHfv0AckkaYh0QDGjKrBOP
	9QNWWxSbpJMSBFiKiiKgqLclglUZD/38cE5TAQ+b2yMyYssaRuAbcwxxP3hqTztNLClG2l1evhF
	ZBXR3h1PPRIGPeFKsWFT2FF+rOQi5A==
X-Google-Smtp-Source: AGHT+IHqWxeNdi7pbbi1lNv/yBeKzLns+JLloZKOQ4JdI3rUkK9XNeVntatlaUO4C+8dhCUrSYXV7YpMh93N9x13c6o=
X-Received: by 2002:a17:906:fe45:b0:b60:d888:32d9 with SMTP id
 a640c23a62f3a-b6471d45a8cmr154690766b.11.1760649375363; Thu, 16 Oct 2025
 14:16:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALnO6CDNRw3UcU9UM7rpkAoQsSmfdkxMKVihmoUmUOCv_fpbJw@mail.gmail.com>
 <871pn2ftx6.fsf@gmail.com>
In-Reply-To: <871pn2ftx6.fsf@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 16 Oct 2025 17:16:04 -0400
X-Gm-Features: AS18NWAFtKAtZRMHnVAsI9xyCn7gx-V8aCoqMy8mkZBHgpxvVdM_6VykTw0rRB8
Message-ID: <CALnO6CC4hBBMyqEfLEn7EO28LVo7i4eDqAMLcFzSJZudVnB0oQ@mail.gmail.com>
Subject: Re: Signed-off-by & the law
To: Collin Funk <collin.funk1@gmail.com>
Cc: Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 4:55=E2=80=AFPM Collin Funk <collin.funk1@gmail.com=
> wrote:
>
> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
>
> > Any contributors/users with an interest in law feel like taking a stab
> > at answering "Is Git's signed-off-by legally useful" ?
> > https://law.stackexchange.com/q/111158/26698
> >
> > Having a solid reference answer is usually a good thing, if one exists.
>
> Not sure if it has ever been a topic in court, but it would allow you to
> argue that committers signed off to the DCO acknowledging that they have
> the ability to contribute the work under an open source license [1]. In
> other words, the they have confirmed the work is not owned by their
> employers, as is often the case with Software Developers in the US [2].

As Junio points out, this is dependent on the project attaching a DCO
meaning to the sign-off.

> What I worry about is whether people actually read it and fully consider
> whether they own the copyright to their work. My assumption is that a
> non-small percentage of people just add a "Signed-off-by" tag as a
> prerequisite to getting their patch approved.

I think this concern showed up in the question, too.

>
> That is why I prefer copyright assignments. I have done many various GNU
> projects that I commit to. I feel, at least in GNU's case, that they
> force you to consider whether an employer may own your work [3]. If so,
> the FSF will request your employer sign your copyright assignment.
>
> Obviously, the assignment process is time consuming and a barrier to
> entry for new contributors. For that reason some GNU projects, such as
> glibc and binutils, allow you to send patches with "Signed-off-by" to
> the DCO if you do not have a copyright assignment nowadays [4].

Less germane to the original question: I'm less familiar with
copyright assignment, but it seems relatively heavyweight here. It
seems ironic to me that GNU would want me to give up my own rights
when contributing to their project ;)

> Obligitory statement that I am not a lawyer here.
>
> Collin
>
> [1] https://developercertificate.org/
> [2] https://en.wikipedia.org/wiki/Work_for_hire#
> [3] https://github.com/coreutils/gnulib/blob/master/doc/Copyright/request=
-assign.future
> [4] https://sourceware.org/glibc/wiki/Contribution%20checklist#Developer_=
Certificate_of_Origin

[kept for context]

--=20
D. Ben Knoble
