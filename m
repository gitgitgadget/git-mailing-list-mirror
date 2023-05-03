Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A308CC7EE22
	for <git@archiver.kernel.org>; Wed,  3 May 2023 11:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjECLf4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 07:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjECLfh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 07:35:37 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DC25FCB
        for <git@vger.kernel.org>; Wed,  3 May 2023 04:35:12 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 7ACD15C0099;
        Wed,  3 May 2023 07:34:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 03 May 2023 07:34:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683113692; x=1683200092; bh=3Y
        jDYvLU9XfE8G6EKmz34/nv3k4HAre9mb8g1S4TjMM=; b=aHKzkt9W7JvwXEAaAK
        WNZpAyL9DJtSJ0hu5xG+5nTzBabrx85OVL2T7Kph7lj5fun851PJV+ZPZU/2EKbj
        BDUYps8MoWZCjxwik8ncuzOkQJQA0IGS+8B6MSTuewZYBXDplhJ/BmI28NHUuaF5
        UU/9btKEjJ8s42KCe351DWkQttcjr7vl1vt3OUaJPAnNdxJGApz7lGZajz+nqgte
        Rd4T4wHnjW6mPXhutwenrRKo4/eSAqxxktx9eIa8IV02qWb5DFpHlveUUdqWzRee
        T3l7rcdcFkDm3p5xe7TjwqcIl/yiw+amocg8i8A0OojLZ3ndrPZPH6Wm75rjOV3y
        ARfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683113692; x=1683200092; bh=3YjDYvLU9XfE8
        G6EKmz34/nv3k4HAre9mb8g1S4TjMM=; b=CvpP7qZw/Z34aZIq0tKGR68Z+RbpB
        NdSOKdzmHWU8CxmZWksJsFhYjf1e6AJlOkDLafeUpOKF1HCVN//VdM0i1boZN9wP
        xWO7hKQPYwRm4XrBjubQYL5/zIPm9xo/3SHfMBY2emtSzHQgyLeNuVc7zKIDH1lO
        7d+crLHt/F7Nvk9YINav4zNHE02oixk/g4fpd6OJUaxTFcl/DsNOqnsXjUVylB+2
        HY7HZ0A7Fwmmap9OWtCW0b0j6TVeV0tPo7J7l9BSkKggQJt58Xq+Yp4UxrVINxk8
        KhyXdTztNPvFmasq6VvAhDpeAkFowDxfm04HR//aGc2PUZccvPt+PMYCA==
X-ME-Sender: <xms:3EZSZMxcuAJUu3f00JPygqtvgPKwWdpN2DBxLHNr_t5wY4btAToF-A>
    <xme:3EZSZATn5IeAN8p4ESsdrA7Wbq9rVcu11QAKF76xzIKHmAumqU83AWD4RJmC1qrmf
    GV4iAtYs8hKYeos2Q>
X-ME-Received: <xmr:3EZSZOVMFOsjtPLZQ2SlPZ_z_9r1YDle0GCDgMmHBuaMOaccZtq6vySK5Z-4Ah1UPCCdzMuXjsQAyjQPkqiRX7pJ_HFub8MyxMoDQjywYguk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvkedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:3EZSZKjnuRJz--DixTlIlBIFwPef-vOJG2ytqgKLoUE2fzTioBoymg>
    <xmx:3EZSZOBWbHpEZ0VvsRvpBNAu9FAOQRbXvaaNNpk6E4ZpZPHZ1DeNRQ>
    <xmx:3EZSZLLZlE2sUyhYqeDmVlTsmsbrHGGp4R-_iLoWBrTtwzybvH8l9w>
    <xmx:3EZSZB83dz-SBjIL2yjcCHNQqYzkPcsj0SWZ1gqtKK8x38oC_O6oEg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 May 2023 07:34:50 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 74e086f3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 3 May 2023 11:34:09 +0000 (UTC)
Date:   Wed, 3 May 2023 13:34:48 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v3 8/8] fetch: introduce machine-parseable "porcelain" output
 format
Message-ID: <e132d9494ee7d8c4eb3a7a82b6420743c8c7a9b0.1683113177.git.ps@pks.im>
References: <cover.1681906948.git.ps@pks.im>
 <cover.1683113177.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6WRLm5FQmsdA8nYe"
Content-Disposition: inline
In-Reply-To: <cover.1683113177.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--6WRLm5FQmsdA8nYe
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

Considering that both multi-remote and submodule fetches are rather
niche and likely not going to be useful for the majority of usecases
these omissions feel acceptable. If usecases for either of these come up
in the future though it is easy enough to add a new "porcelain-v2"
format that adds this information.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/fetch-options.txt |   6 ++
 Documentation/git-fetch.txt     |   9 +++
 builtin/fetch.c                 |  91 +++++++++++++++++++-----
 t/t5574-fetch-output.sh         | 120 ++++++++++++++++++++++++++++++++
 4 files changed, 208 insertions(+), 18 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.=
txt
index 622bd84768..02a5ae21ef 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -78,6 +78,12 @@ linkgit:git-config[1].
 --dry-run::
 	Show what would be done, without making any changes.
=20
+--porcelain::
+	Print the output to standard output in an easy-to-parse format for
+	scripts. See section OUTPUT in linkgit:git-fetch[1] for details.
++
+This is incompatible with `--recurse-submodules=3D[yes|on-demand]`.
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
index 820ec7285c..187c4d373c 100644
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
@@ -745,6 +746,9 @@ static void display_state_init(struct display_state *di=
splay_state, struct ref *
=20
 		break;
 	}
+	case DISPLAY_FORMAT_PORCELAIN:
+		/* We don't need to precompute anything here. */
+		break;
 	default:
 		BUG("unexpected display format %d", display_state->format);
 	}
@@ -815,8 +819,12 @@ static void print_compact(struct display_state *displa=
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
@@ -849,12 +857,17 @@ static void display_ref_update(struct display_state *=
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
@@ -872,7 +885,8 @@ static int update_local_ref(struct ref *ref,
 	if (oideq(&ref->old_oid, &ref->new_oid)) {
 		if (verbosity > 0)
 			display_ref_update(display_state, '=3D', _("[up to date]"), NULL,
-					   remote_ref->name, ref->name, summary_width);
+					   remote_ref->name, ref->name,
+					   &ref->old_oid, &ref->new_oid, summary_width);
 		return 0;
 	}
=20
@@ -885,7 +899,8 @@ static int update_local_ref(struct ref *ref,
 		 */
 		display_ref_update(display_state, '!', _("[rejected]"),
 				   _("can't fetch into checked-out branch"),
-				   remote_ref->name, ref->name, summary_width);
+				   remote_ref->name, ref->name,
+				   &ref->old_oid, &ref->new_oid, summary_width);
 		return 1;
 	}
=20
@@ -896,12 +911,14 @@ static int update_local_ref(struct ref *ref,
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
@@ -934,7 +951,8 @@ static int update_local_ref(struct ref *ref,
 		r =3D s_update_ref(msg, ref, transaction, 0);
 		display_ref_update(display_state, r ? '!' : '*', what,
 				   r ? _("unable to update local ref") : NULL,
-				   remote_ref->name, ref->name, summary_width);
+				   remote_ref->name, ref->name,
+				   &ref->old_oid, &ref->new_oid, summary_width);
 		return r;
 	}
=20
@@ -956,7 +974,8 @@ static int update_local_ref(struct ref *ref,
 		r =3D s_update_ref("fast-forward", ref, transaction, 1);
 		display_ref_update(display_state, r ? '!' : ' ', quickref.buf,
 				   r ? _("unable to update local ref") : NULL,
-				   remote_ref->name, ref->name, summary_width);
+				   remote_ref->name, ref->name,
+				   &ref->old_oid, &ref->new_oid, summary_width);
 		strbuf_release(&quickref);
 		return r;
 	} else if (force || ref->force) {
@@ -968,12 +987,14 @@ static int update_local_ref(struct ref *ref,
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
@@ -1214,7 +1235,9 @@ static int store_updated_refs(struct display_state *d=
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
@@ -1354,6 +1377,7 @@ static int prune_refs(struct display_state *display_s=
tate,
 		for (ref =3D stale_refs; ref; ref =3D ref->next) {
 			display_ref_update(display_state, '-', _("[deleted]"), NULL,
 					   _("(none)"), ref->name,
+					   &ref->new_oid, &ref->old_oid,
 					   summary_width);
 			warn_dangling_symref(stderr, dangling_msg, ref->name);
 		}
@@ -1786,7 +1810,8 @@ static int add_remote_or_group(const char *name, stru=
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
@@ -1822,6 +1847,8 @@ static void add_options_to_argv(struct strvec *argv)
 		strvec_push(argv, "--ipv6");
 	if (!write_fetch_head)
 		strvec_push(argv, "--no-write-fetch-head");
+	if (format =3D=3D DISPLAY_FORMAT_PORCELAIN)
+		strvec_pushf(argv, "--porcelain");
 }
=20
 /* Fetch multiple remotes in parallel */
@@ -1830,6 +1857,7 @@ struct parallel_fetch_state {
 	const char **argv;
 	struct string_list *remotes;
 	int next, result;
+	enum display_format format;
 };
=20
 static int fetch_next_remote(struct child_process *cp,
@@ -1849,7 +1877,7 @@ static int fetch_next_remote(struct child_process *cp,
 	strvec_push(&cp->args, remote);
 	cp->git_cmd =3D 1;
=20
-	if (verbosity >=3D 0)
+	if (verbosity >=3D 0 && state->format !=3D DISPLAY_FORMAT_PORCELAIN)
 		printf(_("Fetching %s\n"), remote);
=20
 	return 1;
@@ -1881,7 +1909,8 @@ static int fetch_finished(int result, struct strbuf *=
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
@@ -1894,10 +1923,10 @@ static int fetch_multiple(struct string_list *list,=
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
@@ -1921,7 +1950,7 @@ static int fetch_multiple(struct string_list *list, i=
nt max_children)
=20
 			strvec_pushv(&cmd.args, argv.v);
 			strvec_push(&cmd.args, name);
-			if (verbosity >=3D 0)
+			if (verbosity >=3D 0 && format !=3D DISPLAY_FORMAT_PORCELAIN)
 				printf(_("Fetching %s\n"), name);
 			cmd.git_cmd =3D 1;
 			if (run_command(&cmd)) {
@@ -2052,6 +2081,13 @@ static int fetch_one(struct remote *remote, int argc=
, const char **argv,
 	return exit_code;
 }
=20
+static int opt_parse_porcelain(const struct option *opt, const char *arg, =
int unset)
+{
+	enum display_format *format =3D opt->value;
+	*format =3D DISPLAY_FORMAT_PORCELAIN;
+	return 0;
+}
+
 int cmd_fetch(int argc, const char **argv, const char *prefix)
 {
 	const char *bundle_uri;
@@ -2104,6 +2140,8 @@ int cmd_fetch(int argc, const char **argv, const char=
 *prefix)
 			    PARSE_OPT_OPTARG, option_fetch_parse_recurse_submodules),
 		OPT_BOOL(0, "dry-run", &dry_run,
 			 N_("dry run")),
+		OPT_CALLBACK_F(0, "porcelain", &display_format, NULL, N_("machine-readab=
le output"),
+			       PARSE_OPT_NOARG|PARSE_OPT_NONEG, opt_parse_porcelain),
 		OPT_BOOL(0, "write-fetch-head", &write_fetch_head,
 			 N_("write fetched references to the FETCH_HEAD file")),
 		OPT_BOOL('k', "keep", &keep, N_("keep downloaded pack")),
@@ -2222,6 +2260,23 @@ int cmd_fetch(int argc, const char **argv, const cha=
r *prefix)
 		fetch_config_from_gitmodules(sfjc, rs);
 	}
=20
+	if (display_format =3D=3D DISPLAY_FORMAT_PORCELAIN) {
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
+	}
+
 	if (negotiate_only && !negotiation_tip.nr)
 		die(_("--negotiate-only needs one or more --negotiation-tip=3D*"));
=20
@@ -2341,7 +2396,7 @@ int cmd_fetch(int argc, const char **argv, const char=
 *prefix)
 			max_children =3D fetch_parallel_config;
=20
 		/* TODO should this also die if we have a previous partial-clone? */
-		result =3D fetch_multiple(&list, max_children);
+		result =3D fetch_multiple(&list, max_children, display_format);
 	}
=20
=20
@@ -2363,7 +2418,7 @@ int cmd_fetch(int argc, const char **argv, const char=
 *prefix)
 		if (max_children < 0)
 			max_children =3D fetch_parallel_config;
=20
-		add_options_to_argv(&options);
+		add_options_to_argv(&options, display_format);
 		result =3D fetch_submodules(the_repository,
 					  &options,
 					  submodule_prefix,
diff --git a/t/t5574-fetch-output.sh b/t/t5574-fetch-output.sh
index 6e0f7e0046..18949e9323 100755
--- a/t/t5574-fetch-output.sh
+++ b/t/t5574-fetch-output.sh
@@ -56,6 +56,102 @@ test_expect_success 'fetch compact output' '
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
+	git clone . porcelain &&
+	git -C porcelain remote add second-remote "$PWD" &&
+	git -C porcelain fetch second-remote &&
+
+	test_commit --no-tag multi-commit &&
+	old_commit=3D$(git rev-parse HEAD~) &&
+	new_commit=3D$(git rev-parse HEAD) &&
+
+	cat >expect <<-EOF &&
+	  $old_commit $new_commit refs/remotes/origin/force-updated
+	  $old_commit $new_commit refs/remotes/second-remote/force-updated
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
 test_expect_success 'fetch output with HEAD' '
 	test_when_finished "rm -rf head" &&
 	git clone . head &&
@@ -85,6 +181,30 @@ test_expect_success 'fetch output with HEAD' '
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
 test_expect_success '--no-show-forced-updates' '
 	mkdir forced-updates &&
 	(
--=20
2.40.1


--6WRLm5FQmsdA8nYe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRSRtgACgkQVbJhu7ck
PpQFpA/9HXJfcWIO9X5H8EuVO9nXEqF51oFdjsCoYqy5MQNn8Wi1Y4zYk9W8c1cS
VChjDhPWJj0zHg7fiNPpSqSJeuaDAqcsD8Wrv5HVwINjbtvVgkhrF/a1jZ7RpCMH
yHB/4CcaFf1p/tNMQn4pxHG1NTTqAP8JLTB96DIlWjSTTCtlllsQxU24M5SI7fQr
NAKNqnCOScvp90Ey5Yeyd7AqZIwUDh/TcvUoM77cCIUZZpYw0GI8952NBiR3mLkM
y9qr0TcAHqGb1fYtcQFHjyP4tv11C52Py/hMRc83SNcr2UuWeHzCr704vZazIS7u
x2lGTTdgyF2UPEdVCMU512gri5H6ogRFswAt6sJOGtsoBoSOkfhsjVZdCIMIN4uR
5xViGvlHEnxpVFYdHDNodF6Sr2o5Jboxbgy0FekyUb3/fybv+KbMfuDki6vlFcpt
a2xNmew1VCUc7OoaKwPw/lWwcJNSwD8QhMYXHeClmAiFaZrMmS55IVVQzh5Vdhev
7KVDCEc33RSi4HNwl2xI5UuQjhFYz5xwP2p2qSaWfS5n4VQ0DCm5+NPgAqE0to+v
KhAZy6mKiwlvi0GQufn/Xw8Wsxvkm/I/k/Air6dADLdCPCwfaKEbotZ5gRxEjE1T
PbpqvFbFHUC8aU3Y/wX2o/j5DRBofCRs6d/GzNY7HsjAGUyH1BI=
=fAxU
-----END PGP SIGNATURE-----

--6WRLm5FQmsdA8nYe--
