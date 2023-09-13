Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A17EDEC71
	for <git@archiver.kernel.org>; Wed, 13 Sep 2023 15:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241659AbjIMPR1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Sep 2023 11:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241336AbjIMPQz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2023 11:16:55 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D58EB9
        for <git@vger.kernel.org>; Wed, 13 Sep 2023 08:16:50 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-402cc6b8bedso78791915e9.1
        for <git@vger.kernel.org>; Wed, 13 Sep 2023 08:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694618209; x=1695223009; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=E3r/YVLe9Si5qkdxha3HdUMQYETsH5Nue+D1TXkAL38=;
        b=HgZRtCOFcOm3EmcHvSnJvsTxypSKj+ZzF1zt2Ire48Y2WHOco26eyicTVXJYXXPHty
         ZOPZkMGuOQVuSjUb+Rz2RerRJfQ7JN0b3n633Q2zlWpzRAV//7C1xpgfoKUdBOKsZfl7
         tDxA4RVV9xkHUqG7MvtDf8yzD/ebw2JZPKr4/dkqZ4C4wrI5WR5Ev+O79qq5OmFe2euL
         QGUxri4L6bsRWs3xHu0XcuvVqtbnnBX58Y6BoB9+Pv1jH1AzD5QXDpMPDBpqcoXc4EhD
         WVPopWliIHVUn4F5F+xyOga3ordXzZPeFNuU0hbeMs40sU476ui9uZBz0ozyVMWoc6qe
         I1kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694618209; x=1695223009;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E3r/YVLe9Si5qkdxha3HdUMQYETsH5Nue+D1TXkAL38=;
        b=RE9dAqPDFZ9ADEoXSL9OYRv/yC+1aCw81oiZLVZd5ItZem4bmWQ8NohCZLk1jt95NG
         usAvI7x3TrkJ7jyMM49PcOZp8WCY6jiSFJcujMOKsTj2gAE7dT8+ywhdmDfz9+PL7tu+
         BFbdwD67C0bcdCX1tsMKhECmbRz/z6biwiak+ArAvgbSp1xqLegfhIsxr9nds7uFRUcC
         1uC1J9Q5D89rRX0eYIMmsw6nOt/UWWz66fztjkhtrL9unL8KAYztHNjB9SFquNOqhGmi
         zAT5G3B0SVvAERDn1b8iOJguYYKRExvgch2LYt16hmrEaUg1dxMsdPfuvhXHRzNb5l1g
         Tz1g==
X-Gm-Message-State: AOJu0YwBHVCCMmvM5x7SIUYOP7Co6sWOh4AJ9mCQl6CB0Ua4gYRVyH1v
        vl8x3DrDTOGGRqpgXP9E8p5HlKoxv7zCAQ==
X-Google-Smtp-Source: AGHT+IEw6YZJVFNloYfef4FrRXYzU44iXWYX8bGPToG/BKHwt6D6msbeOVUoxPyAmyQZZKrg40hllw==
X-Received: by 2002:adf:ebc8:0:b0:31a:e6c2:770d with SMTP id v8-20020adfebc8000000b0031ae6c2770dmr2354299wrn.36.1694618208779;
        Wed, 13 Sep 2023 08:16:48 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id d13-20020adff84d000000b00317909f9985sm15728733wrq.113.2023.09.13.08.16.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 08:16:48 -0700 (PDT)
Message-ID: <59b423e9-d99e-4817-8a33-c50419593740@gmail.com>
Date:   Wed, 13 Sep 2023 16:16:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/2] replacing ci/config/allow-ref with a repo variable
Content-Language: en-US
To:     Jeff King <peff@peff.net>, phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20230830194919.GA1709446@coredump.intra.peff.net>
 <8624fc43-ab42-442b-a141-851fc35dd24f@gmail.com>
 <20230901173214.GA1947546@coredump.intra.peff.net>
 <d3d1109b-3a1f-4e8b-be8d-6581d45f1b81@gmail.com>
 <20230905072444.GH199565@coredump.intra.peff.net>
 <fcdc682b-cf6c-4db9-9970-be136f48de58@gmail.com>
 <20230911093616.GA1605460@coredump.intra.peff.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20230911093616.GA1605460@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff

On 11/09/2023 10:36, Jeff King wrote:
> On Thu, Sep 07, 2023 at 11:04:33AM +0100, Phillip Wood wrote:
> Looking at the ci-config branch of phillipwood/git.git, I see this in
> your allow-refs:
> 
>        refs/heads/main|refs/heads/master|refs/heads/maint|refs/heads/next|refs/heads/seen|refs/tags/gitgui-*|refs/tags/pr-[0-9]*|refs/tags/v[1-9].*)
> 
> So you do use multiple prefixes, though all in refs/tags/.  Do you
> actually push tags for which you do want to run CI,

Yes, but not very often - I could probably just reject all tags and 
start the CI manually when I want it (assuming that's an option). Thanks 
for digging into the various options, it sounds like it is possible so 
long as we don't want multiple prefixes.

Aside: what I'd really like is to be able to set an environment variable 
when I push to skip or force the CI

	GITHUB_SKIP_CI=1 git push github ...

but that would require support from the git client, the protocol and the 
server.

Best Wishes

Phillip
