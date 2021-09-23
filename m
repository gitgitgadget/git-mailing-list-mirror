Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665FBC433F5
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 02:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42B406103C
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 02:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238903AbhIWCVd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 22:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238859AbhIWCVc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 22:21:32 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDC0C061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 19:20:01 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id g8so17555125edt.7
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 19:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=19+byU8eMFvUT9bPfRZTSLKamz6yLgI7AgQnpzqhtbs=;
        b=dYRz/8Ju5Ck2St1Uzmsq+kNXx5ioTa+iaiMN3qWz/Kj1bnnWBIUXbHEYDDAUWo2g1K
         qL6KDnW7eB2x8jfN2LQnEGG83AXCGILig6KMr5IRQEIfbez9LftOohOVrMr6JPWKJpGN
         LQmjQyGs5N9oSS54DclhNxz3H9zXCj/RucASLBbYk6Ok/KQLUs1Ym2u9FLU37IBEK3zF
         erLmXOMADQ9QlpeNBb3OJAiZv8wi66/oqXIBxvFJXWNUPheVRnctO3LGJbjC4Js20c7I
         TNRV3wsq0ADgMudapx3b7/cdo2G5QdmQeicLE07yU1JlgSoGxHkIpjFflC7oTcEYKBAQ
         fYZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=19+byU8eMFvUT9bPfRZTSLKamz6yLgI7AgQnpzqhtbs=;
        b=4FwYq/FtH/pQ6+AYEv+P/2SnvWQe1tMUwUVqbBVKKaU6nGWopRAWTTe3Ihy5O3uuDC
         ej8wER4Es0kbclwhq5Z6rQW3mzduWJ190DgT6Gz3ECkzh6vZ+3UUb704KiXoXFf2yOzc
         VttKdEe8yNnL3XWeYcRu4YJQi+hiwHGqNjoPFm5kAAKgoyqhok2iubmFgPy5zJIOYJXV
         bN4nZ6rKdtvJ9w0ljb0XVYujORtyBo5F2vJXZbS8C0nFYyuPlVhTYdDvmk7KN5x0YNTS
         UvRJvPyLvcMLc2GGjNgBD0vNtQvlIETJA7KnF7/DWbqdKVjU+Wn2mVGEzKw8lUj8SKXj
         1meA==
X-Gm-Message-State: AOAM533hTv5wfMKg/F3Ph98LIyiEnJ8wKIUXPTjFAK9LwqWALFesFIh6
        qYrrCI7geZ4YuDIpcpvIV/4=
X-Google-Smtp-Source: ABdhPJw52NKZSlS19HMi17lLR42sqbDzEaDgr1n1ZL61OF8u3Q32usenbgziOo+hteYrJsmHw4hFsA==
X-Received: by 2002:a05:6402:358a:: with SMTP id y10mr2732272edc.238.1632363600245;
        Wed, 22 Sep 2021 19:20:00 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id dh16sm2276109edb.63.2021.09.22.19.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 19:19:59 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH 0/3] Makefile: make "sparse" and "hdr-check" non-.PHONY
Date:   Thu, 23 Sep 2021 04:17:16 +0200
References: <cover-0.3-00000000000-20210921T224944Z-avarab@gmail.com>
 <YUqQzn5vFDpbF5dM@coredump.intra.peff.net>
 <c13b050c-abb9-c669-b92c-930f2b43ce10@ramsayjones.plus.com>
 <YUttpgkU6eCOxMj/@coredump.intra.peff.net>
 <82c3d9fc-32ff-c38a-cb44-873af1fb83d1@ramsayjones.plus.com>
 <xmqqsfxw42c1.fsf@gitster.g> <87pmt05bww.fsf@evledraar.gmail.com>
 <xmqqtuic2igl.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqtuic2igl.fsf@gitster.g>
Message-ID: <878rzo58z4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 22 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> I've got some WIP efforts in other areas to do that for some other
>> rules.
>>
>> The problem is that you need to "mkdir .shrapnel" to create a
>> ".shrapnel/revision.sp". So you need the ".shrapnel/revision.sp" to
>> depend on the ".shrapnel".
>>
>> Except you'll find that the na=C3=AFve implementation of that fails, sin=
ce
>> any file you create will bump the mtime of the containing directory, so
>> you'll keep re-making ".shrapnel/revision.sp" because ".shrapnel"
>> changed, because ".shrapnel/revision.sp" changed...
>
> We depend on GNU make anyway.  Isn't its "order-only-prerequisites"
> feature what you exactly want to use for the above?

It looks like it, and that I should probably take more time one of these
days to read the GNU make manual through.

But in any case, I do think that's worthwhile in general, i.e. you can
depend on %.h and not need to exclude generated %.h that we make
ourselves if we put that into "gen/" or whatever, "clean" also becomes a
lot easier.

But I'd like to leave it for some future effort of moving *.o, *.sp
etc. generated files around, rather than making *.sp an odd special-case
now.
