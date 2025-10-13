Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36A82749C1
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 14:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366257; cv=none; b=oi+tXSo1zAmhGz3eWOz7kMf7y/MKrxg81G0G3W0qamVF06YuoW1sujv6q4Ajz75ELxDUjx7VazPaSS7Fu9ZpL4VpjkjY4UpDix+zWiRBpEKhYz9z+bf/lcK9LvU4psq7qzGvjuWwldHfv+KwLkREGtw56zk745TaaAgVPnXXtwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366257; c=relaxed/simple;
	bh=NKpgQ3esENcxQbuN8FOi/B/mJYj+zV4ou14g1trYFxw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QWCDvhR6tOi6t4XDS+vJ/PQWeorpWr0afZIribrEmrLfW81kkBqyqH7NOTdLGG4q2RzaZbeGVkAcnW7Xx2Kk5R/9tH92IMyiT4/N2IBxtnHeGQ7yjupmUPIFWu2c8iYk9AV8xjuyl/Ihdn//ZdSKgtl4dYguN0PnbjWXmO/W+II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VJdvLzIT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P5zG4nd+; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VJdvLzIT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P5zG4nd+"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F27E114000BA;
	Mon, 13 Oct 2025 10:37:33 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 13 Oct 2025 10:37:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760366253; x=1760452653; bh=V3nb6hK6QA
	NMNdmjHzcXSVedpRKe1BtOVEb/Oku8CxY=; b=VJdvLzITrfdZ0wqwr217P4rC52
	DFiuEog4twwkPrXTjm+MAVDnpL/xu12DwyTcAM/rjBk0TjMZz0gtRR2EoNXPRUc7
	mN+t1Kmk52TZC91P8JU8UHXl7/ox91+6rGsNWcksJu2SP9KZ00qDFnjZE6Lm+k4i
	g5pxiY59Ef66fHgjIHHOvh294FRG2G388jyNa4GgGdfkJxSSyB520TsLpJJWQpq7
	eek4T0JZwHFAD7gPIGBBo8s5WADJSsaHAuTnXJBswTRU2ork3TH5fn4kpLuvtyqb
	7FkAvjuLUTFLfnCwfRpVBU72DTgSuU4MNuCHCOXCs+ExofWPARaLnj/9fBbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760366253; x=1760452653; bh=V3nb6hK6QANMNdmjHzcXSVedpRKe1BtOVEb
	/Oku8CxY=; b=P5zG4nd+oYOjXJjK+a1qexC0G7HZV/8eP6TXJF73YcAF/4DMAJs
	6xq5X8HLQRKTlBo/2Jv59XaNqD0qGg5Z1d/ittgS9+oNybtJ4vNDW7O1kmy3wDKG
	adsOPp0iIU7t9SGBoHvVQcArKDLMMWVF16ZnRq7i/77Po3lEZYOaUtzA8hyVio4a
	5KjOYR3z71Il10CMsSAxvHwqBlI46g8nF+DJnbCQ4wZujgZKRc9I3A5+K9w/RgZw
	38hoBzDXr5tJ+aKUOAvgV3g2o81h2sGu8jnjcyoFS2yTlpZ8EsXYMogXrkiBcODT
	Kt5ONtZBDATxMOc+qIo9OSDag7Wb3m4pf1w==
X-ME-Sender: <xms:rQ7taJPbaEkRU4uv1wEwTOKPReqLU-2FZKuvRk7RWRNdoVPjpzmPIw>
    <xme:rQ7taC9Qnr-JtqJyUL17LtH0uwr4p5IF2wknVH-qxNODycTznuEkqjz7WKPVtFAkO
    KbXJXTv1IDHFhWkfpuVUqQiPnSDBpQjUBqMk_3M06q-L8-EvyV73A>
X-ME-Received: <xmr:rQ7taNRrsO21NGMLmV0jM_PgBkqB-k0LZBfiYsVG2mSAT2P2DJtUNcrfmm9BzCs84jGFtWAk2GIjKeA0cx_VLuJQuETYuG614RIm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudejleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehkrghrth
    hhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:rQ7taElvjs3ij0MI5j2lesQODN5t0mLRifRJhWpYPx1XJWq8nf-PlQ>
    <xmx:rQ7taNQtLhDYq7K5E8Ow6eBMovBWwcVMdiHB9LMrstrL0q7dt5W1-w>
    <xmx:rQ7taCNJ3MZKUVkJv4HNLM6gwK-WChS6KHpTRifInck79AycEU33MA>
    <xmx:rQ7taGWpr-MNEBPGIlVdmOg3KE9O9-0M56NMnyEIrpgHCkWRpaTw5w>
    <xmx:rQ7taAwjTSgr0Ok1hh89ospJaGtjg7WUYCu-QxuCr1UfJUXzLWUm1Q_2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Oct 2025 10:37:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 9/9] refs: add a '--required' flag to 'git refs optimize'
In-Reply-To: <xmqqwm4y538p.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	13 Oct 2025 06:40:38 -0700")
References: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-0-c7962be584fa@gmail.com>
	<20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-9-c7962be584fa@gmail.com>
	<aOjsjpE1vuFUXXbh@pks.im> <xmqqwm4y538p.fsf@gitster.g>
Date: Mon, 13 Oct 2025 07:37:31 -0700
Message-ID: <xmqqh5w250lw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Perhaps "--check-" followed by a word specific to what we are trying
> to achieve (e.g., if we are trying to see if auto-compaction is
> necessary, "--check-for-auto" "check for auto compaction")?  I
> dunno.

After reading what you did in the previou step, I am reasonably sure
"required" is a wrong word to use, with or without other words like
"check".  Semantically it is similar to the should_pack_refs() check
that we use for pack-refs even before "optimize" came.  We expect it
to answer this question cheaply: are we better off if we repacked,
or can we go on without repacking for now?  It is not about "are we
performing so poorly that we MUST optimize now?"
