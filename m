Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C675C43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 07:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F4D020784
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 07:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Rn21MBAe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f4rsYwjH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387545AbgDBHJy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 03:09:54 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:51147 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725789AbgDBHJy (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 2 Apr 2020 03:09:54 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id EE1B95C028D;
        Thu,  2 Apr 2020 03:09:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 02 Apr 2020 03:09:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=JNtzGwZ7jYj24wKTpl9eK6iafaT
        igj7Es7cpy3cEbX8=; b=Rn21MBAenS5x3OYbg4TJkhwwLmd1x7j4CmOIWb3So2W
        RNfex6+vJGlvNMWnY+gjgA5+2IeTd0Ze6C309Ndqo6y0CvlWg0oGtTwC0B51q6jf
        Hudowv6fnGsPR9qH8jygokrKgWdR33Xsav7dwtS/y9lN4s017Sgj09TUkhKMNdFI
        CTvT04qVnMf/3wKDv0PlfYRI88I897kpXS0jaMpZP6PUW7Zn0NAhLSBbfQFqGwxH
        T1ln8G3qaxS7b8fZR6rwaWSCAfTNwi5m14Me3Syzb8t/Kb+q1xdsmGmdkiQ0y1Qp
        rkkPmobtWUCdlU4cZSNQmFbKVaACWO3rW5VxrvdMKrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=JNtzGw
        Z7jYj24wKTpl9eK6iafaTigj7Es7cpy3cEbX8=; b=f4rsYwjH1nAewFV+b/zjFf
        ynm/wrOcfWp89Bb5MzP4FY9QD5MQKcQHTkth0i2jVFELj5SPcxbGxaEZOc4g3rn6
        ljJZvQJbhYRoVy3nX84DyqaYlfZKLvfVKle1jaO4Ciy+X2hQFOQiGaYrqhqwd7MW
        4m2oX4Jlbs0dLpPRPC49TwKctNk3amZ7nsSg6YebGA+20OBwn1ttM57AoUFmFLMF
        1xIBthP32m1kzW8EEJkdksMTMtspa7cw7OqbqvqQCcgGMfAPIHqFvBrEcBscUPvC
        JD2Cuaeiz84ZZWdEDX8E+tnTLAlK4VCONYhiJGQ4rfNf7XDzLSSvih3CjXBIN8gg
        ==
X-ME-Sender: <xms:wI-FXt8kq5M88_LX7yIZ24Ct7v0PZNj_dLj_JlolNVlOhCFlsq__qQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrtdefgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucfkphepkeelrdduvd
    drleegrddvkeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:wI-FXtiU5BZTD0diahbyA5B_TnLSpzlU7jFNTA28n3Sz2aasxxLHEg>
    <xmx:wI-FXgius4Oh6YSe51LYYmnBEMNKN_LsXL3244kgNbmuNea6KlxZOg>
    <xmx:wI-FXj5lOFc9PvAgiJylB7o7BqqSWy3gWKlBCuukKL_lx3QpKBGK9Q>
    <xmx:wI-FXuBcRvsltu22GDmerS-VQin0vRxuxAsPGZ-8IQ13g90hOKxe9Q>
Received: from vm-mail.pks.im (x590c5e1c.dyn.telefonica.de [89.12.94.28])
        by mail.messagingengine.com (Postfix) with ESMTPA id 42FD7306CDC1;
        Thu,  2 Apr 2020 03:09:52 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 8264c6c8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 2 Apr 2020 07:09:50 +0000 (UTC)
Date:   Thu, 2 Apr 2020 09:09:57 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 8/9] update-ref: read commands in a line-wise fashion
Message-ID: <02ff6b7337cd821c74f2221c2c567e0105c01e0d.1585811014.git.ps@pks.im>
References: <cover.1585129842.git.ps@pks.im>
 <cover.1585811013.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
In-Reply-To: <cover.1585811013.git.ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--x+6KMIRAuhnl3hBn
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
 builtin/update-ref.c | 85 +++++++++++++++++++++++---------------------
 1 file changed, 45 insertions(+), 40 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 0f34b68904..348407b896 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -178,8 +178,8 @@ static int parse_next_oid(const char **next, const char=
 *end,
  * depending on how line_termination is set.
  */
=20
-static const char *parse_cmd_update(struct ref_transaction *transaction,
-				    const char *next, const char *end)
+static void parse_cmd_update(struct ref_transaction *transaction,
+			     const char *next, const char *end)
 {
 	struct strbuf err =3D STRBUF_INIT;
 	char *refname;
@@ -209,12 +209,10 @@ static const char *parse_cmd_update(struct ref_transa=
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
@@ -241,12 +239,10 @@ static const char *parse_cmd_create(struct ref_transa=
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
@@ -277,12 +273,10 @@ static const char *parse_cmd_delete(struct ref_transa=
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
@@ -306,71 +300,82 @@ static const char *parse_cmd_verify(struct ref_transa=
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
 	if (skip_prefix(next, "no-deref", &rest) && *rest =3D=3D line_termination)
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
+	unsigned args;
 } command[] =3D {
-	{ "update", parse_cmd_update },
-	{ "create", parse_cmd_create },
-	{ "delete", parse_cmd_delete },
-	{ "verify", parse_cmd_verify },
-	{ "option", parse_cmd_option },
+	{ "update", parse_cmd_update, 3 },
+	{ "create", parse_cmd_create, 2 },
+	{ "delete", parse_cmd_delete, 2 },
+	{ "verify", parse_cmd_verify, 2 },
+	{ "option", parse_cmd_option, 1 },
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
 		for (i =3D 0; i < ARRAY_SIZE(command); i++) {
 			const char *prefix =3D command[i].prefix;
+			char c;
=20
-			if (!skip_prefix(next, prefix, &next) ||
-			    !skip_prefix(next, " ", &next))
+			if (!starts_with(input.buf, prefix))
+				continue;
+
+			/*
+			 * If the command has arguments, verify that it's
+			 * followed by a space. Otherwise, it shall be followed
+			 * by a line terminator.
+			 */
+			c =3D command[i].args ? ' ' : line_termination;
+			if (input.buf[strlen(prefix)] !=3D c)
 				continue;
=20
 			cmd =3D &command[i];
 			break;
 		}
 		if (!cmd)
-			die("unknown command: %s", next);
+			die("unknown command: %s", input.buf);
=20
-		next =3D cmd->fn(transaction, next, input.buf + input.len);
-		next++;
+		/*
+		 * Read additional arguments if NUL-terminated. Do not raise an
+		 * error in case there is an early EOF to let the command
+		 * handle missing arguments with a proper error message.
+		 */
+		for (j =3D 1; line_termination =3D=3D '\0' && j < cmd->args; j++)
+			if (strbuf_appendwholeline(&input, stdin, line_termination))
+				break;
+
+		cmd->fn(transaction, input.buf + strlen(cmd->prefix) + !!cmd->args,
+			input.buf + input.len);
 	}
=20
 	if (ref_transaction_commit(transaction, &err))
--=20
2.26.0


--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl6Fj8UACgkQVbJhu7ck
PpSdrg//d2DTiDq82MqKT0YvVuWqoEtLXd2nd6HUY8maEdenJ9MqWX3ZPYxnAMY1
nDtIpAIueCOaI7SoKsp+EU13sluh46qceUM7AWWfvB5Oq6yZhxjT7eRApN9Q6SSV
Rs39iG0N98bvm+rRYb1Cdg1sQ5YDM1YfaKdqhgh3QAks1AbesF7wTcjAspdzXMzn
hmXOUnbsjSJcg45xuN5LVd2J00RopIrh0ACAAuQykDVd9ID60UvoHyJO28WafHst
sKhOoJDL6x8+pOAxm0K7G/eD3B4BnT8+ocR0+UXP+IshrYDQSSWnSNfnm2ffVHOY
kf4ewbrOPFVVvHTsuxGf8MsMBrriz42qxk6ywIScbhFPlaspLWZdij8qZB9H6Uwm
GOkBQP0MJb43yrwkOlrDNKgftjCydPDX0M3CM94flk8jyZHwx0rzkT5kMQ4qDcTq
qXs9l0hjU0JWdQkzpUe6Pwpe75BWoehrV4XyjBtZ+QCg+WlaPzprOz5GrcivIH3l
AGGbhd4vYOlbQHMShZftmPyGweQFOL3zt8GL5LQUbzbib7YjrjgfdOQFkDccN4sU
Of+CJOpcS2zWter0BTgV8zr+5Mr3wONJhuINcFVcGIyvZ6dYa4SQT1wuqRaKk8/b
jE+d03s4gJ1O0MgYMljuCdqi8LfDM35jMm/kw9n19jaSa71NZIA=
=wy1I
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
