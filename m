Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35333C77B7F
	for <git@archiver.kernel.org>; Wed, 17 May 2023 11:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjEQLtJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 07:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjEQLs7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 07:48:59 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBD6449E
        for <git@vger.kernel.org>; Wed, 17 May 2023 04:48:54 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id EE2F432002B6
        for <git@vger.kernel.org>; Wed, 17 May 2023 07:48:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 17 May 2023 07:48:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1684324133; x=1684410533; bh=zw
        D5m9WzvJzlKEnEhRLvt4jA5eCuXnNRtcR8AnN+7bM=; b=N9VY653xEwn34YGUz7
        gyzUld2X7tMkXXL01FtgyFXnLXvmpAeW871L7gjK62hZCoSA08rWYNPYE9DWh0es
        VVwJrHhi5Nnilhuo3BxdZh6q/QYlqppq3pZ7P/4J6Y3UYTkj9eFCfiOVqcaoOdFd
        8s/aMpKr7XDbpP86jnezefIv+3349puyOvaVu0L4YLcyXxRedYw88t39QKayvOBc
        poY88qPpnIZMMNnK9IiZJ/RCSY0OzgaI2+j5TcjVjQ0FXhxVOl8CRHtYFGM3a/LL
        f+CPTWPVl+NTqZbiqOwb4e6UlkFAWPlbIh62NhsdrQGMjO4tFe9qQot5C++Kh0EQ
        hW9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684324133; x=1684410533; bh=zwD5m9WzvJzlK
        EnEhRLvt4jA5eCuXnNRtcR8AnN+7bM=; b=RNg8TdyDBbfrhtcwLgDbUqeNt1hf7
        RxiWLmtAXXT7SBWR4jq0EuwnWpL3aci9qLDZzOvRY7lKoPQeh4QL7DCNeJeqc51u
        b7/mdrOhIxvxH3+DuASCFOGDz86VOtyL1BA1kHcF5V0hqyz+/BwZxrUF2VW/HVW1
        ZTUIGEiC6nuvYd1h9ZJu21oSfyyl3iLnGcGWN3U0vNd3/3Z1gGoyWDqyFQOM/KWI
        LWawYPhyXTVQfH4wnip55W9NrJO39hxupja2FlJ45r0hn9ZbSRgspqK5iEIY70+e
        e3QbNvmOtwXxtnArcLyRx/nJTRQZkFRUn5PPXnNvFsMEAaTuOflEPl6Ig==
X-ME-Sender: <xms:Jb9kZCubsr83qBIwWz2Hom-9gEAD7xQa4Nkbjh2aps2v9QC2QbWjNA>
    <xme:Jb9kZHfPDrQjBTWhJ2WOUpJUxLZ9VJyjWtXJ2BDMOKhqlmhrbu-kzyYr7p8TpgCCU
    MuHZ_MnJQYysuPNbQ>
X-ME-Received: <xmr:Jb9kZNyXx2M92PL_va0GClR4MlYYfQubkTKc9GB5gPbKcZJKW1stfQGMCspmB-h57vYpYMUm_LuNvJA6F0TfRJqPISRp7Nd6aedvscDg797A2ACj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeiuddggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepvdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:Jb9kZNO8HtrFKvPBOVkcGvGCJ__Cb8v86u3o9kL0MmA_fixC7RYI2Q>
    <xmx:Jb9kZC-8g8U1ou9Z8kDcI9NiaHNVeKItvAJnOrfR_XZvNufi0wA46A>
    <xmx:Jb9kZFX2YzKSO-a3_9ZEwlZaJJvCXCKYuxGajjY2B1BH4usL0K9Cig>
    <xmx:Jb9kZDLaur3GYyft0j4syMNH2qDfuGqsiNzStBpfTg690BQlkm9uFg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 17 May 2023 07:48:52 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id d9b2f6c5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Wed, 17 May 2023 11:48:29 +0000 (UTC)
Date:   Wed, 17 May 2023 13:48:51 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 3/9] fetch: pass through `fetch_config` directly
Message-ID: <b09f21dff786780dfb0ae71efd9a0cabe31c1e0b.1684324059.git.ps@pks.im>
References: <cover.1684324059.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qZVeX2lkNHody41m"
Content-Disposition: inline
In-Reply-To: <cover.1684324059.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--qZVeX2lkNHody41m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `fetch_config` structure currently only has a single member, which
is the `display_format`. We're about extend it to contain all parsed
config values and will thus need it available in most of the code.

Prepare for this change by passing through the `fetch_config` directly
instead of only passing its single member.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index f268322e6f..401543e05d 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1553,7 +1553,7 @@ static int backfill_tags(struct display_state *displa=
y_state,
=20
 static int do_fetch(struct transport *transport,
 		    struct refspec *rs,
-		    enum display_format display_format)
+		    const struct fetch_config *config)
 {
 	struct ref_transaction *transaction =3D NULL;
 	struct ref *ref_map =3D NULL;
@@ -1639,7 +1639,8 @@ static int do_fetch(struct transport *transport,
 	if (retcode)
 		goto cleanup;
=20
-	display_state_init(&display_state, ref_map, transport->url, display_forma=
t);
+	display_state_init(&display_state, ref_map, transport->url,
+			   config->display_format);
=20
 	if (atomic_fetch) {
 		transaction =3D ref_transaction_begin(&err);
@@ -1828,7 +1829,7 @@ static int add_remote_or_group(const char *name, stru=
ct string_list *list)
 }
=20
 static void add_options_to_argv(struct strvec *argv,
-				enum display_format format)
+				const struct fetch_config *config)
 {
 	if (dry_run)
 		strvec_push(argv, "--dry-run");
@@ -1864,7 +1865,7 @@ static void add_options_to_argv(struct strvec *argv,
 		strvec_push(argv, "--ipv6");
 	if (!write_fetch_head)
 		strvec_push(argv, "--no-write-fetch-head");
-	if (format =3D=3D DISPLAY_FORMAT_PORCELAIN)
+	if (config->display_format =3D=3D DISPLAY_FORMAT_PORCELAIN)
 		strvec_pushf(argv, "--porcelain");
 }
=20
@@ -1874,7 +1875,7 @@ struct parallel_fetch_state {
 	const char **argv;
 	struct string_list *remotes;
 	int next, result;
-	enum display_format format;
+	const struct fetch_config *config;
 };
=20
 static int fetch_next_remote(struct child_process *cp,
@@ -1894,7 +1895,7 @@ static int fetch_next_remote(struct child_process *cp,
 	strvec_push(&cp->args, remote);
 	cp->git_cmd =3D 1;
=20
-	if (verbosity >=3D 0 && state->format !=3D DISPLAY_FORMAT_PORCELAIN)
+	if (verbosity >=3D 0 && state->config->display_format !=3D DISPLAY_FORMAT=
_PORCELAIN)
 		printf(_("Fetching %s\n"), remote);
=20
 	return 1;
@@ -1927,7 +1928,7 @@ static int fetch_finished(int result, struct strbuf *=
out,
 }
=20
 static int fetch_multiple(struct string_list *list, int max_children,
-			  enum display_format format)
+			  const struct fetch_config *config)
 {
 	int i, result =3D 0;
 	struct strvec argv =3D STRVEC_INIT;
@@ -1945,10 +1946,10 @@ static int fetch_multiple(struct string_list *list,=
 int max_children,
 	strvec_pushl(&argv, "-c", "fetch.bundleURI=3D",
 		     "fetch", "--append", "--no-auto-gc",
 		     "--no-write-commit-graph", NULL);
-	add_options_to_argv(&argv, format);
+	add_options_to_argv(&argv, config);
=20
 	if (max_children !=3D 1 && list->nr !=3D 1) {
-		struct parallel_fetch_state state =3D { argv.v, list, 0, 0, format };
+		struct parallel_fetch_state state =3D { argv.v, list, 0, 0, config };
 		const struct run_process_parallel_opts opts =3D {
 			.tr2_category =3D "fetch",
 			.tr2_label =3D "parallel/fetch",
@@ -1972,7 +1973,7 @@ static int fetch_multiple(struct string_list *list, i=
nt max_children,
=20
 			strvec_pushv(&cmd.args, argv.v);
 			strvec_push(&cmd.args, name);
-			if (verbosity >=3D 0 && format !=3D DISPLAY_FORMAT_PORCELAIN)
+			if (verbosity >=3D 0 && config->display_format !=3D DISPLAY_FORMAT_PORC=
ELAIN)
 				printf(_("Fetching %s\n"), name);
 			cmd.git_cmd =3D 1;
 			if (run_command(&cmd)) {
@@ -2028,7 +2029,7 @@ static inline void fetch_one_setup_partial(struct rem=
ote *remote)
=20
 static int fetch_one(struct remote *remote, int argc, const char **argv,
 		     int prune_tags_ok, int use_stdin_refspecs,
-		     enum display_format display_format)
+		     const struct fetch_config *config)
 {
 	struct refspec rs =3D REFSPEC_INIT_FETCH;
 	int i;
@@ -2095,7 +2096,7 @@ static int fetch_one(struct remote *remote, int argc,=
 const char **argv,
 	sigchain_push_common(unlock_pack_on_signal);
 	atexit(unlock_pack_atexit);
 	sigchain_push(SIGPIPE, SIG_IGN);
-	exit_code =3D do_fetch(gtransport, &rs, display_format);
+	exit_code =3D do_fetch(gtransport, &rs, config);
 	sigchain_pop(SIGPIPE);
 	refspec_clear(&rs);
 	transport_disconnect(gtransport);
@@ -2383,7 +2384,7 @@ int cmd_fetch(int argc, const char **argv, const char=
 *prefix)
 		if (filter_options.choice || repo_has_promisor_remote(the_repository))
 			fetch_one_setup_partial(remote);
 		result =3D fetch_one(remote, argc, argv, prune_tags_ok, stdin_refspecs,
-				   config.display_format);
+				   &config);
 	} else {
 		int max_children =3D max_jobs;
=20
@@ -2403,7 +2404,7 @@ int cmd_fetch(int argc, const char **argv, const char=
 *prefix)
 			max_children =3D fetch_parallel_config;
=20
 		/* TODO should this also die if we have a previous partial-clone? */
-		result =3D fetch_multiple(&list, max_children, config.display_format);
+		result =3D fetch_multiple(&list, max_children, &config);
 	}
=20
 	/*
@@ -2424,7 +2425,7 @@ int cmd_fetch(int argc, const char **argv, const char=
 *prefix)
 		if (max_children < 0)
 			max_children =3D fetch_parallel_config;
=20
-		add_options_to_argv(&options, config.display_format);
+		add_options_to_argv(&options, &config);
 		result =3D fetch_submodules(the_repository,
 					  &options,
 					  submodule_prefix,
--=20
2.40.1


--qZVeX2lkNHody41m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRkvyIACgkQVbJhu7ck
PpR2uQ//SBlUj3L+E+onSmE0bmWT/q0KGqhxJyeePYHgo92fPLHTguHpuKDlsRI2
T3rvNo/EdzFrvBqIEqCRbLISz0Y8pynzjAqk2Z1WIG98p4b+HK22Jw5ZqhdlZhZw
iuz0zklnJglPCEuIcdpzf8/cw4UMmAedpy03JPCDI7oDAlpX0b9rOajlmXo+Hh9h
h81mI0RiGnpFeE98bKn+g7gKGQ0Ql5rmPoxs9FsM3QwycJhZY4TJlI2E4YUH1/yM
MIrg8rXXFQKy8M9NG6hAM2mbs5jFbKzDqgb4r7Vceb8X+JS+P/K4O3zsOxvdT8N+
uPrame645Xvy7iIVyAcUxfBHLzhsjSe+EdpjSKBppWPzhmIkvHsF3Cvpx1LaDv+C
lrnvrBAMQo4+YIAgyjfSjhiWdck41TLCQM2eVsa2LrqqL9reSMc5UBBc54juEa2/
+nl2pU7e1ftlJFhGbk57+5Xc2NIDNK3KvtUYjPjlTcMUEZ/lmbH46/Ba6sGMjLb2
2j7DurpixECkibpDkCq8dqGvA7mPk1YozCiRHxKX4nQd78AAUy7oynlTySffR41q
tBrRdzdZFNVlmXk8+6UJVpAOdHIb6p8h9r5uYj0Mjd+pzzY3Mi8JkBEQKrqLkFgC
dNUcujjINTZizTbqypA5khU8gdJcW/DiT5EoowDdkPw04DMYh7s=
=sM6X
-----END PGP SIGNATURE-----

--qZVeX2lkNHody41m--
