Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEA4C54FD0
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 21:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD24A20644
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 21:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfoM6USn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbgDXVmJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 17:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgDXVmI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 17:42:08 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6905BC09B049
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 14:42:08 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b62so11796107qkf.6
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 14:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dfwhJWCxf31y9NoOkD623p+wxYmXq4QNHF+8ZIVNPFg=;
        b=OfoM6USn5wyRcxpmXZRpAR4pdUGXXTPKtAD70Ph/aawMs18FITfYImvAatONC6kzP0
         JESUkXueosE9dCStKKHUZGOhjh937P/pWBlbIQ83GaPJYfMS9cXWLxv6oRjIbg7cmssB
         jf7EnkH3XiKRbYhcl7J9WuUQx8p+b9Fb3GW3WOX+l6CRuUB9zlfxjVhzJr6yaSwj3YWX
         Y5DXux39L8CdBuXBy2pQbt+NC7IslZzDg0tRpFSrhB9UUCkW616yraQIJ7qpSkpQiE+m
         I0XErGgQ/WKcreUbfQacGyMsP5tlB4Sm/tj+WW9zKDrzLAgw5Ij0x4ZRx9GmouXr1VgL
         c3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dfwhJWCxf31y9NoOkD623p+wxYmXq4QNHF+8ZIVNPFg=;
        b=q/3hSrixvRTZMNlQM3+GfRl0coW3SsgRbxh3TYR3pul6uDtT1iMvqIE2jN71YEMY4J
         2jaXf+fd/ldFjEDixOtrOkvlLTbxLlD/cYGjBni8EmYQ90PmRtTIWvRC4FLxdq73RxlZ
         0xmCN828Opo8GMNrvd9bdA7qJCorsA5yak0VEvIbQmVO6C85k9w5vBozEDOZWIWyYU2o
         /JMWGNJ8wvJpyUI5sJQihA1rv7ryQ58R3rNyXrWzdfKLgakO4kTuNwwg/GplmyeBCx+E
         HxJyt/ZSBzbUtq3CTQ9qeLvil5PqFaTQMu1pjii2CyvxwYURf6gIlJsopdFq8n0CfHkd
         96sw==
X-Gm-Message-State: AGi0Pub9bbNHMwMeA56LTBiU2L9GCLeUmeRcDuQdtI2UlP/yG1S750fm
        6B/SskxQIYP1sDuXb5XbuwLi2449ZxeLa4hWoVk=
X-Google-Smtp-Source: APiQypIRe+iFVs9bfHi71z2BIJ1nIaIqOT1i5V6tLOvvwOYDjamAfLIYni4LH399PMSqUNpE7Oj2hZVZaKbvW3o31k4=
X-Received: by 2002:a37:6c07:: with SMTP id h7mr11164259qkc.328.1587764527596;
 Fri, 24 Apr 2020 14:42:07 -0700 (PDT)
MIME-Version: 1.0
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
 <f0294be3f1151526fe002a55fb79015bd35606b2.1587700897.git.gitgitgadget@gmail.com>
 <20200424174544.GN1949@danh.dev>
In-Reply-To: <20200424174544.GN1949@danh.dev>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Sat, 25 Apr 2020 03:11:56 +0530
Message-ID: <CAKiG+9UNdasm_+zx_UhTvqdbiCDfE0TwFiC3SAO0B=njHbAa0A@mail.gmail.com>
Subject: Re: [PATCH 8/8] ci: modification of main.yml to use cmake for
 vs-build job
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 24, 2020 at 11:15 PM Danh Doan <congdanhqx@gmail.com> wrote:
>
> On 2020-04-24 04:01:37+0000, Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com> wrote:
> > From: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
> >
> > This patch modifies .github/workflows/main.yml to use CMake for
> > Visual Studio builds.
> >
> > Modified the vs-test step to match windows-test step. This speeds
> > up the vs-test. Calling git-cmd from powershell and then calling git-bash
> > to perform the tests slows things down(factor of about 6). So git-bash
> > is directly called from powershell to perform the tests using prove.
> >
> > NOTE: Since GitHub keeps the same directory for each job
> > (with respect to path) absolute paths are used in the bin-wrapper
> > scripts.
> >
> > GitHub has switched to CMake 3.17.1 which changed the behaviour of
> > FindCURL module. An extra definition (-DCURL_NO_CURL_CMAKE=ON) has been
> > added to revert to the old behaviour.
> >
> > Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
> > ---
> >  .github/workflows/main.yml | 43 ++++++++++++++++++++++----------------
> >  1 file changed, 25 insertions(+), 18 deletions(-)
> >
> > diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> > index fd4df939b50..94f9a385225 100644
> > --- a/.github/workflows/main.yml
> > +++ b/.github/workflows/main.yml
> > @@ -80,13 +80,6 @@ jobs:
> >      - name: download git-sdk-64-minimal
> >        shell: bash
> >        run: a=git-sdk-64-minimal && mkdir -p $a && curl -# https://wingit.blob.core.windows.net/ci-artifacts/$a.tar.xz | tar -C $a -xJf -
> > -    - name: generate Visual Studio solution
> > -      shell: powershell
> > -      run: |
> > -        & .\git-sdk-64-minimal\usr\bin\bash.exe -lc @"
> > -          make NDEBUG=1 DEVELOPER=1 vcxproj
> > -        "@
> > -        if (!$?) { exit(1) }
> >      - name: download vcpkg artifacts
> >        shell: powershell
> >        run: |
> > @@ -98,6 +91,13 @@ jobs:
> >          Remove-Item compat.zip
> >      - name: add msbuild to PATH
> >        uses: microsoft/setup-msbuild@v1.0.0
> > +    - name: generate Visual Studio solution
> > +      shell: powershell
> > +      run: |
> > +        & .\git-sdk-64-minimal\usr\bin\bash.exe -lc @"
> > +          cmake . -DCMAKE_PREFIX_PATH=./compat/vcbuild/vcpkg/installed/x64-windows -DMSGFMT_EXE=./git-sdk-64-minimal/mingw64/bin/msgfmt.exe -DPERL_TESTS=OFF -DPYTHON_TESTS=OFF -DCURL_NO_CURL_CMAKE=ON
> > +        "@
> > +        if (!$?) { exit(1) }
>
> If you intended to modified some steps to provide a better script for
> that step, I believe you should change in that step.
>
> If the order of those steps need to be changed, please clarify your
> reasoning!
>

Previously, the Visual Studio solution was generated, then the vcpkg
artifacts were downloaded.
With CMake, as it searched for the libraries during configure the
vcpkg artifacts are now downloaded before the configure step.

> >      - name: MSBuild
> >        run: msbuild git.sln -property:Configuration=Release -property:Platform=x64 -maxCpuCount:4 -property:PlatformToolset=v142
> >      - name: bundle artifact tar
> > @@ -125,9 +125,9 @@ jobs:
> >          nr: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
> >      steps:
> >      - uses: actions/checkout@v1
> > -    - name: download git-64-portable
> > +    - name: download git-sdk-64-minimal
> >        shell: bash
> > -      run: a=git-64-portable && mkdir -p $a && curl -# https://wingit.blob.core.windows.net/ci-artifacts/$a.tar.xz | tar -C $a -xJf -
> > +      run: a=git-sdk-64-minimal && mkdir -p $a && curl -# https://wingit.blob.core.windows.net/ci-artifacts/$a.tar.xz | tar -C $a -xJf -
> >      - name: download build artifacts
> >        uses: actions/download-artifact@v1
> >        with:
> > @@ -136,23 +136,30 @@ jobs:
> >      - name: extract build artifacts
> >        shell: bash
> >        run: tar xf artifacts.tar.gz
> > -    - name: test (parallel)
> > +    - name: test
>
> So the test couldn't be run in parallel anymore?
> It's a regression!
> And we don't need the matrix anymore!!!!!
>
> I wonder if Dscho's effort is wasted, he tried very hard to make
> those tests run in parallel.
> He even tried to re-order the matrix in GfW project to let longest
> test run first!
>
>

Okay, When I removed "(parallel)" does not mean that the tests are not
run in parallel.
Now they are run in the same way how windows-test(step) is run.
The tests(vs-test) actually completes before than the windows-test in the CI

> >        shell: powershell
> >        env:
> >          MSYSTEM: MINGW64
> >          NO_SVN_TESTS: 1
> >          GIT_TEST_SKIP_REBASE_P: 1
> >        run: |
> > -        & git-64-portable\git-cmd.exe --command=usr\bin\bash.exe -lc @"
> > -          # Let Git ignore the SDK and the test-cache
> > -          printf '%s\n' /git-64-portable/ /test-cache/ >>.git/info/exclude
> > +        & .\git-sdk-64-minimal\usr\bin\bash.exe -lc @"
> > +          # Let Git ignore the SDK
> > +          printf '%s\n' /git-sdk-64-minimal/ >>.git/info/exclude
> >
> > -          cd t &&
> > -          PATH=\"`$PWD/helper:`$PATH\" &&
> > -          test-tool.exe run-command testsuite --jobs=10 -V -x --write-junit-xml \
> > -                  `$(test-tool.exe path-utils slice-tests \
> > -                          ${{matrix.nr}} 10 t[0-9]*.sh)
> > +          ci/run-test-slice.sh ${{matrix.nr}} 10
> >          "@
> > +    - name: ci/print-test-failures.sh
> > +      if: failure()
> > +      shell: powershell
> > +      run: |
> > +        & .\git-sdk-64-minimal\usr\bin\bash.exe -lc ci/print-test-failures.sh
>
> What is changed?
>
> --
> Danh

Thank You,
Sibi Siddharthan
