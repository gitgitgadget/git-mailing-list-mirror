Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45AFC7EE22
	for <git@archiver.kernel.org>; Tue,  9 May 2023 13:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235342AbjEINC2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 09:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235280AbjEINCZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 09:02:25 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752293AB9
        for <git@vger.kernel.org>; Tue,  9 May 2023 06:02:19 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id DC87F5C0143;
        Tue,  9 May 2023 09:02:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 09 May 2023 09:02:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683637338; x=1683723738; bh=GU
        imfWZFQ8hzPZQXutmD70c4YIGpCV0Get63vqMU90o=; b=SRTsnnsVFISs8Ege3k
        a/pAToo5FYgOTxnx/kewEd1GFahofnTHmGo8TTyPqrO/HiUQvya+RMUHNxEiCdRw
        wvlA/Eb3W+SGok2kYL5lW9ffV/RgJMmMUrruiUiDmg+pMECujFEa6sIdBBLmzN2K
        lCbF83RkLpc+DwX/D6vKhIrkscwQf3wIsOJ5Sp41dH0ngN2CFvOXgpwc43msnaAU
        /iydORHHMM51FNLJoMnxBF40oiwCR6dOU+etwDo3LwZ2EKqfRiylF91nx7eicX8M
        oS5DYrR4AM/NK8IhhfMYj121j7GJBTu2Wj+U5o3sbM9JA1lE0J5MsdNiCQ/F9Qzl
        CAWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683637338; x=1683723738; bh=GUimfWZFQ8hzP
        ZQXutmD70c4YIGpCV0Get63vqMU90o=; b=HCg84LycbKTG7y5YrfdMlWdm94TCT
        WlDbGttWMz0m+YcMNHw3YEAn7/G/UM2cpem9T9uwbuuicKVIpF9Hnd5GdfaX4Pdc
        qtrsMy/OCxJVdWnMr8nIUQkZ+6wD/Rysrk7T1yUQaH5ICCQxdq0za+LXtD8bEkqk
        9nJHFwxmpVldqP30/j6yPRE+MRCcCsEVTJSic4YvULMM0xn1TyC375Y+E+U6Ozkp
        gU5dvDpWd/tNZbACI91x6NpYmNVWYwXE9IJ/bLxttauFcAiJev/am5kvdo/ENs8w
        qRGyUJoYYIFlmGPOq4a7sea7pZraCnzvPWQoD/i3vGjFVMXR66nu+9O7Q==
X-ME-Sender: <xms:WkRaZJGAXvjdttaNH0nEd2vn4hCjeVSNrNVJgVOvNnTjI1kTPKjqXQ>
    <xme:WkRaZOUfYTMNiQPhb3bnFxO9Jc0aNmVVggeFUcom3b1uUjqbQGR9aTLSjF_e0RD5k
    y3hxkmfv4qvUDQuzw>
X-ME-Received: <xmr:WkRaZLKqfhdxQHN4HAd0ftmCj3HC7eRD1p5vUHodJd28CfWE1HWv1dIIWXWgmW0KpC_0gb9FAC4Y4xhYkugC6FdtG_AHbpENzFkxh4pEVCI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegtddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepleejteffveehgeegteekteeiudeiieeigeeigedtffehgeekhfejheefkefhveel
    necuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:WkRaZPEFRstENtnWKtEOeHmkkSiAp18GhinVSP9PP_gagOhs5fNesw>
    <xmx:WkRaZPXRlipG7g9UjD11rcvDLGuXzW-1vmPZVdvuTMxCTXoTcBfZsA>
    <xmx:WkRaZKMfnCep2ExOOoj05LPJWBEVguSJiNbtdbZJyb3Uc5ie_sBAuw>
    <xmx:WkRaZFy74YjbyzR2lHLg_q0ube9zpe5agE-FWAwnVz8GjyLUuHDbkg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 May 2023 09:02:17 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id f4dbdf40 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 9 May 2023 13:02:10 +0000 (UTC)
Date:   Tue, 9 May 2023 15:02:15 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v4 4/8] fetch: fix missing from-reference when fetching
 HEAD:foo
Message-ID: <e599ea6d335d16b45fa75b223ea8db93e46c627d.1683636885.git.ps@pks.im>
References: <cover.1681906948.git.ps@pks.im>
 <cover.1683636885.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OrdGaQt2/jYXWz6U"
Content-Disposition: inline
In-Reply-To: <cover.1683636885.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--OrdGaQt2/jYXWz6U
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
But it is not intended when displaying the updated references and would
cause us to miss the left-hand side of the displayed reference update:

```
$ git fetch origin HEAD:foo
=46rom https://github.com/git/git
 * [new ref]                          -> foo
```

The HEAD string is clearly missing from the left-hand side of the arrow,
which is further stressed by the point that the following commands show
the left-hand side as expected:

```
$ git fetch origin HEAD
=46rom https://github.com/git/git
 * branch                  HEAD       -> FETCH_HEAD

$ git fetch origin master
=46rom https://github.com/git/git
 * branch                  master     -> FETCH_HEAD
 * branch                  master     -> origin/master
```

The logic of how we compute the remote reference name that we ultimately
pass to `display_ref_update()` is not easy to follow. There are three
different cases here:

    - When the remote reference name is "HEAD" we set the remote
      reference name to the empty string. This is the case that causes
      the bug to occur, where we would indeed want to print "HEAD"
      instead of the empty string. This is what `prettify_refname()`
      would return.

    - When the remote reference name has a well-known prefix then we
      strip this prefix. This matches what `prettify_refname()` does.

    - Otherwise, we keep the fully qualified reference name. This also
      matches what `prettify_refname()` does.

As the return value of `prettify_refname()` would do the correct thing
for us in all three cases, we can fix the bug by passing through the
full remote reference name to `display_ref_update()`, which learns to
call `prettify_refname()`. At the same time, this also simplifies the
code a bit.

Note that this patch also changes formatting of the block that computes
the "kind" and "what" variables. This is done on purpose so that it is
part of the diff, hopefully making the change easier to comprehend.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c         | 37 +++++++++++++++++++------------------
 t/t5574-fetch-output.sh | 29 +++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 18 deletions(-)

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
index a09750d225..6e0f7e0046 100755
--- a/t/t5574-fetch-output.sh
+++ b/t/t5574-fetch-output.sh
@@ -56,6 +56,35 @@ test_expect_success 'fetch compact output' '
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
 test_expect_success '--no-show-forced-updates' '
 	mkdir forced-updates &&
 	(
--=20
2.40.1


--OrdGaQt2/jYXWz6U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRaRFYACgkQVbJhu7ck
PpQcNg/+Igj5GwZQVRCAOmvkspxi05MSCm6iBAEZRrw/iSYlbRayl9Uj7aYPn/hx
kK/J8G1MUBmxbwAM0IUX533sGypCk4vYeEsr2BDvrXuEYmiAc230gyj75s81UpPK
wwpMcJ8RZ3L6bh/CgYC1f/qnVpfQKY2fGKN6MMhc3oAghJgg7vfEWgk5OInjRlM8
eZymyr/tFzRHFaDkr4kC93KBH5UOTN5WlyyGR/susIycdg3GDSrjmaSGTBuRNDoD
fdtm/z3SZXGGF59JXWaxS++ydSe+4FHMYMY1I8FYeSlUjbP9b5Ag/54bYOTsGmwI
EvYrl4JOVosHzqN0utBowp5cpbwtsA5VenN6cnA7uBrJsPntIYCOWhM+78/yknl/
mVNRHjTAmLgx/gQhPvR9qwuECAcEky8sBLm2f8n0s/GJHAc2YIAAan5a7OMQ0WDf
rck1UQiUJEv8MmqulsRZgN5GnVzPpZes3m7nDsnJvFcYopssanGVWaDkRc+QX5SV
b03PN3TnEvhfAGW5WEsej1/moez2csyui5ZU/Ar3aXx15u9YeEI6PBAn5XRTtxWJ
zMLCn9O38uNnsMfKZk00lomWhcUtLr1CimrVs+i+m3ZldZj20UakPKKaF4wibwMH
zhBDBzwwt5oIvJxNhiPKLCyLPWSYHzXwpZf7EeRyFp8DkjBU5JM=
=pAKm
-----END PGP SIGNATURE-----

--OrdGaQt2/jYXWz6U--
