Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAC02FE056
	for <git@vger.kernel.org>; Sat, 14 Feb 2026 18:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771092870; cv=none; b=WA1fJZ2vrXKDw84xvTu7FdDdGywnf6OM6K8cqGkSVYQG1JasyTuF0JDrI99fBtiVCp8ZkWkAHly+OdcAI3AoPoS+ttAs0aZeCudGbzbHiZhAwIR8BPjeN9ohCvJEVFshle3cBAp6juVq+Zn27xrHP3T6bj5RDGkl9T40bpdKNxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771092870; c=relaxed/simple;
	bh=+wX3mPpnSNX1Y3o7PO2bKXyiLEWCm4afpuCNcUPuFSw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tMqdIsYDeaGywS67tb2HvaIyz/0lulExJWwhoARZWTqesppZQ3pvhtBC+eVZsMcCRllmw8kB65s21GWQvov2J3E8COtdORTd8RBlmh1guv0nfraZJ2klEvVMaHNbD34WhKxnxVNXC6rnxchZmnHvez7ZqIfAWAFnefmQ05tPrro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dKEruCRp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ad3xYJhX; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dKEruCRp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ad3xYJhX"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id C5D661D0031B;
	Sat, 14 Feb 2026 13:14:26 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sat, 14 Feb 2026 13:14:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771092866; x=1771179266; bh=y/SP2pILqt
	nOFAkrjhtGuBYHFndjy0p/ISPcbhWtveg=; b=dKEruCRpQlzD4BC+MIbyjhrWJ6
	JEGlUwoP+6u4bVQIzC3uvwB0vIeB4nmzLKVZTNnABuctNWVl40lX3J9oLEfCQbfd
	EXpJXCOMiIvWEM2l47eZM82rv1D0cUCLukaNP6ZXLSJFLC5ua5XuZlIcVtkyW3lp
	U48HelGQ6k1sMcvHd4mOsRqNSEHA3i18RiUozAl9e8VXlMBxm6XvrAKQhA0oyP0Q
	Gf/OjO2IsyQ3Hdttlk4SRiA5DvGehtBM3S0bvxZ5cvObXbqMIVbNu5rM9Ts50iqp
	HOIete6He/jiVEneMoSKpl+Dq/QIJANyGwp7i4Vx6gmGny/weTJ/o1pZwSEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771092866; x=1771179266; bh=y/SP2pILqtnOFAkrjhtGuBYHFndjy0p/ISP
	cbhWtveg=; b=Ad3xYJhXxynDHME63pDOTM9PndwoQLfN1dimihwmL4bHM7mUUw3
	rhoB6ouBmKRt/uo92Foyred9ojwAoyVKuerBwV04Xs3s1peSTcR3KhYG6yGf4bIW
	nhuxSH1nzDVNfSb0oFj9lWq42Sm/CEVYBdcDOJtsTSQFfpArObwBwlF5VbeJo0Jj
	0I4YzjN2IGY4i0fzoiWwoQjoPsbYMfYMo9sRZ3/R/6jmNesgYUf9c9g6RLBEbPGV
	NOQH+o3xc+kXa43Jdu/tQ/W8VToLNxJM+dz1n8bVHQSyau1IH2VEvPUzT+Z+LW8n
	scSwQIhtZuytFxzmzdPcTAHQVPEbHE/X58A==
X-ME-Sender: <xms:gruQaSXopOgk3m-kcVb13pdwcIxozV0d13tbC0znj6XRglaFVlugGw>
    <xme:gruQaSRXVUaS1Xen39E8N-bkNSWu-7GzKdJwVLbcnUI640xHnsLERVHoDFro-TIzi
    SqhxWPRp9m5-ibgOB8AAd4iVkA5UkJK807_WMRpYpo_p0VNnLv7nw>
X-ME-Received: <xmr:gruQaQPNk3Qt3U_Q2wa73eZz_iINRmXH6KoPXDtXZ6xfuABs_xcA770ZSmypwR7huI_wIi0OnJHwsmJGg9BFIuCy3d3bNrlXXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvuddukedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhhutggrshhsvghikhhiohhshhhirhhosehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtoheprghvihhlrgdrjhhnsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:gruQaQRs0OlEPz8AamHhSx8SwoZxO6aDk_RD4HfeT17dU6LUDWhRzQ>
    <xmx:gruQaehk70CXnnfGknDz1K8CsSbv9vQ8hisbE1Rp_5ZR_9jYhQMbYw>
    <xmx:gruQaZ-Fpn-MX-E6vq_Y0gZ4zEc8H8jCKbv8nhp39uChiCzrFQt2WA>
    <xmx:gruQaVE1kBS5NZsw9tyfZGyXb6yYBfebYq98UmoTujNQbqlhbuLbLg>
    <xmx:gruQaQ47KW_1r3jgFw_dDWkq5e1_5Mgu-giT6WC_G1BjoJh2HnGiY58P>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Feb 2026 13:14:26 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  jltobler@gmail.com,  avila.jn@gmail.com
Subject: Re: [PATCH v6 0/2] repo: add --keys and rename "keyvalue" to "lines"
In-Reply-To: <20260214005818.37349-1-lucasseikioshiro@gmail.com> (Lucas Seiki
	Oshiro's message of "Fri, 13 Feb 2026 21:35:14 -0300")
References: <20251207190532.67107-1-lucasseikioshiro@gmail.com>
	<20260214005818.37349-1-lucasseikioshiro@gmail.com>
Date: Sat, 14 Feb 2026 10:14:24 -0800
Message-ID: <xmqq7bsfgpkv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> This v6 addresses these issues raised by Patrick:
>
> - It renames `FORMAT_LINES` to `FORMAT_NEWLINE_TERMINATED`
> - Change the commit messsage of the first patch (I'm using Patrick's
>   suggestion)
> - It capitalizes the new paragraphs
>
> There was a discussion about the name of the new format ("lines" vs
> "newline") [1]. Personally I prefer "lines" instead of "newline" because
> I understand the --format flag expects a format name (e.g. `table`,
> `lines`) instead of the delimiter, being `nul` only a short form of
> "nul-terminated". But, of course, I'm open to other opinions about it
> :-).

I'll refrain from commenting on this part, as I am not good at
naming ;-)

Changes relative to the previous round look all good.  Will replace.

Let's mark it for 'next'.

Thanks.
