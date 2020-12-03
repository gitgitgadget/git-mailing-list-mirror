Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D62CC433FE
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 15:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE39C206EC
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 15:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgLCPYj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 10:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbgLCPYj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 10:24:39 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB05CC061A4E
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 07:23:58 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id ek7so1094334qvb.6
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 07:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ouVdo4DJ69F73NXi3RrudjkwVarEROfPWLthz3Dh7uk=;
        b=RBXU7M0XaYj7uAvpsxugK2wrR5HG3IhkDoSNiVFnzSuwGq0XcSK5ydvaB/FFAuhw9M
         B6Mu+CUWD+WAimlHmYucfSb53GxaXJOHxH901B4jdT21x8g5sKrrVTKOLPF+/DGdfiC2
         Psu9epp854jsSH4kLlhI+cBvRdEVsvwqbQWZwchLg1HM5F4gCDmOPmktBITbcaTQy4F7
         btSJ/nooVzinRwwFrXhvgHapcIOpq6bo2EX6QOqs+Ar0s9YnmVnC8wvwu4PYXmhY9TGT
         GxM8GKYw7odokpISbPpwDrDvenWprwe9+r9Wq8IoL2lwS5LEG15sg5QoI+fsjo3Hl36r
         cWJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ouVdo4DJ69F73NXi3RrudjkwVarEROfPWLthz3Dh7uk=;
        b=MPNms2mckGbf8igUAVnxV4DkJAceRLqAUPPdbZuZpky0e+25u8ktbbu8cxxQkpUW/7
         9mzIB+bN2PM+JR2iAv2RtUnNwAHrKVrXDHpJbTbjKfqwLojKpze9PEda4huY/x+Ttyx+
         0d5ehbkZzuUyjRaGDDYnFLGaKdxtibiWlIXhG+DZjpBJYEKcc82umzH+Axs+VlovMmdQ
         Yc01uyGwS5UknQp8YC0LbOuOL2AbimhYa3563Skz1ogBGRnuCidcuk7JCz8+dirJQagR
         J1EQCZnKWYUFtAolvLHcr/gX33hR1wk55ArZMMM+XTMrezjGxfzVMBp/RWW7TA8kyF9o
         o3kg==
X-Gm-Message-State: AOAM530h+BrdmxsFgGZwM5fScZKpHpjNeOdX9IXUcPHEvB8Ehcm8M4VL
        uCt8u5czXHYS22vx5/c8G6V/7E0xesYISA==
X-Google-Smtp-Source: ABdhPJyvlyXnCjpYrRA66wLH6yUdfcNDHZwhN4ti1tGKbiGXI1ZJmzwWW6KCKhXYhzKh1KISObpEAg==
X-Received: by 2002:ad4:548b:: with SMTP id q11mr3686610qvy.44.1607009037466;
        Thu, 03 Dec 2020 07:23:57 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id w31sm1579275qth.60.2020.12.03.07.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 07:23:56 -0800 (PST)
Subject: Re: [PATCH] t7900: speed up expensive test
To:     Jeff King <peff@peff.net>
Cc:     Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org
References: <20201113050631.GA744608@coredump.intra.peff.net>
 <323fd904-a7ee-061d-d846-5da5afbc88b2@virtuell-zuhause.de>
 <20201116041051.GA883199@coredump.intra.peff.net>
 <1403797985.37893.1606777048311@ox.hosteurope.de>
 <X8YnsGsUl53OKFno@coredump.intra.peff.net>
 <X8YrbDpC9/EjRr95@coredump.intra.peff.net>
 <373f3dfe-828b-430d-b88e-5e23302090cb@gmail.com>
 <X8cAXHJRm+Xz9PFM@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b3bfa8df-f750-3dc9-d4e5-1bbd6a636eeb@gmail.com>
Date:   Thu, 3 Dec 2020 10:23:57 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <X8cAXHJRm+Xz9PFM@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/1/2020 9:47 PM, Jeff King wrote:
> Subject: [PATCH] t7900: speed up expensive test
> 
> A test marked with EXPENSIVE creates two 2.5GB files and adds them to
> the repository. This takes 194s to run on my machine, versus 2s when the
> EXPENSIVE prereq isn't set. We can trim this down a bit by doing two
> things:
> 
>   - use "git commit --quiet" to avoid spending time generating a diff
>     summary (this actually only helps for the second commit, but I've
>     added it here to both for consistency). This shaves off 8s.
> 
>   - set core.compression to 0. We know these files are full of random
>     bytes, and so won't compress (that's the point of the test!).
>     Spending cycles on zlib is pointless. This shaves off 122s.
> 
> After this, my total time to run the script is 64s. That won't help
> normal runs without GIT_TEST_LONG set, of course, but it's easy enough
> to do.

I'm happy with these easy fixes to make the test faster without
changing any of the important behavior. Thanks!

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t7900-maintenance.sh | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index d9e68bb2bf..d9a02df686 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -239,13 +239,15 @@ test_expect_success 'incremental-repack task' '
>  '
>  
>  test_expect_success EXPENSIVE 'incremental-repack 2g limit' '
> +	test_config core.compression 0 &&
> +
>  	for i in $(test_seq 1 5)
>  	do
>  		test-tool genrandom foo$i $((512 * 1024 * 1024 + 1)) >>big ||
>  		return 1
>  	done &&
>  	git add big &&
> -	git commit -m "Add big file (1)" &&
> +	git commit -qm "Add big file (1)" &&
>  
>  	# ensure any possible loose objects are in a pack-file
>  	git maintenance run --task=loose-objects &&
> @@ -257,7 +259,7 @@ test_expect_success EXPENSIVE 'incremental-repack 2g limit' '
>  		return 1
>  	done &&
>  	git add big &&
> -	git commit -m "Add big file (2)" &&
> +	git commit -qm "Add big file (2)" &&
>  
>  	# ensure any possible loose objects are in a pack-file
>  	git maintenance run --task=loose-objects &&
> 

