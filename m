Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA80A371CF0
	for <git@vger.kernel.org>; Sun, 15 Mar 2026 16:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773591211; cv=none; b=rvYDtxSQMOmcHcalsOJVRCr+Dal/ivJjfrrBiT6YsGc9H8IekX69Pe6PtBFop32WrX0DqlcaI8KhqHrngC22AbTT3MGFxSK7FE/T+l9xuB7fqX4+21KkmhmWa0tCj5Z87Krr+TphGDZTr4n1ghzEog8OPnzwweTI4ytJVtje4eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773591211; c=relaxed/simple;
	bh=sfLKfZ+sUOmxTBv3ijydgZx6qAZOyGJzpG87ZTrSlBI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K+xN4MHqK7Bc/IHMn3c1mQVb8YaWvNiCbXm/J/EiSZIeUW51X3V6GBSk2lyaPAMxLDv/uJpQ7ZiYIZFyQPJ7+bNzoRLpCal24QQel9M8vIHuHDgugvIzDkcuZnbX2rsXJ/FiaoqkLT2ublOAmWEjU6UtRWbGpm5BRJYGWY7O9Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=blMmN8x4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=InK/n32l; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="blMmN8x4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="InK/n32l"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 03F141400105;
	Sun, 15 Mar 2026 12:13:28 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sun, 15 Mar 2026 12:13:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773591208; x=1773677608; bh=MtKWEqLyKN
	s2Rc1rTc8pKIuH24zdPOnuBlFzKH3wsqw=; b=blMmN8x4x1XALMfPqZezE75uGz
	e/2Yn2n5FEF8UxVsZ/rh6IgExVpM9VtIJ0mj8WEsNh/pSYNhsRZE7NygGaRSj+Mb
	DvAEJsi0R8ffCdl3sRldO140C9o6awqjZuGs6OHsUEZ1ri50T0Dbja5gkKl91/6F
	GUqm8S8DuSZHGkt1DMLsGLDw82KEhaPnOcwkXUDCZvvWtjp1k8jMRwfPhZ10iqLb
	dpja/BGDApIFiGow5X4Pl8k6h3NcYxK2lLCLYCMWWGbR6417sDbmrDNbdvak3ztD
	r9jQ/JjmFNLI6x5OGs/A1MYNOMwzhrMrheuaBOTlcQeXpa0CRtJRganw0ZIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773591208; x=1773677608; bh=MtKWEqLyKNs2Rc1rTc8pKIuH24zdPOnuBlF
	zKH3wsqw=; b=InK/n32l/4YeWkpqh5HcUgA1/iSOa/dnEpFdGQ/aXtx6Kt5NjzU
	J1TO/4sZRtq/yLQQC1ZMRLBCZ4Dld3iiLbcMQI6/5OWGy6fnJJgo4Ow7r1LX1frg
	2sVFOwqKKMuIFKADUnZjo8fA8nAIiwROAEjpkHa+vGQj6sWfcu+mNTAn9hpfzoT/
	NdKsNXJOfX3ZU7gxt8Yu2o+J4/BpqAeuPsrlPx+biG6Xu0JKmyEWD+mIUmg7zoZO
	BtraKSVoddvvQQ2R0wdrU8t680DCQSBn5ZuBkqQNjTT3yefRQwfjkb0AJ5uEZlrQ
	u8H7cTA5omS5IHyDyd7siLEcsfThd+k2NNA==
X-ME-Sender: <xms:p9q2aYI8rHfV9ysOY-zLHdHZ2pSrMcH_UI4Jtrtm8Y5KxM1etOTDag>
    <xme:p9q2aatvPmmFNvLJH48AQW0VBYWQhLtfxMA1Tdyzvg9ahojJC_bU9GwZrkQqH2RR8
    dCcs2cSzMCkzZXrPD0a37GM33S9Rv346Vg9ahtPBsKmQC7oJiRGxmU>
X-ME-Received: <xmr:p9q2acUCq6qcPmfVfhcE3_NPLGxoNW2HRb4dAa0bqBADAxec6sPDr8hAKT8U1m5xLvxlv5nuENRQMB71YkH2C6XOueJid_Alzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleehleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorh
    grrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepvghmihhlhihshhgrfh
    hfvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghp
    thhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthho
    pehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:p9q2aVjhdcAAO5BByUqNJLA_0l8z2YXWHQXXynzO56x_2vRueDlodQ>
    <xmx:p9q2aUoyRmmviZ7mlP330jifcDHkBAKTBmYJIMF9cGMYkr5TOR9hMg>
    <xmx:p9q2abGb632wBjbHrDgj6bcIq-bfIaBxycRmvc8EIGtgzaPKtNjoKQ>
    <xmx:p9q2aZ5MZRkTcOde0NxDMt-twlT5693dVK2AB1ezs1SOO8QOdKTauw>
    <xmx:qNq2aXkZcPrBgNmo0E726BEKqFDEsRo0EPGFP6uuJYMCZeMfEyY1ByOT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 15 Mar 2026 12:13:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Emily Shaffer
 <emilyshaffer@google.com>,  Patrick Steinhardt <ps@pks.im>,  Josh Steadmon
 <steadmon@google.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 3/9] hook: parse the hook.jobs config
In-Reply-To: <20260309133739.294555-4-adrian.ratiu@collabora.com> (Adrian
	Ratiu's message of "Mon, 9 Mar 2026 15:37:33 +0200")
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
	<20260309133739.294555-1-adrian.ratiu@collabora.com>
	<20260309133739.294555-4-adrian.ratiu@collabora.com>
Date: Sun, 15 Mar 2026 09:13:25 -0700
Message-ID: <xmqqtsuhrryy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> The hook.jobs config is a global way to set hook parallelization for
> all hooks, in the sense that it is not per-event nor per-hook.
>
> Finer-grained configs will be added in later commits which can override
> it, for e.g. via a per-event type job options. Next commits will also
> add to this item's documentation.
>
> Parse hook.jobs config key in hook_config_lookup_all() and store its
> value in hook_all_config_cb.jobs, then transfer it into
> hook_config_cache.jobs after the config pass completes.
>
> This is mostly plumbing and the cached value is not yet used.
>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
>  Documentation/config/hook.adoc |  4 ++++
>  hook.c                         | 22 ++++++++++++++++++++--
>  hook.h                         |  1 +
>  3 files changed, 25 insertions(+), 2 deletions(-)

OK.  The previous step is a good preliminary step to prepare for
this.
