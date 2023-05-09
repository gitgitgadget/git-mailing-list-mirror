Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC09EC7EE22
	for <git@archiver.kernel.org>; Tue,  9 May 2023 13:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235530AbjEINC5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 09:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235415AbjEINCf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 09:02:35 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C5B59E5
        for <git@vger.kernel.org>; Tue,  9 May 2023 06:02:32 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 3FDCB5C0166;
        Tue,  9 May 2023 09:02:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 09 May 2023 09:02:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683637352; x=1683723752; bh=ke
        6pJI6ZiyfrXVM5kkuJaksbGcQRbhuqaiZgZyNIK+A=; b=LQOsWlLy9EqQnfvB9y
        YptrIGSlhMx3qkerNojjyu2KroJ/1bmtp0dD+8wcVqgxvlLB85aZe0GrebG7MjSp
        MvTklHaE33lwr33C2vquLlKDclQfk6J2Fz/xVG2YwXT0UyaLLper9e3iD3QU3CVw
        gHdd7WaU3XpECguVCHKdk/UuKjAyI7Ti28+S32nm9LNneOTca1TA80LcZMv3oKO8
        0mWjvZ9lHW+jCQ8XTcYKIDsk0EFFz+k6gL+lMJ7mLF7Lh8h9EFLhiWz4IjTfvS7X
        +ywToSXfgO/VZB6NKeoDEDjuvfjjJqA6tZTiXPJnS8BIf3bskRBa24jmV8OPOvnH
        zzBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683637352; x=1683723752; bh=ke6pJI6ZiyfrX
        VM5kkuJaksbGcQRbhuqaiZgZyNIK+A=; b=dfYoRbLkwbJVGcCZ54/CXNX3hVHhv
        FfdvwmPOBHAWo8y0rGs0seRxbBmipiQyq8/zqYSkBGEBuNjCb2rJjaLOSZyGR7f0
        ECscx+FNygykkYpR9QsdKCuO0SsAak9UD0EuK35BHyYaphD2mRuiIpFdGjl+FWS1
        aMfJ+232wdcCoAxOsKdJKPjwWE/OJCbD74ldepagM8ig0IRD3y5HFUC4XW+Ui/nN
        cUHAbQbCoQqcZ+ePl8UpL2xMOAZhXPYy8IymZ5S5KsPks8FAlUGTG3T5IzzgHGpw
        OCiq5lcCrLWmQu+HoW4FmTxxVnrngs5s3smkafhhf2v1DVAhL8pFTDAIA==
X-ME-Sender: <xms:Z0RaZDYwQNFb1xBw48FjkRqgi1GFiucPsD5x1aL-N5h5cgsY2WKYTw>
    <xme:Z0RaZCYnY1H430vrcnFR6hRl7k2s8M05BKXqovCrbAf94hHGVwUuVVznva0i1KikF
    aKPnMVbykpu_q32CA>
X-ME-Received: <xmr:Z0RaZF8nzL4th40f8cJhe1IySuOgvKbt8WVVOrRo4Z8J6ZrTBhOLbBA6JCA8XJfrLRwEMmqbKsOdyJq8Tk46-b2qybfe9UazJIIsGd0qzSE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegtddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:aERaZJqJw5r-7nopT05rF6OSzJSn44P4siTEM3Mo6QnA08b-5kJExA>
    <xmx:aERaZOq2HTVT5TdxglvhLKeuiy-iUYrF7LLoj5xJdj8kyyhunlVYhQ>
    <xmx:aERaZPS5m1wPf-upsq5n2-Co3D2meFHLdKEviU-llYXA9cP3epdzYQ>
    <xmx:aERaZHko26GC9wt-4tzLJbMD7HC4oQakqftp29Kda2oq4p-U08STOQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 May 2023 09:02:30 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id a875e988 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 9 May 2023 13:02:23 +0000 (UTC)
Date:   Tue, 9 May 2023 15:02:28 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v4 7/8] fetch: move option related variables into main
 function
Message-ID: <20f2e061d602ab5d47f90afdeb406c21fdec1806.1683636885.git.ps@pks.im>
References: <cover.1681906948.git.ps@pks.im>
 <cover.1683636885.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="C7gGX2LneJmMi2i1"
Content-Disposition: inline
In-Reply-To: <cover.1683636885.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--C7gGX2LneJmMi2i1
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
index e15d43dc1e..820ec7285c 100644
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
 static int git_fetch_config(const char *k, const char *v, void *cb)
 {
@@ -160,92 +153,6 @@ static int parse_refmap_arg(const struct option *opt, =
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
@@ -2147,13 +2054,109 @@ static int fetch_one(struct remote *remote, int ar=
gc, const char **argv,
=20
 int cmd_fetch(int argc, const char **argv, const char *prefix)
 {
-	int i;
 	const char *bundle_uri;
+	const char *submodule_prefix =3D "";
 	enum display_format display_format =3D DISPLAY_FORMAT_UNKNOWN;
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


--C7gGX2LneJmMi2i1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRaRGMACgkQVbJhu7ck
PpScBQ//UUNG03eSyCnKQmeA/Zx5hztZItKz4FLbcyfNtd6ChaGGsQhyFH6Lfa0G
3w1gyCyHzc04oSAczW6Es73vboHXdn0sEislc9Vs6lb71qx9KdWr3ytjbA8xIRX9
DlOdy9JG2lZrH0NWqx0ZwYv427spIErmKupebEtsKPzEMx0Bq0kjIhD5iO+XDOWr
j5HKW1TQrk21pYDVTBLK5jMEXeBiSZMYcFiKWhd34MiPzR36gIG64dqupVTT3mWF
bACz5m9w+4dm7nvZVjqPYBos7tp4w785GuRYU20Aj3YCLlhY4tszf9sKBy8G7aUe
j02fHzPfy4NJmmuctaaMXrh9WEKTO94FK4ubZrPl5Al6d0/l7DNukNZZvWcmSwNi
SR34faW67lhRgv88bgdnZIgiqxm2gbDAtPpNGEnCFWqtXFDaSKrM5CrX44O3JJmA
s36zGrP5v8gS4ua8m5l+uxuuCCzaMpJl8LST6Indqu8dS6HTDiHJiha0fkmabJqM
a6CnHWgiUKkmp4mJgEBcseENj8dKwd7/+TtMtWHUbYSy/iIrXlRKKaCXqdPSSyeV
8fpmP9EjciX0HD4J3p7YSmv7FDR9MAQ+yY1uxZ3F3ColU/ZbvUNammzSftk/D9Fe
z191A0W/FBOY2DNZcO0xfYbmUVxLSe8CSo+h64TrBhLafw4ftB4=
=CS1e
-----END PGP SIGNATURE-----

--C7gGX2LneJmMi2i1--
