Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86040C47096
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 03:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5847F61404
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 03:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbhFDDdx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 23:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbhFDDdx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 23:33:53 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96E9C06174A
        for <git@vger.kernel.org>; Thu,  3 Jun 2021 20:32:07 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id f22so6523484pfn.0
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 20:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=cjxX1dIkVq/nkKwOTdZYdGSNoOGabAi4yHeGR8E/Zhc=;
        b=Qib7kFGlh80CO/+ID3r8ycp6s8kqEjdh1s9nWcu9WBWb8Xf5tplqabPHuAP9Ug6VyE
         toHjiydnXK2ZHf39M8ROylSizeGhGZYhuuqoYv0K6knnKw6LU7VED7AZ8Zq3M9oo9cA/
         sA6oNurT+76UlRNNsoWjaoGJNTOwgKl+5TCCgBkBV5aNMgtcp1D+ju3F5F71AFaMpQha
         LqT8nKN9exv9lIUBkIZHnhVKonRXC0QLXz0TY5VJgsQA2zUW8YKhTEnS81GydBN05uHl
         xpwErqnHQBODsYS5YMPApHROG18GwZfWdNNnMrBwI6iDCODwdUtummzeBP6g3oABPIV+
         9qbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cjxX1dIkVq/nkKwOTdZYdGSNoOGabAi4yHeGR8E/Zhc=;
        b=geWyWbahCveiIjllXAspD9BwoBPIfnndliyAGURRIc5MoDnDm4a9x/HokbHZiYvPHz
         CvuOFMxC/c9Fb4ZWoqAL51BvDgrzS0oNhB7HxD8WgAGstaXGKrPEBx5aEPPBfMOnMLZ3
         qASbjS79CzWQPw5K501EH0iyC4SEwKaPNWnAemuB7eYtmIkIbWHdVeLC3kCH1i5PUFNG
         bX7DwD5VDLYXrCRPJO369JWk9aVV8Ss/QpNEVrdsCUqrYuyreIeaXlOJX8fTpyYD6Vbs
         cja3XZmprc0D7UKlGFu05eZr5PlSZ/Tzk5Ltu6sowKy2xKzp1oA3gNa1qeCFoot+m18R
         9HDg==
X-Gm-Message-State: AOAM532x0W84fwgdVJ2valeuGpToao0nf9IQdOBzXcwTKvJWhure2eid
        SNYzY+U/JSnluPYFTr24H81qSdoQJtWxzw==
X-Google-Smtp-Source: ABdhPJzR0N1ga9y1iS6tAfzy7qK7Pb3KFE+7wfr55h8snywvho0fr1Epnf2ee78Ma1/LWG4BhJ6FmQ==
X-Received: by 2002:aa7:83ca:0:b029:2e5:3a96:982a with SMTP id j10-20020aa783ca0000b02902e53a96982amr2310135pfn.12.1622777527166;
        Thu, 03 Jun 2021 20:32:07 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-69.three.co.id. [180.214.232.69])
        by smtp.gmail.com with ESMTPSA id w63sm424902pfw.153.2021.06.03.20.32.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 20:32:06 -0700 (PDT)
Subject: Re: [PATCH] t: use user-specific utf-8 locale for testing
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        git@vger.kernel.org
References: <20210602114646.17463-1-congdanhqx@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <f8cbd947-3176-34bc-a0f0-dd816298e2c7@gmail.com>
Date:   Fri, 4 Jun 2021 10:32:04 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210602114646.17463-1-congdanhqx@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Đoàn,

On 02/06/21 18.46, Đoàn Trần Công Danh wrote:
> In some test-cases, utf-8 locale is required. To find such locale,
> we're using the first available UTF-8 locale that returned by
> "locale -a".
> 

On most systems, the first available such locale is C.UTF-8, so why 
don't we just use it?

> Despite being required by POSIX, locale(1) is unavailable in some
> systems, e.g. Linux with musl libc.  Some of those systems support
> utf-8 locale out of the box.
> 
> However, without "locale -a", we can't guess provided UTF-8 locale.
> 
> Let's give users of those systems an option to have better test
> coverage.
> 

So can we assume to UTF-8 locale as default for testing on systems 
without locale(1)?

> Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
> ---
>   Makefile                                 |  6 ++++++
>   t/lib-git-svn.sh                         | 15 +++++++++------
>   t/t9100-git-svn-basic.sh                 | 14 +++-----------
>   t/t9115-git-svn-dcommit-funky-renames.sh |  6 +++---
>   t/t9129-git-svn-i18n-commitencoding.sh   |  4 ++--
>   5 files changed, 23 insertions(+), 22 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index c3565fc0f8..4b2c24e5ea 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -398,6 +398,9 @@ all::
>   # with a different indexfile format version.  If it isn't set the index
>   # file format used is index-v[23].
>   #
> +# Define GIT_TEST_UTF8_LOCALE to prefered utf-8 locale for testing.
> +# If it isn't set, use the first utf-8 locale returned by "locale -a".
> +#

Better say "... to prefer utf-8 locale for testing".

-- 
An old man doll... just what I always wanted! - Clara
