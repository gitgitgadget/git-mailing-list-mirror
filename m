Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1008C5519F
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 11:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59FDC207D3
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 11:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="VbL7dn1m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgKRLtA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 06:49:00 -0500
Received: from mout.gmx.net ([212.227.17.20]:60079 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgKRLtA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 06:49:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605700134;
        bh=YRqLpgCfNf450pQWy/7CMVA37yejCzbw0VEoXMT9Cuw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=VbL7dn1mBs+DBNv+MpVlmMAs+FtwAOJREwx+7gRM0fasxI2SdSM42vD+ehMQ7IsSe
         b1wi6B+kaTZpFAU7yMK8+sbs7LlLovW0EENdOff4fRu9+KH9OIRN+gVylFlNLWpLQS
         MMVLWsTCEsOPbXQVvHi78ZAezovkPcvS9/hkScMY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.22.105] ([213.196.212.61]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8ofO-1kAGXY2DFm-015t18; Wed, 18
 Nov 2020 12:48:54 +0100
Date:   Wed, 18 Nov 2020 12:48:53 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, "Chris. Webster" <chris@webstech.net>
Subject: Re: [PATCH] ci: avoid using the deprecated `set-env` construct
In-Reply-To: <xmqq8saz68ro.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2011181248320.56@tvgsbejvaqbjf.bet>
References: <pull.781.git.1604712106219.gitgitgadget@gmail.com> <xmqq8sb07bfa.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2011171620180.18437@tvgsbejvaqbjf.bet> <xmqq8saz68ro.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Joirr9XlSG3fhKFyT+fUZsApKpry1Bc9fRYEHm+LE+do7UEeOO7
 qy6e+I2s+vuj0DCwcSA/Tb8ydmjtwKcj6x9TJ6PiIGuHfyHacdSu0FPAuT0NkCOs4br/e8d
 6eZJugaF4TSovnl0otzdj9cnUV5E7W77zm/cEh8erG00sjEW2kh4z9BtAkZ2DOLTocqjy14
 +XYvlkq4JIpeXUzk5xlqA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EwcQXM4UDog=:wvclS8v+aFQtZh7BxijPJ1
 WjK5TSexu7n0/kdTmATrCo7mkYyohL3FI3G2nrdvMWQAapuUA1fS3hb7a/6ueluyNGFFQgsEj
 1t/xO6UeCN3iLfxvd2V0AKlZdNRHDlG27F2fZzQ0il9h5zqAd1/Aq+hMF/gDUlRxheLQ3kawp
 g1lBzGepk35liM8CPz8iHXQXCLHTcNidI/cr26q0ETtkWpy5uGH0d2LWyzdOMt9GT5TA9vK+H
 w7pOL8u4zf8fpGvNB2movYBn9wX6ueIj5TGHstq5TD7m+PP/ZAAwBfqPkl0ygbusPc6hf6JVX
 HmDCHB3qoYxeX1R0rBgN0fz/hvsnOYuf3fjb5LurEHkK+L/3Uum56gcyA8BiPUy5ffqGELClf
 TCatbqBrBodf7PhEhhbU9t7P31W8SefymcSn3g9bGZFCSFgfu1VpAtwygjLT/gLT/JavTQUm6
 XWrn9kWpixpEPheuG9nuT+dC4GpJRL2PRYp3PrFYzVmQIDTXW1V5THvVp2GwnBl7vKcMZfaUk
 7nqeVd852OgQ4gBiRjp+jSROZgDP/EwUZexZv9CZWN/5j3+HJU6kyG2ktXJA6zr5nKr+rHeo5
 Kl7App+0OMb8x1wQwlh8TpJh6CqyLYP8xIdcuxbmlqrkvMo/fbgSZ6Za302xJF/RQZC4wQLcs
 a2SbxODmo9U1/m+8ZWakf+Cx4jPiqx5ZNU5DkMpy0p++k5Y+vkczQ+6OCUiO0MCr9CjDUoHxz
 RBuAYpSqepuqx4pEmAASkWdqekFB7o9bxs2YHjlCgGXZrXFN09Ox1OAb2vrbQfc7ZjaXn14qO
 Gtf5KwportWXyLTqLPpQGR5zmXkDea+ZKIHM/skm8YKM4fEuOyitPI2RWDAF1AVy4yB7UeINY
 n5bMfssd0SM7NrBYVqoxETyIQITTV5MSYYS3sKiMQ=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 17 Nov 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> Perhaps like the following (which is copied-and-pasted without
> >> understanding what is going on or without doing nothing more than
> >> skimming [*1*])?
> >
> > Yes, of course, this precisely what we need.
>
> Thanks.
>
> --- >8 ------ >8 ------ >8 --- cut here --- >8 ------ >8 ------ >8 ---
>
> Subject: [PATCH] ci: avoid `set-env` construct in print-test-failures.sh
>
> Imitating cac42e47 (ci: avoid using the deprecated `set-env`
> construct, 2020-11-07), avoid deprecated ::set-env and use the
> recommended alternative instead in print-test-failures.sh
>
> Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Thank you so much for tying up this loose end,
Dscho

> ---
>  ci/print-test-failures.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/ci/print-test-failures.sh b/ci/print-test-failures.sh
> index 92a983a265..c70d6cdbf2 100755
> --- a/ci/print-test-failures.sh
> +++ b/ci/print-test-failures.sh
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
> --
> 2.29.2-458-g8cf0a80384
>
>
