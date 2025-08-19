Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1463326D5D
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 10:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755600975; cv=none; b=jptNeg/7QKTq2UYsreZA3aLOpE0XcFAxSfBOs6A4IIx0e2545VqmzC/ME1PrKKkf6MOWdbcHHXx88/zirLlyaUltD03ngZ0uWUQ5FDwl1uz/uluDxSVNFLXa+WAu9kCDBjjhAgjVz0rIzCWB0GCxAeq5pYw9OpR1M5S3HA7z/zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755600975; c=relaxed/simple;
	bh=EiZMxqibHbud3BLJm48xWsAGFLoNMM2SW+9NQRIhfjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KxZh/EeH5qyl2GiyME5qp9gl1eHKdQKvCkYGkSuzHmYqouGmke1RQZlGOCvUOIs7qukAARzd7Ut0CmvqkG2zcRgPVstq1zqiEt3GFmXPS2Qt3gnFux9uy6skS120FXRKhcEmkCOPywwZet1YMT3yyG1EZAT2hHj+RcNhnhx0+JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lom+0Tvk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MDU6xSsE; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lom+0Tvk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MDU6xSsE"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 0D64A1D0020B
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 06:56:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 19 Aug 2025 06:56:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755600971;
	 x=1755687371; bh=O2jBG2Oo42ZS12RFRZ6I9FXy9/wpKDv3XJWth1N6OEE=; b=
	lom+0TvkJbKO7XMv1R9OvicxOMaJLd8X0wAxyOULVFiKD4VKZtTr5l8c8OVsasmp
	qjFFAgWE4yzjqtNSJgEWRZSvUdzweTquHYgJJ+EoUlNpUnDwyfiFGokaukwIk3fb
	DXewfattRmu9dXrFaRs5gpZToFVl78NcvPhtEWLDngVriEROfDUUA1AS2oabJVSr
	tDj2zk9da0AelK4jKHaqhvuk5lUjTFImZewY6SmrJtNImHToCE5GIOoig3EkxhG4
	2ab3YU8dNzAUi3l9VDuktpnu5zuxyITcJ+2vJlxxzTvnpYgnKTf/XlaNGJfV2E6S
	cbbdYzwT7tKOJSAcBQB3PQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755600971; x=
	1755687371; bh=O2jBG2Oo42ZS12RFRZ6I9FXy9/wpKDv3XJWth1N6OEE=; b=M
	DU6xSsEd8o7kzYVa2WocBljWWgR7f9IboX1UkRACfn8HMu0/VN5Nm2NWN41kbQS/
	u4bB/IuunduXEXnoUN+zK3YQjRx5TfBu/5UqYnhO6xTteyD1/bHvCQwi0R9OfAuf
	DGJDWraEQn/0AWVu84mYDzwXZQsRnMIHHLpJSzvrjmEa1RMOYyDqGKDQUQOhidf1
	4cwFy2yszz97ss0A7wLXiTOtsQVBvK8eYWsbBHqK+pf9t4qSI+DiO1/rGRMyIftP
	nZoiiVZO48D8olIZ9joXStv/LQhLCLh8mCgD80niCEbmaTGlcJ4rkBqukX5dlYEe
	95k3QcO7l8K6pDoNVMdHw==
X-ME-Sender: <xms:S1ikaI44esoiq6eEtruf8Au68Z8G_fVHdTt2wrBcYVBbuWYFF9_Z1Q>
    <xme:S1ikaL4T5MfdOxzKlxmpDvUUdQVNh1X4OR7E155Lb6GZ03g3SFYLjQhDyQUEybKaG
    jyv0AHQB-hirSBknw>
X-ME-Received: <xmr:S1ikaA2ddmUBWQfnsX-QkcR8NjcvcRgFppOx2cYVTaqcCUlvlYMYAxJyv8tlX67gRlFbx90_nbhnLNCDemU3SA1P6MCGbSTAfXG9a9ZP7TO8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheehfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:S1ikaPWBu3MB7u9AMZSx2CcvG4TPATJxo0jqoj8Qy2ls2jgJ0QHsnw>
    <xmx:S1ikaD5gH8MypFFMGyymwbu0OCP0Zrj9nGaXDhFXqFjX103hDWPrag>
    <xmx:S1ikaOK3-tCuefbqB1zFbO5ic6g33iZDoZIgc81oFwbMRO_yeSoGyg>
    <xmx:S1ikaML24JS-1KiaLWHh5o7ohYq-3gJBchNZK4OvgPEtjBFKHzygHg>
    <xmx:S1ikaCQOz27yuyuHchEg8WnkpKn6FfZcEU-_qayvz91EGMFqjb8Bw44j>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 19 Aug 2025 06:56:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6376a774 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 19 Aug 2025 10:56:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 19 Aug 2025 12:55:59 +0200
Subject: [PATCH RFC 03/11] cache-tree: allow writing in-memory index as
 tree
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-b4-pks-history-builtin-v1-3-9b77c32688fe@pks.im>
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
In-Reply-To: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The function `write_in_core_index_as_tree()` takes a repository and
writes its index into a tree object. What this function cannot do though
is to take an _arbitrary_ in-memory index.

Introduce a new `struct index_state` parameter so that the caller can
pass a different index than the one belonging to the repository. This
will be used in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/checkout.c | 3 ++-
 cache-tree.c       | 5 ++---
 cache-tree.h       | 3 ++-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index f9453473fe2..43583c8d1be 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -902,7 +902,8 @@ static int merge_working_tree(const struct checkout_opts *opts,
 					   0);
 			init_ui_merge_options(&o, the_repository);
 			o.verbosity = 0;
-			work = write_in_core_index_as_tree(the_repository);
+			work = write_in_core_index_as_tree(the_repository,
+							   the_repository->index);
 
 			ret = reset_tree(new_tree,
 					 opts, 1,
diff --git a/cache-tree.c b/cache-tree.c
index 66ef2becbe0..029ec933abe 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -699,11 +699,11 @@ static int write_index_as_tree_internal(struct object_id *oid,
 	return 0;
 }
 
-struct tree* write_in_core_index_as_tree(struct repository *repo) {
+struct tree *write_in_core_index_as_tree(struct repository *repo,
+					 struct index_state *index_state) {
 	struct object_id o;
 	int was_valid, ret;
 
-	struct index_state *index_state	= repo->index;
 	was_valid = index_state->cache_tree &&
 		    cache_tree_fully_valid(index_state->cache_tree);
 
@@ -723,7 +723,6 @@ struct tree* write_in_core_index_as_tree(struct repository *repo) {
 	return lookup_tree(repo, &index_state->cache_tree->oid);
 }
 
-
 int write_index_as_tree(struct object_id *oid, struct index_state *index_state, const char *index_path, int flags, const char *prefix)
 {
 	int entries, was_valid;
diff --git a/cache-tree.h b/cache-tree.h
index b82c4963e7c..f8bddae5235 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -47,7 +47,8 @@ int cache_tree_verify(struct repository *, struct index_state *);
 #define WRITE_TREE_UNMERGED_INDEX (-2)
 #define WRITE_TREE_PREFIX_ERROR (-3)
 
-struct tree* write_in_core_index_as_tree(struct repository *repo);
+struct tree *write_in_core_index_as_tree(struct repository *repo,
+					 struct index_state *index_state);
 int write_index_as_tree(struct object_id *oid, struct index_state *index_state, const char *index_path, int flags, const char *prefix);
 void prime_cache_tree(struct repository *, struct index_state *, struct tree *);
 

-- 
2.51.0.261.g7ce5a0a67e.dirty

