Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0161BC433E7
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 14:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9904C247CA
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 14:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="FodoiVVi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388401AbgJMOKH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 10:10:07 -0400
Received: from mout.gmx.net ([212.227.17.21]:57321 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388390AbgJMOKH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 10:10:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602598181;
        bh=Qmc9MaMQ8MdWlSmaHiurCCRLNoIk3ebymgO4jOwW+Yc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FodoiVViF68cty9sG68o32CK+Td2zphSSlO45bIRsbyZn0jJq9Kn71MSox+enXjmo
         BJk2+QFwUq/wAF64ORTXzNTxbqMRRR/ZxOegayhwPyxUZ1ZBjUAtpMKMf805rKKfVs
         LwDXtOwIqx2aMYcdSafahEk47vd3DgJYCBA5qx3c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([89.1.212.188]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3DJl-1kTALI2t13-003ac0; Tue, 13
 Oct 2020 16:09:41 +0200
Date:   Tue, 13 Oct 2020 14:02:05 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Micha=C5=82_K=C4=99pie=C5=84?= <michal@isc.org>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] diff: add -I<regex> that ignores matching
 changes
In-Reply-To: <20201013063646.GB3278@larwa.hq.kempniu.pl>
Message-ID: <nycvar.QRO.7.76.6.2010131401110.50@tvgsbejvaqbjf.bet>
References: <20201001120606.25773-1-michal@isc.org> <20201012091751.19594-1-michal@isc.org> <20201012091751.19594-3-michal@isc.org> <nycvar.QRO.7.76.6.2010121315170.50@tvgsbejvaqbjf.bet> <20201013063646.GB3278@larwa.hq.kempniu.pl>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-709682026-1602590527=:50"
X-Provags-ID: V03:K1:a0LeBG7ABBAuP6YiY0Ev9cHxbAhoebzcmjwuargkSulG0rBW3Q6
 nATXWRWLdfN59a4M+GS1l3rEyQf31pHTDlJHDS+Z3z7NHfu7jDPiNBID7brsLN7onTEWZlE
 Z1RV09YScRAD3quw88owLrN1ylLEyL1pTsUaYYZ2SWcBWcVYqOmiP2f4S0xr2Qb64zyMR7H
 +exhLZht8kZg5whbXKf9g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7LFVaU42Ix4=:nAPqi8Q4cJbt7SqkDxR9dc
 1jbiVAfk6kvYjV8PWBc+EOR+IoKN4nq/PNdOy683Y37385D+oRLEaU26D1tyQrPo/UEN4w+Xk
 AxwuL+nCOXtZfZJBnMcznqoKqvTUUGWNMg+eaey4lwAVSKsl7TbkKcFmAJSaCqWEaFaEQCjwT
 wE2gItAA+IXgBYFcQOYGRKkOVi/BhSNKTQYLm8g1XCfJbdcSU2tYlsVJf/vwAf700tCXbvXQ+
 LNqr4N14uT9HVpJDTuMKeAnNRqy+z/Ydvdtr4tXfLlHQISgVXcRmUUNTtuSnM1yxvbuTE/41I
 RyV+DS/hxJhdC5eqv7bPyC1A0wabazkOFgOOpM6MEF9trdfu/zU0onzjm7/ZEch3Plwen1tou
 ApmzsZuW4laZHkogMIPKW4E8CA7QAcm0RGhtJqldlLDXOYdB6dkolYZS9DzdQNJMvLvcRYSlZ
 J2h75YWHMs8bXN4/EHqsvHpRVk5z50Ye51lHS/nhOHRadbdxMrrBnoAYEfAZUrcIVYpmh+7s3
 LzpXih7FSm9WxAgBNMCdzm9Hbl+mMylfkDMH8YQQvPYJkJYIXmCWMOSLCu8NGQBonovQm/O/k
 10MXFw0f8n2FRERqERCseMmKahutzA44yQX2Wc7oUFnIHPOPyqHZBEU6ZqW6j6UOb+BqL9TtF
 bb7OBq82v+ElfxlI4kB9lWX5nGWeVEem1yWDYcLS1s6A/elCZNrf5rmEsvzPWMOI/jDdo2wlk
 M27kkpjiX7uJVAunmeEb2GiL7CwSReo6YVMf19rYzKBzQ94RqBQ5lZt499HvO5/hzKeaA4UuG
 tmtP4p4Gu234OpUJLaC0oFlM2MwuaFGN8Qgw6s7Mgy7p3FmVs2eK+DDKvQMxdZMEzFFAK1GEF
 RD+L2Gkriq4XY+LTaAoB03IDWWIR0SGdC+t8PS2Q8AZIswP/dJRbvlgWpDmzp1URmzq55bEfx
 HxW7pyRszxMvqJgeEop/dSD3xuNjpVj7iew3g+pWkznfAW6Tf0C6IRrzLhpD8v0zF1zAsF600
 SqXd45nmzW0iYSNxWmhyqM2/t4M9MlAXZQ6H9TwR8YmCpcb/VergY/0uDHxHYe69ujBLnygjs
 GfDal1ZgOjliSh40vgpYuplcXOERHUi0yh+cvy2yXqa8d9wrFO0HS9CDb+UBCTGdbxIZf4eQB
 ouoDESJ/ATBRQstwysOTVwAaY52yeuj6rdhVgi/OZ8eHcgONex0DURV/BDeErnwQINsvob+Mg
 Zngy3Kq0OCYWWzxVCmTUIDArE7ESiXP7T2Qyzug==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-709682026-1602590527=:50
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Micha=C5=82,

On Tue, 13 Oct 2020, Micha=C5=82 K=C4=99pie=C5=84 wrote:

> Hi Johannes,
>
> > > @@ -5491,6 +5511,9 @@ static void prep_parse_options(struct diff_opt=
ions *options)
> > >  		OPT_BIT_F(0, "ignore-blank-lines", &options->xdl_opts,
> > >  			  N_("ignore changes whose lines are all blank"),
> > >  			  XDF_IGNORE_BLANK_LINES, PARSE_OPT_NONEG),
> > > +		OPT_CALLBACK_F('I', NULL, options, N_("<regex>"),
> > > +			       N_("ignore changes whose all lines match <regex>"),
> > > +			       0, diff_opt_ignore_regex),
> > >  		OPT_BIT(0, "indent-heuristic", &options->xdl_opts,
> > >  			N_("heuristic to shift diff hunk boundaries for easy reading"),
> > >  			XDF_INDENT_HEURISTIC),
> >
> > Are we releasing the `ignore_regex` anywhere?
>
> Oops, I tried to mimic what is done for 'anchors', and I failed to
> notice that apparently the elements of the options->anchors array are
> only free()'d when --patience is also used and the array pointer itself
> is never free()'d at all.  Given this, I believe I need to fix
> diff_opt_ignore_regex() in patch 2 and also make sure that the memory
> allocated in diff_opt_anchored() gets properly released - in another
> preliminary clean-up patch?
>
> At first glance, diff_flush() - specifically the part below the
> 'free_queue' label - looks like a sane place to free() things.  Am I
> mistaken?

Oh wow, from a cursory look it seems as if the diff machinery was not
exactly careful with releasing memory. I might be mistaken, but if I am
not, then this would deserve a separate patch series, methinks.

Ciao,
Dscho

--8323328-709682026-1602590527=:50--
