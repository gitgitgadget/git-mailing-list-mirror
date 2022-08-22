Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF827C28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 16:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235201AbiHVQKD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 12:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234886AbiHVQKB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 12:10:01 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469B632EF1
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 09:09:57 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id a9so5633068ilr.12
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 09:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=HcNVfyBuyt99E//9qDI5FKC8RBGTCzanfcWq+eYiEqQ=;
        b=Tztl6qbhNxoOLW6SEr7UzfZ7W+S4VvmSzhLdaWZRxq8oCOgOWvHRFYXqtwg7xZ++H0
         5m2QLrp+R7Ib0hYn/c+/xZgSjfidPI9osGK4DXRsQxqb0lJ/BN7KISDWIqvPgmQ0qAUP
         sQhBeT/884uZtUVQAO3iFsxMo1OICeBCjMQGp4BXX+nCXif/VrQoZlf6DuNLnUbJWP+d
         Jv8JrdgaJcgXhZNmqoKFBsEd9zNLECjJYwuMSv0U8/k1XCE73x1nYKIR8lvOjKA/rv5t
         NcJEEGh9p735SEWKvNV5fVy2wagFvRNPJlySyO9HTu3n45A/u8m/iZbkSVD9LjKc3yC1
         ycfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=HcNVfyBuyt99E//9qDI5FKC8RBGTCzanfcWq+eYiEqQ=;
        b=6Vvfbka5S++g1udHzwGMW5AWhB7O6Z7bcceqzqLvMfoOaztL7q4NbM/BIVmFh7+vJj
         xsALV6yNmFwjt43W3robzIDlptryoJVErj6qEkOF9xJtU84AMH3I7KKxiFffezR9zfNU
         GsYyGiA3IBALNpS42ooINwSCc1SGElK8NMNWrrt1p1Cv8YTc5lSbrRCqhDr9Q3Xaan+/
         2ZYxWH5H+P1desCDSdOQR2A+Ozl4UkUf6b9/4dkHeaHXZ9wKdDiuYliqfu00H6w/YNdD
         vzUipWa33h0hH9ED4AiamAS7ayfp8aKQMNkYm66tC+fr27mPSe9V4NcaNdWHul1HT43N
         Fdeg==
X-Gm-Message-State: ACgBeo2RCsV8UYdQPzfE4fM8aPzzGEh19nHCrD2xda1WliX9fdm3UJiQ
        7GSaqWj21sqD4t4W/O5MEBvh/Rspaf0q
X-Google-Smtp-Source: AA6agR5zbyIjlfPcRovYmkJtTMp9VNwnF4KXA3wHjIp/0i4l1FTfG6qfjaLZSfn4yGwSQJpbcig13A==
X-Received: by 2002:a05:6e02:1561:b0:2e4:b7b8:bbb7 with SMTP id k1-20020a056e02156100b002e4b7b8bbb7mr10398711ilu.71.1661184596519;
        Mon, 22 Aug 2022 09:09:56 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:5550:8912:9500:397a? ([2600:1700:e72:80a0:5550:8912:9500:397a])
        by smtp.gmail.com with ESMTPSA id e4-20020a92de44000000b002e904093c5dsm5205382ilr.44.2022.08.22.09.09.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 09:09:56 -0700 (PDT)
Message-ID: <3525f8bd-31af-181d-b7a5-6e8a453bbba7@github.com>
Date:   Mon, 22 Aug 2022 12:09:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/6] t5326: demonstrate potential bitmap corruption
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, Johannes.Schindelin@gmx.de,
        chakrabortyabhradeep79@gmail.com, jonathantanmy@google.com,
        kaartic.sivaraam@gmail.com
References: <cover.1660944574.git.me@ttaylorr.com>
 <3e30ab1a19115107fc24a25118f2417319bd1b0d.1660944574.git.me@ttaylorr.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <3e30ab1a19115107fc24a25118f2417319bd1b0d.1660944574.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/19/2022 5:30 PM, Taylor Blau wrote:

> +test_expect_success 'preferred pack change with existing MIDX bitmap' '
> +	rm -fr repo &&

Does a previous test not delete 'repo' when necessary?

Or, do previous tests re-use 'repo' and now we are in a region
where we can safely clear that directory? Should we use a
different name?

> +	git init repo &&
> +	test_when_finished "rm -fr repo" &&

nit: test_when_finished should be the first line of the test.

> +		# Generate a new MIDX which changes the preferred pack to a pack
> +		# contained in the existing MIDX, such that not all objects from
> +		# p2 that appear in the MIDX had their copy selected from p2.
> +		git multi-pack-index write --bitmap \
> +			--preferred-pack="pack-$p2.pack" &&
> +		test_path_is_file $midx &&
> +		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
> +
> +		test_must_fail git clone --no-local . clone2

This section is demonstrating the bug. Perhaps we should have
comments indicating that this is not desired behavior, but is
being demonstrated so the bug can be fixed by a later change?

Thanks,
-Stolee

