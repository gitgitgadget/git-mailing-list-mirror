Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14C7C77B73
	for <git@archiver.kernel.org>; Wed, 19 Apr 2023 12:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbjDSMc5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Apr 2023 08:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbjDSMci (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2023 08:32:38 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F924167F3
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 05:32:01 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 6684432005C1;
        Wed, 19 Apr 2023 08:31:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 19 Apr 2023 08:31:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681907518; x=1681993918; bh=4j
        Km3COaVfcWMPsVHEsG8aIlM26R/58ojhp2L+Y18wU=; b=aktVzpeWSgLTK8CEd9
        VzRiNhXzpk0qr4O031wTtYWsnTY+deWVFmZJ/Zc8hWaOAlhBmjenpVQPDbP/emds
        OB4xrx45HQ3LDevfwtgiN0b6kz/cLM5bS0qUtKnjms3vBg4maPzcQAUTS7ggKFjK
        0d8eDW7/pPUYUS3YhSHJcE9m9LV5mp1Hfx//h2JaR0Pt6MEOqg8fs1RsEw7oJ2/t
        +88GUk6yDKYYvGzd/3yd0OvuMonlqcudjJfeCI9WUeMF/RZR4w80xX5l/hwZ8EX8
        d2gxdlCVXL36oEInMsOttJ4a0vtNOZscDpQLj0NazfUf4IdRqJG9o0sBgPTojfqQ
        QgiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681907518; x=1681993918; bh=4jKm3COaVfcWM
        PsVHEsG8aIlM26R/58ojhp2L+Y18wU=; b=X3JRne+quAVltUrVQcJhyRil0wZF3
        pGdV4PidZOTB8W9YinCwkuRvt5y3dnxN+ljeTX4haD9/Kzy6aCz15sWQRo+SIRdK
        TkoQj7s+Ium8oNCqpJmcFM7OSuX+zQgWuK20Ydybc18XKcsWm8GqHC3Qyw7x8IlO
        sVXfUvZo+xk9KhOrUDGgH+QQWC3UqXvaZrMUrsK0yXaiZm8yLB3VxIbRvzP/7RbU
        8+Uy0hoFeznhuju/iE2i5osWtLNRqqFYsgEDbo1k/iTn+ZFzpMDujLfxoB78p0re
        SuZm4GF40cBhOmVu+fVxL3TrF0o9Pdtqaxjwm5jF5eIwp3jQIWPwVjeTw==
X-ME-Sender: <xms:Pd8_ZOqgjngPPGFEFfpOUOrr6eeShSI95m7fUH4J-AaO1WPxo1_Hqg>
    <xme:Pd8_ZMrb-gQCu_hgJO10yLXnG9_K6Xrsr0Ca91aDDEkKPl3zcsq_XhUu4bwNWPlgl
    uwa8Y6yudtwaQeYeA>
X-ME-Received: <xmr:Pd8_ZDNp30FOx1HdinJMv8_QM2Kc0l2_heOhvwGXWKMwGvEoi313eZ9NiBwvCwAoaKpOeSgWRpYXgD-8fEbb_cR9IEef3F5QXiiq8g1hylExrg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedttddgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:Pd8_ZN4Iiz7OSrMCZRkyHKV_Xt0Yi5LR57SOyhCVxKrtlAk5NGeb8A>
    <xmx:Pd8_ZN7-FXjPiJWy96m5FXnvWUe6n4Up9YWGRTyL0xtwQoav6mTH3Q>
    <xmx:Pd8_ZNiU592KaUuV1SHidVizrdcfnAnPUAqtPDOnHu9k-Jiivm-Bxg>
    <xmx:Pt8_ZKhZz0ng0xeb-z2Gs0UmdTCxN7Heoy2r_cJ9oQCsA6G7tkKHBg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Apr 2023 08:31:56 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id e6b34094 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 19 Apr 2023 12:31:44 +0000 (UTC)
Date:   Wed, 19 Apr 2023 14:31:55 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 8/8] fetch: introduce machine-parseable "porcelain" output
 format
Message-ID: <301138da039451519c6e60d6126e7756a54d346f.1681906949.git.ps@pks.im>
References: <cover.1681906948.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uK5mVgQpVuqmRIBp"
Content-Disposition: inline
In-Reply-To: <cover.1681906948.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--uK5mVgQpVuqmRIBp
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

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/config/fetch.txt  |  4 +-
 Documentation/fetch-options.txt |  4 +-
 Documentation/git-fetch.txt     | 17 ++++++-
 builtin/fetch.c                 | 50 +++++++++++++++-----
 t/t5574-fetch-output.sh         | 84 +++++++++++++++++++++++++++++++++
 5 files changed, 142 insertions(+), 17 deletions(-)

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
index 22ba75a958..a99e24448b 100644
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
@@ -745,8 +746,11 @@ static void display_state_init(struct display_state *d=
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
@@ -2059,6 +2083,8 @@ static int opt_parse_output_format(const struct optio=
n *opt, const char *arg, in
 		*format =3D DISPLAY_FORMAT_FULL;
 	else if (!strcmp(arg, "compact"))
 		*format =3D DISPLAY_FORMAT_COMPACT;
+	else if (!strcmp(arg, "porcelain"))
+		*format =3D DISPLAY_FORMAT_PORCELAIN;
 	else
 		return error(_("unsupported output format '%s'"), arg);
=20
@@ -2201,6 +2227,8 @@ int cmd_fetch(int argc, const char **argv, const char=
 *prefix)
 			display_format =3D DISPLAY_FORMAT_FULL;
 		else if (!strcasecmp(format, "compact"))
 			display_format =3D DISPLAY_FORMAT_COMPACT;
+		else if (!strcasecmp(format, "porcelain"))
+			display_format =3D DISPLAY_FORMAT_PORCELAIN;
 		else
 			die(_("invalid value for '%s': '%s'"),
 			    "fetch.output", format);
diff --git a/t/t5574-fetch-output.sh b/t/t5574-fetch-output.sh
index 5144d5ed21..28d02a93e4 100755
--- a/t/t5574-fetch-output.sh
+++ b/t/t5574-fetch-output.sh
@@ -80,6 +80,72 @@ test_expect_success 'fetch compact output' '
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
@@ -99,6 +165,24 @@ test_expect_success 'fetch output with HEAD and --dry-r=
un' '
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
2.40.0


--uK5mVgQpVuqmRIBp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQ/3zoACgkQVbJhu7ck
PpSUlA/+MF27MWTkdXCXDnD5XVWanF8/3qFMffsNBaTUJjMWqWN7I4nLFhqrBi6O
4wurMQgZBxOz7HCFeSHSlg6DdiFV85hZi9d9L0ZYIMt8ZCk0OWvYZgec7q9CagOQ
Y80cQ2t+M+1UDwJJNCV9MuH+kESkqOm5DHyK1ba538gIJg2b0oxS36VVMDZ9M4Cf
NreTWCNDBYQBS/FfrBcjQdrdMaDczihiGRADvn1webD83ZigDi2+zoxFmAMd4bGj
cZukmdEAC7Jd3GbBKO+q3yRlqSTpJRzyczKuK+GRzO8XgKXN6fY0CvUcsn2QW5vA
3O5p8tRAHOBMYEkTtC6fSH0PeBf38mC0hilUaX8MsMKHq4ZQyPKotL/y9S0aiGYs
rW6gy7+Pp76XSCZ+6P0O2k3TNXQ1haGJxV9wfUdWFJAg5Y7s5vNLc3+hH1iOtx0K
/8Zb63r7g4/EsBFfeEWoYcEb0uvhROZ7qLeB3k67sZfTRf6qeSvhW8gFASjY+n4k
q+kIELBeq8Kna4pPSshOYPsazq+5Ph/6GbO4DxINEV9p1eLryFKAJS/YktapqQxb
XVM9SKId0JHo82CSEhk1/YuJ7W5pfzAutj+u9uAP6Wvo7dA/6vEHrZPyqEVtwdok
iZm0NFKGYZ37OIS2Cq7pPqg+3FIjIZdmyGvkECWSb9Bq/Ft6ymI=
=a7s6
-----END PGP SIGNATURE-----

--uK5mVgQpVuqmRIBp--
