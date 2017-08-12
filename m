Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BE4E208B8
	for <e@80x24.org>; Sat, 12 Aug 2017 12:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750891AbdHLMVg (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Aug 2017 08:21:36 -0400
Received: from mout.web.de ([212.227.15.3]:51713 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750848AbdHLMVf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Aug 2017 08:21:35 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M1XE9-1dMmji0WgT-00tQQx; Sat, 12
 Aug 2017 14:21:15 +0200
Subject: Re: [PATCH] strbuf: clear errno before calling getdelim(3)
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Simon Ruderich <simon@ruderich.org>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Yaroslav Halchenko <yoh@onerussian.com>
References: <20170809173928.h2ylvg5tp2p5inem@hopa.kiewit.dartmouth.edu>
 <8e307474-d180-6d98-2c6b-062f2181bd14@web.de>
 <xmqqzib72qvs.fsf@gitster.mtv.corp.google.com>
 <6d7b0d30-48ea-f79f-78cd-088557ea06ac@web.de>
 <20170810200502.rutab4z3ft7gcpjz@sigill.intra.peff.net>
 <cd49ce13-db87-89c1-77e7-998fdb9442c3@web.de>
 <20170811075059.nn6lru7uy6s6vpza@ruderich.org>
 <e8e7f028-6e23-368c-484f-9f069bae5dc8@web.de>
 <20170812100252.bhbgg5jjlom7dfl2@ruderich.org>
 <510f566b-3aee-98fd-9663-d97c3dcfeb96@web.de>
Message-ID: <a6fe4020-4e3d-0561-db70-2eb87e0680c7@web.de>
Date:   Sat, 12 Aug 2017 14:21:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <510f566b-3aee-98fd-9663-d97c3dcfeb96@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:O/3aUfUjxwmgY6Dia+pJctEm4yOEUGHzarvYCb9rhMpiHp3SBxU
 km1CWRTttobN7vDJDAGYJmcVla13NvtrqjO655Qy50FNBIbM60USSB9KQD2lvgsBSzp8KQe
 hhYBpXDS6lnK6+ClMNoP5ucKtURwHNmOhHDq17DPWHF0z2fPufARQJDwiT8UGdOSPJAS3TC
 Hb9c5wCamVWgih5YDGqYA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DXXTugmbUEs=:SS19I4qHG7vd6XvjlXi2mR
 fh1Qc8doPJYyCrPAsmTf+S7PxasbKvTIxi+DCSKa2oAHrQvSfXpDGruMn8L+ylx6fc1N4vblH
 C0ih1TJ5Ce0z6d/EibJ6ItCGIc3DuQggMAn2Ak8mriuaYmqfakqbneWMdlYWFA2uoN56TIFLV
 +XjjHDMN9NUN5F8RylLHEQDZAH0VunZgmb5d2gIw9sq3WBg4pl5U02OaWTJeuwXGW133Hks2t
 Ej0fs4ZEls4eAbPmvK6uZOv/8M798dC/LAltruQGjI0u74buQ+7LyOVutmlCmegO/Wx3SC8UG
 2TmKGuqr8qPSD08SfmVKgnvNBnnZ2twVSORhGNSOnRRoxS+1eXPa7lfnPyF9pAyAHIqBpM91E
 pmIvtpJO5z43IB2PyrV7DHWuT0zWBjJk9FpWQjBtB2fgSCfaH0yw2wytbbSgc5lmEG3oVlKUe
 jTOpE539wqCp/WtoEb2bjFH8DI7UqNg6aLG9UFo6QW2+1nk8uEfPOp1jh1nRii7KPk5XguLgL
 1P2D3eDo3rRt7dAKnX4cLGPGzEWpQ+Pu9gq4XnHHSdRSRIA94v/LDG6u3/nYzpRLWzthUOhaq
 Q40aoWCoaDEjqJLOxsdnDTLkmHCnQOBa77zvTOWoxWkGTrBOFhsayPhO4ai+diTZT8jX29aVG
 iRMQHGH2aBZcWXg5v0zBf6NpkwYWq5AFLEV+flra7uNCkPUq1WEvPWFh02Rs6iwwJNP4tGOC0
 jkxw7L4pnCOSKp6UHWvz6qOVXR8jokmuJAsk2DG6n13DN54/pSAsdNYJ2jCLT/cGEWW0F6iZA
 KUMiB5RCnLsfLUMvWXSQvnp4+qRPFsLSxP5hZdRaQKc6c1vsp4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.08.2017 um 13:57 schrieb René Scharfe:
> Update: Just noticed that on the BSDs getdelim(3) doesn't set errno
> to ENOMEM on allocation failure, but does set the error indicator.
> That might be an oversight on their part, but that means we
> certainly *need* to check ferror().  And an unchanged errno can
> mean ENOMEM there.  Ugh..

I take that back.  The memory allocation function called by getdelim
will of course set errno on failure.  I got fooled by the manpages,
which don't mention ENOMEM, e.g.: https://man.openbsd.org/getdelim.

René
