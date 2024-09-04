Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FA11E7656
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 19:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725479927; cv=none; b=a/bvD3N/DdqJdrqR2M7WLDUn/MejhwMhlZPj6E4c3zQZ81t1J7kb6y6hnwDP20JngHyL5L6FW9yb05P+kUnVWJ/GQ2FnjJG5voC5f0fxfy1bFoQed7/r9hMFWtFXAAQDtk9CQTIJtDdaMKhoRLiMLmw4m7q1EICGVHcg3oNxSgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725479927; c=relaxed/simple;
	bh=KZThkKRcRMmSN/q1BehgCyLPBYLEh2r7POICYByqh7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UrIGlnPECOuEau+6clEaMrOsqZx8BksZXtw40hSflAAOzHB1P+foGHMoPv4KbtM//0a8UorSEZ5KIojaJ9l9wII/Z6ouhAgNr681ST5SEctzKOZGKKFxjJgItSlH2OiW4WWcCj7ssTmEA+ZFk2YdtBCqOjp/RMJfLqMybO/T9pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWDNve0z; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWDNve0z"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3df03d1f1ddso910977b6e.0
        for <git@vger.kernel.org>; Wed, 04 Sep 2024 12:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725479925; x=1726084725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZThkKRcRMmSN/q1BehgCyLPBYLEh2r7POICYByqh7g=;
        b=PWDNve0zZGtsiENErNS8yNWdHQeVqdRdPd7tWgT2+CBVziBiKP7/hVn8nX34KwT/ni
         xeONmj7wDQ8c+P7apdx0WBO6AHgkucwwaAhCYHKybjBGEjnWq7dG2S54Qu5vEZETyv8w
         nopnfAQs5EoYyH29XVAkSlZUrZOAIH87VuQo6nZdCaOfzhHVHZVWpVQ9fQMC3pufjpPM
         94PBmjAkbaKVybN4MvazgKJ2XDpyQ9qRZsk1mFCWbj8Ztm7+3LQ9w1Eq8fu91pp+Ec7y
         wVDe2Bapp4ML6eyJ4X9B/NlaVuz6nFqbH6LtVL/jMXL5EsEMiZ9chVmp7g2Ean8E9EUa
         0umQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725479925; x=1726084725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZThkKRcRMmSN/q1BehgCyLPBYLEh2r7POICYByqh7g=;
        b=MXUcwI7rofIj7hmHNx0/vKZnshgAECEAVGZW1OkX+Lt2ZCmpTNsQ7dU17fvG17DdoS
         8YRSvBhXnmq4u8WdJ2t4ai7CjV0//uPM2dwruiuyU0bvo5AL15HpuO6WNoOpIaIjjT6X
         GGOSyipAvgkiwcgcrFDzvcmF7NehV98dGk34JZ+hCehyFQepzZ8pvRRXhwZ98AWL9v2B
         AAXDC8N1vlWWU5gHVImP066ADDhKxQplA+2uQOA5Bx/Uq5US0YFin+0wosTs/sRHFYau
         VI436FUxk0eXxiOaAfoK6LVH2vKSk+VQpGR93vdEdLJ+lwz6XvtDW1y1SogGB5QxMe85
         jZ9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUnFVi8IDGus8hJglXgoMLRbFSrt/+xDDrjRneZN9xn3drKnTvdxqVPK3GXdgvF2IDhJb8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp1Y8izp7U16v8obRX1FRd9HOJ6nYZpBcrJ8NAThG+Q9BmWc1g
	7QSMalMrYZliVqEiEvtaSxcHmBFUN4AB4jJi3+wXU629x5KD2Mdjn4dHvEZJKJya+3RsHbB+3l3
	zrR6lgVwl22zCSaCK4mTrSttg/WXOLQ==
X-Google-Smtp-Source: AGHT+IEwSBjnrBw7TNF54NhONRhAVRa6EY6wnCB2kJJ2V57Fje3I6OsrZCVlwHcCNG27BHd4MAiJfmtWwQUTe6/6Zqg=
X-Received: by 2002:a05:6808:11cd:b0:3d9:e22a:8f9e with SMTP id
 5614622812f47-3df05e3bebbmr21134086b6e.39.1725479925211; Wed, 04 Sep 2024
 12:58:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904090614.GZ15670@t480> <0e0fb1c3-d4f7-413b-9985-d71cb1c300df@kdbg.org>
 <20240904180826.GB15670@t480>
In-Reply-To: <20240904180826.GB15670@t480>
From: Jacob Keller <jacob.keller@gmail.com>
Date: Wed, 4 Sep 2024 12:58:34 -0700
Message-ID: <CA+P7+xo9DnTitgVjHzpW1ODwRdFruDf+g+isg5pSHT8f27ASvg@mail.gmail.com>
Subject: Re: git log alias with --all and --exclude
To: Rene Kita <mail@rkta.de>
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 11:15=E2=80=AFAM Rene Kita <mail@rkta.de> wrote:
>
> On Wed, Sep 04, 2024 at 06:49:12PM +0200, Johannes Sixt wrote:
> > Am 04.09.24 um 11:06 schrieb Rene Kita:
> > > I have an alias
> > > 'gr =3D log --oneline --abbrev-commit --all --graph --decorate --colo=
r'
> > > and I would like to be able to sometimes exclude a branch, so call it
> > > with:
> > > $ git gr --exclude=3Dpattern
> > >
> > > This does not work, though. Also does not work without the alias and
> > > typing the complete command by hand. Apparently the --exclude must be
> > > put before the --all to take effect.
> >
> > That is very much by design, so that you can express "branches except
> > the wip and preview branches and remotes except those from the remote
> > archive" with
> >
> > --exclude=3Dwip/* --exclude=3Dpreview* --branches --exclude=3Darchive/*=
 --remotes
> >
> > These collective branch options --branches, --remotes, and --all clear
> > the exclude patterns after having them applied. Therefore, in this exam=
ple,
> > the first two --exclude do not affect --remotes.
>
> OK, certainly not the answer I hoped for, but something I still
> expected. Thanks for the explanation.
>

You could implement this as a shell alias so that your options get
included before the --all. I'm not sure how trivial that would be to
do, but thats how I would go about implementing this alias.
