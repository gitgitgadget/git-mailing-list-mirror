Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FE1CCA47C
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 13:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbiFBNgA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 09:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235406AbiFBNf5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 09:35:57 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8B46FA02
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 06:35:56 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id d3so3392562ilr.10
        for <git@vger.kernel.org>; Thu, 02 Jun 2022 06:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Zpu51Z3qHofI76RN9hKIQ1qgMrx2S3MJEnTGHFcQMvQ=;
        b=gE2TMHKZuPAj7EmWtDCw2Wzz24BnXFjXddYLQZYdsomwkQU7ReTneedlhkAQTpnWrk
         /EFomhmdmZJQYe2YxhMQb96jO3NkfgHfFfg07NIsDmmarGEfU0CVQ2bmoiPjKDGBsW9c
         DqLVO1qsIrtOUJvalOujfYfXHpjfg8NoZQUhSb7Pz0BgHDugZ5dyWm4ZPHKbDjCWLgrD
         mvEwYiSXU+vuLtPQ8XAXDZ5LCmvD+w7IXEQiY3e6X0LY0oAgqaPpDAwr+qYx2J5DqxTn
         VUMAxKzN7iHBt83v6JIQCfVUExdeoB0FnnEqJvQhJkV1+r4JvdRR6b/CRbc//o5755jv
         +E3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Zpu51Z3qHofI76RN9hKIQ1qgMrx2S3MJEnTGHFcQMvQ=;
        b=1DIe4D6L+OrX+sUTw1/SorUz8VqceTSzvo5D1PqD2Qva5F7fJSrb6uyGceUEXCuKC2
         EIfE5LaCTjrw61PJrhyRArFhNvNGiM50tt+8LfqHtQwcUsPL0uA2wqm1OfOymHjyTaeJ
         mEYdyzYt4EFjnqgsD07EUid+QlbNqsswSo/4cm0GrGm/v47Y4yaFKNse5O77WZkdMaZS
         8m1VaqC8zAJVRQ601RKf1Fp0wT4Y6j6L0GsyXEOi+f4zRz7n1HPf+oOS70303tMivXxZ
         MlU+hJt38DsGNgyX/3Pn/UJvoVkuep/Oj/6FL9qEpdzLzkhEyJ2CZzJwg1I3qGcvXHF2
         KzwA==
X-Gm-Message-State: AOAM530ZZwQx8BKsm0O7brgrZ2aEDaBiialM2E/A59tYyHzmxxpB0NzL
        fNbwvtKn/nlXAzFs8z+3VnyJqq1vosOu
X-Google-Smtp-Source: ABdhPJz/lDDXLaFOmKo5NQR8vQHULNEKSVthDAGlN3ZexolgKgNmu8YNFlR6sTsEOOD+kq1GBC5E1A==
X-Received: by 2002:a92:ddcb:0:b0:2cd:95b6:bede with SMTP id d11-20020a92ddcb000000b002cd95b6bedemr3074234ilr.280.1654176955976;
        Thu, 02 Jun 2022 06:35:55 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:9cc9:fda3:3ddf:6700? ([2600:1700:e72:80a0:9cc9:fda3:3ddf:6700])
        by smtp.gmail.com with ESMTPSA id g10-20020a02a08a000000b003314eada5b9sm1200095jah.14.2022.06.02.06.35.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 06:35:55 -0700 (PDT)
Message-ID: <3c6d4a5c-8b39-8771-f578-0ea3c5b57869@github.com>
Date:   Thu, 2 Jun 2022 09:35:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/2] ci: also run the `scalar` tests
Content-Language: en-US
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1129.git.1654160735.gitgitgadget@gmail.com>
 <6ad0d3d401da7787d0e7afb3f804b705731bf2dd.1654160735.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <6ad0d3d401da7787d0e7afb3f804b705731bf2dd.1654160735.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/2/2022 5:05 AM, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> Since Scalar depends on `libgit.a`, it makes sense to ensure in the CI
> and the PR builds that it does not get broken in case of industrious
> refactorings of the core Git code (speaking from experience here).
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  .github/workflows/main.yml | 15 +++++++++++++++
>  ci/run-build-and-tests.sh  |  2 ++
>  ci/run-test-slice.sh       |  5 +++++
>  3 files changed, 22 insertions(+)
> 
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index c35200defb9..785222aa7b3 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -91,6 +91,13 @@ jobs:
>          HOME: ${{runner.workspace}}
>          NO_PERL: 1
>        run: . /etc/profile && ci/make-test-artifacts.sh artifacts
> +    - name: build Scalar
> +      shell: bash
> +      run: |
> +        make -C contrib/scalar &&
> +        mkdir -p artifacts/bin-wrappers artifacts/contrib/scalar &&
> +        cp contrib/scalar/scalar.exe artifacts/contrib/scalar/ &&
> +        cp bin-wrappers/scalar artifacts/bin-wrappers/

I see later you have a "copy Scalar" step which has some duplication
here. The only difference is that you have "make -C contrib/scalar".

Doesn't Scalar get built in our basic "make" build when the
environment includes INCLUDE_SCALAR=YesPlease? So, for that reason I
expected the environment to change, but not need this "make -C ..."

>      - name: zip up tracked files
>        run: git archive -o artifacts/tracked.tar.gz HEAD
>      - name: upload tracked files and build artifacts
> @@ -161,6 +168,8 @@ jobs:
>        run: compat\vcbuild\vcpkg_copy_dlls.bat release
>      - name: generate Visual Studio solution
>        shell: bash
> +      env:
> +        INCLUDE_SCALAR: YesPlease

This is a bit isolated. Is there a way to specify the environment
more generally?

>        run: |
>          cmake `pwd`/contrib/buildsystems/ -DCMAKE_PREFIX_PATH=`pwd`/compat/vcbuild/vcpkg/installed/x64-windows \
>          -DNO_GETTEXT=YesPlease -DPERL_TESTS=OFF -DPYTHON_TESTS=OFF -DCURL_NO_CURL_CMAKE=ON
> @@ -174,6 +183,12 @@ jobs:
>        run: |
>          mkdir -p artifacts &&
>          eval "$(make -n artifacts-tar INCLUDE_DLLS_IN_ARTIFACTS=YesPlease ARTIFACTS_DIRECTORY=artifacts NO_GETTEXT=YesPlease 2>&1 | grep ^tar)"
> +    - name: copy Scalar
> +      shell: bash
> +      run: |
> +        mkdir -p artifacts/bin-wrappers artifacts/contrib/scalar &&
> +        cp contrib/scalar/scalar.exe artifacts/contrib/scalar/ &&
> +        cp bin-wrappers/scalar artifacts/bin-wrappers/
>      - name: zip up tracked files
>        run: git archive -o artifacts/tracked.tar.gz HEAD
>      - name: upload tracked files and build artifacts
> diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> index 280dda7d285..661edb85d1b 100755
> --- a/ci/run-build-and-tests.sh
> +++ b/ci/run-build-and-tests.sh
> @@ -51,4 +51,6 @@ esac
>  make $MAKE_TARGETS
>  check_unignored_build_artifacts
>  
> +make -C contrib/scalar $MAKE_TARGETS
> +

Again, this should "just work" when using INCLUDE_SCALAR in the
environment, right?

>  save_good_tree
> diff --git a/ci/run-test-slice.sh b/ci/run-test-slice.sh
> index f8c2c3106a2..b741fd8f361 100755
> --- a/ci/run-test-slice.sh
> +++ b/ci/run-test-slice.sh
> @@ -14,4 +14,9 @@ make --quiet -C t T="$(cd t &&
>  	./helper/test-tool path-utils slice-tests "$1" "$2" t[0-9]*.sh |
>  	tr '\n' ' ')"
>  
> +if test 0 = "$1"
> +then
> +	make -C contrib/scalar test
> +fi
> +

This is still necessary for now.

Thanks,
-Stolee
