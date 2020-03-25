Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205BFC54FD0
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 09:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA5C20772
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 09:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ttJ0fuMq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="x8tEsjk1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbgCYJyD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 05:54:03 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:48311 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727281AbgCYJyC (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 25 Mar 2020 05:54:02 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 1681F5C020A;
        Wed, 25 Mar 2020 05:54:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 25 Mar 2020 05:54:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=hw6E7atdpdJkzwQTvHYUANYCvOs
        Fzlqr2b0UslbFvzw=; b=ttJ0fuMqxZacqgWNbvg+uwqBsRn+4MtN/fgIFIzc3wu
        Vr2lWyW3X9dGsDYLXYu/KLUgw0ETgCoDTwkkL5pfC3JgsG0GH+0V6+zoVuqBCdw8
        e50KRbQ0Rf4qmd+ugUzDCr1TyGWTVW+R0C3iq9gochK9vBP0dlZRiBWI+5BhKgTG
        XtQpaE/s44VDoJt1G9WTRGlH21KPDZhje5FMc6zH6gnZBbWo+2MkLhcpRUw4FRic
        H3K7BF1y82Iwu5Z/Z4PxxHApDY88E8Mo9xe7a9dsvrqimkzRmatvw9T3LWbMEwRb
        8TKOjJKo8Xpz1n/IQReNGSSvdDeSbIb9FBGBicHKZvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=hw6E7a
        tdpdJkzwQTvHYUANYCvOsFzlqr2b0UslbFvzw=; b=x8tEsjk1F7TbVV5IenDB9/
        HkbdH+HVTt5qrNkc2UgGe3nlPJ29pJ87lXWj7ZLt5K1nd+7kuFus5meTu7nUNeYw
        RMWwVai98vkceotBJQQe6pxxzmbRHIGT6zOTHV6LZ0EK4Ch+1tqtrJe/s62Nnfhf
        Jm8HVh9qwHWwBVLlEYm3KsL35BGsVXHST7xalffVwGMKc3fGCDugvEmoRCf2MmnP
        hmrdDFxyC90ERSGdBq5j00e4JbQqjyGDKSP2ftTQTsgVHPIZRY4/pN5V9grYx7E8
        NKiOrZMZOg3aAQf65mBXlJNbCXKOaGc1QoxW3zb9qPd84GSWxvF6RMZQhex4YDZg
        ==
X-ME-Sender: <xms:OSp7Xpugmw4_6XTxMqSXQNQrFLrxz7OFxOCEgmpqGopYrJTSliaS2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudehfedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucfkphepjeejrddufe
    drudekhedrjedvnecuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrghilhhf
    rhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:OSp7XuON2pyn6r8vfzao9Ll-Sy7On7Wp7MIG8VCnL2TVvqVWIIqrSA>
    <xmx:OSp7XgWRbV5fg9W89c-ZETBSbhWQWmHVq53Y7yv2fDvja_R2WRpwNw>
    <xmx:OSp7Xr7StOD8ta7n4Or0k9Ub8Tft-KHYuTBdCEpF3XZkiuDEyasR7g>
    <xmx:Oip7XnLCEPj1K-u-CYQXBR6ux1ShmiLhH7-fRWphjERytaKNBEFlGA>
Received: from vm-mail.pks.im (x4d0db948.dyn.telefonica.de [77.13.185.72])
        by mail.messagingengine.com (Postfix) with ESMTPA id 74BA9328005E;
        Wed, 25 Mar 2020 05:54:01 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 73538aa7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 25 Mar 2020 09:54:00 +0000 (UTC)
Date:   Wed, 25 Mar 2020 10:54:01 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 5/9] update-ref: drop unused argument for `parse_refname`
Message-ID: <a78043b188eb75652b84988c626ce14136c80433.1585129842.git.ps@pks.im>
References: <cover.1585129842.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <cover.1585129842.git.ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `parse_refname` function accepts a `struct strbuf *input` argument
that isn't used at all. As we're about to convert commands to not use a
strbuf anymore but instead an end pointer, let's drop this argument now
to make the converting commit easier to review.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/update-ref.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index d2b917a47c..6f4e8e88c1 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -50,7 +50,7 @@ static const char *parse_arg(const char *next, struct str=
buf *arg)
  * the argument.  Die if C-quoting is malformed or the reference name
  * is invalid.
  */
-static char *parse_refname(struct strbuf *input, const char **next)
+static char *parse_refname(const char **next)
 {
 	struct strbuf ref =3D STRBUF_INIT;
=20
@@ -189,7 +189,7 @@ static const char *parse_cmd_update(struct ref_transact=
ion *transaction,
 	if (!skip_prefix(next, " ", &next))
 		die("update: missing space after command");
=20
-	refname =3D parse_refname(input, &next);
+	refname =3D parse_refname(&next);
 	if (!refname)
 		die("update: missing <ref>");
=20
@@ -226,7 +226,7 @@ static const char *parse_cmd_create(struct ref_transact=
ion *transaction,
 	if (!skip_prefix(next, " ", &next))
 		die("create: missing space after command");
=20
-	refname =3D parse_refname(input, &next);
+	refname =3D parse_refname(&next);
 	if (!refname)
 		die("create: missing <ref>");
=20
@@ -262,7 +262,7 @@ static const char *parse_cmd_delete(struct ref_transact=
ion *transaction,
 	if (!skip_prefix(next, " ", &next))
 		die("delete: missing space after command");
=20
-	refname =3D parse_refname(input, &next);
+	refname =3D parse_refname(&next);
 	if (!refname)
 		die("delete: missing <ref>");
=20
@@ -300,7 +300,7 @@ static const char *parse_cmd_verify(struct ref_transact=
ion *transaction,
 	if (!skip_prefix(next, " ", &next))
 		die("verify: missing space after command");
=20
-	refname =3D parse_refname(input, &next);
+	refname =3D parse_refname(&next);
 	if (!refname)
 		die("verify: missing <ref>");
=20
--=20
2.26.0


--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl57KjcACgkQVbJhu7ck
PpQLvhAAjitIFUa6aAvu4cZAs5q2LG9Wm5zDDsF/Sdqrc4RJegT2LoljYYSWMt6j
qxn5YTDSYv2cD/tvS0QiTFqz6XTOEbzpog4eU5Dal3SnPNndaqWkeqnQ5SayEBeE
QglJeNXel6C4TsoOg8zIuoDXzgo6kcVgFnNWLQJ/HuRDUEcmRVh7uAnyRozTWtho
BJOfhYADQogiZsVHtbhApURZXlnBY0K/3D+OM7MHTh5PEDc4pBHTZ80IzbQCpfN9
KA4I+ix78dSIYMjfJWbHXGFTxO5jsXz1SmSIK4vN0OjWod/jeVq613MLgqOKAhW3
ZZC7o8eqjt4nukcwki3OBNXPFLCPS6yRkfvdIqAPS7t0y821vX+z206bD8eD1q1X
YqdEJ44LJVrE+JmEgH2TuRowfTSG3WzZkDiEdNX7MOZxj01VxC+6tozSSGyL3vmm
UXHS5xLv7sGF/qOdt+ez1QcRBkp4nrLm+0mXkgKzK+3PVgIRvo2gL/88J8yeAQ75
om5JhoydOkzOvGvMedAHsKpebfRvf3p+3EYHZI/WST5xKN1e4VI/rgaItZF+Swsi
iBr/Qz9o1DQSOrlKUc6By8FzLf7jJcpEbWL13D6LBVff1SlcSKLoHKQT6ZXlnVVx
RIQnSALDgoczC3lEED3lIKng6U1jT5PHN/j7WF3KYlFTSunpV/Y=
=Aqlv
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
