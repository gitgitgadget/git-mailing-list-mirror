Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF3C81F463
	for <e@80x24.org>; Fri, 20 Sep 2019 15:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393313AbfITPLF (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 11:11:05 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36951 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387614AbfITPLF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 11:11:05 -0400
Received: by mail-qk1-f194.google.com with SMTP id u184so7667121qkd.4
        for <git@vger.kernel.org>; Fri, 20 Sep 2019 08:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xt/kotmdGf6l7tabH5deP6uGPVKP9a3wctCLPtR1xM8=;
        b=ehkrK4u8lluYfY9FwQTs3dnHHzXs5EV0PLvhWTtABnNcH3nQwWD81LaTXjMLqVc+BI
         uVhlQT/CFDT9s6YKGteQiRldEHsxB/7/A5tiPDvqAxMJJOzfew6nRjAW65KBx358YXtM
         yC7bx1/usoFc0xmL8Fs5EprlWjKUnklFikfGJcPFCYjnwc2hvraB8Gz9+HtgK9bOcjTP
         sPD1K/KertDCugyXsYv95NLKdS3BM8SPZhVtIwuJDgiOroa3kCvjmAIC4scnKfRjyYCn
         PYRdGs02sbMkzPawlEzHDsZZ+1ZY9L7wox05fVmKap8BN2NqCQz8obxFaKuNnvzapkWg
         3eZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xt/kotmdGf6l7tabH5deP6uGPVKP9a3wctCLPtR1xM8=;
        b=C60WgR6HtmpW/4FbjIWwxj3OTAZTBHTqqPbvpeiDPzWAQ+jj4vVCF5lKE4ThcPh6XX
         ODw9UZMDYRievIM7PK0cVS4lo/KQQEmwmNl4Bn6hhgNwSObg6FpRm7OCkOezi4vI6EsD
         3PNcc94raEY5q7UIAN1TJZg33CNWXqmeSEzZrK52L/wxEyXuy/iK8NA+l1UCeJgH1XZ6
         OJSujxqMciJwnAm15bZLm9JEyfYhwcCkm8pBYI5FIH3L3Se+1Jzd04kKQDc+nDYiQI1j
         CEBZb4GEsR5IBtoDCUCJ2dkAGgCP8yjcuc3AEukgetdOtz4lapB8VbTUJDyYKAdhdE7a
         6+bw==
X-Gm-Message-State: APjAAAW87LGpTqaC9Sue9DmZX9CsMjy7QsYlDgbtw/ZJKKJfmhUSKTMM
        Oh8PJm3zNhoI6kMJb62pB9I9Fb56b3s=
X-Google-Smtp-Source: APXvYqwYYdifpVHofAmU9FcQ0NQLMzAntgOmjvnCW+3EMCtIXobGpsJE6mybvY9N393/mFKzBF6gZg==
X-Received: by 2002:a05:620a:1252:: with SMTP id a18mr4336219qkl.88.1568992264243;
        Fri, 20 Sep 2019 08:11:04 -0700 (PDT)
Received: from ?IPv6:2001:4898:4070:37:142:491c:a46c:6a48? ([2001:4898:a800:1010:89d8:491c:a46c:6a48])
        by smtp.gmail.com with ESMTPSA id q8sm1180087qtj.76.2019.09.20.08.11.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2019 08:11:03 -0700 (PDT)
Subject: Re: [PATCH 05/15] name-rev: use sizeof(*ptr) instead of sizeof(type)
 in allocation
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20190919214712.7348-1-szeder.dev@gmail.com>
 <20190919214712.7348-6-szeder.dev@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <cb35b779-79b1-e27d-e539-9ea9d2601b07@gmail.com>
Date:   Fri, 20 Sep 2019 11:11:02 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <20190919214712.7348-6-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/19/2019 5:47 PM, SZEDER Gábor wrote:
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
>  builtin/name-rev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> index e406ff8e17..dec2228cc7 100644
> --- a/builtin/name-rev.c
> +++ b/builtin/name-rev.c
> @@ -98,7 +98,7 @@ static void name_rev(struct commit *commit,
>  	}
>  
>  	if (name == NULL) {
> -		name = xmalloc(sizeof(rev_name));
> +		name = xmalloc(sizeof(*name));

Is this our preferred way to use xmalloc()? If so, then
I've been doing it wrong and will correct myself in the
future.

-Stolee
