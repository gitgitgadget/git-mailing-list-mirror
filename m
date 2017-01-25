Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 658931F70F
	for <e@80x24.org>; Wed, 25 Jan 2017 09:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751847AbdAYJ56 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 04:57:58 -0500
Received: from mx0.elegosoft.com ([78.47.87.163]:48633 "EHLO mx0.elegosoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751798AbdAYJ54 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 04:57:56 -0500
Received: from localhost (x4e340422.dyn.telefonica.de [78.52.4.34])
        by mx0.elegosoft.com (Postfix) with ESMTPSA id DCB9516C790;
        Wed, 25 Jan 2017 10:57:54 +0100 (CET)
Date:   Wed, 25 Jan 2017 10:57:54 +0100
From:   Patrick Steinhardt <patrick.steinhardt@elego.de>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/4] urlmatch: allow globbing for the URL host part
Message-ID: <20170125095754.GA4096@pks-pc>
References: <20170124170031.18069-1-patrick.steinhardt@elego.de>
 <20170124170031.18069-5-patrick.steinhardt@elego.de>
 <5BF60E6DF2C04DF081466BC3BD3F954F@PhilipOakley>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
In-Reply-To: <5BF60E6DF2C04DF081466BC3BD3F954F@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 24, 2017 at 05:52:39PM -0000, Philip Oakley wrote:
> From: "Patrick Steinhardt" <patrick.steinhardt@elego.de>
>=20
> a quick comment on the documentation part ..
>=20
> > The URL matching function computes for two URLs whether they match not.
> > The match is performed by splitting up the URL into different parts and
> > then doing an exact comparison with the to-be-matched URL.
> >
> > The main user of `urlmatch` is the configuration subsystem. It allows to
> > set certain configurations based on the URL which is being connected to
> > via keys like `http.<url>.*`. A common use case for this is to set
> > proxies for only some remotes which match the given URL. Unfortunately,
> > having exact matches for all parts of the URL can become quite tedious
> > in some setups. Imagine for example a corporate network where there are
> > dozens or even hundreds of subdomains, which would have to be configured
> > individually.
> >
> > This commit introduces the ability to use globbing in the host-part of
> > the URLs. A user can simply specify a `*` as part of the host name to
> > match all subdomains at this level. For example adding a configuration
> > key `http.https://*.example.com.proxy` will match all subdomains of
> > `https://example.com`.
> >
> > Signed-off-by: Patrick Steinhardt <patrick.steinhardt@elego.de>
> > ---
> > Documentation/config.txt |  5 ++++-
> > t/t1300-repo-config.sh   | 36 ++++++++++++++++++++++++++++++++++++
> > urlmatch.c               | 38 ++++++++++++++++++++++++++++++++++----
> > 3 files changed, 74 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/config.txt b/Documentation/config.txt
> > index 506431267..a78921c2b 100644
> > --- a/Documentation/config.txt
> > +++ b/Documentation/config.txt
> > @@ -1914,7 +1914,10 @@ http.<url>.*::
> >   must match exactly between the config key and the URL.
> >
> > . Host/domain name (e.g., `example.com` in `https://example.com/`).
> > -  This field must match exactly between the config key and the URL.
> > +  This field must match between the config key and the URL. It is
> > +  possible to use globs in the config key to match all subdomains, e.g.
> > +  `https://*.example.com/` to match all subdomains of `example.com`. N=
ote
> > +  that a glob only every matches a single part of the hostname.
>=20
> [s/every/ever/ ?]
>=20
> the "match all subdomains" appears to contradict the "a glob only ever=20
> matches a single part ".
>=20
> Maybe borrow the example from the 0/4 cover letter
> "so for example `https://foo.bar.example.com` would not match in the case=
 of=20
> `http.https://*.example.com` " (If I understood it correctly.
>=20
> A simple example often clarifies much better than more words.

Thanks! (Hopefully) improved this in v3.

Regards
Patrick

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJYiHaiAAoJEBF8Z7aeq/EsXCUQAIjNehfTtssBK2Om/ySkKe86
kFqt1tDFPodikAjotjRMopyC5nGNe1U1oluwFIqbBXAuTYcivmKKdoXighBXJbVf
Nl82yjM0j5q6LGnxdWXWIWWDV8mV6OawB8ejzK1LNaidYoDX8vR+2xwnqasXrO1d
tzlsftoHsU3Ik+zqWfypF+laZv4rVlKPdqm6f4JfAdfGF2vhsbuzVupSnnPs9zSR
I3Xk86kufytDSVWP7EDdhWHTMFEKQbmLfN6gZBu3PTqweUNDiOFu7eyZNejASOKX
iybpdW/wCgV21I/oayE5VIOcPALVW9nIqlB8C4PXK4NG5fuFbJnhtYLOepQoeaNZ
z6OZKnEiQfsynrdPf7AFKVK5VRmGp5QmSLULDxoNcrHI3Ij1UECfq7SCk28R5B+U
LujxMdXhCVrfy1+ODx5WO5PgHkgygQ63mL8V862nowlbMhCmdzxgrTKHZ2ES7ZVg
rEnls2FMxN3s8gOmFkc2N3NQmR7ouu62xIqopsKb2Tj92/VkcdLeoeuVbYZkWHBd
Q4IX/T7V+InMDC/OJeDrkMByik3tDoqvF/4OyP5l3EOddttie4vDvB/MrqqJdAYo
FRDUb0h9nfJ3UxCQbjkJgllvy6scRVmcx9Hbpri+H+3r1VkyPBHHKOTuvKH6je3i
wMsh3wSoVM/WxSUDAC10
=8W8x
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
