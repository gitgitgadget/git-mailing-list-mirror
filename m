Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783B5C83F10
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 11:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346017AbjHaLTC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 07:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345978AbjHaLTB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 07:19:01 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FB9CFA
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 04:18:59 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-401d6f6b2e0so11869155e9.1
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 04:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693480737; x=1694085537; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2gDhg8/0T2OGdAOsAu4VuSG4qCIE0A7VbgdHU2ZReHk=;
        b=IKW1DRLEMsQ4RgKaZFB44nfHAUl6snY0ZgCIpBEg5ipaf8ZjPN03jAOUD/a+hkeWQO
         yrfQiPNE/YWT54q6v2EOmiqSq8lzJZwxUEHpYRE3r2NF17nGU8swyCQGakRmTSHsN974
         OFTKNMdhcX28Pwgbh41+lXzE1DU5iGkZhDuldO5cLwAAKtlgQ6CuOwfRasWIspblcWJp
         kgXpsnoLbR9eNlTXHfDdYxxKH9j8XC3bWRSjPErMNpDFGYTJCKWPxovdDC28ak5GiBtj
         /HCklmoKV+ED3+1EeFPBoMWmMZJdXrPTQ6VLCRWOMpced66VIzpghn6JywdKZkA2HqMh
         bcmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693480737; x=1694085537;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2gDhg8/0T2OGdAOsAu4VuSG4qCIE0A7VbgdHU2ZReHk=;
        b=VRza5kYVFEpbjvWs2dmQIy4FlX6htcY6YJrlTnvqoVySXqZBQ1E4Tgutb2hYBsae6C
         5mF2jQU33XCTXO2haHHMLuITg/qKVy7fUDK3H9uCKqP6LHIf80ZllbyA4//ITGLrVgNP
         IVGjXIbkKAnmHw2dkthGpn4hnRnqteb6AFct6KnUonn1xSP28yncEy3X5cv2ycH0YwGf
         AioD//bFjdubJ5VlDs9CV/fGHvLa+N/XFpOXjKtYrhA2pRTUqE0fUx5hr9lL0875DE5k
         /YvBNaKYOJHQBtXItFiceYu/oRIEkD36S+ROo/fg9I0HinarCHo+FAN4ryW7jiEclNed
         ynEQ==
X-Gm-Message-State: AOJu0Yy8X18hUh6ma93HfTzpcx/BH8TiFck/JZo64LJKar5/2jjhxU1r
        dB1OSOJSgNYZtmEDKRgxUfE=
X-Google-Smtp-Source: AGHT+IHZvlq+yyKJEQ2VZcXV3jKUtbprg9S8NzWJ4tCkXlvpq2Sl0kFOJYh8T3+j/cR0QvL18MwocA==
X-Received: by 2002:a5d:4b88:0:b0:31c:8c5f:877e with SMTP id b8-20020a5d4b88000000b0031c8c5f877emr1782644wrt.33.1693480737139;
        Thu, 31 Aug 2023 04:18:57 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id d4-20020adfe884000000b0030ae53550f5sm1868092wrm.51.2023.08.31.04.18.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 04:18:56 -0700 (PDT)
Message-ID: <32d494db-5f8a-4bb5-8342-571c12499118@gmail.com>
Date:   Thu, 31 Aug 2023 12:18:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/8] merge: make xopts a strvec
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
References: <20230831070935.GA3197495@coredump.intra.peff.net>
 <20230831071230.GA3197647@coredump.intra.peff.net>
 <20230831072216.GA3197833@coredump.intra.peff.net>
Content-Language: en-US
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20230831072216.GA3197833@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff

On 31/08/2023 08:22, Jeff King wrote:
> On Thu, Aug 31, 2023 at 03:12:30AM -0400, Jeff King wrote:
> I only noticed the "revert/cherry-pick" thing while sending this patch
> out. But it seems that it was changed recently-ish, and Phillip noted
> the same behavior change there (along with mentioning merge.c). So now I
> doubly feel this is the right thing to do. :)

Thanks for doing this, I had intended to follow up the 
cherry-pick/revert changes by changing merge as well but didn't get 
around to it. I think the current behavior is unlikely to be useful to 
anyone.

Best Wishes

Phillip
