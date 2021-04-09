Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B54C433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 11:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5ABE61177
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 11:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbhDIL2I (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 07:28:08 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:43561 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233530AbhDIL2I (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 9 Apr 2021 07:28:08 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 42F115C004A;
        Fri,  9 Apr 2021 07:27:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 09 Apr 2021 07:27:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=vUkJjMbAaKnoAL2luhpkldKlHQF
        JyUo2e/y+BcVSD24=; b=HHWm52cZxR9EKS5yQ34C+yiNuiLbndCUCOzeqnp/glx
        0NDvr6WtnWl9peOoB/UpvLjG4I/NHN/Ghmid+zCHaZiA0JG3aaHXhPBlnBXlce72
        9tQ9stWRl64IIERBx4TxxCRxFNO7FqWR+pwM12Fs7JvSNDLHrWYMTl/r+LsamZCA
        Pr9sfroGPZHIdI+ipvMsXPgT/99xFkDQwvYPtsYKccpYNIZpjRxNCL1J+VxZytvu
        6QaXo/IObycBydfKBjxSSamzTOFRXzDzHhohWocTvIAmrF753j6xO0g1b5u4Ujge
        OOu93imqYh2SZpW8rPQOqJqRwJyUU4lt/SezAt/53wA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=vUkJjM
        bAaKnoAL2luhpkldKlHQFJyUo2e/y+BcVSD24=; b=XND9Il4m07XP5u3cOPocfH
        1jIhMJSbS3tcSOq7if8yPP6U/o2RG00MGljY/i3wJIOW6o4IXAgNc09yFgw+dIQE
        mNjA5qTcFBKGJWeLTYOXLDzB4PxtwmcO4YzqxeYljTOGo3+tdMNMQm4sZVNoQowT
        DWEgsHW3ywkZrgZae82b5ooKUZf2ccbFyoBG446Be5Atfx+yaHisDFmX8S/AY25Y
        i7dhSgmNF6Vu9yaSDc3AY+eTF/IHMt5NVvc9AVXrvhBqSiJS7HeXC+GYy3N+z9Dp
        lCtqbmNkwwCWRdCsPauztWhGbqeEtGsibVOoD5zPmj3Ub6TN4iKim/1CmPlCH7LQ
        ==
X-ME-Sender: <xms:OjpwYLoPaOcLs8V_LFPkFZdTH5iv6eu1YZWsyr4UN-NC9wnwMLCiaA>
    <xme:OjpwYJeinBiR1npcn0vWPR1ZZgQdZxqdWqh3aldNv67x7t4rTjlp5pImitv9vuLBQ
    w7xRylTOe7xgKomhg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudekuddggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeejrdduledurdekrdduieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:OjpwYBRERlxtkLHPrlWmWzlUOAwM9-Bp-uNUUJl3sn9-kCULq05a_g>
    <xmx:OjpwYCZQX_nZXroKOVT-ZsO5FVNHx-qu18rvr8_vnyULnEczVFKU6Q>
    <xmx:OjpwYEc_CDW6e_w7yqSqKCIo463yz14Der7PhLdQPf9tGNMtDfM4cA>
    <xmx:OzpwYKTKCLF8OJqZTbn0FcX2rPTqK_wx549VT8Xz5UGBTt4R2bYzkA>
Received: from vm-mail.pks.im (x4dbf08a9.dyn.telefonica.de [77.191.8.169])
        by mail.messagingengine.com (Postfix) with ESMTPA id 56188240067;
        Fri,  9 Apr 2021 07:27:54 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 050ef418 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 9 Apr 2021 11:27:54 +0000 (UTC)
Date:   Fri, 9 Apr 2021 13:27:52 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3 1/8] uploadpack.txt: document implication of
 `uploadpackfilter.allow`
Message-ID: <f80b9570d49665b936e706063e42b9b00c2f7f45.1617967252.git.ps@pks.im>
References: <cover.1615813673.git.ps@pks.im>
 <cover.1617967252.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CfzsgjzKEF+Ovm7Y"
Content-Disposition: inline
In-Reply-To: <cover.1617967252.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--CfzsgjzKEF+Ovm7Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When `uploadpackfilter.allow` is set to `true`, it means that filters
are enabled by default except in the case where a filter is explicitly
disabled via `uploadpackilter.<filter>.allow`. This option will not only
enable the currently supported set of filters, but also any filters
which get added in the future. As such, an admin which wants to have
tight control over which filters are allowed and which aren't probably
shouldn't ever set `uploadpackfilter.allow=3Dtrue`.

Amend the documentation to make the ramifications more explicit so that
admins are aware of this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/config/uploadpack.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/uploadpack.txt b/Documentation/config/upl=
oadpack.txt
index b0d761282c..6729a072ea 100644
--- a/Documentation/config/uploadpack.txt
+++ b/Documentation/config/uploadpack.txt
@@ -59,7 +59,8 @@ uploadpack.allowFilter::
=20
 uploadpackfilter.allow::
 	Provides a default value for unspecified object filters (see: the
-	below configuration variable).
+	below configuration variable). If set to `true`, this will also
+	enable all filters which get added in the future.
 	Defaults to `true`.
=20
 uploadpackfilter.<filter>.allow::
--=20
2.31.1


--CfzsgjzKEF+Ovm7Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmBwOjgACgkQVbJhu7ck
PpRRmg//S/ePwI28bvu5x3llyEYInLOqJ8yOhzrPBjWSdfWaG4KDIMHadorPbc2y
W2Jv2mHP+neMC9hmUgePZKJCfVeFYT0cRfAEH0cZytoyqAHyD9RFfD5tNKHVzIma
zBZX6rEO2x4eFJ2b1GX0jm9EFiixyMfBgMRYzErOSf0KP2699SNo4UebEAPUGDZM
w7a1zl2yBzCVlnjh5DkTlO4jmyjwwPYznonkVYF0J9exFGSbcCjVZafW7Hes5OP+
yqDDOyjLID3EzZQ7AMsI+cqjJe4gkG3aFQGLv+luEyzdkNYAkP6U21iaFXGzL9r2
co5QPFkfWXp8rbenbn7yn5bw5vud/a6b6Fqp1tsbDNjO3AeIuMB6cUMKWCqQEPBC
VR3/t9QrRWwVwsD0n6G0qY30foq9J2cpSs8fnOi+yHZrhRkYfOOnpSSBYlTnS9FS
Rbq5MwVRZDTeTJmgm/9ZPFjz7c+uzB5tdx2u4ZX0yE4rq4hLM2Gp4XxetHp51t0Z
HJShuia+C+QQYA7akPqXE6zJPid6u/iP5JN8H06r4/ghj5UBqGdNxIl8FzYhs8JU
lB/Vq8L/pZivaRPJFNE/zjDTuA6lb6qikOB2cnLPcnYArXwGCH8viXTBIQ8jarXb
iS7y84fomw8iYfwzW0A3VjXkQ0SYLwDOkC3F4pb0IYfIagh6aCU=
=eJx7
-----END PGP SIGNATURE-----

--CfzsgjzKEF+Ovm7Y--
