Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9690727702D
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 15:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218922; cv=none; b=lO0reTQJtNfHEiuHNvAxKTGFEFIF9zs4B+JIZ/ArMOw45hPL21RP2OYstBee66iRuvWZUbbyLoa4CS2AQQTxsg95mjn/Q3BnaPoHv6w6+s9qEjHFUQ62nEpgZ/4f4btLycFOb9QZdhw7lEG0LPRVyPqsCYKR0U7HmbU0Qr4oHCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218922; c=relaxed/simple;
	bh=wWHyEGDXjB7aPP+EVqE/6h5N0tK22WlvwV30EP0ALIc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TSGPQij5GQvcIQEfrq2XnJrJbS8y9mHcOIaCxLSgbSifoZpGApu8LeVOa5CotVSuvwvjzMor3kN3uVcwivNUiZh9EzBvW9H9cFyqSZ8fyrQxwl5ccOIFatszH/Iy+2KKCavM7jFzEHscRjpOs0o6YSn5HUGymOR3/LPPAihQvD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cyBJsqok; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PCuIqLXw; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cyBJsqok";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PCuIqLXw"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id B4B7D1D000FD;
	Wed,  4 Feb 2026 10:28:40 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 04 Feb 2026 10:28:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770218920; x=1770305320; bh=1qYRVc8yWX
	SSs+6CyDE0qDE4xutO12lqMv8CVl8XV8s=; b=cyBJsqokP/QTKW1U6KjetzGah2
	z4lH9DZHLfeDc1daRlCFbaKSSGyu+YrDJRgkGVOC626ngKTiu7Tu0z+fjeQRlPyv
	5r6+fUqGG1bEsFTcTy8oCRxvhXA7ui+o/vxaCIFj16VJtxQVuxG+S58Y1NsynB44
	KjHDG+bLQSVWkNi3NF7zTbhrjSWEBklXvdf08AmZsmeA8IYGjhiP6N8pEtJKhWH5
	dp0m2bYt2rS4Eao4vOynpEXazjJlL7t6t0PDgjeFEeliHAC3UcURRdkz5pkIFQMN
	pz7M3NdMjldu/VCK/AtVbusM8jKRlqEQLSwpiRa4v4SZx3TcL6jeHOxjNPkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770218920; x=1770305320; bh=1qYRVc8yWXSSs+6CyDE0qDE4xutO12lqMv8
	CVl8XV8s=; b=PCuIqLXw8PzdYuFIxtU6LJ93c9wZeRFwoAvqbAef57NMQw2QSdx
	Z8wiNoZFam8mdVaecIj1mtFRrFiltpaAJlTU7ZB5gBc3qQ1AkGvSblNWkjlMdD+o
	3Xf0Xf/sAzqoMc/QfJ1xt6EP9Epom0JTDANBgNp6jRyf2CvsFh36mrwgbpG+egRW
	ELjz8QDIFoGjtKaSUIl4IHzoo1crEZwDe8ClcL3GILZ/kGZ9Pjnz4tYwYheedV3a
	ReiG2urmwZOCp8jLRrU0L/j0B+4rhBuuBMzPRDmg5PR+yc2BaGLvFQmXOnZ8Ff12
	lxRHY3piV+y39s0RRVBekDucdgd4tvs4lhg==
X-ME-Sender: <xms:qGWDaY0hVstzOk_b6rhsco5WZ-mBxJnjWbsBbWoi6skAbuLoSx3D7A>
    <xme:qGWDaaG3-4xrIM1YOawwDJV2A2Pw4PX8OTeJrV1STjhdb8BW39vzhXz0TGULChTuo
    cx2mBeGEFPFsn0IbLvv0gam3Cz7t6OmpB5qvh0WA8a0iGcsMziNKg>
X-ME-Received: <xmr:qGWDaV7jfYKmlDAs_Y_8sWgSTPtd_vGNFe2SxRiNPvWY3YMNnucZt9sax9tnLUdoWpqPP0ctqDubiMx9S_0txBZpudZH1XJ51A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedvkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehjlhhtoh
    gslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:qGWDaQtRqKFmiwQAq5n3v0qiCtndEADE5mVX26vfVAiAUkJA-buHZA>
    <xmx:qGWDaW6Z3_rzWKUEW1tSEkUb6qG7sRs9qCjHubZ0kigWF40Jxo2qFA>
    <xmx:qGWDabV1C9lvAP4PSrenUCdR9Hw2ImPocdNthyK84B1cWPXQKfuhYQ>
    <xmx:qGWDaY_PaLZF88K6s0oocG8AhNa-SS7ok4BGPxqD71cdi_yNFUmN9A>
    <xmx:qGWDaRar_bUJSaS9bazbysOGfgpYLzdEE-mmLNqSWQHwV6HiQh5FOvwh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Feb 2026 10:28:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Justin Tobler <jltobler@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 5/5] builtin/repo: find tree with most entries
In-Reply-To: <aYMDL4m7Ceifl1Ja@pks.im> (Patrick Steinhardt's message of "Wed,
	4 Feb 2026 09:28:31 +0100")
References: <20260203221758.1164434-1-jltobler@gmail.com>
	<20260203221758.1164434-6-jltobler@gmail.com>
	<xmqqldh9qw5d.fsf@gitster.g> <aYMDL4m7Ceifl1Ja@pks.im>
Date: Wed, 04 Feb 2026 07:28:38 -0800
Message-ID: <xmqqtsvwply1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> From my point of view that would be the cherry on top of the new tool :)
> I'd personally still like to learn about maximum values in the table, as
> I've found that info to be useful with some customer incidents in the
> past. It's not giving you a trend, but it immediately gives you some
> good signal that the repo shape might be weird if you have commits with
> hundreds of parents.
>
> So maybe this is another step we can do in a subsequent patch series?

Oh, I didn't mean to say "the maximum alone is not interesting
enough for me to bother, come back with histograms."  If you already
have a good feel for normal range/distribution already, then one
data point at the extreme is a sign enough for you to notice when
there is something fishy going on.

Thanks.
