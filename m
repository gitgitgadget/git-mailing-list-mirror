Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C121E5B6C
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 15:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743780025; cv=none; b=sQ4LelVwV2ebHREqV8le+9Vp0k7ToeLI8hFle1BnehWrmwyJcW/kf2qM5oDYmZnrPxf0wi4kg4bt5GZPrT9ECND4UBqJQYa3cdVkJk1q4PLjBvcB2WmACOtMxY9r/N3A+Dx8J727QeB5ywyJhE2WeiTKm1iHqVAq41CZHU0dul8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743780025; c=relaxed/simple;
	bh=Uq7N8B1xvExVYiywKDHaxmB3IRAmT93I9PRUX/JhxcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=DyIo13f62eZ5m1rcaVNy5RrWgdZ/Bf0/LYWXREegQz3tJJ4tybTJWJo+jn2NdotkCeKuYV2N1b6L/ee1K2E6NYwRE2TS49g5Pp8hrMfObDTMx2N5sQyLX2cSomjrOrVQw3AFrNl0fRxiNhvdhlCYOSax86McVnIHaxSznhDAdMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6t92zqq; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6t92zqq"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30bf7d0c15eso20262551fa.0
        for <git@vger.kernel.org>; Fri, 04 Apr 2025 08:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743780022; x=1744384822; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uq7N8B1xvExVYiywKDHaxmB3IRAmT93I9PRUX/JhxcQ=;
        b=b6t92zqq/Ionoq/NqGPbDNE16AIsh2Zi4EG/4Wi7Yzr94jmSFI4kuGairGAo85ASTs
         YjebkXQzHDaQacocfW7Sg2ROKfK/POzFQvlKa6BforQRKDluUwfJZVCxGrHp6zYb846v
         33v6vkBZeA3i0eqhfZpNK1yh7H4CmxCyH+Q3vj2Cg6I+JtA2/GyXtlgB/vRFfz5p0ORr
         QBRnJkO0YdNUeuj4hjiEyCmL8d2+x1vMEawSpX/AWQ2M0AQIG/QObVJzLLD14T+rAHRu
         A/JrvwFLlVl4iVsjKnrKTytJOETdkAhjOm31KipXptlxATSSEBpybA/kyGYzhAxA5DX5
         hrsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743780022; x=1744384822;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uq7N8B1xvExVYiywKDHaxmB3IRAmT93I9PRUX/JhxcQ=;
        b=WzMP4ttp01enBczOmvcp5doMmMaW+B5cyY2n1dBs32xiPuYNtE1R7NReUbiG4HQGrm
         UjB21ptVh/Tlo7BpdWPwE2+/kJJi91kMulNd+YCQi7QCw5ckFDW3oHV0gvcqlYIDP0yN
         tw6WS1HrnJN5Ss45Gten3iX3aRm+9K+Cyg2ZtG5UCvozyjajnrunnO018F0WX/GdlbCX
         bd7jkGvoRO6asI/L1del6Acdfz5NLo0HOsnzD7yFj9/QgP/EdOdgoUwOeVJcvpCHu5kg
         05S1JEFj0idJQSsruboVN4FLZt4XwgqIZlBqXgvpoqtebceg3mti0YZtS77myfQFkpDg
         rJkg==
X-Gm-Message-State: AOJu0YyzgjNhrmjxNHn/5Kr/QDxYzlE88yOcwjY0aqaRd8OOjcTooZ+B
	Akrbzin8WQTooxSWO1U4GHnRTrtkjHyQHtPlx9AFqBS/p9J9+FfopHSrFRU6MZ85bzxujTw157g
	gLv09TOf9mS3HmYtRE1HbS0UMA6UQJ/5odXo=
X-Gm-Gg: ASbGnctYCfM2nqQx352DI7H81i+Ewf31mFjCBZFotff11+SUKqYRmmiNuvAXVvUG3Xw
	c9nMDxPA0+GyF4tIAdE+1qzGKdGitZ7LaGzeBngJyZfXZmcyP7JFkjSOdpcEVp++NXKUF/JTy1y
	kCqipp2vsOqAjf+cvgi3xarGhdZ5iRUngEpHN0GB/gHIB9iLh1uke2WDM/Ash3exDzASpT6S4=
X-Google-Smtp-Source: AGHT+IHBsCR+PCg7aMbLDZgVj1gRpya5cejGGsGx/HT2l1YNmDQS3pP/hoZxHqeLMbutuBKwjp0OwfsCBHVnfJb8pag=
X-Received: by 2002:a2e:a805:0:b0:30b:bf4e:f6fa with SMTP id
 38308e7fff4ca-30f0a12e618mr13323921fa.17.1743780021606; Fri, 04 Apr 2025
 08:20:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250329150248.2274482-1-05ZYT30@gmail.com> <20250403154404.3459805-1-05ZYT30@gmail.com>
 <Z--_TvQ9MXgjxqOV@pks.im> <CAMvj1+rMY2YR8_GGFeDoJ6HCiVDusZZk9fAguKh=kbctHO=2Qg@mail.gmail.com>
In-Reply-To: <CAMvj1+rMY2YR8_GGFeDoJ6HCiVDusZZk9fAguKh=kbctHO=2Qg@mail.gmail.com>
From: Yuting Zheng <05zyt30@gmail.com>
Date: Fri, 4 Apr 2025 23:20:10 +0800
X-Gm-Features: ATxdqUFvmX1Bzjn4-NKtD5q73_6ZJ57Y9JySDeEgW7ejojUjWtuxZiod5UJxYIk
Message-ID: <CAMvj1+qpX8Q2nV62zLAut14-2w399y2V-eJmGc7J+amtJ7d1VA@mail.gmail.com>
Subject: Fwd: Discussion on git-refs list Implementation and Possible Approaches
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 4, 2025 at 10:48=E2=80=AFPM Yuting Zheng <05zyt30@gmail.com> wr=
ote:
>
> Thanks for your review!
>
> > Another factor is the default format that these two commands use which
> > differs. I would heavily lean towards using the format exposed by `git
> > show-ref` because it doesn't require us to hit the ODB, and thus it is
> > way more efficient. This has bitten me quite often already.
>
> Thanks for your reminder! I will explain this output format in my next
> proposal, and I agree that we should adopt the `git show-ref` format for
> its superior efficiency.
>
> > I don't think it would, both are orthogonal to one another. I don't
> > think people _only_ want to format or _only_ want to filter. Quite
> > often, they'll want to do both at the same time.
> >
>
> On the topic of filtering and formatting, I plan to implement these as
> basic functions that work together seamlessly. In other words, the filter
> and format functionalities will be integrated (without being exposed as
> separate options) so that users can combine them as needed. I will
> submit another email for further discussion about options.
>
> > > 2. The performance could be worse than `git-for-each-ref`.
> >
> > Why is that? git-for-each-ref(1) already knows to filter and format, so
> > I'd expect the performance to be roughly the same. In fact, I think we
> > would be able to improve performance if we changed the default format a=
s
> > mentioned above.
> >
>
> I am concerned that iterating over all available options might introduce
> additional overhead.
>
> >
> > I don't think this plan would make sense as it would mean that current
> > users of git-for-each-ref(1) wouldn't be able to migrate.
> >
>
> Finally, in light of your feedback and Karthik=E2=80=99s, I have decided =
that
> Approach 1 will be my final plan.
>
> Thanks !
> Zheng Yuting
