Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF1AC433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 07:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 198BF61AA7
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 07:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbhKSHGY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 02:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbhKSHGY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 02:06:24 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA9EC061574
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 23:03:22 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id x6so26868678edr.5
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 23:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=CzWujlBYJ7HbmjbeS9QoZK7CcsMNv4BpdGSggCwytpc=;
        b=MRRkjWj7WL5enTxacv497+8y7AMQLloLwneH92ZVzZEGhoR2TBMWcIoyxktwe6+KdO
         VH73f+hv9gIIeFDbQcKfjrQL8AGyngwW21xMJjFgh37pSdhS/XoQdCvrUE2+BsYa0Zth
         gDnSY+mCKLNQ6wRiQRpVenQBd3OahnZgyynUAYa3wiFTwbUqQvjI1KJ4fdxKn64u08nC
         JqeuOXvVD/aW9sCVNg+ppP2Lf3JO0XYmt+zEyySTvrgmztnrwXdRVqkQJUWg7Yho9xr1
         RfCCZe2ej7KZXIQhvdV+/OWTWdY+t8zCHSQ7c5Et8xILG901qCadkSy1+L2i8Lc2fFU3
         cFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=CzWujlBYJ7HbmjbeS9QoZK7CcsMNv4BpdGSggCwytpc=;
        b=veVq/68R+/yHPXxKT8/pcfsNvhLFGz8Jl6CfLjN//6Coi8jW0M7k6QrJwBqkTs/hCd
         QXNT8iLi17LbIqfjjK2AXwhc2e40h7o58T5E/ywboMH535v3l0ExCtdmgkzrHgIVaQ7g
         9VoojmPNEUdcm4UQ9L0WmeRS1fenXlAZWLed58lyP5ZDiKiUKSbpDpcDK+VlG73Kn3oQ
         ycTTuGEiQEjvfjgnNA6tNGoc1XG4tueSr+1LEGnX8/xkWxU4fO0w/LavcK2xwnu0Eoi7
         /jIlzq+o2Rj2qMi4jqq11QxJ8Ba24nYORsj/g6g4dOcrSY2jSF1Y9vteO/fgC2B8CMtJ
         dkTg==
X-Gm-Message-State: AOAM531Lda7jGf6r9U8d2dUYExFEquCUM+F8YbX/jaGPNO8z/V+L4hPT
        hKm0REUJf4ZD+fbdBqVI9udTntCmEPw=
X-Google-Smtp-Source: ABdhPJzemFaizeTsRZNTBL/unHONGm4XM2WQ+H8m84b4t+0Mxi0LsH7cGhlW8zzHfmHyr5cuNUr3wg==
X-Received: by 2002:a17:907:7e8e:: with SMTP id qb14mr4661615ejc.562.1637305401038;
        Thu, 18 Nov 2021 23:03:21 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id b11sm1074530edz.50.2021.11.18.23.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 23:03:20 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mnxvb-000a2J-Uo;
        Fri, 19 Nov 2021 08:03:19 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Carlo Arenas <carenas@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Hamza Mahfooz <someguy@effective-light.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v13 3/3] grep/pcre2: fix an edge case concerning ascii
 patterns and UTF-8 data
Date:   Fri, 19 Nov 2021 08:00:30 +0100
References: <20211015161356.3372-1-someguy@effective-light.com>
        <20211015161356.3372-3-someguy@effective-light.com>
        <877dd9i1zj.fsf@igel.home>
        <211115.86fsrxqbvp.gmgdl@evledraar.gmail.com>
        <87o86kv6fh.fsf@igel.home>
        <CAPUEspi=r9EsG8KPvdiD-HM7Drq8ho1yjkN_c_T1e+ZeR4eejg@mail.gmail.com>
        <87fsrwv46h.fsf@igel.home>
        <CAPUEspg8ZUdn+KFz35yG1k9bbfVTe1b+7=+WdMknRS1zu8VcDQ@mail.gmail.com>
        <634c4237-325a-13e8-0a92-09d23bdfb111@web.de>
        <211117.86y25m5wez.gmgdl@evledraar.gmail.com>
        <xmqqczmxxr8o.fsf@gitster.g>
        <c5223004-6db6-e808-f607-d11bd45e7d99@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <c5223004-6db6-e808-f607-d11bd45e7d99@web.de>
Message-ID: <211119.86mtm04og8.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 18 2021, Ren=C3=A9 Scharfe wrote:

> Am 18.11.21 um 19:17 schrieb Junio C Hamano:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
> [...]
>> I guess this is a lot of change in the amount of text involved but
>> the least amount of actual change in the behaviour.  For those with
>> newer PCREv2, the behaviour would be the same as v2.34.0, and for
>> others, the behaviour would be the same as v2.33.0.
>>
>> Having said all that, because the consensus seems to be that the
>> whole "when we should match in UTF mode" may need to be rethought, I
>> think reverting Hamza's [v13 3/3] would be the simplest way to clean
>> up the mess for v2.34.1 that will give us a cleaner slate to later
>> build on, than applying this patch.
>
> Makes sense to me.  It gives a better starting point to solve the issue
> afresh without getting entangled in mind-melting boolean expressions.

Yes, agreed. As noted I haven't had time to dig deeply into this, but
from what I've seen so far there doesn't seem to be any obvious way
forward in terms of a quick fix.

I thought perhaps your patch would be that (but I haven't looked into it
carefully enough), but since you're on-board with reverting & retrying.
