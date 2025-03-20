Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD1716D32A
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 16:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742487085; cv=none; b=UhkCBPL30l/tugOYZlH5dY/5xtj/k7ddFQ/+8sPQBQQRXqS70sL3z6R22jz8XLuSXcLI9eFe47cs/sLAAFfOAyE85hS9crR48O+vGEe0hJHKV6OsV184+S7Ns8a80vn+xKQiIHWdfZaQ/gUYzn4wo6nAQK8+xp4mvNmxgd0W25I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742487085; c=relaxed/simple;
	bh=jmpcbg3v6D1V22NtKKCySpYFKz8lS/jo3CiST+Ot58o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eK4sJgPvfAaYcDZad3KzVUOmPV4zCIWq3q59t2/0KDwan4B/UGBcV8+OUF6Gc0VcODkNpYM9babghRQDZ5LgxOa+TdFHiGvwrMGR6bnHUrspac68KXZwVt2A7FJWQHgLyugkZf0Bm8aGfnh6eq0X7az3jiCABjQhy/NX7b196NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZ1mLcgT; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZ1mLcgT"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3913d129c1aso750310f8f.0
        for <git@vger.kernel.org>; Thu, 20 Mar 2025 09:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742487081; x=1743091881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Kaz5aF6kg61kBGgXJ0g3FvA/RzKzwneVe3EAW8aeJ0=;
        b=WZ1mLcgT5OwV1UzWU5nnUO3UNNR0mZPWTT8cheSGunNBvOF3LAPqEzzAEbsBI2JvwA
         BOd8+yUzk/s8WWnb/H4E6pzd5oZOfsGVOIoJIPJgbp2tHkPYcIwjgNtkFno8j1lvlnF1
         d8Kb3AjZhyCHzwaeXYMPSr8pyMhVyNA/U08kZgKFnnKqPjcIM92/zbaZHUV0tP8541kH
         FCw9S3bjHqg/QdPo2ZkmYnB6y3T+HBrIfPRYMmLNOew+m0PQmmmLywXrVQ8sQjl9DZ/v
         FvWBmWTklwEQ9wH09+PTP0MAY0hcALh/cXlsqOhuAoRAP14RH0VC0C9IdMuO9kqUG0cb
         7EcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742487081; x=1743091881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Kaz5aF6kg61kBGgXJ0g3FvA/RzKzwneVe3EAW8aeJ0=;
        b=CxsfgMrz73XI2t9J8tWWNZKzzNwc2xIo3R20NunliY71g90gDd+hBZNTgSDF15E7iX
         MyvNK5/mGmQvZLLHYHs7zsoLzNWvk7snYU6EciIwSPaebX/49g8ZX/aX8Qs8sQCp3axH
         n79W3QhOv7XSbGrrID1lukG/ztmrbvCHx3Ym+vgJ24co3Bnpc+9pCT0st7G6Q9nAolUc
         /1hrYZwxktaC87X6eUMQEx3IFQj/6nNhlLEjobmj1+pQVVnS2XNZCTPiGKY2KEuIDcwx
         nJEAlS9mx8cIwK37zEO7zRrFc9dU+2yI5mtgRI/PuftkmZOnKSv8MlN7Up/5r+90YBdv
         R7jQ==
X-Gm-Message-State: AOJu0YyP08mJ368vHvdk6Mlr5u8B4q6EPppyZh5jM/HZgIx6gCO2FKqy
	d2LgD+chclqGptR2m+kSVjWIjbXSyI5oggAwKxZ4V0uzqLmWviv3ud1q8nCsdN6r+uvP6aFwGsh
	QRNXxtkehbPC+owgIfGy7+3rIFUw=
X-Gm-Gg: ASbGncsJhqNS0y3RzoYKweZF0VwVFn3BaUsLiWP99Wu+TC82gvt3mfTWkxEW8fULE+B
	TLMph62dR8FqY7IeqPaekc+XcqPLhcbAO3GVgg0RJUW8klivIaN+yWUmMMUNkEX1ZAHPD7elg01
	7Gr5fzFjLZuUBSTM8W0VkPmr4KEWkqsU2iyNQfclk=
X-Google-Smtp-Source: AGHT+IEfjYX1awXslumvH7bzYn81M/obs9OKkNPqbSpIVpK8YGuN/I7gEjNtmcRkoWn5FgGGayXEOhyn+4qzuoTqwG4=
X-Received: by 2002:a5d:64ae:0:b0:391:952:c74a with SMTP id
 ffacd0b85a97d-3997955cb5bmr3539967f8f.8.1742487081335; Thu, 20 Mar 2025
 09:11:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1742367347.git.martin.agren@gmail.com> <7d6b62006ecaf7db159e8db0c85455ed58027ce6.1742367347.git.martin.agren@gmail.com>
 <Z9vdS4bxY6spILsc@pks.im>
In-Reply-To: <Z9vdS4bxY6spILsc@pks.im>
From: =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date: Thu, 20 Mar 2025 17:11:09 +0100
X-Gm-Features: AQ5f1JqLNPCRHTQsN5prTccvuEli-w9oog3kB2bEK69FFtWB3YafLxQa6Kp8FME
Message-ID: <CAN0heSpN-k886+RsZ0+djLd974Mq57B4quZK1yKXRMxCnOvzZw@mail.gmail.com>
Subject: Re: [PATCH 4/8] pretty: fix parsing of half-valid "%<" and "%>" placeholders
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 20 Mar 2025 at 10:18, Patrick Steinhardt <ps@pks.im> wrote:
>
> On Wed, Mar 19, 2025 at 08:23:37AM +0100, Martin =C3=85gren wrote:
> > When parsing a "%<" or "%>", only store the parsed data after parsing
> > successfully. The added test would have failed before this commit. It
> > also shows how the existing behavior is hardly something someone can
> > rely on since the non-consumed modifier ("%<(10,bad)") shows up verbati=
m
> > in the pretty output.
>
> Ideally I'd expect us to die when seeing misformatted placeholders like
> this. This is way less confusing to the user as otherwise things _look_
> like they work, but we silently do the wrong thing.

Right. I can see how it makes some kind of sense to print what we don't
understand when it's something short and simple like "%X". But for more
complex "%X(first,second)" it's kind of obvious that a misspelled
"X(fist,second)" isn't something you want in the output. The whole "if
we can't parse, return zero as the number of consumed characters so that
we can print verbatim while looking for next '%'" is a central piece of
the design here. One could certainly imagine a "strict" mode.

> That being said, I have no idea whether we can do such a change now
> without breaking existing usecases. As you rightfully argue the result
> already is wrong, but with my proposal we'd completely refuse to do
> anything. Which I'd argue is a good thing in the end.

I can see the value of a strict mode, with command line options and
config switches and whatnot, maybe even a changed default behavior at
some point. I'd rather punt on that for now. TBH, I'd be afraid to do a
hard switch from "0 means print it instead" to "0 means die". I don't
disagree that it would be a better end-game though, at some point.

> > We could let the caller use a temporary struct and only copy the data o=
n
> > success. Let's instead make our parsing function easy to use correctly
> > by letting it only touch the output struct in the success case.
>
> s/success/&ful/

Thanks.

> > +     struct padding_args ans =3D {
> > +             .flush_type =3D no_flush,
> > +             .truncate =3D trunc_none,
> > +             .padding =3D 0,
> > +     };
> >
> >       switch (*ch++) {
> >       case '<':
>
> I honestly have no idea what `ans` stands for. You could call it
> `result` to signify that it's what we'll ultimately bubble up to the
> caller in the successful case.

Fair. :-) It's "answer", but "result" is much better. Thanks.


Martin
