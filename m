Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4D7C636CC
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 02:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjBACVK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Jan 2023 21:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjBACVJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2023 21:21:09 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74852E045
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 18:21:07 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id lu11so9916619ejb.3
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 18:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3rzuNT752cHT1Els3XBb956WmNIXKb13s+rzqixOgr4=;
        b=DAoG0+k9IpwhQPaxZ/kMoARksF2hwup6EOJ4oh+znITxZ5fIyLvWM95mDCqftNTXQ8
         XKSkg6NmXfdAKyTp3AREd0xRSiyLey/6ADMtYKKUtSMKQ5voHypjDVOwDNuPTElEmrxB
         dY7M26nWUEwo0q+mleR3R19zueCJi1I9Ew+ahXrop98XPNo8dAPlG6BCtRwT43N8q+aZ
         WFh1eh0Sj7V1pDP+sdIsB44GsZuo42MC3REIiECvMMsH1OlK4FP1DlZhWH7kx4aK5/+0
         P/3Zg/0ls2O+U3irUexBUbVL8BBNVYwGmNSEUi6d9FBFrv0oOOju8tQlw/5HIznMV39v
         9Caw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3rzuNT752cHT1Els3XBb956WmNIXKb13s+rzqixOgr4=;
        b=p/8iCUSWYQFhe9XC53QYgf7UZcALxCbtH3Y4Yw6/7QB6WrvChkSMnqB1BMjfpSF6qH
         fAOC1Vs+cSTOA7EnWfXHDzl5aLnLXjxrlnppWGlad/HJdYlcBiRdQOGaVmFLDhR+DPqW
         vIrw6WmTJJR/65gC1amUvyWav1FMZ3kq2ceR2Q2q/KDZKWRkmKGQWMsOBUZLYtAvdZ/Z
         Vl7vcdO4d9I7aAp+xaVMcChoRjU2iY9D0X9RkFpHezqu89TEAqYCLzafPOUcdNO4zCaB
         Zc5VNgRJlmLsoidD2dMnDm+Fja+/sisGcMHO95i382B7qynjTMKJGHda9LXQWD3yMVaD
         feLw==
X-Gm-Message-State: AO0yUKW1A7ll9TUWJtbGakaU4wezW1bHyUb3c6+i/cgaefbMmyLtTsyJ
        U76QzOpJV+8xbEqKSeGW2yCJvo6ZZ5Hs7uo1
X-Google-Smtp-Source: AK7set/edZwjg7fwr5GSZLkfMANdxb+6vrWvxqKp5ILuAR2BC6umUVMOMVaVsE0OzrfX3G1mbi+NEw==
X-Received: by 2002:a17:907:9916:b0:887:915d:7502 with SMTP id ka22-20020a170907991600b00887915d7502mr659483ejc.31.1675218065953;
        Tue, 31 Jan 2023 18:21:05 -0800 (PST)
Received: from [10.43.18.179] ([216.24.213.49])
        by smtp.gmail.com with ESMTPSA id e16-20020a170906081000b0088cf92eb0e2sm1200602ejd.178.2023.01.31.18.21.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 18:21:05 -0800 (PST)
Message-ID: <b9a38b83-cdfe-0389-3097-c20a699f183c@gmail.com>
Date:   Wed, 1 Feb 2023 03:21:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [GSoC][PATCH] t/t4113-apply-ending.sh: Modernize a test script
To:     Shuqi Liang <cheskaqiqi@gmail.com>, git@vger.kernel.org
References: <20230131224929.2018546-1-cheskaqiqi@gmail.com>
Content-Language: en-US
In-Reply-To: <20230131224929.2018546-1-cheskaqiqi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Shuqi Liang,

> Subject: [GSoC][PATCH] t/t4113-apply-ending.sh: Modernize a test script

For patches that change a single test, the subject line can include just
the "t" and the number.  The part after the colon should start with a
lowercase letter.  Something like

     t4113: modernize test style

On 31/01/2023 23:49, Shuqi Liang wrote:
> 
> I cleaned up some old style in test script.

Commit message should start with description of the existing problem
in present tense, something like:

     Test scripts in file t4113-apply-ending.sh are written in old style,
     where the test_expect_success command and test title are written on
     separate lines ...

Then changes should be described using imperative mood, as if you are
giving commands to the codebase.  See section "[[describe-changes]]"
in "Documentation/SubmittingPatches" for details.

You can also find examples of existing commit messages for similar
changes:

     $ git log --no-merges --grep='modernize' -- t

> 
> for example :
> 
> * old style:
> 
>      test_expect_success \
>          'title' \
>          'body line 1 &&
>          body line 2'
> 
>    should become:
> 
>      test_expect_success 'title' '
>          body line 1 &&
>          body line 2
>      '
> 
> 
> 
> 
> Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
> ---
 > Hi,I'm Shuqi Liang.a junior student majors in Computer Science at
 > University of Western Ontario.

Welcome!

>   t/t4113-apply-ending.sh | 16 +++++++++-------
>   1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/t/t4113-apply-ending.sh b/t/t4113-apply-ending.sh
> index 66fa51591e..aa57895b22 100755
> --- a/t/t4113-apply-ending.sh
> +++ b/t/t4113-apply-ending.sh
> @@ -24,13 +24,14 @@ echo 'a' >file
>   echo 'b' >>file
>   echo 'c' >>file

A "modern" test could also do such preparation for test files as
part of its "setup" step.  This could its own patch in the same
series, separate from style changes.

In case of t4113, files "test-patch" and "file" are created twice.
The second creation of the files could be either its own step
'setup for apply at the beginning', or incorporated into the step
'apply at the beginning'.

Section "Recommended style" in t/README also has some notes about
how heredocs should be indented.

>   
> -test_expect_success setup \
> -    'git update-index --add file'
> -
> +test_expect_success setup '
> +    git update-index --add file
> +'

While changing the quoting around test tiles and commands, the
indentation with spaces could also be changed to TABs.

>   # test

If the setup code on top level of the file is moved into test
steps, this comment and the "# setup" comment at line 11 will
become unnecessary.

>   
> -test_expect_success 'apply at the end' \
> -    'test_must_fail git apply --index test-patch'
> +test_expect_success 'apply at the end' '
> +    test_must_fail git apply --index test-patch
> +'
>   
>   cat >test-patch <<\EOF
>   diff a/file b/file
> @@ -47,7 +48,8 @@ b
>   c'
>   git update-index file
>   
> -test_expect_success 'apply at the beginning' \
> -	'test_must_fail git apply --index test-patch'
> +test_expect_success 'apply at the beginning' '
> +    test_must_fail git apply --index test-patch
> +'
>   
>   test_done

Thanks.

