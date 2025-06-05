Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71B61EF39E
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 12:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749127887; cv=none; b=t1FilRUru0sMzLW4wGHOCpwwC4NtdsGOdYYNA2MJIamhJVMgxlBHkNYhr7hYU848rLz5kXoHdoTWnAb2wvs7T+2LJ1TYwyN2CSvSs0gMRO547ALmS7xcqnOgefgb9f2kiIyL5jw8LrHXytMySiIDjNSkHaZPbbFM1bZ7W3tLOOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749127887; c=relaxed/simple;
	bh=RjW2F4nVXi1ti0a/NFZDJ0XPUqZiQx1Z/JjUuVZvjSY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s9gqhz/JEmT/15q+eJ3ajPCocP9olbzbfeU/DcUVB+bNnNuH77XmVZTI5v+CTIaEUYHOqjjInONMXGgMKEOYJFj/pJtgOhlcjW2t/RG76g9JzpN7wc9PkFfEA1TwHp9etXx4fnzz6vF0pzw86acOGngW5f5s0CwP5B9o58YCjr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PMH975DZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QM2XM7mU; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PMH975DZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QM2XM7mU"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DF11F25400D5;
	Thu,  5 Jun 2025 08:51:23 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 05 Jun 2025 08:51:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749127883; x=1749214283; bh=W5TzSN1/VZ
	phTWTFek9Q6Y6U8mUPi7PiE0ohc8uvbV0=; b=PMH975DZK0uj8/S+NJL7uvLdoh
	TfS/UMXiNopRD94RGea9X0hWK5gFr4CmjKd9uS0lL493bTlIT61YAs0Ili0dlj4G
	SqOjy6DUk/5HIophoDVLapbrtkIiDdKWCa4AfpGxFDcm9VwsOqPZcXwkdInttcjh
	huMYW2UrUxFOkVUU119G4Y5mtuH2M5HJWBjaFmS85nsFnH1FinuAT9jcOOr1pNVl
	dHKN/tYRBvJKB7KWt+iLROuEE+FtpoX+rf4vgfv3Q84RkZJgIM3waIYcbCLSvkng
	vwsptJkz245tBmW4Z0LTOCBo1yE09Hiu5B+Wota12osDUn2cmX0QKmGo9sNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749127883; x=1749214283; bh=W5TzSN1/VZphTWTFek9Q6Y6U8mUPi7PiE0o
	hc8uvbV0=; b=QM2XM7mU/aAwqVpBz5J/pFvDG2aHfnDItbP9dTVjwOthZbfkNSh
	wA/9CoNCRR05Mew3X90sVMnFI7W+tJcKDLv05o5iHjsH1x3SJPSazUmIGbGmcrUl
	gCaM+czRQ13l75u2zGA16v25YPszma96PRPWMydIp7kClZlHwHYDCY8xQsqcgYbf
	nyPmlY1/DuJlXvmHy8VHZsbaJjvwylmu3yh5Aast/mgNvHIethOC8q8SksmyDxiB
	smnpvr+KxNs4Ispm2GAlWVDO1vqRHI6TBD8RNluoTwMEKYhXv3inoIpCkUlsOgVr
	RjFpw+T74lbrprRe5vp5fiP/SvQFSVjV8rw==
X-ME-Sender: <xms:y5JBaCMBNJmzy34nlc84KSqaQaRcXNTjKRckiOjhKt5-SxNoCfsN9w>
    <xme:y5JBaA8KZKJHwz77oqngtMZ5EBP1hP1q8Nyht2ijmRoEffPhmUcFwQ3cozQFIM5Rb
    dDu7XLAkxEbRJjLIg>
X-ME-Received: <xmr:y5JBaJQa1kTu8Zx2YoccpslS4URnGdEuhwYhXVfW7moeTqeKA_4Dvm-65q9LkYqAh_o5DXAFrlphy3OvZdROvvuPx4FlGjiFV1mM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdefieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhgvvhhrrghiphhhih
    hlihhpphgvsghlrghinhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:y5JBaCu1XcjQKcnOGN9afY3OtSslL8wY1gzphSyXT9oslVFF5XR7ug>
    <xmx:y5JBaKeJkgoCnLIWTll9indjgpj5mfLs12FWbPX_jNaY-ZZ8DkKW5g>
    <xmx:y5JBaG1C62CxCCTrceHiTyOW5WW_CIrH_5Nv1VyD0eSH0mxLurMQhg>
    <xmx:y5JBaO_H8tY-lSfpwkIX_gqr0qyDDCpFPiflxv-YT8CEDYpP0NdvLw>
    <xmx:y5JBaIr-a3De8V4zYu8NYoVAnjJRN6aBm7jOoFFsNY4PfkJbxx6ttVMX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Jun 2025 08:51:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Philippe Blain <levraiphilippeblain@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2025, #01; Mon, 7)
In-Reply-To: <e9700234-324d-dc63-d91e-9b8f36fabc79@gmail.com> (Philippe
	Blain's message of "Wed, 9 Apr 2025 07:24:36 -0400")
References: <xmqqtt6znch3.fsf@gitster.g>
	<e9700234-324d-dc63-d91e-9b8f36fabc79@gmail.com>
Date: Thu, 05 Jun 2025 05:51:21 -0700
Message-ID: <xmqqzfem9ws6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Philippe Blain <levraiphilippeblain@gmail.com> writes:

>> * pb/status-rebase-fixes (2025-03-28) 4 commits
> ...
> Yes, I will address the reviewer feedback and send a new version.

Perhaps you got busy after sending this, and I do not mean to rush
anybody (as we are now in pre-release freeze anyway).  I'm in the
process of decluttering my tree, and I'll drop the topic soonish.

These topic lost for decluttering can come back by sending updated
iteration, of course ;-).

Thanks.
