Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C94C07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 06:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91C1F60FF4
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 06:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237949AbhGTFvL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 01:51:11 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36077 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230505AbhGTFvH (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 20 Jul 2021 01:51:07 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 06B645C0103;
        Tue, 20 Jul 2021 02:31:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 20 Jul 2021 02:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=yPcrGqphBzi25Gn/Du+heNEdBBr
        xy7Nz9mYrk/whbN4=; b=s24VOgyBbPALz7n5550968tbD2WV3jYrIV1TL27b47C
        5DT1ME57QL20xjVnT2pzt6ZwrNkZXrmIwR5/neINUDE3yTtylaDk+KMm5D8Ptdyb
        GVit7e5BpxgU3PWw1WRbls6JwiScYzCBaOfjByA0c53YJrwOeKpx6FnpsPKjXHFe
        H2bL0PMt8AaUGalh1Fy1gH3AKBtY1xj3GMikJbEDAchH3Rv2BZnWlYSwtV5165QD
        xpY36KfV9Uy2tp3zt1LH35ZAI+SjoP+UcyUxt4QTRq5LXnz95+X9VSGrEDGaj/hJ
        eWGrVo0mX9+n2cNzzZ0YCrHA4eENHzBK8jNXY1MdDMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=yPcrGq
        phBzi25Gn/Du+heNEdBBrxy7Nz9mYrk/whbN4=; b=kn0CESeecoCUx3vMJ6OaAI
        XPNrQMyC9mPm0ZAzNY/mBI4ueoYitU2RGrFyPFUYAPKYkPkKNWaDfIOmKCMk1LMi
        YmPal3+9O1/iy9I0/ZiEOHBnUrYyEhNMY82YeU2zgbZ4tlIXUT0svDX1CgL2Iypn
        5evd3E0E534/+lF+wiCMjYs8ceHNvBL7g0/2VcYzS9asti/uTEBDKMRt/G+k/ayx
        LCrsUwYbzas1TJeoo8hSPLNK9B9XSMjsO28mmX8n4kNb6Ynr9ytmRNfx1cORUu6T
        taJbp13kScvfm+0V37W8xuqO1ptCBst4UemQun/PCQMg2z6JvJ7w4gtokbeUBdmw
        ==
X-ME-Sender: <xms:zm32YCBc5oniMhG0hPJPLxiCM648Dk04qZyw_YvrGBIGlCdvVtmeRQ>
    <xme:zm32YMgVUKOTfMkDmyhR6qeRC7wZOB-CBiUrRYYxUeuPCDVKPoOjvbuaEwctiGdD6
    2ZgTNmH-wolnEuNhA>
X-ME-Received: <xmr:zm32YFlOa_iMljjWjPsUPnmfVyo28Fr9d_F2bGw6OvuI7GeCalSPhJItMwzrU_lY4jP89j_3ZXTRJavmEYm7dJdelgEm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrfedugddutdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:zm32YAy-A9s82MpOuyedH5Ozwqn4ceUuZkhCApSEZZDe_eYU_zaYdQ>
    <xmx:zm32YHR3qnSuMwju2ACJwl1ENI72H-QAn9i0ri1RcmB94GMhaXumtw>
    <xmx:zm32YLawvQs0dwtcAoe4SeKb2GT0TLqFxBRC_51fPKljv_LL1BIhhQ>
    <xmx:z232YCd_ufZ9MiPX9prWgMFPTzQZSI6pITgHFgFTftCHS6_o-wUrig>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jul 2021 02:31:41 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id befe53bb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 20 Jul 2021 06:31:37 +0000 (UTC)
Date:   Tue, 20 Jul 2021 08:31:35 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2021, #03; Tue, 13)
Message-ID: <YPZtxy1/742YlrlK@ncase>
References: <xmqqmtqpzosf.fsf@gitster.g>
 <YPUrSB8+zEur+ZBt@ncase>
 <YPU48uSCxXbsjvGW@coredump.intra.peff.net>
 <YPVW50Q6oyTxQ4D4@ncase>
 <xmqqtukqkuzr.fsf@gitster.g>
 <60f5d923848d3_145c71208cc@natae.notmuch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pj0VnTzjBlAeDctd"
Content-Disposition: inline
In-Reply-To: <60f5d923848d3_145c71208cc@natae.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--pj0VnTzjBlAeDctd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 19, 2021 at 02:57:23PM -0500, Felipe Contreras wrote:
> Junio C Hamano wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> >=20
> > > On Mon, Jul 19, 2021 at 04:33:54AM -0400, Jeff King wrote:
> > >> On Mon, Jul 19, 2021 at 09:35:36AM +0200, Patrick Steinhardt wrote:
> > >>=20
> > >> > On Tue, Jul 13, 2021 at 06:07:12PM -0700, Junio C Hamano wrote:
> > >> > [snip]
> > >> > > * ps/perf-with-separate-output-directory (2021-07-02) 1 commit
> > >> > >  - perf: fix when running with TEST_OUTPUT_DIRECTORY
> > >> > >=20
> > >> > >  Test update.
> > >> > >=20
> > >> > >  What's the status of this one?
> > >> >=20
> > >> > From my point of view this is ready, but it's still missing review=
s so
> > >> > far. The lack of interest seems to indicate that nobody has hit the
> > >> > issue so far, and I wonder why that is. Am I the only one who sets
> > >> > TEST_OUTPUT_DIRECTORY to a tmpfs directory in his config.mak to sp=
eed up
> > >> > tests?
> > >>=20
> > >> I had marked it to look at, but just hadn't gotten around to it. I j=
ust
> > >> gave it a review (but the upshot is that it looks fine to me).
> > >>=20
> > >> I don't set TEST_OUTPUT_DIRECTORY myself; instead I do:
> > >>=20
> > >>   GIT_TEST_OPTS =3D --root=3D/path/to/tmpfs
> > >>=20
> > >> TBH, I had never really considered using TEST_OUTPUT_DIRECTORY for t=
his
> > >> (--root predates it, and was written explicitly for the tmpfs case).=
 But
> > >> I also think --root is more convenient:
> > >>=20
> > >>   - "make test" will run in the tmpfs for speed, but "./t1234-foo.sh=
 -i"
> > >>     will run locally, which makes it easy to "cd" in to inspect the
> > >>     result
> > >>=20
> > >>   - likewise, I find accessing the results in t/test-results/*.out a
> > >>     little more convenient
> > >>=20
> > >> But all of that is preference. I don't think you're wrong to use
> > >> TEST_OUTPUT_DIRECTORY this way, but the above points might be
> > >> interesting to you.
> > >
> > > It is, thanks a lot for the hint. But given your first point about
> > > direct execution, this in fact makes me want TEST_OUTPUT_DIRECTORY in
> > > contrast to `--root=3D/path/to/tmpfs`: especially in the context of p=
erf
> > > tests, I never run all of them together given that it takes such a lo=
ng
> > > time. So I instead either run them directly or via the `./run` script,
> > > and in both cases I definitely want to have them in tmpfs given that
> > > there's a lot of disk churn if you're using biggish repos.
> > >
> > > Patrick
> >=20
> > Thanks, all.  Let me mark the patch for 'next'.
>=20
> OK, if you don't care that TEST_OUTPUT_DIRECTORY is broken, so be it.

I just think we shouldn't strip away features if we should instead look
at why the testcase is broken and how to fix the root cause. I'll send a
patch in a minute which fixes the testcase without dropping support for
TEST_OUTPUT_DIRECTORY.

Patrick

--pj0VnTzjBlAeDctd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmD2bcYACgkQVbJhu7ck
PpRnlQ/7BPkm2ZXfJ6pVp659C1zeoIQONld45zusSd2vhZwFIi0s1/+pjvgsumb+
mSef104wFK4n3kVt7L8hesUiRc0QNbJrj6wb7HpYKVI9v4uXuo7KnHwcSoY/5LdX
QDClE3olB295oy5u5osMoRmeUEVFbbhx62zC9wsnU7d0Mbne1LW39OE/VbJzneVB
PV0ApIp1N/grHT0EeB9/KJmRsfUjQZu6GUYGb+ATryZ1NsrTbXU2LSC9GTAD6zqa
qnMWYvNnoGx3wn45spsHAn9g2siABtBASTfWQWDuLDnGy7odaKKzawQy6Q4n+iBx
vq4uD+T+/2SgsWXS5UwxV1AWR5LMLYGFYkQh9WjBo/IbmNn0b5Inic6s5ScImf4k
2Jsqjnqi08Q6aTXPvF5/x+Y8f7LzrKtQidAAnLlYCXASBhGMhaGQ9b2Sru5ZAcGR
KwD1nV0kpAn7ugNufrnyxGAcpR6esaq88yDoGpqQ2VTPx9kx8Q5AS6bzzDiIw/48
O5/qIawwWACaEc089ltv6sXFb66kvp978qZ/afTDkVUY9vVNr+sj7k84j4J8OneA
hPNRXfYQ95FwrRqiOLvNPRyWlR2yKmSzCOnYdPhb/6y6H9f4a3y3qE/2Jp9l1Fqp
3FVSu+TjWSsjUBgdMbrrqDvgyL51UfKtNy+FJf0FyTB3/PzQsw8=
=5foe
-----END PGP SIGNATURE-----

--pj0VnTzjBlAeDctd--
