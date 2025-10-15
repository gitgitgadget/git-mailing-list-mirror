Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAE92046BA
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 20:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760560701; cv=none; b=nn3IYgP9eP4Qtu63CttGJTxsFIj1ttvfXyjlI9x1aT4umLM3qt3AEQmZ46FcdoDMagFGFy/KjePUeIqI6JI8elDsjnIWJQgOwpLUMF6lKUAmqfDlLJMkD1E/0uyngv2JKL+b2ZckW59zRkZ1UbsG5FwrfgcNtcxkmI8Ii1QaR7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760560701; c=relaxed/simple;
	bh=Num6oRtrGiR+vtEgsRV6gaSA+jw86Z4p2C3XHfPgBIo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C2Gq2NuTiGWJOSwROBRDUhRRDX1aDcV6jCJcjdZuBDXDAVDYe850cML1v8pKo2Z+4r6NE5/En12j530kGh010HwhOgI8MmxINdt/j9LziljB2qrRtx7STIOTsGipAiWnRUrrpMTHSd7K/qKE7FRhU+/zV80Tzh9nST9wciTJkUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=d3d0uf8f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A5OlEjnE; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="d3d0uf8f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A5OlEjnE"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 9CE53EC0180;
	Wed, 15 Oct 2025 16:38:18 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Wed, 15 Oct 2025 16:38:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760560698; x=1760647098; bh=rulBgI9vmH
	wK0BF6fsc1z7fBQbaaxUIZaXG/iLNgthM=; b=d3d0uf8fmTwDegU2drLS9nxDdW
	i+E1hGwkNnTZ9nx3nxZyaCKF6bqK3KIr4u7pXAdtG8wMDNv2cLb8QzPnp8hBv2r4
	S6NZlA1MntcDWKy89/obyXggawbDR0VY/DplLbZjpBT7eWqqeKjUaofDy+uLOAoA
	0pNqn6OPAOomfw9hZQ87U0kORT2fyeSGGN5AHq5cjQcsoUpDpBM7tmVwRPIjQfcz
	qi2Qqle+rTeCiYjR855DoejH+hBhjCHLjZXhkiS9Vb6JMC83/cnIfRMau8wf1iMn
	jXvUhojjIGxjRaZFrKEkJjREjodsFL+ZXt4YSGrbGlAMbsdpUMeL9aoezOKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760560698; x=1760647098; bh=rulBgI9vmHwK0BF6fsc1z7fBQbaaxUIZaXG
	/iLNgthM=; b=A5OlEjnENWfA5yS0nnpFd8gxUd/0npEzyVohgaeHS2t8KJcq9Z1
	QlFTYEioATcecwAKpjOrWTYZ/UQrT6wl85vfThJUXYRZqOBv+RE75k9unO8EZ2mp
	Mp6Wa3dzWFNJIsOZFlUwoorGgBNxTrsGHb03RuM4AGQ5gUzHzw9NLW5DyyqOks49
	ZG2bNdZmXtDHY6u+78iXFkc8GSgegqgFI0A6ncvofe7uMujpRjWvNYIFUtiaWyr1
	JbJxz/ISlh9QO6hYDUXi2zuLHfMRnAQ1GR8bVcrOnVdjtrY7RmoYPhhmYdu5/3W4
	O5Kt7zOqy4khSCB6iSun6dZIz4a8hb74U7g==
X-ME-Sender: <xms:OgbwaJaROdh5sJk10Vg1qHqDia0BZHw4H4rBZ3kj7La9M2hpRJLrXA>
    <xme:OgbwaH24acVPVShcTVXyy8IeulcyF467EFtVKTSP-mpqa5PBi8FkK0A0r3-0jmiqq
    9Dfmv6HbPj1AFKJa51GDczef8n0ol54O6Vh3e0SQx8F2YFPGm5x>
X-ME-Received: <xmr:OgbwaJXjfbeYm_JIirVvW3cv3Qc8J2FWBk3AM07zRhw9ONJ5odlTWRBdXMFGhEl1pXyfNpSSdRXICTWluRqXc-q2FK0d-bIdHvpc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdegfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhff
    eggfefiedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsohhlohgs
    rghrihhnvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:OgbwaBVIOCdQVKCwjcyMBMPSDsdxRe5SY-8b5lU8A16zYvrsqsBWzw>
    <xmx:OgbwaIcKd1f5ZE8cOwgsV_FRdPhh29mJLP807M-ExPewZ6b5L5TkhA>
    <xmx:OgbwaKVGKgIkC5QDa1vLlx0i89TP-1BR7fvcIymbLBtMwE85BQIDXA>
    <xmx:OgbwaBdcZ4vUuixtXsKnySh1ah9m__YEoZo9X-7P1v09aGV0BiXv5w>
    <xmx:OgbwaF_EZbAJZ47vLlwkxItuOMvR1s6GpAQ_7IU1QPLz_IBKUbQMaSOT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 16:38:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Solly <solobarine@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] t2401: update path checks using test_path helpers
In-Reply-To: <20251015140329.13691-2-solobarine@gmail.com> (Solly's message of
	"Wed, 15 Oct 2025 15:03:29 +0100")
References: <20251014161446.6135-1-solobarine@gmail.com>
	<20251015140329.13691-1-solobarine@gmail.com>
	<20251015140329.13691-2-solobarine@gmail.com>
Date: Wed, 15 Oct 2025 13:38:17 -0700
Message-ID: <xmqqikgfuchy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Solly <solobarine@gmail.com> writes:

> Update old-style shell path checks to use the modern test
> helpers 'test_path_is_file' and 'test_path_is_dir' for improved
> runtime diagnosis.
>
> Signed-off-by: Solly <solobarine@gmail.com>
> ---
>  t/t2401-worktree-prune.sh | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)

Looks good.  Will queue.  Thanks.
