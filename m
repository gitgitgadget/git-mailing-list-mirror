Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE083101BC
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 08:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764922829; cv=none; b=M5D8/qVNn1Eoj+rpHOj4vYCAyhxx2ZoDOrOcsTOB1VywIgDSSjPdWYI27anaAKfMNsOVMOJ5c/xSP0Ylr+uipjTmd2OZU6fnSjwzcf4a+MNMslxZnYjio5H2LZYVNDZLy38zi6eZ+iy/hsrpmxr6pqWr7TukmI+kz+F4kpEoiKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764922829; c=relaxed/simple;
	bh=+sJb6T0qHRr58+brqkh90pfL/vHBRW0bLujR4ZVNGoo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H/fEPlyt++WtgbU9l1iRRoCD4EIqeoqmZkz/sGeKpFG0jHZhAstie2S15ol3mjSbiMLTNOxTzsM/fHG+KiMnX9SGuCX2Du30Cvsf4ihItiu3IZefIq2RK9a+F+0dE/hn9RHRiXwvVbj0x3Rrv7bqZ5s9M+HOnrGAceABDktOSLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kf5q2YW7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DE+KgNbU; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kf5q2YW7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DE+KgNbU"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 40F5B7A029B
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 03:20:17 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 05 Dec 2025 03:20:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1764922817;
	 x=1765009217; bh=Ex8sVgmD9RsJQL9PKV777qWSquS2f5dBmEUvHEmsdi4=; b=
	kf5q2YW72ADuhjeVT4GRIcN2hHFuEZN6nGBlsGff2C1+uLvbw6fMdAuL+FLq/XSX
	SoQNCpDcj3VQOyAX1hKZJJ+cCkNJmSJTOIkTQKxyBnEXc3af2/SjYSFN6mVhJfVu
	ufTsSpT79RIcVsrcyaxZLsh9smYyeyS8dJjYJDFHGH+mfQicJaf2QWZwhiQCLdXp
	KcUGPy5w+yEvSIr2eDoZ0NttzR77CiRqFvwa2peGgaoZb1xE3QdhhAyh6xOpwbT0
	shn8s8oVT3YvhcrigrJpGp9xkx/UEYXbd+fE3SbCH5q2PmZEUIZap4jPotNDcIjA
	ZNdLJxvDD+tJn7pvpYXKgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764922817; x=
	1765009217; bh=Ex8sVgmD9RsJQL9PKV777qWSquS2f5dBmEUvHEmsdi4=; b=D
	E+KgNbUy7HO3SKdGqqJ9RfVCizNZ+i1sZ3X7n4DwVKNCLGm8w2DeTVYrKs5gqdKY
	EKjs0t5awmNq+bHSaZI4MOwaqLDNkIxy8//ETusrly4D6gi75oIF+8tCWxY34+3y
	jYPOJrqDXjbrTyB6ciu75OdpqYkNxmjyb72wVa1BnhyWQMaiCDIAlTAusBiDhQ2K
	WQ4l0c+e0iSNz4hzkkMxL5A5HvpJmRzflFhsaxQIkscFSS4l7XXK6J6iKB0d1z6L
	DdpGg5OZS15ape64ZiAyWvaN9CNYMewKLuJczH7FbXUk7DMU42FlzgVXnSuKRCvd
	ItUXX9ZJT4B/kFP5ezjOA==
X-ME-Sender: <xms:wZUyaYZoC0HGsDoktVlJzoXd_PSOz-_VvpCoCSw33oUzxnG_73kD4w>
    <xme:wZUyaaX56yfYTiL2V8EMonnERhB9fROpxoXsyMFlR-rZgp5IXSfWu9n_aZlbx5_7W
    qPf4CRr-ws6tXeoltdtZrY6dGk4CY8O9NeoTcvbByR8p6GWJkxsoA>
X-ME-Received: <xmr:wZUyaYn0AbiNFoSNGjtMQCHANRzLD3jb0wBCKQK1cUrwnUPmWrntB0EMoOeUGxj0xRQt4wz9o854lfbh1nnjhmILxU_uXEeA1pTiKTctIaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucgovfgvgihtqfhnlhihqddqteefjeefqddtgeculdehtddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeelkeefvdfhieeffffhhedthfefhfffheefvdffudehheetffehgeffgfelleef
    udenucffohhmrghinheptghomhhmihhtqdhgrhgrphhhrdgruhhtohenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhn
    sggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:wZUyaXy1Sb8kzUBfm4HX_LPZex5CwYxDEPVyWaz5ZntLd2frswxR7w>
    <xmx:wZUyaTij5CKHmPc2aMsd14AiYiS3bK1y3hUvWAaDB_Pega1juoLGmw>
    <xmx:wZUyacW7SA8uBjS1wiTSVbK7MayJ1JrE2Vuo5AV5eaRyxYbE72b7iw>
    <xmx:wZUyaV36RdkhIeicpcYsp0K0zQb9Tsk14F-GUlu0-IjvRSq6GCgraA>
    <xmx:wZUyae5bRkOlw82eJgX4ObzK120rfu-fSSoYWynnRMO-JtN13NglSu2b>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 5 Dec 2025 03:20:16 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e85ac40b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 5 Dec 2025 08:20:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 05 Dec 2025 09:19:59 +0100
Subject: [PATCH 2/3] builtin/gc: fix condition for whether to write commit
 graphs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251205-odb-related-fixes-v1-2-ef4250abb584@pks.im>
References: <20251205-odb-related-fixes-v1-0-ef4250abb584@pks.im>
In-Reply-To: <20251205-odb-related-fixes-v1-0-ef4250abb584@pks.im>
To: git@vger.kernel.org
Cc: 
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
 t/t7900-maintenance.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 3 deletions(-)

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
index 6b36f52df7..6f3117304f 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -206,6 +206,32 @@ test_expect_success 'commit-graph auto condition' '
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
+		git branch -D feature &&
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
2.52.0.239.gd5f0c6e74e.dirty

