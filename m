Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 002A81F453
	for <e@80x24.org>; Fri,  8 Feb 2019 00:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfBHARO (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 19:17:14 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33848 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726718AbfBHARN (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 Feb 2019 19:17:13 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:d42:63e7:5548:1ee8])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2F62F60129;
        Fri,  8 Feb 2019 00:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1549585030;
        bh=EqGQbdridjQ7Y6TU+Ipr2OplkKvUOVtNZXsvLt7SxJk=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ZSQvA/yIJKGaYpmzO0R+AaqgnPoUHOv0ztseJymJFWgzkTK33eX3PKRrw1tGdCvSJ
         6+4uKVVCtjx/X7oXCwiuE1W2uOoOlku9vChMAQrH67GYvNd2yj7EJpvnDeMdgzllqi
         Qd0vHUCM63We6IVbSKkWJd1v8K9nkuiO8rZipUwALZHf0WEr4ge1r/GrI1axT/vb98
         flYhFd8ZNqphn1ibf8E0xiWHv35oGEgGipKRF725MxbvDWJdvBymVUhKkszgg+9weO
         SjCb4jrXh89YY/JHxkNTXEsuTYm4BjUI+CpLrGHFeKz4myrf+S/MUMizIG+49N355O
         fmVqcL2UFYA1tMOdJQi7PBu7nAcKn9Q75o424GtxmL0CxkSgSgf8sPp5Simm6wWmwf
         CXztkxwh4Q81pYWz2+JJc7tLcHFzY79dbt7npnsibWu7iTS0kBuI2Yn74AZH6gV8Af
         iwihi+c6jPdiIJRe2oPutML56S+1JZkZqdnq4xZJqD7piVxZ1Dw
Date:   Fri, 8 Feb 2019 00:17:05 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Kevin Daudt <git@lists.ikke.info>
Cc:     git@vger.kernel.org, larsxschneider@gmail.com
Subject: Re: t0028-working-tree-encoding.sh failing on musl based systems
 (Alpine Linux)
Message-ID: <20190208001705.GC11927@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Kevin Daudt <git@lists.ikke.info>, git@vger.kernel.org,
        larsxschneider@gmail.com
References: <20190207215935.GA31515@alpha>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2/5bycvrmDh4d1IB"
Content-Disposition: inline
In-Reply-To: <20190207215935.GA31515@alpha>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--2/5bycvrmDh4d1IB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[Please skip using Reply-To and instead of Mail-Followup-To so that
responses also go to the list.]

On Thu, Feb 07, 2019 at 10:59:35PM +0100, Kevin Daudt wrote:
> I'm trying to get the git test suite passing on Alpine Linux, which is
> based on musl libc.
>=20
> All tests in t0028-working-tree-encoding.sh are currently failing,
> because musl iconv does not support statefull output of UTF-16/32 (eg,
> it does not output a BOM), while git is expecting that to be present:
>=20
> > hint: The file 'test.utf16' is missing a byte order mark (BOM). Please
> > use UTF-16BE or UTF-16LE (depending on the byte order) as
> > working-tree-encoding.
> > fatal: BOM is required in 'test.utf16' if encoded as utf-16
>=20
> Because adding the file to get fails, all the other tests fail as well
> as they expect the file to be present in the repository.
>=20
> Any idea how to get around this?

I think musl needs to patch their libc. RFC 2781 says that if there's no
BOM in UTF-16, then "the text SHOULD be interpreted as being
big-endian."

Unfortunately for all of us, many Windows-based programs have chosen to
ignore that advice (technically, it's only a SHOULD) and interpret it as
little-endian instead. Git can't safely assume anything about the
endianness of a UTF-16 stream that doesn't contain a BOM. Technically,
since the RFC doesn't specify a MUST requirement, musl can't, either.

Even if Git were to produce a BOM to work around this issue, then we'd
still have the problem that any program using musl will write data in
UTF-16 without a BOM. Moreover, because musl, in violation of the RFC,
doesn't read and process BOMs, someone using little-endian UTF-16 (with
a proper BOM) with musl and Git will have their data corrupted,
according to my reading of the musl website.

In other words, I believe this test is failing legitimately.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--2/5bycvrmDh4d1IB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlxcyoEACgkQv1NdgR9S
9ouLRg//RnNMac5JSyAnNduEKVuWb7aFHgf14PBd83mm5VBLL31BriC8wCK4MvaB
bIn34gbIyKadh9cYim0a9ezNDk1+qOScr/hIQ9Gh1zW0zWeFVGAoR1Z8bSvXgf8J
8f9qhGmD0RPpgEVN3q6U9EPzx9PGZI5hi6GsM5fsTOE6sLdYeNhe9y6ch7ThHCAj
Mb7aZUhZhiZ11vc6XPvoRhPW+EZdw8WhN4rIubIbwAELCiJjcZsZE7BjZ4AmtilQ
WeKWp1cstKzRF205FAb6e8Al7rMJDt7PE1lwI9NHJCHhVTmJIOeE0rLVAfLByvjl
liTG+F8Susu9VrtR1vUHlfLb9abgYSC06htEeJhYZ7SlYQioDrGkOsE2F2nVBEZH
vZPOEll8D8NAbfaFXozaObF2umoNjQFrySHzn8EnxzwLz7ZToCDXXa9sQYZj0iWI
1aXBecMcmNqV+JyMu2hthwxlUFMOmFBiJUQyMoDZVuBTF7ujhEHQEID07xYVqQO6
EiQlWF5FnFD/JdhLOfp+BTKTudtmIFrZUhSVqmn+csW1XCXvCs8Dm/QLW2IT23vK
ecUsAiKEuV7scKR9K/GTU9Y9aRfMtSxvkLSoNqzZ7TZNoDStSkeGxQf7n1Kpc718
BtzgnK29zpdw/2Gu20Cl1EssuWiblx8vBjz6oklqKIR071HmmIc=
=+PUh
-----END PGP SIGNATURE-----

--2/5bycvrmDh4d1IB--
