Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC7FC433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 15:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242644AbhLJPL0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 10:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235073AbhLJPLZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 10:11:25 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988FFC061746
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 07:07:50 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id t5so30564196edd.0
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 07:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Wi6vFi5eIrV29ybf4YBqqBkiyBQ6fQpM8/ruJYtG6Ro=;
        b=Q6yarb/FZ9S7yVlGfRd1I8w2fpcgzj993nszR+UugCki2g/hsuPsaN25O1HLCdgaut
         1xYXoxlcjyBvcDL8Orkka2UlaD7KswU2tb3P8iTeKhLIZ9lqq2p7h6kVrxTYWEybXi1w
         79DVB7NOKRbs2EWnxSVON2ks4AJof/obUp+dcGuFyhPuTXmAje1YnF1BpX3mrikMEI+a
         zY0HWVB/ZaHL5ybliemK3TZ/MZlfWDKCzLckqznbt3F8NS27dWGLS1VjepI/5IytPPPP
         VEp4sYvsRoAQPlMX4nTVQNy8CFIc4PJFsV6AluIcODJDw/mFVpDbUAa35sP2U5rKvEql
         b6pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Wi6vFi5eIrV29ybf4YBqqBkiyBQ6fQpM8/ruJYtG6Ro=;
        b=SxsHl5bvbmFU60JSqiRYVYEYoMaq2jgVld7rwVOooaaNh2TqTCeT9ceGIYaqtwXUox
         lKPC93hMWiaQiE/t7Vcrw8FGliqpkyH7xHnubWkMHrRDnE5wg/42QPHaJe8L3ZCHbSYI
         Rlx+pAk2NAtU8CmJee/3maUMiKxrtrvCiBt/PtKJARdRHan1QxRdwk3ktAX7wMMsrIoM
         EBW9BXcRFTqw/ZkshhkiYrcAAqG4rdlkjVOaMJlZ3lhrC3lgcuE64CJ+ncrTyoYi1yy5
         m9TJphIG68gNoqh+9oXu5urT44lSLDz3TJTNc6xpQVdB//xsaOycBJzRuGVRV2VmE3uN
         ruIg==
X-Gm-Message-State: AOAM533Z0crXksYlthEXntF1CmONPzM757+VA1VRA9dQiTTmASvRjZUN
        YMvnWinRsYEdpNl0se4B7p0=
X-Google-Smtp-Source: ABdhPJxoDOt2mq5mdvNbBtp38jEyZMDHhgp/P7jwp3z1vEJ7PDQ4TIUlwgQwHEmuWvQsJ/9pfYbtiA==
X-Received: by 2002:a05:6402:34d2:: with SMTP id w18mr35569476edc.35.1639148833362;
        Fri, 10 Dec 2021 07:07:13 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ga26sm1597731ejc.11.2021.12.10.07.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 07:07:12 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mvhUN-000MMD-EO;
        Fri, 10 Dec 2021 16:07:11 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH 02/10] range-diff.c: don't use st_mult() for signed
 "int"
Date:   Fri, 10 Dec 2021 15:58:43 +0100
References: <RFC-cover-00.10-00000000000-20211209T191653Z-avarab@gmail.com>
 <RFC-patch-02.10-bd7d014c531-20211209T191653Z-avarab@gmail.com>
 <YbLL/YWbjc/sPRyH@coredump.intra.peff.net>
 <211210.86lf0sdah1.gmgdl@evledraar.gmail.com>
 <YbM85W3N0ySi5k+H@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2112101526540.90@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <nycvar.QRO.7.76.6.2112101526540.90@tvgsbejvaqbjf.bet>
Message-ID: <211210.868rwscxcw.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 10 2021, Johannes Schindelin wrote:

> Hi Peff,
>
> On Fri, 10 Dec 2021, Jeff King wrote:
>
>> On Fri, Dec 10, 2021 at 11:22:59AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 B=
jarmason wrote:
>>
>> > > Dropping the st_mult() does nothing to fix the actual problem (which=
 is
>> > > that this function should use a more appropriate type), but introduc=
es
>> > > new failure modes.
>> >
>> > Yes you're entirely right. I had some stupid blinders on while writing
>> > this. FWIW I think I was experimenting with some local macros and
>> > conflated a testing of the overflow of n*n in gdb with the caste'd
>> > version, which you rightly point out here won't have the overflow issue
>> > at all. Sorry.
>>
>> I'm not sure if this is helpful or not, but this is the minimal fix I
>> came up with that runs the testcase I showed earlier. It's basically
>> just swapping out "int" for "ssize_t" for any variables we use to index
>> the arrays (though note a few are themselves held in arrays, and we have
>> to cross some function boundaries).
>>
>> I won't be surprised if it doesn't hit all cases, or if it even hits a
>> few it doesn't need to (e.g., should "phase" be dragged along with "i"
>> and "j" in the first hunk?). I mostly did guess-and-check on the
>> test-case, fixing whatever segfaulted and then running again until it
>> worked. I didn't even really read the code very carefully.
>>
>> I think you _did_ do more of that careful reading, and broke down the
>> refactorings into separate patches in your series. Which is good. So I
>> think what we'd want is to pick out those parts of your series that end
>> up switching the variable type. My goal in sharing this here is just to
>> show that the end result of the fix can (and IMHO should) be around this
>> same order of magnitude.
>
> I am in favor of this patch. Will you have time to submit this with a
> commit message?

I'd also be happy to pick it up as a massaging of my s/int/intmax_t/
change. I think per[1] that intmax_t is more portable here than ssize_t,
but I'm very likely to be missing something. Corrections most welcome.

Per [1] I ejected that out of my v2 because I think the "cost" being
larger than 1<<16 might not be all that useful. I.e. the limiting that's
in get_correspondences().

But I'll happily admit ignorance on how the actual guts of range-diff
work, I just wanted to fix a segfault I kept running into locally at
some point, and figured I'd submit this RFC.

Doesn't an enlargement of the "int" from an assumed 32 bit unsigned to
say a 64bit unsigned require that 16bit unsigned COST_MAX to be
correspondingly bumped to 32bit unsigned? I.e. we'd define it as 1/2 of
whatever "intmax_t" (or "ssize_t" or "long long int" or whatever) is
defined as?

That may be a question under the umbrella of "=C3=86var doesn't actually
understand range-diff", but think I recall playing with bumping one and
not the other (or bumping COST_MAX too close to the size of the
container type) and running into errors...

1. https://lore.kernel.org/git/211210.86czm4d3zo.gmgdl@evledraar.gmail.com/
