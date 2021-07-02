Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CBDC07E95
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 21:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39E34613D3
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 21:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhGBV50 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 17:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhGBV5Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 17:57:25 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465EBC061762
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 14:54:53 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id h9so12983356oih.4
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 14:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Kz/heIgSrFt6x4BZBKi8qbovw4GAS8dhMb2Q6lg/1k8=;
        b=mADO/F4FBoZCkXk2IgkdlhBRsHM807AcGbmvvRiRJ3nOpU64PcFqPzGxkE1sjgds1r
         8mZ1fECxPOxKq3Rmr/AAsP3FOAM9qI3URObe+NFCRN8Hsx0EN0utUehLLzLGC7f3MNjh
         xnlYhRiCK24YsmGm2stATfJoRq+uOYXBeI0e6uyBPIC02dVFqg24AeEeT/4v/jclQvde
         U3qLe/gE3xoPFGPPHxx7+EqM9lasBwxDLS/sL4XOQ476izjyAKMev6JKnH2PRMCZfYGX
         pmydu/7b6eCzW8zajY6KMP47Zln/Ys+Wk8l6s/VI8OEkj4zd9VBVd0t2zEBnkbhyR0w/
         qf2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Kz/heIgSrFt6x4BZBKi8qbovw4GAS8dhMb2Q6lg/1k8=;
        b=hJI0epjI1XddX14HTqg+vmuYiW+SgYlD8f6ZxntPTRQwljdXMEuS1eyopWrk+oaSr9
         vSjBKyG2xBsVQOno9vApEYu9e4dxPfTkreL+H4oz+0dppswST7EncDF9keJ3hfPqzLJe
         jwym1pQoKTGn2oPd79Gl5RVC6EwzfDEC6UwUcRyw4A0q+m/4faNYxPl2IE2NTGsgJv62
         xSJX5331MwZ+fyrPgI9BYtr+vyzZN1I6gtrdZvz7lzjp9WCzk7ilR5DJou8hVHyhoOU9
         hrlcUqz+SWbKpM14+3TEEoolwpDN6+HwJxavtjd7sXhssCT5C6LJUcYxgcp9xWto74po
         ubeg==
X-Gm-Message-State: AOAM531aNyLi+wjfd/ejl21ZSTEgsye9UUzxRyhkPKLVqKXLcilJt90I
        796KD+J7KSm8eVUFghbdrEM=
X-Google-Smtp-Source: ABdhPJxynQ0FzoI4ztTtjWmU6ugFwQePET9dRlPRlyboi+ollOvB0M8NNaga4mPaIcHNhAT890JgiQ==
X-Received: by 2002:aca:f4cb:: with SMTP id s194mr1428942oih.103.1625262892592;
        Fri, 02 Jul 2021 14:54:52 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id y11sm853314oto.28.2021.07.02.14.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 14:54:51 -0700 (PDT)
Date:   Fri, 02 Jul 2021 16:54:50 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        git@vger.kernel.org
Message-ID: <60df8b2a7e982_2eee2088@natae.notmuch>
In-Reply-To: <87zgv59bm8.fsf@evledraar.gmail.com>
References: <60b5d281552d6_e359f20828@natae.notmuch>
 <YLXl5+ronWhcGh13@danh.dev>
 <60b61089ba63d_e40ca20894@natae.notmuch>
 <YLcFU+ORZTzAsyBy@danh.dev>
 <60b70eb930614_4abd208ad@natae.notmuch>
 <87eedj74dr.fsf@evledraar.gmail.com>
 <60b8a98d11d7c_1a0a2d20856@natae.notmuch>
 <87zgw75dyi.fsf@evledraar.gmail.com>
 <60dee69fb7cc7_2964b208fb@natae.notmuch>
 <87zgv59bm8.fsf@evledraar.gmail.com>
Subject: Re: The git spring cleanup challenge
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> =

> On Fri, Jul 02 2021, Felipe Contreras wrote:
> =

> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >> On Thu, Jun 03 2021, Felipe Contreras wrote:
> >> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >
> >> >> We could then just extend the include syntax rather easily to inc=
lude
> >> >> "libraries", which would be like the current include.path, but wo=
uld
> >> >> understand a library:: prefix (better name bikeshedding welcome).=
 We'd
> >> >> then just ship these in /usr/share/git-core/config/includes or wh=
atever,
> >> >> e.g. /usr/share/git-core/config/includes/aliases/svn-like.cfg
> >> >
> >> > I wouldn't be against some some suggested defaults, but *in additi=
on* to
> >> > some hardcoded default aliases that are documented.
> >> =

> >> I'm talking about in terms of the flexibility of implementation of
> >> on-by-default defaults. We could implement it as I suggested and the=
n
> >> just have a core.defaultIncludes, which would by default be set to
> >> git::aliases/svn-like.cfg or whatever, i.e. equivalent to:
> >> =

> >>     [core]
> >>     defaultIncludes =3D "git::default.cfg"
> >> =

> >> Which itself would include a
> >> /usr/share/git-core/config/includes/default.cfg which would do:
> >
> > I really gave this a try, but the problem is that git doesn't even ha=
ve
> > a stardard location to install shared files.
> >
> > I started with $sharedir, but that's not git-specific. Then I added
> > $gitsharedir which required a bunch of changes to the Makefile, and
> > eventually I decided against it.
> >
> > We don't have standard location for shared files. Period.
> >
> >> In a way this is total bikeshedding, I just think it's worth doing i=
t
> >> this way up-front.
> >
> > Yes, maybe so, but git infraestructure is completely unprepared for t=
hat
> > (at this point).
> >
> > So I just decied to hard-code them [1]
> >
> > [1] https://lore.kernel.org/git/20210702100506.1422429-1-felipe.contr=
eras@gmail.com/
> =

> FWIW I only saw this reply after I replied in that thread
> ... referencing this one.
> =

> I haven't tried, but I'd think it wouldn't be a big change.

As I explaind the problem is that the build infraestructure is
completely unprepared to install files in /usr/share.

Go ahead and try to add a simple text file to the distribution.

Are you going to put it under /usr/share/git-core? Where are you going
to add it in the git tree? What target is going to install it?

> You're injecting alias.* config directly, you could just inject an
> include.path=3D* in the relevant part of the config machinery instead.
> =

> We'd need a new verb like gitdir:* and onbranch:*, maybe system:* or
> git:*, we'd then search system:foo.cfg for those relative to our libexe=
c
> or /usr/share data, e.g. /usr/lib/git-core/config/foo.cfg
> =

> We could then carry those in includes/* in the git.git repo, and to
> address the "let's make sure they're there" have a trivial build step
> like the command-list.h to build those into a C object. I.e. dog-food o=
n
> our own build process and run `git config -f <file> -l -z` for each one=
,
> munge that and spew it into a *.c
> file. I.e. include/aliases/svn-like.cfg or whatever.
> =

> Then when we can't find a system:* (or whatever it's called)
> handle_path_include() we'd consult that list of fallbacks.
> =

> I'm not saying it's trivial, just that I think in practice building
> consensus for a "one blessed list of hardcoded aliases" is going to be =
a
> very tough sell, and making it optional/configurable/pluggable might
> make that sell a lot easier.

I know, I do see value in this approach, which is why I tried. But when
I saw I was making more changes to the Makefile than the code I decided
to stop.

Moreover, it makes little sense to implement this perfectly if Junio is
simply going to reject it all.

Maybe once we have the "extra" directory it would be more straightforward=
.

-- =

Felipe Contreras=
