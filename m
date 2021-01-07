Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F160C433E0
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 13:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 336492312A
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 13:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbhAGNwx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 08:52:53 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:50737 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728445AbhAGNwx (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 Jan 2021 08:52:53 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 44E6F5C0064
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 08:51:46 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 07 Jan 2021 08:51:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=fm3; bh=YHi/SVROH3BReFet9Rn1++u14YagPfOR0FbZ/huD
        2mA=; b=MoMaSPFSY0kf/VX1udIWxzoVDPBt9JMdB/VzbEZahjVMvCzxWjvEgMlj
        7ujVKV2eLz+Ad9gro1kq7T6z5leqmk3uXDZuNZTShzfWTxlTk0s2hWd2eF/KhBPb
        EquyeEoegGZvW9C2SZbKjZHaq99JJa67qC7APFABnhJ+LR5xtPMBTy1G+QMJjgu3
        M43vpA/JpKQLQ/v26FYIxbrlbK5ijqETq/YLt8IYgv0ixupKH5gHu3MWQseM0/i4
        szq11SjPZzJK6m4EHBnp77xjRoh5qa0UIOR9UKYUuUVVrO9AMjLvydQs353/6Umr
        1hRKFgwl5GTqoIW0y3DoqHJxwYRNGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=YHi/SV
        ROH3BReFet9Rn1++u14YagPfOR0FbZ/huD2mA=; b=hoata4MIrvSw51yU8TQbdV
        UmgxuY1SMico6g7CbDYvgqTYpjEZl1LHYMdQuXBenQg64m7H2pl3SPlP0Bezgm9B
        z7hhKozzX684AS2bV3GrdeEYy4dZYq+CKOpoBIgSWJHjg7iDCwiRCHDW4pItDI0g
        gowfW1GjYzlkw5CCbyoFfkg6QAmCyE82NKx8taz3iTOjso0FwzavBho2Njbyzxwy
        ifZylslSAQxNAlam8gPZdjpF/tmiheHdFowUgdhZtoxebKCoxIOJbAmsTchJdBe8
        46rTTFgVJueaR7B8OI0twN7AQTu4klvJ2DDZON24ycZwLyYgmGrlmOlsGyXnA21Q
        ==
X-ME-Sender: <xms:8hH3X5_THySH8IO2fc-3MP2IDpNJgxuYHybJzCP8ZjmP6OGsLz-VZg>
    <xme:8hH3Xy_-QAFakMRtYv3kiTvY-XDudrDGDQyBkPPNinnfihYSNR2XYUgQ1JOxLbqKY
    qrmLDnjzIBQAX7jnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdegvddgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecukfhppeejjedrudefrdefgedrvdefvdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhm
X-ME-Proxy: <xmx:8hH3X4sT8trjJdQuaLuTNzNN86BOjxX4fpshx2pk8eCFlEkyBk2rmA>
    <xmx:8hH3X1oqDnnWJ2GO8c4jCGyWdWz8jffT5QS3Om1HncQMcTwoYZHKEA>
    <xmx:8hH3X1kt54OMuJBuzHOhYdfeQhYxymh_XXMOb2cBCBpH3qrwKkbU1g>
    <xmx:8hH3Xzo6LUuwP1fpNOJTLMEAicUUFq8cpHVM9gNf0FeZIZotQgLNmA>
Received: from vm-mail.pks.im (dynamic-077-013-034-232.77.13.pool.telefonica.de [77.13.34.232])
        by mail.messagingengine.com (Postfix) with ESMTPA id CD72A108005B
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 08:51:45 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 6719ab77 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Thu, 7 Jan 2021 13:51:45 +0000 (UTC)
Date:   Thu, 7 Jan 2021 14:51:44 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 2/2] fetch: implement support for atomic reference updates
Message-ID: <4807344e92bedbac37243434850da1f0787ad496.1610027375.git.ps@pks.im>
References: <cover.1610027375.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5RhYjaPrQtw61DiQ"
Content-Disposition: inline
In-Reply-To: <cover.1610027375.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--5RhYjaPrQtw61DiQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When executing a fetch, then git will currently allocate one reference
transaction per reference update and directly commit it. This means that
fetches are non-atomic: even if some of the reference updates fail,
others may still succeed and modify local references.

This is fine in many scenarios, but this strategy has its downsides.

- The view of remote references may be inconsistent and may show a
  bastardized state of the remote repository.

- Batching together updates may improve performance in certain
  scenarios. While the impact probably isn't as pronounced with loose
  references, the upcoming reftable backend may benefit as it needs to
  write less files in case the update is batched.

- The reference-update hook is currently being executed twice per
  updated reference. While this doesn't matter when there is no such
  hook, we have seen severe performance regressions when doing a
  git-fetch(1) with reference-transaction hook when the remote
  repository has hundreds of thousands of references.

Similar to `git push --atomic`, this commit thus introduces atomic
fetches. Instead of allocating one reference transaction per updated
reference, it causes us to only allocate a single transaction and commit
it as soon as all updates were received. If locking of any reference
fails, then we abort the complete transaction and don't update any
reference, which gives us an all-or-nothing fetch.

Note that this may not completely fix the first of above downsides, as
the consistent view also depends on the server-side. If the server
doesn't have a consistent view of its own references during the
reference negotiation phase, then the client would get the same
inconsistent view the server has. This is a separate problem though and,
if it actually exists, can be fixed at a later point.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/fetch-options.txt |   4 +
 builtin/fetch.c                 |  26 +++++-
 t/t5510-fetch.sh                | 139 ++++++++++++++++++++++++++++++++
 3 files changed, 167 insertions(+), 2 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.=
txt
index 2bf77b46fd..07783deee3 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -7,6 +7,10 @@
 	existing contents of `.git/FETCH_HEAD`.  Without this
 	option old data in `.git/FETCH_HEAD` will be overwritten.
=20
+--atomic::
+	Use an atomic transaction to update local refs. Either all refs are
+	updated, or on error, no refs are updated.
+
 --depth=3D<depth>::
 	Limit fetching to the specified number of commits from the tip of
 	each remote branch history. If fetching to a 'shallow' repository
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 020a977bc7..5675ae4ec3 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -63,6 +63,7 @@ static int enable_auto_gc =3D 1;
 static int tags =3D TAGS_DEFAULT, unshallow, update_shallow, deepen;
 static int max_jobs =3D -1, submodule_fetch_jobs_config =3D -1;
 static int fetch_parallel_config =3D 1;
+static int atomic_fetch;
 static enum transport_family family;
 static const char *depth;
 static const char *deepen_since;
@@ -144,6 +145,8 @@ static struct option builtin_fetch_options[] =3D {
 		 N_("set upstream for git pull/fetch")),
 	OPT_BOOL('a', "append", &append,
 		 N_("append to .git/FETCH_HEAD instead of overwriting")),
+	OPT_BOOL(0, "atomic", &atomic_fetch,
+		 N_("use atomic transaction to update references")),
 	OPT_STRING(0, "upload-pack", &upload_pack, N_("path"),
 		   N_("path to upload pack on remote end")),
 	OPT__FORCE(&force, N_("force overwrite of local reference"), 0),
@@ -926,7 +929,8 @@ static int store_updated_refs(const char *raw_url, cons=
t char *remote_name,
 	FILE *fp;
 	struct commit *commit;
 	int url_len, i, rc =3D 0;
-	struct strbuf note =3D STRBUF_INIT;
+	struct strbuf note =3D STRBUF_INIT, err =3D STRBUF_INIT;
+	struct ref_transaction *transaction =3D NULL;
 	const char *what, *kind;
 	struct ref *rm;
 	char *url;
@@ -955,6 +959,14 @@ static int store_updated_refs(const char *raw_url, con=
st char *remote_name,
 		}
 	}
=20
+	if (atomic_fetch) {
+		transaction =3D ref_transaction_begin(&err);
+		if (!transaction) {
+			error("%s", err.buf);
+			goto abort;
+		}
+	}
+
 	prepare_format_display(ref_map);
=20
 	/*
@@ -1048,7 +1060,7 @@ static int store_updated_refs(const char *raw_url, co=
nst char *remote_name,
=20
 			strbuf_reset(&note);
 			if (ref) {
-				rc |=3D update_local_ref(ref, NULL, what,
+				rc |=3D update_local_ref(ref, transaction, what,
 						       rm, &note, summary_width);
 				free(ref);
 			} else if (write_fetch_head || dry_run) {
@@ -1074,6 +1086,14 @@ static int store_updated_refs(const char *raw_url, c=
onst char *remote_name,
 		}
 	}
=20
+	if (!rc && transaction) {
+		rc =3D ref_transaction_commit(transaction, &err);
+		if (rc) {
+			error("%s", err.buf);
+			goto abort;
+		}
+	}
+
 	if (rc & STORE_REF_ERROR_DF_CONFLICT)
 		error(_("some local refs could not be updated; try running\n"
 		      " 'git remote prune %s' to remove any old, conflicting "
@@ -1090,6 +1110,8 @@ static int store_updated_refs(const char *raw_url, co=
nst char *remote_name,
=20
  abort:
 	strbuf_release(&note);
+	strbuf_release(&err);
+	ref_transaction_free(transaction);
 	free(url);
 	fclose(fp);
 	return rc;
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 2013051a64..57da3ab2b3 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -176,6 +176,145 @@ test_expect_success 'fetch --prune --tags with refspe=
c prunes based on refspec'
 	git rev-parse sometag
 '
=20
+test_expect_success 'fetch --atomic works with a single branch' '
+	test_when_finished "rm -rf \"$D\"/atomic" &&
+
+	cd "$D" &&
+	git clone . atomic &&
+	git branch atomic-branch &&
+	git rev-parse atomic-branch >expected &&
+
+	git -C atomic fetch --atomic origin &&
+	git -C atomic rev-parse origin/atomic-branch >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'fetch --atomic works with multiple branches' '
+	test_when_finished "rm -rf \"$D\"/atomic" &&
+
+	cd "$D" &&
+	git clone . atomic &&
+	git branch atomic-branch-1 &&
+	git branch atomic-branch-2 &&
+	git branch atomic-branch-3 &&
+	git rev-parse refs/heads/atomic-branch-1 refs/heads/atomic-branch-2 refs/=
heads/atomic-branch-3 >actual &&
+
+	git -C atomic fetch --atomic origin &&
+	git -C atomic rev-parse refs/remotes/origin/atomic-branch-1 refs/remotes/=
origin/atomic-branch-2 refs/remotes/origin/atomic-branch-3 >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'fetch --atomic works with mixed branches and tags' '
+	test_when_finished "rm -rf \"$D\"/atomic" &&
+
+	cd "$D" &&
+	git clone . atomic &&
+	git branch atomic-mixed-branch &&
+	git tag atomic-mixed-tag &&
+	git rev-parse refs/heads/atomic-mixed-branch refs/tags/atomic-mixed-tag >=
actual &&
+
+	git -C atomic fetch --tags --atomic origin &&
+	git -C atomic rev-parse refs/remotes/origin/atomic-mixed-branch refs/tags=
/atomic-mixed-tag >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'fetch --atomic prunes references' '
+	test_when_finished "rm -rf \"$D\"/atomic" &&
+
+	cd "$D" &&
+	git branch atomic-prune-delete &&
+	git clone . atomic &&
+	git branch --delete atomic-prune-delete &&
+	git branch atomic-prune-create &&
+	git rev-parse refs/heads/atomic-prune-create >actual &&
+
+	git -C atomic fetch --prune --atomic origin &&
+	test_must_fail git -C atomic rev-parse refs/remotes/origin/atomic-prune-d=
elete &&
+	git -C atomic rev-parse refs/remotes/origin/atomic-prune-create >expected=
 &&
+	test_cmp expected actual
+'
+
+test_expect_success 'fetch --atomic aborts with non-fast-forward update' '
+	test_when_finished "rm -rf \"$D\"/atomic" &&
+
+	cd "$D" &&
+	git branch atomic-non-ff &&
+	git clone . atomic &&
+	git rev-parse HEAD >actual &&
+
+	git branch atomic-new-branch &&
+	parent_commit=3D$(git rev-parse atomic-non-ff~) &&
+	git update-ref refs/heads/atomic-non-ff $parent_commit &&
+
+	test_must_fail git -C atomic fetch --atomic origin refs/heads/*:refs/remo=
tes/origin/* &&
+	test_must_fail git -C atomic rev-parse refs/remotes/origin/atomic-new-bra=
nch &&
+	git -C atomic rev-parse refs/remotes/origin/atomic-non-ff >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'fetch --atomic executes a single reference transactio=
n only' '
+	test_when_finished "rm -rf \"$D\"/atomic" &&
+
+	cd "$D" &&
+	git clone . atomic &&
+	git branch atomic-hooks-1 &&
+	git branch atomic-hooks-2 &&
+	head_oid=3D$(git rev-parse HEAD) &&
+
+	cat >expected <<-EOF &&
+		prepared
+		$ZERO_OID $head_oid refs/remotes/origin/atomic-hooks-1
+		$ZERO_OID $head_oid refs/remotes/origin/atomic-hooks-2
+		committed
+		$ZERO_OID $head_oid refs/remotes/origin/atomic-hooks-1
+		$ZERO_OID $head_oid refs/remotes/origin/atomic-hooks-2
+	EOF
+
+	rm -f atomic/actual &&
+	write_script atomic/.git/hooks/reference-transaction <<-\EOF &&
+		( echo "$*" && cat ) >>actual
+	EOF
+
+	git -C atomic fetch --atomic origin &&
+	test_cmp expected atomic/actual
+'
+
+test_expect_success 'fetch --atomic aborts all reference updates if hook a=
borts' '
+	test_when_finished "rm -rf \"$D\"/atomic" &&
+
+	cd "$D" &&
+	git clone . atomic &&
+	git branch atomic-hooks-abort-1 &&
+	git branch atomic-hooks-abort-2 &&
+	git branch atomic-hooks-abort-3 &&
+	git tag atomic-hooks-abort &&
+	head_oid=3D$(git rev-parse HEAD) &&
+
+	cat >expected <<-EOF &&
+		prepared
+		$ZERO_OID $head_oid refs/remotes/origin/atomic-hooks-abort-1
+		$ZERO_OID $head_oid refs/remotes/origin/atomic-hooks-abort-2
+		$ZERO_OID $head_oid refs/remotes/origin/atomic-hooks-abort-3
+		$ZERO_OID $head_oid refs/tags/atomic-hooks-abort
+		aborted
+		$ZERO_OID $head_oid refs/remotes/origin/atomic-hooks-abort-1
+		$ZERO_OID $head_oid refs/remotes/origin/atomic-hooks-abort-2
+		$ZERO_OID $head_oid refs/remotes/origin/atomic-hooks-abort-3
+		$ZERO_OID $head_oid refs/tags/atomic-hooks-abort
+	EOF
+
+	rm -f atomic/actual &&
+	write_script atomic/.git/hooks/reference-transaction <<-\EOF &&
+		( echo "$*" && cat ) >>actual
+		exit 1
+	EOF
+
+	git -C atomic for-each-ref >expected-refs &&
+	test_must_fail git -C atomic fetch --tags --atomic origin &&
+	git -C atomic for-each-ref >actual-refs &&
+	test_cmp expected-refs actual-refs
+'
+
 test_expect_success '--refmap=3D"" ignores configured refspec' '
 	cd "$TRASH_DIRECTORY" &&
 	git clone "$D" remote-refs &&
--=20
2.30.0


--5RhYjaPrQtw61DiQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/3Ee8ACgkQVbJhu7ck
PpTIHQ/+I4cQcu5sbS6tGabMOc8W6VsyLjCCMphtRuxkxy5S9A5VU9atKXNDFoKi
D+xwQdhuKXONA/PQhZfkohbfk+8ZinLaXGFjlu5ERhrVNE/Hx1DmQ2RQTYmaz5LZ
BILrqdJgjlhf3hrqLbjYRhLacyPqVLQCwQ6OgAR68wOLshpO0CGiV+xwcf2HIb9p
nEm9q0+xL6RmZRQY6zEo0LKBwh66TwkWhppLr0LOwvvXUV0GzKodgE1nxR8qPDH3
YdhZ88n8ciZFVbTJwjZFm8jfIRicvYXt+UrCdhe24QKDVUz9kq3rebHysKIuuH/m
5auwYvT43DS56Hdph7n5JGm6PinLOPOqLzJEyM+ftmNmcTeiMglzywwZh1zAThTv
wPZ3Ff3zN7JreEap4rUdRln4/GANKtAGAawzID7l2mxa9J4ngkL3rjlePhAGF4P+
NmRJQNgIaGq7POTWrrMcrloHSzyHC0OHSXQOY1lZXYuRjoydwCSGxIzy9lNwDQlE
dOHQ+SKx3Tqrp9m/dzst8d+4RAIDW/T6IAOoea5ksOZSSRIspgxNSD9dyWClp8Sg
3ouIKqVQ4aBVeMAeNzzsfXL1dnzgEr/p7XjTZgN967IZneqSwNIP6C0tQt6jAFw2
dZ+0gJB4ZvBbBM+JMs0z0JN8EEeXvBEOVshI+89IxIIj51jqQyY=
=gx5t
-----END PGP SIGNATURE-----

--5RhYjaPrQtw61DiQ--
