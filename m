Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F5D22083
	for <git@vger.kernel.org>; Thu, 27 Nov 2025 00:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764202185; cv=none; b=VhFyy8XBGmR+b+nsVe7FuVnGL//FNSynWduoa5pigkdXZoXHjSi8fWONn2xPwR1T49tgl/NzKbR352UCpe+vMVNyr3DJyRH2sKXs+OgpRC9sP18aJ9GjLeIbPognMf+VeULAdOLGUhhc1ur4c38ggBTsiwomuHnQf4FepdMfTJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764202185; c=relaxed/simple;
	bh=Tq+yjrY4W8fRGNF29yyta5O6E2H3QA/eL0ZOMa5UaSE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rsEOFnlL3toAu1Hr+VkfDNtYAy9MHu+xxWRXrVfmlNCn1dXmaRufGvNFohhdZqh7rH54t5xRn5mVNNlsmF5xnL92m6eE0I3tGtlPs+X+pJLKRJw8jOqWocxIq6wIgGAptvKIB92ouGBz4/fWz2Ed66OUavMPHuNCuI4UJxSvRQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=P3BVZLwH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HOyB84HD; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="P3BVZLwH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HOyB84HD"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 16BBE1D000BD;
	Wed, 26 Nov 2025 19:09:43 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 26 Nov 2025 19:09:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1764202182; x=1764288582; bh=7C+/y1l307
	lMJt4WFwwRTHQruqMI7/YTas00PiIsej4=; b=P3BVZLwHd7A1MrA/SVRx2dISh7
	XqtB2YEjAcd34LzYDI8gAtn1NpThNE7QorKof6FwJvHPETtN9EduZWFuDgUyvVl6
	BprWH49a6Ex8jyQ3DYY1WdO8pOvOBlWInYR7G/iMeUGD+jLW3Adtl2bW1mwUAp5V
	BXF99kYmAQgs0h4PdXc4A+H7s9aI7i3i6m4iFfIgmuex/Y0yzdp4noLov71aJQbY
	evelz0cST+BzpXdMrevTedvH7uk2LZZLLOHfdJr2NIhnh9RvwJ2IqukYFBWbx68m
	esRHwjTIpWZHNxhVT4jVcFfn3RDQOs8XdgYsPYB/EZXMvRmkFMZ2OFKvDIRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1764202182; x=1764288582; bh=7C+/y1l307lMJt4WFwwRTHQruqMI7/YTas0
	0PiIsej4=; b=HOyB84HD/8/hZ3YRXaMTWlDX1jL/CagcsfEw+CFGQ/HaiVmM3hl
	uBI+PKWOZmJi+3s7Huk6CYhjmExg5qafMoY6pZeZG7Gg0ubdveT+HfsXIZfIIoSK
	MFJTeZVsEWj1/pGn0Xjhn3QUFYoRir9ihSQtyp60AMSu6cGsjs0lTMFt2mRWbBG4
	F39dmDHie+68QFQSFno/0m6SI7MOaqhkkkponE2FKWEH2NM0RPKFp0gOrtCuWsrV
	V6lsIFk1k9AwHFcWBXLjlK9SSemChnXnoAwLsZYJX/0muwyad3g2klJo84y4Ctky
	lLGN1YkB8pLunCZmBASVs0uy+ffVzieuNzg==
X-ME-Sender: <xms:xpYnaVR3uoXF4MT_bkbLyty9XizTPeHWGUxE_pMnxIWrc3Fppb9xFA>
    <xme:xpYnaRBL2E82ecmFcXBJksZI9OulWuccccUso4okH8DXhQ5dRq5gpLiCx2gn9rwKM
    nffpoqqrCGzRWJjOnWJqWQcwABiRWdmUTe4yZrABL3mXGheBA46ZQ>
X-ME-Received: <xmr:xpYnadExjFCblTuUBqT7TnAn8j6AjzkPnubscd16koDT1JtJ5AhNJaslzgm67YSnqm0y37cEs7pFTIYGAiPi7Huo-etUzwmTOAWu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeehjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehpshesphhkshdrihhmpdhrtghpthhtoheprghtthhhvgifhhhughhhvghsleefgeesgh
    hmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhn
    sehgmhigrdguvgdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:xpYnaTBqzvk6iczEuEIv6Rz54etm2Epthkh0uswAtuzJ3KaUQ2hS-Q>
    <xmx:xpYnadUqP5zr_Ph34CHCypox9ezULS6hdE02j9Su865hfNjUAl1BzQ>
    <xmx:xpYnaXr6CczBwmXi2_xvYbKxk8UX1dq-q0CIwZCv8zgN8c4yeaPBdQ>
    <xmx:xpYnaZSdm_9Rj1G-YUv_-5qO9yQtVaYpGT7Eg9fJCBITySubNpP4-Q>
    <xmx:xpYnaWokHHLe2fx96TDvf3gvBqtYpojetQH1GDfIks5vbIqkIex0ipNA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Nov 2025 19:09:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  atthewhughes934@gmail.com,
  johannes.schindelin@gmx.de,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 5/5] scalar: document config settings
In-Reply-To: <18580f020d149eaa8271542d7e629ef10fd8c9a0.1764195516.git.gitgitgadget@gmail.com>
	(Derrick Stolee via GitGitGadget's message of "Wed, 26 Nov 2025
	22:18:36 +0000")
References: <pull.2010.git.1764195516.gitgitgadget@gmail.com>
	<18580f020d149eaa8271542d7e629ef10fd8c9a0.1764195516.git.gitgitgadget@gmail.com>
Date: Wed, 26 Nov 2025 16:09:41 -0800
Message-ID: <xmqqbjkol4je.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +commitGraph.generationVersion=1::
> +	While the preferred version is 2 for performance reasons, existing users
> +	that had version 1 by default will need special care in upgrading to
> +	version 2. This is likely to change in the future as the upgrade story
> +	is solidifies.

"as the upgrade story solidifies"?

> +fetch.writeCommitGraph=false::
> +	This config setting was created to help users automatically udpate their
> +	commit-graph files as they perform fetches. However, this takes time
> +	from foreground fetches and pulls and Scalar uses background maintenance
> +	for this function instead.

"update their files".

> +index.threads=true::
> +	This tells Git to automatically detect how many threads it should use
> +	when reading the index in parallel due to the `core.preloadIndex=true`
> +	setting.

Is "due to the `core.preloadIndex=true` setting" part of this
sentence still relevant?


Other than that, superbly written.  Thanks, will queue.
