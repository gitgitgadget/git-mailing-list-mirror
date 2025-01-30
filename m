Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C5F1AF0CA
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 21:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738270832; cv=none; b=aInLuh6iPJwpN3a9ud1fobZBKLad7a4EQA43Ojc1ZMs44mAkOUTiaOI0frNf2Hnix27ohkZOZswEnfUUQrm1npj0RxtKk98ewc89d0GGr6lMWWzarSs/I5WUORNtwYLhrdPZBxRRzNUEwBtkg4+8WbdiwssRZ0m5uT14ceQzmjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738270832; c=relaxed/simple;
	bh=RwyyELcjlsj8fO8maeX02nXpagStMTDl76u+Yii9ifk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U4UriSKPpdjsrSNK3O5nBHQ5V+yH7MrZve5MEvsyvxn4xukdmCdwovq2REOJHPgH/tQazSca8kOWr76Us/JYjtzRiyQdpDOkAty3MknY/vXQezPHP7n39sqWa6mQ/2iUB/z3f3tdmzFtTujyH/3BftAjdJqaTY/txlRe4TJiIos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jZwfVc2f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g/Unbv+1; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jZwfVc2f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g/Unbv+1"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3B5E211401A4;
	Thu, 30 Jan 2025 16:00:29 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Thu, 30 Jan 2025 16:00:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738270829; x=1738357229; bh=9c0xyS4dNN
	km/2EhpHaR203cBeJFMwyzr4qZrGn0NoE=; b=jZwfVc2fq0114qcaKMrCo8JXlN
	Ec+5KNi2UvXZ5mchfe/cQctPoV2o2/4PApbx+Djrms3OWitp9jPWUDhyxY0oKErR
	hDLZsJ70OE/Cpx6uSFi9hjtbggiJxRnvD3/6GT2DIxJkccb18xdsQyiTE+chdMi/
	Hp7Csx7iwjaIc2RhmZwVHfURwTCaBfJh1cwbt1otCWF7jjqPTYqbx9vkKdB7Z26+
	9eJ+DIXJGb9094w6I6+lTGSDlP6H5e8rCmIEg9N/er553jQPLw9bQBVAs4jwtfMM
	vj1FJd3mai98bQW0YBPWroDq9eqq2L0biEX4oqLRXRqCVD36tpjWs/oyvniQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738270829; x=1738357229; bh=9c0xyS4dNNkm/2EhpHaR203cBeJFMwyzr4q
	ZrGn0NoE=; b=g/Unbv+1BlOQHfiwCJBGj54lQsDmW3erdL0LvembW6bgKIQuPRU
	nz7GZtGHF5zkSuKCiNOiG1nyPN9ZPgg94/2NcwWXZiPkGdOQsIRmJRg5ZK7SEcXT
	ebMPVELkYwu41X0kETe813BdDKjcq5FfzqHziFKlGBxVYUGkfuR4EpIRjjdFkw3t
	RrjZBl0qIXUVECSD/PIyrbBI4H2wazIDVwjDqa0y4lA4ygiYh3gPx1vtjtaihiuE
	uGth6Y6PJYaWnGR3n/cVmGLD3lMAhmcWkOdpTV9F2/YODH7EZJYDORB8sD3AWo+L
	1yIC1liSotZ5Pb/3P/qITf2ZIeyHFhTVVCw==
X-ME-Sender: <xms:bOibZ9I5Agdl80bCmwcTmnupI3nIU6zyEfugjGuzEgFXNLP_OMa5ng>
    <xme:bOibZ5Jmc62LxBfX31rUw7iKE28tRkv0p62_UP5bgMGEn5ZFL98u2hAj8xMEMbSqS
    3jwU5tKBBilW9u3uQ>
X-ME-Received: <xmr:bOibZ1swQqqfvFUqNs0VkX-Py3-FjSgUDbnH00mF8z5mec8LMcfUXY8pEbCJR4E2WUOE2jZbCGgtFG_7G3alUiVMUDQubMh5JznH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeikeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehkrggrrhhtihgtrdhsihhvrghrrggrmhesghhmrghilhdrtghomhdp
    rhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:beibZ-bEZ7gSxCcUejXsNOI2l9NVDvNsqnhVsaJkxaRLqUEnWl59xw>
    <xmx:beibZ0Y-YfO2dIrGkRwh4Huc7m_kKR2i46FI1lPe0N_66q_RUWQW6g>
    <xmx:beibZyAEyZtg23GIVXpNfveIEubZOJrQ5lBkcEtjb3jhqWpeC2ispQ>
    <xmx:beibZyYTae7vQN31_EWlx6c2JP5Oi3GUf4ML5De8rWSA1VbxaUqLfQ>
    <xmx:beibZzwBv_eeqBefjnyrd0D7KNc6V7Q47FaJAGVl7mx07Sik6lk7AFVw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jan 2025 16:00:28 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,  Christian Couder
 <christian.couder@gmail.com>,  Git Mailing List <git@vger.kernel.org>
Subject: Re: Git in GSoC 2025
In-Reply-To: <xmqqjzaccdpn.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	30 Jan 2025 11:18:44 -0800")
References: <8c8e8797-8de9-4684-94a0-f6c17a592dc5@gmail.com>
	<CAP8UFD3PkyaQBLYPryePk=e54VtsQwjbyvvTsKEBFJnns_jZyg@mail.gmail.com>
	<Z44u7od-mDiKcKVZ@pks.im> <xmqqr04vzyz9.fsf@gitster.g>
	<b784f612-4b6b-414a-9742-86611c50c55f@gmail.com>
	<Z5srHBSPKQlsuH53@pks.im> <xmqqjzaccdpn.fsf@gitster.g>
Date: Thu, 30 Jan 2025 13:00:27 -0800
Message-ID: <xmqqr04kaufo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> I do not mind either word, either, but I have two small issues to
> raise:
>
>  - Is each topic "owned" by some specific person?  Would an owner
>    retires from the project, would the leftover bits go away with
>    the owner?

I obviously meant "When an owner retires", but more importantly, I
should have offered an alternative here, instead of just raising it
as an issue.

How about making the rule a lot simpler?

    The expiration date kicks in _mechanically_, i.e. stale entries
    are unconditionally dropped at the date, based solely on the
    comparison between the timestamp and the wall clock.

People are free to advocate for its continued existence, and when
such an effort achieves a concensus among then-active members of the
community by the stated expiration date, a patch to update the
entry's expiration date may be accepted, thereby prolonging its
shelf life.  Unless such a thing happens before the expiration date
comes, we will mechanically drop the entry.

Of course people _can_ resurrect an expired entry later as a new
one when it seems appropriate.

That makes the decision to expire things from the list easy to make.

This is a tangent, perhaps we should adopt the same "drop
mechanically purely based on timestamp, but allow resuscitation"
rule for topic branches that take forever to hit 'next'.  It would
make my life a little bit simpler ;-).

Thanks.

