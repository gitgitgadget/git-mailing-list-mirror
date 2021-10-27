Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0E8C433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 01:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B63B60E76
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 01:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237733AbhJ0B6A (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 21:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237704AbhJ0B57 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 21:57:59 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7DEC061570
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 18:55:34 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id h2so1263687ili.11
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 18:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZIsBPCuVNffQAwmPRkW/ceOf0Q+Yxx5R23YIw4btZAw=;
        b=Ky2ejlK4QQ+cNLxYuc0BpeiVc9TPE0Q0ICE07JAy0RoB6QASCNQ0Buj7KS2+75/9To
         lr3jdHXXEJIssNKZKZAMLs6Uln51kxEgN0fK9szo79WBViI6+d4YzkzB+LrrhMzj9zVx
         vx4SlbDYLB3mdjMxu9IgzI92R5RZzta6NEPFxfehPyVGbvspalnTPNIeP3UJeGSSOU41
         69VRqI1mTVMrYvqo+YT8nx/5EvCxr7Qq+obftkADsSxMSYWQ85tX/7Fj2/h/DMSgGlnr
         IE22aF3ZLeBZ6psEampxc8m/Ib8pgedTodW769ex1jUzkGMVldPdg6OIoUw7nDVAVyGD
         wiEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZIsBPCuVNffQAwmPRkW/ceOf0Q+Yxx5R23YIw4btZAw=;
        b=PqWOPsEBuRkHReydDL3qM2lMztZoFwUrjqndaKr2HIMSECDN01YsHTQ22A0UeeUR6F
         BPl4ClLsVQ8EAJk4D1c6Tg/6JDqsgBBX3g/EGsDLEZXSFuFlMDX86iELw+dPYqYT43/M
         GSykYWuTVbqaPKJAyGNL/fuHLwqKm6rP2S93zLop1p/R+6FYbr3rnNogYyAPIwIGpm/s
         yLEgvRktQZnF5+6D7pBQtnE2CkOOzJPDGmBkiGQbw9qEI83FClYNc0GsAbn48m5gpXUu
         lsiQOhgGRwTFqGlN3jiwg/nGgshn68mLIz2jULqjj7IlFS2vETaN861fgOtF9ft/diFA
         KdFA==
X-Gm-Message-State: AOAM530kEVMlx4+kPkVGi4MQmqZZqA/fq+z7A0xlnumzRBvaKoFULJfk
        d2E3XQ8aOZxM8iqT1vnVKxA=
X-Google-Smtp-Source: ABdhPJzy04qFgbhp5H9fYOn7Z8eE/dGlb1hzXdEM8hvrtOcFuOWIxJNULWjFap2KbeHvQrvPUR/QjA==
X-Received: by 2002:a92:7f0e:: with SMTP id a14mr16194094ild.215.1635299733057;
        Tue, 26 Oct 2021 18:55:33 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:51d3:ffb0:5109:cde2? ([2600:1700:e72:80a0:51d3:ffb0:5109:cde2])
        by smtp.gmail.com with ESMTPSA id y5sm2334725ilv.5.2021.10.26.18.55.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 18:55:32 -0700 (PDT)
Message-ID: <b22b894b-af03-c108-a3d5-0072c252f513@gmail.com>
Date:   Tue, 26 Oct 2021 21:55:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 2/3] protocol v2: specify static seeding of clone/fetch
 via "bundle-uri"
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        "Robin H . Johnson" <robbat2@gentoo.org>
References: <cover-0.3-00000000000-20211025T211159Z-avarab@gmail.com>
 <patch-2.3-3ac0539c053-20211025T211159Z-avarab@gmail.com>
 <f2269fc7-1688-d62e-02bb-01c5b5e33143@gmail.com>
 <211026.86cznrzu8g.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <211026.86cznrzu8g.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/26/2021 11:00 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Oct 26 2021, Derrick Stolee wrote:
>> The implementation seems simple enough, which I like. I'm a bit
> 
> I mentally inserted the missing "skeptical/uncertain" etc. here :)

More "uncertain" than "skeptical". The current plan works perfectly
for the current implementation, so there is an element of YAGNI that
could easily lead us to avoid overthinking this.
 
>> your current use of Git config as the back-end, only because it is
>> difficult to be future-proof. As the functionality stands today, the
>> current config design works just fine. Perhaps we don't need to
>> worry about the future, because we can design a new, complementary
>> storage for that extra data. It seems worth exploring for a little
>> while, though. Perhaps we should take a page out of 'git-remote'
>> and how it stores named remotes with sub-items for metadata. The
>> names probably don't need to ever be exposed to users, but it could
>> be beneficial to anyone implementing this scheme.
>>
>> [bundle "main"]
>> 	uri = https://example.com/my-bundle
>> 	uri = https://redundant-cdn.com/my-bundle
>> 	size = 120523
>> 	sha256 = {64hexchars}
>>
>> [bundle "fork"]
>> 	uri = https://cdn.org/my-fork
>> 	size = 334
>> 	sha256 = {...}
>> 	prereq = {oid}
>>
>> This kind of layout has an immediate grouping of data that should
>> help any future plan. Notice how I included multiple "uri" lines
>> in the "main", which helps with your plan for duplicate URIs.
> 
> At first sight I like that config schema much better than my current
> one, in particular how it makes the future-proofed "these N urls are one
> logical URL" case simpler.
> 
> But overall I'm a bit on the fence, and leaning towards keeping what I
> have, not out of any lazynes or wanting to just keep what I have mind
> you.
> 
> But rather that the main benefit of the current one is that it's a 1=1
> mapping to the line-based protocol, and you can say update your URLs as:
> 
>     git config --replace-all uploadpack.bundleUri "$first_url" &&
>     git config --add uploadpack.bundleUri "$second_url"
> 
> Having usually you'd know the URL you'd like to replace, so you can use
> the [value-pattern] of --replace-all, if it's a named section or other
> split-out structure that become a two-step lookup.

Don't forget to use --fixed-value for exact string matching instead of
regex matching!

> Also for testing I've got a (trivial) plumbing tool I'll submit called
> "git ls-remote-bundle-uri" (could be folded into something else I guess)
> to dump the server-side config, it's nice that you can pretty much
> directly copy/paste it into config without needing to adjust it.

With the appropriate helper structs and methods in the product code,
such helper tools will still be simple without being a second place
that is directly aware of how the values are stored to disk. I don't
judge your prototype work that helps you build the feature, but it's
simultaneously not a reason to stick to a design.

> Having said all that I'm not sure I feel strongly about it either way,
> what do you think given the above?

I'm not feeling too strong about it right now. The current design
does not need anything extra, but it also purposefully leaves certain
things open for extension in the future.

The thing I worry about is that there will be two supported ways to
store a list of bundle URIs: a flat list of URIs in the multi-valued
uploadPack.bundleURI config value, but then also a second option that
allows the extensions that arise. It's a layer of complication that
would be nice to avoid if there was an easy way to do it, but the
schema I sketched earlier isn't simple enough to merit a switch right
now. Perhaps someone else will have an idea that accomplishes the
same goal, but also is less complicated?
 
> I think most "real" server operators will use this as
> GIT_CONFIG_COUNT=<n> GIT_CONFIG_{KEY,VALUE}_<1..n>, which can of course
> work with any config schema, but if you've got code generating it on the
> other side naming the targets is probably a slight hassle / confusing.

You'd really overload the environment this way? That's not how I would
approach it, but maybe there is a benefit over writing to the repository's
config file. I suppose that you could store the data in a database and
link it to the repository at runtime instead.

> There's also the small matter of it being consistent with the
> packfile-uri config in its current form, but that shouldn't be a reason
> not to come up with something better. If anything any better suggestion
> (if we go for that) could be supported by it too...

What do you mean about being consistent with packfile-uri? This layer
that we care about isn't even implemented in git.git.

Thanks,
-Stolee
