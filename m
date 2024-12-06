Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD5B14AD0D
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 03:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733455123; cv=none; b=KBRYLeVc8ZEgRRDGmGeB9UIrTkKGmdoWesS2SLm9bTg+2MtnYyoiUTF0J22OSJDR0y+9aj6g67TG1lD8FjmqjQ17v0BBnjhvT4Cr5Fb9t8JV2Cgx4vuWblvz6GMFS+yvZu+gGa0WAp6CqSIaoqvGDvZIQlnR7K9W9/puUUDN/xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733455123; c=relaxed/simple;
	bh=i488qOPEUY0CukDr9jGfcALUpwcl4P9x/hPZVOXq/jo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VGx507lGrx34mtl9tCU/QWrlNvA/Cy1M4hOp4WWlF+Iso8ZZRC2cTgZ1Pinhis2ZMZeBZ0OPsM/2qCeqgypDNgCA6fL2vx5BCwfU9GBnHTVsqVVmUt6+ybDeprxwg0lc3DRAgJEkgQW4Y38KopFy4OMWR7h3t8koAwd5mVOu1oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=atlassian.com; spf=pass smtp.mailfrom=atlassian.com; dkim=pass (2048-bit key) header.d=atlassian.com header.i=@atlassian.com header.b=lKeHuiBi; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=atlassian.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atlassian.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atlassian.com header.i=@atlassian.com header.b="lKeHuiBi"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d0ac3be718so222881a12.1
        for <git@vger.kernel.org>; Thu, 05 Dec 2024 19:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian.com; s=google; t=1733455119; x=1734059919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gvtgs+IMjWWKp6z/ei8gCmQ2HU2gmAhzX9/rcczzs8=;
        b=lKeHuiBijcf+Aaq4JhXQ7CnKRsuWADStJU96J8yLmP0xaY5O/tewa8DAbfNaXBveuw
         6uP3Au9BmvAMePSfK0x+eyOUNHHpP4YA5GxUEm+2ihmrsL6t4A3Lb7qjlT0o+KkiYkwz
         YeM0UVUXuwRm7vlL1/loGcuD/izMZxJgPu8h75dX94A8ga1PvNcIR9eolU0WEmdXA2OE
         temJwt+9j5I3MvF48qdlNyTgXai+A/VRgBtajSh6iN1W380ZxUEjfSCD0rt9Si0Ij43o
         j02TA+rfyRCTPizNnvFNM8iyllLcl70ii+tLm4D2+vs+FRAQoKK4nvSWxtsToUytvhh6
         siZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733455119; x=1734059919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4gvtgs+IMjWWKp6z/ei8gCmQ2HU2gmAhzX9/rcczzs8=;
        b=d/eg3DS0qdbcscROD8+9WDQevFGBLDoDdfjY8Ao8RFHqGvD6gV9p6BWUsijpliGb92
         yD+8/XfDhVkICY5/fEKd3nkHE8ILepGBwD4vENDo0A4TZ+eFwVPkWKxNIv2swzJ02rrO
         H7qSfxXESVZW3GP3PedcfrUm0+lonFvThzAoIisKpT73FXBjybus5LHUjSrpPi3o5Qkk
         xfXwwGbGt4DSAS7tzl1sL3EJGBFszRkDDcVLCiANS08I+wHnhQK7eUfdzORN+FiYZtHH
         8tnZx1PPvFwyNd6LANEg8/1EvypIN+6WCh+SL/gI063e8/52x3GpPzR3MNUmXtBx8oQ0
         3oyA==
X-Gm-Message-State: AOJu0YzBTl4yOZd4ehoaWAj/G76c73zOMxXuIz/2gw/Lil4r1SYhEo/l
	1QFwoKgbToNJ7oXnERI0l4H7yaakEee3WRVkwagFEy73W3hEEUJff+Df7FLBk6Px4hU2ujpgJd2
	36Qf9Qkq6gvqkskAvYkmC8epjkhMVlCOJDUrp5nKJc8F++bU3HkZHN2g=
X-Gm-Gg: ASbGncu2YMLLA/uh4S0VX0dzWF0BNpwyt98aFX0/sMWJA9LrB5Nl7fwwiur3t0GAH7a
	lGpm/JOFA+8m8r7sDjCy8N6jxpUF4exfl
X-Google-Smtp-Source: AGHT+IHnZJAMToyHlGKHBvL/Ru6gakHmO32NL8zQ2z2oj2csFVdd4wJ/dyqCeCl2MRZhYxL7t8lVxZ+R4l+phMu29Zs=
X-Received: by 2002:a05:6402:51cb:b0:5d3:ba42:e9e1 with SMTP id
 4fb4d7f45d1cf-5d3be74c1c9mr438437a12.6.1733455119378; Thu, 05 Dec 2024
 19:18:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACfndskJZyOf2k2JHVo=8C6+RE3nUdMF5my3t_qcL1+3dW26og@mail.gmail.com>
 <CACfndskPgu5yxSCYE+x0XTq3U+KzfmN4e=rqifA1_n6HQqdG6A@mail.gmail.com> <CABPp-BECMyPS6TOfKprdRyfkJC1CbFzVm+xG0D4LNNU2E1Jtyg@mail.gmail.com>
In-Reply-To: <CABPp-BECMyPS6TOfKprdRyfkJC1CbFzVm+xG0D4LNNU2E1Jtyg@mail.gmail.com>
From: Manoraj K <mkenchugonde@atlassian.com>
Date: Fri, 6 Dec 2024 08:48:28 +0530
Message-ID: <CACfndskzmJEVPN7UXi2sF-4pUqDEkeG85nOtCVsHYD2_SNrhLg@mail.gmail.com>
Subject: Re: [QUESTION] Performance comparison: full clone + sparse-checkout
 vs partial clone + sparse-checkout
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, stolee@gmail.com, 
	Shubham Kanodia <skanodia@atlassian.com>, 
	Ajith Kuttickattu Sakharia <asakharia@atlassian.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Elijah,

Thanks for your response! Sorry for not responding sooner.

-- `git pull` will both fetch updates for _all_ branches, as well as
merge (or rebase) the updates for the current branch.

The `git pull` here is actually `git pull origin master`. I guess it
will fetch objects and blobs for the master branch only, and in this
case, both partial clone pull and full clone pull should perform
equally.

-- I'm a bit surprised by the `git commit` case; how can it take so
long on your repo (2-3s)?

I run these with `--no-verify,` so hooks don't impact these benchmarks.

How does git understand that it's a partial clone repository during
the object lookup? How does it understand that the object needs to be
fetched instead of coming to understand that the object is not found
in error?


On Fri, Nov 8, 2024 at 10:54=E2=80=AFPM Elijah Newren <newren@gmail.com> wr=
ote:
>
> On Wed, Nov 6, 2024 at 8:52=E2=80=AFPM Manoraj K <mkenchugonde@atlassian.=
com> wrote:
> >
> > Bump
> >
> > On Mon, Oct 28, 2024 at 4:00=E2=80=AFPM Manoraj K <mkenchugonde@atlassi=
an.com> wrote:
> > >
> > > Hi,
> > >
> > > We've conducted benchmarks comparing Git operations between a fully
> > > cloned and partially cloned repository (both using sparse-checkout).
> > > We'd like to understand the technical reasons behind the consistent
> > > performance gains we're seeing in the partial clone setup.
> > >
> > > Benchmark Results:
> > >
> > > Full Clone + Sparse-checkout:
> > > - .git size: 8.5G
> > > - Git index size: 20MB
> > > - Pack objects: 18,761,646
> > > - Operations (mean =C2=B1 std dev):
> > >   * git status: 0.634s =C2=B1 0.004s
> > >   * git commit: 2.677s =C2=B1 0.019s
> > >   * git checkout branch: 0.615s =C2=B1 0.005s
> > >   * git pull (no changes): 5.983s =C2=B1 0.391s
> > >
> > > Partial Clone + Sparse-checkout:
> > > - .git size: 2.0G
> > > - Git index size: 20MB
> > > - Pack objects: 13,560,436
> > > - Operations (mean =C2=B1 std dev):
> > >   * git status: 0.575s =C2=B1 0.012s (9.3% faster)
> > >   * git commit: 2.164s =C2=B1 0.032s (19.2% faster)
> > >   * git checkout branch: 0.724s =C2=B1 0.154s
> > >   * git pull (no changes): 1.866s =C2=B1 0.018s (68.8% faster)
> > >
> > > Key Questions:
> > > 1. What are the technical factors causing these performance
> > > improvements in the partial clone setup?
> > > 2. To be able to get these benefits, is there a way to convert our
> > > existing fully cloned repository to behave like a partial clone
> > > without re-cloning from scratch?
> > >
> > > Appreciate any insights here.
> > >
> > > Best regards,
> > > Manoraj K
>
> Taking some wild guesses:
>
> `git pull` will both fetch updates for _all_ branches, as well as
> merge (or rebase) the updates for the current branch.  Your "no
> changes" probably means there's no merge/rebase needed, but that
> doesn't mean there was nothing to fetch.  A partial clone isn't going
> to download all the blobs, so it has much less to download and is thus
> significantly faster.
>
> `git checkout branch` would likely be slower in a partial clone
> because sometimes objects are missing and need to be downloaded.  And
> indeed, it shows as being a little slower for you.
>
> `git status` is harder to guess at.  The only guess I can come up with
> for this case is that fewer objects means faster lookup (I'm not
> familiar with the packfile code, but  think object lookups use a
> bisect to find the objects in question, and fewer objects to bisect
> would make things faster if so); not sure if this could account for a
> 9% difference, though.  Maybe someone who understands packfiles,
> object lookup, and promisor remotes has a better idea here?
>
> I'm a bit surprised by the `git commit` case; how can it take so long
> on your repo (2-3s)?  Do you have commit hooks in place?  If so, what
> are they doing?  (And if you do, I suspect whatever they are doing is
> responsible for the differences in timings between the partial clone
> and the full clone, so you'd need to dig into them.)
