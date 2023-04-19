Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92188C6FD18
	for <git@archiver.kernel.org>; Wed, 19 Apr 2023 12:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbjDSMcl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Apr 2023 08:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbjDSMcW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2023 08:32:22 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014471444E
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 05:31:51 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 9B92D320005D;
        Wed, 19 Apr 2023 08:31:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 19 Apr 2023 08:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681907510; x=1681993910; bh=dc
        aaVihIO0hHIWcxe9g49DuRBG/knwYTu2CMuvLVqP8=; b=CjBzDJsBrxwBvKr8T1
        tEbGucFUCIaGmdI91Pvns9t/niaKAZTbds9fr7fXe8TOeG/Gfr1pDpchl5P+ynZ5
        nZIrdzr3JVH7VusSf5lNf0trJfdbPc9rTh3ulnh1PsprR3K3WBOiwaj0Yl8TIsog
        dyBYrx72pjx//yn9dFSIFHzr9gv2uWKRS8F2HMH61dKy0LXcCusJn+ef8bc2k0gK
        9Navt6CejOhuQsbAm/3GsR+PcX5QgfzxXQa6atSZOrz6NXGRclL8TyxLvRlf+xpo
        fsvSpIeJIY4DvpW+xOZtYTWYfIwmydswEHIXGDyEPVT8lfQnJgT4dDVBIW3tA5qt
        +JaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681907510; x=1681993910; bh=dcaaVihIO0hHI
        Wcxe9g49DuRBG/knwYTu2CMuvLVqP8=; b=kQPOD6R62xzGWODq2i1Hhwbye3JBQ
        VzJJ9kOH8JXQo2D7EShf8VWOuIGSyRFKQHgJFJwdcaoNpzHQitA9Gbi6J1dcLMtL
        XtLI0hjYmmvOSzr2BfAbMZ7Q3423mqj7BYLm+EXMhG+nbQLM7nbFtjYx1aOBBnTC
        Np36oH/XslDfFG/bidnCWrSpRd5NnGkgY5h6Hgf1bHXL/nTgwLXQb+MFl8ro+4fV
        oWULTR4P7q7S0E/KEHI6hcn2cqW7hB8ZmSf+ZCbgSFCSX7UhypmH4tBYwR/5LO9q
        ZbinWoKiovD7PpwdMeBDyCtkzTaVqmDjvTJuFO7VeF1aAmM1XBcjbCmYA==
X-ME-Sender: <xms:Nt8_ZJRjo7E3j10e-ov0fimzxh34dba5eyXSzEvgTpReIUFtkbA6hA>
    <xme:Nt8_ZCx6btrXOgKGj6tB6R50RtV4FsYgDStX6zn4a4vgaskjXzdw-o9t2ai4nY-te
    OHGzdW6-OZyv5riHw>
X-ME-Received: <xmr:Nt8_ZO3kvQKfSRaqc_aDd1qd3bdyEE8zBqlWoJpYoLMBSXOt0y3qdUo0uO05z7RVikzBti5X2WgZKXlqKL8y3WtomXTu2CJMcYCuVYFhzCBW1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedttddgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:Nt8_ZBDT5puOBTqiWNIWmvNEihnPE15PeDYSsNH1q3kqQ6jwez5jtA>
    <xmx:Nt8_ZCgC7HFycpeVZllI5nVRqQUblXv5uAav1oTMwxD2LUJRhyEPcQ>
    <xmx:Nt8_ZFp3M7l95PFH2hvEmzObtES7JX-ItrPvjHBPeTu9O6zSuZj-LQ>
    <xmx:Nt8_ZKLSN71mG_cuKQY4UuYOZavPJV_xH9wGgcsQLNLuUMmHRhxFpw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Apr 2023 08:31:49 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 13e4a56b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 19 Apr 2023 12:31:36 +0000 (UTC)
Date:   Wed, 19 Apr 2023 14:31:47 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 6/8] fetch: move option related variables into main function
Message-ID: <640a8840e1b87ec8ea985dd2299e1bab584d516d.1681906949.git.ps@pks.im>
References: <cover.1681906948.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r+Im0rOevLKq+wjQ"
Content-Disposition: inline
In-Reply-To: <cover.1681906948.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--r+Im0rOevLKq+wjQ
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
 builtin/fetch.c | 194 ++++++++++++++++++++++++------------------------
 1 file changed, 98 insertions(+), 96 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index bcc156a9ce..81581b0033 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -79,9 +79,8 @@ static int all, append, dry_run, force, keep, multiple, u=
pdate_head_ok;
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
@@ -2145,13 +2052,108 @@ static int fetch_one(struct remote *remote, int ar=
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
2.40.0


--r+Im0rOevLKq+wjQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQ/3zIACgkQVbJhu7ck
PpRCHw//QFv4RTar/E+357f2FyEnpXoOUWzmTR5afeWxdoz1R+FHcNaHwUqew8sM
6QLQa5tQJm3l43vXc1uYmPUSso3vtyxbQQir24q+XrcdoSUmcUpoBvgK63GnAhRR
u+Tc4yvcR9H0BVT8Z6Wm95pVf/oWr+oNDw94lrAOd9jo8rzcjRcd/Tvh44eaytJq
eVrWmwXhJSrtyWnzFduATQAAxJBqZRLMnABF/D36wXWa94lFzhf8aLVEh0E2uShC
8T6XoxiKoGTOJtLshqOpmLzFzXWszOvtvec0PB32PFI3Sw/AJjZuus9O190cf7Ye
76wDML94BpTtUvZpo8QFcjUkeUq474wzDjdMab1MG+/Pl1A06n3smnGni//LCd2U
mHOfjuCNV7YbEbM9zSKEAZSqRMvhFXnJGpVk3LcDxEqHr6xHpF5tEb7XMHQe4Koz
snKsq07IK9zDWgW4q2KJL+SmhUn322RQlX27M+Ohd1lWAKZAp/pwC+ZqPpbwkM2o
PHEsKfoE9nyEHEXrirbZ2xC/RkxlQc2vUShS2WsbnzeadNCCBz9u57k6gXhf+jdQ
PFZCr6d05go+bjIawZcMTAVlb8vvVBRmAX5gHg7e2uNRxjGfv61EWqAOKmejHhdF
bZLbZAt0X4ATqmdXS94p/2xiXicdL9S2O+ASXxOcJRzhzYVWATA=
=DcKN
-----END PGP SIGNATURE-----

--r+Im0rOevLKq+wjQ--
