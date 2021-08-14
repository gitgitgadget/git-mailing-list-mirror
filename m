Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B263AC4338F
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 01:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81E656109D
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 01:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236308AbhHNBnP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 21:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbhHNBnN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 21:43:13 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA720C061756
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 18:42:45 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id k24so7411054vsg.9
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 18:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Vx5kNakLK8mCKkdYLTluz4KTMhhj24pyJnCjQHyzpg8=;
        b=tMe5Da68FJFixAlKXNKdz/nwHEovAr2TzsAdNbZ4Ul6qEb3F3kX1LB2ct0IXXtER0s
         kvlE9AmTCj0z2QH8ppj+9vzF8yp5j1HUcY/j7PySZGQ9ByA0JdcvXffg8wOrvONweMG1
         2BFUeyG1MwElUpieUcg+sw3E5eJzmzn2FnZz5n0FLBH5gB31JkyiAf1j5PgkWKDevXol
         +1/59t2h5cxNbfu5+9JWgMCThhyFGBW6eqVkXOHPKN2twiTpvz9rLWIxVCkkPh+J6y1F
         N59qbQjWxvNbia6F70XlUZerxDpaVYbyA0oCL1S31p8ceUmWngfLVFUbFKuxU4rygIYg
         fxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Vx5kNakLK8mCKkdYLTluz4KTMhhj24pyJnCjQHyzpg8=;
        b=TcelscPVZB0787dukEM+aTKyufpi3Trce14N7LAAuuc+Mb3YfOc5ohEx/ODbtAyIdQ
         KIw3xroXBKA2zInQcn0T0Gbn+dgYLjdzafehnvkBim7gQJQkRbXKoSGCRTaUTpUOZKzi
         HXJ43SxC41vIYL/ebLTld9aLmDmrWCWIBjAXV1H+FJC8kqZDaVXo/yhem1Km7KZlX9rz
         roPjfMAHRXDC010CRvh8sC8Uj9I1dJPCxZeN2c8K81fa+EdteQXSFMvZyuE+wzw0HH1a
         3oJgJvvW2rQYNiuJEd0uDk1ChlGpvX/Dpq2hy5ijhrEeRHtsvzM50AqaLN9T1VjDaJ3r
         c5Ag==
X-Gm-Message-State: AOAM530/Aw7BOu//TF3O4D6Lj5no+SePAD1NEGLgxyx7RrOpK/y5lks5
        UEGyc2D947ccgWTltKyIUUXZBI2qu5vlFD2UA2I=
X-Google-Smtp-Source: ABdhPJyFMfbbQeZ0mFQDO4MdQEyML4gi+P7H2IV9BbmKU94UnfTaQ40zfOl94ICufcy02PrTu6BH8YCkHhHVQWW3zkg=
X-Received: by 2002:a67:fa0b:: with SMTP id i11mr4603120vsq.44.1628905364791;
 Fri, 13 Aug 2021 18:42:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210812202200.82465-1-carenas@gmail.com> <20210813093909.GA3866771@szeder.dev>
In-Reply-To: <20210813093909.GA3866771@szeder.dev>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Fri, 13 Aug 2021 18:42:34 -0700
Message-ID: <CAPUEspjW3jSUwnz39bWBCmNS8mo_Cfjk7NPA5BXpQvPoypUEMg@mail.gmail.com>
Subject: Re: [PATCH] ci: update freebsd 12 cirrus job
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, emaste@freebsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 13, 2021 at 2:39 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
>
> On Thu, Aug 12, 2021 at 01:22:00PM -0700, Carlo Marcelo Arenas Bel=C3=B3n=
 wrote:
> > diff --git a/.cirrus.yml b/.cirrus.yml
> > index c2f5fe385a..e114ffee1a 100644
> > --- a/.cirrus.yml
> > +++ b/.cirrus.yml
> > @@ -2,8 +2,15 @@ env:
> >    CIRRUS_CLONE_DEPTH: 1
> >
> >  freebsd_12_task:
> > +  env:
> > +    GIT_PROVE_OPTS: "--timer --jobs 10"
>
> Why these prove options?

that line came from the Github Actions part of ci/lib.sh.

--jobs is the one I was going after, but kept --timer for consistency.

> On other CI systems we pass 'prove' the option
> '--state=3Dfailed,slow,save' as well to reduce runtime.  However, this
> only works when there is a persistent place for prove's state files,
> e.g. the cache feature of Travis CI.

note that when GitHub Actions was added[1], it was explicitly excluded
because it wasn't really that effective

> If Cirrus CI lacks a similar
> feature, then we can't benefit from this option, but it'd be worth
> mentioning in the commit message.

They do have the option and will likely be a small change that I could
send as a follow up, but wasn't included in this change since it was
"controversial" as pointed above.

note also that the other uses of it aren't really being exercised,
since AFAIK neither azure or travis are running now, and indeed last
time I tried to run CI in my own account it didn't end up well, with
no successful run and running out of credit before I could even
attempt to fix them all.

indeed, was even going to suggest (after release) that they are
removed, which will also make the code cleaner for integrating cirrus
(which still has a usable opensource plan).

> > +    GIT_TEST_OPTS: "--no-chain-lint --no-bin-wrappers"
> Why these test options?

again lifted from the "GitHub Actions" code just for consistency and
to avoid breaking if either of those are broken (considering the only
other running CI does test with those unconditionally), but I realize
now that I might have been too conservative since my focus with this
commit was "speed and accuracy".

> chain-linting is done by a mighty sed script; I think it's worth
> running it with FreeBSD's 'sed' as well.

indeed, even if I recall correctly it was Solaris sed the one that
broke, and I would expect anyone breaking this chainlinting will
notice very quickly on their local run.

> Quoting 't/README', '--no-bin-wrappers' "can speed up test runs
> especially on platforms where running shell scripts is expensive".  Is
> running shell scripts really that expensive on FreeBSD?

no, I am assuming they were added with Windows in mind, but note that
as configure they also affect all the linux builds through GitHub
Actions.
Both these flags might be worth adding back for all non Windows
systems, but doing so will be easier when using the "ci" scripts for
all environments and after it has been discussed IMHO.

> OTOH, why are there no options that would show us some information
> about test failures, i.e. why no '--verbose-log -x --immediate' like
> on other CI systems?

I wasn't the original author, so can't answer why it wasn't done; but
I sure think the next step will be to add support for it to the ci/
scripts and with that make it more consistent, which likely will
include that change.

This patch was just the minimal change to make sure that it runs
efficiently and is representative of current users.

Carlo

[1] https://lore.kernel.org/git/40fe4f7e2c34c6997a6824ef0dc6aad7a71a4434.15=
86538752.git.congdanhqx@gmail.com/
