Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B12C43331
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 09:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 033602078D
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 09:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ED/D5Rj8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gh/7bDQL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbgCYJyZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 05:54:25 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:34409 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726043AbgCYJyY (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 25 Mar 2020 05:54:24 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 1AD625C0229;
        Wed, 25 Mar 2020 05:54:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 25 Mar 2020 05:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=Wh+k+Hnb0FDreKuj4sizYeeAjpL
        /fLJ5sNSAB30OMvM=; b=ED/D5Rj8RNiHxNCkcauO5v3gQD3w4WczmgSkyGTP9gt
        XCgi1BQoRjQsbGu235dl8Q6UMiGXM6qSz9RBw83w0Bv5mxNvDV4O9AcawLPGkcof
        OfNXfPAoDzkRuqtF8RbpG7cDmPSZswOuKBfpWA8u1gTaPuf2y+6gJx2yhV4a7VDm
        ph/BVYDCJt8c1sHpeJ8AfBj1csxszMn1mfgc4dBqLkYQ+1k8GtqiO7VL9nQl1efq
        8rBLitXN6qG3uo5qP47CeQW/Tju8zhdXjEbcUG8NVVNV2VY8CgWW4qza3ZBKtaTV
        zW2UgnygSehJ8NWBgMP7NrbynONdoRho5UFWnPEslMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Wh+k+H
        nb0FDreKuj4sizYeeAjpL/fLJ5sNSAB30OMvM=; b=gh/7bDQLMDuKuuVG5RnGUu
        W0JxJquc8taH4fz6KiNLaww8IEkfbkyHXG6faH2NRRdv2w/JsTog+gMgPmNVT6XW
        CTOOCmwqBO5UE0iZqBnFHff2tPlZLc19mSYWjvrB9+EPYpPrONwshsnJ0v1qUAzz
        PPfKIgvTF4eqIhRe+19jICoUUBz7o4PbhjwWLpmRHreotgjG4hsI0wpHCN4TlEnc
        kRKqssew4WUA2idDbxVbYC1HFS3c+tTpCjrGibT+nhCOyL1fn7ClPWo9tha/N1oo
        mjzyruz1Gn0EH0XSuQdf4bJ+91lzms8YCqjN/0Gw+J5G/1bNk3EJrgHkF51RmT6A
        ==
X-ME-Sender: <xms:Tip7XjUzF0iXhEVPXn53q9B1Gp2n3c0eTDgbxoYOqBSsbeVhZOnxOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudehfedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucfkphepjeejrddufe
    drudekhedrjedvnecuvehluhhsthgvrhfuihiivgepjeenucfrrghrrghmpehmrghilhhf
    rhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:Tip7XtfTrBeBRmH5TXHqcx01y8hiSFRCkd2klOPER35pVWEXQLzW_A>
    <xmx:Tip7XkCZ3SHWxZ_otM7of-KoWEEyR2y3VhqFiIQbrdT8n0q12HR9OA>
    <xmx:Tip7Xs0Ic91WGsfJ2s4Xsg9joM3FTR2TpdmikCloZHYtphDUerrTiw>
    <xmx:Typ7Xu1WrCHd1slvEcv3UOcaOZgHezQxddZYd5jacBYVHg2yFPSLdw>
Received: from vm-mail.pks.im (x4d0db948.dyn.telefonica.de [77.13.185.72])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7A907328005A;
        Wed, 25 Mar 2020 05:54:22 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 95263dc8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 25 Mar 2020 09:54:21 +0000 (UTC)
Date:   Wed, 25 Mar 2020 10:54:22 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 8/9] update-ref: read commands in a line-wise fashion
Message-ID: <1db63f97ec78fad794cec51c5d96b093f7cd2440.1585129843.git.ps@pks.im>
References: <cover.1585129842.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <cover.1585129842.git.ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The git-update-ref(1) supports a `--stdin` mode that allows it to read
all reference updates from standard input. This is mainly used to allow
for atomic reference updates that are all or nothing, so that either all
references will get updated or none.

Currently, git-update-ref(1) reads all commands as a single block of up
to 1000 characters and only starts processing after stdin gets closed.
This is less flexible than one might wish for, as it doesn't really
allow for longer-lived transactions and doesn't allow any verification
without committing everything. E.g. one may imagine the following
exchange:

    > start
    < start: ok
    > update refs/heads/master $NEWOID1 $OLDOID1
    > update refs/heads/branch $NEWOID2 $OLDOID2
    > prepare
    < prepare: ok
    > commit
    < commit: ok

When reading all input as a whole block, the above interactive protocol
is obviously impossible to achieve. But by converting the command to
read commands linewise, we can make it more interactive than before.

Obviously, the linewise interface is only a first step in making
git-update-ref(1) work in a more transaction-oriented way. Missing is
most importantly support for transactional commands that manage the
current transaction.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/update-ref.c | 70 ++++++++++++++++++++------------------------
 1 file changed, 31 insertions(+), 39 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 5f97bb0b75..f35e3ca5ae 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -178,8 +178,8 @@ static int parse_next_oid(const char **next, const char=
 *end,
  * line_termination is set.
  */
=20
-static const char *parse_cmd_update(struct ref_transaction *transaction,
-				    const char *next, const char *end)
+static void parse_cmd_update(struct ref_transaction *transaction,
+			     const char *next, const char *end)
 {
 	struct strbuf err =3D STRBUF_INIT;
 	char *refname;
@@ -212,12 +212,10 @@ static const char *parse_cmd_update(struct ref_transa=
ction *transaction,
 	update_flags =3D default_flags;
 	free(refname);
 	strbuf_release(&err);
-
-	return next;
 }
=20
-static const char *parse_cmd_create(struct ref_transaction *transaction,
-				    const char *next, const char *end)
+static void parse_cmd_create(struct ref_transaction *transaction,
+			     const char *next, const char *end)
 {
 	struct strbuf err =3D STRBUF_INIT;
 	char *refname;
@@ -247,12 +245,10 @@ static const char *parse_cmd_create(struct ref_transa=
ction *transaction,
 	update_flags =3D default_flags;
 	free(refname);
 	strbuf_release(&err);
-
-	return next;
 }
=20
-static const char *parse_cmd_delete(struct ref_transaction *transaction,
-				    const char *next, const char *end)
+static void parse_cmd_delete(struct ref_transaction *transaction,
+			     const char *next, const char *end)
 {
 	struct strbuf err =3D STRBUF_INIT;
 	char *refname;
@@ -286,12 +282,10 @@ static const char *parse_cmd_delete(struct ref_transa=
ction *transaction,
 	update_flags =3D default_flags;
 	free(refname);
 	strbuf_release(&err);
-
-	return next;
 }
=20
-static const char *parse_cmd_verify(struct ref_transaction *transaction,
-				    const char *next, const char *end)
+static void parse_cmd_verify(struct ref_transaction *transaction,
+			     const char *next, const char *end)
 {
 	struct strbuf err =3D STRBUF_INIT;
 	char *refname;
@@ -318,12 +312,10 @@ static const char *parse_cmd_verify(struct ref_transa=
ction *transaction,
 	update_flags =3D default_flags;
 	free(refname);
 	strbuf_release(&err);
-
-	return next;
 }
=20
-static const char *parse_cmd_option(struct ref_transaction *transaction,
-				    const char *next, const char *end)
+static void parse_cmd_option(struct ref_transaction *transaction,
+			     const char *next, const char *end)
 {
 	const char *rest;
 	if (!skip_prefix(next, " ", &next))
@@ -332,60 +324,60 @@ static const char *parse_cmd_option(struct ref_transa=
ction *transaction,
 		update_flags |=3D REF_NO_DEREF;
 	else
 		die("option unknown: %s", next);
-	return rest;
 }
=20
 static const struct parse_cmd {
 	const char *prefix;
-	const char *(*fn)(struct ref_transaction *, const char *, const char *);
+	void (*fn)(struct ref_transaction *, const char *, const char *);
+	unsigned extra_lines;
 } commands[] =3D {
-	{ "update", parse_cmd_update },
-	{ "create", parse_cmd_create },
-	{ "delete", parse_cmd_delete },
-	{ "verify", parse_cmd_verify },
-	{ "option", parse_cmd_option },
+	{ "update", parse_cmd_update, 2 },
+	{ "create", parse_cmd_create, 1 },
+	{ "delete", parse_cmd_delete, 1 },
+	{ "verify", parse_cmd_verify, 1 },
+	{ "option", parse_cmd_option, 0 },
 };
=20
 static void update_refs_stdin(void)
 {
 	struct strbuf input =3D STRBUF_INIT, err =3D STRBUF_INIT;
 	struct ref_transaction *transaction;
-	const char *next;
-	int i;
-
-	if (strbuf_read(&input, 0, 1000) < 0)
-		die_errno("could not read from stdin");
-	next =3D input.buf;
+	int i, j;
=20
 	transaction =3D ref_transaction_begin(&err);
 	if (!transaction)
 		die("%s", err.buf);
=20
 	/* Read each line dispatch its command */
-	while (next < input.buf + input.len) {
+	while (!strbuf_getwholeline(&input, stdin, line_termination)) {
 		const struct parse_cmd *cmd =3D NULL;
=20
-		if (*next =3D=3D line_termination)
+		if (*input.buf =3D=3D line_termination)
 			die("empty command in input");
-		else if (isspace(*next))
-			die("whitespace before command: %s", next);
+		else if (isspace(*input.buf))
+			die("whitespace before command: %s", input.buf);
=20
 		for (i =3D 0; i < ARRAY_SIZE(commands); i++) {
-			if (!skip_prefix(next, commands[i].prefix , &next))
+			if (!starts_with(input.buf, commands[i].prefix))
 				continue;
 			cmd =3D &commands[i];
 			break;
 		}
 		if (!cmd)
-			die("unknown command: %s", next);
+			die("unknown command: %s", input.buf);
=20
 		if (input.buf[strlen(cmd->prefix)] !=3D line_termination &&
 		    input.buf[strlen(cmd->prefix)] !=3D '\0' &&
 		    input.buf[strlen(cmd->prefix)] !=3D ' ')
 			die("%s: no separator after command", cmd->prefix);
=20
-		next =3D cmd->fn(transaction, next, input.buf + input.len);
-		next++;
+		/* Read extra lines if NUL-terminated */
+		for (j =3D 0; line_termination =3D=3D '\0' && j < cmd->extra_lines; j++)
+			if (strbuf_appendwholeline(&input, stdin, line_termination))
+				break;
+
+		cmd->fn(transaction, input.buf + strlen(cmd->prefix),
+			input.buf + input.len);
 	}
=20
 	if (ref_transaction_commit(transaction, &err))
--=20
2.26.0


--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl57KkwACgkQVbJhu7ck
PpSZXA//fyaHsUw+ZOSxMDMh8Fgu0HJph5vO0WgOvxlawJv5kp8AEKB6mHYQyZ6m
eaiNEV97vhL8SbATtwuFnf7kvZ2sEZUHkMWqHcjwS7FpCr5M7/hazKhuBPfr1W4F
/Czd3UG9rnwRA02Ie9YS5h2LDJQGVze//40nobBoGszAOgc33v7mAmkvdLwoLii0
+gHcRVrv81XCGmn/EFsXdJBrEw18hDvYBbGgMeSx0Ftl30tWF0uixbyQtFoQs3Bj
xa7q8T1WPCPTXDV3A4wwYr1dPB7DJZ8HKzYjbsadfi0CLwp3hruNba0A3LO92PVV
pCvT9eABhhc1ySErjx1xQXiajaZdnVoVcBYAFu3Ht8htnEA4L/ImWOft6ksexaIe
W5MKiU/ZHcLpiCaPZUW2LB6R1Kxy+uoLIEezajmS7psGRiZbOXkUO9Ie8q7uyWxX
8tTPjUWd2v/dvTbEAvKolwdObZn8Vxu/1PRdthoKR7IA+NFDDZBHmZaEIuVwhWMP
2wTGpVZsr1gcMT2SfGIWZMopkMnBtTuRDmiH6SgUQ+niuyuy7cwgzRa7PbP9E+83
/GQs/lsBDeFJjOhzM1CgE+NXI+6V8lYOF8a5vtTpTtrxwDvBSJ2ToWg5aDyWuKS6
kyXvCaY7Uwc4eOhJv0wnvBqyPnKkHJ+dJMB63C8p+IRR0+oFD7k=
=zE0d
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
