Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4924D2EC5
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 17:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791222055; cv=none; b=NJZGoC1e3hhvPjODAcPb3W3MHiXvXMWOIzckU0VzG/b8ls1qI0mZ9DqFcMTwjJ+ov0Ts/u0jHKosfVlWCc/h4TwO4L4rOfet9kx0CFipe/T+K5FXGdlRkfXJ32N6NI/tJmALw92FiG05WyF7/Vh/D3QXjzWMK1XFRASf8mPr2cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791222055; c=relaxed/simple;
	bh=rLlAwLwJuLSSGLxC/dqLsreKbcpkky2UzBLfIqcCCQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r1+A+oiDLyOVZ+UF0RBz5zEPWjKgQHp6S7FGG7CJkyIZ2895okOrWU2D/K567ISAfq6ivdT5sVUswowU1cLU2zjz2ecJ2nH1ipMmAb/CQ7n/TJEUMkluXXBRHMR7j1RbTSyGPdUn94GLSx1QmZTy1mxbQg1yoaFnW1mqZMskdOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=J6KJDawf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cfCY9fvW; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="J6KJDawf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cfCY9fvW"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id 1B7B21300923
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 13:40:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 05 Oct 2026 13:40:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1791222052; x=
	1791225652; bh=G2enz2ibP3IiwJQRfYG/aF854JfP4F4uEw1+6Dex4so=; b=J
	6KJDawfntfRfXWQMWCRomuXUE0ELHQgcMQTOU2TRT9xoERv6HI54IoG0VeIF7Aej
	pN9GoiqdilSm98LmbdtXXQehaxQBSJyp1Xy2+UF/S2uBTXdJRH1bDQA0f6IUzzq8
	24Btag2pHyv0FrIIfXHyA1MkuBkbAkoEItGlF2iGjsXK2y9VX1lJsiXA5qaef3m5
	/FHkxs2Rqrw8vVioRNwvGFGZlzdEQj40XoP6eGbgAnZxeVWZPFnKZcGulz7sU5Ks
	1Aw3/BDWZxYtqiOhMZfdO0zSCbwvcNzyzszatZFU4Gx+SzTTmpKUqNDzCRNpvMxW
	qWKCwElbaWUPx466iMUEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1791222052; x=1791225652; bh=G
	2enz2ibP3IiwJQRfYG/aF854JfP4F4uEw1+6Dex4so=; b=cfCY9fvWsB0W+onc+
	vVsbmTMeruE/N2HEAvxeEjZQQRiPOmQ/DsKtwQ0K02E6wlTzUSpq37kNqH8SQP58
	vEfbNQ0uDGIkNkCF6exaX9O/2OimHmzrNN7GQwMjcJGS5v9eKoWaU8eEahfhY4nh
	FuQFWKR47IcC4CLjzhDxF+hLebIZ8er6w0WUs2yH6Ztcbp1p7c1uC5ZMdWGef8Ai
	SHy2aH+ozmDznqslqB+XLkovXBgzaHoGL6ZyNrOeLWHuzwGi5+7A0Cr817QJprSy
	0ZBgvL63uq2cLBLzJ+scipNe10IxayJ8R2oWa09enEYf4mI58ccLBcSD5dmQsXen
	V0+uw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791222052; d=fastmail.com;
	mf=PG1hcmtjaHVjYXJyb2xsQGZhc3RtYWlsLmNvbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:osaMs1lflcO8S8xxVRdV8SQWYbG0YFcFud0lj7B2XMUMmZG
	PH9ayQYoGvxoNcCY6nIUM34S9+dQ9sEZ3dWPqZiG/68fbGmMTFArd8vVAzpQTPpu
	cATY2uKOdZ1bkxcVel9U+BkP/RsFUVAN51ZLXbxhiH1TcEC1PV/T4JqZyZL6ZV/m
	l3YJ3bAuF7+cZvh7FChKeEvt5F1d5J+N4HZ8WGoSJpd89490odbqZYfIRivijSy0
	xSAiidIAuw8WVyV1Gcip5tPaaupefZcamQWSBSIQWjMcgvf+TQRqKHv+7XI9xodp
	beBcdDoRzmVNf0od6ty5xnymqu7H3xH4wwAN9Uw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Hxaowbr58N6qXbr35S+u9FyoaEwqIIinsC+MbrWexBc=:rLlAwLwJuLSSGLxC/dqLsreKbcpkky2UzBLfIqcCCQo=;
X-ME-Sender: <xms:JOHDalDs26-iUteolgz40g8MRoa5h_Oym1F7aOfiAMgPGXkEdDEQzQ>
    <xme:JOHDaqg-4hPwodPhg4h40HoOumrtR73BAxc7JEEwVSt_hKcPazb5J6Fcze6L7JPOo
    OyxvLNq2dsV51T0vSCfsLIEwY8KvcWJD03aLl6DvfTL_cZik8_sSg>
X-ME-Received: <xmr:JOHDalmraZzJvSuqkfrRre1PzGEUZo7sn9WeiSmI2aOFyYkGc5g17SKvJ9GqUq-UcHoL0kXuAYem9vRpqf4Ip2fVU5BpH-ELIr0gqn8VqbxNPkQtKT6qvYLazz7F03ad_vVwgsiSwRgZxe7Pp943>
X-ME-Proxy-Cause: dmFkZTFgT4h9e38redA35qat/9rSF0gSQgkcMwuFif5Hw7VNMOKdUVsaaCTz4YT6KWZSK3
    o7iWklL06JhQ4OKagh8dgeRV41kveiThJjXLoRK3ZIi1v3906Z07MsC9Uu6MgFMR92Gv/U
    SY1qHg89Bgqtxh1WoF1IQyReBikb2u47F9egBgEcqFmPghusoLFtUFT7YgGp5m0doMzo5D
    a6nakdGBFV30+fTp3sxERyhzQERXUyN8CNyCZYdcSTnepkQxq3N5/Tfm+3Bq5ziJtEwWD5
    ZtVLrnSRZTqkn11pnzGblTZDr3KD/GGuYcNqaBiPjpnrCa4rRFu5+EDraacCc8w1rXhGWY
    m2iAxXmyPlsJDPXyyXFc+1m4CfjSrWUVu552M0GlBu0w0P/In5vgkDadVZuO265+vc6c8I
    EcollkF4W/yiTPIglpsVaYO39oMmqzO15J+Amet+j0Y2oR2MXpZcqkINPQZ0gNalGu2d4b
    sU8NH1RbFmyucnFUCTvh335qEEotGFOL6CN7EGrtgepeHGOQn+wAg0FgLBm1Kyw2iIJfTl
    g5/vE4J2LH99iKzadJgks/EdpdKitm/D9VzBYxRO2UQmSWbAWvFk6hq+wtZhH/Wgxeyzkx
    PdDm92285SWM318gvt0CF5fYdvpRbIlrr6cZZhK7EyTOWMQKPr1rqhTZ7K1w
X-ME-Proxy: <xmx:JOHDaur4G4bvHInzyHB39NVUPL9wqDvS-InuFuJG1PbXzLQS5PP2_Q>
    <xmx:JOHDamFthEwYNaKC90WyJfYfPtqVKG6UWnnTaeK17ISDiek6c6vXVA>
    <xmx:JOHDaiwGqtCootNRu16a_MAXNfZTsjTUDbXj9ecVWKhh_GCWDhsoEg>
    <xmx:JOHDajo8a_qcaZN_I4jlci31j4Png9QYK38-T8Ah2WckaCcxPq2i3A>
    <xmx:JOHDag5vkVK5eDOeZdqNsdJny1KDbBRabX1LcIyC0FjqIPRAm-cHO_2V>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Oct 2026 13:40:52 -0400 (EDT)
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com,
	ps@pks.im,
	"Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Subject: [PATCH v2 1/1] repo: add filtering options to "repo structure"
Date: Mon,  5 Oct 2026 13:40:44 -0400
Message-ID: <20261005174045.1900391-2-markchucarroll@fastmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005174045.1900391-1-markchucarroll@fastmail.com>
References: <20260924164503.119506-2-markchucarroll@fastmail.com>
 <20261005174045.1900391-1-markchucarroll@fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement filtering for repo structure, imitating the mechanism
used in "git log".

Signed-off-by: Mark C. Chu-Carroll <markchucarroll@fastmail.com>
---
 Documentation/git-repo.adoc | 41 ++++++++++++++++--
 builtin/repo.c              | 16 +++++--
 t/t1901-repo-structure.sh   | 84 +++++++++++++++++++++++++++++++++++++
 3 files changed, 133 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index ed7d80c690..5cbdf8e727 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -10,7 +10,7 @@ SYNOPSIS
 [synopsis]
 git repo info [--format=(lines|nul) | -z] [--all | <key>...]
 git repo info --keys [--format=(lines|nul) | -z]
-git repo structure [--format=(table|lines|nul) | -z]
+git repo structure [--format=(table|lines|nul) | -z] [<include|^exclude>...]
 
 DESCRIPTION
 -----------
@@ -56,9 +56,10 @@ supported:
 `nul`:::
 	Similar to `lines`, but using a _NUL_ character after each value.
 
-`structure [--format=(table|lines|nul) | -z]`::
-	Retrieve statistics about the current repository structure. The
-	following kinds of information are reported:
+`structure [--format=(table|lines|nul) | -z] [<include|^exclude>...]::
++
+Retrieve statistics about the current repository structure. The
+following kinds of information are reported:
 +
 * Reference counts categorized by type
 * Reachable object counts categorized by type
@@ -66,6 +67,16 @@ supported:
 * Total disk size of reachable objects by type
 * Largest reachable objects in the repository by type
 +
+The set of objects counted can be filtered by specifying a
+collection of query clauses to select which objects will be
+counted. These parameters follow the same syntax as the parameters
+to similar commands like `git log`. Semantically, these parameters
+are treated as a collection of include and exclude specifiers. Th
+set of objects counted will consist of all objects reachable from
+an object included by one of the include specifiers via a path that
+does not include an object in an exclude clause. If no includes
+are specified, then the include set is all reachable objects. 
++
 The output format can be chosen through the flag `--format`. Three formats are
 supported:
 +
@@ -141,6 +152,28 @@ using the `nul` format:
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
diff --git a/builtin/repo.c b/builtin/repo.c
index 84e012f83f..b3aca71298 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -27,7 +27,7 @@
 	"git repo info --keys [--format=(lines|nul) | -z]"
 
 #define REPO_STRUCTURE_USAGE \
-	"git repo structure [--format=(table|lines|nul) | -z]"
+	"git repo structure [--format=(table|lines|nul) | -z] [<include|^exclude>...]"
 
 static const char *const repo_usage[] = {
 	REPO_INFO_USAGE,
@@ -946,12 +946,20 @@ static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
 		OPT_BOOL(0, "progress", &show_progress, N_("show progress")),
 		OPT_END()
 	};
+	struct setup_revision_opt s_r_opt;
+	memset(&s_r_opt, 0, sizeof(s_r_opt));
+	s_r_opt.def = "HEAD";
+	s_r_opt.revarg_opt = REVARG_COMMITTISH;
 
-	argc = parse_options(argc, argv, prefix, options, repo_structure_usage, 0);
-	if (argc)
-		usage(_("too many arguments"));
+	argc = parse_options(argc, argv, prefix, options, repo_structure_usage,
+			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN_OPT);
 
 	repo_init_revisions(repo, &revs, prefix);
+	if (argc > 1) {
+		argc = setup_revisions(argc, argv, &revs, &s_r_opt);
+		if (argc > 1)
+			usage(_("too many arguments"));
+	}
 
 	if (show_progress < 0)
 		show_progress = isatty(2);
diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index 02cc2b594a..eb2c595955 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -144,6 +144,90 @@ test_expect_success SHA1 'repository with references and objects' '
 	)
 '
 
+test_expect_success SHA1 'repository with references and objects, filtered' '
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
+ 		test_commit_bulk 20 &&
+		# Also creates a commit, tree, and blob.
+		git notes add -m foo &&
+
+		# git-rev-list(1) --disk-usage=human option printing the full
+		# "byte/bytes" unit string instead of just "B".
+		cat >expect <<-EOF &&
+		| Repository structure      | Value      |
+		| ------------------------- | ---------- |
+		| * References              |            |
+		|   * Count                 |      5     |
+		|     * Branches            |      2     |
+		|     * Tags                |      1     |
+		|     * Remotes             |      1     |
+		|     * Others              |      1     |
+		|                           |            |
+		| * Reachable objects       |            |
+		|   * Count                 |   3.06 k   |
+		|     * Commits             |   1.05 k   |
+		|     * Trees               |   1.01 k   |
+		|     * Blobs               |   1.01 k   |
+		|     * Tags                |      1     |
+		|   * Inflated size         |  16.04 MiB |
+		|     * Commits             | 226.54 KiB |
+		|     * Trees               |  15.81 MiB |
+		|     * Blobs               |  11.68 KiB |
+		|     * Tags                |    132 B   |
+		|   * Disk size             | $(object_type_disk_usage all true) |
+		|     * Commits             | $(object_type_disk_usage commit true) |
+		|     * Trees               | $(object_type_disk_usage tree true) |
+		|     * Blobs               |  $(object_type_disk_usage blob true) |
+		|     * Tags                |    $(object_type_disk_usage tag) B   |
+		|                           |            |
+		| * Largest objects         |            |
+		|   * Commits               |            |
+		|     * Maximum size    [1] |    223 B   |
+		|     * Maximum parents [2] |      1     |
+		|   * Trees                 |            |
+		|     * Maximum size    [3] |  32.29 KiB |
+		|     * Maximum entries [4] |   1.01 k   |
+		|   * Blobs                 |            |
+		|     * Maximum size    [5] |     13 B   |
+		|   * Tags                  |            |
+		|     * Maximum size    [6] |    132 B   |
+
+		[1] 0dc91eb18580102a3a216c8bfecedeba2b9f9b9a
+		[2] df6400c01440c329f1011669c4c26cc0c7852887
+		[3] 60665251ab71dbd8c18d9bf2174f4ee0d58aa06c
+		[4] 60665251ab71dbd8c18d9bf2174f4ee0d58aa06c
+		[5] 97d808e45116bf02103490294d3d46dad7a2ac62
+		[6] 4dae4f5954f5e6feb3577cfb1b181daa3fd3afd2
+		EOF
+
+		git repo structure  >actual 2>actual-err &&
+		cp actual /tmp/actual &&
+		cp expect /tmp/expect &&
+		test_cmp expect actual &&
+		test_line_count = 0 actual-err &&
+
+		git repo structure grobble ^master >actual 2>actual-err &&
+		cp actual /tmp &&
+		cp actual-err /tmp &&
+		test_grep "|     \* Commits             |    21     |" actual &&
+		test_grep "|     \* Trees               |     2     |" actual &&
+		test_grep "|     \* Commits             |  4.50 KiB |" actual &&
+		test_grep "|     \* Trees               | 32.35 KiB |" actual &&
+		test_grep "|     \* Blobs               | 11.68 KiB |" actual &&
+		test_line_count = 0 actual-err
+	)
+'
+
 test_expect_success SHA1 'lines and nul format' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
-- 
2.53.0

