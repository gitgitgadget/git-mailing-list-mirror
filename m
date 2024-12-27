Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2621F1312
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 10:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735296441; cv=none; b=jDutKM06XIzy3PozYN3YiNj+AfuR91NvC5J4MJ6ABVqsibgom2gdFFflzgvGPsfAvC8JuMMoRc+EvrdFH3htwuEEhXhkPHyTpovEz5oP5Z2mQdVL1URQTYj1djkLl8ibopx13Hbi4MENyD3f2DpQhpjbZpKJ3AAtuEphqcGH6nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735296441; c=relaxed/simple;
	bh=pG3ygjWkFhmo5PuIIs8Oua2uMij7ZmBasJFturr/df8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nIw1uL1vcBwAytw5/4vhefbvid/MeadnR+Z2AVimGUqOsjIvfCLeJ+uLKQpvk+jcfsgi3p+m8EeQiUMzuFqjSIxL1c0xK6sscnRKIQSFvSlthrL7TD1g6FmcuG53X0HbRqrq9g6W26lCQMiSWrJPWA6NL2plxAm18JccZrnJV3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cFR33usH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rM6O2Efz; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cFR33usH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rM6O2Efz"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 02E151380141;
	Fri, 27 Dec 2024 05:47:19 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 27 Dec 2024 05:47:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735296438;
	 x=1735382838; bh=awPmDc+rxS03qd5ZqvaQya5fYkUudIBSx8ZpHtV/AFo=; b=
	cFR33usHK4npEjsx7bhlyzq1e9rJLwTNzfgoo4eWrX5IGKaLipsRzMzcoiPQDVdj
	1yow6tgL8bZkGqh945UI3R+2zjzKpNf5/Yv5xZvI4pdA4NYxjID0sPN6jdByyrXn
	8/WGkuMPvbHarmS1XEMXTd6BDhksd3GZ+CiRl5usuPnp1fr5Hrtk5CjORBGL27xv
	IoItgC14u7Lw+tbS7zHFLE8X59N6iIZzjrCJ+CSZQg18PkhbKs/m1gJ0DL0VmZ2I
	CMXX7OmFlVcPFaDfUlAxDUfrVCpVEjizKvdSDV4XaVWda0YdWyP0y5mAbhUc+4m4
	uDNOmN9cJPsvrDOIWdLwKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735296438; x=
	1735382838; bh=awPmDc+rxS03qd5ZqvaQya5fYkUudIBSx8ZpHtV/AFo=; b=r
	M6O2EfzU7cmFJ5XSlUKBYUkkqYoXpUaWWMuSwUq0rucnCMvHzqCLSlQcn3gedI0R
	3W0m9FOo0/iHqfbedAN9wBf0tnvjo7HGqsHiWGt/SM1B9di4QSmXDpHoZhwvF3Qm
	1r6m/fjFrsXQzUfaG5EofQpTSKYankuwSQRh3AThr6CQ14pfTps3/HHUt/bKXUua
	ik/6Xt6AgZp3UfMLH5cdn+U4dbj0Lbd1DBqxqTEqWQmwLMIT8dnYD3zFvKZejjs2
	sKjq6+xL3zoocQairPaHDPqibiZP7sbhq9QxULl563jTCL80hZVTGDzMMtf+kIzS
	x20lgF88BD2KaStAscGqQ==
X-ME-Sender: <xms:toVuZ--JS0CCuHmoTBz_oTIHpBk99kbQ_LVSV3tthP5ZhHUa5XlzLg>
    <xme:toVuZ-uQYPCPDo9p_JaCjJmJfBDL7__S3pvHV6pAmG5ml1UmTXJDlpcATQ88TwW2i
    FquSvXDX0Q2GlyyXA>
X-ME-Received: <xmr:toVuZ0AuVXUZIl_JSeYDtKdnhQ5C2vJZOGNwvCTPA2mnLR0TEXMmIfC5W2HBJxNA757b3OUSorZnyaZ_j-AsXqItFTdjMMTkmRevJzmAZBo-iw>
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
X-ME-Proxy: <xmx:toVuZ2edteSLZQlbOUborxlORWDJe-pVhrAotM0hpWgYTXZq7-k-vA>
    <xmx:toVuZzNT9jWMIvArAJjPSXrVNUeaRaH-Gqlf6qRxVq_hzoMQD8E6-g>
    <xmx:toVuZwnbi7aq8qwSy1ilm2t9QRYQ-KUwWrWi0Kl3_1NFmsSS-MUDOA>
    <xmx:toVuZ1vqP41YsdzklXFpoPtx0_LF5Mu8yXdSJak8NZlWCNjUwrP21w>
    <xmx:toVuZ8Zzl2LEyVg1ITcu7Y2-7Eks1Y_36re7zq6vYeH9uDhRBAqwcpAl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Dec 2024 05:47:18 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 347534c8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Dec 2024 10:45:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 27 Dec 2024 11:46:22 +0100
Subject: [PATCH 2/9] commit-reach: fix index used to loop through unsigned
 integer
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241227-b4-pks-commit-reach-sign-compare-v1-2-07c59c2aa632@pks.im>
References: <20241227-b4-pks-commit-reach-sign-compare-v1-0-07c59c2aa632@pks.im>
In-Reply-To: <20241227-b4-pks-commit-reach-sign-compare-v1-0-07c59c2aa632@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

In 62e745ced2 (prio-queue: use size_t rather than int for size,
2024-12-20), we refactored `struct prio_queue` to track the number of
contained entries via a `size_t`. While the refactoring adapted one of
the users of that variable, it forgot to also adapt "commit-reach.c"
accordingly. This was missed because that file has -Wsign-conversion
disabled.

Fix the issue by using a `size_t` to iterate through entries.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 commit-reach.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index e3edd1199529792fafbaa03999c5b7b202f7cf1b..e65872617003d0e43776909c30343f091d6b42f2 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -42,8 +42,7 @@ static int compare_commits_by_gen(const void *_a, const void *_b)
 
 static int queue_has_nonstale(struct prio_queue *queue)
 {
-	int i;
-	for (i = 0; i < queue->nr; i++) {
+	for (size_t i = 0; i < queue->nr; i++) {
 		struct commit *commit = queue->array[i].data;
 		if (!(commit->object.flags & STALE))
 			return 1;

-- 
2.48.0.rc0.184.g0fc57dec57.dirty

