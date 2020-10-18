Return-Path: <SRS0=h2Q9=DZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B09AC433DF
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 15:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B87B221D7F
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 15:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRcGVYJT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgJRPj7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Oct 2020 11:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbgJRPj7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Oct 2020 11:39:59 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BC2C061755
        for <git@vger.kernel.org>; Sun, 18 Oct 2020 08:39:58 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x7so8678450wrl.3
        for <git@vger.kernel.org>; Sun, 18 Oct 2020 08:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5WzR2iY5mSx5vUq/wAWETys6lcabgcPN9+s0ELrzc8A=;
        b=KRcGVYJTSoHTaG2KFXej+QhI5WKU9SPaXguyOVBiQe1RipOPmu9MleHHR4xdSmZVr6
         vNifIMEbHiOTExBD8q3nGlMW4xrpt9S/7xWutUpQ9mLBt+UQ7vq3h62mgSNCFHzqAGoe
         bGgHJvc1ab9q0reYJG18GZLj8T6OybSTJC2HUMC2ESrlzkx29C+LwWjnZ4krOIWtUz66
         9ULz6Lauyrx7ONB94pGfTQKwA2UFE2ERJGT5s0vLPyxHAGNwYHECeG3fyFf3t9HYDtjS
         hmqBzEsaK7voqLJd5AzDLKtEmpzCN0VvrSS/dHTEsreoxGnIwt10Pb4Af9d9jQf6kv/9
         oppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=5WzR2iY5mSx5vUq/wAWETys6lcabgcPN9+s0ELrzc8A=;
        b=iJ4cqL9DyuIuTnA1HMcEYsQN+ZMU1PWZEbdR5E2xMFN/RrSbL+gCJhBHxbqklVQu7E
         x6mwHvIWichEo0QuYotV4MwvB6b3NdDl/aoMSqPvzVx0v6N9ESfHVhSMhivLo7gXYT9b
         lxcIJ/kJEb/tHKIrI1y/xw2J6j3SLehvb63d8yDJN+6m5s3iW05ZNMI3NCfiEgCw8cA/
         RL+ca7RWLIbU6p3EU9XdhhCs+tuZCxiAMGJRG+wMz8yKUf+zGFS9fF4cWcOp/XW71Ii4
         jYeXFzZSl6Nfm1Gus6HYuFEVfFemOdgCGuVkjTR1Fah7vWx0bV++/XkxNZ36NpB0avD6
         QmiQ==
X-Gm-Message-State: AOAM532pv/Kz40MXtrjj2dUFH23/4oqQznaIgMDt+GuPMdRZlxFdPc6p
        tBRCaOX1E/yarfeXQ37pD1o=
X-Google-Smtp-Source: ABdhPJxn+1mGbbpEaHirSqK8+KdqYnNLegOB0T+Vrh3M+prCIdM9FHndIUWNg91cgrX4t19It6w/ng==
X-Received: by 2002:adf:f3cb:: with SMTP id g11mr16267392wrp.210.1603035597544;
        Sun, 18 Oct 2020 08:39:57 -0700 (PDT)
Received: from [192.168.1.240] (13.45.90.146.dyn.plus.net. [146.90.45.13])
        by smtp.gmail.com with ESMTPSA id y14sm12057875wma.48.2020.10.18.08.39.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2020 08:39:56 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 4/5][Outreachy] t7201: avoid using cd outside of
 subshells
To:     Charvi Mendiratta <charvi077@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        sunshine@sunshineco.com
References: <20201015175709.20121-1-charvi077@gmail.com>
 <20201017075455.9660-1-charvi077@gmail.com>
 <20201017075455.9660-5-charvi077@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <cf26c039-0870-ced6-5347-ab3f24343105@gmail.com>
Date:   Sun, 18 Oct 2020 16:39:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201017075455.9660-5-charvi077@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Charvi

Congratulations on posting your first patch series.

On 17/10/2020 08:54, Charvi Mendiratta wrote:
> Avoid using `cd` outside of subshells since, if the test fails, there is no guarantee that the current working directory is the expected one, which may cause subsequent tests to run in the wrong directory.

That is an accurate description of why we want to avoid using `cd` 
outside of subshells. However this conversion is converting `cd` inside 
a subshell to use `git -C`. I think that is worthwhile as it avoids 
having to use a subshell but the description should say explain that the 
conversion is desirable to avoid the cost of starting a subshell as the 
original test does not suffer from the problem described in your commit 
message.

Best Wishes

Phillip

> 
> Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
> ---
>   t/t7201-co.sh | 10 ++--------
>   1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/t/t7201-co.sh b/t/t7201-co.sh
> index 74553f991b..5898182fd2 100755
> --- a/t/t7201-co.sh
> +++ b/t/t7201-co.sh
> @@ -339,10 +339,7 @@ test_expect_success 'switch branches while in subdirectory' '
>   	git checkout master &&
>   
>   	mkdir subs &&
> -	(
> -		cd subs &&
> -		git checkout side
> -	) &&
> +	git -C subs checkout side &&
>   	! test -f subs/one &&
>   	rm -fr subs
>   '
> @@ -357,10 +354,7 @@ test_expect_success 'checkout specific path while in subdirectory' '
>   
>   	git checkout master &&
>   	mkdir -p subs &&
> -	(
> -		cd subs &&
> -		git checkout side -- bero
> -	) &&
> +	git -C subs checkout side -- bero &&
>   	test -f subs/bero
>   '
>   
> 
