Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75338C33CB1
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 13:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 425F12082F
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 13:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hh02B/3H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgAQNYz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 08:24:55 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34276 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgAQNYz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 08:24:55 -0500
Received: by mail-qt1-f194.google.com with SMTP id 5so21744122qtz.1
        for <git@vger.kernel.org>; Fri, 17 Jan 2020 05:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s57+5MFPnS2ANOACNnA64Ebj6301NYRZIcZnepMLLQk=;
        b=Hh02B/3H9TjhJ93af8KRkUp3WM5zNfCxzpqS6PFzHw5buQ86ptUVRDEZUS9+GmFOar
         sziugul+gVM0BXwTcwH02sQ9HTcp7uY6IsEgUPLv4WooKndHJ8hX+Dd840I1dGqm3bZm
         Ky+b58w5r5vvJuw/IRjDRGEUQqBK3fyiWjPGN/kGptIwEYjAlXrXVHSOfI4xEREN9HUe
         nO7xElBY3MLM8ivQJMmmp0I3lCXwb5d3B8iHQKkuRW4jbpV21yJCQ0u8yK6qdKJDBw2u
         09vfYPH4vdbpNdZnnAAXWd1Zcsjsk65hFSDfa79lidQ6pwXjJyAnw5y7deCFeOKPC7Ke
         ofng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s57+5MFPnS2ANOACNnA64Ebj6301NYRZIcZnepMLLQk=;
        b=f32w7bSvShw42waPMOAK8QKYrHIh2CjtBy7q+vIm6i1SV6k/5OoK4fJfpG7+s99yuK
         KLvYUUIvgmf+V21vYoNJIN5ftCPvrawSH6hSZdYXM33ne6wee13GiW2J7L1t4rtVfm7Q
         1og/ZahVxNtArr56/v5WIt3DmfGzve1kKDM139bOq/mQcE8FMaeYBfuYKQlwgfWXhBVd
         HjoTvAvfKEQVyjC37Hr6JmPLLsuYykEHB9wSAPnujQImwJCFqasSJgKtoRZo+mXBKzxs
         a9kCX4MF7TukerzU8ox+gxrfC9oTlCxRDWxAZAnVEz13gAbzDj0nJabyVue4MmtZi3eV
         bOaQ==
X-Gm-Message-State: APjAAAVO10kh2U9HGDVRydobA4RFVksb31tHVqXYtGl4b9z749VsxdtB
        hn6GE0Qz2EOy6iJTJ5ZlpWmvffCjrME=
X-Google-Smtp-Source: APXvYqy9l1xv5UFZbHUISxdOFQqHP//Q3AI7yNjWk7R8yortPuM1o6OaGBeZRCjXu4aIP6fuHSe5WQ==
X-Received: by 2002:ac8:440b:: with SMTP id j11mr7529938qtn.283.1579267493873;
        Fri, 17 Jan 2020 05:24:53 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:64d0:3701:c4c7:2368? ([2001:4898:a800:1012:1604:3701:c4c7:2368])
        by smtp.gmail.com with ESMTPSA id r6sm12677085qtm.63.2020.01.17.05.24.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2020 05:24:53 -0800 (PST)
Subject: Re: [PATCH 0/4] checkout/reset/read-tree: fix --recurse-submodules in
 linked worktree
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>
References: <pull.523.git.1579263809.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e5863bce-6038-91cc-36f6-98b1df20f33a@gmail.com>
Date:   Fri, 17 Jan 2020 08:24:52 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <pull.523.git.1579263809.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/17/2020 7:23 AM, Philippe Blain via GitGitGadget wrote:
> The first 3 patches are clean-up patches on t7410-submodule-checkout-to.sh
> (renamed to t2405-worktree-submodule.sh) to bring it up to date.

These cleanups make sense to me.

Thanks,
-Stolee
