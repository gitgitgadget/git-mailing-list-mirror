Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C963EC3A5A7
	for <git@archiver.kernel.org>; Thu,  8 Dec 2022 10:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiLHKJp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Dec 2022 05:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiLHKJn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2022 05:09:43 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CC32BB03
        for <git@vger.kernel.org>; Thu,  8 Dec 2022 02:09:41 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id v7so698288wmn.0
        for <git@vger.kernel.org>; Thu, 08 Dec 2022 02:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3xJtdK49btHPEToxPMCH1arc6PMd2qVqy6vnK74uPQk=;
        b=DWnzm47/idL10c0Q8d90xjySV+9m7z80Oj9Uq2JtqDlbm9hwYcDCDlAsU0LgePdSPn
         l1SG5NPPrBC/UZLNuQY/JMU4Wsvq6sXGH//t2Ih5nwKkgkDYev7LQ2R2smAn8MAUBjxP
         scx7Vg5BTSO0/G8zDxTuBzS6QbJdUEB0R1DNXPGxvMOU1pcwPgmfbWModdeAhHrH06zt
         ZOUfpK1g/6QWcUwGfNfxOadzC/W622B0amAbjWB4AQsIcU3RqyTziJmL59/Tqn9XO+o5
         JEma8lPSrco2Ccs4ZJcPjWr5uU1BdNiS93Qljch9lFTGQzZigBnXx6T9b96UbL2wAnAW
         fAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xJtdK49btHPEToxPMCH1arc6PMd2qVqy6vnK74uPQk=;
        b=tno+ZX4Q/x4fjhhTyX+u0bMm/PiEvLLEotN04lhabsn4Beiqlw4HiMwPPlRi4UbrTR
         IOWo4b7zSlcgUrPMj+aJWl0vOVjy2gMqxE5FcvO6UGrtyk2OWJKgav0zrzuR+ebo2Imf
         vITz8VEuRbXYw6zxl8I+NDhdNmAI36fNeHnkMYXfy3iON1yr6LRIQmg+jvpHNflpgs1+
         KniAJWy8pGMsPttVxrLpLP4lLAHvHAaVGEBxzyRk4BIQVRWPyvSKsnqCvsJq8s7M1z7x
         dI9z9t0RY1ABm/wBh6WvipgLrjLfWC6BBvaYRJ76mGrEGG9OCCZWVaYVNTHYHLxHgeA5
         s2GA==
X-Gm-Message-State: ANoB5pmIBNlOJZrb7QxliVYtGpTbV8930DzcWlWOAVIIBQUNZEkFOYpl
        w1NuCRBiqdLSmDiuAKT/xX0DMASe188=
X-Google-Smtp-Source: AA0mqf462wurakLINUGANLPAR5yPixMH5UEOuXcNRzjn4D0QDaAEX/MpvsUjoegSBItm057tMeexAw==
X-Received: by 2002:a05:600c:6549:b0:3cf:497c:c59e with SMTP id dn9-20020a05600c654900b003cf497cc59emr1628379wmb.6.1670494180171;
        Thu, 08 Dec 2022 02:09:40 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id p18-20020adfce12000000b00242271fd2besm21514950wrn.89.2022.12.08.02.09.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 02:09:39 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <271d275e-df40-76e5-3930-89ab63961fb2@dunelm.org.uk>
Date:   Thu, 8 Dec 2022 10:09:38 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] CI: don't explicitly pick "bash" shell outside of
 Windows, fix regression
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <patch-1.1-08dc682926a-20221207T031459Z-avarab@gmail.com>
 <patch-v2-1.1-c34fd06623a-20221207T120220Z-avarab@gmail.com>
In-Reply-To: <patch-v2-1.1-c34fd06623a-20221207T120220Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 07/12/2022 12:03, Ævar Arnfjörð Bjarmason wrote:
> When the "js/ci-github-workflow-markup" topic was originally merged in
> [1] it included a change to get rid of the "ci/print-test-failures.sh"
> step[2]. This was then brought back in [3] as part of a fix-up patches
> on top[4].
> 
> The problem was that [3] was not a revert of the relevant parts of
> [2], but rather copy/pasted the "ci/print-test-failures.sh" step that
> was present for the Windows job to all "ci/print-test-failures.sh"
> steps. The Windows steps specified "shell: bash", but the non-Windows
> ones did not.
> 
> This broke the "ci/print/test-failures.sh" step for the "linux-musl"
> job, where we don't have a "bash" shell, just a "/bin/sh" (a
> "dash"). This breakage was reported at the time[5], but hadn't been
> fixed.
> 
> It would be sufficient to change this only for "linux-musl", but let's
> change this for both "regular" and "dockerized" to omit the "shell"
> line entirely, as we did before [2].
> 
> Let's also change undo the "name" change that [3] made while
> copy/pasting the "print test failures" step for the Windows job. These
> steps are now the same as they were before [2], except that the "if"
> includes the "env.FAILED_TEST_ARTIFACTS" test.

What's the motivation for this part of the change (which is completely 
unrelated to the choice of shell)? Having the test failures under "Print 
test failures" makes it easy for new contributors to see where to click 
to see the full output for test failures. Now they will appear under 
"Run ci/print-test-failures.sh" which while not terrible is not as clear.

Best Wishes

Phillip

> 1. fc5a070f591 (Merge branch 'js/ci-github-workflow-markup', 2022-06-07)
> 2. 08dccc8fc1f (ci: make it easier to find failed tests' logs in the
>     GitHub workflow, 2022-05-21)
> 3. 5aeb145780f (ci(github): bring back the 'print test failures' step,
>     2022-06-08)
> 4. d0d96b8280f (Merge branch 'js/ci-github-workflow-markup', 2022-06-17)
> 5. https://lore.kernel.org/git/220725.86sfmpneqp.gmgdl@evledraar.gmail.com/
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> 
> I forgot the Signed-off-by in v1, sorry.
> 
> Range-diff against v1:
> 1:  08dc682926a ! 1:  c34fd06623a CI: don't explicitly pick "bash" shell outside of Windows, fix regression
>      @@ Commit message
>           4. d0d96b8280f (Merge branch 'js/ci-github-workflow-markup', 2022-06-17)
>           5. https://lore.kernel.org/git/220725.86sfmpneqp.gmgdl@evledraar.gmail.com/
>       
>      +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>      +
>        ## .github/workflows/main.yml ##
>       @@ .github/workflows/main.yml: jobs:
>            - uses: actions/checkout@v2
> 
>   .github/workflows/main.yml | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 9afacfa0b33..1a86f6a8ce1 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -265,10 +265,8 @@ jobs:
>       - uses: actions/checkout@v2
>       - run: ci/install-dependencies.sh
>       - run: ci/run-build-and-tests.sh
> -    - name: print test failures
> +    - run: ci/print-test-failures.sh
>         if: failure() && env.FAILED_TEST_ARTIFACTS != ''
> -      shell: bash
> -      run: ci/print-test-failures.sh
>       - name: Upload failed tests' directories
>         if: failure() && env.FAILED_TEST_ARTIFACTS != ''
>         uses: actions/upload-artifact@v2
> @@ -297,10 +295,8 @@ jobs:
>       - uses: actions/checkout@v1
>       - run: ci/install-docker-dependencies.sh
>       - run: ci/run-build-and-tests.sh
> -    - name: print test failures
> +    - run: ci/print-test-failures.sh
>         if: failure() && env.FAILED_TEST_ARTIFACTS != ''
> -      shell: bash
> -      run: ci/print-test-failures.sh
>       - name: Upload failed tests' directories
>         if: failure() && env.FAILED_TEST_ARTIFACTS != ''
>         uses: actions/upload-artifact@v1
