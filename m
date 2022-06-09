Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C43C433EF
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 16:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239526AbiFIQAc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 12:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbiFIQAb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 12:00:31 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E943A1D0CF
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 09:00:29 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id a10so22556833ioe.9
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 09:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MxA73WKg7lK4ackFoJ6+eyP+vY/7nl14/NsjoVGMTcE=;
        b=I7rI+xqvVIGtr1UKgHW6zJEM7gy9xirY5Eo7xLkyAJL/gTFtinHNyX6QhDROGNEpDG
         F+g9LkJzg6qzj1lQ2BTvvkK6dF1Gn038pUb9tdTCIsOCtHpFfeZisJUiMNqTUHIY6xPP
         QfWx3SuVCI1KzjQGSm+vXWCR9RdyxnLx+lwuns6iQH+7GFkqNf+Obzt8oqiTcAHww0Jg
         etOyy9m+nIAmkLlCtFHjFwTuJcJCbGeYEtHm+vCvC0z7mPmSeGPnV7Zb1boC9geQ9YNU
         dqZE2M3u6FYegXvsTypOuj44UkE+1SS2j+Mweix545rPI+0SIKRKziBvTs5sUCGnJAB8
         McHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MxA73WKg7lK4ackFoJ6+eyP+vY/7nl14/NsjoVGMTcE=;
        b=I/bVMy77Z7y8ZYYXnVSwOUVJ1ViE7rBbvKP1xsnwyVkEDvvrSEGEgzV0Wy5j0gXmPV
         0RNTB8RCnp2YTEKBORH8JEAbS1jUp4AowyNlwZlNcpAe2v3VNTv/WHxrMjoAcR8kAN3q
         BH2WqPm3PtcNQ4a7JCN7evvuORDbZjLmsBucUXBpEHlt4Sj1MNoNBwP3Fftp2+5W/QUc
         vWKrzXHnXz7h9s0InKa/G+Om83ZYLzIa+hLDmTOYcnc7mTFT5aeovIVJNO7GeYvmYgxm
         z8uU9WoHl/19l9Br+JZQlEezbblJAOkmahKjYSRFXZEZiWyNWkWGNUsve5ZfFbURW8WD
         p/cA==
X-Gm-Message-State: AOAM531s5CDCApdGf9If4uBBePbOZ/GjEjZqTOPyfWbl0BoOd/DZHhgp
        zE66W0IIuIt0dhGcWsB1yv5u
X-Google-Smtp-Source: ABdhPJzam03GDjII/jgd9/ixllFA/tIC6MfciXaZ0sS7brqjppY1tsTEmx/VHzNbHWh+R41w41nmGw==
X-Received: by 2002:a02:6619:0:b0:32e:25b7:d9ed with SMTP id k25-20020a026619000000b0032e25b7d9edmr21377381jac.30.1654790429080;
        Thu, 09 Jun 2022 09:00:29 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:e450:cdf5:d20:d4b1? ([2600:1700:e72:80a0:e450:cdf5:d20:d4b1])
        by smtp.gmail.com with ESMTPSA id c7-20020a023b07000000b00331c06bf620sm4251137jaa.154.2022.06.09.09.00.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 09:00:28 -0700 (PDT)
Message-ID: <3d67b69b-fac8-3171-92dc-303ea672efbf@github.com>
Date:   Thu, 9 Jun 2022 12:00:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/6] docs: document bundle URI standard
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de
References: <pull.1248.git.1654545325.gitgitgadget@gmail.com>
 <e771b2971d092af5ea8a47eb708d03e34b284a0f.1654545325.git.gitgitgadget@gmail.com>
 <xmqqtu8x1fd4.fsf@gitster.g>
 <48e722dc-f860-f7a6-36d0-b0106087aef4@github.com>
 <xmqq5ylarhsg.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqq5ylarhsg.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/8/2022 5:01 PM, Junio C Hamano wrote:
> Derrick Stolee <derrickstolee@github.com> writes:
>>> That sounds quite straight-forward.  Do you envision that their
>>> incremental snapshot packfile chains can somehow be shared with the
>>> bundle URI implementations?  Doesn't it make it more cumbersome that
>>> this proposal uses the bundles as the encapsulation format, rather
>>> than packfiles?  As you are sending extra pieces of information on
>>> top of the payload in the form of table-of-contents already, I
>>> wonder if bundle.<id>.uri should point at a bare packfile (instead
>>> of a bundle), while multi-valued bundle.<id>.prerequisite give the
>>> prerequisite objects?  The machinery that is already generating the
>>> prefetch packfiles already know which packfile has what
>>> prerequisites in it, so it rather looks simpler if the solution did
>>> not involve bundles.
>>
>> The prefetch packfiles could be replaced with bundle URIs, if desired.
>> ...
>> So in this world, the bundle URIs could be used as a replacement for
>> downloading these prefetch packfiles (bundles with filter=blob:none)
>> but the bundled refs become useless to the client.
> 
> That's all understandable, but what I was alluding to was to go in
> the other direction.  Since "bundle URI" thing is new, while the
> GVFS Cache Servers already use these prefetch packfiles, it could be
> beneficial if the new thing can be done without bundle files and
> instead with packfiles.  You are already generating these snapshot
> packfiles for GVFS Cache Servers.  So if we can reuse them to also
> serve "git clone" and "git fetch" clients, we can do so without
> doubling the disk footprint.

Now I'm confused as to what you are trying to say, so let me back
up and start from the beginning. Hopefully, that brings clarity so
we can get to the root of my confusion.

The GVFS Cache Servers started as a way to have low-latency per-object
downloads to satisfy the filesystem virtualization feature of the
clients. This initially was going to be the _only_ way clients got
objects until we realized that commit and tree "misses" are very
expensive.

So, the "prefetch packfile" system was developed to use timestamp-
based packs that contain commits and trees. Clients would provide
their latest timestamp and the servers would provide the list of
packfiles to download.

Because the GVFS Protocol still has the "download objects on-demand"
feature, any objects that were needed that were not already in those
prefetch packfiles (including recently-pushed commits and trees)
could be downloaded by the clients on-demand.

This has been successful in production, and in particular is helpful
that cache servers can be maintained completely independently of the
origin Git server. There is some configuration to allow the origin
server to advertise the list of cache servers via the <url>/gvfs/config
REST API, but otherwise they are completely independent.

For years, I've been interested in bringing this kind of functionality
to Git proper, but struggled on multiple fronts:

1. The independence of the cache servers could not use packfile-URIs.

2. The way packfile-URIs happens _within_ a fetch negotiation makes it
   hard to integrate even if we didn't have this independence.

3. If the Git client directly downloaded these packfiles from the
   cache server, then how does it get the remaining objects from the
   origin server?

Ævar's observation that bundles also add ref tips to the packfile is
the key to breaking down this concern: these ref tips give us a way
to negotiate the difference between what the client already has
(including the bundles downloaded from a bundle provider) and what it
wants from the origin Git server. This all happens without any change
necessary to the origin Git server.

And thus, this bundle URI design came about. It takes all of the best
things about the GVFS Cache Server but then layers refs on top of the
time-based prefetch packfiles so a normal Git client can do that
"catch-up fetch" afterwards.

This motivated my "could we use the new bundle URI feature in the
old GVFS Cache Server environment?" comment:

I could imagine updating GVFS Cache Servers to generate bundles
instead (or also) and updating the VFS for Git clients to use the
bundle URI feature to download the data. However, for the sake of not
overloading the origin server with those incremental fetches, we would
probably keep the "only download missing objects on-demand" feature
in that environment. (Hence, the refs are useless to those clients.)

However, you seem to be hinting at "the GVFS Cache Servers seem to
work just fine, so why do we need bundles?" but I think that the
constraints of what is expected at the end of "git clone" or "git
fetch" require us to not "catch up later" and instead complete the
full download during the process. The refs in the bundles are critical
to making that work.
 
> Even if you scrapped the "bundle URI" and rebuilt it as the
> "packfile URI" mechanism, the only change you need is to make
> positive and negative refs, which were available in bundle files but
> not stored in packfiles, available as a part of the metadata for
> each packfile, no?  You'd be keeping track of associated metadata
> (like the .timestamp and .requires fields) in addition to what is in
> the bundle anyway, so...

From this comment, it seems you are suggesting that we augment the
packfile data being served by the packfile-URI feature in order to
include those positive/negative refs (as well as other metadata that
is included in the bundle URI design).

I see two major issues with that:

1. We don't have a way to add that metadata directly into packfiles,
   so we would need to update the file standard or update the
   packfile-URI protocol to include that metadata.

2. The only source of packfile-URI listings come as a response to the
   "git fetch" request to the origin Git server, so there is no way
   to allow an independent server to provide that data.

I hope I am going in the right direction here, but I likely
misunderstood some of your proposed alternatives.

Thanks,
-Stolee
