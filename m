Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16F611F454
	for <e@80x24.org>; Sun,  3 Nov 2019 18:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfKCSRC (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Nov 2019 13:17:02 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37046 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfKCSRB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Nov 2019 13:17:01 -0500
Received: by mail-wr1-f68.google.com with SMTP id t1so8645634wrv.4
        for <git@vger.kernel.org>; Sun, 03 Nov 2019 10:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bF8vGpknLDbIE1AiLlzc3Dndi3j+W63B5b052HZVs48=;
        b=OyNXmLHiZRXxIR9b9NrEtTznOoAeo3XgCT4lJD6SA6Wvo7dUzkEgknR0zdRc46aDcJ
         hfBrpJX0JQXIcicCFwG6x64g9zjZNc85/J9KgolZJMoEOOkC/ssq3zKQ4BhEUhpOiI6B
         kLWpYwsHUn5ztq+asYRaoyT+15sK5fyoB6W1LrRsOv2As9WM85HDL+Pa9jHudggoqfva
         CMb6aW6OejK9+OaKJZhp/LwPIx7D1ylSQZlylSwlehpqNz3mBTOs6Erp/El18mng4vK1
         dBM6Jl7pTne6QB+SYdpdKmzy+N3LabUDVtenyjT151WaDwes+w33vHflO4aejF5ZWTRl
         QQ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bF8vGpknLDbIE1AiLlzc3Dndi3j+W63B5b052HZVs48=;
        b=QIi5HmIx1IZ79SaFfkI7TRO9Mpwsu2CVesVlEE122kdQlil4ui87L/9Y7jqzeGYCY6
         Sw1QlKBwjYYqy8QSJ+5OhJMDjWEZtm12+je6Q+tOGuvRtqGRcn0+IVKARukf2F1qNQtW
         Y6AEeka4wLzDKHNg6p3J1nmyigDffWx549IUv/OcLZ8b67jm8T4/RumcNilqZfvcfctD
         uiFg74CgtF+OIje5rwYq8JtG6tpoyzcuh2JSrkCNPuCXpo7/OQJ5sle9JL9mjGB4B2kk
         0tAlIFELdffp5RS8GvadN2/lKQCC8o2d8zCs5Yn6Sg0CEJ1sRN+yXUWnHA8inS9v0Jim
         UYbg==
X-Gm-Message-State: APjAAAXh3YYxy5H/MpCIljqlxLpX1wGGfzhDTfeUbQ25vWsMTQwuq8pE
        kikKKXCk8om2YDGiwimfLdk=
X-Google-Smtp-Source: APXvYqzf28F1Q2axeQde6By9C7FNLLtAhe4GsUdyMLzYCkq3wy07yeNZb4XJ+bs5gLQXi8oE3G/J8w==
X-Received: by 2002:a05:6000:12d1:: with SMTP id l17mr6185348wrx.261.1572805019368;
        Sun, 03 Nov 2019 10:16:59 -0800 (PST)
Received: from localhost (host96-200-dynamic.171-212-r.retail.telecomitalia.it. [212.171.200.96])
        by smtp.gmail.com with ESMTPSA id a7sm15443332wrr.89.2019.11.03.10.16.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Nov 2019 10:16:58 -0800 (PST)
Date:   Sun, 3 Nov 2019 19:16:57 +0100
From:   Davide Berardi <berardi.dav@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] Segmentation Fault on non-commit --branch clone
Message-ID: <20191103181657.GA89185@carpenter.lan>
References: <20191101002432.GA49846@carpenter.lan>
 <nycvar.QRO.7.76.6.1911012000160.46@tvgsbejvaqbjf.bet>
 <20191101193558.GA1169@sigill.intra.peff.net>
 <xmqqh83m1t3c.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqh83m1t3c.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 02, 2019 at 07:16:23PM +0900, Junio C Hamano wrote:
>Jeff King <peff@peff.net> writes:
>
>> I don't know how often this would actually help users, though. It _is_ a
>> pretty rare situation to ask for a non-commit. So maybe it's all
>> over-engineering, and we should start with just die(). If somebody comes
>> along later and wants to enhance it, it should be pretty
>> straightforward.
>
>I like that; after update_head() finishes, there are a few clean-up
>things that the caller wants to do besides a checkout() call, but if
>we make update_head() return a failure, perhaps the caller side
>change would be as small as the attached patch.  That would go nicely
>with the "make the result just barely usable" approach of leaving an
>unborn master branch I suggested in a separate message, I would think.
>
Thank you all for your precious comments, I've tried to implement
your suggestions and I've sent the patch here.

The problem with the proposed approach was that the code was
incompatible with some tests (specifically the tests which specifies an
empty .git directory would fail and fallback to the unborn master
branch).

The lookup commit have two error-paths:

1. the commit cannot be found;
2. the commit is found and cannot be casted to a commit (whoops!).

so, I've returned the second condition using an auxiliary variable and
declaring a new lookup_commit function keeping compatibility with the
old one.

I'm sorry for my errors but I'm far for an expert of git internals,
thank you (all) for your time and kindness.

ciao,
D.
