Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CFBC433FE
	for <git@archiver.kernel.org>; Thu, 14 Apr 2022 16:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235635AbiDNQPc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Apr 2022 12:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349697AbiDNP5A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Apr 2022 11:57:00 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA802182
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 08:38:41 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id c6so6846632edn.8
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 08:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=ub2FBTIOeUnbIF3fsLtGENUXnCze1G/9fPSwIXTlqiY=;
        b=PBBH4fkTKj9rpYRf2A2S6bvKidJ/1jVcDPJW4vJuWO7vUncu14GfO307p1sU5jbErw
         nHScrlKyy1V5sSCxci+1D3PbW9BTPgzlUpsMiDu4RVsmoz5W85gbTuomSbpdAmSiqgRf
         GAEVnU5tJ2GRwsLGBoit+teIsZRLUKjU+pn406V0jLyRr/lspTmhFlKLj+mQ2XaLBnp3
         xE+j62U21fHVenUvMdm8oDihUQNC4ybe7TxOe8ueNHK72/jH0Yxfb32Hp4JLGEVNZV2y
         4CXS6CxieVr5z1WlP9mi9FbEXsVodEY9ghoxfE/iL1dhGa/AfnkU4hqCLXDLlUhNs/6j
         MPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=ub2FBTIOeUnbIF3fsLtGENUXnCze1G/9fPSwIXTlqiY=;
        b=uCtwL8C1an9TS7eeP4RTb+aAZXGO4Eoqo97huBTLxwk/q+di4+epfOxiX94jK75X6j
         UN0U0oiP1JI1vBtLdPb5yxQnlENXdpJ43kMmjIgQIMDsJ404Pc9csj7axzYYtGpBdKHp
         3W23kFBIPoK2XU/sIX9KLH7Qb89yVRXqe8yCkzidyy1W3vmSo9wcwJYYsHiz85LS8CzD
         TO0B/fZN6rSbBSJrb+NCbcpf01SmaFKKRdMpQ1/z8Vlkn7W9vHnpqcOHtxw/GtABdLgM
         ut5fm54hq9R3dfKgR/pfk07nFCaR8oV+NRP9eJoe28OO2EoDRwkneOTkjyiIOtW44mZK
         Zrag==
X-Gm-Message-State: AOAM533uukc86H2obo2oO30l3F5rqKpu4Wk9Xv8xQ5+RfK02P3FYsOWR
        64KvK9LJ5X+oeKJg7FKKGF+2IiBGRG96Ig==
X-Google-Smtp-Source: ABdhPJz6AAdlSrEY/KaniBJQ/2/Zh9J7ZbBFAmcnbZHKAgGOaqbBHvO1yBbq8k5dlbxmUwKuyUKfbw==
X-Received: by 2002:a05:6402:cac:b0:410:a920:4e90 with SMTP id cn12-20020a0564020cac00b00410a9204e90mr3668450edb.60.1649950719918;
        Thu, 14 Apr 2022 08:38:39 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id q11-20020a170906144b00b006cf61dfb03esm731624ejc.62.2022.04.14.08.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 08:38:39 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nf1YM-005U8S-KZ;
        Thu, 14 Apr 2022 17:38:38 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH v3] http API: fix dangling pointer issue noted by GCC 12.0
Date:   Thu, 14 Apr 2022 17:27:30 +0200
References: <patch-v2-1.1-777838267a5-20220225T090816Z-avarab@gmail.com>
 <patch-v3-1.1-69190804c67-20220325T143322Z-avarab@gmail.com>
 <Yj4FwuyEW0b5ImEC@nand.local> <xmqqy20x7eqv.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqy20x7eqv.fsf@gitster.g>
Message-ID: <220414.86h76vd69t.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 25 2022, Junio C Hamano wrote:

> Taylor Blau <me@ttaylorr.com> writes:
>
>> On Fri, Mar 25, 2022 at 03:34:49PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 B=
jarmason wrote:
>>> This isn't the only caller that assigns to "slot->finished", see see
>>
>> s/see see/see ?
>>
>>> the assignments in http-walker.c:process_alternates_response() and
>>> http.c:finish_active_slot().
>>>
>>> But those assignments are both to the pointer to our local variable
>>> here, so this fix is correct. The only way that code in http-walker.c
>>> could have done its assignments is to the pointer to this specific
>>> variable.
>>
>> Got it; this is the key piece that I was missing in my earlier review.
>> Sorry about that, this looks completely safe to me now.
>
> It does not exactly look safe to me, though.
>
> With a bit of rewrite, here is what I'd queue for now.  I really
> hope that the pre-release compiler will be fixed soon so that we do
> not have to worry about this patch.

Late reply, sorry.

I don't think the compiler is broken in this case.

Having spelunked in the GCC docs, source, commits involved & in their
bugtracker I don't think they'd consider this broken. It's working as
designed.

Now, of course as with any new compiler warning you might argue that
it's too overzealous, but in this case it's included it a -Wall in GCC
12.0.

The warning is specifically about the local pointer being stored in a
structure that survives the exit of function, and therefore if you were
to dereference that pointer after the function exists the results are
undefined.

Now, we happen to be able to carefully read the code in this case and
reason that we won't be looking at it except in the code that's called
within this function, so in practice we're OK.

But we'd have a bug sneak up on us if that wasn't the case, so it's
safer to NULL this out, which is exactly what the new GCC warning is
concerning itself with.

I.e. it's not promising to narrow itself to only those cases where GCC
can know for absolute certain that it's a *practical* issue.

Which, basically would be asking for it to do as much work to emit it as
it has to do on -fanalyzer, which makes compilation of git.git take
somewhere in the mid-range of double digit minutes for me, instead of
~20s.

So I'd prefer:

 1. Adjust for release etc., but that what I submitted in
    https://lore.kernel.org/git/patch-v3-1.1-69190804c67-20220325T143322Z-a=
varab@gmail.com/
    go in as-is.

 2. If you're convinced this is a compiler bug could you please either
    drop the current version, or rewrite the commit envelope so that
    you're the author?

    I very much appreciate when you do local commit fix-ups for
    rewording, typos, or even rewriting something I did for the better.

    But in this case it's got my name on the envelope & has been
    reworded to say pretty much the exact opposite of what I
    think/believe about this warning.

    Which isn't something wrong or not permitted by the
    license/SOB/whatever.

    I'd just find it confusing when I'll dig this up at some point in
    the future to find my name on it, read the explanation, and then be
    perplexed why I ever thought that about this particular warning
    ... :)

Thanks.
