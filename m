Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13DDC48BD1
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 17:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7ACE613DF
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 17:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbhFKRtl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 13:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbhFKRtk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 13:49:40 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F6FC061574
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 10:47:30 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id t9so3208007qtw.7
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 10:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qDECNDGez8YkLLuQyGyEcVKFFBLrGWx/E0SqaFtmZag=;
        b=gDo2N/EEXZTLLQKbgQ0ao9rHTMDxW4bugHgRtfgqdLjIsWeOy2+GXjaxtdis2rmcUM
         HHxisEAeOxQ9a16QxOxac0BgdRk9kPlhLJAqP0uIK95ubriYXNX3LOr8Mr92M8ysugM3
         l+ZNA8aZQNkQViirmt90YYEutQBk5n4w43tZycBc9brf/KMlIQlCAGrfYPTyrFnMzdLr
         p+VFjRnMqfFlBHRsSdmM1JvmPlRmGK0W6pk7Dc5cEEFS1QiD7L6LOvI1lacA3w6mAwuA
         XxA1IFImtTgwFEzk+UJLLp45xjh2SGqjYN59Qcq9RdOSYOLTIVaQvsCJ8Vf85fpq/CfD
         nG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qDECNDGez8YkLLuQyGyEcVKFFBLrGWx/E0SqaFtmZag=;
        b=mKspEKFK7O2l9RoPim5Zna44uP23S4uKTsvnq2UGkDa2q8etC8pwvTp3XeShc6mjCj
         aYjjLGIlaqJft/VNuPFzuEbUD6OQyGXwMD6I1fCiEi9RAfnIM2CWpP61j6nt8BxrVn6F
         sUPI+V6JiC54MX2biUhIXJvM/uj73pueUKURBSmMXly/hmO4xRUUvUMja4SKxcZ+4sgq
         FoOtCfXTpYQljlsazYwo/0Kun+nKhucwvalCqbWa+2kYISZ9mmZ2OHJDB/OwUWhEe6jQ
         p2d9V8ekin/gYgZyE6TuRFqZum5yE+ZVINm0fWQ3m+ypiN3fKCwLzlYo2OmtsXf7xPPY
         sigw==
X-Gm-Message-State: AOAM531iy+O9cVkw3wBRgciv3A5Xf6jmAajSDbpwrRhqReVcYZSaW582
        NY4SQ5ydZR0WtD3+x+aj0c8=
X-Google-Smtp-Source: ABdhPJxx/rV4lr3DlBIhMfeJvKe55X1IRONzklACAKg7DkMCSuGeg6NXAwcOu0EWpltzbs/FjzKQcg==
X-Received: by 2002:ac8:5d55:: with SMTP id g21mr4928593qtx.101.1623433649261;
        Fri, 11 Jun 2021 10:47:29 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3c70:274a:799:2c37? ([2600:1700:e72:80a0:3c70:274a:799:2c37])
        by smtp.gmail.com with ESMTPSA id i11sm4680924qtq.58.2021.06.11.10.47.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 10:47:28 -0700 (PDT)
Subject: Re: Making split commit graphs pick up new options (namely
 --changed-paths)
To:     Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        peff@peff.net, szeder.dev@gmail.com
References: <871r9a2dol.fsf@evledraar.gmail.com> <YMJKcHpN/gL5U6KK@nand.local>
 <87mtrx1cdr.fsf@evledraar.gmail.com> <YMKzOgOU9lj9Nt0z@nand.local>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e85bb66a-d70d-1861-07ef-82a74bcce4d7@gmail.com>
Date:   Fri, 11 Jun 2021 13:47:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YMKzOgOU9lj9Nt0z@nand.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/10/2021 8:50 PM, Taylor Blau wrote:
> On Fri, Jun 11, 2021 at 01:56:31AM +0200, Ævar Arnfjörð Bjarmason wrote:
>> So yeah, maybe we can just unlink() them right away, or another way to
>> handle the race is that load_commit_graph_chain() could just try again
>> from the beginning in such a case, and presumably picking up the fresh
>> just-rewritten chain.
> 
> I'd probably be in favor of the latter.

I want to point out that on Windows we cannot successfully unlink()
a layer that is currently being read by another Git process. That
will not affect server scenarios (to the best of my knowledge) but
is important to many end users.

Thanks,
-Stolee
