Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC56C54FCB
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 21:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2D6220781
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 21:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="UdXYJCck"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgDXVo2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 17:44:28 -0400
Received: from mout.gmx.net ([212.227.17.20]:51235 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbgDXVo2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 17:44:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587764665;
        bh=riyH5RwS+3YGGBuqIiQXg7mbDJt0+CjGRED4uSpi6w0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=UdXYJCck0uWGmuGrOh5WDt4BS7O17SGVyieyEUDmwNb7/ij3UxAqbyPLFhECMKWhL
         ZmSLD/mQ98EgjS5vsqTlb5/kJcdiblZzItog4PnrxvMx5gQDMzYyk8wQKCzqnuibjv
         8EO4lzFBYyRhz0WeVAl8wsJm7/jWP2o2cM66UaFk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([213.196.212.1]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MfHEJ-1iymqA1dOt-00glAW; Fri, 24 Apr 2020 23:44:25 +0200
Date:   Fri, 24 Apr 2020 23:44:22 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Danh Doan <congdanhqx@gmail.com>
cc:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Subject: Re: [PATCH 8/8] ci: modification of main.yml to use cmake for vs-build
 job
In-Reply-To: <20200424174544.GN1949@danh.dev>
Message-ID: <nycvar.QRO.7.76.6.2004242335100.18039@tvgsbejvaqbjf.bet>
References: <pull.614.git.1587700897.gitgitgadget@gmail.com> <f0294be3f1151526fe002a55fb79015bd35606b2.1587700897.git.gitgitgadget@gmail.com> <20200424174544.GN1949@danh.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:s3cYst6iO7rgevLcVHv8PFCjaJFOSlE0cKIT9XYFAIWcsTsHd2H
 VnGJlkk7K4vL3UnOUuSQBOmTrDnAJnHU66leR9qZg6zB4SFkpK55Zafyy8xw297AHja1RBz
 OtzB6spzDdmpnEmoMKfEJg6dcBwYaKLgm61LhSDyr6eO73aWdaoOT66xivYbhA55m9EUruU
 lo6tTSrDFtg1zNtPChe2Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0Mryqg4szzw=:ArLTBFVBa+j0Rp5wMPx/C4
 dvxKkm9aT8NxBLoO0UskIzXlX0ZxP0CdYdC5OE9QyyvA5hoiXezj36WCZf7H3yeA/Z1zgKyeq
 ZVLlS5eN0r/NUEt8XXVn4T/dfq0IRL2nLsa5t9GxOCLQ6YHx8HVxqgQgFj+A0Y5FaU9AnjxDB
 oDyy9Z4R/dLzFqBOePTKTlxa/2jm/IdnB874PUC+MP6mGqAu1mLWvBP/oGoi8BvsNKZeCozG+
 VNeXyqhMKqajuZolO6MlQ19djV0k0CSRitUtcuO3hbE7MWPCWBoDVL4aJcArHzREc9fZZzk/C
 657r/J4lt8lrYTliPyNrS6iNt0cMkcZ4CF9RsyYbWx/uXbSiJgyej1asnUfOfJqxD+0MLMRqa
 7NRkndKSCp9dTUGOHJDRO70SjIOwieC5Kgk+QvQm56+Ff0sxZAvVc2TjbqaHuWw2kXx6kw4bu
 7Q8rRniudBG+ixspftsNxfoHwJbTIVnGg3cVFifu5qfrsM9JuhBdaUD+DUNvTJRIsAdnm8bOf
 QyjCrsaAPVwWWVio6w6+FsMb0gqI3vVNCuVfF8npnJdVF7CNXkDdnjbj8sD88nwyEW7d7hEkL
 iM/0Za1P4z0R8m5y5Ep0LSnB3osb/SvIL6j6B2l7MtrsDumN4hM+KZ+5e3hGBBc7+od38VrGj
 kycs5/5uj6A5+kLGoXGB10RN3bx/6V3WKiJsqGn0lcz8Pa60BKqwDkFdt84LzWhgBu7IF1CVw
 XVv86ueAr1q5/DWJUCYPbjhvu+3hnMO5gpI1BG2YQyEK1IuGPQcpXPbeMBOBiWzH+xv+WLIa1
 cXHug+u4fkeKWF3kodep4UTrM5TzZwacI0NU4kTbsBfphxm0oF70JsmxbsrfaYLW0SxrWvReK
 R8tSwgEcT5MP1+H/smpVmkp5QFCEJH8fv5t1MPjeWui8iLS++Lp0Gk7S/Hya2IhFgnoXsEfyF
 Ytc2wZPMKrm2r1F+9RNFeog4hCDHzWAGpSuqdAiXuhGArUFPC2nyowZplwcweNo583lbFFX4h
 DTpQldEmd9+Dedh4Zk2Yyc/LL8HhKh5x3Y7BQtqDW6xkqQZxJd1H8OiHj7r+WOcvOPrezy8FP
 qRU4IdAZHqcTO3D17O6FCwhdduGf1uPKgIAyKs2Jt2naTQvPqGUayYm9xVeSOVqY3+hoyo7+h
 m5FT5Pf/IWuhGg/Ken2VHIgh38r2GanvNiaIS+8u3OJP0vjEdF5rgkBYN56zaX/6Uk/tybhqn
 l0j0tDmmTHBvlXnLZ
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Danh,

On Sat, 25 Apr 2020, Danh Doan wrote:

> On 2020-04-24 04:01:37+0000, Sibi Siddharthan via GitGitGadget <gitgitga=
dget@gmail.com> wrote:
> > From: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
> >
> > @@ -98,6 +91,13 @@ jobs:
> >          Remove-Item compat.zip
> >      - name: add msbuild to PATH
> >        uses: microsoft/setup-msbuild@v1.0.0
> > +    - name: generate Visual Studio solution
> > +      shell: powershell
> > +      run: |
> > +        & .\git-sdk-64-minimal\usr\bin\bash.exe -lc @"
> > +          cmake . -DCMAKE_PREFIX_PATH=3D./compat/vcbuild/vcpkg/instal=
led/x64-windows -DMSGFMT_EXE=3D./git-sdk-64-minimal/mingw64/bin/msgfmt.exe=
 -DPERL_TESTS=3DOFF -DPYTHON_TESTS=3DOFF -DCURL_NO_CURL_CMAKE=3DON
> > +        "@
> > +        if (!$?) { exit(1) }
>
> If you intended to modified some steps to provide a better script for
> that step, I believe you should change in that step.
>
> If the order of those steps need to be changed, please clarify your
> reasoning!

It is the order that needs to be changed, indeed: The CMake step requires
the vcpkg artifacts (i.e. pre-built dependencies like curl), whereas the
previous `make vcxproj` did not require them.

And yes, that's good material for the commit message!

> >      - name: MSBuild
> >        run: msbuild git.sln -property:Configuration=3DRelease -propert=
y:Platform=3Dx64 -maxCpuCount:4 -property:PlatformToolset=3Dv142
> >      - name: bundle artifact tar
> > @@ -125,9 +125,9 @@ jobs:
> >          nr: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
> >      steps:
> >      - uses: actions/checkout@v1
> > -    - name: download git-64-portable
> > +    - name: download git-sdk-64-minimal
> >        shell: bash
> > -      run: a=3Dgit-64-portable && mkdir -p $a && curl -# https://wing=
it.blob.core.windows.net/ci-artifacts/$a.tar.xz | tar -C $a -xJf -
> > +      run: a=3Dgit-sdk-64-minimal && mkdir -p $a && curl -# https://w=
ingit.blob.core.windows.net/ci-artifacts/$a.tar.xz | tar -C $a -xJf -
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

No need to worry, it's still parallel.

The reason why it looks incorrect is that Sibi used the `windows-test` job
as an example rather than the `vs-test` one. For that reason, it is the
full `git-sdk-64-minimal` rather than the portable Git in which the tests
are run.

I would prefer to re-revert this again, to use the `(parallel)` and the
`git-64-portable` again.

> He even tried to re-order the matrix in GfW project to let longest
> test run first!

I did! And it was quite a bit of manual work because the times are not
really obvious from the logs, you have to script something to get at them.
In the end, it was not worth the effort, as the overall runtime was only
minimally faster, and I did not like how the order could become stale and
less helpful over time.

> >        shell: powershell
> >        env:
> >          MSYSTEM: MINGW64
> >          NO_SVN_TESTS: 1
> >          GIT_TEST_SKIP_REBASE_P: 1
> >        run: |
> > -        & git-64-portable\git-cmd.exe --command=3Dusr\bin\bash.exe -l=
c @"
> > -          # Let Git ignore the SDK and the test-cache
> > -          printf '%s\n' /git-64-portable/ /test-cache/ >>.git/info/ex=
clude
> > +        & .\git-sdk-64-minimal\usr\bin\bash.exe -lc @"
> > +          # Let Git ignore the SDK
> > +          printf '%s\n' /git-sdk-64-minimal/ >>.git/info/exclude
> >
> > -          cd t &&
> > -          PATH=3D\"`$PWD/helper:`$PATH\" &&
> > -          test-tool.exe run-command testsuite --jobs=3D10 -V -x --wri=
te-junit-xml \
> > -                  `$(test-tool.exe path-utils slice-tests \
> > -                          ${{matrix.nr}} 10 t[0-9]*.sh)
> > +          ci/run-test-slice.sh ${{matrix.nr}} 10
> >          "@
> > +    - name: ci/print-test-failures.sh
> > +      if: failure()
> > +      shell: powershell
> > +      run: |
> > +        & .\git-sdk-64-minimal\usr\bin\bash.exe -lc ci/print-test-fai=
lures.sh
>
> What is changed?

This also is a consequence of copy/editing the `windows-test` job instead
of the `vs-test` one: The portable Git does not bring enough stuff to run
`prove`, therefore we have to "roll our own runner" here.

Unless we use the substantially larger `git-sdk-64-minimal`. But the idea
here _was_ to test in as similar a fashion to developers on Windows: they
would not want to download the full Git for Windows SDK, but run the test
in the Bash of a regular Git for Windows instead.

Indeed, you could say that in a way, this entire patch series is about
trying to make it unnecessary for developers on Windows to download more
than 500MB just to start tinkering with the Git source code.

Or maybe the patch series is about more than just that, but that alone
would be reason enough to want it. And I think we do want it.

Ciao,
Dscho
