Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78943C43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 13:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B04320757
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 13:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Bse7eXCX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bpwc3FqI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbgC3Nqw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 09:46:52 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:49943 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726028AbgC3Nqw (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 30 Mar 2020 09:46:52 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 2126C3AA;
        Mon, 30 Mar 2020 09:46:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 30 Mar 2020 09:46:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=rvkbuvO/T48iVrK35BqJQX1qixd
        Qr/h01VE4EvYSVSY=; b=Bse7eXCXnYoBY8NDk7bLiEvPnmPS7/j5po12OXovGir
        R+/lnyomTSSOguEokgTqByypYij+SAICxiSYcCJ+EXXFiO6s2Lhddlf7MezPPbX7
        SIEylvk/uJRnBrulXFSZAerILGwd14irYONyUDa/iucSTt9d9bAm+BGs6B5SzFld
        lM633Gg0rAQ/7R2IxxA5Uczlwoh4dK9zfwipb8hmO/aUqt2flpwijCBsNogzJwZx
        0mqBV40xA6wxMEhwNQ9bNcMTyS0xoQvcvrrqGmw9fzZuiiirTISVIoKQoEEUMi65
        Odrw83cq9J6nMMf7LpyEcqYXfq4iu2pPmL7da8JSAXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=rvkbuv
        O/T48iVrK35BqJQX1qixdQr/h01VE4EvYSVSY=; b=Bpwc3FqIGFrcRAby1MPjKY
        VTE7UUq4X8EuUh8lNyxpYH99wKlpNqGQcEmMm1bsBeO3THBki7tEakj5T6ckk9fm
        VMfm6HMAWIYf2CZan0Se31jTBp6XalgkbUHCI5Geo11J/OGKhbz78RLlceHSsyT8
        kxWXsBA7EtDM8HU3DV4PEGD7TmFok0nh4LCERq4kRT4qv/ewoaPVX0soBK+A8dUw
        Xpw/4FK8XGhVhwxmvmv1cgKDElRrpnCsm8tV+0bjq+StFXYvmC6MtHlwR1AUMAiw
        vpS5/gntKiKB2Ey+6tQ6csXjbCffP7PFAwGsK5fg2ZpwXuVUprLbdK4RBEYUM/Pg
        ==
X-ME-Sender: <xms:SviBXpmjdXmNQpWcd_-_gsvibt1IaJKlkW5F0JUXbODBDL6Mz8DBig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudeihedgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucfkphepjeekrdehge
    drvddvtddruddtvdenucevlhhushhtvghrufhiiigvpeejnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:SviBXtm0m8UJrkMtdoxSN2F0WHmcSBYNUiwmvpMzmvHUbcV2FSteWg>
    <xmx:SviBXlH3HV2TDhw5lHhUQ1V_cWCM_kohngtusCk_cXLGhWEtsL5jCg>
    <xmx:SviBXtSbieoXWzxedYsFnWlga97MRF-FZD1RCk1sE11rq4EgARllcA>
    <xmx:SviBXsVPLe_iKlvKgrKYY_V59N90ybyp_xkIZ_o4dC77M8jvpODw2Q>
Received: from vm-mail.pks.im (x4e36dc66.dyn.telefonica.de [78.54.220.102])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0E4233280064;
        Mon, 30 Mar 2020 09:46:49 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 794be5cf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 30 Mar 2020 13:46:48 +0000 (UTC)
Date:   Mon, 30 Mar 2020 15:46:52 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 7/9] update-ref: move transaction handling into
 `update_refs_stdin()`
Message-ID: <d2f68f59a716544c637f1c14cfc54bfccdf31181.1585575749.git.ps@pks.im>
References: <cover.1585129842.git.ps@pks.im>
 <cover.1585575749.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <cover.1585575749.git.ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

While the actual logic to update the transaction is handled in
`update_refs_stdin()`, the transaction itself is started and committed
in `cmd_update_ref()` itself. This makes it hard to handle transaction
abortion and commits as part of `update_refs_stdin()` itself, which is
required in order to introduce transaction handling features to `git
update-refs --stdin`.

Refactor the code to move all transaction handling into
`update_refs_stdin()` to prepare for transaction handling features.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/update-ref.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 139c3b11fa..1a7906545d 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -346,15 +346,21 @@ static const struct parse_cmd {
 	{ "option", parse_cmd_option },
 };
=20
-static void update_refs_stdin(struct ref_transaction *transaction)
+static void update_refs_stdin(void)
 {
-	struct strbuf input =3D STRBUF_INIT;
+	struct strbuf input =3D STRBUF_INIT, err =3D STRBUF_INIT;
+	struct ref_transaction *transaction;
 	const char *next;
 	int i;
=20
 	if (strbuf_read(&input, 0, 1000) < 0)
 		die_errno("could not read from stdin");
 	next =3D input.buf;
+
+	transaction =3D ref_transaction_begin(&err);
+	if (!transaction)
+		die("%s", err.buf);
+
 	/* Read each line dispatch its command */
 	while (next < input.buf + input.len) {
 		const struct parse_cmd *cmd =3D NULL;
@@ -389,6 +395,11 @@ static void update_refs_stdin(struct ref_transaction *=
transaction)
 		next++;
 	}
=20
+	if (ref_transaction_commit(transaction, &err))
+		die("%s", err.buf);
+
+	ref_transaction_free(transaction);
+	strbuf_release(&err);
 	strbuf_release(&input);
 }
=20
@@ -423,21 +434,11 @@ int cmd_update_ref(int argc, const char **argv, const=
 char *prefix)
 	}
=20
 	if (read_stdin) {
-		struct strbuf err =3D STRBUF_INIT;
-		struct ref_transaction *transaction;
-
-		transaction =3D ref_transaction_begin(&err);
-		if (!transaction)
-			die("%s", err.buf);
 		if (delete || argc > 0)
 			usage_with_options(git_update_ref_usage, options);
 		if (end_null)
 			line_termination =3D '\0';
-		update_refs_stdin(transaction);
-		if (ref_transaction_commit(transaction, &err))
-			die("%s", err.buf);
-		ref_transaction_free(transaction);
-		strbuf_release(&err);
+		update_refs_stdin();
 		return 0;
 	}
=20
--=20
2.26.0


--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl6B+EoACgkQVbJhu7ck
PpT9Ag//fe1N9p7ZnjHPTdXDuNelzSFOcex4JbabvhrnBJowA5LW4bzAH5wddlp6
Zhoz77GkuhXmNSK3XBcC5Tw8aMBqDpgno2EUdQ7zcdLlzzsiaLnuQ9yDcI1Ro3tf
oYGsC4UDliyHPX3Uok6X/Mjgl4fHgF0KosZ9sYylgKuPRLnxA7TTX+cTvuv66skY
Iey7nEr4rvEmBz9bkYW3Pd7YJJFavcSQjXQPBjZhxR42TirNmB3GlX9RnLP0bGYX
0gYYk9QDBaMqJK2XrIfz7JCdosZhQu0TPUtILAiWe2gGrpd4YR1RXHuw5QmFF1gL
ZyyP2LLnsB7kgd/WCiVnZIQXZsGZGdq4aU86ACK8iEPeBj+6qCOPReQRs1yzcJFD
6nfO1R7ZIO61OULCKGHHOkE9jdTQ0Pcf7xASFeZzEmAczKcS72oY/K4cGVikjhhi
7UTf2OFSoBiZunBfVKp3t9NI8+/6MtC2jzFXSwT1A5rxTmH9IBEGnAyUeEOQHoZ4
kRyQ737PLz8S20WARI63scrKr0oEv2aY+9YM/dlPk+uyYQFO5Z0+EFNyp2pt8No4
X/XclkcwjoBEa+hmEzU17aiveXNMntch/9eX50LEr5f6wrXfD81PIFUq6Bxp6xuB
EzhcxUzFmOrlNc5KUnSID+JVPC7bb45QuyIdNpAhOKwCRfY1/hg=
=uaNU
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
