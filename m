Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6392E1F453
	for <e@80x24.org>; Wed,  3 Oct 2018 16:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbeJCXI7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 19:08:59 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]:33817 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbeJCXI7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 19:08:59 -0400
Received: by mail-qt1-f173.google.com with SMTP id x23-v6so6586386qtr.1
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 09:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=KeT9FYCscqKfAhqqHxnTpAbLQpi5CzLjUxn+e08q3L8=;
        b=nPHr9XqAqlzpevGDkJq3+/D5Iuc5AJKfG/HruWExa59psNYMbpZfrJF3HEDGIXDPbt
         z8gGIUKq+9vE6Et2JiIPJavi9ecJ0DWzPyHXEKlSZkJF2nEgDclXDJU+votsD5zD8Cci
         5g2O0w/H26Dd9f5p1HrU8S96ByaDQ+1O7wysRv0gLt6WoJEy3efJqEqtNd7/q1V1mftl
         bEHLQ3dwfHca99W+e6YoJ92Q1OQsclkZOhCAoI30nzVbkacgyGLJ2mWMrZdFi2O5V3KA
         OfjTob+3Pk73dmJdF7/Q/EJLxmgZSK3HAIWedpkUVUGqc37y6GACxhjMHUzDyvZTbdGe
         /fhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=KeT9FYCscqKfAhqqHxnTpAbLQpi5CzLjUxn+e08q3L8=;
        b=skn9Z99Yh/pmpmK9Z7JYuhWJYb5JtJodc94wdQjYLeUtErtA/sBb1Mb5IGNsoHJf3Z
         QAdgTHdVGCZrEZxmt13tPulanbgmGw+qCv4liZlAVZDqUozaAmT3Ua0IAMQtt90eMrBM
         N8lt5N4hE6wpVEJ8U8rmKGFYL2Hjn5i0Ce4B4aA3AszQOMh3gVWysoIRiNxPi3+T8f5K
         EBB8IRRBDeEoXKVxEJmS1SiQyB7kIZiMFclgnO/R5IO99W6tAKC+KZXPPvTynBGrPbFt
         LbwDm3zNPBAnT8VGQ/nBOJ23ejCmYXAVk1hmwmbgl8Bg/++9M/rdOtJgdXEFEr95Jc2l
         Qwag==
X-Gm-Message-State: ABuFfojQvqvsPVUnui6sAM4nMRco4h9PNhEPxUlWkm/HFT2F2Jcy5g3Q
        EZIz2C8rQ32D85qxup+1jUY=
X-Google-Smtp-Source: ACcGV60tz60if4BmNgkJ/vgKbW/AmDeyDz5PBRJnmeSTRgzmYJiNn16kCCFpvYAxtPQot/NHDoA6LQ==
X-Received: by 2002:ad4:4245:: with SMTP id l5-v6mr1860295qvq.140.1538583594229;
        Wed, 03 Oct 2018 09:19:54 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:93a:8fdb:fc24:18a1? ([2001:4898:8010:0:f26f:8fdb:fc24:18a1])
        by smtp.gmail.com with ESMTPSA id c21-v6sm976667qtk.7.2018.10.03.09.19.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 09:19:51 -0700 (PDT)
Subject: Re: [PATCH 0/2] commit-graph: more leak fixes
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        gitgitgadget@gmail.com, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <1686b309-e0af-5518-0fa5-4635b2f481b9@gmail.com>
 <cover.1538579441.git.martin.agren@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <07aa3628-f651-3a8f-21b4-b66099de864c@gmail.com>
Date:   Wed, 3 Oct 2018 12:19:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <cover.1538579441.git.martin.agren@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/3/2018 11:36 AM, Martin Ågren wrote:
> Hi Derrick,
>
> These two patches on top of yours make the test suite (i.e., the subset
> of it that I run) leak-free with respect to builtin/commit-graph.c and
> commit-graph.c.

Thanks!

> The first could be squashed into your patch 1/2. It touches the same
> function, but it requires a different usage to trigger, so squashing it
> in would require broadening the scope. I understand if you don't want to
> do that.
I'm fine with squashing it in with both our sign-offs. It is the same 
idea, it just requires a different set of arguments to hit it. I'll 
adjust the commit message as necessary.

> If you want to pick these up as part of your re-roll in any way, shape
> or form, go ahead. If not, they can go in separately, either in parallel
> or after your series lands. Whatever the destiny of this posting, I'll
> follow through as appropriate.

I'll add your PATCH 2/2 to my v2. Thanks!
