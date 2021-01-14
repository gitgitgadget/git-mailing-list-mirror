Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAEEC433DB
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 23:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AA6123A59
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 23:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730576AbhANXTk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 18:19:40 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:53258 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726506AbhANXTk (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 14 Jan 2021 18:19:40 -0500
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8493660781;
        Thu, 14 Jan 2021 23:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1610666309;
        bh=dnF4ko0qoi2wLcicZrflEhEnvWG6EC4woFWuKhy03rU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=hGtbX2GdO3eJ+cfbPbmjl9zUFHXFf8ZSh/tmhcRFyjH3AWP4h4eBtsSvNXVprN+Kf
         yA6vqtkttAqmCrUZsolcJRxW7sneK/rPlw75B/89NOMiZUPKIRc/bZ3yNhO85ROpPn
         i4Od6YwYEYIZh/XfruV2x7Imi9/YQAEvo0nAlQs0KaGvCzsJVqS2fYXyqYp88/hYeJ
         c1WNXliRwA9LyMXFzFBDznCWUQZIeZXcQuHcpsDCsPmpCwBss6o/Ze7tVG774Z9oOY
         rS9/2H1wI8LME6GRLNBogme1Hr528MPYCHhEfmy6S7f12DQax7//nDkTsRd1hdNfqS
         U0ijNUQpT7ItL2vww1+4rqMLhDZpqdAEiPx7yaGIZHGSmefgMZ+4x4GsvLF00c6ipc
         ww8+a9H7qcST1KeWWGz63Mf/b1LDRp4uE9Bk8rhxal6tsHrvygmr33pY95MCiYrqrI
         erQvYg4eoIdFTZ/74XuloFS3YnodWFvbgKkSO6edOWtPRMJTzCX
Date:   Thu, 14 Jan 2021 23:18:23 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/5] gpg-interface: improve interface for parsing tags
Message-ID: <YADRP22NG15AHoAB@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>
References: <20210111003740.1319996-1-sandals@crustytoothpaste.net>
 <20210111003740.1319996-3-sandals@crustytoothpaste.net>
 <xmqqbldu699q.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Lxi/+Mz/jTrRlrSX"
Content-Disposition: inline
In-Reply-To: <xmqqbldu699q.fsf@gitster.c.googlers.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Lxi/+Mz/jTrRlrSX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-01-12 at 04:58:57, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > diff --git a/ref-filter.c b/ref-filter.c
> > index aa260bfd09..8d8baec1b5 100644
> > --- a/ref-filter.c
> > +++ b/ref-filter.c
> > @@ -1215,7 +1215,13 @@ static void find_subpos(const char *buf,
> >  			unsigned long *nonsiglen,
> >  			const char **sig, unsigned long *siglen)
> >  {
> > +	struct strbuf payload =3D STRBUF_INIT;
> > +	struct strbuf signature =3D STRBUF_INIT;
> >  	const char *eol;
> > +	const char *end =3D buf + strlen(buf);
> > +	const char *sigstart;
> > +
> > +
> >  	/* skip past header until we hit empty line */
> >  	while (*buf && *buf !=3D '\n') {
> >  		eol =3D strchrnul(buf, '\n');
> > @@ -1228,14 +1234,15 @@ static void find_subpos(const char *buf,
> >  		buf++;
> > =20
> >  	/* parse signature first; we might not even have a subject line */
> > -	*sig =3D buf + parse_signature(buf, strlen(buf));
> > -	*siglen =3D strlen(*sig);
> > +	parse_signature(buf, end - buf, &payload, &signature);
> > +	*sig =3D strbuf_detach(&signature, siglen);
>=20
> "unsigned long *siglen" may not be the same as "size_t *siglen", and
> the latter is what strbuf_detach() expects to see.  This breaks
> 32-bit builds e.g. [*1*].
>=20
> I suspect that all these ${foo}len, including the parameter to this
> function but also the four local variables in its sole caller, would
> want to become size_t.
>=20
> Thanks.

I'll reroll with the fixes for size_t and unsigned long.  Feel free to
drop the series if it's causing CI to fail until I get around to that
(likely this weekend).
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--Lxi/+Mz/jTrRlrSX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYADRPwAKCRB8DEliiIei
gUuVAP9gj7Clj60h0q1UAvawi4sjaK8UuB+hkOs2c8EOmTirlAD9FHAo5Q16KFxk
8T88L/dUJoL3rEvEuLcaxz7n1+5gJgc=
=Pgs/
-----END PGP SIGNATURE-----

--Lxi/+Mz/jTrRlrSX--
