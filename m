Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8087E1E492D
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 18:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738347384; cv=none; b=V3GZfGPilwRBwLl2kIvUgiUSWPMsuoLbqoK/sOdPMQbHzSbWUeptOd7HOxP7ztr5zyOMhVVM13RFjCzwbQVyyyYYmR+DIq65B6Ag9YteRK0Ta+mnKk/JM/DITRR8kdW+wVj3iIf0AmN86aL8f+nsVqQR3dymsSC3BhV+xwfWlSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738347384; c=relaxed/simple;
	bh=k05bx69t+UO0bHnvmn9lhjzAB/w2iwRyE8/p67HkwyI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=INtZEHeOCWayEKHmAvUZAJWknOVMQ8L+IVx9j/jPej9bF96xQH3pm8Xg4hGbaTbgztadm5cndRR0o6BFM77qOpwI1QQhg+sZ4ecvccRevQdSN4zR30YVBgr4/WXkRetudaOs9ZmBsEJbWJueKwZdRY1LfwS4x0btbLzACtmD1io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pNJIwPIR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gMa7SewM; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pNJIwPIR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gMa7SewM"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5893C2540103;
	Fri, 31 Jan 2025 13:16:21 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Fri, 31 Jan 2025 13:16:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738347381; x=1738433781; bh=6B0g0BonjK
	9FzEH/40nP0RmO/ZojW+3zb1B8MwquQYs=; b=pNJIwPIRMBjuKMOHVYYRLe+ge7
	r37r9DBVlaw/UwGmOJUuHuQcmXgMN8ib5bWleGowMP1W6bPF0AkwDyLyGdjcpwtM
	SsgiwxDCHi6ioPC8T+jD+yyEp9jt9N9IvMmqhrawE7d0QAotHB1dtGFu7NPcTjWP
	LY/GB4g4/452OW7PuyEtJ2fvmr6RJ+/G9WSIEhSo2fvtYTpIJmh19QGDvLtkGB8Z
	Y8vdwwG3BeZgudBaPLpdLq9VGgJj65Bo364Otx7AIy8cJ9v4j4gEr+cZuxLxg49p
	EAIrKU9nGQT/ZX6u9+IfGZh4mpFbgzHgQow7vC0gcoBvkLvJsNl6wcSHmqrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738347381; x=1738433781; bh=6B0g0BonjK9FzEH/40nP0RmO/ZojW+3zb1B
	8MwquQYs=; b=gMa7SewMbXGAsIwZndNtxEwcMeGUBWcCZE2X0z19SZ8y/praMIT
	rtORbO8K7j165+bbbXz231Nlvz9e1IOnnd1O980yhP5sG0/rOw2fXHFoO45t5h1O
	HmVkMNTlGJU/1JyAxw16EApXFoMRJXslC89KSBwLyzyPi+Se6LOR4LidwWlnKSzU
	M5E/1r9B1leqDhKVFQpVWyKze+MEsVYsiA5YqsP5AaFhC4NQT+zKXXny1bIKnmEY
	YmJJyuXo6d+/p0LyzcCHflKSTr0E/WH3dfx6OIxmq08m3qJwE5iy1NJYq3AIjxmC
	s9J6lZTQ81YyZfW0DXNwa6Vpus7xhYSiaEA==
X-ME-Sender: <xms:dBOdZ8j0wODpTRJjo_NG09uJDmzu2k1BG9QCQY7sWuJy6HL9a6J-Gw>
    <xme:dBOdZ1AFam4rxVwEWEp7lt5R2snNq7xJWhGVoPeN9xjnqJJlBoJGc7ucrXPq7z6ba
    wdmoyPK4z1SebcVCg>
X-ME-Received: <xmr:dBOdZ0F7CoE-fymtCK5LHozDYXJ_kLHHpMjcjMEg63bWOvVDHjCCpluC2Qcnq74XnS062xCsIN-Q6kUU8Y7Eue29kPHclMILijrt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelgeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    mhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:dROdZ9RMAp91OcMglHsmtapLA_AjmRbf_HWEYysyOen0dPEVIeIbUA>
    <xmx:dROdZ5zytKzYouxFl_dkUlxgd85VAAvnJoJI-Bbg7Obx-IMeOZVOrA>
    <xmx:dROdZ74Quovg7nBd6szm7YWDCRfmZiwVXT546NASFTuzX3fN18cpaQ>
    <xmx:dROdZ2xmCU8gnncZ6JCDTOl0G6lctSipql-xaMII9ECgdNxNfW0nIw>
    <xmx:dROdZ7vWYD2vlPKNbO15oSv2TtfvdwHhZCcxNzLREUB5rCmib8B7apdD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jan 2025 13:16:20 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 0/4] hash: introduce generic wrappers to update hash
 contexts
In-Reply-To: <20250131-b4-pks-hash-context-direct-v1-0-67a6d3f49d6e@pks.im>
	(Patrick Steinhardt's message of "Fri, 31 Jan 2025 13:55:27 +0100")
References: <20250131-b4-pks-hash-context-direct-v1-0-67a6d3f49d6e@pks.im>
Date: Fri, 31 Jan 2025 10:16:19 -0800
Message-ID: <xmqqh65e97d8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> this patch series introduces a couple of generic wrappers to update hash
> contexts. Instead of updating contexts via function pointers provided by
> the hash algorithm, we now remember the hash algorithm in the context
> itself. As a result, subsequent calls that update the hash don't need to
> remember which algorithm they used:
>
>     ```
>     struct git_hash_ctx ctx;
>     struct object_id oid;
>
>     git_hash_sha1_init(&ctx);
>     git_hash_update(&ctx, data);
>     git_hash_final_oid(&oid, &ctx);
>     ```
>
> This was discussed in [1] and [2].
>
> The series is built on top of master at 3b0d05c4a7 (The fifth batch,
> 2025-01-29) with tb/unsafe-hashtcleanup at 04292c3796 (hash.h: drop
> unsafe_ function variants, 2025-01-23) merged into it.
>
> Thanks!
>
> Patrick
>
> [1]: <Z3fhK1ACzJfVehM2@pks.im>
> [2]: <Z4jyZCAwqOjZ-u2U@pks.im>

Sounds sensible.  

It seems to textually interact with Karthik's attempt to pass down a
hash_algo instance through the callchain in pack-write.c but I
should be able to resolve the conflicts.

Thanks.
