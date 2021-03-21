Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7F6C433C1
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 18:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F257661947
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 18:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhCUSlz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 14:41:55 -0400
Received: from avasout04.plus.net ([212.159.14.19]:60533 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbhCUSlc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 14:41:32 -0400
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Mar 2021 14:41:32 EDT
Received: from [10.0.2.15] ([147.147.167.73])
        by smtp with ESMTPA
        id O2tilVH5MOQhvO2tjlCHik; Sun, 21 Mar 2021 18:34:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1616351640; bh=HTPJIq5qF3ni7pZINo2iISsr8tTUezBaL869MDcU/F4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=IPJV4zlFZmXunkm2XqK8QkSR7OomoM47AW+5kpHws5Jwx8ZdCSRx1Z8DVgujf3bo3
         iAniQAj1O7RaFc1y3lfrCHviEZI827m07MDsjwgmHVsQnJKh7lIaNeaVQReTWuOICQ
         HLHZ4U1DWgKpOk9ud3XI/pHe2GcRwiCvGdOFWhaojhBnU7EucowB0iQDA684z9LbNy
         bxznRcUfYAM6Ueiz8lw1nOcFAeiaBBOmS/U37Cfm91c1cf2BIO1oJ1Atd/lakZTC/9
         SCiTDxqz6C4LfE2f5IHKLDjYh7pnxANbk+YKZJr01EQxy7EsS2piFvSHObg3MsUM6U
         UuQkZg7bSQRUA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=IvmFjI3g c=1 sm=1 tr=0
 a=nK5asC+3lBOC3EoKtwbYYg==:117 a=nK5asC+3lBOC3EoKtwbYYg==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=9YBR7cmRu54I56X3SL8A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 1/2] diff --no-index tests: add test for --exit-code
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <87wnu0r8tq.fsf@evledraar.gmail.com>
 <cover.1616330120.git.avarab@gmail.com>
 <a6e4ed6c3f1d37170d7e99a2fab9c90662cceb19.1616330120.git.avarab@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <29da572f-8d94-000e-ffc0-fded4b56d3c3@ramsayjones.plus.com>
Date:   Sun, 21 Mar 2021 18:33:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <a6e4ed6c3f1d37170d7e99a2fab9c90662cceb19.1616330120.git.avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfLukJ5w/xu3Di/NFiJbllsKV2eoGeZL8EVEHlmfMYhOOVnwz9bBEGEqmH3SoucQIGXOhT1hp2K4iRUytQgKbs3RQ5OhcrlVFO8AyrEEo5CNebKWKPdMI
 m/2KIsFp7ViFugVvpDojKi5E+XhvZYzlWOr3rd8WJsKm3dJyVuuzkAgUGuUHBJ+cMa7a+h2s05FFeA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 21/03/2021 12:39, Ævar Arnfjörð Bjarmason wrote:
> Add a test for --exit-code working with --no-index. There's no reason
> to suppose it wouldn't, but we weren't testing for it anywhere in our
> tests. Let's fix that blind spot.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  t/t4053-diff-no-index.sh | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
> index 0168946b639..9b7a8ebfd3f 100755
> --- a/t/t4053-diff-no-index.sh
> +++ b/t/t4053-diff-no-index.sh
> @@ -16,7 +16,12 @@ test_expect_success 'setup' '
>  	echo 1 >non/git/b
>  '
>  
> -test_expect_success 'git diff --no-index directories' '
> +test_expect_success 'git diff --no-index --exit-code' '
> +	git diff --no-index --exit-code a/1 non/git/a &&
> +	test_expect_code 1 git diff --no-index --exit-code a/1 a/2
> +'
> +
> +Test_expect_success 'git diff --no-index directories' '

I assume that s/test/Test/ was not intended. ;-)

ATB,
Ramsay Jones

>  	test_expect_code 1 git diff --no-index a b >cnt &&
>  	test_line_count = 14 cnt
>  '
> 
