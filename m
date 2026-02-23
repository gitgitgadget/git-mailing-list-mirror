Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013DF32FA30
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 17:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771866626; cv=none; b=gkOBJfzbQiWgzXpJSKWsfVxeECc16fPjE0opw/UyJOaYvtojTzXptbdURzuFUd6SM/ELbD3nqso66p3QrtH+XpQIjrKTyhgsnl3OSIq/wWVcnr5cbZ9/EXyfk9kFVQVBlq6p8werZKt16NTlxNW+AfyC34BSZ95MWRfJ1vzkYaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771866626; c=relaxed/simple;
	bh=v/yMq6y/Ol5rVMhNYO68HjEEqK1LUWb3zSrMROVMiHc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mGT4Raz7wFJZnvkGnFsOp0D68b21QHVYdTR7gNbCIbC0I6Bg8qRhREWstCe5mmglnbb9wTfjEC1IcRN0bNA5DdsrideifRBMKQFmtabPoDOqHMhMn5gWFLQ/KGs/X+4Vumgt8Awk1GSnpChJbrCNjt3AeMyeJ3Ud1xsfwsfYASg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OGmhJNmx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wb7CtR1t; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OGmhJNmx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wb7CtR1t"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 214F214001D1;
	Mon, 23 Feb 2026 12:10:22 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 23 Feb 2026 12:10:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771866622; x=1771953022; bh=3ONJjpPctX
	dH0uQ7Pu5uMc446LdD2lYtSmD1ngXpFs0=; b=OGmhJNmxt/Cg0yrVsorybS8UBi
	aOu1rZZMz3G4PsaFX0bZmdLmq3wFMNTHntjeaXZvq4OupEeNdwiYLOCcX5P87jLW
	TWukKP+xVEdoBLklBLy5Sillzt4w7Bku+XhNjGLhePkqZvXWGWyk+XXv/VWV/89J
	j3hkJa004vielzPmxkfljwg+AQj2AWj20gjtOgUIeJbrtgTvtlsNl8qOqKrLmDcG
	30dzdyoFaCbGarcvqeOOX7s/gHT7U7Sde3Qdi/I6U9pK2qQdvFcB5OQAkEJS5uu0
	SL+7ZX/kudkMlAge28qRFMoz290CyoKTwwsIoQxGiVYemd3jSogQRqAmGN1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771866622; x=1771953022; bh=3ONJjpPctXdH0uQ7Pu5uMc446LdD2lYtSmD
	1ngXpFs0=; b=wb7CtR1taKuCOqb3uSTCTatdYozEHrXKNexmlzJ6U5RQtivbbfd
	jLhNXgPmB2hU8bf6bDDRELN5rPWBbm9yiRtKbgyDJ7X6rG9OW6F82OZy8rWV9Bsh
	RefzXV1/xySuXgafYNGoQbdZDNdheP+SFaEq52XaaAHfHAIM88rsVNnJxxqyj3H4
	GpkVK9DeNa+CsYtRIDMMXT6o9+uJjAxAakEwDdKRqO9jQVtl2s0iiU7pCDfCD0ME
	bd8qIQCpCe/j2Mj8tTivBz6PQjEfF5rj8hkZl1hEWlu88WMIR+1UYVmWsj8rZDFS
	MVqHDm+VW2STiXyTDpDzJxYoE/GNx38yLxQ==
X-ME-Sender: <xms:_omcaehh-JUCrqbx1I4t4KJ1nGeSytalDz7Ny11iOoVSh44Pv5l2LQ>
    <xme:_omcaWDgxtco3xwLiR6I9D37StEbgy_o6GGJU03gAi9ZZu6jqbFrH46MEm-EM-NeD
    8DwBa4NeJltvMQQT3hOv5HP91baMAYMU5Cv7iv8MDR6DRcquFnF4w>
X-ME-Received: <xmr:_omcabHWrRMMkiPG_xpS1Oj8XXN2IBDejHcpKA4zg-KaBFzqzBsHFA68x22ZNMnbWX-ci7ZPvFHCsbTx8bNpGYO16hWiIqrd8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehmughfvghrughouhhsrghlrghmudelkeelseihrghhohhordgtohhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:_omcaWJ9M9LlvSufClwDg3-FFK3P_VOpCAhUh1ZOWLOraE6UyK-cKA>
    <xmx:_omcaXmkKwJDxaMWj0pzWfPAyEMlm0n_8B-7MhdNEKOnzPj_tfp0SA>
    <xmx:_omcaWQLfP5Ej_EcKm3sXZvPbCRBRkwA5lQJHZEkx2Ba1XxfPSPVIg>
    <xmx:_omcaRLFJ40m7SS5qj3xrYx2uyU3RCHWswFoela5G-K_iQaR-Hd9VQ>
    <xmx:_omcadHZpkzoILPqTL4JkHp_cvDedh4qSQhbq9l8r3heH-KINHh2iTso>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 12:10:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Md Ferdous Alam via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Md Ferdous Alam <mdferdousalam1989@yahoo.com>
Subject: Re: [PATCH] doc: commit: document special date keywords for --date
In-Reply-To: <pull.2051.git.1771836303147.gitgitgadget@gmail.com> (Md Ferdous
	Alam via GitGitGadget's message of "Mon, 23 Feb 2026 08:45:03 +0000")
References: <pull.2051.git.1771836303147.gitgitgadget@gmail.com>
Date: Mon, 23 Feb 2026 09:10:20 -0800
Message-ID: <xmqqa4wzo077.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Md Ferdous Alam via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: mdferdousalam <mdferdousalam1989@yahoo.com>
>
> The --date option in git-commit accepts human-readable keywords
> like "now", "yesterday", "noon", "midnight", "tea", and "never",
> but these were not documented.

I've always thought that these are easter eggs to be discovered,
deliberately left out of documentation, as they mostly exist to be
amusing.  For those who want to be precise, the date formats section
gives sufficient information.

Other than perhaps "now", which may be handy but not so useful in
the context of "git commit --date=now".

Moreover, 7.days.ago and 1.week.ago are also in the same category as
what you called "keywords" here, but we do not try to make an
exhausitive list.

So, I dunno.
