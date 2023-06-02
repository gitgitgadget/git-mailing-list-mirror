Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC206C7EE24
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 13:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235761AbjFBNC4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 09:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235595AbjFBNCu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 09:02:50 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350811B5
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 06:02:48 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 752AB5C010C;
        Fri,  2 Jun 2023 09:02:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 02 Jun 2023 09:02:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1685710967; x=1685797367; bh=q7
        GCfA8V7HDnBKB1Tk915p6kG3FU/Mzd1fXGookrldg=; b=ALJEmeBqDEIIgyPm1f
        KNynlvhwQpASJGCmr+qsbV/GJazqh3I1psc4mx1gAp3w1Vp0FjKhHc5oCH+JP2oM
        29mhyVA2XC7l56TKtP+YiMC2O/h+zEjeYob6dtL+bDS7fjPtTWGVX7K1Fs8ujhNy
        BkeBffhlLZiiUpmOtGXG+2foieNmbJI89BUBzWJ7X+NHu0yxpvVayzofWXSeQVXC
        VkzlChxppkoy3S93HLaNnAYFUd/lxAIkYWKPCnfy5A5mRVPaC9sym8/9NIEhMsTO
        xLwJ82aMbj7UX2pavlCOti0ynV9itqDFkBp7WZnQN1KzxiUzSx3vx5TAaUuOEegj
        z0GA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685710967; x=1685797367; bh=q7GCfA8V7HDnB
        KB1Tk915p6kG3FU/Mzd1fXGookrldg=; b=nLPBtL9N94jISAWIqBsAHNhw/A/ID
        xu6p9llSHcecaKj5fd8UsZEHEgTmbJ7Kxur8TExIZnLxjdo0cr1kRg+O+bNix0DT
        mzEYNxKiX9nvBs//pqPqBCodGTUdGrY08zTTfqkuJp/39ayrdiRfsZaUnvuT2FA7
        WiyHyKePLCF4jT3FpA0cLoUM1KKi5tByyX4yQNa1PGsbvBxnw96CFnSJ6bOat0d4
        qaBqMd4HM8sePEdkAIDJmOVSeZGqkUD5AmUJNYTHM1iibQCDFY5ohy5f5Fy6wv5N
        ynqpTqvHjrYHGopmzMwKG9o/zkMjVe9KKsumA7A2lephsmbi4mZH8C2MQ==
X-ME-Sender: <xms:duh5ZNGQlN762hk7AhlRWXxiH-5O3CzzY3N8q0hXHaT3Qx65kS_bgQ>
    <xme:duh5ZCWL_0Ued2erdHXnZ-TUDr1go_GY7f2i7eFm_zCvvfvkszDR--jlI2gWlxafH
    bseNqegu791fT8Bug>
X-ME-Received: <xmr:duh5ZPLUTbiL9B-uY4-1pt9RMSV-H_eWDKUB8MKf2CFXwynJjX_8Sq_prf13llTEdw8DbiParcQPQe4st0-L7hHwAzE42JiDfBWLziheppeFtg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeelfedgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:duh5ZDGDcNYkvhmNsGX1P6YJFp4D7CmNZH31hNEzH4CZFilm4v4pJg>
    <xmx:duh5ZDWmNQ-usGFQwz5I-FFZ9wCKoaNuVJkhlq8iYGHR0iorrc60ag>
    <xmx:duh5ZOP-7VxujC5O_tdujUil0vAb15QlaMSoABAjnCMpJKNQv7FHIQ>
    <xmx:d-h5ZOQ9dIVqSbsyK5zU4PeGozczVuu_y5M0ENtEP-xwUJ6TH_EtcA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Jun 2023 09:02:45 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 7593346e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 2 Jun 2023 13:01:49 +0000 (UTC)
Date:   Fri, 2 Jun 2023 15:02:42 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/5] cat-file: simplify reading from standard input
Message-ID: <e7cba8dc4cebde0841ac04702155890d87e74492.1685710884.git.ps@pks.im>
References: <cover.1685710884.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WN44MJKrqWK7T5ux"
Content-Disposition: inline
In-Reply-To: <cover.1685710884.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--WN44MJKrqWK7T5ux
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The batch modes of git-cat-file(1) read queries from stantard input that
are either newline- or NUL-delimited. This code was introduced via
db9d67f2e9 (builtin/cat-file.c: support NUL-delimited input with `-z`,
2022-07-22), which notes that:

"""
The refactoring here is slightly unfortunate, since we turn loops like:

     while (strbuf_getline(&buf, stdin) !=3D EOF)

 into:

     while (1) {
         int ret;
         if (opt->nul_terminated)
             ret =3D strbuf_getline_nul(&input, stdin);
         else
             ret =3D strbuf_getline(&input, stdin);

         if (ret =3D=3D EOF)
             break;
     }
"""

The commit proposed introducing a helper function that is easier to use,
which is just what we have done in the preceding commit. Refactor the
code to use this new helper to simplify the loop.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/cat-file.c | 32 +++++++++-----------------------
 1 file changed, 9 insertions(+), 23 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 0bafc14e6c..001dcb24d6 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -42,7 +42,7 @@ struct batch_options {
 	int all_objects;
 	int unordered;
 	int transform_mode; /* may be 'w' or 'c' for --filters or --textconv */
-	int nul_terminated;
+	char input_delim;
 	const char *format;
 };
=20
@@ -694,20 +694,12 @@ static void batch_objects_command(struct batch_option=
s *opt,
 	struct queued_cmd *queued_cmd =3D NULL;
 	size_t alloc =3D 0, nr =3D 0;
=20
-	while (1) {
-		int i, ret;
+	while (strbuf_getdelim_strip_crlf(&input, stdin, opt->input_delim) !=3D E=
OF) {
+		int i;
 		const struct parse_cmd *cmd =3D NULL;
 		const char *p =3D NULL, *cmd_end;
 		struct queued_cmd call =3D {0};
=20
-		if (opt->nul_terminated)
-			ret =3D strbuf_getline_nul(&input, stdin);
-		else
-			ret =3D strbuf_getline(&input, stdin);
-
-		if (ret)
-			break;
-
 		if (!input.len)
 			die(_("empty command in input"));
 		if (isspace(*input.buf))
@@ -851,16 +843,7 @@ static int batch_objects(struct batch_options *opt)
 		goto cleanup;
 	}
=20
-	while (1) {
-		int ret;
-		if (opt->nul_terminated)
-			ret =3D strbuf_getline_nul(&input, stdin);
-		else
-			ret =3D strbuf_getline(&input, stdin);
-
-		if (ret =3D=3D EOF)
-			break;
-
+	while (strbuf_getdelim_strip_crlf(&input, stdin, opt->input_delim) !=3D E=
OF) {
 		if (data.split_on_whitespace) {
 			/*
 			 * Split at first whitespace, tying off the beginning
@@ -929,6 +912,7 @@ int cmd_cat_file(int argc, const char **argv, const cha=
r *prefix)
 	const char *exp_type =3D NULL, *obj_name =3D NULL;
 	struct batch_options batch =3D {0};
 	int unknown_type =3D 0;
+	int input_nul_terminated =3D 0;
=20
 	const char * const usage[] =3D {
 		N_("git cat-file <type> <object>"),
@@ -965,7 +949,7 @@ int cmd_cat_file(int argc, const char **argv, const cha=
r *prefix)
 			N_("like --batch, but don't emit <contents>"),
 			PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
 			batch_option_callback),
-		OPT_BOOL('z', NULL, &batch.nul_terminated, N_("stdin is NUL-terminated")=
),
+		OPT_BOOL('z', NULL, &input_nul_terminated, N_("stdin is NUL-terminated")=
),
 		OPT_CALLBACK_F(0, "batch-command", &batch, N_("format"),
 			N_("read commands from stdin"),
 			PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
@@ -1024,10 +1008,12 @@ int cmd_cat_file(int argc, const char **argv, const=
 char *prefix)
 	else if (batch.all_objects)
 		usage_msg_optf(_("'%s' requires a batch mode"), usage, options,
 			       "--batch-all-objects");
-	else if (batch.nul_terminated)
+	else if (input_nul_terminated)
 		usage_msg_optf(_("'%s' requires a batch mode"), usage, options,
 			       "-z");
=20
+	batch.input_delim =3D input_nul_terminated ? '\0' : '\n';
+
 	/* Batch defaults */
 	if (batch.buffer_output < 0)
 		batch.buffer_output =3D batch.all_objects;
--=20
2.40.1


--WN44MJKrqWK7T5ux
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmR56HEACgkQVbJhu7ck
PpSLJhAAm6S+nFTnfnj/IvGIW/YfTvBhEbWcSoZ6rQsvvj6d3sMBDUl9bV/da+9D
yEpmaP64ZCdUln1Cl/rR4na5WmgjPjWlwlipSAw/0MsBMMVja9tdXsdyctHrVyTs
Q0iUmz577siqMhP5pbUXlO6qglYbnRb3UbfzZU/rBZEGG6z+AF4g3IdcR1B7Xb7W
MUU3048at5qP1qbcEsLcyYcafd2R0a41z3UZyCDYTiOyWwKH+Ab8UicfyBKD7eXi
NYP4FdKD0T0rvfg389QbKZ2RKaBsUUtVqWKje5XMkklFjopAh6tkpzGt5TTWhDaI
jZtXqMIQzYf5dAAmdvfFjr1cIwESHPO3x9SoVNw9Srz2lEVRgw68y6+5NQpgc3za
SZRKVdkTDjF9LL4mK48HHvAqHoJHXF491ESk/QJT8RFbzoEuijkTisa4PVTmyxxL
rb/F86GJgwxz+YFbi8I0M1545ZNjb6NGSvMH0tShyFacvM8njtmgmT1h7HkdGNsA
acTsUmFkr0jeyMboZNjpncUM2+C6PeJZ9acLrAkjZ2uq7zQSU9lylU1WtmjDFYbh
bItogpTAc1sBUYzry8hM/qhBhkEl4iJa2A1TqNkigM6ICFq9xQL1cRaRTM5a3MsZ
ZLi+VhGyKHjff3nTHurqmc426oTqrJjVGLaGHyR7pZ1Iwnt/Lcc=
=Dag2
-----END PGP SIGNATURE-----

--WN44MJKrqWK7T5ux--
