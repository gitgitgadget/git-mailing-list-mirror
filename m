Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B336FC61DA3
	for <git@archiver.kernel.org>; Tue, 21 Feb 2023 22:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjBUWFy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 17:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjBUWFx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 17:05:53 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFA532529
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 14:05:51 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id z10so3512190ple.6
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 14:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SkLVoYj1B+5VEONnExqeMCLmvWnC8uUTUMIeDFw+SNE=;
        b=iHXK5tiB8bWhUKWiGSNabR1tiM1aZiCI+VOhfCDLJoS5w50pL5gpimI2MXLJZqyQIP
         aVVZ31CQupdLLBMiNUQ0WpdKcw2p+DPPfWFeeSG9QnCjO/DxUZKx/AT6qM8ITImDuIj8
         tmjQxkDrRwszdttyUWA6hwa9wimJwOrpZGsAmXau263+I9oKyc549BznO/C3l6ygx1NW
         ERUuNTCEZrwfJXz9x6qNNld67zXfEYSGevHLeal50Qk0TdOMknX4UVWhWPwYqkkJkUi3
         oEPkdzUjBr7jPgoaQ10eg86BIin78GO9MMtM44KKEP4IbHXylC8M0d3ttw4B7Uiakuww
         nH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SkLVoYj1B+5VEONnExqeMCLmvWnC8uUTUMIeDFw+SNE=;
        b=a7AMK3oE7BmuORSylPbVypzwvfVZF2Nxkj3bdvBXWeBgKE+fqvytFkpD9kDHKaWL1S
         HbvNGjcK/wR9CjfSNM9Z/TIC9vcdNQIHkVfdg0wrLwIWAKL5HTYEUrsVc1+UfvxkU3fx
         wIMvZdK//0XdXXRvO9lieFRiXjeg9RA9hmsAaQkmMdCuALk4RQ9GcEl+PVL9dasiCnjO
         MOqJeznEE1PlVBid0sNue3oMzz20Eqb4rXAKcuBSvWjxU4n3OIIQbkeCxFGtP6K1IjOA
         8AWxMK4JA27qIObIUai060QMbBUecUEHetqpBcFW9zAavonBw5CZoufqjoQfRD3DJaOq
         3AxA==
X-Gm-Message-State: AO0yUKWxIweSJufmzlu6v3/W7gLC3/yO7B780ZGe8VQK5xrcGiKuA5ue
        g4wiPZfsFwpHSPguc+/3yixgLeiy2pnWYfw=
X-Google-Smtp-Source: AK7set+/czkFJZ8JC/ZxFcqA02m+/a7Noy6kpge44PJ2rb8YPnW5rftEjOtmSwzoJ6+9BrgTcGOf9A==
X-Received: by 2002:a17:90a:1951:b0:230:7b4a:45dd with SMTP id 17-20020a17090a195100b002307b4a45ddmr5691874pjh.20.1677017151336;
        Tue, 21 Feb 2023 14:05:51 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id q63-20020a17090a17c500b0023317104415sm3464063pja.17.2023.02.21.14.05.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 14:05:50 -0800 (PST)
Message-ID: <77734da5-e711-f653-b022-ba3b26823701@github.com>
Date:   Tue, 21 Feb 2023 14:05:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [GSOC][PATCH v2 1/1] t4121: modernize test style
Content-Language: en-US
To:     Vivan Garg <gvivan6@gmail.com>, git@vger.kernel.org
Cc:     christian.couder@gmail.com, hariom18599@gmail.com
References: <20230220235121.34375-1-gvivan6@gmail.com>
 <20230221214653.85830-1-gvivan6@gmail.com>
 <20230221214653.85830-2-gvivan6@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20230221214653.85830-2-gvivan6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vivan Garg wrote:
> Test scripts in file t4121-apply-diffs.sh are written in old style,
> where the test_expect_success command and test title are written on
> separate lines, therefore update the tests to adhere to the new
> style.

The new commit message is sufficiently descriptive, thanks for updating. In
terms of readability, it is a bit of a run-on sentence (the comma after
"lines" could be a period, i.e. "...separate lines. Therefore, update
the..."). I don't think it needs to be updated, but it's something to keep
in mind for future contributions. :) 

> 
> Signed-off-by: Vivan Garg <gvivan6@gmail.com>
> ---
>  t/t4121-apply-diffs.sh | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/t/t4121-apply-diffs.sh b/t/t4121-apply-diffs.sh
> index a80cec9d11..f1cc42ff71 100755
> --- a/t/t4121-apply-diffs.sh
> +++ b/t/t4121-apply-diffs.sh
> @@ -16,8 +16,8 @@ echo '1
>  7
>  8' >file
>  
> -test_expect_success 'setup' \
> -	'git add file &&
> +test_expect_success 'setup' '
> +	git add file &&
>  	git commit -q -m 1 &&
>  	git checkout -b test &&
>  	mv file file.tmp &&
> @@ -27,10 +27,11 @@ test_expect_success 'setup' \
>  	git commit -a -q -m 2 &&
>  	echo 9 >>file &&
>  	git commit -a -q -m 3 &&
> -	git checkout main'
> +	git checkout main
> +'
>  
> -test_expect_success \
> -	'check if contextually independent diffs for the same file apply' \
> -	'( git diff test~2 test~1 && git diff test~1 test~0 )| git apply'
> +test_expect_success 'check if contextually independent diffs for the same file apply' '
> +	( git diff test~2 test~1 && git diff test~1 test~0 ) | git apply
> +'

Whitespace looks good here. I think this is ready-to-merge; thanks!

>  
>  test_done

