Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13EFC77B75
	for <git@archiver.kernel.org>; Wed, 17 May 2023 11:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjEQLtR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 07:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjEQLtJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 07:49:09 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD5344AB
        for <git@vger.kernel.org>; Wed, 17 May 2023 04:49:08 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 78E6C320034E
        for <git@vger.kernel.org>; Wed, 17 May 2023 07:49:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 17 May 2023 07:49:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1684324147; x=1684410547; bh=Vs
        dbTYRdPXVbLietTon7fuQz8GWgaU/13o1fInKTTMk=; b=Wkv/omSpZw5D3I9m3N
        LXcDtOEd922a8SDUOFl2q1Gs/7PNuk+DrdpIuRXNNybbtHXuDZ7Pigp0A4fudkrR
        9+bQxJf3/r6YQCULfhvi2ScKzwnuCnLcHfKi4YjF+oz2Ed44hTGZa5++jBsehfJv
        nU1G+SEyD8nZbLHERKhiOPeF4K67e+DOnD8loo1Ijgr9iuooMtCsf5FdqNRckF6T
        JuJCB10O9510uwi7oFbQBuIrmwt/HNHM4GV5or8OuVR8WuMfS67TyQItBl4mlsKZ
        HWwlWOgVsmJdPI87wSvfN4+YRVceOkxtxsBzzBV1Q+DDiHVe2cjHvf6FOaMo9I/d
        +fmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684324147; x=1684410547; bh=VsdbTYRdPXVbL
        ietTon7fuQz8GWgaU/13o1fInKTTMk=; b=e95EC1aBfF4JSGjwQOz1pbwWMvZp+
        o5q92P8hMiAESZskt+SwcTq5Wu5Ht1CknRbHdoTmru5bXGjZfU/0FPmJ89cQ7J9x
        FV80X6KXCRMIbJH6az884HDoS/P4AO8LTJiw4gPRmCWhNjUB++j1mlBBQIa0XRKf
        wRfiOzFAY0OALc1Gd+Q7n5fUUBlF0jqm/fgIuCOLTdFn3ENBV1tHWjs/uT3q5xia
        lBdlwXoxwfj5SPTo0j1G2vtn8hi7gGTEkvlhfr7hwwVtGpNbinbcNy5YDDeu5qd9
        v/ftnInbXmEg/5Sfm+XW6T33qvL3maw7o9Hl9it3WKBiKk8Ec7Y89Yzuw==
X-ME-Sender: <xms:Mr9kZHNdguG1cqZ-qvppaqEZXDc5xRVgyS0tFJp5aRT0bVIgZJREJQ>
    <xme:Mr9kZB84cUzXzm2BCFLLyCIiI_vCzXjoxb5BAdFIVpGEaOEUVp3xCu_ud-kJHKVWb
    GRvluC1Rd4n4dXqng>
X-ME-Received: <xmr:Mr9kZGQXldrQSinVir40u-g04f5IGakOIJKZmhZQ7bjzFMrvEYLz5PJS6TS-PXkA9x4SGDGO462CLRWWEIQutwX5F-4G8e3SSwhCh9YwHO_88CT7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeiuddggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:Mr9kZLs5kpEA3afz0H9U6GPm2KbeszgVwQ8BjCmH-YfZwjoYreg8VA>
    <xmx:Mr9kZPdayPmK6xPF3PRBe3vExoZOfEmfFgowMbH_TW07I2fzDmx8kA>
    <xmx:Mr9kZH1Bo-owlmpGGbWfVYbyrEuZkL9piSJ2mU1afOn70RiIphpaow>
    <xmx:M79kZNqvsvlOjoaWIDUTF1L8O78cHPAcVo6M6kRKDpWfeNyMvv_iPw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 17 May 2023 07:49:06 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 801929af (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Wed, 17 May 2023 11:48:43 +0000 (UTC)
Date:   Wed, 17 May 2023 13:49:04 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 6/9] fetch: use `fetch_config` to store
 "fetch.showForcedUpdates" value
Message-ID: <5e842c1327efa73cac4f51160d70dd16ba09bfb3.1684324059.git.ps@pks.im>
References: <cover.1684324059.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bBN48D2+r4JlC8LH"
Content-Disposition: inline
In-Reply-To: <cover.1684324059.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--bBN48D2+r4JlC8LH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Move the parsed "fetch.showForcedUpdaets" config value into the
`fetch_config` structure. This reduces our reliance on global variables
and further unifies the way we parse the configuration in git-fetch(1).

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 94718bcb2a..eec04d7660 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -73,7 +73,6 @@ struct display_state {
 	int url_len, shown_url;
 };
=20
-static int fetch_show_forced_updates =3D 1;
 static uint64_t forced_updates_ms =3D 0;
 static int prefetch =3D 0;
 static int prune =3D -1; /* unspecified */
@@ -108,6 +107,7 @@ struct fetch_config {
 	enum display_format display_format;
 	int prune;
 	int prune_tags;
+	int show_forced_updates;
 };
=20
 static int git_fetch_config(const char *k, const char *v, void *cb)
@@ -125,7 +125,7 @@ static int git_fetch_config(const char *k, const char *=
v, void *cb)
 	}
=20
 	if (!strcmp(k, "fetch.showforcedupdates")) {
-		fetch_show_forced_updates =3D git_config_bool(k, v);
+		fetch_config->show_forced_updates =3D git_config_bool(k, v);
 		return 0;
 	}
=20
@@ -891,7 +891,8 @@ static int update_local_ref(struct ref *ref,
 			    struct ref_transaction *transaction,
 			    struct display_state *display_state,
 			    const struct ref *remote_ref,
-			    int summary_width)
+			    int summary_width,
+			    const struct fetch_config *config)
 {
 	struct commit *current =3D NULL, *updated;
 	int fast_forward =3D 0;
@@ -972,7 +973,7 @@ static int update_local_ref(struct ref *ref,
 		return r;
 	}
=20
-	if (fetch_show_forced_updates) {
+	if (config->show_forced_updates) {
 		uint64_t t_before =3D getnanotime();
 		fast_forward =3D repo_in_merge_bases(the_repository, current,
 						   updated);
@@ -1125,7 +1126,8 @@ static int store_updated_refs(struct display_state *d=
isplay_state,
 			      const char *remote_name,
 			      int connectivity_checked,
 			      struct ref_transaction *transaction, struct ref *ref_map,
-			      struct fetch_head *fetch_head)
+			      struct fetch_head *fetch_head,
+			      const struct fetch_config *config)
 {
 	int rc =3D 0;
 	struct strbuf note =3D STRBUF_INIT;
@@ -1241,7 +1243,7 @@ static int store_updated_refs(struct display_state *d=
isplay_state,
=20
 			if (ref) {
 				rc |=3D update_local_ref(ref, transaction, display_state,
-						       rm, summary_width);
+						       rm, summary_width, config);
 				free(ref);
 			} else if (write_fetch_head || dry_run) {
 				/*
@@ -1265,7 +1267,7 @@ static int store_updated_refs(struct display_state *d=
isplay_state,
 		      "branches"), remote_name);
=20
 	if (advice_enabled(ADVICE_FETCH_SHOW_FORCED_UPDATES)) {
-		if (!fetch_show_forced_updates) {
+		if (!config->show_forced_updates) {
 			warning(_(warn_show_forced_updates));
 		} else if (forced_updates_ms > FORCED_UPDATES_DELAY_WARNING_IN_MS) {
 			warning(_(warn_time_show_forced_updates),
@@ -1326,7 +1328,8 @@ static int fetch_and_consume_refs(struct display_stat=
e *display_state,
 				  struct transport *transport,
 				  struct ref_transaction *transaction,
 				  struct ref *ref_map,
-				  struct fetch_head *fetch_head)
+				  struct fetch_head *fetch_head,
+				  const struct fetch_config *config)
 {
 	int connectivity_checked =3D 1;
 	int ret;
@@ -1349,7 +1352,7 @@ static int fetch_and_consume_refs(struct display_stat=
e *display_state,
 	trace2_region_enter("fetch", "consume_refs", the_repository);
 	ret =3D store_updated_refs(display_state, transport->remote->name,
 				 connectivity_checked, transaction, ref_map,
-				 fetch_head);
+				 fetch_head, config);
 	trace2_region_leave("fetch", "consume_refs", the_repository);
=20
 out:
@@ -1520,7 +1523,8 @@ static int backfill_tags(struct display_state *displa=
y_state,
 			 struct transport *transport,
 			 struct ref_transaction *transaction,
 			 struct ref *ref_map,
-			 struct fetch_head *fetch_head)
+			 struct fetch_head *fetch_head,
+			 const struct fetch_config *config)
 {
 	int retcode, cannot_reuse;
=20
@@ -1541,7 +1545,8 @@ static int backfill_tags(struct display_state *displa=
y_state,
 	transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, NULL);
 	transport_set_option(transport, TRANS_OPT_DEPTH, "0");
 	transport_set_option(transport, TRANS_OPT_DEEPEN_RELATIVE, NULL);
-	retcode =3D fetch_and_consume_refs(display_state, transport, transaction,=
 ref_map, fetch_head);
+	retcode =3D fetch_and_consume_refs(display_state, transport, transaction,=
 ref_map,
+					 fetch_head, config);
=20
 	if (gsecondary) {
 		transport_disconnect(gsecondary);
@@ -1668,7 +1673,8 @@ static int do_fetch(struct transport *transport,
 			retcode =3D 1;
 	}
=20
-	if (fetch_and_consume_refs(&display_state, transport, transaction, ref_ma=
p, &fetch_head)) {
+	if (fetch_and_consume_refs(&display_state, transport, transaction, ref_ma=
p,
+				   &fetch_head, config)) {
 		retcode =3D 1;
 		goto cleanup;
 	}
@@ -1691,7 +1697,7 @@ static int do_fetch(struct transport *transport,
 			 * the transaction and don't commit anything.
 			 */
 			if (backfill_tags(&display_state, transport, transaction, tags_ref_map,
-					  &fetch_head))
+					  &fetch_head, config))
 				retcode =3D 1;
 		}
=20
@@ -2110,6 +2116,7 @@ int cmd_fetch(int argc, const char **argv, const char=
 *prefix)
 		.display_format =3D DISPLAY_FORMAT_FULL,
 		.prune =3D -1,
 		.prune_tags =3D -1,
+		.show_forced_updates =3D 1,
 	};
 	const char *submodule_prefix =3D "";
 	const char *bundle_uri;
@@ -2207,7 +2214,7 @@ int cmd_fetch(int argc, const char **argv, const char=
 *prefix)
 			 N_("run 'maintenance --auto' after fetching")),
 		OPT_BOOL(0, "auto-gc", &enable_auto_gc,
 			 N_("run 'maintenance --auto' after fetching")),
-		OPT_BOOL(0, "show-forced-updates", &fetch_show_forced_updates,
+		OPT_BOOL(0, "show-forced-updates", &config.show_forced_updates,
 			 N_("check for forced-updates on all updated branches")),
 		OPT_BOOL(0, "write-commit-graph", &fetch_write_commit_graph,
 			 N_("write the commit-graph after fetching")),
--=20
2.40.1


--bBN48D2+r4JlC8LH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRkvy8ACgkQVbJhu7ck
PpSRZhAAq7GyUMFGRiVpsm6Xskb8jf/qvUyaPdHYvCDbu/rKQtfKat5jzG5H2GxG
9iDOBWZCrt/UgoV3FsHPfp1Rra4FXEfu9Qk7AieZ3ztqs/dDqS4YhA5UlSjU7AK2
sLqDHjuBfDpgQvDduLf85XwiY97Ez+ESo3ln1OXq+2d7SffqFUrSJzUFIOL72s6l
siIInl1jkLJSJ1/8NOsHXkTCgMUOBWkCDXfGD/tcPpm/g2FuOeOdbMV59wDSsevA
/dJEQ12jm+ilAwIgrWMQcRJR+Vtugn+aV2H4s8dsb0vGYz0ybihyFEvFuznGNXsi
ndHS+weXbwHfJ7Adx349deIhsGTcM0/iYglo/LR6vvqqHMIObDKp50Mf2jKKt1cE
TW01HuPCw+0NEq50bqu5ZC8cCguLqdfufyFBJ5Ae1RkzWxmhc9v1MloAQuw02JKP
N3lhVhYVyGFPHOicvTcfiifaOP336fKB8n+AWDkleBrytz9L4gLszs/ULJKsJ0T0
v77dVgmsYUarks8hUhBef4Opt/FkJHrbAY8yIgHcBR8hkrV16pjl4pwvRp2fSzWn
0OHKciv3x/i/QyiSGQYKdX/x+4fPP8hpwuqmnvFb0ww88EpNaraCRs/cV7VH2Uva
ClzpPoE6yOwGEddnUdBJ5j+SCMqKXws7yWoDkpkko0HbOMXe2fQ=
=N5/S
-----END PGP SIGNATURE-----

--bBN48D2+r4JlC8LH--
