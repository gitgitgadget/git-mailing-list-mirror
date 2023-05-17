Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C77C77B75
	for <git@archiver.kernel.org>; Wed, 17 May 2023 11:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjEQLtW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 07:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjEQLtO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 07:49:14 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C453A8D
        for <git@vger.kernel.org>; Wed, 17 May 2023 04:49:12 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 0F18332003D3
        for <git@vger.kernel.org>; Wed, 17 May 2023 07:49:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 17 May 2023 07:49:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1684324151; x=1684410551; bh=bF
        gp8hkBbbIMWO0IUzjlTdREL2Gx8KIlZaYqmGlT4xE=; b=VTQd7OZZbZbBnTstp6
        XdCTuUSjhW3fmkMHTT+kaDOvPBJo6u/6vDMMrmEjzT6Z2GcHdvd4rz1ct2Io4zIB
        z3LLqea2RDq4Z6CtzyxZ9Sv/LYTtYvFjQ5cHJZTIPQirEjLdSS9uZMIvBXkH0iFZ
        9SiB7XAIGoLU/Aup+tpcQ8yZSA5pzpgbZ7creHgEWAfnqKbka3IPskqDJreSyyhh
        UdHWO942H75dtoS0Lpitbec7s3EKh1Lw56M8sBnGBC7bCDxyGD3ooIbV56oZwonJ
        UDWOFC5JMxgAJxY7t82vL22yBl6Xpc2i1WvQCGJvyQn60NRZlBggIU4wFG7hDbWi
        N8Ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684324151; x=1684410551; bh=bFgp8hkBbbIMW
        O0IUzjlTdREL2Gx8KIlZaYqmGlT4xE=; b=V+ixL9mum2Ksehu14OzF8GIuk2B9L
        4/dqOP3GwoNyriExVvqRAwckOhtKBAmTuaF1vCzKMkZJi2OkiRFo8hKohKSWSdZR
        zdaVSljvbgbuCP2icOdHTKt0oJqc/DCsfP9SELmBqCx8+gywSCd7fYbso71bvK2D
        qQc5dYzcNZCrfHapvtpmvjrAx3frq21jeboH0si7wYI2wSK9NFbh0dvJodc5uAel
        CLzF8X3ZBq4owvh3TxJXSRHDLZoyjY0TbJd0DRDHAAoNU5pXAmwjDPj5yEj/knnS
        7WwwupG4C5Aadp+4Zgt7cv7QFpAfM/QS+g3amiB1RPynaGiMqCZlQ5QBQ==
X-ME-Sender: <xms:N79kZBAhXP52k294s2DH7sho3SDC9iMTOQFMnrNP7z30YS0ioYAYCg>
    <xme:N79kZPiPpLUHIvGv9sVDZZGNpBJOcVj5THGkX7ISZYJeQIM5yJt9ZdH4eBQkx7-96
    AKh_GBSJ0tvPp_PTw>
X-ME-Received: <xmr:N79kZMl0avDUpI7Hl_wNO1tbDtUeAk9FRsDUg0WlUDTlLjfSmOXmBvx9TA-5fzpMXDfhsrohN1qK7Iccdu7InfRnE_ffPCs1DwYK2w1jETcYaK5_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeiuddggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:N79kZLy7bz6QOVu6lvzUfhwYyPHZNjjgG9IHRkaatzetKBRpHWjKUg>
    <xmx:N79kZGSb0U2SXXyN-eCM6Xac-nIERLp6QaIrIdwPG0zn-k8e94RUww>
    <xmx:N79kZOad8eyd7Y8SWEkEbgblxO5kyDaz0c591SS_M6lC_fR9m3s8RA>
    <xmx:N79kZNPJPeaBdFC9Kgfe8WW0LM04t0z1SCyLHL2FmJrHmmAS9cMa0g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 17 May 2023 07:49:10 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 612d832b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Wed, 17 May 2023 11:48:47 +0000 (UTC)
Date:   Wed, 17 May 2023 13:49:08 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 7/9] fetch: use `fetch_config` to store
 "fetch.recurseSubmodules" value
Message-ID: <74eee5858d1511e35a0039ef8bd65585676b3f72.1684324059.git.ps@pks.im>
References: <cover.1684324059.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Jdy/NNF3EtjDqC8f"
Content-Disposition: inline
In-Reply-To: <cover.1684324059.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Jdy/NNF3EtjDqC8f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Move the parsed "fetch.recurseSubmodules" config value into the
`fetch_config` structure. This reduces our reliance on global variables
and further unifies the way we parse the configuration in git-fetch(1).

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index eec04d7660..b40df7e7ca 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -97,7 +97,6 @@ static struct string_list deepen_not =3D STRING_LIST_INIT=
_NODUP;
 static struct strbuf default_rla =3D STRBUF_INIT;
 static struct transport *gtransport;
 static struct transport *gsecondary;
-static int recurse_submodules =3D RECURSE_SUBMODULES_DEFAULT;
 static struct refspec refmap =3D REFSPEC_INIT_FETCH;
 static struct list_objects_filter_options filter_options =3D LIST_OBJECTS_=
FILTER_INIT;
 static struct string_list server_options =3D STRING_LIST_INIT_DUP;
@@ -108,6 +107,7 @@ struct fetch_config {
 	int prune;
 	int prune_tags;
 	int show_forced_updates;
+	int recurse_submodules;
 };
=20
 static int git_fetch_config(const char *k, const char *v, void *cb)
@@ -132,14 +132,14 @@ static int git_fetch_config(const char *k, const char=
 *v, void *cb)
 	if (!strcmp(k, "submodule.recurse")) {
 		int r =3D git_config_bool(k, v) ?
 			RECURSE_SUBMODULES_ON : RECURSE_SUBMODULES_OFF;
-		recurse_submodules =3D r;
+		fetch_config->recurse_submodules =3D r;
 	}
=20
 	if (!strcmp(k, "submodule.fetchjobs")) {
 		submodule_fetch_jobs_config =3D parse_submodule_fetchjobs(k, v);
 		return 0;
 	} else if (!strcmp(k, "fetch.recursesubmodules")) {
-		recurse_submodules =3D parse_fetch_recurse_submodules_arg(k, v);
+		fetch_config->recurse_submodules =3D parse_fetch_recurse_submodules_arg(=
k, v);
 		return 0;
 	}
=20
@@ -1210,7 +1210,7 @@ static int store_updated_refs(struct display_state *d=
isplay_state,
 				ref->force =3D rm->peer_ref->force;
 			}
=20
-			if (recurse_submodules !=3D RECURSE_SUBMODULES_OFF &&
+			if (config->recurse_submodules !=3D RECURSE_SUBMODULES_OFF &&
 			    (!rm->peer_ref || !oideq(&ref->old_oid, &ref->new_oid))) {
 				check_for_new_submodule_commits(&rm->old_oid);
 			}
@@ -1849,11 +1849,11 @@ static void add_options_to_argv(struct strvec *argv,
 		strvec_push(argv, "--force");
 	if (keep)
 		strvec_push(argv, "--keep");
-	if (recurse_submodules =3D=3D RECURSE_SUBMODULES_ON)
+	if (config->recurse_submodules =3D=3D RECURSE_SUBMODULES_ON)
 		strvec_push(argv, "--recurse-submodules");
-	else if (recurse_submodules =3D=3D RECURSE_SUBMODULES_OFF)
+	else if (config->recurse_submodules =3D=3D RECURSE_SUBMODULES_OFF)
 		strvec_push(argv, "--no-recurse-submodules");
-	else if (recurse_submodules =3D=3D RECURSE_SUBMODULES_ON_DEMAND)
+	else if (config->recurse_submodules =3D=3D RECURSE_SUBMODULES_ON_DEMAND)
 		strvec_push(argv, "--recurse-submodules=3Don-demand");
 	if (tags =3D=3D TAGS_SET)
 		strvec_push(argv, "--tags");
@@ -2117,6 +2117,7 @@ int cmd_fetch(int argc, const char **argv, const char=
 *prefix)
 		.prune =3D -1,
 		.prune_tags =3D -1,
 		.show_forced_updates =3D 1,
+		.recurse_submodules =3D RECURSE_SUBMODULES_DEFAULT,
 	};
 	const char *submodule_prefix =3D "";
 	const char *bundle_uri;
@@ -2245,7 +2246,7 @@ int cmd_fetch(int argc, const char **argv, const char=
 *prefix)
 			     builtin_fetch_options, builtin_fetch_usage, 0);
=20
 	if (recurse_submodules_cli !=3D RECURSE_SUBMODULES_DEFAULT)
-		recurse_submodules =3D recurse_submodules_cli;
+		config.recurse_submodules =3D recurse_submodules_cli;
=20
 	if (negotiate_only) {
 		switch (recurse_submodules_cli) {
@@ -2256,7 +2257,7 @@ int cmd_fetch(int argc, const char **argv, const char=
 *prefix)
 			 * submodules. Skip it by setting recurse_submodules to
 			 * RECURSE_SUBMODULES_OFF.
 			 */
-			recurse_submodules =3D RECURSE_SUBMODULES_OFF;
+			config.recurse_submodules =3D RECURSE_SUBMODULES_OFF;
 			break;
=20
 		default:
@@ -2265,11 +2266,11 @@ int cmd_fetch(int argc, const char **argv, const ch=
ar *prefix)
 		}
 	}
=20
-	if (recurse_submodules !=3D RECURSE_SUBMODULES_OFF) {
+	if (config.recurse_submodules !=3D RECURSE_SUBMODULES_OFF) {
 		int *sfjc =3D submodule_fetch_jobs_config =3D=3D -1
 			    ? &submodule_fetch_jobs_config : NULL;
-		int *rs =3D recurse_submodules =3D=3D RECURSE_SUBMODULES_DEFAULT
-			  ? &recurse_submodules : NULL;
+		int *rs =3D config.recurse_submodules =3D=3D RECURSE_SUBMODULES_DEFAULT
+			  ? &config.recurse_submodules : NULL;
=20
 		fetch_config_from_gitmodules(sfjc, rs);
 	}
@@ -2283,7 +2284,7 @@ int cmd_fetch(int argc, const char **argv, const char=
 *prefix)
 			 * Reference updates in submodules would be ambiguous
 			 * in porcelain mode, so we reject this combination.
 			 */
-			recurse_submodules =3D RECURSE_SUBMODULES_OFF;
+			config.recurse_submodules =3D RECURSE_SUBMODULES_OFF;
 			break;
=20
 		default:
@@ -2425,7 +2426,7 @@ int cmd_fetch(int argc, const char **argv, const char=
 *prefix)
 	 * the fetched history from each remote, so there is no need
 	 * to fetch submodules from here.
 	 */
-	if (!result && remote && (recurse_submodules !=3D RECURSE_SUBMODULES_OFF)=
) {
+	if (!result && remote && (config.recurse_submodules !=3D RECURSE_SUBMODUL=
ES_OFF)) {
 		struct strvec options =3D STRVEC_INIT;
 		int max_children =3D max_jobs;
=20
@@ -2438,7 +2439,7 @@ int cmd_fetch(int argc, const char **argv, const char=
 *prefix)
 		result =3D fetch_submodules(the_repository,
 					  &options,
 					  submodule_prefix,
-					  recurse_submodules,
+					  config.recurse_submodules,
 					  recurse_submodules_default,
 					  verbosity < 0,
 					  max_children);
--=20
2.40.1


--Jdy/NNF3EtjDqC8f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRkvzQACgkQVbJhu7ck
PpRp2hAAkKfKPj0mGP5RP2pPV6q0TH+NhxI95avcAXAr3Ufxjp/TmddqSSkG4tm0
2V0QdlNPgjVcKEN+INVxnc9+dlue/8dn7keh3dBqL0Z7gKBU4Xi8nV4aRW7ERRt+
vDY0dvFIMKIxD3MnzlSsoTTUYp7u42R+H36jPqWqr9GSiBmltB0yRRYQ8R9N2fEM
dnTijvrDu8fiRu6Wn7KH9cIbUMtxJgRppRHvnVJXE7vOqrooza3n2s3kMF8fXpmT
fjDu6nrS58JOdMEZinB9SxPZ3d+0yFVzlzaMm2ae/PHI4mRQjdPy/gL+jtLNrymT
PP+iCAGWGD9dBfwpsnaKEEzjbr07PlhYBmX9TGCspMxUPrnhbVdcBSthKQLwGY+f
Ia1EXYfncWuDFcc6ovjAO1FNDjpGobUE2UEaPtF0AZbZrAqfriLLZgfv5sOUkmXT
5FbpyjAc16kdz628zDrqQUK/jH1AJWQ48b+rEvSf3SlkdjxqnqPuUju9BdkBJv3D
e8g49A11n4T+lv8TFerGbzdpi29/zLksmHq89kuVUfU9POBrrgXE1r74tVJVLsOe
04FXpKC6hf3maqgh8/uFIZtuvVgI9IpzRRcGeb2MU9gmoXiixrV2MhlwWx9/ubdC
43YLOkX10bcr+gKQK0hCzJkAkzlIo0KjG5iGj6B45M6D1HVK658=
=d1qn
-----END PGP SIGNATURE-----

--Jdy/NNF3EtjDqC8f--
