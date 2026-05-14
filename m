Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE23731ED7C
	for <git@vger.kernel.org>; Thu, 14 May 2026 15:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778772991; cv=none; b=KSXNGnnbU48HZrAL5HiTI1sSXkulRB/J6sqPnSmbN5LUHNkIneY0I+wlFr3iniJ9G35MjQpUY/CmC0hE2KPPe0qp2I0d9EVp5mnZC6HJ/FLOEFhj0ScUJ4kujKLAdZqhwoS94FHJ3QIpY1PHAhJB4VnXXFuSQyQ+Kef105a4J7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778772991; c=relaxed/simple;
	bh=UqSdI4bH2WiB4LXtJXoSg9QuXV4LrBD96ekwROJi1JE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SmZi99Q1dxK4uVIB49XEjapVoVz/2G8veMUbeKMWuQJvFOrHNLdPBvlaO4YPiu967Zz8rdSAOZ2NL8+QmyB8kDsa0hPkcojz9kRO7f1V6B72GOrPzxEa1uNrvouof32CunBUU63aqaKlLfpaVy305MJTBfvRR9JenIL7Urm8Zik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rxuAEgWi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SKWkPne1; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rxuAEgWi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SKWkPne1"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 0A6E4EC00C0;
	Thu, 14 May 2026 11:36:29 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 14 May 2026 11:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778772989; x=1778859389; bh=oG12x20L5J
	iV/eWUfooVuUZ93PhMqZYOwdiYoe0jk+s=; b=rxuAEgWit36qg32Iv/A3xVLCBl
	FroZ3oknP91lk15rVHVynwTP5nqvuwRV1Llab28MNAPnX1D9WvMfJ/wjvJ+aeY+j
	BClmiTV4isRHadrzBx7vK8p851EkSNWrenPRFSCAjND7La7NkxaOppWdLugFEty7
	BF+pd1iHt/o6trfQKQz0uxvYYwUKMlwR36UX/xLxxNJ2WULaihx8Y0UP4n4rMinr
	FNf66DtEIuEG14XbcGNKdzp8EpsfkYx3Zx6oEwZ3w+Ea7kvW1j7szMyJcOu2kdFu
	j/yeiX8AXP054DsHB2LHQterHO6g1tbpUkW60GzcKHkODaj5LGyLkYWg/YLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778772989; x=1778859389; bh=oG12x20L5JiV/eWUfooVuUZ93PhMqZYOwdi
	Yoe0jk+s=; b=SKWkPne1VaEVizJx+qQFk62m5NQx94T+u7jpUNvSeIPr5gOc9P/
	luJ7pNjyj0DF3fSW+UztE2WP+DsYz8UgQMhxiAUo7Awbz4j7fF+9wIvyvrSD1YJn
	an1mv/Es4E6DtJPmnfXurf9WMnCOXDBXg1hC7mOPMiAMGJ9lYT3orLdCGmuN4vHd
	ItQp1+b2DGGiZ4xWnCDPz5cduT10m4vHkpz+hcIDxxZt14LN6R4fP5HO9mMJtBuy
	/fhvn+kcDfPDz1mcYUE2jx9Bxs+Ynct6qPoA7dLKK40Fft/0+pgmUhvFcuL6rf4n
	slrfhWh0NNdoMO2UtC4DLwPdbU4OrUMQblQ==
X-ME-Sender: <xms:_OsFapRNmTc3NHvrm5G9d02CX6RIR2XN21s6SoHl2V-8YSueFK2lFg>
    <xme:_OsFapzAl6fj9GAMY8tKRIAEEgFMuALNWWU--0mQlAae8P09VdF-y_gCMSC0b54L2
    BnxBsF8a8q6d-nz6Hjft322ztEQXQ9iDLt5V3UobnFPzKcgnRDllw>
X-ME-Received: <xmr:_OsFaj04Y_hk-XwHgGThAKbLM0ckL4cXZByA9UM5Y8i1C_HXXcMx3TmCrx82Vf1gHoSzBKy14M309EfhZArdT8EZ0jjA5V5VBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdejkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthgrrghhohhlsehuthhurdhfihdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghf
    fhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:_OsFav7NIX4tdm-U5JptCx0O9mGk62nqC2fpq-GdC43BTVxwYtEEQQ>
    <xmx:_OsFauUe4Op_7gzSeWCFdwJFnpZLNV6tFhZpirRdEX8WFSIAIM4cwA>
    <xmx:_OsFamAz4bzxkPbVZpjyFjFbbkQ1aSRP_t8ErJz6pcLv8FmkSk1XzQ>
    <xmx:_OsFal4zduRCxRlUrgPa5qVbTUSijXrr6Bn9EpACVI68ZvkUhuGruQ>
    <xmx:_esFauUtYCFxdmIzU8KY67RaRUywWD4-FR8XcqMOyIbWJIdzldc2q3GR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 May 2026 11:36:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tuomas Ahola <taahol@utu.fi>
Cc: <git@vger.kernel.org>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/4] approxidate: alias "today" to "now"
In-Reply-To: <20260514115520.6660-3-taahol@utu.fi> (Tuomas Ahola's message of
	"Thu, 14 May 2026 14:55:18 +0300")
References: <20260512145430.13212-1-taahol@utu.fi>
	<20260514115520.6660-1-taahol@utu.fi>
	<20260514115520.6660-3-taahol@utu.fi>
Date: Fri, 15 May 2026 00:36:27 +0900
Message-ID: <xmqqwlx6f1fo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tuomas Ahola <taahol@utu.fi> writes:

>     Sorry, I don't know if I understood.  Does the patch change the behavior of
>     that command somehow?  Is there some kind of edge case I missed?

No, I did not think it was a good idea to carve the behaviour in
stone that "git log --since=today" behaves as if it were given "git
log --since=now".  My reaction would have been very different if we
were deliberatly and explicitly saying "today is synonym for now",
but the thing is, it is not a designed behaviour but what
approxidate does for anything it does not understand, e.g.

    git log --since=decay
    git log --since=bogus

all behave as if it were given --since=now.
