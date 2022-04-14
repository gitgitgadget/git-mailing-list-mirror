Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5907FC433F5
	for <git@archiver.kernel.org>; Thu, 14 Apr 2022 06:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239993AbiDNGVe convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 14 Apr 2022 02:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiDNGVc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Apr 2022 02:21:32 -0400
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6AD4A3D5
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 23:19:07 -0700 (PDT)
Received: by mail-pf1-f179.google.com with SMTP id bo5so3989445pfb.4
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 23:19:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qUnnaQ5Q5xb561p4sOgv0r7uMkwAZcK8zEce/Ur6Q9U=;
        b=hD5H+wM2uawmWX0gi0ufA81YvYzjF0c3dSHvPw/SBybZl2cGrG3WpaY+1QcknhtwwN
         OtWzfHRX/CQz7ahxc9ZDNLVdykON+dArPXJ05ujClwVyV7qs3gMcDFBHrmT3ucQsTJ9g
         XYPcZ8oat25nWZPOhjboCQx3DnuJVJNg/gOlTLuiSAOZlDIQZ+6hKmXBidZk3K7gUG5f
         i2w6+U+4x9doQynivfZdnLKNRfx+6K59AtDYUsxAOkRw6woh/zjj0/3BYTlTsJqk3hzg
         LfwWsQT4H7JaJsnaAwc/HLo51SKbq3qG6ll+PRmWrD/UYJUco+xty6NRIsTLgEuAT/tj
         qcrQ==
X-Gm-Message-State: AOAM532Ix/PPihYlvG3MDpS2pQ+yOYB08J5AtW/HxNDOd88/FcmqE5xK
        JQ/aDQaKra8DByWgV9LKsbvPv1yvYa0vxH2EiXM=
X-Google-Smtp-Source: ABdhPJyU2DPZK3+GPGdE4xDyxRi5oOE4e76hF6kypUQFZ3qV1xfy7iV8rEJnHZryzgsESc/zBcp4yG5L04yXEfmevl8=
X-Received: by 2002:a65:6045:0:b0:399:3a5e:e25a with SMTP id
 a5-20020a656045000000b003993a5ee25amr1047650pgp.139.1649917147136; Wed, 13
 Apr 2022 23:19:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
 <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com> <patch-v3-03.29-820c4e551d9-20220413T194847Z-avarab@gmail.com>
In-Reply-To: <patch-v3-03.29-820c4e551d9-20220413T194847Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 14 Apr 2022 02:18:56 -0400
Message-ID: <CAPig+cTP937Gr1acUuiot0Ra9M6RbrQuBDbdeeJeQAtf_oxeaw@mail.gmail.com>
Subject: Re: [PATCH v3 03/29] CI: remove more dead Travis CI support
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 13, 2022 at 5:13 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> Remove code that I missed in 4a6e4b96026 (CI: remove Travis CI
> support, 2021-11-23). This code was only called from or used by the
> now-removed .travis.yml, or needed by the Travis CI environment.
>
> For the symlinking in ci/run-build-and-tests.sh: Back when
> 3c93b829205 (travis-ci: build Git during the 'script' phase,
> 2018-01-08) and 4b060a4d973 (ci: use a junction on Windows instead of
> a symlink, 2019-01-27) adjusted this "ln" command, the Windows build
> would use ci/run-build-and-tests.sh.
>
> As seen in 889cacb6897 (ci: configure GitHub Actions for CI/PR,
> 2020-04-11) the current windows build uses a different entry point
> under the GitHub CI, which doesn't use this .prove caching. Namely
> "ci/run-test-slice.sh".
>
> We can be certain that it's never used in "ci/run-test-slice.sh"
> because to have a ".prove" file we'd need to use "--state=save", which
> we only do in the dead Azure codepath in ci/lib.sh. If it were used it
> would do the wrong thing, because the different test slices would each
> try to clobber the same "t/.prove" file.
>
> If a subsequent run then used the -"-state=failed,slow,save" it would

s/-"-/--"/

> defeat the purpose of "ci/run-test-slice.sh", since all slices would
> then run all tests. I.e. behavior of prove's "--state" options is to
> select tests to run from the provided "--state" file, in addition to
> those specified on the command-line.
>
> For ci/run-docker{,-build}.sh: It was likewise last referenced in the
> .travis.yml removed in my 4a6e4b96026. The current "dockerized" run in
> ".github/workflows/main.yml" calls the same entry points as the main
> "regular" job.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
