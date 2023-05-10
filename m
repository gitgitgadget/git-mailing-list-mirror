Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81473C77B7D
	for <git@archiver.kernel.org>; Wed, 10 May 2023 12:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237076AbjEJMfF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 08:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237056AbjEJMen (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 08:34:43 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E81DA244
        for <git@vger.kernel.org>; Wed, 10 May 2023 05:34:38 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 24B653200915;
        Wed, 10 May 2023 08:34:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 10 May 2023 08:34:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683722076; x=1683808476; bh=HR
        taDev8Y9EJ65z4JfyvF2lkaP+uzw9mKaAmzAs/Z7I=; b=fW6yE/2itylFg5r8VS
        Vq4bYnl3ukLjhKxqEkdzmqH2rOftOk9HS+1ls700rLlfw8RHu2JNmdkKLKGBf4+d
        tipZa39bA3Jre0jMej9NjKbqW5JbQkb1flpkUbsgFaur3udZ8rBjngXlk8/CiZbh
        3gVhcFC7y0A60wMYzGZX7Y2nch8sJrbSzVWQm95jea0M/0AaePpfWp/6wq4/Iv8G
        ygesxH5R7iraRAV0R5BsvxKKa7tneDRQvkxwQXCNt87FubjO1dEjDWb9RJLnW9Ti
        rPT0c/rocZJJoMAmee/sKV6uRqnrXxWNfaHR1m5JHSk4QeIfMqqm9+t7Ndj+h6SE
        lqNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683722076; x=1683808476; bh=HRtaDev8Y9EJ6
        5z4JfyvF2lkaP+uzw9mKaAmzAs/Z7I=; b=HN2yOfYM5IpXGP+vNhSIDrLZbOOOX
        kobWUEt0BOqRasEmCHraZ5IpEBO4dCrV8xV63ZpvcCOcoj/4DPIu5v4lGPJksAkC
        n93NjY05w8hqLnXMC73YjmBIiVz2rkCqOZtnpeQcyRmHjgFi6IRDmK6x1ZaY9Qi0
        u7/wTQOCcxHnD9Ja81xlBLNYWv2UguKwdIEeFZ+JKU01UTnPUIPj2Vb4aUT5Bt5G
        Mkc49vW82ysHNd6DuYfl6gGVGcHfMHJMgAbY6hcw7ZxyBGifP8BS1FHK8l0BorQF
        ubwFCpgOFssGL0ENQ4OpAPzwJKNWQpfWaO2x5hGgBj0BaiS6GVkvieWKw==
X-ME-Sender: <xms:XI9bZOcqwyAr-BYunoUIdHsrFvnKcueSndqxung6T_0GZOEZnFaJvw>
    <xme:XI9bZIPqjnJXmr_UGyKBduiaW2jzUSAdWq5HETQkC54LFwWNX-z04fkkQP8yhG-2E
    xXqVJu5xHVRBPwYRQ>
X-ME-Received: <xmr:XI9bZPjjr-_iLwAoENwbcmVZ2IZ2DCrqjcGT2tFIeOYKZGbEm-pH5Gf1nhtOjuZNEzSV64n0DiaAXqbX_26nJp4PcxdkpSOqOYExhXN4UURt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegiedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:XI9bZL9MOJJiorWW3NAA36V7YQ7Y-vUmEGKCTWZka5NW4y1u5GxWgw>
    <xmx:XI9bZKsLRHWGVOAc-YCA3_lJHd2TyjbjKc1WvoHoZQvAnT_Q-2lN5A>
    <xmx:XI9bZCE2_5y0C4t0Ol1SeowN6-64RnsXT1-cFyzdIDgfo7mYsTmaAg>
    <xmx:XI9bZMKRJsCWbmisMSk8T2yQXNIzmCH9aR59b907lf57IBHMZsuzhw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 May 2023 08:34:35 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id e7344253 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 10 May 2023 12:34:25 +0000 (UTC)
Date:   Wed, 10 May 2023 14:34:32 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v5 8/9] fetch: move option related variables into main
 function
Message-ID: <8e33a08c35fd083903bfaf1e90634e690981cd4d.1683721293.git.ps@pks.im>
References: <cover.1681906948.git.ps@pks.im>
 <cover.1683721293.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qyvmVjqEtfTCoGyC"
Content-Disposition: inline
In-Reply-To: <cover.1683721293.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--qyvmVjqEtfTCoGyC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The options of git-fetch(1) which we pass to `parse_options()` are
declared globally in `builtin/fetch.c`. This means we're forced to use
global variables for all the options, which is more likely to cause
confusion than explicitly passing state around.

Refactor the code to move the options into `cmd_fetch()`. Move variables
that were previously forced to be declared globally and which are only
used by `cmd_fetch()` into function-local scope.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c | 197 ++++++++++++++++++++++++------------------------
 1 file changed, 100 insertions(+), 97 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 439d3c667b..7a3d620c4c 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -75,13 +75,12 @@ static int fetch_prune_tags_config =3D -1; /* unspecifi=
ed */
 static int prune_tags =3D -1; /* unspecified */
 #define PRUNE_TAGS_BY_DEFAULT 0 /* do we prune tags by default? */
=20
-static int all, append, dry_run, force, keep, multiple, update_head_ok;
+static int append, dry_run, force, keep, update_head_ok;
 static int write_fetch_head =3D 1;
 static int verbosity, deepen_relative, set_upstream, refetch;
 static int progress =3D -1;
-static int enable_auto_gc =3D 1;
-static int tags =3D TAGS_DEFAULT, unshallow, update_shallow, deepen;
-static int max_jobs =3D -1, submodule_fetch_jobs_config =3D -1;
+static int tags =3D TAGS_DEFAULT, update_shallow, deepen;
+static int submodule_fetch_jobs_config =3D -1;
 static int fetch_parallel_config =3D 1;
 static int atomic_fetch;
 static enum transport_family family;
@@ -92,17 +91,11 @@ static struct string_list deepen_not =3D STRING_LIST_IN=
IT_NODUP;
 static struct strbuf default_rla =3D STRBUF_INIT;
 static struct transport *gtransport;
 static struct transport *gsecondary;
-static const char *submodule_prefix =3D "";
 static int recurse_submodules =3D RECURSE_SUBMODULES_DEFAULT;
-static int recurse_submodules_cli =3D RECURSE_SUBMODULES_DEFAULT;
-static int recurse_submodules_default =3D RECURSE_SUBMODULES_ON_DEMAND;
 static struct refspec refmap =3D REFSPEC_INIT_FETCH;
 static struct list_objects_filter_options filter_options =3D LIST_OBJECTS_=
FILTER_INIT;
 static struct string_list server_options =3D STRING_LIST_INIT_DUP;
 static struct string_list negotiation_tip =3D STRING_LIST_INIT_NODUP;
-static int fetch_write_commit_graph =3D -1;
-static int stdin_refspecs =3D 0;
-static int negotiate_only;
=20
 struct fetch_config {
 	enum display_format display_format;
@@ -178,92 +171,6 @@ static int parse_refmap_arg(const struct option *opt, =
const char *arg, int unset
 	return 0;
 }
=20
-static struct option builtin_fetch_options[] =3D {
-	OPT__VERBOSITY(&verbosity),
-	OPT_BOOL(0, "all", &all,
-		 N_("fetch from all remotes")),
-	OPT_BOOL(0, "set-upstream", &set_upstream,
-		 N_("set upstream for git pull/fetch")),
-	OPT_BOOL('a', "append", &append,
-		 N_("append to .git/FETCH_HEAD instead of overwriting")),
-	OPT_BOOL(0, "atomic", &atomic_fetch,
-		 N_("use atomic transaction to update references")),
-	OPT_STRING(0, "upload-pack", &upload_pack, N_("path"),
-		   N_("path to upload pack on remote end")),
-	OPT__FORCE(&force, N_("force overwrite of local reference"), 0),
-	OPT_BOOL('m', "multiple", &multiple,
-		 N_("fetch from multiple remotes")),
-	OPT_SET_INT('t', "tags", &tags,
-		    N_("fetch all tags and associated objects"), TAGS_SET),
-	OPT_SET_INT('n', NULL, &tags,
-		    N_("do not fetch all tags (--no-tags)"), TAGS_UNSET),
-	OPT_INTEGER('j', "jobs", &max_jobs,
-		    N_("number of submodules fetched in parallel")),
-	OPT_BOOL(0, "prefetch", &prefetch,
-		 N_("modify the refspec to place all refs within refs/prefetch/")),
-	OPT_BOOL('p', "prune", &prune,
-		 N_("prune remote-tracking branches no longer on remote")),
-	OPT_BOOL('P', "prune-tags", &prune_tags,
-		 N_("prune local tags no longer on remote and clobber changed tags")),
-	OPT_CALLBACK_F(0, "recurse-submodules", &recurse_submodules_cli, N_("on-d=
emand"),
-		    N_("control recursive fetching of submodules"),
-		    PARSE_OPT_OPTARG, option_fetch_parse_recurse_submodules),
-	OPT_BOOL(0, "dry-run", &dry_run,
-		 N_("dry run")),
-	OPT_BOOL(0, "write-fetch-head", &write_fetch_head,
-		 N_("write fetched references to the FETCH_HEAD file")),
-	OPT_BOOL('k', "keep", &keep, N_("keep downloaded pack")),
-	OPT_BOOL('u', "update-head-ok", &update_head_ok,
-		    N_("allow updating of HEAD ref")),
-	OPT_BOOL(0, "progress", &progress, N_("force progress reporting")),
-	OPT_STRING(0, "depth", &depth, N_("depth"),
-		   N_("deepen history of shallow clone")),
-	OPT_STRING(0, "shallow-since", &deepen_since, N_("time"),
-		   N_("deepen history of shallow repository based on time")),
-	OPT_STRING_LIST(0, "shallow-exclude", &deepen_not, N_("revision"),
-			N_("deepen history of shallow clone, excluding rev")),
-	OPT_INTEGER(0, "deepen", &deepen_relative,
-		    N_("deepen history of shallow clone")),
-	OPT_SET_INT_F(0, "unshallow", &unshallow,
-		      N_("convert to a complete repository"),
-		      1, PARSE_OPT_NONEG),
-	OPT_SET_INT_F(0, "refetch", &refetch,
-		      N_("re-fetch without negotiating common commits"),
-		      1, PARSE_OPT_NONEG),
-	{ OPTION_STRING, 0, "submodule-prefix", &submodule_prefix, N_("dir"),
-		   N_("prepend this to submodule path output"), PARSE_OPT_HIDDEN },
-	OPT_CALLBACK_F(0, "recurse-submodules-default",
-		   &recurse_submodules_default, N_("on-demand"),
-		   N_("default for recursive fetching of submodules "
-		      "(lower priority than config files)"),
-		   PARSE_OPT_HIDDEN, option_fetch_parse_recurse_submodules),
-	OPT_BOOL(0, "update-shallow", &update_shallow,
-		 N_("accept refs that update .git/shallow")),
-	OPT_CALLBACK_F(0, "refmap", NULL, N_("refmap"),
-		       N_("specify fetch refmap"), PARSE_OPT_NONEG, parse_refmap_arg),
-	OPT_STRING_LIST('o', "server-option", &server_options, N_("server-specifi=
c"), N_("option to transmit")),
-	OPT_SET_INT('4', "ipv4", &family, N_("use IPv4 addresses only"),
-			TRANSPORT_FAMILY_IPV4),
-	OPT_SET_INT('6', "ipv6", &family, N_("use IPv6 addresses only"),
-			TRANSPORT_FAMILY_IPV6),
-	OPT_STRING_LIST(0, "negotiation-tip", &negotiation_tip, N_("revision"),
-			N_("report that we have only objects reachable from this object")),
-	OPT_BOOL(0, "negotiate-only", &negotiate_only,
-		 N_("do not fetch a packfile; instead, print ancestors of negotiation ti=
ps")),
-	OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
-	OPT_BOOL(0, "auto-maintenance", &enable_auto_gc,
-		 N_("run 'maintenance --auto' after fetching")),
-	OPT_BOOL(0, "auto-gc", &enable_auto_gc,
-		 N_("run 'maintenance --auto' after fetching")),
-	OPT_BOOL(0, "show-forced-updates", &fetch_show_forced_updates,
-		 N_("check for forced-updates on all updated branches")),
-	OPT_BOOL(0, "write-commit-graph", &fetch_write_commit_graph,
-		 N_("write the commit-graph after fetching")),
-	OPT_BOOL(0, "stdin", &stdin_refspecs,
-		 N_("accept refspecs from stdin")),
-	OPT_END()
-};
-
 static void unlock_pack(unsigned int flags)
 {
 	if (gtransport)
@@ -2159,12 +2066,108 @@ int cmd_fetch(int argc, const char **argv, const c=
har *prefix)
 	struct fetch_config config =3D {
 		.display_format =3D DISPLAY_FORMAT_FULL,
 	};
-	int i;
+	const char *submodule_prefix =3D "";
 	const char *bundle_uri;
 	struct string_list list =3D STRING_LIST_INIT_DUP;
 	struct remote *remote =3D NULL;
+	int all =3D 0, multiple =3D 0;
 	int result =3D 0;
 	int prune_tags_ok =3D 1;
+	int enable_auto_gc =3D 1;
+	int unshallow =3D 0;
+	int max_jobs =3D -1;
+	int recurse_submodules_cli =3D RECURSE_SUBMODULES_DEFAULT;
+	int recurse_submodules_default =3D RECURSE_SUBMODULES_ON_DEMAND;
+	int fetch_write_commit_graph =3D -1;
+	int stdin_refspecs =3D 0;
+	int negotiate_only =3D 0;
+	int i;
+
+	struct option builtin_fetch_options[] =3D {
+		OPT__VERBOSITY(&verbosity),
+		OPT_BOOL(0, "all", &all,
+			 N_("fetch from all remotes")),
+		OPT_BOOL(0, "set-upstream", &set_upstream,
+			 N_("set upstream for git pull/fetch")),
+		OPT_BOOL('a', "append", &append,
+			 N_("append to .git/FETCH_HEAD instead of overwriting")),
+		OPT_BOOL(0, "atomic", &atomic_fetch,
+			 N_("use atomic transaction to update references")),
+		OPT_STRING(0, "upload-pack", &upload_pack, N_("path"),
+			   N_("path to upload pack on remote end")),
+		OPT__FORCE(&force, N_("force overwrite of local reference"), 0),
+		OPT_BOOL('m', "multiple", &multiple,
+			 N_("fetch from multiple remotes")),
+		OPT_SET_INT('t', "tags", &tags,
+			    N_("fetch all tags and associated objects"), TAGS_SET),
+		OPT_SET_INT('n', NULL, &tags,
+			    N_("do not fetch all tags (--no-tags)"), TAGS_UNSET),
+		OPT_INTEGER('j', "jobs", &max_jobs,
+			    N_("number of submodules fetched in parallel")),
+		OPT_BOOL(0, "prefetch", &prefetch,
+			 N_("modify the refspec to place all refs within refs/prefetch/")),
+		OPT_BOOL('p', "prune", &prune,
+			 N_("prune remote-tracking branches no longer on remote")),
+		OPT_BOOL('P', "prune-tags", &prune_tags,
+			 N_("prune local tags no longer on remote and clobber changed tags")),
+		OPT_CALLBACK_F(0, "recurse-submodules", &recurse_submodules_cli, N_("on-=
demand"),
+			    N_("control recursive fetching of submodules"),
+			    PARSE_OPT_OPTARG, option_fetch_parse_recurse_submodules),
+		OPT_BOOL(0, "dry-run", &dry_run,
+			 N_("dry run")),
+		OPT_BOOL(0, "write-fetch-head", &write_fetch_head,
+			 N_("write fetched references to the FETCH_HEAD file")),
+		OPT_BOOL('k', "keep", &keep, N_("keep downloaded pack")),
+		OPT_BOOL('u', "update-head-ok", &update_head_ok,
+			    N_("allow updating of HEAD ref")),
+		OPT_BOOL(0, "progress", &progress, N_("force progress reporting")),
+		OPT_STRING(0, "depth", &depth, N_("depth"),
+			   N_("deepen history of shallow clone")),
+		OPT_STRING(0, "shallow-since", &deepen_since, N_("time"),
+			   N_("deepen history of shallow repository based on time")),
+		OPT_STRING_LIST(0, "shallow-exclude", &deepen_not, N_("revision"),
+				N_("deepen history of shallow clone, excluding rev")),
+		OPT_INTEGER(0, "deepen", &deepen_relative,
+			    N_("deepen history of shallow clone")),
+		OPT_SET_INT_F(0, "unshallow", &unshallow,
+			      N_("convert to a complete repository"),
+			      1, PARSE_OPT_NONEG),
+		OPT_SET_INT_F(0, "refetch", &refetch,
+			      N_("re-fetch without negotiating common commits"),
+			      1, PARSE_OPT_NONEG),
+		{ OPTION_STRING, 0, "submodule-prefix", &submodule_prefix, N_("dir"),
+			   N_("prepend this to submodule path output"), PARSE_OPT_HIDDEN },
+		OPT_CALLBACK_F(0, "recurse-submodules-default",
+			   &recurse_submodules_default, N_("on-demand"),
+			   N_("default for recursive fetching of submodules "
+			      "(lower priority than config files)"),
+			   PARSE_OPT_HIDDEN, option_fetch_parse_recurse_submodules),
+		OPT_BOOL(0, "update-shallow", &update_shallow,
+			 N_("accept refs that update .git/shallow")),
+		OPT_CALLBACK_F(0, "refmap", NULL, N_("refmap"),
+			       N_("specify fetch refmap"), PARSE_OPT_NONEG, parse_refmap_arg),
+		OPT_STRING_LIST('o', "server-option", &server_options, N_("server-specif=
ic"), N_("option to transmit")),
+		OPT_SET_INT('4', "ipv4", &family, N_("use IPv4 addresses only"),
+				TRANSPORT_FAMILY_IPV4),
+		OPT_SET_INT('6', "ipv6", &family, N_("use IPv6 addresses only"),
+				TRANSPORT_FAMILY_IPV6),
+		OPT_STRING_LIST(0, "negotiation-tip", &negotiation_tip, N_("revision"),
+				N_("report that we have only objects reachable from this object")),
+		OPT_BOOL(0, "negotiate-only", &negotiate_only,
+			 N_("do not fetch a packfile; instead, print ancestors of negotiation t=
ips")),
+		OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
+		OPT_BOOL(0, "auto-maintenance", &enable_auto_gc,
+			 N_("run 'maintenance --auto' after fetching")),
+		OPT_BOOL(0, "auto-gc", &enable_auto_gc,
+			 N_("run 'maintenance --auto' after fetching")),
+		OPT_BOOL(0, "show-forced-updates", &fetch_show_forced_updates,
+			 N_("check for forced-updates on all updated branches")),
+		OPT_BOOL(0, "write-commit-graph", &fetch_write_commit_graph,
+			 N_("write the commit-graph after fetching")),
+		OPT_BOOL(0, "stdin", &stdin_refspecs,
+			 N_("accept refspecs from stdin")),
+		OPT_END()
+	};
=20
 	packet_trace_identity("fetch");
=20
--=20
2.40.1


--qyvmVjqEtfTCoGyC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRbj1cACgkQVbJhu7ck
PpSXLBAAq7NexJWshsvuaGvSf4LHlRREriUQfo+yrcsl4LENP55l7kT+j1aexZS9
DS/hpgOo2W00BQ5l3DZrGkj0GY/gAB6yCYcJ8qf0rq8+SDybez3X0z9R6vnSeNmC
Ros7Cf1ki3YGgumpbgcL9qlyNLH3jo4rvFH+kKLk4xREi4TmL7oH0yg2g+D85PKe
QmizBPpsHbB1v1C1Tz/6GeGKVBciPgWOroB0NQRG+MR0UgT3ENJptyY1DZT0NOc8
MIMyicQkbLvrGv27Tm5ymIjwCcw8xHRHdGEE15CKDKFlj2s3UIj3/ueAFKotgDCn
uGkCbfdWT6c3i+17cmjV21Ej+nfIWCoA6yti23wCG1eviLT3042YrxBGzFr2LFbY
ezwVa5b7jP2/dg+9FE3mjyB4iE8PYKSXq+YwxN3VXPDqLPtwYgz/ly8PmJIYGS8w
Z4s02T1lqF4xoCMeHnaKnISZdtRJJoYhwKzcpxT+MxORPeTfpe4zWBRvoDDFkOSZ
AE6s9YrKPvnEo2KrpFMa12bL861eX+axNkigRyz4fqsxGSGyrms8G58y/XIdLtIF
UNJR0jG68mKdUY0YJfzwDxdLKnfHRhYRM1IU18jEdtUWeF3foTaYOfRoa5TDppsP
nfD7/lLtcpP0elvW4ppHfCd5eEHaF6TwoIENkanw1lUws/JYwuc=
=y5EH
-----END PGP SIGNATURE-----

--qyvmVjqEtfTCoGyC--
