Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769DAC54FD0
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 09:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AEB4207FC
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 09:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ijOnzR3r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="umKQaVsD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbgCYJyS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 05:54:18 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:55539 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726043AbgCYJyR (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 25 Mar 2020 05:54:17 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 665AC5C0227;
        Wed, 25 Mar 2020 05:54:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 25 Mar 2020 05:54:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=qjE1dLyd86/2PFfowjUBjXBk9l+
        Qv3TEJ4R+NS9QVbw=; b=ijOnzR3rWDrN0F0x5L86EaebKH06vYIYOCxBA01qm/E
        0AVxiAgM7tLTidLXy1/reipimfI6xFZfsBVp16UDiuyY/uGltuXWekQ2h96sKIUM
        t9X7tR93Hf7f5LymZxINywGxJ3bQvsNMEokfQph3ESw77ZFNErnuUzq8cuBd6S2l
        jSAAcOuVbpPIdkN20mIElgVPwW0e4sFNZJw9cAc3FcH/P1w3IWPYB9R2nCKkPYTF
        rtKQq4LiBccrbMhpC3eNIA89ZNugjuv/w5Q2I2UAbVCsDxRb3dRNxDlHGRFb4Gnd
        4urrIf/dLlWzDJ+pKcrDgpZv08OFsiEj9rqYJiwfTgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=qjE1dL
        yd86/2PFfowjUBjXBk9l+Qv3TEJ4R+NS9QVbw=; b=umKQaVsD+JCblDiALgq40i
        NIXd6VYaLbImaVATcfSu1FQMWf8GKI1GsOfl4tj3mCTFgL/I8lVmWEPOuIYE67D6
        oG/6gqRB5HLwl9A+bdCyrapwFqo405jvAVw+Xui7aWChE07X82Us3h4RwXcaMTwf
        ptHy3rr7+B2IICV1n6bwHm2Et1bmkq7sJrv8sAp8v3VJW//Qo/L8HDovj30Mqdcg
        zzaYQgR7eCHVUfUJcO0DfZiIgcWgZjXXxmEekwRN6kcrT/R7PVFpmCrCTwbHlAyL
        JoeosEH6YWacxl0QJ11Vy1Wh3eEKimXRweGDwgkUoejQe1zqryZL1TeOOEy9deHg
        ==
X-ME-Sender: <xms:SCp7XrpYAOgOMze_zBnazOHPXcsSlefSw_UGqiahXauRPvYgS93aUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudehfedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucfkphepjeejrddufe
    drudekhedrjedvnecuvehluhhsthgvrhfuihiivgepieenucfrrghrrghmpehmrghilhhf
    rhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:SCp7XhQadiyCzCBSNwACSXX76uXGZ4EVjVxp4p_CUsGNQ-DbtiBSFw>
    <xmx:SCp7XiqJCQfMj-05sdfe6T6fG9je4t7SpM6VDlhqE2eimvEVbErTOA>
    <xmx:SCp7Xsw7ctJvA59zC6OTAD3ESrUlncR5TvSmTKTTM4C4V84l4147Ng>
    <xmx:SCp7Xj07HIcYefAgJdFbmi-dUAvAaLcCpLaRT_2BPZZlvzb55exdBg>
Received: from vm-mail.pks.im (x4d0db948.dyn.telefonica.de [77.13.185.72])
        by mail.messagingengine.com (Postfix) with ESMTPA id CDC57328005A;
        Wed, 25 Mar 2020 05:54:15 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 9faa6cd2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 25 Mar 2020 09:54:14 +0000 (UTC)
Date:   Wed, 25 Mar 2020 10:54:16 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 7/9] update-ref: move transaction handling into
 `update_refs_stdin()`
Message-ID: <bd92a649d79cde43260358ca939baee0f1a2f076.1585129842.git.ps@pks.im>
References: <cover.1585129842.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
In-Reply-To: <cover.1585129842.git.ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--x+6KMIRAuhnl3hBn
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
index 6f036ae765..5f97bb0b75 100644
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
@@ -382,6 +388,11 @@ static void update_refs_stdin(struct ref_transaction *=
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
@@ -416,21 +427,11 @@ int cmd_update_ref(int argc, const char **argv, const=
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


--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl57KkUACgkQVbJhu7ck
PpSywA//TmHutjskP7LKPZWZOSUiu08flQFl4DG8JyBUKhuwsxNT86LcV/2Y8USS
rCJ8e4ROKnATZXeeIFbUkXgG1CQzSoUoQzdcYm2h3/4HGOgCykXWHbZB9WgM0nrL
EeZIQNxygY+m14oc4aotNfTs+2yBMkW/7TqKJG5kcuPiSble8AYpOY/H/u3AUrVV
AfEED4H4mSqJu2jaVDe7BoPlkqhjnwhIlb6iPsMDReXGoWdekxacSlnuDQj+qTJr
6+YaYO+zjk18Ex93JuuoIzjIj4ZJoqAho6xLII8frAnX9dGBDcT9KgNTylNyNbSc
WIE/W10z9JciF1hjbqTt6i5pfJKkaqR2mtIBbBbBcTpu6Lb/NeOC13EDT4Dz+ldg
VrawtzxvgWIQvBcztWJTSBHKBM5+b8C3IdBf+g/Feei6Ufw9ggiOGrtimtqOfHvQ
hm7BF21ctCrilCFNM/vxVh6reXYlKdYddkz8zuzhBrABHnXOe5Cfg9nTplm72E18
fg1OvBmFsWfLPS6MhWnTRquZohomD+usJR787IqyCvG8dtXgFn653hO3iNRr+J9W
AT+jRI5FS6X0RsbVHY6i1Y4x9H0qTe3fAHCIHO181CAQysC62cnHz+2X7fhcxW3n
ynQTpPD0YZTd3bkFs+6lnmKJijbTcd5ypDH5lXT80pw6tvLJSdk=
=J9Cu
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
