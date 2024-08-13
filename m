Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3648917E8EA
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723541501; cv=none; b=m5M0jiaR/naBCHr7BA6Aw2fU+Jex51GuYhNxHphSTjwmdDxzZtkeHcOV9MgDFPeLGVCOksp3T7s4EroqwDumO+DqGkWaeYxd9ZBf7NLS6qt18yiBaLOWqim2So/ZXnE6kiaZKX5Gf6RGR+eZy7ZTj0gCb8HQX+PEB2pLH8SDvJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723541501; c=relaxed/simple;
	bh=bRWVYqnjVu+N5NHbN8oxZtS1NQshG1QSH2y1ChqmUVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fL5im6cZ9+dNpo7EwzBQNrXaJ6CYsDWMJy0xxr5M9sMXFZ+4RCwvxrohIz/2XYPA3NtBu+a4fl0CmoZfEPD/CcKL357El2/1dfO1buVQsFeYfZ78bfoJM/e/r4A7Qa1+9iO9MJ9ZN1D9vSZEfhSQA0yTfScni4iaHke1Tr3Opoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Pffsi3tx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Onj8s/iF; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Pffsi3tx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Onj8s/iF"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 777DD138FCEA;
	Tue, 13 Aug 2024 05:31:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 13 Aug 2024 05:31:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723541499; x=1723627899; bh=fY3QklG+5J
	9bg7jitVmt2MFrjB4EdA04boCX2CSDFj0=; b=Pffsi3tx9J3Gc/htBZcz3nMCOq
	xzPTi5l07776ftydRQYCINDFyWDO2YHkm2LdMMs+qLB+PQBs97erNNwJ41ZqCi+t
	t6lav3TrSivWiGLTpts0siUG9hRn32PaVtuDkvkJVsKf01LOgzKdkKjGBIMcrcPl
	8kt+TncW7zkqkOuhGIr2DILhDeoX6JELYBJuk6x3tk2cUgeGAbVymgaIW4fCJEh/
	J/3gcZVo2PhD0CX7purnbUaR1ro+qzmm+F4pSN6ysVEyHYI9KW2sfETDrCHl2S3I
	3zav7h6agpol8/QfKn4Gtc2TU9wh+pRrh+fzjI1DzkOTnvzY4yl2+iT0CxfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723541499; x=1723627899; bh=fY3QklG+5J9bg7jitVmt2MFrjB4E
	dA04boCX2CSDFj0=; b=Onj8s/iF5OpgVUS4YDFNauEeQuTQnjYQC4BU/vAtbOYB
	uoR1wh2jaGExZwKGW2GJZauhMuJ2lTk/SfC2U3rQKVb/L3XS6ZnBSY1SKKkhLXkD
	NNpxt3DMo2nv35TOWXSkIPpn60xHoiYfiy4A7Jzi1Hzl+M2O08hzYEOw21JCGG31
	HVn34DDjokl7/pthbXIsbzzHiDQ4GhTRam8QrVQuw38p/3S7AipNPO4XAAV15tOu
	4O10Vvw9zq5IIvUr7AGhLFZJUs+960zubjAopAUGbscjThLQA/eb4IHlaa8jYOf7
	Lp0qmp5bAinFqxPb4bQV/CQ0O2R9jFdbekpCJfQ6VQ==
X-ME-Sender: <xms:-ye7ZnJQpi1rEATdchE_IcwPh3kJTbPzr-CzbODNdt7Nn3v--hgriw>
    <xme:-ye7ZrLIJCnguPsTf8u38niOSY8wtT4N5HJcyKmmWgZ2CMghC41Wwm2srn6LvimAw
    i7MIdbSXvimactMzA>
X-ME-Received: <xmr:-ye7Zvu3cegYZXYuwrOz4Q4cPuj8qFhdleGFOT6p2tmbA50Tdua4IQ0VPDRjluBtFFTqGe4KeC7A1cl5H_g0r8otAKbw_KdnaNxyL6R2CWC1jw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehjrghmvghssehjrghmvghslhhiuhdrihhopdhrtghpthhtohepkhgrrhhthhhi
    khdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrd
    gtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:-ye7ZgZE_q0uBKGCN7HB8p67fLjQ32tdej3aZbyS_UuHSxoWN2B4Fw>
    <xmx:-ye7ZuYeLKyoTqL25FvzByHci1w8KdWS3Lgx5TRnvOzfClDZfZlNnA>
    <xmx:-ye7ZkBoemO4xLKAXmjXGvqEcvpWTT-Yvkr52caOFbmuXTU8DYgigQ>
    <xmx:-ye7ZsZ0ZWJ0DPew4yV6t7OR8uW_Zata0zbvVLJIFRGukAM4V5rH2w>
    <xmx:-ye7ZjO28MKcMVYUKJ8ebNO8etQmGvoHMXF-yEJpqXCpPpUA0GgyTskK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 05:31:38 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6caa586e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 09:31:21 +0000 (UTC)
Date: Tue, 13 Aug 2024 11:31:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, karthik nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3 10/22] builtin/notes: fix leaking `struct notes_tree` when
 merging notes
Message-ID: <0af1bab5a1432eb636dc0fa7b538fa39661cb34d.1723540931.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723540931.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723540931.git.ps@pks.im>

We allocate a `struct notes_tree` in `merge_commit()` which we then
initialize via `init_notes()`. It's not really necessary to allocate the
structure though given that we never pass ownership to the caller.
Furthermore, the allocation leads to a memory leak because despite its
name, `free_notes()` doesn't free the `notes_tree` but only clears it.

Fix this issue by converting the code to use an on-stack variable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/notes.c                       | 9 ++++-----
 t/t3310-notes-merge-manual-resolve.sh | 1 +
 t/t3311-notes-merge-fanout.sh         | 1 +
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index d9c356e354..81cbaeec6b 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -807,7 +807,7 @@ static int merge_commit(struct notes_merge_options *o)
 {
 	struct strbuf msg = STRBUF_INIT;
 	struct object_id oid, parent_oid;
-	struct notes_tree *t;
+	struct notes_tree t = {0};
 	struct commit *partial;
 	struct pretty_print_context pretty_ctx;
 	void *local_ref_to_free;
@@ -830,8 +830,7 @@ static int merge_commit(struct notes_merge_options *o)
 	else
 		oidclr(&parent_oid, the_repository->hash_algo);
 
-	CALLOC_ARRAY(t, 1);
-	init_notes(t, "NOTES_MERGE_PARTIAL", combine_notes_overwrite, 0);
+	init_notes(&t, "NOTES_MERGE_PARTIAL", combine_notes_overwrite, 0);
 
 	o->local_ref = local_ref_to_free =
 		refs_resolve_refdup(get_main_ref_store(the_repository),
@@ -839,7 +838,7 @@ static int merge_commit(struct notes_merge_options *o)
 	if (!o->local_ref)
 		die(_("failed to resolve NOTES_MERGE_REF"));
 
-	if (notes_merge_commit(o, t, partial, &oid))
+	if (notes_merge_commit(o, &t, partial, &oid))
 		die(_("failed to finalize notes merge"));
 
 	/* Reuse existing commit message in reflog message */
@@ -853,7 +852,7 @@ static int merge_commit(struct notes_merge_options *o)
 			is_null_oid(&parent_oid) ? NULL : &parent_oid,
 			0, UPDATE_REFS_DIE_ON_ERR);
 
-	free_notes(t);
+	free_notes(&t);
 	strbuf_release(&msg);
 	ret = merge_abort(o);
 	free(local_ref_to_free);
diff --git a/t/t3310-notes-merge-manual-resolve.sh b/t/t3310-notes-merge-manual-resolve.sh
index 597df5ebc0..04866b89be 100755
--- a/t/t3310-notes-merge-manual-resolve.sh
+++ b/t/t3310-notes-merge-manual-resolve.sh
@@ -5,6 +5,7 @@
 
 test_description='Test notes merging with manual conflict resolution'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Set up a notes merge scenario with different kinds of conflicts
diff --git a/t/t3311-notes-merge-fanout.sh b/t/t3311-notes-merge-fanout.sh
index 5b675417e9..ce4144db0f 100755
--- a/t/t3311-notes-merge-fanout.sh
+++ b/t/t3311-notes-merge-fanout.sh
@@ -5,6 +5,7 @@
 
 test_description='Test notes merging at various fanout levels'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 verify_notes () {
-- 
2.46.0.46.g406f326d27.dirty

