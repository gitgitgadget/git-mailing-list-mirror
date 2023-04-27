Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6ABCC77B73
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 11:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243671AbjD0LNj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 07:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243678AbjD0LNb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 07:13:31 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E7F55BF
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 04:13:29 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 114FD5C0233;
        Thu, 27 Apr 2023 07:13:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 27 Apr 2023 07:13:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1682594009; x=1682680409; bh=k1
        Irg+K2Ks7P6+3Wg70FgcscNVTm1zQzldeRekZGlfw=; b=Avll/nX3cLabU7x461
        huFK8mzovhgcWKfRVh3krT6tu4m4N1OpKftyPa+3rRK3DUOjOX2SObJt8iu5shVD
        szSBrhFEIBjW0IcnrN3iJC2hGhDMkF3hEgAzvHSTb0slitYgXqdltn/cZnM8Wy8I
        6iK0xkji+xrO5rssP0nElV13nKG3CypMBUm4zgNHNIkpluEqShl4nGUOjwyBhC9O
        /gszVF3lJGMu6cQ368cVkQufb+mq2kqkRGW/EfD9YUQlBl+emCj9Vt85ikZB3feN
        doF+UYGJtYiXXyWegVAxJ0oygMBiMzUnyh2OigR+3mhkLNUxVOc/qBoGhaJlUDsR
        doYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682594009; x=1682680409; bh=k1Irg+K2Ks7P6
        +3Wg70FgcscNVTm1zQzldeRekZGlfw=; b=SUC8/14DnHw3s2rEUcGfA3FjTd8bC
        kdrlyXaWOsOfSD+O4aQdli8y2+Gc3XOvCL4o+aHBKbAy5ZBCmVPhhgQ7OejobfFM
        alG2XS4777q3lVcLCQYnxE1RquxYW703TA5erYBelGmNtSyZxVpZTlj49WqZ2eAg
        hQDKrCMR/oPC+yZcmj5flekTxqruxZ0b/3rBR9cggEdeSUxj3BCo71N+5OChKWGl
        LUoUlwzU0UHIJdIpRxqzmC1Ws4NNrX/E6sAY2ZWaccYSJdUHRVx/WpJgt0399OYH
        gUnmcjV8gxwNJ6iWs4RURkve1BfSJsZKVyB4Y3bkLcSxF7xCEMDtqVWUw==
X-ME-Sender: <xms:2FhKZADT0uMC4zEVw48IzyCxy7Q9PT26v7ePibPtZQBNWuHg9tMAmw>
    <xme:2FhKZCjzSzbALw1hDdJu8E-6kuiuAJUs64-LgyNcuknc2r0XLamyKP7bWgUqtFUVS
    -6aUDF3aTbsgfPdDA>
X-ME-Received: <xmr:2FhKZDnQDCtHzOrtO3GoCBafN9JPS917smPL6XFhWbnQL0AsA3HeoA-HF2cooTNXiWWjl6isPthBe5KMb5PXDaThkbp3ng2c1WlPS_6HtVLe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeduiedgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:2FhKZGxK935-mYmw1VC9v7GpD6a80GDnvKeBu3_PMN4locA_BnCRbQ>
    <xmx:2FhKZFR8-7s8pNGGsCmOoEWs6fV_33v21zH3pnoH-uMJnAobERATgA>
    <xmx:2FhKZBYEHvI8ZW8T_PK6ILaWxxoKQi6L55YHcX3o_D9hHUneDr4dgw>
    <xmx:2VhKZDOaHIMFpHhRbI9rEFm-EnCJM0S8G9SBUVk6RuqzsBjjfv2iDA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Apr 2023 07:13:27 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id c535e891 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 27 Apr 2023 11:12:58 +0000 (UTC)
Date:   Thu, 27 Apr 2023 13:13:25 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v2 5/8] fetch: move display format parsing into main function
Message-ID: <4990d35998ea5b6a16acce106edfaf3c68e4a01e.1682593865.git.ps@pks.im>
References: <cover.1681906948.git.ps@pks.im>
 <cover.1682593865.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jniHzfyhWB5zJdpw"
Content-Disposition: inline
In-Reply-To: <cover.1682593865.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--jniHzfyhWB5zJdpw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Parsing the display format happens inside of `display_state_init()`. As
we only need to check for a simple config entry, this is a natural
location to put this code as it means that display-state logic is neatly
contained in a single location.

We're about to introduce a output format though that is intended to be
parseable by machines, for example inside of a script. In that case it
becomes a bit awkward of an interface if you have to call git-fetch(1)
with the `fetch.output` config key set. We're thus going to introduce a
new `--output-format` switch for git-fetch(1) so that the output format
can be configured more directly.

This means we'll have to hook parsing of the display format into the
command line options parser. Having the code to determine the actual
output format scattered across two different sites is hard to reason
about though.

Refactor the code such that callers are expected to pass the display
format that is to be used into `display_state_init()`. This allows us to
lift up the code into the main function, where we can then hook it into
command line options parser in a follow-up commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index e03fcd1b2f..bcc156a9ce 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -788,14 +788,13 @@ static int refcol_width(const struct ref *ref, int co=
mpact_format)
 }
=20
 static void display_state_init(struct display_state *display_state, struct=
 ref *ref_map,
-			       const char *raw_url)
+			       const char *raw_url, enum display_format format)
 {
-	const char *format =3D "full";
 	int i;
=20
 	memset(display_state, 0, sizeof(*display_state));
-
 	strbuf_init(&display_state->buf, 0);
+	display_state->format =3D format;
=20
 	if (raw_url)
 		display_state->url =3D transport_anonymize_url(raw_url);
@@ -812,15 +811,6 @@ static void display_state_init(struct display_state *d=
isplay_state, struct ref *
 	if (verbosity < 0)
 		return;
=20
-	git_config_get_string_tmp("fetch.output", &format);
-	if (!strcasecmp(format, "full"))
-		display_state->format =3D DISPLAY_FORMAT_FULL;
-	else if (!strcasecmp(format, "compact"))
-		display_state->format =3D DISPLAY_FORMAT_COMPACT;
-	else
-		die(_("invalid value for '%s': '%s'"),
-		    "fetch.output", format);
-
 	switch (display_state->format) {
 	case DISPLAY_FORMAT_FULL:
 	case DISPLAY_FORMAT_COMPACT: {
@@ -1614,7 +1604,8 @@ static int backfill_tags(struct display_state *displa=
y_state,
 }
=20
 static int do_fetch(struct transport *transport,
-		    struct refspec *rs)
+		    struct refspec *rs,
+		    enum display_format display_format)
 {
 	struct ref_transaction *transaction =3D NULL;
 	struct ref *ref_map =3D NULL;
@@ -1700,7 +1691,7 @@ static int do_fetch(struct transport *transport,
 	if (retcode)
 		goto cleanup;
=20
-	display_state_init(&display_state, ref_map, transport->url);
+	display_state_init(&display_state, ref_map, transport->url, display_forma=
t);
=20
 	if (atomic_fetch) {
 		transaction =3D ref_transaction_begin(&err);
@@ -2076,7 +2067,8 @@ static inline void fetch_one_setup_partial(struct rem=
ote *remote)
 }
=20
 static int fetch_one(struct remote *remote, int argc, const char **argv,
-		     int prune_tags_ok, int use_stdin_refspecs)
+		     int prune_tags_ok, int use_stdin_refspecs,
+		     enum display_format display_format)
 {
 	struct refspec rs =3D REFSPEC_INIT_FETCH;
 	int i;
@@ -2143,7 +2135,7 @@ static int fetch_one(struct remote *remote, int argc,=
 const char **argv,
 	sigchain_push_common(unlock_pack_on_signal);
 	atexit(unlock_pack_atexit);
 	sigchain_push(SIGPIPE, SIG_IGN);
-	exit_code =3D do_fetch(gtransport, &rs);
+	exit_code =3D do_fetch(gtransport, &rs, display_format);
 	sigchain_pop(SIGPIPE);
 	refspec_clear(&rs);
 	transport_disconnect(gtransport);
@@ -2155,6 +2147,7 @@ int cmd_fetch(int argc, const char **argv, const char=
 *prefix)
 {
 	int i;
 	const char *bundle_uri;
+	enum display_format display_format =3D DISPLAY_FORMAT_UNKNOWN;
 	struct string_list list =3D STRING_LIST_INIT_DUP;
 	struct remote *remote =3D NULL;
 	int result =3D 0;
@@ -2181,6 +2174,19 @@ int cmd_fetch(int argc, const char **argv, const cha=
r *prefix)
 	argc =3D parse_options(argc, argv, prefix,
 			     builtin_fetch_options, builtin_fetch_usage, 0);
=20
+	if (display_format =3D=3D DISPLAY_FORMAT_UNKNOWN) {
+		const char *format =3D "full";
+
+		git_config_get_string_tmp("fetch.output", &format);
+		if (!strcasecmp(format, "full"))
+			display_format =3D DISPLAY_FORMAT_FULL;
+		else if (!strcasecmp(format, "compact"))
+			display_format =3D DISPLAY_FORMAT_COMPACT;
+		else
+			die(_("invalid value for '%s': '%s'"),
+			    "fetch.output", format);
+	}
+
 	if (recurse_submodules_cli !=3D RECURSE_SUBMODULES_DEFAULT)
 		recurse_submodules =3D recurse_submodules_cli;
=20
@@ -2309,7 +2315,8 @@ int cmd_fetch(int argc, const char **argv, const char=
 *prefix)
 	} else if (remote) {
 		if (filter_options.choice || has_promisor_remote())
 			fetch_one_setup_partial(remote);
-		result =3D fetch_one(remote, argc, argv, prune_tags_ok, stdin_refspecs);
+		result =3D fetch_one(remote, argc, argv, prune_tags_ok, stdin_refspecs,
+				   display_format);
 	} else {
 		int max_children =3D max_jobs;
=20
--=20
2.40.1


--jniHzfyhWB5zJdpw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRKWNQACgkQVbJhu7ck
PpQBLQ/9FJV0M8vb+t9zL86Z82DAzTKTmJV2N9t8wb4xSD6RcGtLVedjm9A8CUXw
vRfnu/OGxM/wUbVySvCPoCLUi9wl//MnaCAz6IbMg7zEnhZh92sw//7sJ9Raihjf
uycilOgFDBDEUV+gsnZ1lzKSb+Gu0hl9GssZnBca3ysBv2C/lyWYfvfXyuYEelqS
ZzpuqEcz1VO2v+jCB+xcQm53P2vI3uVs1bMRYPd1FghS1If1sfin1tX1KHE3gQkZ
ar/Xy77O03s2TMJSrRSrEdpGTi9LAMD9l0W3ae3r4qHI0NGNwdbVzOYLPzASR0Gx
U7Ov4Q+DdmuKkOWL5CggAgyvU+XmHxiHnymsW6UJMRNmUHKpqzBukys40LDA+QYv
L/MTJGWhF/80AOUT2GtDGeTFdu0fVAd2wJ+7etA44UJCki627rSYCpeQHoC1Ssoi
+eKVba+H0JJuZlbjkMiDJvXejxc2wIjl1XoOVCogcnMW8MI4LpZRIm8XcEVDp1zM
Fac5K/PQX/oAT3vzy3MupZr/AfBSc6T4pfXzOuI0owDcK4dUMykZ+FofGoY4tIU9
rSyl0dEiMoOC4wyATF/EiP73JKU8bSHdhgVEquwiXMuai8aia+vpfM2AYLd4225q
vFsOvj3aUv1+sju2CuYo6XlInNLlL0GAttizTGY5CLXbm9f/QDQ=
=DIOU
-----END PGP SIGNATURE-----

--jniHzfyhWB5zJdpw--
