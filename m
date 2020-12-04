Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7962BC4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 21:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0662022CE3
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 21:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbgLDVCi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 16:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbgLDVCi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 16:02:38 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9D8C0613D1
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 13:01:51 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id 4so3493541qvh.1
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 13:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DPfgixKrPBfdBZC93YH2Bu3ZKGDBr9IUOcgVNcq99Io=;
        b=aCLfDkNJXvB1zIJfofH6UcWimTc6TleWIOr7/A2IdnZJUbNp7nAmExTds77XFrzTKM
         qm35Lw8LJN6ki/qJahicJawKbKpstTnJnUg/vxXKrpR0tOqdoIpv3L7tsMXjvHV6cc/5
         GMmo2wzKSgclY5ObiOnplkfMPicnL9qd5s5qV26VPPThuNuehm6Dh7ErzsJmISKLIvhR
         7RGADBukFB1lsvC6hHeudeV99ZQBGCWJvxTr5RzkW5IeosItPk4AU5wX9cHC/r8hhTX6
         GXDZU9jl7CTboGowA460DZ43CAFZExyODcDPhUg/2PxilKxxl4J+FotqsWKe2jiHsLNx
         aMCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DPfgixKrPBfdBZC93YH2Bu3ZKGDBr9IUOcgVNcq99Io=;
        b=OKMaYyThOMXQJUCND7xJoclil0OxTGsnR4eNgDFonpN3xH7aKSWaXXIMiRE7pn5A2o
         +bqrAFsn9+/CpwDsp2z8aKm5qlHduu8WySQHRv/q5vGAOrJ229eeFG+sdUoSYLbSHuZE
         ckAcWwjIXfkL5W/7u5kqbbbtpXA1LTJwR8dT9wCb/0TtV3v+OVn+Ku3+MMVa229+XVTN
         0ocuZ1cpP199h+xd6VJLO1VBk2N2KNzqlNkMSCipttjst2c1pEjuyh0GUyXSbohTmnom
         utwyd0+ekU7SaQfyM/MDrKjjN0nSjXdbXVige0z+cvm3MWAX+m5iNgbHTIzf9XMbGDiU
         ieYQ==
X-Gm-Message-State: AOAM5330xe0xOyv23Di+ljV+yHrDvkQHzExZOzRlIWsEOwTMKQuTKNc7
        DQXdOMpxmCzRu2xXbgaI0m2Ph0TGoMZ/AQ==
X-Google-Smtp-Source: ABdhPJyUA9T0/P7LFEP/phdewmLBCaz/yg7zuHGByjyJjmPbbtUNuJXwMVkr4LVfd/6Q9fnCMbNEsg==
X-Received: by 2002:a05:6214:9af:: with SMTP id du15mr2820760qvb.45.1607115710781;
        Fri, 04 Dec 2020 13:01:50 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:b1fe:7f84:31ea:b380? ([2600:1700:e72:80a0:b1fe:7f84:31ea:b380])
        by smtp.gmail.com with UTF8SMTPSA id u4sm6161319qtv.49.2020.12.04.13.01.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Dec 2020 13:01:50 -0800 (PST)
Subject: Re: [PATCH 7/9] commit-graph: drop count_distinct_commits() function
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
References: <X8qEg/KiAQDugPC0@coredump.intra.peff.net>
 <X8qGTaIdnNa5mAfC@coredump.intra.peff.net>
 <1103d97b-668f-8ad6-fc62-3fa09067a8bb@gmail.com>
 <X8qfRDsfLYTDL3HV@coredump.intra.peff.net>
 <05c616b0-138a-3e30-5a71-4ba9fb26e6ef@gmail.com>
 <X8qhAO6uUDgHjP7S@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <22c74095-a552-b821-566b-ecc91c70b32d@gmail.com>
Date:   Fri, 4 Dec 2020 16:01:48 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <X8qhAO6uUDgHjP7S@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/4/2020 3:50 PM, Jeff King wrote:
> On Fri, Dec 04, 2020 at 03:47:43PM -0500, Derrick Stolee wrote:
>>> Does that make more sense?
>> Makes sense to me. No need to change this patch at all.
> 
> I brushed up the commit message a bit to make those points clearer:

LGTM. Thanks.

-Stolee

