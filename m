Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F88DC35254
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 13:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A58E217BA
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 13:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="b9m7ShSI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgBENPQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 08:15:16 -0500
Received: from mout.gmx.net ([212.227.15.15]:35095 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbgBENPQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 08:15:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580908512;
        bh=Iy+5Ki5kyYL3MmRShdxdtobe+8qZGjfbZYSGjH44/yA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=b9m7ShSIm7VtcYaMtpFutSZ3UNFqD31e+Mw5Pn312DA36A+iyvKLlo4PLtag8tT+9
         Oem9PYHYA9rSj/AMzpkdCyS/bZTYiNxMiWSvLtJyDODnad6Tl1uW5+AllC/JPq5Eqt
         1fAsvnGDQMjGu5VUAhn9kcSvQ958JdXFi88GriJw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQ5rO-1jCa2p4A5I-00M5lM; Wed, 05
 Feb 2020 14:15:12 +0100
Date:   Wed, 5 Feb 2020 14:15:10 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Kevin Willford via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Kevin Willford <Kevin.Willford@microsoft.com>
Subject: Re: [PATCH v2 0/4] fsmonitor: start using an opaque token for last
 update
In-Reply-To: <pull.510.v2.git.1579793207.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2002051413460.3718@tvgsbejvaqbjf.bet>
References: <pull.510.git.1578423871.gitgitgadget@gmail.com> <pull.510.v2.git.1579793207.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:dFsUJWEJxHauUfd8qR6T0m8vbnIUADIkzuxYBF2tUTWRM3JojQz
 22x0POxVF4L00KPNA4Psxv1nWXppgc43t8WBMIxvH83wxyaksFfyX2JzKMc9ejmASv1wwwq
 kOdONQ7QhF12VinmDK2v6akTwFdd4A/q6o1yt7Q4kphPF5PwcDXw1x5nyJAE4PLazEoFXFk
 3/+oH1bwgaLZeoOckVs+w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6M1qgAPTb9w=:Ba4bC7scxEnmdfo7n+XQwR
 1Wy972IYr/VzYW01uTWGG48aubgu0xZoeyIW/mtRNBNe5YpwVwHikRRFVp5dPkk5K6HWtBn/N
 G+y0cM5dZhsWULZbqj0fSiUTG6CLP8hXxrAwrSZdDmXs5CnCw3lOu07yRJuuTwLgul5zKSfUy
 /AYfBHseQXxEl0trmtB6HRkLHBBZWMm72y1vrxS+pLyoVVExeHv/VXV+HE9l2Bpcm0Fl5HKHm
 KvE4fWw//bGXCNOGmSDW1FQRLcP+p3oP5M9fbZ7HNMuTs7nK2e9grgPQfMOuqCd/gukb3gI5r
 91IYORDuDvWpo493gAdUE5jMtidOOep6q/ZLCfuBrbsD+JXwnbjEf0FuNlBaxSHkpP014Lf31
 Kvfs1klGtpIXavbkB/u55yGdpPsdkNYIgWeqvq3wK5YCkRU8IBesHivqrofhpfP+8JWrO/Em+
 2mo0amRTdSBOT0pk2pklmQU9vCLu9L6YO13fEjM4uyxCTDQg7oZ50FVOqS8ELW3WzIZ0xrfdu
 NCgoR0iCdOL2C+vSQ8z1vusBF56Wn9AAzkwaMkVVy43pqHXvGksffUC0DGa+DJhIlvnT4K5yS
 F1K/+WZo9nPX5ckFWiZGabaQ5WhsHEN+TMzgslup0P7mWHaVy4l3GS5ZJppHnogvzhUEvByyF
 Ajjtc5RObpkpiNI0tJJyOd/L8jmRHKDvpsg6csPR1IhF3Cr/6WSc+0jpD9rl8rt3Z1OQ7fWcL
 iNAaWKUEgANb4z6APwmE3OkGx+4MceD5y2R7jp1AH+HYA2mSJVkr3QBZ3FFG04PSEclNhzDju
 zrqEQoi/MqdnOuXNwFrAcruu7rageqqNsKGrZKgicM+9NFP96BTlN1FR8aayrUTzc/c3dY3Ql
 NfrQNzblvheSrRGF5/6py8V6jY8V6ON4nlnNATeS2Y39kdgX8N3NZFa3L/12kPPS6KazCimwG
 iKBJUAj/Wbc08P4ChmB/aKRjPn2mTVCz5U1RNuunNCRZuRE5yFbkRIaear4tUBtgyCHWcUIV8
 eP1ioNOdi9xgzrRE51OgBBDQLc7BJpNGedUK2VP9KH6AAIUc19f3FSpL5ILkFLH4Vnq8PRTw9
 qNGFpdofmSnr7Pa91MZviRZ0cIka5rkIlsg1tZDHPW4DoqytETgjntzUHeYKfiMsPNpjje9ys
 NiXCJfGWfcbR9aMjnGEMpgs7+CVEiX90Lsl7n9bnZL5A1wAUGb4casvpHLaLaQp3FlSncqXcD
 AVvfGflxiGMq1kWtx
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Kevin,

On Thu, 23 Jan 2020, Kevin Willford via GitGitGadget wrote:

> Only change for this version is to sync the watchman script that is in
> templates with the one in t/t7519 since it had some commented out debug =
code
> that could be useful.
>
> Also haven't received any feedback on this patch series which would be g=
ood
> to make sure I'm not making any obvious mistakes.

I just read through the series (focusing on the C part) and offered a
couple of suggestions, nothing major.

While I would love to see the fallback-mechanism simplified a little I
think this patch series is already in a pretty good shape.

Thanks,
Dscho
