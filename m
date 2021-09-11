Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79460C433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 02:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4706A60FE3
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 02:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbhIKCqX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 22:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbhIKCqW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 22:46:22 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9810CC061574
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 19:45:10 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id g21so5255088edw.4
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 19:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=yBeHD2cmlPPvkgQ3TABI3Ii2blBxXQrLxscG19jxl1I=;
        b=Z3LD8gp2ciFrHy+x1WxpvUsxk3xW0ZV82sFkcD1snzKgm3axiIFEsGOPckUVCEu1CM
         0/F+94UHwYG/JF+tv3YpEfsQJrNfMxOsUrXYtM5bHkRj6CkB3uc+TLUVHQdolFD7UYyz
         PiQvIL/yQ0HK8g/xi9HwikXnL69gQt6NkUNUmyUGGz5iD9+0MzlbnW0T+uVXAhvYtuig
         w1kiCX3EyJcjEmb+enDi/8mqBSla7Jl4wJoJv8lpNohC9pFsGC2gA1mj2DJTQckocdkO
         20YJeKuY0L34ag2zS1GcZapZTSmZM6JNSAqle9NyZJm+4D2ScFFc7FFgo7iRky9c2TM+
         UA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=yBeHD2cmlPPvkgQ3TABI3Ii2blBxXQrLxscG19jxl1I=;
        b=1CUwLUe4zeGYwlILP14enCr/ykolyy32LeH7Qd0cc2c7TB52yHEHEg8Q7rONoT+25/
         IScnq+y+UADM73dCkJ5SGI4znWdjnYUz18tdLEVPuoxiZFchDGYb3KyZ8TpnSnLSfJUC
         mLvqW0v51O5/xtRXAJkFkowriU0XR4oim2zIyjXtV/NTLB+v14pw/n8Gm38A/Kls/9bG
         sMt5egk4Cmutmw/3297oNvNqeLy+4B73tlsN4GaDcWm+OdanpyDd/0/TnhiCFnd1Ldyt
         7epYOxs57dgg/xmCkVN7+rucTgQRGD1hDygVB31Ax2nFoqbw3dL0bZfQ6bhda2yQZESS
         jrlw==
X-Gm-Message-State: AOAM532k1tDtqQ8l+5K5r1WIC9aR/W9J3JypDXS6zJ2xXgWiiA19o9CF
        5/w78Wu7WlpKIK1lDBfj95TVtdvFdtACRw==
X-Google-Smtp-Source: ABdhPJyH4ecI7kK0tP45Qq44T+RV3XTSnNFyypad6tToxZyIutRIJoIslpijdmcz3w1BlgvzK0gT1g==
X-Received: by 2002:aa7:cfcb:: with SMTP id r11mr1100872edy.14.1631328309068;
        Fri, 10 Sep 2021 19:45:09 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id n15sm187890edw.70.2021.09.10.19.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 19:45:08 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 4/6] built-ins: "properly" align continued usage output
Date:   Sat, 11 Sep 2021 04:40:44 +0200
References: <cover-0.2-00000000000-20210901T110917Z-avarab@gmail.com>
 <cover-v2-0.6-00000000000-20210910T153146Z-avarab@gmail.com>
 <patch-v2-4.6-4547cc968b1-20210910T153147Z-avarab@gmail.com>
 <xmqqfsucot4f.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqfsucot4f.fsf@gitster.g>
Message-ID: <87v937akzw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 10 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Let's "fix" various "git <cmd> -h" output by "properly" aligning the
>> output in cases where we continue usage output after a "\n". The "fix"
>> and "properly" scare quotes are because this actually makes things
>
> The "A" and "B" *in* scare quotes?

Perhaps I should take a stab at rewriting this, something like:

    Let's start by aligning the strings in the C code so that their
    indentation is correct, in the end it'll still be off due to the
    indentation parse_options() itself adds, but that'll be fixed in a
    subsequent commit. That subsequent commit relies on the indentation
    in the source being consistent.

>> The issue is that we should have whitespace corresponding to the
>> length of the command name here, e.g. in the case of "git ls-remote"
>> it should be 14 characters, or the length of ""git ls-remote
>> ". Instead we had 21 characters in builtin/ls-remote.c, those extra 7
>> characters are the length of "usage: " (and also " or:"). So in the C
>> locale the resulting output aligns nicely:
>>
>>     $ git ls-remote -h
>>     usage: git ls-remote [--heads] [--tags] [--refs] [--upload-pack=3D<e=
xec>]
>>                          [-q | --quiet] [--exit-code] [--get-url]
>>                          [--symref] [<repository> [<refs>...]]
>
> Isn't this aiming for a wrong end goal?  With an overly long
> subcommand name, we'd end up with overly deep indentation of the
> subsequent lines (hence too narrow a space to fit the options).
>
> Rather, wouldn't it be better to aim for a consistent and wide
> enough indentation, like say two tabs, everywhere, no matter how
> long the subcommand name is?

Similarly to the discussion on another patch about whether we should
convert these long lines to [<options>] or not, I think this is really
outside the scope of this series.

In this particular case the indentation remains exactly the same before
this series and after, for the other cases there's usually a change of
1-3 spaces or so, i.e. they were slightly off.

Should we have no indentation at all? Auto re-indent or whatever? Maybe,
but let's start by narrowly fixing code that's clearly a bit off in
functionality from what it's doing & intending to do right now.
