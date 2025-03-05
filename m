Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A662119F438
	for <git@vger.kernel.org>; Wed,  5 Mar 2025 19:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741202925; cv=none; b=Vj2y7+d0+0lnMsCIPtv7SWSZDC99GUMBn/Vjbo9YtMWYWX0U9RQT5UF8uRx9POlgCMyzRYAtysf59gxsaheFxp7UOIy0lULvPiqKL5TbU3SaUMbcRcp43aKEiXZKem5g9zYxpyDieYsVSiAoCF5vpudEY/yxcuOkmKpkTftzO5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741202925; c=relaxed/simple;
	bh=OATucM0unpW7Qabo28112b1Fzffo3qMkha4BfrqTTB0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XcN2nequ9Qu9UIffRFMMvsmV2AiM8MGyZ6ook1jSWnViVT+LjrQxa2F59mk+VU587yM/jinnusy7Hx7Ec9b/tEqwJV/HDLWpJItTIcTbAGdb7HDfx8fMcyOO1QK7sh5o5mbmOUgpprF8yLfJd5wXlsj8EXY2LZQP1G6qgfXngP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Apl8Wlnb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hMKinvJT; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Apl8Wlnb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hMKinvJT"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A3FA01140093;
	Wed,  5 Mar 2025 14:28:42 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Wed, 05 Mar 2025 14:28:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741202922; x=1741289322; bh=9bBnR02c+w
	YkpxpVrwhtmMJumAFS/FctAaVejSX1vWA=; b=Apl8WlnbjnV0+livaGQ5okdnUK
	cFsHNY8+ggy+qj8dzOy18mamhphejzrLyC91WdDJwD/E4r5WONTaNhSd3f/ROVNL
	KOQ22V9ZQWX8P413hTAo31jspcVSf7M4ldK6wFOkGs0ta6QXQNJDTrWyhu4QJ/br
	MieR8c1Hdl+AJDyHhnjwp+mO1jMfdojPYngjeHwYpw6I/cN1ZBcEiffHHxUydnAr
	Mh37uI8majtKZK9llXtnEvenzdL6kUh4lTXqxVK35k291d+8mkyq9L1WU9XUb3S7
	U04M5EhOyCycENg85BzpYieJxebNW6sSf9/nM/EEJS9rnd8V2mnmQVFvB4Sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741202922; x=1741289322; bh=9bBnR02c+wYkpxpVrwhtmMJumAFS/FctAaV
	ejSX1vWA=; b=hMKinvJTAmNUC6BByROSREr1muK5p85FWyPb1KIL8o/c+AaiAup
	P1VIv/55J1n46BaQq22lAJKwOZ4w7UBh97t/BilxyO341SB6XOhXulD7Ftq3aC0o
	VonpKIbpMe5DvJ5S/L3lG0rPrOJ2q04iydS0+xTMsDViNjIBfbdtZBFR4RiNYH0r
	omA+srsrIdmRIOojPiIiUCaUjMddZdfI98ZHnsP76wUu0M6lrCS0zIv/d1l8buqQ
	ME/Nt+wz3nvtHuuX+e2+ufyBNhHchPBJtxEVW8TOqgQ9W9xwswcZK6wWe0ibABCg
	neZS2fCRXRUIjp00UDu1ot7+kQuiliW5TsQ==
X-ME-Sender: <xms:6qXIZ9CDqmve4AylepvUTqGNNK8uvCUaH9FlHc3gA81gHZBPn4jvBQ>
    <xme:6qXIZ7gbvTX2XXfFdTC82zdl2cG4aSbfKLJaL2zI-iM68roJsG3F9f61vpHgU8uOs
    5sjCsVYXZ7uG1Fi1w>
X-ME-Received: <xmr:6qXIZ4l1bN1jjww0SeoK_i7R7RJhlfphhLtCU75XRi4egdBYbnkhIpy44uV111AZf5IM2IgLF-rLavtp4VAknyQ0GA6GLDi053Wr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdehieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehjlhhtoh
    gslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougdu
    vdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:6qXIZ3yN9iVkxoJSCFE0KF99YVlj0_os_UbL4JYRY25m2RQ8qZAXMA>
    <xmx:6qXIZyRqq99gjZ0LAucC4zOUPGQFCmW0GQ_xAmlv_pIi25qdBec8IQ>
    <xmx:6qXIZ6Ylb8-ESo44L9eqqamFmyupsmO1EyKc2nyzRUiLOYn2t-QwYA>
    <xmx:6qXIZzS9y0mhJLZZ8p82ObUK9DWzivqQwKfaD9KE1gctK68NhFVVhw>
    <xmx:6qXIZxF9ABGaYo6uYaChgMIx09mYnfhIVjuxB7NSl93c5ScUJW6pQkAC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Mar 2025 14:28:41 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  jltobler@gmail.com,
  phillip.wood123@gmail.com
Subject: Re: [PATCH v3 0/8] refs: introduce support for partial reference
 transactions
In-Reply-To: <20250305-245-partially-atomic-ref-updates-v3-0-0c64e3052354@gmail.com>
	(Karthik Nayak's message of "Wed, 05 Mar 2025 18:38:55 +0100")
References: <20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com>
	<20250305-245-partially-atomic-ref-updates-v3-0-0c64e3052354@gmail.com>
Date: Wed, 05 Mar 2025 11:28:39 -0800
Message-ID: <xmqqo6yfl1js.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Git's reference updates are traditionally all or nothing - when
> updating multiple references in a transaction, either all updates
> succeed or none do.

I am quite confused.  In the beginning (traditionally), there was no
transaction to speak of.  You try to update two refs at the same
time, we did best effort but that was never atomic.  Later we
introduced transactions to optionally make the changes all-or-none.

So, if you want "I have these N updates, but I do not care if some
of them have to fail---just make your best effort to update as many
of them as you can", why are you still doing a transaction?

Perhaps it is merely the phrasing that makes this proposal
confusing.  If presented as "non-transactional batched updates",
perhaps it may have been more palatable.  I dunno, but "partial
transaction" does not quite sound like a transaction, at least to
me.
