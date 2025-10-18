Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5E8229B36
	for <git@vger.kernel.org>; Sat, 18 Oct 2025 16:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760803293; cv=none; b=WGSThukBa8Dw4WWIWC866+6Oa6xG06ctfzLWCzPWf2VwMtvfZ4kgmeLMcOOFY0DsnaJ4bkxLZg0h2ZCGKZ5oIz3dmXj+erli8zuMYHEJdB9H32GaZu7y02pDznmXz7NnQ1dVX+y97ki8Re8hCHVkxyhv7v1D3JGQAcv7kuYc59w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760803293; c=relaxed/simple;
	bh=EQ5waK1BYPHpwtes6UQtiLzhbrFz+il0LypyzXV5ONg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vgz+X9FR7ZxGGUk7vzMDoGqjBLrnUwUFNEBpt8A1X6k3NtEqDHzZtU3m2krClZINbwrnDcjCu/4KE9F3UswdgMkY8miMRCAr/rQlGATB8jSyDN3uHgUMTy/HzCEFuhD+8pG9tdWJ0aroDAjNP7/Qnur7GJOQ0cQIzQpFkKc7Lpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NydYFFVL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oVnfjW/S; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NydYFFVL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oVnfjW/S"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 259127A017B;
	Sat, 18 Oct 2025 12:01:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sat, 18 Oct 2025 12:01:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760803290; x=1760889690; bh=aFa+rZQozW
	HIrjtX1iZNQwlufq4U7a59M9UAvPuxZig=; b=NydYFFVLMhG26W9XNnRicDfel8
	UX2aBsb8KQW6pM++ugVdLQNkMsqKGx3r+wTwkRD7cxurzzeRjdveEsrbVkDIYlCE
	b8hiRxdg24+nqkwevn4030VXGndHMwXTR7E8HxS/BF9WD0RdEp8n3lRLocm2p/S1
	V9s7uE1kdGebeoqriOJnoY6V/cmWVmPFHmUq1Tc5/MmeS54YrICugepIgbyfFnwZ
	3Y/sEMK7k4iT4L3xoJx2fKWvURpeWqL6h0bsn2FRqdINLlnuTZjZU311XOWIKmVn
	B4b7r3VGpXyoI4sCbmn8l+0z9p4yyB8SILjn+Pzk5Cb/n8Gu+eE9GRyS5amQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760803290; x=1760889690; bh=aFa+rZQozWHIrjtX1iZNQwlufq4U7a59M9U
	AvPuxZig=; b=oVnfjW/SVt10CrEelL6a8sMwelOafgs+aiVj7CCi6Y6lwTeGnWw
	ciQuQbY41f1rvmxoIbdZ/3PU1NHshZxRctCua7Y+BUR84PMHx7kBZAtzh5NnNit0
	JZL5ePvqcCC9m1i8DYMblcWitE8ZI5TKLLw0p6dkDEOEMEugVprZW8TRCLlX0tLl
	wPr7I7qjTCisNOiBr8WzkALOjpMXEr4QUZV6Qc7E056eLqQVMThGegq6mmohMFpJ
	InvAsydPZO2FxLgJQe8nAvHTLPiQfNGJVITI+9D7MKXdW9T1J/HHwXLB0/sVOuyf
	Oz2xPm7RVKE/P25qWG4H8QFrHmLmX7a/Hzg==
X-ME-Sender: <xms:2bnzaJE-e_ZDSCk85ya_PeXbOFJC9xta3BwSiwWDO39KopimzTkYDA>
    <xme:2bnzaFWqinv7lPACdEZfsNBDqU1KTsGIa2d0KPhevH16EGrvuP-gjMRANSjX75QBC
    8tyKyUk7doI2TKJL4R5IvpcdzHumaIPwjeW3TYn9i-NAoJ82kQu>
X-ME-Received: <xmr:2bnzaALyWFlkLbVOWjkti86qIIPYv-dLc_FoPHeP3OnbtWCjSRtR45jyM2cQf09lpdfowPxQB5AcAmTp_mcBcw92uJs1YS_CeAZM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufedvgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigf
    efkeevteevveeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdho
    rhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    gvlhhohigvshhpsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:2bnzaN_kRKPkYKdQc-i7dyjAUPDp8T9BMeh-LBeo3wkUmnDfKKQmWg>
    <xmx:2bnzaLICy3bv9CRhyAIxYHrFitixdnIvBIT8rrnQ19ds-zo9SZDKzQ>
    <xmx:2bnzaKlfih-5Cm8YIa6OlyG59u9wyqByLMxHOHDqIVxBI5NOw_2XuQ>
    <xmx:2bnzaHOkkwX2BycAMqbnIBy0HkB_-9gPzJqWW3TClANCDkIFcGGMFQ>
    <xmx:2bnzaAG-n4PcjygPvNxWNkaiSVcjS28-64oiQ_6z3whBnhoIjgMQ2Zks>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Oct 2025 12:01:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: El_Hoy <eloyesp@gmail.com>,  git@vger.kernel.org
Subject: Re: Making git grep ignore binary the default
In-Reply-To: <20251018102209.GH1060824@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 18 Oct 2025 06:22:09 -0400")
References: <CAPapNH0C3+bU-RUO6oFHUKLjKuNdm-aXgsFTHFobYVrJXWzr=g@mail.gmail.com>
	<xmqqsefhxlmd.fsf@gitster.g>
	<20251018102209.GH1060824@coredump.intra.peff.net>
Date: Sat, 18 Oct 2025 09:01:28 -0700
Message-ID: <xmqq347gw65j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I think we've discussed this before, and digging in the archive found
> this thread from 2012:
>
>   https://lore.kernel.org/git/4f1d2a8b.a2d8320a.50ec.576d@mx.google.com/
>
> I think some of those ideas came to fruition. You can do:
>
>   git grep ':(attr:!binary)'
>
> now (which obviously is harder than "-I", but the point is that it
> extends to any attribute if you want). But I still think it would be
> nice if there was a way to make it the default (without using an alias).

Yeah, after I re-read the thread, I specially liked the "filetype"
idea that you floated in

  https://lore.kernel.org/git/20120125214625.GA4666@sigill.intra.peff.net/

;-).
