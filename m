Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359D9C43381
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 06:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8AF122E00
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 06:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbhAGGh6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 01:37:58 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:40061 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725763AbhAGGh5 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 Jan 2021 01:37:57 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id A50815C00E2;
        Thu,  7 Jan 2021 01:36:51 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 07 Jan 2021 01:36:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=NhcY0U38xKkTr7cUtve+a17n1ok
        jzjChAKiQALYXLhw=; b=wbGCnW7FM3tuszC6/YG95nycbDc94j7fIWNAfEXmuD2
        4VaBqjwEeNouYfFy33Ke+e1PGAxjf+4c9gqzuWoO4qweHRV+eLlRhJ9dletyR7bl
        qlGFbQaIzJXB+OtdFfHNpshBJZDMMshGG71aZc1qNBEZ5gaj2AszBdyEvUEuiXQc
        BLJn+2SR/MiPaydjEfcOi/GWLxiiMkirohBxZ5auGRNPUhcKBQqEurxXYNmyeBDW
        UklaVB/qbr74oXVFVrGVSJ82L35OfUpx9KK990Lyd4cZj0Y3NurfChLcGVXT6OGO
        lRZ4GJ6QT6fm7MvXOaALgzcrXb2sBV+v+OE9KNip6EA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=NhcY0U
        38xKkTr7cUtve+a17n1okjzjChAKiQALYXLhw=; b=r0DAlH8XUfxSvwZtg5aJvb
        9NOXNV/TooeotB6MEQ0qKl3HvjPku1FYoFLBOiCOXNKKY/ffLrz9Pfgy+MdsR7Js
        NxXILhenuVdv4F+Yed6RPp4vcQKc1Wy228sCY7Ste0Em0HC5g4hUNqAh48lH2xG7
        vFCK+bO54hAfPXj+rQSltBnVGz7Cw8hLPuzYblzeZaCA0qClneOdpQoT1ZgneMZ8
        KwUUG78M4/A7Z3hvT8lD58W3n1BjLT9aCRH9HYL03Rr57cw8Nqs+ncoJrm5IS5Ys
        8esncIEEH6mwlFn9hCzvBQGKNPgUTaJ+Mq8fZEhPHA6JLXNqzW4cpuHU1njTDJ7Q
        ==
X-ME-Sender: <xms:Aqz2X6Q_aDRHC2NfLECfOOGo4tykczIvbv0Lh_g01FdlwlNGv_UyEA>
    <xme:Aqz2X_yMtiSfsWPNfisxTx35lqjd9SsNUKG0YqOXshPkMegiRAyjQu-LiQqsTGxl8
    kGE4ZMhYqXWvI7JNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeguddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeejrddufedrfeegrddvfedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:A6z2X33HFBw31xONLmVqgse3cNaNJtWHgQeOFV1ghX5v1nOeAM4Oug>
    <xmx:A6z2X2CqMjIyzA0Y7YbQEuVXckoC5bwjnc7turxxUOsbc8P4kdmPMg>
    <xmx:A6z2XziPaHHn_leRi6L4Zjs3HTdeRuAF0Clg43eAiMKrLk_AoFJrbQ>
    <xmx:A6z2XwtIAkcVE3MgFsRn8NDX6ogGlT4A-cd9qHxDx5_J8A8ZjtMOvQ>
Received: from vm-mail.pks.im (dynamic-077-013-034-232.77.13.pool.telefonica.de [77.13.34.232])
        by mail.messagingengine.com (Postfix) with ESMTPA id 26972240057;
        Thu,  7 Jan 2021 01:36:50 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 3ecd311f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 7 Jan 2021 06:36:48 +0000 (UTC)
Date:   Thu, 7 Jan 2021 07:36:47 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v6 1/8] git: add `--super-prefix` to usage string
Message-ID: <cd3de0743a258485c79c4690b6c907728104930a.1610001187.git.ps@pks.im>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1610001187.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bIlzZN8jorHM/GUc"
Content-Disposition: inline
In-Reply-To: <cover.1610001187.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--bIlzZN8jorHM/GUc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When the `--super-prefix` option was implmented in 74866d7579 (git: make
super-prefix option, 2016-10-07), its existence was only documented in
the manpage but not in the command's own usage string. Given that the
commit message didn't mention that this was done intentionally and given
that it's documented in the manpage, this seems like an oversight.

Add it to the usage string to fix the inconsistency.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 git.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git.c b/git.c
index a00a0a4d94..5a8ff12f87 100644
--- a/git.c
+++ b/git.c
@@ -29,6 +29,7 @@ const char git_usage_string[] =3D
 	   "           [--exec-path[=3D<path>]] [--html-path] [--man-path] [--inf=
o-path]\n"
 	   "           [-p | --paginate | -P | --no-pager] [--no-replace-objects]=
 [--bare]\n"
 	   "           [--git-dir=3D<path>] [--work-tree=3D<path>] [--namespace=
=3D<name>]\n"
+	   "           [--super-prefix=3D<path>]\n"
 	   "           <command> [<args>]");
=20
 const char git_more_info_string[] =3D
--=20
2.30.0


--bIlzZN8jorHM/GUc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/2q/4ACgkQVbJhu7ck
PpTuRg//VM1GjlKjAvWNkUwQbxB1ogO9wZhoONE4WkTLRgI+CIN8h/Z9+Z1A0YVB
vJTI3yI+Uohzx4NCaOhfSfzmXbINzi0/nxHI/dMI799Ujp7d16IUY9dhKOBNHsvH
oua6nrTOUUtprLORzPqNj0VJQOcHWtdjb3spfhguNCiMxeyrmqw9/siJMBz9uu0v
Q4PSMQuB7LiNFHCHLJjnqnzSyG05XLYY/eGrBg0VaYRH/l4biPa/80DzFLvHSVDv
4gfXi8AOI+hLqbMEq1Mh+YGFSlfpNBxvxRTpCNI13TQ5fUiomSQnOqw2WaoRcmB0
a/V9zBhinzkht05nLHgEMGbwk3zQ+Xd6VEwg4RilisVeJDR18HvFxsrGKu8mXnKu
Fr1A1YuUiVCHI6XAr0kNxkDRgC6JTpo83k6GC7pxVbL+Nef5Do7WQaZuDbu7RhRg
uV7AwOPAboMOJ1KSNh1yqNOuYUDvXYX0tyBb/KN40OuZyf4lsRgeaNRUJ0zNDcWw
h32Ox2THQadcNP67fPuoKn+wG6Mr7Is2hLQjQsByPnUPw5oRKP+0H8rKWxKTtqMZ
+RX7w6HCZhcRAbM33xNfS014F2sCEhmgD6UxZx8kj1RI9YSpziK5jXWdOWtkUHnv
DqJdTVhJauDyhr658X0FVdlBb3ChWpDkSzRY9cNGc88HbFxEJ6I=
=DGdI
-----END PGP SIGNATURE-----

--bIlzZN8jorHM/GUc--
