Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C05C71F404
	for <e@80x24.org>; Fri,  7 Sep 2018 17:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbeIGWG7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 18:06:59 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34083 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbeIGWG7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 18:06:59 -0400
Received: by mail-qt0-f195.google.com with SMTP id m13-v6so17090476qth.1
        for <git@vger.kernel.org>; Fri, 07 Sep 2018 10:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=KSDUA39qW8o1IP4sovtV73dzTqwp3goxYF9vVpCX378=;
        b=jB6GEJLzPfyWBVejgU/l7sNdgW6POXx58zg8+AVXZgCEz2srdOMtltfQPvxTNQIQZb
         0GhaA9aEZmSYqlkIeemYU/ZBA3JFgnSmVuOO/SjdHFxgxaw857WJ3wvOV6aooPHCvkwl
         CL61X0Jod7ayr8Q4ld51JdWLysq+1hGm67fS/c/G7YSXfnl5OCPWAzQL+pR/F//qOa5G
         QT9AGqYvP0TLHNPtJWUrVL8wYXDbVtO6Ff4e+00s2wZizVFgLP6Xeqd7VgS8j7QawtHG
         HIvDL/ewLDdHWdNIQpNnzD56xj7qz+Ngx+/qB5Gi6fMGVsVS7Xxg396MWMJWYdr2qW3L
         tFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=KSDUA39qW8o1IP4sovtV73dzTqwp3goxYF9vVpCX378=;
        b=JsI3YSHXUz5ln0l+AQJTMW+FTTjXSOa6swk+hBm1T3xRb4HjrR436AaflR8DDtgRwQ
         YfasMpEEAog9DxmV6PK6H57wf4S02vCFyAsHaVYJUVkggCGxQrESyVBkf7pUl3mDAc8g
         ppmODls63bkkGe5L5i6gh7XkOdI+tgghA+IK1205IWOAInMKFbwAmTVpg0M1ZmEVO0pe
         Pm0eFmavn5Fe+GLfcK6pdIPPZSmaImsSy2vKE8m9MGqGBZv2R2ZkKwNlPxihJP0zi0EH
         34B48eLhjY7s31+ZV6arQqdYxnm/BFmzSxr7QuFRNGDPzyu7R9/KGMXMBYZlwOi8zz8V
         vvrw==
X-Gm-Message-State: APzg51DpnWQjMOCHTpSJr8XIo2P1tsWTYXqZtNj9xfG2dJrlKFXF8yWJ
        /FoCFrIDr6af8Oc4OTNJ8ihFtZES
X-Google-Smtp-Source: ANB0VdZC6EPPqMg0sZRINjJJ+wPJ1n5X905kANkXZe35HJXEwG+V0FgKY0cLboeB7kSo5+Tt18AzVQ==
X-Received: by 2002:ac8:1978:: with SMTP id g53-v6mr7085544qtk.193.1536341102422;
        Fri, 07 Sep 2018 10:25:02 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:343f:f4ad:2a71:7def? ([2001:4898:8010:0:1d75:f4ad:2a71:7def])
        by smtp.gmail.com with ESMTPSA id x8-v6sm6085685qtx.87.2018.09.07.10.25.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 10:25:01 -0700 (PDT)
Subject: Re: [PATCH 1/2] commit-graph write: add progress output
To:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20180904202729.13900-1-avarab@gmail.com>
 <20180904202729.13900-2-avarab@gmail.com>
 <xmqqin3k7w8b.fsf@gitster-ct.c.googlers.com>
 <c6960252-c095-fb2b-e0bc-b1e6bb261614@gmail.com>
 <87ftylqr4z.fsf@evledraar.gmail.com> <87efe5qqks.fsf@evledraar.gmail.com>
 <20180907171548.GA11708@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <27b2e24c-4f96-b8d9-3c03-68195d447394@gmail.com>
Date:   Fri, 7 Sep 2018 13:25:02 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180907171548.GA11708@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/7/2018 1:15 PM, Jeff King wrote:
> On Fri, Sep 07, 2018 at 05:23:31PM +0200, Ævar Arnfjörð Bjarmason wrote:
>
>> Hrm, no. I spoke too soon because I was conflating "commit-graph write"
>> v.s. "gc". For "gc" we're now with this change just e.g. spending 6
>> seconds on 2015-04-03-1M-git displaying nothing, because we're looping
>> through the commits and finding that we have no new work.
>>
>> So I'm on the fence about this, but leaning towards just taking my
>> initial approch. I.e. it sucks if you're e.g. testing different "git gc"
>> options that we're churning in the background doing nothing, just
>> because we're trying to report how many *new* things we added to the
>> graph.
>>
>> After all, the main point IMNSHO is not to show some diagnostic output
>> of exactly how much work we're doing, that I have 200 new commits with
>> generation numbers or whatever is just useless trivia, but rather to not
>> leave the user thinking the command is hanging.
> I think there's some precedent for your view of things, too. For
> example, "writing objects" counts _all_ of the objects, even though many
> of them are just copying bytes straight from disk, and some are actually
> generating a delta and/or zlib-deflating content.
>
> So it's not the most precise measurement we could give, but it shows
> there's activity, and the "average" movement over many objects tends to
> be reasonably smooth.
>
>> So I think I'll just do what I was doing to begin with and change the
>> message to "Refreshing commit graph generation numbers" or something to
>> indicate that it's a find/verify/compute operation, not just a compute
>> operation.
> So basically yes, I agree with this. :)

Same here. Thanks for the discussion.

-Stolee

