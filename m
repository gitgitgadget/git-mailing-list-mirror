Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAD71FECBA
	for <git@vger.kernel.org>; Thu, 11 Dec 2025 07:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765437611; cv=none; b=PIwoMT7lNilOjbx2rO3FQSVNiWIGkb7FqgGP6yPUZWIigRVSdk9MSLwAATuU/VL/Hbu71ao3E81fp1kfplFhdx8hg8o/H3911to7X8+AufO44g+47mOPyuA3EDzpDjJlXak2n6LHjFD8jxphBCI+s/VBVs99jUwWW/V+hLHYOW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765437611; c=relaxed/simple;
	bh=y00rSd6Z/qhkN5VsEqAeVi1jReMfJwYcQKZ1EllrgSw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nJV1XH3gZhwfvsEOTUOwyt6sszn/IvjH67MjsWPXno2/mAieLY5pTbWhlMv+H6TUp1k5/9fzW1DQRkqbqTG8S8L7YfInXAPSqPr4/hn6NxV0uadFnDtOJwNA/1jmSlg0hRElP7m+bQ6ntcLUfYSa/zxg0gXT4j8XzuWu29V3Gek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IIW78hBB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j0lNOdDd; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IIW78hBB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j0lNOdDd"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 802547A0166;
	Thu, 11 Dec 2025 02:20:08 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 11 Dec 2025 02:20:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765437608;
	 x=1765524008; bh=DrbjabXNqom2ce9J5WAh6y47FBIDVEX+NQghrnSktdU=; b=
	IIW78hBBoc5v1KKl7QFLc21qeIp9Wi0eQk9ROSiEqkElh2FU/WO2+IfMT0LbasFu
	Z+jxhkXZwHUtm6jZGUiqkjhiL1oDfHSDIRVvOe7LdIoEG9tQCJMquVTlNiT0BtFl
	37N4h5jiRxCd6gSXqCKrByxZghvkJyfi9vmiCWv4fPgUCwtF+KgWz1TpRKk6CfU7
	S2uLvjac362S+s6BegS4w/8Db74/XUFIphUuSDj/9gq122kLDJUX1QYR08o2Ohqi
	DL8XZ+MZIDsxY1mOgJ/s9BvZ6APutS6wCW5m8pgOZ3sw68+ZHsYjg3+4Ws4YhG/A
	Wh4wPq0jyxwXI8D7JGCC4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765437608; x=
	1765524008; bh=DrbjabXNqom2ce9J5WAh6y47FBIDVEX+NQghrnSktdU=; b=j
	0lNOdDd+7tPBii/I19xzRZI73TJTBk7CM/rtrsCLVL6tJO/wMm6TBK5UOgmL4+Xk
	tZ8mSaZrVrtwpTwk3ASwOx0twmRSM0LrzMR8r/ahivESV8gmr5PbECuVIHafRbFs
	8LJmUNCF36gskcNraVCMt2//2Y8QwA9Q9xyQK/uPwqZRgL8IokUhCIK21pEfr/GF
	kDX6xt/oaAWlYT2IcxTTUpkzFE4psSgilOOwMN8gJFOuKDiU6PaMHa+NDmU9H5wf
	z0qnWf0+eVxHbV05Lz/eICyspvhU4wVaxoXTKvwF1PNfiLAuEo0aYeqc1o/hgDv1
	jVWequwAFB4iOimr7Hnnw==
X-ME-Sender: <xms:qHA6afFS9W1Y4LcXZC-nC_TNtgK5W-EhSlJe6YyNHZNDK8T5vefp-Q>
    <xme:qHA6aTzO9l_OyTyl4IajQ_qhXAaf0njbrpLQEmkvJSfErCLrQ489lpw9cR61bR1fq
    tVU92_ElWAwV-t7uWaHDF4LzhRAGxJxI1Q3VPvVDF55CUTTl2-dbg>
X-ME-Received: <xmr:qHA6aei_LfVpLKXymtgyp9Zx70joJth8xcSYiKjRoWnLh07SYUSlEryThARnmVwm6cyQOiTWkZUDQSjL-biGdWw18XamcjW288J-B8bd0ztf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epleekfedvhfeifeffhfehtdfhfefhffehfedvffduheehteffheegfffgleelfedunecu
    ffhomhgrihhnpegtohhmmhhithdqghhrrghphhdrrghuthhonecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdr
    tghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhm
X-ME-Proxy: <xmx:qHA6aWypj4EKWLmOJmPYRdWFEwnTZ7e-8areSV76uWmK8Pon_nXpSg>
    <xmx:qHA6aZKmU345suNXN-gGDUAyqc3thYL57vQhL9_tWJBcaoxKE-6vzQ>
    <xmx:qHA6aVSZbiZ_sXELI2_JTvDBudHM9wkYsxlf47PouL7bSgyVC2h3TA>
    <xmx:qHA6aZrKG1qFNTxOobIKwTxAD7IFd1vU-8e0V-v4IrACwFqSy_tiwA>
    <xmx:qHA6aXwbopGfyOz2SXh8DrJYS7pV_jpVJMXn1ELpDsW8q8BMko4650Ws>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Dec 2025 02:20:07 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 596d7930 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Dec 2025 07:20:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 11 Dec 2025 08:19:58 +0100
Subject: [PATCH v2 1/2] builtin/gc: fix condition for whether to write
 commit graphs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251211-odb-related-fixes-v2-1-bdf875ce51fc@pks.im>
References: <20251211-odb-related-fixes-v2-0-bdf875ce51fc@pks.im>
In-Reply-To: <20251211-odb-related-fixes-v2-0-bdf875ce51fc@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, 
 Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: b4 0.14.3

When performing auto-maintenance we check whether commit graphs need to
be generated by counting the number of commits that are reachable by any
reference, but not covered by a commit graph. This search is performed
by iterating through all references and then doing a depth-first search
until we have found enough commits that are not present in the commit
graph.

This logic has a memory leak though:

  Direct leak of 16 byte(s) in 1 object(s) allocated from:
      #0 0x55555562e433 in malloc (git+0xda433)
      #1 0x555555964322 in do_xmalloc ../wrapper.c:55:8
      #2 0x5555559642e6 in xmalloc ../wrapper.c:76:9
      #3 0x55555579bf29 in commit_list_append ../commit.c:1872:35
      #4 0x55555569f160 in dfs_on_ref ../builtin/gc.c:1165:4
      #5 0x5555558c33fd in do_for_each_ref_iterator ../refs/iterator.c:431:12
      #6 0x5555558af520 in do_for_each_ref ../refs.c:1828:9
      #7 0x5555558ac317 in refs_for_each_ref ../refs.c:1833:9
      #8 0x55555569e207 in should_write_commit_graph ../builtin/gc.c:1188:11
      #9 0x55555569c915 in maintenance_is_needed ../builtin/gc.c:3492:8
      #10 0x55555569b76a in cmd_maintenance ../builtin/gc.c:3542:9
      #11 0x55555575166a in run_builtin ../git.c:506:11
      #12 0x5555557502f0 in handle_builtin ../git.c:779:9
      #13 0x555555751127 in run_argv ../git.c:862:4
      #14 0x55555575007b in cmd_main ../git.c:984:19
      #15 0x5555557523aa in main ../common-main.c:9:11
      #16 0x7ffff7a2a4d7 in __libc_start_call_main (/nix/store/xx7cm72qy2c0643cm1ipngd87aqwkcdp-glibc-2.40-66/lib/libc.so.6+0x2a4d7) (BuildId: cddea92d6cba8333be952b5a02fd47d61054c5ab)
      #17 0x7ffff7a2a59a in __libc_start_main@GLIBC_2.2.5 (/nix/store/xx7cm72qy2c0643cm1ipngd87aqwkcdp-glibc-2.40-66/lib/libc.so.6+0x2a59a) (BuildId: cddea92d6cba8333be952b5a02fd47d61054c5ab)
      #18 0x5555555f0934 in _start (git+0x9c934)

The root cause of this memory leak is our use of `commit_list_append()`.
This function expects as parameters the item to append and the _tail_ of
the list to append. This tail will then be overwritten with the new tail
of the list so that it can be used in subsequent calls. But we call it
with `commit_list_append(parent->item, &stack)`, so we end up losing
everything but the new item.

This issue only surfaces when counting merge commits. Next to being a
memory leak, it also shows that we're in fact miscounting as we only
respect children of the last parent. All previous parents are discarded,
so their children will be disregarded unless they are hit via another
reference.

While crafting a test case for the issue I was puzzled that I couldn't
establish the proper border at which the auto-condition would be
fulfilled. As it turns out, there's another bug: if an object is at the
tip of any reference we don't mark it as seen. Consequently, if it is
reachable via any other reference, we'd count that object twice.

Fix both of these bugs so that we properly count objects without leaking
any memory.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c           |  8 +++++---
 t/t7900-maintenance.sh | 25 +++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 92c6e7b954..17ff68cbd9 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1130,8 +1130,10 @@ static int dfs_on_ref(const struct reference *ref, void *cb_data)
 		return 0;
 
 	commit = lookup_commit(the_repository, maybe_peeled);
-	if (!commit)
+	if (!commit || commit->object.flags & SEEN)
 		return 0;
+	commit->object.flags |= SEEN;
+
 	if (repo_parse_commit(the_repository, commit) ||
 	    commit_graph_position(commit) != COMMIT_NOT_FROM_GRAPH)
 		return 0;
@@ -1141,7 +1143,7 @@ static int dfs_on_ref(const struct reference *ref, void *cb_data)
 	if (data->num_not_in_graph >= data->limit)
 		return 1;
 
-	commit_list_append(commit, &stack);
+	commit_list_insert(commit, &stack);
 
 	while (!result && stack) {
 		struct commit_list *parent;
@@ -1162,7 +1164,7 @@ static int dfs_on_ref(const struct reference *ref, void *cb_data)
 				break;
 			}
 
-			commit_list_append(parent->item, &stack);
+			commit_list_insert(parent->item, &stack);
 		}
 	}
 
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 6b36f52df7..a2b4403595 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -206,6 +206,31 @@ test_expect_success 'commit-graph auto condition' '
 	test_subcommand $COMMIT_GRAPH_WRITE <cg-two-satisfied.txt
 '
 
+test_expect_success 'commit-graph auto condition with merges' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		git config set maintenance.auto false &&
+		git commit --allow-empty -m initial &&
+		git switch --create feature &&
+		git commit --allow-empty -m feature-1 &&
+		git commit --allow-empty -m feature-2 &&
+		git switch - &&
+		git commit --allow-empty -m main-1 &&
+		git commit --allow-empty -m main-2 &&
+		git merge feature &&
+
+		# We have 6 commit, none of which are covered by a commit
+		# graph. So this must be the boundary at which we start to
+		# perform maintenance.
+		test_must_fail git -c maintenance.commit-graph.auto=7 \
+			maintenance is-needed --auto --task=commit-graph &&
+		git -c maintenance.commit-graph.auto=6 \
+			maintenance is-needed --auto --task=commit-graph
+	)
+'
+
 test_expect_success 'run --task=bogus' '
 	test_must_fail git maintenance run --task=bogus 2>err &&
 	test_grep "is not a valid task" err

-- 
2.52.0.270.g3f4935d65f.dirty

