Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21EE02027C
	for <e@80x24.org>; Thu, 13 Jul 2017 21:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752279AbdGMVxV (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 17:53:21 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:36480 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbdGMVxU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 17:53:20 -0400
Received: by mail-pg0-f48.google.com with SMTP id u62so35665236pgb.3
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 14:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=am9Zofg/6OGJZvWkxdr6OAwvUWfoVaiTJ04XSkFoHb8=;
        b=NRcWV2ZF1a/c/u7eJGgHIh7qPi+gnEPaad7lo3VD2hVzRLzRSSG+lwhQxnY+9ZU2tp
         JEM2A6FNgZ7R/yfOXl1Uk1j1PJ76w8a2S5xXRwsogoaZ0lHvBS+ol41dn+29fAmESPGK
         DP8bzwA8sxpD9fcjD/mrJUsf96nGezPAYoJ3dZooqWnLTACVJmIXX/AE/RoxK/VOREx8
         1WSBlvfZByw8+jApDkvqRmYM35udIK1tf47Yie7bctGIhV7bhd+kIhhDu6MlJnEXyGj/
         R5TsythiCcjiB+wl4K6Q7SZaTcjW8ySX1UVoyXGQYG3yy98rjPBBnzUGTOB2p0gGPFSs
         W2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=am9Zofg/6OGJZvWkxdr6OAwvUWfoVaiTJ04XSkFoHb8=;
        b=H2VlujSLQQxC90kBq/XOjfTopnmOzVyfuOKq4ETewmNIjOUhsET08CiEXRZhHeBswZ
         dTusmWdqg5nPNCn65wr9izCQHaoDKHYmycah2dz6yA7pAcAgAr/mL5IClpNzTohp/bjS
         Tjv/HIf46qiiT1A9qyANgpFZpRgYwMZvI+fsKoBOnEKrayuvXGVcHo6V0hjuWM5jz90I
         mADj0G7AJ3f3nYF3knRbkAOgwbAdqhLavCOcYgiXSTl7TATZ28H41XcBIdbrFRzTYp8H
         KbaMnBx950uPERXM1QlM0/ApPv91j6W0ptL29liNzQq1cA5oappn9x15Sfm+u0aB6udX
         gs3Q==
X-Gm-Message-State: AIVw111PlbHeJJCK0q3fqbMj2+sIgNQ7umNKsYfF7jdLFjSqmq6tFSUz
        1HUXz68yphhi7g==
X-Received: by 10.84.176.3 with SMTP id u3mr12356938plb.134.1499982799279;
        Thu, 13 Jul 2017 14:53:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3079:9e61:8883:4f9c])
        by smtp.gmail.com with ESMTPSA id c82sm14278763pfd.5.2017.07.13.14.53.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Jul 2017 14:53:18 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Subject: Re: Reducing redundant build at Travis?
References: <xmqqeftlz0dv.fsf@gitster.mtv.corp.google.com>
        <CADJMNYmGR8Ti0S77y2ykPdSZB68DrBb8O0wfX6PaezV1+j2bnw@mail.gmail.com>
Date:   Thu, 13 Jul 2017 14:53:17 -0700
In-Reply-To: <CADJMNYmGR8Ti0S77y2ykPdSZB68DrBb8O0wfX6PaezV1+j2bnw@mail.gmail.com>
        (Lars Schneider's message of "Thu, 13 Jul 2017 23:21:34 +0200")
Message-ID: <xmqqiniwt35e.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> On Thu, Jul 13, 2017 at 1:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> I usually try to stay as late as possible to finish all the
>> integration branches in order before pushing out the result; it is
>> more efficient to be able to batch things (for humans).
>>
>> I however noticed that This often means we would have multiple build
>> jobs at Travis for branches and builds on Windows often fails
>
> The Windows build has some kind of problem since June 22.
> Somehow building gitk-git just blocks the build and waits until
> the timeout. I had no time, yet, to investigate this further.
>
>
>> waiting for its response.  Since I tagged the tip of 'maint', and I
>> wanted to give all the build a fair chance to succeed without other
>> build jobs starving it of resources, I pushed out 'maint' and the
>> tag before others, even though I already have all the other
>> integration branches ready.
>>
>> Unfortunately, https://travis-ci.org/git/git/builds/ shows that it
>> does not care if it spawned a job to build the tip of 'maint' and
>> another for 'v2.13.3' that point at the same thing.
>
> That is indeed suprising and wasteful. Looks like other people
> did run into the same issue. How about something like this?
> https://github.com/mockito/mockito/blob/release/2.x/.travis.yml#L26-L29

That unfortunately is exactly what I wanted to avoid.

We'd want to test tagged releases, and we'd want to test usual
updates to integration branches.  It just is that sometimes the tips
of integration branches happen to be at the tagged release, so I'd
prefer to always build tags but skip a branch build if it happens to
be also tagged.  After all, none of the integration branches may
directly point at a tagged release when the tag is pushed out.


