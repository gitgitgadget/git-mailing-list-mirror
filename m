Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6ACC77B7C
	for <git@archiver.kernel.org>; Tue,  9 May 2023 13:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235357AbjEINCv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 09:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235280AbjEINCa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 09:02:30 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE69D49D9
        for <git@vger.kernel.org>; Tue,  9 May 2023 06:02:28 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 289B65C00D2;
        Tue,  9 May 2023 09:02:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 09 May 2023 09:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683637348; x=1683723748; bh=hb
        wdr44lRbpriueAn1dZdH94v9LgwIQHxkgabHU/LSM=; b=Wk9iM+ltiKpsJ9fOhp
        7haqhEjxAG/pd0j6mnGHvnxHA5/RHpksDr/dqt1duYO049zRnipGhXaD7rbxglkj
        NRfq1x7DBQ6HjaqWiB46cH3nR9hSskxfpedtbCO7X991nOh0kQ/744Sm/eXFS7wb
        1KJjKhmx1OVgIWwWgCyJyE3rUCQGRA7A78pT8WLxvg+tT61pJ4VC4tgY/18oDjoS
        F1rTBEPuJw7K6PYFVlksjonoLSoyF40B1/D+MfN8gXWmJ1He2/Fm04F7IXRdNHH3
        6U9XjOsaO2LhIRNdSD8tv25r9ydj+XyqKhGiO8Q6Or19Wiiri12LaiX4kLD5Gy0r
        osPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683637348; x=1683723748; bh=hbwdr44lRbpri
        ueAn1dZdH94v9LgwIQHxkgabHU/LSM=; b=KpGKy+OAt5uakUFGEphHmGrG7yAdJ
        U3pKzgNE/7GNNzLOKHSvDB154roYqS86HY9g/4KNwclatcvrh4EHBVg6veTwk0Wt
        EZH0900pbVox+UxCqqQfsXHKKrLWvxiNUAyAUWP07ZoavswFo8gE5C/tdRkKqlCi
        zw19Tsh9McQAg+W9/G6vJVM83fpb39oFyAnlvxdfv2tFLMMyFhNZmnkQ9zXdhyUC
        IDey1DrlK66X01M4W/HRHw0ovsKm+AHE1jrvE0hqaSgSIcNpU6bkfNlU5/8pZ9vw
        efRIqNYqjeqLuJs6no57EWgrHz3AsqEkJWm3HMeh6YUxcw+JCHy1a79Pw==
X-ME-Sender: <xms:Y0RaZCywy3HtSnVTv_Tp0AZTjHgoDHt1HcwQMbbSz5vKjlRJzTlkVQ>
    <xme:Y0RaZOSmh0xnVTzw3WMSZxXWCFapBECa31EH6RSZDYKjIHOaS5Ysw1Ouk6NXjEEma
    COt5Y5oT360TzmB7w>
X-ME-Received: <xmr:Y0RaZEU_Q_9Q3903qCHEg16uZra3j0Nnv9cxJG416VWWSvwDjmVqFijZWwmAkYP9bCibtWYGsTQxQCimjLyGX4n--NPpG90Gxa9ZfmAzn40>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegtddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:Y0RaZIha-YglabewH55X4qhg1A9gaWEfqPuCn71e-5if2Ur-SmMWsw>
    <xmx:Y0RaZECAJfu-_1fGBrOpeOUYAs5NyDme9d_iqkcrYJNRCy-pI6RjaQ>
    <xmx:Y0RaZJK3F9yy63EXogZYdNSgRcXnDegO_hO1rUIL7Wx4gsERRpOW_A>
    <xmx:ZERaZH-bYUZNXyYyqqwOrzIQYgoH7jzPejtDu87QyajqlcmPrYojDA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 May 2023 09:02:26 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 8a41d0de (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 9 May 2023 13:02:18 +0000 (UTC)
Date:   Tue, 9 May 2023 15:02:24 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v4 6/8] fetch: move display format parsing into main function
Message-ID: <826b8b7bc0d7d6a76f6fd19d8f4a8460af61e9cf.1683636885.git.ps@pks.im>
References: <cover.1681906948.git.ps@pks.im>
 <cover.1683636885.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gXuAMadW0Jlk1ONy"
Content-Disposition: inline
In-Reply-To: <cover.1683636885.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--gXuAMadW0Jlk1ONy
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


--gXuAMadW0Jlk1ONy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRaRF8ACgkQVbJhu7ck
PpRunQ/7BZsSLZmXgVGSInywU54v201AiZjjajc7/NVFQaR87Jvdil4n9ieZ6s2O
kcUr06YQDff3+edfllMLcZ8S0CdQ6fTXlnnNXBSGCEKDiqXZbU0kCybzHMAxWJi9
2Gm1hhISCGEpuvyYoYd5eyPczJiUMXnvZjrgz6zZmn0bbPx0OvHy9586v5x3fp3d
XgIVNSl7YUxzUEbgIOy8Oe9lcXriQ9H68ZAHXPMMj6zYsn078vlqdHx/iAKVjOCT
kITEFG1krXpZzamfxk9zFxgOgsWY+8ZM61PIH9tp3rNS27dwBAvOL/97OirBWbkO
wjxdqZpXVmIddyXCb/XMGQXs07uUIBEhGnwWvMO+h4ojjGnI6b1F8qURee8eXvw2
Rit3vDd122SCqTwKV/F58bhfEscaU7HK2iXELbbGz5duiuzy0C+8fFgWvspHFZPk
CLkMi8XWkM8fk4dJNdGdqYEdGVUkIWDGPlGd2lOeHH30RvDpKuCXlXOw4X+r3zwD
4eYg0JVZF2XkMUxHTWF9/gEq+wdRsQhzKgq66RObpk7/j7qq1LXTd6nW6FHYAQIj
yqS0j2EP9VtIZLkQPu8UYMGu51QMVNGph4BNhsN9fKk4pX0phTiEV1DBgRn02Vdd
mt0YwvjyObK8fNPuUltJt0XVjKT+yl1C15jZ8I38ND9BMqWPuAw=
=iDVu
-----END PGP SIGNATURE-----

--gXuAMadW0Jlk1ONy--
