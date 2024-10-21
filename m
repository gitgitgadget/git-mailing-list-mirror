Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7244C2F4A
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 16:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729528472; cv=none; b=esgjQD+a77fCd7g1duW+fp6Wy5MkUYc1gzt9VqCl3nqwqh9YG6v6ZMTIppHS1x3mNnMp+9R5oGO3Sm9Lu1Z7eT4ZLZpm9hEqRS2ExG5Z+P0CPpva6ZbfdtFc2+Cx5vrgJBVdaBhzPnDT+8nSy8+BxiC2sNg840CSjwhSOSUdk2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729528472; c=relaxed/simple;
	bh=hC4fenvl1xRqP54RSF5sccJgGm9XV0RP4T+RDh/ZaUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W19sc0qvbMUoZ1kv4kwGjLhJF/mkNZzfpj6wLPtiHYojOU1Rnt5RriaKp7e2uNeAsXeGMA8RwrF9S0OK8RKWtUo2ishdMp/Dp+D7caxdSebqrXrS3QlVpf7pthFKuSY6zNGCPX0HHglxVJWtZxzVRM+Yo31qyjZV76/GWp2Os9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HS27IcMa; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HS27IcMa"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3e5f9712991so2279067b6e.2
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729528469; x=1730133269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzIpoBnTe2NpFUj1cyelPJgIjeObt+pSMUsxv22u2hE=;
        b=HS27IcMaTDnxCEr0xGBK2k3YbBZGm75rHlFG2Wl8f//5eFhENRAxomgdkiUpt4C4mD
         3invsCAqJBK+eU9bfT+xywzH7ldr6z4n6tpZX5UCkWCtTMVnqu96lPSoGtbw08jydYbq
         FB4b2BEV+lkfiILaeh1aWC8ytCqWTAK5+PsIW/oN//hu+tTyg1bNtGW09GHcTMXcHNMz
         ol8UJnCwtFm/11yre1dLyzQjpL1LffBCm9rNkDz7R1I7WX7584NBsyxYodWmddZZmERb
         v/BVhxobiMKDYOnn3T9jdaq3nbrOcJu1iEVW7Lf9CCpVMDMBVj8nMEiXGnZRjUnki0qS
         2bUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729528469; x=1730133269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VzIpoBnTe2NpFUj1cyelPJgIjeObt+pSMUsxv22u2hE=;
        b=baTtFOlvMuWO1xGhfLGIOIglExOU8vMBIHSeXZoCzkpxghnLIPa8Oh5QSLWKWWyZbB
         8vxRwT0M8bIVdG5gQ4wOJgDdrpfGsfTHZdVNNTnYpgzZn+WSa1KbKf1qctCwmWPy6fFl
         NOW8PKD0sP1IU657WykgDbdSF3G+4FcEa98hFlOfA0ZmHhqgf6dhEUEbPF9WxI5STK1l
         zZiH5c++POD+ryCiZ6K+DwidR3w/M8m4u3jujiDBsKS0ceXjmovf0gUXDQ4Q8/XRqXez
         QQmgVv+eDbnOP24wNHi7UzvuqyBF1JtKR+ODOoy7e71QC2aqvRQmIJPvBdOYjn6mQxRa
         XFjA==
X-Forwarded-Encrypted: i=1; AJvYcCWi5rfLjZwPdiIEGL1LFMmulLrBxzRVqVkdwy8EngFMekVA4voorWTUM8lX+MRukJcnULc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcN70d8YDq/PPJxBY1CqzBHhJKRZfmoN7N4A2nInvJADH6PlzT
	YL82kr7YRZgEfpA+ccYLxGSVx6QXzvB2RyJg4FyYRjKF731e2AWQinzkwBXAd06Xls26IAT5aBn
	Ic9EferIGdDlpEzUl7A6RMI3i6BMH3o0m
X-Google-Smtp-Source: AGHT+IGuIDXoSXnRM42mvEzFBWlpiE2CD2tycFzd96OS55vuE1JY4vUr6vkdwcY3G9xsuWAK12QyfcfnlGSMhmXFcpM=
X-Received: by 2002:a05:6808:159e:b0:3e5:c8aa:1441 with SMTP id
 5614622812f47-3e602deaa15mr9569976b6e.45.1729528469218; Mon, 21 Oct 2024
 09:34:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
 <pull.1810.v2.git.git.1729259580.gitgitgadget@gmail.com> <a333d8a40134f4a06812fdbf85c2b011e9d3e472.1729259580.git.gitgitgadget@gmail.com>
 <ZxZHFY4cXQ1lA4QU@pks.im> <CAPSxiM_+4ZaaiyvWDVwXf3tnt08otsx=1dcJJtQsL7h59dO8kQ@mail.gmail.com>
 <ZxaAVgJa1VCj/9Ge@nand.local>
In-Reply-To: <ZxaAVgJa1VCj/9Ge@nand.local>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Mon, 21 Oct 2024 16:34:18 +0000
Message-ID: <CAPSxiM_3msts1md99umicv+D7wAmKqW541-7oxW44fF65NKpTA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] daemon: replace atoi() with strtoul_ui() and strtol_i()
To: Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>, Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 4:24=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> On Mon, Oct 21, 2024 at 01:43:53PM +0000, Usman Akinyemi wrote:
> > > Hum. I think the test description can stay as-is, as we don't typical=
ly
> > > mention all the exact details of what we test in a test suite. But I
> > > also don't mind this too much.
> >
> > Ohh, noted. I just thought the test description does not have anything
> > about merge.
>
> Let's leave it as-is, unless you can come up with a new description that
> is a little shorter. Absent of that, I think the current description is
> fine as-is.
Noted andThanks.
>
> > > > @@ -8,6 +8,31 @@ TEST_PASSES_SANITIZE_LEAK=3Dtrue
> > > >  . ./test-lib.sh
> > > >
> > > >  . "$TEST_DIRECTORY"/lib-git-daemon.sh
> > > > +
> > > > +test_expect_success 'daemon rejects invalid --init-timeout values'=
 '
> > > > +     for arg in "3a" "-3"
> > > > +     do
> > > > +             test_must_fail git daemon --init-timeout=3D"$arg" 2>a=
ctual_error &&
> > > > +             test_write_lines "fatal: invalid init-timeout '\''$ar=
g'\'', expecting a non-negative integer" >expected &&
> > >
> > > You can use ${SQ} instead of '\'', also for the other two tests.
> >
> > Will make a change now.
>
> Thanks. ${SQ} is much preferred here, and makes the resulting test much
> easier to read.
Noted and thanks.
>
> Thanks,
> Taylor
