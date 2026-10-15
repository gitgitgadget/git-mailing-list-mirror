Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA8A4BD79F
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 17:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792083962; cv=none; b=kmASA5dwElZ/PkjeSeubZfQ9R+eaFQF1Gvyo8nUh7P23uh08ocIz9OtZJ/qUAJiryabu3H8eIErLFXER9fVft6+6pQrEYhzlApq9VV2dXL/Allma2OZ0sPtUvlIL624DMyJBL3pU/Y6hkyE7jDDXA1QoW5Tl4UiZrQi4JmQfftE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792083962; c=relaxed/simple;
	bh=98usU+S7aNc8OdQroL6cSUs55hKC206D8DSJJZsiQY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d1X2woTd91+/0vIQHN3D6VD8+vp7qs6ZQ3PyJWWDfF5zprofMYzUi2KqpEe3e6P1IS4jJ2/ZeBeoS2yqe+2EOBELMscrZvuprCCYXpVRkle548VWsIr4aZ5Rot6n8v+zpYcLelbgUwm775RQ+i0Q5RPB7rOTkZAjm/Gf0/n+1ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=XVpe4m+i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o65fWJ2l; arc=none smtp.client-ip=103.168.172.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="XVpe4m+i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o65fWJ2l"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailflow.phl.internal (Postfix) with ESMTP id 961B313800DB
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 13:05:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 15 Oct 2026 13:05:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1792083942; x=
	1792087542; bh=f92gyKGB87oeFnoG04fmWJdMV9N4c3ygqjdCgTYWNl8=; b=X
	Vpe4m+itIAprXoA/LoSSuBbyByvEBjeOTfKM35On73/OjZbU3SDAtA9aSPANfpkp
	Dvmo4KereudBEJNCeJgmbOBi+ROT1m5i6m1YkkRukKHaZD7eouraRhJNWNRD0JvM
	ob6AuSSF2l1QClT4v5CWYPIvM77pGAiVRYoZ1fstC9v3ZIw+r6wSls/IWMa7DJKW
	nxZKs064QFM+RzOQdkJvlLO7mlsXGEQlJYy9gA+Wgd8mi0cejqfp92NdXwU1dSa1
	iB7hvpjTjznN2bOIcUsFWnsJeSIEiOcYgKZb3xXT4PzKfEO5z7eTfeXPZI/BpJaE
	TEdOUbCB4vHQ13/vLy6Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1792083942; x=1792087542; bh=f
	92gyKGB87oeFnoG04fmWJdMV9N4c3ygqjdCgTYWNl8=; b=o65fWJ2lgqwGq7Noq
	x9VpHEPROt/vY+KfsxRjfrhVZ2s9UMheIYvX31gQFTwmBFZrKZ+cnTsxeQELHeb6
	X4UbM0pEjNDTY8LA2O1K7T4Hi7Jdzq1f/5LDCEJq1mtuBzP7uRo3HWJdrZMYUEpY
	lMAzCXgnXZTo40vDBclFF1iA/GyCKJ81KY2tWStt848TZQxrsDPamx65rRuY8OCy
	wTBrG4TCPxdnieib2xnnjG9HrGs8WJuC7sTbCRKGRqLknWBBCG1EU4opd7xzkCiV
	y2QlBqSj6l/gpP34TPnoUYFKxdGE8EVLUOKuLM9F/IZhTFEB6Ggw+dnnoRSME7S0
	qCs3w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792083942; d=fastmail.com;
	mf=PG1hcmtjaHVjYXJyb2xsQGZhc3RtYWlsLmNvbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:aK6N2SNUluBMGUMoA0t+zfNsHHQ7d2Rcc3RefpNG/jKFFM4
	HUT8M6Zl61CGQTcdANarDUuIVGz0m4yblhaAZ1Q0mRZPRlmPegcKtWR4tzwY98cV
	vr93ko27xoRQOppnnjLIgR/Hc5rAcAWYtYAnUiXSa0xf6rwx6l72Yb+SNkIC+snr
	r00uKfExY1eyLnaX3MYS3FY3XryYuXRIRmy23wewK2rqXe+lSoBObKunbXRNzOyp
	GS98Rf5fNTHw0auHPLZft9UxbasNQumzL43S2Pta/4WZuMx424Vd148hOrHAiqr+
	ez8hsOGdcTgnk1YIAlddnengJY2YA9cZjsv80iA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:hdfseouhhJuOy0dBdePViAdE0BVNIg7rauESRC+iRRI=:98usU+S7aNc8OdQroL6cSUs55hKC206D8DSJJZsiQY0=;
X-ME-Sender: <xms:5gfRajYGUxfNpDQnhoqsp8w35aUqgEusqsAgR7RjxOgkssVPVj9xwA>
    <xme:5gfRapbp5HbpqRkfnXgUnKb6YArRiWf6ci9A19Z4LW5qsbfddtxAMn92FU20eW8au
    qG-PSPRoBksJOFCmdSRFhhT9a8YWYXo97XU3rQzXAOJD99x7apoQmi->
X-ME-Received: <xmr:5gfRaq9GhiGMheLXCDTJELh2pL5Q4N6l0ZW9nJpqpaZulqzVD6A7cvD1F229arKRKkUVPQeP1Il4qoI5pXsF-vtEgM8Gpit0-go5BPmt8yv6FA>
X-ME-Proxy-Cause: dmFkZTGiTgd5O7w1XEhQ8+Vh9fhzBjNrPwn6e1wBLGxamiEwbIfaCA/TEN2QKGFZLfkR4u
    CpcGzAkpfYQsGUQjgyCKkZDDtAnurzRnJfT0PNuoOOd2Dj8r4F0UzWVJnCPjlBdew9riDC
    y3283335LZngGITeEOuR29b7KlO5WiuCqtTyoENbpJlp/n5+z8robxAFIJtWy3eKDxEp2f
    vDwDHAEHum4fg6KHRRkZNybILXjr58HBD6ptxSZ4Sd94AhUauaOjGLU16DlM5m7kM6Hjer
    3wmMp+182rtWVU9Hvcqi0fr5ZRjiQCYQLDDOZ0NlLiGEm2kCVXo8/jPCG+L9f2A5tOiRlD
    NOnM4uUbIGf4kJ+319SpL4l9E0XPpKL/sWC/cN52qg+ZiCs+klK9AEHlSj29+1WgrOLaPN
    PNlWzO/EZvfMR/tRApaNlVsZ1yGE6vJYHy1Xecog8nX0dh3Id9qbFIQLbIFfuWZWOErAyG
    +dgLJGG7B3zuQg+bW+gDM+29jTUy8sRpzjECbYB16ArgW81aCK4+O2r/zZsehg/rx7hvoi
    3Dxu2y3shBY0mi6hju006AlCwcd+b329n9n3mCJg/bHscQsfAcDmsKBI6jav7fQLjNPk8b
    PuOnQzDpLQZu4LJlneBpEyGgLWJBOw0hSsDUkh3imG98pS2xHTZLutWDvPEw
X-ME-Proxy: <xmx:5gfRaohgIa5e7NSAwWx5NBTwOdbEBYuiceRzP23-a36dwuc_xGpgSg>
    <xmx:5gfRaqd_kbtgYcM_J61yx_w8d4r2n5C8PBUAOXlidRGK9Ae2P3JI-Q>
    <xmx:5gfRavqxLWTbr8rbRsmTs-Sb0qs1VmgR-V9ktw2LNoLS1gv_W6EC5Q>
    <xmx:5gfRavB2vhuG5tuGVKp65RrkZ37EpwrzwJV6zZAkniLbD01fDohcIg>
    <xmx:5gfRanzPz_ejkXoKlKHUZsceYcWvI98w1ykQSVedPHYvrd2SPQ-xKAB_>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 13:05:41 -0400 (EDT)
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com,
	ps@pks.im,
	"Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Subject: [PATCH v7 1/1] repo: add filtering options to "repo structure"
Date: Thu, 15 Oct 2026 13:05:20 -0400
Message-ID: <20261015170518.48395-4-markchucarroll@fastmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015170518.48395-2-markchucarroll@fastmail.com>
References: <20261015144559.3652143-3-markchucarroll@fastmail.com>
 <20261015170518.48395-2-markchucarroll@fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation of "git repo stucture" provides summary
information about everything in the repository - all of the
branches, remotes, tags, stashes, and notes. But sometimes
to properly diagnose a problem, it's useful to be able to
filter this information to get focused data about the specific
part of the repo that's exhibiting a problem.

Update "git repo structure" to use rev expressions
to filter the set of objects to be processed.

This implementation makes an awkward trade-off involving
"setup_revisions" which results in doing the ref-walk twice when
revisions are specified on the command line. In order to accept
the standard revs parameters, it uses `setup_revisions`, which does a
ref walk and populates the pending objects list that will be used by
"repo structure". But this ref walk doesn't count refs in the way that
"repo structure" requires, and because "setup_revisions" doesn't support
a custom callback for its ref-walk, that's not changeable.

So in the cases where a user specifies revs, "repo structure" does
an initial ref-walk as part of "setup_revisions", and then a second
ref-walk in "count_references" in repo.c to count by reference type.
Further, if the user doesn't specify a revs parameter, "setup_revisions"
is not called, so the "count_references" walk needs to add objects
to the pending list. A parameter is added to "count_references"
to allow it to distinguish the cases where the pending
list is already populated from the case where it needs to
populate it.

Signed-off-by: Mark C. Chu-Carroll <markchucarroll@fastmail.com>
---
 Documentation/git-repo.adoc |  31 +++++-
 builtin/repo.c              |  32 ++++--
 t/t1901-repo-structure.sh   | 197 ++++++++++++++++++++++++++++++++++++
 3 files changed, 247 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index ed7d80c690..819202dc4e 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -10,7 +10,7 @@ SYNOPSIS
 [synopsis]
 git repo info [--format=(lines|nul) | -z] [--all | <key>...]
 git repo info --keys [--format=(lines|nul) | -z]
-git repo structure [--format=(table|lines|nul) | -z]
+git repo structure [--format=(table|lines|nul) | -z] [<revs>...]
 
 DESCRIPTION
 -----------
@@ -56,7 +56,7 @@ supported:
 `nul`:::
 	Similar to `lines`, but using a _NUL_ character after each value.
 
-`structure [--format=(table|lines|nul) | -z]`::
+`structure [--format=(table|lines|nul) | -z] [<revs>...]`::
 	Retrieve statistics about the current repository structure. The
 	following kinds of information are reported:
 +
@@ -66,6 +66,11 @@ supported:
 * Total disk size of reachable objects by type
 * Largest reachable objects in the repository by type
 +
+The set of objects counted can be filtered by specifying a collection
+of revisions to select which objects will be counted. These parameters
+follow the same syntax as the parameters to similar commands like
+`git log`. Defaults to all objects reachable from a reference.
++
 The output format can be chosen through the flag `--format`. Three formats are
 supported:
 +
@@ -141,6 +146,28 @@ using the `nul` format:
 git repo info --format=nul layout.bare layout.shallow
 ------------
 
+* Generates information about storage usage in the repository:
++
+------------
+git repo structure
+------------
++
+
+* Generates information about storage usage in the repository omitting
+the branch "foo":
++
+------------
+git repo structure --all ^foo
+------------
++
+* Generates information about repository objects reachable from
+the references "x" and "y", but omitting anything that can
+only be reached on a path including "xchild":
++
+------------
+git repo structure x y ^xchild
+------------
++
 SEE ALSO
 --------
 linkgit:git-rev-parse[1]
diff --git a/builtin/repo.c b/builtin/repo.c
index 84e012f83f..78638c2dcd 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -27,7 +27,7 @@
 	"git repo info --keys [--format=(lines|nul) | -z]"
 
 #define REPO_STRUCTURE_USAGE \
-	"git repo structure [--format=(table|lines|nul) | -z]"
+	"git repo structure [--format=(table|lines|nul) | -z] [<revs>...]"
 
 static const char *const repo_usage[] = {
 	REPO_INFO_USAGE,
@@ -740,6 +740,7 @@ struct count_references_data {
 	struct ref_stats *stats;
 	struct rev_info *revs;
 	struct progress *progress;
+	bool add_to_pending;
 };
 
 static int count_references(const struct reference *ref, void *cb_data)
@@ -766,10 +767,12 @@ static int count_references(const struct reference *ref, void *cb_data)
 	}
 
 	/*
-	 * While iterating through references for counting, also add OIDs in
+	 * While iterating through references for counting, if we didn't already
+	 * populate the pending list in setup_revisions, also add OIDs in
 	 * preparation for the path walk.
 	 */
-	add_pending_oid(data->revs, NULL, ref->oid, 0);
+	if (data->add_to_pending)
+		add_pending_oid(data->revs, NULL, ref->oid, 0);
 
 	ref_count = get_total_reference_count(stats);
 	display_progress(data->progress, ref_count);
@@ -780,11 +783,13 @@ static int count_references(const struct reference *ref, void *cb_data)
 static void structure_count_references(struct ref_stats *stats,
 				       struct rev_info *revs,
 				       struct repository *repo,
-				       int show_progress)
+				       int show_progress,
+				       bool add_to_pending)
 {
 	struct count_references_data data = {
 		.stats = stats,
 		.revs = revs,
+		.add_to_pending = add_to_pending
 	};
 
 	if (show_progress)
@@ -935,6 +940,7 @@ static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
 	struct repo_structure stats = { 0 };
 	struct rev_info revs;
 	int show_progress = -1;
+	bool included_revision_args = false;
 	struct option options[] = {
 		OPT_CALLBACK_F(0, "format", &format, N_("format"),
 			       N_("output format"),
@@ -947,16 +953,20 @@ static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
 		OPT_END()
 	};
 
-	argc = parse_options(argc, argv, prefix, options, repo_structure_usage, 0);
-	if (argc)
-		usage(_("too many arguments"));
-
-	repo_init_revisions(repo, &revs, prefix);
-
+	argc = parse_options(argc, argv, prefix, options, repo_structure_usage,
+			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN_OPT);
 	if (show_progress < 0)
 		show_progress = isatty(2);
 
-	structure_count_references(&stats.refs, &revs, repo, show_progress);
+	repo_init_revisions(repo, &revs, prefix);
+	if (argc > 1) {
+		argc = setup_revisions(argc, argv, &revs, NULL);
+		included_revision_args = true;
+		if (argc > 1)
+			return error(_("unrecognized argument: %s"), argv[1]);
+	}
+
+	structure_count_references(&stats.refs, &revs, repo, show_progress, !included_revision_args);
 	structure_count_objects(&stats.objects, &revs, repo, show_progress);
 
 	switch (format) {
diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index 02cc2b594a..4e5e4a0a7a 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -144,6 +144,203 @@ test_expect_success SHA1 'repository with references and objects' '
 	)
 '
 
+test_expect_success SHA1 'repository with branches' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit_bulk 1005 &&
+		git tag -a foo -m bar &&
+
+		oid="$(git rev-parse HEAD)" &&
+		git update-ref refs/remotes/origin/foo "$oid" &&
+		git checkout -b grobble &&
+		test_commit_bulk --ref=refs/heads/grobble 20 &&
+		git checkout master &&
+		test_commit_bulk 20 &&
+		# Also creates a commit, tree, and blob.
+		git notes add -m foo &&
+		git repo structure --format=lines >actual 2>err &&
+		test_grep "^objects" actual >actual.objects &&
+		cat >expect <<-\EOF &&
+		objects.commits.count=1046
+		objects.trees.count=1006
+		objects.blobs.count=1006
+		objects.tags.count=1
+		objects.commits.inflated_size=231976
+		objects.trees.inflated_size=16578431
+		objects.blobs.inflated_size=11962
+		objects.tags.inflated_size=132
+		objects.commits.disk_size=163722
+		objects.trees.disk_size=284547
+		objects.blobs.disk_size=21022
+		objects.tags.disk_size=126
+		objects.commits.max_size=223
+		objects.commits.max_size_oid=0dc91eb18580102a3a216c8bfecedeba2b9f9b9a
+		objects.trees.max_size=33063
+		objects.trees.max_size_oid=60665251ab71dbd8c18d9bf2174f4ee0d58aa06c
+		objects.blobs.max_size=13
+		objects.blobs.max_size_oid=97d808e45116bf02103490294d3d46dad7a2ac62
+		objects.tags.max_size=132
+		objects.tags.max_size_oid=4dae4f5954f5e6feb3577cfb1b181daa3fd3afd2
+		objects.commits.max_parents=1
+		objects.commits.max_parents_oid=df6400c01440c329f1011669c4c26cc0c7852887
+		objects.trees.max_entries=1005
+		objects.trees.max_entries_oid=60665251ab71dbd8c18d9bf2174f4ee0d58aa06c
+		EOF
+		test_cmp expect actual.objects &&
+		test_must_be_empty err
+	)
+'
+
+test_expect_success SHA1 'filter by a positive rev' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit_bulk 1005 &&
+		git tag -a foo -m bar &&
+		oid="$(git rev-parse HEAD)" &&
+		git update-ref refs/remotes/origin/foo "$oid" &&
+		git checkout -b grobble &&
+		test_commit_bulk --ref=refs/heads/grobble 20 &&
+		git checkout master &&
+		test_commit_bulk 20 &&
+		git notes add -m foo &&
+
+		cat >expect <<-\EOF &&
+		objects.commits.count=1025
+		objects.trees.count=1005
+		objects.blobs.count=1005
+		objects.tags.count=0
+		objects.commits.inflated_size=227371
+		objects.trees.inflated_size=16578363
+		objects.blobs.inflated_size=11958
+		objects.tags.inflated_size=0
+		objects.commits.disk_size=160455
+		objects.trees.disk_size=284462
+		objects.blobs.disk_size=21003
+		objects.tags.disk_size=0
+		objects.commits.max_size=223
+		objects.commits.max_size_oid=0dc91eb18580102a3a216c8bfecedeba2b9f9b9a
+		objects.trees.max_size=33063
+		objects.trees.max_size_oid=60665251ab71dbd8c18d9bf2174f4ee0d58aa06c
+		objects.blobs.max_size=13
+		objects.blobs.max_size_oid=97d808e45116bf02103490294d3d46dad7a2ac62
+		objects.tags.max_size=0
+		objects.tags.max_size_oid=0000000000000000000000000000000000000000
+		objects.commits.max_parents=1
+		objects.commits.max_parents_oid=c1d3cb6c863e93a546c657ccecdf0f643d2e18af
+		objects.trees.max_entries=1005
+		objects.trees.max_entries_oid=60665251ab71dbd8c18d9bf2174f4ee0d58aa06c
+		EOF
+		git repo structure --format=lines grobble >actual 2>err &&
+		test_grep "^objects" actual >actual.objects &&
+		test_cmp expect actual.objects &&
+		test_must_be_empty err
+	)
+'
+
+test_expect_success SHA1 'filter by both positive and negative revs' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit_bulk 1005 &&
+		git tag -a foo -m bar &&
+
+		oid="$(git rev-parse HEAD)" &&
+		git update-ref refs/remotes/origin/foo "$oid" &&
+		git checkout -b grobble &&
+		test_commit_bulk --ref=refs/heads/grobble 20 &&
+		git checkout master &&
+		test_commit_bulk 20 &&
+		# Also creates a commit, tree, and blob.
+		git notes add -m foo &&
+
+		cat >expect <<-\EOF &&
+		objects.commits.count=20
+		objects.trees.count=1
+		objects.blobs.count=1005
+		objects.tags.count=0
+		objects.commits.inflated_size=4411
+		objects.trees.inflated_size=33063
+		objects.blobs.inflated_size=11958
+		objects.tags.inflated_size=0
+		objects.commits.disk_size=3122
+		objects.trees.disk_size=53
+		objects.blobs.disk_size=21003
+		objects.tags.disk_size=0
+		objects.commits.max_size=221
+		objects.commits.max_size_oid=c1d3cb6c863e93a546c657ccecdf0f643d2e18af
+		objects.trees.max_size=33063
+		objects.trees.max_size_oid=60665251ab71dbd8c18d9bf2174f4ee0d58aa06c
+		objects.blobs.max_size=13
+		objects.blobs.max_size_oid=97d808e45116bf02103490294d3d46dad7a2ac62
+		objects.tags.max_size=0
+		objects.tags.max_size_oid=0000000000000000000000000000000000000000
+		objects.commits.max_parents=1
+		objects.commits.max_parents_oid=c1d3cb6c863e93a546c657ccecdf0f643d2e18af
+		objects.trees.max_entries=1005
+		objects.trees.max_entries_oid=60665251ab71dbd8c18d9bf2174f4ee0d58aa06c
+		EOF
+		git repo structure --format=lines grobble ^master >actual 2>err &&
+		test_grep "^objects" actual >actual.objects &&
+		test_cmp expect actual.objects &&
+		test_must_be_empty err
+	)
+'
+
+test_expect_success 'filter by object type' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit_bulk 1005 &&
+		git tag -a foo -m bar &&
+
+		oid="$(git rev-parse HEAD)" &&
+		git update-ref refs/remotes/origin/foo "$oid" &&
+		git checkout -b grobble &&
+		test_commit_bulk --ref=refs/heads/grobble 20 &&
+		git checkout master &&
+		test_commit_bulk 20 &&
+		# Also creates a commit, tree, and blob.
+		git notes add -m foo &&
+
+		cat >expect <<-\EOF &&
+		objects.commits.count=0
+		objects.trees.count=0
+		objects.blobs.count=1006
+		objects.tags.count=0
+		objects.commits.inflated_size=0
+		objects.trees.inflated_size=0
+		objects.blobs.inflated_size=11962
+		objects.tags.inflated_size=0
+		objects.commits.disk_size=0
+		objects.trees.disk_size=0
+		objects.blobs.disk_size=21022
+		objects.tags.disk_size=0
+		objects.commits.max_size=0
+		objects.commits.max_size_oid=0000000000000000000000000000000000000000
+		objects.trees.max_size=0
+		objects.trees.max_size_oid=0000000000000000000000000000000000000000
+		objects.blobs.max_size=13
+		objects.blobs.max_size_oid=97d808e45116bf02103490294d3d46dad7a2ac62
+		objects.tags.max_size=0
+		objects.tags.max_size_oid=0000000000000000000000000000000000000000
+		objects.commits.max_parents=0
+		objects.commits.max_parents_oid=0000000000000000000000000000000000000000
+		objects.trees.max_entries=0
+		objects.trees.max_entries_oid=0000000000000000000000000000000000000000
+		EOF
+		git repo structure --format=lines --objects --all --filter=object:type=blob >actual 2>err &&
+		test_grep "^objects" actual >actual.objects &&
+		test_cmp expect actual.objects &&
+		test_must_be_empty err
+	)
+'
+
 test_expect_success SHA1 'lines and nul format' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
-- 
2.53.0

