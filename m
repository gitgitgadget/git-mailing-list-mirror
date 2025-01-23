Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D351B85626
	for <git@vger.kernel.org>; Thu, 23 Jan 2025 03:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737603770; cv=none; b=ARKnpFgbMfwpmaiu79LfyOVwPRInsGsL0MqmfDu46ynsFGsufNmtoNeJ587bITNehhk2ZskRhKREiP3zisKno0+ArENP1W74YDLldYxeIuBC2ZYiJLxzYzHvEg/yRPfdJDMtu0avQIAR0wFW0ug31WFV+9imAQ42b4W64IBYU6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737603770; c=relaxed/simple;
	bh=HPTdIBDFGBqVjrW3CXAKPTVh4+8nPoU+5J+C7gR5H4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jzta+JKIlwpLV35Pxy1Hc9HP8S46anw0x8y0k0UBaeu9sMIEMF4tQqDTLsODmCNFwxex/HnWdQkJAOTa17Fr6QkQMQgdXayZDpixphSFJj9qwbUmzx+ZI3dTIP8H+jImt6+VflHTV7VoVESTfZH7wS0/C4jXI52wsmYQxVCABac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yr188tiG; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yr188tiG"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d3d143376dso676909a12.3
        for <git@vger.kernel.org>; Wed, 22 Jan 2025 19:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737603767; x=1738208567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXjOYxh93ik03shqt+Vy8SQzqqnr9daOrKwjwk4Qngg=;
        b=Yr188tiGmPE69YBPVLNu7EmgdmzB3GWF0lsSKzb0jfT++b6uM1LoC9dInNaF/GqeSI
         TQhlbqBGWWSU6M0bZIQW0StJkC3USdXdbR7g2CDjLTpGzH2KwlDPi8hs9dwW73kAjhsP
         TTflzc/k9PfX/zvJW652RGvAt+UGp2oCOY3Z0cwe/3rFL8m5ZcbXbP9yqO8YX0smzGR3
         to/KAtLsDQXsWUw38s47A2r4xPAiInhNLF22Xh7vlrXcDJ8sQoN3CGG2HuZw1vcbpotR
         U3zmAl3cbf3LBp4s0koC7LJSvQLSqw5YLIk16iv4fKyX3lTam8tpW4ummZ9FZlSxPZpG
         hNug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737603767; x=1738208567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SXjOYxh93ik03shqt+Vy8SQzqqnr9daOrKwjwk4Qngg=;
        b=LULkUb6WCBb8juBqNo6xcKoqkDZ9mJApvcediLPqft8WoyUUbOx81qe1b0lDmUqJ++
         fb59M97uloAe1IWR4M+SRx14GezdjRQe8idf5o6fLOUqY9mpRa+ZHopVCbwj1CDcq09W
         uDvS26elLiOxwNtRgGeJDjZnsH0a6Lrcz/EYgD31lEh1lvYcvT6NVSfEYhWVvkiMLfds
         PIJtDB4bwCoPhBivAXZBj9CtteWdO3YCEhqL/TABB8uSZ4f+/K2fXIgFD12uEAYPrHTJ
         gOgSB8Q+EWbMLCtUVSfhm8rRTagXGvMvPrN3f1r8MO6Rv/3DljZjywRwhTmw99Yp8/i7
         BZvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkWDv7uSSj2cJKFXMc/guxjKMlxyZwbTWLbufJBBabny3TPuiMd2sp4ZDDPTy1Atx4Eyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTzS459yFUoq3HZ+ppq34dcR137z6o78IYBLJv0tH6OUd1Y5Tj
	la+3c/O27zwgNc3DEip1g31ZqLVSV+uaS79+dj0TgyfM+CoF+Ca7SCW6TBDz5LIVV9PiWUu4ckB
	G+JQhceGqdDR1BI7xTgP3TgsEM54=
X-Gm-Gg: ASbGncv7f51KdqwHauUmMMLlfpM02Znfx3J5OjqZCQF4ZPZ0TaYdD9vr9Ur5i+bLgsK
	Y+rMV/roTTSegYuq9Vd35Brck32dcZ7qZLGKBSbZZeCWoTIDZLgm9jG0Ba8ktmg==
X-Google-Smtp-Source: AGHT+IFYxZx9cGcS8u4VjBPEmKCiGbDh0W5p0hYBNgG7telommSjyhpd/Qw1BsbTfKRw7W6+Wl1Ao3Cq5LHHg27M/Ts=
X-Received: by 2002:a05:6402:2110:b0:5d3:ba42:ea03 with SMTP id
 4fb4d7f45d1cf-5db7d2f8135mr17315304a12.8.1737603766755; Wed, 22 Jan 2025
 19:42:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1843.v2.git.1735611513.gitgitgadget@gmail.com>
 <pull.1843.v3.git.1736994932003.gitgitgadget@gmail.com> <xmqqzfjqr526.fsf@gitster.g>
In-Reply-To: <xmqqzfjqr526.fsf@gitster.g>
From: ZheNing Hu <adlternative@gmail.com>
Date: Thu, 23 Jan 2025 11:42:35 +0800
X-Gm-Features: AWEUYZmQHUiPWXeRNla7HkX4yqvFAXTXl-X1uPlO7c0CVkFxTdvyZKH29AAUkEE
Message-ID: <CAOLTT8RFqseTSMFXjw--d2BBVAb=7x_mrOaJr4VHcio99H2rMg@mail.gmail.com>
Subject: Re: [PATCH v3] gc: add `--expire-to` option
To: Junio C Hamano <gitster@pobox.com>
Cc: ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, me@ttaylorr.com, 
	peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2025=E5=B9=B41=E6=9C=8817=E6=97=
=A5=E5=91=A8=E4=BA=94 02:23=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > This commit extends the functionality of `git gc`
> > by adding a new option, `--expire-to=3D<dir>`. Previously,
> > this feature was implemented in `git repack` (see 91badeb),
> > allowing users to specify a directory where unreachable and
> > expired cruft packs are stored during garbage collection.
> > However, users had to run `git repack --cruft --expire-to=3D<dir>`
> > followed by `git prune` to achieve similar results within `git gc`.
> >
> > By introducing `--expire-to=3D<dir>` directly into `git gc`,
> > we simplify the process for users who wish to manage their
> > repository's cleanup more efficiently. This change involves
> > passing the `--expire-to=3D<dir>` parameter through to `git repack`,
> > making it easier for users to set up a backup location for cruft
> > packs that will be pruned.
>
> Today I do not have enough time to do my usual commit log message
> critique.  Please use "git show -s --format=3Dreference" when
> referring to an earlier commit.
>

Okay, I will change to using this format.

> > Note: When git-gc is used with both `--cruft` and `--expire-to`,
> > it does not pass `-a` to git-repack to delete all unreachable
> > objects as `git gc --prune=3Dnow` originally did. Instead, it
> > generates a cruft pack in the directory specified by expire-to.
>
> Is this less important than "we added --expire-to to gc that is
> passed down to underlying repack" in the previous paragraph?
>

I had thought that adding --expire-to to gc was key in this patch,
but the change to the implementation of --prune=3Dnow should
indeed be mentioned more.

> Not removing the unreachables too early with "repack -a" is an
> essential part of the design of this new feature to allow us not to
> lose the cruft objects, so I was a bit surprised that this was
> described as a "Note:".
>

You're right. This section shouldn't use a note; it should provide
a more detailed explanation instead.

> > diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
> > index 370e22faaeb..b4c0cf02972 100644
> > --- a/Documentation/git-gc.txt
> > +++ b/Documentation/git-gc.txt
> > @@ -69,6 +69,12 @@ be performed as well.
> >       the `--max-cruft-size` option of linkgit:git-repack[1] for
> >       more.
> >
> > +--expire-to=3D<dir>::
> > +     When packing unreachable objects into a cruft pack, write a cruft
> > +     pack containing pruned objects (if any) to the directory `<dir>`.
> > +     See the `--expire-to` option of linkgit:git-repack[1] for
> > +     more.
>
> Does "When packing unreachable objects into a cruft pack" mean that
> this option is only meaningful with "--cruft"?  As "--cruft" is on
> by default, is it an error to pass "--no-cruft" when you use this
> option?
>

It (--expired-to) can currently only be used together with --cruft.
Using --no-cruft together with --expire-to will not result in an error,
but --expired-to will not take effect either.

I should mention in the document that --expire-to and --cruft
need to be used together, otherwise --expire-to will not
have any effect.

> "for more" -> "for more information" or something?
>

OK,  "for more information".

> > diff --git a/builtin/gc.c b/builtin/gc.c
> > index d52735354c9..8656e1caff0 100644
> > --- a/builtin/gc.c
> > +++ b/builtin/gc.c
> > @@ -136,6 +136,7 @@ struct gc_config {
> >       char *prune_worktrees_expire;
> >       char *repack_filter;
> >       char *repack_filter_to;
> > +     char *repack_expire_to;
> >       unsigned long big_pack_threshold;
> >       unsigned long max_delta_cache_size;
> >  };
> > @@ -432,7 +433,8 @@ static int keep_one_pack(struct string_list_item *i=
tem, void *data UNUSED)
> >  static void add_repack_all_option(struct gc_config *cfg,
> >                                 struct string_list *keep_pack)
> >  {
> > -     if (cfg->prune_expire && !strcmp(cfg->prune_expire, "now"))
> > +     if (cfg->prune_expire && !strcmp(cfg->prune_expire, "now")
> > +             && !(cfg->cruft_packs && cfg->repack_expire_to))
> >               strvec_push(&repack, "-a");
>
> Hmph.  When "--expire-to=3D<there>" is given, we are dropping these
> unreachable objects right away, but we said "--no-cruft", then we
> say "repack -a".  If we have both "--cruft" and "--expire-to=3D<there>",
> then ...
>
> >       else if (cfg->cruft_packs) {
> >               strvec_push(&repack, "--cruft");
> > @@ -441,6 +443,8 @@ static void add_repack_all_option(struct gc_config =
*cfg,
> >               if (cfg->max_cruft_size)
> >                       strvec_pushf(&repack, "--max-cruft-size=3D%lu",
> >                                    cfg->max_cruft_size);
> > +             if (cfg->repack_expire_to)
> > +                     strvec_pushf(&repack, "--expire-to=3D%s", cfg->re=
pack_expire_to);
>
> ... we do the usual "repack --cruft --expire-to=3D<there>" in the next
> block.
>
> > @@ -675,7 +679,6 @@ struct repository *repo UNUSED)
> >       const char *prune_expire_sentinel =3D "sentinel";
> >       const char *prune_expire_arg =3D prune_expire_sentinel;
> >       int ret;
> > -
> >       struct option builtin_gc_options[] =3D {
> >               OPT__QUIET(&quiet, N_("suppress progress reporting")),
> >               { OPTION_STRING, 0, "prune", &prune_expire_arg, N_("date"=
),
>
> OK.
>
> > @@ -694,6 +697,8 @@ struct repository *repo UNUSED)
> >                          PARSE_OPT_NOCOMPLETE),
> >               OPT_BOOL(0, "keep-largest-pack", &keep_largest_pack,
> >                        N_("repack all other packs except the largest pa=
ck")),
> > +             OPT_STRING(0, "expire-to", &cfg.repack_expire_to, N_("dir=
"),
> > +                        N_("pack prefix to store a pack containing pru=
ned objects")),
> >               OPT_END()
> >       };
>
> OK.
>
> > diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
> > index ee074b99b70..d4b0653a9b7 100755
> > --- a/t/t6500-gc.sh
> > +++ b/t/t6500-gc.sh
> > @@ -339,6 +339,12 @@ test_expect_success 'gc.maxCruftSize sets appropri=
ate repack options' '
> >       test_subcommand $cruft_max_size_opts --max-cruft-size=3D3145728 <=
trace2.txt
> >  '
> >
> > +test_expect_success '--expire-to sets appropriate repack options' '
> > +     mkdir expired &&
> > +     GIT_TRACE2_EVENT=3D$(pwd)/trace2.txt git -C cruft--max-size gc --=
cruft --expire-to=3D./expired/pack &&
> > +     test_subcommand $cruft_max_size_opts --expire-to=3D./expired/pack=
 <trace2.txt
> > +'
>
> As "--cruft" is on by default, the command line does not have to
> have it, but being explicit is good.
>
> Should we also see what happens when "--no-cruft" is given?
>

 --expire-to with --no-cruft  will still run repack -a, I will add
corresponding tests.

> Thanks.

Thanks.
