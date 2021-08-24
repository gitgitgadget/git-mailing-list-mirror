Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64082C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 02:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32D5561357
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 02:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbhHXCD7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 22:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbhHXCD6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 22:03:58 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900B6C061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 19:03:15 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id l7-20020a0568302b0700b0051c0181deebso10084036otv.12
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 19:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IRJUBxAZu5ke5Zl/MrY/zH/4s/BXhle9yXSKf27Pk30=;
        b=dVVYXMRTtQ0KWiEigFWGU+12kzVxhYovHmSULmMcWz1LiYRlWJymVdrT3LJANQ0V2T
         98BSDt61dU8FwIO4GPcZivUCvSCxUwGCMoj5ZKMaD9Fn/OQ6gWg+S+lK8MJ7IxF95LjJ
         +iB5HjZiLI61eUICokrav29BreE1ufnPJdNH3+nCViOkySdj8XpLGNXEF8yE9WDL1KaM
         MnclP5NYr0XBaNm3WIUcsbUgU4uG2eXdjXILnYp4c3cphDAdmh2eD+S5GT5u8lEfA/jJ
         cwNCzBigM0AolBHmGQ5Oio4pM8o+2E1QKJMdwQpLCS2016K82d5P8/tmbSnmGtbNPlcj
         aFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IRJUBxAZu5ke5Zl/MrY/zH/4s/BXhle9yXSKf27Pk30=;
        b=L9cWIrYHKJPAgbxWzBqwVd3WtJEnc3/96BH/sxlgR+cwP/oP8Ms1UY51PV9sd1xsGZ
         NgFYw77T+yhTxQdV1w0dwpEh19Ycou7hlC7llOu0LPEXeVbLTkVViWAya/WixyZS6q5b
         0eP2o2Er5ssxV6EgIH9X+NVGBO14uphJJlbS5brXl2/m3qOMiKIp1HrVShn7I19laUTg
         ZeuTRCMpAbKDH63lc6Wzg7r3Gk2litm6hwwfu8PTgpNqcPQZA8bcDWwvFcmGDW4NkBXj
         0XPn401EOPeXqQ1ZtOJkqeuGW8Qjxv58CVk6B8+OSXU8XiUbV/dsdab+ffpbywD1UMzg
         VPlg==
X-Gm-Message-State: AOAM533vUSr6rJ+ARnnwofWPmvkIIm1hpztOUkCzZhSSeUFbEi+WKdCV
        0jz7ybSZTp3F0woMs3mV6UM=
X-Google-Smtp-Source: ABdhPJztPf3DYfbKtjQu11pcaqWDqXDVV5Zn4zxTVqNovKsukbzBBtfQtwmPqnwUVC5I9Uri7vlaAQ==
X-Received: by 2002:aca:f386:: with SMTP id r128mr1182540oih.168.1629770594807;
        Mon, 23 Aug 2021 19:03:14 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:71da:d4eb:b0d6:b514? ([2600:1700:e72:80a0:71da:d4eb:b0d6:b514])
        by smtp.gmail.com with ESMTPSA id a6sm4165198oto.36.2021.08.23.19.03.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 19:03:14 -0700 (PDT)
Subject: Re: [RFC PATCH 00/13] Add bundle-uri: resumably clones, static "dumb"
 CDN etc.
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
References: <RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com>
 <e7fe220b-2877-107e-8f7e-ea507a65feff@gmail.com>
 <87k0kcfdg0.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c56bec68-bf00-f3b0-74b4-fd3e47319000@gmail.com>
Date:   Mon, 23 Aug 2021 22:03:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87k0kcfdg0.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/23/2021 9:28 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Aug 10 2021, Derrick Stolee wrote:
> 
>> On 8/5/2021 11:07 AM, Ævar Arnfjörð Bjarmason wrote:> We're in the 2.33.0 rc cycle, and I'd hoped to have some more prep

(I'll skip the parts where you agree with me.)

>> 3. The bundle-uri feature is focused on "clone" scenarios, and I don't see
>>    how it could be used to help "fetch" scenarios. To be fair, I also have
>>    been vocal about how the packfile-uri feature is very hard to make
>>    helpful for the "fetch" scenario. The benefits to "clone" seem to be
>>    worth the effort alone. I think the bundle-api doubles-down on that
>>    being the core functionality that matters, and that is fine by me. It
>>    sacrifices the flexibility of the packfile-uri with a lower maintenance
>>    burden for servers that want to implement it.
> 
> Not correct, I'm going to have it handle incremental fetches.
> 
> What *is* correct is that the initial RFC patches here entirely punt on
> it (I only hook them into clone.c, no fetch.c).
> 
> I focused on the "clone" case to get to a MVP earlier, and as you note I
> think in practice most users of this will want to only use it for clone
> bootstrapping, and won't care so much about the incremental case.
> 
> But for the "fetch" case we'd simply start fetching the N bundles in
> parallel, and read their headers, then abort fetching any whose header
> declares tips that we already have.

To save network time, we would need to read data as it is streaming
from the network and stop the download when we realize we don't need
the bundle? This seems wasteful, but I'm willing to see it work in
reality before judging it too harshly.

It would be better if the origin Git server could see the tips that
the user has and then only recommend bundles that serve new data.
That requires a closer awareness of which bundles contain which
content.

> So e.g. for a repo with a "big" bundle that's 1 week old, and 7
> incremental bundles for the last 7 days of updates we'd quickly find
> that we only need the last 3 if we updated 4 days ago, based on only
> fetching their headers.

I can attest that using time-based packs can be a good way to catch
up based on pre-computed pack-files instead of generating one on
demand. The GVFS protocol has a "prefetch" endpoint that gives all
pre-computed pack-files since a given timestamp. (One big difference
is that those pack-files contain only commits and trees, not blobs.
We should ensure that your proposal can extend to bundles that serve
filtered repos such as --filter=blob:none.)

The thing that works especially well with the GVFS protocol is that
if we are missing a reachable object from one of those pack-files,
then it is downloaded as a one-off request _when needed_. This allows
the pack-files to be computed by independent cache servers that have
their own clocks and compute their own timestamps and generate these
pack-files as "new objects I fetched since the last timestamp".

This is all to say that your timestamp-based approach will work as
long as you are very careful in how the incremental bundles are
constructed. There can really only be one list of bundles at a time,
and somehow we need those servers to atomically swap their list of
bundles when they are reorganized.

> The client spec is very liberal on "MAY" instead of "MUST" for
> supporting clients. E.g. a client might sensibly conclude that their
> most recent commits are recent enough, and that it would probably be a
> waste of time to fetch the headers of the pointed-to bundles, and just
> do a normal fetch instead.

Sensible. I wouldn't expect anything less.

> The response format is also currently:
> 
>     <URI>[ <optional key-value>*]
> 
> And nothing uses the "optional key-value". One of the main things I had
> in mind was to support something like (none of these key-values are
> specified currently):
> 
>     https://example.com/big.bundle tip=deadbeef1
>     https://example.com/incremental-1.bundle prereq=deadbeef1 tip=deadbeef2
>     https://example.com/incremental-2.bundle prereq=deadbeef2 tip=deadbeef3
> 
> Or:
> 
>     https://example.com/big.bundle type=complete
>     https://example.com/incremental-1.bundle type=incremental
>     https://example.com/incremental-2.bundle type=incremental
> 
> I.e. allow the server to up-front to optionally specify some details
> about the pointed-to-bundles, purely so the client can avoid the work
> and roundtrip of trying to fetch the headers of N pointed-to bundles
> just to see which if any it needs for a clone/fetch.

Ok, this seems like a reasonable way forward. If the bundles are
truly focused on data within a core "trunk" (say, the reflog of
the default branch) then this works. It gets more complicated for
repos with many long-lived branches that merge together over the
span of weeks. I'm talking about extreme outliers like the Windows
OS repository, so take this concern with a grain of salt. The
point is that in that world, a single tip isn't enough sometimes.

...
>> One question I saw Jonathan ask was "can we modify the packfile-uri
>> capability to be better?" I think this feature has enough different goals
>> that they could co-exist. That's the point of protocol v2, right? Servers
>> can implement and advertise the subset of functionality that they think is
>> best for their needs.
> 
> *Nod*, I also think as shown with these patches the overall complexity
> after setting up the scaffolding for a new feature isn't very high, and
> much of it is going away in some generally useful prep patches I'm
> trying to get in...
> 
>> I hope my ramblings provide some amount of clarity to the discussion, but
>> also I intend to show support of the idea. If I was given the choice of
>> which feature to support (I mostly work on the client experience, so take
>> my choice with a grain of salt), then I would focus on implementing the
>> bundle-uri capability _before_ the packfile-uri capability. And that's the
>> best part: more options present more flexibility for different hosts to
>> make different decisions.
> 
> Thanks again. I'll keep you CC'd on future submissions if that's OK.

Sounds good. I'll try to prioritize review.

> One thing I could really use to move this forward is code review of some
> of the outstanding serieses I've got, in particular these two are
> immediately applicable to this one. It's based on the former, and I
> needed to steal one patch from the latter:
> 
> https://lore.kernel.org/git/cover-v4-00.10-00000000000-20210805T011823Z-avarab@gmail.com/
> https://lore.kernel.org/git/cover-v2-0.4-00000000000-20210823T110136Z-avarab@gmail.com/

I'll see what I can contribute here.

Thanks,
-Stolee
