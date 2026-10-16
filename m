Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448AC4B95DB
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 13:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792157488; cv=none; b=sX7Y+gAootDoF3IM+K9QeB7JmXjb4E5/3Gpg3UaMSh+Ky4Txv3SHz73z+IxVu0FPVnI+dKYhVgWualROd7vOVJiMCjrWwpvpFp9aWOPXHO4YK3ONejZszuli5GTOXA+00KBp77QrS9UEeMmzE4Kg9lWWDsLIYWzhpEmeIGec6Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792157488; c=relaxed/simple;
	bh=98usU+S7aNc8OdQroL6cSUs55hKC206D8DSJJZsiQY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LRetnvJ2m7fkXuHVqQj9rfKon8/Yrl3tqm8piMDTlFDkP7q5Nrgdl7L9KHFToi1mSeUmftSruvxk4f+rZza7k2Dil/wzA5khv+AUjU51b5BWVf0DNY0P2ZbW0+qrdZozNfZN1BayzmBF1HLm1Dc/wv7gNl8N/4Xb50fFf9djH5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=uE8dGka5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Oqhg6eJX; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="uE8dGka5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Oqhg6eJX"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7C9727A0152
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 09:31:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 16 Oct 2026 09:31:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1792157485; x=
	1792243885; bh=f92gyKGB87oeFnoG04fmWJdMV9N4c3ygqjdCgTYWNl8=; b=u
	E8dGka5Vz4D7SXL8j2B5TBnRbrG8Zrc322hP4WJ5VhyfTfaHZesAX5tz3fjBtUol
	RXSwhl3dosNtuYTJJbzWoBEuQqALRY2dmHFYRWZiKejZcja/fQM16NTckO1B2ibE
	4sE8khYGvkSMa7GhawmHQw2jSntYpiSL3wOkcYF38FxE4N0g1/e8J00gxuF8JaRJ
	ek+eYP2UGDWrpylBLua5PeSlpi0VTxbpbn9cnKX74nZ/NzTtNCuN5s87lK1dOZWZ
	jXT0Ibq8BfRwipbI2GWEpXv/bpoTHnJeNiuJITNI2soePEynu25r1mCl4Y6GlKFW
	tB8Qou3E9owTbrPBv1FFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1792157485; x=1792243885; bh=f
	92gyKGB87oeFnoG04fmWJdMV9N4c3ygqjdCgTYWNl8=; b=Oqhg6eJXcZ2yHIXHC
	lpiZWImMMluRXZy/hbw3LJcfP6hRZFJZcquCgHH8ytIufi5x7MhR1Idc/I8NPF+k
	jQKOq1I08YE0l5vEGURUWvs3BqbIQp56n2wttYMoo72duP87AQL7YoG/xzAiAVZO
	wli/8T49NU9RN+DZVoNsmG1DJB4K/DcSWVK+3mjkDi/jcOk93qw0qlWJWKqhUSf3
	EBEBjvAFoq1y3pumFECKgDkEJ4GgdI5x9IgmmylDQRYM4PhYHc1TbgqCUyeHXwsS
	98hXjlcRgXTn2SzZQieuvUnSFRMgJo6+ogLqh4RWZJnaZt+LsZRkWMf+Uw8SHNru
	0R34Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792157485; d=fastmail.com;
	mf=PG1hcmtjaHVjYXJyb2xsQGZhc3RtYWlsLmNvbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:k/zeeA7gAF9a6VcbbMAPe7Vf+MhPIjWBQg4xG5FpTdv95gR
	IOYVKX/TxVBO2KP4d66JQEgkTEibbpLbZvCAwloYckj6Yv0GzLbHJ6XhxBm7KOHR
	pWlSdozyaX3QZqdFh625S0TQvgGDoowuKvseYbI7orMEO8TX5JQi0xz+DbgyAHzb
	fC1cQWfBF5av6Qbikky/NK/WnsJmvxu0vlqVEl1+FqQPlTaQB3+hEka2edUPo5JQ
	3wkj1KNOMMvI7bohCZgrvdeOcuT6fwz1Y3nT06L0rOPO+qvsCZnDjpsMzC60WVk8
	8vckgBAi4eXZ2u39HtQrcrKpHHLJ+/jP0123vtg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,reviewed-by,
	subject,to;
Message-Instance: m=1; h=sha256:BLgNd22zOWLdmPkfyYnr6zC6TtNvGMuyYs/ZOTtnjZc=:98usU+S7aNc8OdQroL6cSUs55hKC206D8DSJJZsiQY0=;
X-ME-Sender: <xms:LSfSaqwYdWEqTpfHaaYdIxJ_-HExSN2N5rzBlhXxlJDeSs4Xp3St4A>
    <xme:LSfSatLvwrSFRe9zeCXOPAdq3tTT9utqd8JqifHXyYHUrEUksdCksqNKDDmnXH5P1
    8XAY6vye7e7TUqA2N_SlwFyOfNjzjFjZWdAnS97XgPvns8OP_sC-vs>
X-ME-Received: <xmr:LSfSakpbIe81KlPWdDq2mbFL7vf-HTr1_26ZYM5RruCfaeG0mZ2OP9kiL3Q4QO7_FhFCWdWbzc1E1AB7eQeC-xdbMDfPOtXhaexvD37Dco0VMw>
X-ME-Proxy-Cause: dmFkZTF6m93v0iAVst1k9RCWZWM9b8ltsvtmKqnmjEqGaV74Kbbtltsw6gjIbSkGHD3afy
    WOgwCntXpyj/8sf6mLAjAWxe13DROOWLOQh8kHMRMUpoTOYcW3HFtAs8FYY0nPWXfYqDiY
    8SlxjAdMj7tCFkxQ7njCg3xOl2mbJVI7mr7shVJa+IgLyqoGNOiyFM+sS3C7lxWBvQ+ITI
    v0pFbbCCgY0i5LZQfuczOldwvLgBSMZkUjA08rRWyRMp7mwARi1+zaMde+hOb3lAulK1zv
    1VuAXL8VxGERvxt5a7LnE1KyeiRLm39nEvspmZI+QslZ0fobtdpIFkB+t8csDW2usf8eda
    eZ6gWg4Z52cxH334dvuk9HtFWIlxjr8zjpPluJPrPqlykOZZMrn09PAmhcS1jm6FoK6wAV
    6yly2nq1Oiej6IWespKs0FOlvOjLsgAXnB9sZKDbuKGYtThslY5f8+jxUNA3fEnFezi3pC
    RiCXcQ0dXoGMraTviZm0xxje2ggLSVbr6dK2VoaQzVOSzWqOAcIjyAGDpBs/IK9StKEIwC
    dmKL4snGictfLFmCaIhvUMKPYgxvWG2caPwUt+NMt2uGs4sh6/ANX8px2a9D80JdJ6fYmI
    P1xMSNKI54tql4F2mg2XQqQwnE5qUrBXQjGN/cQeunhFgEKgwPpnJwsyeW1A
X-ME-Proxy: <xmx:LSfSasKEEaMpwWFUpbn4AJNAegXVqQMrlxZv2LgQGTSY9cQbsBXRNg>
    <xmx:LSfSapSPqf_rF54mLibM0_MFb_svxRx8VW1ikWT7Bpo6pxSYrWpgag>
    <xmx:LSfSartzneplPfRv14OyivqV2m9Vk5Sgg7yIPx_Y4T-b4yviaA9_bQ>
    <xmx:LSfSaqaQoYsuvLHOQNtbKvmIFbZFr18KPtv_5go0WqzA0CA89jGmGg>
    <xmx:LSfSanateo8wlTxiExj-VDi85mSuehDkU6SknDydqQXfgPSbn_gpWUQ4>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Oct 2026 09:31:24 -0400 (EDT)
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
To: gitster@pobox.com,
	git@vger.kernel.org
Cc: jltobler@gmail.com,
	ps@pks.im,
	"Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Subject: [PATCH v7 1/1] repo: add filtering options to "repo structure"
Date: Fri, 16 Oct 2026 09:31:18 -0400
Message-ID: <20261016133118.3659793-2-markchucarroll@fastmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016133118.3659793-1-markchucarroll@fastmail.com>
References: <20261015144559.3652143-3-markchucarroll@fastmail.com>
 <20261016133118.3659793-1-markchucarroll@fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reviewed-by: ps@pks.im
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

