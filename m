Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C81B264A9F
	for <git@vger.kernel.org>; Tue, 20 May 2025 09:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747734800; cv=none; b=jMV2Drtd08oxgKnWfITAyUWRNvVOaai4pZUM35xvhKS0Jb6wEvNN+o1P19aMWVh+esxpTm/6wjeS6yXWs8w1VlaqpY415F3czHbznq9uDwrXW5YduPSvH4UWAa/UKmp4G06txK0vFrRoPm4mmMb2Yq2MKU9qh3Z6hM2v9VIynBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747734800; c=relaxed/simple;
	bh=okV+LJ+w2y37CbwqXJFlbQvYsSANHSFE8qPRNzn/CMI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SotmukhNdt0oy7r8PmZ6pdGFPYlYf4kBFcglTVnVFkTHPYa5Z2dPcH0jAMMM6sv5TwnLkIbX/IhbtRO7rKVpm9324GvTmMr8hKUOReHqlISRmQWt4kTlpo9JU8m6oROvKlpBFMM2bKRkbUAKcMxCg77Qm51wiNXwWfekBWNjS/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bl4NQCRD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d+Q/rmvJ; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bl4NQCRD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d+Q/rmvJ"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 915D0138044F;
	Tue, 20 May 2025 05:53:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 20 May 2025 05:53:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747734797;
	 x=1747821197; bh=mB65FbOU5CjtpOx6UQ1O8MwSWqWS37VFSo1AfM3cM38=; b=
	bl4NQCRDaRJfx1l8j2eKL/F8DFzg73EI7b2NvLpTw5OUZF2M+WVVkSYYF3FlVwk7
	aTvjOdg5+j9pxayaOtLW5XGCNuvHZI7Uta3gdIWIeFmXFasLhALNhvC+PIXyl7VJ
	rONz+t+6QDLus6JaHlavmbREPOSntMNsa+iJGFm4JgRdTau+go8/SgaGxxVwMNPS
	uXF08lW3crN5hsrMThELmawUwlsBlxbXaJPcpCSXWModDJPWlJeVQHfnERqkyw1t
	GmMUvSRUdQr8Pww+3CGz+YlHBKJW8NaVJA0iqrrmp8WALhWvuKLru66iXQhno4Ak
	55X26cM35ysmbHgpjHhqMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747734797; x=
	1747821197; bh=mB65FbOU5CjtpOx6UQ1O8MwSWqWS37VFSo1AfM3cM38=; b=d
	+Q/rmvJh9L8+Y4nLsiFmuvGTbXBAlt58DziTMj2iU0CulFzMN5bb0E+z/0y9E06/
	TBsMPJk3fF8zexLpPrBtNkhD3zWfokRzRhvK2L3fe4fZMv5+Hlk9pOIv7DZjVvUy
	CtgzI38fSiVIb7F7izqpNygLOn77eEaBzRpa4F6TYW55ibochIa4Yib7gjTYaL4f
	2SKdwP5CwA2NHtJyqqwTkTv5U5rqglFZyRvt6UKZieMPU0PSH7V+8FgHZxV7xzzN
	vYXUpHE0VBMxeVOHYrW0Axg0mFfo4+xsH8+nOQPZfmZt086WR3pYneQljN9W5qQ9
	LkSvOjKTwRthSHaYOXaCg==
X-ME-Sender: <xms:DVEsaG6heUfRN__SaN9sDvUX8_KTtaxho01wa19ffVDRt1pOjVCiXA>
    <xme:DVEsaP6rMDN5ea_ktoE-bJ3F422NKxHS9ftEgXb3kgAxrM5y9O0R1kN0U6D9igZ0n
    V-GmE1wfmKEvW7H7Q>
X-ME-Received: <xmr:DVEsaFfHx08rVjTUhFOr-lGgzXV01KK5g5mecAA0jZKKbxEPWAtePKdw7lRJfdr4Y1yFg3tt5DdS27sl_gZX7boBbVjZLyHvt-3aTffoEXM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvdefleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgv
    fhhfsehpvghffhdrnhgvthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:DVEsaDJ2P_AiSCXG2t1yI1qcltPmnkd3dmPsCoD6CbxCcZAh0Hd94A>
    <xmx:DVEsaKIDkt1k_of6y_UqGwdLHiWOzuPErGhsJ05UM09Lt2xRLoKyRA>
    <xmx:DVEsaEy0rdwAztfqPm1pcNmuPmvV-rthmSK7WW8PKEQbMNUSlFF9cA>
    <xmx:DVEsaOKdn5b321LjnX1G5kv8HmXnazmLBloaHv5Wd2O6vpdOzUOAxA>
    <xmx:DVEsaNUartm24p8iJoPBJHN9sdAeNQgqCasDMlgFUHegWH-5NTEneQf->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 May 2025 05:53:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 66cccb39 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 20 May 2025 09:53:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 20 May 2025 11:53:09 +0200
Subject: [PATCH v2 1/2] packfile: explain ordering of how we look up
 auxiliary pack files
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250520-pks-pack-avoid-stats-on-missing-v2-1-333c5217fb05@pks.im>
References: <20250520-pks-pack-avoid-stats-on-missing-v2-0-333c5217fb05@pks.im>
In-Reply-To: <20250520-pks-pack-avoid-stats-on-missing-v2-0-333c5217fb05@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

When adding a packfile to an object database we perform four syscalls:

  - Three calls to access(3p) are done to check for auxiliary data
    structures.

  - One call to stat(3p) is done to check for the ".pack" itself.

One curious bit is that we perform the access(3p) calls before checking
for the packfile itself, but if the packfile doesn't exist we discard
all results. The access(3p) calls are thus essentially wasted, so one
may be triggered to reorder those calls so that we can short-circuit the
other syscalls in case the packfile does not exist.

The order in which we look up files is quite important though to help
avoid races:

  - When installing a packfile we move auxiliary data structures into
    place before we install the ".idx" file.

  - When deleting a packfile we first delete the ".idx" and ".pack"
    files before deleting auxiliary data structures.

As such, to avoid any races with concurrently created or deleted packs
we need to make sure that we _first_ read auxiliary data structures
before we read the corresponding ".idx" or ".pack" file. Otherwise it
may easily happen that we return a populated but misclassified pack.

Add a comment to `add_packed_git()` to make future readers aware of this
ordering requirement.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/packfile.c b/packfile.c
index d91016f1c7f..933036e2606 100644
--- a/packfile.c
+++ b/packfile.c
@@ -737,6 +737,17 @@ struct packed_git *add_packed_git(struct repository *r, const char *path,
 	p = alloc_packed_git(r, alloc);
 	memcpy(p->pack_name, path, path_len);
 
+	/*
+	 * Note that we have to check auxiliary data structures before we check
+	 * for the ".pack" file to exist to avoid races with a packfile that is
+	 * in the process of being deleted. The ".pack" file is unlinked before
+	 * its auxiliary data structures, so we know that we either get a
+	 * consistent snapshot of all data structures or that we'll fail to
+	 * stat(3p) the packfile itself and thus return `NULL`.
+	 *
+	 * As such, we cannot bail out before the access(3p) calls in case the
+	 * packfile doesn't exist without doing two stat(3p) calls for it.
+	 */
 	xsnprintf(p->pack_name + path_len, alloc - path_len, ".keep");
 	if (!access(p->pack_name, F_OK))
 		p->pack_keep = 1;

-- 
2.49.0.1151.ga128411c76.dirty

