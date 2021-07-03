Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0654C07E97
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 12:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6784617ED
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 12:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbhGCME7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Jul 2021 08:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhGCME6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jul 2021 08:04:58 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D374CC061762
        for <git@vger.kernel.org>; Sat,  3 Jul 2021 05:02:24 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id j11so16940015edq.6
        for <git@vger.kernel.org>; Sat, 03 Jul 2021 05:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=flzwKw6IRbwJmUD48v5BSkiiTaGJRNsG1aWHvcqA8a0=;
        b=e+weN8gF4BmTOnWxWb2unh7dTHQsPq2EsMbeAOaaptAiTNHDMPP2y6aLBEr2TaunPu
         X7FBZ/EQhcCnbn38hoCtvI5ik0hBPrWkam6m/Gzeb1b1az3mzpNU2CSToGiGrlo0oJ8U
         N/nkGJU9hiPgRLNs+Fie+lKBCTfv6c4HLxkRuOFwJxXRiTRxE6sxb1G2OaYnODcoWp4H
         mVDXpyNNvYcvGpgMOLGGsKFR1bay+q40V+W1d9miBZH9jFsvGjPIE1pEnDnQoZstPihW
         tN7KenMTefrzjAqoWlhlzJVSvN7Mlej/dcFIInbBwTLi2eKJLEbl4gJcm3mSkjD//bwA
         CKQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=flzwKw6IRbwJmUD48v5BSkiiTaGJRNsG1aWHvcqA8a0=;
        b=Jn2YCI9VW4iDi5EimpPz2xaw8NDjAKgaAoS9QFjPizlcaqNefEpy8RQWgtfy9i9DjT
         vOEzodbWJ/wKDgiFFb2xc9t1BZ+zpnyGUA5xMv8wV1Rdd4uLQg19pR6gtttvBbDXwLFE
         YQ6PepsKEfp7ffLyJur5gGwrp++9CNCGKp8SYAhSjJBnW1lElTQJSlqDyETAUrwkzsgS
         U+2ZO88CETN3R4LatZl8nWeXK1am/lTezUbyxXwxc69HB47iFZyJM9Q3cFScnOnrFpZt
         0ju+tBNGIwldG1l3bRBIgpCxR2V+DiHGmO8hTKeHAqloHnrL+PYL1/z39PLdrIpJoIjZ
         V0Ow==
X-Gm-Message-State: AOAM530IK5Kf/BvHbaTsqvBhd6WbdDEEwzeXlRAHNFvTyd/Xl7t9HKTt
        pfXE1wP2mwaxGrxnUwle3jw=
X-Google-Smtp-Source: ABdhPJxz6IX4qgijbTP3ZcrA0eY41tvwoFT5CB7/olAHKKsnFQB82J5oPdbV66/U3yaOalKW+I3VHQ==
X-Received: by 2002:a05:6402:5114:: with SMTP id m20mr5009664edd.174.1625313743271;
        Sat, 03 Jul 2021 05:02:23 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id j1sm2509464edl.80.2021.07.03.05.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jul 2021 05:02:22 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Subject: Re: [PATCH] Documentation/Makefile: don't re-build on 'git version'
 changes
Date:   Sat, 03 Jul 2021 13:58:55 +0200
References: <874kdn1j6i.fsf@evledraar.gmail.com>
 <patch-1.1-911881ce19f-20210702T115617Z-avarab@gmail.com>
 <xmqqmtr4pv9r.fsf@gitster.g>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <xmqqmtr4pv9r.fsf@gitster.g>
Message-ID: <87pmvz8v1u.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 02 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Since 9a71722b4df (Doc: auto-detect changed build flags, 2019-03-17)
>> we've been eagerly re-building the documentation whenever the output
>> of "git version" (via the GIT-VERSION file) changed. This was never
>> the intention, and was a regression on what we intended in
>> 7b8a74f39cb (Documentation: Replace @@GIT_VERSION@@ in documentation,
>> 2007-03-25).
>
> I am not sure.  Even if there were no changes in say
> 'Documentation/git-cat-file.txt' and the sources it depends on
> between 'master' and 'next', after doing this:
>
>     $ git checkout next
>     $ make prefix=3D$HOME/git-next/ install install-doc
>     $ git checkout master
>     $ make prefix=3D$HOME/git-master/ install install-doc
>     $ $HOME/git-master/bin/git help cat-file | tail -n 1
>
> I should see that the documentation should say it is from the
> 'master' branch in its footer, no?

Yes in theory, in practice it's very annoying to have the very slow
documentation build be re-built so aggressively. Since it wasn't a
practical issue anyone worried about before 2019 I think it's worth
reverting it.

> In other words, I think 7b8a74f39cb's reasoning (not the
> implementation), especially the last sentence of its log message, is
> flawed, where it said:
>
>     Documentation: Replace @@GIT_VERSION@@ in documentation
>=20=20=20=20=20
>     Include GIT-VERSION-FILE and replace @@GIT_VERSION@@ in
>     the HTML and XML asciidoc output. The documentation
>     doesn't depend on GIT-VERSION-FILE so it will not be
>     automatically rebuild if nothing else changed.

Arguably it's a feature. The point of the version in the documentation
is to make it clear what version we're discussing. If I build something
on the master SHA-1 and advance to next, and none of the documentation
dependencies change, it's most useful to refer to the oldest last
version we can cover.

I think nobody's doing such a "chained" build when building the docs for
a "real" release, and having mixed versions might be confusing, but for
the "local build" case from a development checkout it's arguably more
useful.
