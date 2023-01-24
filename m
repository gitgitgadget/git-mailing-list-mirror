Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F95C54E94
	for <git@archiver.kernel.org>; Tue, 24 Jan 2023 18:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbjAXSqu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Jan 2023 13:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234129AbjAXSqt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2023 13:46:49 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC147458A2
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 10:46:05 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id e19so9086734qvw.13
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 10:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KKCu7Xjl0kdxPEk5ClfndRpdTxWHtnRR/7McmllhNhc=;
        b=Rgi4ILYP7dx9RydRQtugqtD3ZQzrUgsi1ktdY+vOJ0xT9Dm9X8r+Wb172v5G5Qv6Qg
         0An2E0wTU2p+68UDOzK3aVqr/xCnjG2OPrBLwv8QFW9+gyeeC51ZzKe/k/rTf3pK2hfZ
         a13xCEcpIjN4ql2qyvGc7rihIIw/HgLmadYH9PBjy1NrjhrnwlSelmWAPVFhppKKZuKJ
         bePSFHm/1qPe9vUjAUNf6eK75vkBbEsEs0EwkH7WVSxuCzf8X389QUlYs2mZ09LUhOaO
         1ZShjwRfgkpgtwPsLDq6w9X3/S0aAJeKIuNo9SPuK5qcWast8VZbZBF6OvO0SMqad+9O
         +wqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KKCu7Xjl0kdxPEk5ClfndRpdTxWHtnRR/7McmllhNhc=;
        b=kuw4sEOrJPdo1wqExre+HWvoXiFTLt3b3o7IkQOKK4Fdv8xJLQB5i2VrEkK7aOy/du
         fGq/BSRWdbKSpgikhCe1f7sXfe6kI3E8+pJpTDBnUJUzZQ4h1pRPydmV190sokYP2s0s
         uBtEQ8TrMqKQQSqEAtpz4Fxvjeav9++iLpseKrqdY8sq/amPw+yiBIb04dkE4K2txVrc
         VpgxdUcQBeWCpLXOk9whsweodQ4ZE24nemrI9Elsx5ZHOEvvLXksbbuCGmZT4GzQF3Lb
         oH72of5HSdQTBKRSz9EB5WpjsTtBEJBYSDP8RJ3SfC22rFTXh6pJBpUQsSpebsKIzFlh
         tzuw==
X-Gm-Message-State: AFqh2ko4i6O/CJu3wEpcyI3ZdgJYcrQ4DdVX6t+TNCYiGdC/zWJ+RJpd
        CRZRayWahK3WcYna6MqU13Jl
X-Google-Smtp-Source: AMrXdXuHxu8YtQOu90u8QlARRGWGDPPUewwMSRG+xzSUIbzcohXxFGYr7ZXM3U05vsh0l60mecmyHg==
X-Received: by 2002:a05:6214:842:b0:535:5c17:4a1a with SMTP id dg2-20020a056214084200b005355c174a1amr26345380qvb.26.1674585964811;
        Tue, 24 Jan 2023 10:46:04 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:b018:69c6:bab4:fb42? ([2600:1700:e72:80a0:b018:69c6:bab4:fb42])
        by smtp.gmail.com with ESMTPSA id i184-20020a3786c1000000b00705c8cce5dcsm1836432qkd.111.2023.01.24.10.46.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 10:46:04 -0800 (PST)
Message-ID: <bad5d998-b34a-15dd-4f9d-9bf1cb74dda0@github.com>
Date:   Tue, 24 Jan 2023 13:46:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2.5 02/11] bundle: verify using connected()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        avarab@gmail.com, steadmon@google.com, chooglen@google.com
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
 <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
 <b3828725bc8f8887b9b4777a0e3d84224a427f31.1674487310.git.gitgitgadget@gmail.com>
 <xmqqsfg1m8l6.fsf@gitster.g>
 <eae85534-89c9-6eff-69d5-7d4b2be85fb6@github.com>
 <xmqqilgxm2ky.fsf@gitster.g> <xmqqtu0glw81.fsf@gitster.g>
 <771a2993-85bd-0831-0977-24204f84e206@github.com>
 <ecc6b167-f5c4-48ce-3973-461d1659ed40@github.com>
 <xmqqfsbzhm7h.fsf@gitster.g>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqfsbzhm7h.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/24/2023 12:33 PM, Junio C Hamano wrote:
> Derrick Stolee <derrickstolee@github.com> writes:
> 
>> When Git verifies a bundle to see if it is safe for unbundling, it first
>> looks to see if the prerequisite commits are in the object store. This
>> is usually a sufficient filter, and those missing commits are indicated
>> clearly in the error messages.
> 
> I am not sure if our early check is because "does the prerequisite
> even exist?" is sufficient.  It is a short-cut that is cheap and can
> be done without preparing the commit traversal.

I suppose I should say "Usually, existence in the object store is
correlated with having all reachable objects, but this is not
guaranteed." I'll also mention that it is a short-cut that can fail
faster than the reachability check.

>> This check is more strict than what Git applies even to fetched
>> pack-files.
> 
> I do not see the need to say "even" here.  In what other situation
> do we make connectivity checks, and is there a need to be more
> strict than others when checking fetched packfiles?

I suppose that I was implying that fetches are the more common
operation, and the scrutiny applied to an arbitrary pack-file from
a remote is probably higher there. However, who knows where a
bundle came from, so the scrutiny should be the same.

>> To better align with the restrictions required by 'git fetch',
>> reimplement this check in verify_bundle() to use check_connected(). This
>> also simplifies the code significantly.
> 
> Wonderful.  I never liked the custom check done in unbundle code,
> which I am reasonably sure came from scripted hack to unbundle I
> wrote eons ago.
 
Excellent. Thanks for your feedback.

-Stolee
