Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA491A2C29
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 21:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738274266; cv=none; b=PHbEc0lbLOHRXey1SxfpEkQC3jlgzQkbLFRGgTnByH2BfNc/2OTf5k/0gIl2e65NiDAEwjoj+R20q1NmuKJnr2iK6MYrhW0OpwiK41IaRStjREDkozpLcU4lt2elbcD+GVJVtFlNDFMl6TM52Otc8DQLkklqfwk/t+M61qse8Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738274266; c=relaxed/simple;
	bh=0L8fMvgb0TYjfa70xg7pvNU/QWE98qtIzge1jDG3WbE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Iexg/k4RCOy8LEfkurGrbjaprhLKOHav4KCV7rbD//lwGTXApHvA2wsagjdbtHjAREqMo+TMnYVsfNHfWMy9O/p83C6o4WB86D6z96xsvBGIIbNWBEFVP2+ytV6nGH6/APFwU+bElsDcMdKs4XGyO7N1FZ8UynuVRsrxh2huXbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CDw/EUJl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D+NymI8B; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CDw/EUJl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D+NymI8B"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 7B80413801E2;
	Thu, 30 Jan 2025 16:57:43 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Thu, 30 Jan 2025 16:57:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738274263; x=1738360663; bh=ieqT7A8mAm
	vtGtFg2VAYfZoR4lJq8/KBPeYSw1e5u/g=; b=CDw/EUJlmVNSVxYwBhy2w6/FYe
	OX0QZDy2QnTCipCPhhTJlt21pDyi3zBqagvzviRMfdV+22fsdFwUFDU+uz7E05UN
	e5eN6VENKp4ITDDGt5w3nB3X+u8ufZNHjB997j8KYDVamLP22rOFZgkxQyBNUv9O
	IUr+dPybQpoqNFvO/nYwHPZwfU6vrnh1qjvIliKCmVP+7kX8A2iCIq02fPIx9DpR
	FXPrmslvkwlDayQYTK3j7WayoyOrl/EKrECIX84/Mmtszwrv3vdQfu5DhUtszaOn
	qzRgv0g71T1vLMGk86M3HlSZhCAiIQEVJxAaBLbGWgR1kBeduX5Fdfmtflgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738274263; x=1738360663; bh=ieqT7A8mAmvtGtFg2VAYfZoR4lJq8/KBPeY
	Sw1e5u/g=; b=D+NymI8BobNtMBMAb1aRgKmVIkFNGPAuPVj7hvDu06o2emv8X2V
	AWE5ZmOfB9DK3emDO7fdbRdgqkF0T3WCD/TUf/OxdUrrTxZgpNvyeG9yB25cAoMY
	ZQ2W/0kEy3Uh4L+pC0e7K/fPJebWXhnE3n3HBRazi2zI+kidudwLRxBzaD/Boo2a
	iS+UsXvQpSlGStpFLdlNcbQVluLDW19/m50QN+3/O0+1KkjJJCwClT+K1qWejFh9
	vpjSLoQvF9/lkRKWLhAfhQtvq3tYeII5s6FOE6l+rsynsV5QoJ12G+FWVWmZ/qd3
	se1quKcyVTIUPr/1l1aCiYm8PPdxzr0EjDQ==
X-ME-Sender: <xms:1_WbZ7kyfzNJenp92wcCRcQjW9DID3LpKGAw5W3dnzljPu1SHnXWTw>
    <xme:1_WbZ-3qPK1FXsZVDLK5tAkZga1x4kntyslXmjp3si7pfzUBs3zJidP7awyLABL0w
    F1MPT-K6wK1TCwJnA>
X-ME-Received: <xmr:1_WbZxpN3Y3YrQCBQCf3-X0poLETLDvdl_EJ6k3dPuw2vOfEqfpGd-zeq35nE05xyADovkaZZ56gD1ddCBGcNop8QNY7Tyl_ynAt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeileeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeejke
    eujeegteevjeetgeeileeujeeijeefueegieetiedtleffvdffheeihedufeenucffohhm
    rghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhssggvtghkvghrse
    hnvgigsghrihgughgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:1_WbZzmcWh_WKMq5BAD_5TVLcKTQm1rJB9cA9zWhA_blb9ZAixDfXg>
    <xmx:1_WbZ51-v3CGHF-xnL7m-bahWyxcbz_00KRCQjpYC4rT6LL44ep30w>
    <xmx:1_WbZyuT7GxlGX7BVxYRFWQa4Bf9sVdZX8JXhpz_48K0onONrHRIBg>
    <xmx:1_WbZ9XcNFXF1se4Pez_SD_ua6glYfEwoR6PFwrtSdtycDseKikWfQ>
    <xmx:1_WbZywTxtnIJXlwa0rpjaCcVIlEh-a6Ngj6AluLiaweDxepiuYiLR01>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jan 2025 16:57:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: <git@vger.kernel.org>
Subject: Re: [BUG] PREFIX environment variable ignored by git config --system
In-Reply-To: <001801db72af$20a35560$61ea0020$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Wed, 29 Jan 2025 19:37:17
	-0500")
References: <007f01db726b$ac911ce0$05b356a0$@nexbridge.com>
	<xmqqbjvpk1wo.fsf@gitster.g>
	<008201db726f$6e6990b0$4b3cb210$@nexbridge.com>
	<xmqq5xlxidh6.fsf@gitster.g>
	<009c01db728d$164a60d0$42df2270$@nexbridge.com>
	<xmqqwmedgpkf.fsf@gitster.g>
	<001201db72a8$72719480$5754bd80$@nexbridge.com>
	<xmqqfrl1gosc.fsf@gitster.g>
	<001501db72aa$fc812350$f58369f0$@nexbridge.com>
	<xmqqbjvpgnea.fsf@gitster.g>
	<001801db72af$20a35560$61ea0020$@nexbridge.com>
Date: Thu, 30 Jan 2025 13:57:41 -0800
Message-ID: <xmqqldusarsa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

<rsbecker@nexbridge.com> writes:

> On January 29, 2025 7:24 PM, Junio C Hamano wrote:
>><rsbecker@nexbridge.com> writes:
>>
>>> This appears to do exactly what I am looking for. When I create that
>>> file, git picks up config values from that file.The question is, is
>>> this environment variable actually sanctioned or is it just coincidence?
> It does
>>exactly what I am looking for.
>>
>>How about reading "git config --help"?
>
> Yup. It's there, thanks. So should I figure out how to sync the website with
> this
> or ignore it?

It depends on how good a friend you are to them, right ;-)?

https://github.com/progit/progit2/issues?q=is%3Aissue%20state%3Aopen%20PREFIX

seems to say that the issue has not been reported, and doing so
might be a good first step.

We'd probably want a bit of history digging to see if we ever
supported "$PREFIX/etc/gitconfig" before opening that issue, though.
How to phrase the issue would be different between "we used to but
no longer support this since version X" and "we never supported such
a variable".  This is a #leftoverbit for those without a lot of
coding skills but patience, being good at using "git blame", and a
good notetaking skills to summarize findings, are needed.

Another good thing to do is to match the environment variables and
their descriptions we have in the output from "git help git" with
that page.  We may have acquired a few more of them since that page
of the book was written 10 years ago, for example.  This would be a
good #leftoverbit for those without any coding experience but want
to improve the documentation that exists in the overall ecosystem.

Thanks.

