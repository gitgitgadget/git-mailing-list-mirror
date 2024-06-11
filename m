Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F50B176FA7
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 09:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718097630; cv=none; b=KA8+aWUUn/spHPC9pfNIx2Ubjp4H42IEapbwaQkp9AKq/TQ3oQruPZLRX5xHW3DcGT1UQZ+S+ofL93jNYLEeLTuKjG8XhkZeQ41OORN1lDA+2NKFPD+ENbGQk/ve9ql2cBwm7LlRRsvp1XbZLaJWHX17hVGfYVwWoMUNN4l4MPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718097630; c=relaxed/simple;
	bh=aBjt+wC7imncYi+fa7UPFjMoFnWe7SGmhHYfj49/g/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O48VZVUi68gHZTpHrLuhouDvEEWPt0+mvkUrwST4RStUO/K2+tOl4bnxrUHsLfPRmTdyY0i+9/8dMeCWwVePaxKplf/1IOTGyN3PBZz0glXn4RrtBmgZvx/VaPIFzHGGKt7IjtbS7kB47Ubwly9thcdSBxoeeSF4mvoV/MgzxX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=a9fbClkD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GvIvjxBu; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="a9fbClkD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GvIvjxBu"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 63A811C00133;
	Tue, 11 Jun 2024 05:20:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 11 Jun 2024 05:20:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718097628; x=1718184028; bh=K5JUcskTTk
	L7PRbEqIbRIaGYCIf7UTFWOf1RCDCRcUk=; b=a9fbClkDjUTFKJ26zpC2+PgE46
	ol8F5um13Dqv104Z/luLzsaWcCJdDOcEUKlITBRqGI//iXcPoPkMmCuhNUrLa8zz
	Vx4W9NU3P5z8Q9h/1q6cEjBEnXcwFY4Kmq0xBSLEMvL4Sp2KdbYyj3ptalZvDC34
	jx86QooN8ZIm3pb6/Y5GSSo2u7z0VxkqGgLIjzNsflX4j4lha3hZ4Xe+3aOp0Tid
	Uw/YqETI/Wxjw9Acxks8D81fZVOR6on0ECvYxRVOxt2wCBlXjf16DjpqsVtojOCa
	NcWMSiwGeuWcdkvHwQXjqZUzFOh1hP9RuLgzyUHuhvPK9KSwN3pd6ACRATaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718097628; x=1718184028; bh=K5JUcskTTkL7PRbEqIbRIaGYCIf7
	UTFWOf1RCDCRcUk=; b=GvIvjxBumdoFSrxUlfI0qNCtoqcqcoJQ2Q6TfmuJdqH/
	powp/GLLVwotf9QR995WWQHOHT1IkTTiXzki+g5RO33CLm/QPA4IORebG2UTheFq
	DyaXlB/pL13WowR8kthg5HK1K/BugM6dzxIXNZJl6wKr4YwbNOxtRjA8anaNU7iu
	Rjreo6lGIX9VGLPy2m21tCee5U8ZQWZLuRtuUaYxiQBJBIS7KGVxAnYbkJm5cSQY
	x7E9XeJU3lIVFjS2+mmWggKt3gJ8CZEwcZ6LmgH2QLj8uc+ToI2ikyalgdMGDKxD
	/Cw/8O5Ks+TvStPViZmTOBlsl0j4Kze+6smJRSlk2A==
X-ME-Sender: <xms:2xZoZlfDyF4NRg6Xx3qukjHq7RF53q7GTtOjkSiEfz6kiifhevJ4Uw>
    <xme:2xZoZjNyJYkk5pqw-xTEynLjxg5x3JIe3IAjs6a9mj5pr73LzBXGFOwtDRgqpsq5A
    MC8VvaXJpYvl57N1A>
X-ME-Received: <xmr:2xZoZujJ74HiRI6D1P2EVFXnrF5VmS90a4PkQc6V9YrU9JT7aY2vEvyUSOrWs_3v20kF4wWI5zKtFKYLVVs6gqsORqDlEcwaAVfHsUJDDwcubW9UULwS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepgeeiffejkeetleeuhfetteehgeeutefhteeugfdtuefftdfhkeeukeekuedvieel
    necuffhomhgrihhnpeguihhffhhophhtrdhnohenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:2xZoZu_TQlmTZ5XONsMSbul5X7JYx80-IWGguEX9jPUteG9XQODXmw>
    <xmx:2xZoZhu7dOpqhfVF0uJx6TjlvJUTKsfhEuxB2rTOzoUrjWzDGn5G0w>
    <xmx:2xZoZtGImBsLoyXW4miZW2M3mQtXUN84NeTqz7A7ZV-BrVrtrN6VLw>
    <xmx:2xZoZoOYJ5znQeiBzhiH3tk2K5m4S5C6lu00sp22lGhFirDeio8S5w>
    <xmx:3BZoZpLXgMYDwitpSKwn9VnL6rMfp6H6KPUv677TFottyqIwQd1nzGME>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 05:20:26 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 1ffa80d3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Jun 2024 09:20:17 +0000 (UTC)
Date: Tue, 11 Jun 2024 11:20:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 15/29] revision: free diff options
Message-ID: <99f4f3d3412a40eb6ada67ae48c7369cb57762cc.1718095906.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
 <cover.1718095906.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HHoBCGQHx3HecpI8"
Content-Disposition: inline
In-Reply-To: <cover.1718095906.git.ps@pks.im>


--HHoBCGQHx3HecpI8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There is a todo comment in `release_revisions()` that mentions that we
need to free the diff options, which was added via 54c8a7c379 (revisions
API: add a TODO for diff_free(&revs->diffopt), 2022-04-14). Releasing
the diff options wasn't quite feasible at that time because some call
sites rely on its contents to remain even after the revisions have been
released.

In fact, there really only are a couple of callsites that misbehave
here:

  - `cmd_shortlog()` releases the revisions, but continues to access its
    file pointer.

  - `do_diff_cache()` creates a shallow copy of `struct diff_options`,
    but does not set the `no_free` member. Consequently, we end up
    releasing resources of the caller-provided diff options.

  - `diff_free()` and friends do not play nice when being called
    multiple times as they don't unset data structures that they have
    just released.

Fix all of those cases and enable the call to `diff_free()`, which plugs
a bunch of memory leaks.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/shortlog.c                        | 5 +----
 diff-lib.c                                | 2 ++
 diff.c                                    | 8 ++++++--
 revision.c                                | 2 +-
 t/t4208-log-magic-pathspec.sh             | 1 +
 t/t6000-rev-list-misc.sh                  | 1 +
 t/t6001-rev-list-graft.sh                 | 1 +
 t/t6013-rev-list-reverse-parents.sh       | 1 +
 t/t6017-rev-list-stdin.sh                 | 1 +
 t/t9500-gitweb-standalone-no-errors.sh    | 1 +
 t/t9502-gitweb-standalone-parse-output.sh | 1 +
 11 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index d4daf31e22..5bde7c68c2 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -460,11 +460,8 @@ int cmd_shortlog(int argc, const char **argv, const ch=
ar *prefix)
 	else
 		get_from_rev(&rev, &log);
=20
-	release_revisions(&rev);
-
 	shortlog_output(&log);
-	if (log.file !=3D stdout)
-		fclose(log.file);
+	release_revisions(&rev);
 	return 0;
 }
=20
diff --git a/diff-lib.c b/diff-lib.c
index 5a5a50c5a1..1cbf03bf39 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -662,9 +662,11 @@ int do_diff_cache(const struct object_id *tree_oid, st=
ruct diff_options *opt)
 	repo_init_revisions(opt->repo, &revs, NULL);
 	copy_pathspec(&revs.prune_data, &opt->pathspec);
 	revs.diffopt =3D *opt;
+	revs.diffopt.no_free =3D 1;
=20
 	if (diff_cache(&revs, tree_oid, NULL, 1))
 		exit(128);
+
 	release_revisions(&revs);
 	return 0;
 }
diff --git a/diff.c b/diff.c
index e70301df76..53e2f5a42e 100644
--- a/diff.c
+++ b/diff.c
@@ -6649,8 +6649,10 @@ static void diff_flush_patch_all_file_pairs(struct d=
iff_options *o)
=20
 static void diff_free_file(struct diff_options *options)
 {
-	if (options->close_file)
+	if (options->close_file && options->file) {
 		fclose(options->file);
+		options->file =3D NULL;
+	}
 }
=20
 static void diff_free_ignore_regex(struct diff_options *options)
@@ -6661,7 +6663,9 @@ static void diff_free_ignore_regex(struct diff_option=
s *options)
 		regfree(options->ignore_regex[i]);
 		free(options->ignore_regex[i]);
 	}
-	free(options->ignore_regex);
+
+	FREE_AND_NULL(options->ignore_regex);
+	options->ignore_regex_nr =3D 0;
 }
=20
 void diff_free(struct diff_options *options)
diff --git a/revision.c b/revision.c
index 82c0aadb42..99c75c939d 100644
--- a/revision.c
+++ b/revision.c
@@ -3191,7 +3191,7 @@ void release_revisions(struct rev_info *revs)
 	release_revisions_mailmap(revs->mailmap);
 	free_grep_patterns(&revs->grep_filter);
 	graph_clear(revs->graph);
-	/* TODO (need to handle "no_free"): diff_free(&revs->diffopt) */
+	diff_free(&revs->diffopt);
 	diff_free(&revs->pruning);
 	reflog_walk_info_release(revs->reflog_info);
 	release_revisions_topo_walk_info(revs->topo_walk_info);
diff --git a/t/t4208-log-magic-pathspec.sh b/t/t4208-log-magic-pathspec.sh
index 806b2809d4..2a46eb6bed 100755
--- a/t/t4208-log-magic-pathspec.sh
+++ b/t/t4208-log-magic-pathspec.sh
@@ -5,6 +5,7 @@ test_description=3D'magic pathspec tests using git-log'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup' '
diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
index 6289a2e8b0..f6d17ee902 100755
--- a/t/t6000-rev-list-misc.sh
+++ b/t/t6000-rev-list-misc.sh
@@ -5,6 +5,7 @@ test_description=3D'miscellaneous rev-list tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success setup '
diff --git a/t/t6001-rev-list-graft.sh b/t/t6001-rev-list-graft.sh
index 73a2465aa0..3553bbbfe7 100755
--- a/t/t6001-rev-list-graft.sh
+++ b/t/t6001-rev-list-graft.sh
@@ -5,6 +5,7 @@ test_description=3D'Revision traversal vs grafts and path l=
imiter'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success setup '
diff --git a/t/t6013-rev-list-reverse-parents.sh b/t/t6013-rev-list-reverse=
-parents.sh
index 39793cbbd6..4128269c1d 100755
--- a/t/t6013-rev-list-reverse-parents.sh
+++ b/t/t6013-rev-list-reverse-parents.sh
@@ -5,6 +5,7 @@ test_description=3D'--reverse combines with --parents'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
=20
diff --git a/t/t6017-rev-list-stdin.sh b/t/t6017-rev-list-stdin.sh
index 4821b90e74..a0a40fe55c 100755
--- a/t/t6017-rev-list-stdin.sh
+++ b/t/t6017-rev-list-stdin.sh
@@ -8,6 +8,7 @@ test_description=3D'log family learns --stdin'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 check () {
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standa=
lone-no-errors.sh
index 7679780fb8..ccfa415384 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -13,6 +13,7 @@ or warnings to log.'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./lib-gitweb.sh
=20
 # ----------------------------------------------------------------------
diff --git a/t/t9502-gitweb-standalone-parse-output.sh b/t/t9502-gitweb-sta=
ndalone-parse-output.sh
index 81d5625557..b41ea19331 100755
--- a/t/t9502-gitweb-standalone-parse-output.sh
+++ b/t/t9502-gitweb-standalone-parse-output.sh
@@ -13,6 +13,7 @@ in the HTTP header or the actual script output.'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./lib-gitweb.sh
=20
 # ----------------------------------------------------------------------
--=20
2.45.2.436.gcd77e87115.dirty


--HHoBCGQHx3HecpI8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZoFtcACgkQVbJhu7ck
PpQymw/8CBBJ/C1KvZoOaKhhX+T9lQ+680X5n8HnuhdYbFfnepM5Q0yqjTkvmhae
8Cciz0sDa6APVbxBwBgKCIhnQ0dD6UCkO8rSmc/9PWd96aAKDV3AWy6iYDKnG3xT
pG3AdzgRGjRqz0v45barHlDhYVjWz3LuJ0xMyGHdgsjsXptz5iCYiUlOdwQFwVVF
oUziZeXnMyzs3v4426wKIBnDNMaMQ5Judapc3+SCMgfNCNWeiA7081nZWsXeOuK2
rXIwrP3sH01AqV4nxuZs/KJWdilFW772GxNKiQKhXEH0xHHgnaPg6yhliBWlzJKu
UnGH2BQQAcM6UqmEYDBFhVVNFeCRBh9LSPaNOokSbtQiIwahmGpNUsT6bELaAaKK
uMRXYwdQ0TAvDdvds4TIBewCm2ShPMdb8Tfb1ZL6Q34TsLxJ79VFiH4VpEycql92
i91k/eCRIjyUG1v1CNrzaQNTjkLX/lkkz1cLAhfGoXsQx+N5XUoVACPe/OS8keHa
jt+g5w4iruAMbt1xQL6cmWyxh6bS6wsZUTL8dDdxzFGqXr/nvZtd/iZE+u7TLKy6
4fftN0zN5N97ZVU3ylCaJtHJytaLUdkQQCfBPq49QjPjX/PsRz8V+hd+j/rBw1/9
2Qd+51oeVCvFx3Xv1IURarFduMVQUSXukJo+mClxzpgbXpMqFZs=
=QkRy
-----END PGP SIGNATURE-----

--HHoBCGQHx3HecpI8--
