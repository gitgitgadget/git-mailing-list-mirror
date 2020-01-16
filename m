Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B69C33CAF
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 21:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5658520748
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 21:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="SXEejZdU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbgAPVf2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 16:35:28 -0500
Received: from mout.gmx.net ([212.227.15.19]:54055 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729235AbgAPVf2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 16:35:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579210522;
        bh=7SE1aj+aTSt/25J1DFSxTkJm60vYqQr+YgRjVxNVi/o=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=SXEejZdUgY7tsPWe1gjT9o8RXb0hrCbMFxCzMVKZ5d/IhroL1nwDOC+i8INXLXAMT
         vILOAWbMrCPlR2lpwgJqqlWw+ZdHN0aGj5BOa+LUTUMWMswyq0tMU9ax69Fm4FkFEL
         znDErLfjMQyI4zWBdiiKY4eqOYtycuTu4aDH8WT4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MIdiZ-1ipBzr2QBp-00EcyZ; Thu, 16
 Jan 2020 22:35:22 +0100
Date:   Thu, 16 Jan 2020 22:35:21 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] msvc: accommodate for vcpkg's upgrade to OpenSSL
 v1.1.x
In-Reply-To: <xmqqo8v3gnpl.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2001162235080.46@tvgsbejvaqbjf.bet>
References: <pull.527.git.1579129054234.gitgitgadget@gmail.com> <xmqqmuaoia15.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.2001161107050.46@tvgsbejvaqbjf.bet> <xmqqo8v3gnpl.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:dl81Mx2JP4lCTV/1dlZ3sfM0+JfdSlSXM+MsSHBgkyfdRNvY7Kr
 Bwj0pXGgn8U1mLluRgLhdQH9avffFdD95vWroHlREyW27WJzZn6iA6SBOgIIKPrZcoJYX0Y
 ot4NevqLaSKKq0JmpKLjgrw3XnyHO0dXEqOQ2gkB2h8oNmG50asq5KjugIYZsSxJN2T4myH
 JxjWtPprhFF8Hkyy2i+4g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:h6hUKuBS1aU=:GzwlTvMuBSjm+YJsretKpK
 8pKgOKjrK3KcDvviTDN4UCBJ2F8a1ynvA77yEMXPPds8Vau6yleCl8JrPrpbXbWmugZGAHQEH
 LmWoiJBhMfGBtPI8Ey6HP4jmMBgcGf+Orq8ohTItlh0s/4efkIAOxX9jaUDGlEuOuT4m85twV
 +ICAE477ygSYP2rKbn1D8fUHH063bFAFnh0xyy9ScoLgHcwtqopS3dFk2XgCs+FuAznew7zzx
 WyAOkF8weFtUHjV3dnjX+rwTtpb8m3tTkevL4+evInAQfHo2DYS/KG2xaB/BfvxBHXe4cj7kW
 v8ZHE31lhRJHqMDRw7W39sy6QmKB1BARgRf2AcewoA6iA9EUwLBJ5rAGXtF166xBMMJfkx8Ci
 84Vje6D05zLFgiga4/23m8+gdNF6gVtQ2TBT+01TdKvzYpIVx9tOdpFdhP/cjsjY3p8u1Dzi5
 q5ED++wrRgFV7WBUwTBNcblvBH/Dj5IW3mVcoTm/v9cDlZAh/Ax4iH6DoEU3bRo4mhyoIwk2h
 XijMf0ypiVBDyO2OhMDNt8BTeQi5iHryKtkt/YOgnStRJa5wKMil+Xs5zhdxAznts5qWUNANE
 MvBRRkTh8k38slAmFL4yS34KaU39oO5jjznblVx1eEKLD2ETMMEDtfTXEyS+xh1pP6T/8Vorg
 KgOMKEJoWprTG9Wx0Ufmg6XVmkNhX5uUt2daG2kMnHAvC09Cgdrw9+DPuHkduUCdRIEQg3tM+
 qE6YVgignv+ietXeP4f0hDDisgZeluKCR3hhl10XTlukuus3wGyfeXZHw/zAJ+TvQZZjanpdS
 jkrmBcsO5Bj2sPf26cHXz2lsXCWcuRiPEXl2h3GD1rAoD16BfzFWr7TGMIiVNjtfCZya/jvip
 s6pwUrS4Cv8nIlBApb6fnV97r629ta85znSCVNWceLNSZllAHTaMSzWA7yn+78AODeytp5TtP
 JulbE5erLSJlCcMr7a4ImgmZiwNX+Mj3pvfnziiSbrLnrTkMmUdujGo8eQ27T8k1YNGM0PJBt
 3CfY8sbSe1XWLd2rCsq01PpRafKHSVROkbyMxpKZCPyUb13/d753DCloFM1Ulog5lWkEHrZAZ
 fztXU7Xf9fV5ARVC0GjKxPIgI/zX9UDuSWjuIsoeGhdHmkUblXZ15u1wWCX+n88qdpNrkTJlM
 aDI2KbuTFRSqoaQ0KnLopDu6rkEYffef3mKLhvWAKcVex58JVhNYtMFxWBS/7uvJT1zY+n+VC
 QfSdM9qFmMnzmpewPMLmb50Ev+ZN9VPs7zubuSqDgjjVOse7HZhOcfJFbx0U=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 16 Jan 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> Should this patch directly go to 'master' (or even 'maint' for v2.25
> >> maintenance track)?  I do not see much point in cooking it in 'next'
> >> for an extended period of time.
> >
> > That would be nice. As long as this patch is not merged, we will be st=
uck
> > with failing Azure Pipelines.
>
> OK, so let's take it to 'maint' directly and merge it down to
> 'master' (and all the "more recent" integration branches).

Thank you!
Dscho
