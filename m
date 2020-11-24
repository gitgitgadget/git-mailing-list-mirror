Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBA3C56201
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 21:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1CBE206FB
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 21:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qdoDvcwA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388590AbgKXV7L (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 16:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731751AbgKXV7K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 16:59:10 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C76C0613D6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 13:59:10 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id b144so633657qkc.13
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 13:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2ZR1WLko9RHJaWKObFT++LNAIXVpKRSh+c0zrGr5MUE=;
        b=qdoDvcwACkHLaekUIxgg9CL1CEGRIyYeHfiu9JcBvi088UAcKNgzQ42iAlqNSTmDfZ
         hBbXGZ4dUuPFQAbxEnvkSEb44/Sj35nWMqkYtQ3TBLstuMJuKuJqwglVxo0XuwXpMWeR
         OQ/c47G0EdJLPwAK53iiE5DQoQ1g2JhBJ6uggb1AmohXou1b5k2vfhn219PAlllhzX+F
         APrZUQZ+iEk6jIM80XlF4gQtjDM2PC3LKkZSixq//I9Y1BH/0YHCN03N1sZNG9shHJ2s
         jCcxfn5L1S23UEsu/6lYk2QjNPs48e7MMu8tXJFrn7uFX5rKJanORdPpVs+luehiZANy
         dHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2ZR1WLko9RHJaWKObFT++LNAIXVpKRSh+c0zrGr5MUE=;
        b=AKGkUqWpTlJb94xmvToQi3CglWUvmwF/HwtuxfXkB35+u2wBxO7TelvMc+DNOCOAYi
         kYtyAFIudttvg5blKNRdqu/Su300bFLD7D6AJjStyoKRUpDFyy4aIVffNzUudtfPRBWF
         XodkeZc3THXNqRegLwScXXEZICKfbXTPG0ZKuixt2LpjL6DZ9a7hq5VeGBNLp0ruH3h5
         ppcUx5EGBx0wXXGKbYw/D0oChf4hmfG7oGnrQXGMSs3S5ole1c9fxYMVoDb6b0eaXzoe
         kh5iuLlyPzyNRGOIbditLlGwCmoul6GhmARR0S0m8KbqxJRSeMHxnOgfcHWW70QpADXV
         seRw==
X-Gm-Message-State: AOAM532GgjFnq7iJphZTO2tAIlOBmNLyF3JAGWyEEnWsRB1YXP2FWXwi
        wfrOBuRFUJS8IisZL8fgPsI=
X-Google-Smtp-Source: ABdhPJxrdTF4A0D6OkR6DqPMEb/cBY5A7ErqpJeHpg3SxkWz3Bg00e6d3lS80dSpHP8DfJm7J7A9gA==
X-Received: by 2002:a05:620a:b91:: with SMTP id k17mr344305qkh.158.1606255149410;
        Tue, 24 Nov 2020 13:59:09 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:b5e9:7f83:ac96:1a69? ([2600:1700:e72:80a0:b5e9:7f83:ac96:1a69])
        by smtp.gmail.com with UTF8SMTPSA id s7sm463165qkm.124.2020.11.24.13.59.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2020 13:59:08 -0800 (PST)
Subject: Re: [PATCH 1/1] maintenance: fix a SEGFAULT when no repository
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Rafael Silva <rafaeloliveira.cs@gmail.com>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>
References: <20201124164405.29327-1-rafaeloliveira.cs@gmail.com>
 <20201124164405.29327-2-rafaeloliveira.cs@gmail.com>
 <1bfd84da-5b74-be10-fc2c-dee80111ee2d@gmail.com>
 <xmqqim9uifz8.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7fbe28ff-6d0f-f377-d86f-0b32f12ddee6@gmail.com>
Date:   Tue, 24 Nov 2020 16:59:08 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <xmqqim9uifz8.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/24/2020 4:48 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>> The reason to use RUN_SETUP_GENTLY was probably due to some thought
>> of modifying the background maintenance schedule without being in a
>> Git repository. However, we currently run the [un]register logic
>> inside of the stop|start subcommands, so a GIT_DIR is required there,
>> too.
> 
> Meaning all the operations we currently support requires to be done
> in a repository?  If so, that may be acceptable.

That is the current case.

> When a new operation that does not require to be in a repository is
> added, or when an existing operation is updated not to require to be
> in a repository, reverting the change and then checking in the
> implementation of each operation if we are in a repository instead
> should be easy enough---it pretty much should amount to Rafael's
> patch, right?

Yes, I agree.

> But then, being prepared for that future already is also OK, so I
> can go either way.  Please figure it out between you ;-)

The only thing I can think is that using RUN_SETUP protects all
subcommands immediately. It is equally possible that we add a
new subcommand that _also_ requires the GIT_DIR and we need to
be sure to implement this check at the beginning of that method,
too!

But again, I'm just happy that this was found and is being fixed.

Rafael: please feel free to take or ignore my suggestion at your
discretion. The existing review has also been illuminating.

Thanks,
-Stolee
