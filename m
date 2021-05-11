Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A026C433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 19:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED6FA613C5
	for <git@archiver.kernel.org>; Tue, 11 May 2021 19:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbhEKTCG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 15:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbhEKTCF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 15:02:05 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF492C061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 12:00:57 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so8235909otg.2
        for <git@vger.kernel.org>; Tue, 11 May 2021 12:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Xo0VRIzCIGg4ntLLSw1J6p0QG33UcVyLG0TxS6dB6EA=;
        b=GXdjXdK6UKoNEYmnFCh61PhjzKR9ZmJHvGRGM4u0he32uQbTr+hGtC3IbF+tZLlnQ1
         QPShd6Qte+hjRgWeZiUxfoXQ7Pdb0tYzr8UunGevFCxY/CrRVY8gusV3J63/ytwCHk4r
         qZ9H+sQYNq466QVbKuCvJqF27snGEsiSCtw8lTjlhJPEgyAPLf5QBUgoLQrG1i/R23X5
         WWkkl4KTuy/omfEWfaUVRCOTSySy4g+tSYmpoGjtdcKvj3T/eVltFDE0X90L2lLFS8Ut
         v3tH6PpdQGZmfDANSm3ZFb3ZG4vMLrsrUD/e/hqums6Zigh+SLbZa1AQ+FvvmZelJYT7
         NTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Xo0VRIzCIGg4ntLLSw1J6p0QG33UcVyLG0TxS6dB6EA=;
        b=KqlC7sTI77/icvU1kyShkQdoan+2oUIV7Sm/D8AwyVkskMgUw8DhhOg1Zs8yT/cAub
         Ppx+057v2Aywt3EKrkHmm5tSNI4xArJ5y++Gc4gq6DIYAnRxQ/v5ppF71FR76VFpvxS1
         YU6sl75UFnIG4zVmXTr7nrUhY0ljhBxHDQ+0/WnLgMRQEuK+78hxFpDFOzHxxtTezpj2
         CTEATj/qjJYZ0XhTnzAgblRyDQ6KDC0Nb/KI4dSv68w6x+HV7+O73Em74KDM4ZtBZQnX
         LrXesKN4yXEZL/pigANKOvGF6z53OgqZuLFGyz07J1NJ8iTJ3PZMLO54whjJIQ/USBuN
         t6MQ==
X-Gm-Message-State: AOAM5315V3ntVa25Vl7PAStglKTRqG9lpyqrMXTRGuiAnQe9qLzm+1Yv
        Yta7BM/OPBDsDpZyymhAjbQ=
X-Google-Smtp-Source: ABdhPJwtM86ZbEtP4gPYyI1vH1NSOIJOiXNf97MAqfGMiSDOjXJC93Do30IcY+52vudGBJj+f3SimA==
X-Received: by 2002:a9d:6146:: with SMTP id c6mr7758376otk.21.1620759657289;
        Tue, 11 May 2021 12:00:57 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id i9sm3446475oog.17.2021.05.11.12.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 12:00:56 -0700 (PDT)
Date:   Tue, 11 May 2021 14:00:55 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
Message-ID: <609ad46776dec_6011e208d7@natae.notmuch>
In-Reply-To: <877dk5tovj.fsf@evledraar.gmail.com>
References: <3461c7b0-594d-989e-3048-2fc6583084ad@gmail.com>
 <YJWiQH2nf0B14Zy7@camp.crustytoothpaste.net>
 <YJW81zNr5bgW+yVs@coredump.intra.peff.net>
 <CAN0heSpN_ieGc2HJCvSsmUuEqS-GGPDcZHz=v2Z3hJY=Or_HMw@mail.gmail.com>
 <YJmykGWaWi03+WoW@coredump.intra.peff.net>
 <609a07ca6a51c_5afe12088b@natae.notmuch>
 <YJogn8cUtSP/BAbJ@coredump.intra.peff.net>
 <609a3a5a7aa08_5d5d32088@natae.notmuch>
 <877dk5tovj.fsf@evledraar.gmail.com>
Subject: Re: [RFC suggestion] Generate manpage directly with Asciidoctor
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Tue, May 11 2021, Felipe Contreras wrote:
> =

> > Jeff King wrote:
> >> On Mon, May 10, 2021 at 11:27:54PM -0500, Felipe Contreras wrote:
> >> > Jeff King wrote:
> >> [...]
> >> > I've never understood developers worried about how the bleeding ed=
ge
> >> > would build in ancient platforms, when ancient platforms don't car=
e
> >> > about the bleeding edge.
> >> =

> >> Again, this is about developers. Are there people contributing new
> >> documentation to Git who are doing so on Debian stable, and would be=

> >> inconvenienced by needing to upgrade their toolchain?
> >
> > Developers don't need to create (or use) debian packages. They can
> > simply do `gem install asciidoctor` and be done with it. Some may eve=
n
> > create a docker container to install all the doc toolchain in order t=
o
> > avoid polluting their main environment.
> >
> > I for one would start building the documentation more if all I needed=
 is
> > one dependency.
> =

> Just because I'm developing the latest git.git revision on Debian stabl=
e
> that doesn't mean that I'm keen to install the very latest openssl,
> libcurl, asciidoc, C compiler, or whatever other thing we depend on.
> =

> I'm not disagreeing with bumping the dependency in this case (I haven't=

> looked into it). I'm just pointing out that in general there's a lot of=

> use-cases for e.g. building a latest git on an N year old OS.

I'm not disagreeing with that. The reason I mentioned it is what Jeff
said next:

> > > It's not too hard to install an updated gem, but not quite as nice
> > > as using the system package (it also makes things weird for
> > > building the stable Debian package itself, which would want to
> > > rely only on other packages; but of course any proposed change to
> > > the doc toolchain would be for new versions, and would not get
> > > backported there anyway).

Doing `gem install` solves the problem for whomever wants to build the
latest git in Debian stable.

Building Debian stable packages is something else.

> Of course we can ask these people to just build their dependencies too,=

> as I noted in [1] in a past discussion. Whether we bump our required
> dependencies is a trade-off between our own convenience and these sorts=

> of in-the-wild builds.
> =

> I'm just saying we should keep this use-case in mind, it's not an all o=
r
> nothing where you either have ancient deps + ancient git or bleeding
> edge deps + bleeding edge git. A lot of people build ancient deps +
> bleeding edge git.

But what is "this"?

 1) Building the latest documentation in Debian stable
 2) Packaging the latest git in Debian stable

If it's 1) then there's no problem: `gem install` does the trick, and in
fact in their CI builds [1] they test with versions of Ruby as old as
2.3, and Debian stable ships with 2.5.

I test my own Ruby code with versions of Ruby as old as 2.0 and there's
rarely any issue. What works with Ruby 2.3 works with Ruby 2.0. Ruby is
not like python (where 3.0 is completely different from 2.0).

If it's 2) then that's where I say: who cares?

> The "just use the built doc tarballs" is only a partial solution, and
> e.g. won't work for someone who's interested in building "next" or
> otherwise applying local patches that have doc changes.

Right, but "just use the built doc tarballs" is not the suggestion for
people trying to do 1).

Cheers.

[1] https://github.com/asciidoctor/asciidoctor/actions/runs/830132862

-- =

Felipe Contreras=
