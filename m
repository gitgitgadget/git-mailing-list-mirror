Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F0DC433E9
	for <git@archiver.kernel.org>; Thu, 31 Dec 2020 11:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB96C223E8
	for <git@archiver.kernel.org>; Thu, 31 Dec 2020 11:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgLaLcf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 06:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgLaLcf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 06:32:35 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D9BC061575
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 03:31:54 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id 11so17786137oty.9
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 03:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=x+WO/gbexjcrhzdSKdhv2zrgnzbtJzFi1c7iH1FQ2pI=;
        b=jzQwIGTVXjBx8oGUq5bMM8TLQ5XJkxf+Uc6tpQpT/eRHwg5BTWvTJ7v/8kwQZWuh6o
         33u8oN0//Tm8QfQzuA03CU5kw/O51fgfdiNOF1DXQzFGALtWnc3V035kKEEn0PNbsryz
         vyEBl2DWlG+vMjZ4q6wOK3jKCKFIjYMkYA/lAmf2v0VZAlUGXbjALa/T/8g7eZ7tdBfJ
         kRsjFbosoInSc4aDHQay1DxW1uL4xQhDsMCmZTR5gGeD2ZMx1OUjQNVJlVckLrIRcj2H
         m/mxruYeaXLJr+4/y42JpXgAmt57+IJgDUTFU+Bz7xau25O7FFNHokoRggqJCwV65+TX
         Egjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x+WO/gbexjcrhzdSKdhv2zrgnzbtJzFi1c7iH1FQ2pI=;
        b=olRabQbaQYre8ZEJKzexgZuwgljl7jJ+50+tL2kX0FybaJimmhWOdRLXr6XGSP5jcO
         ugO7nHWDZZsALxhZ8ZfVh7AG6Fbr96SiLC4w6YWi05J23vVQIsY2OVqnnhM0XSTxeB+N
         ce1717GLxz2UVTXieCQ1piczIi7O4T8u83C4zUcI6WxsbE1pjusHAteXx2hDd/U8PfTF
         4Skn381kdaOXj98KWmDWSCoklqePdUMkmDuDvG0XppmDquBpHN3gBpygzm2R18e2NbEW
         6fjsWG6ViwFe1auYfVz8upV+Zfgrc8i4+KmE8Iv/+sfedEAy6LgGmgmyhD86a43q0eK1
         VUFQ==
X-Gm-Message-State: AOAM530eTOvI8V+IY/Vlf2U1U+b1be18gtm67M8TJWH8nsqq7uYFYa25
        7/16BLJE/z2VrJ/0wFb52QPXyO+iuS8=
X-Google-Smtp-Source: ABdhPJxrMo46Pg39XMbCqFEEdsrufKo905n+w9JqgIkhPrdzMDW99uc9wBts4pGjPh7tshUb05yYLQ==
X-Received: by 2002:a9d:a78:: with SMTP id 111mr41082176otg.94.1609414313623;
        Thu, 31 Dec 2020 03:31:53 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id l21sm11898408otd.0.2020.12.31.03.31.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Dec 2020 03:31:53 -0800 (PST)
Subject: Re: test-tool: bloom: generate_filter for multiple string?
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        git@vger.kernel.org
References: <20201231035438.22533-1-congdanhqx@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <dfe3fbf9-4708-cd53-d78e-780375224b8e@gmail.com>
Date:   Thu, 31 Dec 2020 06:31:52 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <20201231035438.22533-1-congdanhqx@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/30/2020 10:54 PM, Đoàn Trần Công Danh wrote:
> 
> Hello,
> 
> I'm reading the code for Bloom Filter to see if arXiv:2012.00472
> could be an improvement.
> 
> I'm not sure if I'm missing something or it's our test-bloom generate_filter
> doesn't really support testing for multiple inputs.

It doesn't support creating a _realistic_ filter of the given size. The tests
at this level are more about keeping the filters consistent so we can trust
that we are not accidentally changing the hashing algorithm and its file format.

The test works if we provide multiple inputs, the problem is that the resulting
filter has a higher density of bits than we expect, since we didn't size it
according to the number of inputs.

> If I understand correctly, we should either:
> * allocate more entry for inputs; or
> * abort if argc != 3

Either approach would be fine. I wonder what your goal is for testing the
multiple inputs. Are you expecting a larger filter to demonstrate some
behavior that is not tested by a small filter?

> diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
> index 46e97b04eb..1026facc59 100644
> --- a/t/helper/test-bloom.c
> +++ b/t/helper/test-bloom.c
> @@ -68,12 +68,14 @@ int cmd__bloom(int argc, const char **argv)
>  	if (!strcmp(argv[1], "generate_filter")) {
>  		struct bloom_filter filter;
>  		int i = 2;
> -		filter.len =  (settings.bits_per_entry + BITS_PER_WORD - 1) / BITS_PER_WORD;
> -		filter.data = xcalloc(filter.len, sizeof(unsigned char));
>  
>  		if (argc - 1 < i)
>  			usage(bloom_usage);
>  
> +		filter.len = (settings.bits_per_entry * (argc - 2) + BITS_PER_WORD - 1)
> +			/ BITS_PER_WORD;
> +		filter.data = xcalloc(filter.len, sizeof(unsigned char));
> +

Whitespace issues aside, this is the right approach to make the filter grow with
the input.

>  		while (argv[i]) {
>  			add_string_to_filter(argv[i], &filter);
>  			i++;
> diff --git a/t/t0095-bloom.sh b/t/t0095-bloom.sh
> index 7e4ab1795f..6d83927c86 100755
> --- a/t/t0095-bloom.sh
> +++ b/t/t0095-bloom.sh
> @@ -67,6 +67,17 @@ test_expect_success 'compute bloom key for test string 2' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'compute bloom key for multiple string' '
> +	cat >expect <<-\EOF &&
> +	Hashes:0xb270de9b|0x1bb6f26e|0x84fd0641|0xee431a14|0x57892de7|0xc0cf41ba|0x2a15558d|
> +	Hashes:0x20ab385b|0xf5237fe2|0xc99bc769|0x9e140ef0|0x728c5677|0x47049dfe|0x1b7ce585|

Multiple hash outputs work already, helping us build confidence that our
hash algorithm hasn't changed.

> +	Filter_Length:3
> +	Filter_Data:45|ba|ac|

And this is the part of the output that you are changing.

> +	EOF
> +	test-tool bloom generate_filter "Hello world!" file.txt >actual &&
> +	test_cmp expect actual
> +'
> +

So, your suggested change has merit. I just wonder what value it provides on top
of the current implementation? If your goal is to create a way to inspect a full-sized
filter, then that would be interesting to explore.

Thanks,
-Stolee

