Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE3A7EF
	for <git@vger.kernel.org>; Sun, 28 Jan 2024 00:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706400496; cv=none; b=TvINxs+0v6m28QUtfBS3TCjMbnRq9gBjcgERmQ1/tyi3xv2HbDZnzanzgxKKPWPC8cA1HOoKq35FU9B/YhNnjmvPc7YA1j+qLu8/HsjLOGKjxdcK8wOz/Sz8TpGFK+ez1eDMTGCMhspdSQXPMOG5BOZTTw9eAiHoSysesbgonaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706400496; c=relaxed/simple;
	bh=WIujRr+2H/RQuioLqnsW3p5CYJZQFbu9rjnf19py/eM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LQWTH1r/MWCPheotSiQEJsaYOp0NMjDImfpvCb7j4Te+Basat09fs8ZwXEVfU9Q3EyfCTK1EIddssN6WdIeJ6Jl0/6QJmLkvVuujKdqBSIZI/TROg0YxelEvJys+aJyT2y3Tomrc77JUfuuEN4MSoqtHzSRpnLW49JEoUq77qPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1l/R/NF; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1l/R/NF"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5100cb238bcso2754790e87.3
        for <git@vger.kernel.org>; Sat, 27 Jan 2024 16:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706400493; x=1707005293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eBkGf/FFz5oy4qbkLkg4YYpKKZD3xBwBXm0S1oYHn3U=;
        b=T1l/R/NFvzrxd7XZhGJLOPlaps2bdSgAA+E5ymmAEPQZGUC959nZo7NXi95vEvVZJC
         rKewiu1Qf6kVGXR6Q2dgF3wU1Mx55XuxyJ15oLfYrxWDfpib+c/p1TWrilFCK+lgdNOW
         x4FUjQO3vw07rsYLIyWyvsJqK/kuVjMnpiTRk+fInepAoFtTC0CbNSd2Yot2fOsVzu/6
         JPqxshNZhCTYPUYPLFlsqX2CKPtMYJWFVVVVqI94c1/QRw5bkOGfVIkT+Qoa3ns4m46p
         02RVr8VHDhiWtNF0A6h64mzj2t7CWENgLDanJ0HCSZIpFNRGIB7gV7dBsqAHsJUQF9gV
         NspQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706400493; x=1707005293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eBkGf/FFz5oy4qbkLkg4YYpKKZD3xBwBXm0S1oYHn3U=;
        b=oY7U0HMuHrVaL6ekOlQxaT056N0Kdguo/dRc6NdwCTF31C+N3CqsjAcnL3k9yQYMqI
         wf7eJwC77kYWscskixj55fjpRL45/OQyPkEDakLemfmEukeDxXg4M1oNdO97w0JrmS3u
         2uf0i8nRWTTADID4870x2N4tvVnwipV7e2lcXyYRXOuH2j6HfyWCWjAlMHNopfWuqDjK
         gygHPAOl89V/AI5dnIh4WgI3Sqyb9NtN00gQ9cwHNSVliQVAuzS9wVKcIjONvh3afeh9
         M7Xn81RU/5eVZ3sCV+NToy3CnIqpkjmZlx/Y1tAeFvTmTtpvP6W/iJX3M0hcMLni69hT
         mt2g==
X-Gm-Message-State: AOJu0YyxzNPs0WsI7TefoiMCcnRtoI+6u60z4VRKr/zKfJMhj9Tj1FrM
	/sU7yLFNL4fa1TxbEbsr3nH0Bhsk2vdnweSYQ+616vob5w9zhBm21cYupaKvRpnG3b4uXoUGs5U
	cd7uyBjK7JvMoj/HmrgqGbkYnpfE=
X-Google-Smtp-Source: AGHT+IGDgXDsIYf0WeC4NxMEv19Qcn9nvlHv64H2fvA1+Jb6vJ48PYf0Z++LZiXBVoBVJ1k0jr+xug3DdKXMMQ2DZAM=
X-Received: by 2002:ac2:4bc9:0:b0:510:893:f8c3 with SMTP id
 o9-20020ac24bc9000000b005100893f8c3mr1878553lfq.20.1706400492643; Sat, 27 Jan
 2024 16:08:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
 <20240119060721.3734775-5-brianmlyles@gmail.com> <b897771e-c60e-4e41-bfae-3bcfdd832be1@gmail.com>
 <xmqq8r4gnd3c.fsf@gitster.g>
In-Reply-To: <xmqq8r4gnd3c.fsf@gitster.g>
From: Brian Lyles <brianmlyles@gmail.com>
Date: Sat, 27 Jan 2024 18:07:36 -0600
Message-ID: <CAHPHrScPSSCLC4FjUWoboOV_FX4c7huJSFsGWeYk+O21+AYE7w@mail.gmail.com>
Subject: Re: [PATCH 4/4] cherry-pick: Add `--empty` for more robust redundant
 commit handling
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org, me@ttaylorr.com, 
	newren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Junio

On Tue, Jan 23, 2024 at 12:01=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> > Thanks for the well explained commit message
>
> ;-)
>
> >> The `--keep-redundant-commits` option will be documented as a deprecat=
ed
> >> synonym of `--empty=3Dkeep`, and will be supported for backwards
> >> compatibility for the time being.
> >
> > I'm not sure if we need to deprecate it as in "it will be removed in
> > the future" or just reduce it prominence in favor of --empty
>
> True, especially since --empty=3Dkeep is much less descriptive and the
> part after "note that ..." below will take a long time before
> sticking in readers' brain.

I responded to this in my reply to Phillip, and CC'd you there.

> >> +--empty=3D(stop|drop|keep)::
> >> +    How to handle commits being cherry-picked that are redundant with
> >> +    changes already in the current history.
>
> It might make it easier to understand if we moved the description in
> 'keep' that says something about --allow-empty here, as it should
> apply to other two choices if I understand correctly.  Let me try:
>
>     This option specifies how a commit that is not originally empty
>     but becomes a no-op when cherry-picked due to earlier changes
>     already applied or already in the current history.  Regardless
>     of this this option, `cherry-pick` will fail on a commit that is
>     empty in the original history---see `--allow-empty` to pass them
>     intact.
>
> or something.  Then the description of `keep` can become just as
> short as other two, e.g. a single sentence "The commit that becomes
> empty will be kept".

Thank you for this suggestion. You are correct that the difference
between `--empty` and `allow-empty` is relevant regardless of the option
selected by the user.

In fact, this entire tidbit is somewhat duplicative with the note I
already added after the options:

> Note that commits which start empty will cause the cherry-pick to fail
> (unless `--allow-empty` is specified).

I'll clean this up in v2. Here's what I am thinking currently:

> --empty=3D(stop|drop|keep)::
>     How to handle commits being cherry-picked that are redundant with
>     changes already in the current history.
> +
> --
> `stop`;;
>     The cherry-pick will stop when the commit is applied, allowing
>     you to examine the commit. This is the default behavior.
> `drop`;;
>     The commit will be dropped.
> `keep`;;
>     The commit will be kept.
> --
> +
> Note that this option species how to handle a commit that was not initial=
ly
> empty, but rather became empty due to a previous commit. Commits that wer=
e
> initially empty will cause the cherry-pick to fail. To force the inclusio=
n of
> those commits, use `--allow-empty`.
> +

Thank you,
Brian Lyles
