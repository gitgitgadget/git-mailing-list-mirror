Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A784EC2D0E4
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 15:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C2512083E
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 15:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="A40s2R4r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730712AbgKQPVk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 10:21:40 -0500
Received: from mout.gmx.net ([212.227.17.21]:52585 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730553AbgKQPVj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 10:21:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605626494;
        bh=sop1AOf0RUdAqvpPqxZHyzqB/t7V2htr4bjofTJyFBk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=A40s2R4rALjnNVJpmrG7O1l4RO/dUhj73XM+8wb91YR1mhCo7gZ/hgYeRHU16a4Nz
         hU1a2cCwIy83jVDwAWIZYua5Y4p/tk+iRF8yHJEyMQpXzlQphLwRHKthrZJU1vmbzr
         ryODrW2YZRz7j35sV/aIZBl665dl3yKj/RoWkXLg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.61]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MtOGU-1kPyz22p8Y-00uuBy; Tue, 17
 Nov 2020 16:21:34 +0100
Date:   Tue, 17 Nov 2020 16:21:33 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, "Chris. Webster" <chris@webstech.net>
Subject: Re: [PATCH] ci: avoid using the deprecated `set-env` construct
In-Reply-To: <xmqq8sb07bfa.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2011171620180.18437@tvgsbejvaqbjf.bet>
References: <pull.781.git.1604712106219.gitgitgadget@gmail.com> <xmqq8sb07bfa.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:V1+Hgt16sXnJeWTDy2xLpt8bSNermBG2Ufr35JEzWwQCPwiqMs8
 y89dSVzXKFEyB8CW5BQaef1s8NlxnK5XnuRxr+piky+GxJvjXB/ql6Y8cA4wGFok49e6u5G
 YgW8NIIHalUijvrRB94a0va71Iiow1dwvnwpFvmpzrqEDAuQonisYrzBojDXd/HP82s3UXM
 NaJ/2hCgfjs6mm27R1Myg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LmMCjX9blDw=:WUHM47AEjTlm+TIphUmQd3
 Mj45yrK/fRJ1W/KNkWRJv2HysekVy5NPhI6o6ZKzgC4BbG9YBtFhLHNEasqOCjIdccsAzVZr3
 Ptoxyq0Impw3S4r+SLAuElCWhzOA72Dz+7MNToVxyXzfOUo87J0AWv+V9yvVL8jqJaf3xJ32I
 yu0KYRFEnRB8es+qeDxGEyNFlkFCgIN0ttJ5urq3jyjd4dlhnkH3NEpQAGdL9lukgW1EQ3sCo
 KFENdmVY8IJh/257NK19Kzo0Vyh3gqENNPJBOg6CMmTjnqgQHn/DGe+gkV4mtk4bhqzHGXZ/J
 xU1xbE0J7mx1hIohDNkB6azT49FBQp37o1LziesPf5k8NK9yRwnNohbqG7sGF7eUGBhKVcx52
 bq24FlcMkckuxEr5RUwEXLHFiApWJEHundshygHO6NtTHVKSHSW0Mx6ta9I/KywAnpal/L2nS
 pam26O0GCL8FArQr4d1rOoPB4/6k5ZZZ8q8rWGxx3z8OjB5WUXhqn6Y/BIm9pHJRw4JD80l/B
 +cmsEo0Te/npDFqDP4R/myJRQB2rvR2DQzlGtWY3vSZXeSiluHJTtZWPuUy6pjD37DZyVvmXY
 zxPOIAmDj3AncBw0fTR71H8lmzVdgwtaSVffD/ZLaob2nYOpRZjLdK2MWWgbCnDfkD+TZMd7a
 5mwYcZ99zXUTjsvQpXlSQxBykFqr63CXNNDgw/6ew+F12Z8rQpYTldO0guiB7M+UH6MktfMHy
 Ntvkmkme8ezxtt5UjMN1uEdJuhZHYAhXYBjLdvnJ3t7J5TryJ6TaVHfI4unaO/iT8565QsGYB
 EpfvbMME/kbyNxfl06nhJrTq7E1eKhrIiTEqnRhG4mkdNjpqKXh0H3VWMbanAxKfdH7N1Brm0
 WArsypy6U5jb3u9irSBRbx8aNR9QGYDaTCpDlckAI=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 16 Nov 2020, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > The `set-env` construct was deprecated as of the announcement in
> > https://github.blog/changelog/2020-10-01-github-actions-deprecating-se=
t-env-and-add-path-commands/
> > ...
> > diff --git a/.github/workflows/check-whitespace.yml b/.github/workflow=
s/check-whitespace.yml
> > index 9d070b9cdf..c74b47de9e 100644
> > --- a/.github/workflows/check-whitespace.yml
> > +++ b/.github/workflows/check-whitespace.yml
> > @@ -14,7 +14,7 @@ jobs:
> >      steps:
> >      - name: Set commit count
> >        shell: bash
> > -      run: echo "::set-env name=3DCOMMIT_DEPTH::$((1+$COMMITS))"
> > +      run: echo "COMMIT_DEPTH=3D$((1+$COMMITS))" >>$GITHUB_ENV
> >        env:
> >          COMMITS: ${{ github.event.pull_request.commits }}
>
> Do we need something similar for ci/print-test-failures.sh to
> prevent failures like https://github.com/git/git/runs/1409815807?
>
> Perhaps like the following (which is copied-and-pasted without
> understanding what is going on or without doing nothing more than
> skimming [*1*])?

Yes, of course, this precisely what we need.

Sorry for not even _thinking_ about `git grep set-env`. This seems the
only remaining use of that construct in our workflows, though.

Thanks,
Dscho

>
>
> Reference
>
> *1* https://docs.github.com/en/free-pro-team@latest/actions/reference/wo=
rkflow-commands-for-github-actions#setting-an-environment-variable
>
>
>  ci/print-test-failures.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git c/ci/print-test-failures.sh w/ci/print-test-failures.sh
> index 92a983a265..c70d6cdbf2 100755
> --- c/ci/print-test-failures.sh
> +++ w/ci/print-test-failures.sh
> @@ -48,7 +48,7 @@ do
>  			;;
>  		github-actions)
>  			mkdir -p failed-test-artifacts
> -			echo "::set-env name=3DFAILED_TEST_ARTIFACTS::t/failed-test-artifact=
s"
> +			echo "FAILED_TEST_ARTIFACTS=3Dt/failed-test-artifacts" >>$GITHUB_ENV
>  			cp "${TEST_EXIT%.exit}.out" failed-test-artifacts/
>  			tar czf failed-test-artifacts/"$test_name".trash.tar.gz "$trash_dir"
>  			continue
>
>
