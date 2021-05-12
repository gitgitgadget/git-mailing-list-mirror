Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6355CC433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 13:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F03861363
	for <git@archiver.kernel.org>; Wed, 12 May 2021 13:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbhELNNc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 09:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbhELNNb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 09:13:31 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F75C061574
        for <git@vger.kernel.org>; Wed, 12 May 2021 06:12:21 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id m190so18215253pga.2
        for <git@vger.kernel.org>; Wed, 12 May 2021 06:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8dKycfZxOGiUSehHUzKMbxSoTIg36dZm26trWqKCB9c=;
        b=RboL7EkUJC7zWFtqluWRzTcqlicKxcIjaXqGmmDUjf2n2Zse+SUBUwmzBniPflrzJO
         svZ4FuSpRJ7v+JQEl73qj9xmjS+UO/30DRQRZ6fxwToVayPS+GsF+yhYKwCV3g4eKZvY
         GEXUVEJYQJ+wPTTCfhuG4SiX4YPrKs+EQtTv1+pQhtTUM4DGoIuvgWAbITAGcmMG5BCS
         XoImSG80K5O8HJO1hRtIizNTsdG437fFajmdcyRMWyV5DMuNYQY6KFV4g7N0XwNR3g9w
         yNS6J2txtxPGuFxRmA3nOQoOo1BHWT9IW4meeey5nS7kyLhpldt2pm2eaAzwddHHibne
         SdKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8dKycfZxOGiUSehHUzKMbxSoTIg36dZm26trWqKCB9c=;
        b=sSefIf4EM0/45zp8Q5BCil5I54VsWC3z9pL2CWesIp4a6tpt4ykK6zWeuuqm9cFAcq
         mh4inGexZGMEMEjNhhCzNrQXEJ3r/BMCDlvhNgVmsLTa4IDYsToV9eus02tmXwDyMqhQ
         8R5tk7qNYpGsoLS4PPmkjFLAMvzpzXAkazyyuAnnQKwC1lv+KgQ+ln32BJ577UES50Vu
         6cP1kGwFhnrULazeAs0jEk2FV5ImOO93RvDYB6p/yePyqYgb3uwtjxBm2Z5uuK2Y3jxq
         kESp3qCyEBnFwUQlkpTh0nFof1ZnW47rUWCXEWlcbJdQE/lWEmpJ6E72ciPz6Uq50uG1
         jh9g==
X-Gm-Message-State: AOAM531wr0ehqGD07vTJfd5XW3oe/BxLTffkUQ/aMqzNdaZ2ozxIDK31
        DBXsg5p5gk7R28p3U+mapc1KyA5KPdagOA==
X-Google-Smtp-Source: ABdhPJzb9A0GfUOViN5DtFBxrwJobpdFM0i+8yDp/aGEVypk8boqQFc3iw4fJg8cq2TIxTNHIDpbTA==
X-Received: by 2002:a62:60c4:0:b029:2ca:ebf7:cd0d with SMTP id u187-20020a6260c40000b02902caebf7cd0dmr7049258pfb.71.1620825141351;
        Wed, 12 May 2021 06:12:21 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-43.three.co.id. [116.206.12.43])
        by smtp.gmail.com with ESMTPSA id v12sm4501040pgi.44.2021.05.12.06.12.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 06:12:20 -0700 (PDT)
Subject: Re: [PATCH] pretty: fix a typo in the documentation for %(trailers)
To:     Louis Sautier via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Louis Sautier <sautier.louis@gmail.com>
References: <pull.1023.git.git.1620818283024.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <b81b5625-db23-7fbe-a122-bce08d61b2e9@gmail.com>
Date:   Wed, 12 May 2021 20:12:18 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <pull.1023.git.git.1620818283024.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Louis, welcome to Git mailing list!

On 12/05/21 18.18, Louis Sautier via GitGitGadget wrote:
> From: Louis Sautier <sautier.louis@gmail.com>
> 
> This just changes occurance to occurrence.
> 

The commit message is essentially occurance/occurrence.

> Signed-off-by: Louis Sautier <sautier.louis@gmail.com>
> ---
>      pretty: fix a typo in the documentation for %(trailers)
>      
>      Hi,
>      
>      Here is a very minor change: occurance → occurrence ?
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1023%2Fsbraz%2Ftypo-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1023/sbraz/typo-v1
> Pull-Request: https://github.com/git/git/pull/1023
> 
>   Documentation/pretty-formats.txt | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
> index cd697f508c53..ea9b26c3f734 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -271,7 +271,7 @@ endif::git-rev-list[]
>   			  `trailers` string may be followed by a colon
>   			  and zero or more comma-separated options.
>   			  If any option is provided multiple times the
> -			  last occurance wins.
> +			  last occurrence wins.

That's the correct spelling. Looks OK.

>   +
>   The boolean options accept an optional value `[=<BOOL>]`. The values
>   `true`, `false`, `on`, `off` etc. are all accepted. See the "boolean"
> 
> base-commit: a0f521b56c724f4e21eef1cec2d456b1dbd72c10
> 

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
