Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83803C00140
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 18:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241242AbiHES3v (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Aug 2022 14:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241044AbiHES3r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Aug 2022 14:29:47 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1293CBFD
        for <git@vger.kernel.org>; Fri,  5 Aug 2022 11:29:46 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id h125so3503019oif.8
        for <git@vger.kernel.org>; Fri, 05 Aug 2022 11:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=EN9KQeEqYRNEK1+BdxI3Vl+xhwR9eM/vG/qk5PXD61s=;
        b=g2400F+hbwdh/On9vUXk40xdQ2avdRi+3WWAM5pvaFEFh1O66dmao3hOJATCYVm4wd
         XsZCEG2cUdqSt9GA7xgycxpGtARBo05Uqey615yguBZbSsjxA3fyBJvxdfL8itozLvBl
         Qt9/9tx3NfjvJyXIfW/KT4XNwme7okYM0f9LbVNuQxxWNtN2sU4DNutyxVCdPjkoUWXU
         oH0mIE4aFl5Mv+9okLMytVZ8WmcWlKOfQuzsBJj6QhHx3iYW+/2fgV9H0Ks7EP80B9CY
         XE0XSvyz7ufwGcHT/uwAtx+Z+Vx/r882p0n+bAwI5splDZgQAU4K9rJJA4y21NuEllmg
         hb6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=EN9KQeEqYRNEK1+BdxI3Vl+xhwR9eM/vG/qk5PXD61s=;
        b=69wumvjXyacCyx4qErl8vPrQPLVCEA/0C/3owi4lBav66Jhh0m18fMLZ1YKfYjbbIt
         jcZF6mkt6TX/xwdkngJNyt+yU4C45Asbar0sMF8rQHSQgx7z35KSJNVpyVYT+9uhgCRP
         8JawLvYrz5r9/ktBYBHTu3l4E673AXdHHlbkUCE59UXbIN+ApK6WVrlRme371dT1gNcX
         R65JMZhX88s0BiXwsh1YC0rSvhJ3w4bQTxr8RhCt6WJq/3PQVF/fMMxEcPaidUTI8scM
         n9AD8hs2NYJ+eEVhiDcjcVU7ernqpivQAIRF4sTJAM9ELBkqXfuMf8rou/dxG55jzf2h
         uizQ==
X-Gm-Message-State: ACgBeo1ZNWwP5dXRhkI64gRWFO6C4K3DATEO9D3GFccOCzV1kC1NW1f8
        4jQ0snCEjeyB6giikj2XL682
X-Google-Smtp-Source: AA6agR4GLGF7oNpe2mbUOouS9f+mGDtVoQBkgwly3NrB6UvI6Eo6ibzCTXruvJFXpcKoxKufZWN0Pg==
X-Received: by 2002:a05:6808:2187:b0:33a:c507:d4f3 with SMTP id be7-20020a056808218700b0033ac507d4f3mr6838133oib.205.1659724185460;
        Fri, 05 Aug 2022 11:29:45 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:3928:8f07:23c6:89bf? ([2600:1700:e72:80a0:3928:8f07:23c6:89bf])
        by smtp.gmail.com with ESMTPSA id r2-20020a9d30c2000000b0061dc5648bf6sm821617otg.6.2022.08.05.11.29.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 11:29:45 -0700 (PDT)
Message-ID: <0d31cca1-ee4c-e33f-fdff-80a85bce7981@github.com>
Date:   Fri, 5 Aug 2022 14:29:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 2/2] bundle-uri: add example bundle organization
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Matthew John Cheetham <mjcheetham@outlook.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        dyroneteng@gmail.com, Johannes.Schindelin@gmx.de,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
References: <pull.1248.v2.git.1656535245.gitgitgadget@gmail.com>
 <pull.1248.v3.git.1658757188.gitgitgadget@gmail.com>
 <a933471c3afdd2c95d4115719c24d79e5e430b4d.1658757188.git.gitgitgadget@gmail.com>
 <AS8PR03MB86898A2F7156918A390296CAC09F9@AS8PR03MB8689.eurprd03.prod.outlook.com>
 <9b1cf24c-dfa9-0a5b-06f7-8942a8ba72ec@github.com>
 <220804.86y1w3sozy.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220804.86y1w3sozy.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/4/2022 4:29 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Aug 04 2022, Derrick Stolee wrote:
> 
>> On 8/4/2022 12:09 PM, Matthew John Cheetham wrote:

>>> Just to confirm, in this example the origin server advertises a single
>>> URL (over v2 protocol) that points to this example "list of lists"?
>>
>> No, here the origin server provides the list of lists using the 'bundle-uri'
>> protocol v2 command. Using the config file format was an unfortunate choice
>> on my part because that actually uses "key=value" lines.
>>
>> This could be more clear by using that format:
>>
>>   bundle.version=1
>>   bundle.mode=any
>>   bundle.eastus.uri=https://eastus.example.com/<domain>/<org>/<repo>
>>   bundle.europe.uri=https://europe.example.com/<domain>/<org>/<repo>
>>   bundle.apac.uri=https://apac.example.com/<domain>/<org>/<repo>
> 
> [I've tried to stay away from the bundle-uri topic for a while, to give
> others some space to comment]
> 
> On it generally: Your CL goes into some of the saga of it, but briefly
> the design I put forward initially assumed that these sort of things
> would be offloaded to other protocols.
> 
> So, just to take an example of a prominent URL from your "From"
> address. AFAICT there isn't a eastus.api.github.com, or
> europe.api.github.com, instead it just uses DNS load-balancing for
> api.github.com.
...
>  We've had some back & fourths on that before. You clearly think this
> sort of thing is needed in (some version of) a bundle-uri. I don't
> really see why. This sort of load spreading by different DNS naming
> hasn't been common in serious production use for a decade or two.

The difference in our proposals is that yours _requires_ using DNS
load-balancing while mine does not require it.

The places where I have deviated from your design are almost entirely
because your design forces certain things on the side of the bundle
provider that I found unacceptable requirements.

> But let's leave that aside, and other things I think we've had diverging
> ideas about before (e.g. your spec's explicit cache management, which I
> imagined offloading to standard HTTP features).
> 
> I do think that:
> 
> 1) This proposed version would be much stronger if it generally tried to
>    justify the features it's putting forward. E.g. just in this case
>    (but it applies more generally) it seems to be taken as a given that
>    {eastus,europe,apac}.<domain> etc. is the natural way to do that sort
>    of load-balancing.
> 
>    But the spec doesn't really go into it. Why would someone use that
>    instead of setting up GeoDNS (or similar), why does it need to be in
>    git's protocol, and not in DNS?

Again, just because you _could_ do something using another technology
doesn't mean that we should require all users to do that to solve
their problems.

Everything is about trade-offs, and one of the most important things
that your proposal lacked was the ability to provide a bundle list that
updates independently of the origin Git server. That requires that the
Git server can advertise a location that contains a bundle list. Once
we have a way to parse a bundle list outside of the Git protocol and a
way to advertise bundle lists in the Git protocol, it is incredibly
easy to provide this ability to advertise multiple geographies in a
list of URIs. Here, the complexity of providing the flexibility is small
compared to the flexibility available to users.

> 2) I'd really like it clarified in the doc whether it considers itself a
>    "living document" amenable to change, or a "spec" that we have to
>    stick to.
> 
>    I'd like it to be the former, and I think it should be prominently
>    noted there (e.g. that it's "EXPERIMENTAL" or whatever).

The living document portion is because the code is not implemented at
the same time as this design document is merged. Having actual code
solidifies the spec a lot more than a design document does on its own.
Having the code implemented provides a way to test things, but also a
released version of the spec becomes something that others depend on.

I'd be fine starting off with "EXPERIMENTAL" just like the sparse-
checkout builtin has, but the longer the code is out in the wild, the
less that EXPERIMENTAL tag offers us to shift things.

Thanks,
-Stolee
