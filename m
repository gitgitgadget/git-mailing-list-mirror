Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A502C433F5
	for <git@archiver.kernel.org>; Thu, 14 Apr 2022 06:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236864AbiDNGsw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Apr 2022 02:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiDNGsv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Apr 2022 02:48:51 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128F03F301
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 23:46:27 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id h63so4388707iof.12
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 23:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=k9PjW+UDTy6IDgCwIfXbYk2xRjRWAJkfefa+bW5aIiQ=;
        b=lOfE6bWoq4aUKYRi+6hpqRCfbCL2RIRuVYIfa6riuKn5Ul1JsN4ei8m2eM3eSM9Hp7
         5GleZeIuQXbdjx/H8IwvQ2nUUIj71ztS45d+q0XT2sw/CfcT+RoCjM3zKwZ72TfTAcDK
         5ZKa/LR8x0HkvEEqnUXEImrvQ+v8zbb5GlAEuC04t6pFWyWksDFQGAwo2Ho55EILMysU
         AeIsrFf4x6/nLwSOAPmI48vBYeWB9RV6vZ/6UcLVlZiJUPiF0FDZzWdaLW2cACLczg6j
         Jg2t77ozwKhjecEYDp61CdwakQpY8hbiscjQ5A6H83oWjMWT5UXCuVasynJSywEO7yt3
         HUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=k9PjW+UDTy6IDgCwIfXbYk2xRjRWAJkfefa+bW5aIiQ=;
        b=J2YXZwN+Q4VYd2iwL+6Y92p8LxHgkI+Nrjvl8A5+pCUjcfDA7cRnhEbjimXIf/u1Tg
         /5X2ZgIihgDlYoswK04/XBO1jnr8Iv//vhXAAw7zhQjXxiqLkfO0WAQ1Ei6mQZiDNpKD
         Zw3LfNelVeFZQ7GEHufJaYYu1E/DFd51YNf5iMh0D/bjvWAPfOe25epOdCyTaYAjkEK6
         +25Rb2FIQU7TEMblKn/8onWcBoNiOt9dM/L6HVA8/knuF3+Aour88p/8tINCuKVsFGey
         XHctiWmqsRIUBxU+tp/zH6m9xZpJi9QO46kIR34hiBK6BZP/ppsiaenSQTvVYF2m6TNt
         eQBw==
X-Gm-Message-State: AOAM530xUaR+G8HWMyrPM1eerS+g1AkIGewHNcJnmNE92IS+j5rWBJ6R
        UVb1RmLctHVphNwD9p0xipo=
X-Google-Smtp-Source: ABdhPJyhqQM81/WqiR2lpucnYbGT9PYierd5yClZnH3uTUYbo6zmXafjnMGzvzyU+KDVwDzUib/Ssg==
X-Received: by 2002:a05:6638:150c:b0:321:568a:366c with SMTP id b12-20020a056638150c00b00321568a366cmr597275jat.109.1649918786313;
        Wed, 13 Apr 2022 23:46:26 -0700 (PDT)
Received: from [10.11.12.100] (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id v18-20020a6b5b12000000b00645bd8bd288sm700464ioh.47.2022.04.13.23.46.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 23:46:26 -0700 (PDT)
Sender: Eric Sunshine <ericsunshine@gmail.com>
Message-ID: <407028e3-ea88-a396-2d00-d7bf5977ba20@sunshineco.com>
Date:   Thu, 14 Apr 2022 02:46:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH v3 13/29] CI: remove "run-build-and-tests.sh", run "make
 [test]" directly
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>
References: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
 <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
 <patch-v3-13.29-13feda050c0-20220413T194847Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
In-Reply-To: <patch-v3-13.29-13feda050c0-20220413T194847Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/13/22 3:51 PM, Ævar Arnfjörð Bjarmason wrote:
> Remove the already thin "ci/run-build-and-tests.sh" wrapper and
> instead make the CI run "make" or "make test" directly. By doing this
> we'll be able to easily see at a glance whether our failure was in the
> compilation or testing, whether that's via human eyes or improve
> machine readability.
> 
> We also need to run our new "ci/check-unignored-build-artifacts.sh" on
> success() in the CI now, just like we already had a step conditional
> on failure() running ci/print-test-failures.sh.
> 
> The reason we used a "ci/run-build-and-tests.sh" wrapper in the first
> place had to do with Travis CI-specific constraints that no longer
> apply to us, as the Travis CI support has been removed.
> 
> Instead we can configure the CI in an earlier step by running
> "ci/lib.sh", which under GitHub CI will write the environment
> variables we need to the "$GITHUB_ENV" file.
> 
> We'll then have access to them in subsequent steps, and crucially
> those variables will be prominently visible at the start of each step
> via an expandable drop-down in the UI.drop-do.
> 
> I.e. this changes the CI run from a top-down flow like (pseudocode):
> 
>   - job:
>     - step1:
>       - use ci/lib.sh to set env vars
>       - run a script like ci/run-build-and-tests.sh
>     - step2:
>       - if: failure()
>       - use ci/lib.sh to set env vars
>       - run ci/print-test-failures.sh
> 
> To:
> 
>   - job:
>     - step1:
>       - set variables in $GITHUB_ENV using ci/lib.sh
>     - step2:
>       - make
>     - step3:
>       - make test
>     - step4:
>       - if: failure()
>       - run ci/print-test-failures.sh
>     - step5:
>       - if: success()
>       - run ci/check-unignored-build-artifacts.sh
> 
> There is a proposal[2] to get some of the benefits of this approach by
> not re-arranging our variable setup in this way, but to instead use
> the GitHub CI grouping syntax to focus on the relevant parts of "make"
> or "make test" when we have failures.
> 
> Doing it this way makes for better looking GitHub CI UI, and lays much
> better ground work for our CI going forward. Because:
> 
>   * The CI logic will be more portable to a future CI system, since a
>     common feature of them is to run various commands in sequence, but
>     a future system won't necessarily support the GitHub-specifics
>     syntax of "grouping" output within a "step".
> 
>     Even if those systems don't support a "$GITHUB_ENV" emulating will
>     be much easier than to deal with some CI-specific grouping syntax.
> 
>   * At the start of every step the GitHub CI presents an expandable
>     list of environment variables from "$GITHUB_ENV". We'll now see
>     exactly what variables affected that step (although we currently
>     overshoot that a bit, and always define all variables).
> 
>   * CI failures will be easier to reproduce locally, as this makes the
>     relevant ci/* scripts something that sets up our environment, but
>     leaves "make" and "make test" working as they do locally.
> 
>     To reproduce a run the user only needs to set the variables
>     discussed in the drop-down above, either manually or by running
>     "ci/lib.sh".
> 
>   * The output will be less verbose. The "ci/lib.sh" script uses "set
>     -x", and before this e.g. "ci/static-analysis.sh" would start with
>     40 lines of trace output, culminating in using "export" to export
>     the relevant environment variables.
> 
>     Now that verbosity is in the earlier "ci/lib.sh" step, and not in
>     any subsequent one. The "make" targets then start out with the
>     relevant output non-trace output right away.

s/output non-trace output/non-trace output/

>   * If we do want to use the grouping syntax within a "step" it'll now
>     be easier to do so. It doesn't support nesting, so we'd have to
>     make a choice between using it for e.g. "make" v.s. "make test", or
>     individual test failures. See "sadly" in [3].
> 
> 1. https://lore.kernel.org/git/211120.86k0h30zuw.gmgdl@evledraar.gmail.com/
> 2. https://lore.kernel.org/git/pull.1117.git.1643050574.gitgitgadget@gmail.com/
> 3. https://lore.kernel.org/git/9333ba781b8240f704e739b00d274f8c3d887e39.1643050574.git.gitgitgadget@gmail.com/
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

