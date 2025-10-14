Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF462DA755
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 20:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760472978; cv=none; b=nR5hpPwZJLrnRSrO/rlVGEVrsxuHwyOHOtxa9ge9M3eP8SAmNk0VpY5y8TMt6Tl9jsWnErgAhL9JrZGf1FhsplC3tEWj40CR6Bsd1Ln1I1IQr+XNXTKMzhrEB/9DBFuGUYHuUM5kgsCO5hFcCH8g+WUu6FgaZLxOACrsVydDKc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760472978; c=relaxed/simple;
	bh=ZN+Ik2nWhDiWrWMGhwwXsL2DXQD3eSv3hXa20AnKQXQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tdYDAuZSXMR54i70Guzk4f9PLsnAoaknJ3XddirjHioLeZ8vm//Ul0pVO33HSUrtYYAeEh7SDRRCL4u40hpDsmJIUGg/DepCuGdxxP/4LUG3+B/+f5jH6DOddJk0FsR+0q+615XEBntq9hxWsgEqmDDthkioVxNzyV1QDMNkNHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AlGEo3Tt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WvE/SIcG; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AlGEo3Tt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WvE/SIcG"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AF7457A0082;
	Tue, 14 Oct 2025 16:16:14 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 14 Oct 2025 16:16:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760472974; x=1760559374; bh=W48lPfqDRO
	hSP4rymshIJELeiknsgll9d1gAACpXzlY=; b=AlGEo3TtGsiB+Q3a2loU+4e09Q
	tHVnaVVnklgqXYnOyvAJv7zERRQXmc0tZNOQ77Vj5KsHVF7GVUztvBKsw9SC946t
	BoGB0mavEBIlCWGAZGhryn7JuKKzHoXTCQyl1wouwq7qMu7EXSLVNDulHCSH9cLK
	gzLWH6wajTVnk78JM5m7Gv2YRF2hOZqeBq86AaQLXJIYbja02YNepVyAyjnWz3De
	oIS556sOldXpddtdIpFG3kn0Mwj+6cWvjA8fHM3BxrjuFaafIxUDOVfkTiN7nwUz
	Tjs6JBY1U5o5B2dnjwbzO4MWRZpL0nmtLzsTDld6LFhgfSxwkWl/mM0gSLGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760472974; x=1760559374; bh=W48lPfqDROhSP4rymshIJELeiknsgll9d1g
	AACpXzlY=; b=WvE/SIcGI/qS8Ln+9mIDEE72hM4meZUrht8IL8k7sGuM05NRfaO
	gMWGVpEnugfM5ZpfVNoIL2JPfFd7xLT8oRN+AHOAwi40K/XUVVly8frxG0Pja95+
	iTBWbTpseI6AbuO+Lu/QcjOotRdTg8Gtf3M4uGeZ3dpJRgeQHGvo0cqiNt8ZrfZK
	KL9rEr1BEyKm+ImfoMt30VGgKEUGt0gf1G8nDx6R4GEA/nK+CTGvQMT5l4KVhoBn
	Ir+KwLxeLJ/TDa5ojnll9ptgFu5DhVEeB1wjdofqA+u5zCV2mzFYQSuVwunw/CSt
	Ww4cZe5BCuaJ3SWV4cTtW0J0dM3TWZ8CIHQ==
X-ME-Sender: <xms:jq_uaKCTeE9ewsBC30_bXL-9evU_HRC3n1p9t50-xGMBaPDm_XbwVg>
    <xme:jq_uaL-SSrRD-B6GY-LzxD9EDvsiSqDNqYaj6DkvbJAK0dnBUBASV4oo4lpmEAoRT
    sM5kONyNWe2ddsVqgIyFd42NzSpuFolfTjJpCy_7IhBdxLcGg4c2g>
X-ME-Received: <xmr:jq_uaK8dKuIOam6iSR4uAaYNa6-yDhrQ3DlO5MZTNmrmNvsRNYu72p70fWO2MkhRS8MPGT_XyHWhDJnuyow3AJjkbv3ODnjtMvDv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddugeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehl
    ohhhmhgrnhhnrdhshhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:jq_uaCdhuCoqCZCONIPqJ0ISKtmYkGxaok45FTx5oMfvQuBilXOWWA>
    <xmx:jq_uaDHjH6T1Yrgoh9Nb7dBdWIL3IMuPguNIMtdnqflWakUK-BWOKA>
    <xmx:jq_uaAdDb4FstwG2wuMJEIf9_01Nkm6eNRn3t8TETts8UvWV3W3ZvA>
    <xmx:jq_uaNHd3lzN8L-_FmzBW-4-cP_8HaYgigJmMpfvhL4qzFJL7RAsJQ>
    <xmx:jq_uaAKUc1FBubgO9fp3e-DC7JqlQZ7NzT2evf0qBGps7KItMeS4zA04>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 16:16:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Michael Lohmann <git@lohmann.sh>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/5] setup: rename `die_upon_assumed_unsafe_repo()` to
 align with check
In-Reply-To: <20251013094152.23597-3-git@lohmann.sh> (Michael Lohmann's
	message of "Mon, 13 Oct 2025 11:41:43 +0200")
References: <20251013094152.23597-1-git@lohmann.sh>
	<20251013094152.23597-3-git@lohmann.sh>
Date: Tue, 14 Oct 2025 13:16:12 -0700
Message-ID: <xmqq347lxmr7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Michael Lohmann <git@lohmann.sh> writes:

> This function dies if the repo in question is deemed to be unsafe and
> the ownership is only part of the verification. In addition it already
> checks for "safe.directory" config, making the name
> `ensure_valid_ownership()` not expressive.
> When additional options to check if a repository is considered to be
> safe are added, this name is more indicative of the content.

The new name chosen in the previous step makes perfect sense, and
the previous step sounds like a good thing to do.  Likewise, I can
understand the reason why we want to rename this helper here, as the
reason why we die no longer is based solely on ownership.

But why "assumed unsafe", instead of just "die_upon_unsafe_repo()"?
