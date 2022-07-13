Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E11CC43334
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 13:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236120AbiGMN3z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 09:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbiGMN3v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 09:29:51 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D19924956
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657718981;
        bh=x53rulJZ2F8TsAPjgSecwQvvNRCjUtd4j/kZRSteVcU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=UXS7TWA2b9mQUu8Bkg0IRHWxvICT5GmJE/nBCJyk6upd67iBvtGv7hWTQ2B5cF9+9
         bP2wxh5ngy9ZlJ2gxCVFxpbtr9Y39/MJsMyEIiio2RZy84d5wA7z45vNCLqxsyBs1j
         a/uojfzb6mX43MOziqpyYKT0pv+qaKoKk+3LnYRk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.17.180.6] ([213.196.212.225]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N17Ye-1nQh1b13rG-012Xsr; Wed, 13
 Jul 2022 15:29:41 +0200
Date:   Wed, 13 Jul 2022 15:29:40 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/3] Use "allowlist" and "denylist" tree-wide
In-Reply-To: <pull.1274.git.1657718450.gitgitgadget@gmail.com>
Message-ID: <8n9169qs-9554-rqs8-0902-58n309n89471@tzk.qr>
References: <pull.1274.git.1657718450.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:NeKPq5vnqDfYdgAS0+N16bPr6pY5gtaV9DqNXxDC+kSqx6dZac0
 beUXVsqQp97+8738g+ZpyOhfjqM5hqwqVs2nQIdCQcu7IpK2whZuIx6yRV/BaCuBHNm6F2Z
 uCVlMXI1E50qYQDxeJMYTvpXDhWW6BBRxdu0+nzG7KtVFQOLjzWD20hR/2Fmeemli4lpE8N
 qmIKHbCD9+9FzchNoK7Lg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AabJdX9tAw8=:4tcRIv3Yr2hegxdrveA5NA
 lRbUNhIZa/1kDG46nH5AL/tv3ghd7hvQUaOxV9nekz1Y5J7kBQ0IeXb3BrdYXCR9oVo1qIFf+
 CPQaTu8PHAtP/sLGm2owN7m/P+oHOoTIrrnoXJW+B6QmK8busTMEZ4Yav8c7U/kWzRhTjp3Ak
 xjN8l1con9R8Du0V7yafD81VsVKe1f/b/N0SPvE80zzMzYZ0BnumhsvumMr92wTQIWRji5Eek
 wnFYCIvchKm6ysaAyzcitVMexG9+7nZ0Fvi8RCqFB07KHtZHNDVFuZCig6mVIigYJUxJC/KyZ
 dlnB1MoAj7+vhjKIPIgmNFTmQlX6j4pdU50MJfv8rsbXMo67DKYE8ef1tJX7Dc+cZudxPuDFy
 +9JhN75++E4aHrmPktM43lDk2ui/6uiVEsY+lFXlAJ+BHJwvvx84hxCh+8JoJwJIhND4lxWeu
 QiVqQBPO3JOOFwD8I/lbfte+NUneSbVAVS/CdkSdUAtq8R8B5uv4BiCmJt32LaZN6XleRv35M
 rrJs43DRaP521YHRH+qLbfFEDzryUvfHv9bye7+xeYBvUo5uW8ephlfp5wMSNdW1iv25u069k
 iPelCVP6Xw3O3NCKuHPU8gHd+UnM+u2637y344A981Bi8mf79CWprub01PXAecraeZ0j9wxcc
 QIfV/kK/daEZgLI85yFp0bwSZhou7q5W9GWiyNJHL+rQnm+eMZV8dSXfnTrcjTBlyTeNoVGim
 jT5Las5s4xLddPFkRZdfG8y39/0+5bZuDrACJ/zG44xIeBNwRAiTBQIBU/hNNuaWSlq0iZeX6
 wGKiT3cP5oeJ935sc8rcvmrY6zpkBo4y3bf1oTCtrBj4tgiygBKqjWC/hs/i24A96OGYLagWY
 cbW3m6Y02+sDVAsN8/KbigHIwBmabsrXsACRWb0tuyXkuI6UpZqj0ikWDPDoYyewz1PQSCUQG
 RTaXaAnZyQa557SKxgI5W8AGcEcabN+9lM10i/H2WpAmRSv8pMp7uPIT+khxc5ahC5GcLP0Q4
 Y+20+kKLo7GiBCuLU4V60lgH1njYO2UHi0VKUCQz+AIzgPANcjx8I07DxkXU1M5hqi3kKQn54
 CoECWTg+0zFDbCaXGZtkziprWBdM6ggIF7aFfSRWBsZKSQWMtYNctPz/w==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Wed, 13 Jul 2022, Derrick Stolee via GitGitGadget wrote:

> The terms "allowlist" and "denylist" are self-defining. One "allows" thi=
ngs
> while the other "denies" things.
>
> These are better terms over "whitelist" and "blacklist" which require pr=
ior
> knowledge of the terms or cultural expectations around what each color
> "means".

I agree that "allowlist" and "denylist" are much better terms. As you say,
they are more obvious even for non-native speakers, but we do want to take
the cultural implications into account and be mindful to avoid needlessly
controversial language.

Therefore, I am very much in favor of this patch series: ACK!

Thank you for putting in the work to make this happen,
Dscho
