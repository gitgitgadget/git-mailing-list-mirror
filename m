Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06ACC6FD18
	for <git@archiver.kernel.org>; Wed, 19 Apr 2023 12:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbjDSMcf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Apr 2023 08:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbjDSMcM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2023 08:32:12 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C7116F82
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 05:31:48 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id B317A320092D;
        Wed, 19 Apr 2023 08:31:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 19 Apr 2023 08:31:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681907506; x=1681993906; bh=PS
        n/Dyz8LJGa/2dDrbydOPuEBURUbhdA0f7gLLW+/gI=; b=Xb5tvIRSXgUMulmpwO
        Wjc73Yc8WL3ebeHTjC5Za3uses2o4ATar+XQt/2J4M9XrPSNZqXMsEfgNuZ3eslK
        aXov8yc4z79nxcp+pHu1Z9SN8H/DjBw1O1V/ZPtmINEiK7CT3N9B3uDtg96S3nOn
        GpCyWPZLso7biiC1zJmI8UC6Fi86HJnjXGeIffW03U1kIGoQoVzjTV7XHnnNZ7yB
        3XajIoHKAKRkn+zMsZNiAi88mKZKxt4mCdXeRCNgW9pzx3C0sd0KEk06lBD3+0yF
        UwO0UUvR+aF+rnVEObjEk0RKJqbm+j5cZSwg/09N+Ko5AleyjYONYimovCoHnDbN
        EVlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681907506; x=1681993906; bh=PSn/Dyz8LJGa/
        2dDrbydOPuEBURUbhdA0f7gLLW+/gI=; b=foh9khLiAHrAP7z8fpEA8oAhbKMM7
        NKYtDgzBuwbDYj+nGK45R8o6SJoElr4eRM14PzgkJg+fKETNxdLZyq+AJ01qlg4/
        Ngo1S5lr6f/1ibl7mXywROkp3gXbGNxxfxG5Q3XTiOzX9AafvDIwDMc33n/ypXq7
        hliVfjZzODWMbMPU8kaxncCu/5PU5FlfQpgixF3MM4HJL/Xog7VEcjWdGvruhec4
        Qoxlv5NlZYbmc9eKzm1twD/jlwEp8sXFye08HNV9t5WcY5GP3Dah59lUNPV+rKFf
        KvROTc2fPtS34Sv1Q66OLLIikPygpWyQpuTXTJ9Hnq5jd60dHDy5UOQvQ==
X-ME-Sender: <xms:Mt8_ZCBiyu-xKZtr-I7N_YvClFsEzNBTmU1ugMU6H9mAbAAoN3IJ-w>
    <xme:Mt8_ZMijymqUCLgVhEnOHiaQT2lC3feKrpddsObaQFojwU_6lb_fVVsmLHuEFm_c1
    DJG5JGmHm-PRpK_jQ>
X-ME-Received: <xmr:Mt8_ZFnELetOMIZ-vy5xR9VgeMlzaHVSyMSVnzMksUEJajDoM6lxVqGGYoRLHoAIUV88WMjuWP6gTYK1CIxz3A2S5wIfrR-NG9F5k_eBycu43A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedttddgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:Mt8_ZAz807VHx9WuY2C2EzM1QcuGuZKw7_LeCLg3SezIPqIti2ZZuw>
    <xmx:Mt8_ZHTdCN9r7Bm-JGuJS2gG14HT6_2Ik0fFdwR0B2fVdUTDOtHZdw>
    <xmx:Mt8_ZLYeky3wuQvU0IiJDsac4tKsGEYuHrla70Vh1E1Y7t33s0VyNA>
    <xmx:Mt8_ZI6zA47KJf0-ADFddt9yoRYk-SBCZw84OvxkjylVDwcCTPaocw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Apr 2023 08:31:45 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 047232c7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 19 Apr 2023 12:31:32 +0000 (UTC)
Date:   Wed, 19 Apr 2023 14:31:43 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 5/8] fetch: move display format parsing into main function
Message-ID: <d98c3ee0ceac73a62f279dec645e1f4c0b170b68.1681906948.git.ps@pks.im>
References: <cover.1681906948.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nivUDRkz4HaWyrIc"
Content-Disposition: inline
In-Reply-To: <cover.1681906948.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--nivUDRkz4HaWyrIc
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
2.40.0


--nivUDRkz4HaWyrIc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQ/3y4ACgkQVbJhu7ck
PpSueQ//S5wkvwS58HJnAqw4gLyZl5eaoc7WC5JhH1pDSJeEtrII9T5HsYOBCfD3
1kfb4x7kbH+k7kvvJRAVX/RDFWceaI2rC6+Gfd4Fzd9V6EdzcYY7uswR7WlA2fXd
j3Rl01sidi1wjuzW2SkiLtUWEZJikwAPyDlwcT1+hjOk0uZA8ma13g3me2nCDQ5c
hJDsrW1EVyDmu0+wYAj1ZQndIJGoOC04eMpjcP8ZyTyaC65RbSId4Ihg8rcjCkcp
Z7cp0RRk96Uo+1dM2BJR4vVel8zM/D6RpV2Clhx1lYpTbw1zQhMfc6VaudVCWMao
CfGNf99PiyMlwfanz0WLHyj0fMo61KAGDx5U6UDGpJklmQw/4Gda9rUx0AX5W3SJ
Y1e0l5zxX5Rplh2B6Njbu93q1kP1MqC+2287TSQHO6/UtVUNSuLLHB5kGprBVczJ
EHA7T2U/yfJwBr2WSnPErHfX+VxCBn6LP7gN3MPBUbvUxjY43slYgHE9HLqHHGQV
hc8aLWLinlAuUUrGTWtf0cOeWvwHKEk1ktm44tdw0EgG+4Szw04RlhxHvDNCdpYL
OUPXInfdcJTdCpDxy6kE4IMpTog6w5bORr7vf7ld1zkkgeJO3YxSxnZMCFvR4WH3
6BL8km7+eUoGzoJQL6UwNab+K3GQORdLdrLcBeiyT8lZwQhY99g=
=wx8m
-----END PGP SIGNATURE-----

--nivUDRkz4HaWyrIc--
