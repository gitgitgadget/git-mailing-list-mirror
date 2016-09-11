Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A416207DF
	for <e@80x24.org>; Sun, 11 Sep 2016 08:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754957AbcIKIKY (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 04:10:24 -0400
Received: from mout.gmx.net ([212.227.15.18]:54607 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753809AbcIKIKS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 04:10:18 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MUpFU-1bWzno3Cl2-00Y6xN; Sun, 11 Sep 2016 10:09:44
 +0200
Date:   Sun, 11 Sep 2016 10:09:42 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 16/17] lib'ify checkout_fast_forward_to()
In-Reply-To: <xmqqzinhaq5p.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1609111008370.129229@virtualbox>
References: <cover.1472219214.git.johannes.schindelin@gmx.de>        <cover.1473431645.git.johannes.schindelin@gmx.de>        <f624be21280cb2f7624ed7bb4d890903cccf1c7d.1473431645.git.johannes.schindelin@gmx.de>
 <xmqqzinhaq5p.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:W1L19hVA1nP8y9gH5tlM/ynO/TWYwCiSClrulF1cguDpx8OZaps
 Z1g1QWyA1cit7/hicqtwWfHznQGgYwCFesqszXJNJQi2C+ZCVbTP4xg34txXaE19eZUmYtd
 KqWEYqds72SMJ/OtPD3+Gls+ZkRWPvA8dJ8nrbKo+uyPsv6jqjWK1cilK/kRYSkx9nBsDp5
 +/AbBirZdDHVt83g1+IHw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RHNexW1zafI=:rpmZ6Te6ni8RGh0wqrZg0C
 HPP4iWBZ+eDEvySJUDoIpEsXmBZtQNaTd6qikoRKOafGXH17ZtPChNXu4/u27lTRpC/G5fC56
 HwyzncguXXLojlHZrrBQO5mxplF8sbEVBmwGMaWDGG1QUsA9R1betri3jYyeYizie/qYdx7e8
 fy00NYdLyOCFrrCh1tltRZjS6cJGibm45iNmSWuMp32YEMzd+UV7VtXiNb9B8+spKz4MjQy4C
 R/pgZQxaJoJTAlKYDverlrynQPw+cTaY09vM3yYLJMOk5X0K5OPJzZWivt3x1r8I0yPzsthBw
 I6L1LpNhp2RkZdSe5eRssICvi/boQYqqa6HM0bUOMWzql5H3MgCVML1zheYqdUCvVkksskhzC
 TZSQsX65/vPWDlzYWLibs8EuAcXbRQC6owAHDmqFjqsXW2FX1fn36RU/B91zZTYVAsD7JrnjX
 MEPFImX6YCzmgHQqDpWcohC+08yL5veEz6WzBgdVbFEWVkVIKWhMuA9hNT/gvMzsmbmsdNFMO
 2bWuRPS6/jFCicLgOFPv5ySnx23Z1new2envu1+Pf8lokPgkrPcgtm5f+FCNCYrFv8NPVmpod
 5SapvQvytRuuZdIFNRlRhlWDabOIO4hyYHq5cB4oxb25lmX3S8dXuEcqrugKz8ugL/QxDaNh4
 sxg/4ydPtyt5DAUz4THK/zeGAkMxcBCg/InwkyIVQlvcKtvtY7s+rbj1b95KOjPsZKOh1q2rv
 VwjzakOB9jjRZHQ3pGclZmUeUspLqejIIDz9+v/NPMIb9Ig/CIcidu+LOKRKROH8UDnbIUlM5
 f5EaTTS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 9 Sep 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > Instead of dying there, let the caller high up in the callchain
> > notice the error and handle it (by dying, still).
> >
> > The only callers of checkout_fast_forward_to(), cmd_merge(),
> > pull_into_void(), cmd_pull() and sequencer's fast_forward_to(),
> > already check the return value and handle it appropriately. With this
> > step, we make it notice an error return from this function.
> >
> > So this is a safe conversion to make checkout_fast_forward_to()
> > callable from new callers that want it not to die, without changing
> > the external behaviour of anything existing.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> 
> I'll retitle this to
> 
>     sequencer: lib'ify chckout_fast_forward()
> 
> and checkout_fast_forward_to() in the second paragraph to match the
> reality.  Other than that, the above analysis matches what I see in
> the code and the libification done here looks correct.

Good catch. Please also fix it in the third paragraph. (I changed it also
locally, in case a v4 is required.)

Ciao,
Dscho
