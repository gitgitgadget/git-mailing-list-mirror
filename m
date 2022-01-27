Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D3EC433F5
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 14:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242363AbiA0O3E (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 09:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiA0O3D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 09:29:03 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65379C061747
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 06:29:03 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id w133so6144666oie.7
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 06:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NOCUuVzGE3ehIVxPAWisAzYIB8019ABdinWblNEtijs=;
        b=LsU/MW5WK3rdN9khk/xjURdhPpXwovpkAoRbh0Jh2FcOdqqsetowyuQhFIdyHD+8sV
         7FaURaQyFlYHEpkyLBuTKtmYDO+OU1JH6i8VN8jmDmvQ9IB3qwUfV/+oZln4mZpDN4i7
         L7DrW14MUnnH57GLzcYdol84F3fJKYFzSrHNP8ffzrjg/IVDjEHuZeiGY/5RkI4owB5P
         KtQFI7tym268/TYVEjqOOh8d9TJ/0zP9UI/rNZBN+VybMIieEyUlzlHOtrMFzwHfEoo8
         rtFx83aELSWjDWcnyrANN7WnuqBad608cXjIqHR9P2jvmoTg3TFBX683QpCu3guwjQg+
         2MBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NOCUuVzGE3ehIVxPAWisAzYIB8019ABdinWblNEtijs=;
        b=lZNqHiJy6zBO+KLknvfVi0rADV3f8J4E8m/vZaIKHoYrq9bOurwrTxiwxTpef0OwB/
         wxhmFvBVoagvt1VlXvmpm31JSkegK3AcRRoMHac3D3p6Iz/XReHh21AU9gtZo53lj+0G
         tIv8m855vqgnPmJJ8wBdTVPy1B0BjA952MtbxwWyMb1ru7WatHoOlTn4WTYu6SfWoySN
         gUD9m1k6zz4mBGHU6tKCiCA1n3ThaZbySvlQkk4u7Iw9rO3iMqD65fCHAjEPsToLFQlD
         RYKkYKAGZuMcDNKkyVpLOMUk3c80K8xl9EHus/7sMCcay3vA9Kj3kRat/2vjKGjbIYHH
         E/nw==
X-Gm-Message-State: AOAM532SJL6jYAmswn3pimpwW5b6Km8ek6VpAjSPFly5uSvWn5KvY0zD
        TFg9v5DZTuYSxCwEYtXPOFQ=
X-Google-Smtp-Source: ABdhPJzZF8tUGi9Pw+dpa8I255Jng+gKZ0BYVaP0/+TQFuYxG8D3ba2KmkXZx5gSSkki9laRbUBpaA==
X-Received: by 2002:a05:6808:3029:: with SMTP id ay41mr2271609oib.173.1643293742674;
        Thu, 27 Jan 2022 06:29:02 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:d9cb:250e:9ea6:f8? ([2600:1700:e72:80a0:d9cb:250e:9ea6:f8])
        by smtp.gmail.com with ESMTPSA id g34sm4268880ooi.48.2022.01.27.06.29.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 06:29:02 -0800 (PST)
Message-ID: <c693f0bf-dafd-e4da-dd5c-ca44f20fe588@gmail.com>
Date:   Thu, 27 Jan 2022 09:29:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 0/5] Sparse checkout: fix bug with worktree of bare
 repo
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1101.v3.git.1640727143.gitgitgadget@gmail.com>
 <pull.1101.v4.git.1643136134.gitgitgadget@gmail.com>
 <CABPp-BHm3GRA3HWQwK2JiTKWye80ovwh-DRUOTys7g2D4UmwsA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CABPp-BHm3GRA3HWQwK2JiTKWye80ovwh-DRUOTys7g2D4UmwsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/27/2022 2:20 AM, Elijah Newren wrote:
> On Tue, Jan 25, 2022 at 10:42 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> This series is now based on v2.35.0 since that contains all of the necessary
>> topics.
> 
> Heads up for the maintainer: has a minor textual conflict with
> en/present-despite-skipped (this series modifies the end of a
> paragraph that the other series modifies the beginning of).

Thanks for pointing this out. My next version will not have this conflict,
so feel free to resolve the conflict by dropping the changes on this side.

>> This patch series includes a fix to the bug reported by Sean Allred [1] and
>> diagnosed by Eric Sunshine [2].
>>
>> The root cause is that 'git sparse-checkout init' writes to the worktree
>> config without checking that core.bare or core.worktree are set in the
>> common config file. This series fixes this, but also puts in place some
>> helpers to prevent this from happening in the future.
> This series has become pretty solid.  I had only very minor comments
> on the patches.  Thanks for working on this.

Thank you for your careful review. I'll let it simmer over the weekend
before sending a v5 that includes your recommended changes.

Thanks,
-Stolee
