Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAC3C77B7F
	for <git@archiver.kernel.org>; Wed, 17 May 2023 11:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjEQLtA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 07:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjEQLsv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 07:48:51 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2D03ABB
        for <git@vger.kernel.org>; Wed, 17 May 2023 04:48:49 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 75BB432002B6
        for <git@vger.kernel.org>; Wed, 17 May 2023 07:48:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 17 May 2023 07:48:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1684324129; x=1684410529; bh=5V
        URXlK+z1n1Tqi2pZYvUj61anNYLHP6bt29jF1saOs=; b=myLtH00p2B1lDgoBD9
        WMwj+IcRNeH6q4zIP+8vfk0wAx6/BkkndM/cKqjSnrt5deIOfAJnuoMQYid94dS8
        Tfc0sadIpxd1Iz+LYOKD8iAlEjcMTGvDNvqDhI+9WDiVXn+oCTFa1kBwyVkq0kNf
        7ceEiIXLVSB3exEQa1fTIo1de2bclSiz//Iqo4aVi5yqfbVwE30keWPdCnDh3VTU
        TcPvmRNYhD8AnJuGUabprmErOScgRlcPsmMxn5/q59v4h1H/kGSQK/HNvSrrRD3t
        eLa0DNFRD7SBLZ8+QqZPZfDiCTE/882r/bnss4Nqj/Zzd9kKhPxcIKg2DU76KUUc
        gNgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684324129; x=1684410529; bh=5VURXlK+z1n1T
        qi2pZYvUj61anNYLHP6bt29jF1saOs=; b=vxGEVtLrsD5iX3hiDWvfBYghxb6lv
        LGJMxke7ezniUQsdxFKKgQz0Ws+lo9V447+IEJ8g6vlD/VVR2+CQEA6MxN/xuCsF
        jFNZf2rWmelCFDtFrvb0UkN2lW56FhWBWaRX5yUhfZU5Rg0qSvv6LZmM6NpLaVGW
        kbNN0AB99ZWGfS+5QgBb1J/JP3TNbbsoHdpZvlB4JLkPvNUCwaY7XuCs7HUhpe/P
        AxcINKWoSTYvI38CYPZsXsO7vxT9yPenDhrQvfcTeRMObZbSAmJWmU4/F+wxT1c2
        Mb984U5DikgZ6tAejWWWgxgo5QOL37N0Bh05BSlXjjIe9jP61zNrSxKxw==
X-ME-Sender: <xms:IL9kZCAhbdqV5xTzOs3NWqsbI1PI4OjUqWOUAzA9aszU5Uru6km4Mg>
    <xme:IL9kZMj2r516cJEXQXlPaTcipFB8dJwlr_JPU2FMH3qiqI40P52Y76TFGuBO8EW3B
    i5wxYxiWqxAp5kHHg>
X-ME-Received: <xmr:IL9kZFkbZCNKdq5E_Bzt4ZcIFx2Ab2tM71nshi9eijz_hsyZvh6LFeUA_acGTjKM3Mg574O2PoKhzUjhDKwq4pqO2bV-cgJaZ5G7EjBUR3nxvWVn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeiuddggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:IL9kZAwHIauIaGRjn1_0KUWLYxfIuus3iDFMwVa3GTpIUjptwxd6OA>
    <xmx:IL9kZHSMuKwdScgZpFZWULvzBl5jAr2h625Sxv7_kn-GYFHXMpd72A>
    <xmx:IL9kZLahmuwaUPvoWXlh5tzGah3rKMrG7MUQPpn5XLWFL4-xSAXn2Q>
    <xmx:Ib9kZKM6ofDorB95zcAPFUPgOFiEIt2-Ny9dRGsQ1pghz2dOgQ4kmg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 17 May 2023 07:48:48 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 5ab87d4e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Wed, 17 May 2023 11:48:25 +0000 (UTC)
Date:   Wed, 17 May 2023 13:48:46 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 2/9] fetch: drop unneeded NULL-check for `remote_ref`
Message-ID: <7197540df60d34e8f727e29d300dd0c96e31d310.1684324059.git.ps@pks.im>
References: <cover.1684324059.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7gAjnNoO9v9L7lk+"
Content-Disposition: inline
In-Reply-To: <cover.1684324059.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--7gAjnNoO9v9L7lk+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Drop the `NULL` check for `remote_ref` in `update_local_ref()`. The
function only has a single caller, and that caller always passes in a
non-`NULL` value.

This fixes a false positive in Coverity.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 9147b700e5..f268322e6f 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -953,11 +953,10 @@ static int update_local_ref(struct ref *ref,
 		 * Base this on the remote's ref name, as it's
 		 * more likely to follow a standard layout.
 		 */
-		const char *name =3D remote_ref ? remote_ref->name : "";
-		if (starts_with(name, "refs/tags/")) {
+		if (starts_with(remote_ref->name, "refs/tags/")) {
 			msg =3D "storing tag";
 			what =3D _("[new tag]");
-		} else if (starts_with(name, "refs/heads/")) {
+		} else if (starts_with(remote_ref->name, "refs/heads/")) {
 			msg =3D "storing head";
 			what =3D _("[new branch]");
 		} else {
--=20
2.40.1


--7gAjnNoO9v9L7lk+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRkvx4ACgkQVbJhu7ck
PpQ6DQ/9FVAWYKf09OeBjjJP1QSi/nzRrMEp7zV+QR00Hb7UUERx5Gm3VB0cRjtF
VwG0/3cLuOJTml16I1HZzxz/UhbeLD04IKQ/LBSKHvD1CqW1DyUoQ+nbKLcx7NmO
mbo3OmnNkLn7Sshr5CjYtH/yGTU48+Px47L25kvx5B345TwalgmK2xpJoAfMri6u
QbdIA5NikLfyKOxC99oqfv9t5cXCMe4VfuZrw9FyRR+A0iXhXPhhYlEmhElyp/rr
J8dNJaRPEXlAcyef8tpwFGuVHvYeQJVh2qKWv7U2b+BgkGF/9pYR5SWl2vbXH5Ln
mVgs48sp/KMoA5wr8HL6wCo2ORYtrrNyb6oTmCyQC/IjN+RyvQS5rxjaFYEQ6H4r
OQa4oKS+3wyZT/fBrtzNoSa1RRHRWe+8k5hrYHFC26ZwkUjlnTLCA3+RDky5SILn
Ne4GELt3zI9H2u/XBEVFpKQ+T0k8mdnvtUW6zlXnuYjN9tBpFwR+5bB26wBBrWTT
ylAou6JgSblwCxNPH+XcPdoIu5nR+37NajBvTbhoYmH5HfNA9+kQl5aOOqrm+HEX
BCrXvfanHoma1taEYQORhh79y0jS2d8F2s80/1FIh+Up4xMy6BiS/0JIk7Q1F4OQ
OIRDAPrPRgjQEzYeerrmxlmzUKDjAtgdMrrjljIFacUDN9zIcvk=
=nwfs
-----END PGP SIGNATURE-----

--7gAjnNoO9v9L7lk+--
