Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB190C7EE22
	for <git@archiver.kernel.org>; Tue,  9 May 2023 13:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235539AbjEINDA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 09:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235383AbjEINCl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 09:02:41 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2196055BB
        for <git@vger.kernel.org>; Tue,  9 May 2023 06:02:37 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 87B6A5C0081;
        Tue,  9 May 2023 09:02:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 09 May 2023 09:02:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683637356; x=1683723756; bh=lW
        19jmNNERQlNNQMW37EXxLel77qNqsNjWDeh7lh2x4=; b=pPzwS2nXXuZTFaqR0o
        w6LnHzBJMlNQ4GfwY1eAgqQEjFPBV6IdEmXYKVZFdbhizHbqH+srqpvPdSoRkNEG
        EMMhG+/OHZ1FY0pIhlp6bDoylgbPHc9eQqARjIu/vOYJ7eBOGYri0ws28b3G8XH2
        YE7ct96ye2MIH8AbrS/Rx/rGpeAeaM2ka15sD3yitY5sBOSoQ+6Cmc4VvMSrrJfe
        caK+FGQ6Em0q+82y0XizdfxjmrhumMivBh+u++gNka/g5qZUHoxslhChS84xRYpU
        twwLau4NgGY0V9uoEkxRNjaCdX5k3vTPLjMbXXw67aK8iGpYBYoWTGQ4KZChYOKS
        ng+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683637356; x=1683723756; bh=lW19jmNNERQlN
        NQMW37EXxLel77qNqsNjWDeh7lh2x4=; b=Tsq09tDWYEpTcUDQ4YZplun4TK1mh
        BAcr74rh7jUBh6fdZQQhOS4NBUbeS1PYqDIYx/4Fuxhy+iNqGJlZRdnpxSMIc38Q
        Kp/US9iFW6D4YY6+bKi4mstLkLxLkM5qRBFIQHBjLEsdV2yTC9mSWr0iQBc74W7l
        bka0Rqc+APQ8OfyrEabxFQKtwUhXmAnIDoWyYSNtxaq4Z2ZewkU1Of2HufaIelSb
        H+bB7OkexN5+LpASRVQb+Q6gh2BQX3K6YW5tFH0jiheBwrbWtmEtuW3gaNU662MT
        bOXoEo8z6BOQmFUnt2dli4MYc8bugOkhNMUMPdmK0KMTxQ8gJM0UWlgNg==
X-ME-Sender: <xms:bERaZPO6Go0lZf6y882BE9E8qtGOl7F5KcYvnfPQPfQ_noQSNOdl8A>
    <xme:bERaZJ8HUnJ1t3bWYcyy-cWeFkFkWRMTyHZQw0xLMlnk4Y7tlGOnnVoU7j5C1cRwr
    7MEEdOq2ZhATMfizw>
X-ME-Received: <xmr:bERaZORwuj_bls5RVKV845mAssDDReuw-mvuIGfvcYFrK5aQagRix-O3JOfJ43b2LZzwbFYyzE5Ka7LedUYDak6CPVk6cHhN0LB1xQEDlXs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegtddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:bERaZDtV4rLoFPn_usnAxgD1QgkLYwzlBKsTT0VHV4k7Tz9ccPfaCw>
    <xmx:bERaZHcQmXusxfOGD9qjeLCVMPcx9XBiIH3u9TClMiuqk2s5x9jN3w>
    <xmx:bERaZP2IkQUbPM1EX4vmdk9w8HWfbVSGb12jhxu14gpoIKno1MXuCQ>
    <xmx:bERaZO5KSxgInwqtOo9Dv4DLsBBEX15i3in6-KqVd-SUZDZoUa4qnA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 May 2023 09:02:34 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 0cbf3b2c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 9 May 2023 13:02:27 +0000 (UTC)
Date:   Tue, 9 May 2023 15:02:33 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v4 8/8] fetch: introduce machine-parseable "porcelain" output
 format
Message-ID: <24ae381950249fd5c1cd799b75dda1407495d9d4.1683636885.git.ps@pks.im>
References: <cover.1681906948.git.ps@pks.im>
 <cover.1683636885.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aodgVKBT+xdkz6LK"
Content-Disposition: inline
In-Reply-To: <cover.1683636885.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--aodgVKBT+xdkz6LK
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
 builtin/fetch.c                 |  91 +++++++++++++++++----
 t/t5574-fetch-output.sh         | 140 ++++++++++++++++++++++++++++++++
 4 files changed, 229 insertions(+), 18 deletions(-)

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
index 6e0f7e0046..695624ac08 100755
--- a/t/t5574-fetch-output.sh
+++ b/t/t5574-fetch-output.sh
@@ -56,6 +56,122 @@ test_expect_success 'fetch compact output' '
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
 test_expect_success 'fetch output with HEAD' '
 	test_when_finished "rm -rf head" &&
 	git clone . head &&
@@ -85,6 +201,30 @@ test_expect_success 'fetch output with HEAD' '
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


--aodgVKBT+xdkz6LK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRaRGgACgkQVbJhu7ck
PpR+1A/+N98dIt0qE3CntuF7IX/rnJ/Tjy4eujWr2LjO6PhvLYzepOl7TA96x6yM
IPB+JQPHpLKIxY72sIQ/BtSSggxOkgroJHTdMkrvuUJhh8hNsmUoGklBITriACLS
CByXUWC0wf9/ioka5ZG2nOhkkhwn3IyE8a5aRg0yiu4MJBRP65WTF0Hg1+fcRDyV
rO6VPdBiBET8LDXEw4KitBB6R7PwNLt1d7riAovD4mA2VrXN65ckzlTxrh+JopNb
GmX/KkZod7GHfLB1KRhEQz8pofSUGoGEgPXv/GYRvl7UQadHs9BdEMdLllbo9QeP
oAH2tWh8F1HG4dz5aQyv6rzMUW1VxftZPy3LAeo7fYXuw02GObhBVWk7s8+wTVLw
XJz1mGjUWKslmVOp6N3N248ndCAMS8GVTdaU9/7hL9cvGeLNIf+7Sz6pVD7QFRMm
bXr7ijA502A/EtVFXPIMrmucyAOkasFb4bCQYsFIuG5cOZvxt2G4Dg4zNf+rCirT
+m6hiSrCiS239cBqyWG5KFg9istS/tXEPP8gmF7WWFq5OdJYdxbl0ctvXjVPb3W1
gaP7tx6oqQilFQW6IHmX2qOVzrU/u+DimZh1XtRePUtvzrJAU11cZh1sSvWDMxwz
5lgVdG6M9eu2uVJGee154OOKt0sRj647NogXltao37765qP8VZY=
=kavv
-----END PGP SIGNATURE-----

--aodgVKBT+xdkz6LK--
