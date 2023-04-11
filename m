Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A466C77B6F
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 13:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjDKNva (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 09:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbjDKNvT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 09:51:19 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB8155A1
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 06:51:08 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id w15-20020a056830410f00b006a386a0568dso11230796ott.4
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 06:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1681221068; x=1683813068;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5NOOsCKfRcP9UNH093XtYR/0uqoTjzyZZ9VhUlaC7D4=;
        b=YGmtfE1xsM6NwR1bmhX2j9cuP8yV9V7tyikfbVgvteAa9xi7yHOb2oS3AvG19SXtCV
         VrfjVJB8e10tneFUrFE+COFZI1sRJBZt4fbILh0lwVIo8/MSb2XpL+IkDKNaxMM5Rfx/
         UnEPDRK96InnJsnzixAYLkHLVUjRBOsg0bNnvNcnt8MUEw19zJOBe2BIhuPKaZPcBcSE
         Uj5wsuvaauAn1z21Ll3yWcD0GzFEfuqTqc7+4eMdRpQs+9+rwvbR1zltWFnHBcPhblFT
         7BrakED8v7M6oGuY9GmExxs8ikHoy6Z4iPmYad23hx22ry/zxlu1y1/QSOI0xZWou9mx
         7DXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681221068; x=1683813068;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5NOOsCKfRcP9UNH093XtYR/0uqoTjzyZZ9VhUlaC7D4=;
        b=wb+wdiWu4AjnWCffhDpeTvtOZb5scQeY7gnJCSwonyb6vSdxpZfnPpE+elYTA3wPma
         0euKbRpPmFYbRq++LqAYbSbLzwiYUPcEFSXfUF7mQ6h1wgcF2OAJR5fPm7q8lvAaQ8/Y
         uAUmyGRM+LRZcnMg0b/016hBVIGR0IMKukviOFEoc0ypHBOWQ+RsgbtoIhgawQupMGoT
         YgmZmOTDTCs9FhqtclcMyZV9Klg7IWLTENqvzXF9JCnewxdqbZ9zL18dzkAzdRvN3IbU
         xaTbwzwcwz61vHHg0D1tr43/cSktM6tNGSm/aq174DCHUzBSUvAKGcuHe51bQsiP3aRq
         /G5A==
X-Gm-Message-State: AAQBX9cMFFxyHQAl0ydV/JQT/MJjWDX2EITgd1jkGTHQIeW8UCCZd0eg
        2kpC4036z/AONkfI7NH5yknw
X-Google-Smtp-Source: AKy350blE6eKNp67/iI3Ol3gDXTOw0KdmW9DUX1ev32Rv3i1DXLvdcuIYV1y18Txp+8UxRO71knj2A==
X-Received: by 2002:a05:6830:1d57:b0:6a1:49c0:6a61 with SMTP id p23-20020a0568301d5700b006a149c06a61mr6779641oth.28.1681221067976;
        Tue, 11 Apr 2023 06:51:07 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id v5-20020a0568301bc500b006a2fd720f82sm5385983ota.7.2023.04.11.06.51.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 06:51:07 -0700 (PDT)
Message-ID: <18a54c6e-7357-42ca-779f-2ba3e6653880@github.com>
Date:   Tue, 11 Apr 2023 09:51:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 7/7] t: invert `GIT_TEST_WRITE_REV_INDEX`
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <cover.1681166596.git.me@ttaylorr.com>
 <9c80379958824ac8fb7834f4f98000d11c3dc4e0.1681166596.git.me@ttaylorr.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <9c80379958824ac8fb7834f4f98000d11c3dc4e0.1681166596.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/10/2023 6:53 PM, Taylor Blau wrote:
> Instead of getting rid of the option, invert its meaning to instead
> disable writing ".rev" files, thereby running the test suite in a mode
> where the reverse index is generated from scratch.
> 
> This ensures that we are still running and exercising Git's behavior
> when forced to generate reverse indexes from scratch.

I don't think this is true because you remove the environment
variable from the following test. Replacing the line with
GIT_TEST_NO_WRITE_REV_INDEX=1 would keep us testing the from-scratch
case as a side-effect in other tests.

> diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> index b098e10f52..e9fbfb6345 100755
> --- a/ci/run-build-and-tests.sh
> +++ b/ci/run-build-and-tests.sh
> @@ -27,7 +27,6 @@ linux-TEST-vars)
>  	export GIT_TEST_MULTI_PACK_INDEX=1
>  	export GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=1
>  	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
> -	export GIT_TEST_WRITE_REV_INDEX=1
>  	export GIT_TEST_CHECKOUT_WORKERS=2
>  	;;

Thanks,
-Stolee
