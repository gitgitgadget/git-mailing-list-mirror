Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90948C4332F
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 14:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiKAOLc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 10:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiKAOLa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 10:11:30 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3431AF14
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 07:11:29 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id u24so12702940edd.13
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 07:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vMlta798ExzLk7T7fjRHVUwbVjdvTtHCO6Wp2INhkmA=;
        b=EAH6hJQFMp3Q8d5LCfKmHOlA9GNzEs7GTg/wYQJMz59TrrjOMhnqCFuPEK33spPqe7
         xk1kf/gyhWIpzewMX1yEgpJYcd3MYK5eMYMSW6aX4jnwm3cqngNgtnr9bOovEbAfEbEB
         uPhkxYG9Lza5xefdU6PCq4hxX6Ycze/lR6riyn9302LrY4PlhSwU/ZRB/uQKI+gFEEdI
         B7xugT93+KWjyFZc4/ehavta1qeK/FqIffikFw2uaNOPoz/fvpCzqfXjkCO2Sx/d98GU
         ESlxc9/CsgmN5qo/u68UIdnGqQ4UxY+IUURWEZH7hXeeiNN/j1wyaXONwrU0dhStg8OT
         EsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vMlta798ExzLk7T7fjRHVUwbVjdvTtHCO6Wp2INhkmA=;
        b=M2z17uLQz8EyakDKURgfOVWH5LBETGuKSaHEQMtNE5L9z8LhEaW6USy0xr9CPi/cO1
         6pnAPabgTssF419rBTN03Sx25xYTf6S8AsnLfLBUsKMl/xpF7CE6MiAfyjEWofoMe+5L
         GbxG9dVYrCm2AMYT7nax5fwhmj+MPfaSNia0Kaixx2YABr4SwjmZ7SP/XKQur2PVq/0O
         rDL6TfbuDV9qqF9u1/22z3IzlWpQ+ZZuntVn0mlzELq0JFYp/PlvjRrRslgbgwQGX+6c
         eEbfDOJPXUcaWl1Clg1yxnCVvf3Sc9H/3zKOXDFO4O2XLOm5c9TrdWONPHzul3I8Owf0
         kdKg==
X-Gm-Message-State: ACrzQf0JPS5z767o7w9rfFRpk/hNa3fnx5KeXRxX7BiJ5iVZNpTQpdOD
        cB+Omt4JBBESatFGoupBzvB88gf3eTXWxQ==
X-Google-Smtp-Source: AMsMyM6bmIm+6rBxgraURZdXl68xuUvtII3TAXoIg7auXz/mgtDh/cXjRn4JehJnphxxrU72NtWhjQ==
X-Received: by 2002:a05:6402:2949:b0:451:fabf:d88a with SMTP id ed9-20020a056402294900b00451fabfd88amr18611454edb.324.1667311887798;
        Tue, 01 Nov 2022 07:11:27 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id g18-20020a17090604d200b0077d37a5d401sm4247258eja.33.2022.11.01.07.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 07:11:27 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oprzC-00BLGm-2Y;
        Tue, 01 Nov 2022 15:11:26 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] t5516/t5601: be less strict about the number of
 credential warnings
Date:   Tue, 01 Nov 2022 15:05:23 +0100
References: <Y2CDrZNgNZ+flJBK@coredump.intra.peff.net>
 <Y2CD6GBl6ORqKsug@coredump.intra.peff.net>
 <221101.861qqn5ovf.gmgdl@evledraar.gmail.com>
 <Y2DNS0W5vgk2Q3qJ@coredump.intra.peff.net>
 <221101.86sfj33wmg.gmgdl@evledraar.gmail.com>
 <Y2Di/5Hgp6IdSuuk@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y2Di/5Hgp6IdSuuk@coredump.intra.peff.net>
Message-ID: <221101.86k04e4ve9.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 01 2022, Jeff King wrote:

> On Tue, Nov 01, 2022 at 09:15:00AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> > So I really didn't revisit this commit much at all, and was just trying
>> > to save Dscho (or Taylor) the work of having to rebase it, if we go wi=
th
>> > my patch 1.
>> >
>> > IMHO it is OK enough as it is, but if I were writing it from scratch I
>> > probably would have given the rationale that the tests are insiting on=
 a
>> > dumb, sub-optimal behavior. And flakes or inconsistencies aside, they
>> > should be asserting only the presence or absence of the message. And
>> > probably would have left each at "grep" and dropped the test_line_count
>> > totally.
>>=20
>> Do you mean that even if we fix the bug and consistently emit one and
>> only one such message you'd like to have the tests not assert that
>> that's the case?
>
> No, I wouldn't mind it, if that is a bug we've fixed. I just mean that
> the tests as written never wanted to say "3 is the absolute right number
> of times to write this message". They only put "3" there because it made
> things pass.

That's one reason, another is to assert current behavior, and to be able
to answer questions like "does this patch change behavior" without
having to recursively diff the trash directory output of a test run,
because everything's so fuzzy.

If and when it's 1 instead of 3, great, adjusting the test isn't a big
deal.

Anyway, we're off into general testing philosophy again, which I think
is off topic here.

>> I do think that UX is important enough to test for, particularly if
>> we've had a bug related to that that we've fixed. I.e. if something in
>> the direction of my [1] goes in.
>
> Sure, I don't mind at all a test for it. In the short-term, if you want
> a test that fails, I'd prefer it be separate so that we can test the
> useful existing behavior that _does_ work. If the multiple-messages bug
> is fixed, I don't mind folding them together into a single test that
> passes.

Right, I'm not saying "keep the flaky test", I'm saying let's keep the
ones we know aren't flaky.

>> > It is not even clear to me that the remote-https is the one being
>> > swallowed (at least, I have not seen an argument or evidence that this
>> > is so; it does seem plausible).
>>=20
>> It is the case, the only ones that are going to be duplicated are the
>> "warn" ones, because for "die" we'll die right away in the parent
>> process.
>
> Right, I understand why "die" produces only one. My question was when we
> produce 2 on Windows (sometimes?) but 3 elsewhere, are we sure it is the
> one from remote-https that is eaten, or could it ever be one of the
> others?

I don't have a test case in front of me, and Johannes didn't provide one
(or even a link to CI output).

But from his description and being familiar with the code I'm pretty
certain isn't not the "die" cases, those are all in-process, and it
happens before we spawn sub-processes, I don't see how that would be
different on Windows.

>> > I thought the point is that the outer program calling the helper would
>> > consistently produce the error, always yielding at least one instance.
>> > The helper one is generally "extra" and undesired.
>>=20
>> Yes, exactly. Which is what my fix[1] the root cause addresses.
>>=20
>> Anyway, I'm just trying to help here. If you/Johannes/others want to go
>> with the "hotfix" as-is that's fine my me.
>>=20
>> I just don't see what the hurry is, it's been this way for two releases,
>> if it's flaky that's been the case for months, I'd think we could just
>> fix the root cause.
>
> It recently bit me twice, so maybe I am giving it more urgency than it
> deserves (or maybe something changed in CI to make it more likely).

Bit you in GitHub Windows CI?

> I do think it would be nice to fix it. I don't love your patch for the
> reasons I replied there (not your fault; it's inherently a crappy and
> complicated problem). In the meantime, I'd like to see CI fixed, as
> it is wasting developer's time. And that's why I called Dscho's
> loosening "good enough". It is hopefully a temporary state anyway.
>
> But I would be just as happy to see a similar patch which just changed
> the 2/3 lines to "-ge 1" (or just a straight grep).

Sure, if we're deciding not to care about tests that are unrelated to
the flakyness problem at hand being loosened.
