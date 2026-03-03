Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4A437EFF0
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 18:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772561036; cv=none; b=nCKXaBivRvuWiairUig0GxfoGfoOUR2ZSjkEcKQ7VCGZ8GlrAoD1V9P6+X+/HDidKrPMxcmNiSz67+0SsZ3siYeKLeYjy2fqAmJCjUqJh4dDOrDo1kaznMCGlfAhtoWyVIA+mBiXIXrPiOUQjJmCTlzYAU/ERAl1a+aXSDBte2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772561036; c=relaxed/simple;
	bh=/w+2um2AcjzbfOra+d+nsW5sTFATcZIFkZgd5a6svYY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Sno1IK9wAurfxck0J+oTsdZH/uvUtiZ9KiBb8Yqg54vNHuGC0zCYh1i5/LFRZ/YjJogvnSPBXjJipCHNtbT7JkbPk3GMj5HGfHxjgaQe7Zl58NrIlY7+KdOajgUQ7Pu9ziZltVbQeP/3g0v+bJTz9FHPGJZVO2mMqKXsOfglB1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=K2y9Uq22; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WCVmGZ17; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="K2y9Uq22";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WCVmGZ17"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 15FFD1400184;
	Tue,  3 Mar 2026 13:03:54 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Tue, 03 Mar 2026 13:03:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772561034; x=1772647434; bh=jYTDzEgMIT
	M+ykIT/+dvqjjQvLjjUyY295S2LpeNHD4=; b=K2y9Uq22PuCgihiBZre0PtdqPa
	xz7g/lYjlFOoAhpsw6WlYY/PTCe4hjKUf0sqr9VnT3nXPpStSVTamlKRUrjfFjAZ
	DcNzJrYpIrAKvByRoFTGPJmigPCKSeEyMmig2uMTN1FgvTrGTAgRF1to/StEwnCz
	5jqxN22h7GvtIzIOzv7LPgVqFRAaFSi3lIjGv45aLievDbqp2ZhRsq3bMpbv2PcE
	/SCrFOFqRCliekBOJuAeHLomEmReVzMjv3mL8iJxfEj/boNrch25zZn7mY6Arb+J
	H/cbXB4ThLSvkMiMwuiD026HCTCIrxE3K+oZJbLfmljPUTBhy4ERlaZUB2Yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772561034; x=1772647434; bh=jYTDzEgMITM+ykIT/+dvqjjQvLjjUyY295S
	2LpeNHD4=; b=WCVmGZ17YpqAMLoelD2aoKe5EaLrfFdNfeg+s1WdjAWU7RZvRWK
	VOihNzeUdifDCLZkIzyOz2uw3Yxnhd0Bi7zTMrnLno6utlvd4+bSXPHfN6juwDZH
	LOmEpfNN9nH5+TGz1beQGdGdGYPAoG0j8W+RXlGpjgVJweXu5YpM6MAPEO2S5r6F
	jO5Y7+Vol1HtxzLXep9NTdG6BtjkTJYMe1M0ipxtAELfKlRe+52i8Ynta2lD4OUr
	+6NNwnwY8ccHzrTwzsbnkD1xtUh8auntHKLaKfMX7qMtRjyFKlsLGRn+TtSyPuAN
	3i3tPIwZIO/KzU/bqT0g3jmvQ302g92QFvQ==
X-ME-Sender: <xms:iiKnaewlnvqVu0a2lxyVTjIa3Dfm9FTh6Z1arwL6-8Hxllj9KjwW7A>
    <xme:iiKnaRslyhpBeGbLqmv_o8hN8I8pvL-SHIaTerb6C1X5efM9nrprhzXKnA0XRS7Bd
    rpldLFsydFMLlyT_Nh8Qw_1QgrSq8b8FhGjTz31dHqjxFfnI-8erg>
X-ME-Received: <xmr:iiKnadsWytgJ6KwdD2kURg1ovnFuBap9fq89TaeK3e90zr_fAuXSOuQmt3gVzp1n6epvo_VS80_qnvcfaXkzRM070gCude_dnQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieduvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprghnthhoihhnvgdrtghouhhsshhonhesphhrohhtoh
    hnmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:iiKnaeMAQ8P01KX1Jz8CnHCUHpDcjR07U1k--ryaafA-oMHhjWaDPQ>
    <xmx:iiKnaT3O-GsgfvL-iyxLqp3jkKJ2Gw90FxBSzh5DIyxvuc51NXIG3A>
    <xmx:iiKnaSMfCJNO5gtTPgz0dAefARTHX4yKahfbGMTzgd5rV21VDoIG5g>
    <xmx:iiKnab29hWKpUcG9y2afVUSgMZfQTXG_216-xFEHr7gPNflPyHD9KQ>
    <xmx:iiKnaYXh6-UHW1gR-0FLn87m4KPKad8ucl10YjIe4rG60KKwuqFnskuC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Mar 2026 13:03:53 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Antoine Cousson <antoine.cousson@protonmail.com>
Cc: git@vger.kernel.org
Subject: Re: git whatchanged --i-still-use-it
In-Reply-To: <bhYbjxeZY0QZt48g6XVTVfyPo6vbv9yeYLsw9PgFdVKgye6Ue0cAPy_RkNTwAOYEANhHyD6QbaxZrWaPS4__jlTcAVKOaEjrDgAxQYKdYvE=@protonmail.com>
	(Antoine Cousson's message of "Tue, 03 Mar 2026 16:01:02 +0000")
References: <bhYbjxeZY0QZt48g6XVTVfyPo6vbv9yeYLsw9PgFdVKgye6Ue0cAPy_RkNTwAOYEANhHyD6QbaxZrWaPS4__jlTcAVKOaEjrDgAxQYKdYvE=@protonmail.com>
Date: Tue, 03 Mar 2026 10:03:52 -0800
Message-ID: <xmqqpl5kdc3b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Antoine Cousson <antoine.cousson@protonmail.com> writes:

> I would like to say that I still use `git whatchanged` I like the way we see the
> modified files instead of just `git log`

Then perhaps you would like "git log --stat" even better?  Instead
of meaningless pair of hexadecimal object names, you'd get a sense
of the size of damage each commit causes to the codebase.

The command is going away.  You could

  $ git config alias.whatchanged "log --raw --no-merges"

if you really prefer the ugly hexadecimal gibberish, though.
