Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009FAC43603
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 12:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C498120838
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 12:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="eazCg62l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfLJMTh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 07:19:37 -0500
Received: from mout.gmx.net ([212.227.15.15]:46825 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727131AbfLJMTh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 07:19:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575980372;
        bh=Rlk+z3DFZdHOUMN5Ke8wy/JeXcAP6BmiLMDoPJIc7rQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=eazCg62l/HLq14ZL7UP5+pdDYzWHYt8a9svqDjFKoMLUxeSacdX4Tfe+oBgn/2r8x
         lArAspt0PV7JuU3yFkd6n+6bJVQ3xKW+Z77sGX/rgZJ2Z45zoxs5mSDR56wojMOqkr
         DGX05NV/p7uugUsCI0GFEtPc01U2n3f9aFY7gBt0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAfUo-1iTg8h470i-00B7uR; Tue, 10
 Dec 2019 13:19:32 +0100
Date:   Tue, 10 Dec 2019 13:19:13 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     panzercheg via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, panzercheg <panzercheg@gmail.com>
Subject: Re: [PATCH v2 1/1] "git lfs" allows users to specify the custom
 storage location by configuration variable lfs.storage, but when "git p4"
 interacts with GitLFS pointers, it always used the hardcoded default that
 is the .git/lfs/ directory, without paying attention to the configuration.
In-Reply-To: <xmqq1rtdt9rc.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1912101317340.31080@tvgsbejvaqbjf.bet>
References: <pull.483.git.1575466209.gitgitgadget@gmail.com> <pull.483.v2.git.1575901722.gitgitgadget@gmail.com> <e65375c528bdcdcc928dce8159edfccddcf77070.1575901722.git.gitgitgadget@gmail.com> <xmqq1rtdt9rc.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:OtpEK1/HJ8W5s/8HW3QFEiqmffP/0oRQCggA740x3CUKMdH+sEU
 CsdAW+ob17yg9eGBdIOUbMshhkXfpiQMaEjBj8DyYSzfJigYA/MdWgMWt9rgNmv9SB3ZYOY
 4nWFF1kqDS9oTVDwnPRSd8ZlMNdkJVCNjydmGLKA4Hlhoixcg/TZBoeC3LBgMPlOkJrrzU3
 BcOV+e22rUQ/1R/sXYgFg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eSOiqlP0qgI=:1XbMc1DuHiAzGPV4oYd2UR
 glNJab3O9widoUQyRQYsAv02RbbjxAavOqbQizzxBL25hgq9Revbkatlwz878f7zxqVGYb/sP
 4pniJwl/K4xboFUB5FQTKft60M3ei6+/6um7x7tTa5d6CbmGpc41QqRdm1XwlMI5YsaUhQfKH
 TptsxBwq45h2NbRPZiSe/hLhr0dGtruMzxlM7tAtTR/ZLNFlkn+nwQ+1ODksRf8bdUj6SwXij
 YfvNjT/ipTKEJppSkqekEyd2k9qiOfGl5JITgb12QIllp8Wye0y2qroygMlALGBH0iEJdWFbT
 y07JKjZwr2O2t8h55ouwKPCV8bx89/2SbTUjJEUmY7rIRPIwYEOYxer6djqrCKP1wP7CCOM+t
 geX6j8WZNpcI/RyfgHBmi2J4PwxRrCFD2CXsU6vlhLZnSQ71dKwLE9E4+mxZL94YdV3OmEwiT
 uJxpf2Sjxre53oYRX9Yyf16odziVp5ITnGkvpqOuubfNss6UfDcway7bZVsbpjGzuy2LNs1mD
 kIWmThCsd2kkAR13I/pJz2h7RMH1jo1YxIDiya+pMxDy+LLR7GNVwWiRJx2fY7gMf9lI8Z+an
 1h2hkNhayD75v5sFIp2DBKy2XYLehpgYVFhkbl7+XAccqy9ra4Xx5s01Rg17fIIhLkeSGwmiH
 Gp9eEsWVHcL8lujX3v+AQkC9H5xLc3WRUxWcTsaXHbe6xtZzt2FMXAzSSbmFcBX2lvKSl8e9n
 cCPv9UM1gGVblVnOG2V7r0jnNNcPonDx2/VNtzNnNmKvldWoqNssRwgmS3mRdoBFcJeWHHBNp
 cchsUljsAC+hr0PvsVHGgcWHvRWPiSNgOWuGP4lP+HsQk++kWqxl6RX0MLZeSThbv9C0QZyDw
 n1VW6IYOwl8b7ISh7/hPk7wa/6fPjDXYvSJduFNu3xcfTL6J+RKztBGF2nP7BxMSllyyl37m4
 IvgzYMOT5TNEsR4GQ2zmrR4D5XsnNzrt3GXHiHPoYXz9J7r+IH5+rDy4hRT+qhj3ygjUcnd90
 JBwZE/epcWLXiPwqxNqm9L7gQQRzIoyuM+1iliGXhcnnU2bm3bVXv1+xhn649p/zu4wHPzZla
 /MLczGo6/pTgNDQr/74X7T2Qrvdd7K9fHd5zmLGPI2w77syox0oar+Pm1OcbS4DvRtS7CIRub
 VSJ05VqEth56meBRoZyVPY2jLcRRUopMMJzBMOPgGY3poRWftp28Dc2deNoGAOFzhatvP8E6B
 RhXF8HY7FZYocv2CU1uHMKkqYyJnwEQISwaLSa44CA934ibEdHsPWgr6z/Qk=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 9 Dec 2019, Junio C Hamano wrote:

> "panzercheg via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> >Subject: Re: [PATCH v2 1/1] "git lfs" allows users to specify the custo=
m storage location by configuration variable lfs.storage, but when "git p4=
" interacts with GitLFS pointers, it always used the hardcoded default tha=
t is the .git/lfs/ directory, without paying attention to the configuratio=
n.
>
> Oops, what happened here?
>
> I wonder/I wish if GGG can be a bit more helpful when seeing a
> commit that looks "strange".

There is already a ticket about that:
https://github.com/gitgitgadget/gitgitgadget/issues/120

All it requires is a contributor with a little time :-)

> > From: panzercheg <panzercheg@gmail.com>
> >
> > Use the value configured in lfs.storage, if exists, as all the
> > "git" operations do, for consistency.
> >
> > Signed-off-by: r.burenkov <panzercheg@gmail.com>
>
> Please make sure that the name/email as the author matches whom you
> sign-off the patch as.

This, too, should be addressed as part of above-mentioned ticket.

Ciao,
Dscho
