Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F013439A045
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 21:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772660601; cv=none; b=GICNXMo89IPH7X/v0tDPxDCf4OVkJiYJowo0Nc/TKdaeBpMmeALzMskbrAsw9AbObqLUgpqzf40U6h+Rt3jXYXx7HIywD1ASOqNtnWL4dIvscfIFIEOf+B3J06DbkXh+0mAtwCdjxBbGBl9BogEwl6l707WMLpFX7bxs4QHIb/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772660601; c=relaxed/simple;
	bh=oAJvYWyE8HWDK9YRSAWLZOrq3CMBFFTAihVo5GI3KXE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H41IEmDlutkw4jFavT4nJ5P+/jusXN+sNMT57TEFDTP4fzogaSdkrmWNTWc6wiKBAlEi8Dmo7j7l18mrFamGNyPnskuDvkFMuSF5JWuznVqJQNWZtBJoawM+gqprCwHVHzOafn/7b1T5YaPmJtbCaYQGms0pgQFPYMJRRPGsMc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hBMpEmBm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lGhcNcv0; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hBMpEmBm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lGhcNcv0"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DB88D7A0136;
	Wed,  4 Mar 2026 16:43:18 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 04 Mar 2026 16:43:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772660598; x=1772746998; bh=6t/jtLTp4I
	zJJCetfhPjNk6oTJP9t69k0UaujQCNu6c=; b=hBMpEmBmOwanHjy8nyiAUzn29+
	DZ3aA3OppN8dluQUXsaDyqVM5J3zUB8ZWRVxGtVvZ7vlKS1RTpvyKPjQWak9GzA5
	mgl9dpFruHdM+vQPvn48x5bCdslwuI2SliyF+pwDpgE2apRRdVlCTu6osGTQQ6Uv
	ZrKY93Yhf2ekA+LZO/xekdXnIvDRagRNmDZ9VuxEy/R8lX/Kdkof3CUUQfHKc3TU
	a+J3mkaRVmwShhlFCrRnJnqioTn0Yo8qyCISXQIB7dDbfR2xT+0+D/oHqICWg1YH
	nWq44AFWx8dbct8ZqublN4IetOOyqi9MYciNyk7+YeZlkdLYgp/irjEY+zZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772660598; x=1772746998; bh=6t/jtLTp4IzJJCetfhPjNk6oTJP9t69k0Ua
	ujQCNu6c=; b=lGhcNcv07/jxMywPaob+cHA3wgGa2dlkTfOxOfB5IeRPuncpPYV
	0Q3igvJkUJvm0+xk5vNbu+zNGUnpQB5JuJvG+pQZraDlIGOPgEDuX3Mxj6uyY6ey
	ZEhy4YCJycXWKLZZi5emiVC5G71mEKRuaDWnPyGw04swb/3IVjl5lssziCi6k4NI
	nqLuTDAmS4NZkbnuTAPWKuvm8DICFAjWnYLArezoyUfO+ZkF+ZN+delzXV9ORnyH
	Ci+HfRo5/CVWCOyabJUfaIKG1y6qBMBRV9KaJWO6zpi6RXXwRxWfg1XCoMouI3js
	1tfhSrKdJ0LC1LrLt8hlTPn6Cah6c77T1jg==
X-ME-Sender: <xms:dqeoaf1bLU0S9NUjMObUQWDxviOIxMctX6QmdK2X5X5anC6PTpVgcQ>
    <xme:dqeoaVE5YDPb4k6ZNFRjSff8BP5KktBUeMfVCEsEKzoQpyTltAQS93uaBgBNSmNbn
    v9al3fU5rpu5OtLYC_PPGrl_a292YiQj21RAX3onz4TmoUZCsPN9A>
X-ME-Received: <xmr:dqeoaU47DdZM_e_Ax7slwNExp-W8qB5y3yW03wyCJT1hDX-CR56OxIIGTELMQWY0S44rvbYgQ4c-vJVKos3KMfCOZSu7mpQYZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieegieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkuh
    hfohhrihhjihelkeesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:dqeoaTti8i95ORlorQ50U99PCUB4hYGjG_hpgZ6xsElp6WacH_Cjxg>
    <xmx:dqeoad4KGpTE_eABaJF6AT35ogKmzeYin12C8K4IWSugV4e36LHkkg>
    <xmx:dqeoaWViGEyDJ_wx8_OO9SHmsMmKzKRSaIJ0DrddUn33oKVJBwMhKw>
    <xmx:dqeoaX-2zyHIdBLwE-xISoh24DpFF0VB4EdbhziwEk1UGnTH759Fqw>
    <xmx:dqeoaQZPQCc5HmMrd7Iu3x-JSadbkAdDarQ8NlHD9o7qW5hl9CEyBzLl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Mar 2026 16:43:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Seyi Kuforiji <kuforiji98@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH v2 3/5] list-objects-filter: use
 oidmap_clear_with_free() for cleanup
In-Reply-To: <xmqqcy1j72y7.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	04 Mar 2026 12:30:08 -0800")
References: <20260227234213.17633-1-kuforiji98@gmail.com>
	<20260302200018.75731-1-kuforiji98@gmail.com>
	<20260302200018.75731-4-kuforiji98@gmail.com>
	<xmqq7brtyids.fsf@gitster.g> <aafX6qva_badx_RM@pks.im>
	<xmqqjyvra9xg.fsf@gitster.g>
	<CAGedMte09S1FE2nX5SnamzqZyMGfme-kL0skZ+e+st-b2HbQMA@mail.gmail.com>
	<xmqqcy1j72y7.fsf@gitster.g>
Date: Wed, 04 Mar 2026 13:43:17 -0800
Message-ID: <xmqqzf4n5kzu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Seyi Kuforiji <kuforiji98@gmail.com> writes:
>
>> On Wed, 4 Mar 2026 at 16:31, Junio C Hamano <gitster@pobox.com> wrote:
>>>
>>> Patrick Steinhardt <ps@pks.im> writes:
>>>
>>> > Agreed. But I think with the current status quo I'd rather drop this
>>> > patch though as it may otherwise make the reader scratch their head why
>>> > we do the exercise in the first place.
>>>
>>> I do not think too strongly either way myself, but you may be right.
>>>
>>> Unless we are dropping the "we optionally let you free the shell"
>>> traditional interface, it is of questionable value to use the new
>>> interface.
>>>
>>> Thanks.
>>>
>>
>> Hello
>>
>> Thank you so much for the reviews.
>>
>> I'll send a new version dropping the [PATCH 3/5].
>
> I thought that Patrick wants to see only [1/5] and [2/5], discarding
> the rest (i.e. 3/5, 4/5, and 5/5).  If that is the plan, I do not
> think we need any resend.

Ah, in https://lore.kernel.org/git/aafX5CmP82WYFyIb@pks.im/ he wants
the callback to be renamed, so we do need a new iteration (v3).  I
still think that if you are to drop [3/5], then [4/5] and [5/5]
should also be dropped, leaving only the first two patches.

Thanks.

