Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AE4C77B73
	for <git@archiver.kernel.org>; Wed, 19 Apr 2023 12:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbjDSMcP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Apr 2023 08:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbjDSMby (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2023 08:31:54 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E102916DD6
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 05:31:38 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 1B1C33200937;
        Wed, 19 Apr 2023 08:31:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 19 Apr 2023 08:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681907497; x=1681993897; bh=Zz
        2cabaXclVnL/zZPo/SpLNzTgDLgOWbLFQpPzOlKLM=; b=h3baep8WTHLCb1RM5z
        ogRF8U8kJGKhh+61Xh3KMOk9kl0sKYlldq1H8UAYlOyv93Z+XHMgjpAw1aWybeBI
        I6kFKX8NRsImFgLMDbiw7vd90AgQ5/R/X763yMHtAVb9g7E/HahkRW7U1Hx+agKo
        c/7c8J2+JGiBmylLVG/1Tbd5w+oynRu3LxAcgdRcLq8h/08WM8GfP7NLWBwejunG
        mMPutXuxDmep8aw0daI1wwG2ysXC9hKlP3fmQaKnqZsB+GxnYd6+hedZFE/OZM6r
        EhKIKhYiv18ucGiOM3sA3HvaHr1xK7ghgQNR88DynMVF56YOQ8oVOmiBD/4LU+22
        YmFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681907497; x=1681993897; bh=Zz2cabaXclVnL
        /zZPo/SpLNzTgDLgOWbLFQpPzOlKLM=; b=YQ87w99a0Zs6x5f9kRSo+xjtFyZQO
        6bCBxHOOSzV9IZHyra67J2XBUQkVaCIbTpra07REYgr2dhd98H8pO/g6N8g8U2l9
        I+hbIw7gCuVtuphgGeOmwVbhri+JyCRnVlgtDxWR1KKTApfH7xFTPXwCckytz9D4
        xXdNo9r9e0ptyhByDWCZgiAhvyhQv7atCctdAj0lDNzM/XtKYig9RdFo1JKj2jJv
        2c/HwA92EAavUGIRR9w3Z9jWJxWmbia+qgF+TyBLspTN2xR9QObaNGQwVdQ5/yEx
        37MGJ/mLtFBoaRf024e+1/9BA+c5lyRLNrwbh5iNatttOKflt2k4QEO7A==
X-ME-Sender: <xms:Kd8_ZPqZmOnFU70zu_iraIfQDXMyOoIm6zodKf2is45JuJsznZFIkw>
    <xme:Kd8_ZJpHvpZO3SYTggf2SeaEJE5MLVYp2uMr4q-UV-zw5P9Yla8FV7B74bJ2QRNUL
    T400Pcpe5-vY1t35g>
X-ME-Received: <xmr:Kd8_ZMMwsajY3S6oo-oBZOphm6K1b0tr8mzSn1lwDClxVu0SRQwnWWxmS4eh_0Y4GvXgzkng76wu0mDp_eAhogJR9FqulvkhB4TUZCqgn2jIZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedttddgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeljeetffevheeggeetkeetieduieeiie
    egieegtdffheegkefhjeehfeekhfevleenucffohhmrghinhepghhithhhuhgsrdgtohhm
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:Kd8_ZC5h6FfiWZVyqYEyK1GYp40yQ98YAbXEHmXAqB9XCrU-NKUHxw>
    <xmx:Kd8_ZO547Osra3rdDDLmdWXcanlP4FAwvAKPBB9rgCX3nwkoR80S9g>
    <xmx:Kd8_ZKjto0ghHPERYXSFuhq78uX8dsYbGZYbmayRF79nN_-nsNgoZg>
    <xmx:Kd8_ZDiDnB27fyGJHZwV2WbjmT4pRtmPHyJKvn1orkCqrHkhhrei8A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Apr 2023 08:31:36 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 99cdbfe5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 19 Apr 2023 12:31:24 +0000 (UTC)
Date:   Wed, 19 Apr 2023 14:31:35 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 3/8] fetch: fix missing from-reference when fetching HEAD:foo
Message-ID: <596e12f03a296d753ee6fe8face9522edc9e397e.1681906948.git.ps@pks.im>
References: <cover.1681906948.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="S0NEOrNx6Xj1E63+"
Content-Disposition: inline
In-Reply-To: <cover.1681906948.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--S0NEOrNx6Xj1E63+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When displaying reference updates, we print a line that looks similar to
the following:

```
 * branch               master          -> master
```

The "branch" bit changes depending on what kind of reference we're
updating, while both of the right-hand references are computed by
stripping well-known prefixes like "refs/heads/" or "refs/tags".

The logic is kind of intertwined though and not easy to follow: we
precompute both the kind (e.g. "branch") and the what, which is the
abbreviated remote reference name, in `store_updated_refs()` and then
pass it down the call chain to `display_ref_update()`.

There is a set of different cases here:

    - When the remote reference name is "HEAD" we assume no kind and
      will thus instead print "[new ref]". We keep what at the empty
      string.

    - When the remote reference name has a well-known prefix then the
      kind would be "branch", "tag" or "remote-tracking branch". The
      what is the reference with the well-known prefix stripped and in
      fact matches the output that `prettify_refname()` would return.

    - Otherwise, we'll again assume no kind and keep the what set to the
      fully qualified reference name.

Now there is a bug with the first case here, where the remote reference
name is "HEAD". As noted, "what" will be set to the empty string. And
that seems to be intentional because we also use this information to
update the FETCH_HEAD, and in case we're updating HEAD we seemingly
don't want to append that to our FETCH_HEAD value.

But as mentioned, we also use this value to display reference updates.
And while the call to `display_ref_update()` correctly figures out that
we meant "HEAD" when `what` is empty, the call to `update_local_ref()`
doesn't. `update_local_ref()` will then call `display_ref_update()` with
the empty string and cause the following broken output:

```
$ git fetch --dry-run origin HEAD:foo
=46rom https://github.com/git/git
 * [new ref]                          -> foo
```

The HEAD string is clearly missing from the left-hand side of the arrow,
which is further stressed by the point that the following commands work
as expected:

```
$ git fetch --dry-run origin HEAD
=46rom https://github.com/git/git
 * branch                  HEAD       -> FETCH_HEAD

$ git fetch --dry-run origin master
=46rom https://github.com/git/git
 * branch                  master     -> FETCH_HEAD
 * branch                  master     -> origin/master
```

Fix this bug by instead unconditionally passing the full reference name
to `display_ref_update()` which learns to call `prettify_refname()` on
it. This does fix the above bug and is otherwise functionally the same
as `prettify_refname()` would only ever strip the well-known prefixes
just as intended. So at the same time, this also simplifies the code a
bit.

Note that this patch also changes formatting of the block that computes
the "kind" and "what" variables. This is done on purpose so that it is
part of the diff, hopefully making the change easier to comprehend.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c         | 37 +++++++++++++++++++------------------
 t/t5574-fetch-output.sh | 19 +++++++++++++++++++
 2 files changed, 38 insertions(+), 18 deletions(-)

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
index 0e45c27007..55f0f05b6a 100755
--- a/t/t5574-fetch-output.sh
+++ b/t/t5574-fetch-output.sh
@@ -54,6 +54,25 @@ test_expect_success 'fetch compact output' '
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
+	git -C head fetch --dry-run origin HEAD:foo >actual 2>&1 &&
+	cat >expect <<-EOF &&
+	From $(test-tool path-utils real_path .)/.
+	 * [new ref]         HEAD       -> foo
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success '--no-show-forced-updates' '
 	mkdir forced-updates &&
 	(
--=20
2.40.0


--S0NEOrNx6Xj1E63+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQ/3yYACgkQVbJhu7ck
PpTF1BAAqDNI6IMSgPVRmxLZCQmaT8xW1Frm9uLgZbwm406qMi8kDV0cu6llaV75
4hzi/JUQsrZLRMAx22029N90uPog05Gt30RTEngefU/EtcKAu2dt0KIFMeVe/8+i
M2+ptsOIgcv6ndFO6e5pXuVtMtuJRZwIYpiPUs5Z+LLvM87JmUu+CLAiJ7aOC/5p
bveSARy7WrkHikNE3KCVw7KxOEpnOTOUieqjQQ7k8vGix2gwOqaRxVtiCwiRWU+d
hDuKxlLvHVt07nkXK96cqT9wttUZ5n1xw5SL0a8axWtiI093OUjqJjLVkPrkgKnt
LO4XJ+T4wO7CJxEtYQSJ7vOPd71lnCM8YhoWOfpC/nva2qNfBh5L9gFa7G07NI11
fXtVFJ1wvx5TQJU9F5MD6FawVINDfyAtGVZ4BUHYM838pX87bk3/8OnHT1g9Rguw
jMe3CE1o9twlHOrpsWUFMwwLZpFqucfoAoB34VH7mKlSB8Mf+8yc8SpzWPpZb9pY
iFtpRsZs6qBrRlX3v3b/ABiu3H5aat35egMtawWfclTLBIupi6Zue4GY4eE7OA+2
Dn/PsmE9xHtZs6lUSY0H3iWr0IAYSVOIibFsKE1eTj/xq7OWZoS68d3GYNqVYd1j
mMhFbWCfOSFk7FVy1rVZjqI2WMTWoo+HKXvyxN3RLtvjbUaqefo=
=CyPt
-----END PGP SIGNATURE-----

--S0NEOrNx6Xj1E63+--
