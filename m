Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7868FC4708F
	for <git@archiver.kernel.org>; Mon, 31 May 2021 06:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48BC7611CA
	for <git@archiver.kernel.org>; Mon, 31 May 2021 06:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhEaGnX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 02:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbhEaGnU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 02:43:20 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F260EC061574
        for <git@vger.kernel.org>; Sun, 30 May 2021 23:41:19 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 22-20020a17090a0c16b0290164a5354ad0so763001pjs.2
        for <git@vger.kernel.org>; Sun, 30 May 2021 23:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Np98XOVLKTd56/cp6hqSrPg+UjNINh3eMYNIfT1C4fI=;
        b=tmxKv9kP7aUUZMcVGKll+cnZ9J4nhscrKKUf4eg+P/FEmv6Y9tjH6Z2z2SPL+gZ+HP
         XcH0A/xrDucQUf7X2ihvnHMykXEuOHjWC3Npp72kPCHeVzHUH64HXKCnPVmUxxmKjzCG
         gqwptmEV+GUDEUlRXaUi9t8rwN3hHWOA6TCKgLKiNmRY5+5YT0um2xUwMhdKrrVVt0qg
         +a7wiP6nKUIu1cGz6WyN1XtL3qRNnLu5LWUw7QESTco70O9Yig4p9k/e9PRXNM9cgoPb
         60y9nc4o42ZBesRoh6TsMIMMh7FlXI8HqSOo9lSIV9dmBCRgU6fU6ROyDxZd+pMssxAL
         IJQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Np98XOVLKTd56/cp6hqSrPg+UjNINh3eMYNIfT1C4fI=;
        b=M94Q+0ZZDLkYic8/rb29QY9OhZU82vhSgjkmymWHitdCclB+O7psNk2kBEl++JpZxn
         nBmLviFAOgzcwtRWNTViLWuPB6QxkCBXSL/TDaY6Wz5s18g0tMYoU3Sr5aWCYEQN3ym3
         ez/sa+1fSH61j0V9akYuKTVCFNSl5G+1+Pn22lMz16IcHSqSEOg2ebIcOCy47/OiY13q
         t1IANRxUyiy/PyTAhKSZYUgUVI+RkPsdsnmhKzXCe982AwLHsFr7bcxMdnXS+TDJy9vP
         RwObb0s4P83KpmCWbHOS9b31gGUCnIPXBRDuoavtAqyL9Xqj7dOKunQ4frUP9hREunYP
         bFgg==
X-Gm-Message-State: AOAM532CxFDCTmRgAdvXJNHvypCju3AvMfBryHPX36KAYpYGLVQV0OLx
        oMtUMztbi/eYnE/OBAHd6OU=
X-Google-Smtp-Source: ABdhPJwyQyq3v0e6qhTbk9+Uge+P4M9aOFOK+5SvnO4t+0CKmLG6uTo2ugDorPj0+4XUwUZPwPz7Yw==
X-Received: by 2002:a17:902:9046:b029:106:646a:2d10 with SMTP id w6-20020a1709029046b0290106646a2d10mr256662plz.55.1622443279343;
        Sun, 30 May 2021 23:41:19 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-52.three.co.id. [116.206.12.52])
        by smtp.gmail.com with ESMTPSA id g19sm2788927pjl.24.2021.05.30.23.41.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 May 2021 23:41:19 -0700 (PDT)
Subject: Re: [PATCH] describe-doc:fix a obscure error description in the git
 log documentation
To:     Andy AO via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Derrick Stolee <stolee@gmail.com>, Andy AO <zen96285@gmail.com>
References: <pull.1030.git.git.1622440856607.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <b5acad71-af41-ece2-6128-bca243f8f299@gmail.com>
Date:   Mon, 31 May 2021 13:41:15 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <pull.1030.git.git.1622440856607.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Andy, welcome to Git mailing list!

On 31/05/21 13.00, Andy AO via GitGitGadget wrote:
> From: zen96285 <zen96285@gmail.com>
> 
> The git log documentation says "The default option is 'short'." This is wrong. After testing, the default value of '--decorate' is 'auto', not 'short'.
> 
> There is no difference between 'auto' and 'short' in terminal, but there is a significant difference in how they behave in the shell.The information generated by the 'short' can be saved in shell variables, while the 'auto' can't.
> 

Why are info generated with 'short' option (and not 'auto') can be 
assigned to a variable?

> diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
> index 1bbf865a1b2d..37a4694b060a 100644
> --- a/Documentation/git-log.txt
> +++ b/Documentation/git-log.txt
> @@ -39,7 +39,7 @@ OPTIONS
>   	full ref name (including prefix) will be printed. If 'auto' is
>   	specified, then if the output is going to a terminal, the ref names
>   	are shown as if 'short' were given, otherwise no ref names are
> -	shown. The default option is 'short'.
> +	shown. The default option is 'auto'.
>   

Looks OK to me, thanks.

-- 
An old man doll... just what I always wanted! - Clara
