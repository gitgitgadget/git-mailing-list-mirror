Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7CDC433EF
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 19:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 940BB60F4B
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 19:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237150AbhIVTIo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 15:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236431AbhIVTIn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 15:08:43 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AEBC061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 12:07:13 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id e16so3671941qte.13
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 12:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QS2c3GeXW6QRb6mmVScQngRvcHBEj3FMXLSq3Bg4uUo=;
        b=P3CszYSpavlwC5I5wU0Dg0epLWnUhMYMmuzMK+J5sdlzn9O2ckO5EfvTMYs8rY1F12
         h0famz4Jr99tpFjf/rgRLjU0GQ9rOi5jJX2GpP35aoBYOagE7W+fIGqf6KiYix3BKmWP
         NOX/uDSXAtpyRVRegNkLDOjEzcn6YluHsERq5n6ddrynR63c1Sbi34pEYyM+IKGddLlE
         IcS9EJ1PqCH8mG79R/YumweJAFXvXx0zfJBI1s48i47qs+00emPPNSETYAh1sUxb1vnX
         vT342EXwWuK6I0LNqteb97K2r8+h/Ywu17YSxkwrrBeO3Ua+MzEg9y5DPLnJ+DeLuVzz
         rRsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QS2c3GeXW6QRb6mmVScQngRvcHBEj3FMXLSq3Bg4uUo=;
        b=XVISC9KFZuXYaesR1pFXxrm4tNX2JOimntT7VHpgZLaeuHWQI+IqXf7rYWW3ZK2Qlz
         zmv9RaH0r4Ea+sMaArPzSQpUAD9b/DsHZ5+YBTZ3ltULwjFBTLL3DZG12eFHaURIRHNE
         IlJ+2USdG3Nxr4MFL5tYGXfXrPB8eo3oxE9LGRrA4rDEuhh9l4rJwuBCsUEB0bVufwe9
         CirsvRfOpiIA7Wiy/yI7C+2cLa8WUmj/fFTsKPTPayjCa67RXV9lVq2yS8CAUL28/4t9
         eG2OZI3uaYPA2ckFvRLUAz6ezZaOc89TBUcI2c5G5W91gpHaKdmScwbKE7oqg7oOdN/i
         C2jQ==
X-Gm-Message-State: AOAM5306JU337uw2ZMY7sSpyZHSOHihq3aDbPsMewXBuMuwK3FjiO+2G
        jZ2UHkQACQlEmVQ4RhIz1fBSCYbb/YN8UQ==
X-Google-Smtp-Source: ABdhPJyA8gRGUK01tdQhNiRaTw0cDOnsOOm26fXBLfCMvMqiCHGYZg1t+Ik82DsHblYPwPFAWIttpQ==
X-Received: by 2002:a05:622a:295:: with SMTP id z21mr903322qtw.125.1632337632295;
        Wed, 22 Sep 2021 12:07:12 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id h15sm1205501qtq.41.2021.09.22.12.07.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 12:07:11 -0700 (PDT)
Subject: Re: [PATCH v2] Makefile: avoid breaking compilation database
 generation with DEVELOPER
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        git@vger.kernel.org
Cc:     avarab@gmail.com, Eric Sunshine <sunshine@sunshineco.com>
References: <20210922183311.3766-1-carenas@gmail.com>
 <20210922185702.4328-1-carenas@gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <0e6f9744-e5b2-6afc-cc67-60cc838b07b1@gmail.com>
Date:   Wed, 22 Sep 2021 15:07:10 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210922185702.4328-1-carenas@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Carlo,

Le 2021-09-22 à 14:57, Carlo Marcelo Arenas Belón a écrit :
> 3821c38068 (Makefile: add support for generating JSON compilation
> database, 2020-09-03), adds a feature to be used with clang to generate
> a compilation database by copying most of what was done before with the
> header dependency, but by doing so includes on its availability check
> the CFLAGS which became specially problematic once DEVELOPER=1 implied
> -pedantic as pointed out by Ævar[1].
> 
> Remove the unnecessary flags in the availability test, so it will work
> regardless of which other warnings are enabled or if the compiler has
> been told to error on them.
> 
> [1] https://lore.kernel.org/git/patch-1.1-6b2e9af5e67-20210922T103749Z-avarab@gmail.com/
> 
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>   Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 9df565f27b..d5c6d0ea3b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1302,7 +1302,7 @@ GENERATE_COMPILATION_DATABASE = no
>   endif
>   
>   ifeq ($(GENERATE_COMPILATION_DATABASE),yes)
> -compdb_check = $(shell $(CC) $(ALL_CFLAGS) \
> +compdb_check = $(shell $(CC) \
>   	-c -MJ /dev/null \
>   	-x c /dev/null -o /dev/null 2>&1; \
>   	echo $$?)

Thanks for cleaning that up.

Acked-by: Philippe Blain <levraiphilippeblain@gmail.com>

Philippe.
