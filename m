Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5601C241686
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 08:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754553894; cv=none; b=D9jmJ+UuiQXmg2UQu5RRkwZ0EGbYAGwVT54F/t+j55Ne2NcZiYzl8GKr/pHojd+qzLPRa+MOprhGajFwvCClH0ZzWEYXSAP8RAGuDpmwfFIISa3ZKaM1asgqwjp9LOHp+ykWuAlcDw9Om1rjLGGMXdN4ZT85SsJuIhFy32sFrms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754553894; c=relaxed/simple;
	bh=WPFnPmnogIyhnaptDXUF7c9AKkSQALsdM4B/Ua3uYOc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=Mi7/qZNgLjLqHalgTOwQz4pbFN7a1c60WicCTxiLAvgLSjew11mQAj2HHplgnWbfWFiraU2+tRwSTu5lu2adS7mrWYDH9DXorF6vrNA8rLDDK3+Lsf8pntkDrbddJ8LMcMiAdllNTa+VjefJOqpwrVjKi9gHi8LcmnqlPrniXP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=W0RhV2Ok; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cBeY5NX3; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="W0RhV2Ok";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cBeY5NX3"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 4927DEC0015;
	Thu,  7 Aug 2025 04:04:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 07 Aug 2025 04:04:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754553890;
	 x=1754640290; bh=YMJwc3TPAdpmNY32htEURoKc/9gEv4CGFiVvJ7faAuU=; b=
	W0RhV2OkGtI0d1hRF12c1CWefeVUGUPr88sQa8VX+zLXpgnOU1to/7Fs/3gMGMMk
	fc81Mn1lXsiyRRWKQDs5bLJhdtnb+z9vV1Uk2fXzKulkxfp4bBuRp/p2fgQ7grix
	Bz3klU4WA9WSOaAfQG/DBq+IMTH+LbinKLeC10vzlWzgdJJoBDMPP9SRmsGMZ4mm
	c9Tfh2PV5+m6Bep3TtjtkkX/096sHgqOBfTKiHZbbGVDd/d/zYDsRDZ/uCiyCdYh
	Ol3EzEoWYs47JTKMsye1femQcNpac8cMhQkQX3VWHSD4cPEJqR5CdVrgMyq3qX5+
	3bcqjt2vFtChPLP6oxJc9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754553890; x=
	1754640290; bh=YMJwc3TPAdpmNY32htEURoKc/9gEv4CGFiVvJ7faAuU=; b=c
	BeY5NX30N1M0HrUvgwSWQJ//SWFPjVYVBXMIKbFFGnletnI0Om48ma2vrQuHbx6+
	r5GOFDrCJTU/Qjy43Nr0b78/VV7APgcjssJDq+tTd0VgDRgQaKzChafWfllGFw1A
	wQuqoppDXSZeXrZQS1vQyoTxEOYZVCuwmk8H+A2B76tpTp/y24N7qSI3bBcBB2eF
	M32BF2/btMXhiNw1mSQWXgvNVNhnCRJnMVMnx5zbi0p0tDq56jsp0HEb9aL5zHNO
	tyIOeO05XmWvnCRhHWrm46a7WRe5YuHCM/SUSTNRtZHtKsxO1mLKD9XeigfIFd8Q
	R+iI+yD2bfQtF8L2JejAw==
X-ME-Sender: <xms:IV6UaCnwMnm_j0egoHLBJzAG2z98TRHEDcwF9wbteGTDazLZKvwOgg>
    <xme:IV6UaFWqU_V-B95UrZdll3gB48auJZDMJ-Y3-druUFhrUrAe6Imxj5QpCAAzEafpb
    a8T1L8SKi_glCUnVg>
X-ME-Received: <xmr:IV6UaHEOpeE73evaiFzfTi9Oc9Ugex3z649ZK5actk-8MsnoVFxZC4-JzqOr0uNjeoK4yGgolDaAddC58XvNG8s51StmYFPVyfnqqa4jnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddtgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedtheefhfegffevgeegtdfhheeuvden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    hedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohep
    ohhsfigrlhgurdgsuhguuggvnhhhrghgvghnsehgmhigrdguvgdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtohhlvggvsehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:IV6UaBdpguH3js-FdbjOoU1Cu2GNOTQEwvQvVJ9zJAnVfa5SV77Qjg>
    <xmx:IV6UaILCIQZh0ULeIShJfnYhDeVjmC3pRyD2sYEUpChLjle_LG1L8w>
    <xmx:IV6UaGHlMVNnLzt8J4UDAajJk8xZ5dy6hbQRC95t6Tl5LBtxqD0Y0w>
    <xmx:IV6UaLARMct_sEa9X-D4cOfl_aaazRsxaWf_uaMpH98D_IOCWW5Bng>
    <xmx:Il6UaFHLpRIWjLpr1UWUBK6KEb_HvLRJHs0mFsoGyVmZ_-_pkuhEswbu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 04:04:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 23cee6fc (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 7 Aug 2025 08:04:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 00/10] commit-graph: remove reliance on global state
Date: Thu, 07 Aug 2025 10:04:42 +0200
Message-Id: <20250807-b4-pks-commit-graph-wo-the-repository-v3-0-82edef830a1e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABpelGgC/42NQQ6CMBBFr0K6dkxboFRX3sO4oGWkEwMlLUEN4
 e4WTIxLlm8y/72ZRQyEkZ2zmQWcKJLvE+SHjFlX9y0CNYmZ5LLklajAFDA8IljfdTRCG+rBwdP
 D6BACDj7S6MMbRGOlra2xGnOWXEPAO722zvWW2FFc/7bsJNbrt6B5sbMwCeCgS94oqdBI1Jc0O
 lLHVv0k/5Vqr1Im5UkIU6PKNSrxUy7L8gFzKq/KKgEAAA==
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

Thanks!

Patrick

---
Patrick Steinhardt (10):
      trace2: introduce function to trace unsigned integers
      commit-graph: stop using signed integers to count Bloom filters
      commit-graph: fix type for some write options
      commit-graph: fix sign comparison warnings
      commit-graph: stop using `the_hash_algo` via macros
      commit-graph: store the hash algorithm instead of its length
      commit-graph: refactor `parse_commit_graph()` to take a repository
      commit-graph: stop using `the_hash_algo`
      commit-graph: stop using `the_repository`
      commit-graph: stop passing in redundant repository

 builtin/commit-graph.c       |  13 +-
 builtin/commit.c             |   2 +-
 builtin/merge.c              |   2 +-
 commit-graph.c               | 371 +++++++++++++++++++++----------------------
 commit-graph.h               |  25 ++-
 oss-fuzz/fuzz-commit-graph.c |   6 +-
 t/helper/test-read-graph.c   |   2 +-
 trace2.c                     |  14 ++
 trace2.h                     |   9 ++
 9 files changed, 227 insertions(+), 217 deletions(-)

Range-diff versus v2:

 1:  16f0fd6fb4 =  1:  a652405a05 trace2: introduce function to trace unsigned integers
 2:  53f12d827b =  2:  16a02e5dc0 commit-graph: stop using signed integers to count Bloom filters
 3:  f8d920e132 !  3:  0cbd808dab commit-graph: fix type for some write options
    @@ commit-graph.c: static void split_graph_merge_strategy(struct write_commit_graph
     -
     -	int max_commits = 0;
     -	int size_mult = 2;
    -+	size_t max_commits = 0;
    -+	size_t size_mult = 2;
    ++	unsigned max_commits = 0;
    ++	unsigned size_mult = 2;
      
      	if (ctx->opts) {
      		max_commits = ctx->opts->max_commits;
    @@ commit-graph.h: enum commit_graph_split_flags {
      struct commit_graph_opts {
     -	int size_multiple;
     -	int max_commits;
    -+	size_t size_multiple;
    -+	size_t max_commits;
    ++	unsigned size_multiple;
    ++	unsigned max_commits;
      	timestamp_t expire_time;
      	enum commit_graph_split_flags split_flags;
      	int max_new_filters;
 4:  12d8d8f087 =  4:  8c1e6dc24c commit-graph: fix sign comparison warnings
 5:  c7fc957de1 =  5:  9b0c61d221 commit-graph: stop using `the_hash_algo` via macros
 6:  d41c5a419a =  6:  41e2e742ee commit-graph: store the hash algorithm instead of its length
 7:  fec6cf25c7 =  7:  06dc3545fe commit-graph: refactor `parse_commit_graph()` to take a repository
 8:  6a3ba128c2 =  8:  e06517c3a2 commit-graph: stop using `the_hash_algo`
 9:  c2e549b474 =  9:  0f10e272bb commit-graph: stop using `the_repository`
10:  59a325475d = 10:  e00dc6651c commit-graph: stop passing in redundant repository

---
base-commit: e813a0200a7121b97fec535f0d0b460b0a33356c
change-id: 20250717-b4-pks-commit-graph-wo-the-repository-1dc2cacbc8e3

