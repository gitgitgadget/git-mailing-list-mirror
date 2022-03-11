Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EE1C433F5
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 22:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiCKWoI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 17:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiCKWn7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 17:43:59 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05E21ED4C0
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 14:40:53 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id ay7so10971512oib.8
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 14:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=s9MLO31xJC9N92QqdilfMix/7s+AzUrICBFBGcqOlWM=;
        b=VKCQUarR9skgvuZ9Sd3zxELkERlOXWEEFA3U34AYn3pE+3K6z2c7WBCjjdsXYSC9Ki
         IIKD1aneGgJ3Jg7du3NJ/1oTKbJiXp4asa7Jow8OIO76QybDPaNVrawMdoqmyNA6mdeb
         1oYnivQxLNwTu2TdujWm6v9FuJOMeufsLK61xsIrbjSZRvtt16v1vD3C88ePzwpEfXfC
         zEiciBJUgJyPecY/+1LHt6GFmPBnLK5wujbRDbKV0W4Z4L4UWbVy9/BoSDgi9eQAsEGA
         EsAfGBtO2jT3d+GijfMDhCcKSRlcWL/0px5Q2oXAjQ5stxgpg2LKVt0SA8VxMaS00Bj9
         7hiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=s9MLO31xJC9N92QqdilfMix/7s+AzUrICBFBGcqOlWM=;
        b=TvoxTrCrSv+b80wZqTqjDWBgnNzIjjL7rMR1mu+PWW65/udQZGI2XcxBzrvv/RJ0lE
         EVxGJfKKbroehkS7M6ShVSyjsZlisg+RvKiE8PR2G4MjD/nsGaP3mWbzGF5dCILTjO3F
         JCnBeq9MiXyDGjibporTjImTCJcpG5dtcmi6G7Evt06igxOqgu6zxuwY00c8K5rpNrOc
         ejaABl6COt8ZPMhQKKBCcm2UNsxIOLQlp+gjytE1h0ZP2q4N2UnJcdOIQ2FEtfdXuv+8
         BDzxbGTfT54cO7QkM2YcGFZoG3lUBr7DdwIKNFvCW6nSQCMdKNfxefOUbzXkgALAs/ef
         6p0g==
X-Gm-Message-State: AOAM532rn3/28s1+vbgQqQc2Ciy1HUGB6fHa9CZuS5Z3DIZHNxjHm2xw
        XJa0NAv2hwjBQUOXPzXHahI+9rW9ag7u
X-Google-Smtp-Source: ABdhPJzJDmdWDAwmDYT0lnzDxXH9O2kPLDbuL17NgDIpilEORUlhPYmqfjqfcBH8pNvQ1AMFRjU0fw==
X-Received: by 2002:a05:6870:e3c1:b0:d7:2dc8:7fd0 with SMTP id y1-20020a056870e3c100b000d72dc87fd0mr6549071oad.104.1647034100252;
        Fri, 11 Mar 2022 13:28:20 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id l14-20020a4ac60e000000b002e0e75dcb82sm4073579ooq.12.2022.03.11.13.28.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 13:28:19 -0800 (PST)
Message-ID: <d745488d-d70e-0b1d-ce08-ce276a9d4310@github.com>
Date:   Fri, 11 Mar 2022 16:28:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH v2 00/13] bundle-uri: a "dumb CDN" for git
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        "Robin H . Johnson" <robbat2@gentoo.org>,
        Teng Long <dyroneteng@gmail.com>
References: <cover-0.3-00000000000-20211025T211159Z-avarab@gmail.com>
 <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/11/2022 11:24 AM, Ævar Arnfjörð Bjarmason wrote:
> Per recent discussion[1] this is my not-quite-feature-complete version
> of the bundle-uri capability.  This was sent to the list in some form
> beforfe in [2] and [3].
> 
> Recently Derrick Stolee has sent an alternate implementation of some
> of the same ideas in [4]. Per [1] we're planning to work together on
> getting a version of this into git that makes everyone happy, sending
> what I've got here is the first step in that.

Thanks! It's good to see your intended end-to-end for comparison
before we start the combined effort. I look forward to the additional
details coming next week, because there are a lot of optimizations in
there that will inform our direction.
 
> A high-level summary of the important differences in my approach &
> Derrick's (which I hope I'm summarizing fairly here) is that his
> approach optionally adds a bundle TOC format, that format allows you
> to define topology relationships between bundles to guide a
> (returning) client in what it needs to fetch.
> 
> Whereas the idea in this series is to lean entirely on the client
> downloading bundles & inferring what needs to be done via the
> tip/prereqs listed in the header format of the (existing, not changed
> here) bundle format.
> 
> Both have pros & cons, I started trying to summarize those, but let's
> leave that for later.

I know you were in a rush to deliver this, so I'm going to assume
that "leave that for later" was "I didn't have time to write that
here". The very high-level comparison that I gathered from our
chat were these points:

 1. My version uses the TOC and its "timestamp" heuristic to
    minimize how much data the client needs to download on a "no-op"
    fetch. Your version requires that the client downloads some
    initial range of data from each advertised URI.

 2. My version lets the TOC sit at one well-known URI that can be
    advertised independently of the origin server. I don't see an
    equivalent in yours (so far).

 3. The TOC in my version allows the server advertisement be an "OR"
    (download from any of these locations... some might be closer to
    you than others) and yours is an "AND" (this is the list of
    bundles... you probably need all of them for a full clone). This
    difference is something that can be worked into the advertisement
    to allow both modes, if that is a valuable mechanism.

I'm also interested to see how you allow for someone to create their
own local bundle server that is independent of the origin Git server
(so the bundle-uri advertisement does not help them see the bundles).
Perhaps that's just not part of your design, so will be part of the
combined effort.

> There's also some high-level "journey" differences in the
> two. E.g. Derrick implemented the ability to have "git bundle" itself
> fetch bundles remotely, I don't have that and instead lean entirely on
> the protocol and "fetch". Those differences really aren't important,
> and we can have our cake & eat it too on that front. I.e. end up with
> some sensible intersection (or union) of the tooling.

I agree that this is something to work out later. I think it is nice
to allow the user a way to download bundles from a specific URI if
they happen to have one, but that could easily be embedded into a
'git fetch <bundle-URI>' kind of command. Please redesign this as you
see fit when combining efforts.

> I ran out of time to finish up some of what I had on this topic this
> week, but figured (especially since I'd promised to get it done this
> week) to send what I have now for discussion.
> 
> Things missing & reader's notes:
> 
>  * I had some amendmends to the protocol I meant to distill further
>    into the protocol docs at [5]. Basically omitting the ability to
>    transmit key-values and to have it just be a list of URIs with an
>    optional <header> for each one, which is purely a server-to-client
>    aid (i.e. those headers will be what you'll find in the pointed-to
>    bundles).

As long as early versions of the client can ignore the extra key-value
pairs advertised by later versions without issue, it makes sense to
avoid this in early versions.

It would be nice to delay the use of advertising these headers inline
with the advertisement until more of the idea is made concrete. In
particular, the more we can strip out things in early versions that
can be applied later as an optimization, the better. I'm thinking
specifically about how your incremental fetch story will download only
the headers of the bundles to discover which ones are necessary. That
can also be used in the TOC with a timestamp heuristic to discover
that the client already has all of the information from the latest
bundle, even though the server timestamp advanced. Showing the value
to that case _plus_ the "AND" case of bundle-uri advertisements
would be a nice justification for the complication involved there.

> * This series goes up to "clone", but I also have incremental fetch
>   patches. I ran into an (easily solvable bug) in that & thought it
>   was best to omit it for now. It'll be here soon.
> 
>   Basically for incremental fetch we'll in parallel get the headers
>   for remote bundles, and then do an early abort of those downloads
>   that we deem that we don't need.

This is the main thing I was missing in our earlier discussions
(in August and October): this feature of downloading the headers for
the remote bundles is critical for allowing incremental fetch to
work in your model. It's a clever way to solve the problem.

I'm interested to see how well it performs in real-world scenarios.

I'm imagining a way to incrementally build things from simplest to
most complicated, and it goes in this order:

 0. Implement 'git clone --bundle-uri=<X> <url>' where we expect
    a bundle at the given uri <X>.

 1. Implement 'git clone <url>' to understand a bundle-uri
    advertisement with AND (get all bundles and unbundle them in
    some order before fetching) and OR (get any _one_ of these
    full bundles) logic.

 2. Extend the bundle downloading to understand a TOC, allowing
    the OR advertisement to advertise TOC (perhaps guarded with
    some metadata in the advertisement).

 3. For the TOC model, allow 'git fetch' to update from the TOC.

 4. Extend the AND advertisements to do parallel header-only
    downloads to integrate with 'git fetch'. The implementation
    of these pieces also improve performance of the TOC model.

This is me just spitballing of a way that we can make incremental
progress towards this feature without needing to go super-deep
into one model or the other before we are able to test this
example against real-world bundle server prototypes.

>   Clever (but all standard & boring) use of HTTP caching headers
>   between client & servers then allows the client to not request the
>   same thing again and again. I.e. want less server load on your CDN?
>   Just have the bundles be unique URLs and set appropriate caching
>   headers.

I was hoping that the TOC model would avoid the need for cleverness
at all, but I'm interested to see what we can do with these tricks
in all cases.
 
> * A problem with this implementation (and Derrick's, I believe) is
>   that it keeps a server waiting while we twiddle our thumbs and wget
>   (or equivalent) the bundle(s) locally. If you e.g. clone
>   "chromium.git" the server will get tired of waiting, drop the
>   connection, and unless the bundle is 100% up-to-date the "clone"
>   will fail.

This is absolutely the case with my implementation. I call it out
with comments, but I didn't have a solution in mind other than
"disconnect if necessary, then reconnect."
 
>   The solution to this is to get the bundle headers in parallel, and
>   as soon as we've got them present the OIDs in the headers as "HAVE"
>   to the server, which'll then send us an incremental PACK (and even
>   possibly a packfile-uri) for the difference between those bundle(s)
>   and what its tips are.
> 
>   We can then simply disconnect, download/index-pack everything, and
>   do a connectivity checkat the end.

This is a clever idea and is absolutely something that can be done
as a later step (even after step 4 from my outline above).

>   This requires some careful error handling, e.g. if the resulting
>   repo isn't valid we'll need to retry, and the current negotiation
>   API isn't very happy to negotiate on the basis of OIDs we don't have
>   in the object store (but the protocol handles it just fine).

This is exactly why we shouldn't over-index on that idea too early,
but definitely keep it in our back pockets for a future improvement.

Thanks for the detailed cover letter. I hope to look more closely
at the patches themselves for feedback early next week.

Thanks,
-Stolee
