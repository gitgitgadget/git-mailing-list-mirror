Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65F936C0B0
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 15:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771341757; cv=none; b=icFU6yOUV7VUL+/LDEHMuspSZ9/aKpRBlqxVT7yLlckIfZfKzA8BkJs6Nv52yaorBNQgjmKZVEtl6zvCN5Q2EJxqlhgvA0P3Ho+FBZ83M0Pan5Eg/BNF2OKYNUyBpKXj9l2yRCsU+aldBj3fq1NCos3OxiB+gbfcr1yz4iEnK+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771341757; c=relaxed/simple;
	bh=ZHDQbRQXo48Sgsq460t8jhLJWKRceg7BIeJJxsFK514=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WKQyprt53jJl/ybZ178M8IEeNqJK1GXMGOIw8c4lIVUYCWaA7k2BjhOOS1cV6M6K1a2MDefV52vtjljjOcSyWRcvoWy28RSt2aXcJTtcw+/rajBeNMGhZ03gTGW1R8JahntQiwIHdlH4QZamC4KRAGZiygekoXIWLGPNnEt/bh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=2I5KC5Gf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dxj9FzTP; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="2I5KC5Gf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dxj9FzTP"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 1B8C1EC0350;
	Tue, 17 Feb 2026 10:22:35 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 17 Feb 2026 10:22:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771341755; x=1771428155; bh=hqeTO8gFky
	gJlVnVv3FFfzO0HxcKHXYQcITLXFHdzXM=; b=2I5KC5Gf2BXqPwX4Tx0ZwM+ToZ
	f8OFyX4KJmzO1PSxojidqIZPUGBYshYQTCLikQAQ/LUsLKjHP0yWNHbpqWvgsmDT
	CkDnaadMFaEat4V+rpaImngYGzcfRvb5sxraFt9vHlpyegCi12qJ/eRN4YzZKbuK
	SkMXaZBnDpbWUkwyOJ4umRLPRAPey+z25eWPSRL+e8oJHCl5kzpqNmeL9dQ2FGSL
	L7dG+pI9QmlnoALog6M7ytV/BPKdyRVYetlP2wOmWrEcGIrhoRxZqbt0aEHZL8fy
	OtvrgnxKi+WoRFz7LdgyHgAcHXkm0boPGQ6cp88ND4OEEwBty2fmIGeStTug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771341755; x=1771428155; bh=hqeTO8gFkygJlVnVv3FFfzO0HxcKHXYQcIT
	LXFHdzXM=; b=dxj9FzTPSOy9B8GCzRXRYnJrg3yLVQcmYakdpenrZSEiIJwD4Vd
	ww8MRnIcajPLvlZurFE8DbJIfUHAWuJSeKM7vyHQ86HsQRoqv6SUculUopDxDW59
	eXYIDVw9UQ+Iy4bosPrGQ/xj57yWnlMwHyMOpexxth77mApzXNBy858J0FhNe/4w
	MOkBUvDYWFOs8qd4gtDHSAkgh9JD45eWOumbhRxafhX7Ei4FM9O6J+6+2VEpi+/6
	dCi/fBwzBM4OTTokNvji8R1xXmR88Rqcp+SL5RHO3ug0bAfcDR2Mr+xWJ1za2I3X
	ykJkdFGvHOmdw3qtPwnfAqq+sF0MzQnnIrQ==
X-ME-Sender: <xms:uoeUadFsDKfAYQNFFrUx5OKp4GG4Sn91XR7iqJbrtPuhK4I3jclHgg>
    <xme:uoeUaZMB5_Mo-uxN3nRpQ5OfPSr4P-wJeClGLT_oVH4uY3zSf3ancLN9i7zCZp1ne
    mLZE-7qTPxK7zP7fhnSmcsIOXTxMG89qYkuouMwnCm2keOi3410DA>
X-ME-Received: <xmr:uoeUaXdQXPXPi2sE9mEk26g_hGVAFW4zhk_YjIJMULScupnmfZOhNqwVG5C1E6Fd7aVlpl1JcDSjndsfGV2V63Bfbjg1kj_nwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddtudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hpshesphhkshdrihhmpdhrtghpthhtohepmhhrohhikhesuggvlhgrhigvugdrshhprggt
    vgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:u4eUaetW7k1v94VZssoJsAeuonnGuzTae6YYxMOv5ozthEGbe3bSnA>
    <xmx:u4eUaQnhS3DCRYqb9437QyROvzegOYFZ41ahKZfubcrP5OSXSWcNXA>
    <xmx:u4eUaYxAxUKA1GWR6hRw1b1c7RU1hphQjwEF3apOQMFw1cpd8LTIDQ>
    <xmx:u4eUaaOLQ-Wl6wSq6YqIFANqpOlJoNVU7pN2r33_beAPUt0FR-Vd4w>
    <xmx:u4eUad-nHb2NHmJRN5EZOrxmg9OWtOk4ZkMVF2KVRkojdEo-ooTAEgwT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 10:22:34 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  Mirko Faina <mroik@delayed.space>,
  git@vger.kernel.org
Subject: Re: [PATCH v2] format-patch: fix From header in cover letter
In-Reply-To: <20260217063400.GA101988@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 17 Feb 2026 01:34:00 -0500")
References: <aZAMr6XOwKkTa55q@exploit>
	<20260216152730.37478-1-mroik@delayed.space> <aZQJEDyUyMv4_c1l@pks.im>
	<20260217063400.GA101988@coredump.intra.peff.net>
Date: Tue, 17 Feb 2026 07:22:33 -0800
Message-ID: <xmqqecmje6o6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I think that wording comes from me back in 2013, and I just never gave
> any thought to cover-letter generation by format-patch itself.

Figures.  If "--from" was done by somebody who did not know or care
about the cover letter, it is totally understandable omission the
patch addresses.  The log message may want to refer to a9080475
(teach format-patch to place other authors into in-body "From",
2013-07-03).

> I never
> use it (and I probably forgot it even existed, given that most people
> would use send-email's cover letter generation, and I do my own thing
> with mutt).

I use it myself and I really hate the way it lists the patches.  We
should have done "log --oneline --reverse" instead of "shortlog", as
it is hard to understand the reference the cover letter message
makes to individual patches like "the first two patches do X", etc.

> So I think the direction of the patch is good, and I agree it would make
> sense to clarify the documentation.

Yes.  It does make sense to document the change in thinking in the
proposed log message and in documentation.

Thanks.

