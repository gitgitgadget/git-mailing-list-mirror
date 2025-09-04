Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C29E80B
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 12:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756990206; cv=none; b=PmyqyPMtJus6vmKuxoh/YQMnNKqZVWYk3DCZKJomGoB1J/DeB9M1eo18xVOqldeyzTpEYPt0/oapYfjrd69oSN9+EncX0fvVExpM3U6xt+IRZxSYPe2xDq9+PxFebIo0DmxmYwKanE/XJIvu6QJ2bd8a9X0WIKOTblB8c1I/yi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756990206; c=relaxed/simple;
	bh=VbG7YPuKynlBrUwj1vTZL6HuOa8BWT5uXkRmReKLbH0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WNRvChxqx5Zj3qe3GGUpvilzL2RKkvJ3Xd/ynMzLvJYbZMuVBRjHvZrIh2rublOUzTC2gXcSVjlbFgglhjKFyCabIivZFKe0HABPulgXJYrtcaxCLDhjtRRAVUp5aEozNdxiwPk27IjMpvJEIDaCr65jwZXbtUD8YJPBae9LfYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=crz4WUvp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h2ZO0Qfh; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="crz4WUvp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h2ZO0Qfh"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 9433F1D002AE
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 08:50:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 04 Sep 2025 08:50:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1756990203; x=1757076603; bh=WPQdSAfrrr
	8rdnPDV+MFNYe+ZftUyg+ZZ0qXV6p/xWY=; b=crz4WUvpONnLbPwaz/MsUiknJ+
	KpRNN08bC646PXeR7pVUjo6BSZhtrEAzdjisoqTXZAM+3SLoY20gCqCLBz/+DsT7
	/Qf2o/a7sZ49nvO9SdKz7po5a7F2A01YLbyrC4wIoWruOQ+b/UwHZ/UmYFZtwyUV
	SXiXbhk3voMU6yjfxdxVdrJIbIuqSfxqsJasyAz+WnlU5ar/SQEdvnERuBlUnSi4
	sbcpguCWvTlUEUG+a2K50K2lji6JrdWe50UsNY6VnS9r+9Ax85k69IBMBQdM/wp1
	1F37vnURZOxCVNCBOfLhPvo0bP8RCg8foPV1iMz3K6kum2QQnH/qH9TCEgXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1756990203; x=1757076603; bh=WPQdSAfrrr8rdnPDV+MFNYe+ZftU
	yg+ZZ0qXV6p/xWY=; b=h2ZO0QfhaOlQIqRfJoA5/Zgez04KZEUy2Yy8kXpg5tL4
	/WPRgwblb8emHr8BOR2Z9kgv2N5amTFLbpYi62RhzP//e8dY5ga6rzthBkMOpFi6
	H44obItupLUCCqsCfcNq0xNONdiubrvgB8g0zkAxb4uOjU4k7nnvIyMMQ71td0wd
	Ga435AaM46ECgWDAh1ttWuL/uFkUZonGhyi/XRKBdvCoSDNSWoBDZSg3/YzGlR/H
	/dDxD/GAqAAp1SCGQfK+di/dugeEYo1VfvkWigJIfHuxW7rh92h0dcPR0cQrmdDZ
	xQ0e0aRkttHEzARxRs1RzbjFOhsHH0+7YLprzkXzYA==
X-ME-Sender: <xms:-4q5aO3Ly366u7m1FIXAlKAgKsBns5CU4PaC4SB21Sbhd1Q5gulFoA>
    <xme:-4q5aDEtmxYYJJHCvbw1r2ZIYwBdX5HKYzGR2uWBFWK8KV1JaT2hRSYadaF-W7ORQ
    HtS0K5oSJ5GwAGWgg>
X-ME-Received: <xmr:-4q5aATFTZo8pzQ_yiMXCxDsWXquOogUJAVOkpsemUI5qRYjzy3JsDVnmKtPRBMuO7hJJL-cj2ewGtZ1Bokv6Jx88qGouv-82BOFajG8BjLDzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhufffkfggtgfgvfevofesthejredtredtje
    enucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhi
    mheqnecuggftrfgrthhtvghrnhepveeugeektdetieegjeeuheeuudfgveelfeevheeuhe
    fgteffffevhfeuhfeukeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:-4q5aCBw80pwnzFLX9qbXv-IRa1sl92-d4uBjsWJK6IdEnDGL9sdIg>
    <xmx:-4q5aI1qjn-W9o3xzhtIOfl5w9hvHs-loZAWjk4r1V-kgtcuPx381A>
    <xmx:-4q5aIUVWdJn5NNf_vUU1eM2OoM82hPaD0UrgZ38mNqYtJ2MYQup2A>
    <xmx:-4q5aClHc57JVdaSn1XRExvGeFD10LBCm1KXRkCJ5QjVu5JA3qic8w>
    <xmx:-4q5aA_dWo_koWB6Nq8WU-7EjhdnCB-jcuAlbmL0aD4zWZyr1QQf-B_W>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 4 Sep 2025 08:50:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6885aabd (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Thu, 4 Sep 2025 12:50:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/6] odb: track commit graphs via object source
Date: Thu, 04 Sep 2025 14:49:54 +0200
Message-Id: <20250904-b4-pks-commit-graph-via-source-v1-0-d932c2481e1a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPKKuWgC/x2NQQqEMAwAvyI5b6At9aBfEQ/dNmoQbUlUFsS/b
 /E4DMzcoCRMCn1zg9DFynmvYD8NxCXsMyGnyuCMa01nPH49llUx5m3jA2cJZcGLA2o+JVLVZIO
 llJz1UCNFaOLfOxjG5/kDS1BKPnAAAAA=
X-Change-ID: 20250904-b4-pks-commit-graph-via-source-b4e1a1edd214
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Hi,

commit graphs are currently stored on the object database level. This
doesn't really make much sense conceptually, given that commit graphs
are specific to one object source. Furthermore, with the upcoming
pluggable object database effort, an object source's backend may not
evene have a commit graph in the first place but store that information
in a different format altogether.

This patch series prepares for that by moving the commit graph from
`struct object_database` into `struct odb_source`.

There's a trivial conflict with tc/last-modified that can be solved like
this:

diff --cc commit-graph.c
index 9929c1ed87,2f20f66cfd..0000000000
--- a/commit-graph.c
+++ b/commit-graph.c
@@@ -823,7 -812,12 +823,11 @@@ int corrected_commit_dates_enabled(stru
  
  struct bloom_filter_settings *get_bloom_filter_settings(struct repository *r)
  {
 -	struct commit_graph *g;
 +	struct commit_graph *g = prepare_commit_graph(r);
+ 
 -	if (!prepare_commit_graph(r))
++	if (!g)
+ 	       return NULL;
+ 
 -	g = r->objects->commit_graph;
  	while (g) {
  		if (g->bloom_filter_settings)
  			return g->bloom_filter_settings;

Thanks!

Patrick

---
Patrick Steinhardt (6):
      blame: drop explicit check for commit graph
      revision: drop explicit check for commit graph
      commit-graph: return the prepared commit graph from `prepare_commit_graph()`
      commit-graph: return commit graph from `repo_find_commit_pos_in_graph()`
      commit-graph: pass graphs that are to be merged as parameter
      odb: move commit-graph into the object sources

 blame.c        |   3 -
 bloom.c        |   8 ++-
 commit-graph.c | 177 +++++++++++++++++++++++++++++++--------------------------
 commit-graph.h |  14 ++---
 odb.c          |   9 +--
 odb.h          |   6 +-
 packfile.c     |   3 +-
 revision.c     |   3 -
 8 files changed, 118 insertions(+), 105 deletions(-)


---
base-commit: 2462961280690837670d997bde64bd4ebf8ae66d
change-id: 20250904-b4-pks-commit-graph-via-source-b4e1a1edd214

