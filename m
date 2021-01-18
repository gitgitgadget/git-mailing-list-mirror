Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC8BC433DB
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 15:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A0C422BEA
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 15:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405381AbhARPET (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 10:04:19 -0500
Received: from mout.gmx.net ([212.227.17.21]:57353 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405350AbhARPDq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 10:03:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610982132;
        bh=/GyYffKIOACbKG5HR/oBE9f2UL2OGJDN0XcswYfwV8o=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=krw27RI3PD+ZO4MiXrFbVsdgor4io9IdV3TcVKEKD3X2t+/qud54pVj/AI9C0GEuq
         RK9bH6I9YbEgwfrwAEzFsu7UQZ8gLJnEqEVkOO/NyvQ/qAnm28SSqFKCHcrGDnEj8k
         1ibOiiv8IWOFATFIfIZ0ibSnjQ+4qQXbK+eI34Ik=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.115.203] ([89.1.215.22]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MrhQC-1lmf5M1j08-00nkVC; Mon, 18
 Jan 2021 16:02:12 +0100
Date:   Mon, 18 Jan 2021 16:02:17 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Miriam Rubio <mirucam@gmail.com>
cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Subject: Re: [PATCH v2 1/7] bisect--helper: reimplement `bisect_log` shell
 function in C
In-Reply-To: <20201221162743.96056-2-mirucam@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2101181555200.52@tvgsbejvaqbjf.bet>
References: <20201221162743.96056-1-mirucam@gmail.com> <20201221162743.96056-2-mirucam@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:0DoCwZZ/62BvXKNcVj60S42gNzPmUGByoJMPKV9norZwAf3UPSS
 z50QQwlxke79KplYAiKz1R/G6cI6lPbfsFnR0Cs2Mq1B7x/l6dFb/+fH1oyGFj6kr3PmnC7
 0BN7D3GYGUNty76sDIP0/GOsv+Q8BFBhO3VUGNn5RjvBqUQTzTlwFxUuvpQpd8b+ew1PwDi
 75/93GuVm++p0X3F6kPvQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xcIl427o/q8=:Ttt6KrxqdztNxwLyFPV/nS
 4AeIC7ZJP1CVk4XQtuWKz/5nV2TjKnoS3JbQKS87pfX+47DwDI6XZeOnwpFQaoxEB1mlY6/g1
 3nxAHiPkmhy7Fk7QOcjZrlh/3DSEigW28lS2cIVu6PuXd0jnbTTldGVa8q+wfxsffP3ghn4iA
 9eVKFoEVB9Bkx+20ZMewYWpoAzIcGwR/94uXfP0xRIqjDjrf3Zleb0b0g93unPLSmxBO7plol
 gj8rt98ZFoAn5Mtr/NlxaM/Uxm62dK9m6yg6g9/N+T+NMfGNXVGlo319XOuovWOwTOwyyTgqA
 8peBvqlF7BzDo1mzj0zxp3gW9Xf58NwbKf5g/UFEsgf4Vv0saUN990WrCufYoOLzYP+fZ/DYK
 FJNaObz7yRLgq1YjD9BHGi2tXhz3r5u0F9aSn8+zPRYqdL8S7Mz1ycLiImVGcEsQbTsd9HSsY
 21ffLuD4H6ib7SKCmsyqv6Csr47fZjjNO8ibhC4X3x8/aPce+0M/nlOGWo5LmabBn46Szj54L
 rdAR+6WsfMPGfMx84bpwjdswoi/gG/QdP/3t+TGN2QsBFEQv8wF+PXtuyHnKJpI96MFfK3vMh
 fvESTbYfSmasb5FMX9ZWwD+mBwAAA+i4wKyEqi2cCADaVFKWu4DrtwI8PJNOqPGS60FOni9By
 ningGvNn/oIVL6fsoyXskU8Ct6X85EWa8kJHf/H6P78RxY630KWxll73BzehARoje6UjiY9RC
 w3pMu+sJwD6zq5MuWm99dQQkzy0yoqvHaJ9vbmsFH+kSpb3R0i71HIMlW7M8BLBHbdVrli/7r
 IlfNymoVrFjHGuKFYKVPszcm8/64tWxZWvABxnEzti9we74MPvGsL26kyfE3fGRFVFnFFLapa
 RVLFGm7H44dFKeSSmhp2ZU0SS4BDH+p/MufG9ki2s=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Miriam,

On Mon, 21 Dec 2020, Miriam Rubio wrote:

> From: Pranit Bauva <pranit.bauva@gmail.com>
>
> Reimplement the `bisect_log()` shell function in C and also add
> `--bisect-log` subcommand to `git bisect--helper` to call it from
> git-bisect.sh .
>
> Using `--bisect-log` subcommand is a temporary measure to port shell
> function to C so as to use the existing test suite.
>
> Mentored-by: Lars Schneider <larsxschneider@gmail.com>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
> Signed-off-by: Miriam Rubio <mirucam@gmail.com>

Good. I see this was originally sent as [PATCH 20/29] in
https://lore.kernel.org/git/20200120143800.900-21-mirucam@gmail.com/, but
this version contains improvements:

- It returns `BISECT_FAILED` in `bisect_log()` instead of -1 (and
  `BISECT_OK` instead of 0)

- Instead of checking for `argc > 1` (which was wrong), it now verifies
  that no arguments were passed via `if (argc)`

- It exits from the shell script appropriately when the helper failed

Just one nit:

> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 709eb713a3..1854377fa6 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -938,6 +951,8 @@ int cmd_bisect__helper(int argc, const char **argv, =
const char *prefix)
>  			 N_("verify the next bisection state then checkout the next bisectio=
n commit"), BISECT_AUTO_NEXT),
>  		OPT_CMDMODE(0, "bisect-state", &cmdmode,
>  			 N_("mark the state of ref (or refs)"), BISECT_STATE),
> +		OPT_CMDMODE(0, "bisect-log", &cmdmode,
> +			 N_("output the contents of BISECT_LOG"), BISECT_LOG),

If this is supposed to be a more permanent subcommand (and
https://git-scm.com/docs/git-bisect#_bisect_log_and_bisect_replay suggests
it might be), it would probably make more sense to describe the option in
less implementation-specific detail. Maybe something like:

	list the bisection steps so far

Ciao,
Dscho
