Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A06C7619A
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 09:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjDLJiB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 05:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjDLJh7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 05:37:59 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD8E12F
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 02:37:57 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 069CE32007BE;
        Wed, 12 Apr 2023 05:37:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 12 Apr 2023 05:37:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681292274; x=1681378674; bh=tJ
        oKomdzT0BjDNWJCvsJ0u6DxdfrFFzZaiqZiVg1Y8w=; b=hYDDyRa99w/5lucLw1
        ImpOwHRcw/gT5sJGzF/MNXDOB5PqisVKljhAO1XfkZg30D3f8+N9xFWzwKFzPZep
        7N82otySM42mgPJeRSbmbtL8YpJBJUzoUPwRxRZtSlhqi3/xGiS19TQhf1I/amP3
        0hxi/Rtnf6EgVGe5AvK5clsGoqlv9Ls2oeD7gF0R4Zf8lY15YboGxLeYbo1/5upq
        pAVqluboFq/wEwRbeqOBHfLcab97+jnmtuzYW1jPvczrOm7drPFXnG6Rfc0YukFI
        8X/cVSS5xmCySAWgyDZ0vE56QWzEJWwSs/a9nHykcbVOnFXVDiEvEs6a8bvCn9DH
        JrFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681292274; x=1681378674; bh=tJoKomdzT0BjD
        NWJCvsJ0u6DxdfrFFzZaiqZiVg1Y8w=; b=c6R7sUMMeAbJH50+BseC+DEBkczAJ
        qoGPsqvQUCmR/HZi6UVKQOPc6tQY1D4aim/Y0+jtpzJfgzJZz4DlCjI5perhi6sR
        DFcXO39d6aZcbFim+sKW/GNAgNwx6Wro0CQ0MHFZ0GIWHc01QfWCnkHl2Zfg9+p3
        xkr+R8z/2Fy/9dMKolOjmn+E0nE6SvkxI4ENA1FwZCFdfVQ5NuAGwUcikQAtj/Ia
        9mtUpLfQiIPlSdge+Gk3yLqZQZYruG3SJGfsnn8EAfieReh3of3K2lKzkYfCJpoq
        HY6BpdzPJWX3vxucPd6+dCQj1y2KhCk1JScL4w+G7GLEJ7o9cnVEiVl3Q==
X-ME-Sender: <xms:8ns2ZJojSjFbc2R_n3r3HnaOPt4L6KZAHkMsZXGrmzDYzFucTfILWg>
    <xme:8ns2ZLqgez4LyUeHmn_A9_fzs8PjlGqevdj6EUR5a-Cge-gkupGvAd-WGzPDlTVP_
    uiBC8iOBHIwspcjmw>
X-ME-Received: <xmr:8ns2ZGPj4hvfX7xdyom_D3WGEei9ACOMZhvda_ZSpd5NM_v6Q4gJs5o4bmIa7yuAzW7HS9Zk5UzqYWtFaa_Lff0zXU_ELYF3SnmZrttosYc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekiedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:8ns2ZE4vDXbSmLxeV2BkONJw3JLSEGbaawiUXCGGj0Qm8t1Q0CBoBA>
    <xmx:8ns2ZI78SJhuQd63mp97jWu1_KQZN127k6Ax4BFx29VMAMjDyC1fdQ>
    <xmx:8ns2ZMi4yeGVo0TzPLmeQP1TcfCWuLRLCWtxPnRSX2dqH1NOMl73aA>
    <xmx:8ns2ZGlvVTe7XA-ixejfxhJ-lf12imRhLH4Ycx4k-pAIo5ZVu4aFSQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Apr 2023 05:37:53 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 3579dd79 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 12 Apr 2023 09:37:30 +0000 (UTC)
Date:   Wed, 12 Apr 2023 11:37:47 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        peff@peff.net, dstolee@microsoft.com
Subject: Re: [PATCH] repack: fix geometric repacking with gitalternates
Message-ID: <ZDZ7661iNaWW9Vj7@ncase>
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
 <ZCxytq1esQWvjIz/@nand.local>
 <ZC0eY8q6ushpfkrQ@ncase>
 <4c7b95e1-9d3c-e253-98ca-ac6c201babb3@github.com>
 <ZDSgbYa+j/5c5t8j@nand.local>
 <ZDWVSuFJLU54txwc@ncase>
 <ZDXNaCYV+DhxaBt3@nand.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AXqWhN2z1twE6eG3"
Content-Disposition: inline
In-Reply-To: <ZDXNaCYV+DhxaBt3@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--AXqWhN2z1twE6eG3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 11, 2023 at 05:13:12PM -0400, Taylor Blau wrote:
> On Tue, Apr 11, 2023 at 07:13:46PM +0200, Patrick Steinhardt wrote:
> > So ultimately, we would only ever write an MIDX containing only local
> > packs already. It rather feels like this is only by chance though, so I
> > think it is good to include your patch regardless of whether it actually
> > does something or not. Better be explicit here, also as documentation to
> > the reader.
>=20
> Doh, this is definitely right. I even wrote that code a while ago; shows
> you how good my memory is ;-).
>=20
> FWIW, I agree that even though it doesn't do anything in this instance,
> it is a good safeguard to have in place, so I think including it in your
> series is the right thing to do.

I was wrong, it actually does fix a problem, just not the one we thought
it would fix. When all packfiles are non-local, git-multi-pack-index(1)
would end up returning an error because it cannot find any of them. So
by skipping over these non-local packfiles early on we avoid spawning
it altogether and thus avoid the error.

Partick

--AXqWhN2z1twE6eG3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQ2e+oACgkQVbJhu7ck
PpTS2g//W3H3JEecuBzcW0JwVEG0rLJysZj/nvbr+HqkPvKgE+ICgI8vyUN2EvD9
0fF27ll3pVYCpmJpT8lXh92e27DIeTu7i9qFu4hohkgI1/Sp4X3mE4tRZi0GSdLB
VAJH1PMbMTQZ/Y0iklv6qXxzK3KxzFFTjHTIdNUr+wojAozsuUOb5qRQSSgqF5Uo
5tzgKs5hnK9RFdohgCdZcp7a6cczp1OqPOaxGk0zWyfM6BYWodM8KrV2WiIssa5w
/2SazJ2i3mImstUO8YyS8Sv7TCbzUr1vAAHgj2zXS/GLrh/H4M32GWva5+9mk5KJ
zjIKk04/HyUT4jf9UESByuG/cOiTFofr/Rj2QWb2/0Uybi1JxRGjIX+xn0we/pXs
XcCO0Nyi4G5IK1dk3KccGLGRKAMHaeFoOdf40TibbtUiIQ5GN4aVioiNa6cNpibQ
2NcnA9643WPGWiC6k0hnoTG1Cd2gz3Pw56xGDTNIuQMBQzQQSV+xBSuMuSKP5FgQ
se0o98KT3AwLzw/Jv7f2DKhUJAay6kBn3E2/w+Vgr/DGyt7efUCJyMLnADesFpaz
/kj3E9hQzeZUuUmEpNOn/CyePbRNRja+2XTT1QJBOmX7jumb1yle2mrfosQ5faAg
CXJKpszlu2p0iyX9bTKgYbq0kai/H1E/uUxpq4mVohxI+U2Fio0=
=2dXA
-----END PGP SIGNATURE-----

--AXqWhN2z1twE6eG3--
