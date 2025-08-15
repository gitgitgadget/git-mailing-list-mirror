Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181641DE3BB
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 05:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755236997; cv=none; b=fo1KqETsc2BfVl/xvZSuToGIyLC3dBdZf/zDnQOP9hKFDX5Bch9VtdcDz8NFCawkwAIiRZS0OxI5z4ZkXtJw8we6S5uxMzKPxm1NAPmVodWcWwSB0D6w0ZLXwFS047XDA/Tzy1R2JXmnvflqWNus/6ZfINhfjzSk590BeAgDJtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755236997; c=relaxed/simple;
	bh=jDJXn6D2/wRrdvP2mv2K7Q9XKvaRP38Cqo/wLeMu9Qw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=B+lk36Fq+dhP90eHjq6cCW9dziRr5XOc0lnCpcZERx8PreIpNezJj2JlsA4+zd0lnG4G9TRuNU2wDRZzlshccGAbAjlrVnfan+VOAXbMvkZVgFihVuSZvYR3lSn/rVk5bmwMz42rdjvVAjS38UJwOWEVQjGLGGJ3RZ8GNsAZc1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Kg8R8q4B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aRbYXzB+; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Kg8R8q4B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aRbYXzB+"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 149F714000DA;
	Fri, 15 Aug 2025 01:49:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 15 Aug 2025 01:49:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755236994;
	 x=1755323394; bh=S8M9NE2qZ89NRebE30xWC1pyf1K2yjHGlgBVTbGmSEM=; b=
	Kg8R8q4BQCDl1Y7mtHdTY2d8Pi0n4lAi7QRh1fEpC+YeDfugeY6vAHO0wcMySLyV
	B9YJ3Un/joAaz5Y9IbnH7Cy3zQ4nYSPU0tD24N3HV4x67i+0u5yP0UC1/P4o3QAo
	pCeRt8TIkr1tleuvhfQJP3+KkNauGGWCCGFyG4NbBMYNvbOCtdXcnuDWjz1VlOb9
	d0kPI7DGFIl9OCeUwmg1YNgZDcDJs45BF+qkvg0qCtI0mLY3LxB4/J2Wz8dFqsgx
	iyfcJXf5KSM+gnasr5L38YV4eX1ACOkGfBZDx6T0qsMcPfFSiRe2Ioa1WybKyJwl
	Qv/dB1Tm5Dwz/JcazZjSBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755236994; x=
	1755323394; bh=S8M9NE2qZ89NRebE30xWC1pyf1K2yjHGlgBVTbGmSEM=; b=a
	RbYXzB+PB/rhgTqF1nx/wGNBHBz4wKlVBE+jN0074wGzNbY6iOvp8wUGeGgRkdcp
	jTkNnYX/l+24+icNJDNzKeAXs+jx7bMtojZhRy0X+NpIoQkTCnI2gQK2kPjqYydp
	KtC0Hzt2j0n/3eik2Gj9HinZBinf2h08C2KK/jvEtSNHIo7LdXufXEimTUyI/JrW
	5tk4NwMnYSL1a5AdsJsE7LE0VUApCXBLpldUx6v1p6FqmhPmXscDxQxGwJGWHlPZ
	AyGVMV5L1r0IL3KdbS2MfHeR7oqLrxnUydAEPLhv2hfv31qvFm07Bsf6PpU/vPzt
	dzov2OVCspYdNcdYLrsuA==
X-ME-Sender: <xms:gcqeaOmUxMJjyIfCFWHy1tcYEoGZdaey58AMNO8ywB01AoCppDmSXw>
    <xme:gcqeaBVQW4NCj11g9Ln4HwY4CHyfofiFiKvfuWSnftZ8zp8pV3D14yT45stQixFwi
    PnSYYoINLyLJRpZnA>
X-ME-Received: <xmr:gcqeaDEh0YZKxo6Vzq6FhdwJFdxDnwDVM9YDkUuKeZrqfiWdwtQnI-n3l8RuHBhmMyU1kUIowqrzzhvdwHXvcBJvYMYcjeeQXbrbIsr5pA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeefudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedtheefhfegffevgeegtdfhheeuvden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    hedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomhdprhgtphhtthhopehoshifrghlugdrsghuugguvghnhhgrghgvnhes
    ghhmgidruggv
X-ME-Proxy: <xmx:gcqeaNfkHpcYopHtCSPtGsHa6D5a4n1YQzxTuclBGaUmRaJ6iikY7g>
    <xmx:gcqeaELz8IVrLMZ9MiPPZ8LBImQJ6VeCC3o37sr8yPlEN_yj8tQzZA>
    <xmx:gcqeaCEnNlXy2YTQXP7-46euQVhMoMjaEwi_I6BRhrHMW8tWAv3aQA>
    <xmx:gcqeaHCQE5eP4_xE_hQjmOW_2MupH1RWkcF3drQf8ndcklf_S3wTrA>
    <xmx:gsqeaCRH_W0Hyk0AHBoWulMSZYdmWeMLjTJL_kXt8HyJGhJx0-XuEDRV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Aug 2025 01:49:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b3d41440 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 15 Aug 2025 05:49:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 0/6] commit-graph: remove reliance on global state
Date: Fri, 15 Aug 2025 07:49:46 +0200
Message-Id: <20250815-b4-pks-commit-graph-wo-the-repository-v4-0-b6b651178cce@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHrKnmgC/43QTQ6CMBAF4KuQrh3THyzVlfcwLkoZYGKwpCVVY
 7i7RROjO5Zv0vnepE8WMRBGdiieLGCiSP6aQ7kpmOvttUOgJmcmudzxSlRQlzBeIjg/DDRBF+z
 Yw83D1CMEHH2kyYcHiMZJZ13tDCqWrTFgS/d3z+mcc09xefeuTWKZfhoML1c2JAEczI43WmqsJ
 ZpjXtrSwBY+yV9SryVlJvdC1Ba1MqjFH6l+ybX/kNRypcQGW6O4Ffgl53l+AaWRyFt9AQAA
X-Change-ID: 20250717-b4-pks-commit-graph-wo-the-repository-1dc2cacbc8e3
In-Reply-To: <20250804-b4-pks-commit-graph-wo-the-repository-v1-0-850d626eb2e8@pks.im>
References: <20250804-b4-pks-commit-graph-wo-the-repository-v1-0-850d626eb2e8@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>, 
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Hi,

this patch series is another step on our long road towards not having
global state. In addition to that, as commit-graphs are part of the
object database layer, this is also another step towards pluggable
object databases.

Changes in v2:
  - Use `unsigned` instead of `size_t` to count number of Bloom filters.
  - Use `uint32_t` instead of `size_t` for number of commit graphs,
    as this type is also used to iterate through this count already.
  - Refactor `parse_commit_graph()` to take a repository instead of both
    repo settings and a hash algo.
  - Link to v1: https://lore.kernel.org/r/20250804-b4-pks-commit-graph-wo-the-repository-v1-0-850d626eb2e8@pks.im

Changes in v3:
  - Use `unsigned` for commit-graph options instead of `size_t`.
  - Link to v2: https://lore.kernel.org/r/20250806-b4-pks-commit-graph-wo-the-repository-v2-0-911bae638e61@pks.im

Changes in v4:
  - Drop the patches that fix `-Wsign-compare` warnings.
  - Link to v3: https://lore.kernel.org/r/20250807-b4-pks-commit-graph-wo-the-repository-v3-0-82edef830a1e@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (6):
      commit-graph: stop using `the_hash_algo` via macros
      commit-graph: store the hash algorithm instead of its length
      commit-graph: refactor `parse_commit_graph()` to take a repository
      commit-graph: stop using `the_hash_algo`
      commit-graph: stop using `the_repository`
      commit-graph: stop passing in redundant repository

 builtin/commit-graph.c       |   9 +-
 builtin/commit.c             |   2 +-
 builtin/merge.c              |   2 +-
 commit-graph.c               | 283 +++++++++++++++++++++----------------------
 commit-graph.h               |  21 ++--
 oss-fuzz/fuzz-commit-graph.c |   6 +-
 t/helper/test-read-graph.c   |   2 +-
 7 files changed, 157 insertions(+), 168 deletions(-)

Range-diff versus v3:

 1:  26daf74e02 <  -:  ---------- trace2: introduce function to trace unsigned integers
 2:  646805924e <  -:  ---------- commit-graph: stop using signed integers to count Bloom filters
 3:  01e38f39cf <  -:  ---------- commit-graph: fix type for some write options
 4:  a362f63472 <  -:  ---------- commit-graph: fix sign comparison warnings
 5:  041d9c07a0 =  1:  f7083b7e3b commit-graph: stop using `the_hash_algo` via macros
 6:  6c1fa6be4f =  2:  336e35e93b commit-graph: store the hash algorithm instead of its length
 7:  ed04f7b787 =  3:  1446e1d66f commit-graph: refactor `parse_commit_graph()` to take a repository
 8:  1eb6316e8d !  4:  368e5ada3e commit-graph: stop using `the_hash_algo`
    @@ commit-graph.c: int open_commit_graph_chain(const char *chain_file,
      		close(*fd);
      		return 0;
      	}
    --	if (st->st_size < (ssize_t) the_hash_algo->hexsz) {
    -+	if (st->st_size < (ssize_t) hash_algo->hexsz) {
    +-	if (st->st_size < the_hash_algo->hexsz) {
    ++	if (st->st_size < hash_algo->hexsz) {
      		close(*fd);
      		if (!st->st_size) {
      			/* treat empty files the same as missing */
     @@ commit-graph.c: struct commit_graph *load_commit_graph_chain_fd_st(struct repository *r,
    + 	int i = 0, valid = 1, count;
      	FILE *fp = xfdopen(fd, "r");
    - 	size_t count;
      
     -	count = st->st_size / (the_hash_algo->hexsz + 1);
     +	count = st->st_size / (r->hash_algo->hexsz + 1);
    @@ commit-graph.c: static struct tree *load_tree_for_commit(struct repository *r,
      
      	oidread(&oid, commit_data, the_repository->hash_algo);
     @@ commit-graph.c: static int write_graph_chunk_oids(struct hashfile *f,
    - 
    + 	int count;
      	for (count = 0; count < ctx->commits.nr; count++, list++) {
      		display_progress(ctx->progress, ++ctx->progress_cnt);
     -		hashwrite(f, (*list)->object.oid.hash, the_hash_algo->rawsz);
    @@ commit-graph.c: static int write_graph_chunk_data(struct hashfile *f,
      
      		parent = (*list)->parents;
      
    -@@ commit-graph.c: static size_t write_graph_chunk_base_1(struct hashfile *f,
    +@@ commit-graph.c: static int write_graph_chunk_base_1(struct hashfile *f,
      		return 0;
      
      	num = write_graph_chunk_base_1(f, g->base_graph);
 9:  8d599f5a37 !  5:  a51cccec0d commit-graph: stop using `the_repository`
    @@ builtin/merge.c: int cmd_merge(int argc,
      ## commit-graph.c ##
     @@
     -#define USE_THE_REPOSITORY_VARIABLE
    --
    + #define DISABLE_SIGN_COMPARE_WARNINGS
    + 
      #include "git-compat-util.h"
    - #include "config.h"
    - #include "csum-file.h"
     @@
      #include "tree.h"
      #include "chunk-format.h"
10:  41ccdd6da1 !  6:  841d280105 commit-graph: stop passing in redundant repository
    @@ commit-graph.c: int open_commit_graph_chain(const char *chain_file,
      						   int *incomplete_chain)
      {
     @@ commit-graph.c: struct commit_graph *load_commit_graph_chain_fd_st(struct repository *r,
    + 	int i = 0, valid = 1, count;
      	FILE *fp = xfdopen(fd, "r");
    - 	size_t count;
      
     -	count = st->st_size / (r->hash_algo->hexsz + 1);
     +	count = st->st_size / (odb->repo->hash_algo->hexsz + 1);
    @@ commit-graph.c: struct commit_graph *load_commit_graph_chain_fd_st(struct reposi
     -	odb_prepare_alternates(r->objects);
     +	odb_prepare_alternates(odb);
      
    - 	for (size_t i = 0; i < count; i++) {
    + 	for (i = 0; i < count; i++) {
      		struct odb_source *source;
     @@ commit-graph.c: struct commit_graph *load_commit_graph_chain_fd_st(struct repository *r,
      		if (strbuf_getline_lf(&line, fp) == EOF)

---
base-commit: e813a0200a7121b97fec535f0d0b460b0a33356c
change-id: 20250717-b4-pks-commit-graph-wo-the-repository-1dc2cacbc8e3

