Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3146DC77B7A
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 05:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbjFFFUL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jun 2023 01:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234597AbjFFFTw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2023 01:19:52 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C8CE48
        for <git@vger.kernel.org>; Mon,  5 Jun 2023 22:19:46 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 708043200AD8;
        Tue,  6 Jun 2023 01:19:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 06 Jun 2023 01:19:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1686028785; x=1686115185; bh=vf
        cPmJ4efmXjiTOW83TQsU5+kFT87977jH3HBHHPl7Q=; b=OPxlFyl0VKV+Huii3N
        9yHfu0s80BAtIbuzYYvwqaeAYh+tlfY1n4spXMV0aJxp8BPsVypf8kp37VjIk7xu
        bqIo4LrTfoVrHsE47sUIK6fpQtTa8AQgoFaiCt8Jj0dnm22d5brF8IAJ2AFoz/ia
        m8tKfS/jmILmAbLP2m3uN+GA9Qu+j3sN3uc5JB3TS0MFa/V6V2he2UAMQhvr4xuz
        gAYHWP4Cr8OrjNiY434B3NA3Y+XPip56E1xVzn3760bYOYsfuniz7avN7+nC9MtO
        bvC96RetcANlHRQu+WVqwkI7FD+DTTOSaCrZXfLAhYZ4VN1rukRUptBTXgcY5KvZ
        5big==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1686028785; x=1686115185; bh=vfcPmJ4efmXji
        TOW83TQsU5+kFT87977jH3HBHHPl7Q=; b=v+1y2g888m1bm9kEYGOaZCP3J3lHu
        qu01pPGexT22W9LQNEe7s6+0/qXSGdDFRz+HrCFOaeeZTlw+y8W82zJUfAPhFryk
        nH8QTNFJTxnvxthhzC/gFk4m9UMKchM/SFVEmuIPKIRmUansqtvQeQ5TJmcbHMew
        rIqnVSKhcW7fVW/8shzmTcJN/P3oriWKs08ENAF63hmoXBr2iExhki8ZWs2FZhNO
        UYd8nj2GCeT1ryBxW6rrqSf13VaUZJ2MdPch9cAkMInxWI07kTUW7FSLiVHDnFbz
        HvYUV8/JnGqGtxIbgrcHO88blAUoFch1Dr/tCGt7TnE3O/WRyRT+KMteQ==
X-ME-Sender: <xms:8MF-ZOmw_GDlztr88GvYUSKG98bYrJ25g7OYbG3SIwfpyQOgnnrtuQ>
    <xme:8MF-ZF3FSr-9d5l6p9bJ847Pp5dFtufRXqZJVzldO1-JADUWgjBegmNVVr7IbfEZA
    qxGzm14L6lgdVh9aw>
X-ME-Received: <xmr:8MF-ZMruQy80rmfrKUnw2tZ8LPX8cF8ULOTu5Z7cKG8c3w5bX2gqCuglsd4Oq8ls5LmIv3JXAJXWTyxNboZrmZNs7EQwNQ5OnIyOtXHlXGE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedttddgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:8MF-ZCmUkbugoLjhY_gOsVZwX1RQI6S6DsSDqj_Mwcwcw_jtMropUg>
    <xmx:8MF-ZM2vKAhOaU41_pDp8YI3k98SnYVCc0DIq4QUKakJ-zdILed3YA>
    <xmx:8MF-ZJukJ19FIzjbyrkgByEqw048zpzqKPi7MuJY9wQxxV5AkdulPA>
    <xmx:8cF-ZJziZ9jab7Nitsb5N7-k1zH_NhYbrFtdUpK7ETbebG8lhWvbCg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jun 2023 01:19:43 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id e761944c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 6 Jun 2023 05:18:40 +0000 (UTC)
Date:   Tue, 6 Jun 2023 07:19:41 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/5] cat-file: simplify reading from standard input
Message-ID: <e7cba8dc4cebde0841ac04702155890d87e74492.1686028409.git.ps@pks.im>
References: <cover.1685710884.git.ps@pks.im>
 <cover.1686028409.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0acIJQnfG4ju0ARq"
Content-Disposition: inline
In-Reply-To: <cover.1686028409.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--0acIJQnfG4ju0ARq
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
2.41.0


--0acIJQnfG4ju0ARq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmR+wewACgkQVbJhu7ck
PpSs8xAAmu70HKCqoU/rcy/ndBUpaD7dTRrHBcsZNNPagaCvYIbJbsnusQYzutvS
2QnYu7ZMU6cdcvWIZgxgkS8JMw8l73rWzrc4cEIZ6UWKdRtEJIbnxgyMBhJcPLF1
u/TTk8Clfjq6N0+2T4eJ7uLiGfEX+TUt1lZfO4bW4ZFBGB1jCgMlssuzr1WXqwGM
iMWR8WzC6LUvsSE/TnFBBrXf5Ey7MgLPRnxEK0iGJa5ubWuaUq9qARoRsexqclFw
9iflEBMZjnJeyfk3vn3l+/BJrMPG/z6B+eI/4KjOrPIVg35dmGFmOW8zgwDDGp7T
wZUqWv1zcV8ko18IzFW0LwBgcnLw4d+ggj1sZ9B9Z3iOSByX4Zi92sz3KOwgKU9/
zt0mHubLr+SntFsINE5ohUKUlAoKER5GYSijVS9XG5kF8jd2NZWZsComhrGsr0oE
/D6bpsqsBq6V/+yn+A5SiLfmZkkV7ZDtBOMRrZjdKwW8FPJeLXRyO30ahbyvoKSp
5osPN1znynSX29odl/Ej2j5qYdbBGB/qrW65FDGjy2Oo1b/Lr6MNJdGwQIDYMRQo
bM5SbzbSmNSwU/9oD/tLkxiUlIi1yHUaAjvo3gjX9SweZE0f42uoYxrB3wsgHAx6
KJeBLg2w8Bs2pQhF2hVp6n7w4uwzDf7K1rHuddEhGWZnq+UNroA=
=PzO6
-----END PGP SIGNATURE-----

--0acIJQnfG4ju0ARq--
