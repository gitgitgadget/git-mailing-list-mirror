Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD176C77B73
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 11:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243698AbjD0LOA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 07:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243715AbjD0LNr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 07:13:47 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141A05BB1
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 04:13:42 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 821D45C023D;
        Thu, 27 Apr 2023 07:13:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 27 Apr 2023 07:13:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1682594021; x=1682680421; bh=dA
        zXLKtxHaWSMz+0If6TCHCCexqwv7bMpfzg1V5L0O0=; b=kgO4tQEc2qWeAAoUaf
        soL8mbsxTfyliPQH91ajO2YKB4OLFUltLr+G6lQndq/FpSTKKFDZ49WbjceR7r5O
        cTxDnMuRwXFfsQH53M2WntehSHiMczBI4nmZtaPLEy/EjEQGV2aJx3I5enYrWaQA
        db0Qh+xxYTx8Uz5JBIHXAK6Esbzx65UnS6wOAmv8J0Hm/G9vBrdpRaNBBL5PgPcr
        XkKzOShEII3DRRsBpNpuRjQUy46Jop81ySQcUjpFHlUN4BtFkZuB9YmyCWoQzas4
        fbXglR/brH+/QafZVIq0ZIA7lQPukXHLr2MBgffDD1SV5DdQvQhclsCDu1ri+Xrj
        jsyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682594021; x=1682680421; bh=dAzXLKtxHaWSM
        z+0If6TCHCCexqwv7bMpfzg1V5L0O0=; b=IBGrdI6KD+Vc6Rj9qDJ/M3TFDljXU
        vNLDerXrSEwNeLXrS3vAsbWNgIOa4HkJVxI3JugetdrnM5S/cHRKJz/9tZyrMrj6
        EdA0D61LfeWW5mi6G/ii7MbanKcDpXIXzIw9Gr6WkGZz2I6UeW/UcCuNG8ORzqwR
        8IOE/gDnXy0+4uW2A7RPUqh6wU+dRtHzNc2zT4z5dG8NWDL0djyJ5F2ypvo598eo
        eCruN+OSid+cPrR8j5cZVggg+fXowGJvqoNwo0zFVhcpGvhgvEZ66jkhZQNlZPIT
        rluaHl4tNKQBeqszBNLzcRZGNI1caD82QUViTfv1KtVwmhlAStEm6IEGQ==
X-ME-Sender: <xms:5VhKZLlgzk4DA57ibnU3aOfW_uDyDr-6beyNrSMRBYTBgmfjIs37_A>
    <xme:5VhKZO2AR9ki4A6x-EJrIZCc7QI0kkBTTLQLeU_ERBE0clW7wd3uQOWFIFv0WIOYi
    XLayS4U-l-EfoIPVQ>
X-ME-Received: <xmr:5VhKZBorIxkNWZDyvfyUTbbNR8hFSnqQ6w0K8gvtshQ9rOqqNp2buGU5ZIQAwqprlydl0k6Ij5dgGnQojUZxw-SlQxpQdZseTo8XMNvwrz1L>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeduiedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:5VhKZDkijtkm5Fit3yrDG8IJABT8q_ZlwFDh6NxO1R-6tam4CEMDWA>
    <xmx:5VhKZJ2ME4upd4Cj1GW5CnJiFF-x6TjWjMD3ziQrrF_Z-jXpIJ8uLw>
    <xmx:5VhKZCuJSg-TtEEZhyTuSzHqBrcj_TJX7fBJGWa6-dcdhlbBrUMYLA>
    <xmx:5VhKZETPclj-E9VBBkS3r1Mzn1AH-fo7CW-WkgN_YpjI1Fm4iktg9Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Apr 2023 07:13:39 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 4dab03d4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 27 Apr 2023 11:13:11 +0000 (UTC)
Date:   Thu, 27 Apr 2023 13:13:38 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v2 8/8] fetch: introduce machine-parseable "porcelain" output
 format
Message-ID: <d7c1bc1a80406ad320c2de684e0c97ba14827c7a.1682593865.git.ps@pks.im>
References: <cover.1681906948.git.ps@pks.im>
 <cover.1682593865.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HIaMSHoDb66n6Yip"
Content-Disposition: inline
In-Reply-To: <cover.1682593865.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--HIaMSHoDb66n6Yip
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
most likely usecase, which is when fetching from a single remote. If
usecases come up for this in the future though it is easy enough to add
a new "porcelain-v2" format that adds this information.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/config/fetch.txt  |  4 +-
 Documentation/fetch-options.txt |  4 +-
 Documentation/git-fetch.txt     | 17 ++++++-
 builtin/fetch.c                 | 47 +++++++++++++-----
 t/t5574-fetch-output.sh         | 84 +++++++++++++++++++++++++++++++++
 5 files changed, 139 insertions(+), 17 deletions(-)

diff --git a/Documentation/config/fetch.txt b/Documentation/config/fetch.txt
index 568f0f75b3..70734226c0 100644
--- a/Documentation/config/fetch.txt
+++ b/Documentation/config/fetch.txt
@@ -52,8 +52,8 @@ fetch.pruneTags::
=20
 fetch.output::
 	Control how ref update status is printed. Valid values are
-	`full` and `compact`. Default value is `full`. See section
-	OUTPUT in linkgit:git-fetch[1] for detail.
+	`full`, `compact` and `porcelain`. Default value is `full`.
+	See section OUTPUT in linkgit:git-fetch[1] for detail.
=20
 fetch.negotiationAlgorithm::
 	Control how information about the commits in the local repository
diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.=
txt
index 654f96f79d..5ca8a67fe8 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -80,8 +80,8 @@ linkgit:git-config[1].
=20
 --output-format::
 	Control how ref update status is printed. Valid values are
-	`full` and `compact`. Default value is `full`. See section
-	OUTPUT in linkgit:git-fetch[1] for detail.
+	`full`, `compact` and `porcelain`. Default value is `full`.
+	See section OUTPUT in linkgit:git-fetch[1] for detail.
=20
 ifndef::git-pull[]
 --[no-]write-fetch-head::
diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index fba66f1460..efd22cd372 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -197,13 +197,26 @@ The output of "git fetch" depends on the transport me=
thod used; this
 section describes the output when fetching over the Git protocol
 (either locally or via ssh) and Smart HTTP protocol.
=20
-The status of the fetch is output in tabular form, with each line
-representing the status of a single ref. Each line is of the form:
+The output format can be chosen either via the `fetch.output` config
+(see linkgit:git-config[1]), or via the `--output-format` switch.
+Supported values include:
+
+For the `full` and `compact` output formats, the status of the fetch is
+output in tabular, with each line representing the status of a single
+ref. Each line is of the form:
=20
 -------------------------------
  <flag> <summary> <from> -> <to> [<reason>]
 -------------------------------
=20
+The `porcelain` output format is intended to be machine-parseable. In
+contrast to the human-readable output formats it thus prints to standard
+output instead of standard error. Each line is of the form:
+
+-------------------------------
+<flag> <old-object-id> <new-object-id> <local-reference>
+-------------------------------
+
 The status of up-to-date refs is shown only if the --verbose option is
 used.
=20
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 30099b2ac3..abe6b8879d 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -52,6 +52,7 @@ enum display_format {
 	DISPLAY_FORMAT_UNKNOWN =3D 0,
 	DISPLAY_FORMAT_FULL,
 	DISPLAY_FORMAT_COMPACT,
+	DISPLAY_FORMAT_PORCELAIN,
 	DISPLAY_FORMAT_MAX,
 };
=20
@@ -59,6 +60,7 @@ static const char * const display_formats[DISPLAY_FORMAT_=
MAX] =3D {
 	NULL,
 	"full",
 	"compact",
+	"porcelain",
 };
=20
 struct display_state {
@@ -752,8 +754,11 @@ static void display_state_init(struct display_state *d=
isplay_state, struct ref *
=20
 		break;
 	}
+	case DISPLAY_FORMAT_PORCELAIN:
+		/* We don't need to precompute anything here. */
+		break;
 	default:
-		BUG("unexpected display foramt %d", display_state->format);
+		BUG("unexpected display format %d", display_state->format);
 	}
 }
=20
@@ -822,8 +827,12 @@ static void print_compact(struct display_state *displa=
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
@@ -856,12 +865,17 @@ static void display_ref_update(struct display_state *=
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
@@ -879,7 +893,8 @@ static int update_local_ref(struct ref *ref,
 	if (oideq(&ref->old_oid, &ref->new_oid)) {
 		if (verbosity > 0)
 			display_ref_update(display_state, '=3D', _("[up to date]"), NULL,
-					   remote_ref->name, ref->name, summary_width);
+					   remote_ref->name, ref->name,
+					   &ref->old_oid, &ref->new_oid, summary_width);
 		return 0;
 	}
=20
@@ -892,7 +907,8 @@ static int update_local_ref(struct ref *ref,
 		 */
 		display_ref_update(display_state, '!', _("[rejected]"),
 				   _("can't fetch into checked-out branch"),
-				   remote_ref->name, ref->name, summary_width);
+				   remote_ref->name, ref->name,
+				   &ref->old_oid, &ref->new_oid, summary_width);
 		return 1;
 	}
=20
@@ -903,12 +919,14 @@ static int update_local_ref(struct ref *ref,
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
@@ -941,7 +959,8 @@ static int update_local_ref(struct ref *ref,
 		r =3D s_update_ref(msg, ref, transaction, 0);
 		display_ref_update(display_state, r ? '!' : '*', what,
 				   r ? _("unable to update local ref") : NULL,
-				   remote_ref->name, ref->name, summary_width);
+				   remote_ref->name, ref->name,
+				   &ref->old_oid, &ref->new_oid, summary_width);
 		return r;
 	}
=20
@@ -963,7 +982,8 @@ static int update_local_ref(struct ref *ref,
 		r =3D s_update_ref("fast-forward", ref, transaction, 1);
 		display_ref_update(display_state, r ? '!' : ' ', quickref.buf,
 				   r ? _("unable to update local ref") : NULL,
-				   remote_ref->name, ref->name, summary_width);
+				   remote_ref->name, ref->name,
+				   &ref->old_oid, &ref->new_oid, summary_width);
 		strbuf_release(&quickref);
 		return r;
 	} else if (force || ref->force) {
@@ -975,12 +995,14 @@ static int update_local_ref(struct ref *ref,
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
@@ -1221,7 +1243,9 @@ static int store_updated_refs(struct display_state *d=
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
@@ -1361,6 +1385,7 @@ static int prune_refs(struct display_state *display_s=
tate,
 		for (ref =3D stale_refs; ref; ref =3D ref->next) {
 			display_ref_update(display_state, '-', _("[deleted]"), NULL,
 					   _("(none)"), ref->name,
+					   &ref->new_oid, &ref->old_oid,
 					   summary_width);
 			warn_dangling_symref(stderr, dangling_msg, ref->name);
 		}
diff --git a/t/t5574-fetch-output.sh b/t/t5574-fetch-output.sh
index 662c960f94..d88ad8af31 100755
--- a/t/t5574-fetch-output.sh
+++ b/t/t5574-fetch-output.sh
@@ -102,6 +102,72 @@ test_expect_success 'fetch compact output with multipl=
e remotes' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'fetch porcelain output' '
+	test_when_finished "rm -rf porcelain-cfg porcelain-cli" &&
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
+	git clone . porcelain-cli &&
+	git clone . porcelain-cfg &&
+	git -C porcelain-cfg fetch origin $refspecs &&
+	git -C porcelain-cli fetch origin $refspecs &&
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
+	test_must_fail git -C porcelain-cfg -c fetch.output=3Dporcelain fetch --d=
ry-run --prune origin $refspecs >actual-dry-run-cfg &&
+	test_must_fail git -C porcelain-cli fetch --output-format=3Dporcelain --d=
ry-run --prune origin $refspecs >actual-dry-run-cli &&
+	test_cmp actual-dry-run-cfg actual-dry-run-cli &&
+	test_cmp expect actual-dry-run-cfg &&
+
+	# And now we perform a non-dry-run fetch.
+	test_must_fail git -C porcelain-cfg -c fetch.output=3Dporcelain fetch --p=
rune origin $refspecs >actual-cfg &&
+	test_must_fail git -C porcelain-cli fetch --output-format=3Dporcelain --p=
rune origin $refspecs >actual-cli &&
+	test_cmp actual-cfg actual-cli &&
+	test_cmp expect actual-cfg &&
+
+	# Ensure that the dry-run and non-dry-run output matches.
+	test_cmp actual-dry-run-cfg actual-cfg
+'
+
 test_expect_success 'fetch output with HEAD and --dry-run' '
 	test_when_finished "rm -rf head" &&
 	git clone . head &&
@@ -127,6 +193,24 @@ test_expect_success 'fetch output with HEAD and --dry-=
run' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'fetch porcelain output with HEAD and --dry-run' '
+	test_when_finished "rm -rf head" &&
+	git clone . head &&
+	COMMIT_ID=3D$(git rev-parse HEAD) &&
+
+	git -C head fetch --output-format=3Dporcelain --dry-run origin HEAD >actu=
al &&
+	cat >expect <<-EOF &&
+	* $ZERO_OID $COMMIT_ID FETCH_HEAD
+	EOF
+	test_cmp expect actual &&
+
+	git -C head fetch --output-format=3Dporcelain --dry-run origin HEAD:foo >=
actual &&
+	cat >expect <<-EOF &&
+	* $ZERO_OID $COMMIT_ID refs/heads/foo
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success '--no-show-forced-updates' '
 	mkdir forced-updates &&
 	(
--=20
2.40.1


--HIaMSHoDb66n6Yip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRKWOEACgkQVbJhu7ck
PpRpog//exqGxc4vnyq4SaTkbG2l6pP2OOWZunVR8UNNRZS/EXiwOHDOmMZbaY3d
tTQ46HS1J2S6Al68eOu3G4JN9oxWpUkVsjqEqGO20c+KqQeZJYbRcWVk93njOAs2
N5dcAq5vBjlvKxEaabKliJK0LkRLfaVFCXTK1lAhCfzOPrs85rcEnx4t2YuPkB/3
bkoHY9m1q6/vHJMQ8MxLbg8evNWZ8NkNg9m9ZTCSMZb2Rb3TIETIi0ge+mfGRHae
OLXaQnEG+y0hCyjPup/+WRvd33OiJKa3U5dPVfnSWhiC5tBy4XLQ32VEq56zocfS
BpP8Du3V1kQ75CPUfL4VmSa+7ax4T+tYnNVDb15VwXrEW6FZLk5PbI6I0nXxhMeN
wmRO7Uj61WlUtGZJguFRsbfxh8CUs6dEKwOo4ACOSwhYEjZTPYjmZZ2lmr6/gLB/
xUNfhfhcfJb18iOTjL93VmfInfcLHE9xNGiouzU4itYh9MokIlzT9VAHUh1oWRBO
3uzifJFN3Mjax1rp8gEVBgSKt/1OKhy3yo10wP1yROeFi+v6kMTZyiHjjRIhfD5P
uvFCHy5DcjR5jEWAVR05iGcKHgCh1efFZPs2sQuaVXa3gmuZPDqKUMxqTEdusbn7
qkKrsiMQtarrI3ENiQzARUoLnNiMruIDX1f9mLOaRDANn6IChJg=
=2xJg
-----END PGP SIGNATURE-----

--HIaMSHoDb66n6Yip--
