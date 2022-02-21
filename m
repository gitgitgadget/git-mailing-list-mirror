Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57749C433F5
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 20:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbiBUUQD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 15:16:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiBUUQA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 15:16:00 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0F912ABE
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 12:15:36 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id p14so35950791ejf.11
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 12:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=5uFkEKkXQdw0j2iQ9o1+PXcRIvPkOTb1CwnnAWE8b6w=;
        b=C+BbCddmh48CXLAbrqoNYepWKLaxCsJ3ts3qGaRfMTcxhzv4jWIMYN9N65+z/D1uWm
         HyGTxS6QbMTHLImGD0HXP2b3p1i0jYI40gHzoB2k7u5qHvtcynhXNo/ZFOdy18cFEfJk
         krJwXfyssxukrEc4pC4uFlH3Szp8RVCKxfq5GGyJ4UaJzMGVNnYiSS7M13B8plez5/re
         MxrMrwXtY9H6QsNHs/xFhkQvSyo6DLvLVRfmbab24FBHQ46fEvHvAMv+W/+/KuqJkMFo
         xIF1uACAK/rzYhK2dwJnH8QjDyErAxY8O0pPy5nSkvrAUOK1RT+xA45N9x2ZWMWcehA6
         tvMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=5uFkEKkXQdw0j2iQ9o1+PXcRIvPkOTb1CwnnAWE8b6w=;
        b=bF+1y2mwPGWbNUzQjShwnPmCaH5vCwEv75Re5APi+M4bHBgYUijOGK6SMl5f4/CpnS
         zFSGneKiFggBwLR9tz07aNbjtIa0FezBOcBZVn2Ashl21uQoMclCOohXiO/uAm/Qjvf7
         4V0bjhLFDR3DXNQV2JK0O5xHXRW5Zogx+EXrW+DBwQkpl/fqoNb+SECpsotNCbthrwoy
         UqsMXSfzyb0a/Tu2K96jat0NV9sKBwsW+B6KnBNwoWVOIAna2OpkzNOkvupwFcXRfVOt
         qXuRBhX44JvFN2BVJH6pARamfYhr1P8Y66RlLqE/rt956kfCiJaRwojMU4aU0ArTRQKd
         SZaA==
X-Gm-Message-State: AOAM532SVoRnA6v0Ytw03dJQm3w9lAHvGWDdsTIV2spg/gk6vY6CecBA
        W8RX3SP6s/efCcuxkghQS/uFYGSEPP921Q==
X-Google-Smtp-Source: ABdhPJyQ+jc1i0xHyqvs2+uR5Rk7dRI8+wzDJ7HFqxBOySDjKIghUes6qjEyVNxpKTqBe4NC1iW1BA==
X-Received: by 2002:a17:906:7197:b0:6cd:ef8f:ecbf with SMTP id h23-20020a170906719700b006cdef8fecbfmr16858596ejk.18.1645474534855;
        Mon, 21 Feb 2022 12:15:34 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id 29sm5616791ejk.147.2022.02.21.12.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 12:15:33 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nMF5p-005oWm-78;
        Mon, 21 Feb 2022 21:15:33 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Victoria Dye <vdye@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 00/11] Makefile: fix "Perl" and "Python" rules, speed up
 re-builds
Date:   Mon, 21 Feb 2022 21:14:00 +0100
References: <cover-00.11-00000000000-20211217T002023Z-avarab@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <cover-00.11-00000000000-20211217T002023Z-avarab@gmail.com>
Message-ID: <220221.86r17w9dsq.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 17 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

A gentle reminder about considering picking up this topic that got lost
around the holidays.

This thread doesn't have any reviews, but as the linked-to range-diff
shows it's all had reviews already as part of the larger topic I split
it up from (except for the trivial addition noted below).

> This topic is split-up from v4 of ab/make-dependency[1]. Range-diff to
> it below. As noted in [2] I opted to split up that series rather than
> having it grow too large.
>
> This is miscellanious cleanups related to the "Perl" rules, and some
> fixes for bad dependency rules in 08/11. Then in 10/11 we make the
> "Python" rules use the new template we created for "Perl",
>
> We are then able to speed up "make" re-builds a bit in 11/11, as we
> don't need to inject @@GIT_VERSION@@ into the Perl scripts anymore.
>
> The 09/11 is new. It's a trivial sorting of the PERL_DEFINES list,
> which'll help to maintain it in the future.
>
> 1. https://lore.kernel.org/git/cover-v4-00.23-00000000000-20211117T101807=
Z-avarab@gmail.com/
> 2. https://lore.kernel.org/git/211217.86a6h09km9.gmgdl@evledraar.gmail.co=
m/
>
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (11):
>   Makefile: clean perl/build/ even with NO_PERL=3DY
>   Makefile: don't set up "perl/build" rules under NO_PERL=3DY
>   Makefile: use "=3D" not ":=3D" for po/* and perl/*
>   Makefile: remove "mv $@ $@+" dance redundant to .DELETE_ON_ERROR
>   Makefile: guard Perl-only variable assignments
>   Makefile: change "ifndef NO_PERL" to "ifdef NO_PERL"
>   Makefile: adjust Perl-related comments & whitespace
>   Makefile: correct "GIT-PERL-{DEFINES,HEADER}" dependency graph
>   Makefile: sort PERL_DEFINES list
>   Makefile: create a GIT-PYTHON-DEFINES, like "PERL"
>   Makefile: stop needing @@GIT_VERSION@@ in *.perl scripts
>
>  .gitignore          |   2 +-
>  Makefile            | 160 +++++++++++++++++++++++---------------------
>  git-cvsserver.perl  |   6 +-
>  git-send-email.perl |   7 +-
>  git-svn.perl        |   2 +-
>  5 files changed, 90 insertions(+), 87 deletions(-)
>
> Range-diff:
>  1:  1621ca72c1d <  -:  ----------- Makefile: don't invoke msgfmt with --=
statistics
>  4:  daead5ec293 =3D  1:  185f5a9a9cf Makefile: clean perl/build/ even wi=
th NO_PERL=3DY
>  2:  b7c36c9fea0 =3D  2:  37eeccc5646 Makefile: don't set up "perl/build"=
 rules under NO_PERL=3DY
>  3:  29b000eb0f1 =3D  3:  572a82c71a1 Makefile: use "=3D" not ":=3D" for =
po/* and perl/*
>  5:  3c987590740 =3D  4:  5baff22f5af Makefile: remove "mv $@ $@+" dance =
redundant to .DELETE_ON_ERROR
>  6:  b57f582ccd3 =3D  5:  992e325491d Makefile: guard Perl-only variable =
assignments
>  7:  fcdee92f64c =3D  6:  5e94ef729fe Makefile: change "ifndef NO_PERL" t=
o "ifdef NO_PERL"
>  8:  1e25b532ca2 =3D  7:  4eeef8571aa Makefile: adjust Perl-related comme=
nts & whitespace
>  9:  77d9855bfcf =3D  8:  8aa35537b08 Makefile: correct "GIT-PERL-{DEFINE=
S,HEADER}" dependency graph
>  -:  ----------- >  9:  5ff768a5cec Makefile: sort PERL_DEFINES list
> 10:  6004cdcd8d9 =3D 10:  fe79797f45e Makefile: create a GIT-PYTHON-DEFIN=
ES, like "PERL"
> 11:  17b30e96057 =3D 11:  defbd9b6db2 Makefile: stop needing @@GIT_VERSIO=
N@@ in *.perl scripts
> 12:  30ddf7da2c8 <  -:  ----------- Makefiles: add "shared.mak", move ".D=
ELETE_ON_ERROR" to it
> 13:  f378a7dc35e <  -:  ----------- Makefile: move $(comma), $(empty) and=
 $(space) to shared.mak
> 14:  13cbb851d32 <  -:  ----------- Makefile: re-add and use the "shellqu=
ote" macros
> 15:  337953e4994 <  -:  ----------- Makefile: add a "TRACK_template" for =
GIT-*{FLAGS,DEFINES,...}
> 16:  5bb597c1993 <  -:  ----------- Makefile: add "$(QUIET)" boilerplate =
to shared.mak
> 17:  3c4d0589667 <  -:  ----------- Makefile: use $(wspfx) for $(QUIET...=
) in shared.mak
> 18:  be5882b2c99 <  -:  ----------- Makefiles: add and use wildcard "mkdi=
r -p" template
> 19:  2710f8af6cd <  -:  ----------- Makefile: correct the dependency grap=
h of hook-list.h
> 20:  59f22a0269a <  -:  ----------- Makefile: use $(file) I/O instead of =
"FORCE" when possible
> 21:  dd569a59c74 <  -:  ----------- Makefile: disable GNU make built-in w=
ildcard rules
> 22:  4168a7e3b30 <  -:  ----------- Makefile: define $(LIB_H) in terms of=
 $(FIND_SOURCE_FILES)
> 23:  48a3927d972 <  -:  ----------- Makefile: move ".SUFFIXES" rule to sh=
ared.mak

