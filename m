Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D39520281
	for <e@80x24.org>; Thu, 21 Sep 2017 03:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751450AbdIUDtG (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 23:49:06 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:49392 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751361AbdIUDtF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 23:49:05 -0400
Received: by mail-pf0-f178.google.com with SMTP id l188so2585667pfc.6
        for <git@vger.kernel.org>; Wed, 20 Sep 2017 20:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PEfjMeHkLSWq5T2M+lojhl2kobOGx+C5X+1L+0WViaU=;
        b=iV/xj3Z5a8c3usWgl4JHG84krA5vS4zxtBwn6spAE76eflXr7dYeMRppbYkq4VH0cg
         9+8rHhCm2btwBgerzyyV97WOdvXdAWUCJM1/1629FT0CAgNpTfMe/TyAf6ZcAqNRkjTy
         IsWkfa/FIS1VwBhsWCXeX4rYQCfeqZJVxQlimkazE0G/Gx5VZTDBaiv8/5PXfaPYQUbg
         xWpy780WZTlpWeD0U/B/aAL6ozDVigT9TLCeWZ1jSNBE2zrh3iBuJEMowEAoS+h8kba+
         JdwGHyPtc0GgrAO5Xh59b4FmOiQu+rapXVMuysN+Z06enEQA3IRbp3a2oXTnxmXX0Hsh
         5nyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PEfjMeHkLSWq5T2M+lojhl2kobOGx+C5X+1L+0WViaU=;
        b=Cy4yh3gjc23+d8fVitP48w4AJhC4PATurkryLqTow7y5eyLbgtGq8Bb8+1KFud86qt
         vP/9yih6EuQnBglCFomAJIEcSs9UZk8v5PWrA/gG3eJnVOshx9rAHsh/C85b3EVpZu6f
         J5eojIW1nnLr9bpjR3FzSOgu7qlNek2bohwIpmJjddrUdl1+yT72qTfFtQFm3Os/CNx9
         kyM4qeoKNeA5QxNX33Sr/YVvVon2xQLQr5VfV1qDmVSx2E4nz9RkOJXkhWYbsFFQmyid
         IR43Ja6zO8HOb9bkjw3c4t7li0CPfs27IXhc+vZ/lmls5ag0Dc23ZIU4h4tdZmiSKBfu
         ZZGQ==
X-Gm-Message-State: AHPjjUjMKDUUEK+eLnlvLkK/tzdljTPkTqF4rjkqnAD9Vd+MbApa5vdU
        5qIJN5a2keMksC3BMtDCUOg=
X-Google-Smtp-Source: AOwi7QCB6rVIYrYKiMSIuKcWYfBPTDkm4P4NbL9+3V1vMtsU49BQ5Brxv+f0RMmuJRvv8IgOtiSPSw==
X-Received: by 10.84.244.6 with SMTP id g6mr4227635pll.223.1505965744628;
        Wed, 20 Sep 2017 20:49:04 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:da9:ac38:cdcf:de91])
        by smtp.gmail.com with ESMTPSA id n18sm489322pgd.69.2017.09.20.20.49.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 20 Sep 2017 20:49:03 -0700 (PDT)
Date:   Wed, 20 Sep 2017 20:49:00 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] revision: replace "struct cmdline_pathspec" with
 argv_array
Message-ID: <20170921034900.GB88098@aiede.mtv.corp.google.com>
References: <1505936846-2195-4-git-send-email-martin.agren@gmail.com>
 <20170920202552.kkwhigmv7lq6cj3y@sigill.intra.peff.net>
 <20170920203659.xqy76bg5nfabvbfx@sigill.intra.peff.net>
 <20170920224826.GH27425@aiede.mtv.corp.google.com>
 <20170921030424.akqaou7tqj2updgr@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170921030424.akqaou7tqj2updgr@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:

> But mostly I am fundamentally against using UNLEAK() in a case like
> this, because it does not match either of the properties which justified
> adding UNLEAK() in the first place:
>
>   1. We are about to exit the program, so the "leak" is only caused by
>      the memory going out of scope at that exit.
>
>      By contrast, the revision machinery may be called many times in the
>      same program.
>
>   2. The memory remains useful until around the time of program exit.
>
>      This most certainly does not, as it would not even be reachable.
[...]
> On Wed, Sep 20, 2017 at 03:48:26PM -0700, Jonathan Nieder wrote:

>> In other words, proposed changes:
>>
>>  1. Could the commit message describe what effect this would have on
>>     maximum heap usage, if any?  (In qualitative terms is fine, though
>>     actual numbers would be even better if it's easy to get them.)
>>     That would make it easier to justify not using UNLEAK.
>
> What wording are you looking for? It was a leak, and now it's gone.  The
> size of the leak depends on how much you feed to --stdin. IMHO using
> UNLEAK is totally inappropriate for this case, and doesn't even seem
> like an alternative worth rejecting.
>
>>  2. Can parse_pathspec get a comment in pathspec.h saying that it
>>     defensively copies anything it needs from args so the caller is
>>     free to modify or free it?  That way, it should be more obvious
>>     to people in the future modifying parse_pathspec() that callers
>>     may rely on that.  (The current API comment describes argv as
>>     "command line arguments", which I fear would send the opposite
>>     message to implementors.)
>
> I certainly agree that the pathspec interface could use better
> documentation. Patches welcome? :)

I think I failed at communicating here.  That is not what I meant at
all.

The context is that Git (especially older parts of it) suffers from a
pretty severe lack of API documentation.  For newcomers that is
especially obvious --- long-time git contributors, on the other hand,
may get used to patterns and common interfaces and may have trouble
seeing just how bad the lack of clearly communicated API contracts is.

There is a bit of a "broken window" problem, too: authors of one-off
patches may reasonably assume from existing code that this is just the
way it is and, lacking examples of how to document an API, add more
underdocumented API contracts.

The patch I am replying to tightens the contract for parse_pathspec().
I am not asking for comprehensive documentation of that function ---
that would be clearly off-topic for the patch.  Instead, I am saying
that we should document what we are newly requiring of the function in
the patch.  That way, the documented contract becomes clearer over
time as people document what they are relying on.  I think of that as
generally a good practice.

In other words, it was not at all obvious that "(2) The memory remains
useful until around the time of program exit" did not hold.  To a
casual reader it instead looks like (2) does hold, and there's no
documentation short of delving into the implementation of
parse_pathspec() to convince a reader otherwise.  The documentation
that is present leads to the opposite conclusion.

The assertion (1) that this allocation is going to happen multiple
times in a program isn't true either.  As you noted, we only read
stdin once.  But that doesn't matter as long as (2) doesn't hold.

TBH saying that I should write the one-sentence doc patch feels like
a cop-out.  Just like it is not sustainable for those reviewers that
are interested in good test coverage to be the only ones who write
tests, I think we cannot avoid treating documentation of API contracts
as a shared responsibility.

Thanks and hope that clarifies,
Jonathan
