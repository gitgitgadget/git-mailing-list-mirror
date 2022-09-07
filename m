Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D43C38145
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 22:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiIGWKf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 18:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiIGWKe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 18:10:34 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E437C2D1E3
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 15:10:32 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id y127so15991743pfy.5
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 15:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=pgDoQRscarCAXTc5jA9iDbrgJ23vsrHezFnolxY+wTo=;
        b=V4SDqHMRHP3rIAh1IhKb5EcsecFdGtpSTmJ7Z7rXS1Mxq3K427pPPD2VAMNYdJXNjB
         waGOqA2IRMSbMoIG3J/MSII9ib+HYgNePPc7q1p0pStYTzxMWVLn8xD03186YPzEd9c0
         MUxyA0zLQ0S3Rzllrg09ukJy1YBVa4/VK+3gTaJJ2UFaPZMdq9lNZbMFkOKP92vWNQFz
         vJDwMx/JunfupAl6A2NykioBV4yAxjYi6dz1qU6zBZoMI80XuZpXjMvVmpCYNjCQ1/qp
         gKtfWGgn+0E4P32zLk47j1lg4+ssINX+BbP+AC94+jhy5QDPSlD28YmVbjdmJSxsX6KT
         fJOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=pgDoQRscarCAXTc5jA9iDbrgJ23vsrHezFnolxY+wTo=;
        b=U/RGUfvqYtd/moqteFUIBQwFvMXSl+Qf5XHHNS+GCAVbaqH6AlNjxs/LJd9yTY0/0S
         OAwwpFhLaJowLwISprFexgQbvJTXOeIN9lyA70b7GR9IRsX8ZaiYnJOL/zedHgDfoAmU
         CE9FEvEyTxPnuBX01nuX8/RY3WqfPOr7fW2gQKwpAgZWq+EVvk+VD69Q34kAcX15abfW
         sY+HH2Vdr73gSKCHC6tAvHGkZ9CD/fXJUPfHiCQKz9uFo0N/NQdhxW8dGb/xtx5TA19v
         eDSo8q+K3V6rNkAVBFDX7LLHSI6k4xBLV296JV0KWVJ+aD96y/6kzCDETLe14/NnamP/
         G+0Q==
X-Gm-Message-State: ACgBeo1LYWtQZM8Q/rMt7MOnxVYLEjcydaudT+qlfnP1Kc3CZVjC4kgm
        ym+bVLRAhug1CdRcwJLQp1DLDT1Ze7+o
X-Google-Smtp-Source: AA6agR5y1Kk7VDCBiSY08YiAOz6UhwpXuCid7xbIpr3ybOBBhvp9lGywRu1QrNCao2g5NfFv1G2DEg==
X-Received: by 2002:a63:211:0:b0:41d:946e:cf67 with SMTP id 17-20020a630211000000b0041d946ecf67mr5120459pgc.497.1662588632375;
        Wed, 07 Sep 2022 15:10:32 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id h7-20020aa796c7000000b0053e6eae9668sm2409989pfq.2.2022.09.07.15.10.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 15:10:32 -0700 (PDT)
Message-ID: <3df77ffd-85a2-3a54-9005-34a24ec6e82d@github.com>
Date:   Wed, 7 Sep 2022 15:10:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH v2 1/5] cmake: make it easier to diagnose regressions in
 CTest runs
Content-Language: en-US
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1320.git.1660143750.gitgitgadget@gmail.com>
 <pull.1320.v2.git.1661243463.gitgitgadget@gmail.com>
 <e00cb37b98ac09cff010e843ef19eeec761f8985.1661243463.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <e00cb37b98ac09cff010e843ef19eeec761f8985.1661243463.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> When a test script fails in Git's test suite, the usual course of action
> is to re-run it using options to increase the verbosity of the output,
> e.g. `-v` and `-x`.
> 
> Like in Git's CI runs, when running the tests in Visual Studio via the
> CTest route, it is cumbersome or at least requires a very unintuitive
> approach to pass options to the test scripts.

At first I wondered whether there's a way to make arg specification more
intuitive, rather than silently changing defaults. Unfortunately, it looks
like even in the latest versions of CTest don't really support passing
arguments through to tests [1] (and the workarounds are unpleasant at best).

But then, you mentioned that there *is* a cumbersome/unintuitive approach to
passing the options; what approach were you thinking?

[1] https://gitlab.kitware.com/cmake/cmake/-/issues/20470

> 
> So let's just pass those options by default: This will not clutter any
> output window but the log that is written to a log file will have
> information necessary to figure out test failures.

Makes sense, I don't see any harm in providing more verbose output by
default here.

> 
> While at it, also imitate what the Windows jobs in Git's CI runs do to
> accelerate running the test scripts: pass the `--no-bin-wrappers` and
> `--no-chain-lint` options. This makes the test runs noticeably faster
> because the `bin-wrappers/` scripts as well as the `chain-lint` code
> make heavy use of POSIX shell scripting, which is really, really slow on
> Windows due to the need to emulate POSIX behavior via the MSYS2 runtime.

I'm a bit more hesitant on including these. I see how the performance
benefit (on Windows in particular) would make typical user experience nicer.
But, if someone develops locally with '--no-chain-lint' specified, they'll
be much more likely to miss a broken && chain (personally, I get caught by
chain lint errors *all the time* when I'm adding/updating tests) and cause
unnecessary churn in their patch submissions. So, my recommendation would be
to drop '--no-chain-lint' here (unless it's less important to the average
developer than I think it is).

It's also possible that '--no-bin-wrappers' does something weird with their
local installation of Git but I think it's safe enough to make the default
if the performance gain is substantial.

> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  contrib/buildsystems/CMakeLists.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
> index 1b23f2440d8..4aee1e24342 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -1088,7 +1088,7 @@ file(GLOB test_scipts "${CMAKE_SOURCE_DIR}/t/t[0-9]*.sh")
>  #test
>  foreach(tsh ${test_scipts})
>  	add_test(NAME ${tsh}
> -		COMMAND ${SH_EXE} ${tsh}
> +		COMMAND ${SH_EXE} ${tsh} --no-bin-wrappers --no-chain-lint -vx

As you have it here, I don't think there's a way for a user to override
these defaults (unless there's something about the manual workaround you
mentioned earlier that allows it). Since a user could feasibly want to set
their own options, could you add a build variable to CMakeLists.txt like
'GIT_TEST_OPTS'? You could use it to set the default options you have here,
but a user could still specify their own value at build time to override.

>  		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/t)
>  endforeach()
>  

