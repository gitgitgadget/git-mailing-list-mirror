Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50683C433F5
	for <git@archiver.kernel.org>; Tue, 24 May 2022 19:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240784AbiEXT0T (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 15:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbiEXT0R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 15:26:17 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7242541982
        for <git@vger.kernel.org>; Tue, 24 May 2022 12:26:16 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id i40so24346851eda.7
        for <git@vger.kernel.org>; Tue, 24 May 2022 12:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=MiTV4kMi0QIk1S2dxHL+QeGbD7nwRO6nb+zhsmocP4o=;
        b=MbuUG51AoV6xp4CSu6SAmvDrj4CwBMS3M1QL9GcdDI8b1fKKznNGNei8NtaL3ggpRU
         HGgj3j0XSIofH73v1q1h9plkqRHZ1oEkTyM//1hcJUUauVLpqMyHupZRnY3bETm9ZnHU
         EDzJVIQmZzGCEugi3yFz7H4uaVynWsWaYL2PsfVeEnl2vUdBPZBFsF6xNFPEMOUpuuhf
         Ft4Mfcu4109AD5GpFv9DHwmEf+EhbByNQjFT3cGVyn3j0renDmF3HWFsYIJl63URdsxh
         pzuAzLyyWEk47qBPh/nsm2D6idF4Lv/N+Z0+xaSEV38oohZRi2slh2cmZn8EUciHHPZE
         qQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=MiTV4kMi0QIk1S2dxHL+QeGbD7nwRO6nb+zhsmocP4o=;
        b=WKPEWG71P2TlhwL70iR6jW1wcOkCa7rv08M3P5Sax0EQsPYaLyh9Sg5l6ln5U1xkL/
         Hw8ENY9aYeAQl3niO1196CreacIEf/65rTFN5jRVJWadu5S4JBMnK2j7Pyd5tPNcj1Ea
         RFagLJ8kDG+K50LBePj3zrnUY0jTs88btpmw3DdCms4m8MAPwCt+GmREqfBXT1tCdmy1
         BN2ejS7wCy8VXHE3udpvs76+wiVYi8ooLbsfd6yZ/JGhyhjhronK6I8dq2dgbZTwFGnv
         FKjNNCIcx4yGeh7Amx2pN56imhR1x6A+xxAxyNmms+LzTJy+rgEY1ElXF6FRhvDBq0Ym
         v87Q==
X-Gm-Message-State: AOAM531kefnbDiuMyaOBKirQIg+n5Vr5ZsPXPpPtq/O13E3cYXS54U89
        18aLD1Evinam4TTflAUH470c2juTC9o=
X-Google-Smtp-Source: ABdhPJwD10qq0lTi/ajK/zj0p90GnA4eDZiDoFf/2DCcK/6DxgiPGsjdQB7XV/K2/dN57JfiO7kDWg==
X-Received: by 2002:aa7:c38a:0:b0:42a:ab63:c5a3 with SMTP id k10-20020aa7c38a000000b0042aab63c5a3mr30688026edq.303.1653420374579;
        Tue, 24 May 2022 12:26:14 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id m5-20020a17090677c500b006f3ef214e24sm7452544ejn.138.2022.05.24.12.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 12:26:14 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ntaAX-003WTY-Fb;
        Tue, 24 May 2022 21:26:13 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Ed Maste <emaste@FreeBSD.org>
Subject: Re: [PATCH] ci: update Cirrus-CI image to FreeBSD 13.0
Date:   Tue, 24 May 2022 21:24:14 +0200
References: <20220524165823.18804-1-levraiphilippeblain@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220524165823.18804-1-levraiphilippeblain@gmail.com>
Message-ID: <220524.86czg2wx4a.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 24 2022, Philippe Blain wrote:

> The FreeBSD CI build (on Cirrus-CI) has been failing in
> 't9001-send-email.sh' for quite some time, with an error from the
> runtime linker relating to the Perl installation:
>
>     ld-elf.so.1: /usr/local/lib/perl5/5.32/mach/CORE/libperl.so.5.32: Undefined symbol "strerror_l@FBSD_1.6"
>
> The first instance is in t9001.6 but it fails similarly in several tests
> in this file.
>
> The FreeBSD image we use is FreeBSD 12.2, which is unsupported since
> March 31st, 2022 [1]. Switching to a supported version, 13.0,
> makes this error disappear [2].
>
> Change the image we use to FreeBSD 13.0.
>
> [1] https://www.freebsd.org/security/unsupported/
> [2] https://lore.kernel.org/git/9cc31276-ab78-fa8a-9fb4-b19266911211@gmail.com/
>
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
>
>     Here is a proper patch following my earlier mail [1].
>     
>     [1] https://lore.kernel.org/git/CAPUEspgdAos4KC-3AwYDd5p+u0hGk73nGocBTFFSR7VB9+M5jw@mail.gmail.com/T/#t
>
>  .cirrus.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/.cirrus.yml b/.cirrus.yml
> index e114ffee1a..20c85eef81 100644
> --- a/.cirrus.yml
> +++ b/.cirrus.yml
> @@ -9,7 +9,7 @@ freebsd_12_task:
>      DEFAULT_TEST_TARGET: prove
>      DEVELOPER: 1
>    freebsd_instance:
> -    image_family: freebsd-12-2
> +    image_family: freebsd-13-0
>      memory: 2G
>    install_script:
>      pkg install -y gettext gmake perl5
>
> base-commit: 7a3eb286977746bc09a5de7682df0e5a7085e17c

This may or may not be a good idea, I've got no about about this CI
setup & what FreeBSD version we'd prefer.

But that you're seeing this in t9001-send-email.sh in particular
suggests that perl isn't broken in general, as we hard depend on it in a
bunch of places in the test suite.

Rather, it's some more advanced Perl usage.

So aside from this switch perhaps we'd like to have a more specific
prereq for those send-email tests than just "PERL", which is controlled
by our "NO_PERL" build-time setting, i.e. to actually probe if Perl
works.

The error you quote doesn't tell us anything about where it happened,
which aside from anything else would be useful to have in the commit
message. I.e. what command did we run when this failed, and did other
perl commands before that (either in that test, or others) work?
