Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1500202DD
	for <e@80x24.org>; Mon, 30 Oct 2017 19:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752029AbdJ3Tj3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 15:39:29 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:51063 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751947AbdJ3Tj2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 15:39:28 -0400
Received: by mail-io0-f170.google.com with SMTP id 97so29824076iok.7
        for <git@vger.kernel.org>; Mon, 30 Oct 2017 12:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oPU1K0bluflXbdOtY+hEVVuP5pXn9Q/JwUpdHuRqfdY=;
        b=gRjYVOIT7scd281beCdrcQA22/iHTbIvt9kEQ3juvbxkuVO9FxY9avXz+UH1aMfOMa
         wf47yWNbPcLJjH4wxLIE4Xir2ELFsfKTZzIOXSSmnFM97+UVZihE3HLDPwQLSJM+mkMf
         S4vN22IO9NMgbNeqomnTd2//EVgtquQsIs9kFiO0NN5u+vjU6gAVoNEICzgcipKpcV8z
         lBBePCrQWLy8jmYm5i+967KdGQSOKpJB0e+X6gKtg++eGMvEyYr0iWEDFkmKR4b22SDh
         vS7rZlamCwPzoAIGbVQzMH+0NNS/4tznFa7ItmjGtXHi+QwDuoOgjx/g1yI9q5yAjJEN
         odGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oPU1K0bluflXbdOtY+hEVVuP5pXn9Q/JwUpdHuRqfdY=;
        b=SGHCsFZqaO3WckaFXfwYv1mJOcWhUgjCtmWeZWw6QtwPTWHCYZ4VuyUy6a6NCeaBPZ
         S0/tzb1HJBlhJomxFdmPrOTsMpzNWtKm+bYhXF5bw2Jqzll88IiFd/sdMRz7an0bjYoP
         PVYwOEgzNomDNlPmMFarwXRQiM+W0RuS3/ST+neaajNQwm3RInYUqFzwvjfyrU+b8qqS
         xPkPxeCec13bubW5jNjGEQU5EMZwHDoC7cnGUBJS+q4llo/HgMItlqvR8rztf7Lf7nVW
         ljiBPDQm9fOCE5y/sW9dzO5BXt/KhM0UvHuySGGP9bsEwX12h2Dlxm4+HfUr31pAAfkl
         UfYg==
X-Gm-Message-State: AMCzsaXPJS/R0isplup1xRJW7e4PP4drZLXOUCpWrPnXzR/j9gbb8Ibb
        4Cgk32WZ2MwxqbEkSYGsLYUh5w==
X-Google-Smtp-Source: ABhQp+RASno7eOTCO8taMmTsEA8IkhEDNyO4otn+Dw1f7Fkzk6MmeZNclflxYDNlnozifzQKRh44dQ==
X-Received: by 10.107.129.11 with SMTP id c11mr12533051iod.258.1509392367373;
        Mon, 30 Oct 2017 12:39:27 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:9c29:988d:323f:ada0])
        by smtp.gmail.com with ESMTPSA id e99sm2208440itd.40.2017.10.30.12.39.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 30 Oct 2017 12:39:26 -0700 (PDT)
Date:   Mon, 30 Oct 2017 12:39:24 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] diff: convert flags to be stored in bitfields
Message-ID: <20171030193924.GC125460@google.com>
References: <20171027222853.180981-1-bmwill@google.com>
 <20171027222853.180981-4-bmwill@google.com>
 <xmqqk1zeafaq.fsf@gitster.mtv.corp.google.com>
 <xmqqzi898olb.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzi898olb.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/30, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I still haven't brought myself to like the structure being passed by
> > value and the singleton diff_flags_cleared thing, but I suspect that
> > we may get used to them once we start using these.  I dunno.
> 
> Just bikeshedding, but I just had to prepare an evil merge to add a
> new use of diff_flags_cleared to a codepath that evolved in a topic
> still in flight, and realized that I really hate the name.  Perhaps
> I wouldn't have hated it so much if it were named diff_flags_none or
> diff_flags_empty, I guess.

I have a new version of the series I'll send out and i ended up dropping
it entirely.  Didn't even need a clear function because I was able to
drop the touched stuff and it would have only been used inside of
builtin/log.c to clear the touched flags.

-- 
Brandon Williams
