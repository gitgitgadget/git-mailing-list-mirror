Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E868CC433DB
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 15:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FACB64ED5
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 15:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbhBZPw7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 10:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbhBZPwt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 10:52:49 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2314FC061786
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 07:52:07 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id x10so2283522oor.3
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 07:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MhvV8gwFXVEVJnaZTe/B8XSBbotnKbt6kS+6WwBAHaI=;
        b=tYuQOR2IOBOJYa1y+mwN7cRNgMdW4rj7AjqeHau58z8wVKS3vcWTlEtR65lSZm+T/d
         SVc/Mvs4VD/Ewg9xo2bFhq2PXbdxhnHbQxg69d/CiBaOspzWigyfPJtNaWiU5CzTdFvQ
         evvX2y//auvdw5XRyASazaUprnFRTREyntDY39nJGVD3EI+Rbr8CaNNbxV3iTqgBJnAb
         Emtm0nUeitjDLZJP6I6rGu2b7xBoyx6zS1WgvMYczeo+C/qb8eakhqLGaPkfxNHF84Jh
         p2jTUfEh2fGqLtOzTT04dakrkp6731+GVXeU8x3mBDIsj91iD0r8N7CMfFA/AjKF29ts
         M9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MhvV8gwFXVEVJnaZTe/B8XSBbotnKbt6kS+6WwBAHaI=;
        b=BJWZzTzl19lbI9adZEOhi+VYMOS7OW99zBB45mc1rUL6yED5BgtrpNfOwnyKAs5juS
         +b1Wele0YiowU2lZZzNORbp+YE+zMC8m5Ajslprs/MMJBVt4pz7CzDwH/kX0q4DDUYn9
         DH+7KJHX06IVGWpGS366Cujl/L2T5AZrhOWx639NDu8Af3FXHBD0iBLhg9IXM3FMFaHr
         EqAkn0Q6kung0t7GMR1kElQvczd+J0GWP0W1EIIkaqkzc/RBSrqBZDo6SaHkwIc2tQlt
         Yepz4yIVGIkOsZoEEidC29sbLswvPZEdo7Jep9XiqRgoSL9SI14To4VP9fl19DuWG49A
         FMOA==
X-Gm-Message-State: AOAM531GChLU3Xc9Ij6nDQdvkk6BfmcwyhdO5PrIbPEAlDK2eXmxfEJX
        yJR4bITdJ6lurPmVTMOWpZmLgu1UbkHhQg==
X-Google-Smtp-Source: ABdhPJyna0VseSs6QMaTCIB3QeUfMMmdWFG46ydGhHvBq+RcYt/I/FOGWas8VcOiRF6dCtnx6ZC4ZQ==
X-Received: by 2002:a4a:94a7:: with SMTP id k36mr2664842ooi.45.1614354726508;
        Fri, 26 Feb 2021 07:52:06 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:8d21:2da6:2067:31cb? ([2600:1700:e72:80a0:8d21:2da6:2067:31cb])
        by smtp.gmail.com with UTF8SMTPSA id m11sm1704580oih.34.2021.02.26.07.52.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Feb 2021 07:52:06 -0800 (PST)
Message-ID: <9edad7cc-f578-3b55-394a-08b351eaa7c5@gmail.com>
Date:   Fri, 26 Feb 2021 10:52:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH v3 02/10] diffcore-rename: add a new idx_possible_rename
 function
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.844.v2.git.1614123848.gitgitgadget@gmail.com>
 <pull.844.v3.git.1614304699.gitgitgadget@gmail.com>
 <40f57bcc2055773a7dd35bde50c54354a643d07a.1614304700.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <40f57bcc2055773a7dd35bde50c54354a643d07a.1614304700.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/25/2021 8:58 PM, Elijah Newren via GitGitGadget wrote:
> Anyway, that's a lot of background so that we can actually describe the
> new function.  Add an idx_possible_rename() function which combines the
> recently added dir_rename_guess and idx_map fields to provide the index
> within rename_dst of a potential match for a given file.

This paragraph could use rewording now that idx_possible_rename() is not
new to this commit, and dir_rename_guess() is introduced here (but not
yet initialized). This would be a good time to introduce the
dir_rename_info struct and how it _will_ be populated.

> -static int idx_possible_rename(char *filename)
> +static int idx_possible_rename(char *filename, struct dir_rename_info *info)
>  {
...
> +	if (!info->setup)
> +		return -1;

It might be worth noting in the commit message that since
info.setup is always zero, this implementation is not run (yet).

In general, I'm finding this a lot easier to read the code in
the presented order. The commit messages need to be massaged to
match.

Thanks,
-Stolee

