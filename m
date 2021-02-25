Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3238C433E0
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 05:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33B6164E6C
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 05:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbhBYFiO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 00:38:14 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:43591 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231786AbhBYFiM (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 25 Feb 2021 00:38:12 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 17D7F5C00E5;
        Thu, 25 Feb 2021 00:37:01 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 25 Feb 2021 00:37:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=v6owwrqUjXXY2EhE/lH/SV6dNCq
        +CdhyhiSfWw7OlxQ=; b=rPmJRHCxI2VFY93sHvsQKoQG1KVRktFBln1wthgnsZB
        6KljsFOkjZDv/FsltHJWNomSt34lRtYjvnB0le7tV8dIA1DRlZ3rjZsz+gUh81yV
        ekWGzXpA7RWHPNjc72Fgqid8SselGV/lJpKOcc/loMBtr9IuZCREFwi+zieL97Fm
        eTp9Mxc98IpGi0+D1VVVXjIV2JqHOUFxrwOCOGHSRT7d8HtCx/n3R69R+ZU60Dll
        w6cxKVvOvM6pROjRa6wZ/zcN5HatH9EPm3+mrZlOO4n4I1EYYlFcHe5AFmgK/Vu/
        XSf0EaChdvqL1A1QjsX70d21dqZYRreGBZXCOJ8FOCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=v6owwr
        qUjXXY2EhE/lH/SV6dNCq+CdhyhiSfWw7OlxQ=; b=KG92eeJif2tQ0l7rkbakAN
        O1EecQF6/KlkwpTYKOVizEkU5sROSHJxIML3sHtqecrEehcwxDf5q5oVp9HRNwUP
        QEe/ggoHnxtkIT6nti7P3ZjUaZDAVQ4HXp2CndLTA9qCIpFC9fGo7s/EA5C1M5v6
        ydss1Xxn2ObqQJUBKeuuvKxztwHcUVl5Su/bG8JMUR6Tb9ZgCQLHxJYPj+QF17ZE
        aLtBaALU5ME3dnMRCBCbL1Yxqzvr5mofBXlabTzeu/HdPOIIDJbYdID3ddagcRxX
        VobFpk/Q9J9FvyYb3OPzcOVC1vPzF7API8GpzVPDKWqtzwpWPjFB3HAvyRclx2xA
        ==
X-ME-Sender: <xms:fDc3YOfkF0dJdxj-kFxHjpVKiXkHXPtM_bLk6E0fbzhcRA5TKqVM3A>
    <xme:fDc3YIMcvlunaPGeABLqWjGzIby-R3j5NEUPHxrlSNbfSIvdN5xSZzOFfv_u8D4uV
    1O4SvZOxHIeoZniCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrkeekgdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    kfhppeejjedrudekfedrvdefrdelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:fDc3YPgttLcd_yU4u_H7iTS2yl5deV3QiMgNre-BQJi02c4t3D_c5A>
    <xmx:fDc3YL_Oh84kbxMMzHiX6WqGePXDyAnmA_uwYXM3cqU6K8BLGbfkpA>
    <xmx:fDc3YKtl6mmb4oHan8iS9AbnFtwo6ST-BcAK8Csqj99rEB6E5OZELg>
    <xmx:fTc3YA0S7GvqPTePNvTm5rxqTHzoEflTOK2Hpu9WD0WuIbNBny-_oQ>
Received: from vm-mail.pks.im (x4db71709.dyn.telefonica.de [77.183.23.9])
        by mail.messagingengine.com (Postfix) with ESMTPA id 29901108005F;
        Thu, 25 Feb 2021 00:37:00 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id fb02c8e1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 25 Feb 2021 05:36:55 +0000 (UTC)
Date:   Thu, 25 Feb 2021 06:36:54 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     Yaron Wittenstein <yaron.wittenstein@gmail.com>,
        git@vger.kernel.org
Subject: Re: [QUESTION] Tracking HEAD changes?
Message-ID: <YDc3dinQ37FY8fhD@ncase>
References: <CAGgn8PdU1GE_CZdGUpJWKzygd0O+Yn2BnAFGmPfKAxFpoVoqUA@mail.gmail.com>
 <YDROhhrM5qJti1ir@coredump.intra.peff.net>
 <YDVo0kGYODP0JjqT@coredump.intra.peff.net>
 <CAGgn8PcPtLNtZTmMqKKTmH3KOezkr-jY7aTEDA-0dvYWuzid9A@mail.gmail.com>
 <YDa/EupbrNa62r+D@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="24+QGE2eblW82e6j"
Content-Disposition: inline
In-Reply-To: <YDa/EupbrNa62r+D@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--24+QGE2eblW82e6j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 24, 2021 at 04:03:14PM -0500, Jeff King wrote:
> On Wed, Feb 24, 2021 at 10:21:55PM +0200, Yaron Wittenstein wrote:
>=20
> > That indeed seems to do the trick.
> > I've done a little experiment and saw that when doing git reset the
> > hook gets called.
> >=20
> > However, when switching branches the hook doesn't execute :(
> >=20
> > I don't understand if it's intentional, since when I've moved to a new
> > branch HEAD pointed to another commit id.
> > The only workaround I see here is using the post-checkout hook in addit=
ion.
>=20
> Hmm, I would have thought that the branch switch would trigger the hooks
> because they're updating HEAD. I wonder if that is a bug (or lack of
> feature :) ) in the transaction hooks, or something Patrick did
> intentionally.
>=20
> -Peff

It was done semi-intentionally, or at least with the knowledge that
symrefs aren't covered. This is mostly because they're not covered by
the reference transaction mechanism itself.

But this again reminds me that I still have to update the documentation
of the hook to at least make it more explicit what's currently covered
and what's not.

Patrick

--24+QGE2eblW82e6j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmA3N3UACgkQVbJhu7ck
PpSRqg//cQAXbJIiK2fSHlWPfxBZuyw9AbCsRYknylExj92B/FZ06XRi8oNZoijy
DiY3HmHf5BmM1btj8KgnHdxyxhzxOQ/vSdDSGhEDHgr33bfO/VeSIA4aig1IwzbQ
hRlWxXj43T8upXrGhkY7xffOjbEJa3Ky6o5GWIU9TBwZEyFbW+YT6geE3H3hD6Ra
xg1ikcprDDhzYUrhmyapeQe7YvkxqGG4lGodiBT0X8V2VVOhXzOIXXATX8Zv70gd
YY6I06ilBqk0P1RSksRRr2o3WBCbDUOf3wrwf/KTN8Qk/Qb0EMdpGdKQcA5N136S
c20EwwtiYPCt5xOxserUwEoP4Rb92A8kkaIEkoMjYTpZt8QV7diiRpkdR6mTEUha
EJbZSKOt31zC9C4qHKw00cFL9zszL2+rTZVZM9mwqEAzNwiQl/oumSR3HNNhSU+T
Zq15eBrjWF4peRhATROUNopXH7vieV+tF/QVLWV5r8yoZtyTNuPCgvmeLCakAWCZ
jtHXainV7+j3O9yGQiNWo0ZSBxT0Jchx+llBCCLCwVHwlgdc0sKKWJUrSUIvKh6e
29x2SoJ2e92Q2RWCTxgHrJie1SP1VDKDKqfRpKKIedvMrGSBB12MZVPyPySR1G6s
dwp+o/YjFUz9nxayL/iPH34y5+j/K6I9x0TITPSJT3o7syr6YAU=
=G6lE
-----END PGP SIGNATURE-----

--24+QGE2eblW82e6j--
