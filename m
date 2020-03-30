Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3291C43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 13:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B47672073B
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 13:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZJDjpnYC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k4IqQqab"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbgC3Nqd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 09:46:33 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:46345 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728065AbgC3Nqc (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 30 Mar 2020 09:46:32 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id C12CE3AA;
        Mon, 30 Mar 2020 09:46:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 30 Mar 2020 09:46:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=1f1Lu6keEugHfrxsIQge5geVX55
        q+O8JboNY7AbEoRQ=; b=ZJDjpnYC1mo5UcGl5EcbfpyPklT+Wv5do90H4SlsPkj
        NY6eCvOdwOt2ZrV3AERunyw6x92iFvMWRRNyU/5Lez1YZNoQ8BI+O41P/8quZPwC
        0aUvWVqMkg88R54l1RmKwWGMn53C/WypPREIbfMRpwM/i5+8z9VOutNa8iSe+Xl8
        6skKKnyRjV+2XCga/mRV1rkf+kDDeSRf81YRF601r6/p9u7VfdXzAWJgfNuVbOfV
        RPF84FKWV/UdTpkz6PUeMlVadIsCyZkwsjflLv3qFPENv7gOYIk2cx40ZqHm7AbF
        bNOWeNUQEe9GVLcfB8jGDUQaDLq+hZAx2CTikRgSjyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=1f1Lu6
        keEugHfrxsIQge5geVX55q+O8JboNY7AbEoRQ=; b=k4IqQqabW2XLzbErOcNkNb
        THFk8sWWAIinMFVuy3wI0lHcrcAunCaE19p7Y3rsMWB0tLm/qU8rfKczuS7ubciY
        7WcUs0ub6Yq8y+mNHeLVVn4NDrOEEXxok4vC4FyJON1aoXXPbaRzuYtxO91e/EJk
        ququWEyKO5kD3j7/i9EYhAgXdjugLQR8KDw1mSjXF9CbDBJAJGOrZ+9ZAIswuy0R
        AzzNwa1IiBLzcYzHQrIfIY17YPOM+B2bLw31bxikna5+X1QbIMljfEwyY+x9SCwS
        NT1r25bcBvE517y1QqoxKuet2+3YzzoSgN6HjZfLBncmUy1WqsahJr753J15Mkxg
        ==
X-ME-Sender: <xms:N_iBXsbqNBW_0-tFTKRtP93pa-06VTiknDKBffTrs1rGabY8E5aMyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudeihedgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucfkphepjeekrdehge
    drvddvtddruddtvdenucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:N_iBXu3Rz2aCb25VVQwvag3fFhcenaBBAzmlvFIVQTWbEkZhaSXDUg>
    <xmx:N_iBXkVYEb7qcLWVE3bLGwQwJc_zmZtkc_o_f_VgFyHyaQYTyefWFg>
    <xmx:N_iBXgUXF6F9AavsA00Fx4q9Tfvt5WDIt2ZRxeijkM3jFyHNx8jkEg>
    <xmx:N_iBXg00Mj9xWPhnC-FZiyzwhTTFgTu3Jsq6UHKvB5IW34FcjW5CDQ>
Received: from vm-mail.pks.im (x4e36dc66.dyn.telefonica.de [78.54.220.102])
        by mail.messagingengine.com (Postfix) with ESMTPA id C48113280068;
        Mon, 30 Mar 2020 09:46:30 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id b6a45f62 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 30 Mar 2020 13:46:29 +0000 (UTC)
Date:   Mon, 30 Mar 2020 15:46:33 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/9] update-ref: organize commands in an array
Message-ID: <bd8c059fbcd9dc21203dff61e047af66e4239caf.1585575749.git.ps@pks.im>
References: <cover.1585129842.git.ps@pks.im>
 <cover.1585575749.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <cover.1585575749.git.ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We currently manually wire up all commands known to `git-update-ref
--stdin`, making it harder than necessary to preprocess arguments after
the command is determined. To make this more extensible, let's refactor
the code to use an array of known commands instead. While this doesn't
add a lot of value now, it is a preparatory step to implement line-wise
reading of commands.

As we're going to introduce commands without trailing spaces, this
commit also moves whitespace parsing into the respective commands.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/update-ref.c | 73 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 56 insertions(+), 17 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 2d8f7f0578..559475681e 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -171,11 +171,11 @@ static int parse_next_oid(struct strbuf *input, const=
 char **next,
 /*
  * The following five parse_cmd_*() functions parse the corresponding
  * command.  In each case, next points at the character following the
- * command name and the following space.  They each return a pointer
- * to the character terminating the command, and die with an
- * explanatory message if there are any parsing problems.  All of
- * these functions handle either text or binary format input,
- * depending on how line_termination is set.
+ * command name.  They each return a pointer to the character
+ * terminating the command, and die with an explanatory message if
+ * there are any parsing problems.  All of these functions handle
+ * either text or binary format input, depending on how
+ * line_termination is set.
  */
=20
 static const char *parse_cmd_update(struct ref_transaction *transaction,
@@ -186,6 +186,9 @@ static const char *parse_cmd_update(struct ref_transact=
ion *transaction,
 	struct object_id new_oid, old_oid;
 	int have_old;
=20
+	if (!skip_prefix(next, " ", &next))
+		die("update: missing space after command");
+
 	refname =3D parse_refname(input, &next);
 	if (!refname)
 		die("update: missing <ref>");
@@ -220,6 +223,9 @@ static const char *parse_cmd_create(struct ref_transact=
ion *transaction,
 	char *refname;
 	struct object_id new_oid;
=20
+	if (!skip_prefix(next, " ", &next))
+		die("create: missing space after command");
+
 	refname =3D parse_refname(input, &next);
 	if (!refname)
 		die("create: missing <ref>");
@@ -253,6 +259,9 @@ static const char *parse_cmd_delete(struct ref_transact=
ion *transaction,
 	struct object_id old_oid;
 	int have_old;
=20
+	if (!skip_prefix(next, " ", &next))
+		die("delete: missing space after command");
+
 	refname =3D parse_refname(input, &next);
 	if (!refname)
 		die("delete: missing <ref>");
@@ -288,6 +297,9 @@ static const char *parse_cmd_verify(struct ref_transact=
ion *transaction,
 	char *refname;
 	struct object_id old_oid;
=20
+	if (!skip_prefix(next, " ", &next))
+		die("verify: missing space after command");
+
 	refname =3D parse_refname(input, &next);
 	if (!refname)
 		die("verify: missing <ref>");
@@ -310,9 +322,12 @@ static const char *parse_cmd_verify(struct ref_transac=
tion *transaction,
 	return next;
 }
=20
-static const char *parse_cmd_option(struct strbuf *input, const char *next)
+static const char *parse_cmd_option(struct ref_transaction *transaction,
+				    struct strbuf *input, const char *next)
 {
 	const char *rest;
+	if (!skip_prefix(next, " ", &next))
+		die("option: missing space after command");
 	if (skip_prefix(next, "no-deref", &rest) && *rest =3D=3D line_termination)
 		update_flags |=3D REF_NO_DEREF;
 	else
@@ -320,33 +335,57 @@ static const char *parse_cmd_option(struct strbuf *in=
put, const char *next)
 	return rest;
 }
=20
+static const struct parse_cmd {
+	const char *prefix;
+	const char *(*fn)(struct ref_transaction *, struct strbuf *, const char *=
);
+} command[] =3D {
+	{ "update", parse_cmd_update },
+	{ "create", parse_cmd_create },
+	{ "delete", parse_cmd_delete },
+	{ "verify", parse_cmd_verify },
+	{ "option", parse_cmd_option },
+};
+
 static void update_refs_stdin(struct ref_transaction *transaction)
 {
 	struct strbuf input =3D STRBUF_INIT;
 	const char *next;
+	int i;
=20
 	if (strbuf_read(&input, 0, 1000) < 0)
 		die_errno("could not read from stdin");
 	next =3D input.buf;
 	/* Read each line dispatch its command */
 	while (next < input.buf + input.len) {
+		const struct parse_cmd *cmd =3D NULL;
+
 		if (*next =3D=3D line_termination)
 			die("empty command in input");
 		else if (isspace(*next))
 			die("whitespace before command: %s", next);
-		else if (skip_prefix(next, "update ", &next))
-			next =3D parse_cmd_update(transaction, &input, next);
-		else if (skip_prefix(next, "create ", &next))
-			next =3D parse_cmd_create(transaction, &input, next);
-		else if (skip_prefix(next, "delete ", &next))
-			next =3D parse_cmd_delete(transaction, &input, next);
-		else if (skip_prefix(next, "verify ", &next))
-			next =3D parse_cmd_verify(transaction, &input, next);
-		else if (skip_prefix(next, "option ", &next))
-			next =3D parse_cmd_option(&input, next);
-		else
+
+		for (i =3D 0; i < ARRAY_SIZE(command); i++) {
+			const char *prefix =3D command[i].prefix;
+
+			if (!skip_prefix(next, prefix, &next))
+				continue;
+
+			/*
+			 * Check that the command is terminated by an argument
+			 * or line terminator and not only a matching prefix.
+			 */
+			if (input.buf[strlen(prefix)] !=3D line_termination &&
+			    input.buf[strlen(prefix)] !=3D '\0' &&
+			    input.buf[strlen(prefix)] !=3D ' ')
+				continue;
+
+			cmd =3D &command[i];
+			break;
+		}
+		if (!cmd)
 			die("unknown command: %s", next);
=20
+		next =3D cmd->fn(transaction, &input, next);
 		next++;
 	}
=20
--=20
2.26.0


--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl6B+DcACgkQVbJhu7ck
PpQAlQ/8Dm2tsBkQBjcyJzfiAz/685i8KxDlY877qaAryV7dhR3O5db9WRRtwTyp
5G+3hv83wlgHHqmNt45IR09OHlcwe7MWOdW87UPaivO2CkcCWO7Pn39TTQ+2k1o5
sMnjeYWfzVqS3RcFrS3DVPR44P+/41qkF9MsG64C2cZfjU37Ln1bH6CZDdKnXGZF
YVpzckXIvcqYI/r+6E71z15eW5kSxvRoIENvgUO/IQTPPQ2Ho/K4rWKsDIai857L
X+ffeHsq+mEOmPL+HmG2ApeCHvkdRPisYLAW7yRv+dKMUj6WdxhQ076N05A0qlO7
UYgKTiEHgIg+TLrCZcEPUGvqucXj1td2MBtpvM0i0HaSpkUAK+upCJ2/1slTX2ZO
WZ6eOBMbImF+dKEd+TJPNly3IuuiL5c2a4VjnW3eXUsNvzBpHnUNJcchujxevotA
dOi8meQ9uo2DjmLaInMaH1HdTOVd+1DDiRUgV4HJTW5B/mMJua60Fz4U+gR0ngkI
7pCYa9W53Jg5K4PLqgsG1mWgQ9VNitI84ThyYYoF3V53BVfIivDoKXbrhcd8b9ni
JGM4wcHhFAKQoNyoXKnRY5W5ibIumXf5QSJfGFjbItdGn+mqnNIOvV8FtVFZD4//
RjXRPDHgh2GIpIl4wLrSy0vAB0jF1b4e86V1BGp/YtBpjDKt2tY=
=hxOp
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
