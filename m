Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16A323759
	for <git@vger.kernel.org>; Sat, 27 Jan 2024 23:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706399832; cv=none; b=ZskZEwNgoBMZLdE7hT7v2mFUY/Wtq7130h2t5Z2f97sRPgbosOjuU6q3ia98C6042jR1hwn49UefM4cJglzpizuB/JdZBTAEuuKFsLxSZsRyRKvZ32W3YJ9W4EnwEIIoJl4jzHyZ+1+9raoPhzENC77h0ktdK/PcccKGurJm6ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706399832; c=relaxed/simple;
	bh=Z+b16mc9QN/CjFCTigEyPnVv3c6hkghCR80wKnNL+9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OzQTv5eJgsScUh57vhHUTxIhpmp/BnY6pPk+z2QdxzoSAseJvYlDml5e0sDp4bUOQNIyTCIfhm/7NpR/mbX4A0WEtXL+cB5XZO2A381Rt+9d3T+bdhn6hgzLn7dfXn1z7y6iUejCRI0hoXjPKbtWQu9bNSFJ6ryOOZzh6pKkLeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FDIax0Qb; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDIax0Qb"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-510133ed214so2392194e87.1
        for <git@vger.kernel.org>; Sat, 27 Jan 2024 15:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706399829; x=1707004629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84yGq5mEkPZaubACDTjWQ/BEDqq1+ijWQfCABjeWqGI=;
        b=FDIax0QbJccwrWuJiNpfLT/hq5oRPy9Dm4BwDzSWwfPu8YL055TTk6+vlLl61HFH7n
         8sktbPbOAH9dOpqsTtIaszh1YuvfaSA5JSSFUC5dbyTE9rNkd4bPgIhlIpqGLgoNGfDV
         1twImSj1uEsniUoP1a6H6ijN7bLz+PoR3jv7JmLPzk9f9ZMoE+0pgYQFJK5HYF7bwZ/3
         pTgf7eR7/feiuyH6Ctqd4c0ferMWd6txl4qzvz0B86GzXJL+hs01bwTMfjHD247rfK/j
         yDPo/2R77UHt6nYiQWY29USdbLOH7iTD2IUQcitSQ2EjSiTiKFscAZrAgicAy7bgVMUv
         KMZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706399829; x=1707004629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=84yGq5mEkPZaubACDTjWQ/BEDqq1+ijWQfCABjeWqGI=;
        b=JOvkw4ky2gE5J/YsFJdMgmeiJNAxMv1o44hmwaMYbxMN7HRyUzIgLDcq/fo8TdswuI
         9F9v4ThlhyzCdcG1UoMPwGLINQtp76xMPEG9yh4xqHLkIgAzwePenG93U1SxhiN896TV
         fFsezaxNQhrRWtMIL01TjLDfbctjHJNxYW2X+7jzBPWLHl2N0KYY2JmVvDMjbIFAsmMl
         DZEdkZDhMwexe8cs5HsfSZdpRrQC8FWiqhhtAi6Ii4CFjHhAyS6p1mPu6W1jzKmbyorB
         w4bcfs1JUVYcj3K6al2QKfq6ffG/RYLv3+MPfvyk1EiwyaLX6j/t+2F25ePC/O4yDrFQ
         W/ZA==
X-Gm-Message-State: AOJu0YwqTgkGpng+6EbVBsiOmPNx/5XLKusHrwg/u2bV6tozkIExrqUe
	+6x1FdFviYhoJqT8tEWw5ewrFcQuv6zZFhJ9cxgqRIs3nLPQ4Ar296rI4U0Fn0O3178kfIj8aRw
	cWoKcwtPUoOYdDzFBIg9Ai+5KrEU=
X-Google-Smtp-Source: AGHT+IGTEnhdIKiGKw5wDmZE2f0Qbtguy+x/TVsrqlEhLytqwLjzMqVYkKehRaynmsSI8G6pUN0rlXQUlK35lI9iGk4=
X-Received: by 2002:a05:6512:ea6:b0:50f:de3:d042 with SMTP id
 bi38-20020a0565120ea600b0050f0de3d042mr1467521lfb.19.1706399828541; Sat, 27
 Jan 2024 15:57:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
 <20240119060721.3734775-5-brianmlyles@gmail.com> <b897771e-c60e-4e41-bfae-3bcfdd832be1@gmail.com>
In-Reply-To: <b897771e-c60e-4e41-bfae-3bcfdd832be1@gmail.com>
From: Brian Lyles <brianmlyles@gmail.com>
Date: Sat, 27 Jan 2024 17:56:31 -0600
Message-ID: <CAHPHrSf+joHe6ikErHLgWrk-_qjSROS-dXCHagxWGDAF=2deDg@mail.gmail.com>
Subject: Re: [PATCH 4/4] cherry-pick: Add `--empty` for more robust redundant
 commit handling
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[+cc Junio]

On Tue, Jan 23, 2024 at 8:25=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> Hi Brian
>
>
> On 19/01/2024 05:59, brianmlyles@gmail.com wrote:
>
> > The `--keep-redundant-commits` option will be documented as a deprecate=
d
> > synonym of `--empty=3Dkeep`, and will be supported for backwards
> > compatibility for the time being.
>
> I'm not sure if we need to deprecate it as in "it will be removed in the
> future" or just reduce it prominence in favor of --empty

This is also related to Junio's comment:

> On Tue, Jan 23, 2024 at 12:01=E2=80=AFPM Junio C Hamano <gitster@pobox.co=
m>
wrote:
>
> True, especially since --empty=3Dkeep is much less descriptive and the
> part after "note that ..." below will take a long time before
> sticking in readers' brain.

My primary motivation here was simply for consistency with `--empty` for
both git-rebase(1) and git-am(1). In theory, I am not opposed to
updating this patch to instead simply add a `--drop-redundant-commits`
option if we feel that provides better usability. However, I think that
the consistency would be better.

I will happily defer to the group consensus here, with the options I see
being:

1. No deprecation: just make `--keep-redundant-commits` a synonym of
  `--empty=3Dkeep`
2. Soft deprecation: Give a warning when `--keep-redundant-commits` is
  used
3. Add `--drop-redundant-commits` instead of `--empty`

My preference would be 2, followed by 1 and then 3.

> I'm still on the fence about "stop" vs "ask". I see in your tests you've
> accidentally used "ask" which makes me wonder if that is the more
> familiar term for users who probably use "git rebase" more often than
> "git am".

Oh, thank you for catching that. The cause here was actually because I
had initially written these tests prior to adding the "ask -> stop"
change rather than familiarity. I simply failed to update the tests
after moving things around.

> The code changes look good but I think we want to update
> verify_opt_compatible() to check for "--empty" being combined with
> "--continue" etc. as well.

It looks like `--keep-redundant-commits` was not being included in these
checks previously. I suspect that to be an oversight though.

I can add this for v2.

>
> >       if (cleanup_arg) {
> >               opts->default_msg_cleanup =3D get_cleanup_mode(cleanup_ar=
g, 1);
> >               opts->explicit_cleanup =3D 1;
> > diff --git a/sequencer.c b/sequencer.c
> > index 582bde8d46..c49c27c795 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -2934,6 +2934,9 @@ static int populate_opts_cb(const char *key, cons=
t char *value,
> >       else if (!strcmp(key, "options.allow-empty-message"))
> >               opts->allow_empty_message =3D
> >                       git_config_bool_or_int(key, value, ctx->kvi, &err=
or_flag);
> > +     else if (!strcmp(key, "options.drop-redundant-commits"))
> > +             opts->drop_redundant_commits =3D
> > +                     git_config_bool_or_int(key, value, ctx->kvi, &err=
or_flag);
> >       else if (!strcmp(key, "options.keep-redundant-commits"))
> >               opts->keep_redundant_commits =3D
> >                       git_config_bool_or_int(key, value, ctx->kvi, &err=
or_flag);
> > @@ -3478,6 +3481,9 @@ static int save_opts(struct replay_opts *opts)
> >       if (opts->allow_empty_message)
> >               res |=3D git_config_set_in_file_gently(opts_file,
> >                               "options.allow-empty-message", "true");
> > +     if (opts->drop_redundant_commits)
> > +             res |=3D git_config_set_in_file_gently(opts_file,
> > +                             "options.drop-redundant-commits", "true")=
;
>
> It is good that we're saving the option - it would be good to add a test
> to check that we remember --empty after stopping for a conflict resolutio=
n.

I can add a test for this in v2

> >       if (opts->keep_redundant_commits)
> >               res |=3D git_config_set_in_file_gently(opts_file,
> >                               "options.keep-redundant-commits", "true")=
;
> > diff --git a/t/t3505-cherry-pick-empty.sh b/t/t3505-cherry-pick-empty.s=
h
> > index 6adfd25351..ae0cf7886a 100755
> > --- a/t/t3505-cherry-pick-empty.sh
> > +++ b/t/t3505-cherry-pick-empty.sh
> > @@ -89,7 +89,7 @@ test_expect_success 'cherry-pick a commit that become=
s no-op (prep)' '
> >       git commit -m "add file2 on the side"
> >   '
> >
> > -test_expect_success 'cherry-pick a no-op without --keep-redundant' '
> > +test_expect_success 'cherry-pick a no-op with neither --keep-redundant=
 nor --empty' '
> >       git reset --hard &&
> >       git checkout fork^0 &&
> >       test_must_fail git cherry-pick main
> > @@ -104,4 +104,28 @@ test_expect_success 'cherry-pick a no-op with --ke=
ep-redundant' '
> >       test_cmp expect actual
> >   '
> >
> > +test_expect_success 'cherry-pick a no-op with --empty=3Dask' '
> > +     git reset --hard &&
> > +     git checkout fork^0 &&
> > +     test_must_fail git cherry-pick --empty=3Dask main
>
> This is an example of why it is a good idea to check the error message
> when using "test_must_fail" as here the test will fail due to a bad
> value passed to "--empty" rather than for the reason we want the test to
> check. It would be good to add a separate test to check that we reject
> invalid "--empty" values.

An excellent catch, thank you. Will be addressed in v2

> > +'
> > +
> > +test_expect_success 'cherry-pick a no-op with --empty=3Ddrop' '
> > +     git reset --hard &&
> > +     git checkout fork^0 &&
> > +     git cherry-pick --empty=3Ddrop main &&
> > +     git show -s --format=3D%s >actual &&
> > +     echo "add file2 on the side" >expect &&
> > +     test_cmp expect actual
>
> I think you could simplify this by using test_commit_message

Thanks for pointing that function out -- you're absolutely right. Will
be addressed in v2.


Thanks for the review,
Brian Lyles
