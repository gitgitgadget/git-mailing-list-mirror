Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E302E406
	for <git@vger.kernel.org>; Tue, 21 Jan 2025 19:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737487061; cv=none; b=Gwne1h8PnkLNLf2IqIjlm3wdMViNAaVNuHTPAg38c1iCSOsYNJeEVcwhbq3JYYhyHafWvOHt0mvJN3AmYG5Pdma2TqPIC9oc/MDG2HN6rL6hIT8XJ2Mx702DVTP6h9xfzNXTVv5cYUfZRdkUWVRedtQ/aZgrmVVq1s3tj9Cj96A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737487061; c=relaxed/simple;
	bh=kbgi1SujJ7j1fiurms7G8hOOOhLqihsfpx5Qqhw1uLU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l1iugDOt5mhKBGd6MsutkeOX8GUnxqkHEj++4IJJq5qiIP+c6zvk8JnV6Z/ce13DeJN4D3pBTSeOnnwMjYizdPKdznaIpzsQcNYv5qFob3fKC7SBR8X9tg6TdZ/Lm43CtgllS3Vz2tIuUqYgw2IgoyNIWHMD/GUg438gaOhI0vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=grFNJHzI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pCUaKTSs; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="grFNJHzI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pCUaKTSs"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 25CC125400F5;
	Tue, 21 Jan 2025 14:17:39 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 21 Jan 2025 14:17:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737487058; x=1737573458; bh=DsTDYgX429
	ILyoKQnMiFU82F9e3FqnLJV5bABngqKCQ=; b=grFNJHzIKC4SgAJbLu14O2GGxf
	+RlfD+AuK2TSg6Gq1Ux0O7EhGfcbXHyOALOj04oejYE2oykBzUSxK/cG7Hn5oNUj
	7WRiv6iFvH/i7kzai8dSxwhxT1l832MivfNrlcUf4OTZ9QJ/slMHfr4irsdHE4zD
	f9/vd+TP8hF2uthc4twOhQoAeQVHlOhSWa1bLNBDA2cxyNfIef31zL1hZjO9k/RT
	gC0liY1wbArqVvkbb3S1acT1WZkNjqR4H0ZyqSVqjmU1GxDae+gpPvI7J2LefPLl
	9GCF8tZHSu/bUP6GsGfKdRiF1Gcx6cKjSywNlbMqC3m+7l89bb6AESF6KkVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737487058; x=1737573458; bh=DsTDYgX429ILyoKQnMiFU82F9e3FqnLJV5b
	ABngqKCQ=; b=pCUaKTSshM1XhPV7F595iWtbI8s4MfYwOrCtJEjzOhgvk5Eu2kn
	/2IKL0zrT6PSx4bjJCfFuevWg5dQBeYCFEJ/3loB+jsHLAnqYqn9TOEnVhyoxRPB
	7IqciDTb8pHFv6pdVZJh3aJ3i2L2KBLvZNIeu2VGguPNNqrTPfQYUrK/9+QOM3Cv
	zlU1W3+Dkf/wrAZS63Uew8NlejIlE4R5ArqzXh2GqPZxBruLS6uxjfTva7CLhM8h
	XY7t1IPPYWQpwNcbmnZI8A+Nk0VInogsQjf2AiTWjymxbI8tEf5sKXtWzZWnsgNm
	WTwzI9171UP/DsIO79R4esk81ihrXLV7fyQ==
X-ME-Sender: <xms:0vKPZyw1P9EpbRj-aoTOjpT7B5vRccAk1aGrqJxzHYdshp5rJ-72OQ>
    <xme:0vKPZ-RHNVb5wxVqeR3XP_ttH6A0lbczpI5hQtFIjHkW5GM6gPXUzBhk_0QDfLWwC
    CPqLeH1UW9mWqOXDA>
X-ME-Received: <xmr:0vKPZ0XM1ohvqjmuGVbcIUiZKUIsmjHKNIYCFXTPbyVdDgaSu84b620XU2bTTiVv00MjsP1FYa6xbWsFv3vjHjJyjMMBmeffWyH->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejvddgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefve
    etteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:0vKPZ4hjeqlnQV40Ux_uE7nbI5r-jPgOmh53lbnxcOVP4B9if3WnZg>
    <xmx:0vKPZ0BVLAxhby6TrZmkThUtu_-KeY6LzdZCpQ5C2CDbGaZy5xmBXg>
    <xmx:0vKPZ5JoXpusUrno9v0rMv9D673IngKCvAl1iyevrc6KoRpfILuUgg>
    <xmx:0vKPZ7BDW27bCq_cTbmd_J5514B5I9DxWcJ2dNm2NnoQT83dlv729g>
    <xmx:0vKPZ3OO4FoY14Jx2GK9gxJy75TcfJVFJwqCLaWDghPKIXwe4CEkW7XF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jan 2025 14:17:38 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2025, #05; Fri, 17)
In-Reply-To: <20250119125526.GA1540196@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 19 Jan 2025 07:55:26 -0500")
References: <xmqqwmetgdgm.fsf@gitster.g>
	<20250118131507.GA387197@coredump.intra.peff.net>
	<xmqq34hg3utv.fsf@gitster.g>
	<20250119125146.GB1538605@coredump.intra.peff.net>
	<20250119125526.GA1540196@coredump.intra.peff.net>
Date: Tue, 21 Jan 2025 11:17:37 -0800
Message-ID: <xmqqfrlc0yem.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I was thinking to just leave the offending code untouched in the
> individual commands if we went this route.

Ah, I see.  Yeah, then we have a subtle and possibly brittle code
paths that are well contained inside two functions.

> But anyway, I'll prepare a version going the other get_be32() direction.

Thanks.  That probably results in better code with fewer magic.

THanks.
