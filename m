Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65804C432BE
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 09:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48A7360FD7
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 09:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235595AbhHQJDy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 05:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235009AbhHQJDv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 05:03:51 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7119C061764
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 02:03:17 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id w6so17139680plg.9
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 02:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=i+pmpC4rEhlaAylfvweq+PSg1a3Syze/vuJIEkXLMQk=;
        b=NtKzGfnU4RAN1bXGa+wvzy1Bc+bwiuT+MPxtXS8PSo6X15x15EfGL41ntSck7ABK84
         to5KDrrN/gd4iSyj9GxTkcYyRYc5efdPU0dTKyO4+H7/5KeZ3tGc1/N3H4oFO+J02DI5
         0SCFlgflD7TmyO9Daax38KPkmSb/8Wt/RdoecIHSQqXCTowPNHLIh1XODS+hDJK1EfCG
         ioKG0TzExRmqDpjkef3dZhz6VWq6xKAMkntbk779ITza4ErjWg6GOJeVoYJGwF0z5bCB
         4zrBqXONQqM9yvyjpl2ZgzlORJdkGPGGTYG93Tgl9CxHttAiZqNca1WxfO6PmI+mC7BY
         tz0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i+pmpC4rEhlaAylfvweq+PSg1a3Syze/vuJIEkXLMQk=;
        b=FJQD86P+ESkzYY8cx5/V5LJ4zuLaiWxsc2VFvtBaMbx0B3gTdkRF7HyJPi/F+36m2O
         G0LKpeVutHhlTtbsVaW536wc6+gz3a0URfBDEjCCnmLrnBreaQ7n0kykyTxjRYFPhoP5
         Vd3KfYC4XVeTcxpUGstH49274+RuBAtYj8ANM/EK5sn07M79vgGwKABfoSjrNX9qFLuh
         bIJ74ZPnaVr0Pq2tHM2Qb6GVXW81NOAsx5vdOlhNecdlSDYyA4z23IOlRhlvQZWlS74B
         yfrxmChSzwcM6V6WScFx6LvBjBkVRHlTCyxClQSawbzNZoXlBryWsQ0KwH/8hBog+iLm
         WxHg==
X-Gm-Message-State: AOAM531ZieLtoI42QHozgXv7TmMebYqSAF4A5eaDs+lgR17IRmUly0Nr
        OV4eYQst6TAl0IFiXB0eKwhIuHB3uro=
X-Google-Smtp-Source: ABdhPJxb+O8CT9U8/TmfOgec210x03aCY7I45O+xfgmYbW+Sfxb0vOES8NbcK7xyRSL30l0vj94sig==
X-Received: by 2002:a05:6a00:10cf:b0:3e2:139b:6d6c with SMTP id d15-20020a056a0010cf00b003e2139b6d6cmr2708633pfu.3.1629190997298;
        Tue, 17 Aug 2021 02:03:17 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-1.three.co.id. [180.214.233.1])
        by smtp.gmail.com with ESMTPSA id n22sm1816772pff.57.2021.08.17.02.03.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 02:03:17 -0700 (PDT)
Subject: Re: [PATCH v4 2/6] t6030-bisect-porcelain: add test for bisect
 visualize
To:     Miriam Rubio <mirucam@gmail.com>, git@vger.kernel.org
References: <20210817081458.53136-1-mirucam@gmail.com>
 <20210817081458.53136-3-mirucam@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <cca9771b-035e-0aca-bcf2-115f7af364e4@gmail.com>
Date:   Tue, 17 Aug 2021 16:03:14 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210817081458.53136-3-mirucam@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/08/21 15.14, Miriam Rubio wrote:
> Add a test to control breakages in bisect visualize command.
> 
> Signed-off-by: Miriam Rubio <mirucam@gmail.com>
> ---
>   t/t6030-bisect-porcelain.sh | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
> index f41453cc97..99b7517400 100755
> --- a/t/t6030-bisect-porcelain.sh
> +++ b/t/t6030-bisect-porcelain.sh
> @@ -976,4 +976,11 @@ test_expect_success 'bisect run fails with exit code smaller than 0' '
>   	test_must_fail git bisect run ./test_script.sh > my_bisect_log.txt
>   '
>   
> +test_expect_success 'bisect visualize with a filename with dash and space' '
> +	echo "My test line" >> -hello\ 2 &&
> +	git add -- -hello\ 2 &&
> +	git commit --quiet -m "Add test line" -- -hello\ 2 &&
> +	git bisect visualize -p -- -hello\ 2 > my_bisect_log.txt
> +'
> +
>   test_done
> 

Seems like you're testing with filename with dash and space. Does git 
bisect visualize have any problems handling such filenames?

-- 
An old man doll... just what I always wanted! - Clara
