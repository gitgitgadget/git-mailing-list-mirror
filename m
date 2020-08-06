Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876E2C433E3
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E71952177B
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o6ESVFgS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbgHFRgJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730491AbgHFRf1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 13:35:27 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F150BC0086A4
        for <git@vger.kernel.org>; Thu,  6 Aug 2020 08:19:27 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r4so41404626wrx.9
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 08:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=3771J4F+BofkO6Ae6FvUcUUY1Jx3z36VqUZu9fDQPKM=;
        b=o6ESVFgSnskmFFPzLm9HgMRK1/2YkvyiNoV++k7lw5EYgCN1uDwf+xdmi6aAamDeCn
         Sk4kIynbrgf3K+2MZpqtxhqPqYe6R6jh2xl9xc3DM/VN9FP6fwWtWXPuQX5Q6HTHtNKz
         mm6THGOkhvQwWZfVKGb94uMPZlANnFbB6kcpUs2/m4nOFUt3TbBzhXY6p6586PtHxlEs
         7+G8i6N5a47syGQ42PBIIesM+y3YjCjjnOFzmex2+IwvGO+5r7eWupHrjkA0VE5bqzaQ
         JpKf/YP78omNo8ykHrsfUFQW0fLK45k4kYHzsIW9uNOU+sTONk+nFYuCdoZk7fdQACzZ
         y8+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=3771J4F+BofkO6Ae6FvUcUUY1Jx3z36VqUZu9fDQPKM=;
        b=pCfGKRoP1inHmvKf3xtO5223NycawLBT1auoG2kfkxeJ0N1kYrH0iFSSGHeyT6N4rr
         b2EvMfMT8C2x3zloQEQ773wuiWQsPunvj2MMeIuO+yv03CJDuGzTbIq3K+qMi0VwSFo5
         dUlKougTZSIQOTCOIwq0iFr3Eb4t3FXYqDit95g6nonqNn/gYfa45fVqJd4rVRpYEWY7
         q8l0DZ63uCJbGrk+0B3gAsycdgpvOHEInLuEyKwcg81Bauwe0DHALdpHZyu/ScWh+DI6
         NMSbCKU26NDNfQWvVhjIUcwVWglmf/hMQEuMmxvuCgJoR2TTlIg4sE/NTbYLcjfmxI2b
         5ivQ==
X-Gm-Message-State: AOAM532D29fwMWSaYPH/81TJ6RnalDnP0a6Z/u76J0dzOXnh5koz06BU
        XHKArW6PeEQGWE16Z/Dyv5z8pyOh3XU8Ew==
X-Google-Smtp-Source: ABdhPJwX9J715za+OORgLezgsZ2nQxT3XhJ7kfK12GJY3N0tKVClJpYqJS8Zz9qauD62NPtYulFZhA==
X-Received: by 2002:adf:e94a:: with SMTP id m10mr8599019wrn.249.1596727166532;
        Thu, 06 Aug 2020 08:19:26 -0700 (PDT)
Received: from [192.168.14.141] (bzq-79-177-198-237.red.bezeqint.net. [79.177.198.237])
        by smtp.gmail.com with ESMTPSA id k184sm6820897wme.1.2020.08.06.08.19.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 08:19:25 -0700 (PDT)
Subject: Re: Why is AuthorDate displayed on git-blame?
To:     "Raymond E. Pasco" <ray@ameretat.dev>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <C4PPV24G8ZNK.3IYI2MQ3A262Y@ziyou>
From:   Noam Soloveichik <inoamsol@gmail.com>
Message-ID: <6dabe718-6d6e-e76c-677d-f2dc4a5b83be@gmail.com>
Date:   Thu, 6 Aug 2020 18:19:23 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.0
MIME-Version: 1.0
In-Reply-To: <C4PPV24G8ZNK.3IYI2MQ3A262Y@ziyou>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 06/08/2020 9:57, Raymond E. Pasco wrote:
> On Tue Aug 4, 2020 at 8:40 PM EDT, Junio C Hamano wrote: > --first-parent:: Follow only the first parent commit upon seeing a > merge commit. This option can be used to determine when a line was > introduced to a particular integration branch, rather than when it > was introduced to the history overall.
I want to make sure I understand your proposal correctly -
--first-parent would still show AuthorDate, but of the
*merge-commit*, and not the commit that introduced the line of code
to the history overall.

If so, it's going to get the job done for commits which are applied
by a merge-commit. Although I wonder what --first-parent would
display for commits which are applied *not* by a merge.

Consider the linux kernel, where some of its commits are merge
commits from pull requests, and some are applied patches: with
different AuthorDate and CommitDate. For those commits, AuthorDate
represents the date the patch was originally sent to review, not when
it was introduced to the integration branch, which is represented by
the CommitDate, which leads to inconsistencies.
