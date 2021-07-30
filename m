Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A73C4338F
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 16:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28F6060EBC
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 16:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhG3QBp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 12:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhG3QBn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 12:01:43 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E554BC06175F
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 09:01:38 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id z24so9857690qkz.7
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 09:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GLQNg7eUZeNh9aOn+3V8gc7GGF6P/rPCAO+FkBW2lAA=;
        b=N85i2FuwPYnZMl53iBG2a0YmVJ2Pngm/ZlUTuVrOB0hkUMcSLs5ZPcuoSKGsarBJRx
         lPrO9n6d4wfsm8DbQpF1rYIdaL33CbpeCJP1xZWLj0L09epgWyNITPRf7OLi7bejHOOg
         Oy6+BvkkBdKrVErlm++SWxPBCJRZXEVT308F2Z+y9HhTqPnKZwOrPjr8Yl91pN8Ilxjl
         xcfOidTWlhWG3Ot3gRUpxze1a4/PrHO+uTXYyHHy+LjzUPuCQOaqekKJPls9JyWoVhUd
         AuMsPKyNkSE82MO4c/2pxx+tDOMfofGTVkQVaCnVEjyR4JfQb1HZu+uUpHDOdgT7CThx
         SlWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GLQNg7eUZeNh9aOn+3V8gc7GGF6P/rPCAO+FkBW2lAA=;
        b=sYY24aV0VUG1qq8dLpaWLtbOynfTSylJJ8xOL3tZQZbqedljtyxhw9xR7AJQ12pODB
         PR+uYC70tHXlGiL9RoZ5ZbjkZxwb7SgX+Z8TSRdupLERIRKnZp9CoaaQLxbLqKFBru5M
         ZSA2PAczl55azEbO75nGLHPJ8lW4gTejkzqu+yYnq0sNtmI+9n9r/3WKEP8ikRWAl5m2
         KflHNR1gZZDwBpq+4W2K0McvTBIDQBg9o4Z/BMpsuzoS4Wi42FSkkg9HybfTer/VjVl/
         hLHOTsO98ZxXgYa8ejCwhbiCO1L/vx0bbI88wnBwHVhRY3nXXtMqW40Y9ijxDadmnMol
         JB1Q==
X-Gm-Message-State: AOAM533T9bKrJKRYTYI1NffNm2iloMTZzbnbQNHTlPt+0wEpRPf+d64j
        056ZC5YcKIFF8un6EyOROiI=
X-Google-Smtp-Source: ABdhPJzxhrFu4HP4xnMZyKvckPoW0wETAIjG6KYp5vLXVON7NSF1nIse6KKV0dcxoZd+u4aJIbVkhw==
X-Received: by 2002:a05:620a:172c:: with SMTP id az44mr3015812qkb.324.1627660898116;
        Fri, 30 Jul 2021 09:01:38 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id w5sm776878qtv.3.2021.07.30.09.01.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jul 2021 09:01:37 -0700 (PDT)
Subject: Re: [PATCH 0/1] Improve automatic setup of tracking for new branches
To:     Ben Boeckel <mathstuf@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Taylor Blau <me@ttaylorr.com>
References: <20210728135041.501850-1-mathstuf@gmail.com>
 <20210729020125.746206-1-mathstuf@gmail.com>
 <9b8b3a12-6801-1c5d-9cfb-c87b51cd9548@gmail.com>
 <YQQFWtKo8b1WJIGe@erythro.dev.benboeckel.internal>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <7b50ebc6-7b28-412d-b124-9bd54750c922@gmail.com>
Date:   Fri, 30 Jul 2021 12:01:36 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQQFWtKo8b1WJIGe@erythro.dev.benboeckel.internal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi again,

Le 2021-07-30 à 09:57, Ben Boeckel a écrit :
> On Fri, Jul 30, 2021 at 09:35:39 -0400, Philippe Blain wrote:
>> Le 2021-07-28 à 22:01, Ben Boeckel a écrit :
>>
>> Small nit: usually when sending a second version of a patch, you would use
>> the '-v2' argument to 'git format-patch' so that the patch and cover letter
>> is prefixed [PATCH v2].
> 
> Yes, I realized that I had forgotten the `--reroll-count=` argument when
> making this patch (I suppose a way to store the Cc list for a topic
> somewhere would be nice so I didn't lean so heavily on shell history
> would help this).

There is 'format.cc', but it's not branch-specific, so you would have to
use one worktree per branch with extension.worktreeConfig...

> 
> FWIW, my main gripe with the email-based workflow is the lack of
> coordinated metadata (LWN has numerous comments by me about my views if
> you're curious, but I should really formalize them into blog posts). But
> when in Rome :) .
> 

I agree. I almost always use Gitgitgadget [1], which keeps track of the CC list for
me, of updating the re-roll count, of adding the in-reply-to header such that subsequent
versions of the series are sent as a response to the cover letter of the previous version,
generating a range-diff against the previous version,
commenting on the PR when the series is mentioned in "What's cooking", etc.

Some things it does not support are: sending a patch as a response to some random
mail on the list, which is sometimes useful, reading the commit notes to generate
in-patch commentaries [2], customizing the diff generated by 'format-patch'.
Other things are listed at [3].

Recently I've even been using only the terminal with Gitgitgadget:
I use 'git branch --edit-description'
to write my cover letter, and then use the 'gh' GitHub CLI to open my PR:

$ git config --get-regexp alias.desc*
alias.desc-title !git config branch.$(git branch --show-current).description | head -1
alias.desc-body !git config branch.$(git branch --show-current).description | tail -n+3
$ gh pr create --title "$(git desc-title)" --body "$(git desc-body)" --head phil-blain:$(git branch --show-current)


Cheers,
Philippe.

[1] https://gitgitgadget.github.io/
[2] https://github.com/gitgitgadget/gitgitgadget/issues/173
[3] https://github.com/gitgitgadget/gitgitgadget/issues
