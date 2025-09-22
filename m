Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B83315D32
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 17:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758562542; cv=none; b=pHL5OsX/T7jHblnBEGZjchi3Y2w9M1MCBfRkaOmWtTlvBiLnXTCP8GylSk/MDIyisvLUSXfjZs+gtISosITC7L7PNgkdOsk+DlBz5eE0fOg2xsm+0q8/+gyxFquonl6F4aiwzpltS61bSk6y5PyzWS/EpzGE8ULt0J+RBIQJl20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758562542; c=relaxed/simple;
	bh=xvaXbWBVfI1xoXwpEduxzo/ac/UJSZ+h4e2WN7DdFUE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F8glFG9DJjLZxvV9B5K801xkAiyMsIdYME0IRx/82+MSRX1RGOB+9dMRCD8tK+fQfkilOwojIy7no4OBojikmKzQIT9GP//7ApX1gb7kZfpaA/SDxNbqm27K21auvlx0SZDNy3msnampyve3mCXxwviaBmCRz1GbvgoXP1y+NRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ni8td4Sw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cl0s+pwX; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ni8td4Sw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cl0s+pwX"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D3FF21400129;
	Mon, 22 Sep 2025 13:35:39 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 22 Sep 2025 13:35:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758562539; x=1758648939; bh=xebAGo5lgB
	6M1oROJs1+RK+lBKboDW+4LInhkXZgmSs=; b=ni8td4SwR+XxwX6+Z/Wl1Hgbtd
	bjs3oer8B3xZ8zBVQ8/Ay8mdkkt4ezHTIpCxGH8Oh3nU0VTF3IIw6S0i9317667U
	rfQUoIf5iRPXg7MPbJGObNAplLujMzr9pSdrRS6e7jsgliH2sCME7beNk+b0S5ii
	/zWwTMdBlpBp0OkNvoWK0fSA+5fOlUqyDpplzne2L/9atdRvk4M+7+hVDmtr43yO
	WNFul5J82LJmrOLhUUXm6MDJUjgn6yQu2oVIBusKxcDa5Q8WnzfmuYMc7+DsT8pG
	B6oF9wAczhIXme1eA7OcWjpRP0hA9Gfx7YoxgRR8l4dZ8U9WRrhcwfAJcmzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758562539; x=1758648939; bh=xebAGo5lgB6M1oROJs1+RK+lBKboDW+4LIn
	hkXZgmSs=; b=cl0s+pwXhqhCVI1CgyVD8hqRcIZ1DZzCNQPPRtXBK2Bf2p3I9EK
	PIfjQPCxgu1R8Xd48tGcdSctwkdBzdkN3RuPfunn/0No+llT1ID3Tu+ak95un6QM
	3qY8P0MCWL5Kuuzj347mrRRlx79Nx8AuSuzlVT6sUshI8wJ3rQlcFvTcENeFbD8n
	3RrKyn3CzQCkJOSUrz4tH3u9nPBJ5cBenYtnMe93jSu8eHwHgLT/0crWpgV7Cumj
	1r6Cm8J/6MoUhrxzmw17tq0+9gtT+Zut342QPQ+TSgaiB/1vqr0JuzSNPEOC7Tjm
	TxFH7A2zXNaGzBNUVWrPHPX/+1TOSJVQlmA==
X-ME-Sender: <xms:64jRaHh4eX3BpdeDlWynQ49HKL5ldWcwplC1GeufWSKgotzJ7egoSQ>
    <xme:64jRaLDbwhBrTlbSnmRHrQ3U9wuhmcor2sCMajbArfD_-MmcT6qL0WW7lmAbFFIbX
    zZ9lCOU0-FM94ROvuY6-QWSemQeavQ450sQojN0KSb96JIcGxrTlQ0>
X-ME-Received: <xmr:64jRaMG3gciykshAK0z7VAvLHZUI_m6JP2h0uDo3UQoX-2xFFVv_Ns1tOc6Shkse9I7cSVgEynuZknw93mzrvxvM1QrIbzeS6SXY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehkeegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepth
    hoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:64jRaDKxXoc3JzR3G7FhgNpjMLkpsvFQXZvEHx7ZKTf8WIXZQtzHeg>
    <xmx:64jRaAmU3RkAsu4w6t2cLjLbyTXr-ghT3KMUdJOf0ea_oaDn5PcRZA>
    <xmx:64jRaLRrOqtps8P_eFW-HxIzfCSI66PhVr9F4uYik9aZjAIZMcKB_Q>
    <xmx:64jRaCKnfk7NMFD-zDEHGdQyIlu-jjX4qRVmCdr8svus45lUwWJSEw>
    <xmx:64jRaAZd5ZlkcMUnYh0R9ckHDyWVHyaaYVgPp-Nknd84veDEgeaCLf7B>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 13:35:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Toon Claes <toon@iotcl.com>,  git@vger.kernel.org
Subject: Re: [PATCH 4/4] refs: do not clobber dangling symrefs
In-Reply-To: <20250922172140.GB2202085@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 22 Sep 2025 13:21:40 -0400")
References: <20250819192934.GD1059295@coredump.intra.peff.net>
	<20250922122332.584428-1-toon@iotcl.com> <xmqqwm5qv5xh.fsf@gitster.g>
	<20250922172140.GB2202085@coredump.intra.peff.net>
Date: Mon, 22 Sep 2025 10:35:37 -0700
Message-ID: <xmqqecryv192.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> ... But we could add support for "ref <old-target>" to the
> non-symref commands. That is not just a syntactic weakness, but
> something you literally _can't_ do now (convert a symref into a regular
> ref atomically).

OK.  Your explanation makes sense.

