Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E856C433EF
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 11:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347356AbiAGLzu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 06:55:50 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:40363 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347328AbiAGLzq (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 7 Jan 2022 06:55:46 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 43EE85C01C2;
        Fri,  7 Jan 2022 06:55:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 07 Jan 2022 06:55:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=9s3G5+ImP1ycwPufAS1veetfnbt
        Y+1mT9DFbK/u4Za0=; b=QiKBeBqRIe/TjlfiGsp7z6IaNlMMvqN72iZgsOxQyRY
        KjtXKnM5ERaz0Ce/FUxQ4bcbNySsOjOdDQpUxrX75bd6wP7bzPh4J24A5JaTf+MQ
        V9cTDL4UtcDEis9pBKKJomr7RICRvPMu82zw7VHTwA0YyykOs2tvXCw/LlmHfgz5
        unjnle1sUKwP/xHjER8rVuykWf38RsOoI5cry0D9Wp3L+yZMbLPTYHoSqTZDflxF
        uG7RB9YGIhuMbPDS6OR7pSxt5dGVTQ7bLmZl2FrycpV6DC655XZf8l3C1bI54Ccj
        U8magNo62GCVZ4rL81BvZtVGuCiub0avahknB6Bbsvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=9s3G5+
        ImP1ycwPufAS1veetfnbtY+1mT9DFbK/u4Za0=; b=CqGxEhZ3VNUeWN8JuLgF/t
        PgXkq3+Omqw6r+OsJq/269pqvct3wV7QE8r2NjtpxM0xKl3mtzj4+Jw0r6x1ovkj
        ps8okGKvLopEvpr7FaAWCh8K885XOcnb/a4Ar7zhrRDiUSgjI9b8mSLhXM9jlRI8
        EWXDsH2oFy9qN9roYmTDHwCySjt6nzfs4UpqoUirfzyj/bTQmlMEtHzbPCH26n0j
        0zBOT/t4Jk/fR+ASUUD81NXf+iZJFC7ls3MHAxkrkqPFt+QEXnidiZdhfxDWDoOv
        6YfjsifyHxkhABNnwfnLFJel8ikkS6rowLyOUfoonGlZS4mRJKGEbKxpHECBbe8A
        ==
X-ME-Sender: <xms:QirYYdZPwplgZy6t-6auWiwONNAiISd-fYpknyuhrO0jgFlcL6jVaQ>
    <xme:QirYYUZetIAdAIhz-BEuXpSF6rvMhkeSwjnPv-1XRonih-pG8Ed139uRoPm6jWWku
    _I5btnfu6PZo3R_bQ>
X-ME-Received: <xmr:QirYYf9fZ2300gNZh3xQR2tjc9gsHquQFhNS4w6mD3Yl0w_lr77VYgwWza8yFCMn0RZwFiJlD_y_K4nfm0l5QDbA-DbWYozuzsKn4Pm5U5XMoPeoGHycsJ9t>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudegvddguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:QirYYbplOlts7IQS8PNMF24-K1fLMvd-HCIw6b69rATe7CgrJyoxog>
    <xmx:QirYYYow_p5oW8PwbV18pbfhFYBJgyEoVt7YOl02uFH8d8ZYg-S4fw>
    <xmx:QirYYRRD9f3PoJVIzfdL34xOYJ10gZ8qcxMU8EyVPeh8QHLjNhlsdQ>
    <xmx:QirYYf0Ep9WLRraJjAtD8QK3fjsayxev-LGbziyziDA9xPBwtwhG1w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jan 2022 06:55:45 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 0b9a2e5e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 7 Jan 2022 11:55:45 +0000 (UTC)
Date:   Fri, 7 Jan 2022 12:55:21 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Bryan Turner <bturner@atlassian.com>,
        Waleed Khan <me@waleedkhan.name>
Subject: [PATCH v2 3/6] refs: allow skipping the reference-transaction hook
Message-ID: <550d89a3236eb7afcd5ef627509368e8fc298662.1641556319.git.ps@pks.im>
References: <cover.1638874287.git.ps@pks.im>
 <cover.1641556319.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FkNGUjxJAQoegMVL"
Content-Disposition: inline
In-Reply-To: <cover.1641556319.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--FkNGUjxJAQoegMVL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The reference-transaction hook is executing whenever we prepare, commit
or abort a reference transaction. While this is mostly intentional, in
case of the files backend we're leaking the implementation detail that
the store is in fact a composite store with one loose and one packed
backend to the caller. So while we want to execute the hook for all
logical updates, executing it for such implementation details is
unexpected.

Prepare for a fix by adding a new flag which allows to skip execution of
the hook.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 3 +++
 refs.h | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/refs.c b/refs.c
index 7415864b62..526bf5ed97 100644
--- a/refs.c
+++ b/refs.c
@@ -2084,6 +2084,9 @@ static int run_transaction_hook(struct ref_transactio=
n *transaction,
 	const char *hook;
 	int ret =3D 0, i;
=20
+	if (transaction->flags & REF_TRANSACTION_SKIP_HOOK)
+		return 0;
+
 	hook =3D find_hook("reference-transaction");
 	if (!hook)
 		return ret;
diff --git a/refs.h b/refs.h
index 31f7bf9642..d4056f9fe2 100644
--- a/refs.h
+++ b/refs.h
@@ -568,6 +568,11 @@ enum action_on_err {
 	UPDATE_REFS_QUIET_ON_ERR
 };
=20
+/*
+ * Skip executing the reference-transaction hook.
+ */
+#define REF_TRANSACTION_SKIP_HOOK (1 << 0)
+
 /*
  * Begin a reference transaction.  The reference transaction must
  * be freed by calling ref_transaction_free().
--=20
2.34.1


--FkNGUjxJAQoegMVL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmHYKigACgkQVbJhu7ck
PpQpuw/+MGd+BswIMytHWVb7Ly5ij/1hXxBBT+sIRhH0SdNhhMVN2jg1QsXEYJUf
YJ/yiYZp6/Ud5BbobFi2d3Pz/NgGl8rxXtGffFQRs+6G81Qq1A5vwzKXcq6cQS9Z
OOkfUYsCJWUr1/c6/R2x/H73xsmtzoQwW4QK8k4pHPyOeiYewji6fZxUp9dWdFfb
ElwRcW+oKt3y2ktaXMGe79golgu0Cemh7QcoobRrn9L6UtCOzuUyMOaGaNEGbYIu
Js4rMHsVMIPfjMrvPPsO7u5dxa0fuMAJ0mbckKN3mxGXZ5qUEmtpt824XTW5AB8w
J2NN2a83eBPw0Q0qThRqn0I3004cfqA65AhExbH8b3Px16O9akpF1Uo5h0AclAkm
aPBYc4+HLjqH+9GZeE2mePDmMnCdVepl9pbS1onejXal87fvNUWORNvRLIsvsBJs
QTa6e68mRQbWqK4mBiD/dxB4nbTJPQ7Osx3E7IXhxi3buHI4IO37IJx0bs9wIy+Y
m9CqOg7b5glt5IuMqRrdxt5kWswuaDVeDCUp9kTPPmXM703eBmIoTYKXuoeNRzd8
WHBI20ItIiN5x6kDaXlYE7NpsphR7P5PkgCSUkrZh+zv6xfH4dMrwWIO6R8T79OG
abs09GtlW0zvnlOqbRW9Mhahu909LiCykuaepAezocqICMHF67U=
=iWdA
-----END PGP SIGNATURE-----

--FkNGUjxJAQoegMVL--
