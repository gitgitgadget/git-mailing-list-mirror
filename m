Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EA93314D1
	for <git@vger.kernel.org>; Mon, 16 Feb 2026 15:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771256302; cv=none; b=L8Nqj+VdmulcNuE6d7Ewp5+UYc029OaRwsxMdsIK/XlbfuAYPmvEVvhFl4K8UEP6+nalheqEGZYxHUMB8tfXim6JawiA0Yz6XW7s+o8mMAvq2uzgdkHrfz+L3h8lsBj4D0+WITZgCXyPikGrBAbr/v9SGDjHqx05i5SU4ArmXLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771256302; c=relaxed/simple;
	bh=ft5GAuo+effEeqQd1dIKDOArZakjnzDfZCJu8DbPsso=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RHzC+ZZNb8gQpXxXNfDhM+4yy0LeTvqzQ/VnRLJFI00ViPwB2k29p3hyCq3nMojVJOIGPTvjTll4MgVluYzwGOj76SbFaXd+Vo5BlMN0Zz0B4F4hb5lTHrywgmG5AaSx1lmqbOddJt8uetUvhEPMhfU/fTqVlPyStRZ5Jp3pU5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FyrhNg7v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JAtXacQG; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FyrhNg7v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JAtXacQG"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 47567140018E;
	Mon, 16 Feb 2026 10:38:20 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 16 Feb 2026 10:38:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771256300;
	 x=1771342700; bh=stqa5PQbIe0l4cUUx1rBQcNldRUcJBbWAEXdsEsqTbs=; b=
	FyrhNg7vX8VtNstyur9o66BUqp9se8HQF3kf9Z5aS8dVuf7g3lM4HXUR/qJfy0xq
	3welauQq7T0fz5jA8IUzGil7+LIgJ4xr5f7GxlRE0v8PSgdBvbzmKBbM9hifIkEv
	WoMijg/CvEnBr1WPLEqO0EY9bWQgP2lkIzsm0APQDCd0PwVP1p5qGUVZ3vNS7H9W
	2zk9hbdfzIFf4k6H4dIWdYOmPHNbu+shF7r3hmS5zAfrSatIjGtB4HCG/pCSNUgC
	1xpiOge0wFulbESgx9zFGMj9bZ6UM6dzJxXcO+s4cagKoLDYS/lCGmTyyC2rSnjC
	Y9RizfNiJOXPc2yPGnb1jQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771256300; x=
	1771342700; bh=stqa5PQbIe0l4cUUx1rBQcNldRUcJBbWAEXdsEsqTbs=; b=J
	AtXacQG3uds94wxwIoWO3DLNJgLRgu9CoishVSz/pT7sEHFT6pl5q0whfV0VAYrd
	8lmOta6XiV2/kZWVHeeNE5meXECkkxn9HTb3ubSRGRmBHlIRSNBuOlKySMLvGjS7
	pDCVCrI5l5fsPq23T+XGMifrbi1r1B/EoVP6nwNTV+/UuKY1hJ3MigqKIJjnj/UW
	+Ni8T9QKP4KZ2cS6J4h0edxo0MLO4tWtld8ooalhsxqvz9xFjs9LNBKyFkZsD6DY
	2TokAWUk+buuKbaw/Ybidf5zKAuMhjKED7npzzT8Ph1AJI7r6EcruLhHLLFU5wGZ
	m86LCo4/kjd3dRdaNbEkA==
X-ME-Sender: <xms:7DmTacY_OOLkF3b_10_kZIbfhbF2ZDGw7LZ-UqRYrJ4Te_kHh7m_Lw>
    <xme:7DmTadaqWjJ-a-ylWjFBQhI3TTZ6DIWPif2PsW49-jRtMjoGiR9TulGH-VOdZ_vI_
    mNhq_wiDtQd56Epc8Njv9SA-JxfCyRFas2H2VTiiir8zm-dc6K5KQ>
X-ME-Received: <xmr:7DmTaUn3pyvW_lWSHI_mDO7ImbkpVzPLGO6F9SwzHgyFlUtqRKHfogRs3RFiIK1FPrHMoJNpdDTY7aLTEhPFB7fR2nAjXxSYK0TFdMsgGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudejvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhsmhhilh
    gvhiesghhithhlrggsrdgtohhm
X-ME-Proxy: <xmx:7DmTaRwp1utS6wrKrQTE7kXrtSXM-8fn7ktQhI8n4QuVhF35puj1rw>
    <xmx:7DmTaaMmtepgM-xsvvD2ikAxhCDZrQ0JJl3kk2RKVyZ0_5gnZ6B3MA>
    <xmx:7DmTadTQs0UKAw1qN4-6PgpK0Tc2Q6ILTEWst4orWX4bJMV748dQEg>
    <xmx:7DmTaQYVM3JjRxladH2vmjJSXWBuVkY-HXt73fuMeN4SZpC7jc2MdA>
    <xmx:7DmTaSJH78eSpnbh1-1aNqiypzQMpIy7kAven4fJBOTKnwu9JR-U3Jg2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Feb 2026 10:38:19 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8d3f3ee9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Feb 2026 15:38:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 16 Feb 2026 16:38:02 +0100
Subject: [PATCH 2/3] commit: make `repo_parse_commit_no_graph()` more
 robust
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-b4-pks-receive-pack-optimize-shallow-v1-2-e98886daff2b@pks.im>
References: <20260216-b4-pks-receive-pack-optimize-shallow-v1-0-e98886daff2b@pks.im>
In-Reply-To: <20260216-b4-pks-receive-pack-optimize-shallow-v1-0-e98886daff2b@pks.im>
To: git@vger.kernel.org
Cc: Matt Smiley <msmiley@gitlab.com>
X-Mailer: b4 0.14.3

In the next commit we will start to parse more commits via the
commit-graph. This change will lead to a segfault though because we try
to access the tree of a commit via `repo_get_commit_tree()`, but:

  - The commit has been parsed via the commit-graph, and thus its
    `maybe_tree` field is not yet populated.

  - We cannot use the commit-graph to populate the commit's tree because
    we're in the process of writing the commit-graph.

The consequence is that we'll get a `NULL` pointer for the tree in
`write_graph_chunk_data()`.

In theory we are already mindful of this situation, as we explicitly use
`repo_parse_commit_no_graph()` to parse the commit without the help of
the commit-graph. But that doesn't do the trick as the commit is already
marked as parsed, so the function will not re-populate it. And as the
commit-graph has been closed, neither will `get_commit_tree_oid()` be
able to load the tree for us.

It seems like this issue can only be hit under artificial circumstances:
the error was hit via `git_test_write_commit_graph_or_die()`, which is
run by git-commit(1) and git-merge(1) in case `GIT_TEST_COMMIT_GRAPH=1`:

  $ GIT_TEST_COMMIT_GRAPH=1 meson test t7507-commit-verbose \
      --test-args=-ix -i
  ...
  ++ git -c commit.verbose=true commit --amend
  hint: Waiting for your editor to close the file...
  ./test-lib.sh: line 1012: 55895 Segmentation fault         (core dumped) git -c commit.verbose=true commit --amend

To the best of my knowledge, this is the only case where we end up
writing a commit-graph in the same process that might have already
consulted the commit-graph to look up arbitrary objects. But regardless
of that, this feels like a bigger accident that is just waiting to
happen.

Make the code more robust by extending `repo_parse_commit_no_graph()` to
unparse a commit first in case we detect it's coming from a graph. This
ensures that we will re-read the object without it, and thus we will
populate `maybe_tree` properly.

This fix shouldn't have any performance consequences: the function is
only ever called in the "commit-graph.c" code, and we'll only re-parse
the commit at most once.

Add an exclusion to our Coccinelle rules so that it doesn't complain
about us accessing `maybe_tree` directly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 commit.h                        | 14 ++++++++++++--
 contrib/coccinelle/commit.cocci |  2 +-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/commit.h b/commit.h
index 1635de418b..f2f39e1a89 100644
--- a/commit.h
+++ b/commit.h
@@ -103,16 +103,26 @@ static inline int repo_parse_commit(struct repository *r, struct commit *item)
 	return repo_parse_commit_gently(r, item, 0);
 }
 
+void unparse_commit(struct repository *r, const struct object_id *oid);
+
 static inline int repo_parse_commit_no_graph(struct repository *r,
 					     struct commit *commit)
 {
+	/*
+	 * When the commit has been parsed but its tree wasn't populated then
+	 * this is an indicator that it has been parsed via the commit-graph.
+	 * We cannot read the tree via the commit-graph, as we're explicitly
+	 * told not to use it. We thus have to first un-parse the object so
+	 * that we can re-parse it without the graph.
+	 */
+	if (commit->object.parsed && !commit->maybe_tree)
+		unparse_commit(r, &commit->object.oid);
+
 	return repo_parse_commit_internal(r, commit, 0, 0);
 }
 
 void parse_commit_or_die(struct commit *item);
 
-void unparse_commit(struct repository *r, const struct object_id *oid);
-
 struct buffer_slab;
 struct buffer_slab *allocate_commit_buffer_slab(void);
 void free_commit_buffer_slab(struct buffer_slab *bs);
diff --git a/contrib/coccinelle/commit.cocci b/contrib/coccinelle/commit.cocci
index c5284604c5..42725161e9 100644
--- a/contrib/coccinelle/commit.cocci
+++ b/contrib/coccinelle/commit.cocci
@@ -26,7 +26,7 @@ expression s;
 // repo_get_commit_tree() on the LHS.
 @@
 identifier f != { repo_get_commit_tree, get_commit_tree_in_graph_one,
-		  load_tree_for_commit, set_commit_tree };
+		  load_tree_for_commit, set_commit_tree, repo_parse_commit_no_graph };
 expression c;
 @@
   f(...) {<...

-- 
2.53.0.352.gd1286b26eb.dirty

