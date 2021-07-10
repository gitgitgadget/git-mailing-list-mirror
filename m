Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395F5C07E95
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 09:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E5DA61375
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 09:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbhGJJIx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 05:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbhGJJIx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 05:08:53 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5723FC0613DD
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 02:06:08 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id eb14so17863960edb.0
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 02:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=gxKiUTfHJXYcfbeYqpaSzxU1r65hHSn2WJuUnbeGB0c=;
        b=FyTiCIqji2PaBTX/EMX/g6rb+6AK0ilavKSsnfM3hJ/yNGSfSAiWOQPWqwsP0mlYSe
         47w3eXH/MXzrKcpcu4MdACfdzAl/oVNaqHZjiRBgcVLbm0O7PAZM39ZgiTMTTiNUAFVi
         YRdeZY9pPIvR/DiaAPyMGIDvYXIfOiFOtxxlGQHawe5mLM3xdZpXLXqubk7avuzoDuoO
         YWpreHVYghci8YB9HkpCV4t032l4YV6UywW2xijFXcCdRXBbxp8usvaQITmXuujKZLue
         NmHt8N5tO4AYhv0arMOdxlJD9DHE0SrpM06PmjZENTztfGFTxCu3mBBUrCFCNWgBdW1W
         9g/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=gxKiUTfHJXYcfbeYqpaSzxU1r65hHSn2WJuUnbeGB0c=;
        b=SDiq9kzWOIVCb+V12qHY79KNAJJVZk1ydZ6XVQeECDTqqyExTok3HmrpuaLKlwjVOt
         VFDRZnv/rZKPQSyOUvNzdpn9FLWIQgBrGUXQzxwYfjnEva/FDNEC2em8E8C60Vf8T/k2
         huPHmmab4jW5wsQfzoy8OPdNKikGXYUKYj74YafHehH3+rhXmOM8vD7NGPt9FQGpQLoq
         CypTF7ir4tktmnnFIBIa4m3vIjgdaZG2Iah4QS8xuFMP3kUOEQFHLaXH8rIRqgg1vQvL
         yq586X6LgtfvvEjMqgCrK9eBz5W1CcESNLc9WsnRdXX0uHOe1+R6PsFNU+hRQjNhgX35
         fPiA==
X-Gm-Message-State: AOAM5309UMTl967V30F1OKfjFJu7rT2ouW/PlUrHX+UQQbH58HlXVE1y
        CKw2pyUhKFwvQVcrfP4lzYQ=
X-Google-Smtp-Source: ABdhPJz8P7KfFOkpR99RT2vHhx9TwJHWNEUlsf0eFVk5WYOEr6sb9Ceott82Q7gsQ7rJ0KrVesVNOQ==
X-Received: by 2002:a05:6402:1a38:: with SMTP id be24mr12795285edb.58.1625907966864;
        Sat, 10 Jul 2021 02:06:06 -0700 (PDT)
Received: from evledraar ([109.36.149.59])
        by smtp.gmail.com with ESMTPSA id a25sm3407470edr.21.2021.07.10.02.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 02:06:06 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 3/3] hook-list.h: add a generated list of hooks, like
 config-list.h
Date:   Sat, 10 Jul 2021 11:03:50 +0200
References: <cover-0.3-0000000000-20210617T100239Z-avarab@gmail.com>
 <cover-0.3-0000000000-20210629T183325Z-avarab@gmail.com>
 <patch-3.3-ba7f01f4f6-20210629T183325Z-avarab@gmail.com>
 <YOixxZQDVDKIM8bo@google.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YOixxZQDVDKIM8bo@google.com>
Message-ID: <87wnpy4jyb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 09 2021, Emily Shaffer wrote:

> On Tue, Jun 29, 2021 at 08:54:02PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>  const char *find_hook(const char *name)
>>  {
>>  	static struct strbuf path =3D STRBUF_INIT;
>>=20=20
>> +	if (!known_hook(name))
>> +		die(_("the hook '%s' is not known to git, should be in hook-list.h vi=
a githooks(5)"),
>> +		    name);
>> +
>
> I'm not sure that it's necessary to require this, to be honest. I see a
> use case for wrappers to want to store and run hooks in an idiomatic
> way, and doing so by instructing their users to stick in
> .git/hooks/wrapper-clone (for example) and then calling 'git hook run
> wrapper-clone'. That's doubly compelling in a later config-based-hooks
> world where 'git hook run' gets you free multihook features like
> ordering and parallelism. I will likely want to remove this when
> rebasing my config-based hooks work on top of your restart.

Indeed, FWIW this was part of my general approach of narrowly supporting
existing git behavior only with 'git hook run', i.e. there's no general
"run this thing like a hook for me" now, so we're not losing anything by
not having it support that.

But yes, I can see how "run this script for me as if though it were a
hook" would be useful, will be trivial to support it & still somehow
assert typos/that hook-list.h / githooks.txt is a source of truth about
our known hooks.
