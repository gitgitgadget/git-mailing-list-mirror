Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E38289371
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 15:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749224305; cv=none; b=UdprcQlOu4zOoZ0tbUCCF2bG3EIR5RXujuOAeGIoiavzWf7fU7bUjdIyWrGCD+10mcDC4F8HLsTJqRfNNJ+qzWlMLRjmjuwAlezC0+8bcU4NsWjSTxV4l2K/LFXBiBiOolqYB/GEWa0U3c1xrEAfyBsgJz9N2EeiM9abVvvpCP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749224305; c=relaxed/simple;
	bh=8nFgGwHagUbrG76y+jo4CQlE4c/JE3Snl9ZOqJkZf6M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nVLx44rZziiKS+X0UHcUUbWCH9PB8pVaLucEhjPtQu0uDoOTEw7vbCSsaLz/ruX/w9MhxK0ZiddOnBwD8HzsZi9fUnVZ/Y+D432rWw3cn+K9x5naYghUjwJWeOzVlEsKYvvA6xd+yqif8M69r7eXo9M3W846Q2jKcBROHHyp3P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=A5rRCCjd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TK1n8FjB; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="A5rRCCjd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TK1n8FjB"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C15E62540082;
	Fri,  6 Jun 2025 11:38:22 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Fri, 06 Jun 2025 11:38:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749224302; x=1749310702; bh=8nFgGwHagU
	brG76y+jo4CQlE4c/JE3Snl9ZOqJkZf6M=; b=A5rRCCjdzp1NjBE3yLjGRdFFuh
	8Wf9yOaST0eK8LwWigarnoxHyB90vi7E9SHnOwGktVY+4ska6bNySC9GZKHuXwGS
	iyOcUJvzVT6H/tAhf+LmtdNdTH4s2NMSGPOKwE0JHvHGYIW3cgThcVeUItX39pzK
	+dLAXMYM5b+Zbb+dsEigrUyuds0VgmwzwDsNCNC2zEkynRaeu9JsMKqPy43E42wW
	Yey1otjrCVq9w6mZyRtwHhBwtfW0Rp/TMf/w5reN5cU1fspFQYMUIm2tHlKwXDXa
	crTZ+CBkK3MBdswzo56c2a/Ozhih9O3e+NaU2uudi2yCQLvV57uxCg5OCx3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749224302; x=1749310702; bh=8nFgGwHagUbrG76y+jo4CQlE4c/JE3Snl9Z
	OqJkZf6M=; b=TK1n8FjBoQUPMPGYXFoUh1kTOglUvPhgZ42gK9R/7mGjOofvRn9
	gzUaNbmYx4Om/JiJb3Y5H2KcR+UrJLBlETkJ1yw+x7WlcSFSb06/l7SkuZom93r4
	IyGOedZHW3jLyLy6MBdJLpeMXzqqcndyGlXPSTvEodxZSrRBrNEbSJGK3FBVRDdV
	eZWbKrQmljG2jF6fkFLQIwMFWhnHmCKMhGvf/E+0cXjgHybpf1ztJAIk+wBOyK7H
	3fBOzTF9Sk6SN+P1fJ2N5S1IXcYHTk/40QWPY5aI2EVeAG/mRJ5bILtvFfdhlYcw
	TR15400ilGgSVaOYZ3JDtmD0xEAtfyRcN1A==
X-ME-Sender: <xms:bgtDaOMYeupYdGZSNg1P717Szy34zF1O8hDxNIYNsg_3ofKffs2sTA>
    <xme:bgtDaM-mkpsMdCxEsXt85VKMAefrmpFGdmrMJg7xiyPDZ957EG3a9qWRZX93Tn-2I
    fxJqr8SqDXuasvemw>
X-ME-Received: <xmr:bgtDaFRYgz-1E8HWzAZMWkE3W3DL_U6GsEcV7rQjYT7FRAPWl25yZXGHDFScHmo-az1d0qJiPj0uIzvkNhQEtCA_-JAIKQsgeJCm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdehvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkh
    hrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghp
    thhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:bgtDaOt_m5ZRwGPJnZxnK4YbwcOxXEKOTdxdeW4NJ2vwlr08KrI8ZA>
    <xmx:bgtDaGddCsgOjOIEtRDwOUqDqQTVX5OvT9chyQRmYyDwM942F6nwZQ>
    <xmx:bgtDaC3rLmq2xhDk0Nx9aE2VuBIiOrS8k5D-w5ocXBqKEM2jCbX-5Q>
    <xmx:bgtDaK8hXqOPAk4KMbBbvVnMrMLCc5Qa6ZO2GjSP6svgschfT7H--Q>
    <xmx:bgtDaJ_8mNGBCXyYnsqhIBpcPZaNcurySv_nv6WW9pwYgc18z5TzrEEo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Jun 2025 11:38:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 4/4] curl: pass `long` values where expected
In-Reply-To: <20250606100558.GA3591871@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 6 Jun 2025 06:05:58 -0400")
References: <pull.1931.git.1749112304079.gitgitgadget@gmail.com>
	<pull.1931.v2.git.1749202164.gitgitgadget@gmail.com>
	<80de7491d24fb51c6b2c3b2fc1728db30e2477f7.1749202164.git.gitgitgadget@gmail.com>
	<20250606100558.GA3591871@coredump.intra.peff.net>
Date: Fri, 06 Jun 2025 08:38:20 -0700
Message-ID: <xmqqqzzw518z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> But as your patch fixes the exact set that I also needed when building
> against my custom-built libcurl, I'm content to say we have spent enough
> time digging. If there is some platform or makefile knob combination
> that triggers one we missed, then curl's type-checker will catch it and
> we can fix it then.

Yeah, thanks, both.

