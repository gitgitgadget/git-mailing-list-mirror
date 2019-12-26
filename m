Return-Path: <SRS0=68ZU=2Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19562C2D0DA
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 14:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB13A20740
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 14:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4ou1XzS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfLZO3C (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Dec 2019 09:29:02 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42860 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfLZO3C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Dec 2019 09:29:02 -0500
Received: by mail-qk1-f195.google.com with SMTP id z14so18279735qkg.9
        for <git@vger.kernel.org>; Thu, 26 Dec 2019 06:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h0hM4pCtggKQ3lRaTWT68lenkorDuHtwuPbHu1EM9x0=;
        b=L4ou1XzSz+7R4GIL2vhGi1Xv7apy94fp119aalnkuhcADPcY7FiynOEYkhxDYejpp+
         asz3kCOhdbcGp7p+K47EVvk1q0n6Xx1fTX3XDNkZbwy8UCm2kN1M1pCZNX+ea2BDDyG4
         j/F0nz+/QxS1ZYSJL5xVxajvIf9zzNmdkSmiXqZidJcN8PP3X1EoMDTZwwZyyWDWeNkv
         PuRiTM0pj3oO12DFCRemFr/FTDvDZI2/SJOEBWpOI0TeGfslQ8yl0q2fcElzQxNrDDZO
         WgikyqZT21DQLXyFt1ax4moHE7bu4ElIkbcyg45zUq23hEwpDvTSsKpy9071gTFbSmkt
         VEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h0hM4pCtggKQ3lRaTWT68lenkorDuHtwuPbHu1EM9x0=;
        b=UPyBjhTHUCUerqj4ZssyejQuYhXHfAxR0kRaOnAq7Aa+IIiydFd21ELTl4UL4/3FXO
         iQ1UyUyNHK4K7ZY+qqP8o7ii6xubVjQ5M0UEb8vuf2hb122JzV9BvzvXZKRUauWbbPMy
         VYDVSbaseOfbcG5FQxdziOIEBk+9To2el+iJMPaKaGens/Ph1lT0yQALUbzmfuVhvfRp
         C4tFU+xMkLX/IACcR+1eJQ8zyLj4s+3Boj1uJt1ir1gkNUV8Fu6zz0SubzQEGet4a4Sh
         FXVUhFWlNjDOckYWjMeyK7Foi7+h+yKDjjCxxW9gg6kmxlE3lsuD3U0g2i3+YdPFvEvz
         4h2g==
X-Gm-Message-State: APjAAAXwahcTq5syIJShHuOE1M5kA9VfxjQGT3K7+OEzpQW+k6zWsg1I
        jg1PKcQwgpEf1hc+pupu/Gg=
X-Google-Smtp-Source: APXvYqzQ7PeO7jHUCX6GtV56MTKkuCA7imr+jHxptPKWBWnWWTCq6tikj2LBBrK2YD1kpwvNR+xkbg==
X-Received: by 2002:a37:a014:: with SMTP id j20mr39225429qke.456.1577370541643;
        Thu, 26 Dec 2019 06:29:01 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:d596:b1c5:69e0:b2e5? ([2001:4898:a800:1012:86ca:b1c5:69e0:b2e5])
        by smtp.gmail.com with ESMTPSA id r6sm9394546qtm.63.2019.12.26.06.29.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Dec 2019 06:29:00 -0800 (PST)
Subject: Re: [PATCH 1/5] fetch test: use more robust test for filtered objects
To:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20191224005816.GC38316@google.com>
 <20191224005907.GD38316@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a50a4ed5-5135-597a-fd37-9a907030b59f@gmail.com>
Date:   Thu, 26 Dec 2019 09:29:00 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <20191224005907.GD38316@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/23/2019 7:59 PM, Jonathan Nieder wrote:
>  	# Ensure that object is not inadvertently fetched
> -	test_must_fail git -C client cat-file -e $(git hash-object server/one.t)
> +	commit=$(git -C server rev-parse HEAD) &&
> +	blob=$(git hash-object server/one.t) &&
> +	git -C client rev-list --objects --missing=allow-any "$commit" >oids &&
> +	! grep "$blob" oids
>  '
>  
>  test_expect_success 'filtering by size has no effect if support for it is not advertised' '
> @@ -929,7 +932,10 @@ test_expect_success 'filtering by size has no effect if support for it is not ad
>  	git -C client fetch-pack --filter=blob:limit=0 ../server HEAD 2> err &&
>  
>  	# Ensure that object is fetched
> -	git -C client cat-file -e $(git hash-object server/one.t) &&
> +	commit=$(git -C server rev-parse HEAD) &&
> +	blob=$(git hash-object server/one.t) &&
> +	git -C client rev-list --objects --missing=allow-any "$commit" >oids &&
> +	grep "$blob" oids &&
>  
>  	test_i18ngrep "filtering not recognized by server" err
>  '
> @@ -951,9 +957,11 @@ fetch_filter_blob_limit_zero () {
>  	git -C client fetch --filter=blob:limit=0 origin HEAD:somewhere &&
>  
>  	# Ensure that commit is fetched, but blob is not
> -	test_config -C client extensions.partialclone "arbitrary string" &&
> -	git -C client cat-file -e $(git -C "$SERVER" rev-parse two) &&
> -	test_must_fail git -C client cat-file -e $(git hash-object "$SERVER/two.t")
> +	commit=$(git -C "$SERVER" rev-parse two) &&
> +	blob=$(git hash-object server/two.t) &&
> +	git -C client rev-list --objects --missing=allow-any "$commit" >oids &&
> +	grep "$commit" oids &&
> +	! grep "$blob" oids

At first glance, I saw this and thought the "three is many" rule would imply
the boilerplate in these tests should be de-duplicated with a function.
However, the use of the "commit" and "blob" variables is different in each
test, so I did not find a convenient way to make this simpler.

Thanks,
-Stolee

