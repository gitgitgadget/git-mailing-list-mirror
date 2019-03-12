Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3D9220248
	for <e@80x24.org>; Tue, 12 Mar 2019 08:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbfCLIxq (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 04:53:46 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37473 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfCLIxq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 04:53:46 -0400
Received: by mail-wm1-f68.google.com with SMTP id x10so1664275wmg.2
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 01:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=4HAq6hhgFkb2kLTZol48YrBxPgGeUHSDLe63BqvrX1I=;
        b=Vxgil+AoIvu9YxCTUUwJ8scBkZTABMZJF3QEqaYbjy3MemQfUh5NfEtSgtxUwTdnhx
         OI0CZ5Q+66sLPOPsGrg+LQBNim8iepMQbiuKf8TP2d1dfsSSeKNNoNc+Izn97FGDFvHQ
         oWGbrNAfG5Hdic5b4GaBiSbe3Aj4K1IOza1et4hQ/YTmRSM0hOckty0QRm/qWER7T3ZL
         WxrzkFqotUj8j2UHOPKZr4P/vBGlJx85y8Un8r6tikyzeVi0HNaWt7Uogel1SR/8HZLh
         ++WI7oCocWSieEQPc6WV1E/Vi7o1yCCS2/rE6rFrpTvMFbdfN7tf0WCA0e6xr98hiAbX
         vzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=4HAq6hhgFkb2kLTZol48YrBxPgGeUHSDLe63BqvrX1I=;
        b=ekoOx91gNKo3IrRpm4dT68xhI14X1brF2w87tc3cP8vzfLTrN8G/8zHyNBgHAOtjrE
         qGNE2sd8nDJJsBvLwwozuPlWPQBJQ7imBCT/WE+n76hUL5jvrvbk+U89OAM7TXN/4bP1
         fr87RQ7m8FHdc5wRwi5jogj7c5fgJ7/WO9oB/iKe/vSB1fZHT866zzPUzS7nqfQWE/hD
         iTjhH12nB+PHOAm0ppgLJHP/mFSjFBUm8QhuPQm/Ewmov1AsWfhV4tU0/7F+ULB0KCx8
         6B6bA1q8S2ydXa3Vuhm5H235sCAi9dyBETKxj7Ouhr9smzLIAqZLRtxO5PL1GgewJ9dU
         cMZQ==
X-Gm-Message-State: APjAAAWz5QrSeYLnwzzgFTO9Jp+1owIJu1M77d79PkeoycHuDvEM3szi
        u2x3wL14ytnje3s0NUyZKDA=
X-Google-Smtp-Source: APXvYqxusT9lraLi8v0wshU01suz7EPidAiH+lBl8BhBWaIfR480kf14hDvCADCyt8Xuh6cphpbO5Q==
X-Received: by 2002:a1c:d18a:: with SMTP id i132mr1530907wmg.27.1552380823534;
        Tue, 12 Mar 2019 01:53:43 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id z15sm1466954wmi.46.2019.03.12.01.53.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 01:53:42 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeffrey Walton <noloader@gmail.com>,
        Todd Zullinger <tmz@pobox.com>, Git List <git@vger.kernel.org>,
        Marc Stevens <marc@marc-stevens.nl>
Subject: Re: disabling sha1dc unaligned access, was Re: One failed self test on Fedora 29
References: <CAH8yC8k_Zyi89uxTWTrjN65UAAc1L+jLho+P7O7UyvE-LvZuzA@mail.gmail.com>
        <20190308174343.GX31362@zaya.teonanacatl.net>
        <CAH8yC8mg3vjPoof5SDemQ_YiL+7e1ak535U2nFnPbaWJ8xSWOA@mail.gmail.com>
        <CAH8yC8kn=EmEm_UPrnpwaofv97S42Se6FC+hWcm0EHCX-4rewQ@mail.gmail.com>
        <xmqq1s3emapy.fsf@gitster-ct.c.googlers.com>
        <20190311033755.GB7087@sigill.intra.peff.net>
        <CACsJy8CdqbOKu7SHMt_Pz1EtRz08HGpwWHUHoZbUiow_pPh=+A@mail.gmail.com>
        <8cf2fa6c-d742-a2a6-cde7-66cef87b04e8@virtuell-zuhause.de>
        <20190311182328.GB16865@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190311182328.GB16865@sigill.intra.peff.net>
Date:   Tue, 12 Mar 2019 09:53:41 +0100
Message-ID: <8736nscw2y.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 11 2019, Jeff King wrote:

> On Mon, Mar 11, 2019 at 07:15:12PM +0100, Thomas Braun wrote:
>
>> Am 11.03.2019 um 12:58 schrieb Duy Nguyen:
>> > On Mon, Mar 11, 2019 at 10:48 AM Jeff King <peff@peff.net> wrote:
>> >> And AFAIK there is no good way to
>> >> modify the submodule-provided content as part of the build. Why do we
>> >> even have the submodule again? ;P
>> >
>> > Because of dogfooding of course. This is an interesting use case
>> > though. I wonder if people often want to "patch" submodules like this
>> > (and what we could do if that's the case)
>>
>> I usually do the following:
>>
>> - Fork the sub-project
>> - Add a branch with my proposed patches
>> - Update the URL and the commit of the submodule in the super-project
>>
>> This of course requires all users to do
>>
>> git submodule sync
>>
>> which is a bit incovenient, but works.
>
> The problem to me is not that the steps that a developer has to do, but
> rather that we are dependent on the upstream project to make a simple
> fix (which they may not agree to do, or may take a long time to do).
>
> Whereas if we import the content into our repo as a subtree, we are free
> to hack it up as we see fit, and then occasionally pull from upstream
> and reconcile the changes. Changing upstream isn't advisable in the
> general case, but I think makes a lot of sense for small changes
> (especially if you have the discipline to actually get the same or
> similar change pushed upstream).
>
> In this particular case, though, the sha1dc project is pretty
> responsive, so I don't think it's going to be a big deal. It just seems
> like an anti-pattern in general.

There's a at least a couple of aspects to this.

One is whether we should have the submodule in
sha1collisiondetection/. I agree that's probably a bad idea now
per-se. Honestly I wasn't expecting the answer when I submitted the
final patch to switch to it fully to be to the effect of submodules
being too immature for the git project itself to use. So now we're
effectively mid-series, and should maybe just back out.

But the other is the developer social engineering question of how we
strike the right trade-off when we import upstream code.

I fully agree with what you've said in theory, but if we look at what's
happened in practice we as a project are demonstrably not disciplined
enough to manage upstream code like this without overtly perma-forking
it.

E.g. I gave up on updating compat/regex some time ago because of the
various cross-tree patches that had ended up modifying it. Now we can't
just upstream a new engine anymore.

Someone needs to first go through those various modifications, upstream
them one-by-one or prove they're not needed anymore (and many are
portability / obscure compiler fixes, so that's hard...). The
compat/regex isn't unique here, e.g. compat/poll/ is another example of
this.

As far as I can tell none of the people changing that code went through
the process of submitting a parallel upstream fix or seeing if the issue
was fixed upstream and we could just update the code we were carrying,
and of course that gets progressively harder for any one contributor as
our divergence grows.

So even though the theory of the sha1collisiondetection/ submodule +
sha1dc/ code fork is silly, perhaps we've stumbled upon some way where
we at least file an upstream bug for issues we find and fix. As
demonstrated by other such changes that's already leaps and bounds ahead
of what we're usually doing.
