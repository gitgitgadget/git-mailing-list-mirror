Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9D5C433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 13:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82D2561158
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 13:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343763AbhIHNQc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 09:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235989AbhIHNQ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 09:16:26 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A90C061757
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 06:15:17 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id l24so1765227qtj.4
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 06:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MGE/xU+XQsh5EWgXuvPHIfww6TxM9oqS0WWac4MR2ck=;
        b=JZv9zS+wW1FDmWJJER9h4/UpZgaYCzpYbdDkZaFMmt2RyvsNREOCikseFhbMcSs+lY
         bWtxFeyMNKUU58ztJH4+3+Zs6kUPtVAr1G6ax7Ob21we8vQ0WD0O0PTeJX7sPUuNEb8r
         5FMzHFbE3UlUM+XFMzXbljJtVbOLx/N7ZZhaz0CzPwY5Kul03dszHUKaU3/2zaNIWPtL
         ThJYq6mHt+XPQnGyoFrRCv2c9di4ZipbyKp1tikLB8p5GwnpBq7JYbECL5o/U3f0A8V5
         ZUr1wVh7E8ANh9/soCYDoqv8OuU3RrWscylD/F0+wqwIPwIUXRC4yzAEQksMlRoZ4478
         oJug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MGE/xU+XQsh5EWgXuvPHIfww6TxM9oqS0WWac4MR2ck=;
        b=tUtKs407ucxMsajbLtliX66GYaT5wDZNCx6NS1FjEXY97exsWH3smAggKg/frT8BHv
         gJQ85IlwNHQt4BOxDrS4owwUB8VeFG26NJIts3izenckV3pk3WNC96XPwSxYGc0FxQKD
         2aJFWDuzqTEzlqaJ/BXdrmY64aAcyzOGfnJjhb5u78K4g30Cvw28M6Om7Psdx9LNE35U
         WRiEuxVykYm1u6mMR8EFbCxfF6jb3wSedpxCiGSOL57Xms9MqE77IY1TFqQLtC0lCMAD
         a/YcUjypqJaRaHEjwsFuDOB/SmXkc6wFBGiDFLHiMnVJikKpwpXpeSAUIHQPh6DWst2M
         tyVg==
X-Gm-Message-State: AOAM532tK3o7MFUKhmkfFgFiNL4zFrhGOPRckjeTsvPIiuCHrH8g+AgU
        I53e5BMYRdHuG6Vhbt7VxkDteMlKBQo=
X-Google-Smtp-Source: ABdhPJyZ/KbPZP0O38xSVXGxCwxPwNUITyJ7eZI4T3+DZLOCq78x3KTPapbbHMVF5TKMeREJDlum4w==
X-Received: by 2002:ac8:4818:: with SMTP id g24mr3525048qtq.328.1631106916914;
        Wed, 08 Sep 2021 06:15:16 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:79fe:8f64:ef46:a881? ([2600:1700:e72:80a0:79fe:8f64:ef46:a881])
        by smtp.gmail.com with ESMTPSA id p123sm1697527qke.94.2021.09.08.06.15.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 06:15:16 -0700 (PDT)
Subject: Re: [PATCH 3/3] stash: restore untracked files AFTER restoring
 tracked files
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
References: <pull.1086.git.git.1631065426.gitgitgadget@gmail.com>
 <ac8ca07481d2ed4156036c2441d10712a1b92b0e.1631065427.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <53a16340-561b-dc67-5562-31d16460da84@gmail.com>
Date:   Wed, 8 Sep 2021 09:15:15 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <ac8ca07481d2ed4156036c2441d10712a1b92b0e.1631065427.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/7/2021 9:43 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> If a user deletes a file and places a directory of untracked files
> there, then stashes all these changes, the untracked directory of files
> cannot be restored until after the corresponding file in the way is
> removed.  So, restore changes to tracked files before restoring
> untracked files.
> 
> There is no similar problem to worry about in the opposite directory,

s/directory/direction/ ?

> because untracked files are always additive.  Said another way, there's
> no way to "stash a removal of an untracked file" because if an untracked
> file is removed, git simply doesn't know about it.

Makes sense.

Thanks,
-Stolee
