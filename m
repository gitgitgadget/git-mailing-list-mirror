Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F0BC433E0
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 11:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C995E22473
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 11:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbhAKLHM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 06:07:12 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:46689 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728251AbhAKLHL (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Jan 2021 06:07:11 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id B2C6F28F1;
        Mon, 11 Jan 2021 06:05:37 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 11 Jan 2021 06:05:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=Q4mj6L5XP7Ty1ZXrnqQMEcHGhpD
        zodgpyC+xFckFGP0=; b=heg/yD2rX8D13oRYZBl944hG8/r8uuBRM5dxyZ5fLsj
        GlFzEotzSPKrkYIqgjaIMDCgkkGrjh/aXe2kpye8BOMO537611ALDOXAm+FiEtmC
        J4atqjyxeWg7m+2atccA2S42t0x7Akg8fNFNnB+XJRRvG5pbMQdWDMI0oAfsP2/n
        nu5/0Yzt0ru/N3IXjY0KYSkgOjC2A8qviKkfkPGMDlfhYCJRlOMGnP6IAtbMVxTV
        feDcUIMAoDOKZY9EM+BNLr9MIaVrhWfBfvS0hP9bnHzETQWJrKiWu9oq6q4TFgAf
        6ayetAxKvntwdXd3JnEAIXZwwnS2w2PgsZk64XhWPZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Q4mj6L
        5XP7Ty1ZXrnqQMEcHGhpDzodgpyC+xFckFGP0=; b=Ol+GIrq2oFRa8porlHrUUF
        9MK8kpVXG7ONr8Y7jTBo4zBiPLlm583i9azkwKyPu+8qZo/NbSTjSptQeuckCF3U
        nwOn8xkO/dOFEIHYyreuejW01k3RDFWBdGNepmEtsQaVi9bNZfXfIlpsNw8KcM24
        bspdN9ddA/JOApIFAGobg8MzOGy7SyHD084sdKuVLBCQi8aSylh+Uh8C3dHiCTca
        IM3QyF1NShtOWeIE88eU6wfYD3THVOAV4tfehmB3/XlI8A4Wf3x0C2f4zpPd7Hfu
        b55x+1/3DGLzsVfAbPpLSilxTYf69M5jcbqGa6Px0ro6CckDKh4UsHBpPZw5zajQ
        ==
X-ME-Sender: <xms:ADH8X1HyZ2izHagkWomS1Xnbqr87ANg3dLssEtYUMiqpLGYt0x2z_w>
    <xme:ADH8X6RzGOFU_rHyjY7O2pNez6y2S1bjLmzEJd4wwHvTDiS_0d-9EQPMbwbUsDRsH
    K_fJGj-uDy2ia53iw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdehuddgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepkeelrddugedrgeehrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:ADH8X0CKo0P7sDu6HBKMU70dshzBchF6DmOwPjcRlAsrHnuva17D6w>
    <xmx:ADH8Xy1Kgm-wCSYsTyfHDnaPjgIS-nRRxgfGMHZnCyo73c_EFN9zBA>
    <xmx:ADH8X6UMmf_XYaXz50ZS3vx5fZuSHXcaMIomdHcMkWCSedykHxMDVA>
    <xmx:ATH8X-3Sln-vbVYq8Z8rWQzApbq0PWvnJKnMt_MWDXUlMQsuRFrccw>
Received: from vm-mail.pks.im (dynamic-089-014-045-170.89.14.pool.telefonica.de [89.14.45.170])
        by mail.messagingengine.com (Postfix) with ESMTPA id 15752108005B;
        Mon, 11 Jan 2021 06:05:35 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 24cbc782 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 11 Jan 2021 11:05:34 +0000 (UTC)
Date:   Mon, 11 Jan 2021 12:05:33 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 5/5] fetch: implement support for atomic reference updates
Message-ID: <6a79e7adccbe4ee1d20352612a43295b3e7f37a7.1610362744.git.ps@pks.im>
References: <cover.1610027375.git.ps@pks.im>
 <cover.1610362744.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kfQpfVkRh6s4oKRK"
Content-Disposition: inline
In-Reply-To: <cover.1610362744.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--kfQpfVkRh6s4oKRK
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

This commit also changes the way we write FETCH_HEAD in case `--atomic`
is passed. Instead of writing changes as we go, we need to accumulate
all changes first and only commit them at the end when we know that all
reference updates succeeded. Ideally, we'd just do so via a temporary
file so that we don't need to carry all updates in-memory. This isn't
trivially doable though considering the `--append` mode, where we do not
truncate the file but simply append to it. And given that we support
concurrent processes appending to FETCH_HEAD at the same time without
any loss of data, seeding the temporary file with current contents of
FETCH_HEAD initially and then doing a rename wouldn't work either. So
this commit implements the simple strategy of buffering all changes and
appending them to the file on commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/fetch-options.txt |   4 +
 builtin/fetch.c                 |  46 ++++++++-
 t/t5510-fetch.sh                | 168 ++++++++++++++++++++++++++++++++
 3 files changed, 213 insertions(+), 5 deletions(-)

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
index 654c7a7eed..51c9930d06 100644
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
@@ -970,13 +973,23 @@ static void append_fetch_head(struct fetch_head *fetc=
h_head,
 			strbuf_addch(&fetch_head->buf, url[i]);
 	strbuf_addch(&fetch_head->buf, '\n');
=20
-	strbuf_write(&fetch_head->buf, fetch_head->fp);
-	strbuf_reset(&fetch_head->buf);
+	/*
+	 * When using an atomic fetch, we do not want to update FETCH_HEAD if
+	 * any of the reference updates fails. We thus have to write all
+	 * updates to a buffer first and only commit it as soon as all
+	 * references have been successfully updated.
+	 */
+	if (!atomic_fetch) {
+		strbuf_write(&fetch_head->buf, fetch_head->fp);
+		strbuf_reset(&fetch_head->buf);
+	}
 }
=20
 static void commit_fetch_head(struct fetch_head *fetch_head)
 {
-	/* Nothing to commit yet. */
+	if (!fetch_head->fp || !atomic_fetch)
+		return;
+	strbuf_write(&fetch_head->buf, fetch_head->fp);
 }
=20
 static void close_fetch_head(struct fetch_head *fetch_head)
@@ -1003,7 +1016,8 @@ static int store_updated_refs(const char *raw_url, co=
nst char *remote_name,
 	struct fetch_head fetch_head;
 	struct commit *commit;
 	int url_len, i, rc =3D 0;
-	struct strbuf note =3D STRBUF_INIT;
+	struct strbuf note =3D STRBUF_INIT, err =3D STRBUF_INIT;
+	struct ref_transaction *transaction =3D NULL;
 	const char *what, *kind;
 	struct ref *rm;
 	char *url;
@@ -1029,6 +1043,14 @@ static int store_updated_refs(const char *raw_url, c=
onst char *remote_name,
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
@@ -1105,7 +1127,7 @@ static int store_updated_refs(const char *raw_url, co=
nst char *remote_name,
=20
 			strbuf_reset(&note);
 			if (ref) {
-				rc |=3D update_local_ref(ref, NULL, what,
+				rc |=3D update_local_ref(ref, transaction, what,
 						       rm, &note, summary_width);
 				free(ref);
 			} else if (write_fetch_head || dry_run) {
@@ -1131,6 +1153,14 @@ static int store_updated_refs(const char *raw_url, c=
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
 	if (!rc)
 		commit_fetch_head(&fetch_head);
=20
@@ -1150,6 +1180,8 @@ static int store_updated_refs(const char *raw_url, co=
nst char *remote_name,
=20
  abort:
 	strbuf_release(&note);
+	strbuf_release(&err);
+	ref_transaction_free(transaction);
 	free(url);
 	close_fetch_head(&fetch_head);
 	return rc;
@@ -1961,6 +1993,10 @@ int cmd_fetch(int argc, const char **argv, const cha=
r *prefix)
 			die(_("--filter can only be used with the remote "
 			      "configured in extensions.partialclone"));
=20
+		if (atomic_fetch)
+			die(_("--atomic can only be used when fetching "
+			      "from one remote"));
+
 		if (stdin_refspecs)
 			die(_("--stdin can only be used when fetching "
 			      "from one remote"));
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 2013051a64..109d15be98 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -176,6 +176,174 @@ test_expect_success 'fetch --prune --tags with refspe=
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
+	oid=3D$(git rev-parse atomic-branch) &&
+	echo "$oid" >expected &&
+
+	git -C atomic fetch --atomic origin &&
+	git -C atomic rev-parse origin/atomic-branch >actual &&
+	test_cmp expected actual &&
+	test $oid =3D "$(git -C atomic rev-parse --verify FETCH_HEAD)"
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
+	test_cmp expected actual &&
+	test_must_be_empty atomic/.git/FETCH_HEAD
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
+	test_cmp expected-refs actual-refs &&
+	test_must_be_empty atomic/.git/FETCH_HEAD
+'
+
+test_expect_success 'fetch --atomic --append appends to FETCH_HEAD' '
+	test_when_finished "rm -rf \"$D\"/atomic" &&
+
+	cd "$D" &&
+	git clone . atomic &&
+	oid=3D$(git rev-parse HEAD) &&
+
+	git branch atomic-fetch-head-1 &&
+	git -C atomic fetch --atomic origin atomic-fetch-head-1 &&
+	test_line_count =3D 1 atomic/.git/FETCH_HEAD &&
+
+	git branch atomic-fetch-head-2 &&
+	git -C atomic fetch --atomic --append origin atomic-fetch-head-2 &&
+	test_line_count =3D 2 atomic/.git/FETCH_HEAD &&
+	cp atomic/.git/FETCH_HEAD expected &&
+
+	write_script atomic/.git/hooks/reference-transaction <<-\EOF &&
+		exit 1
+	EOF
+
+	git branch atomic-fetch-head-3 &&
+	test_must_fail git -C atomic fetch --atomic --append origin atomic-fetch-=
head-3 &&
+	test_cmp expected atomic/.git/FETCH_HEAD
+'
+
 test_expect_success '--refmap=3D"" ignores configured refspec' '
 	cd "$TRASH_DIRECTORY" &&
 	git clone "$D" remote-refs &&
--=20
2.30.0


--kfQpfVkRh6s4oKRK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/8MPwACgkQVbJhu7ck
PpTxBBAAgQxARlkDmh+wYOUcValPCXiEV1impy1APf8POBHcugifYCgpyFrLwIuw
nNzSLqgOSF3LbKpFbM8wBWuzevKf0nIFW6ctTIaWxprtQni6hGBTKVyfWiIcnjlF
FvGvNVANAyOrVaH2FDH3SSHFrUQQI1p0Y+nokzOWGkZBzrmUwQvcYDiqYo2STsp/
oM5OZuSsU6sN3/2zTaoda4EzrvpGVBDNTyNYC3LduMXsLjfPmiq1VudB5v/Su76g
4ARrv/BZDl61mUR9DQz032mHXd6N7KStL8iPwK68WU0M0wS6lEvNyHoq/pSyNRdB
KWBsPC62Tcjph+pA6IScTT89DYqd/jSN5qWGJa2DQovKsPLR5PuOeqwqKojpzsUy
BGQnvjUXVIT5VOsyKqCLlEdix6SQwr9fE0Acmb15n+57EHIJSGdvnzC1Aj4FFHc2
B7ZolPIP0HUZTpwJU2J03zYCPOYfg6S+K54FP+UiUEBoHBrVbuUTog+VQ93PdrzL
x2Ovou7X2+T42msxz1anZNhSJjURVx4vwJeF+qL0D0fnPqiRi3sUrLs1kET4u2Wm
xUanRdyWX6IdTtJJwBBNWp86j5eomsprYUDG/GMeUSFwEckhoEf+uQenpG4V2hm5
1WNaVsq1siXNz4ZTgUKD50jnDjEjf2cKhwQcGsr1JoXP5/p1hew=
=ayw7
-----END PGP SIGNATURE-----

--kfQpfVkRh6s4oKRK--
