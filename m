Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A591DFE17
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 16:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725467408; cv=none; b=fKURSAlRiQDveKwkxyH3eTKbiEv9u+qv9Tyu26yyTT1GV2w+D+nZ8LWb2lt0SLih1vmmCoUxOPT/d88dVYJHnXudWhoKG4h3OVPkpdgwNusmFxlgsMrYvUT10QbXkvAzIyQXjEGlBedeIfVe2fB/bAWf4lE8vX4/u8ONhfssJ8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725467408; c=relaxed/simple;
	bh=/J9zSsfdH5YzpA1ErumH4gPjADxxb6qUUkvzazYJUfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MGsHyIMTRXDnxJDL8OjMv7jCWbuKhSlal35+vxIP/DD3My9cb8v05M9o5lU2nNruC44+j5Ru5PSENv00ZiluimcTyigbcmR0A6AYWTZotVqwje3nJF+6Z775/QSFWmpCtQf7A1NDBueNk5hKWMcifZgCRT8FuCGpdhnGsMDk53Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJJ7zlDV; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJJ7zlDV"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2d89dbb60bdso786300a91.1
        for <git@vger.kernel.org>; Wed, 04 Sep 2024 09:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725467406; x=1726072206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdkDs30fSHOLi5EwugtPPNu9SaGefvg0dmEgOfGb8Ow=;
        b=PJJ7zlDVizsfSq41Nj12SZxUPbJIQYd60UvIIRhgHnaURu+5N9ed7GJIqo6+hzRpq3
         /Vj4woY1BJ7wkxIK56H4f6feln93Z7n/AHbAVTnwyCYeHI7gBDJMect0+0/7RybcM4zd
         UVzyT3Ip9hGkWgASbaBYx3GcCeWaMDKHjX7sPu1iBPgQMvFv2GXsfkQddbDoOgYPtX3o
         DM8J5JbjbvE7/z2YsRDafrMoG+xlTTsRItmomZwT6Pzmwui2FrKpyPkJcdFUDYhLKj56
         /1iwsC6QZcB2KHfvjHdyO3SlV0r/RFPg0r93aOYvUm7Rl65e5eQNCH2qkLILfhKI1DrR
         pn2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725467406; x=1726072206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bdkDs30fSHOLi5EwugtPPNu9SaGefvg0dmEgOfGb8Ow=;
        b=dFWSVSX6Bz6LlJW0RBsLp3euaqI+aqjX7cgXzdNccKeFt/yeAkky+jhX83lNiJfvs2
         Y/V6bEEd1OPsl9Tyw94paiL4K8senFN0wmaF1EFNMm1nqcrBB61o86BjApgYinwrOYLT
         8gOpd4yp5pShh/v1n6P/8PqAfmwpxf/mSe48DH2fGu7yzV7S71WIcPjeEemsrUCDPJAS
         sMFuoj3pDWDBQmdy9y04j9niqB3FXHWrPY9bMYRPtP8d5CcVP+6z1GUdsYSJtILFhu0h
         eBVDtSiXMei2LmfMYanxC1rxvErUoievdpoeg65lVxXw9ReCdi0uOSGBy6VpbyIh8n5T
         d7MA==
X-Forwarded-Encrypted: i=1; AJvYcCX/zmiLOnSYLMob2wpMSSyUGFnTioFBOU2D7tyNaKEwqfoVsHpOUG2q5Gy3eaZf1hWVc2s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu2K0gQrFZ43IJUV1b8lJTTqCw9yDGHFI28d0vJcd7cZA/qZQo
	7rY8Z6OzJC5jzNQv3aigz0tAiQbCLVlf9EjAm/KGZ8yPsDHoL6BF2ZbfTkjHUiwX8ZGV92e/+FX
	PADyIvvej/oAGcBfP/nddc8M0QiE=
X-Google-Smtp-Source: AGHT+IGXbXVG+/C3/QxH7wea3c9SCybnjAI/l8hPT2OvNonK6cY12L1+l6OdbQ99mKvdVM2IBz8Pep+Yik6HyfinfP4=
X-Received: by 2002:a17:90a:be17:b0:2d8:7804:b3a with SMTP id
 98e67ed59e1d1-2d878040ba9mr19214940a91.26.1725467405797; Wed, 04 Sep 2024
 09:30:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG=Um+1wTbXn_RN+LOCrpZpSNR_QF582PszxNyhz5anVHtBp+w@mail.gmail.com>
 <Zs8KzG0vzCEDvkvx@tanuki> <xmqq4j7438yc.fsf@gitster.g> <CAG=Um+2OQofcfo3vjvPJEAUht5cGg0LnPAx54SWUPETgkRACPQ@mail.gmail.com>
 <ZtacHCuql0pX3V2u@tanuki> <xmqq5xrcn2k1.fsf@gitster.g>
In-Reply-To: <xmqq5xrcn2k1.fsf@gitster.g>
From: Shubham Kanodia <shubhamsizzles@gmail.com>
Date: Wed, 4 Sep 2024 21:59:29 +0530
Message-ID: <CAG=Um+3QtRkNcSq68iOWW=HWJytDReaikAfjX6MrgOY5n56gFg@mail.gmail.com>
Subject: Re: Improvement: `git-maintenance` to allow configuring of remotes to fetch
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 9:37=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Patrick Steinhardt <ps@pks.im> writes:
>
> > The prefetch refspec would be rewritten by git-maintenance(1) such that
> > the destination part (the right-hand side of the refspec) is prefixed
> > with `refs/prefetch/`, same as the fetch refspec would be changed in
> > this way.
> >
> > An alternative would be to _not_ rewrite the prefetch refspec at all an=
d
> > thus allow the user to prefetch into arbitrary hierarchies. But I'm a
> > bit worried that this might cause users to misconfigure prefetches by
> > accident, causing it to overwrite their usual set of refs.
>
> I agree that it is the right place to configure this as attributes
> to remotes.  It would make it handy if we could give a catch-all
> configuration, though.  For example:
>
>  [remote "origin"]
>         prefetch =3D true
>         prefetchref =3D refs/heads/* refs/tags/*
>  [remote "*"]
>         prefetch =3D false
>
> may toggle prefetch off for all remotes, except that the tags and
> the local branches of the remote "origin" are prefetched.  Instead
> of a multi-value configuration variable (like remote.*.fetch) where
> we need to worry about clearing convention, we can use a regular
> "last one wins" variable that is whitespace separated patterns, as
> such a pattern can never have a whitespace in it.
>
> As you too agree with the position to consider "prefetch" should be
> invisible to the end-users, we should not allow users to specify the
> full refspec at all, or if it is forced or not with "+" prefix.
> Only accept a set of patterns to match, and keep it opaque where in
> the local refs/* hierarchy they are stored.  It is an implementation
> detail that the users should not have to know about and rely on.
>
> Thanks.

Right so I have good direction to start working on this. I'm going to
tackle this in a few parts since this is my first contribution =E2=80=94

1. adding a boolean `prefetch` attribute to `remote` =E2=80=94 allows contr=
ol
over remotes that prefetch
2. adding `prefetchref` =E2=80=94 allows control over refs per remote.
3. Check if adding a ` [remote "*"]` catchall is a possibility

For the boolean `prefetch` value the =E2=80=94
1. The default would be assumed to be `true`
2. No changes in behavior to any variation of  `git fetch --prefetch`
command itself.
If no remote is supplied to `git fetch` then it means default remote,
or if `--all` is used, it means all remotes and `--prefetch` for both
always
prefetches irrespective of the config value.

If I understand the codebase well, the changes would primarily affect
`remote.c` and `gc.c`.

Also much thanks for the feedback both of you've given thus far.
