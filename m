Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0565C433E6
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 12:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6B1823975
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 12:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbhAHMMS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 07:12:18 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:35189 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726844AbhAHMMR (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 8 Jan 2021 07:12:17 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 81A635C022E;
        Fri,  8 Jan 2021 07:11:30 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 08 Jan 2021 07:11:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=C/+h0Cjf8a4ft6yhhwowsLZkE4Z
        /+BP1ScLGLWUrj0s=; b=P9kpYeyPppWO2eQ16p8/3jZltZWh9JQN0Y+SS9r3zAq
        V+cMa1TFzzpVzv94+TAsAoW1mgJzQVijN4pdXKoJ4MBRNT2z7yIkcjSkq0tyealu
        q6VGm5NCpredT5J3J9HrmqXjg6BHP6u2nfhECy4nV4K+lg9lgNl3pM8cDASjE1DQ
        rzSXCr3AUFWjvdrsgllm5hVhH3iUJ0XcAvLFWQ5v51na8uYjpSfM2jaqI8tcqmHX
        xT3ZSC9Ccy4NYbrCfbQTyvvqbUyZzSOFKu1ag1H99jYVYs+tOLuUon6vhw5Lb0M/
        bJwkpt+OshUMKfa4nrhLiEvAFjZG5yC/jtgI25QJb6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=C/+h0C
        jf8a4ft6yhhwowsLZkE4Z/+BP1ScLGLWUrj0s=; b=KKEhRiLS0EzmTMhyPaSyWa
        pAuTS/q4Wskrmx7crJHCYaTHmy7a4bJRTTOwheUqHS6J9dDChXPKtQvsBbVslvl/
        Fah4zzioez/w3cHIQ2NmvLMSWoLAL8KAjCsItZKT1ehu2kxAbC/wdatYDa3jyij1
        1pugi+N0CHponqSaRxxHKiETIf+VLdO25th3R+x2BXKuUCY2oORvgx9ecVfEPsj/
        DQORaazMh79ye1GLDj13jlSzWfU6henjHQCvgt5rZKbqktvlhyZdn3Ask3Tws6Nu
        TakIuIhWVDqMjNCuao5DZC4ECuUzpy9zWRYGgZMS5EsB1tZXZLHOsyxz0qYI1hoQ
        ==
X-ME-Sender: <xms:8kv4X_qeZKAaPmvWZ5JWlV6d08uogxGtwhpHWXVvpRnDEOQBRoG4sw>
    <xme:8kv4X5poGlRMlaPdHKUTwEXSaKQ36mYmDbMLe972JvvXqkK5z_GA_0q1pHJIBPoO_
    0FVDIaN2DmfQqUe-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeggedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeejrddukeefrdegrddvgeehnecuvehluhhsthgvrhfuihiivgepgeenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:8kv4X8M9kXqFuYxGSsC4dPgqeNLy2n9VXLOUakeZsbZvsiyI4fvXDw>
    <xmx:8kv4Xy7q-_t6BS68qClC1-bAoXQkoF5aJsN9hwaZkj6285esoPbwdg>
    <xmx:8kv4X-7NU6HXxkTeWPDY7XnUENhg7_VHKayqCL3adpk_u1FC68lRxg>
    <xmx:8kv4XzgwkTQyI3rnODwWzfSq3N3g7QMa94Ob1jZQaXxrB1wOomaV-g>
Received: from vm-mail.pks.im (x4db704f5.dyn.telefonica.de [77.183.4.245])
        by mail.messagingengine.com (Postfix) with ESMTPA id DB85E24005B;
        Fri,  8 Jan 2021 07:11:29 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 095f387f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 8 Jan 2021 12:11:29 +0000 (UTC)
Date:   Fri, 8 Jan 2021 13:11:28 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 4/4] fetch: implement support for atomic reference updates
Message-ID: <53705281b60285837905137f45fc8607012d2f19.1610107599.git.ps@pks.im>
References: <cover.1610027375.git.ps@pks.im>
 <cover.1610107599.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XPeJQTfk1XrtXPMq"
Content-Disposition: inline
In-Reply-To: <cover.1610107599.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--XPeJQTfk1XrtXPMq
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
 builtin/fetch.c                 |  66 ++++++++++---
 t/t5510-fetch.sh                | 168 ++++++++++++++++++++++++++++++++
 3 files changed, 227 insertions(+), 11 deletions(-)

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
index 654e0bb520..e3446fc493 100644
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
@@ -913,6 +916,7 @@ static int iterate_ref_map(void *cb_data, struct object=
_id *oid)
=20
 struct fetch_head {
 	FILE *fp;
+	struct strbuf buf;
 };
=20
 static int open_fetch_head(struct fetch_head *fetch_head)
@@ -922,6 +926,7 @@ static int open_fetch_head(struct fetch_head *fetch_hea=
d)
 	if (!write_fetch_head)
 		return 0;
=20
+	strbuf_init(&fetch_head->buf, 0);
 	fetch_head->fp =3D fopen(filename, "a");
 	if (!fetch_head->fp)
 		return error_errno(_("cannot open %s"), filename);
@@ -938,19 +943,34 @@ static void append_fetch_head(struct fetch_head *fetc=
h_head, const char *old_oid
 	if (!write_fetch_head)
 		return;
=20
-	fprintf(fetch_head->fp, "%s\t%s\t%s",
-		old_oid, merge_status_marker, note);
-	for (i =3D 0; i < url_len; ++i)
-		if ('\n' =3D=3D url[i])
-			fputs("\\n", fetch_head->fp);
-		else
-			fputc(url[i], fetch_head->fp);
-	fputc('\n', fetch_head->fp);
+	/*
+	 * When using an atomic fetch, we do not want to update FETCH_HEAD if
+	 * any of the reference updates fails. We thus have to write all
+	 * updates to a buffer first and only commit it as soon as all
+	 * references have been successfully updated.
+	 */
+	if (atomic_fetch) {
+		strbuf_addf(&fetch_head->buf, "%s\t%s\t%s",
+			    old_oid, merge_status_marker, note);
+		strbuf_add(&fetch_head->buf, url, url_len);
+		strbuf_addch(&fetch_head->buf, '\n');
+	} else {
+		fprintf(fetch_head->fp, "%s\t%s\t%s",
+			old_oid, merge_status_marker, note);
+		for (i =3D 0; i < url_len; ++i)
+			if ('\n' =3D=3D url[i])
+				fputs("\\n", fetch_head->fp);
+			else
+				fputc(url[i], fetch_head->fp);
+		fputc('\n', fetch_head->fp);
+	}
 }
=20
 static void commit_fetch_head(struct fetch_head *fetch_head)
 {
-	/* Nothing to commit yet. */
+	if (!write_fetch_head || !atomic_fetch)
+		return;
+	strbuf_write(&fetch_head->buf, fetch_head->fp);
 }
=20
 static void close_fetch_head(struct fetch_head *fetch_head)
@@ -959,6 +979,7 @@ static void close_fetch_head(struct fetch_head *fetch_h=
ead)
 		return;
=20
 	fclose(fetch_head->fp);
+	strbuf_release(&fetch_head->buf);
 }
=20
 static const char warn_show_forced_updates[] =3D
@@ -976,7 +997,8 @@ static int store_updated_refs(const char *raw_url, cons=
t char *remote_name,
 	struct fetch_head fetch_head;
 	struct commit *commit;
 	int url_len, i, rc =3D 0;
-	struct strbuf note =3D STRBUF_INIT;
+	struct strbuf note =3D STRBUF_INIT, err =3D STRBUF_INIT;
+	struct ref_transaction *transaction =3D NULL;
 	const char *what, *kind;
 	struct ref *rm;
 	char *url;
@@ -1002,6 +1024,14 @@ static int store_updated_refs(const char *raw_url, c=
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
@@ -1089,7 +1119,7 @@ static int store_updated_refs(const char *raw_url, co=
nst char *remote_name,
=20
 			strbuf_reset(&note);
 			if (ref) {
-				rc |=3D update_local_ref(ref, NULL, what,
+				rc |=3D update_local_ref(ref, transaction, what,
 						       rm, &note, summary_width);
 				free(ref);
 			} else if (write_fetch_head || dry_run) {
@@ -1115,6 +1145,14 @@ static int store_updated_refs(const char *raw_url, c=
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
@@ -1134,6 +1172,8 @@ static int store_updated_refs(const char *raw_url, co=
nst char *remote_name,
=20
  abort:
 	strbuf_release(&note);
+	strbuf_release(&err);
+	ref_transaction_free(transaction);
 	free(url);
 	close_fetch_head(&fetch_head);
 	return rc;
@@ -1945,6 +1985,10 @@ int cmd_fetch(int argc, const char **argv, const cha=
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


--XPeJQTfk1XrtXPMq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/4S+8ACgkQVbJhu7ck
PpScQQ/8Dy8IKa8zr+W1IWMhGeWvonlQSGtifSXkBd3uhvQ97pt1pyL6q0WFE/CC
utXsHQFgP/X2tzYRFuKV6GwTv3cZI05fv4KcTwOt8108O6cHuH3d0iAmTXZN61yd
JBRyAK4OYaMsPIpiX+mqYS/xVSIm/QNWUEv0LCMp2watB0XfN3VPlB5r3s5iQ859
WNCBUMa7Af7q/DaxRbkA8XST6X9uzLit+3iX2dfjpeSh3d+/DB8ZPXYXmS+yOUDo
imYczpkApt8Xqyb3vqjsUFdDEvxTU63Jstaknuzabx2bzJLcFukuvJxPWohDuZZP
FDxI7ieLOKMAUadGmyZhcyzlEIYqvNsl5WwwWX8YAvqtIGFbE71AoLXWE5G94Zfb
oYRFxT2V0yRYXgY7gC3f8CZkh1uV2/8qtwdHS3jqE0FXf5U1UfMucettUFoecSDP
DKtw5SpzifcSy70/Ohefh/ZXjOP0gmg9+/g0cwlbzgRNB8tPmK6xTH1tvJGS2uZ3
JaGPxgBOhqUrWEu7a2DTX8viBaFfVIQTijArw7xcm8C40Ucx1hGGuYAoBLKRH3G7
ea8dSfcqHgGV4ytoTzDlxVcigKeCpXjgjnxUD3NqZW6FcH2WvcTgJrbD85Ibsowj
4BARjwv7/rRfzsAVnfmF1L/nGuMBySe4jC6teI3lIy3fpZFhGlw=
=7eAt
-----END PGP SIGNATURE-----

--XPeJQTfk1XrtXPMq--
