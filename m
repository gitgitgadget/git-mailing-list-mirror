Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B5E3D576
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 09:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708509402; cv=none; b=FN77zXHa5sGd+7/oSffYttbXVME2KNqr8/6JpFxtaiCiLCs2j3nC0tdGZ1nmC+62slepSLQ81COoR5/yhKaQEkK/CjjgIA79Gu96hyNcb4RxRiQC92SAmqu2MSLMYn96QacGcRNAHV4k65DpP+UZx7WZbCfbxLwQBhuHJBSQ/Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708509402; c=relaxed/simple;
	bh=jkpXfDrbOQqHj4UfAuSPAW2q2Bdk13NbVjzMzi+lgCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLF0hTjL1a9V5uikJyiO6M5ULXrfN7usY6ozIkRj8g/4g8yCEQfMZzWv74LIw4mEUBRRpcjeUHv3cgszei1PcWnyVc/C7Z6LA3JkSUR06pWKHSHRO6buoJxqEt084KZoIYZ9PzbhMEY/EkZgVIcJhOX+W9g5kPy+Kg6jFM8RMUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cGt5cmAl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YXomi1lS; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cGt5cmAl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YXomi1lS"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B519111400C4;
	Wed, 21 Feb 2024 04:56:39 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 21 Feb 2024 04:56:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708509399; x=1708595799; bh=4MnM4HOqAY
	YD6Z7FBRgpkjggrp7riTLlGLOh+MOQkXE=; b=cGt5cmAlFkIS8ZZiZD/PbJrvfq
	cho3wTFE4uoxI56yxlINMYfpOtj9CrISMgBlYi9lXgwKeCB/8Qf54pPjbdQm+5rN
	ppOkxI2RAGyJTHx2b4zX8rIhqA5lApDAxBOXv7oCeCpJemcYF1DPda0PzAjsQ6+U
	d7JKcS8XQrdxb6IGP1G/BwWTXBaT7yVSlBvXvDkaUiMPKf65AqNhzSylJx4ANHQq
	hqgFJz1JQNE7tvrzp+oIkBvLwdRyJ0vckxrSjRtlH2An8VYAX5LAFk4TAKafDQVi
	JaC3o3jaN4wdyRoB9wzwgOqVUaLh13s8/DdVWBXCyMiMbvixkcwVez2XOgJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708509399; x=1708595799; bh=4MnM4HOqAYYD6Z7FBRgpkjggrp7r
	iTLlGLOh+MOQkXE=; b=YXomi1lSoG2j1fe4ITunF3KCbhhcTk8lVoaDaxBaLSnj
	R5wOewEllzfh0vTiKtd7Eo2pEGgKEa0t6HCAZeZ8oLNHaHWr9tyg5/sdkacfn0j0
	S5scwquVZ9Uesy3eXRwhXeeFrylbNhXJPRuAfUvzdkVn9zoCgltgBECeZSMHAzfe
	Mu0LP+T9YNO6TNWitwG5IHu0xubt2oAPJC+GCYjvDUfFqyw4B8bKWWQvkRr9x4+S
	ASXMaet5Px+iKkFQORyiSPaDS7Cke/C8DM3eXjAv08CXeG3jazA6QsVrenTW/SYY
	4vnthLWG1sKeE/Waf1YROMThaaKKVOImZw2oVs8YiA==
X-ME-Sender: <xms:18jVZVEHkiZy1-38EAAQ58exTUmMYfCRTdi9MYQjadWOmIDmrcpdTA>
    <xme:18jVZaX_YeMcPWA2ITvA8zRJsSEDwYKfdNDmCErJEmvnAYkY7NPYhrICTlUGqi50V
    2TtpvH797rlCvJk8Q>
X-ME-Received: <xmr:18jVZXJv5JU91_KuPVjixmIgxrf-2TxOj8y7La-rrJwXDCARR82HoGVgwJClMxMCqEFq5mpXb0PuizrnjMwk77zIjHPqOZVLbeafEgkpO2NT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvgddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:18jVZbFLX-yWqYLs976iIhftzT1AW98JC_Sbb7DlJsZPPfb6V30SMw>
    <xmx:18jVZbUEBMQVkl4cCWitkKlsOB043mQ6srYm--Bfu4IDG3huMYXMtQ>
    <xmx:18jVZWM7s99e2_Dzgm96eBg0m51akp7ZNfO7Qc7KK9415yEr0lNssQ>
    <xmx:18jVZYgTZZmQUUXm1u0PH8kqQGyMPlyQTdobpf0e3z9TmNJhtqNYTw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Feb 2024 04:56:38 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 207c463e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Feb 2024 09:52:34 +0000 (UTC)
Date: Wed, 21 Feb 2024 10:56:36 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Yasushi SHOJI <yasushi.shoji@gmail.com>
Subject: [PATCH 1/2] object-name: detect and report empty reflogs
Message-ID: <0fac6ebb098c7e8cdc87cb75f2dcffdc4b1ccfaa.1708509190.git.ps@pks.im>
References: <CAELBRWK-bZTV0qx6_34HAgpmYwy+5Zo2E0M+4B6yZJJ3CqweTw@mail.gmail.com>
 <cover.1708509190.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MpryXjFS4b6pN0Ie"
Content-Disposition: inline
In-Reply-To: <cover.1708509190.git.ps@pks.im>


--MpryXjFS4b6pN0Ie
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `ref@{n}` syntax allows the user to request the n'th reflog entry
for a ref. This syntax is zero-indexed, meaning that entry zero refers
to the first entry in the reflog. The behaviour here is quite confusing
though and depends on the state of the corresponding reflog:

  - If the reflog is not empty, we return the first reflog entry.

  - If the reflog is empty, we return the object ID of the ref.

  - If the reflog is missing, we return an error.

This is inconsistent and quite misleading.

This behaviour goes back to 6436a20284 (refs: allow @{n} to work with
n-sized reflog, 2021-01-07), which fixed a bug that wouldn't allow a
user to return the n'th reflog entry with an n-sized reflog. With this
commit, `read_ref_at()` started to special case reading the first entry
of the reflog via a separate `read_ref_at_ent_newest()` function. The
problem here is that we forgot to check whether the callback was invoked
at all, and thus we don't notice empty reflogs.

The commit in question added a test for `ref@{0}` when the reflog is
empty. But that test only works by chance: while `read_ref_at()` won't
initialize the object ID passed in by the pointer, all callers of this
function happen to call `repo_ref_dwim()` and thus pre-populate the
object ID. Thus, the consequence is that we indeed return the object ID
of the refname when the reflog is empty.

This behaviour is documented nowhere, and the fact that we return a
somewhat sensible result to the caller by sheer luck further stresses
the point that this behaviour is only accidental, even if there is a
test covering it.

Furthermore, this behaviour causes problems for the git-show-branch(1)
command. When executing `git show-branch --reflog` for a ref that either
has no or an empty reflog we run into a segfault. This is because the
`read_ref_at()` function doesn't report the error to us, and thus parts
of its out-parameters are not initialized.

Start to detect and report empty or missing reflogs in `read_ref_at()`
and report them to the caller. This results in a change in behaviour
when asking for `ref@{0}` with an empty or missing reflog because we now
die instead of returning the object ID of the ref itself. This adapted
behaviour should lead to less surprises as we now really only report
object IDs to the caller that actually come from the reflog, thus making
the user experience a whole lot more consistent.

This change also fixes the segfault in git-show-branch(1). Note that
this commit does not add a test yet -- this will be handled in the next
commit.

Reported-by: Yasushi SHOJI <yasushi.shoji@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-name.c                  | 10 ++++++----
 refs.c                         |  3 ++-
 t/t1506-rev-parse-diagnosis.sh |  8 ++++++++
 t/t1508-at-combinations.sh     | 29 +++++++++++++++++++++++++----
 4 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/object-name.c b/object-name.c
index 3a2ef5d680..e2a6c9d2ec 100644
--- a/object-name.c
+++ b/object-name.c
@@ -994,8 +994,8 @@ static int get_oid_basic(struct repository *r, const ch=
ar *str, int len,
 	if (reflog_len) {
 		int nth, i;
 		timestamp_t at_time;
-		timestamp_t co_time;
-		int co_tz, co_cnt;
+		timestamp_t co_time =3D 0;
+		int co_tz =3D 0, co_cnt =3D 0;
=20
 		/* Is it asking for N-th entry, or approxidate? */
 		for (i =3D nth =3D 0; 0 <=3D nth && i < reflog_len; i++) {
@@ -1020,6 +1020,7 @@ static int get_oid_basic(struct repository *r, const =
char *str, int len,
 				return -1;
 			}
 		}
+
 		if (read_ref_at(get_main_ref_store(r),
 				real_ref, flags, at_time, nth, oid, NULL,
 				&co_time, &co_tz, &co_cnt)) {
@@ -1035,9 +1036,10 @@ static int get_oid_basic(struct repository *r, const=
 char *str, int len,
 						show_date(co_time, co_tz, DATE_MODE(RFC2822)));
 				}
 			} else {
-				if (flags & GET_OID_QUIETLY) {
+				if (flags & GET_OID_QUIETLY)
 					exit(128);
-				}
+				if (!co_cnt)
+					die(_("log for '%.*s' is empty"), len, str);
 				die(_("log for '%.*s' only has %d entries"),
 				    len, str, co_cnt);
 			}
diff --git a/refs.c b/refs.c
index c633abf284..a2369e7835 100644
--- a/refs.c
+++ b/refs.c
@@ -1084,6 +1084,7 @@ static int read_ref_at_ent_newest(struct object_id *o=
oid UNUSED,
 	struct read_ref_at_cb *cb =3D cb_data;
=20
 	set_read_ref_cutoffs(cb, timestamp, tz, message);
+	cb->found_it =3D 1;
 	oidcpy(cb->oid, noid);
 	/* We just want the first entry */
 	return 1;
@@ -1123,7 +1124,7 @@ int read_ref_at(struct ref_store *refs, const char *r=
efname,
=20
 	if (cb.cnt =3D=3D 0) {
 		refs_for_each_reflog_ent_reverse(refs, refname, read_ref_at_ent_newest, =
&cb);
-		return 0;
+		return !cb.found_it;
 	}
=20
 	refs_for_each_reflog_ent_reverse(refs, refname, read_ref_at_ent, &cb);
diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnosis.sh
index ef40511d89..9d147c4ade 100755
--- a/t/t1506-rev-parse-diagnosis.sh
+++ b/t/t1506-rev-parse-diagnosis.sh
@@ -140,6 +140,14 @@ test_expect_success 'incorrect file in :path and :N:pa=
th' '
 	test_grep "path .disk-only.txt. exists on disk, but not in the index" err=
or
 '
=20
+test_expect_success '@{0} reference with empty reflog' '
+	git checkout -B empty-reflog main &&
+	git reflog expire --expire=3Dnow refs/heads/empty-reflog &&
+	test_must_fail git rev-parse empty-reflog@{0} >output 2>error &&
+	test_must_be_empty output &&
+	test_grep "log for ${SQ}empty-reflog${SQ} is empty" error
+'
+
 test_expect_success 'invalid @{n} reference' '
 	test_must_fail git rev-parse main@{99999} >output 2>error &&
 	test_must_be_empty output &&
diff --git a/t/t1508-at-combinations.sh b/t/t1508-at-combinations.sh
index e841309d0e..020106a1cc 100755
--- a/t/t1508-at-combinations.sh
+++ b/t/t1508-at-combinations.sh
@@ -110,10 +110,31 @@ test_expect_success '@{1} works with only one reflog =
entry' '
 	test_cmp_rev newbranch~ newbranch@{1}
 '
=20
-test_expect_success '@{0} works with empty reflog' '
-	git checkout -B newbranch main &&
-	git reflog expire --expire=3Dnow refs/heads/newbranch &&
-	test_cmp_rev newbranch newbranch@{0}
+test_expect_success '@{0} fails with empty reflog' '
+	git checkout -B empty-reflog main &&
+	git reflog expire --expire=3Dnow refs/heads/empty-reflog &&
+	cat >expect <<-EOF &&
+	fatal: Needed a single revision
+	EOF
+	test_must_fail git rev-parse --verify missing-reflog@{0} 2>err &&
+	test_cmp expect err
+'
+
+test_expect_success '@{0} fails with missing reflog' '
+	git -c core.logAllRefUpdates=3Dfalse checkout -B missing-reflog main &&
+	cat >expect <<-EOF &&
+	fatal: Needed a single revision
+	EOF
+	test_must_fail git rev-parse --verify missing-reflog@{0} 2>err &&
+	test_cmp expect err
+'
+
+test_expect_success '@{0} favors first reflog entry with diverged reflog' '
+	git checkout -B diverged-reflog main &&
+	test_commit A &&
+	test_commit B &&
+	git reflog delete diverged-reflog@{0} &&
+	test_cmp_rev diverged-reflog~ diverged-reflog@{0}
 '
=20
 test_done
--=20
2.44.0-rc1


--MpryXjFS4b6pN0Ie
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXVyNMACgkQVbJhu7ck
PpRt3g/9ECG8CATIgXTIwPE4KJNNUqJJepvPJ3zIVnt+zCQez/h7+GzqhQhGYSqd
m3aiKSC5EaiR296/epiNKAxt7e7QqvjRVJ/9WA+B/DeC7I8m5SQBVvOQHDIJncN6
kLmGbL6nmeYmSW0jdORlNrEeOuxYv3bwOye+fGrMei7s8MS0ArboOsL+LTGenDmL
jb80+zFlLzkdMsdqaIt+RPH4g760P4+MyPdNTahQIjH88vVs3YFL9H2koryew8/r
7uR/9IWQvoR0Vdo1JoF0WdoMufA2urOj8k+YH/Whp1O7zxzkAfrptGBSNnFdCQnI
54rvAmZx+l2Q5agn8H2ok9Pg+15cSyytmYeD9yLBWJPatUB6TBrpTzHyEyk/E5ja
5iacJXn4vQzucs2Cuc+kZ3QqLBNIOGH0BPhmlSrF0iJAV/kJTNnjinkfdezAEg9j
weD8XRne4DX6LDKj4fkyJ3A1j6RwsmYuwnP5wf8OEDRo6Nw1GKNeKEAwIA7gKDwb
Elm3oY36RctukW0sodN9CYP8NBbv8HKXRoQezZZxZKexTbO+G8c/vp2lQ6T8nHzA
vsxnDLA10ANkjbWoGQOTucMHwo5pG3x4adMCEhElqbdDSgrfg8ChbfG/Z97QuJCv
gEwNnZGN+DrGJC+uzX84zvOV0v6+cdC5Oe+ktltaaSeXncGvDrU=
=MxC0
-----END PGP SIGNATURE-----

--MpryXjFS4b6pN0Ie--
