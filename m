Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1913C18858D
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 09:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727687610; cv=none; b=ceF4YOmAtCBos2RkSQd9InVAqTscn+YcqHa5vyL5h76fQo6mgXPoHQL/+9+dY5asxjO/bRZDmK11zcjgl3lJr2Yoj7gMCtvMW0R05xubSlW14qWIq1EtutJtcOodukFw+JYEToeqBJGTcEkEdMN0cgwaFG+8kEnDzWMYgaQ5vgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727687610; c=relaxed/simple;
	bh=iQPwM65CoBe3fymROaL6km5B2te5VTVja2vT5AKFdLw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brQuhGwjRIUVmIPMZ2Tetqz5Y9o+XFBDcXBYsrYvp9PnNfvTtDYhmixyJULhbZXjbgoDP/I7k2C/O9/XMR3i72ohPCJ2HM6jlPB+Z1W5LzS9yZEsZtRrH5MTJl3HKBRc5tDi/JYpquP40T3oSnSLl/Av7PqOOeTivWYasmPB3Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IVdwgDt2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pYgHv9sg; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IVdwgDt2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pYgHv9sg"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5700C11400B7
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 05:13:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 30 Sep 2024 05:13:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727687608; x=1727774008; bh=mvjPC5KKjQ
	UnuK7GCn8/Jr/zeybuo/nbGbajliZmT4Y=; b=IVdwgDt2rxaYVNqByUJ3kOZ9X+
	8nRJywkG9c57QVnDoRVaUWl7r5di+Jo99N4/RfEsdoaJv8Mb+ts67/64vGhp827E
	1mtSdKL0LzeKsBV7Y1O4eysne/KNQaXtvVxYdMdHmbi3IFp3+9YpKFSeKsKohyiw
	4qwH1iYN4YSZIlrwdFDJ6FqNnL4e4+XkKhVwjBxh5S/rEYqqAtTyL2gXrLXhOXFL
	aJ+vi8BhxnQbg3npBwy0t48Dj/wypnKSxor1dbMFe92j3pyJIwe2odcsnfwoHcTa
	XX2WouydV/z18yzm9OkuCipiUcZ5UC7Xo99hDw99Sv6BrLaeUM4+X2v7Mv3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727687608; x=1727774008; bh=mvjPC5KKjQUnuK7GCn8/Jr/zeybu
	o/nbGbajliZmT4Y=; b=pYgHv9sguCzuDVjaDT0KB23ivHC822ay1LoXzGIK68NI
	dJL8E2S6yBNKXKLws2JB7bAzMypXHnlorajbGAX1tbjyjtnafTyytpN0NmP1AsbE
	qC4NuRlq4Czw7u5C0AnS1tGsln0nTcps0CQoCdyHdZnGtH4Q+gopgzwFYm96TfoO
	DATROG5bYLHDWlYeTU8yrHhQICeE+Cd+UiRxPK7eT92CbDGgB60fJgCg6ztOOdKf
	7NAuVnCTshxj+RMPSNmDClAVLNZUN0itIfXjq7DZABE5DvaMI5JGh6FbxuhvUNDR
	OCsZV0lTZVQIn3fbQc7DPOuZ/Q3v679Eqp0YIEh8ew==
X-ME-Sender: <xms:uGv6ZnRd3J_2_GSCES_iTeBi4ihlwn1shmQmLcsDaDocfpqVB0GlpQ>
    <xme:uGv6ZowesBPbVcV62w2v9w3KXjG0eoy-MdZLMVhEueglSh9c9yGe9iebBgxuwrl4Z
    zRVqX1AiVpZztZQKg>
X-ME-Received: <xmr:uGv6Zs0h3yUs5b-3FlgM7ls3iA-fD7XSb7ciFEFicn8H_csMwi3AgOm0roizm1XYRIEvGa2dgr2V8J1wm_klEJhb_9L3nlHiwR_9Pma7BZOumgA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:uGv6ZnD-PsygxKALR3PkX63BAlu5XJql8KLZ0QXn89rnBHB6vosdzg>
    <xmx:uGv6Zgi67npNjOPkvLkVi7dmVcBqI-T7zc8k-wsLMoqSaIz0yqlspg>
    <xmx:uGv6ZroBD8NxLQQK2thAkMV6HOm1S0-OeWSrBQ4w613eJFr0wKXYLg>
    <xmx:uGv6ZrhpBt9tAm4I_RuujqoclfjGOxPCfBnHgtRJsODJq61Gcti6Gg>
    <xmx:uGv6ZsZnreUr-guTqTmq6_EZPVMbMPawi6EYxA5SBtMdhxLl0eEX1ULu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 30 Sep 2024 05:13:27 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 907e9062 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 30 Sep 2024 09:12:41 +0000 (UTC)
Date: Mon, 30 Sep 2024 11:13:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 05/23] wt-status: fix leaking buffer with sparse directories
Message-ID: <4196fea159a98ff9a25ca0f65a9c669f45155a7b.1727687410.git.ps@pks.im>
References: <cover.1727687410.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727687410.git.ps@pks.im>

When hitting a sparse directory in `wt_status_collect_changes_initial()`
we use a `struct strbuf` to assemble the directory's name. We never free
that buffer though, causing a memory leak.

Fix the leak by releasing the buffer. While at it, move the buffer
outside of the loop and reset it to save on some wasteful allocations.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1092-sparse-checkout-compatibility.sh | 1 +
 wt-status.c                              | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index eb32da2a7f..55efafe4e0 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -5,6 +5,7 @@ test_description='compare full workdir to sparse workdir'
 GIT_TEST_SPLIT_INDEX=0
 GIT_TEST_SPARSE_INDEX=
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/wt-status.c b/wt-status.c
index 6a6397ca8f..6a8c05d1cf 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -717,6 +717,7 @@ static int add_file_to_list(const struct object_id *oid,
 static void wt_status_collect_changes_initial(struct wt_status *s)
 {
 	struct index_state *istate = s->repo->index;
+	struct strbuf base = STRBUF_INIT;
 	int i;
 
 	for (i = 0; i < istate->cache_nr; i++) {
@@ -735,7 +736,6 @@ static void wt_status_collect_changes_initial(struct wt_status *s)
 			 * expanding the trees to find the elements that are new in this
 			 * tree and marking them with DIFF_STATUS_ADDED.
 			 */
-			struct strbuf base = STRBUF_INIT;
 			struct pathspec ps = { 0 };
 			struct tree *tree = lookup_tree(istate->repo, &ce->oid);
 
@@ -743,9 +743,11 @@ static void wt_status_collect_changes_initial(struct wt_status *s)
 			ps.has_wildcard = 1;
 			ps.max_depth = -1;
 
+			strbuf_reset(&base);
 			strbuf_add(&base, ce->name, ce->ce_namelen);
 			read_tree_at(istate->repo, tree, &base, 0, &ps,
 				     add_file_to_list, s);
+
 			continue;
 		}
 
@@ -772,6 +774,8 @@ static void wt_status_collect_changes_initial(struct wt_status *s)
 			s->committable = 1;
 		}
 	}
+
+	strbuf_release(&base);
 }
 
 static void wt_status_collect_untracked(struct wt_status *s)
-- 
2.46.2.852.g229c0bf0e5.dirty

