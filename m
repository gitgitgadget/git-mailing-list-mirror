Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789F22FE05D
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 12:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756990210; cv=none; b=rQHStK49eV78qEejI62IyI8hYMCa1+CHm80fw4frFSrGTkMhU0Y4YS82Ph6H6A61ij15EMS8pLPUgpBZHCVVN7L61v/0fCajVPATCzCqBkeMOKOqODCDfCN35NI5OXFVQO8lOvDUmQDvVIjNTgdB9kzUNnb0OBwE3UTGYzYxJjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756990210; c=relaxed/simple;
	bh=5KD4fIJvsL5RODuDUH+tp3ErKjQynRLKEVWv2B823VY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Smusk5gQHM0B4Ti4HMl6xsIdNexYJn3prkMuXf8NJerlL4cEQBzSK7cGOlNhlLg0lRk+TPRl6k10NBccDa4e9X/SuEYwnCe1QI4zjEtdJ73tDEGABWUDJ7/xl9aVqVyK8005koSEiiqvEnpgE2xamJhqKR+bSZQ2iPhV7msgGBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BQO0d4OV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L8parbS7; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BQO0d4OV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L8parbS7"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id AC0A41D0029B
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 08:50:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 04 Sep 2025 08:50:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756990207;
	 x=1757076607; bh=9Bhh9HxRlgUM2ZFsuKHMF7RORcauOOwtUMGEjoLnx90=; b=
	BQO0d4OVJy/qAkSvN28Op5Z1QKWCtc7oYBDC3K/rc8b0Jt9xQ9I0M3Nn9FXxhf4m
	2b7a8fOhTwNw79gc/ZUfHCvzTTRWvfFhOBlJsIXCW8+bx9WOwOijfFpnRlpZtk/+
	kB7+e4tH/C+X/IKxxCB8qATL0WjssIKogNcXu8oDnWvyUXXzxN1oIb70F6Zv3bvw
	hCs+M2E32ju0UKj1OJ0au7j4WZ2zJwJsDSRYdL1+pHqVftbak8qpN6FS9Lt5NOJf
	0QY2DP6DlB0DQwifw13OD9ht926RnCTPyYyyOAJ9UjAxnveXN+fx6+m972zgBsKT
	t+GJQNGc5+HeeeLv4ugusg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756990207; x=
	1757076607; bh=9Bhh9HxRlgUM2ZFsuKHMF7RORcauOOwtUMGEjoLnx90=; b=L
	8parbS7IXw0xmqPrAH1Hkts2x6DBI1rKbfikVofS6GHk2D0KvnGOjMMX8i0Ue94V
	/fIaZYxc3pB691MSDAahwI18JwQUlsjKFY00fxEGqBK2OklmSbjwDhMlQ6AODQG8
	YN8A5KMZhz7Z1ZzsIRkQyzfgMvH3sXs7wON+dPoptET5EDFpRH2u6pf1cxOSyMjZ
	GfnpicuthEUvTyuU0aAxZXwlMANOkJc/ouPEdmoOeW3xGP7ZIiLmexGzSXpOBAyU
	0+TDZLN6NZkCLzjUFm6rUoF95Qqiq/IiEkdtioHj9MhP2oErlcMwyx4pjfIj+tDS
	VkZ660EYMqGTLdiY1WAjg==
X-ME-Sender: <xms:_4q5aFW-vOPFfFHKJ_vGGlMnKVCaUF-CnzApvd32J5IyJEZvxp0voQ>
    <xme:_4q5aHnT2zLiZ3egIlg9cCnbhhF7FTxCsEJHg4sYQ7V_ptJFkJjn95I0wwQh2FgjP
    _HUR7EqcWMsha41bw>
X-ME-Received: <xmr:_4q5aKxBmXHDX8SsOohT5n2sJvASrw0W1ZHJhl1vG64yrAfgkwPJLXESUVAFfEBYHeqYKTQQ2dLwOgJV18fQVVGberxpWv4m2t7BI3IZ0lQ4tw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetke
    duheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:_4q5aKhz9mLCzwJ4Kg6ieVv5L-fuLYPm9MJrhD403N35eBc1aGeSCA>
    <xmx:_4q5aHUbY5_5s96yHn9savQYMCqi5vlEE4spZ3DwEZRfzptw1krusg>
    <xmx:_4q5aE3YuLw4Ph44AXSTwIAD76oqnYzgd61hiJB9O4uzXJipdeqY3Q>
    <xmx:_4q5aFHmmHIK6rsiNlx3SUiNpBMfTv5sW007TTFPdn_Q0bEOm-9Ofw>
    <xmx:_4q5aJfSxUfTqB-OgHQioFG8L1UYz1PD2S_mCtN5Au4j6oIqY8kuYXAq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 4 Sep 2025 08:50:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 336dd0e9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Thu, 4 Sep 2025 12:50:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 04 Sep 2025 14:49:56 +0200
Subject: [PATCH 2/6] revision: drop explicit check for commit graph
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-b4-pks-commit-graph-via-source-v1-2-d932c2481e1a@pks.im>
References: <20250904-b4-pks-commit-graph-via-source-v1-0-d932c2481e1a@pks.im>
In-Reply-To: <20250904-b4-pks-commit-graph-via-source-v1-0-d932c2481e1a@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

When filtering down revisions by paths we know to use bloom filters from
the commit graph, if we have any. The entry point for this is in
`check_maybe_different_in_bloom_filter()`, where we first verify that:

  - We do have a commit graph.

  - That the commit is contained therein by checking that we have a
    proper generation number.

  - And that the graph contains a bloom filter.

The first check is somewhat redundant though: if we don't have a commit
graph, then the second check would already tell us that we don't have a
generation number for the specific commit.

In theory this could be seen as a performance optimization to
short-circuit for scenarios where there is no commit graph. But in
practice this shouldn't matter: if there is no commit graph, then the
commit graph data slab would also be unpopulated and thus a lookup of
the commit should happen in constant time.

Drop the unnecessary check.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 revision.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/revision.c b/revision.c
index 6ba8f67054..6018f30a99 100644
--- a/revision.c
+++ b/revision.c
@@ -774,9 +774,6 @@ static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
 	struct bloom_filter *filter;
 	int result = 0;
 
-	if (!revs->repo->objects->commit_graph)
-		return -1;
-
 	if (commit_graph_generation(commit) == GENERATION_NUMBER_INFINITY)
 		return -1;
 

-- 
2.51.0.417.g1ba7204a04.dirty

