Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793EFC433FE
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 05:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239135AbiKQFqt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 00:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239064AbiKQFqn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 00:46:43 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3409E5F84A
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 21:46:43 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 6BA6C3201B5D;
        Thu, 17 Nov 2022 00:46:42 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 17 Nov 2022 00:46:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1668664002; x=1668750402; bh=xuPwI6sT9X
        LIDWpqNGO7uTx7tq6IsnSsXEQLV5d6fac=; b=cpmIa/+E7+WC1KKzFBWpCqW8v9
        PYUX9c+m38TecTFA6F85aQ4R822MYM2ZMfn1R16wPeaWfyOCt7lCtN9slFUAI4Is
        r/g1el1shv5eq2XYF83EWoWhx3yiypce8Aez4+TK+dNjgcPXyypFO0qJlPOl2o8u
        e4WqCsUlZaV+jfjSUEWvZLvMFOURjLHBhMjqPKJyK9lZuDgJbuUc8EHnLT8Vpw/G
        tC5jzPKydiRrQzsAOWvNFT4xK2tunBzcMIx5OJ8X1H4MYCVe6V38LVlXUY6OKhha
        dnvN7pJEuIm1F5N1rSEPP28yyc5Need2WyHUge6eo8Fxir/osboTIUmzkUhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668664002; x=1668750402; bh=xuPwI6sT9XLIDWpqNGO7uTx7tq6I
        snSsXEQLV5d6fac=; b=gxK45tC7ivlJJjzCBIHza5vcNw33mlRTc+HcbF5I4X8b
        8k4sy09x4RQ527Lvv984zr7urIsozWxUxbIMioHp+sNPZWmUNdgxoXEbwoO2KRKL
        BHFB0VYkJMIo8lV1ZKaUroj4H/2DICSQ9g7Y1mMy5pOTp8i2yJLI4U603AQZIBd1
        ISYpXniDhvqDmchXLMGhIcLY4PBvRlxU7q7EUm+UJWiwOizHjC6Uiw/Itqsm3wE7
        Olyf48JAgcJ/GH7YE2HpunLyNUMibIGFAEwq0Db0doGJGPAuFTFabrv6mZL4ay+L
        po8hLqQAXP/NaeCWwWevNrYNyYX86TUfB9qfzo81CA==
X-ME-Sender: <xms:wcp1Y5SEl5PE6Qt-zYR7j2WREjbdc7gl9LiVoJfSSQJaWghOEKc8eg>
    <xme:wcp1YyyHBtESRrE9eI8iAGRIKKeZHX-oGUdbAKEsyNHOIlOJuv1AlX9AvK4vdEM3h
    q5pROO0udydz1YxAg>
X-ME-Received: <xmr:wcp1Y-1tKZnh_z1OoHT0VKHQNcHTX19PvkYiR-WZwkY4_N38TRayLL5esDjyqpzLcUKHWIR_YndtZeVAyFo4h0UJtMCQaKIxo9I3NIU0PijWu_Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgeejgdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:wcp1YxAoxpDn16CZZmTdrHBc_br3v5UxMOK4K_7U5g7erQ1OYQslCQ>
    <xmx:wcp1YygzYbeZ8hzTDF16-bkK7DiOd2cnfJ-yhGZ9ptJO8SE-KY1QhA>
    <xmx:wcp1Y1pUH8Ib0t986rXTNEh2h0snAbmZDRcorcjpFuREKTbDafRDrw>
    <xmx:wsp1YzsrGHh2v55V_09meFoSdjaxRpn9edB3D-b9hI_ZpMH9P1S4sw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Nov 2022 00:46:40 -0500 (EST)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 9daff9cd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 17 Nov 2022 05:46:26 +0000 (UTC)
Date:   Thu, 17 Nov 2022 06:46:39 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: [PATCH v6 1/7] refs: fix memory leak when parsing hideRefs config
Message-ID: <ef182e4330bfc80ac4eaf26f186ef15ac5530fde.1668663796.git.ps@pks.im>
References: <cover.1666967670.git.ps@pks.im>
 <cover.1668663795.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8t0KTk1OWHJJA3Sp"
Content-Disposition: inline
In-Reply-To: <cover.1668663795.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--8t0KTk1OWHJJA3Sp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When parsing the hideRefs configuration, we first duplicate the config
value so that we can modify it. We then subsequently append it to the
`hide_refs` string list, which is initialized with `strdup_strings`
enabled. As a consequence we again reallocate the string, but never
free the first duplicate and thus have a memory leak.

While we never clean up the static `hide_refs` variable anyway, this is
no excuse to make the leak worse by leaking every value twice. We are
also about to change the way this variable will be handled so that we do
indeed start to clean it up. So let's fix the memory leak by using the
`string_list_append_nodup()` so that we pass ownership of the allocated
string to `hide_refs`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 1491ae937e..a4ab264d74 100644
--- a/refs.c
+++ b/refs.c
@@ -1435,7 +1435,7 @@ int parse_hide_refs_config(const char *var, const cha=
r *value, const char *secti
 			CALLOC_ARRAY(hide_refs, 1);
 			hide_refs->strdup_strings =3D 1;
 		}
-		string_list_append(hide_refs, ref);
+		string_list_append_nodup(hide_refs, ref);
 	}
 	return 0;
 }
--=20
2.38.1


--8t0KTk1OWHJJA3Sp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmN1yr4ACgkQVbJhu7ck
PpR4OhAAjZukTjvoSDvANn8RMj5APzGqox8CNHiKQR008ZuLfEJGnD+u4sGy6EGr
2v89QBDGOsw7ltOAVtLd7LGCwVnE+syP4JU49Kdt39vf4HiC08cqTwcaMb2NUDQd
5iwdkFs1drt+C9NyTtmNemycdX8h8t93cDEAoxFOvzGL0DeyrW9duNS/I9TL1VJY
nHLo0HxtxeFg6woMLbvic1qsvUR0/Z36I6J2uw93oPD4hrptvuoYLmecAQxavcbf
CrdPghHLEgR9ctHkfPLI9UIlrmIGsFhSd8IW9Wa6OFbjKjrZawOAzKaMoS1GrCg5
K1x+m+0IEWCwMcMnZ9/Q+hPeztqBs1KgI5uyXYLeyvsb6RTLvSnANb6mhG4/fcyf
s4TE7MtRoHQzCz55oG2R60xnnluHVpY9VTlptEoBq1TCv9UFw6k+FRLAl8K5TGd5
5sZM6Cai/pwFRMIB9FoKBzhV5RVCryIs7Ph2p1r9PEeq+KdKbx7RFaRZb5R6W6A1
CxNbFAj0d4jxgeNFoo4flr82dgxy2JhvXAA0DbfUhFnBAtowXL8dIvKD5Uipdq3d
XJd1JPn0olSdNoMU4K2nAVvjKvSKE3H3nHm5M/hFeNzRuSV7EMl4wGmB2sOTr7c4
BEBF9/fk3ev4VBrY5EL8Pucbe9h2xWNRZ6jgWEA5Pk4kKsW7l8k=
=lvzT
-----END PGP SIGNATURE-----

--8t0KTk1OWHJJA3Sp--
