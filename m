Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A97C433F5
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 08:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237953AbiAQIMo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jan 2022 03:12:44 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:38237 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230177AbiAQIMn (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 17 Jan 2022 03:12:43 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 1E8445C00C5;
        Mon, 17 Jan 2022 03:12:43 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 17 Jan 2022 03:12:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=I2zRV07sfwxW3btYSVMwHIY//nR
        f9QC4BAaDAkvXvME=; b=oGgMUbTqQ2xhMSPaz0SGx2DGnkMeDFlV104Hqz86adA
        Z3KRe+uWzzP39O7Fw2ox5L7f1pLbONnY2zSigr2QVMFoUPEdZTknR1tiLNx6654C
        Guygh73po01ctAaOGepwaGOt6sHpbJVxSiPvbTulXNqmDbjd6TxEtd33UESJPE9z
        hmARUdSi8jH6+NUWL8l315n5i5ctt7noU1RGLCg0Ju3nyOcLqbltpmwWGQEtwADl
        fYI78jiPzKV2SlsC0lwrc0ROM/OP7zJoH8x83hrFsyc0eSByO1Y8buSRWcbnJ2DW
        3IccqGkTt1GOXsNIqlNsGVMvDOnmjSM14mIivn+oM2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=I2zRV0
        7sfwxW3btYSVMwHIY//nRf9QC4BAaDAkvXvME=; b=IIupYzEZW/2MlJhHbAC/cc
        Hh8x17G3c7DW/SlBX9g7/ABihsb+LxXAwUYWTiFpzTBD13eLSBVXWd3FyEbnZNUQ
        PwPX+hx4Q9BkzvI8IIL4YtD82k1gJwiio0nEaVV623K9RNdNmrvowb9YbLcq66vb
        Lkm/vhrLa0CSiLYwQq/7+1VSnOzrNB9X+lCnbVB2SPkBbchqI9QgwjzdkwiREb6C
        vG9/goSF+ZSBxWB+E+JD/t+CXFcCyXNEjFR8eUkkgg0KIAvRzhCXpo34rVkEDOdN
        LCpgjR8qnuzzawWywfpyKNcFUD136+DZZ0FnSDyZL+vZLoI36VksIoKiqwZONOHg
        ==
X-ME-Sender: <xms:-iTlYc7u2dmJwHvcnH6rSq9EVMHijOTRsMpA7rVGtecHtG4_P4Py4Q>
    <xme:-iTlYd7dNaCR7WhYiRvt1OvhAIP2-RFdHWlY4WeYmisPDJci-zIeD4Yu8kOB0AKWJ
    RIMnTrIIp_TBgzYdw>
X-ME-Received: <xmr:-iTlYbdDTaBqlx_jD0tLGkRyKQoH9eHonBgQOyaCkJmebfJBQIhEx182CjAN01gELzbQ5cplKoeWy3mcdXo6F7K__ZzYQK7tmVFwAVbeLwqCSr3FhvKtiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddtgdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:-iTlYRKrUw9ogiDNjDC17hMeyM1oMLhnTeylhmVMBN-zzjQtjE3Jxg>
    <xmx:-iTlYQLHLT_y1WXmeCq1cC7hV52W5g04zT12me1jlG3aF1Ybxhk3Rw>
    <xmx:-iTlYSwkCLqnCTgoDcyroWaKOJ9t11AyAcp6KFbhlWtkZ-rSXkIz4Q>
    <xmx:-yTlYVEV2SXP-yhycAYZq7F2VtKQxU3rAffb2xB5LHGNzXWHtysLNw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Jan 2022 03:12:41 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 99ed193f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 17 Jan 2022 08:12:40 +0000 (UTC)
Date:   Mon, 17 Jan 2022 09:12:39 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Bryan Turner <bturner@atlassian.com>,
        Waleed Khan <me@waleedkhan.name>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH v4 3/6] refs: allow skipping the reference-transaction hook
Message-ID: <f4a07fe9a8823d382e010a8b4978fa8a3fc3c943.1642406989.git.ps@pks.im>
References: <cover.1641556319.git.ps@pks.im>
 <cover.1642406989.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rzGCon5+Ea6/2lhj"
Content-Disposition: inline
In-Reply-To: <cover.1642406989.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--rzGCon5+Ea6/2lhj
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


--rzGCon5+Ea6/2lhj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmHlJPYACgkQVbJhu7ck
PpRsJw//Zlfpk58TZCajKOWGiZ83NTXBS3pVH9Wn7YURd3rQ7Mm+Ir+h8k/YC3B8
h9fpShwKUeFHnHJnxUBW93ytSihZeKDAccr2Mr0uMwRGlMx0iCgKcTMqcpj3U+fp
ttmfLyJ9kgqGo2wdfOf5WEuWol+WBRCPlB4o4Y/Jiqs8Y2s5QsYpoFUrfyWukFhz
QxCN+WYNyBcLD5DKg01wg/WmtMmhQ6KYqF0G6jQY0u5Pq73U6sMraG4CEPo0vw2J
S+Rbr2FvkaOR4Z0DqjSeQhcWvPBjfnsXBdvP5sl1LLtOVmEoZnoHbA8LRzEWyVNL
TWLEdi6JqE6lh3xTlBc1KEeTO2dW6y+U0yWBCzNaSDesa6LhcdrqDjsTbf1cGQ4W
VlZRR0eiy209UXksQIrsoVFsvO2VvpDIQId4W0OF50FD9MmETJUyKGnV6zFUPTUF
cTS52pV4ieZGDYHis5CuC/USg46tjwevdIYaSGZrz0fGyeBjqECgUUpYq5F6FbPi
a60HA45mfC6qO+hLdfbGdIZfVfxHQa6wNuArlDbLdPi4W+7+WzmezDt+8B1qK7vE
1uw1r6GKPp2by8XPpSs2kRsvVrKdQtWTwbq8tHIW9LEagh8C9jx6km7qnrD/Op+N
OnDCWond3pN7u/D/1L0VKOD08kHXtBVCpPO+Ris3L0DT2S2okjY=
=gjIp
-----END PGP SIGNATURE-----

--rzGCon5+Ea6/2lhj--
