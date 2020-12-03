Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAE7C433FE
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 18:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34874207B6
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 18:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbgLCSk6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 13:40:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgLCSk5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 13:40:57 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D720FC061A4E
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 10:40:11 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id t143so3221671oif.10
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 10:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GD6x/q1wO9AxobuQCN42E3duN+J47fzNVah69KFEkSg=;
        b=EUDen8HUcKRQ+hgeN7KSQIiFNsB/YOlo8LI2NNqfuo0RjxcrxWY0TwGDJaoAWI8bBX
         EvIJ0C/AxNqIaS6zvpi/b1CIa177w1XfT6oB6Z1ej73VxJ224T5I3Yjk/35+6j0E3S76
         Ezici1NWTmw1bGDgWTaENeoowXjZGcpQEh0fXuYhd7RZv3FRBLvGYPNO6M7dBj9fIzhq
         8cJ1MITHJ96egvF7FbNbQKdzqzlbtM9vk8UUIOLlInQ6rclhN0L0xNvhYWQ+S9j+9JGs
         o9A8Y+TbPiH2dzGinsLawXl9wQffH3TFhQB4z+9D+/WsDbDn+6qtHBYueKdvTjPua/cv
         jSyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GD6x/q1wO9AxobuQCN42E3duN+J47fzNVah69KFEkSg=;
        b=EKPcuh2x3W+58uydKkKgI2f/jd6ipSkp492W3/fAIVcOUHCeXqdAgXkT2jnzxXlmZ6
         5aeKQLy24qutuHHOXf6+z5K0pxqIjdMyqje5TYNMxfkto1ot1v/dXkbpLLGoXdj8WuvJ
         SagLKthcTk8C7aGNtvkztoISn20n/swEbBBQ0QnH1L+UaDWPz0rogJJ/Y1Oa8C/DKoDK
         UeAIRZrB+qMyLwmHR1BYg6jQt5Hb7f5n9fOgMHKIxmmkYOljnU4Wjny8OkuSjwdNuwHR
         s+B/Ej2pHVHlwSl1cXvcHm2lIBC2tnXy9cfad32q93UJbw1DCLalPhjeEkAVGq4okJ5U
         cRZw==
X-Gm-Message-State: AOAM532qJ2v1pHE7RdRxBbLWInO/c58WpwuEfMdbrDGImiubRrikTEP0
        4m64SicFLrz/SS+Ax5NB3PjYIsLcon0hHg==
X-Google-Smtp-Source: ABdhPJxHqi4EE3vANYk0XjGc187Dtp1prrtNEifI94MEkYchZFAfWsijhkvOm65QpSGWHCKWV040MA==
X-Received: by 2002:aca:3142:: with SMTP id x63mr271281oix.140.1607020810984;
        Thu, 03 Dec 2020 10:40:10 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id h62sm36935oia.9.2020.12.03.10.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 10:40:10 -0800 (PST)
Subject: Re: [PATCH 6/7] merge-ort: add die-not-implemented stub
 handle_content_merge() function
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
References: <pull.803.git.1607011187.gitgitgadget@gmail.com>
 <9f1ac20e31886ad7cd56ff582c58cce4ee743fa1.1607011187.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8e861bc8-4da1-01aa-7de6-c6c128590170@gmail.com>
Date:   Thu, 3 Dec 2020 13:40:09 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <9f1ac20e31886ad7cd56ff582c58cce4ee743fa1.1607011187.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/3/2020 10:59 AM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> This simplistic and weird-looking patch is here to facilitate future
> patch submissions.  Adding this stub allows rename detection code to
> reference it in one patch series, while a separate patch series can
> define the implementation, and then both series can merge cleanly and
> work nicely together at that point.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-ort.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/merge-ort.c b/merge-ort.c
> index e653ba35ea..e7220cbbb4 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -523,6 +523,18 @@ static int collect_merge_info(struct merge_options *opt,
>  
>  /*** Function Grouping: functions related to threeway content merges ***/
>  
> +static int handle_content_merge(struct merge_options *opt,
> +				const char *path,
> +				const struct version_info *o,
> +				const struct version_info *a,
> +				const struct version_info *b,
> +				const char *pathnames[3],
> +				const int extra_marker_size,
> +				struct version_info *result)
> +{
> +	die("Not yet implemented");
> +}
> +
>  /*** Function Grouping: functions related to detect_and_process_renames(), ***
>   *** which are split into directory and regular rename detection sections. ***/
>  
> @@ -919,6 +931,8 @@ static void process_entry(struct merge_options *opt,
>  		ci->merged.clean = 0;
>  		ci->merged.result.mode = ci->stages[1].mode;
>  		oidcpy(&ci->merged.result.oid, &ci->stages[1].oid);
> +		/* When we fix above, we'll call handle_content_merge() */
> +		(void)handle_content_merge;

I'm not exactly sure what the value is of this line. Is it just to
make sure we have a reference to the 'static' method without actually
calling it anywhere?

"weird-looking patch" indeed! I'm more confused than anything.

Thanks,
-Stolee

