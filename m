Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D94C3A59D
	for <git@archiver.kernel.org>; Mon,  4 Apr 2022 21:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348374AbiDDVVI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 17:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380624AbiDDUlE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 16:41:04 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69DD201B1
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 13:39:06 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id q20so6694675wmq.1
        for <git@vger.kernel.org>; Mon, 04 Apr 2022 13:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2ewTHjw5622+LDp6wHIOLz+5ubN45Hfq9qi7hTEmOy0=;
        b=dzlAsJcHx6fc+wOesav91fSvyhq+YMsgOcWIwwH10AncnC8pa16jFWfZ7IAuy19fnO
         7Pj9HAu3EVTQMCu/jTDP8Mwfx/rKU9lW0re6X9SBuaUQfDdYCey+PORIIpZd13GfWAZw
         jVRKlWCx4rJx9Lqlfv2Ix9Ce1DmKJod1vsneLz4LLvdVXkHUI877TLVbMWIe9ga61rHT
         OHK6oyVtbal3sjjEWE1pGPPK6PKAfJCjfngRjYFHIrkoSVL5BagsBosMSsh6VNG4uHn1
         Yte8Rqb1ysPrajLDO41FbmsB4VGtJ4d+44evuNHIpF9wKnJJg6ATnNcQcf766oFkY8Ju
         wl2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2ewTHjw5622+LDp6wHIOLz+5ubN45Hfq9qi7hTEmOy0=;
        b=Q7Xxp+NPWUAyLDkPckIc+UrzjUhbz4kJBCYtsrLiHNiq0l4sNlCRjkKDePgyWkXtgR
         n8Qyqtx2RSDoZkcoW3+xMRpaYsV2Qc/GcdXpafKOoq8IEzl+N0oV/ndLYCVZouId3UAa
         PJ1vxLa4soa1elGWEHFssGeqZfJ6+rUt+wxP5x+3ZfIF57LU9JJk4YyqNb9ywXMEqeGE
         OnLu6bOTTof8GE380HWERuFK+dbHxmwOihtJgDXf3lwONbU4xqqRuGsiPuLRqtC2vWWk
         e0doSJihZTpnk4epVcnGx4Ct/4CV00cAPwu2oj7WPYXv/Rpy7QwNycTVWrGOCsRHpSLE
         /DkQ==
X-Gm-Message-State: AOAM530SUuTzWc4j33Xt9SeU1HimFhcOGDAkvJ55j9FiMMnQwJkniA1C
        TrBYHVEW4/1AG4QIUfBIR6c=
X-Google-Smtp-Source: ABdhPJwKCYJwAYi9FawiAjAhS+PUwNxtVPJCnY7gCmAfAtTxWil/d3XZukUWACWdRZf0XAyrfMIYrg==
X-Received: by 2002:a05:600c:40f:b0:38c:be5c:9037 with SMTP id q15-20020a05600c040f00b0038cbe5c9037mr769880wmb.44.1649104745149;
        Mon, 04 Apr 2022 13:39:05 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.224])
        by smtp.gmail.com with ESMTPSA id i19-20020a05600c355300b0038e1d69af52sm80640wmq.7.2022.04.04.13.39.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 13:39:04 -0700 (PDT)
Message-ID: <975e203d-6bd3-f5ea-c21b-3e7518a04bb9@gmail.com>
Date:   Mon, 4 Apr 2022 21:39:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] test-lib.sh: Use GLIBC_TUNABLES instead of
 MALLOC_CHECK_ on glibc >= 2.34
Content-Language: en-GB-large
To:     Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20220304133702.26706-1-gitter.spiros@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20220304133702.26706-1-gitter.spiros@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/03/2022 13:37, Elia Pinto wrote:
> In glibc >= 2.34 MALLOC_CHECK_ and MALLOC_PERTURB_ environment
> variables have been replaced by GLIBC_TUNABLES.  Also the new
> glibc requires that you preload a library called libc_malloc_debug.so
> to get these features.
> 
> Using the ordinary glibc system variable detect if this is glibc >= 2.34 and
> use GLIBC_TUNABLES and the new library.
> 
> This patch was inspired by a Richard W.M. Jones ndbkit patch
> 
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
> This is the third version of the patch.
> 
> Compared to the second version[1], the code is further simplified,
> eliminating a case statement and modifying a string statement.
> 
> [1] https://www.spinics.net/lists/git/msg433917.html
> 
>   t/test-lib.sh | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 9af5fb7674..4d10646015 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -550,9 +550,25 @@ else
>   	setup_malloc_check () {
>   		MALLOC_CHECK_=3	MALLOC_PERTURB_=165
>   		export MALLOC_CHECK_ MALLOC_PERTURB_
> +		if _GLIBC_VERSION=$(getconf GNU_LIBC_VERSION 2>/dev/null) &&
> +		_GLIBC_VERSION=${_GLIBC_VERSION#"glibc "} &&
> +		expr 2.34 \<= "$_GLIBC_VERSION" >/dev/null
> +		then
> +			g=
> +			LD_PRELOAD="libc_malloc_debug.so.0"

When compiling with "SANITIZE = address,leak" this use of LD_PRELOAD 
makes the tests fail with

==9750==ASan runtime does not come first in initial library list; you 
should either link runtime to your application or manually preload it 
with LD_PRELOAD.

because libc_malloc_debug.so is being loaded before libasan.so. If I set 
TEST_NO_MALLOC_CHECK=1 when I run the tests then ASAN does not complain 
but it would be nicer if I did not have to do that. I'm confused as to 
why the CI leak tests are running fine - am I missing something with my 
setup?

Best Wishes

Phillip
