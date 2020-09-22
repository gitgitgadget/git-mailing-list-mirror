Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F2FC2D0E2
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 09:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0E012075E
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 09:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgIVJRx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 05:17:53 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36176 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726424AbgIVJRw (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 22 Sep 2020 05:17:52 -0400
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0385260734;
        Tue, 22 Sep 2020 09:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1600766241;
        bh=p3KiinETyWjaeyZI2F/HVw/mNfvHNHHwahuwB1XSmYY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=dJfoVTDWLH2AdU8Ejld2ZzDul0PhZocMp1hULSZQiKwnIfAlupsCc1qxV+NgoKgub
         YO7RvIeoX9PpmFxyweX4CG4upB5tDNmDll/SeZPgqaHxks02pbOnhirfxYwIVqgP5k
         jF/We8z7hHFRw/5BVGkk26lXn4VgE+F8t0QJuonqe47A6Wqpw38rwL8WkYZSm3RDGo
         C2+pgNsiXbclPG0yuKVnxc7wkq+6XRP0uw92Iutrjd2dKOwAes81IHXsRjnouPNc8X
         7aOGijC9mBzUqlcm/LZ0a95hnl+a0e4lyPsZ+zGltHDYLs8MhGfshfSDaX9TDUXjzc
         W5rjhf0tNZKNG8ZmXpRhb8E2ZICeUmzpz4C0gv78YronfBtapDEXTgpjGaT/tkuYi6
         SviPUyFGUcmZQn5D7fQ/974IulIoM2YedAWJzncSNopJnrH/TecT2M70PjOZq8yfe0
         5TiD1W/RRJ+C/Vnds2sudK98TDg8hPqR44HHb9hkL/y70xxtJBX
Date:   Tue, 22 Sep 2020 09:17:17 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Matheus Tavares <matheus.bernardino@usp.br>
Subject: Re: [PATCH v3] builtin/clone: avoid failure with GIT_DEFAULT_HASH
Message-ID: <20200922091717.GP67496@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>,
        Matheus Tavares <matheus.bernardino@usp.br>
References: <20200911233815.2808426-1-sandals@crustytoothpaste.net>
 <20200920223541.1299038-1-sandals@crustytoothpaste.net>
 <xmqq4knrhhzx.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="A6Z7MKnLVMfR85kG"
Content-Disposition: inline
In-Reply-To: <xmqq4knrhhzx.fsf@gitster.c.googlers.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--A6Z7MKnLVMfR85kG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-09-21 at 04:27:14, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > +test_expect_success 'clone with GIT_DEFAULT_HASH' '
> > +	(
> > +		sane_unset GIT_DEFAULT_HASH &&
> > +		git init --object-format=3Dsha1 test-sha1 &&
> > +		git init --object-format=3Dsha256 test-sha256
> > +	) &&
> > +	test_commit -C test-sha1 foo &&
> > +	test_commit -C test-sha256 foo &&
>=20
> Unfortunately, the 'foo' commit is created in test-sha1, but the
> next step to create 'foo' in test-sha256 fails with
>=20
>         fatal: unknown repository extensions found:
>                 objectformat

I'm not seeing that with this series based on master
(385c171a018f2747b329bcfa6be8eda1709e5abd).  I'm doing this:

  make -j6 all && (cd t && GIT_TEST_DEFAULT_HASH=3Dsha256 ./t5601-*.sh --ve=
rbose)
  make -j6 all && (cd t && GIT_TEST_DEFAULT_HASH=3Dsha1 ./t5601-*.sh --verb=
ose)

And getting this output:

  Initialized empty Git repository in /home/bmc/checkouts/git/t/trash direc=
tory.t5601-clone/test-sha1/.git/
  Initialized empty Git repository in /home/bmc/checkouts/git/t/trash direc=
tory.t5601-clone/test-sha256/.git/
  [master (root-commit) 946e985] foo
   Author: A U Thor <author@example.com>
   1 file changed, 1 insertion(+)
   create mode 100644 foo.t
  [master (root-commit) ff872d8] foo
   Author: A U Thor <author@example.com>
   1 file changed, 1 insertion(+)
   create mode 100644 foo.t
  Cloning into 'test-clone-sha256'...
  done.
  Cloning into 'test-clone-sha1'...
  done.
  On branch master
  Your branch is up to date with 'origin/master'.
 =20
  nothing to commit, working tree clean
  On branch master
  Your branch is up to date with 'origin/master'.
 =20
  nothing to commit, working tree clean

Is there something I'm missing here?
--=20
brian m. carlson: Houston, Texas, US

--A6Z7MKnLVMfR85kG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX2nBHAAKCRB8DEliiIei
gfT7AP9/G8EwXKir9ST4iPHksL0ZlRD84VITOjjGaKE+ndi9EQEAtp5LnCvVLaoA
YI5IRkRCqiiGiiI/NnCS9tvEIpEbOAk=
=K4j1
-----END PGP SIGNATURE-----

--A6Z7MKnLVMfR85kG--
