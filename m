Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284C319DFA7
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 09:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727775754; cv=none; b=iD86cFJx574D+wO+yOztnXgM6t6GdP/KBsYlES0C1LB+fAEl/xM1flEm2eax1jmUOkv2s/PmDnJqZvBPCsBvsRBl7tWBqdlWRlkgbZYLRdNtbjtEZw4barrVDXsdw0yIsvjJCpf87ceewIaQeSaYSVMLt59fbVae+WMDMyKJzA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727775754; c=relaxed/simple;
	bh=vV0AsLiyRRy9aJacPjNjqGAPQUnFNugOVkPW5R/4AgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rq5VPsK28vW1pwjPJP3/geBJ1zX5RfcG4xjjZ6MuhlMbJpUqKTeLVqLwrEYtWx2wXiW4mVeOVGIa2o1XUXmEFIGHwPZ+h8NUHToAs8erXdKOSgUb6tpRbky6dfn3RMBXT66Jl6UfdEkx+LJBz6CSUEFQBdEwYhWzMFZX9N2Vv4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=i7xV2Hb/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gWbBcc+U; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="i7xV2Hb/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gWbBcc+U"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 60BAD1140F11;
	Tue,  1 Oct 2024 05:42:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 01 Oct 2024 05:42:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727775752; x=1727862152; bh=xD9RQLoIJ4
	TVbE8oPxgkWYjBzZfkkgReWNVwOJFNAVs=; b=i7xV2Hb/QMoUkzcbJvcQSc46eB
	DyN5vZWgJcZouIUjAw8vJtPIUdJluv6aVe5h5MAU/7otRu/K5RJPAfcbTPjfUE4G
	AYObcQC+LWZjQWb0njMQ/K1lgQA9BesmSm0B6Q61uy5Lm67AniI70UNpHeL7YciZ
	diRBT8e7DwM7p5uKl+y5SkRIEpxOzni85x8qPNNYuZXfcB4f/j0IvoFHtvh4a3XQ
	7BsLwSqD+bTBmHoU/2Evr87pztiVb7YUY9PyNyvilBC6m37pmkoNo5gtiKBIFT6s
	+1OMKypTxWjqlVoR3aO4D7RofXwaGvPzTLe6l9oU7TH/BxNv/cmpjAohxuqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727775752; x=1727862152; bh=xD9RQLoIJ4TVbE8oPxgkWYjBzZfk
	kgReWNVwOJFNAVs=; b=gWbBcc+UP7oBVFMHZdsgG/e6Kl32SkFe9gUfrYpU898N
	xg0KM8SsvJq6gOH5SD7k5ClLn9J9TT9bi2TgmuAGTCjEnsh9PM7EShRn56ADHise
	/K4Tnlb5PN7GQ//R2AWgZ9Ro6P6jr/7DB8eRwxC7sDlldMRDHnzOaaFjwS/Ae5Mp
	FNPhCq3bMqlc/aqaONAZUitCKNGBf1fXexF1eWFb6BWD6brtqDWp/wZTFxXsB489
	m439Xgzw6DS+lpz2XZY41IlnV2j8chyzeh5Tya2sw7CtidsEDe7k2D8QtMljrvsa
	IRb+ob8l8CZSjFZqqyw4aTWtVpAIBsoW5JgKPWCl8w==
X-ME-Sender: <xms:CMT7ZulpLtocoHNXji39o7KcqC6EFuDz-ps90V21CUXr-pfiW3pP0w>
    <xme:CMT7Zl2KrJEwosZw9C9TjMbBs_mALvVsIStZAHfblpWe8nw71PQvtmMQYXy_tkHsq
    iJz-VCe__oPvc2lAA>
X-ME-Received: <xmr:CMT7ZsrP4jWn1VRqSoKUZ5j6RmQYdY3im4mkdBSLKQJcbflZk4JixMhyJKc_ncxulWKHU9QyUNzFwZ2UbThxZA0rtacVE6UU4IjWZZq1B9B4Ug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddujedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhdrshdrrh
    esfigvsgdruggv
X-ME-Proxy: <xmx:CMT7ZilhXbcZ0i_2HlPTVAJD9EatNYz240W3mifFLWtuJ-S2kDgvyg>
    <xmx:CMT7Zs34HFROF9s9dU_I0pXjQKC__noesvCxrFYOW2I1bfqdru2Dzw>
    <xmx:CMT7Zpu5wHt9ZN14uvypKHI3c-g6qv4ffAhtrY3BkEhz3UOfgRx8NA>
    <xmx:CMT7ZoXaUc8b2fnIfUhMpzU2DarqPYJpUj9MLDPE-vjQ6b6i2WeFnA>
    <xmx:CMT7ZvRUcBXACdgePI013qwkYRXexNmU30D0plhX3L8VTumL5VemnvLS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 05:42:31 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 32bcb830 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 1 Oct 2024 09:41:43 +0000 (UTC)
Date: Tue, 1 Oct 2024 11:42:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v4 15/25] reftable/stack: handle allocation failures in
 `stack_compact_range()`
Message-ID: <6aaae4baa6ec9bccf8f8e8a517dcebda995b65b2.1727774935.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727774935.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727774935.git.ps@pks.im>

Handle allocation failures in `stack_compact_range()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 1b77c9d014..2e6dd513d7 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -1131,6 +1131,11 @@ static int stack_compact_range(struct reftable_stack *st,
 	 * from the point of view of the newer process.
 	 */
 	REFTABLE_CALLOC_ARRAY(table_locks, last - first + 1);
+	if (!table_locks) {
+		err = REFTABLE_OUT_OF_MEMORY_ERROR;
+		goto done;
+	}
+
 	for (i = last + 1; i > first; i--) {
 		stack_filename(&table_name, st, reader_name(st->readers[i - 1]));
 
@@ -1312,8 +1317,18 @@ static int stack_compact_range(struct reftable_stack *st,
 		 * thus have to allocate `readers_len + 1` many entries.
 		 */
 		REFTABLE_CALLOC_ARRAY(names, st->merged->readers_len + 1);
-		for (size_t i = 0; i < st->merged->readers_len; i++)
-			names[i] = xstrdup(st->readers[i]->name);
+		if (!names) {
+			err = REFTABLE_OUT_OF_MEMORY_ERROR;
+			goto done;
+		}
+
+		for (size_t i = 0; i < st->merged->readers_len; i++) {
+			names[i] = reftable_strdup(st->readers[i]->name);
+			if (!names[i]) {
+				err = REFTABLE_OUT_OF_MEMORY_ERROR;
+				goto done;
+			}
+		}
 		first_to_replace = first;
 		last_to_replace = last;
 	}
-- 
2.47.0.rc0.dirty

