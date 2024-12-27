Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7191F12F8
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 10:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735296443; cv=none; b=Vjvhj4FCYL1YBHceWVsNnSA936JRuvVEArUZ9iuq46T0/Uzk+bDynuyjZggmbCgxRznEfrs4cKMzgL5tYDOtF/OQjZ/Wpt8Rr4oByHTBqXM6hUiN32Y7Qu2a43DLbUYZuR0pbUkoOHuvEEnFCxs4BMEFz/wJ2jP3DzpQjUdGw4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735296443; c=relaxed/simple;
	bh=HLHynNfCCOyl7r7y8m+vUGF0F/shQyUSdzjyDMCEhRU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Uvj1ENBQkhaiiRB83zvBRH3f8Csir057MfAxvizh6zvteIyEiAozcDLxEHZIz+DU1jIZbCvtzYMXS88NITtFcO2fZD3PApBjGdafuZiLc726RhIZpE/lILdbd/OuZXdaUSlMkJRn41fD0A3JoFNzm+V32nqX7nzHw2cGYzzF7XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dkDKSc8a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wGECxv/L; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dkDKSc8a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wGECxv/L"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8A67111400D8;
	Fri, 27 Dec 2024 05:47:20 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 27 Dec 2024 05:47:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735296440;
	 x=1735382840; bh=5S6Vh/GlSTPlon10saubYRL0hUbdtAsBrSh9OPH4RY0=; b=
	dkDKSc8ahSMQYsvGsZ9M2+osADTcrEeEodvpSS9Gqfn5Dftb3nQm6l1aBUc7NBqf
	dqatVu9KXxubdEub56Gtzr/eiiNXTPcD4nAx0ux090NE1nv0O6b7YLHBn/2XqISA
	cyhwuiYc7VJ+LEMSRF/Q4pYJL5rZaV8vW1lw0n1ojd03xKXdLv6GvpGiTdcKA0f2
	ONDzQbXGB+4v89ZHmgJZ0FzeFq9aQxtjCQPpF97orIGUOEUM6Wns4/unf4KpJiiM
	4iTkaX12nEWlpG2ygMs9zFNq0I5ZrAmqa9K7Y7dlD5nH+AxOpqnvoAYGbN32WEXx
	iC5U5Z9K7En2drf97ggaUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735296440; x=
	1735382840; bh=5S6Vh/GlSTPlon10saubYRL0hUbdtAsBrSh9OPH4RY0=; b=w
	GECxv/LOOaaqoBJX9hG5D9LhFNX13WzevSZMCRJdHgJFHf49MjD8toiWuwAAejVS
	tm0ZmDYj2HhPFCFmxh4hQYm83hnixiJX4pbUa9C67IHCkzP7LGrr1CtUKG+ZmQKj
	S9z3BdvRZXn86ScmavfDm9KkPU2Vi3DhmOtq/Moqh/4Z5CiI3ZcS1309pUNX10j6
	TrykaZr+4cuJrWTeIGwX9OtlDKImpyxnqAGONMk7OWNbJtOzLKMfq6UZwkud9zNH
	5R7lVyC+dbcAESn8cWmvHJDvQzBUz2ssSl9F2u5/ytjGbZA1h8CVoo0fWZvoB+lR
	MdduoExBWY3xW9rU8UZeg==
X-ME-Sender: <xms:uIVuZ5kNA-J5UPdcA0K29DT4uWPDqC7tKmHDj8YC2H2Pq7SH8LrVhA>
    <xme:uIVuZ01chng-95uTlzRfD3yqOtWLTN0Xc2IcYh2mCCkzJxYu0PqF539zRCxmeW4Ha
    Srw17a7fGuSv1xGwA>
X-ME-Received: <xmr:uIVuZ_rSftyTZ4sz4agdBNt63wGONvbUYlgjXm05DnehSd7rr189Os2oBAY0lt_iCZ6jW4lvMRKSKGoioo-ukZ-B9PSL98HdH3Kz7cX7v_aW0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvtddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhf
    sehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:uIVuZ5nc52JRKKofqiqj4Zxm94UfvQwzJlxmSO74NOspUq4PThNNJA>
    <xmx:uIVuZ30nOrQ8aVkgciB0shcuvyz1QJuqAccq8kf5LAwVNrWgfqoMbA>
    <xmx:uIVuZ4u6X0p5xjUDnk6pVdUQxb0y73V3ouOvnIn0HgqHSF3wgkl4mw>
    <xmx:uIVuZ7XgHKHQUj3jkKuCuw_h58nZ81yEn3rIZzAiLHKhx04JC4U8yQ>
    <xmx:uIVuZ1DH4W6JNuIpwpWlyyHWsV2EAfhmQVXz7e84p4c1g-HvHv63IHHq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Dec 2024 05:47:19 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 153ea489 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Dec 2024 10:45:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 27 Dec 2024 11:46:25 +0100
Subject: [PATCH 5/9] commit-reach: use `size_t` to track indices in
 `get_reachable_subset()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241227-b4-pks-commit-reach-sign-compare-v1-5-07c59c2aa632@pks.im>
References: <20241227-b4-pks-commit-reach-sign-compare-v1-0-07c59c2aa632@pks.im>
In-Reply-To: <20241227-b4-pks-commit-reach-sign-compare-v1-0-07c59c2aa632@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

Similar as with the preceding commit, adapt `get_reachable_subset()` so
that it tracks array indices via `size_t` instead of using signed
integers to fix a couple of -Wsign-compare warnings. Adapt callers
accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 bisect.c       | 9 +++++----
 commit-reach.c | 8 ++++----
 commit-reach.h | 4 ++--
 commit.c       | 4 ++--
 commit.h       | 2 +-
 ref-filter.c   | 2 +-
 remote.c       | 4 ++--
 7 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/bisect.c b/bisect.c
index 1a9069c9ad8a19d6e0ee45415407c70f36885514..7a1afc46e5fc0250212f5b6eaf952cf8e36b56fe 100644
--- a/bisect.c
+++ b/bisect.c
@@ -780,10 +780,10 @@ static struct commit *get_commit_reference(struct repository *r,
 }
 
 static struct commit **get_bad_and_good_commits(struct repository *r,
-						int *rev_nr)
+						size_t *rev_nr)
 {
 	struct commit **rev;
-	int i, n = 0;
+	size_t i, n = 0;
 
 	ALLOC_ARRAY(rev, 1 + good_revs.nr);
 	rev[n++] = get_commit_reference(r, current_bad_oid);
@@ -887,7 +887,7 @@ static enum bisect_error check_merge_bases(int rev_nr, struct commit **rev, int
 	return res;
 }
 
-static int check_ancestors(struct repository *r, int rev_nr,
+static int check_ancestors(struct repository *r, size_t rev_nr,
 			   struct commit **rev, const char *prefix)
 {
 	struct strvec rev_argv = STRVEC_INIT;
@@ -922,7 +922,8 @@ static enum bisect_error check_good_are_ancestors_of_bad(struct repository *r,
 {
 	char *filename;
 	struct stat st;
-	int fd, rev_nr;
+	int fd;
+	size_t rev_nr;
 	enum bisect_error res = BISECT_OK;
 	struct commit **rev;
 
diff --git a/commit-reach.c b/commit-reach.c
index d7f6f1be75e95cc834d60be719e930a77ad0518f..bab40f557580476d59d3a0b0ef56f40263e6615e 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -791,8 +791,8 @@ int can_all_from_reach_with_flag(struct object_array *from,
 				 timestamp_t min_generation)
 {
 	struct commit **list = NULL;
-	int i;
-	int nr_commits;
+	size_t i;
+	size_t nr_commits;
 	int result = 1;
 
 	ALLOC_ARRAY(list, from->nr);
@@ -944,8 +944,8 @@ int can_all_from_reach(struct commit_list *from, struct commit_list *to,
 	return result;
 }
 
-struct commit_list *get_reachable_subset(struct commit **from, int nr_from,
-					 struct commit **to, int nr_to,
+struct commit_list *get_reachable_subset(struct commit **from, size_t nr_from,
+					 struct commit **to, size_t nr_to,
 					 unsigned int reachable_flag)
 {
 	struct commit **item;
diff --git a/commit-reach.h b/commit-reach.h
index d5f3347376b6310727c74b81cb7660485b96c0bc..fa5408054ac01372c041d18595a405cfdaec6af3 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -95,8 +95,8 @@ int can_all_from_reach(struct commit_list *from, struct commit_list *to,
  * This method uses the PARENT1 and PARENT2 flags during its operation,
  * so be sure these flags are not set before calling the method.
  */
-struct commit_list *get_reachable_subset(struct commit **from, int nr_from,
-					 struct commit **to, int nr_to,
+struct commit_list *get_reachable_subset(struct commit **from, size_t nr_from,
+					 struct commit **to, size_t nr_to,
 					 unsigned int reachable_flag);
 
 struct ahead_behind_count {
diff --git a/commit.c b/commit.c
index a127fe60c5e83c3968fc0538f0e801e4afd52acd..540660359d4190f7dbc1aaa7668b033a6d16afe9 100644
--- a/commit.c
+++ b/commit.c
@@ -778,11 +778,11 @@ static void clear_commit_marks_1(struct commit_list **plist,
 	}
 }
 
-void clear_commit_marks_many(int nr, struct commit **commit, unsigned int mark)
+void clear_commit_marks_many(size_t nr, struct commit **commit, unsigned int mark)
 {
 	struct commit_list *list = NULL;
 
-	while (nr--) {
+	for (size_t i = 0; i < nr; i++) {
 		clear_commit_marks_1(&list, *commit, mark);
 		commit++;
 	}
diff --git a/commit.h b/commit.h
index 943e3d74b2ae026d77e3bac59a4e993314e79ce4..70c870dae4d4b972a1f608983fc17024ad04d2e9 100644
--- a/commit.h
+++ b/commit.h
@@ -210,7 +210,7 @@ struct commit *pop_most_recent_commit(struct commit_list **list,
 struct commit *pop_commit(struct commit_list **stack);
 
 void clear_commit_marks(struct commit *commit, unsigned int mark);
-void clear_commit_marks_many(int nr, struct commit **commit, unsigned int mark);
+void clear_commit_marks_many(size_t nr, struct commit **commit, unsigned int mark);
 
 
 enum rev_sort_order {
diff --git a/ref-filter.c b/ref-filter.c
index 23054694c2c96014ef411a225c6c941eb8d2d56c..bf5534605e234d7cdd01d52f5c83f5314745e13d 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -3041,7 +3041,7 @@ static void reach_filter(struct ref_array *array,
 			 struct commit_list **check_reachable,
 			 int include_reached)
 {
-	int i, old_nr;
+	size_t i, old_nr;
 	struct commit **to_clear;
 
 	if (!*check_reachable)
diff --git a/remote.c b/remote.c
index 18e5ccf391844516e2fcc54fc0d6835283ff6a48..0f6fba85625b523122e50e28a0f64b6e143cd9fb 100644
--- a/remote.c
+++ b/remote.c
@@ -1535,7 +1535,7 @@ static struct ref **tail_ref(struct ref **head)
 
 struct tips {
 	struct commit **tip;
-	int nr, alloc;
+	size_t nr, alloc;
 };
 
 static void add_to_tips(struct tips *tips, const struct object_id *oid)
@@ -1602,7 +1602,7 @@ static void add_missing_tags(struct ref *src, struct ref **dst, struct ref ***ds
 		const int reachable_flag = 1;
 		struct commit_list *found_commits;
 		struct commit **src_commits;
-		int nr_src_commits = 0, alloc_src_commits = 16;
+		size_t nr_src_commits = 0, alloc_src_commits = 16;
 		ALLOC_ARRAY(src_commits, alloc_src_commits);
 
 		for_each_string_list_item(item, &src_tag) {

-- 
2.48.0.rc0.184.g0fc57dec57.dirty

