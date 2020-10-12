Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BC3C433E7
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 20:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C86A82087E
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 20:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="iTe78CXD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbgJLU15 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 16:27:57 -0400
Received: from mout.gmx.net ([212.227.15.19]:45025 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbgJLU15 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 16:27:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602534468;
        bh=5aVSEFD378Xng6rSjuGVYFF6ML9+hy3iYgoebyAjL24=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=iTe78CXDn0UDEDUVXMhaUeO/D0p+wMjrfOPExCB5sCUTNTkPt/sqJ23Y7wVkcwso4
         HLubK9dqX9WNVcwbRxioBrqGew/3JEeIUopifyXE61ZhW4g6KTZCGvHQOqqFW4s8Xe
         LwkKzt2ly/92BTzOs4sczefdO/Qjp/tGO0cGBGPU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([89.1.212.188]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MatVh-1jvksR2q3H-00cOJD; Mon, 12
 Oct 2020 22:27:48 +0200
Date:   Mon, 12 Oct 2020 22:27:46 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 05/13] reftable: utility functions
In-Reply-To: <20201012194121.GA3814681@google.com>
Message-ID: <nycvar.QRO.7.76.6.2010122222250.50@tvgsbejvaqbjf.bet>
References: <4190da597e65bce072fa3c37c9410a56def4b489.1601568663.git.gitgitgadget@gmail.com> <20201008014855.1416580-1-jonathantanmy@google.com> <CAFQ2z_MRzz41x0Osvf6unvQ4Bk-RsA9NxbWZWpfwwJ2D=4Pv7A@mail.gmail.com> <nycvar.QRO.7.76.6.2010111247450.50@tvgsbejvaqbjf.bet>
 <20201012151919.GA3740546@google.com> <nycvar.QRO.7.76.6.2010122035330.50@tvgsbejvaqbjf.bet> <20201012194121.GA3814681@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:UcQRFsrzfXJDktCzCWj3hrvYKRajMfm1rctWSDy7Uf3oWXrFq1L
 N+IzIbRnZpVe12tH+Ieznkx+tyd3C2byafXJsY+Y7o4nFX0f8KPowhyRumLATrBofKP8nKk
 96/5So8cHLH62zrxsml/yO/hlf+lxo/gdsgPaFtdpG7DpfaapF47EYNvzX9UGKJ4NEh9+ea
 D5gM1L6JILeSOBmGYJ/bA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZML6Tu5hO3g=:SOU7wu9T0+u7xmLtg/sjmM
 iHt1Qltm7YE74Aml1X5yR5nLRTkLss6a6gaG7vvrabXiOnGykuCShwRzduNRAP2sY4127aiHD
 CSHAGLMi9jMb/nx+6qDNB6wHzgjAAoXcA+QAEWF9Rb3m2vDpjWw0ECE5AuKOB8s5iMkBJMtiZ
 dw3nv0V2oydwJcox2ThPp0y2tRBTEzzXU1Nq6Kix41EjvSjI7DaiozOEFAczvmIKOXpy1Z813
 dON9X6JB//X5DuhFo+j76VZ8CKaSTv7XvxKcxukO1iEMfqW4OkiAO/RZ48HtGAjUezPP1cSbN
 6IzdTbVNO1DVe0F9BYPJx0yjygn6RGa3W448fHFgSFJvBvXIlswfq/5HCk3/lwfmvlNDrq2/C
 Hq+KBZtBbCf1TrgrRB0saj+RRXDMW7x6CIhCwBdH0ESJKR1qMWWIl5Zo1k2eUlmH6Y6hJzUPf
 HaRObYyCzeqqLRR6iBnZk1+nWudx+3Vg2RlXdD+mvVisc+pIJjV7TlXIVj3dvQfZb5cDW0gln
 n4rc/CIqDnaAAEH2FjRuECtiXBzD3ze356bMQn/BD68/dMCZVulhcoSUMIMA77EG7s9JPLXsj
 S2YCMzjybF5LoTqkqd478CnyGgJrVuFIwY+plgcyn8kTYUBboH2czNIEnpGg+xTn0PkyBKQcy
 Fwk0vYBXLzSe6M5wGOWh/1KFK7dNmdS+ShunWLOtsRBh69S3Bgngs/qflpFBUEd2tk/vHckF7
 XZEM0Dp7qSmS+nZ/y0QhAE214rzeRhS1ry1iBD3+k6KeJS4xHgPmNPyP7yLZiO2UkosBdxDbI
 E16St57RhxnZf6Vwn/vkl4IMps4n3+z/Jtso8wF3UNftbf+g5kR5ZfWnJLzIyOzjRO9zjq9JL
 tam7RfwwuQQaq9ZP3Q/eU3wVa39BoZoWoEA5i4t+tNj62qMBf9XD98dv68cXmoqkUtkDLiZJE
 wAA+cvitKWbAwG7pCEcjmERDFUKAZzpr+pcy0Hi5SAl+qKzN5yUVfsA3MepVeRuKIEmo2sgKq
 KKK42TeFT+eIYh7f1KqW1sEsAQCE3JjdDRuOGMEC00AjDiUteNcGMOTSVRY8Et/w2zC9aizra
 Lgydafl/1qLKvSPpNNFycmO0ddzQCx0Oy4sB34vG/tASIxlPd7B4cFSwVm0NTCl/VsYp08Rfb
 1A3AmGLgQxyGGTriQtbKi9Us860seU4pP04FAdL4AP1RuXEkFfKXU+Dg+05xEV+RtEMD70DRs
 5I3fkVWMJI7IiQj5l2GEHAtgDKAQoXXQdhKmGfg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Mon, 12 Oct 2020, Jonathan Nieder wrote:

> Johannes Schindelin wrote:
>
> > Of course, at this stage I understand that my feedback is not very
> > welcome,
>
> Do you mean because you don't feel that your feedback has been
> sufficiently acted upon, or is there something else you are alluding to?

My feedback has not been acted upon, and my arguments have been dismissed
(or there were attempts to dismiss them, I should say, that did not
convince me). At least I saw that when gitster repeated some of my
concerns in #git-devel, there were attempts to address them. While I feel
bad about leaving the burden on gitster's shoulders, at least I am glad
that those concerns are being addressed.

Ciao,
Dscho

