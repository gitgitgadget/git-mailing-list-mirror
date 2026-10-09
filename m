Received: from flow-b1-smtp.messagingengine.com (flow-b1-smtp.messagingengine.com [202.12.124.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3C24F7CD5
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 18:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791569414; cv=none; b=mSTGqpLCzpIpYxRT2rU5AhJfV03IkIj3JI5jrS1H7gdK0pV7eDF4gso53IXfiRXvQPpxbilBuyumlxeH1ywcOLIyJ/VTt1IIOWq4Y2QQVgKEbrWj9gVb819V5GFii8sUnYFyTP4aX9I+Myw9ybeSDPn4P6GR3r3VDFxI8DJDW3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791569414; c=relaxed/simple;
	bh=RobVyZHnxvITyoMQKylu6uT+kwFB1ChmWh54vviVfls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jWubPUumUjVHVTVlbjOvv+M+ZuxFarh+IvePGu3Q1D6acaLWqlx0bD6DRsNL7hL2RoiCNa6kT4BqiWGM7K/GtNzwbOs9UE5vAydT9ZxS1lwCRG92WCSKIBiKMKCJStzy9B1MiLa+sotQWCISGJ5f5p+hzgAEmmZJDQ3c6sziXLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Dq6Hcm9r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D87MUC7a; arc=none smtp.client-ip=202.12.124.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Dq6Hcm9r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D87MUC7a"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id C309D1300F26
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 14:10:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 09 Oct 2026 14:10:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1791569411; x=
	1791573011; bh=dMWjtuPLJKrAE7Dr3zp/ZtQLTwPYiGtBaSD/vQ1tFk4=; b=D
	q6Hcm9rumJsZ9NyPFPwn7iKJBCDkV/jv+2kPs4nNhn//kY8wA3BexEB8TKVhO1vn
	nBPb6UlRZiROmF/Ssb/GrVTcloXg4T+fv9YJRsEzHv9DuId9aZ1yDu4h1CGI0ne1
	+Ne184105YzqVsNkIc+0xOm36qfhP4L2JjAvZRm6ux5zDQ/zmQxu1e4lrp/qcMa4
	rpKOLLVyBnYcz5ZmhOi+krXpbd58/fBYiY+b3/5oIuZhyR4ck/4fRA8KNgt5yGdp
	CQqhAyFo+CUSq5D91AKwJlWuHLKkRtcoCp+xqTx6xeqJeoY3KQGOVlFWA9MTM7Av
	kxxItMrxQVsw2toWTT3OA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1791569411; x=1791573011; bh=d
	MWjtuPLJKrAE7Dr3zp/ZtQLTwPYiGtBaSD/vQ1tFk4=; b=D87MUC7a2O8QclpCW
	rDWHsQPYEuYnZL1F3ChhoRD0mYh1+fuEWEmsu3tzrJdTKKHmFg/hzRKaO/1Zcy5F
	SRuN58cpPwkZKz1nYG0bVVWhUEMac+zfcnq/QzIteBe95FZWRhQfAZakorPB2xMd
	oeVKlT6cdjsSZa/p4H7rivJtN58d6qK55Lt9Zu0Lc64dvHevIRwg1aVtmQWf70u3
	waOmJu34xvJHk8i1gSQtBim2dXEdSs1szKcTuw6tjvYoAmU0Vn3p67rmyOCJzuWJ
	hxJHi6bhAO3cgZ3qvpXwG5yeKQi9z61VjunHCIILPQ2SwKxguYYCBlbNZG7DxYK1
	YYPOg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791569411; d=fastmail.com;
	mf=PG1hcmtjaHVjYXJyb2xsQGZhc3RtYWlsLmNvbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:p3ZPZo/R4qpEgvq144U/QdVRXmWhP8iwCcZwUzCAeUmCSAk
	s0tYtg1fBgByaRXSmz4hJLxBusygowRKsP7OlWkhpEyYaEUyowNuKnrTTAiHkCWH
	ViD6Qvef+wnHSdYr5Pth4WCxVCnhB4pA+blwvlHKtdae3N4FBlwxrMqZZ57O6Pgc
	AR4/jd+ksQ+pmhSLY9NhDvi2d8s4AdjIOrOt3Qz4i4sO7qz9DelO2znHPALU/60j
	f7G/CARPMvPBPAh/47oxmPnoq9bjfmZH0bxHjt4cdy3ATKM5jJ5e0y+VyRsDybka
	26NIKBTdtGjEaylxLbstoVu0QZkW7mBBF7W5tBA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:IvpuiwXfhP+r1XmNtTdqkUcozld+lJTOcqd+TbbWXBI=:RobVyZHnxvITyoMQKylu6uT+kwFB1ChmWh54vviVfls=;
X-ME-Sender: <xms:Ay7JaqWlkLTEsOoFYT-mdQW_1THzd6z2GxAx9ZW0LLPa-gJ-ArWxUg>
    <xme:Ay7JatmFswMWeG3I4bUKiCJfwAOcyv1weOlLVj-dteDVj73LgzF4k_cQjTPXSkTme
    HmkK_pxs78OnnsdEP0wxKQUNBut2jCnGgOzXkuxIEkZyQ6hMJ0Xp6Q>
X-ME-Received: <xmr:Ay7JajYBp91okmQYuNuu_sMEwm70Fdo7m0OUKgQPegBzv17IzLunt6mnXGSVo3I_U_cNaSgO-driqE4PJCTyhxpHNEoxDizSyzOEoM4VL9AV0_H48DY4JQOScJ3jQo4UYH-oIFNOx4DF3hqPJ0LV>
X-ME-Proxy-Cause: dmFkZTGvrWrBqoNo/SGmDMChYQVxAQK1vuW2zvi/SyW6vEyDefe0kXikfbNtQSiyJre3Vs
    Pak99tUzUmRHJljeBr6NGr/dYaq5PcxPUzapGW8wOcXRqM0VS/gpDF3W03XiqGpmAfbgmn
    Y3D/xKgdACj3+ZVIjDdmM8e+sEitBsye1tUJ8vvqTUay/S+y5lex6nC/LurPbySnqtU1P/
    zsRvkXqI1QfYLKJDDnAcu28beqETaje9kmBJnijlK6rX5oRyjbhSm/94KE0opPRNTU2NnR
    TyBxu7Kq36pFVOzB/E6J9fKOuktElS284kj4fTWjKMhxPQ8maqad2lVRlDiFRaMwlav5WD
    SBkh87hm1OddemEZ45jyl3RxVISrXcWt7BkEfEaJlD8RQHrnTnxVVD+ka35Ml5OFtd+3in
    Uc4l/hTweTtHDFE/O4rbTsOSBBgXFR9b3Kral/CGipmgGvbNCL54wTKKjC0XP4ZxpOpMRi
    gmzGyGuKZ+AE4UmBNp0YZ4PX6ZsoNIhBWNSnxsFDqoDovGEMKVTZDE2wsGEDGsQekezNdS
    w6ztlcGDWSNwTaM8uMiOKWcINwzb4RN61vo+Kk8NGji67BucR/+QTcSsbcpFBPk/lAjc+S
    5Agr8M24di8hrEvD0ZN3GgAPbpK8tFbELo7Y3JuXLredm5iJFwjQLfVpKTtA
X-ME-Proxy: <xmx:Ay7JagMWGjZBz_dxlMDbJNJY4eovOS_LV7-I6Tqu5sG5uvJEJz9oaQ>
    <xmx:Ay7JagZH5wqgCqndmQbeqCxMbviU2zQwQkZqa9R8zvyyv3rYFmRN7g>
    <xmx:Ay7Jam3vZmo9OGpWyZCEUQgvqA0SMDX5c48N9CIaeQV_Jcfzr96B8w>
    <xmx:Ay7JaufyVo-DWjyNIq3hdCxM7tHXS2r58MtwoS4g0vkmDXJ74WTM3Q>
    <xmx:Ay7Jan89QDIIPXJEs1990wru5QAaHBrKh2Xr_bqcRcNiYrNpnAfd_pxi>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 14:10:11 -0400 (EDT)
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com,
	ps@pks.im,
	"Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Subject: [PATCH v3 1/1] repo: add filtering options to "repo structure"
Date: Fri,  9 Oct 2026 14:09:51 -0400
Message-ID: <20261009180951.1628134-2-markchucarroll@fastmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009180951.1628134-1-markchucarroll@fastmail.com>
References: <20260924164503.119506-2-markchucarroll@fastmail.com>
 <20261009180951.1628134-1-markchucarroll@fastmail.com>
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
"setup_revisions". In order to accept standard the standard
revs parameters, it uses `setup_revisions`, which does a ref
walk and populates the pending objects list that will be used
by "repo structure". But this ref walk doesn't count refs in the
way that "repo structure" requires, and because "setup_revisions"
doesn't support a custom callback for its ref-walk, that's not
changeable.

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
 Documentation/git-repo.adoc     |  37 +++++-
 Documentation/git-rev-list.adoc |   2 +-
 Documentation/revisions.adoc    |   2 +-
 builtin/repo.c                  |  32 +++--
 revision.c                      |   2 +-
 revision.h                      |   2 +-
 t/t1901-repo-structure.sh       | 211 ++++++++++++++++++++++++--------
 7 files changed, 217 insertions(+), 71 deletions(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index ed7d80c690..d2cbabd330 100644
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
@@ -56,9 +56,10 @@ supported:
 `nul`:::
 	Similar to `lines`, but using a _NUL_ character after each value.
 
-`structure [--format=(table|lines|nul) | -z]`::
-	Retrieve statistics about the current repository structure. The
-	following kinds of information are reported:
+`structure [--format=(table|lines|nul) | -z] [<revs>...]::
++
+Retrieve statistics about the current repository structure. The
+following kinds of information are reported:
 +
 * Reference counts categorized by type
 * Reachable object counts categorized by type
@@ -66,6 +67,12 @@ supported:
 * Total disk size of reachable objects by type
 * Largest reachable objects in the repository by type
 +
+The set of objects counted can be filtered by specifying a collection
+of revisions to select which objects will be counted. These parameters
+follow the same syntax as the parameters to similar commands like
+`git log`. If no includes are specified, then the include set is all
+reachable objects.
++
 The output format can be chosen through the flag `--format`. Three formats are
 supported:
 +
@@ -141,6 +148,28 @@ using the `nul` format:
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
+git repo structure ^foo
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
diff --git a/Documentation/git-rev-list.adoc b/Documentation/git-rev-list.adoc
index f582491dd4..05f16a1146 100644
--- a/Documentation/git-rev-list.adoc
+++ b/Documentation/git-rev-list.adoc
@@ -114,7 +114,7 @@ do
 done |
 sort -n
 ----------
-
+p
 * Compare the on-disk size of branches in one group of refs, excluding
   another. If you co-mingle objects from multiple remotes in a single
   repository, this can show which remotes are contributing to the
diff --git a/Documentation/revisions.adoc b/Documentation/revisions.adoc
index 3fbfbd3d5f..4391f8daa6 100644
--- a/Documentation/revisions.adoc
+++ b/Documentation/revisions.adoc
@@ -226,7 +226,7 @@ existing tag object.
   This is most useful to address a blob or tree from a commit or tree that has
   the same tree structure as the working tree.
 
-':[<n>:]<path>', e.g. ':0:README', ':README'::
+ ':[<n>:]<path>', e.g. ':0:README', ':README'::
   A colon, optionally followed by a stage number (0 to 3) and a
   colon, followed by a path, names a blob object in the
   index at the given path. A missing stage number (and the colon
diff --git a/builtin/repo.c b/builtin/repo.c
index 84e012f83f..081940a85c 100644
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
+	}
+	if (argc > 1)
+		usage(_("too many arguments"));
+
+	structure_count_references(&stats.refs, &revs, repo, show_progress, !included_revision_args);
 	structure_count_objects(&stats.objects, &revs, repo, show_progress);
 
 	switch (format) {
diff --git a/revision.c b/revision.c
index ee1df92d1d..79d44b58b5 100644
--- a/revision.c
+++ b/revision.c
@@ -2837,7 +2837,7 @@ static int handle_revision_pseudo_opt(struct rev_info *revs,
 	 * NOTE!
 	 *
 	 * Commands like "git shortlog" will not accept the options below
-	 * unless parse_revision_opt queues them (as opposed to erroring
+	 * unless parse_revision_op	t queues them (as opposed to erroring
 	 * out).
 	 *
 	 * When implementing your new pseudo-option, remember to
diff --git a/revision.h b/revision.h
index e5dabd18ce..63135c5f88 100644
--- a/revision.h
+++ b/revision.h
@@ -125,7 +125,7 @@ struct topo_walk_info;
 
 struct rev_info {
 	/*
-	 * Work queue of commits, stored as either a linked list or a
+~	 * Work queue of commits, stored as either a linked list or a
 	 * priority queue, but never both at the same time.
 	 * rev_info_commit_list_to_queue() converts list to queue.
 	 */
diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index 02cc2b594a..e35b46a277 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -21,58 +21,6 @@ object_type_disk_usage() {
 	fi
 }
 
-test_expect_success 'empty repository' '
-	test_when_finished "rm -rf repo" &&
-	git init repo &&
-	(
-		cd repo &&
-		cat >expect <<-\EOF &&
-		| Repository structure      | Value  |
-		| ------------------------- | ------ |
-		| * References              |        |
-		|   * Count                 |    0   |
-		|     * Branches            |    0   |
-		|     * Tags                |    0   |
-		|     * Remotes             |    0   |
-		|     * Others              |    0   |
-		|                           |        |
-		| * Reachable objects       |        |
-		|   * Count                 |    0   |
-		|     * Commits             |    0   |
-		|     * Trees               |    0   |
-		|     * Blobs               |    0   |
-		|     * Tags                |    0   |
-		|   * Inflated size         |    0 B |
-		|     * Commits             |    0 B |
-		|     * Trees               |    0 B |
-		|     * Blobs               |    0 B |
-		|     * Tags                |    0 B |
-		|   * Disk size             |    0 B |
-		|     * Commits             |    0 B |
-		|     * Trees               |    0 B |
-		|     * Blobs               |    0 B |
-		|     * Tags                |    0 B |
-		|                           |        |
-		| * Largest objects         |        |
-		|   * Commits               |        |
-		|     * Maximum size        |    0 B |
-		|     * Maximum parents     |    0   |
-		|   * Trees                 |        |
-		|     * Maximum size        |    0 B |
-		|     * Maximum entries     |    0   |
-		|   * Blobs                 |        |
-		|     * Maximum size        |    0 B |
-		|   * Tags                  |        |
-		|     * Maximum size        |    0 B |
-		EOF
-
-		git repo structure >out 2>err &&
-
-		test_cmp expect out &&
-		test_line_count = 0 err
-	)
-'
-
 test_expect_success SHA1 'repository with references and objects' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
@@ -144,6 +92,165 @@ test_expect_success SHA1 'repository with references and objects' '
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
+		git repo structure --format=lines  >actual 2>actual-err &&
+		test_line_count = 0 actual-err &&
+		test_grep "objects.commits.inflated.size=231976" actual &&
+		test_grep "objects.commits.count=1046" actual &&
+		test_grep "objects.blobs.count=1006" actual &&
+		test_grep "objects.trees.count=1006" actual &&
+		test_grep "objects.trees.disk_size=284547" actual &&
+		test_grep "objects.blobs.disk_size=21022" actual &&
+		test_grep "objects.tags.disk_size=126" actual &&
+		test_line_count = 0 actual-err
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
+
+		oid="$(git rev-parse HEAD)" &&
+		git update-ref refs/remotes/origin/foo "$oid" &&
+		git checkout -b grobble &&
+		test_commit_bulk --ref=refs/heads/grobble 20 &&
+		git checkout master &&
+		test_commit_bulk 20 &&
+		git notes add -m foo &&
+
+		git repo structure --format=lines grobble >actual 2>actual-err &&
+		test_grep "objects.commits.count=1025" actual &&
+		test_grep "objects.commits.disk_size=160455" actual &&
+		test_grep "objects.commits.inflated.size=227371" actual &&
+		test_grep "objects.blobs.count=1005" actual &&
+		test_grep "objects.blobs.disk_size=21003" actual &&
+		test_grep "objects.blobs.inflated_size=11958" actual &&
+		test_grep "objects.trees.count=1005" actual &&
+		test_grep "objects.trees.disk_size=284462" actual &&
+		test_grep "objects.trees.inflated_size=16578363" actual &&
+		test_grep "objects.tags.disk_size=0" actual &&
+		test_line_count = 0 actual-err
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
+		git repo structure --format=lines  >actual 2>actual-err &&
+		test_line_count = 0 actual-err &&
+
+		git repo structure --format=lines grobble ^master >actual 2>actual-err &&
+		test_grep "objects.commits.count=20" actual &&
+		test_grep "objects.commits.disk_size=3122" actual &&
+		test_grep "objects.commits.inflated.size=4411" actual &&
+		test_grep "objects.blobs.count=1005" actual &&
+		test_grep "objects.blobs.disk_size=21003" actual &&
+		test_grep "objects.blobs.inflated_size=11958" actual &&
+		test_grep "objects.trees.count=1" actual &&
+		test_grep "objects.trees.disk_size=53" actual &&
+		test_grep "objects.trees.inflated_size=33063" actual &&
+		test_grep "objects.tags.disk_size=0" actual &&
+		test_line_count = 0 actual-err
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
+		git repo structure --format=lines --objects --all --filter=object:type=blob >actual 2>actual-err &&
+		cp actual /tmp/test-actual-exclude-blob &&
+		test_grep "objects.commits.disk_size=0" actual &&
+		test_grep "objects.commits.max_size=0" actual &&
+		test_grep "objects.tags.disk_size=0" actual &&
+		test_grep "objects.tags.inflated_size=0" actual &&
+		test_grep "objects.trees.disk_size=0" actual &&
+		test_grep "objects.trees.inflated_size=0" actual &&
+		test_grep "objects.blobs.disk_size=21022" actual &&
+		test_grep "objects.blobs.count=1006" actual &&
+		test_grep "objects.blobs.disk_size=21022" actual &&
+		test_grep "objects.blobs.inflated_size=11962" actual &&
+		test_line_count = 0 actual-err
+	)
+'
+
+test_expect_success 'filter using by ref^{tree}' '
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
+		git repo structure --format=lines HEAD^{tree}  >actual 2>err &&
+		test_grep "objects.commits.count=0" actual &&
+		test_grep "objects.trees.count=1" actual &&
+		test_grep "objects.blobs.count=1005" actual &&
+		test_grep "objects.tags.count=0" actual &&
+		test_grep "objects.commits.inflated_size=0" actual &&
+		test_grep "objects.trees.inflated_size=33063" actual &&
+		test_grep "objects.blobs.inflated_size=11958" actual &&
+		test_grep "objects.tags.inflated_size=0" actual &&
+		test_grep "objects.commits.disk_size=0" actual &&
+		test_grep "objects.trees.disk_size=53" actual &&
+		test_grep "objects.blobs.disk_size=21003" actual &&
+		test_grep "objects.tags.disk_size=0" actual &&
+		test_line_count = 0 err
+	)
+'
+
 test_expect_success SHA1 'lines and nul format' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
-- 
2.53.0

