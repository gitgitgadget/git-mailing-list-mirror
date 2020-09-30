Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB61C4727C
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 19:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D31720709
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 19:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Gk/nAJnF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbgI3TSC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 15:18:02 -0400
Received: from mout.gmx.net ([212.227.15.18]:54687 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728270AbgI3TSC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 15:18:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601493478;
        bh=3TPt8iSKYUeO4+HHUFhqH40/SgcDhpR5K4/kD2b2C30=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Gk/nAJnFzPK6XakSHvBkJ8WMqZX34SRW+tOvHSFt5FCL+4BgUQ89JlM4uchySDdtz
         TPIiNtSAwn1wuJ+uAkU9nlnuKHoTfAlIybugrts09LHoLGvLxKGWyALEr4GsE4b3LX
         mMQI0QOZOeiP1KSOKGEVeCrvHG9jpTY9hr0OXYsU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.113.174] ([213.196.213.65]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgesQ-1ktROs1wRo-00h2cL; Wed, 30
 Sep 2020 21:17:58 +0200
Date:   Wed, 30 Sep 2020 21:17:56 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=98ystein_Walle?= <oystwa@gmail.com>
Subject: Re: [PATCH v4 08/10] cmake (Windows): initialize vcpkg/build
 dependencies automatically
In-Reply-To: <14ddfc17815d68f2f32aebbc4b0ecb3ce6f25dc1.1601479585.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2009302117220.50@tvgsbejvaqbjf.bet>
References: <pull.738.v3.git.1601327357.gitgitgadget@gmail.com>        <pull.738.v4.git.1601479585.gitgitgadget@gmail.com> <14ddfc17815d68f2f32aebbc4b0ecb3ce6f25dc1.1601479585.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:AAsuXx1HJI8KiEwz7ZVIeHfDPYm6oyvxXndymmbQsz4rv2AILcW
 0TOpDzW/dWpCCCedinYUwop6tJ1rK+tAndEDQpO7ZrExARnTL0INrgb+Lm/Lm/C8Xr6h8th
 UHyTijxyRT+ftUXPXAgh3q64pgCh7rTgtBLSyx8ia34mv5s0t2fUIB9jR03b2JmXkMH4HC3
 JuJgL3R2AEfSPC2/EtNyg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5VsaW+JzIag=:R40jkUVk8KUcd/cltXLvpY
 wOh8zKDO8QWmY7NUKDkf8O9yE7XvtkpQpKZ2nFCSO+paTekwZXjZU42EGaHr/hfLUsMXqKVLx
 T1sV6bq69B+AoBJTuVqPVxk5Jeo/jsO3+ZlXBz25eyBhJmt4Q6erfPT/6HwRAD7B9dB3ER57F
 K72bttZHk77XNeSlvOgdZ2H0otZRO2RAbuQufJyLMA2N2gDL1I8/dEo6f49HVjatapbhoSszL
 Wjs35+dPbZ8W5ZILhTisKF/CxYaapq0N7ThGhK1OSaOYYk0MfyiAuJbbbBhCzSFP5n2VFLOjs
 lQ0h24Xhe477C4HNUHkWrruzrjP0lfSl0vlQTbMhB4szgZS1NMX8AxlEh8nGsLh/nLpZvrpob
 mSRnfCICbFMnD72HA6optbnlnuzyPCWDEyJb2U7zEkUzMo3cSs5RLlXKC4IRReCydROlaOTDG
 wAZFQ8P6iUOyEkDgR0HikV1Ylvi7yhzNvO/FrMBu2YEYkcf1Eg98VXFMYYNJjbgA5VQd1ZDMD
 JlKBWc18XtQy/N6Xlqzn9TpUOPpT9gl9G+XDBVA6m/B9iXhcPKE+RYydoORIaN/SCUY9UzA+1
 I1EiMPnxy8erCmSIP7Duy8VKVrOpTIUb/TkF4pSvNPUbQm1N+EozAE477B79lNIr0c7TeRIg+
 N6V6pTehUDsbGxEzrHD6k1d2SdVQQ7T4G3coD0AIFnbGLidHaHTonHP8Ygb2uv0yhEERh8G+a
 tsg/PzNo1HZwf/ThJMC4QINCFkzZlNF+oYDhJrXGya8kvY5BBLqkTCq7v8pKSaKHcsvWpYohF
 s5Cv9GdOCtz3saNWoSeukJ+4ekupCASMKEHIu8e6sh4+luyT6bkQd2AhmG+Iv9bCoKxN9sbOA
 EKd04m7kFNmCUzjpJIdXnW8HpvrCCI2MDlqLfNfM/JqJrVmgzLEFQKaJAJog1+vDJb15yRM4k
 +ClwhaZeMrZlyhrfDDNlOvCG0fEouXJE0eJ0vKVVVzL/hxrmFdq/zaY8soZr5qftD/JR62Ag1
 Fzj+ZcWbnsjS14SKuBXlOTFaZSiwNQJCqj0yLfAOE9FO6eN5LXrpKn8bSI8LYVxGIm/K+2SRj
 oLFSymHbilW0XqzBLoOghyMnN9X8qfOB40Rc5OU983XQlfJ0Njmxd70o86iZy4AY18WWyvGrO
 JERaRr5srwW8Pz9isGfDgmB+7Px0Kl0OC4cUAsN2gtx5GbeSNPAH5k/pMjJ18Kee+ESXtd50y
 +6zCWuubmU/RT55M/28C1H826Q0MTyIMjwp89eg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,


On Wed, 30 Sep 2020, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The idea of having CMake support in Git's source tree is to enable
> contributors on Windows to start contributing with little effort. To
> that end, we just added some sensible defaults that will let users open
> the worktree in Visual Studio and start building.
>
> This expects the dependencies (such as zlib) to be available already,
> though. If they are not available, we expect the user to run
> `compat/vcbuild/vcpkg_install.bat`.
>
> Rather than requiring this step to be manual, detect the situation and
> run it as part of the CMake configuration step.
>
> Note that this obviously only applies to the scenario when we want to
> compile in Visual Studio (i.e. with MS Visual C), not with GCC.
> Therefore, we guard this new code block behind the `MSVC` conditional.
>
> This concludes our journey to make it as effortless as possible to start
> developing Git in Visual Studio: all the developer needs to do is to
> clone Git's repository, open the worktree via `File>Open>Folder...` and
> wait for CMake to finish configuring.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> squash! cmake (Windows): initialize vcpkg/build dependencies automatical=
ly
>
> MSVC

Aaargh! This was of course meant to be deleted after rewording the commit
message :-(

Sorry about that,
Dscho

> ---
>  contrib/buildsystems/CMakeLists.txt | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/=
CMakeLists.txt
> index 78b90abe5e..ebadae2271 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -42,6 +42,10 @@ cmake_minimum_required(VERSION 3.14)
>  set(CMAKE_SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/../..)
>  if(WIN32)
>  	set(VCPKG_DIR "${CMAKE_SOURCE_DIR}/compat/vcbuild/vcpkg")
> +	if(MSVC AND NOT EXISTS ${VCPKG_DIR})
> +		message("Initializing vcpkg and building the Git's dependencies (this=
 will take a while...)")
> +		execute_process(COMMAND ${CMAKE_SOURCE_DIR}/compat/vcbuild/vcpkg_inst=
all.bat)
> +	endif()
>  	list(APPEND CMAKE_PREFIX_PATH "${VCPKG_DIR}/installed/x64-windows")
>
>  	# In the vcpkg edition, we need this to be able to link to libcurl
> --
> gitgitgadget
>
>
>
