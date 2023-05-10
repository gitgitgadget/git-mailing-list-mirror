Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184E2C7EE23
	for <git@archiver.kernel.org>; Wed, 10 May 2023 12:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237042AbjEJMes (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 08:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237068AbjEJMek (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 08:34:40 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172FF83F1
        for <git@vger.kernel.org>; Wed, 10 May 2023 05:34:33 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 34C973200915;
        Wed, 10 May 2023 08:34:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 10 May 2023 08:34:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683722071; x=1683808471; bh=Lq
        vKaXXSjS+TBnj8gSPxfC+VLjGy811a+k9Lf2eHT7Y=; b=kMM5qVRu7pWQpUYjZW
        5cF/Dzip0thX4qTOUvbNjhKY04mp9oOsmiqhFr4+xeww88hO7UQ7u2xaFnbdu0f7
        yxflVsnMKMZtbwd6jkmvSoa9KmYiU80jX7PF73POMTMGR0UFXjssGbRDhb4cwbZZ
        EWduxl7zDKJeI6ZV525fBks9GtTrUL6WIQRmvC/9jXX5BcU5+Vv2+D0ibOIyf2ND
        WftmB86+jsCLTEP7Y2N281QwKRo/sh4IbGrj/eIA6D8xgyu+SJlRZWHU2KsMFmAZ
        JypiPtjrd+8nos/DOpU3ydzqPOWsBu24Qqpgn2cr/NvFTQSlYmQIIHuQP37jWtVS
        Gh7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683722071; x=1683808471; bh=LqvKaXXSjS+TB
        nj8gSPxfC+VLjGy811a+k9Lf2eHT7Y=; b=ZeDtmxhpa/MPW29fxQ0sWXlvrdw5+
        VngQ54DhyUmfCC04FeWRITFXFMUsjRa4cm1DCiXrJ77tPovjF+QPle1iAI46RXeb
        uZJ6KhOFPSNkvY98neOdezCjvmOXx08cwVrFZnLCKtsLdce5W28ZiJAd+tnJ9QC1
        pKtDmqC7wlOMCtXgr/tWieA0LS13OAECTOHUIDDgjrtupnbSIlThV5UKUoOqm5V5
        bzwYMxy7yM7o4MImUNekZaKre6VFow86D/2GylN9n2uqHCfX++Cq2cw3f3WaOhGj
        RWUHeNZNXyAruMKLm3RU5V6dUoAqw4Fdxxq9Nex6Xy0GTVgQZwXGAA/7Q==
X-ME-Sender: <xms:V49bZDeCd2gSCzvhP5Bn5s9jPdCyprcsLMxlCA4JYoQSiben-Yedpg>
    <xme:V49bZJP3id58wCXeBB8Oew1RIr7PAxsiIjKb573ZTazSrGdLnL-5oi9PPsDDIjsh3
    X0THqlPaciSffujvA>
X-ME-Received: <xmr:V49bZMjTEGJGp3pLKCih6UHeHAIrNyHmCt5uer2lTOG13a0fa6YV4zOMzNVHVQiGI9g8SJWXoytXU0M19uHk1p_n8ozHY6J-d3G3GucHKvMx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegiedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:V49bZE9Is9BJFCRcHJUUc2J_HORoGYD03Jpn5O5HhOq9hYm1QhpoVA>
    <xmx:V49bZPuHZFaKrRoL6kkY7ASkeMzNChh_-1-uUdxUR7AbnGP44a5edw>
    <xmx:V49bZDEERKG7Y5x8nrSZRbcrQA6JZzOGu71H-8guFgMjez8gCn3yfw>
    <xmx:V49bZJJ4DV2zHZoAMECc09KV7STkmZWU_uOj79345Vwj8g2pkMDqnw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 May 2023 08:34:30 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 6686fe17 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 10 May 2023 12:34:20 +0000 (UTC)
Date:   Wed, 10 May 2023 14:34:28 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v5 7/9] fetch: lift up parsing of "fetch.output" config
 variable
Message-ID: <0c3dbcd09fb5e064601dc3fd9ac650cb496371e5.1683721293.git.ps@pks.im>
References: <cover.1681906948.git.ps@pks.im>
 <cover.1683721293.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="H2oCXpanvfgki/6b"
Content-Disposition: inline
In-Reply-To: <cover.1683721293.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--H2oCXpanvfgki/6b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Parsing the display format happens inside of `display_state_init()`. As
we only need to check for a simple config entry, this is a natural
location to put this code as it means that display-state logic is neatly
contained in a single location.

We're about to introduce a new "porcelain" output format though that is
intended to be parseable by machines, for example inside of a script.
This format can be enabled by passing the `--porcelain` switch to
git-fetch(1). As a consequence, we'll have to add a second callsite that
influences the output format, which will become awkward to handle.

Refactor the code such that callers are expected to pass the display
format that is to be used into `display_state_init()`. This allows us to
lift up the code into the main function, where we can then hook it into
command line options parser in a follow-up commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c | 50 +++++++++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 4c58ee503a..439d3c667b 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -104,8 +104,14 @@ static int fetch_write_commit_graph =3D -1;
 static int stdin_refspecs =3D 0;
 static int negotiate_only;
=20
+struct fetch_config {
+	enum display_format display_format;
+};
+
 static int git_fetch_config(const char *k, const char *v, void *cb)
 {
+	struct fetch_config *fetch_config =3D cb;
+
 	if (!strcmp(k, "fetch.prune")) {
 		fetch_prune_config =3D git_config_bool(k, v);
 		return 0;
@@ -144,6 +150,18 @@ static int git_fetch_config(const char *k, const char =
*v, void *cb)
 		return 0;
 	}
=20
+	if (!strcmp(k, "fetch.output")) {
+		if (!v)
+			return config_error_nonbool(k);
+		else if (!strcasecmp(v, "full"))
+			fetch_config->display_format =3D DISPLAY_FORMAT_FULL;
+		else if (!strcasecmp(v, "compact"))
+			fetch_config->display_format =3D DISPLAY_FORMAT_COMPACT;
+		else
+			die(_("invalid value for '%s': '%s'"),
+			    "fetch.output", v);
+	}
+
 	return git_default_config(k, v, cb);
 }
=20
@@ -800,14 +818,13 @@ static int refcol_width(const struct ref *ref_map, in=
t compact_format)
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
@@ -824,15 +841,6 @@ static void display_state_init(struct display_state *d=
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
 	case DISPLAY_FORMAT_COMPACT:
@@ -1605,7 +1613,8 @@ static int backfill_tags(struct display_state *displa=
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
@@ -1691,7 +1700,7 @@ static int do_fetch(struct transport *transport,
 	if (retcode)
 		goto cleanup;
=20
-	display_state_init(&display_state, ref_map, transport->url);
+	display_state_init(&display_state, ref_map, transport->url, display_forma=
t);
=20
 	if (atomic_fetch) {
 		transaction =3D ref_transaction_begin(&err);
@@ -2069,7 +2078,8 @@ static inline void fetch_one_setup_partial(struct rem=
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
@@ -2136,7 +2146,7 @@ static int fetch_one(struct remote *remote, int argc,=
 const char **argv,
 	sigchain_push_common(unlock_pack_on_signal);
 	atexit(unlock_pack_atexit);
 	sigchain_push(SIGPIPE, SIG_IGN);
-	exit_code =3D do_fetch(gtransport, &rs);
+	exit_code =3D do_fetch(gtransport, &rs, display_format);
 	sigchain_pop(SIGPIPE);
 	refspec_clear(&rs);
 	transport_disconnect(gtransport);
@@ -2146,6 +2156,9 @@ static int fetch_one(struct remote *remote, int argc,=
 const char **argv,
=20
 int cmd_fetch(int argc, const char **argv, const char *prefix)
 {
+	struct fetch_config config =3D {
+		.display_format =3D DISPLAY_FORMAT_FULL,
+	};
 	int i;
 	const char *bundle_uri;
 	struct string_list list =3D STRING_LIST_INIT_DUP;
@@ -2165,7 +2178,7 @@ int cmd_fetch(int argc, const char **argv, const char=
 *prefix)
 		free(anon);
 	}
=20
-	git_config(git_fetch_config, NULL);
+	git_config(git_fetch_config, &config);
 	if (the_repository->gitdir) {
 		prepare_repo_settings(the_repository);
 		the_repository->settings.command_requires_full_index =3D 0;
@@ -2302,7 +2315,8 @@ int cmd_fetch(int argc, const char **argv, const char=
 *prefix)
 	} else if (remote) {
 		if (filter_options.choice || has_promisor_remote())
 			fetch_one_setup_partial(remote);
-		result =3D fetch_one(remote, argc, argv, prune_tags_ok, stdin_refspecs);
+		result =3D fetch_one(remote, argc, argv, prune_tags_ok, stdin_refspecs,
+				   config.display_format);
 	} else {
 		int max_children =3D max_jobs;
=20
--=20
2.40.1


--H2oCXpanvfgki/6b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRbj1MACgkQVbJhu7ck
PpRb1Q/9HTnJkfF1FJlab5nU3znNm3iW1crApGcYf5dSWK98Ovn7whcXmwSzQcod
99S3pTu/piliJfDJqcDx7GDMD8GtWPwaSaAJ0f8ym1FlW2K95lFf4APcyJlnmx2O
/C+XLXvteeViPHxpVFjl9wUzC0YQGBSTgOWCoYV2L3+TnZeyXujEzPnfNPug6pXG
aKV+XgkcTPLWUF9M9gwuq/SzNDhBTqKKBcr6lwxXNYKmPJD52zGLPHan/m8MZV7C
nlsLN3Wvjv1kZcgEMHAyRcFJODy6yYf5cRSgpTLimLmjEhZbqC+iomOOIrBwISmO
CWJVifKsFD4wmPkLV33PvkJwKsSqBZAwp52IzMo1qHTmmXk8gImBL4ApVUPod3Oa
Z3uLBO0vLyGuSvtxLHYFp/HFiqGKIuHOxrjvEsAl9BZxSAQaC/AMrWeDxTf9I2HF
yxv36bV2NENVXGc27qtIswvZrqlzM5Icp7xH0PgV7Tzg+cb2G7Gq6oB3Lspb5ICz
r2oKD3cyQQIvqVKs5RuGECpZ3EPWad4bkMpTvKfQ+SW8hog/QzRwLiOHwFoAQkZW
LK39gvbooVmS0BdCbBaq8ck4xl/nKJLfkOtNzZKUIgnXWsi1xTSqwKfdeP040Xwk
w2xZQ8UjGz46UXYR1AFO6XjnwPAukuR5vYq/n3WLzPc5A0W8JW0=
=kn3S
-----END PGP SIGNATURE-----

--H2oCXpanvfgki/6b--
