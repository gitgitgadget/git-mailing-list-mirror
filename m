Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B0230DEA9
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 21:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763673859; cv=none; b=Llgzk5RydmE9yJWcgSLsqFHOeoMvSR43LoABXATfzUwyMMRi8RBN6fjSSXKoPbgLwyuRaxo1erpIYOvCoS0IajTBwV2PNM7iCPsDnyUyol1bE4fkPaEqDsx1YZHu1ySRVS3pg88NiOPDV2vhwDn1eH3jgMpfFYH9K9aUsw3w5nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763673859; c=relaxed/simple;
	bh=/WASewN6nZ3pg7OhSNv83L7t7dXXmxFapjQqB4QJaZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TRoHJ8BUgCtM4pXqcR8s1mg75Dzr5M63ZzZzAPZGi7JIAw8UwWyaKr4fLqO4Tfrdj0F1vfugd//DpcOtqDmp71X7bDmRKeE1OYLvEdTRAicmQHBn3AZgxYIKkVqU/NMI5mAeB6uQnSyFXQDa4eq92asq336VF7ZyiO0+9ng1Joc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJXd2fOZ; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJXd2fOZ"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-450b2715b6cso608694b6e.0
        for <git@vger.kernel.org>; Thu, 20 Nov 2025 13:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763673856; x=1764278656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOt6LEHwtEud9XQGha8DonAJFCqEYT/Ojw6TV51po6k=;
        b=hJXd2fOZzdAqwG6L3Ikjcfzoc+3TlhNXjZllzQ3VwH9ihxtcQ+o5ZeLS/NfEYbJ934
         YjqY294PTK7NgXcD7dqnBHPl2R+ZvPAx8z4uHemWhUtWm6VSbQLgZ+wc+2FUwFzRnIj9
         ZICfbtwU6Z5M2GWm2SzbqNM7CIQg+14f7WCnqYJll30Vwu4xBH43o0CqTYIiPfzpu7uV
         +3Lq0BNa3vCsBeguF3UuBF6abEKEO9uzrz6hOs5hR4v8ie6HPpoIBkziABlxXqdfYkOx
         KlRIzh72PPwJrEuD7l2/c3HnxWMVAe89Ss1ge88pLYmXfGtIll/5HuzG95sdRwtx3qJ8
         TuZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763673856; x=1764278656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SOt6LEHwtEud9XQGha8DonAJFCqEYT/Ojw6TV51po6k=;
        b=qikmytylAmUBloihIbyJ6LKmNZJ0qWmVyZACwePahCEyMCHEEayAE8jG5eM9/au6CR
         YSpeDf/nVpglmK8MfKYZfW5Ol5GAEpHN4kNcuMHgz4UKTNGczuAz+/de+Yh+vlbMkbC0
         zkymlN2muypRGDNTDqoniFmvjmBwrUfX408IYPFlnG/AIpeb8eFckVPGkywqk1qQ7JqT
         csv1t+l8MVwmfiqzo9Y83HWJMI8XtFcm5sU4ODwC0ZLt3M7eLgMYxqSY6oz9b0D4B8Ge
         lVabOL1d7uo7Yz3xKX4HDNk0fYCTotlEjfgR5fz4KWSa2j45Zmd5ReK9JVOEfIvv8vj+
         HSqw==
X-Gm-Message-State: AOJu0YxfKQmke2k0UpoSWxw5owBg1M4TwBhYe+bGXQgCrtRu1IRDb+SY
	cEEuFk0yGYb9eZ6Q5Y4NB+B8sdsuKh7oUq3J0/+IxiPh2Ag3QT/C5c9Ne3nbAxwPk5e5bM3QQ/B
	dZSYJd/VzinlbHz+97xr4k/3yTFzq2b5iJg==
X-Gm-Gg: ASbGncuIVHMZo8TLeYSjGL15YkbOghfzXrQh8zsm7zEwKBcJ3TuFFh7yFQE5gNIBTDK
	csak0lH+GH0f43Z7kOAI2LI9y7pi+KmQvE5cbfuKAgsbxriIycRduCzBwNDt696sgCOvJJfy+C3
	gcc8wmdZLIkvUoqMuMuIGRr4iLXi1rhoZKKjsqy6p0ykYMjEcANcNvrUz40lZgY5YQiRbCF24hX
	rQYrKm75waHws9ApgiAb2KqQMtbdLsaLmkul8cD9YdW3vNNVuU2avY8P5hyVunBudLml0XsUUUr
	AsvCjGgqC6Pp2hSJZAe1rvKP4w==
X-Google-Smtp-Source: AGHT+IEx4mJKsFyr5hkJbypXU/rzLqSMHhWcqx30uG9G2y//7RCVf35eaLfLCcEDJJ7PhHR7toHPtHxfFno232bDbyY=
X-Received: by 2002:a05:6808:c292:b0:43f:6d5a:9cfa with SMTP id
 5614622812f47-45112a9215emr43832b6e.23.1763673856443; Thu, 20 Nov 2025
 13:24:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL4-wQrgD3nnW2BfNf6e9d7tDANE60dYBRRP_0FW3Z-LvQrZmg@mail.gmail.com>
 <0e971281-d1c4-4030-9297-f5e2c0765431@app.fastmail.com>
In-Reply-To: <0e971281-d1c4-4030-9297-f5e2c0765431@app.fastmail.com>
From: Martin Guy <martinwguy@gmail.com>
Date: Thu, 20 Nov 2025 22:24:03 +0100
X-Gm-Features: AWmQ_bnRpeAQz_7XaaReGVFhHzlyNcBNWEwHPIVxfSWY3-aj4l2nejd0DzQ6ASk
Message-ID: <CAL4-wQpeYc8-FfcZGWcs6KmR-oswTs3Kjcc7xAb34cFX7s0c-A@mail.gmail.com>
Subject: Re: Feature request: git cp
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, but that only seems to affect "git log" retroactively, whereas
I'm interested in it being part of the history so that "git blame"
knows about it. At present, the blame for a line would end at the time
of the split (when the file appears to have been created ex novo)
though I suppose people would end up at that break and could then
switch to tracking the old file instead.

Maybe I'm expecting too much of git, with all the truly wonderful
things it does already, but the idea seems to fit into the current
scheme of things as seen from the outside (I don't know how the "git
mv" line-based trackback works).

    M

On Thu, 20 Nov 2025 at 16:17, Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
> On Thu, Nov 20, 2025, at 15:56, Martin Guy wrote:
> > I am splitting a large source file into three smaller ones (mp3.c into
> > mad.c, lame.c and twolame.c)
> > and would like the history to track the relevant lines in each file,
> > like "git mv" does,
> > but I only seem able to do this with one file by "git mv"ing it and
> > copying that to the other
> > as a new file.
> >
> > So what I'd like is "git cp" that is like "git mv" but where blame for
> > both the resulting files
> > goes back the original one, if that's possible and unless there's a
> > way to achieve the same
> > effect that I haven't figured out.
> >
> > A fairly rare thing to wish to do, but may be useful in this case.
>
> Copies and file moves are detected dynamically when you use things like
> `git log`.
>
> Try `git log --stat --find-copies-harder`.  I get this output after copyi=
ng a file three times.
>
>      README.md =3D> rm1.md | 0
>      README.md =3D> rm2.md | 0
>      README.md =3D> rm3.md | 0
>      3 files changed, 0 insertions(+), 0 deletions(-)
>
> I get this output when I change one of the lines in the same commit on on=
e of the files.
>
>      README.md =3D> rm1.md | 2 +-
>      README.md =3D> rm2.md | 0
>      README.md =3D> rm3.md | 0
>      3 files changed, 1 insertion(+), 1 deletion(-)
>
> This is the first time I=E2=80=99ve tried this option so I don=E2=80=99t =
know
> more about it.
