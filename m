Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3D7C433C1
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 08:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CD5C617C9
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 08:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbhC1IOT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 04:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhC1IN6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 04:13:58 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F08EC061762
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 01:13:58 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id e14so2942175plj.2
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 01:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GDymjDVhhtDz1zT6Jyz9zyB7ycYQ4rGTGarkQ510SVU=;
        b=ptXtaowZBFRIoTSVw8TI0hRrfwtQ8y0lOK6fw9ebSN5g64JL8aVaMA4mkdXdaN9RGb
         Yl27G5HkOc163JtdH90N/WOpjM/i8XT2MJlK0xaoHy/A0b48lE5LETFuA7Jbxmm9d8Ty
         mDZ9H3al3VP9/2QmNjQuSWWq6xAIak2YrM4qnuX6hwAyzPihgcFMBVU3XMcaaB1kQuGF
         TRLsN3sqSvnn3/szy7sw6gIXldNieRS9D84YKbWfO854XYTtVdEdNf/S05EtZLWAAY2z
         99PZnTiQjoLRFVzdslqaup1s7wuDY9QMC7Y/s4CU9KrQPMJEWtuMLnm4CpzK0h9Cdn/J
         kP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GDymjDVhhtDz1zT6Jyz9zyB7ycYQ4rGTGarkQ510SVU=;
        b=hQZNSTTbNi2zp8glYXI06/P80DSXWJhmiqMjmJLKGQxbEDRWSKBQZQXDVol1IKrM06
         m/0m3GWywp6f6HxRYoIEOwCCryJHR4i0fWnKZOyCUJk9Dy9ULgPxDjm3Kx3AOZw71rSg
         pDnhmTEha3JWW5DJu0VtjC8oAliiLYTbu6wsNCcOsBYk7l5pRtBPIfseIHndqopA7dUI
         EjwyMpLMfQVteV2wrddFuEu1/xwAov5M80+wjpGZjqxXLU6pndVUTMSXNUrwrX7bQqD3
         LFfD1xFxc1jv3DXVPAcHlLsa36KbRyqfZ2hlF/kHyQsz+mu869oqzluA8+f2iIq1Efii
         YCZQ==
X-Gm-Message-State: AOAM532XvfP3ThsYoUZSO0rVW1zfe8GVCoobmW3mamp8e1BRTFKMXKF+
        mUR9SnHXxX6laxGr9iOH6oOOAEj2mJesng==
X-Google-Smtp-Source: ABdhPJyk20vqVp3qLkZfQOzFnknBWdFQO9VBG7IWni3qcN4EC8FSYMzrKCFfWJ5nbwTJ4NNcqP0A5g==
X-Received: by 2002:a17:902:dac2:b029:e6:30a6:4c06 with SMTP id q2-20020a170902dac2b02900e630a64c06mr23789030plx.65.1616919237667;
        Sun, 28 Mar 2021 01:13:57 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-8.three.co.id. [116.206.28.8])
        by smtp.gmail.com with ESMTPSA id q19sm14243748pff.91.2021.03.28.01.13.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Mar 2021 01:13:57 -0700 (PDT)
Subject: Re: [PATCH] Documentation: amended usages of various (sub)commands
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Chinmoy via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Chinmoy <chinmoy12c@gmail.com>, git@vger.kernel.org
References: <pull.920.git.1616913298624.gitgitgadget@gmail.com>
 <e85a653c-2650-313d-b5ca-5874559d9528@gmail.com>
Message-ID: <de6d56b5-89e4-1e50-1011-0a9b9c46f4d9@gmail.com>
Date:   Sun, 28 Mar 2021 15:13:54 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <e85a653c-2650-313d-b5ca-5874559d9528@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/03/21 13.56, Bagas Sanjaya wrote:
> On 28/03/21 13.34, Chinmoy via GitGitGadget wrote:
>> From: Chinmoy Chakraborty <chinmoy12c@gmail.com>
>>
>> The Git suite option parsing API's Technical Documentation suggests this
>> about the option descriptions of a (sub)command:
>>
>> `description` is a short string to describe the effect of the option.
>> It shall begin with a lower-case letter and a full stop (.) shall be
>> omitted at the end.
>>
>> Various (sub)commands' option arrays don't follow the guideline provided
>> by the parse_options Documentation regarding the descriptions.
>>
>> Signed-off-by: Chinmoy Chakraborty <chinmoy12c@gmail.com>
>> ---
>>      Documentation: amended usages of various (sub)commands
>>      The Git suite option parsing API's Technical Documentation suggests this
>>      about the option descriptions of a (sub)command:
>>      description is a short string to describe the effect of the option. It
>>      shall begin with a lower-case letter and a full stop (.) shall be
>>      omitted at the end.
>>      Various (sub)commands' option arrays don't follow the guideline provided
>>      by the parse_options Documentation regarding the descriptions.
>>      Signed-off-by: Chinmoy Chakraborty chinmoy12c@gmail.com
>>
>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-920%2Fchinmoy12c%2Fissue_636-v1
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-920/chinmoy12c/issue_636-v1
>> Pull-Request: https://github.com/gitgitgadget/git/pull/920
>>
>>   builtin/column.c     | 8 ++++----
>>   builtin/range-diff.c | 2 +-
>>   2 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/builtin/column.c b/builtin/column.c
>> index e815e148aa18..40d4b3bee2dd 100644
>> --- a/builtin/column.c
>> +++ b/builtin/column.c
>> @@ -27,10 +27,10 @@ int cmd_column(int argc, const char **argv, const char *prefix)
>>           OPT_STRING(0, "command", &real_command, N_("name"), N_("lookup config vars")),
>>           OPT_COLUMN(0, "mode", &colopts, N_("layout to use")),
>>           OPT_INTEGER(0, "raw-mode", &colopts, N_("layout to use")),
>> -        OPT_INTEGER(0, "width", &copts.width, N_("Maximum width")),
>> -        OPT_STRING(0, "indent", &copts.indent, N_("string"), N_("Padding space on left border")),
>> -        OPT_INTEGER(0, "nl", &copts.nl, N_("Padding space on right border")),
>> -        OPT_INTEGER(0, "padding", &copts.padding, N_("Padding space between columns")),
>> +        OPT_INTEGER(0, "width", &copts.width, N_("maximum width")),
>> +        OPT_STRING(0, "indent", &copts.indent, N_("string"), N_("padding space on left border")),
>> +        OPT_INTEGER(0, "nl", &copts.nl, N_("padding space on right border")),
>> +        OPT_INTEGER(0, "padding", &copts.padding, N_("padding space between columns")),
>>           OPT_END()
>>       };
>> diff --git a/builtin/range-diff.c b/builtin/range-diff.c
>> index 78bc9fa77062..50318849d657 100644
>> --- a/builtin/range-diff.c
>> +++ b/builtin/range-diff.c
>> @@ -25,7 +25,7 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
>>       struct option range_diff_options[] = {
>>           OPT_INTEGER(0, "creation-factor",
>>                   &range_diff_opts.creation_factor,
>> -                N_("Percentage by which creation is weighted")),
>> +                N_("percentage by which creation is weighted")),
>>           OPT_BOOL(0, "no-dual-color", &simple_color,
>>                   N_("use simple diff colors")),
>>           OPT_PASSTHRU_ARGV(0, "notes", &other_arg,
>>
>> base-commit: 84d06cdc06389ae7c462434cb7b1db0980f63860
>>
> Wait, I expected that this patch touches Documentation/* (as the title implied),
> but it seems like the patch content is something else (not related).
> 
> Totally wrong patch submitted here.
> 
Oops, I don't see that diff above. Sorry for that.

What about this patch title below?:

`Make (sub)command options conform to TD of option parsing`

-- 
An old man doll... just what I always wanted! - Clara
