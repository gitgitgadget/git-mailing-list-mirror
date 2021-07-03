Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC9DC07E97
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 12:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C33361939
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 12:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhGCMa2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Jul 2021 08:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbhGCMa1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jul 2021 08:30:27 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F93C061762
        for <git@vger.kernel.org>; Sat,  3 Jul 2021 05:27:53 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id m1so16983973edq.8
        for <git@vger.kernel.org>; Sat, 03 Jul 2021 05:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=/A6o7Dc/KMyYnZ+2iFzMd8ZKsiS9fxEMRCQPwQLTcnE=;
        b=ZjIVvm/rQLwAwPVMoM+OtD/C8b/FhQ0I58i/ITzzhpMShqqhVO2+xOD1qzc2Id4Inq
         WfHoh61MIAWWjOA6BlOW2VhM0hOFRWqBUYb4iqE/xsYwFNfs898I2vgaC5RiKQaGslS2
         Kg/J2yEBZ8JKfCHbry6PBUdeBG+4kcsusS9qIXVAxGE0sdh9vMgwawtsZfm9I4TpiXKi
         7vv3VVb3iHQS2gZZGcXlcZEHVduCRlFi2sa6e8O+d7NEKSPXvXVEalXBId5CtZQUjEKa
         QDeskCCcDD/rtdJMtx1e5IjUSdme9TUDrFL2fF67HbzoszvgzrQ949SxWUzckhGWx10S
         qC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=/A6o7Dc/KMyYnZ+2iFzMd8ZKsiS9fxEMRCQPwQLTcnE=;
        b=EZ10SZcppONkGef6YTES8b40J2QqzkLFlZQlPaW9rwxPGh0vLhmok2A9cmdcD75Mp7
         QP/+nysnUq+aS+sqrLlcOkT9awHHW1jwdKVZ3EmxIF6cJtCxMgYFRo7e9ewlDeNPOUHl
         W4CBJDj6gchzLDMR56jZa9fuTtJOoMUzUtLCMPLwSVx+4khCevGewwprat2v8DKuwLQR
         84v44gvd+hMGwsyf7pFI2gDXTiK7etQ0ef3DoXkF/zrdwdF1MIqAyP2reoZK0f4+iwtY
         gSqk+tn6DCukpdHg3G2jSXgyteJhZ5iRbqIOjNHUKIZyAyoMSgl0NJUiQb77PxzrGk+6
         ZaJQ==
X-Gm-Message-State: AOAM530a7XsyJlBnulJ6FCTjVLhQv4CH/KIcS9ISNa70U/tsN+GPbIUR
        sdNxXwHVb09FKyBSV59pG398kIk+rWw=
X-Google-Smtp-Source: ABdhPJwm4ctkKiOo96pFsTjcvzWHd4p/36OMMsLqJjM1Wa7wVgKS62CV2gJWX+fNYZuNE0r60Ru8bQ==
X-Received: by 2002:a50:8e16:: with SMTP id 22mr4934672edw.369.1625315271626;
        Sat, 03 Jul 2021 05:27:51 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id br4sm1933575ejb.110.2021.07.03.05.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jul 2021 05:27:50 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Subject: Re: [PATCH] Documentation/Makefile: don't re-build on 'git version'
 changes
Date:   Sat, 03 Jul 2021 14:03:40 +0200
References: <874kdn1j6i.fsf@evledraar.gmail.com>
 <patch-1.1-911881ce19f-20210702T115617Z-avarab@gmail.com>
 <60dfb7d11cac3_3dd220811@natae.notmuch>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <60dfb7d11cac3_3dd220811@natae.notmuch>
Message-ID: <87mtr38tvd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 02 2021, Felipe Contreras wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Since 9a71722b4df (Doc: auto-detect changed build flags, 2019-03-17)
>> we've been eagerly re-building the documentation whenever the output
>> of "git version" (via the GIT-VERSION file) changed. This was never
>> the intention, and was a regression on what we intended in
>> 7b8a74f39cb (Documentation: Replace @@GIT_VERSION@@ in documentation,
>> 2007-03-25).
>>=20
>> So let's add an ASCIIDOC_MANVERSION variable that we exclude from
>> ASCIIDOC_COMMON. The change in 9a71722b4df was only intending to catch
>> cases where we e.g. switched between asciidoc and asciidoctor, not to
>> undo the logic in 7b8a74f39cb and force a re-build every time our HEAD
>> changed in the repository.
>
> Once again, why do we care that the version is 2.32.0.98.gcfb60a24d6 and
> not 2.32.0.97.g949e814b27?
>
> Not just in the documentation, but everywhere.

It's useful e.g. on my Debian system to see that the "next" Debian
packaged is 2.31.0.291.g576ba9dcdaf in docs & "git version", arguably
less so for documentation.

But yeah, I think we should at least have some opt-out for sticking the
exact version everywhere, given the mostly unless re-building it does
during development.

> Maybe we can add a GIT_RELEASE variable that unlike GIT_VERSION it
> doesn't contain the precise commit. For example GIT_RELEASE =3D 2.33-dev.

I just added this to my pre-make script:

	grep -q ^/version .git/info/exclude || echo /version >>.git/info/exclude
	echo $(grep -o -P '(?<=3D^DEF_VER=3Dv).*' GIT-VERSION-GEN)-dev >version

It makes use of GIT-VERSION-GEN picking up a tarball "version" file.

So far it seems like Junio isn't interested in the patch, and in any
case it doesn't fix the more general over-rebuilding due to version
changes noted upthread when it comes to *.o and libgit. Doing this fixes
both for me. Then when I build an installed version I don't use that
trick.
