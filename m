Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30157EC8734
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 15:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbjIGPZF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 11:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241661AbjIGPY3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 11:24:29 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF81E45
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 08:24:16 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99bc9e3cbf1so226544766b.0
        for <git@vger.kernel.org>; Thu, 07 Sep 2023 08:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694100255; x=1694705055; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3BVEylZ9oLmGRwXTo/vXY0ov/ie6Pc0QRRgGUEvu5qM=;
        b=IpLgaJeOCTtioqGZPTyQtGy3A4hVWSgnvRGI1c/PmygHwqTSNDk9VQI+LCIb/kLfV2
         D1OrZ0shT/jbq8hfKYfABATiq4Y5dwkO1MPocehJwEZ3yFey2vMBk6opUqVMRENLa+bY
         0xp0kSK6ChFaYzDRONs0NIvf7xboy1duXNNaumiW3QJeGiBKdsvIg7bAL8ZYz2Tw7iQ5
         1mM+loHCjpm73T4vJ8AI3oRhh9VFsavmjZUHEBpxojTCSQu3lQvBxMb3RaA9yJvYFEVk
         wfeM5rOySgrK/mSlfBiDAPXfGBhDvUKD8U8W+8a7rtxNlcLGyvQbtAeJnu29F2osZY6C
         nqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694100255; x=1694705055;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3BVEylZ9oLmGRwXTo/vXY0ov/ie6Pc0QRRgGUEvu5qM=;
        b=lt6O8h9B0tfrc+Fjskh0fWMq1xNPYQhGgUL15BMNqgncf+z0fmnFoCEqdqf+12PZKe
         VMXqAUaZ9Ai+tDIFPgLDIfEySxDrnOza7KfoJeeLKRWSsEkkFXyY6pWzM1NBTrqmcP/4
         UGf7UHopRHy60SFtWYnxKUZTbz7PrLOizVmcB2ZMUqg7Yw2ZngI9UPbgmadSg7CzMl4w
         pgJNGDkTm5fFboIoizsG84SIyaxsjpxi8L7qjsWQw1hTOH+PKiCQJlqm8OKAX8MUILmg
         W6RV3PD7ooEYXoOmzNB9KNtcw1+5IxGmy/GTuTZKAmaRATkHhAwlDwty+om9IcL+nU+9
         bXkw==
X-Gm-Message-State: AOJu0YxdJHVBS4S0BtXFqYIRNK4tBrpso9s6q7ISUFpZ0vnJz10tswId
        MGxbXqSfnu5GQJ+rmAfFDpIEuYXx19woJw==
X-Google-Smtp-Source: AGHT+IEeT+4hJGF6Lo1OBqWxe38gixM2y38vSF+A+OPbqbjT220Qwi7g2fkmSkStGTKPgeIvXRZ9rg==
X-Received: by 2002:a05:600c:512a:b0:400:140c:6083 with SMTP id o42-20020a05600c512a00b00400140c6083mr1695959wms.2.1694081073972;
        Thu, 07 Sep 2023 03:04:33 -0700 (PDT)
Received: from [192.168.1.101] ([90.242.223.1])
        by smtp.googlemail.com with ESMTPSA id r19-20020adfa153000000b0031f2dea4810sm18567866wrr.61.2023.09.07.03.04.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 03:04:33 -0700 (PDT)
Message-ID: <fcdc682b-cf6c-4db9-9970-be136f48de58@gmail.com>
Date:   Thu, 7 Sep 2023 11:04:33 +0100
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
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20230905072444.GH199565@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/09/2023 08:24, Jeff King wrote:
> On Mon, Sep 04, 2023 at 10:56:15AM +0100, Phillip Wood wrote:
> 
>>> Yes, I think it would be possible to do something like:
>>>
>>>     if: |
>>>       (vars.CI_BRANCHES == '' || contains(vars.CI_BRANCHES, github.ref_name)) &&
>>>       !contains(vars.CI_BRANCHES_REJECT, github.ref_name)
>>>
>>> It doesn't allow globbing, though. Do you need that?
>>
>> Oh I'd missed that, yes I do. All the globs are prefix matches but I'm not
>> sure that helps.
> 
> It does make it easier. There's no globbing function available to us,
> but if we know something is a prefix, there's a startsWith() we can use.
> It does seem we're getting a combinatorial expansion of things to check,
> though:
> 
>    - full names to accept
>    - full names to reject
>    - prefixes to accept
>    - prefixes to reject
> 
> I wrote "prefixes" but I'm actually not sure how feasible that is. That
> implies iterating over the list of prefixes, which I'm not sure we can
> do.

I scanned the github documentation the other day and wondered if it 
would be possible to use with fromJson with a json array to do a prefx 
match on each element. It all sounds like it is getting a bit 
complicated though.

Best Wishes

Phillip

> -Peff

