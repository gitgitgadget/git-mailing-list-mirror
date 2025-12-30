Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9D8B640
	for <git@vger.kernel.org>; Tue, 30 Dec 2025 04:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767069517; cv=none; b=knVcIGvrUlkCB9rbYsY6mNYhARUEuP55dvQjbSCviD9oa/M9GA5UaAdu1gmupuOXvxJfn5NkTbJ3HVlXbVYi7lyh2v9BxOfA0LQcNbJEmRp6EsYoRkU1pZcMnYPqxj+brOTZDZZ6ANKQ46nhaovGNMzl67PDG0O/d8VPGYVM/eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767069517; c=relaxed/simple;
	bh=TGhfWG+vXE+fF4YEOfyzqHov8Nod2vV502e+YwP6mTM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tWm3RppVjBRJ/UkV4PjJbJ3V9ns02D3LSPloHFOTYOhTosdJMnO56ugoqGdAQbBe1tQ5LrC11SpwnX2WOiURalV1z9ZMiUvGrxw5z5TeaofK9j8CWVHybFDyQ97Yv78klNqkKfNSfpxeILGhMU/49S0PfHhOpEBbT7yMO0FAS74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ay3ZfjSR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N+VtAe+z; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ay3ZfjSR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N+VtAe+z"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 119F37A00D7;
	Mon, 29 Dec 2025 23:38:33 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 29 Dec 2025 23:38:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1767069512; x=1767155912; bh=j+MEPocBLT
	tZqy9RrxB9yP5w2s0n2URZjMU4CYPNeb0=; b=Ay3ZfjSRziokP8/bdSF5CCBba3
	5roJljVxyftefVZRV24K9p3u4vFtodlS4w8AJ757Ra+WjvnUn1VEFNxZWCOd27Dr
	mcZXdNFg9Kn4ZL17rCTTuCsqcvQeU1ukb2Zj7D3a6HH2jhaVdrdTiPVPOIf3YtBj
	5Essh/foqB034YCWpY8DDxhIh+6GYzzm6JbETqsWyIyIJT53S74Xa3AnrKvz7uzV
	ne+jW0CRiEHmZbGYuQIBsBp20bJVkhOLolh7Fuf95OXMJX9tS6j1TkHQG7fI+phu
	ns/pe/jz9M+g2Z3n82iT7Ds0YxHtht8kBnGoRD6M1XM445ZctcvzcLNiImKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767069512; x=1767155912; bh=j+MEPocBLTtZqy9RrxB9yP5w2s0n2URZjMU
	4CYPNeb0=; b=N+VtAe+zD0sqce4qRriaLeY/VpmJI3iRVxWPIWQYk6vZZx/Mw2f
	dMkQxfdj8wmdSzl6UC0B67Mp68SLXu0/hDWHQ3AwGPNhhdnPHJ4/8H4B8TROJ6YM
	gCwcGSXUuQACnc7gtuHrrx7J8nJ6QDz1QIviWMc0FSIfuiZ/+f8l0bbDfiHydBC5
	1hKTMfKMx535KCJLWcdlQp6XspnWqR2G4hhenEjrHUCXG0IYIlD/KPqP7oIWrkDx
	rbKITYV6epvczgsZ/21VbSdcfqqWxwN6CL8oLLhRL7uZiAKEDq+ztlDxhrAqdZ2J
	5Cvhz0bTqUNjJ3IAKyUTFsh0X3eAm/EvbEg==
X-ME-Sender: <xms:SFdTafFg1y3jX9jXBva2L20pvwvKbmOM8oTMuZU37LRQ8_HkZb3R2w>
    <xme:SFdTaTWNJ8Uo-pQofB3iKE8pWx1ZI6o7r1Iavc4Dlx2qE2IvaQvAzg0bzPCHN9who
    s2PBBq0u9EzaYbvFbNDqCj7HIqFO967YgcXJxxqmXpQFntYLqTAcw>
X-ME-Received: <xmr:SFdTaWLLegt2e2zQz5lNsaJWSRdvKBiYtlkSjntHoieDgQygmUPoHHWluYzG3Ynbd8qcLOCJ70yZNhobVm_r0A6sPW1dDzYtKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejledtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    shhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:SFdTab-yeoma7FshM3rOFLLMmVQlEeEA9DjaIqvpkAYJXFI3saVzMw>
    <xmx:SFdTaRLrKt264mMndct4Dd6fZ8tx2vjkXRAfJxFfAo-OUX_qDJPCTw>
    <xmx:SFdTaYmQplk8R60ddOSCfokZNbOVLvuXLsgq0lmtvyRtUCnYVW7t3Q>
    <xmx:SFdTadOz_WWD4hprmIMrqeKK02I_lUrjBkBxve4Y3ceKcj8Qnss3pw>
    <xmx:SFdTaRpApxKzIQ4B4_rGhRgc99bwa-3jSh-SDm8TEUTVMD94Aj-GFyuC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Dec 2025 23:38:32 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] diff: avoid segfault with freed entries
In-Reply-To: <pull.2027.git.1767044697712.gitgitgadget@gmail.com> (Derrick
	Stolee via GitGitGadget's message of "Mon, 29 Dec 2025 21:44:57
	+0000")
References: <pull.2027.git.1767044697712.gitgitgadget@gmail.com>
Date: Tue, 30 Dec 2025 13:38:30 +0900
Message-ID: <xmqqtsx8h9dl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> The more elaborate explanation is that within diffcore_std(), we may
> skip the initial prefetch due to the output format (--name-only in the
> test) and go straight to diffcore_skip_stat_unmatch().

That's very interesting.  We have code to fetch on-demand when it
turns out that the initial prefetch shouldn't have been skipped and
we need contents, so in that sense, the condition to skip the
initial prefetch does not have to be precise, but we may want to see
if we can have a single helper function that exactly tells us if we
need to look at the contents or not.  I think we had a few changes
that made the definition of "diff status is based on contents" in
the past few releases, not for the purpose of this prefetch skipping
but to set the exit status.
