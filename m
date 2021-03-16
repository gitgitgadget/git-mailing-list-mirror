Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9064C433E0
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 19:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9806D64F07
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 19:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbhCPTcf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 15:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240533AbhCPTcS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 15:32:18 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109C6C06174A
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 12:32:16 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id d20so36515460qkc.2
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 12:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HIJlMQGYXSEeBENSwZWCJ83ybxa1jHt2Kaaop5bP6Uw=;
        b=XHdwirnP68zZpo1mBGbrsPRmS5Hl1S1XtepyBEsW3OM7zoMK7guKZX+xRdWO22G/ZQ
         oW3mP9QQY8XcWkHTkPCHDW7IbkW4AF6EQ74TzSAq075RSDCdmQZZTM1L+Ma7jJ8T7LUV
         yYhPlXpQemhapOBSPVV1w7dZvh/JicYkY7Y7XcKauPV8eqqh3kO9KQ/WSd6xDJZ8wV8M
         Od0M4FZZdJek5SKUYwYWa9c06ssWwo9UHQD+vCNXhLsbcg1IZtSy/UK+Mf4Q0xZDTNbB
         oomFE5nMDVjX6iuFlc81zcOVpNmcU174McipDK5KfDRossG3uIl6ZAdub0M8OuPYqByW
         ikeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HIJlMQGYXSEeBENSwZWCJ83ybxa1jHt2Kaaop5bP6Uw=;
        b=gPLFfr9AJVALIOVLjgtXgf2radF5TpZQ4g4pFlzegHZ1iqYYgcu/zTabobhtBhq5PD
         peOHBoIO2e0Fw4/f2lgLhc+wCl/vtlOtqiB73fRsrG5lfmarXIcgvFJ4KHoPfYFPOriz
         c+hU9i4uuhtfBzyH+4BnzUAZjlq7uMY9P3V/WI0dqSBOKhpypI9sFlKxnIJTMAOeBZRV
         ti5MQEh0/gu+W0CaQSGdMgz/SPntSmAh99wvaTeieOhRIuw1UdWy2Xd+r9fDp98YEEXw
         ZUout2iSp3PjI41sCggq/mSwQNhBQTJwEtu7bYcJ8n+tYaD9FcBXK5tORjhagwlUB3VK
         ahCQ==
X-Gm-Message-State: AOAM531ziJmGavsU7PjWnJUlLQI9uBOp+st3NqTCqU6SznZaSE8l4KFl
        OhAj/WscsgBnqPa8DMNx+oA=
X-Google-Smtp-Source: ABdhPJzBDe8dD3AxXLRcMtIcwBkgvsKu+x5GTbwwv+h0pl0qcPb31baEDw59dQ6O8RzpuDaS7JBAvw==
X-Received: by 2002:a37:66c6:: with SMTP id a189mr647842qkc.229.1615923135252;
        Tue, 16 Mar 2021 12:32:15 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:fcd1:da21:8108:69bc? ([2600:1700:e72:80a0:fcd1:da21:8108:69bc])
        by smtp.gmail.com with ESMTPSA id s24sm15726728qks.127.2021.03.16.12.32.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 12:32:14 -0700 (PDT)
Subject: Re: [PATCH v4 22/22] fetch-pack: use new fsck API to printing
 dangling submodules
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
References: <20210306110439.27694-1-avarab@gmail.com>
 <20210316161738.30254-23-avarab@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <72b6e263-1e53-cc00-9545-cddd11820fe4@gmail.com>
Date:   Tue, 16 Mar 2021 15:32:13 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210316161738.30254-23-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/16/2021 12:17 PM, Ævar Arnfjörð Bjarmason wrote:
> Refactor the check added in 5476e1efde (fetch-pack: print and use
> dangling .gitmodules, 2021-02-22) to make use of us now passing the
> "msg_id" to the user defined "error_func". We can now compare against
> the FSCK_MSG_GITMODULES_MISSING instead of parsing the generated
> message.
> 
> Let's also replace register_found_gitmodules() with directly
> manipulating the "gitmodules_found" member. A recent commit moved it
> into "fsck_options" so we could do this here.
> 
> Add a fsck-cb.c file similar to parse-options-cb.c, the alternative
> would be to either define this directly in fsck.c as a public API, or
> to create some library shared by fetch-pack.c ad builtin/index-pack.
> 
> I expect that there won't be many of these fsck utility functions in
> the future, so just having a single fsck-cb.c makes sense.

I'm not convinced that having a single cb function merits its
own file. But, if you expect this pattern to be expanded a
couple more times, then I would say it is worth it. Do you have
such plans?

Thanks,
-Stolee
