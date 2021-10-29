Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9473C433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 18:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA3E460F4B
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 18:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhJ2StO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 14:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbhJ2StL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 14:49:11 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0776BC061203
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 11:46:23 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id v17so10018829qtp.1
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 11:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bo8khXN0R9IOkRFyn/1aN+t3KGO0wsuI+pLsFimBvQk=;
        b=FXkayP6h4JjyBunKmuFl1xT/Q/XOZJFjBX81KJamnPmQHAkGngMDKPFdW7vAICLGMU
         stn+dkSckoftA6REGlz1q1Qz31dajL9/xexuprgzzhZlVQtf36/Hp0WeyDE/7LjdCs74
         tw0dUYQfnRU5CbIZWLV1ej4zTJMSLrX9AJgyFCKvWbCMKAZlyuDb1m8INxJoJFwTgOo0
         0E/cBTWy7FwulA+nloVXTs88uXh22mFoq9dpIjlHddjoSWoqSnL+itMmp2wNM/lXsdZs
         oFlm6dQwu1i/F/yibJLnmEnZqF8yxdfWCaXOtkPJEEtHZbLhgl24P0oEP1Af8DS59Pr5
         yIXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bo8khXN0R9IOkRFyn/1aN+t3KGO0wsuI+pLsFimBvQk=;
        b=juiEvhj2eDog2i2RP5Fl0GxotBxsTZx+1yDTiFKfi2rZ6rPXkxy2WW5nnkeghzUN+6
         Lw2BvtyUDkF5fFFMu7OJJv/Fp1ljNo8t4xDgnduipCJgl/8P9XVTGRTaE9DkESA2koh2
         QgkU4Kbzv6zGGhsBEkfil4dN3LN77cJ1EpIFMzNtLgOxQnGzJv35qlFvu5qmYCqf9XA/
         02tnSQuyk5upK1E1oYQCZ9PUP6HgMz4HJTSOZImME/tmh+QbXrHlIY7LqTLpuGTkljSs
         1P1Pyg9/2lPL8c20VfscmopgguTqz+LASFMqmGjkvvPCDl4f51Spz/JdDHhf1NN9iVh/
         6XeA==
X-Gm-Message-State: AOAM532XDGhuTIy8NGVmlvA8H1U55dXC6GP+8LLxPZqirAva3/kQ+dU0
        kpb5UKG3JW84Rjwq0Xc8cD9ntAYC1B8=
X-Google-Smtp-Source: ABdhPJzkjbUqr1HGVEKgc/2FnvcKEVOoho8Fay/YTi+2m+XVryNI+omgqd6/TIYulHOFX9im9jpbFw==
X-Received: by 2002:a05:622a:174b:: with SMTP id l11mr13380652qtk.405.1635533182034;
        Fri, 29 Oct 2021 11:46:22 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:6463:ee8f:8638:ff1b? ([2600:1700:e72:80a0:6463:ee8f:8638:ff1b])
        by smtp.gmail.com with ESMTPSA id y8sm1257041qtx.0.2021.10.29.11.46.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Oct 2021 11:46:21 -0700 (PDT)
Message-ID: <c9c4e1e7-aaa2-bbad-355b-8439fad93fa7@gmail.com>
Date:   Fri, 29 Oct 2021 14:46:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 0/3] bundle-uri: "dumb" static CDN offloading, spec &
 server implementation
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        "Robin H . Johnson" <robbat2@gentoo.org>
References: <cover-0.3-00000000000-20211025T211159Z-avarab@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <cover-0.3-00000000000-20211025T211159Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/25/2021 5:25 PM, Ævar Arnfjörð Bjarmason wrote:
> This implements a new "bundle-uri" protocol v2 extension, which allows
> servers to advertise *.bundle files which clients can pre-seed their
> full "clone"'s or incremental "fetch"'s from.
> 
> This is both an alternative to, and complimentary to the existing
> "packfile-uri" mechanism, i.e. servers and/or clients can pick one or
> both, but would generally pick one over the other.
> 
> This "bundle-uri" mechanism has the advantage of being dumber, and
> offloads more complexity from the server side to the client
> side.

Generally, I like that using bundles presents an easier way to serve
static content from an alternative source and then let Git's fetch
negotiation catch up with the remainder.

However, after inspecting your design and talking to some GitHub
engineers who know more about CDNs and general internet things than I
do, I want to propose an alternative design. I think this new design
is simultaneously more flexible as well as promotes further decoupling
of the origin Git server and the bundle contents.

Your proposed design extends protocol v2 to let the client request a
list of bundle URIs from the origin server. However, this still requires
the origin server to know about this list. Further, your implementation
focuses on the server side without integrating with the client.

I propose that we flip this around. The "bundle server" should know
which bundles are available at which URIs, and the client should contact
the bundle server directly for a "table of contents" that lists these
URIs, along with metadata related to each URI. The origin Git server
then would only need to store the list of bundle servers and the URIs
to their table of contents. The client could then pick from among those
bundle servers (probably by ping time, or randomly) to start the bundle
downloads.

To summarize, there are two pieces here, that can be implemented at
different times:

1. Create a specification for a "bundle server" that doesn't need to
   speak the Git protocol at all. This could be a REST API specification
   using well-established standards such as JSON for the table of
   contents.

2. Create a way for the origin Git server to advertise known bundle
   servers to clients so they can automatically benefit from faster
   downloads without needing to know about bundle servers.

There are a few key benefits to this approach:

 * Further decoupling. The origin Git server doesn't need to know how
   the bundle server organizes its bundles. This allows maximum flexibility
   depending on whether the bundles are stored in something like a CDN
   (where bundles can't be too big) or some kind of blob storage (where
   they can have arbitrarily large size).

 * The bundle servers could be run completely independently from the
   origin Git server. Organizations could run their own bundle servers to
   host data in the same building as their build farms. As long as they
   can configure the bundle location at clone/fetch time, the origin Git
   server doesn't need to be involved.

While I didn't go so far as to create a clear standard or implement a
prototype in the Git codebase, I created a very simple prototype [1] using
a python script that parses a JSON table of contents and downloads
bundles into the Git repository. Then, I made a 'clone.sh' script that
initializes a repository using the bundle fetcher and fetching the
remainder from the origin Git server. I even computed static bundles for
the git.git repository based on where 'master' has been over several days
in the past month, to give an example of incremental bundles. You can
test the approach all the way to including the fetch to github.com (note
how the GitHub servers were not modified in any way for this).

[1] https://github.com/derrickstolee/bundles

There are a lot of limitations to the prototype, but it hopefully
demonstrates the possibility of using something other than the Git protocol
to solve these problems.

Let me know if you are interested in switching your approach to something
more like what I propose here. There are many more questions about what
information could/should be located in the table of contents and how it can
be extended in the future. I'm interested to explore that space with you.

Thanks,
-Stolee
