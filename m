Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10384C4332F
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 12:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiJMMQM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 08:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiJMMQK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 08:16:10 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7D452FED
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 05:16:09 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id h185so1383001pgc.10
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 05:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2xpQrFDMA0FYMGNSTJA+ELn8ma+n4DQ06R4dtUuKTmI=;
        b=JFNBpFDW5WDxnN7jz955D0uhvqu04pi/oa0RlU3fTDq1uAXWOIN4wwOM+xMYT5ugq2
         GDyV4VMYaNocfT4qs1YCZ9Xk3OOMpcHW3DRJnL1Pr780c3Sj+NvQcMBchmPNmte4/RaS
         A0j2o1eXQulTA6hFI8vvd3NYQamufNE49H0yA86UQdf+dkD0YvD6CHyqR0SGl3E5HE0A
         67+MfpYxGHzvhmWJm5uFuNXAfnYwKg7ryYSEvKS6IJpGfXhbFWUOqM4J0Osd2WKJTY6u
         s8Uu5yDb/gAl+n5qmkxnNHQChUoSrpse29UMnJL66xRuVKuR/fDP/Umd34sqvJsrOyBu
         UZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2xpQrFDMA0FYMGNSTJA+ELn8ma+n4DQ06R4dtUuKTmI=;
        b=zJ2bBb9LxxCstkrMQqSkm43IeVYF8W2pdLMDiHuMu9lL25rknjfwe/18IQh2ZiJ73D
         IbhI7X0jRb52rzj9QImYaRdYwIVdPvDLG3FF2vnr/WL4PypmXu6CQtSoch9aODgSIsZ4
         GKOocyQRKVpP7HOjy51GMb4LlVZcN1/A9ki604xVDaOR4Op5WTdwhGEHBhuHDTCmnu1P
         l/nEHnHwbFGJ8Q2sHlEHVUT4A94sbdEfD8+DidoyARBnAFpf3KPwcyrojP9wMB6e5hnx
         HHyvfqU06MJIuBjgvex6ltVz4AZ59D1nuYNUTbmTVmS0rfBe06WHE9oKcERAircamw97
         yd4g==
X-Gm-Message-State: ACrzQf2RrGgPKpaCdgpWwbjwgUEiolPe29ufycCe3J7j2Zx8FXnCV8yV
        IwAPf0yEB2hdF9/mHA7DOeFIlQPBvwmz3w==
X-Google-Smtp-Source: AMsMyM6auRu9iCgjjQLr5b3+CCzD5RECYGyy6OuHIo8EiW26ZaGy/QpTm9emGgWund5hGdtqZ+JSjA==
X-Received: by 2002:a63:2a86:0:b0:46a:eaba:f1f3 with SMTP id q128-20020a632a86000000b0046aeabaf1f3mr5291263pgq.79.1665663368358;
        Thu, 13 Oct 2022 05:16:08 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-7.three.co.id. [180.214.232.7])
        by smtp.gmail.com with ESMTPSA id oa10-20020a17090b1bca00b0020d747a6ebcsm3180857pjb.50.2022.10.13.05.16.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 05:16:08 -0700 (PDT)
Message-ID: <1ebea198-fa2a-3f79-e698-64fa4799bcde@gmail.com>
Date:   Thu, 13 Oct 2022 19:16:05 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: Git diff misattributes the first word of a line to the previous
 line
Content-Language: en-US
To:     Gurjeet Singh <gurjeet@singh.im>, git@vger.kernel.org
References: <CABwTF4U-KXHF7=8RWY7Ecbspz205Msa3syZFiWYDg3XmZsNGVw@mail.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <CABwTF4U-KXHF7=8RWY7Ecbspz205Msa3syZFiWYDg3XmZsNGVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/13/22 12:51, Gurjeet Singh wrote:
> # **** Expected **** output
> $ git diff --word-diff=plain /tmp/1.txt /tmp/2.txt
> diff --git a/tmp/1.txt b/tmp/2.txt
> index 8239f93..099fb80 100644
> --- a/tmp/1.txt
> +++ b/tmp/2.txt
> @@ -1,2 +1,2 @@
>     x = yz {+opt1+}
>     [-ab-]{+ac+} = [-cd ef-]{+pq opt2+}
> 

What Git version (and on what system) you made the expected diff above?

-- 
An old man doll... just what I always wanted! - Clara

