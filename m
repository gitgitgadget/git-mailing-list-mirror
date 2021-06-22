Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC52C2B9F4
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 05:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E39C660234
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 05:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhFVFhb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 01:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbhFVFha (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 01:37:30 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51168C061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 22:35:14 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id y4so8536209pfi.9
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 22:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jzF5q+eDcBv0Wo4KXNfgSickDFo1DEEHkXa98p1Jo1U=;
        b=b0jLG0glB3Yo9MmQQCJv/xXiFvDSJqKwSQW1nvcjZ3iNDR6WdV3Nx1tfQjCMSfCN7I
         Ou9+gaJCQZBohsmzjEKkoOlAmUi+/DDdgC9iIVRv3z/llOVO5Sjr+awXNGG4JsE1Cng3
         8SJatqmf8b1DY59OwtrzhKdGG5xC9aY3VBl4Rrx5FPWkieAqpUDbTPVMX1H1amFuNatj
         snjtafenl372x5RfuB8iVbcnMpTCSbW26gY59J01rqBEmcfUeOMnS9RqkHTHgVds06W7
         ILwLb5AS+CIdfKZ0KaDrpI0jbbINJvx5w+rhS4JfINphgMQ50Cs2pNRERdwMJj4PRDls
         ibJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jzF5q+eDcBv0Wo4KXNfgSickDFo1DEEHkXa98p1Jo1U=;
        b=r/mivehFpNlBapXwK53Zb+ZqqBvej3+siIQZ1hoP2gUBcVcvq9Bmq0qcIfdZe50VBW
         pfjMXzyfq7Br1bTQYWP7Ta2Qq6ysURoad2xu/Xr3OWz//iIvsMlqdXgerWsmd+JwsbHo
         J8yIBJK6lXh8hPuTNHXqx3VV0RyfP5al2O5QzmNGlVp34qajSpMjvZfr6IqUHi5HUVvt
         s2HpxaRr6nFpV/km5aVRAeCEq8GHUQX/Qh2tFYbEtfb6GCZ5z2sXGtkTuujQYN0KIsKj
         FMqlTVjsebwR8xbe6TsNEGhlU3XcC8Mdo1gDo+WmZHWC8JOuCo1YaNiZtjijObWD0Z06
         wlmA==
X-Gm-Message-State: AOAM5303nfZmCKLB/E5pVaWAlVgU25jWapzZq3lRp3erR3XYz4X/V2aW
        RUCZGZCOhIidFDSNbVulmqy0sx7FGQDbfg==
X-Google-Smtp-Source: ABdhPJzYmcN7VVcmnkmXe0TTt9cjWgwIyXcX30eZE2NXrtpT/aN5ZB6YO6gUJJQiEt7wq8jfoYB6qw==
X-Received: by 2002:a62:2901:0:b029:28e:ef3d:10d2 with SMTP id p1-20020a6229010000b029028eef3d10d2mr1889661pfp.45.1624340113751;
        Mon, 21 Jun 2021 22:35:13 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-57.three.co.id. [116.206.28.57])
        by smtp.gmail.com with ESMTPSA id u10sm16909579pfh.123.2021.06.21.22.35.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 22:35:12 -0700 (PDT)
Subject: Re: [PATCH 00/23] doc: cleanups and asciidoctor direct man pages
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Cc:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
References: <20210621163110.1074145-1-felipe.contreras@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <f660c96f-cc30-6a18-00ba-82a2673aa3bd@gmail.com>
Date:   Tue, 22 Jun 2021 12:35:02 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210621163110.1074145-1-felipe.contreras@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21/06/21 23.30, Felipe Contreras wrote:
> I already sent the first part of this series separately multiple times,
> the last one is 4 simple obviously correct patches [1], but since the
> maintainer has admitted he has no problem ignoring valid work
> entirely due to personal animus [2], I'm sending the whole chain.
> 
> There's no point in carefully selecting multiple series of patches to be
> merged one by one when all of them are going to be ignored. So I'm
> sending all 3 series at once.
> 
> Hopefully by sending it all at once some people will be able to realize
> that:
> 
>   1. They are valid
>   2. They are helpful
>   3. They make the code more maintainable
>   4. They enable new features
>   5. They enable the new features to be easily tested
>   6. They reduce the doc-diff of the new feature, as well as others
>   7. They are superior to the competing series currently in seen
>   8. They include work of multiple contributors
> 
> Any fair and impartial maintainer would attempt to pick them up.
> 
> Cheers.
> 

I think the next step after this patch series is to add asciidoctor 
direct man pages generation option to ./configure script (maybe 
--enable-asciidoctor-manpage?). But before that, we need to add 
--enable-asciidoctor option, which sets USE_ASCIIDOCTOR=YesPlease.

-- 
An old man doll... just what I always wanted! - Clara
