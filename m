Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88966C433EF
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 15:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358918AbhLBPZb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 10:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358903AbhLBPZa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 10:25:30 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F300C06174A
        for <git@vger.kernel.org>; Thu,  2 Dec 2021 07:22:08 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id o4so56116155oia.10
        for <git@vger.kernel.org>; Thu, 02 Dec 2021 07:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AbeMiG9Tn5pIjJnmSRixN7ZvM4CVe8dC5YGveJZYxfs=;
        b=l1pUWULhUh0RSSsUSDG6Jn3QfToDRNGhvdPdL03co5kfd/vBaKdmzOVWSwSbk5Gr8s
         z8895JFJUurgCEE9rybwWECDOGPBBzVdYd17IQBmK/SYXkhQmNOyaUv1w80PH3ne99wG
         JLW3hgqpvrkR/q4NebR5PWiLTamajzbN4Otoy+DcwtOkr5Y9lbDfb/a9nXlG6F6tDpoQ
         AQLn9Ekc0fXMy6sTF3GLa0zoZcuVQomFdCU0cYM2MISK+b2sho79xMiyYpZQtNwjlvP3
         05WdSXFq2Md0jSyNi/Qpomfl7uxVCdn1z2/H59Kdg0SFZkZ7OzHBXz+cm4SUP88E8P0p
         rgSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AbeMiG9Tn5pIjJnmSRixN7ZvM4CVe8dC5YGveJZYxfs=;
        b=VZ/+7Q6A/msoa6+nXe9pWai1jKoQwfEqPLk3xXfdSWflzdC10AxlIfzKKGF7VNa96B
         mqC17q0U9dLUan78zJZKeglHGvnguXVMMDIGoYWR4MrShOtKVjI6/WRN3mOWs813MdtO
         QtvU9tkppbeW2UblJhYqZNeA4xuny2q9BZo2F3fps+L1VwAGgm9rmE+HvutK0SrOhgKQ
         JolTYfO+Z4ai87LrICNGFsPUA6zhILFN6HShHEWCfvFZKyEZ4w2yxt2fziy8I4iD2BVS
         VVJj87w/1Aqi5UcGy++ZzbLfPAWBNwqN/1OnGioMxyO+MlpQ4XyBoMvl0k0zWEO/Kyhr
         jeQw==
X-Gm-Message-State: AOAM5309Tjaa5rCI3YDEc8I0AMm3ZVerC2MJeQ88TzHfw9necauBWAUq
        SSq9i3nmjnFqdH6ECc2yZVY=
X-Google-Smtp-Source: ABdhPJyHzrZnRirSeER0mTt8scErD4Fyx92PkjiXdG9N+VmP6OdDqwN/2CJPRv4sHJ6+YWF65d+W5A==
X-Received: by 2002:a54:4819:: with SMTP id j25mr4816869oij.66.1638458527428;
        Thu, 02 Dec 2021 07:22:07 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:a483:be4f:55c1:3cc8? ([2600:1700:e72:80a0:a483:be4f:55c1:3cc8])
        by smtp.gmail.com with ESMTPSA id v19sm64943ott.13.2021.12.02.07.22.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 07:22:06 -0800 (PST)
Message-ID: <2d5456f6-5a4d-1600-83f3-2b6d3e1b270a@gmail.com>
Date:   Thu, 2 Dec 2021 10:22:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 04/17] chunk-format.h: extract oid_version()
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, larsxschneider@gmail.com, peff@peff.net,
        tytso@mit.edu
References: <cover.1638224692.git.me@ttaylorr.com>
 <ea245b7216067093fdd3a5b2e3a9390f634c8af0.1638224692.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <ea245b7216067093fdd3a5b2e3a9390f634c8af0.1638224692.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/29/2021 5:25 PM, Taylor Blau wrote:
> There are three definitions of an identical function which converts
> `the_hash_algo` into either 1 (for SHA-1) or 2 (for SHA-256). There is a
> copy of this function for writing both the commit-graph and
> multi-pack-index file, and another inline definition used to write the
> .rev header.
> 
> Consolidate these into a single definition in chunk-format.h. It's not
> clear that this is the best header to define this function in, but it
> should do for now.

Thanks for consolidating these!
 
> (Worth noting, the .rev caller expects a 4-byte unsigned, but the other
> two callers work with a single unsigned byte. The consolidated version
> uses the latter type, and lets the compiler widen it when required).
> 
> Another caller will be added in a subsequent patch.

>  chunk-format.c | 12 ++++++++++++
>  chunk-format.h |  3 +++
>  commit-graph.c | 18 +++---------------
>  midx.c         | 18 +++---------------
>  pack-write.c   | 15 ++-------------

I notice that you don't use this in load_pack_mtimes_file(),
in pack-mtimes.c but you could at this point.

The code you do touch looks good.

Thanks,
-Stolee
