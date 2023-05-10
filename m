Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844FBC77B7C
	for <git@archiver.kernel.org>; Wed, 10 May 2023 12:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237046AbjEJMee (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 08:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237031AbjEJMeZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 08:34:25 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987B693FA
        for <git@vger.kernel.org>; Wed, 10 May 2023 05:34:20 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id B78433200915;
        Wed, 10 May 2023 08:34:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 10 May 2023 08:34:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683722059; x=1683808459; bh=DU
        Aiwwap859+UC5NXuvc6xH2/ICfx5+cyJzv67YR6ck=; b=H/RY8nuf1tvNWQaqG2
        ZjPZ7mu0FumOQMXY832zxyZ66FW7bw+zluK4Zou//C9Z3Uh+SAy1ChSwGBUyWyss
        JVKiq1MFEPoU3SCeV7YhqpJM/0Jv2nOlfGNzXnGEuVaUl1iuRRmNxFI3HE/VMRHz
        4M7WbyM6m+jKUKxJEztlaIKmuNB2DEHdoXy8FYyCeTfFAVsuymyVDpM8WhDKLSj2
        1jQ51kj4CntM8VFMrZ9JvvtwNx0NIuov7rTt/n9vSUihZ9szZLuDyHL7D5NRiIDF
        MtyA47g7m3dWLyEMJvo9YVDtEYmGoOng3Ea0A9LkWjeTymQA+wyVPrDk1i0r7ub6
        LAjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683722059; x=1683808459; bh=DUAiwwap859+U
        C5NXuvc6xH2/ICfx5+cyJzv67YR6ck=; b=Cz1mUU7P8fCjdqaZcSq5kmFg8OT/8
        o38TRf3oIEPjcum8sqEclZ3blM378f6GoBYuPiti6JPHDnQwkk+TBu+LiPmjt8DZ
        PVtkUaSru8S+cBnaXBJ/OUwZJNKdFsqqeykPqYLU2ii4elsb03qbuMAFo/ka3fXS
        74MxrJ/JUtu5ECzSx+IXecOkRuFM1r+Vrr7cpGD6bwuAOQM32P1LmE2OTwf+V3g5
        2CZtnvsUrogEqGX1iJagXaQ0/GyKQuCxJkN3M/BMmUOmjBi8JLa+Mk5DqM6QowPt
        o3tFpKRis7cMIw3bmXUVu32c6p6Xh4gYbrrxoKVLxFzJSrLA7IzMYvXvQ==
X-ME-Sender: <xms:S49bZElA0rsrM1Yiu3a6RYeqLq6HkUY3BjzTnDKnFiOvFokRu7vR1A>
    <xme:S49bZD0RibdPBCJzhDjmsYZ9XoxxRlDJPLjtSt1tm-GyEzXjRPWLg6i0aXjnk-G2p
    d7wvo6FiLi5JH8uOw>
X-ME-Received: <xmr:S49bZCp9dQzycE7vEr53iA7Nm5G14Mn_Pn3IZPDb3by2M0nhgZy2EU0QOp8f7ai4nXsrOD0New7xYKIzNAhigOvOnO1l331VXA7YPf1SQalS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegiedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepleejteffveehgeegteekteeiudeiieeigeeigedtffehgeekhfejheefkefhveel
    necuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:S49bZAlzFfAAA5sP2vdZDeSsEQpsoL8OMbSwbZkazFIQGRZw4eUnog>
    <xmx:S49bZC3VC5ViVu7pDW6MMlN5IrnUEl4ldbuzN26iGj7nURw204WJjQ>
    <xmx:S49bZHvO8iNuqsj1ZttZr-7IyghGnKY4K2wJ_vy9euSuPM5yqs0Ltw>
    <xmx:S49bZFSEYUHg0UWaQFow_du5XNvkidd7lOiPFOH_g0x4EM0u5XZ0fQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 May 2023 08:34:17 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 8bdd7db1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 10 May 2023 12:34:08 +0000 (UTC)
Date:   Wed, 10 May 2023 14:34:15 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v5 4/9] fetch: print left-hand side when fetching HEAD:foo
Message-ID: <2cc7318697ef6062f6deadf7a22feb26c2c829e8.1683721293.git.ps@pks.im>
References: <cover.1681906948.git.ps@pks.im>
 <cover.1683721293.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XmXDs68GX3oMfPCx"
Content-Disposition: inline
In-Reply-To: <cover.1683721293.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--XmXDs68GX3oMfPCx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

`store_updated_refs()` parses the remote reference for two purposes:

    - It gets used as a note when writing FETCH_HEAD.

    - It is passed through to `display_ref_update()` to display
      updated references in the following format:

      ```
       * branch               master          -> master
      ```

In most cases, the parsed remote reference is the prettified reference
name and can thus be used for both cases. But if the remote reference is
HEAD, the parsed remote reference becomes empty. This is intended when
we write the FETCH_HEAD, where we skip writing the note in that case.
But when displaying the updated references this leads to inconsistent
output where the left-hand side of reference updates is missing in some
cases:

```
$ git fetch origin HEAD HEAD:explicit-head :implicit-head main
=46rom https://github.com/git/git
 * branch                  HEAD       -> FETCH_HEAD
 * [new ref]                          -> explicit-head
 * [new ref]                          -> implicit-head
 * branch                  main       -> FETCH_HEAD
```

This behaviour has existed ever since the table-based output has been
introduced for git-fetch(1) via 165f390250 (git-fetch: more terse fetch
output, 2007-11-03) and was never explicitly documented either in the
commit message or in any of our tests. So while it may not be a bug per
se, it feels like a weird inconsistency and not like it was a concious
design decision.

The logic of how we compute the remote reference name that we ultimately
pass to `display_ref_update()` is not easy to follow. There are three
different cases here:

    - When the remote reference name is "HEAD" we set the remote
      reference name to the empty string. This is the case that causes
      the left-hand side to go missing, where we would indeed want to
      print "HEAD" instead of the empty string. This is what
      `prettify_refname()` would return.

    - When the remote reference name has a well-known prefix then we
      strip this prefix. This matches what `prettify_refname()` does.

    - Otherwise, we keep the fully qualified reference name. This also
      matches what `prettify_refname()` does.

As the return value of `prettify_refname()` would do the correct thing
for us in all three cases, we can thus fix the inconsistency by passing
through the full remote reference name to `display_ref_update()`, which
learns to call `prettify_refname()`. At the same time, this also
simplifies the code a bit.

Note that this patch also changes formatting of the block that computes
the "kind" (which is the category like "branch" or "tag") and "what"
(which is the prettified reference name like "master" or "v1.0")
variables. This is done on purpose so that it is part of the diff,
hopefully making the change easier to comprehend.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c         | 37 ++++++++++++++++----------------
 t/t5574-fetch-output.sh | 47 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 18 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 08d7fc7233..6aecf549e8 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -918,12 +918,14 @@ static void display_ref_update(struct display_state *=
display_state, char code,
 	}
=20
 	width =3D (summary_width + strlen(summary) - gettext_width(summary));
+	remote =3D prettify_refname(remote);
+	local =3D prettify_refname(local);
=20
 	strbuf_addf(&display_state->buf, " %c %-*s ", code, width, summary);
 	if (!display_state->compact_format)
-		print_remote_to_local(display_state, remote, prettify_refname(local));
+		print_remote_to_local(display_state, remote, local);
 	else
-		print_compact(display_state, remote, prettify_refname(local));
+		print_compact(display_state, remote, local);
 	if (error)
 		strbuf_addf(&display_state->buf, "  (%s)", error);
 	strbuf_addch(&display_state->buf, '\n');
@@ -934,7 +936,7 @@ static void display_ref_update(struct display_state *di=
splay_state, char code,
 static int update_local_ref(struct ref *ref,
 			    struct ref_transaction *transaction,
 			    struct display_state *display_state,
-			    const char *remote, const struct ref *remote_ref,
+			    const struct ref *remote_ref,
 			    int summary_width)
 {
 	struct commit *current =3D NULL, *updated;
@@ -946,7 +948,7 @@ static int update_local_ref(struct ref *ref,
 	if (oideq(&ref->old_oid, &ref->new_oid)) {
 		if (verbosity > 0)
 			display_ref_update(display_state, '=3D', _("[up to date]"), NULL,
-					   remote, ref->name, summary_width);
+					   remote_ref->name, ref->name, summary_width);
 		return 0;
 	}
=20
@@ -959,7 +961,7 @@ static int update_local_ref(struct ref *ref,
 		 */
 		display_ref_update(display_state, '!', _("[rejected]"),
 				   _("can't fetch into checked-out branch"),
-				   remote, ref->name, summary_width);
+				   remote_ref->name, ref->name, summary_width);
 		return 1;
 	}
=20
@@ -970,12 +972,12 @@ static int update_local_ref(struct ref *ref,
 			r =3D s_update_ref("updating tag", ref, transaction, 0);
 			display_ref_update(display_state, r ? '!' : 't', _("[tag update]"),
 					   r ? _("unable to update local ref") : NULL,
-					   remote, ref->name, summary_width);
+					   remote_ref->name, ref->name, summary_width);
 			return r;
 		} else {
 			display_ref_update(display_state, '!', _("[rejected]"),
 					   _("would clobber existing tag"),
-					   remote, ref->name, summary_width);
+					   remote_ref->name, ref->name, summary_width);
 			return 1;
 		}
 	}
@@ -1008,7 +1010,7 @@ static int update_local_ref(struct ref *ref,
 		r =3D s_update_ref(msg, ref, transaction, 0);
 		display_ref_update(display_state, r ? '!' : '*', what,
 				   r ? _("unable to update local ref") : NULL,
-				   remote, ref->name, summary_width);
+				   remote_ref->name, ref->name, summary_width);
 		return r;
 	}
=20
@@ -1030,7 +1032,7 @@ static int update_local_ref(struct ref *ref,
 		r =3D s_update_ref("fast-forward", ref, transaction, 1);
 		display_ref_update(display_state, r ? '!' : ' ', quickref.buf,
 				   r ? _("unable to update local ref") : NULL,
-				   remote, ref->name, summary_width);
+				   remote_ref->name, ref->name, summary_width);
 		strbuf_release(&quickref);
 		return r;
 	} else if (force || ref->force) {
@@ -1042,12 +1044,12 @@ static int update_local_ref(struct ref *ref,
 		r =3D s_update_ref("forced-update", ref, transaction, 1);
 		display_ref_update(display_state, r ? '!' : '+', quickref.buf,
 				   r ? _("unable to update local ref") : _("forced update"),
-				   remote, ref->name, summary_width);
+				   remote_ref->name, ref->name, summary_width);
 		strbuf_release(&quickref);
 		return r;
 	} else {
 		display_ref_update(display_state, '!', _("[rejected]"), _("non-fast-forw=
ard"),
-				   remote, ref->name, summary_width);
+				   remote_ref->name, ref->name, summary_width);
 		return 1;
 	}
 }
@@ -1252,14 +1254,13 @@ static int store_updated_refs(struct display_state =
*display_state,
 			if (!strcmp(rm->name, "HEAD")) {
 				kind =3D "";
 				what =3D "";
-			}
-			else if (skip_prefix(rm->name, "refs/heads/", &what))
+			} else if (skip_prefix(rm->name, "refs/heads/", &what)) {
 				kind =3D "branch";
-			else if (skip_prefix(rm->name, "refs/tags/", &what))
+			} else if (skip_prefix(rm->name, "refs/tags/", &what)) {
 				kind =3D "tag";
-			else if (skip_prefix(rm->name, "refs/remotes/", &what))
+			} else if (skip_prefix(rm->name, "refs/remotes/", &what)) {
 				kind =3D "remote-tracking branch";
-			else {
+			} else {
 				kind =3D "";
 				what =3D rm->name;
 			}
@@ -1277,7 +1278,7 @@ static int store_updated_refs(struct display_state *d=
isplay_state,
 					  display_state->url_len);
=20
 			if (ref) {
-				rc |=3D update_local_ref(ref, transaction, display_state, what,
+				rc |=3D update_local_ref(ref, transaction, display_state,
 						       rm, summary_width);
 				free(ref);
 			} else if (write_fetch_head || dry_run) {
@@ -1288,7 +1289,7 @@ static int store_updated_refs(struct display_state *d=
isplay_state,
 				 */
 				display_ref_update(display_state, '*',
 						   *kind ? kind : "branch", NULL,
-						   *what ? what : "HEAD",
+						   rm->name,
 						   "FETCH_HEAD", summary_width);
 			}
 		}
diff --git a/t/t5574-fetch-output.sh b/t/t5574-fetch-output.sh
index 8a344e6790..9890f6f381 100755
--- a/t/t5574-fetch-output.sh
+++ b/t/t5574-fetch-output.sh
@@ -61,6 +61,53 @@ test_expect_success 'fetch compact output' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'fetch output with HEAD' '
+	test_when_finished "rm -rf head" &&
+	git clone . head &&
+
+	git -C head fetch --dry-run origin HEAD >actual.out 2>actual.err &&
+	cat >expect <<-EOF &&
+	From $(test-tool path-utils real_path .)/.
+	 * branch            HEAD       -> FETCH_HEAD
+	EOF
+	test_must_be_empty actual.out &&
+	test_cmp expect actual.err &&
+
+	git -C head fetch origin HEAD >actual.out 2>actual.err &&
+	test_must_be_empty actual.out &&
+	test_cmp expect actual.err &&
+
+	git -C head fetch --dry-run origin HEAD:foo >actual.out 2>actual.err &&
+	cat >expect <<-EOF &&
+	From $(test-tool path-utils real_path .)/.
+	 * [new ref]         HEAD       -> foo
+	EOF
+	test_must_be_empty actual.out &&
+	test_cmp expect actual.err &&
+
+	git -C head fetch origin HEAD:foo >actual.out 2>actual.err &&
+	test_must_be_empty actual.out &&
+	test_cmp expect actual.err
+'
+
+test_expect_success 'fetch output with object ID' '
+	test_when_finished "rm -rf object-id" &&
+	git clone . object-id &&
+	commit=3D$(git rev-parse HEAD) &&
+
+	git -C object-id fetch --dry-run origin $commit:object-id >actual.out 2>a=
ctual.err &&
+	cat >expect <<-EOF &&
+	From $(test-tool path-utils real_path .)/.
+	 * [new ref]         $commit -> object-id
+	EOF
+	test_must_be_empty actual.out &&
+	test_cmp expect actual.err &&
+
+	git -C object-id fetch origin $commit:object-id >actual.out 2>actual.err =
&&
+	test_must_be_empty actual.out &&
+	test_cmp expect actual.err
+'
+
 test_expect_success '--no-show-forced-updates' '
 	mkdir forced-updates &&
 	(
--=20
2.40.1


--XmXDs68GX3oMfPCx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRbj0YACgkQVbJhu7ck
PpQKwg//V4VqJMLLxSnG2Zf0PYGcIKcdcJdNiWCBioV8W0OI2jdC4wbbDx9ZeE/B
MQ/QsyhN98jvxB8m8v1zquz7t0AIw8iIif9thUU2uvveH7IPlEHXO7b1xnVpefDL
UKx1Lb4PqZdLnKKzdPiKdQBahvn5mn4909uRjWH2jPefluVVhD/bbtshcyTUhJgf
2Y81TtQdWFEQrPqmghhhWc5lGAOmCssEFoOcQrTJzFmDQBsCQdGr8/P985ps8l2i
u4wr3y13JYP4eT8lhxIwfrbLWnbDfO2KcGThqB7SyO9lgPNZOvr2zdtirxAqkYDk
KX8/SinAWsLQRgM0vjTvxkRySoi11shv/uQY2hWRe6kxVgmCAhnb/1ihXl+Z0hI8
k5bdwYUFSvOiZeAzbkW8gnnkR8YUefAiZ9hp4/5HyxNt6XiRa8c4i4dwH6nzp3w8
HIL9ALlCxn9uopz6TNzdX8q0KbkgV0PRZ57tOA9DokXFXNzaz3TyN09d6xkh9hI/
EeGyd8M2V4446UhkfPAJP/2r01XiFpn2986+ZQ6DUACXYtSw9swPYMljujG2v8g7
AJDkGW0H+GIZwOZEh9NXr5GVhldzye8AFQG5mv5MDua0ti5Jc4+EPwtD1BU4TSg1
Q5i9ghcvBL547VZpWm8OgzyGBqyd5JLhhe/GTXUzqr5bMRObUtA=
=OJuM
-----END PGP SIGNATURE-----

--XmXDs68GX3oMfPCx--
