Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C58DC4320E
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 13:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 337F760EE7
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 13:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235655AbhHJN4N (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 09:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbhHJN4M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 09:56:12 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D15AC0613D3
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 06:55:50 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id e14so22371756qkg.3
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 06:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dj0FY3k5nkB9/CdSWu3NwPNUEvt73YlhyvhqRONc/eg=;
        b=nPtShYCulQ7rXGAS1ZB5loTLid9mFh02nMwJ/zRTYIM+xx2OXAqVJL2cctYF3uX81d
         ue54NyYpS+ypR+MZEw/vSlWMSwr5eHFLo3qYuEbxAwHNzJ5/6Hkt2/NYxvhM0WIDk/Yf
         gmNoEb8LjIr9vN2JDdiaDaa0zDV+erFKjMoIEr09NNXpj58WHqONREWDNJDTWAW1P9cW
         sv3sIc9KkrCP5honddE5Yh3RHENqN7tM/C3uEdFZV7mgiI6I833v5PmsOeTfavsy61ya
         8FpOX/b/KsbLsfXOLJE8FjkQ1Va29ChS1iWPiOZIJCx4a0ip9rH/hu2nUkaRtfaLRwCD
         m4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dj0FY3k5nkB9/CdSWu3NwPNUEvt73YlhyvhqRONc/eg=;
        b=fuLI1IdqaSmcrQ6YZN1B0Jr4QXuc8bdXRTWvii7ucmKQi5YH0cY3Nwvw4A/kecj6oM
         a8l7iWHUzfyjVAxwsN96QM7oARFw2gb+eSnPWDiK8y3AO9iIaASxvOt5sS5Ud/MORxzl
         0KYZ5EOCZzOEuFlUNisZ9/MrP3wIsy/xrFWK4apBb52FLDjaR+RCE8XuCoTJMDebD1ru
         hZh5QqHjl0adMSKDDyrxudxLr+ag/wX1LiHoBxVp8o+gJMIyO4snBV/4ip7UNeZUJk8j
         BusB+zSYrVFC13kSfEcQcXwoToMUn6R62qo1hj94pVz7djKQddoCXEc2NNcNhTNSQP+e
         vr0g==
X-Gm-Message-State: AOAM532m908TfbwdKcSGzrJGvgboF1DljXKYrJJDFkH6WnbnjyamQMse
        2xPW/UdPcQWAVnres5mhMXw=
X-Google-Smtp-Source: ABdhPJwtnU2UL2/Wg+fw4Jis3YkJPAgXxEUCQpqQ0C6O22eBYRzFfhg4g4jzXcCnirffqkvByPxPDg==
X-Received: by 2002:a05:620a:14b8:: with SMTP id x24mr28909226qkj.475.1628603749017;
        Tue, 10 Aug 2021 06:55:49 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:eca1:9959:196d:81ab? ([2600:1700:e72:80a0:eca1:9959:196d:81ab])
        by smtp.gmail.com with ESMTPSA id m28sm5284964qki.86.2021.08.10.06.55.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 06:55:48 -0700 (PDT)
Subject: Re: [RFC PATCH 00/13] Add bundle-uri: resumably clones, static "dumb"
 CDN etc.
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
References: <RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e7fe220b-2877-107e-8f7e-ea507a65feff@gmail.com>
Date:   Tue, 10 Aug 2021 09:55:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/5/2021 11:07 AM, Ævar Arnfjörð Bjarmason wrote:> We're in the 2.33.0 rc cycle, and I'd hoped to have some more prep
> work for this integrated already, but for now here's something
> interesting I've been working on for early commentary/feedback.

I've taking a brief look at the code, but mostly have thoughts about the
core idea based on reading the documentation. I'll keep my feedback here
restricted to that, especially because I saw some thoughts from Jonathan
that question the idea.

> This adds the the ability to protocol v2 for servers to optimistically
> pre-seed supporting clients with one or more bundles via a new
> "bundle-uri" protocol extension.

To make sure I understand things correctly, I'm going to rewrite the
description of the feature in my own words. Please correct me if I have
misread something.

This presents a new capability for protocol v2 that allows a server to
notify a client that they can download a bundle to bootstrap their object
database, and then come back to the origin server to "catch up" the
remaining new objects since that bundle via a fetch negotiation.

This idea is similar to the packfile-uri feature in that it offloads some
server load to a dumb data store (like a CDN) but differs in a few key
ways:

1. The bundle download does not need to be controlled by the server, and
   the server doesn't even need to know its contents. The client will
   discover the content and share its view in a later negotiation.

2. The packfile-uri could advertise a pack that contains only the large
   reachable blobs, and hence could use the "happy path" for bitmaps to
   compute a packfile containing all reachable objects except these large
   blobs. For the bundle-uri feature to mimic this, the blobs would need
   to be reachable from refs (perhaps shallow tags?) but it would not be
   clear that the negotiation would prevent redownloading those files.
   This is an area to explore and expand upon.

3. The bundle-uri feature is focused on "clone" scenarios, and I don't see
   how it could be used to help "fetch" scenarios. To be fair, I also have
   been vocal about how the packfile-uri feature is very hard to make
   helpful for the "fetch" scenario. The benefits to "clone" seem to be
   worth the effort alone. I think the bundle-api doubles-down on that
   being the core functionality that matters, and that is fine by me. It
   sacrifices the flexibility of the packfile-uri with a lower maintenance
   burden for servers that want to implement it.

The biggest benefit that I see is that the Git server does not need to
worry about whether the bundle has an exact set of data that it expects.
There is no timing issue about whether or not the exact packfile is seeded.
Instead, the server could have a fixed URL for its bundle and update its
contents (atomically) at any schedule without worrying about concurrent
clones being interrupted. From an operational perspective, I find the
bundle-uri a better way to offload "clone" load.

This also depends on that following "git fetch" being easy to serve. In
that sense, it can be beneficial to be somewhat aware of the bundles that
are being served: can we store the bundled refs as reachability bitmaps so
we have those available for the negotiation in the following "git fetch"
operations? This choice seems specific to how the server is deciding to
create these bundles.

It also presents interesting ideas for how to create the bundle to focus
on some core portion of the repo. The "thundering herd" of CI machines
that re-clone repos at a high rate will also be likely to use the
"--single-branch" option to reduce the refs that they will ask for in the
negotiation. In that sense, we won't want a snapshot of all refs at a
given time and instead might prefer a snapshot of the default branch or
some set of highly-active branches.

One question I saw Jonathan ask was "can we modify the packfile-uri
capability to be better?" I think this feature has enough different goals
that they could co-exist. That's the point of protocol v2, right? Servers
can implement and advertise the subset of functionality that they think is
best for their needs.

I hope my ramblings provide some amount of clarity to the discussion, but
also I intend to show support of the idea. If I was given the choice of
which feature to support (I mostly work on the client experience, so take
my choice with a grain of salt), then I would focus on implementing the
bundle-uri capability _before_ the packfile-uri capability. And that's the
best part: more options present more flexibility for different hosts to
make different decisions.

Thanks,
-Stolee
