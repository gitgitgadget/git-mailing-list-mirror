Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31370C4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 10:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiLOKSf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 05:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLOKSd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 05:18:33 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447B813F
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 02:18:32 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id bx10so2579579wrb.0
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 02:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o2rxruX8lhDF189aWDTlHDepELjNk3CwrA/Hk+jLBYk=;
        b=dttIFhMi5LfC2XDXaYZRMlpKgBWJXnXQMZL6HH2HpSUKoqeQiROM0F0yG+Sn+ZhmdL
         QY/Uszv9vXL41aOmusgV3N/qapo2wHC087XvV2yTwg1vLO+oVLDqkJQPAH7Wv1O1kWF3
         sEC1ZL3uKKGU3JzY4AwQFLuvqFcZ2O742L3WBIgXm1lPDUCKwDEVy9O86mLzI11qYphu
         1yNvOPZHA6lTO2kc+LPaRdh4pvCwQYIUiklwtrFbI7F7gTggxvRW32wzFvz2s5FemQE5
         7ahQQn5gn2mh/Rlvj3FtmtCx2bIouv+eX6fCqaweXBE2XmdAyL8OEFDsTtSHcTXSSt3V
         xtxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o2rxruX8lhDF189aWDTlHDepELjNk3CwrA/Hk+jLBYk=;
        b=yt8naFCinj0TqvmcYNUPxdtQN7FDcKnajr90ZjyzTX3rP5r5ell5dZ+y0Hb2xl7qRg
         rSPofORh3ljgNPPHNGEidte5MBERUbPyWWnTK1ATzU6KsPCfZEmcvAkXfKUuEJuZMwYq
         GoR6aUGeO5s3YQVnTYIlntHsim10MzXhFHrebtxdJ1yyKx77iIT29JGyW8Ue0nmwH+rX
         GTaBYWtlQJfErlDgsY6fz8PbsNR4B1VR+6ORufppVBK0jOwZ+mYLdtEVO7sjCpVLGqEh
         iO5aB5sDfgZpPWtLeouIFV2lxyRxSlY0E2fOzWk6Y6xW52X2PgU6H303z3fO1vxV4oeH
         q1IQ==
X-Gm-Message-State: ANoB5pkqTC2ohSgVAQu2MUdsZEFOrS3m/AuXXWXoWaHgk8U7k81CKjF6
        T8aHCTwbNwIHRxGM0fUA0PWOaSfgmyg=
X-Google-Smtp-Source: AA0mqf5nYFsO2maSb7SyRbtXTHths6eZ8aQ8ipctT5T6zgVbstAak37Bfv80fdaNpSM810FeVhdayg==
X-Received: by 2002:a5d:6186:0:b0:242:1238:91d2 with SMTP id j6-20020a5d6186000000b00242123891d2mr17641184wru.17.1671099510674;
        Thu, 15 Dec 2022 02:18:30 -0800 (PST)
Received: from [192.168.1.14] (host-92-2-151-214.as13285.net. [92.2.151.214])
        by smtp.gmail.com with ESMTPSA id m11-20020a7bce0b000000b003d070e45574sm5629507wmc.11.2022.12.15.02.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 02:18:30 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <5352a684-8d47-ea1d-ee87-92e4722d47ce@dunelm.org.uk>
Date:   Thu, 15 Dec 2022 10:18:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] git: remove unneeded casts
To:     Rose via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija Kijin <doremylover123@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <pull.1396.git.git.1671032126602.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.1396.git.git.1671032126602.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/12/2022 15:35, Rose via GitGitGadget wrote:
> From: Seija Kijin <doremylover123@gmail.com>
> 
> Many of these casts remain,
> even though the target variable is the type it is being casted to.
> We can safely remove said casts.

Like Peff I curious how you found these. I also agree that it would be 
helpful to understand the history so we can be sure there the cast is 
not a sympton of a bug - Peff has given you a great start on that. A lot 
of the changes look like useful cleanups but there are a couple that 
caught my eye as being wrong or undesirable which I've commented on below.

> diff --git a/strbuf.c b/strbuf.c
> index 0890b1405c5..940f59473eb 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -493,7 +493,7 @@ void strbuf_add_percentencode(struct strbuf *dst, const char *src, int flags)
>   		if (ch <= 0x1F || ch >= 0x7F ||
>   		    (ch == '/' && (flags & STRBUF_ENCODE_SLASH)) ||
>   		    strchr(URL_UNSAFE_CHARS, ch))
> -			strbuf_addf(dst, "%%%02X", (unsigned char)ch);
> +			strbuf_addf(dst, "%%%02X", ch);

This one is wrong, the cast is required if char is signed as in that 
case it will be converted to a signed integer (because printf() takes a 
variable number of arguments) and then %X treats that integer as 
unsigned. That means that if the high bit is set we'll now print a bunch 
of leading F's. To see this compile and run

#include <stdio.h>

int main(void)
{
         printf("%02X %02X\n", (signed char)0x80, (unsigned char)0x80);
         return 0;
}

which prints

FFFFFF80 80

> diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
> index c84549f6c50..04fa4e5a01d 100644
> --- a/xdiff/xprepare.c
> +++ b/xdiff/xprepare.c
> @@ -188,7 +188,7 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
>   			if (!(crec = xdl_cha_alloc(&xdf->rcha)))
>   				goto abort;
>   			crec->ptr = prev;
> -			crec->size = (long) (cur - prev);
> +			crec->size = (cur - prev);

I'm not sure if we want to remove this cast. cur and prev are pointers 
so (cur - prev) has type ptrdiff_t which maybe wider than long. We can 
debate whether we should be using a cast to hide any compiler warning 
here but the cast is not redundant in the same way as others in this patch.

>   			crec->ha = hav;
>   			recs[nrec++] = crec;
>   			if (xdl_classify_record(pass, cf, rhash, hbits, crec) < 0)
> diff --git a/xdiff/xutils.c b/xdiff/xutils.c
> index 9e36f24875d..853f2260a1d 100644
> --- a/xdiff/xutils.c
> +++ b/xdiff/xutils.c
> @@ -130,7 +130,7 @@ long xdl_guess_lines(mmfile_t *mf, long sample) {
>   			else
>   				cur++;
>   		}
> -		tsize += (long) (cur - data);
> +		tsize += (cur - data);

This is in the same class as the one above. (Also if we do end up 
removing the cast we should remove the parentheses as well)

Best Wishes

Phillip
