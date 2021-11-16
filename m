Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE3CC433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 22:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22B8263222
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 22:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbhKPWQB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 17:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbhKPWQA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 17:16:00 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6558EC061570
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 14:13:03 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id n66so1668187oia.9
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 14:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=p/HdqS5kDuJMFXdNImf7h/iqKkUm/UzJZ6dBcWIsy5M=;
        b=Ndk2tFRXgz5JMlYDKXjhpxhy2XRrm521I9yPLvlBi0v5lIjxTfcZXdM55/ES2WSfOB
         l1frxDpV96sbtHzJDjGbvtz7MPszj9tnIYXUnttn7bqZxSpsSKubnYGulr34RR1BOlYU
         8sNbatjlOWVwgUvqPfdf8821EOajMSfkwzB/ETjTWwjIIUezxeYD/yQn6xRNEFG5ouIZ
         CJ7+wPVwr4UG+/fUc+Si/9ZccMSYvlTdFGtrBwKoXs3JnNd2Rxic4SFAJ3K0KYPJ3pw3
         t0KMNVJ6fiC1pcvmA4XDQnkeTe1WWdIVWIK5Xt5Top/f3Hqm+9zMGN0xBuV7vZ2WYD6M
         9kNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=p/HdqS5kDuJMFXdNImf7h/iqKkUm/UzJZ6dBcWIsy5M=;
        b=VgQzTXNO/iw/KJeXRm2kTlhP+hc7Mi7rRRkw433Gqx69Xx9+E2HHAlL3tbnncG5OsW
         JL/JbO6cD0TMHDFiA5iShfSVVcGYt9C5sDwbsawBgnrQC4VufbtmyRr0jZf+mmqBs19H
         00N1hfCT5Sdnlx1t1IEjDgdT5A9/1YIHTh3IdbO+i60OFH5qDUR4ETHYwiic2Py/MVfb
         2aECI1BsdwNv8Zo1cgIXclziowvESqOQTqLsz6M3+OTt3WNBX20x98kjqyT8PxSBRZGG
         RwIT6K/w1/0I8JQt9vsOG3G1ENswgRtxMdNxxNpy7Q9DERTDnzblOGpvrVUN1BPFLyvQ
         3mbw==
X-Gm-Message-State: AOAM531jiXxyFvOzhYUkEU0X8NWI/izHTbyGWgmWOu/uO2EGroobp+vo
        ZN3Oj2YjR8kueipzzi+8hHY=
X-Google-Smtp-Source: ABdhPJzuipRGNKEKlAnssvAPLv9GEkWDc1QlJ+NufNektC0WLZ4+aBntCHSyMvfg6DU9bX4RJ6Zv9g==
X-Received: by 2002:a05:6808:1185:: with SMTP id j5mr56084669oil.16.1637100782537;
        Tue, 16 Nov 2021 14:13:02 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:1061:bd63:e16a:f842? ([2600:1700:e72:80a0:1061:bd63:e16a:f842])
        by smtp.gmail.com with ESMTPSA id n22sm3298866oop.29.2021.11.16.14.13.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 14:13:01 -0800 (PST)
Message-ID: <cb995591-d837-ac3d-9935-5eab1c98b4d7@gmail.com>
Date:   Tue, 16 Nov 2021 17:12:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] t5319: corrupt more bytes of the midx checksum
Content-Language: en-US
To:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, dstolee@microsoft.com
References: <cover.1624473543.git.me@ttaylorr.com>
 <94e9de44e3b52513c5ab48aecd74f809dc34cbe3.1624473543.git.me@ttaylorr.com>
 <20211110231132.GB5811@szeder.dev> <YYzq0uBr+uoVvkbC@coredump.intra.peff.net>
 <YZQeMjjtxS2LU2Tk@nand.local> <YZQk6t1veegeAlYh@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <YZQk6t1veegeAlYh@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/16/2021 4:38 PM, Jeff King wrote:
> So very occasionally we can end up with a real 0xff byte, and the test
> fails. The most robust fix would be to read out the final byte and then
> change it to something else (e.g., adding 1 mod 256). But that's awkward
> to do in shell. Let's just blindly corrupt 10 bytes instead of 1, which
> reduces our chances of an accidental noop to 1 in 2^80.
> 
> Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t5319-multi-pack-index.sh | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
> index 3f69e43178..a612e44547 100755
> --- a/t/t5319-multi-pack-index.sh
> +++ b/t/t5319-multi-pack-index.sh
> @@ -482,8 +482,10 @@ test_expect_success 'corrupt MIDX is not reused' '
>  '
>  
>  test_expect_success 'verify incorrect checksum' '
> -	pos=$(($(wc -c <$objdir/pack/multi-pack-index) - 1)) &&
> -	corrupt_midx_and_verify $pos "\377" $objdir "incorrect checksum"
> +	pos=$(($(wc -c <$objdir/pack/multi-pack-index) - 10)) &&
> +	corrupt_midx_and_verify $pos \
> +		"\377\377\377\377\377\377\377\377\377\377" \
> +		$objdir "incorrect checksum"
>  '

Thanks for taking the time to make this a patch. This approach looks
good to me.

Thanks,
-Stolee
