Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE57C388F7
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 08:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B6C8217A0
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 08:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UZ6UkeW8";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f62j26o3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbgKMIIz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 03:08:55 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:33467 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725866AbgKMIIy (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 13 Nov 2020 03:08:54 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 2C4185C00A4;
        Fri, 13 Nov 2020 03:08:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 13 Nov 2020 03:08:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=IN5KADwKDzeBpr4UkkQ5g42X/Sm
        ePhIC4ahuxhiwRg4=; b=UZ6UkeW8q7yqWphYXew7hYvobi1ypPSaGdx80C5P6lR
        lSBfPBVEYw3SJkWhXJ/6XNJ3Vy2aOknKF6txbGFliJp5Bf1kq8yZgF+Am/dbHdyQ
        fxLokFY9zom18fYlJ8nFuQqB24JeilSZ5klB5Vcj2DGQGzBha3HG2wx6hfjNs37r
        kGDW2E/TyO59uxEepJu4uJZ18zom5TUfXkdTlvEMlZ+ydQS/MxcXuIrhb0o9c4HK
        KNWWTEL+VfRV0fsT4ZzqWHxJ5760w2gjsv6ACmycUUiFCLDQy3CprGf0o6FPrF+k
        jCVjBMaSoDdYBVBHwHCCp/kCLgBsesmLayfVJ5o9tTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=IN5KAD
        wKDzeBpr4UkkQ5g42X/SmePhIC4ahuxhiwRg4=; b=f62j26o3Htw1IzmNTU3Tpn
        JWC8AAU4KZe8gPJm55X9wA9sGMyq0bkVDs2QEKYI8Z2RSZI1kcu4NGLSN/maCAMe
        ZBxlB3Y49rh+IM/wBL0WKY2Fp4wVlgsN14bYiVaPsoMZlqRYS4WNMQqO3eV2oXNE
        XpyRpEwNKxu1E51hzY0HlZTCY7IshJ4SZvJN3lMhPWDCxvNSas8dS7+A6Rd6TeVa
        dVjx+JcEdPv85HgmRbdj+bCXmla2keDeho6ycfii6om0il3MmY/e6+MGSXNG4CaP
        6uta/ukU+Sq3HAAQ2syDOX+nosrq8G9gZYx+GanB4nC+gG0nJaptW4eD+m6oQHwA
        ==
X-ME-Sender: <xms:FD-uXwnfHhbSNFc-KCUHSbooE6h5ioRkOcM3hSqwHBJ-Hn6gjk5gLg>
    <xme:FD-uX_0oydkpir6VCP8gz94TRRH_3AGbC3X8kNByGtixb7yuqM99lCH1Nwl5bvcCK
    Zk9ERWs45SRz0oq2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddvgedguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucfkphepkeelrdduvddrfedurddvfeehnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:FD-uX-oZFpzwEeoBWRyhvMc-W0m9yGh5zKb5YCoRJBlMZKQB1fAEZw>
    <xmx:FD-uX8mwTGV7mAPq3__7wKzq4XBDLqX6Fo0xnaEDq4BR_1u6aupAKQ>
    <xmx:FD-uX-2fC4whYe0S2q6pE-Nb7qOyIcO7b-YlQdvVSrZAoRAvirTvUg>
    <xmx:FT-uXz_KEBaVMpUOmNqfXpmdvKh35Xa1PTExJCh-uetAZszJF01iIQ>
Received: from vm-mail.pks.im (dynamic-089-012-031-235.89.12.pool.telefonica.de [89.12.31.235])
        by mail.messagingengine.com (Postfix) with ESMTPA id EF9A73280065;
        Fri, 13 Nov 2020 03:08:51 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id f0c64e46 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 13 Nov 2020 08:08:49 +0000 (UTC)
Date:   Fri, 13 Nov 2020 09:08:49 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v3 1/4] t1400: avoid touching refs on filesystem
Message-ID: <X64/ETgmrandZ8l3@ncase>
References: <cover.1604501265.git.ps@pks.im>
 <cover.1605077740.git.ps@pks.im>
 <e66b1bcc62139f62866dc9f25856eaebfe107056.1605077740.git.ps@pks.im>
 <20201111230659.GA632312@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EyqdS50YLYbrNXej"
Content-Disposition: inline
In-Reply-To: <20201111230659.GA632312@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--EyqdS50YLYbrNXej
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2020 at 06:06:59PM -0500, Jeff King wrote:
> On Wed, Nov 11, 2020 at 07:58:38AM +0100, Patrick Steinhardt wrote:
> > +# Some of the tests delete HEAD, which causes us to not treat the curr=
ent
> > +# working directory as a Git repository anymore. To avoid using any po=
tential
> > +# parent repository to be discovered, we need to set up the ceiling di=
rectories.
> > +GIT_CEILING_DIRECTORIES=3D"$PWD/.."
> > +export GIT_CEILING_DIRECTORIES
>=20
> Do we still need this, now that we're not deleting HEAD? I think we do
> still delete a branch via HEAD, but that should leave an unborn branch,
> which is still a valid repo.

Good point, we don't.

> >  test_expect_success "deleting current branch adds message to HEAD's lo=
g" '
> > -	test_when_finished "rm -f .git/$m" &&
> > +	test_when_finished "git update-ref -d $m" &&
> >  	git update-ref $m $A &&
> >  	git symbolic-ref HEAD $m &&
> >  	git update-ref -m delete-$m -d $m &&
> > -	test_path_is_missing .git/$m &&
> > +	test_must_fail git show-ref --verify -q $m &&
> >  	grep "delete-$m$" .git/logs/HEAD
> >  '
>=20
> E.g., these ones should leave a valid repo (and must remain HEAD,
> because it's special for reflogging).
>=20
> > -cp -f .git/HEAD .git/HEAD.orig
> >  test_expect_success 'delete symref without dereference' '
> > -	test_when_finished "cp -f .git/HEAD.orig .git/HEAD" &&
> > -	git update-ref --no-deref -d HEAD &&
> > -	test_path_is_missing .git/HEAD
> > +	git symbolic-ref SYMREF $m &&
> > +	git update-ref --no-deref -d SYMREF &&
> > +	test_must_fail git show-ref --verify -q SYMREF
> >  '
>=20
> And now this one is safe. Good.
>=20
> I wonder, though...is it still testing the same thing as the original?
> This is not related to the use of SYMREF vs HEAD, but wouldn't show-ref
> similarly fail if we had deleted $m, but left SYMREF in place (i.e., if
> --no-deref didn't actually do anything)?
>=20
> Perhaps this would be better:
>=20
>   # confirm that the pointed-to ref is still there
>   git show-ref --verify $m &&
>   # but our symref is not
>   test_must_fail git show-ref --verify SYMREF &&
>   test_must_fail git symbolic-ref SYMREF

It would be, but I bailed at this point because we don't actually have
"$m" at this point. But agreed, i'll also include this into both tests.

Patrick

> >  test_expect_success 'delete symref without dereference when the referr=
ed ref is packed' '
> > -	test_when_finished "cp -f .git/HEAD.orig .git/HEAD" &&
> >  	echo foo >foo.c &&
> >  	git add foo.c &&
> >  	git commit -m foo &&
> > +	git symbolic-ref SYMREF $m &&
> >  	git pack-refs --all &&
> > -	git update-ref --no-deref -d HEAD &&
> > -	test_path_is_missing .git/HEAD
> > +	git update-ref --no-deref -d SYMREF &&
> > +	test_must_fail git show-ref --verify -q SYMREF
> >  '
>=20
> Likewise here.
>=20
> -Peff

--EyqdS50YLYbrNXej
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl+uPxAACgkQVbJhu7ck
PpQA0Q//b3bojMkzGLksHD3NXMCzdZLdnSwrTeK8wsvZSd+ciuYscDrxaVl8WNey
QDW/wkFEubSgMFJjCPvxHhXQ8hm2OjT6HttLbxKJW7fhidOFoKA/6ywVDPwRdy6L
anub/YOsIunv001OweEcDWQVs4+bKSthzMN6R5N5NTtMMexF5rtEXY1gI6N3YyAu
YcCbx0tpeUgCVb0PcbC97tZv0LIp4SybSqzeSt0h8070BRR9CWG7bmXIwq5RJcyN
NsNDZkxpovkSR1++eY6235ttJdozBRZNPURpd99ck0+0vNtGXtlSeIwk7boGZH5F
Mmpx/Zrgh77bDSMC+2cBg2b/LO6dKu0OmUk29vC7L4CGvXuFXk6HMU3AFRPNEc13
PNNZYuh/EEegjKTszhhtAkrOJoHhNOkbEOotadBFAoGfrwplUx/uuyJs1uGpKVnO
WaFLUr81RXcBn/U8tfEZnV1H8ClXSBmIx2P35ANHsYjCX0ArG4OsdC9GohMbU1SQ
QFnFSv361qXMq6d1d6Z6qEA4wSRgfsMcOuDzZPOSnSfnCfjNdRj8ofl5QoEx+94g
xtf2ux+LmyXspTkGFFjoRQOB9sgCtWi4OQ+aHucOv/zxbG1kX5AV7LXsUclIhEaD
LjccuoGhcnX3POIqsKzZkj6B6fO946xHjvl0zYe9foHFi9tG/eY=
=zZdE
-----END PGP SIGNATURE-----

--EyqdS50YLYbrNXej--
