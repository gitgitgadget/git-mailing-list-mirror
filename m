Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1B5C433FE
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 13:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbiKJN4p (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 08:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiKJN4o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 08:56:44 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4433B178A4
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 05:56:43 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id i12so1411257qvs.2
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 05:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c39ecbgBX8IrH6Bx+ebIpg4nB2jWKS2ReorJQQVFaxc=;
        b=QBEj3P2zZpqhAfUTCvUPLUa3nk6fJEx+gZDEQO4Taiot9lA30Ktqh3T04PLQThmJhN
         eqmrpc0hZj06C2AYRgBvbY3XMFpA8EhBaV9/WSinLnUzSgzd9M5ZHYpa0w372v54Lwxr
         xUTD4z0fpvGeX1GIUuko7lFrfGaN8tM7Sj2kVOXFktBJNc/J+JMIWRvWhwT/T4KJG842
         OUHgewl6Y5+nyMXiz4AYm+VjMNo6uDpDaQXu3EYRiib+YnVqTYkuQmtgl+ssfN/daOsh
         dOJmeukyR10QReA1jHSWYmwAnk2/DOdWqBEj+p0bY9D5w4motPiYdOLTaCunidOVNZHK
         ctxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c39ecbgBX8IrH6Bx+ebIpg4nB2jWKS2ReorJQQVFaxc=;
        b=xaLovIfZpAp7x5oo8jBgF3Pa0y/QzTIoPrbH8+zUN70PtSEtrpP/JKSI+Csx3nMR9c
         XmMvGV6bDoo4ZIY+B8AMqeUvHWSR8EbGliKyutcxY4LTM/6VINqaAhjE+iiiRT0tpVpx
         eztJWU7aegkZqX8P3H3q8/4Zz8+0ZdgEsG3dbBRV3/iGJjRi63vOMQKlLuZGhw1ydxB2
         Pwl6LMLeB+wSN2GSF1FDfsxb+XIGizMRUXR36OfL5F10rM7oEmT+psfQZ849ObrzNAoE
         25yySKUp+TV/w5pVAtFTAzK97BSpUGXTgeXmNb8t118E6GarFWVJJqzBzCI0tCK6QUxI
         /Ygw==
X-Gm-Message-State: ACrzQf0l49atch8JWhxsncXY/8fVXn7tcYIdWElBw+WjzDgtWK4V0qfw
        fnWPilLHTAXPGKC6M1rDjSMH
X-Google-Smtp-Source: AMsMyM7Q7bMUpnQIHTrTt/YsrlTq7ix4KxdfufeFOBA8ihA5py46UIu0/EZuvieeVW8PZH3a9TmrKw==
X-Received: by 2002:a0c:e512:0:b0:4bb:95ea:d6d with SMTP id l18-20020a0ce512000000b004bb95ea0d6dmr59804377qvm.72.1668088602210;
        Thu, 10 Nov 2022 05:56:42 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:8dc6:f062:5d1c:cdbf? ([2600:1700:e72:80a0:8dc6:f062:5d1c:cdbf])
        by smtp.gmail.com with ESMTPSA id bx12-20020a05622a090c00b0039c7b9522ecsm11438631qtb.35.2022.11.10.05.56.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 05:56:41 -0800 (PST)
Message-ID: <83b9ff0b-a655-714e-a8f9-44b0d1ac3177@github.com>
Date:   Thu, 10 Nov 2022 08:56:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] tests(scalar): tighten the stale `scalar.repo` test some
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1415.git.1668065327120.gitgitgadget@gmail.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1415.git.1668065327120.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/10/2022 2:28 AM, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> As pointed out by Stolee, the previous incarnation of this test case was
> not stringent enough: we want to verify that _only_ the stale entries
> are removed (previously, the test case would have succeeded even if all
> entries had been removed).

Thanks for tightening the test!

LGTM.
-Stolee
