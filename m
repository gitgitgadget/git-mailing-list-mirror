Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A7BC77B78
	for <git@archiver.kernel.org>; Wed,  3 May 2023 11:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjECLf2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 07:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjECLfI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 07:35:08 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5E549EC
        for <git@vger.kernel.org>; Wed,  3 May 2023 04:34:46 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 6CFC95C0151;
        Wed,  3 May 2023 07:34:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 03 May 2023 07:34:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683113683; x=1683200083; bh=Ag
        g80R7HLeQBkxGPOjnuE6+FjRZfmWkjyCEnwDmkCN0=; b=VAMZ/g5xSCBPdFCPnH
        RRK0LnnulbpvHOF9Bm2Az634dusudfSOG7YlXssYeMhVogyEzpKCfuZV4Tu7KkTG
        LBZ+LUFEzxWv5/a31Qh+nE3sI4ckIJNriVlhphKvXjNlhkIBUgjdbKSjstuniBB0
        g9C86tjm1br/RwtCOsm/LWErSSTWBt/icbxUD8elmV1Gmodgsb+glIQd3t6ydOAJ
        gszhMJEdrDtAk68TlaFIiF32vA9hyNNp/ugpScyHYVLfR9do4MVAgbKVS421pYdW
        OVmMICGAhU55LpUqfU01M2pemzK/NGWa/+56bR23InvtkDBYsUWyHlKYH5GLKe1i
        QVIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683113683; x=1683200083; bh=Agg80R7HLeQBk
        xGPOjnuE6+FjRZfmWkjyCEnwDmkCN0=; b=F8V2lsX4hgkxC+4+EFJpCv8CPZDOG
        fRWXgNm01rIjowwwlb9mA6LHc4HqGdpHH2xZ//t5l5Yb77YguLikTe9ojveTgI2T
        cezzlkKrEwOH91h4J/3H8YkgmJYc3HunWCLC8AmYrlQ0/iF/IgAaleE5jxw5bh0n
        Ndf8oqOJ6Dtm3xgfrY7Nur6f2WwXdxlYIgXxKfNsXqmi4GHFajWw9wFmhGaHr8Sb
        mwdKC5ibC5ntcNKMCHGx5OfSderUXQq6d85+OzZmbFGkIzEx0kWFvSWXC4l8ao3i
        bt1TB2NVePcIH17k139Ew9kiQmWobXrqGUTeADDewzCz2bhJ/s0HBD1Lw==
X-ME-Sender: <xms:00ZSZB9PRHvwoi7HWmCVKgqX7Yil52uDm4zeuaY_ZRzEYqLli90Ljw>
    <xme:00ZSZFumtfVNUV-cXF_oo1oksuQEX6jTSNewhu3EDYqoubhC088xiTXjr7J5OAUdJ
    K16CApdOBQpTfo5UQ>
X-ME-Received: <xmr:00ZSZPDuEQ-O3ANNj7Q1Jokpm675g1X4YfRbAL1YdmvCZ9ikr-x511C9OQFFbPedtzi4bL-L2r4AzXBU4jVlWpP8R1DI3fIiB54ICMzfa6bv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvkedggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:00ZSZFfIcTEbTD7GW9_9v_IQpHclP1tlkDD4EwZ7M7bqCV_gjGFcfw>
    <xmx:00ZSZGM76KV_ubZ72ny-jsteDLvVeFJTIqHN0P-Ih9EWi799E_bzsA>
    <xmx:00ZSZHnXZmOgWp9CD4KBG0_fxr3LGT8xac70gomvf69R6O46Gx9S2A>
    <xmx:00ZSZDorFBFm7HF9eNuaKyWhWHuH_IG0cZhHOdOo_5cDTVggHLXIWg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 May 2023 07:34:41 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 8c588f1e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 3 May 2023 11:34:01 +0000 (UTC)
Date:   Wed, 3 May 2023 13:34:40 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v3 6/8] fetch: move display format parsing into main function
Message-ID: <cd23440128ea3057c2f5110d230417abc59bdc3c.1683113177.git.ps@pks.im>
References: <cover.1681906948.git.ps@pks.im>
 <cover.1683113177.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CAJhabAV6Ek2g4eZ"
Content-Disposition: inline
In-Reply-To: <cover.1683113177.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--CAJhabAV6Ek2g4eZ
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
index 9e7e45344d..e15d43dc1e 100644
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
@@ -2078,7 +2069,8 @@ static inline void fetch_one_setup_partial(struct rem=
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
@@ -2145,7 +2137,7 @@ static int fetch_one(struct remote *remote, int argc,=
 const char **argv,
 	sigchain_push_common(unlock_pack_on_signal);
 	atexit(unlock_pack_atexit);
 	sigchain_push(SIGPIPE, SIG_IGN);
-	exit_code =3D do_fetch(gtransport, &rs);
+	exit_code =3D do_fetch(gtransport, &rs, display_format);
 	sigchain_pop(SIGPIPE);
 	refspec_clear(&rs);
 	transport_disconnect(gtransport);
@@ -2157,6 +2149,7 @@ int cmd_fetch(int argc, const char **argv, const char=
 *prefix)
 {
 	int i;
 	const char *bundle_uri;
+	enum display_format display_format =3D DISPLAY_FORMAT_UNKNOWN;
 	struct string_list list =3D STRING_LIST_INIT_DUP;
 	struct remote *remote =3D NULL;
 	int result =3D 0;
@@ -2183,6 +2176,19 @@ int cmd_fetch(int argc, const char **argv, const cha=
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
@@ -2311,7 +2317,8 @@ int cmd_fetch(int argc, const char **argv, const char=
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


--CAJhabAV6Ek2g4eZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRSRs8ACgkQVbJhu7ck
PpQQXQ//W2K+dp1p2BCh1R1rZpVJdTw+wROu+lP/Sv6B9mo2jqrg6MZPTQBocnYw
XdBoCK5PWhmauqxUyLFisY/GlGXn4svMxYno8CwlgVmOHccG1Lo6Fi7F9WmJsJXj
N+y0NEYnrKYdeoBUTryaxMGnCtQdVj7cgqDNHRSinGWildmstIDspGMInDxh0l2h
rx7GaK1LI7+RogIS7YIMw8noPuP1s9ntEbz4Xpk1PSBtT/sL1Yhj1N3MZI+HaskS
SgmBaW8QWssOCVg85EGsyiWL0RBeVK/ZqHOzHMo/zuPcBcMY6XybugbLjXXBAJYm
wr7XAyGQDbWySrqn2skXwvvLEK0Tmssf16iBe0zF0iMP4U86uPzymiNBiFgJdLON
IoWtEp2CqQ6kqXGRol6Li9um0i95ox71bRYafeOqkSUWFaa+M/T0rdyDkeCFH8HX
bu36hWERMD4bCV7b6rjlkg2lAd7sQUs3WVMdQBbszU4B+JCuFc5TYDm02hjUSr96
Kor6BBYCL+lbjmrUgqLTK7iw5nq85SqzFSJnpZWfmF6nz1nAi/deTuVrtCfW/4Vc
apmonRVD4vWhonc48GMvXsU4fFVxHCVn8F5Y6WYoP0GlNHK0NZHMtSlyMcfvilzS
sq/Ps5tNCvx6HAqK7yDeUTsUEjovgbWD0pr+ajuLEAZLMGyEFMI=
=dt8r
-----END PGP SIGNATURE-----

--CAJhabAV6Ek2g4eZ--
