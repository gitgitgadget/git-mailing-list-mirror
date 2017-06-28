Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DE7E20209
	for <e@80x24.org>; Wed, 28 Jun 2017 05:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752039AbdF1FL0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Jun 2017 01:11:26 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:36561 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751634AbdF1FLZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2017 01:11:25 -0400
Received: by mail-it0-f68.google.com with SMTP id 185so4507232itv.3
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 22:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=G5duDwCM9PjRa8DPNcuXBBVzQ5exNo/h0zWVuVd02QI=;
        b=axNjxsET8C8qs9DDvc6lmBFWNd6TRpfSw9/FamCpl/LFi8oPvJfNwpEPewLTuJ25wZ
         4DrqE7Hw6CD2+M4gUbUOzgTwix9xYy1YRX84gKjXxAQeys6Yejz6qfjgY0XdYe/JGswv
         uF3TRVQuU1uyWsgbzrl7roqaSPEtbZiZsjDzcYLNr4F8aTdamMqZRf3ZGbWJ/3l+adIy
         d7qVRZLhochWxwBYAiQ+PrfBEPJ8JIDiZW1lx8g/DEHx5FK4CI+Y+pqUbbjvPOAvuW1G
         WSvLtD2Qdae8vLlICur+iXH3renS5BANfPoKxoUL3BKAOK/zZ2AxQdgMqJKZAl23/0Q7
         ybSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=G5duDwCM9PjRa8DPNcuXBBVzQ5exNo/h0zWVuVd02QI=;
        b=MQJJvHKEVlODWQyFfBFVo0g0iyFKxTIQEKUILZhqKf+P66TzuJ8bHGvDhohOZ53q4l
         ccZ+TL4uxZxiiuYTheh9qF3RjZvwL0n36nJ9IjoPSip6wQNnxdaaeGxCSqQcJXvxb/A4
         TCwCK8aRi5M/SErXEDu0rA2/rzGhqNPAfP9voPEeTqxaNk8IUgM61fNQXOBCBsstIBOh
         7TE4obC/gt2cTWMbsHOYrIVpof+GE/Jwr3+rQH8sGqF136zDIBEh/Dh5aprKUK/nQJwr
         EYlEjigRbqQKYv6LXC/PnjtsQ1Os/LvaANnPXFhBGkNB0vV/W7G4HuEbuhQuzJ+xHJ3i
         +JgQ==
X-Gm-Message-State: AKS2vOwoXq7GKDQj6/Jmrewl/IjWAUlQmRgWgiAEiOdzrKwaJnla3t4s
        pBzSFXEhe/HGsjqX8nRLGUOe+i/FJA==
X-Received: by 10.36.84.144 with SMTP id t138mr6404466ita.76.1498626684995;
 Tue, 27 Jun 2017 22:11:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.40.70 with HTTP; Tue, 27 Jun 2017 22:11:24 -0700 (PDT)
In-Reply-To: <20170610134026.104552-1-benpeart@microsoft.com>
References: <20170610134026.104552-1-benpeart@microsoft.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 28 Jun 2017 07:11:24 +0200
Message-ID: <CAP8UFD3LA1WvjOZN9WgzMQhuTTXNX7yKgChgAJsLFHX0Ag17JA@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] Fast git status via a file system watcher
To:     Ben Peart <peartben@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        David Turner <David.Turner@twosigma.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 10, 2017 at 3:40 PM, Ben Peart <peartben@gmail.com> wrote:
> Changes from V4 include:
...

I took a look at this patch series except the last patch ([PATCH v5
7/7] fsmonitor: add a performance test) as Junio reviewed it already,
and had only a few comments on patches 3/7 and 4/7.

I am still not convinced by the discussions following v2
(http://public-inbox.org/git/20170518201333.13088-1-benpeart@microsoft.com/)
about using a hook instead of for example a "core.fsmonitorcommand".

I think using a hook is not necessary and might not be a good match
for later optimizations. For example people might want to use a
library or some OS specific system calls to do what the hook does.

AEvar previously reported some not so great performance numbers on
some big Booking.com boxes with a big monorepo and it seems that using
taskset for example to make sure that the hook is run on the same CPU
improves these numbers significantly. So avoiding to run a separate
process can be important in some cases.
