Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C94C3F2C6
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 13:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 160AF20842
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 13:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Ao1Tt6EC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbgCCNdk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 08:33:40 -0500
Received: from mout.gmx.net ([212.227.17.21]:54429 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbgCCNdj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 08:33:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583242413;
        bh=34z+BhSloBoq7PPRLQRYkmS5HKgvtl+xqiGJCwDXsCc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Ao1Tt6ECOA+TWTg9puxOEzPxmxYVS0k0Nu7oSw4Nt+veu19TJm5tYfToP3/Q26Mhz
         SSOxiHajMfIa9IsdLkEc4Mzip9AxjMfsebkMJnxmGme1L+zNcGosjjsdldhzfL56ur
         XuLbr4B6p2ypUCJ1bZNEzVD52XdiEgrPzgIeU/AA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([213.196.213.69]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M2wGi-1j5oHp0hDw-003NTU; Tue, 03 Mar 2020 14:33:33 +0100
Date:   Tue, 3 Mar 2020 14:33:33 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Thomas Gummerer <t.gummerer@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Son Luong Ngoc <son.luong@booking.com>, git@vger.kernel.org,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Subject: Re: [PATCH 2/2] stash: remove the stash.useBuiltin setting
In-Reply-To: <20200302181924.GB1571684@cat>
Message-ID: <nycvar.QRO.7.76.6.2003031430180.46@tvgsbejvaqbjf.bet>
References: <61922A39-13DC-4B17-94FC-7F67DF308347@booking.com> <xmqq36ayob9a.fsf@gitster-ct.c.googlers.com> <20200302181832.GA1571684@cat> <20200302181924.GB1571684@cat>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:pTOwOmbuFRcuzXNmf7Td8Ph7iOUoxfZIikflN+smuTRavGijUg0
 HBaZp0ZTCXShb78JCqJ3cPXDBYMAtHkWgxV8O2JnmxVKliVlijLQGpDrWB7oBM+UFZ5/iSA
 ujfAUE7nqhdJIiJRxWGY1X/gu6rsAKquOWWZt8QeSNz8Ke3J829SLW6TE2bdQ3wlm0xo1mF
 Os+KErhdvR8qBF+Zbv5fg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Nu7mfzUcDGI=:L8VrTmzQJEB514wRrzNhj6
 fo1Yws6V1WdlJxl/AFldwge/wtPRaUaVarRDWRYSsWRKZVQYL5bvPWaAIAq8gBiu/XS2HA4IA
 +YlT5ogcbcGYIcJSptR1DFGFOUxYeMuz3izIGknMgt551ziF20BKZZqt39UMsOmGInBOLX+Cd
 GDUidcdAEo2HgvvB4qoAdvvxH6Z1y+I8KEdzUGCLkMsD9zDftgCEst663F68wj+GPu15YCUHM
 dU8fmZyVHstLSiy5S5HRAf9/BndF2MMWsW50j9zEdEhxdCiT+L3FN3q7VnVH2pyCa+xb7JW9B
 XVyiyMO5N+RtB15g4zVO4963qpdF0sdD2V3Mfmt0tCdQcm8mK6iyFWSMuIC90kh6KR/L1em0T
 6Gwuz+QFXCTPK6sOIneS010YgvB+rmOwbfrAe8E/s2+vomcsVhv9puKSBCQxGaF/+1HVkeIkM
 V7nzQ18cNspNq6cmppwp5QYPiQM7Wmv+K4QEDy6Gt14sinNLAYFuTRvj65k50yCgutbBd0AX6
 4GZCmkuVtC9+1a2AODpznMNvuZyJ9Y2ZQJuNWMvUfFMenxNWSGL9KIOI46VLaRJHVH68SrXop
 GT4yJhLXKvm9mB0tTqumfOUVUMODHjgf7qydurhF7OXnih6B7vo9cmwwS0WnHCeS8OYXypr3Q
 PefFbNCDQJ81qcG9TB5Zi62tGhEaikSzheqpe5PgJ9oYS4TozpVoZXT5XqJZ0vxe3T0pIZxkW
 bYlRmaBFsnR7EmwzyMIk2qmibST57odzAdHtHTHIwMkJ+UT3l4aB3+R2EknG0fn6GYqefgYXE
 rSWCGPHVccRydWMKC3JbQdqjIk7YsHJbx6SsYa9jacVhFRgqIorhH94zcWQyKdU5+JDRcPOGF
 MxkJQN75Kxrn6fQ7oRPrdarTg1/joYCA/SUXr5dDUxZ2ULCfEchPXXz0gT+IeRpR5Hm7d8uLz
 zNQ5pjOXsHreneBJyrbovAs3nywsXBZRcAudmOR/9KPlr+kLsr31kOFOR/GWaLxv1B8oJbyoL
 YIfmu8AZgPavFq0PFB85RtWkmRyntfLSJtqPIa40gtItiOdU2Ba9FxnV4diRtUm76S6HiaaXv
 +HQ/Ucd1q7nouJSacqc8Dht0CXv/XleDtJ+BgigUHAd4vbSR4MIkrTGOkLYpe+75K+eW84ciY
 qLTghl5jAm9mm3I0ybYyOzDMo8h86y61+AVuEkJwfLcQIp5FHUQ1rw4QPz8e5onnIxDi1fYag
 58y8nM4AVznr9VLq5
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas,

On Mon, 2 Mar 2020, Thomas Gummerer wrote:

> Remove the stash.useBuiltin setting which was added as an escape hatch
> to disable the builtin version of stash first released with Git 2.22.

Great!

> diff --git a/builtin/stash.c b/builtin/stash.c
> index f371db270c..5f4bd693df 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -1558,22 +1540,18 @@ int cmd_stash(int argc, const char **argv, const=
 char *prefix)
>  		OPT_END()
>  	};
>
> -	if (!use_builtin_stash()) {
> -		const char *path =3D mkpath("%s/git-legacy-stash",
> -					  git_exec_path());
> -
> -		if (sane_execvp(path, (char **)argv) < 0)
> -			die_errno(_("could not exec %s"), path);
> -		else
> -			BUG("sane_execvp() returned???");
> -	}
> -
>  	prefix =3D setup_git_directory();
>  	trace_repo_setup(prefix);
>  	setup_work_tree();

However, this is only needed because we did not change `git.c` at the same
time (as I had done for `rebase` in 80dfc9242eb (git: mark cmd_rebase as
requiring a worktree, 2019-07-24)). In other words, I think we will also
want to address this part of `git.c`:

        /*
         * NEEDSWORK: Until the builtin stash is thoroughly robust and no
         * longer needs redirection to the stash shell script this is kept=
 as
         * is, then should be changed to RUN_SETUP | NEED_WORK_TREE
         */
        { "stash", cmd_stash },

Other than that, I think your patch pair is good to go!

Ciao,
Dscho
