Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F339C2D0A3
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 16:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3255222284
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 16:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="iEbNeRAY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1785914AbgJZQZ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 12:25:29 -0400
Received: from mout.gmx.net ([212.227.17.20]:49979 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1785800AbgJZQZ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 12:25:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1603729504;
        bh=OTBUCGIcEBEtN+El3nqSuZXwX/1hS2IkCkpednEyYJI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=iEbNeRAYwZRfAZtUgmTBPxjCdXxY3rlLh3PWL5WlskVt5ZhIR3BB+gMwV6tCnRt4g
         mEgcy9fLNXD2oLcfxE154rvT4oMPZt1VH83dcgW6QTfW9Z98qQLqLL6CJMpxLyVDFm
         Ye743ZTpDqXabTBwTVZwke6AQufvUjPmeAWcpydY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([89.1.213.122]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHoRK-1kZmze0FjK-00Ew99; Mon, 26
 Oct 2020 17:25:04 +0100
Date:   Mon, 26 Oct 2020 17:25:01 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     VenomVendor <info@venomvendor.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: Re: [PATCH 4/3] am, sequencer: stop parsing our own committer
 ident
In-Reply-To: <20201023074510.GB2918369@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2010261722230.56@tvgsbejvaqbjf.bet>
References: <20201023070747.GA2198273@coredump.intra.peff.net> <20201023070939.GB2913115@coredump.intra.peff.net> <20201023072630.GA2918369@coredump.intra.peff.net> <20201023074510.GB2918369@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7FtOQieXq0n/W2R427K/rUbdOFnZJviAmWhzwOi6az3MCA0e8ge
 NmfcPmRY+cACvwJxtQxGb6xauKa6zE/QSfYdA1St4JDp5iwNtq7kKgoFkL3R404Lof/H0zZ
 /Ym9yIjMnKrpIIlzuseudI5yFnzRHhxiTMqkDVg+HlC00y1bw+aIgdlBlYr+RgOrRaohBF3
 8/zj/KspQd9Cmo3lMKOOg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:O6hz8w6rjUk=:HUegh4fMrLA3YfTYFczmRD
 KsF/ggpJpEkQTne7bu3y6vRBgFdnyAElU8mLbc08LL7NqemDuKxEubot6aQloQrV0J6fnDq3v
 ACM0fxDJ0T/D3/FtLgFz7Sj08LFUcfYWr1B18CsIZG/EcRFNgdiwyzjHdix3I716nwSxp5QU2
 mJndxgqxv38i+kPwopqNavh0lMRsOtPmcQpQkYck8EylBBhiDhY/nOVcQrKYv6rnrA39FNMPc
 CCA3SG1xb9+G0nSggr0YFrONdQw9Sovw+Pu6lhx7CYfmBAXnSDC+QmB6sJaE2eBXqvnWItd9C
 oNu+XD4HVYSKj3nsVgh6ZAzLPc57hlBemhfApy9s+PkgJ8uU4McRY/b/21ZAjbyNV3IH4FyYp
 xvGgKC1HIn4jxynAeTS5/ADt1BiBA9F7Bv8UR5nXfZKFEc+HM4uWzKkQW6ax+siFF6MHpHAMH
 bgWKYa7jvZZOas2woao1svZqJBT4fzpvgBUxWAANTneHsFxgpXj8lOPgbIJ586069swBDNCD+
 6ih6tPABJeuLJYKbPGp6fXforngah64Oc558UGvvobZEAh41jjh+vh2BoK68rQoe2+aHXoCgL
 YpVbsuEVOv8YvSuhyCAADenjlUuXucTanefrLPc10rihKgc1/VxAJ7nV16Eajq+gA055vC1MO
 cqrNYXPzbNdHXOt2dSXqm15S3T4D1UtzNO+XmCCu3IW12G2y06ti86dSkoN/8G16wy3DW2xUT
 NCqX1i5rt58NsQ07N8RtiFjuELOps5qGDRZ1HE3MiOXwrZmLhf2Dm5M9+gmAOtWYwRKGBEKFY
 TNFZyyVf2ykZg+YHrm7ByYLsYHlm26FbBPib6/Bf+082+YKoYwkX66RFjJqQUWXZ41Rc4gF0N
 peyKmZN1BhETwtvGYrDSKgXXUYoksEeodwKTvUono=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 23 Oct 2020, Jeff King wrote:

> diff --git a/ident.c b/ident.c
> index 6aba4b5cb6..7743c1ed05 100644
> --- a/ident.c
> +++ b/ident.c
> @@ -384,6 +384,12 @@ const char *fmt_ident(const char *name, const char =
*email,
>  	struct strbuf *ident =3D &ident_pool[index];
>  	index =3D (index + 1) % ARRAY_SIZE(ident_pool);
>
> +	if (!email) {
> +		if (whose_ident =3D=3D WANT_AUTHOR_IDENT)
> +			email =3D getenv("GIT_AUTHOR_EMAIL");
> +		else if (whose_ident =3D=3D WANT_COMMITTER_IDENT)
> +			email =3D getenv("GIT_COMMITTER_EMAIL");

I *guess* that this is a strict improvement, calling `getenv()` much
closer to the time the value is actually used (and hence avoiding the
problem where pointers returned by `getenv()` get stale due to environment
changes).

Thanks,
Dscho
