Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF7BC77B7D
	for <git@archiver.kernel.org>; Wed, 10 May 2023 12:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237107AbjEJMfH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 08:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237085AbjEJMep (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 08:34:45 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CD57EE3
        for <git@vger.kernel.org>; Wed, 10 May 2023 05:34:42 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id EFD3E3200919;
        Wed, 10 May 2023 08:34:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 10 May 2023 08:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683722080; x=1683808480; bh=Gw
        HAh7ymY1dL1n7gAHZxXdhUi5jHFwsCMP+QwVBgdNc=; b=X8jwkIduQyOGICVkAW
        i/KuzUpdIXjVsZ2WWb4ooIEkbaRD+NZs6QW/kYGkH6P7p16myj6lCAgtgg48JP8Q
        FM5shO1sN8C1g0007p3CL6bkjalrw0U4RWizmaZHgoiJa8tzWxUEVU63FbsysPiU
        rjUd/jh9XRKcIlMhrloP1ix3iVmwM4Zrs0pHvGkr2NW6xmZZG6JmWcz0nVBbbBo1
        oiA6rUSrLk4hBUtS9hISE5sWGrG3LOcqSXjbm1cnTToe9rOmUcG9e6T/3WA+bj9Y
        N48JmY+7/S07ZP5p9qolr2DOXRBelbl6HE0i7dJ3JnrDRE8xVpvrjYxikw5quCSz
        Uzeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683722080; x=1683808480; bh=GwHAh7ymY1dL1
        n7gAHZxXdhUi5jHFwsCMP+QwVBgdNc=; b=D0LZW9EaBJnuavHA+Sq0zrR2H0K9Q
        6SInG9//7Fe4nG6bjgzCXLSK+4lTBts8vybETI9XHnIwV2jkAh3qtDSGW9g3rMcr
        f7NkFNj1hXSQlHT2geyEMmslJ+YE7U2SGQzLZZUZnFHS9b3qkett867qc/Mw+twF
        DnIobbtR8y/8zBSOLufVh4WOIOr/Y85Ub70IG6m2siqERZIlYzA/sT6U39wF0LOc
        HrxUl6MrYA9CqcVSErJiJ8gL31dEFGKnt1qKM002WMwPkIVbp8s57+JAd3reWJOO
        Xkn5Tipa9AzN6YntjbwJDQ8MZYwWWY+at0Bxx24wJsl3LtWeN9sFN6Q5A==
X-ME-Sender: <xms:YI9bZLJDQwr3FYsN8y_aoPJdLc-usoTAvFIHQ8W1FtisTh2Xls8HQg>
    <xme:YI9bZPLag9ljQSfEw-Lwsg-UIc_dAlbQI77Hkp4kAUz-upCKG-hsVHJZqjmpsYCCx
    9TItn6mpJ0ny1nYUQ>
X-ME-Received: <xmr:YI9bZDv9Ub6aY-2FoSja5KwEEo5NkGROsTnZ8h7Gou0Zk19oBgjz3fRRvel0iwV-NIaqKlb5RusVMvwZj1eycxGExDGhOFSybLerRoxsRoAS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegiedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:YI9bZEZAs5NOlOq3dRkuo6GXS4np1w3Qf68by-rqyD6ry7cvJp1XWA>
    <xmx:YI9bZCYG3R_xmfVhffpmOJNuScq84jXTeL2d0vA6z9tAbrTNuUoJCw>
    <xmx:YI9bZIBekETvau04BqH5TAViogaCPZmPXrtM_9h3SXcVQ9IRp7HUnA>
    <xmx:YI9bZJXXWzDR5VZ76xoEdz113rbO7g_cWKb-TX-ekS2FRuDrAOZdDA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 May 2023 08:34:38 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 359bdb51 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 10 May 2023 12:34:29 +0000 (UTC)
Date:   Wed, 10 May 2023 14:34:36 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v5 9/9] fetch: introduce machine-parseable "porcelain" output
 format
Message-ID: <d49152c22068d18cf9f8a2f1e5fe92a3b1f13e37.1683721293.git.ps@pks.im>
References: <cover.1681906948.git.ps@pks.im>
 <cover.1683721293.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s7cNegqV08IN7d/H"
Content-Disposition: inline
In-Reply-To: <cover.1683721293.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--s7cNegqV08IN7d/H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The output of git-fetch(1) is obviously designed for consumption by
users, only: we neatly columnize data, we abbreviate reference names, we
print neat arrows and we don't provide information about actual object
IDs that have changed. This makes the output format basically unusable
in the context of scripted invocations of git-fetch(1) that want to
learn about the exact changes that the command performs.

Introduce a new machine-parseable "porcelain" output format that is
supposed to fix this shortcoming. This output format is intended to
provide information about every reference that is about to be updated,
the old object ID that the reference has been pointing to and the new
object ID it will be updated to. Furthermore, the output format provides
the same flags as the human-readable format to indicate basic conditions
for each reference update like whether it was a fast-forward update, a
branch deletion, a rejected update or others.

The output format is quite simple:

```
<flag> <old-object-id> <new-object-id> <local-reference>\n
```

We assume two conditions which are generally true:

    - The old and new object IDs have fixed known widths and cannot
      contain spaces.

    - References cannot contain newlines.

With these assumptions, the output format becomes unambiguously
parseable. Furthermore, given that this output is designed to be
consumed by scripts, the machine-readable data is printed to stdout
instead of stderr like the human-readable output is. This is mostly done
so that other data printed to stderr, like error messages or progress
meters, don't interfere with the parseable data.

A notable ommission here is that the output format does not include the
remote from which a reference was fetched, which might be important
information especially in the context of multi-remote fetches. But as
such a format would require us to print the remote for every single
reference update due to parallelizable fetches it feels wasteful for the
most likely usecase, which is when fetching from a single remote.

In a similar spirit, a second restriction is that this cannot be used
with `--recurse-submodules`. This is because any reference updates would
be ambiguous without also printing the repository in which the update
happens.

Considering that both multi-remote and submodule fetches are user-facing
features, using them in conjunction with `--porcelain` that is intended
for scripting purposes is likely not going to be useful in the majority
of cases. With that in mind these restrictions feel acceptable. If
usecases for either of these come up in the future though it is easy
enough to add a new "porcelain-v2" format that adds this information.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/fetch-options.txt |   7 ++
 Documentation/git-fetch.txt     |   9 ++
 builtin/fetch.c                 |  88 ++++++++++++++----
 t/t5574-fetch-output.sh         | 159 ++++++++++++++++++++++++++++++++
 4 files changed, 244 insertions(+), 19 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.=
txt
index 622bd84768..41fc7ca3c6 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -78,6 +78,13 @@ linkgit:git-config[1].
 --dry-run::
 	Show what would be done, without making any changes.
=20
+--porcelain::
+	Print the output to standard output in an easy-to-parse format for
+	scripts. See section OUTPUT in linkgit:git-fetch[1] for details.
++
+This is incompatible with `--recurse-submodules=3D[yes|on-demand]` and tak=
es
+precedence over the `fetch.output` config option.
+
 ifndef::git-pull[]
 --[no-]write-fetch-head::
 	Write the list of remote refs fetched in the `FETCH_HEAD`
diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index fba66f1460..f123139c58 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -204,6 +204,15 @@ representing the status of a single ref. Each line is =
of the form:
  <flag> <summary> <from> -> <to> [<reason>]
 -------------------------------
=20
+When using `--porcelain`, the output format is intended to be
+machine-parseable. In contrast to the human-readable output formats it
+thus prints to standard output instead of standard error. Each line is
+of the form:
+
+-------------------------------
+<flag> <old-object-id> <new-object-id> <local-reference>
+-------------------------------
+
 The status of up-to-date refs is shown only if the --verbose option is
 used.
=20
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 7a3d620c4c..462fc86b99 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -52,6 +52,7 @@ enum display_format {
 	DISPLAY_FORMAT_UNKNOWN =3D 0,
 	DISPLAY_FORMAT_FULL,
 	DISPLAY_FORMAT_COMPACT,
+	DISPLAY_FORMAT_PORCELAIN,
 };
=20
 struct display_state {
@@ -754,6 +755,9 @@ static void display_state_init(struct display_state *di=
splay_state, struct ref *
 		display_state->refcol_width =3D refcol_width(ref_map,
 							   display_state->format =3D=3D DISPLAY_FORMAT_COMPACT);
 		break;
+	case DISPLAY_FORMAT_PORCELAIN:
+		/* We don't need to precompute anything here. */
+		break;
 	default:
 		BUG("unexpected display format %d", display_state->format);
 	}
@@ -824,8 +828,12 @@ static void print_compact(struct display_state *displa=
y_state,
 static void display_ref_update(struct display_state *display_state, char c=
ode,
 			       const char *summary, const char *error,
 			       const char *remote, const char *local,
+			       const struct object_id *old_oid,
+			       const struct object_id *new_oid,
 			       int summary_width)
 {
+	FILE *f =3D stderr;
+
 	if (verbosity < 0)
 		return;
=20
@@ -858,12 +866,17 @@ static void display_ref_update(struct display_state *=
display_state, char code,
=20
 		break;
 	}
+	case DISPLAY_FORMAT_PORCELAIN:
+		strbuf_addf(&display_state->buf, "%c %s %s %s", code,
+			    oid_to_hex(old_oid), oid_to_hex(new_oid), local);
+		f =3D stdout;
+		break;
 	default:
 		BUG("unexpected display format %d", display_state->format);
 	};
 	strbuf_addch(&display_state->buf, '\n');
=20
-	fputs(display_state->buf.buf, stderr);
+	fputs(display_state->buf.buf, f);
 }
=20
 static int update_local_ref(struct ref *ref,
@@ -881,7 +894,8 @@ static int update_local_ref(struct ref *ref,
 	if (oideq(&ref->old_oid, &ref->new_oid)) {
 		if (verbosity > 0)
 			display_ref_update(display_state, '=3D', _("[up to date]"), NULL,
-					   remote_ref->name, ref->name, summary_width);
+					   remote_ref->name, ref->name,
+					   &ref->old_oid, &ref->new_oid, summary_width);
 		return 0;
 	}
=20
@@ -894,7 +908,8 @@ static int update_local_ref(struct ref *ref,
 		 */
 		display_ref_update(display_state, '!', _("[rejected]"),
 				   _("can't fetch into checked-out branch"),
-				   remote_ref->name, ref->name, summary_width);
+				   remote_ref->name, ref->name,
+				   &ref->old_oid, &ref->new_oid, summary_width);
 		return 1;
 	}
=20
@@ -905,12 +920,14 @@ static int update_local_ref(struct ref *ref,
 			r =3D s_update_ref("updating tag", ref, transaction, 0);
 			display_ref_update(display_state, r ? '!' : 't', _("[tag update]"),
 					   r ? _("unable to update local ref") : NULL,
-					   remote_ref->name, ref->name, summary_width);
+					   remote_ref->name, ref->name,
+					   &ref->old_oid, &ref->new_oid, summary_width);
 			return r;
 		} else {
 			display_ref_update(display_state, '!', _("[rejected]"),
 					   _("would clobber existing tag"),
-					   remote_ref->name, ref->name, summary_width);
+					   remote_ref->name, ref->name,
+					   &ref->old_oid, &ref->new_oid, summary_width);
 			return 1;
 		}
 	}
@@ -943,7 +960,8 @@ static int update_local_ref(struct ref *ref,
 		r =3D s_update_ref(msg, ref, transaction, 0);
 		display_ref_update(display_state, r ? '!' : '*', what,
 				   r ? _("unable to update local ref") : NULL,
-				   remote_ref->name, ref->name, summary_width);
+				   remote_ref->name, ref->name,
+				   &ref->old_oid, &ref->new_oid, summary_width);
 		return r;
 	}
=20
@@ -965,7 +983,8 @@ static int update_local_ref(struct ref *ref,
 		r =3D s_update_ref("fast-forward", ref, transaction, 1);
 		display_ref_update(display_state, r ? '!' : ' ', quickref.buf,
 				   r ? _("unable to update local ref") : NULL,
-				   remote_ref->name, ref->name, summary_width);
+				   remote_ref->name, ref->name,
+				   &ref->old_oid, &ref->new_oid, summary_width);
 		strbuf_release(&quickref);
 		return r;
 	} else if (force || ref->force) {
@@ -977,12 +996,14 @@ static int update_local_ref(struct ref *ref,
 		r =3D s_update_ref("forced-update", ref, transaction, 1);
 		display_ref_update(display_state, r ? '!' : '+', quickref.buf,
 				   r ? _("unable to update local ref") : _("forced update"),
-				   remote_ref->name, ref->name, summary_width);
+				   remote_ref->name, ref->name,
+				   &ref->old_oid, &ref->new_oid, summary_width);
 		strbuf_release(&quickref);
 		return r;
 	} else {
 		display_ref_update(display_state, '!', _("[rejected]"), _("non-fast-forw=
ard"),
-				   remote_ref->name, ref->name, summary_width);
+				   remote_ref->name, ref->name,
+				   &ref->old_oid, &ref->new_oid, summary_width);
 		return 1;
 	}
 }
@@ -1223,7 +1244,9 @@ static int store_updated_refs(struct display_state *d=
isplay_state,
 				display_ref_update(display_state, '*',
 						   *kind ? kind : "branch", NULL,
 						   rm->name,
-						   "FETCH_HEAD", summary_width);
+						   "FETCH_HEAD",
+						   &rm->new_oid, &rm->old_oid,
+						   summary_width);
 			}
 		}
 	}
@@ -1363,6 +1386,7 @@ static int prune_refs(struct display_state *display_s=
tate,
 		for (ref =3D stale_refs; ref; ref =3D ref->next) {
 			display_ref_update(display_state, '-', _("[deleted]"), NULL,
 					   _("(none)"), ref->name,
+					   &ref->new_oid, &ref->old_oid,
 					   summary_width);
 			warn_dangling_symref(stderr, dangling_msg, ref->name);
 		}
@@ -1795,7 +1819,8 @@ static int add_remote_or_group(const char *name, stru=
ct string_list *list)
 	return 1;
 }
=20
-static void add_options_to_argv(struct strvec *argv)
+static void add_options_to_argv(struct strvec *argv,
+				enum display_format format)
 {
 	if (dry_run)
 		strvec_push(argv, "--dry-run");
@@ -1831,6 +1856,8 @@ static void add_options_to_argv(struct strvec *argv)
 		strvec_push(argv, "--ipv6");
 	if (!write_fetch_head)
 		strvec_push(argv, "--no-write-fetch-head");
+	if (format =3D=3D DISPLAY_FORMAT_PORCELAIN)
+		strvec_pushf(argv, "--porcelain");
 }
=20
 /* Fetch multiple remotes in parallel */
@@ -1839,6 +1866,7 @@ struct parallel_fetch_state {
 	const char **argv;
 	struct string_list *remotes;
 	int next, result;
+	enum display_format format;
 };
=20
 static int fetch_next_remote(struct child_process *cp,
@@ -1858,7 +1886,7 @@ static int fetch_next_remote(struct child_process *cp,
 	strvec_push(&cp->args, remote);
 	cp->git_cmd =3D 1;
=20
-	if (verbosity >=3D 0)
+	if (verbosity >=3D 0 && state->format !=3D DISPLAY_FORMAT_PORCELAIN)
 		printf(_("Fetching %s\n"), remote);
=20
 	return 1;
@@ -1890,7 +1918,8 @@ static int fetch_finished(int result, struct strbuf *=
out,
 	return 0;
 }
=20
-static int fetch_multiple(struct string_list *list, int max_children)
+static int fetch_multiple(struct string_list *list, int max_children,
+			  enum display_format format)
 {
 	int i, result =3D 0;
 	struct strvec argv =3D STRVEC_INIT;
@@ -1903,10 +1932,10 @@ static int fetch_multiple(struct string_list *list,=
 int max_children)
=20
 	strvec_pushl(&argv, "fetch", "--append", "--no-auto-gc",
 		     "--no-write-commit-graph", NULL);
-	add_options_to_argv(&argv);
+	add_options_to_argv(&argv, format);
=20
 	if (max_children !=3D 1 && list->nr !=3D 1) {
-		struct parallel_fetch_state state =3D { argv.v, list, 0, 0 };
+		struct parallel_fetch_state state =3D { argv.v, list, 0, 0, format };
 		const struct run_process_parallel_opts opts =3D {
 			.tr2_category =3D "fetch",
 			.tr2_label =3D "parallel/fetch",
@@ -1930,7 +1959,7 @@ static int fetch_multiple(struct string_list *list, i=
nt max_children)
=20
 			strvec_pushv(&cmd.args, argv.v);
 			strvec_push(&cmd.args, name);
-			if (verbosity >=3D 0)
+			if (verbosity >=3D 0 && format !=3D DISPLAY_FORMAT_PORCELAIN)
 				printf(_("Fetching %s\n"), name);
 			cmd.git_cmd =3D 1;
 			if (run_command(&cmd)) {
@@ -2081,6 +2110,7 @@ int cmd_fetch(int argc, const char **argv, const char=
 *prefix)
 	int fetch_write_commit_graph =3D -1;
 	int stdin_refspecs =3D 0;
 	int negotiate_only =3D 0;
+	int porcelain =3D 0;
 	int i;
=20
 	struct option builtin_fetch_options[] =3D {
@@ -2115,6 +2145,7 @@ int cmd_fetch(int argc, const char **argv, const char=
 *prefix)
 			    PARSE_OPT_OPTARG, option_fetch_parse_recurse_submodules),
 		OPT_BOOL(0, "dry-run", &dry_run,
 			 N_("dry run")),
+		OPT_BOOL(0, "porcelain", &porcelain, N_("machine-readable output")),
 		OPT_BOOL(0, "write-fetch-head", &write_fetch_head,
 			 N_("write fetched references to the FETCH_HEAD file")),
 		OPT_BOOL('k', "keep", &keep, N_("keep downloaded pack")),
@@ -2220,6 +2251,26 @@ int cmd_fetch(int argc, const char **argv, const cha=
r *prefix)
 		fetch_config_from_gitmodules(sfjc, rs);
 	}
=20
+
+	if (porcelain) {
+		switch (recurse_submodules_cli) {
+		case RECURSE_SUBMODULES_OFF:
+		case RECURSE_SUBMODULES_DEFAULT:
+			/*
+			 * Reference updates in submodules would be ambiguous
+			 * in porcelain mode, so we reject this combination.
+			 */
+			recurse_submodules =3D RECURSE_SUBMODULES_OFF;
+			break;
+
+		default:
+			die(_("options '%s' and '%s' cannot be used together"),
+			    "--porcelain", "--recurse-submodules");
+		}
+
+		config.display_format =3D DISPLAY_FORMAT_PORCELAIN;
+	}
+
 	if (negotiate_only && !negotiation_tip.nr)
 		die(_("--negotiate-only needs one or more --negotiation-tip=3D*"));
=20
@@ -2339,10 +2390,9 @@ int cmd_fetch(int argc, const char **argv, const cha=
r *prefix)
 			max_children =3D fetch_parallel_config;
=20
 		/* TODO should this also die if we have a previous partial-clone? */
-		result =3D fetch_multiple(&list, max_children);
+		result =3D fetch_multiple(&list, max_children, config.display_format);
 	}
=20
-
 	/*
 	 * This is only needed after fetch_one(), which does not fetch
 	 * submodules by itself.
@@ -2361,7 +2411,7 @@ int cmd_fetch(int argc, const char **argv, const char=
 *prefix)
 		if (max_children < 0)
 			max_children =3D fetch_parallel_config;
=20
-		add_options_to_argv(&options);
+		add_options_to_argv(&options, config.display_format);
 		result =3D fetch_submodules(the_repository,
 					  &options,
 					  submodule_prefix,
diff --git a/t/t5574-fetch-output.sh b/t/t5574-fetch-output.sh
index 9890f6f381..90e6dcb9a7 100755
--- a/t/t5574-fetch-output.sh
+++ b/t/t5574-fetch-output.sh
@@ -61,6 +61,141 @@ test_expect_success 'fetch compact output' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'fetch porcelain output' '
+	test_when_finished "rm -rf porcelain" &&
+
+	# Set up a bunch of references that we can use to demonstrate different
+	# kinds of flag symbols in the output format.
+	MAIN_OLD=3D$(git rev-parse HEAD) &&
+	git branch "fast-forward" &&
+	git branch "deleted-branch" &&
+	git checkout -b force-updated &&
+	test_commit --no-tag force-update-old &&
+	FORCE_UPDATED_OLD=3D$(git rev-parse HEAD) &&
+	git checkout main &&
+
+	# Clone and pre-seed the repositories. We fetch references into two
+	# namespaces so that we can test that rejected and force-updated
+	# references are reported properly.
+	refspecs=3D"refs/heads/*:refs/unforced/* +refs/heads/*:refs/forced/*" &&
+	git clone . porcelain &&
+	git -C porcelain fetch origin $refspecs &&
+
+	# Now that we have set up the client repositories we can change our
+	# local references.
+	git branch new-branch &&
+	git branch -d deleted-branch &&
+	git checkout fast-forward &&
+	test_commit --no-tag fast-forward-new &&
+	FAST_FORWARD_NEW=3D$(git rev-parse HEAD) &&
+	git checkout force-updated &&
+	git reset --hard HEAD~ &&
+	test_commit --no-tag force-update-new &&
+	FORCE_UPDATED_NEW=3D$(git rev-parse HEAD) &&
+
+	cat >expect <<-EOF &&
+	- $MAIN_OLD $ZERO_OID refs/forced/deleted-branch
+	- $MAIN_OLD $ZERO_OID refs/unforced/deleted-branch
+	  $MAIN_OLD $FAST_FORWARD_NEW refs/unforced/fast-forward
+	! $FORCE_UPDATED_OLD $FORCE_UPDATED_NEW refs/unforced/force-updated
+	* $ZERO_OID $MAIN_OLD refs/unforced/new-branch
+	  $MAIN_OLD $FAST_FORWARD_NEW refs/forced/fast-forward
+	+ $FORCE_UPDATED_OLD $FORCE_UPDATED_NEW refs/forced/force-updated
+	* $ZERO_OID $MAIN_OLD refs/forced/new-branch
+	  $MAIN_OLD $FAST_FORWARD_NEW refs/remotes/origin/fast-forward
+	+ $FORCE_UPDATED_OLD $FORCE_UPDATED_NEW refs/remotes/origin/force-updated
+	* $ZERO_OID $MAIN_OLD refs/remotes/origin/new-branch
+	EOF
+
+	# Execute a dry-run fetch first. We do this to assert that the dry-run
+	# and non-dry-run fetches produces the same output. Execution of the
+	# fetch is expected to fail as we have a rejected reference update.
+	test_must_fail git -C porcelain fetch \
+		--porcelain --dry-run --prune origin $refspecs >actual &&
+	test_cmp expect actual &&
+
+	# And now we perform a non-dry-run fetch.
+	test_must_fail git -C porcelain fetch \
+		--porcelain --prune origin $refspecs >actual 2>stderr &&
+	test_cmp expect actual &&
+	test_must_be_empty stderr
+'
+
+test_expect_success 'fetch porcelain with multiple remotes' '
+	test_when_finished "rm -rf porcelain" &&
+
+	git switch --create multiple-remotes &&
+	git clone . porcelain &&
+	git -C porcelain remote add second-remote "$PWD" &&
+	git -C porcelain fetch second-remote &&
+
+	test_commit --no-tag multi-commit &&
+	old_commit=3D$(git rev-parse HEAD~) &&
+	new_commit=3D$(git rev-parse HEAD) &&
+
+	cat >expect <<-EOF &&
+	  $old_commit $new_commit refs/remotes/origin/multiple-remotes
+	  $old_commit $new_commit refs/remotes/second-remote/multiple-remotes
+	EOF
+
+	git -C porcelain fetch --porcelain --all >actual 2>stderr &&
+	test_cmp expect actual &&
+	test_must_be_empty stderr
+'
+
+test_expect_success 'fetch porcelain refuses to work with submodules' '
+	test_when_finished "rm -rf porcelain" &&
+
+	cat >expect <<-EOF &&
+	fatal: options ${SQ}--porcelain${SQ} and ${SQ}--recurse-submodules${SQ} c=
annot be used together
+	EOF
+
+	git init porcelain &&
+	test_must_fail git -C porcelain fetch --porcelain --recurse-submodules=3D=
yes 2>stderr &&
+	test_cmp expect stderr &&
+
+	test_must_fail git -C porcelain fetch --porcelain --recurse-submodules=3D=
on-demand 2>stderr &&
+	test_cmp expect stderr
+'
+
+test_expect_success 'fetch porcelain overrides fetch.output config' '
+	test_when_finished "rm -rf porcelain" &&
+
+	git switch --create config-override &&
+	git clone . porcelain &&
+	test_commit new-commit &&
+	old_commit=3D$(git rev-parse HEAD~) &&
+	new_commit=3D$(git rev-parse HEAD) &&
+
+	cat >expect <<-EOF &&
+	  $old_commit $new_commit refs/remotes/origin/config-override
+	* $ZERO_OID $new_commit refs/tags/new-commit
+	EOF
+
+	git -C porcelain -c fetch.output=3Dcompact fetch --porcelain >stdout 2>st=
derr &&
+	test_must_be_empty stderr &&
+	test_cmp expect stdout
+'
+
+test_expect_success 'fetch --no-porcelain overrides previous --porcelain' '
+	test_when_finished "rm -rf no-porcelain" &&
+
+	git switch --create no-porcelain &&
+	git clone . no-porcelain &&
+	test_commit --no-tag no-porcelain &&
+	old_commit=3D$(git rev-parse --short HEAD~) &&
+	new_commit=3D$(git rev-parse --short HEAD) &&
+
+	cat >expect <<-EOF &&
+	From $(test-tool path-utils real_path .)/.
+	   $old_commit..$new_commit  no-porcelain -> origin/no-porcelain
+	EOF
+
+	git -C no-porcelain fetch --porcelain --no-porcelain >stdout 2>stderr &&
+	test_cmp expect stderr &&
+	test_must_be_empty stdout
+'
+
 test_expect_success 'fetch output with HEAD' '
 	test_when_finished "rm -rf head" &&
 	git clone . head &&
@@ -90,6 +225,30 @@ test_expect_success 'fetch output with HEAD' '
 	test_cmp expect actual.err
 '
=20
+test_expect_success 'fetch porcelain output with HEAD' '
+	test_when_finished "rm -rf head" &&
+	git clone . head &&
+	COMMIT_ID=3D$(git rev-parse HEAD) &&
+
+	git -C head fetch --porcelain --dry-run origin HEAD >actual &&
+	cat >expect <<-EOF &&
+	* $ZERO_OID $COMMIT_ID FETCH_HEAD
+	EOF
+	test_cmp expect actual &&
+
+	git -C head fetch --porcelain origin HEAD >actual &&
+	test_cmp expect actual &&
+
+	git -C head fetch --porcelain --dry-run origin HEAD:foo >actual &&
+	cat >expect <<-EOF &&
+	* $ZERO_OID $COMMIT_ID refs/heads/foo
+	EOF
+	test_cmp expect actual &&
+
+	git -C head fetch --porcelain origin HEAD:foo >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'fetch output with object ID' '
 	test_when_finished "rm -rf object-id" &&
 	git clone . object-id &&
--=20
2.40.1


--s7cNegqV08IN7d/H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRbj1wACgkQVbJhu7ck
PpTiQw/3SfLPZp1DP3sxM53Eh9Mb71U5xqdyPF6RwYjGmi1UBftMC6IJHXeo5hPz
ge6SHxA9a/6hcqRhYODKQiRbmgzYbdY4/YvCzB2y7Sjhrv8g+LdErLCLqGyBn+uy
3qXjhnO7kQq03CD+THyztwZOzWc7tTjnFf01TGQPM7AadMhLyNFTghlnD7VszVX2
Grg5VdO654C2F9vxGYpKg+to1ayvzUaWIn/TALRF7wil3Ay0sO8lXY14qPLUrsxC
EZJKjj9tE4GsFZPlDWV9mxg7hXOh0CY8O7bXyvX+DZ8SUmfc0j8WhmGWM/9EJnEn
zuUkPMfmQcoRov+AKReLjkJIvCVtyNcfT0cZvjOFxAlu60oSWAKTXEnlrPulkJ9N
3EdHKRIA5dgKrFWzbyPhVAJjc3e/DqsvhgZIJkW7gl21NPvQ+GBF1hyfyKhRVwuO
BxbkCf7daki6GLSgjg3blJtJ6/jJM8/IewAOyoQp6RE8MUtSz+kXcCFhQO4f2ys9
aCTTJeIBQ9VosC2IwTB3FYiJfRsGntam1HzwBTnD4LlbEmed+8HQQTdWkWbavwoI
P7G5teMCbMcPMAKy1oeFSKlLyIMq20S03oJVXSWQPHEXGLmSd8I6ePAad5ne7wef
ep+Cfjp0VgOgdaZBViegIvvFWG85Aj61YQ+7hW8D5/w7XwAaTA==
=18T2
-----END PGP SIGNATURE-----

--s7cNegqV08IN7d/H--
