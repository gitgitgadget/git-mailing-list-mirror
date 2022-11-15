Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB05C4332F
	for <git@archiver.kernel.org>; Tue, 15 Nov 2022 01:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbiKOBdR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 20:33:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbiKOBdN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 20:33:13 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D812E5
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 17:33:12 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id f27so32678290eje.1
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 17:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SH7xe83mxVsKkozmRCouRGsxxdybv7Nx4G5sWMcD5lg=;
        b=Yb0Cs2pOhNkt2/nzdYu89PqfTN2pA58ex4qX/UJEz3zXV5tADhaTKw74VevC63zL+i
         kFKHXqMq3OZt/b3GQwd/yseEaeNHqJ7OFDwYvWRaMDp/101SOg26jDNijXVLVJT2S5AZ
         d5Rlwz/N9oiT5NV0gHHZCUYKrkZhVVx4NRydW5+NKzhpllq8flJ9KFh8EIY88KdiSBNp
         Ji3Sjw+OELnq5f9f8nDwiZirKvCX7syarPyoepTkySQZzaOjHABViK5ZKfsCY7qyx6FC
         VWBz5ZuxROdHecng63T6GAEoYVobM5aACRROhPdHFCad2ACUYAAo/VQSNe5/d/U/XCh9
         8uZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SH7xe83mxVsKkozmRCouRGsxxdybv7Nx4G5sWMcD5lg=;
        b=8Nz7oK5GDbDFCRxRqSDre67gQZ60UHo43lfah4drgVileWkpKkZThHGw9+FL5Lr2GQ
         yQJSK7CMeqg3NeB+E6WndVJbC5Md6VwEXqni5W65qksEzkaIQMI8CVjRC6FkvPQ++N6X
         BcikM9LQvM9oUBNTH14Ozjdb0KffrO3FYj3jjuHRzKxAQ5/hIsAQF/viIJU0vBZhx2/x
         PkBOFcuipcyx5IEUiHiQHpKO0KshXabkqAumzyBDiIRa9pfzz8DnUSPM4ri6KEEMADSS
         V00J/klcuXIqOhyYEX+6eSDi0ztsuxS7dbnNdVQGgrETsmSM4ah7ErJsCE3i4Ag+eZMO
         ij2w==
X-Gm-Message-State: ANoB5pkEN3PF+ecYUDfcDrv/n4JjfrqgEgtMjRC7NX5IcG/X9b4pqNb+
        BMpPylzByDSxf9NR4+Bvq1M=
X-Google-Smtp-Source: AA0mqf5TKizDov2AuDUHedTqMxJu6qkJZebmNBtJ7C6fGj3lj1jEw9eYXv6xtJtxx/G66RXufOu+fA==
X-Received: by 2002:a17:906:13c6:b0:78d:b5be:e5f with SMTP id g6-20020a17090613c600b0078db5be0e5fmr12079434ejc.601.1668475990750;
        Mon, 14 Nov 2022 17:33:10 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id eo8-20020a056402530800b00458898fe90asm5513609edb.5.2022.11.14.17.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 17:33:10 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oukp2-003LWm-37;
        Tue, 15 Nov 2022 02:33:08 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Robert Coup <robert@coup.net.nz>
Subject: Re: [PATCH v2 00/10] Get rid of "git --super-prefix"
Date:   Tue, 15 Nov 2022 02:27:31 +0100
References: <RFC-cover-0.8-00000000000-20221109T192315Z-avarab@gmail.com>
        <cover-v2-00.10-00000000000-20221114T100803Z-avarab@gmail.com>
        <kl6lk03xnm1h.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <kl6lk03xnm1h.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <221115.868rkdknmz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 14 2022, Glen Choo wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> It's also proposing to replace Glen's one-patch[6], which is working
>> around the problem shown in the test added in 1/10 here. Per
>> downthread of [7] I think Glen was aiming for getting a more narrow
>> fix in case we split off 9/10 here into some later fix.
>>
>> As we're fixing an edge case in something that's always been broken
>> (and thus wouldn't backport) I think it's better to just fix the
>> problem directly, rather than introducing new "--super-prefix" use,
>> just to take it away later.
>
> I still prefer that we take the one-patch to unbreak new releases,
> because partial clone + submodules is absolutely broken (e.g. it's
> already causing quite a lot of headaches at $DAYJOB) and the patch is
> obviously harmless.
>
> And more importantly, it lets us take our time with this series and get
> it right without time pressure. It's not as pressing as, e.g. a
> regression fix, but it does render certain Git setups unusable.
>
> With regards to urgency and when to choose "small and harmless fixes vs
> bigger and better fixes", I think Junio has generally made those calls
> in the past. @Taylor if you have an opinion, I'd love to hear it.

I feel like I'm missing something here. What's the regression? The test
you're adding here didn't work at all until 0f5e8851737 (Merge branch
'rc/fetch-refetch', 2022-04-04), as the command didn't exist yet. That
commit went out with v2.36.0.

If it never worked there's no regression, and we wouldn't be merging
down a fix for older point-releases.

Or is there some case I've missed here which did work before, doesn't
now, but just isn't captured in this test? If so what case is that, and
when did it break?
