Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4875F6F510
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 13:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714398096; cv=none; b=RrxCAIlRDiLS196Nnae0b5ZsRR/gNvHdzHX0XeTpyRpQFp0qeB/jlXNUtbLTS3XqI0uImxBuX5jn8R0AM21rQ/zXecC4QUqVD77mc+iiOUQY1tfbz/Fe4hS7qf4ji6DNt6rMfhuI7f8eE2XP9xQTH8zPoYIoTKJOKD4VZ2zJfiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714398096; c=relaxed/simple;
	bh=f5NHt35jyXiTSOZHg2xXLl9XuMGNPO4x7pSiHh9wKs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7/1BdUd3pukkfzWFnCsk/wp6sDC2AzqswEbgAKND0upMaGW3I3m2SuJH/qNGdE7pn3BMHOAhr/d4ll5n8xez2wZwM/phxTEBpbfSTLw29UqOEIWYUfSBJSBgD8Gt+1zw57me9iYNjdrbO2RHKA3q/ohxZ9pEZv9mecuXJsM9wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QDIk1C8f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eKzMS12h; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QDIk1C8f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eKzMS12h"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id E3AFE18000BD;
	Mon, 29 Apr 2024 09:41:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 29 Apr 2024 09:41:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714398092; x=1714484492; bh=AnkYyI003h
	DBUqEHJDEAaqnH7mySG0+faBhoh//wwnc=; b=QDIk1C8f4v/CrzRC7Am/IihX7D
	K7sO1aPPjrNhAc42DkeuQiAWqFkcc5OMg4pAl3LoNl3hWHnxUOw4eFBM3l9AWL12
	lnQwKpdn2PraGOqx7Ll7rG6QuwQJbysllFKPfUeRl5xu/m8G5CBVLqia+i+S4I9C
	TP+EaO7Ph+nT5waGc11IWU9AJIG4924Srs5TEMwprmfh5uoVi/Pt4sBG5ORlRXcF
	+GrfbTxUNG0Zq5A+xcxUPteZy76CXazGCsZ9vm3n1ADd+wPQQ0SPPUw/5M0iwiDl
	XgoSGNqXrS4s5gIVmL8LAQxHkVPBhqriCGL91MbKDMGnzCbr1NrMrRmmyThg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714398092; x=1714484492; bh=AnkYyI003hDBUqEHJDEAaqnH7myS
	G0+faBhoh//wwnc=; b=eKzMS12hmq6wl4bmacnOqgyF/s2s0zsfIeMzXisxRW5R
	59uzUYrAt78beOFJRxvaKer0hljn9FWuFPt/kQdm2vYkNKssZyanqqbFF1eHAts0
	KDPJl1VOJeIz7Qh3memmQRgGWSMFPedliQZdJadoc+1DKDQmzi7dhpecvN8yZbOY
	a+PqFyM5cn2/0e5Im5+VJSX6j4KiVEQsYVtuFA4nbp2mWD+cqLPwMHJM9PMi3zO6
	JvbR/HaJ6tWM1AMx2rALur4Vcntft+lV84k5WkcUTLFsDSvZm4fndepwckgHoVyt
	8qPzJDS0bK4oROK9Fbf9cxEzXlUy4Zsn4Nvotun7rw==
X-ME-Sender: <xms:jKMvZtJzz4pB44BqI1OAhS8zoRlnF7idEbaz4PKw-FRuSHZdMxVoyg>
    <xme:jKMvZpIY8aWdnF1l2cgDeInfXeA0njhyacd0txfGGJmq2dDG_kcUMF5WMLhELdQGL
    DyomfDIvrrb-xE_qQ>
X-ME-Received: <xmr:jKMvZlv6sn0SsIiigToLtih_-hdEITsqOjA2eXX19DCObEJrHbuBl7s04r9HOmJdVG9IptCBSbcbPo-A9AIuxE-vD7r8y-5DTWaReugB7Z2N9iQm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduuddgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:jKMvZubG6UyeFrN9Jax5Wj6qVlgkFZeKrRBTLhzV1GFm-bDQmv0xpA>
    <xmx:jKMvZkYYiNSKK_DeiTOuKT20bE1vxI7eJ2mmv-GSwnHpNNlbC7BOvg>
    <xmx:jKMvZiDWL1mRz012iJEWBaEnl3r-2SBRsbQKjPyK0z41ffJDsrAZFA>
    <xmx:jKMvZiZ93Ivpz21sA03h7mIoxtQQp_7b7eYKwWmQHC7ZhH09SQZeoA>
    <xmx:jKMvZsHfcO2ZtVsjdiEn9XQNcxa7zNqhaxENhGJJY6zOFc3LYIJZMETs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 09:41:31 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0dad22f1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Apr 2024 13:41:11 +0000 (UTC)
Date: Mon, 29 Apr 2024 15:41:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 2/3] refs: do not label special refs as pseudo refs
Message-ID: <b5e7ddb1e30acb7e3871a189beb2c828b18f9e73.1714398019.git.ps@pks.im>
References: <cover.1714398019.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oG8aAt8DQAya1IUU"
Content-Disposition: inline
In-Reply-To: <cover.1714398019.git.ps@pks.im>


--oG8aAt8DQAya1IUU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We have two refs which almost behave like a ref in many contexts, but
aren't really:

  - MERGE_HEAD contains the list of parents during a merge.

  - FETCH_HEAD contains the list of fetched references after
    git-fetch(1) with some annotations.

These references have been declared "special refs" in 8df4c5d205
(Documentation: add "special refs" to the glossary, 2024-01-19).

Due to their "_HEAD" suffix, those special refs also almost look like a
pseudo ref, even though they aren't. But because `is_pseudoref()` labels
anything as a pseudo ref that ends with the `_HEAD` suffix, it will also
happily label both of the above special refs as pseudo refs.

This mis-labeling creates some weirdness and inconsistent behaviour
across ref backends. As special refs are never stored via a ref backend,
they theoretically speaking cannot know about special refs. But with the
recent introduction of the `--include-root-refs` flag this isn't quite
true anymore: the "files" backend will yield all refs that look like a
pseudo ref or "HEAD" stored in the root directory. And given that both
of the above look like pseudo refs, the "files" backend will list those,
too. The "reftable" backend naturally cannot know about those, and
teaching it to parse and yield these special refs very much feels like
the wrong way to go. So, arguably, the better direction to go is to mark
the "files" behaviour as a bug and stop yielding special refs there.

Conceptually, this feels like the right thing to do, too. Special refs
really aren't refs, they are a different file format that for some part
may behave like a ref. If we were designing these special refs from
scratch, we would have likely never named it anything like a "ref" at
all.

So let's double down on the path that the mentioned commit has started,
which is to cleanly distinguish special refs and pseudo refs.

Ideally, the proper way would be to return to the original meaning that
pseudo refs really had: a ref that behaves like a ref for most of the
part, but isn't really a ref. We would essentially replace the current
"pseudoref" term with the "special ref" term. The consequence is that
all refs except for FETCH_HEAD and MERGE_HEAD would be normal refs,
regardless of whether they live in the root hierarchy or not. The way
that pseudorefs are enforced now would then change to be a naming policy
for refs, only. It's unclear though how sensible it would be to do such
a large change to terminology now, which is why this commit does the
next best thing.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/glossary-content.txt | 36 ++++++++++++++++++------------
 refs.c                             |  2 ++
 t/t6302-for-each-ref-filter.sh     | 17 ++++++++++++++
 3 files changed, 41 insertions(+), 14 deletions(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-co=
ntent.txt
index d71b199955..4275918fa0 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -497,20 +497,28 @@ exclude;;
 	unusual refs.
=20
 [[def_pseudoref]]pseudoref::
-	Pseudorefs are a class of files under `$GIT_DIR` which behave
-	like refs for the purposes of rev-parse, but which are treated
-	specially by git.  Pseudorefs both have names that are all-caps,
-	and always start with a line consisting of a
-	<<def_SHA1,SHA-1>> followed by whitespace.  So, HEAD is not a
-	pseudoref, because it is sometimes a symbolic ref.  They might
-	optionally contain some additional data.  `MERGE_HEAD` and
-	`CHERRY_PICK_HEAD` are examples.  Unlike
-	<<def_per_worktree_ref,per-worktree refs>>, these files cannot
-	be symbolic refs, and never have reflogs.  They also cannot be
-	updated through the normal ref update machinery.  Instead,
-	they are updated by directly writing to the files.  However,
-	they can be read as if they were refs, so `git rev-parse
-	MERGE_HEAD` will work.
+	Pseudorefs are references that live in the root of the reference
+	hierarchy, outside of the usual "refs/" hierarchy. Pseudorefs have an
+	all-uppercase name and must end with a "_HEAD" suffix, for example
+	"`BISECT_HEAD`". Other than that, pseudorefs behave the exact same as
+	any other reference and can be both read and written via regular Git
+	tooling.
++
+<<def_special_ref>,Special refs>> are not pseudorefs.
++
+Due to historic reasons, Git has several irregular pseudo refs that do not
+follow above rules. The following list of irregular pseudo refs is exhaust=
ive
+and shall not be extended in the future:
+
+ - "`AUTO_MERGE`"
+
+ - "`BISECT_EXPECTED_REV`"
+
+ - "`NOTES_MERGE_PARTIAL`"
+
+ - "`NOTES_MERGE_REF`"
+
+ - "`MERGE_AUTOSTASH`"
=20
 [[def_pull]]pull::
 	Pulling a <<def_branch,branch>> means to <<def_fetch,fetch>> it and
diff --git a/refs.c b/refs.c
index c64f66bff9..567c6fc6ff 100644
--- a/refs.c
+++ b/refs.c
@@ -905,6 +905,8 @@ int is_pseudoref(struct ref_store *refs, const char *re=
fname)
=20
 	if (!is_pseudoref_syntax(refname))
 		return 0;
+	if (is_special_ref(refname))
+		return 0;
=20
 	if (ends_with(refname, "_HEAD")) {
 		refs_resolve_ref_unsafe(refs, refname,
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 948f1bb5f4..8c92fbde79 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -52,6 +52,23 @@ test_expect_success '--include-root-refs pattern prints =
pseudorefs' '
 	test_cmp expect actual
 '
=20
+test_expect_success '--include-root-refs pattern does not print special re=
fs' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+		git rev-parse HEAD >.git/MERGE_HEAD &&
+		git for-each-ref --format=3D"%(refname)" --include-root-refs >actual &&
+		cat >expect <<-EOF &&
+		HEAD
+		$(git symbolic-ref HEAD)
+		refs/tags/initial
+		EOF
+		test_cmp expect actual
+	)
+'
+
 test_expect_success '--include-root-refs with other patterns' '
 	cat >expect <<-\EOF &&
 	HEAD
--=20
2.45.0-rc1


--oG8aAt8DQAya1IUU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYvo4cACgkQVbJhu7ck
PpSBThAApLzUKs5BDeB9BWSiztExaxDXYKqXjzzkhwEE/s9PWj92bcc3OxWFPb+H
QFD8EAvDYttB3M8twkvdZWhqxNMtBMLr2X244Tg/Damhm/OMgLtP1RYHkdYlcvIo
0GCMix54R7ZXtNDrNXZiq8TNNJKtucdTJxTb7mnsiTCUvC0/YzgZ5ximQo89xMT9
IEraS4udRVDHsAFMmygiVyNfDh5Au9PpGu0o1+d/nA68eHXTHytimpGGOSZ2seoy
CWHj2AjXjpPregtmFMlZx89eL1Kea+afkWq7tmgWyp3gyIQvY5Lx4YtMnLvnN5eO
N+d8eFtQrGClM9dEJ7I4W2XsaTeHj98NSNO9ExBlk37Bl4BLXso5aRx5JyMbJ5Qa
Y9lIqKwPWo+9MYVeTw60BnXZfOhM6SwAbtBRzjVYTAzXTDaBcJPWHNIf+VpVGnle
bgasRksQ8w1rVInaOIc5vX/et3WJUdUQS9hhwkst1aoZI1T0oWV1nuf5UhSz3DOB
T7Gyi/b8rau29HnFyM9rF/FBfXSFPxbxPFeAEJqvgLhL/b8evgvVBYzeUT1FLie1
g8pDGbnQ5XE0pLJFe2zPVLIAUfAHgryJTuECHdzf9qmFqqwnqRGk4J1zmDPiPLow
kkqwpjE9ug9aXZymcea7J1+gENq4pQKlRk+Xf5O9DXzJGOsKgnM=
=qug5
-----END PGP SIGNATURE-----

--oG8aAt8DQAya1IUU--
