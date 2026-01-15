Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB5A35CB8F
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 09:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768469767; cv=none; b=CxW2xbzCPIg07Mk3g7miWP/cXLM6TMS9Ju+s8nGWhDPjTNqoN3SGiaoQOMSpaWEanKtfRCMFUvK5dW5FrYUEg5C0pYjZHkh2iRbgV8XHIOBIcU9pPwdNdmS+c8FZ94bBsSSNivd5LGS3f2cfe1cGt0iXq2O2swpwIOiDDGotwNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768469767; c=relaxed/simple;
	bh=g9VMiada2oO6U1Z4G49XsjoLIbo/8q0UqwDdR+yCMl8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L2OEhI4C8n7K1ekZRWwHyE9BfGHwtNCotaGtD92o30lPpLksP8cSgHmYe0kfbp/7ucIGkdsgNo6bifutKPuDS5dJ+Ijksi07CCdnrpMvLiTG3zK6DyHe3lqwZUMh+P6xuyV5+Xj6/nP46NJTu9roSTg9ewk1fC3jtMG0q5Lvhy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MJEVKXwH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u2SMKcCU; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MJEVKXwH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u2SMKcCU"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E809D7A0035
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 04:36:05 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 15 Jan 2026 04:36:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768469765;
	 x=1768556165; bh=YQJ63D7YKEDgsS0aSmkyRKZa2RzYyNA4PCykXpOpfuk=; b=
	MJEVKXwHxDDFZ3yGrpjIxH0POLpEblCtE/NkNtX610P/MRLiFXvVxhuJUAeM3vfb
	XIuyvAa//YDUuoqO2Ajv3kywZU8wA99dZKmkkT0oAqdqVP4nXR51PntAXgq/QIQ5
	C7DmgNqxnfCYc2UjeOSHVOjyCvG71NPrL0UIMHSkJM+YQV4G2Xon3rmhJ2VFv+rl
	hT6X8o2beaa5d/c5MIphogRub7eKvRB8lEVWymdyNO8s9mrz1wp3sS7L1x/lZ4PG
	xlYt+CB41Iz6M8qzPehC+Va2VuGSCVhuySI4dRJOVbkHDN+2bUCUwqCJffiH6BUZ
	o+Z/3V1sP0AuSAobu6XZGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768469765; x=
	1768556165; bh=YQJ63D7YKEDgsS0aSmkyRKZa2RzYyNA4PCykXpOpfuk=; b=u
	2SMKcCU1TSaUz79JWlmxkn9swK6AhSBXsJ04O5TVrLB8j0Z67wqy+lF9exs8AsA9
	YhX3V0xnS7DvqOwefr0KdLWiDpeQNGbFaTZrHw5FoGsZFcz8cUfjY1nrejotCJqZ
	DvPYecEvit6WgR/FXfQxMge/OhmRRwuD00gT/NeUd59y5L0+94clBrbe7f7tROhe
	UdLZ/voI1d18n/icsoYSwEM0bEdesoyTOhsFk7Ad3xiInxkd42uq8nEDG+JiJCyP
	8leVhEoEIbCxUfYjENpAgZdFQS8ZVNk/uYmz+4Mjx0lSV5hKDvz+gtrVXbLrIrtH
	kojfmPYiPfFAj10f+fVTg==
X-ME-Sender: <xms:BbVoaRkiI3e-_eKoQEtzd3i_T1AUVRwgNNFS7G2hgAgbPn8EUaSZkQ>
    <xme:BbVoaTwPRA5-8HRiaSlaZA7yS1T7OSKWS9-ABFaKxoyHhqVSVw3brt_i851IaoIms
    hLZbA-zUFjt6q7GSbxLcdQrJj6gO5_Kox9lcRkqSZzZyUKkweErw2k>
X-ME-Received: <xmr:BbVoadTPHMiujkvv1P2evdrvFPgprs4VcF_R89VonSMku1Tp5Xv5vcXEtQtv5P3orUB3pZGcRxt-BkNcy8OUQWWaJ3acJBr6pBs5WmnlmC90aQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdehjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:BbVoaWt24u4e1hrwWv5lToRlVclrC3Zf7ofXVoucWz0NdCr9TxCb6Q>
    <xmx:BbVoafuCmcIuPwirMwhRHhU3cIl0vpQj0jpyiSk1a2XPonwZvRI-jA>
    <xmx:BbVoacwzGfIEQp4t4BVTnEUlzwdayuC7rQ7iWf0q7Ar-8QbrOIMYFA>
    <xmx:BbVoaVhfU3CJF94rxB6WnjWmDTWbg2Fc8SgwI5Yanp-me9ixfe97ew>
    <xmx:BbVoaZ023ZYd1SuVTtP5RxMhA9Fpcg7xcKJmYZVvx3XYHsLuA63AQXO_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 15 Jan 2026 04:36:05 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 53d3c8a5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 15 Jan 2026 09:36:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 15 Jan 2026 10:35:33 +0100
Subject: [PATCH 2/3] commit: rename `reverse_commit_list()` to conform to
 coding guidelines
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-pks-commit-list-coding-guidelines-v1-2-c58868dbf412@pks.im>
References: <20260115-pks-commit-list-coding-guidelines-v1-0-c58868dbf412@pks.im>
In-Reply-To: <20260115-pks-commit-list-coding-guidelines-v1-0-c58868dbf412@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Our coding guidelines say that:

  Functions that operate on `struct S` are named `S_<verb>()` and should
  generally receive a pointer to `struct S` as first parameter.

While most of the functions related to `struct commit_list` already
follow that naming schema, `reverse_commit_list()` doesn't.

Rename the function to address this and adjust all of its callers. Add a
compatibility wrapper for the old function name to ease the transition
and avoid any semantic conflicts with in-flight patch series. This
wrapper will be removed once Git 2.53 has been released.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/merge-tree.c | 2 +-
 builtin/stash.c      | 2 +-
 commit.c             | 2 +-
 commit.h             | 7 ++++++-
 merge-ort.c          | 2 +-
 sequencer.c          | 2 +-
 6 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 1c063d9a41..979a55d3b2 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -483,7 +483,7 @@ static int real_merge(struct merge_tree_options *o,
 			exit(128);
 		if (!merge_bases && !o->allow_unrelated_histories)
 			die(_("refusing to merge unrelated histories"));
-		merge_bases = reverse_commit_list(merge_bases);
+		merge_bases = commit_list_reverse(merge_bases);
 		merge_incore_recursive(&opt, merge_bases, parent1, parent2, &result);
 		free_commit_list(merge_bases);
 	}
diff --git a/builtin/stash.c b/builtin/stash.c
index 948eba06fb..4cb2351787 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -2308,7 +2308,7 @@ static int do_export_stash(struct repository *r,
 	 * but where their first parents form a chain to our original empty
 	 * base commit.
 	 */
-	items = reverse_commit_list(items);
+	items = commit_list_reverse(items);
 	for (cur = items; cur; cur = cur->next) {
 		struct commit_list *parents = NULL;
 		struct commit_list **next = &parents;
diff --git a/commit.c b/commit.c
index c5c66d3a6b..36f02c96aa 100644
--- a/commit.c
+++ b/commit.c
@@ -691,7 +691,7 @@ struct commit_list *commit_list_copy(const struct commit_list *list)
 	return head;
 }
 
-struct commit_list *reverse_commit_list(struct commit_list *list)
+struct commit_list *commit_list_reverse(struct commit_list *list)
 {
 	struct commit_list *next = NULL, *current, *backup;
 	for (current = list; current; current = backup) {
diff --git a/commit.h b/commit.h
index 2faf08cd18..f50d9e5a4a 100644
--- a/commit.h
+++ b/commit.h
@@ -189,7 +189,7 @@ void commit_list_sort_by_date(struct commit_list **list);
 struct commit_list *commit_list_copy(const struct commit_list *list);
 
 /* Modify list in-place to reverse it, returning new head; list will be tail */
-struct commit_list *reverse_commit_list(struct commit_list *list);
+struct commit_list *commit_list_reverse(struct commit_list *list);
 
 void free_commit_list(struct commit_list *list);
 
@@ -202,6 +202,11 @@ static inline struct commit_list *copy_commit_list(struct commit_list *l)
 	return commit_list_copy(l);
 }
 
+static inline struct commit_list *reverse_commit_list(struct commit_list *l)
+{
+	return commit_list_reverse(l);
+}
+
 struct rev_info; /* in revision.h, it circularly uses enum cmit_fmt */
 
 const char *repo_logmsg_reencode(struct repository *r,
diff --git a/merge-ort.c b/merge-ort.c
index f31754c361..2ddaaffc26 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -5314,7 +5314,7 @@ static void merge_ort_internal(struct merge_options *opt,
 			goto out;
 		}
 		/* See merge-ort.h:merge_incore_recursive() declaration NOTE */
-		merge_bases = reverse_commit_list(merge_bases);
+		merge_bases = commit_list_reverse(merge_bases);
 	}
 
 	merged_merge_bases = pop_commit(&merge_bases);
diff --git a/sequencer.c b/sequencer.c
index f38d247b10..e09f8eed55 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4317,7 +4317,7 @@ static int do_merge(struct repository *r,
 		      git_path_merge_head(r), 0);
 	write_message("no-ff", 5, git_path_merge_mode(r), 0);
 
-	bases = reverse_commit_list(bases);
+	bases = commit_list_reverse(bases);
 
 	repo_read_index(r);
 	init_ui_merge_options(&o, r);

-- 
2.52.0.660.gd05f3a8ea5.dirty

