Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605DDC433F5
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 10:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40A2B61181
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 10:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238094AbhJFKgw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 06:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237836AbhJFKgv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 06:36:51 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA869C061749
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 03:34:59 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id np13so1856758pjb.4
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 03:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rBlAn+C2g5wBlSPkoIBTos8nqhgHLRK17MLF/s3j4Oc=;
        b=SX5qRYk92mvBMcy1gMrew/vjo4Jd56Wtl96fRquWiIC5rof0qMIXpZ4DnPWJl2rS/T
         M+W/r4Wg1FRGLj1yb+JhD04EeWzpuMYDkQVKCixPt8h+CA/n34mM68VV8NBuUaL+N+Ys
         RyQSmseajuLF4+7OPf9nWAfJJfFZLI2d7+AeyLTAx1XJNxvFYJJH8t0SvjwCgr9EKubw
         6v0b2WFEeYKRz0HHDe8HxFiUsXZYLhPoeIwwHAPQdd/ShQ/P9aicJFr5gCPDIjrQW/vs
         mybiPxXTwEWWAPVrzcTh5w+FgA1KWlVi2+novHTd4ilPweRaqUpy68p3uZPKIm8glniM
         EGeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rBlAn+C2g5wBlSPkoIBTos8nqhgHLRK17MLF/s3j4Oc=;
        b=h20nruCEaL6dlVKVch9XwEU8Afik7ET+hDR4Yhg+JI9xsL6DyZX633SuC0fHDj3quK
         i4pudw/NuRt3DqaHo3iNjDgEjX+I0RjumrkY8/eNnl4LKihTM3DagmGQx6Iurxsbrh3H
         i21ZrVzj6xkXirmxq15zq8YJp5PbMCgzt3h2NAdJOKdJ9Xxb+BmUX2IKGMl7uI3V3P9e
         /JWP0A8dpalqGJ4VeF3sn/hM3Xq+NTE1ybCt+rIJIkR4bIUpWt49jaMOKfT/Ev1YUFeq
         Q2A96lDrbXGteqlIC/yKaU95Jh24Q678kxSCMvvEDupCvWKO5f+cFV6ztgLFHQZUfP3J
         yUaA==
X-Gm-Message-State: AOAM531Jxw1+akDE22k4tM5ILqUChNwXg1raVsA7+uE4wu+4vDFsYvtv
        G09LhmmZCfHKdD/Fa1yKcRU=
X-Google-Smtp-Source: ABdhPJwzzgsmjROCscd5yvn5OFepBGvEPKA26J2egE7R2MuEgSdL5vuGdVd9mCJpAIFMXy8OsmO4EQ==
X-Received: by 2002:a17:902:7613:b0:13d:b35f:b4d7 with SMTP id k19-20020a170902761300b0013db35fb4d7mr10480208pll.8.1633516499502;
        Wed, 06 Oct 2021 03:34:59 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-73.three.co.id. [180.214.233.73])
        by smtp.gmail.com with ESMTPSA id z8sm20432760pgc.53.2021.10.06.03.34.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 03:34:59 -0700 (PDT)
Subject: Re: [PATCH v2 5/7] reset: make sparse-aware (except --mixed)
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>, Victoria Dye <vdye@github.com>
References: <pull.1048.git.1633013461.gitgitgadget@gmail.com>
 <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
 <78cd85d8dcc790251ce8235e649902cf6adf091a.1633440057.git.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <2d0c6f7c-ef7c-4d9a-4d57-d95404b6e20a@gmail.com>
Date:   Wed, 6 Oct 2021 17:34:56 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <78cd85d8dcc790251ce8235e649902cf6adf091a.1633440057.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/10/21 20.20, Victoria Dye via GitGitGadget wrote:
> From: Victoria Dye <vdye@github.com>
> 
> In order to accurately reconstruct the cache tree in `prime_cache_tree_rec`,
> the function must determine whether the currently-processing directory in
> the tree is sparse or not. If it is not sparse, the tree is parsed and
> subtree recursively constructed. If it is sparse, no subtrees are added to
> the tree and the entry count is set to 1 (representing the sparse directory
> itself).
> 

Better say `If it is sparse, no subtrees ..., else the tree ...`

-- 
An old man doll... just what I always wanted! - Clara
