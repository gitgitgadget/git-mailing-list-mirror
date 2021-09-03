Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CC0C433EF
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 02:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A5196056C
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 02:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345734AbhICCeH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 22:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239772AbhICCeH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 22:34:07 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18618C061575
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 19:33:08 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a14so1993270uao.0
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 19:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9geA+DDJ6g4UC+ZCStrAjftHTu7wiEGbd+7r6nGOYrM=;
        b=i27jW9eaQJ982dX9SLol41aysYWk8snF+n/UZVxOn67n1mW2DmVQlZXiZbV/TWgqLG
         gsFPrbKMQZuGxcDXCMvN6W+E2fOaktQAjFhDOW7w8un5sd68AmvyKSoOtvk9YgD4Gv2h
         DuuKXGtZrzWMY4+ousCAXan+kB2YU0P4pHEVD4sTlA8cbwNwSIrq+QsD1Ntoqj6Q5eTN
         h+YNxWXxdI63rzRT9DSILEz9UVsR59xPqvMMn/Izfe41UehkoRh4ZC7d/8w5Ovm8T7KQ
         dyY/trz/InYLRIxdafKmHBQfakg95psv9dMmjIQ2tMzA1Ib1zvllaJnqAgrE2zZtbh3P
         W4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9geA+DDJ6g4UC+ZCStrAjftHTu7wiEGbd+7r6nGOYrM=;
        b=ejOVrlFCdIBltHZXwNYtTZW6r59tEfxop5QfgyUEeDJNZbxTkTKCeI+c/8qs2kUzWH
         t1IzNuJGaHE7VRjLSg64fiK3B7j0gcf4HpIVqYXkNhWIMA8MhSH3eUJvkYR6+A8naIsF
         +zjtyCW58bNL0YGIKFN6F8elWokzxc3Q88SOqsjz02jspQOAvlNG4OjSeplfDX2x/Nsx
         uPwr5yK7Ho7uLKpLnHoHCx/hs3cSRI0ohrVP9vM/Mv/dFEBNRLtQ1ZryngMA4A5I3Dkw
         s0BbKtGFMzDxCMz/Qo59S0HE15cI2A5nWJNOSuKAguCawjbyP5kxabkN3Wdtv9SLgO9N
         vKYw==
X-Gm-Message-State: AOAM532ybiMT2WNwHD+41BixG/zpB8NL0vp4BspBol27e/c14TYA0z8j
        xIZ3iqp3pF6a6tTflkPPyKedLqAvG15rG0LRoQ6ohIAe
X-Google-Smtp-Source: ABdhPJzt1whka80HUkUAre4uxZNei2ZUVpieCIFsM6F/LO+itQIYztWgOuLNg2ul8gDTPRCivFLEhTEWaBGeRJdPcvI=
X-Received: by 2002:ab0:3418:: with SMTP id z24mr1014822uap.96.1630636387122;
 Thu, 02 Sep 2021 19:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210902085438.54121-1-carenas@gmail.com> <87ilzjuv2t.fsf@evledraar.gmail.com>
 <87fsunuulu.fsf@evledraar.gmail.com>
In-Reply-To: <87fsunuulu.fsf@evledraar.gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Thu, 2 Sep 2021 19:32:56 -0700
Message-ID: <CAPUEspi28JrPUa4jTACzuuco4mmMmDxjzTbCz5wigHORXQBUXw@mail.gmail.com>
Subject: Re: [PATCH] makefile: teach git about NO_MSGFMT (as supported in GUI
 and gitk)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

OnThu, Sep 2, 2021 at 3:42 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avara=
b@gmail.com> wrote:
> On Thu, Sep 02 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> > On Thu, Sep 02 2021, Carlo Marcelo Arenas Bel=C3=B3n wrote:
> >> NO_MSGFMT can be used to indicate there is no msgfmt available, so
> >> make git recognize that and avoid failing to build while trying to
> >> generate i18n files.
> >
> > Why would we want to avoid failing the build if we don't have msgfmt?

OK, I have to admit, this is mainly because gettext and msgfmt come
from different packages in OpenBSD, and I keep forgetting to install
the latter.
It makes sense too, if you only care about a quick build and your
binary won't use the message files (ex: a git part of a build
container or a portable minimal package); you are correct I usually do
NO_GETTEXT=3D1 as well in that case, which is why I didn't saw the tests
breaking.

> > I understand why you'd want NO_GETTEXT in that case, but what's the
> > point of building with NO_GETTEXT=3D NO_MSGFMT=3DY?

I think they are conceptually different, one instructs the build
system that we want to build international support in the binary,
while the other only says "I have this tool and want the catalogs
generated with it"

> > If we can't build the *.mo files we'll have a completely broken
> > installation that can't do anything useful with gettext, so why not jus=
t
> > build without gettext at that point?

the gettext() calls fail cleanly if there are no catalogs to use, so I
wouldn't agree it is broken
and more importantly, will start using them if they are provided and
the binary is pointed to them, they don't need to be freshly generated
or even match the version of the binary they are queried from.

> > When this patch is applied a lot of things related to gettext in our
> > tests fail if you build with NO_GETTEXT=3D NO_MSGFMT=3DY, because those
> > things are assuming that if NO_GETTEXT isn't defined we'll have the *.m=
o
> > files, po/build etc.

apologies, thanks for checking, that was sloppy of me.

> Some further digging reveals that we've got in-tree git-gui/po/po2msg.sh
> and gitk-git/po/po2msg.sh (copy/pasted, but slightly different) that
> supports some subset of "msgfmt --tcl".
>
> I.e. those programs with NO_MSGFMT still end up with locale files they
> can use, whereas in this patch we don't end up with anything at all...

I have to admit I found odd we had those as I was expecting they
should behave like git in this case and don't generate any mo files.

FWIW Git for Windows seems to go to great extents to NOT include those
in the release.

Carlo
