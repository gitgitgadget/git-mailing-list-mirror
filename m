Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D53AC433C1
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 07:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE87161A02
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 07:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhCZHxF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 03:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhCZHwv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 03:52:51 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10770C0613AA
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 00:52:51 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id y200so4331744pfb.5
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 00:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=0lHKIKyvXHRmCFnkfqEwG4atkXgqTN8E9qBk47BE1l0=;
        b=udH1W2NFg32xKSddZpfsln7zL5KipTs0lkJ2Np3AQcAZOMiE0wSKKCm8HQImKJF/Vc
         SWGd+w4PksUktbIZpg+XzlOv6GHuSYQ+cU2tQAz+VvhCaAH7yI9pYJ19qK9V7vHdD0hG
         Tt70lS+79EozRisRjbFt3o/Nggl0zJXnxXyESGPfDfQJJ6r8Fb4zRjWAwuwwyZqQn/gi
         nSqIuHwS1i/AoFv/xnWxNHuIteyGqEd70ScmM/fwe7xuQxmDJvrr64xnXpJaznCVoS4L
         7izJOjTs9fje4IONApOUQLggd3+L3B8IpmUB9+8fhHgKZJDohS0XFKRM0DWT8neAaI3o
         oUhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=0lHKIKyvXHRmCFnkfqEwG4atkXgqTN8E9qBk47BE1l0=;
        b=fp+C6ICZ87ZP2LtwdXAnH+qebfPgMtgUVvklLUoTnlxPvS7gj/+YqXXX6QfH9dmfJV
         hdXrLIgGA9DWx/C7tYjoxhs7JB7lrByqeyipQocwhb9KjoWAByRvtHRWF4Hmn3vCxvAU
         Go/ECKWEReeB4yb7l07q3MviTxmb2JO7pUzMBc2o3H2MXQB/SvXAnN9Xssulc5aPuaLW
         mmcR5vR5AFcbYwe9x/A9wT2Df0usi2phnLO93vJVJ0jAp3gLGrYxRCZBFju8EuKDxsx1
         uF76A29AbURKNiSphH8wKv1PJUUhJObHTlEM3+08w4XFRAtFVvTwKudwSwcRcqfYS97a
         artw==
X-Gm-Message-State: AOAM5310Vuws7ZeUr5VS7ILUfgqcr9ygWVeRaKNofMSQmV9KwYsSdN5e
        MuPbF6E9skLvbrqZ2RgnuJESTIZJIcJX3Q==
X-Google-Smtp-Source: ABdhPJx0MSHSrIojLc0LqqLErXVL80RUwiyAIKTV3K0pLhRklXrMEDYddZ2McHYkpCiDP7vp5RmsEg==
X-Received: by 2002:a63:1b25:: with SMTP id b37mr263281pgb.371.1616745170204;
        Fri, 26 Mar 2021 00:52:50 -0700 (PDT)
Received: from [192.168.10.22] ([125.21.249.98])
        by smtp.gmail.com with ESMTPSA id y8sm8782318pfp.140.2021.03.26.00.52.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Mar 2021 00:52:49 -0700 (PDT)
Subject: Re: [PATCH] cache-tree.c: remove implicit dependency on
 the_repository
To:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
References: <pull.915.git.1616701733901.gitgitgadget@gmail.com>
 <f187df01-8e59-ac74-01e1-586a7a63fd4e@gmail.com>
From:   Chinmoy Chakraborty <chinmoy12c@gmail.com>
Message-ID: <b8f81261-635f-ba5c-5f10-9f96349a9583@gmail.com>
Date:   Fri, 26 Mar 2021 13:24:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <f187df01-8e59-ac74-01e1-586a7a63fd4e@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 3/26/21 2:01 AM, Derrick Stolee wrote
> 2. Rebase your work onto ds/sparse-index, so you also fix the
>     new use in sparse-index.c.
Should I open a separate branch (and PR) on my repo, with the the 
updated ds/sparse-index and then submit it?
