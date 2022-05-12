Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278FCC433EF
	for <git@archiver.kernel.org>; Thu, 12 May 2022 13:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354575AbiELN4v (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 09:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354779AbiELN4r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 09:56:47 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B2C1C345D
        for <git@vger.kernel.org>; Thu, 12 May 2022 06:56:35 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id ay15so2021854uab.9
        for <git@vger.kernel.org>; Thu, 12 May 2022 06:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XkKoQKvpwpDbGNS24ls4afBz2CZDyvK+JwMcUDJ7a7U=;
        b=fmuYqy05QXMAH6B98fEVygQfhGqHEjsIQpkAzWHkyAySFOuZNqLQa1d9tkxBJ6nSUb
         6Crs+6bdZV/iEMqBBqiXmVjKBdEJN7qxt6ODVYas5RCoAdhzKVMuzjQWznZZ9zeBVhLe
         pbgxkiqQp9rlsyi304Nd7TBg900GE6NX0X8Kctha7FqzId5xUzuUg/Xq7kr9zkX0QNHi
         ah9fHw6BjkSWRdFJM1Brqat0f3coMqC8zmgO2oM7vcY946+jyeLsscZWWOHarsRcWEG2
         yCHdliLZCWWZfEPGrPKUY12lnYV/v6C1YcQbd5+JrGKtyxsqkoxCzI6U0kPV3YSjaULI
         DdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XkKoQKvpwpDbGNS24ls4afBz2CZDyvK+JwMcUDJ7a7U=;
        b=F5yShLneZXXHtGJPLY3bOZVF17V/EbmSV4YHlwRZTQt/PSeeH6fg7Mh1bQYXJNbizQ
         zC7gyT4ZQzTB8DB0ZZU54B697eb07nvRgEP7eOwuqIvpp+oAm4onQy1oXu8gO9owv11K
         K4e2nAjywXczW9vWA6lRllgBXjyLXgsKsuGHoyFyg5EK8C8gPfJL/VG4l1OECQVe6sX7
         Vc36/0zyybGNDe9J6opt2xezfFD6SCmB9yK9EMXRj5db2/9+1EkX4aQmlODGdivokDaw
         e/b4YV7gss9T4MS0Bz/k5dMG2L6j1CjZkLH0tEr+16qh5GhZ1JQsQn0Srr5fgmD+IbIn
         tSkw==
X-Gm-Message-State: AOAM530G1zjkDQeun0G7zvQRyKykijrIDDZRprDnL9paCdo6sLLWip0f
        5FzwsJqNudZ/Ooih6GKCP1OEuoTv9qH+iDqePqg=
X-Google-Smtp-Source: ABdhPJxyQE7B3JNHm3ra81nePiP961GCsB17PFr5gL8Zenv1KzyBz+odmYzXqCOoGiwjLJZ94MeGEZRe5MLh0hF3dI4=
X-Received: by 2002:a9f:3084:0:b0:360:1fa1:6aca with SMTP id
 j4-20020a9f3084000000b003601fa16acamr49661uab.57.1652363794902; Thu, 12 May
 2022 06:56:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220504104601.136403-1-chriscool@tuxfamily.org>
 <20220509153834.485871-1-chriscool@tuxfamily.org> <CAPUEsphA=q10wCsrf3AxR9fXz9HQHt374tDFoWBu++EPNDA-LA@mail.gmail.com>
 <Yn0FPkoUNacvctAp@ncase>
In-Reply-To: <Yn0FPkoUNacvctAp@ncase>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Thu, 12 May 2022 06:56:24 -0700
Message-ID: <CAPUEsphh_3oFkfAdB-mZ9ZH7F0tCm_iwapy8=6VFE45yWoOK3w@mail.gmail.com>
Subject: Re: [PATCH v3] http: add custom hostname to IP address resolutions
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On thu, May 12, 2022 at 6:01 AM Patrick Steinhardt <ps@pks.im> wrote:
> On Tue, May 10, 2022 at 11:20:41AM -0700, Carlo Arenas wrote:
> > On Mon, May 9, 2022 at 8:38 AM Christian Couder
> > <christian.couder@gmail.com> wrote:
> > > diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
> > > index f92c79c132..4a8dbb7eee 100755
> > > --- a/t/t5551-http-fetch-smart.sh
> > > +++ b/t/t5551-http-fetch-smart.sh
> > > @@ -567,4 +567,11 @@ test_expect_success 'client falls back from v2 to v0 to match server' '
> > >         grep symref=HEAD:refs/heads/ trace
> > >  '
> > >
> > > +test_expect_success 'passing hostname resolution information works' '
> > > +       BOGUS_HOST=gitbogusexamplehost.com &&
> > > +       BOGUS_HTTPD_URL=$HTTPD_PROTO://$BOGUS_HOST:$LIB_HTTPD_PORT &&
> > > +       test_must_fail git ls-remote "$BOGUS_HTTPD_URL/smart/repo.git" >/dev/null &&
> > > +       git -c "http.curloptResolve=$BOGUS_HOST:$LIB_HTTPD_PORT:127.0.0.1" ls-remote "$BOGUS_HTTPD_URL/smart/repo.git" >/dev/null
> > > +'
> >
> > Is setting it up as a command line config option the way you expect to
> > use this, and if so why not make it a full blown command line option
> > with the previous caveats that were discussed before?
>
> If you did this as a command-line option, you'd now be forced to add it
> to every single command you want to support this: git-fetch, git-pull,
> git-remote, git-ls-remote and maybe others I forgot about. On the other
> hand, by having this as a configuration variable in `http.c` all of
> those commands benefit the same.

There are ways to add common options to all commands that would help
here, but as Junio pointed out it is not ideal because then you have
to ALSO provide implementations, which you don't seem interested in
doing.

> Furthermore, using a config option is a lot more flexible: you can
> persist it at different levels of your gitconfig, can easily inject it
> in a script via the use of environment variables, or directly override
> it when spawning a command with `-c`.
>
> Overall, I think it is preferable to keep this as an option as opposed
> to adding such an obscure parameter to all of the commands.

I think we had already decided that a config is more flexible, even if
I personally don't agree.

> > I also think it might be a little confusing (and probably warranted of
> > an advice message) if git will decide based on a configuration
> > somewhere in its resolution tree that the IP I am connecting is
> > different than the one I expect it to use through the system
> > configured resolution mechanism for such a thing.
>
> That's true already though, isn't it? A user may set `url.*.insteadOf`
> and be surprised at a later point that their URLs are getting redirected
> somewhere else. And there's probably a lot more examples where a user
> may be confused when forgetting about certain configuration variables
> that change the way Git behaves.

That is a good point, but unlike url.*.insteadOf, this is meant to be
an obscure setting that shouldn't be enabled by default (or under
common circumstances), so having the advice there is helpful for when
we find ourselves in an unexpected situation and to avoid confusion.

I would even argue YOUR use of it in a server might even benefit from
this advice, because it could be strange to get a different IP than
the one you set in the command line if there is also another entry in
some config that you happened to read.

> I also don't think that using an advise here would be ideal. The main
> use case of this configuration variable is going to be servers.

My feedback about servers is indeed below, so I won't repeat myself
but keeping a global config that has this advice disabled in a server
shouldn't be that difficult; indeed it MIGHT be already there since
most features that are meant for interactive users (like an advice)
are better disabled in servers.

> > I assume that if you want to use this frequently, having that advice
> > disabled in your global config wouldn't be a hassle, but it might be
> > useful to know that I am interacting with a potentially different IP
> > when referring to some host by name in my local repo, maybe because I
> > forgot to change that setting after some debugging.
> >
> > I am sure all those folks that forget to edit their /etc/hosts after
> > they are done with their local site versions might instead use this
> > and then be happy to be warned about it later.
> >
> > Carlo
