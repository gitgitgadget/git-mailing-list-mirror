Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBE2C77B73
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 11:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243319AbjD0LNf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 07:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243692AbjD0LN3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 07:13:29 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D0C49DE
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 04:13:20 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 5794D5C020D;
        Thu, 27 Apr 2023 07:13:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 27 Apr 2023 07:13:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1682594000; x=1682680400; bh=o1
        ZXgEnbiFgI0dxoWXI2p92/CznREiJEU2ynBA2/nrY=; b=aJ0OxP8IeOTzCF/tPk
        Niu0w/pd79JBjINZdpMdYp2Dk5YPPJnbdqDzCyJzOMJNgiAqbkghXO2KqRmhc6we
        rpd7JRcbZ+XgA4zjoZtyV5u8ZdQTT+Mpaoa/cWLShhcznRUXszvKWaanyi0Njf5Y
        y1Pt4O1LTlYcHilV71ZwxBL/TjztXu9bMvx41vPeBIdyFbm1BgX9Fe9ldEgJlzlI
        F9C4mOknVsX5jQ07zI5UAmZzRAiKhvDApEolZLrpgIo6gSo2pPIVbII1GbVXCUj7
        OmLIcaD1wWpI1oklAUbeWzQY0aAqpyPk6/JSJdyiAB+uCtzThhkbfWclptOKhCIA
        flDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682594000; x=1682680400; bh=o1ZXgEnbiFgI0
        dxoWXI2p92/CznREiJEU2ynBA2/nrY=; b=Ct0ep9WPpyTWcGHP8TDp2wS9EsqX5
        V5JIEgFPD6u5G5zwW9myVKT0u6RRq/icdwjpwounOH3rDGzyDczsdXRQr4g6f8LG
        30xhX1YJ9XVpWIk+ugLA/qrjplksg9do4h4RzcwvmWIasNYFiL4KlGxmQu1Qs7ss
        LcWH0XY84xAbX5zZUzgQ8d1LanBB9ezyDYe8Rg1WtHai16brYuddiLg05/xzipKQ
        bJ33m3zNJKllGtlCx0olipMxEqPURHJ8eMe5+1lxWeJRioJ9SS2QXHsG6l0qMDAy
        wB7upCm1lyTLo8NQ36vDp5Dkfqi/d2/9PrDYMn9EyEBg5ld0ZdVVaoUZg==
X-ME-Sender: <xms:0FhKZN8tahOleh055MwM1jDxqVbP_6OTjGlDjUTOe8r3feq_VJ8A9Q>
    <xme:0FhKZBv-9Zzt3v8ZAVW-Ozd_iusS4fBv-_KHMNSDf0DP_6vL7DQU161LPC-lp-Chv
    o3lj5hRanzKIqzHrw>
X-ME-Received: <xmr:0FhKZLDLTXkunb-QlXRRJDR6Ehe_SmuSN408OOLNJHBMlIjxPnSlJj8UOXWzAy28UC65vyDGRyJXDTbqTK3op6oayTjpeb5fcu2fYBDbsqoE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeduiedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepleejteffveehgeegteekteeiudeiieeigeeigedtffehgeekhfejheefkefhveel
    necuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedune
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:0FhKZBdGQzbURWgN_Ql3aoEUZmzbGMeKZY2xR2T7bahU90yVmZMbng>
    <xmx:0FhKZCNGFVfoyoLAULqoewQaGI21jsgFuzBkz7t69-mREGKkfR7qRA>
    <xmx:0FhKZDnrPLQFA26x8UZ1PTNcT9rEdZ9bEoIXUFQyBm8-FWfmnh2Vjw>
    <xmx:0FhKZPpr5VO75xUxn6asm1TpJDKpdv3dCEKCyq3nJE60I64W5OP07A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Apr 2023 07:13:18 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id e81d3453 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 27 Apr 2023 11:12:49 +0000 (UTC)
Date:   Thu, 27 Apr 2023 13:13:16 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v2 3/8] fetch: fix missing from-reference when fetching
 HEAD:foo
Message-ID: <d1fb6eeae76bc550030475e40868b90a2ca6ce8c.1682593865.git.ps@pks.im>
References: <cover.1681906948.git.ps@pks.im>
 <cover.1682593865.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="URyxEUR5OWGvA+Za"
Content-Disposition: inline
In-Reply-To: <cover.1682593865.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--URyxEUR5OWGvA+Za
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
 t/t5574-fetch-output.sh | 25 +++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 18 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index c310d89878..7c64f0c562 100644
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
index 0e45c27007..b9dcdade63 100755
--- a/t/t5574-fetch-output.sh
+++ b/t/t5574-fetch-output.sh
@@ -54,6 +54,31 @@ test_expect_success 'fetch compact output' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'fetch output with HEAD and --dry-run' '
+	test_when_finished "rm -rf head" &&
+	git clone . head &&
+
+	git -C head fetch --dry-run origin HEAD >actual 2>&1 &&
+	cat >expect <<-EOF &&
+	From $(test-tool path-utils real_path .)/.
+	 * branch            HEAD       -> FETCH_HEAD
+	EOF
+	test_cmp expect actual &&
+
+	git -C head fetch origin HEAD >actual 2>&1 &&
+	test_cmp expect actual &&
+
+	git -C head fetch --dry-run origin HEAD:foo >actual 2>&1 &&
+	cat >expect <<-EOF &&
+	From $(test-tool path-utils real_path .)/.
+	 * [new ref]         HEAD       -> foo
+	EOF
+	test_cmp expect actual &&
+
+	git -C head fetch origin HEAD:foo >actual 2>&1 &&
+	test_cmp expect actual
+'
+
 test_expect_success '--no-show-forced-updates' '
 	mkdir forced-updates &&
 	(
--=20
2.40.1


--URyxEUR5OWGvA+Za
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRKWMsACgkQVbJhu7ck
PpRseA/+KjFxIMJ7vGvcbAVVLQtqE8lE6rXvx9saYX4fnATNK5m73KgbcblDIiXh
WRkN7KGpWQqGE56f71Grzlk9VyGjKmpobPh2s3akzKYpVpkzaXcEfLhEWbv5blEB
C1eRrlZJDr6LvYR1dCD4ULaMBof6KfUA488hquENkB1n1e/G7O/cHoB9NCennPe6
sP8MJViq9pvNTGBmpAmSGYWyIiVrUQ8Z6kAPxCO/BswcuSBrnh7Bs1v/C97XW0CA
V9mADZhcGgOBMJ6qyBLWWRRycZo8LJWkzrSbZUUUApFadN08VklZllWNmF55BxjY
GnWyFG8t704bVenoErKzucbfL8rc3DZ0K0MzhPioVseMRh/DuV3KVZKJ490SZl3B
6BsoJ+Og6oFKy29afU77WHp0lXz2AdtCLXHhe+A3zxCbyfqJiiJD3zOGRMer2AWX
4+0GbSZBIiuxQ7qc/oaNCJJcWzTsub7uc+MsrF9cpGb6aahMIQKc6DMrGCIL+M2f
Kk7fGmtKsEg+pwuqSDqUhUB8CBTbdO210FVfDqJ/hlq35GMPt+wrJmoV2Ony7Cbr
kH4P9lE6Ce7PtWmqcGd9FRGzLYPfAYFRQeUk5lBW1ALswrNGYDKex/VmWN2to43l
+9kZ5exPsPN8PsXRAGna5vCTrYwgw8fgnb5TZeSxUH+Km2j6V+A=
=NtlI
-----END PGP SIGNATURE-----

--URyxEUR5OWGvA+Za--
