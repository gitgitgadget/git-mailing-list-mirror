Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D7DC4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 13:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiLTNaQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 08:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiLTNaP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 08:30:15 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2460312F
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 05:30:14 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id bq12so724491qtb.3
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 05:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1bCGdCf8znoWp4D/uRqUnntkZ8Z0Yr+jj2pjz+kUPak=;
        b=UojZRPIzHlbeB6RCuOnHXNlbOB7gBj6kAACg5r1MHb8E/skbMqv+iZE1howMqp/xfC
         uazmC0gzJ9u+uAurShcul7FLa2e8kkQNeYsE/wbkweVs5F+ABifslUflMEHgNikMPQ97
         qK3/A80fMis2mcKxRjNBhHjyJ2XrUpm8ABZdW11VHYkCr4dLoJpg7fIKttrPkv/RJCtr
         UY3kCHlKzHztWJ/K1Cbr5sus9rqeWZ9RQXUlVkCwIwHr17F3hKvNg1r+sk6jPVcJQRtn
         ITWlefKu0+e8ikj9qcXVQbWo6qVvOXktXdbu5iAyBXcz/FkVsr5c7VgG0ufFEtYvY/hy
         CqUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1bCGdCf8znoWp4D/uRqUnntkZ8Z0Yr+jj2pjz+kUPak=;
        b=uVXAJcuD8hfW7PaGP9t3gkOCw15X0lwGBLzjnJeInjNoU1v2mmENR0gK7hS8eYu8dN
         sE+xmeOC9mo1H6tUkjR5G/yDh4nDE6roTSTOdhl/1lLoNYqWvlGGrN6rOkpyYj2lCoLT
         YRdr+8noSXBJKS+ZwOi7aElplKSYruDCmoebVABvQiW2bJs8h8jZ7ZnMBL94cKhCRW9k
         0rcPnEhGACvxoPHY05jtR+wB6j6z4iFBkxv2bgGfGTo3IRzXr+bwNkBhuC7sPNbjAVWj
         XonTeIS3m6Ct4nZoVCKuLAsQ9We/mNizJBaAarC4pnvoAKejrw9Hrmi3L7AbNtv0RXGw
         cjdg==
X-Gm-Message-State: ANoB5pnpbWhrHSCnlP0NpylEL/S6gLHuuEA53bNcvWchOgT24GHN9diE
        Bsp0i/srmQDrVSF5FjxF6X7W
X-Google-Smtp-Source: AA0mqf4CW6KMffRug6hyfD8M2QWoSqvBGKY9nWZ6fSspW5uj50Xh/eunsqZxAUX42jmEwrCBig/fSQ==
X-Received: by 2002:ac8:71cf:0:b0:3a8:104c:11cd with SMTP id i15-20020ac871cf000000b003a8104c11cdmr54656387qtp.35.1671543013218;
        Tue, 20 Dec 2022 05:30:13 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:6103:2a44:3e02:702f? ([2600:1700:e72:80a0:6103:2a44:3e02:702f])
        by smtp.gmail.com with ESMTPSA id t26-20020a05620a035a00b006b949afa980sm8632980qkm.56.2022.12.20.05.30.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 05:30:12 -0800 (PST)
Message-ID: <0609575c-68ad-5392-0631-3563c179f177@github.com>
Date:   Tue, 20 Dec 2022 08:30:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH] Revert "builtin/bundle.c: let parse-options parse
 subcommands"
To:     Hubert Jasudowicz <hubertj@stmcyber.pl>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <20221220123142.812965-1-hubertj@stmcyber.pl>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20221220123142.812965-1-hubertj@stmcyber.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/20/22 7:31 AM, Hubert Jasudowicz wrote:
> This reverts commit aef7d75e5809eda765bbe407c7f8e0f8617f0fd0.
> 
> The change breaks git bundle command. Running any subcommand
> results with:
> 
> $ git bundle create
> Segmentation fault (core dumped)

Could you be more specific? We have tests that verify that
these commands work without a segfault. There must be something
different about your environment that makes the segfault occur.

One thing that I could believe is that you are running 'git
bundle create' outside of a Git repository, and I doubt we have
tests covering that scenario.

Before reverting this change that has been out in two releases,
I recommend adding a test that demonstrates your failure and
then doing a specific update to fix that scenario.

Thanks,
-Stolee

