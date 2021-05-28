Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D19C4708C
	for <git@archiver.kernel.org>; Fri, 28 May 2021 14:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AAF0613B6
	for <git@archiver.kernel.org>; Fri, 28 May 2021 14:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbhE1OT7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 10:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235452AbhE1OTz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 10:19:55 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1C2C061574
        for <git@vger.kernel.org>; Fri, 28 May 2021 07:18:19 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id j9so5032870edt.6
        for <git@vger.kernel.org>; Fri, 28 May 2021 07:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=C+gwunXOfg6+xA1kebIfg8d3iHwBAoNCboalZheRmBU=;
        b=N91NOnvhGSgsCKVqZIRMtzrXMmoY/ko26E/JX26vFWkiWACLMxW7t7FcgURvfu23UM
         KxnhnsXgn+wRotVvvF9uERO/zR5HDLS3gEop7VckuOeo9lN3rxNr315TIuxkJlGH13Mf
         4d2eBv0CfXvT8eHWJ3g5oHVbZ4rMet3sXznmKIyEUa13yWtarTj+SrlqsapNW41Rkrsb
         rBF8xIHUBSRRBWY2RS2AIfv//PHiERUyHGwpbfyvZTS9mqJ/P4xNBsEHbxv2cIuWmOSo
         Dw6eGioJTZm0z44PYVmtQSy5Pbbx28vFIV67Jww/3shsZBArUI9eofQrkiQUO+aIX2Ru
         AC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=C+gwunXOfg6+xA1kebIfg8d3iHwBAoNCboalZheRmBU=;
        b=quR7AlhWsQiMmv780P9Owm6jvByQdL6QLA64/YWkA+atk+AEplLZ7yIKcUJtu5igmB
         cN1eF00BJCoW/XiXXSpJdoTUKCG8q4mGILMAFYfQQmbhNzSfrnQSa4p7jul1G2OptU9w
         q3S38IAupH3vufXQ+OTRAFJkUmXFnKy1coQ8IQec4Lzvvm6xowdd8u6Pqf04Bcla/E11
         GUgdlDPAWdVJM5eU9L+O3eEvD7db5KMfOUKAoTAnCv2nT8ysbR47IsPI7O7SCZVFZz8m
         ZWxa1DsTLtB922ULOhJAJ2oyEuAH14/C55PacrC7st9jsUlgS/Z1mCyEba87D1g7ZUkQ
         raCQ==
X-Gm-Message-State: AOAM531PNyBaiGVLF/7no/9uwntpEqMKPTTlk3/crf26EqnsTvqXUSWY
        /yTe7NmgEFdDPsWkx9ZEujNeCefXAIjjPg==
X-Google-Smtp-Source: ABdhPJxIsA+14Dy5mzO8xtZ6YYRvjocMxnugulWyXoOeGUJiRNY8qtljsGjMt83d3W/ep2mUCOgNaw==
X-Received: by 2002:aa7:c5c6:: with SMTP id h6mr10104275eds.127.1622211497672;
        Fri, 28 May 2021 07:18:17 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id n13sm2422991ejk.97.2021.05.28.07.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 07:18:17 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 30/31] hooks: fix a TOCTOU in "did we run a hook?"
 heuristic
Date:   Fri, 28 May 2021 16:11:21 +0200
References: <87lf80l1m6.fsf@evledraar.gmail.com>
 <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
 <patch-30.31-d93bdc0c294-20210528T110515Z-avarab@gmail.com>
 <b5c0a071-a073-7153-a623-75642a79942e@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <b5c0a071-a073-7153-a623-75642a79942e@gmail.com>
Message-ID: <87lf7z2b88.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, May 28 2021, Bagas Sanjaya wrote:

> On 28/05/21 19.11, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Let's also change this for the push-to-checkout hook. Now instead of
>> checking if the hook exists and either doing a push to checkout or a
>> push to deploy we'll always attempt a push to checkout. If the hook
>> doesn't exist we'll fall back on push to deploy. The same behavior as
>> before, without the TOCTOU race. See 0855331941b (receive-pack:
>> support push-to-checkout hook, 2014-12-01) for the introduction of the
>> previous behavior.
>
> What is TOCTOU? I never hear this term before.

A common race condition[1], time of use, time of check. I.e. in this
case we use the hook first, and then later we check if there's a
hook. Thus we've got a logic error where we're assuming we'll get the
same answer[2] in both instances.

In this case what we plainly want is to just save away whether we did X,
not do X, and then later check if we can do X to see if we did X
earlier.

I think this whole thing is still suspect even with my fix, there's an
inherent assumption here of a single-thread view of the world. I.e. that
you have a user running a git command at a time, and that while our hook
run didn't change the index, a background process might have.

But this probably handles the most common case, i.e. a hook explicitly
changing the index and wanting its invoker to notice, and in any case we
have the single-thread assumption already, so we might as well make it
less buggy/racy.

If you dig through the history we used to do this without the check for
"earlier X?" before for at least one of the hooks, but it got changed to
the current state as an optimization.

1. https://en.wikipedia.org/wiki/TOCTOU
2. I mean, I don't think any programmer assumed it in this case, it was
   just intentional lazyness or a legitimate trade-off, but now that
   it's easy to eliminate the race...
