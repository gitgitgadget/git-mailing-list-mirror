Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0179C433F5
	for <git@archiver.kernel.org>; Sat, 14 May 2022 14:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbiENOht (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 May 2022 10:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbiENOhr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 May 2022 10:37:47 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8A723BD5;
        Sat, 14 May 2022 07:37:44 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k30so2132537wrd.5;
        Sat, 14 May 2022 07:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=kB472YUphLLi8oSDhXb53KpHnVK+dSZakSBf1hP1KJc=;
        b=XMu1S+GJRonV31R18J5Cv1gN4/n94wFN1b3xL5tE80rayCjWFhPvvxWt9vJQeOmIXo
         OgvOkNviRbKKKgnOtGJRpK4qay2jApMeE/cd2SbeWZcEUxOCvVWnqnrQdkJFeedOsmSw
         qYfuusZUGsi57nzuLPOs8VUYqgWcX9rIhEobJ1A9HoGeEWXTy/Q67yMctDuXieBxEybk
         raZBuTsWYFzzJihSaL3Ey0FwTOl3k18k3h95W5ByAGIR19GySsRT3yRrWenBrUNKfpvl
         1ho/1HaDXBgH5113TRbeKfrGtsytbtG+JvPEbsVEIkwiRhPWCdH5INdRKU0M5EdtPpH2
         Vecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=kB472YUphLLi8oSDhXb53KpHnVK+dSZakSBf1hP1KJc=;
        b=ClSpG0vZXSioYWO/l7JD274jVdragFOKW4qAkPNPWSdiI9iedkEYt0kqs21l+687Co
         LnsBILkNZaWks+xZiO2gW3Yi2+iaoC0H6gvhBiCq0y2imNraUkvzYMPRkRwxOJz9JJrm
         9hJcefj4kV0gz0nOsIRWV2kiAS1YSzxRM82vJ7ycHgnFrZYqsJfwSg3E0qSLdI+ErIpJ
         cgBd6fSQHyBMps0niOi9Dtzy1Y/s/xiCrcNcYKf3w8D9Pcr2TCxOnkOjNuonGA1L9Ff9
         kdsB3+s6cT0g6vVvoyHgIhiL122r/gmwprhPu8eASaQyIKlEQfxIm7cFIeKhu5530xwc
         4pPg==
X-Gm-Message-State: AOAM533A4zeGR9MxnDO37l8kers0DyXu5nadCvYlWrCB1nHcWr8XX4bm
        2ryzNEdof1s/7k5PDK5lb5Q=
X-Google-Smtp-Source: ABdhPJwDOSS7ZV1hIbp2ubf4ITN4EvZcELgqZaPXLOHSVjSGE8Wsoi7dL4Kz7T1lk/t4ohJl3z1u6g==
X-Received: by 2002:adf:e646:0:b0:20a:c4fa:4991 with SMTP id b6-20020adfe646000000b0020ac4fa4991mr7629863wrn.413.1652539063288;
        Sat, 14 May 2022 07:37:43 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id s16-20020adfa290000000b0020c5253d91asm4874015wra.102.2022.05.14.07.37.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 May 2022 07:37:42 -0700 (PDT)
Message-ID: <0fc70bd3-5883-47e4-1814-6ed6c756a400@gmail.com>
Date:   Sat, 14 May 2022 16:37:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] getpriority: Only getpriority translation the priority
 values
Content-Language: en-US
To:     Theodore Dubois <tbodt@google.com>
References: <20220510220821.1481801-1-tbodt@google.com>
Cc:     linux-man@vger.kernel.org, mtk.manpages@gmail.com,
        git@vger.kernel.org
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <20220510220821.1481801-1-tbodt@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Theodore,

On 5/11/22 00:08, Theodore Dubois wrote:
> The translation is needed to avoid returning a negative number from a
> successful syscall, and this requirement doesn't apply to setpriority.
> See the implementation of getpriority in kernel/sys.c.
> 
> Signed-off-by: Theodore Dubois <tbodt@google.com>

Patch applied.

BTW, I had to manually edit the patch.
It's the second time I see this (I can't find the other one), your patch 
didn't apply for the following reason: the a/ and b/ prefixes in the 
file paths are missing.  Did you use git-format-patch(1) to produce the 
patch?  Can you reproduce this?

I CCd the git mailing list in case they know what's going on.

Thanks,

Alex

> ---
>   man2/getpriority.2 | 17 ++++-------------
>   1 file changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git man2/getpriority.2 man2/getpriority.2

Should have been:
diff --git a/man2/getpriority.2 b/man2/getpriority.2

> index 3e1be3e6c..24c1b7f11 100644
> --- man2/getpriority.2
> +++ man2/getpriority.2

Should have been:

--- a/man2/getpriority.2
+++ b/man2/getpriority.2


> @@ -206,20 +206,11 @@ All BSD-like systems (SunOS 4.1.3, Ultrix 4.2,
>   manner as Linux 2.6.12 and later.
>   .\"
>   .SS C library/kernel differences
> -Within the kernel, nice values are actually represented
> -using the range 40..1
> -(since negative numbers are error codes) and these are the values
> -employed by the
> -.BR setpriority ()
> -and
> -.BR getpriority ()
> -system calls.
> -The glibc wrapper functions for these system calls handle the
> -translations between the user-land and kernel representations
> -of the nice value according to the formula
> +The getpriority system call returns nice values translated to the range 40..1,
> +since a negative return value would be interpreted as an error.
> +The glibc wrapper function for getpriority translates the value back according to the formula
>   .IR "unice\ =\ 20\ \-\ knice" .
> -(Thus, the kernel's 40..1 range corresponds to the
> -range \-20..19 as seen by user space.)
> +(Thus, the 40..1 range returned by the kernel corresponds to the range \-20..19 as seen by user space.)
>   .SH BUGS
>   According to POSIX, the nice value is a per-process setting.
>   However, under the current Linux/NPTL implementation of POSIX threads,

-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
