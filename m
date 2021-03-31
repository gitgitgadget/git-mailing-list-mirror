Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69256C433B4
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 14:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3534660FE4
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 14:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235944AbhCaOFW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 10:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235943AbhCaOEu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 10:04:50 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71330C061574
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 07:04:50 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id u21so30212153ejo.13
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 07:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=J6fvxcJJElkBhMaucToSo8D7EjwGNPj/+9T9uQt8P3g=;
        b=WfiVmkZ8OhkdJd+F5vMRIk5q9gUdzj1HQ+596mkEEksJ+rrVBUWBCWRS5Pt/a7Z5L7
         bQMR3drQTFl+07pe2cxWmZ/nhEQ+1+KU6mlc1y39jewL5oWLQIsbkLv7Qiy+wjte4Ixy
         eX8bNlO5zR7G0eM/x6QGXuEq700tq0HXxW6B5EseYAwVA++bKJ4Ny9Bk9nrRAcdb89RI
         ELKi6PKsF5mea4GTN+HjBPX4M0GxLTwgyOVvOkvIIWuSp9FIoMhe+Oxituy0wlZNHWeC
         ibldgkZiTan4jbVeD+HzqYIaVunkAsAjNhhkWDDX1RRhoo76e70DfrPALBfIfZqXQI/M
         aLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=J6fvxcJJElkBhMaucToSo8D7EjwGNPj/+9T9uQt8P3g=;
        b=Eb+RRHOy9Q1OTPCfGNArBheOpCh47B/1/v4zBVfEpOiyDbg6szvnuzDrc4pYtMwzCB
         liolNW9baswPlPgiry0YnnmVd6sqRLY2OsYnixjZpk/ehiLdzUE5q/bl4OQE5BlWBsR6
         SpHl0Gis5aWqsnIjCKJeaz53/QCoGHWEYpvxkZSM4saYdPNGFXClCWPopUvx4N50pKkW
         5lxTDuXPs7tHQTjzabdyuoJOarX0iZcw4Ml5M5tS+AEA0r+ZNgmlokXeCM2oGf7DwFKd
         YIOx30ywii9bYhNBypRmbGp2vvjA/xZBOwwL/R/S2/KCHVEgZXzLL1uXPJmLpm6bascS
         FBNg==
X-Gm-Message-State: AOAM531OjH4skg4B5/yhdZ26hN1bcpulGlpQldz6j01YKGDW2PbsOzr2
        okkxxHws7cxnyPR53UYH5Lo=
X-Google-Smtp-Source: ABdhPJya3SyL/hZ2nLvDcNH9/dXB54Cy/OL0pZp0CcT2NlLumQsIKeiB8xiCyaEah4dfgbVIpbHqvw==
X-Received: by 2002:a17:906:d10b:: with SMTP id b11mr3724453ejz.144.1617199489107;
        Wed, 31 Mar 2021 07:04:49 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id n6sm1273198eji.37.2021.03.31.07.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 07:04:48 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Andreas =?utf-8?Q?F?= =?utf-8?Q?=C3=A4rber?= 
        <andreas.faerber@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/6] Makefile: make INSTALL_SYMLINKS affect the build
 directory
References: <cover-0.6-00000000000-20210329T161723Z-avarab@gmail.com>
 <cover-0.7-00000000000-20210329T162327Z-avarab@gmail.com>
 <patch-4.7-1089ca3d184-20210329T162327Z-avarab@gmail.com>
 <xmqqo8f1h9ra.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqo8f1h9ra.fsf@gitster.g>
Date:   Wed, 31 Mar 2021 16:04:48 +0200
Message-ID: <87sg4bl8qn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 30 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Change the INSTALL_SYMLINKS flag to also affect whether a built-in
>> like e.g. git-fetch is a symlink or not in git's build directory.
>>
>> This doesn't matter for anything other than as an aid to developers
>> who might be confused about their build not matching the installation,
>> and who'd like to be reminded that e.g. "git-fetch" is a built-in by
>> "ls" coloring appropriately it as a symlink.
>
> I am not with the cause and hence not very interested in this
> "feature".
>
> When there are multiple possible reasons why something is made into
> a symbolic link, the symlink-ness in the build directory cannot
> fundamentally mirror the symlink-ness in the installation, no?
> "git" and "git-fetch" may be in the same directory in the build, but
> their installation directories are different, so they may be
> hardlinked in the former but they may be turned into symlinks in the
> latter.

This won't be the case after 6/6 in INSTALL_FALLBACK_LN_CP. I'll make
some note of it here.

In practice I think this fallback mode is useful to almost nobody, so
being able to have the build directory mirror the install for
development purposes makes things much more obvious.
