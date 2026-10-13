Received: from flow-b7-smtp.messagingengine.com (flow-b7-smtp.messagingengine.com [202.12.124.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2316F5221C0
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 17:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912560; cv=none; b=cxnFMSqd67N8HTfDkYappG7TyFy8YvIYSA4LkGR0TSMXCuzq2dgFEOOdWdRNDlNOo1MkpOd1EgEW0I911rA9YwB85XKiv2l0waN5ax0KRcsHmDe1486/LeJAtKqIlSpBQidR2icnyc1CHNXlHOSpBGDWTZRUH2xxDGoQ327LG50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912560; c=relaxed/simple;
	bh=M5ytjtbYnWjSOp140jLJG3zeJTBKpia7RbKqQiss0KM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AdlIv9nVyv8S/GJNZl4qvFf0J/4ENvyf+37TaRZUtDzQtzCn5chWbCaLelUPivaRJvWaw54yY+ZijwY0+71p5OK0L6UYOKEghvuYOLL3t9jLfeC5/F0FSHd2x547/aEhK+8G1m2pMDjtjiH7hwj8Gotmq7e3ynYtO09qtNhXGqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=H9GuouRE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=x523Nct7; arc=none smtp.client-ip=202.12.124.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="H9GuouRE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="x523Nct7"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id 5DAE41301043
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 13:29:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 13 Oct 2026 13:29:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1791912557; x=
	1791916157; bh=BRuvva05PJQzjpxDDad21CbfEVVF6A6a8D7wXoSIHGU=; b=H
	9GuouREXeOk5K5tJgnrbG1kmtQfsoqBiAn95NL38ECJbJZLZBkAERmdKt/mjYlFv
	7upIclCIVk4zU2axFS1/SRwoRYciRK9QGQaMSgFj9PFEr0sOwqHWcYgL8b8y6kMi
	p/RbHMaokz495B2VFYBfXdxVgEu6NNOVc98G5YQbgh38Gyxf/0JjC3aHTNQyZZe8
	oFLO5l+bvqj2EUfe/LBBVVD/gLt/mina/h3aggtZ4L/1mlQZ087LYIfInL3cJr/c
	Tue3G43cSpXlJE+DnhwndAL1EhyKfQgbyWnId760thM9VSeAMOq1SDALknmyHroL
	gjDeAtTW8wXUxYfjMELDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1791912557; x=1791916157; bh=B
	Ruvva05PJQzjpxDDad21CbfEVVF6A6a8D7wXoSIHGU=; b=x523Nct7XgVNit2Xv
	/Q8bLyOSS/o6X5uIYZZeOF/Z5mK9SsVJonuWcIlPN3Jxzqq7RLS0lhJZ1XLaR/fN
	E5sdL85Vr8ngBQ7XXZaVS/Cosr4gRZTrZsL2AYShd6YHf8F1o2xCJanjspdwnNaU
	tNG9xMhoOB8f8c9DU5WZVBz97RmTM8FeBKQqaWMe5ElojJ1fsDGRJpAjrSSqxHLZ
	cgXxz04vn5UVubqui47psBmrMWOu9QNJg/84hzcGW7yU6rVcgahCQiVOEDP33IzH
	P7TvSvMuEQuMUmWHpzeR1tc62RXhRtYPQ0e9etrD5EVbMmVrz3pphlNpZNHvVlrL
	5jB7A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791912557; d=fastmail.com;
	mf=PG1hcmtjaHVjYXJyb2xsQGZhc3RtYWlsLmNvbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:tW/okakgk7SJSucqRNKL/ExQR4G5XNNWcJUDAcoa7E/VUlt
	eAFLdBRJ1aXFOWSj3TKs7wvVmFcBr0laZ4nDGvAa+nI2LuV0c+nAr49Vtulrv8q1
	IrIi1UT0yoB7SkZWb36hTXAC+hu7PGJt4Cm7nse4hq2RELiLJ6bw/q2TwIPizLan
	HUaVTOCS4GFs+ooVpWS9QFJ+gbgj3+jK0wNDhbPVjfrJoL3lNbLO2MK9JlM6CMU2
	DdQsVJtSKMDs2nT8y/SaopUDF0IOcww//auZCYBsiIWNy1MQTw7y1VkdoFzj8BBW
	fXkyqWJwh7zCIw3OqpBLr6pmMrDWwVDxB9Gk4+w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:ZwnMXSwyZp95b44qncVAEtNxYWeU18CP89uKEOwSPpc=:M5ytjtbYnWjSOp140jLJG3zeJTBKpia7RbKqQiss0KM=;
X-ME-Sender: <xms:bGrOaqUohzk9PkB0IvuRvl4Wxo8kRDVscJStn_63AuUK-8No6sKF6A>
    <xme:bGrOatlMW966FkVlaxz66pBZPUrXFZx8flyPtkf5vNHylVEaxfY7gYQXVJAgd_q_k
    g7gnjZmzrQO4QbC7Ki2mUxju5N1eHa5Up7NaaTuM1zMOYhe3oA4Iw>
X-ME-Received: <xmr:bGrOaja84Cdt4fO1uc06_nrWLHgq9RGPGXQQpOjDbC_u31zsARAa1zezN8iN9_Bi74vYNrP287JwH8hCrAuUA6oth2sZMMU4Xrd_WXg7XZBgNA>
X-ME-Proxy-Cause: dmFkZTEtnvW9IPgAf6BqDj28j799XQ1bqExy/kW8oe4hpny3EYHUdwstFVLMz46WtiwH3b
    Rivg0J575pq9cTgsyum3YTLBCVFdJjKgBNmAqcA74w5VI2bsW2Wd6Lpyk9DlNYQYEPESem
    RQDRUQzb52OEW+JpW2/40bMIW1FalY+S/f8XcrFywHOzvx1Cu+B1IErMDGP642przGTRl/
    nt7TrPy6TBf+Ulr8vwDy4UGTxk+IE4d4lbDuL9QTChe/Dt9Zbo8EYpI9WHvWBiHYJ53OxV
    RGC6UmXC4irMr9UDIiCVt2cgfEbBejvNk1rezoV58xcRAVDYhgqXsdiuYlv9j6jCBzCIo2
    YH69TfS9OpczflyaqPUnQ9BeIt1GJQEHHjBD1M9nnGMITNgBpLS8QgspvO+N2/dnPt3r6m
    ek10IrFgBeR9HIUyfxH2VqDxA/u9Gjcu+Nuu8VYx2RkDZA4njYo2DEZluvC+/0bxoKdyHi
    6EFgDp1WWqJbVQo0qZpdzrdAHf3OIvAKGLeaHagBMdSxOK+QHqYHMOxquyl65q06BbGGCc
    zanqsC483IEI+6tQP0wms8oocGMcVGPPph9VSfO0I1oCcFjXof4cUgexLmrWrv3gJKVZaY
    TX5H1nfSyrb1f5KYsLoYoXLNbnSavk5q3nUewPTf02B6vC+1sGrUUe+U/Tgw
X-ME-Proxy: <xmx:bGrOagO1sBLyygjGxg3sfQXHfmuUYeBfojlQZuwSiYq6K8Db1f7_DQ>
    <xmx:bGrOagb64t2z7ai83ZzbObEW1nCbmWBukhRPtZvBin3so5GKjaaS1Q>
    <xmx:bGrOam0mZGbSGHWLJLDUBM3jOipvd5QUp7PviRQbnBbBUVR8PbvNFQ>
    <xmx:bGrOauddkQ1hlRt61cWNC9_3f5s-HvmoZ4GyPH2YXr0JPUPtPGOr6A>
    <xmx:bWrOan_Extpjo8V8otRp4qp69NOZNwZNbGDysa6aOUFBbgmE5IQsTD4t>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 13:29:16 -0400 (EDT)
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com,
	ps@pks.im,
	"Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Subject: [PATCH v5 1/1] repo: add filtering options to "repo structure"
Date: Tue, 13 Oct 2026 13:28:51 -0400
Message-ID: <20261013172849.1109478-4-markchucarroll@fastmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013172849.1109478-2-markchucarroll@fastmail.com>
References: <20261010150539.930614-2-markchucarroll@fastmail.com>
 <20261013172849.1109478-2-markchucarroll@fastmail.com>
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
revisions are specified on the command line. In order to accept standard
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
 t/t1901-repo-structure.sh   | 208 +++++++++++++++++++++++++++++++++++-
 3 files changed, 253 insertions(+), 18 deletions(-)

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
index 84e012f83f..f45dea06d5 100644
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
+			usage(_("too many arguments"));
+	}
+
+	structure_count_references(&stats.refs, &revs, repo, show_progress, !included_revision_args);
 	structure_count_objects(&stats.objects, &revs, repo, show_progress);
 
 	switch (format) {
diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index 02cc2b594a..1d25ee14e5 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -140,10 +140,208 @@ test_expect_success SHA1 'repository with references and objects' '
 		git repo structure >out 2>err &&
 
 		test_cmp expect out &&
-		test_line_count = 0 err
+		test_must_be_empty err
+	)
+'
+
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
 	)
 '
 
+
 test_expect_success SHA1 'lines and nul format' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
@@ -186,13 +384,13 @@ test_expect_success SHA1 'lines and nul format' '
 		git repo structure --format=lines >out 2>err &&
 
 		test_cmp expect out &&
-		test_line_count = 0 err &&
+		test_must_be_empty err &&
 
 		git repo structure --format=nul >out 2>err &&
 		tr "\012\000" "=\012" <out >actual &&
 
 		test_cmp expect actual &&
-		test_line_count = 0 err &&
+		test_must_be_empty err &&
 
 		# "-z", as a synonym to "--format=nul", participates in the
 		# usual "last one wins" rule.
@@ -200,7 +398,7 @@ test_expect_success SHA1 'lines and nul format' '
 		tr "\012\000" "=\012" <out >actual &&
 
 		test_cmp expect actual &&
-		test_line_count = 0 err
+		test_must_be_empty err
 	)
 '
 
@@ -220,7 +418,7 @@ test_expect_success 'progress meter option' '
 		GIT_PROGRESS_DELAY=0 git repo structure --no-progress >out 2>err &&
 
 		test_file_not_empty out &&
-		test_line_count = 0 err
+		test_must_be_empty err
 	)
 '
 
-- 
2.53.0

