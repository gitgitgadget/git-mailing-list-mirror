Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144BCC433E9
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 11:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E510E2395A
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 11:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbhAJL5t (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jan 2021 06:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbhAJL5s (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jan 2021 06:57:48 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B328EC0617A2
        for <git@vger.kernel.org>; Sun, 10 Jan 2021 03:57:07 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id j12so14256859ota.7
        for <git@vger.kernel.org>; Sun, 10 Jan 2021 03:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A5iPxhsBV3d+G0Cazh3mqN6x6cQvmvP8TdJELUYRKnc=;
        b=prTefsLhYty8JdgVn9DKb6NOG0kfcnbeg8On9WfhbzdQsAme2J+bA8SCrCgZ3WBqI8
         qT+BvrguMXsc8uNT7tVr0GNIv85nYhLeB9Qzw5cTJB0U+8dlUiJ9iut0HtFKimhfF0cW
         cxkc/7ZELkt3HTZOpAWf5iBplakHRUodkAVq2vmQwNLwbx81xaNj9IEJN0jcio4Up3Bb
         uwuajG68M8k6gBIGtvzbMcAnUxwNsh1QogEuXC2PZOeqy5jUPzAw7VaKw4dfjCPLl3Ta
         M6qQF3YTzN9qSS2eE+d6VwRWu7o2y5E6OXL00ud5ai3ltDpLk5/kIkZ8U8cFER++J65C
         HP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A5iPxhsBV3d+G0Cazh3mqN6x6cQvmvP8TdJELUYRKnc=;
        b=ZJ6WnheHGLzXYy0zahiseOFsgtzQtYdaaIEiGWFYXGPG7zwg2lGkN9SBm4yyXQOqHk
         h3HndcenynfPCiubxM5WV5dKVqBgz3ZHmA6j3FBSxIHL6UqKnSSmivBm6xnr3dr8DvjT
         f9nIQEkju1eZNRoZ7rOHCGG1DUQcnT7fw5YO4qRSeROwi7ITBzwuXJKkVlBFP5VwLKWx
         gPkXc0vOiqj1eTqhv272jrIKfealgKF/Cw+vAaj4iQHj87wPXG5aWpRSj4g62yDKfSIk
         DUh4dPrT3+WVjqsaaa0CdPeUJ0Bgz5pVZxgfMcpIbBtIl6y0w81I2ju80JsdlDTHtci5
         rqgw==
X-Gm-Message-State: AOAM530JuT0fgmZeQIPmvg/ftA2gVYJlk/U86aWECcjfy2UivMlJn1oX
        R8dwVXGAYAEgA1TCaXA/xww=
X-Google-Smtp-Source: ABdhPJz6jpRfw0dyqYvuTR25xQxba7YP6tq9pUctkwxqTpuqJT2HfBKAhTEKm69To5iKCR93+vxxDg==
X-Received: by 2002:a05:6830:1f5a:: with SMTP id u26mr8049726oth.250.1610279827030;
        Sun, 10 Jan 2021 03:57:07 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id d20sm3001342ote.48.2021.01.10.03.57.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Jan 2021 03:57:06 -0800 (PST)
Subject: Re: [PATCH v3 00/14] Remove more index compatibility macros
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.830.v2.git.1609821783.gitgitgadget@gmail.com>
 <pull.830.v3.git.1610136177.gitgitgadget@gmail.com>
 <xmqq1retclzr.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1c428df5-849d-7e30-76b7-498bdd827f5e@gmail.com>
Date:   Sun, 10 Jan 2021 06:57:05 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <xmqq1retclzr.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/10/2021 2:03 AM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> UPDATE: this is now based on ag/merge-strategies-in-c to avoid conflicts in
>> 'seen'. The changes in builtin/rm.c still conflict with
>> mt/rm-sparse-checkout, but that branch seems to be waiting for a clearer
>> plan on some corner cases. I thought about ejecting it, but 'rm' still uses
>> ce_match_stat(), so just dropping the patch gives less of a final stake at
>> the end of the series. (I'm still open to it, if necessary.)
> 
> I haven't read this latest iteration myself yet beyond the cover
> letter, but tonight's 'seen' has this queued near its tip.  I expect
> it would either stay there or occasionally ejected, until the base
> topic solidifies a bit more.

Thanks. I'll continue to watch that topic and provide review as
new versions come out.

-Stolee

