Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE73C433E8
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 20:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2776619C1
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 20:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbhCWUAl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 16:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbhCWUAO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 16:00:14 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D411C061574
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 13:00:13 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id g15so15741447qkl.4
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 13:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QtrojKHhTcFzYbbgZ6HFZLSh1CuZyLNzWnGdEn9MZw0=;
        b=RyywlZjf0Pguafpz/jS0G9HQP3tKi6N+1OmhXjskIXbk3XU2v5TLaknCczgnqdiquX
         Vq4q8n+UGt+NulqE4H6CuYaJiU7r0uZoQguPVxEzAoT0fr2gi2nOnOP8Mh9ZZE0QiMw+
         wk1h+RXq7g41be/MU4Q+Z5gajfx4/6bB5d71WC0FXiHiIIJvHOrriuDszwI1rDiASaex
         cSDDxjMcJzHjRKYtQq109HeQhw0QoUzkGHuQ+sWLPO9IONx9SMEQ2FgLVjQM9P7xx5HD
         FBViZntFQtb0E2NR/GRjqI1QImajfm2HGGM/CZFeFWXTeZpWGdGo8Puhc8hm/CrE0rlR
         Ju0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QtrojKHhTcFzYbbgZ6HFZLSh1CuZyLNzWnGdEn9MZw0=;
        b=Zg8AIWv7mWxzC0we6qmYDhTp+oW4budourqMKHRW71l/EyjYmpjYhs3r+u1Xo5fLj1
         Fn6L6cPlSH6BatlyOOAZshVVwZavG7H6sHf40WqWOQekrIX+ADrg70B97pFI3GHlxTgO
         QC4mgE+wsSCvjwrqC39nfxhk8h0/eCpijhxcZfCmCSXF8F+C3WnEZRuKYSoFv6iBtJSI
         uWM6mAfSp9UgizrkvXvgT4XsrCExfWJGlQsF0jBp9g6oJkDuh/dMbL61P+/2KZ9F5FKv
         k6vBOiFoUoh3CetxBq93HUsgVAC+0I/j9tYAwdRMTnzERuW7Baxb3Xh8L324prZm8fnx
         1ZzQ==
X-Gm-Message-State: AOAM531MjeJAlh6o4S9byCw5uLnmDoqAYEbaigiUfoqfuW2wmy30PLZP
        SV8i8iipotgmC4hKzQ2kNzEV6EI/X8Nb65dJ
X-Google-Smtp-Source: ABdhPJy60aAe+TfxUqa1WMLl+YWRDl2+DXvqqJwQg5JqelRu7UAj1xE4BIu+6mJPXP+A2KTFklfa6A==
X-Received: by 2002:a05:620a:209d:: with SMTP id e29mr7253626qka.316.1616529612370;
        Tue, 23 Mar 2021 13:00:12 -0700 (PDT)
Received: from US0059EMPL003.northamerica.corp.microsoft.com ([2600:1700:e72:80a0:4d90:cb39:e70:9354])
        by smtp.gmail.com with ESMTPSA id d24sm14259971qko.54.2021.03.23.13.00.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 13:00:11 -0700 (PDT)
Subject: Re: [PATCH v3 2/7] t3705: add tests for `git add` in sparse checkouts
To:     Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com
References: <cover.1615588108.git.matheus.bernardino@usp.br>
 <d93c3f51465a3e409819db63bd81802e7ef20ea9.1615588108.git.matheus.bernardino@usp.br>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <085184fb-d637-696d-085c-0b456c7e9568@gmail.com>
Date:   Tue, 23 Mar 2021 16:00:11 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <d93c3f51465a3e409819db63bd81802e7ef20ea9.1615588108.git.matheus.bernardino@usp.br>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/12/21 5:47 PM, Matheus Tavares wrote:
> We already have a couple tests for `add` with SKIP_WORKTREE entries in
> t7012, but these only cover the most basic scenarios. As we will be
> changing how `add` deals with sparse paths in the subsequent commits,
> let's move these two tests to their own file and add more test cases
> for different `add` options and situations. This also demonstrates two
> options that don't currently respect SKIP_WORKTREE entries: `--chmod`
> and `--renormalize`.

I'm super-late to taking a look at this series, but I wanted
to point out how much I like this new test structure. In
particular, I appreciate that you point out undesirable
behavior with a failing test here that changes with your
correction in the next patch.

Thanks!
-Stolee

