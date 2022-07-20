Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3D9C43334
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 01:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241518AbiGTBrY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 21:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbiGTBrW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 21:47:22 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46DF286E0
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 18:47:19 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id h14so1442999ilq.12
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 18:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=j45ndVhREXMvlx3K7RiKowfrOCwq3Evd4mLSOJrUlkc=;
        b=DD3K3u7jc0EQ1oRwJkFaIqXF/+9d00dlSnMcBq57JRi3QwEUktRQLR6W+kGONVlAvX
         YlphDa3P0/pUflUypquYnpq2a6Y3jOyz3gPnPzuh66a52kisEIEK1PSfeo5L0fvHS7xH
         0CU/S8DkkaGqT5CHDBFMOX0V5hOMp25mlyzEMUWfo18gUo5z/7TKEvM7iFiFTOGCU+4S
         RsJ7wTTUg2NewjK7Y28R3ytl4KoC0c6DnagvweLx5p4DukGYc3MfbJ/ldyreCrTVV6Ps
         HnSCPSbKkjMp5/kqYpVuPvnSEsT1OUOdoFqCwbWhRqZQHEFdN45gzGP+pk38HyHRl1li
         F9Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=j45ndVhREXMvlx3K7RiKowfrOCwq3Evd4mLSOJrUlkc=;
        b=ihQNDFTT/BNqcmUq2PaI/Kk0fn9Q65GVZHMXwbI8Y3PSs31knniJHvn2TCJEm0E8rh
         sMtLaKMV0WlGtHJGLSS+ZvexAvp6VfsHjcdrqOCafP4bRfRsyBwhMxzEEyvIwxx/LXWR
         PTc9wzKGdQas3iN7v4xCz6JpeRnEcNQyc0XW0KqIPnBl7aSryRxEUpzU4umSJt4U7vpK
         X8t+fUZS1aYEMTgaJ7FUBZMxPO3HzQCI0cZ27opikwMrMlJPxkLvJEJOSOfdk4ivMRUG
         DaknzYLBCd9yC5RoDH3Zs1SB3MYCBu9v7R99lo5l0a2ajzaI9jLtZVz6z1aKEh5hEX7j
         6Sew==
X-Gm-Message-State: AJIora/49yJkBvu72a1HKIcIMRTcC9rCxbvUUvKudPUkfQP+HL0SXV/1
        Erl+S5LzrteKJc2ttY1jN2+l
X-Google-Smtp-Source: AGRyM1t9I6L2mOHxr3Wpes340Qpbut5uhtW0Fe34Dyz7Nmqf1QLePnLUuHOlhaNn3kGs11NfkV77oQ==
X-Received: by 2002:a05:6e02:1b01:b0:2dc:7472:a5d1 with SMTP id i1-20020a056e021b0100b002dc7472a5d1mr17197139ilv.62.1658281639329;
        Tue, 19 Jul 2022 18:47:19 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:d574:b134:aa04:ad2c? ([2600:1700:e72:80a0:d574:b134:aa04:ad2c])
        by smtp.gmail.com with ESMTPSA id 7-20020a921307000000b002dcafb975c6sm6408732ilt.82.2022.07.19.18.47.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 18:47:18 -0700 (PDT)
Message-ID: <93e76ab0-925d-3596-ae86-b5fbd8349555@github.com>
Date:   Tue, 19 Jul 2022 21:47:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 08/10] test-lib: have the "check" mode for SANITIZE=leak
 consider leak logs
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>
References: <cover-00.10-00000000000-20220719T205710Z-avarab@gmail.com>
 <patch-08.10-afbb7e19195-20220719T205710Z-avarab@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <patch-08.10-afbb7e19195-20220719T205710Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/19/2022 5:05 PM, Ævar Arnfjörð Bjarmason wrote:

>  
> +The "check" mode is especially useful if combined with
> +GIT_TEST_SANITIZE_LEAK_LOG=true.
> +
>  GIT_TEST_SANITIZE_LEAK_LOG=true will log memory leaks to
>  "test-results/$TEST_NAME.leak/trace.*" files. Useful in combination
>  with "GIT_TEST_PASSING_SANITIZE_LEAK" to check if we're falsely
>  reporting a test as "passing" with SANITIZE=leak due to ignored exit
>  codes.
>  
> +When GIT_TEST_SANITIZE_LEAK_LOG=true is set we'll look at the
> +"test-results/$TEST_NAME.leak/trace.*" files at the end of the test
> +run in combination with the "TEST_PASSES_SANITIZE_LEAK" and
> +GIT_TEST_PASSING_SANITIZE_LEAK=check setting to see if we'll fail a
> +test leaked, but which the test run itself didn't catch due to ignored
> +or missed exit codes.

Is this paragraph about when GIT_TEST_SANITIZE_LEAK_LOG=true _and_
GIT_TEST_PASSING_SANITIZE_LEAK=check are set? Or, when ...LEAK_LOG=true
we set GIT_TEST_PASSING_SANITIZE_LEAK=check at the end? If it's the
first, then I think the paragraph should lead with that.

This paragraph is also a single sentence. I lose myself in it
halfway through. Please break it up to add clarity.

Thanks,
-Stolee
