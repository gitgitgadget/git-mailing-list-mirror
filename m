Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1150C433E9
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 15:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7041864E6C
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 15:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236794AbhBXPxW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 10:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233586AbhBXPhz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 10:37:55 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BCDC06178A
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 07:37:04 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id r19so2545661otk.2
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 07:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vIGBsfeeUqh7v3eAC1AjB1z514jigGiNQs0aaBhZTjA=;
        b=d8LBqtN7tonglrFtOLgtoyCUQIiGZGA2UT/pzsFnSCIvqVUyBCO0vRXx+4R6IROay6
         8i/Qfw9oyCbmDbMBE4iTTwWtFoAJU0JBHZiTj9ePIrz7k0/EsQ4m0tB60YKeU1FRkxCu
         MX0hrXuE144KuBCezWWOzHYQ9qbHV+h0lesQs7edaMvRptHkmiGjShpj0RjRH5NzrmQ0
         fHrAOa9LVhDWYFWUhKboqMPbA5whmkfuuXVn+AH/WIu22iHV++NsgM/420qBFTmYURhQ
         Fu5j+ZL5uvDL+LeI/Q5kzfDgqO8jtDkOk3IL1Zhogv0DUPnTxUom2yVTUkuy3WmCFn1P
         kbQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vIGBsfeeUqh7v3eAC1AjB1z514jigGiNQs0aaBhZTjA=;
        b=PwW5H4QObvVSoVAmTnbidPvtrsZ9P94iCcLLqypS5pk9VkzEMxDw1ioFG5EOK1ccL6
         0yWzm9hLbBOj8XUv5hFUNhOYHHhDiEX0YhsIMIbQ+Kjfk4GlxOjJvRdtX3csnJr9rp0o
         61PrNSQGfUNffxbcRDol2LRLl7vraUtOm860Z3829kP4CzQz/vmjrdh+dToJ7sAUSrw5
         yKnUbdyf/Rf0+Q4VtDI5jktS+rcp7RHotgKvusGF+9a7ylQmvY3xf9SjDolZx/nR92LA
         Ojib9GpUWBmhrbi9+TMnTXkIE6lsfCVIWWZJoFgRrcFBqmBr2A+bT0YmRX8jD/k7hcDd
         gHeA==
X-Gm-Message-State: AOAM532CGdJkc9G3LEc4sPiJ1buSbRDHJ/31bglM50TwhpSmBTKAb+BQ
        /5Lc+VdaNwMU5ucq4zoZsro=
X-Google-Smtp-Source: ABdhPJy4V+ekvy6eZORa9XPnjuA/qgtZgr64lOg26ZZqOEPoiDnYlPCp3dKHKKKVr2beVxJa3O3Wyg==
X-Received: by 2002:a9d:66c9:: with SMTP id t9mr4379612otm.111.1614181023534;
        Wed, 24 Feb 2021 07:37:03 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:d50a:c289:effe:68e4? ([2600:1700:e72:80a0:d50a:c289:effe:68e4])
        by smtp.gmail.com with UTF8SMTPSA id t20sm413003oic.23.2021.02.24.07.37.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Feb 2021 07:37:03 -0800 (PST)
Message-ID: <588e7f21-9890-3aa6-4222-42946c5446fe@gmail.com>
Date:   Wed, 24 Feb 2021 10:37:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH v2 04/10] diffcore-rename: extend
 cleanup_dir_rename_info()
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
References: <pull.844.git.1613289544.gitgitgadget@gmail.com>
 <pull.844.v2.git.1614123848.gitgitgadget@gmail.com>
 <f7bdad78219de6819d0403f8957e9a0c8b4218bc.1614123848.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <f7bdad78219de6819d0403f8957e9a0c8b4218bc.1614123848.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/23/2021 6:44 PM, Elijah Newren via GitGitGadget wrote:
> +		for (i=0; i<to_remove.nr; ++i)

nit: "i < to_remove.nr"

I'm really stretching to find something valuable to say about
these well-constructed patches.

-Stolee
