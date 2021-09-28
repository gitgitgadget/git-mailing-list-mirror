Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DA2C433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 08:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E67E61153
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 08:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239490AbhI1IX3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 04:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239292AbhI1IX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 04:23:28 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78F0C061575
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 01:21:48 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id ba1so22099409edb.4
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 01:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=zctvQluzP7qFGdhrBys5i0JLWmTzd0omZtKtI9NUsiw=;
        b=jk6ksyX3V0NTrDEI0dHdopfeyuL3OZ+ylq4tbQrnoBocXYRbdgzaao/jCMKP59hxT+
         1uHF9wN/6TBZZZuuPNWULgVvlH5+/hxW5z2iSvPxzs90FKvZ7zkQnK870944gD2EI12R
         /GtxyhgJpn6222l6JWF5z+6DEmtYXKchPxmLAOdg7D3ZlGrVmqT/KC0Zch0oNQzMzoxE
         FQTppsofoEhmMR9YxFLuBhmw85wCAQjKSQq4jzffvE9FVJa0UJdc5dlNUELlqrpy7ViO
         IMcfDCEEywzUVCh3pNfSZ94GrHv9hYs+v1ea/ufIiMDHDQXp03LmAR0cNXRzmpPxssQY
         0/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=zctvQluzP7qFGdhrBys5i0JLWmTzd0omZtKtI9NUsiw=;
        b=7tLgA7UKI85CdJ7s3pW7iMI6ohBFC8dXzrX/w8mpKkbkGef8C0N835V3B/fdmEXRGE
         hUgSPhAd4KeRyvXxnXKDqje2J8jqJ9ZmS1hEqvJ/3elo7lWXclgsLevhrZ+gqb0bV5Wa
         AfbGbp208uW+0EFqf+l1bf8Md51RRyyoX7FXfjc92fBZftlqCUwid6i3YBspbxq/D9Bg
         3ajK1lPBGKllbUktqjnQvOySOoS+zOWIbjfjeFyRC3Ria2ALdVCHDKGWmgZ2Y+4sZgyf
         iwCJw/AfLQTE40OJcuZjNiQANjh0oCyy1tzIYioiPDAIIxyRyfkGZeshkf5j4pRqEenz
         ZMRg==
X-Gm-Message-State: AOAM530xhVQbpSY6VMVEnX+thPMXRUlJ378Iy2pO9Fe5ea6znv8z2xgj
        ucsX78GXv8fAbYN/HhktVT8=
X-Google-Smtp-Source: ABdhPJwxlKfb9n781fnBon8UnJCL8HaSSM9SQF0loZokBaOhQz4/3ES+e68NJT8W+PvI5GecPHyCgA==
X-Received: by 2002:a17:907:7785:: with SMTP id ky5mr5275588ejc.247.1632817307439;
        Tue, 28 Sep 2021 01:21:47 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id b5sm4811962edu.13.2021.09.28.01.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 01:21:46 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2021, #08; Mon, 27)
Date:   Tue, 28 Sep 2021 10:07:41 +0200
References: <xmqq8rzhmsi7.fsf@gitster.g>
 <CABPp-BGuzd_TH57-1RvwJQD5r3S3ZkJcuiPnU8aWee8pgzUBEw@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <CABPp-BGuzd_TH57-1RvwJQD5r3S3ZkJcuiPnU8aWee8pgzUBEw@mail.gmail.com>
Message-ID: <87ilylxg85.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 27 2021, Elijah Newren wrote:

[Aside: I quite liked the method of replying to What's Cooking per-topic
in Johannes's replies to
https://lore.kernel.org/git/xmqqsfyf5b74.fsf@gitster.g/; I'm never quite
sure if I should have one E-Mail with all of my comments on other
in-flight work, use existing commentary as a springboard etc. Doing the
latter here]

>> * js/scalar (2021-09-14) 15 commits
>>  - scalar: accept -C and -c options before the subcommand
>>  - scalar: implement the `version` command
>>  - scalar: implement the `delete` command
>>  - scalar: teach 'reconfigure' to optionally handle all registered enlistments
>>  - scalar: allow reconfiguring an existing enlistment
>>  - scalar: implement the `run` command
>>  - scalar: teach 'clone' to support the --single-branch option
>>  - scalar: implement the `clone` subcommand
>>  - scalar: implement 'scalar list'
>>  - scalar: let 'unregister' handle a deleted enlistment directory gracefully
>>  - scalar: 'unregister' stops background maintenance
>>  - scalar: 'register' sets recommended config and starts maintenance
>>  - scalar: create test infrastructure
>>  - scalar: start documenting the command
>>  - scalar: create a rudimentary executable
>>
>>  Add pieces from "scalar" to contrib/.
>>
>>  Will merge to 'next'?
>
> I feel bad for taking so long to take a look, but I finally responded
> with a few comments.  Mostly, I'm glad it's a contrib thing; a lot of
> the config makes sense to me (even if some of it is 'meh' for my
> repository sizes or setup), but two of the config settings would be
> very objectionable if they were a core git command.  Since it's
> contrib, though, it's probably fine to be very opinionated...and
> perhaps even excessively so.  ;-)
>
> However, since Johannes has been away for a couple weeks, maybe give
> him a chance to return and respond to myself and others (and perhaps
> push any updates that occurred to him while on vacation) before
> merging down?

Since the thread at
https://lore.kernel.org/git/87ilz44kdk.fsf@evledraar.gmail.com/ I've
been running with an altered version of Johannes's patches that does the
Makefile integration differently, per my
https://lore.kernel.org/git/87ilz44kdk.fsf@evledraar.gmail.com/.

I've been trickling in some of the Makefile changes that make that
easier (still quite possible on top of "master", I just had some
cleanups). It builds[1], tests[2], installs[3] and participates in any
auxiliary targets like "check-docs", "sparse"[4] (and now my
"sparse-incr") etc.

AFAIKT Johannes's version is so far just doing [1] and [2], and just
optionally if you "make" in the contrib subdirectory.

Junio seemed positive on that direction in [1][2]. Re your comments in
[3]: Right now "scalar" doesn't define any of its own config, but one
way out of some of your comments seems to be to do that.

If it's using its own build system in contrib/scalar that'll happen how
exactly? We keep the main manpage in contrib/scalar/scalar.txt but have
a Documentation/config/scalar.txt? Have "git help --config" grow some
optional mode for scalar-specific config? Add a "scalar help-config"?

In case my opinion on it isn't painfully obvious at this point I think
the answer for both current & future integration reasons should be to
just have its assets & build logic intergrated with existing locations
and logic.

1. https://lore.kernel.org/git/xmqqilz32hhr.fsf@gitster.g/
2. https://lore.kernel.org/git/xmqq1r5qzv35.fsf@gitster.g/
3. https://lore.kernel.org/git/CABPp-BG_wupp1o5bBSYOJSvF3eJjf=TbX0RBHqqKuD+3F8s6hw@mail.gmail.com/
