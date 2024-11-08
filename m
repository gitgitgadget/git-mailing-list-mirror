Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5104D199385
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 17:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731086658; cv=none; b=rtDjfWaCGIsAQr6nkwppSvxx78vZVRXawnrnJRasnWlpIf1OP2ma1WhS1tUQCMlNFA71r/YRfJvDQMDG0XTyYUN73S15QLaZNh/KrKRXHJtgm1h9J2VLZEIKFUW2hXU4uIIlBk+khTWdLbQUM9rfAphpcqTJ+HnDf2FZEprniMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731086658; c=relaxed/simple;
	bh=oc13ir99rL+hl6dBZB7mKPJLlxpm9gVR+bUaSfBfIY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pMv5WFPwizhlGw1qSIo/XyRmqqFV6Ym56e9AgVnJJftIakqqN0WFbwacos30UitosXAhwP7gEx1SoJygZxEGhGln35vcHR8Nm0xMHIKH4Wge2fvFUdoSjco/qRzf0rk56n55YjW6IBKmGJ1Z5Qnl0/odmQXCIr7P+LGVo9buRrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTWPrVQi; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTWPrVQi"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-8323b555a6aso114465639f.3
        for <git@vger.kernel.org>; Fri, 08 Nov 2024 09:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731086652; x=1731691452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWVELxoerduv2PgQ6CaGUsh8rzAEYb4gsLpmdMhfy6g=;
        b=iTWPrVQia86UPTDOahVhocuk9+n1UyExmMRGGVJsGsZU6DE7PgplXqPVNovSKd76SX
         6WuWc2WZ2Pf6nQ0utfGolPRN0NMtXo9n+2DHto1EG7/5jEb96nn6ErunmScxsjvcVAq6
         dQgb/Up2CaPOR3M9F/i/N1urwtO8QUYZj2NSYu95HAqXWm9zodbUxijOoNTzTFIisaQR
         qcP3WBsALIHMhBgQi3x+bv6w2okjXdQRxAQ+cR+/QzpoLTOa9gtlir467sSZVoQFwTQD
         OxAgUGlzINZ8M4ocj5Wi+7kvYyrdxCCadWG7RYvYwvhrkG/KHoqhpuc+ucwFa6CT4mSL
         yp9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731086652; x=1731691452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xWVELxoerduv2PgQ6CaGUsh8rzAEYb4gsLpmdMhfy6g=;
        b=m1PEvZ4j2YSRVF41gH5NCZyspT2EUKLze8lWqKdEFPpInVEetKenUA5w1cNv3Ngbe3
         cecLohe3a/GAoZPdJzlgAvpNONaVfw24HecOuTmQgO/zt/VUFMrDpkCVx833vuNPE4WU
         fLrzWbwM6lIHQdgif5SUMSooKG58GWvVJ19mAQhdmHX/GkAQ1lSsBHKBxMqBqhMHdUUl
         1787CjSRERjeYpLguYN+YL7V3CSVGo9Bghz9heohwnxYQp8uB0HC+JN39pD7Kb8lvkKn
         IyDeI1wEjc/xkIFvDGxQZK0uSwsE7BTwy/u6WEtVEb6eahBgsW5zHAgz+PeMmeK1fJms
         PGWA==
X-Gm-Message-State: AOJu0Yyb7I7/hguB+vhRAGS05P4THuwwzyNyzf2QakD6mBzWRZrF0oaY
	94fRH94lEh2XxSJe2JatCgW+Pksfv1uvVl2vPZGbE4cdyWOMGGhNZqeYYcVmuH4Yh/BFmJKiI6h
	e7R94F5nKa5Se8pphAxKaQ0K6K3E=
X-Google-Smtp-Source: AGHT+IHGtgURlAGmZ5R6UjDFoN30swpQ/v2fNuFkpBFDG+JSCsGf9yXarlQMmUiYYNHJBhOkCiGDdUWCk8bGAVe+nTg=
X-Received: by 2002:a05:6602:6d85:b0:837:7f69:eac2 with SMTP id
 ca18e2360f4ac-83e032a1845mr422713739f.1.1731086652225; Fri, 08 Nov 2024
 09:24:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACfndskJZyOf2k2JHVo=8C6+RE3nUdMF5my3t_qcL1+3dW26og@mail.gmail.com>
 <CACfndskPgu5yxSCYE+x0XTq3U+KzfmN4e=rqifA1_n6HQqdG6A@mail.gmail.com>
In-Reply-To: <CACfndskPgu5yxSCYE+x0XTq3U+KzfmN4e=rqifA1_n6HQqdG6A@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 8 Nov 2024 09:24:00 -0800
Message-ID: <CABPp-BECMyPS6TOfKprdRyfkJC1CbFzVm+xG0D4LNNU2E1Jtyg@mail.gmail.com>
Subject: Re: [QUESTION] Performance comparison: full clone + sparse-checkout
 vs partial clone + sparse-checkout
To: Manoraj K <mkenchugonde@atlassian.com>
Cc: git@vger.kernel.org, stolee@gmail.com, 
	Shubham Kanodia <skanodia@atlassian.com>, 
	Ajith Kuttickattu Sakharia <asakharia@atlassian.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 8:52=E2=80=AFPM Manoraj K <mkenchugonde@atlassian.co=
m> wrote:
>
> Bump
>
> On Mon, Oct 28, 2024 at 4:00=E2=80=AFPM Manoraj K <mkenchugonde@atlassian=
.com> wrote:
> >
> > Hi,
> >
> > We've conducted benchmarks comparing Git operations between a fully
> > cloned and partially cloned repository (both using sparse-checkout).
> > We'd like to understand the technical reasons behind the consistent
> > performance gains we're seeing in the partial clone setup.
> >
> > Benchmark Results:
> >
> > Full Clone + Sparse-checkout:
> > - .git size: 8.5G
> > - Git index size: 20MB
> > - Pack objects: 18,761,646
> > - Operations (mean =C2=B1 std dev):
> >   * git status: 0.634s =C2=B1 0.004s
> >   * git commit: 2.677s =C2=B1 0.019s
> >   * git checkout branch: 0.615s =C2=B1 0.005s
> >   * git pull (no changes): 5.983s =C2=B1 0.391s
> >
> > Partial Clone + Sparse-checkout:
> > - .git size: 2.0G
> > - Git index size: 20MB
> > - Pack objects: 13,560,436
> > - Operations (mean =C2=B1 std dev):
> >   * git status: 0.575s =C2=B1 0.012s (9.3% faster)
> >   * git commit: 2.164s =C2=B1 0.032s (19.2% faster)
> >   * git checkout branch: 0.724s =C2=B1 0.154s
> >   * git pull (no changes): 1.866s =C2=B1 0.018s (68.8% faster)
> >
> > Key Questions:
> > 1. What are the technical factors causing these performance
> > improvements in the partial clone setup?
> > 2. To be able to get these benefits, is there a way to convert our
> > existing fully cloned repository to behave like a partial clone
> > without re-cloning from scratch?
> >
> > Appreciate any insights here.
> >
> > Best regards,
> > Manoraj K

Taking some wild guesses:

`git pull` will both fetch updates for _all_ branches, as well as
merge (or rebase) the updates for the current branch.  Your "no
changes" probably means there's no merge/rebase needed, but that
doesn't mean there was nothing to fetch.  A partial clone isn't going
to download all the blobs, so it has much less to download and is thus
significantly faster.

`git checkout branch` would likely be slower in a partial clone
because sometimes objects are missing and need to be downloaded.  And
indeed, it shows as being a little slower for you.

`git status` is harder to guess at.  The only guess I can come up with
for this case is that fewer objects means faster lookup (I'm not
familiar with the packfile code, but  think object lookups use a
bisect to find the objects in question, and fewer objects to bisect
would make things faster if so); not sure if this could account for a
9% difference, though.  Maybe someone who understands packfiles,
object lookup, and promisor remotes has a better idea here?

I'm a bit surprised by the `git commit` case; how can it take so long
on your repo (2-3s)?  Do you have commit hooks in place?  If so, what
are they doing?  (And if you do, I suspect whatever they are doing is
responsible for the differences in timings between the partial clone
and the full clone, so you'd need to dig into them.)
