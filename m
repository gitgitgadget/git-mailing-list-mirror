Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1752421D3E1
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 23:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752018085; cv=none; b=qKaoGMI+HdZiT/2KonBJOqGg9BElckhSddKD/IeoGNiF2WbP0NCI80BcoaLT3tK2zeqWZpevhIWtLe1TsSTG6TZ1OGCWmcY/kkfrEaXR2nJAGtbWtXBGP+Gm0DnqOqXZ6vqrH09yotQzUHzKOrHb7tvLvAEOXFhVDTk9Bw0/IWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752018085; c=relaxed/simple;
	bh=19xBXfHt6EfKVndnbfwG/W5QNJmV8dORbbe1VcpP6EE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n0owrxPfCefMBpW1TotRf/czMhIKVfB8fw9rhUau7IHWvylaI41VyL1VBrkf34LrpOeOIcWE5n0pCWdd/m2S+oRy3kVbjvsMwsuvbpadl6y5fkoF5Srss6SVXOfxRdI4BBncKeRRuFaJ1LlDUNOCXTmnPvNeHUjK+1+F72nhlxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=f6SBwUSo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zh32GBmR; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="f6SBwUSo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zh32GBmR"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EB8DD14001AC;
	Tue,  8 Jul 2025 19:41:21 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 08 Jul 2025 19:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752018081; x=1752104481; bh=iiu6uBrzqI
	tM5NtGKQF/axu7vCj0DJUhmTp+j0Frako=; b=f6SBwUSovWnYifTEO/FjMgZTRB
	VhhdnKZyO5WYO4tnKyO63ntDXoNqxqZlBUTqN9ny67QHieqdgRU4u7e6BdT0a3tY
	j6ObKH8YuDbNrrRcyre0L2K29f9dlhzdt3UxwJoKlE7hOhsAGB/YyTVZ25hdfzFv
	O5Uus6nBiieGQNRahIFXNSAOABEIDar6hK4zbP476WeqzPSgbCLrd94mZdwxsT2o
	b7m2syiapqZdeDBHXeQWkkQvMQXl459A9SSLoing6r0dY/vqinvZW26rzPIAWdNU
	EU8YUCi79+VDxp/VecYWWifht3nXKJBfGuU4w0igrAv6ap9BTat6iJQsiO3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752018081; x=1752104481; bh=iiu6uBrzqItM5NtGKQF/axu7vCj0DJUhmTp
	+j0Frako=; b=Zh32GBmRHpLYt/k3gAaJeTcTCplWuJ3d3/w3OX4Fs1DP0+r4iK0
	Nc51NhU79qHkrP7ABZ9zbKyMC9M5wDIpKvbNYehM0CZ+T3mXhYxNCquchwYAiQNk
	vsW8kmJnW8EmKBpI9aWP90DbNWzWmyzw9icXL40MZ5iyrK/UyLGmaCohDWikBbR9
	eefhPoLiJYgVIotVAm3KDTwUKB81rDu2oPnEIzioPY8ccm6sIYDbtu09pnron2Sq
	hpZxOa8uQeIjJmUNqj2zQQsWze8UnGj6IQqpRNBuVAOp19YPz+gRi1HllA97XiGd
	RK3Wo11am3ipS3SlBxeuEktB9B29NsJ0DBQ==
X-ME-Sender: <xms:oaxtaMtjxu7MBkgc4TrOv1Kufl5pMq2hFPJlNbXkf4_70IqowSBsAA>
    <xme:oaxtaB46CDrYqIbGp3j4fgX5fHnTejE7nkl0niKm2sJ2WX0zqkXy2Ndw2hPWvqvkj
    _buq1o5lByhTxNuaQ>
X-ME-Received: <xmr:oaxtaIMiTZVtNVM9AWVUDUFKwbPVVoCt4-nTvTVStf9DZMbr4M1uU0_wBdmkiOGnMbPBR2RlpnK5a77qU57yxUO3aQ4Gfwxr8Ve1p0k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefiedtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopegrhihurdgthhgrnhguvghkrghrsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrh
    gvnhesghhmrghilhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:oaxtaPsyE7AExB0cruELYdTVHQpcP2Sq4guvmFYzZFveeMWOD3TCxQ>
    <xmx:oaxtaLZVjnCqMvfKLGWoNiHUEg9b9hyWq9HOFN_CWvyFhdpArYrorA>
    <xmx:oaxtaBx5bLMkysg1HChmpSy80b99RMDD206Wp4JnsDHTRmlUT4_pZg>
    <xmx:oaxtaDi9nMaPzfiHZYO9nW5ENnEuC7HX19BrlfujiPIpuQjQKdrKeg>
    <xmx:oaxtaGRJtY_Bc7W2AIRNq6j44_w8Q2PJrmKUhT6Y1d7Jc8JnzB9W_i3U>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jul 2025 19:41:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>,
    Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: git@vger.kernel.org,  newren@gmail.com,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 0/3] sparse-checkout: add 'clean' command
In-Reply-To: <pull.1941.git.1751973594.gitgitgadget@gmail.com> (Derrick Stolee
	via GitGitGadget's message of "Tue, 08 Jul 2025 11:19:50 +0000")
References: <pull.1941.git.1751973594.gitgitgadget@gmail.com>
Date: Tue, 08 Jul 2025 16:41:20 -0700
Message-ID: <xmqq1pqqs127.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> The implementation is rather simple with the current CLI. Future
> augmentations could include a --quiet option to silence the output and a
> --verbose option to list the files that exist within each directory and
> would/will be removed.

I liked the overall idea but this has some interactions with a topic
in flight.  2c5b5565 (environment: remove the global variable
'sparse_expect_files_outside_of_patterns', 2025-07-01).  I may have
botched (semantic) conflict resolution but with both merged to
'seen', a few steps in the sparse test seem to fail.

For tonight's integration, I'll leave the topic out of 'seen' so
that we can pass other new topics that we acquired through the CI.

I may re-attempt merging this topic later, or I may eject the other
topic from 'seen' and queue this one first, asking the other topic
to be redone on top.  We'll see.

Thanks.
