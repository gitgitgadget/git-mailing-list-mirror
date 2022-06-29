Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CADACCA47C
	for <git@archiver.kernel.org>; Wed, 29 Jun 2022 12:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbiF2MnC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 08:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233247AbiF2MnB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 08:43:01 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3443136179
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 05:43:00 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id q6so32257395eji.13
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 05:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=m7b8Ya/1APDmQSdWg7I2GL9orgrYKJETD3k/iT+O+G8=;
        b=G3tNRrOPFUvdP7+UyNs26LV+gyEmu9k7dX7kUVVAu0gJ8ykCP7XqzVGAEJ6sa/t2yq
         JtB0dygMp2Pc0vaAQclqic/YiCH3ycuIc+w1k8Y34NMw5MlTigNXQYYlu0Y7xWqRRRDG
         eayfdVapdQL0d2i+1iqUsZVh8Z4n4J0Nb7YB852mTebV0KMIGrQVWpPZHVbg2Ur6TSZG
         Gfv9Zbhv8YS3atIiJc/rJBUaFcpoH7THyweMzXpavh39TO/EeDyqHAhhEfEV/ipmieB8
         dirzRfRfj65E0BqmUmvOEAQ6DKP07yNf73Oklcw7lUO1qAm1u1KmKstgu8HFqUjhxR4M
         2o4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=m7b8Ya/1APDmQSdWg7I2GL9orgrYKJETD3k/iT+O+G8=;
        b=XMYUOTNKCGcALp/KRvhYg8WGq5TcLJivRnXEUddm1UowBIfCN/1JiN+NmsSOSM6C56
         a7nEEBVI7vJTZV95X38UhvB2isbyZiV4gEHqQ+0g74f9TrYriYFHnNIKiiZnS/HE8fVR
         ZbkAfifmjoEpC1GNhp7s/qPJ+gNiQpti63WbYeC232NTq5lsHdvPLKMgwxO7Zg3hfC+A
         /J7KIi9TR/qBnynnRIJEI32cF7o2bICgSWcBA9Qia5TS09ZRL4vYN3XgCQv8abCNRh7u
         dDOEuwFNUKJ9HRYmLx06E6dhmX0tcTGthjt/FnG4j2ARbD68uOjJntGDNPuayibzZRGS
         TzvQ==
X-Gm-Message-State: AJIora8fdZaCQeyqr8Hyj8P2WQ8LIaXsvzFM1K0yjcwncOG9zN8FmAFe
        QAHowkjvlHLelX/jKRwWTj2QNhCM2ss=
X-Google-Smtp-Source: AGRyM1u/ZS7S0uwxhrN0uSJcDNjo2tvXI1iMZ6MRqdwbos9doKmZ7pm0U1koj3GOnNj/6l4Ry82f1g==
X-Received: by 2002:a17:906:8d6:b0:723:42c3:657 with SMTP id o22-20020a17090608d600b0072342c30657mr3064247eje.657.1656506578515;
        Wed, 29 Jun 2022 05:42:58 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id s15-20020a170906500f00b00722dceb3f8bsm7733792ejj.151.2022.06.29.05.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 05:42:57 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o6X20-001yD8-H1;
        Wed, 29 Jun 2022 14:42:56 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Pavel Rappo <pavel.rappo@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: Re: How to reduce pickaxe times for a particular repo?
Date:   Wed, 29 Jun 2022 14:31:15 +0200
References: <CAChcVumN66OxOjag9gPqgLq7gQrgdaEkZAJabusE-gGC7LLVyw@mail.gmail.com>
 <220628.86bkudf19g.gmgdl@evledraar.gmail.com>
 <CAChcVu=w8mxFtXHukZkf-VswchH_sRppCm=0XZbwh=9-Y4P8cg@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CAChcVu=w8mxFtXHukZkf-VswchH_sRppCm=0XZbwh=9-Y4P8cg@mail.gmail.com>
Message-ID: <220629.8635fnfxnz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 28 2022, Pavel Rappo wrote:

> On Tue, Jun 28, 2022 at 12:58 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>
> <snip>
>
>> But eventually you'll simply run into the regex engine being slow
>
> Since I know very little about git internals, I was under a naive
> impression that a significant, if not comparable to that of regex,
> portion of pickaxe's time is spent on computing diffs between
> revisions. So I assumed that there was a way to pre-compute those
> diffs.

Yes and no, maybe sort of :)

Firstly, -S doesn't involve a diff, it's comparing the raw pre-post
image, and seeing how many times we match.

-G does involve computing the diff.

One the one hand we're fast at making diffs, but that really shouldn't
be significant compared to the speed of a regex engine.

The other side of this is that we're really stupid about how we invoke
the regex engine, historical reasons, backwards compatibility & all
that, but we:

 * Aren't compiling the regex once, and using it N times in some cases
   (I have some local patches to fix this)
 * Are computing matches one line at a time, when we could e.g. point
   PCRE to an entire diff with the right line-split options.
 * Are often doing needless work, e.g. in v2.33 I solved an issue with
   us continuing to create diffs when we could abort early (see
   f97fe358576 (pickaxe -G: don't special-case create/delete,
   2021-04-12)), which resulted in some speed-up.q

Some of these are tricky to fix.
> <snip>
>
>>  2. Stick that into Lucene with trigram indexing, e.g. ElasticSearch
>>     might make this easy.
>
> <snip>
>
>> For someone familiar with the tools involved that should be about a day
>> to get to a rough hacky solution, it's mostly gluing existing OTS
>> software together.
>
> <snip>
>
> I'll see what I can do with external systems. You see, I initially
> came from a similar repository exposed through OpenGrok. But I think
> that something was wrong with the index or query syntax because I
> couldn't find the things that I knew were there. I was able to secure
> a git repo that was close to that of OpenGrok as I found pickaxe to be
> robust albeit slow alternative for my searches.

This is the first time I hear about OpenGrok, so no idea, sorry.

One common pitfall with search indexes is that they tend to have a
blacklist of words, e.g. Lucene will have "for", "or" and other common
English words as part of its defaults, so if you're trying to e.g. find
when you altered a for-loop you might silently be getting no results.
