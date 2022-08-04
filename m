Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1039C25B06
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 21:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbiHDVAk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 17:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239784AbiHDVAi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 17:00:38 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8900329CA6
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 14:00:36 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id kb8so1484960ejc.4
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 14:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc;
        bh=raL6byptCtB6Q15qVbiQEMSw1n91FAOA6euNYBcnZqs=;
        b=oOsyqwlS9t6twVzsd0NyLPhLLzmVcBOfiS+abHHCMItAKD//AO1kbmMOKenqWvnrbm
         60l3L5OxrJwVixdobbizf+KM8w4fO5Yz5zr0benAY/n58u5cCm1uOsQDshFRWkEn4FFs
         08JvgkXcwTbNxK+mNDhe4tvj5IODwKsOJh+rEf6yjpks9T7QzbnRb1+8SnD0M8JBDIYT
         2mJkYzKh+obL6KIVSIlQUNy61bMKIULgfr/E2WsfdowhQLG6eVNPkAv0bGRvIWYQz1zS
         sO6kufUPda4FKffsjPGifOETpGOR4ijhtuI27k5PYe6lvAv2PRocEVP0Xevk6ohij6J1
         yimw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=raL6byptCtB6Q15qVbiQEMSw1n91FAOA6euNYBcnZqs=;
        b=yC23oKzxmPXc3DjVdQ7Y5w5cIfnp11ytHcM/tRv+u+2nlsMl5P16wrF+G2eDLC4C8c
         PKHz2LDhccgnAwULPOaUY0C7AWmpD2UQCx4BVGjBqLx4cjtec/SHDoMKUve1OZ4mfLTf
         ocZhnady+f4XlKisyKO8fDOwAIumfhF6VcUKhuJcM0p4emhCr7F3wqQfcvoEMj5OfZhf
         Xud+BnhFSelKO/jGrQqcJxSAEn8FKwhXSNttleBFGANovi8zDcIPTvDQVWopi31e6kDB
         UJtGOAZAXWNGfiF/YLHRPG4QgVl+YOw78n7AnsWUI4tdoVWjE7CTthamwRJFoWbGKxfS
         0xCg==
X-Gm-Message-State: ACgBeo3G73QoBlGxnYq76Thu7/eyrnYLLt1IIbf2CL3hv7e2GM6R4ex8
        vrhaz2Kx0OTE3LcibQdPmAs=
X-Google-Smtp-Source: AA6agR4eM5Ocu2YT8bffx1G+a9bmgD1kouvGS38AziVJHHnNXNWFqP+JiGOC5ZoC3BC3xHXzvz/Eig==
X-Received: by 2002:a17:907:7b89:b0:730:8649:983c with SMTP id ne9-20020a1709077b8900b007308649983cmr2607555ejc.542.1659646834834;
        Thu, 04 Aug 2022 14:00:34 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id f4-20020a17090631c400b00730661374ffsm711842ejf.134.2022.08.04.14.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 14:00:34 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oJhxJ-0005mu-10;
        Thu, 04 Aug 2022 23:00:33 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Matthew John Cheetham <mjcheetham@outlook.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        dyroneteng@gmail.com, Johannes.Schindelin@gmx.de,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 2/2] bundle-uri: add example bundle organization
Date:   Thu, 04 Aug 2022 22:29:26 +0200
References: <pull.1248.v2.git.1656535245.gitgitgadget@gmail.com>
 <pull.1248.v3.git.1658757188.gitgitgadget@gmail.com>
 <a933471c3afdd2c95d4115719c24d79e5e430b4d.1658757188.git.gitgitgadget@gmail.com>
 <AS8PR03MB86898A2F7156918A390296CAC09F9@AS8PR03MB8689.eurprd03.prod.outlook.com>
 <9b1cf24c-dfa9-0a5b-06f7-8942a8ba72ec@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <9b1cf24c-dfa9-0a5b-06f7-8942a8ba72ec@github.com>
Message-ID: <220804.86y1w3sozy.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Aug 04 2022, Derrick Stolee wrote:

> On 8/4/2022 12:09 PM, Matthew John Cheetham wrote:
>> On 2022-07-25 14:53, Derrick Stolee via GitGitGadget wrote:
>>> From: Derrick Stolee <derrickstolee@github.com>
>>>
>>> The previous change introduced the bundle URI design document. It
>>> creates a flexible set of options that allow bundle providers many ways
>>> to organize Git object data and speed up clones and fetches. It is
>>> particularly important that we have flexibility so we can apply future
>>> advancements as new ideas for efficiently organizing Git data are
>>> discovered.
>>>
>>> However, the design document does not provide even an example of how
>>> bundles could be organized, and that makes it difficult to envision how
>>> the feature should work at the end of the implementation plan.
>>>
>>> Add a section that details how a bundle provider could work, including
>>> using the Git server advertisement for multiple geo-distributed servers.
>>> This organization is based on the GVFS Cache Servers which have
>>> successfully used similar ideas to provide fast object access and
>>> reduced server load for very large repositories.
>> Thanks! This patch is helpful guidance for bundle server implementors.
>>> +This example organization is a simplified model of what is used by the
>>> +GVFS Cache Servers (see section near the end of this document) which have
>>> +been beneficial in speeding up clones and fetches for very large
>>> +repositories, although using extra software outside of Git.
>> 
>> Nit: might be a good idea to use "VFS for Git" rather than the old name
>> "GVFS" [1].
>
> The rename from "GVFS" to "VFS for Git" is made even more confusing
> because "the GVFS Protocol" keeps the name since it is independent of
> the virtual filesystem part (and has "gvfs" in the API routes). In
> particular, "the GVFS Cache Servers" provide a repository mirror using
> the GVFS protocol and can be used by things like Scalar (when using
> the microsoft/git fork).
>  
>>> +The bundle provider deploys servers across multiple geographies. Each
>>> +server manages its own bundle set. The server can track a number of Git
>>> +repositories, but provides a bundle list for each based on a pattern. For
>>> +example, when mirroring a repository at `https://<domain>/<org>/<repo>`
>>> +the bundle server could have its bundle list available at
>>> +`https://<server-url>/<domain>/<org>/<repo>`. The origin Git server can
>>> +list all of these servers under the "any" mode:
>>> +
>>> +	[bundle]
>>> +		version = 1
>>> +		mode = any
>>> +		
>>> +	[bundle "eastus"]
>>> +		uri = https://eastus.example.com/<domain>/<org>/<repo>
>>> +		
>>> +	[bundle "europe"]
>>> +		uri = https://europe.example.com/<domain>/<org>/<repo>
>>> +		
>>> +	[bundle "apac"]
>>> +		uri = https://apac.example.com/<domain>/<org>/<repo>
>>> +
>>> +This "list of lists" is static and only changes if a bundle server is
>>> +added or removed.
>>> +
>>> +Each bundle server manages its own set of bundles. The initial bundle list
>>> +contains only a single bundle, containing all of the objects received from
>>> +cloning the repository from the origin server. The list uses the
>>> +`creationToken` heuristic and a `creationToken` is made for the bundle
>>> +based on the server's timestamp.
>> 
>> Just to confirm, in this example the origin server advertises a single
>> URL (over v2 protocol) that points to this example "list of lists"?
>
> No, here the origin server provides the list of lists using the 'bundle-uri'
> protocol v2 command. Using the config file format was an unfortunate choice
> on my part because that actually uses "key=value" lines.
>
> This could be more clear by using that format:
>
>   bundle.version=1
>   bundle.mode=any
>   bundle.eastus.uri=https://eastus.example.com/<domain>/<org>/<repo>
>   bundle.europe.uri=https://europe.example.com/<domain>/<org>/<repo>
>   bundle.apac.uri=https://apac.example.com/<domain>/<org>/<repo>

[I've tried to stay away from the bundle-uri topic for a while, to give
others some space to comment]

On it generally: Your CL goes into some of the saga of it, but briefly
the design I put forward initially assumed that these sort of things
would be offloaded to other protocols.

So, just to take an example of a prominent URL from your "From"
address. AFAICT there isn't a eastus.api.github.com, or
europe.api.github.com, instead it just uses DNS load-balancing for
api.github.com.

See the different IPs you'll get e.g. at
https://www.whatsmydns.net/#A/api.github.com (or from many other such
geoloc-inspecting DNS lookup tools). You can also do the same with
multicast etc.

 We've had some back & fourths on that before. You clearly think this
sort of thing is needed in (some version of) a bundle-uri. I don't
really see why. This sort of load spreading by different DNS naming
hasn't been common in serious production use for a decade or two.

But let's leave that aside, and other things I think we've had diverging
ideas about before (e.g. your spec's explicit cache management, which I
imagined offloading to standard HTTP features).

I do think that:

1) This proposed version would be much stronger if it generally tried to
   justify the features it's putting forward. E.g. just in this case
   (but it applies more generally) it seems to be taken as a given that
   {eastus,europe,apac}.<domain> etc. is the natural way to do that sort
   of load-balancing.

   But the spec doesn't really go into it. Why would someone use that
   instead of setting up GeoDNS (or similar), why does it need to be in
   git's protocol, and not in DNS?

2) I'd really like it clarified in the doc whether it considers itself a
   "living document" amenable to change, or a "spec" that we have to
   stick to.

   I'd like it to be the former, and I think it should be prominently
   noted there (e.g. that it's "EXPERIMENTAL" or whatever).

   I don't think it's a good time investment to argue over every little
   detail of how and why some aspects of bundle-uri should look before
   any of it is in-tree, we can just start with some base functionality,
   and tweak it.

   So if e.g. we find (from real-world benchmarking etc.) that some
   feature of the current spec isn't required (such as this
   GeoDNS-alike) we should be able to remove it, and not say "we can't,
   that's part of 'the spec'".

   Or maybe we keep that (and change something else). The point is that
   I don't think we have the full overview *right now*, and it would be
   regrettable if we prematurely decreed certain things "stable" or
   "specc'd".

I suspect we agree on #2, since your CL mentions a PR that integrates
basically the docs had as part of [1]. So presumably you're aiming for
getting to the end of those PRs, followed by some phase where we attempt
to unify the two, which might mean stripping out some feature(s) from
one or both, and adding others.

Thanks again for pushing this forward!

1. https://lore.kernel.org/git/RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com/

