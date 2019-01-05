Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9ADE91F6A9
	for <e@80x24.org>; Sat,  5 Jan 2019 17:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfAERjy (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Jan 2019 12:39:54 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58188 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726252AbfAERjy (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 5 Jan 2019 12:39:54 -0500
Received: from genre.crustytoothpaste.net (unknown [138.237.15.57])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 222C260736;
        Sat,  5 Jan 2019 17:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1546709992;
        bh=wra3YrOxt+LqUmneIXlykuH1LTOiB0jyNiRYXs5h5GA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=l1OSwydl/ZELbF21GL+hdmt7IFtWT7c6DVa+mZUVidlpAIroGiEFUt3X66xwIVjbt
         Q2fDWZAdHol8i4sK4Yr5LLM2DyJGddJwYKIXfEPKruwDIuFTdaWA3tTskylkwmDX84
         HkESp5t/cgrnUPxM5TbisU1dBBZ5HYfVd0GYn3TZTZE4S5NfCJzj5Q+uPqT8H5gKaL
         qJMaZBvK58OMum4/CzIc1S3p9kdq/PXlb11n2i1YLS5ufTuiQbJHQzc/C1KjzAQFGk
         ahyPCjqVdA/DUco6Dy1L6cCfYo6w7+Wsf6fHNM609+DwcuMMF7ONmn364hUBXxt2I0
         okL5yxrGLoZgzdl3LOL72jMCFk2wlOtTAicqgPvNKqjlfzVES+aa1dG8HpB7nonr1J
         td98Ric84ScLQIxaW2QqFH3qQRMT+9B8Z+F6IthmUCa3EjIskCj2qJpjw3TYO4ozC4
         PVP8RcNBdPBRYAog2QVv+UrJ7PYf9ARfu+VSdLnfFh4iNjGpiOO
Date:   Sat, 5 Jan 2019 17:39:44 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] diff: add support for reading files literally with
 --no-index
Message-ID: <20190105173944.GH423984@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
References: <20181220002610.43832-1-sandals@crustytoothpaste.net>
 <20190104021855.GB97188@google.com>
 <20190104025724.GG423984@genre.crustytoothpaste.net>
 <xmqq36q8cjgf.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5vjQsMS/9MbKYGLq"
Content-Disposition: inline
In-Reply-To: <xmqq36q8cjgf.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--5vjQsMS/9MbKYGLq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 04, 2019 at 11:26:56AM -0800, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> >>  - --dereference to control whether to follow symlinks
> >
> > This is actually surprisingly difficult. The reason I implemented this
> > only for no-index mode is because there are actually several places we
> > can stat a file in the diff code, and implementing a --dereference
> > option that catches all of those cases and getting the option passed
> > down to them is non-trivial.
>=20
> Another thing to worry about is symlinks that point outside the
> working tree.  When a tracked content "dir/link" is a symlink to
> "/etc/motd", it probably makes sense to open("/etc/motd") and read()
> it on the working tree side of the diff, and probably even on the
> index side of the diff, but what about obtaining contents for
> "dir/link" in a year-old commit under --deference mode?  I am not
> sure if it makes sense to read from the filesystem in such a case.
>=20
> I personally am perfectly fine if this "do not compare readlink(2),
> but read contents literally" is limited to the --no-index mode.

That's a good point. I think I'll stick with the current design, then,
since that seems like the least surprising way forward. It also means
that we don't read outside of the working tree unless --no-index is in
use, which may be beneficial for security purposes.

Thanks for a helpful perspective.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--5vjQsMS/9MbKYGLq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlww6+AACgkQv1NdgR9S
9otVjQ//Rw7WCaTTmcFw9du97RVvRpcGaAbr0RPzKPlYt+s6q7UyvGjjHtCrDHvJ
KVuX83m86J8KbnhxqTIJCQZnRg13qkaZfTkYLmVJT0lNFaWZ+eOh3OSzoSfjVpq0
/6R1T/pLE3dCtGRXdjM0aV2x3Vuuo/wL2XNhavC5QQplogXxcdZL3VGQHImWMym5
wOmr1HrJ3LS0uiN+Nn42blAp/CrkSvUwjM3LuUzbM7piMXWXOy0LWVuM/N42Gt39
O3mi602lAy6kShfQMN6fSdUdMPFYv3JjKUJOxQQf25giWMvcEmUz6vxPRwdGbA6R
aOfmRmfFoF9oTaR/0jOcDVEyr1gkqWm5LnfkUGPHKIAT9MvNIJysRRn04UEryo14
KoESm3WSBMVRu+lPwnoSZKJq2PKcxTHFhmu4+A/OkYsPyViJ5NWL2dJKW3EdmrOV
3S26zq6zyZcg4WdTJ/YMQscVZ4q5fGFXHEBx7CIJP7M+IOkTCVphd1jnHBd+l5YR
7dEcyeJ6Jl+APRkgfl2ThpcPUTCKiaKhAdIGpnnkPfF9dkqHYvgrMNoUJIAQ2Cq6
AKqnv20rWnnJlXercijKMXK6R1AktyT5L8YegAq8IP64Eh8XQcwj/Gj0hzL69Mh7
4O5OFVlIOH6NqR6XkPL8pxAKdM0fdqml4IKIxoFPELYp8k7Q2xM=
=5t4y
-----END PGP SIGNATURE-----

--5vjQsMS/9MbKYGLq--
