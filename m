Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193B6C433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 19:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiKHTUU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 14:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiKHTUS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 14:20:18 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31926B3B9
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 11:20:17 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 205-20020a2503d6000000b006d2132f6f85so13207532ybd.16
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 11:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rVnDeR3ORbN6jvDaRhso86S+9vJcGaVQxTQab2l9Gks=;
        b=kv6PMY+dNhuOOMvaNZmhYmefw7fELE/RSfHxhfcMtN8ooZzkMNgLD8RP8C6BiQTtNe
         6PTZBJr/E67o6X7MP+upP/OstQdrg1Y3YQAKRqxP3HgaOtHnlWXI7DimB78qQY+RvOcP
         FzjCy+ncVMyWb1NaKlqpAA4SGakgTr8qMMUvS/pUd7EBT++e3OfRdD79p4Bo7aGyR30i
         3XOwr77GiiHi+5BmGjBWOahy+ke8kzfe6FNkStAVTWvFdm6FA5uSqMOR2HLC0QT+mPNJ
         JpEGTTHK4hOTH7jkzpfMPrAOXeTB3Ryi6hqlZSZZXsuTW5z+e1Rfg4XYROWgGQPS18fO
         kmtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rVnDeR3ORbN6jvDaRhso86S+9vJcGaVQxTQab2l9Gks=;
        b=23mRlojK0GRCDI+Gy+R9DT4XaNwQPKrGO9vJPaqqwYslZ3qsfURKyZ4TIq1qAiM2Qy
         pa6yrI1dox/4/0krQzegVjOiM+zZX6Rbm3zeAhsB5vMmv/m9MUUlkADnH0VR+8/i9LRR
         7IVPFT61Kx1xppU377HNEO4PmsT8nMIyD/vy2uQi34Rd0/E8fugn3WgQ8ej9PlPk+OCj
         PiCUuxjGxoLuyseCWNHsKqlqEXA4/MECQMxYtR7o47qfJXtWzcvvTY13eB0hYCX00XON
         iHuwG+XFar7ZP5U9hpGaHjipzmp//RkpsiCzLrlJlLKzlgjQbdgH0My0fraqF2CcX5td
         COcQ==
X-Gm-Message-State: ANoB5pksGmEQhb4bELNQMgzqWttJzxXr0Pyu/Avlof/vb/RgQD+UK57H
        ZW3b1dx/gU9BG2BIjy/yi/KRCeMbt4fIVA==
X-Google-Smtp-Source: AA0mqf663DsM6saYJT7ahPvE+0vsnmN4uGmKtoYdHwRkjUm9SNLRRotqSdbqw/JDplaPDK56uDSxoQzEHg3fhw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a25:7755:0:b0:6d2:ee1b:8b62 with SMTP id
 s82-20020a257755000000b006d2ee1b8b62mr817191ybc.470.1667935216988; Tue, 08
 Nov 2022 11:20:16 -0800 (PST)
Date:   Tue, 08 Nov 2022 11:20:15 -0800
In-Reply-To: <221108.86v8npqonn.gmgdl@evledraar.gmail.com>
Mime-Version: 1.0
References: <cover-0.8-00000000000-20221102T074148Z-avarab@gmail.com>
 <cover-v2-0.9-00000000000-20221108T140501Z-avarab@gmail.com>
 <kl6lh6z947ud.fsf@chooglen-macbookpro.roam.corp.google.com> <221108.86v8npqonn.gmgdl@evledraar.gmail.com>
Message-ID: <kl6ledud45jk.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2 0/9] submodule: tests, cleanup to prepare for built-in
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Tue, Nov 08 2022, Glen Choo wrote:
>
>> [...]
>> Thanks! This addresses all of my comments from v1, and I didn't=20
>> spot any other issues during a quick 2nd pass.
>>
>>   Reviewed-by: Glen Choo <chooglen@google.com>
>
> Thanks for the quick review!
>
> One thing I completely forgot in the v2 CL: The 3/9 here is new. Stictly
> speaking we could skip it, but I wanted to be able to mark the new test
> I added as as leak-free, and fixing the only leak it ran into was
> trivial:
> https://lore.kernel.org/git/patch-v2-3.9-a3529d7f9e0-20221108T140501Z-ava=
rab@gmail.com/
>
> So rather than having another "small leak fix for submodules" topic
> depend on this topic, I think it's OK to just bundle that up with this
> one.

Yes, it looked quite trivial. IMO bundling this was a more efficient use
of time than sending another series.
