Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A4BC4332F
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 11:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242948AbiDELcD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 07:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242238AbiDEKgy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 06:36:54 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D7653E38
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 03:22:05 -0700 (PDT)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 4136B5A0EC;
        Tue,  5 Apr 2022 10:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1649154124;
        bh=pVK9IcS5XjwSctdW/WaaHJoikWdBk65Vr1W5ARfwl+k=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=1DmdNo8aEJzIVhVgAJ2ets5PJ0LrEchcOmd44jRGFMe9GMPds8MxDPQ7co4l0f1bf
         IkP6GWjeRzvRi6ZOFTtERrIVBYaf2aYpCXDCVB52pANooxxN9LzCvATmG/6QaZsBuo
         SjLGxcjvMCibJxYP2RtnbfVuZ//Eq2Z45C8XYw1Bcv1NUz9z2UUR16tMCScQ6qzyWG
         OIenrdirZl/xfxMzIe0dOQZZzFYpzO8RIZhJ7jhCPSSf8cymXi7Gs8v8tMa+jExeWU
         OpeZzsYMf0ib2HtztQ8H7uRNVoPgmYj62qh3ubr8OPyipPmcwv8sWM8zksZuminHb6
         WJbI0cnGonmLx9dPHxFob7PzK+83OoPWUFwh6N99hhISpDLjt+svi+13+jMRQbAcfX
         Ie8WuLIjhMx6c2UF5tGcKo3cDqEF0yRueqRd3lkIuYfenPrzOYeGj93IMNWMUejkH/
         4NGACAEUNNbfyRmNo8haXvu0MCHYXqxkpsYDV/30h0AN3FkeZyo
Date:   Tue, 5 Apr 2022 10:22:02 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 3/4] builtin/stash: provide a way to export stashes to
 a ref
Message-ID: <YkwYSv7EitHaCQTs@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
 <20220329214941.2018609-1-sandals@crustytoothpaste.net>
 <20220329214941.2018609-4-sandals@crustytoothpaste.net>
 <220331.86lewqswes.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ifxWAyGOidZMRn1o"
Content-Disposition: inline
In-Reply-To: <220331.86lewqswes.gmgdl@evledraar.gmail.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ifxWAyGOidZMRn1o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-03-31 at 02:09:21, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>=20
> On Tue, Mar 29 2022, brian m. carlson wrote:
>=20
> > +	if (argc) {
> > +		/*
> > +		 * Find each specified stash, and load data into the array.
> > +		 */
> > +		for (int i =3D 0; i < argc; i++) {
> > +			ALLOC_GROW_BY(items, nitems, 1, nalloc);
> > +			if (parse_revision(&revision, argv[i], 0) ||
> > +			    get_oid_with_context(the_repository, revision.buf,
> > +						 GET_OID_QUIETLY | GET_OID_GENTLY,
> > +						 &items[i], &unused)) {
> > +				error(_("unable to find stash entry %s"), argv[i]);
> > +				res =3D -1;
> > +				goto out;
> > +			}
> > +		}
>=20
> One thing I missed on the first read-through, in the earlier commit you
> factored out parse_revision(), which now contains this code (which was
> here before this series):
> =09
> 	+	if (!commit) {
> 	+		if (!ref_exists(ref_stash)) {
> 	+			fprintf_ln(stderr, _("No stash entries found."));
> 	+			return -1;
> 	+		}
>=20
> Aren't we going to print both "No stash entries" and "unable to find
> stash entry %s" in those cases?

No, we're not, because commit isn't NULL.  However, I'll put this under
the quiet flag nevertheless for the situation in the next chunk down
(where argc is 0) where this is a problem.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--ifxWAyGOidZMRn1o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYkwYSQAKCRB8DEliiIei
gf8fAP9eB+RH70IycFlnrtE0uX22g6zVGcFurWJgihGhOzjlOQEAyxPWFir7CS7E
lbo9plDM9T5IDXjk4dj6aQANQKncigc=
=SgJe
-----END PGP SIGNATURE-----

--ifxWAyGOidZMRn1o--
