Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19EE5C77B75
	for <git@archiver.kernel.org>; Wed,  3 May 2023 11:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjECLfG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 07:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjECLes (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 07:34:48 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71ECF5592
        for <git@vger.kernel.org>; Wed,  3 May 2023 04:34:35 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id BDBBF5C0099;
        Wed,  3 May 2023 07:34:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 03 May 2023 07:34:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683113674; x=1683200074; bh=jV
        OVYkOjnzVa6tPIIejyJRAasVTCrTYIJ0fXFrfo+SQ=; b=pWEn+cb1d3cAugGnS8
        jcWko8bbK3el7qVGQeXJv8zGxgagqe5XqsqNoY7aN2Co7QrRRAw+32xpJQazcX7T
        8NcR14nlQnl/0k5JHbCUYHaaiURQESY82zaVaXoBhw6SprMQweyXRO71FyKyByUY
        fBpSaO8n2Zl5Bwfb77EqhjO8vlmTemUg/lLXxivZnExgIb31Tl3lUiEWimSi3PrH
        LB4jVcLyphklPNqfmo4IQocSvVngyVkHFOqRdDyjXns0l/OWpmmQ5Q868gcKg9QS
        wtCezNA/FVLxkuUWYrkWDXicZB21fqQ7iGUAO9M7W6ZhcAShy/uFuEQlS3rnw1nH
        wYZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683113674; x=1683200074; bh=jVOVYkOjnzVa6
        tPIIejyJRAasVTCrTYIJ0fXFrfo+SQ=; b=F2UrNnNNsBDoPifGWjuqwT0MNmsrs
        tVW+E0Lt/SzXHdwAhAL3C+soDpDhuC8vTEF3NKVjoZRDOE2hJ2R9rzttV0eazXCv
        E3snCOjJqo7wwFHojkkQ+zuYaUn3LbVBdhHlPJBLts4ufr1zj94yghNvJUGLKJDY
        XP9wMCoaswmYb/LBiGftzysY+iVAsVEgEdxsjJqKDolSjjSNzozdR7ggA8BkRlJ2
        D/gf2hnO96qZ/YX8iUxkdAAhWq3D+hfvnfwHvnRAYNzEzVfjJ7hNN5X4AvCSHqyy
        9UgSZ5wzNDT10eP6YP5ZhEeK+lt29mvRTxGH6i+a28z4RL9ASHk7pMgqQ==
X-ME-Sender: <xms:ykZSZO5RJp_fhFStlnXaIE4b-afbKYnfmJlSXDOyEnC4ObRrhDQhbA>
    <xme:ykZSZH7SSmT9m68G_HEA_J3X3be6vc9WPs7tKDrRCdd0x904vH5v_gIH71Q8lGNTk
    qpzAYrImtMiFVketw>
X-ME-Received: <xmr:ykZSZNcrgTQeraSVCleFclhGKK6UJS-ubv8aMIyWYrv-4HXU79Q30j__7pM0SH6rY3ElPMFzTvCpPoyF5PPoQpMEV9Esf37TlHpV6xQYwAAb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvkedggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepleejteffveehgeegteekteeiudeiieeigeeigedtffehgeekhfejheefkefhveel
    necuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:ykZSZLJAeomCM8Uumo_Z-96OfeZdOmvEw9FAVpjqxzcC0HDIdSJwtA>
    <xmx:ykZSZCI8iZu6MB2lN_JXxJFKzbsejnIVWcy3JjG3E2Uch3Y8P3dVpg>
    <xmx:ykZSZMzCs_EImE5_9iTAkhlNMQeUQunnBIaYwKISMa2cxmDRx_y_cA>
    <xmx:ykZSZHGDYneXPt4WIsUdJDOswoPJ7zrBhxPhE6bW0TAetT-xJerGSw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 May 2023 07:34:33 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id cf8c86c8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 3 May 2023 11:33:52 +0000 (UTC)
Date:   Wed, 3 May 2023 13:34:31 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v3 4/8] fetch: fix missing from-reference when fetching
 HEAD:foo
Message-ID: <46e1266ab0b13ace9b50bd98c00dbabb566c6cd2.1683113177.git.ps@pks.im>
References: <cover.1681906948.git.ps@pks.im>
 <cover.1683113177.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UIKqbO6kvAtdKWN+"
Content-Disposition: inline
In-Reply-To: <cover.1683113177.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--UIKqbO6kvAtdKWN+
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


--UIKqbO6kvAtdKWN+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRSRsYACgkQVbJhu7ck
PpTlcw//e5ON7AXmmyCCLOfpGoZ78FQze4SwcMbvr46s6R39OzrIBMbpvK6Ta1rW
lsDjqTuEdcOL4XslJpeccUB3I+vemRguWPRgv4EXVvHwqmrXNaE306McjrUC4RS9
Jk/n4Z0Gz/ofI2o7y7gm3zEBbA49da+dY3UP5ipsfBU5MF0xFAM29fEs9Oc8uJRC
cfsxmIp0bjAy6r7vyEb2Hk3uSL4FcGVTonsRCw+oxbWqViJUyf6cqQVYHtGZcZXU
JBR3KMf9+i9FSp+u0uP2wOK+GiapMht4d4Tft3zK+fYvQsL/SjAORgDYu4v52obQ
a9gpB5tVUvnjahO71ZsveWTtAYlVDsTQLBo7+u+Z/l6cON5RB0/OmbnDglMeqLu2
6bYbqJOkmpY5zLetWumul4IByAUFkGT9nBIzdcgdqI+Dnpl9MBFUrV8CYgN9FgPS
fIOHM6Y3Gfj0oL8TFKE+IGLG29OCFveyK/QaYgYjDxexy7X+P5EjGAiHKITgEc3H
fOEVskXYX6QArEI4YUZcXwQtTQAOKQNoD6AUiuYvgcbMpWTdNLdNzVUVm8ktRjsC
mKl2iZasaNcK11UkKzQILtLZU0MAq6fxcclzTeccTluSmqxXTwGCr8qndBE+2B+T
T2SNWP4RB6brPY4XGG6JTlLIL7gpGBA5juo4GGkP7kmYkoFnGB4=
=Oum8
-----END PGP SIGNATURE-----

--UIKqbO6kvAtdKWN+--
