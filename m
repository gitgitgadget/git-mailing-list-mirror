Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F77C71153
	for <git@archiver.kernel.org>; Mon,  4 Sep 2023 09:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234918AbjIDJ4r (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Sep 2023 05:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbjIDJ4q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Sep 2023 05:56:46 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9EA41719
        for <git@vger.kernel.org>; Mon,  4 Sep 2023 02:56:20 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31768ce2e81so1025812f8f.1
        for <git@vger.kernel.org>; Mon, 04 Sep 2023 02:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693821377; x=1694426177; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=r1Y8OmHVFB3vY5BfQb/iU4rmmcorxNCwSPbTvI5U5fQ=;
        b=Qw7KoWRQXKLHOklt8E+mWqGs4ZOdxLt68gl6l/EpCrv9nkezRtUyXlUU88ANHFtgKE
         aE9UQuea0Aajzvqtzr1Bt5aMUTFBYm5NjGogEQF8QRVH4N4SNdNpB9UXGGvaHj/nCHqC
         bWyd6DB2XxmiOz9QLyjTEoT4c7YkWSaPhXZClLGG1yqkHl05eUCznNU0icYxit6FXcuR
         Gz7XCTX1mB2XLIpSAdJNT5BW8iqKHESk0U9sDyPnVZEOREsN7IZ0gAvxWrBQLvtGfqom
         4HwZQRD44gHcYAFhbH92hTFkaiDy8DXVDgy36MuzRGakY5bgVUmbtwrTQ9KRnyYhXHzA
         iZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693821377; x=1694426177;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r1Y8OmHVFB3vY5BfQb/iU4rmmcorxNCwSPbTvI5U5fQ=;
        b=kwpj6YUvlbqz+JTUxm3Z69GpXD9xCO2WCbZCtESdrdeqT3A+KVOb2VKCYUWIUzlubl
         dxFcNguCJ1mqpayywzMdL4LHlbDQbONYQki9JQFw/C6a0H4Ox0b7m/VBLyxQQVDIdh9h
         B0XKpb7nV4kwVIqyb2HUsrex7eobTMLIz1Dsfe1IOnf+35fMAu0KUAD787Yw4RLYW7BW
         0T2aAcDPoXBLSkCkNOUQxoEOiQkYNf4AxOTk/DcZK7oIq9QbGxph+1WaKhcD80U4qXlx
         iFK8pa7S+pV0EYN9jm51yeEklinlTkAc51IRhM8kiz0s4/zwwlCFc50+pzAddfzuMNo7
         XcWA==
X-Gm-Message-State: AOJu0YxlXyZWUwbQLIJ591qE1GnECfyiRfG7PJ8TcXVtlhLrVFgj9uNL
        fPrlXt/5kPN2jRr+g/pCawCzf3vVun705A==
X-Google-Smtp-Source: AGHT+IFwK0I+5VLEEbiJwgcQJA2pPC+n9ta8UnJzvEKotxcMZXcV9Hlku4SdeALRVlgIwF9cAZFVTw==
X-Received: by 2002:adf:f08e:0:b0:315:8f4f:81b8 with SMTP id n14-20020adff08e000000b003158f4f81b8mr6480720wro.50.1693821377026;
        Mon, 04 Sep 2023 02:56:17 -0700 (PDT)
Received: from [192.168.1.101] ([90.242.223.1])
        by smtp.googlemail.com with ESMTPSA id x16-20020adfffd0000000b0031c8a43712asm14083307wrs.69.2023.09.04.02.56.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 02:56:16 -0700 (PDT)
Message-ID: <d3d1109b-3a1f-4e8b-be8d-6581d45f1b81@gmail.com>
Date:   Mon, 4 Sep 2023 10:56:15 +0100
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
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20230901173214.GA1947546@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/09/2023 18:32, Jeff King wrote:
> On Fri, Sep 01, 2023 at 02:24:59PM +0100, Phillip Wood wrote:
> 
>> On 30/08/2023 20:49, Jeff King wrote:
>>> This is a more efficient way to do the same thing that
>>> ci/config/allow-ref does (which didn't exist back then).
>>
>> I like the idea of a more efficient way to skip the ci for certain refs.
>> I've got my allow-ref script set up to reject a bunch of refs and run the ci
>> on everything else. It's not clear to me how to replicate that with the
>> setup proposed here. Would it be possible to add a second variable that
>> prevents the ci from being run if it contains ref being pushed?
> 
> Drat, I was hoping nobody was using it that way. :)

Sorry to be a pain.

> Yes, I think it would be possible to do something like:
> 
>    if: |
>      (vars.CI_BRANCHES == '' || contains(vars.CI_BRANCHES, github.ref_name)) &&
>      !contains(vars.CI_BRANCHES_REJECT, github.ref_name)
> 
> It doesn't allow globbing, though. Do you need that?

Oh I'd missed that, yes I do. All the globs are prefix matches but I'm 
not sure that helps.

Best Wishes

Phillip

> -Peff

