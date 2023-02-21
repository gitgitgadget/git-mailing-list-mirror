Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25E3C636D7
	for <git@archiver.kernel.org>; Tue, 21 Feb 2023 17:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235025AbjBURW0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 12:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234940AbjBURWY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 12:22:24 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FD129424
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 09:22:14 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id q11so6140945plx.5
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 09:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AysYUY4YeH2/Ok61ntqZAZPyDgzYbcn4Pfa+ZuMHFTc=;
        b=CU5TDgIhZ4EJMXhhlb9Bu5/idSL8F90XriaMQ/x9MOXYQb3KUe6nL7tAiJrQeViprs
         K3PFx1Y8PDsVqtOaGAkdK9xC6D17fvpFY33GIehHpJJsgiX2nNosSOBaqujthT5pmflJ
         94u70zExXL6fz4YruAUmU7YMprp1yRXZ61TZTAQlP9OKBUDRvkplhLlo2uPHaBmKKJX+
         gRiZ+kOSnGtQfmj2tf0i2OgCrkjWVRq3ge3I8dlq5lkP1pRxwF0rWppSLnEwtMR/yORV
         PhWNiou/5qu89R7QeBuCUDvRJGBIoCzvvfQVZCkPdzmF8dr5fgLVO+X3NqB1NrhsEBxT
         r1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AysYUY4YeH2/Ok61ntqZAZPyDgzYbcn4Pfa+ZuMHFTc=;
        b=iI6DVi8lsLp/q7r6aVqtCWiY6cuLClsgw0LuUDziTFpoc/6wWvW0AJ191F3F//nT24
         AUu3O/+dKxU5QmeuKhMD0z+MkVJzgOT3cnMt51lafhgcgdGVT35HVALw4fkYrtjC+/y0
         C5KpgWhcRqBXahWV7L2syUqyTmsErWjVXjfpGVQUjm3M+YIOGftbuow7Ol7yUSQa6bMi
         7aFjrN5ft5CAgrQ/Wpmn1AF0rjN9SZ6LTXc9muWje8vxHd1u7uT7tWGM2BO5ah08rcoS
         BaktRFGf2ae4MBnKaMpXEM0ud4/5zKfc3ob/s9qlBP1rmj3Iwd48P2m69Y6oTSFcAyUP
         +3tQ==
X-Gm-Message-State: AO0yUKWLKQBh9RnwgDgVcE7qm7i/4l25Lm4aC3XaNYs5nM/d33ltvAom
        QHtzKaNJxzRoaG+XE0d8LP0a
X-Google-Smtp-Source: AK7set/2aW1F5/Mic5JnpoiLHpdMDdjbkQf9jiTelnhER+IZT1dc+4OPB2/fimfrRvRFC6dB40QthQ==
X-Received: by 2002:a05:6a20:12c3:b0:bf:8003:cc6b with SMTP id v3-20020a056a2012c300b000bf8003cc6bmr5938936pzg.42.1677000134082;
        Tue, 21 Feb 2023 09:22:14 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id v10-20020a62a50a000000b005d3399efd80sm212154pfm.136.2023.02.21.09.22.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 09:22:13 -0800 (PST)
Message-ID: <38cb184d-e47a-2129-a93e-16ffd2afe67a@github.com>
Date:   Tue, 21 Feb 2023 09:22:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [GSOC][PATCH] t4121: modernize test style
Content-Language: en-US
To:     Vivan Garg <gvivan6@gmail.com>, git@vger.kernel.org
Cc:     christian.couder@gmail.com, hariom18599@gmail.com
References: <20230220235121.34375-1-gvivan6@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20230220235121.34375-1-gvivan6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vivan Garg wrote:
> Test scripts in file t4121-apply-diffs.sh are written in old style,
> where the test_expect_success command and test title are written on
> separate lines

nit: period at the end of the sentence (s/lines/lines.)

Also, this commit message explains *why* you're making the change, but not
what the commit actually does (that is, update the tests to adhere to the
new style). Would you mind adding a note about that to the message?

> 
> Signed-off-by: Vivan Garg <gvivan6@gmail.com>
> ---
> Greetings, my name is Vivan Garg. I am currently pursuing a double major
> in computer science and finance at the University of Waterloo in Canada. 
> I am currently completing my third software developer internship at Morgan
> Stanley. As part of my coursework, I studied C and shell scripting, which 
> I then applied in internships and personal projects. C++ is the programming 
> language that I am most comfortable with right now. Please feel free to 
> address me as Vivan, and my pronouns are he/him/his. I meet the requirements 
> for GSOC participation. So far, I've either read or skimmed the following 
> documents based on prior knowledge: Submitting patches, Coding guidelines, 
> Myfirstcontribution.txt, gittutorial, Giteveryday, readme, Hacking-Git, 
> General-Microproject-Information, SoC-2023-Ideas, and 
> General-Application-Information. I'm looking forward to having a fantastic 
> time here! 

Welcome to the Git community, and thanks for your contribution! :) 

> 
>  t/t4121-apply-diffs.sh | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/t/t4121-apply-diffs.sh b/t/t4121-apply-diffs.sh
> index a80cec9d11..2ff38ededa 100755
> --- a/t/t4121-apply-diffs.sh
> +++ b/t/t4121-apply-diffs.sh
> @@ -16,8 +16,8 @@ echo '1
>  7
>  8' >file
>  
> -test_expect_success 'setup' \
> -	'git add file &&
> +test_expect_success 'setup' '
> +	git add file &&
>  	git commit -q -m 1 &&
>  	git checkout -b test &&
>  	mv file file.tmp &&
> @@ -27,10 +27,11 @@ test_expect_success 'setup' \
>  	git commit -a -q -m 2 &&
>  	echo 9 >>file &&
>  	git commit -a -q -m 3 &&
> -	git checkout main'
> +	git checkout main
> +'

This test looks good.

>  
> -test_expect_success \
> -	'check if contextually independent diffs for the same file apply' \
> -	'( git diff test~2 test~1 && git diff test~1 test~0 )| git apply'
> +test_expect_success 'check if contextually independent diffs for the same file apply' '
> +	( git diff test~2 test~1 && git diff test~1 test~0 )| git apply
> +'

As for this one, the test is correctly updated to the new style (per the
microproject prompt). However, the spacing around the '|' is a little weird
- I think there should be a space after ')'. On your next re-roll, could you
fix that spacing (in this patch is fine - it's not a substantial enough
change to warrant its own commit)?

>  
>  test_done

