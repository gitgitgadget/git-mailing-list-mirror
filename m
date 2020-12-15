Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99153C2BB9A
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 14:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62B4822518
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 14:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbgLOO2j (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 09:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729565AbgLOO2g (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 09:28:36 -0500
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2752AC0617A6
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 06:27:56 -0800 (PST)
Received: by mail-oo1-xc41.google.com with SMTP id x203so4868434ooa.9
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 06:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Lad/crKAEEwrKFNNzGStey1MKEY2XoKyH7FneJoV1I0=;
        b=bq1slNtLyxE6MdoNzlQGIEqEvFogvMtuou7e6TZMKQPS1DTvlSlStQ4T2IZZmtpfis
         YcWSukEGAknuL3AbDSWZiaultxMisHI7GaukhcFUVziDJDriPIzC/ghfzZJ21N33aKnN
         DQE8U6pMJ6/TZ+E8v1rxQ6wG3ySzZm4fpFgAST76uQShpeEyYwJ4MhGAz1sY4TpobyeO
         BGTQDnKIyj0T/GD9ueJYfGgRsOUWdHIFAA3C/XQBSogxnAaHZsU3nk3CKmBwFyxLcJ+o
         ZOCsksRV2uN/8XTjZgtAXl/7BMnwEQTH9wjayycO7NTsdmNlQizoEk6SvOGSuREfVXmv
         f2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Lad/crKAEEwrKFNNzGStey1MKEY2XoKyH7FneJoV1I0=;
        b=NQeeCH4BFfncerhqplWBcVMJpztTW95sLGNwwc/WV5wqCgPX2i2wArTinj3Qr8o579
         UVBhiC/O9ZSSkOftqaMgHayX9NWIwCzBlZHO9Nw0CA4ul7Z+zwGIIryIBcxTNeHOk2Na
         6clGAq8R4q6eAgpXhoH0fH+mRKU+DJbFQH5gslpuJ8yvULEEsAJizi/y0vYeOC461HFC
         9+CmMpwQ1m55hkWwC6SjyP4PnBGKZilIozvjC+qr5ZYMaEXDvaKFpTan+U31dcW7bql+
         L8pcBUOkcSK2jORZC013DezOfSwaMfN6q/dwJDKwOoludXyf+5YmGefnqMWjuXtdK+mG
         rrFw==
X-Gm-Message-State: AOAM532fqUpl9xOnYs+P6aj7ggv1JKwxtEWxllPqCdHvfO7O6kidZqke
        0NVRgCkfMVRPY4lXt2kXXW8=
X-Google-Smtp-Source: ABdhPJx90bU5TIFSuMeGjH7VaFtQW50xt30l54Wbu4ZuSgb5v+lSsbFNlsuwSvMG2KXpAJdNXgypVA==
X-Received: by 2002:a4a:bd19:: with SMTP id n25mr22579892oop.56.1608042475510;
        Tue, 15 Dec 2020 06:27:55 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id c14sm441689otp.19.2020.12.15.06.27.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 06:27:55 -0800 (PST)
Subject: Re: [PATCH v2 10/11] merge-ort: add implementation of normal rename
 handling
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.812.git.1607542887.gitgitgadget@gmail.com>
 <pull.812.v2.git.1607962900.gitgitgadget@gmail.com>
 <22cb71102614f9d1fdd41a4b9524f11e08afa241.1607962900.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e7ce7008-0968-895c-f6e2-ee2609fd2556@gmail.com>
Date:   Tue, 15 Dec 2020 09:27:54 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <22cb71102614f9d1fdd41a4b9524f11e08afa241.1607962900.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/14/2020 11:21 AM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Implement handling of normal renames.  This code replaces the following
> from merge-recurisve.c:
> 
>   * the code relevant to RENAME_NORMAL in process_renames()
>   * the RENAME_NORMAL case of process_entry()
> 
> Also, there is some shared code from merge-recursive.c for multiple
> different rename cases which we will no longer need for this case (or
> other rename cases):
> 
>   * handle_rename_normal()
>   * setup_rename_conflict_info()
> 
> The consolidation of four separate codepaths into one is made possible
> by a change in design: process_renames() tweaks the conflict_info
> entries within opt->priv->paths such that process_entry() can then
> handle all the non-rename conflict types (directory/file, modify/delete,
> etc.) orthogonally.  This means we're much less likely to miss special
> implementation of some kind of combination of conflict types (see
> commits brought in by 66c62eaec6 ("Merge branch 'en/merge-tests'",
> 2020-11-18), especially commit ef52778708 ("merge tests: expect improved
> directory/file conflict handling in ort", 2020-10-26) for more details).
> That, together with letting worktree/index updating be handled
> orthogonally in the merge_switch_to_result() function, dramatically
> simplifies the code for various special rename cases.
> 
> (To be fair, the code for handling normal renames wasn't all that
> complicated beforehand, but it's still much simpler now.)

Definitely looks simple.

> +				memcpy(&newinfo->stages[other_source_index],
> +				       &oldinfo->stages[other_source_index],
> +				       sizeof(newinfo->stages[0]));
> +				newinfo->filemask |= (1 << other_source_index);
> +				newinfo->pathnames[other_source_index] = oldpath;

I'm happy your organization brought us to a clean place.

Thanks,
-Stolee
