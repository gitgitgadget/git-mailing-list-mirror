Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EA51F2C4B
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 10:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735296446; cv=none; b=OU97y1OiVw/cTc1caAhu2DF74kR2/79yvWGXgF05I9FH5U4G28oOrwaQVfwWJlmVqvpCYdp7g4Up0+i32OGNErmyGNAN8ere4cIFf9sakb3Aj6OhPSP+tlmuXtYSm22D7nfpSqZItV9rMB0UdCVgTp46SwrAA8uFjI21y19z6pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735296446; c=relaxed/simple;
	bh=Onq1Xvs6f6Gy6S95efIfPuIvVzSBZ0B+8qEIh71xUmE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LposA5XjqJapr9170RW+8j6IVOsFre07NhsZUfWhl0UYXfHSuadn6lVkMOaQ/DnLTMA1rg6fc4HyKjQ+zSe31ExT8p3XEv/1qZPrxQP9ph0ClqtfXgKyyCXzqj36L1RTmN7vqnGO/1Tsh9jdxH2RD6aD/1p1hTivCXP9C6Fp7jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iFsTvugw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YnhjVaXT; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iFsTvugw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YnhjVaXT"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id C406F1380146;
	Fri, 27 Dec 2024 05:47:23 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 27 Dec 2024 05:47:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735296443;
	 x=1735382843; bh=zYcMOUIU3thyun63hOz2gpKsEcGRdAIkcmuRkAtkfDg=; b=
	iFsTvugwHjStD1BNjLmOp1kMblBlr7Puq+PcTd5Ucn29jajopgpjdSAyxGWiR8wo
	fNaJI9n6nI8ChI4VY7iDvQStFq4uLQ083lpRIUPF5icMf8ga8K4wZA/yiwypo+SB
	Vh1p19Xl48HJFZxtrudsaLvFJ/IugfjbhpJ9rRalEjWS78zlkoj6Rufn5mfVpqQC
	pmlmPTHRmp8Jo2rRP+yBYARtkgIa3ZVNSJNLjUit8IuIRWtxiQ6dp1Vqpt3feMYx
	ipkjyMOps6B8nWMbw8sToM5UHKWFCimH7M2Gv3rlZA8MCRSxsGWpJBjs78V0PoWK
	VS7TOv6mt+ymRI0l40Pv6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735296443; x=
	1735382843; bh=zYcMOUIU3thyun63hOz2gpKsEcGRdAIkcmuRkAtkfDg=; b=Y
	nhjVaXTW8YKB+B0niRGEH9MTOlva7AqrLnYHQgL6OBb2/fUMSKRMJbPnA6TvWgYq
	xSkWWh1jysmn95ubDngi1lHCdkh779Pk5FpXhAG9lEAfPCSoWLal/rSLiRgK0YtR
	foD0gdxtFe0zKMC9KxgiPUCWbLkbuH0Go7A4CmUYfjLyUbMkdb1zFz8B+/ntQkmj
	HVUIrCKwGA+nRR1+6dL4IllVitKNQYkh+cOq4PyvDLbbTjxQYKjXtwgeX19H8bvm
	yOsc7W/qHM64Y071PxqKFUxzprvHJMU+SlFiwwZvr8yDrlG4qLK13SreGGQACrMR
	2vufZDwyIDkWHp8P0ebfA==
X-ME-Sender: <xms:u4VuZ4JFOpRkH8ZhznnQZv9XhMp_fYBCxoWPqqbj9D5xojTaiAXcPw>
    <xme:u4VuZ4KAEI8kmoYGnuAebNgIVnhqdzRr-s_j5eyqciTj94Do8g-C5YgOKqjNQcb-d
    TtfQTycQ1VUQF7LWA>
X-ME-Received: <xmr:u4VuZ4vbs-htcsAz6EfwsJdklStXlr4Fi3QYznsfabfnLvlIJim6J8Jn0A5Xj0NCQWDcLJyQCzSHkm9HySp56-gdMR4rm6PzMhcTzqBlFzHjyg>
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
X-ME-Proxy: <xmx:u4VuZ1bI2t54eh5uYJ3VZORloyPTepN29d3nJmzkxetUx4eV4adJVQ>
    <xmx:u4VuZ_ZUsPKEZnDtgVc5aE4wF0effSu7_vgtmZcaSsyxxBDzGb6y5Q>
    <xmx:u4VuZxDNF-nSdcZfl3HjF2mA4pbbAh5NoxY-dUZQ0EJm-2MKS2o7fw>
    <xmx:u4VuZ1ZBvP7WSPbAq80w1CoObhRX5LetAdGjewR872hRW0xkID1hMg>
    <xmx:u4VuZ-nK2Ju8Qn4tJ4p5SzaBVo7a7eSIOEjiaWadHzl-fMSwJvHP40lu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Dec 2024 05:47:22 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4b7d4690 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Dec 2024 10:45:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 27 Dec 2024 11:46:29 +0100
Subject: [PATCH 9/9] commit-reach: use `size_t` to track indices when
 computing merge bases
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241227-b4-pks-commit-reach-sign-compare-v1-9-07c59c2aa632@pks.im>
References: <20241227-b4-pks-commit-reach-sign-compare-v1-0-07c59c2aa632@pks.im>
In-Reply-To: <20241227-b4-pks-commit-reach-sign-compare-v1-0-07c59c2aa632@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

The functions `repo_get_merge_bases_many()` and friends accepts an array
of commits as well as a parameter that indicates how large that array
is. This parameter is using a signed integer, which leads to a couple of
warnings with -Wsign-compare.

Refactor the code to use `size_t` to track indices instead and adapt
callers accordingly. While most callers are trivial, there are two
callers that require a bit more scrutiny:

  - builtin/merge-base.c:show_merge_base() subtracts `1` from the
    `rev_nr` before calling `repo_get_merge_bases_many_dirty()`, so if
    the variable was `0` it would wrap. This code is fine though because
    its only caller will execute that code only when `argc >= 2`, and it
    follows that `rev_nr >= 2`, as well.

  - bisect.ccheck_merge_bases() similarly subtracts `1` from `rev_nr`.
    Again, there is only a single caller that populates `rev_nr` with
    `good_revs.nr`. And because a bisection always requires at least one
    good revision it follws that `rev_nr >= 1`.

Mark the file as -Wsign-compare-clean.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 bisect.c              | 2 +-
 builtin/merge-base.c  | 4 ++--
 commit-reach.c        | 7 +++----
 commit-reach.h        | 4 ++--
 t/helper/test-reach.c | 6 +++---
 5 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/bisect.c b/bisect.c
index 7a1afc46e5fc0250212f5b6eaf952cf8e36b56fe..7a3c77c6d84da0cb6e135b6e0b1ca3596903af5c 100644
--- a/bisect.c
+++ b/bisect.c
@@ -855,7 +855,7 @@ static void handle_skipped_merge_base(const struct object_id *mb)
  * for early success, this will be converted back to 0 in
  * check_good_are_ancestors_of_bad().
  */
-static enum bisect_error check_merge_bases(int rev_nr, struct commit **rev, int no_checkout)
+static enum bisect_error check_merge_bases(size_t rev_nr, struct commit **rev, int no_checkout)
 {
 	enum bisect_error res = BISECT_OK;
 	struct commit_list *result = NULL;
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index a20c93b11aaa0b9f380b843469da2a3b5db10d00..123c81515e1f5f12045e4073f78b6e8a2b04bb4b 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -8,7 +8,7 @@
 #include "parse-options.h"
 #include "commit-reach.h"
 
-static int show_merge_base(struct commit **rev, int rev_nr, int show_all)
+static int show_merge_base(struct commit **rev, size_t rev_nr, int show_all)
 {
 	struct commit_list *result = NULL, *r;
 
@@ -149,7 +149,7 @@ int cmd_merge_base(int argc,
 		   struct repository *repo UNUSED)
 {
 	struct commit **rev;
-	int rev_nr = 0;
+	size_t rev_nr = 0;
 	int show_all = 0;
 	int cmdmode = 0;
 	int ret;
diff --git a/commit-reach.c b/commit-reach.c
index bab40f557580476d59d3a0b0ef56f40263e6615e..a339e41aa4ed1e375ee6f2f42a163ff1c654c3e4 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "commit.h"
@@ -421,7 +420,7 @@ static int remove_redundant(struct repository *r, struct commit **array,
 
 static int get_merge_bases_many_0(struct repository *r,
 				  struct commit *one,
-				  int n,
+				  size_t n,
 				  struct commit **twos,
 				  int cleanup,
 				  struct commit_list **result)
@@ -469,7 +468,7 @@ static int get_merge_bases_many_0(struct repository *r,
 
 int repo_get_merge_bases_many(struct repository *r,
 			      struct commit *one,
-			      int n,
+			      size_t n,
 			      struct commit **twos,
 			      struct commit_list **result)
 {
@@ -478,7 +477,7 @@ int repo_get_merge_bases_many(struct repository *r,
 
 int repo_get_merge_bases_many_dirty(struct repository *r,
 				    struct commit *one,
-				    int n,
+				    size_t n,
 				    struct commit **twos,
 				    struct commit_list **result)
 {
diff --git a/commit-reach.h b/commit-reach.h
index fa5408054ac01372c041d18595a405cfdaec6af3..6012402dfcfe453fd710d0b4c9a9e09f8953f63a 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -14,12 +14,12 @@ int repo_get_merge_bases(struct repository *r,
 			 struct commit *rev2,
 			 struct commit_list **result);
 int repo_get_merge_bases_many(struct repository *r,
-			      struct commit *one, int n,
+			      struct commit *one, size_t n,
 			      struct commit **twos,
 			      struct commit_list **result);
 /* To be used only when object flags after this call no longer matter */
 int repo_get_merge_bases_many_dirty(struct repository *r,
-				    struct commit *one, int n,
+				    struct commit *one, size_t n,
 				    struct commit **twos,
 				    struct commit_list **result);
 
diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index 01cf77ae65b9a7db2f31a9a1558b8bb84b2e81d3..028ec0030678284eba844e121c6eff88abdd3139 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -35,7 +35,7 @@ int cmd__reach(int ac, const char **av)
 	struct commit_list *X, *Y;
 	struct object_array X_obj = OBJECT_ARRAY_INIT;
 	struct commit **X_array, **Y_array;
-	int X_nr, X_alloc, Y_nr, Y_alloc;
+	size_t X_nr, X_alloc, Y_nr, Y_alloc;
 	struct strbuf buf = STRBUF_INIT;
 	struct repository *r = the_repository;
 
@@ -157,7 +157,7 @@ int cmd__reach(int ac, const char **av)
 		clear_contains_cache(&cache);
 	} else if (!strcmp(av[1], "get_reachable_subset")) {
 		const int reachable_flag = 1;
-		int i, count = 0;
+		int count = 0;
 		struct commit_list *current;
 		struct commit_list *list = get_reachable_subset(X_array, X_nr,
 								Y_array, Y_nr,
@@ -169,7 +169,7 @@ int cmd__reach(int ac, const char **av)
 				    oid_to_hex(&list->item->object.oid));
 			count++;
 		}
-		for (i = 0; i < Y_nr; i++) {
+		for (size_t i = 0; i < Y_nr; i++) {
 			if (Y_array[i]->object.flags & reachable_flag)
 				count--;
 		}

-- 
2.48.0.rc0.184.g0fc57dec57.dirty

