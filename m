Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3788C4332F
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 12:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235193AbiKRMNo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 07:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235220AbiKRMNm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 07:13:42 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360A5CF4
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 04:13:41 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id g12so8936693wrs.10
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 04:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EnGUadeRZcK+advOzGgdxEptT6co9bCf4yTJPqqgtVM=;
        b=ikvuTsjI3j42f+YgRuWpBtbW4tOd5w4VcSpUE0LL0ikDyIS0wNlY0acKs5AGaAs3WN
         E9l6CZL5z/BI9pcGYhT51W2AuubbQ4S4hR9mOm5rDJPKif+84PYSvl97gNBH6QnHVQtu
         LO7tvA0VayIH7lF+jhRz1j7cjmQVdIS+h/cFrBvZ6MTnC0bnCfYyilB8N9lpKljiO+NI
         NuYtbHJZSKNmQuo5DoqfNmdGpWsE9nLb8Qa4aZcjYZ3ZjGrZI5SfLNdz2cyxUjBxdzAE
         cjqaqG1NxmttR++KA+oKwAViZTF4DF0gyJacSnfhpbUzxHFQUghIsSRkqykr5VhofhR+
         B0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EnGUadeRZcK+advOzGgdxEptT6co9bCf4yTJPqqgtVM=;
        b=j46NpZPNj4fE5loSsR4Jwgtk8JUDZXTrmKL/ASCwhGqT4JLi3QmJlWTxENsDN7Wyp1
         +Ce6nHTlEQOMWuuQNGxQ3iEA21QnssF8JtyIRIg+5RnJ+qrJ+xlBXDTbNmO8o7x0Xyo5
         7wbqHn5kq2hAarFdBOEXuTOvqsjJoV7be+qWJIfaKvd4XLPpxkVc0Tr2hdxrCAL5YBVS
         DD8tKVAMQfm+z/2bXn9qJzWDFWySqIFrLy1s2eJnLXqP/PxUdUc/3uS4upcG4U2yCMoY
         ht9HJwqdQlZayBzC+/SGJzHb6e5L0qkxwMRDvMGUexlAMkv/UiZY+/lOdTKha/f6FP5m
         xEjg==
X-Gm-Message-State: ANoB5pmkAOpQl3EZaZ7lVTDC6Ix2p+ghwOuS7LW+Z9WeZR5zQVr886gB
        B7oskidKJ2mpNZn0TvLU47I=
X-Google-Smtp-Source: AA0mqf6JpzKKyZ4GeSMXvy0p19vVzgZ5gC1F3eNUyJ+12dxxf1YWt+S9xqPbo/itHW2NlsYz2unwBA==
X-Received: by 2002:adf:e30b:0:b0:236:aacc:ea87 with SMTP id b11-20020adfe30b000000b00236aaccea87mr4205467wrj.414.1668773619633;
        Fri, 18 Nov 2022 04:13:39 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id l8-20020adfa388000000b002417f35767asm3574543wrb.40.2022.11.18.04.13.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 04:13:39 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <51e91e8f-f11c-be8c-a23d-566eb3fbb387@dunelm.org.uk>
Date:   Fri, 18 Nov 2022 12:13:37 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 00/12] tree-wide: chip away at
 USE_THE_INDEX_COMPATIBILITY_MACROS
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
References: <cover-00.12-00000000000-20221118T112205Z-avarab@gmail.com>
In-Reply-To: <cover-00.12-00000000000-20221118T112205Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 18/11/2022 11:30, Ævar Arnfjörð Bjarmason wrote:
> As 3/12 here notes we've been undergoing a sloooow migration away from
> functions that provide "the_index" for you since 2007, with the last
> major move away from some of them being in 2019.

The commit cited in 3/12 actually introduced most of these macros. What 
it did was remove the dependency on `the_index` from cache.c. Maybe I'm 
missing some context but I struggling to see the benefit in removing the 
macros with out removing the dependency on `the_index`. Doing that would 
require much more manual work as it cannot be automated with coccinelle 
but it would provide a tangible benefit which I don't see here.

Best Wishes

Phillip
