Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C33E748F
	for <git@vger.kernel.org>; Sat, 18 Jan 2025 01:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737162771; cv=none; b=q0bfcIXnCAnttQF52ppus8Z7TQP7mOgtQElCawSyO3pQQdugjCEAcTrA0PvFS6kowOSa4zpmSHerEZjTLdxe6kblSNfylYTBx/0zq/nUW3nPR+Mq3SQt6Bfd5OBimx58kXdsUPbmv7f7aWyitkc+UM880EE4XHo6tfLiebH4XrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737162771; c=relaxed/simple;
	bh=Un4IDGxpUUQpJ0BVCBL4QCLo/bDnA6L8tw+arrNAbp0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lIyHpPVEXInPw0izNtmawSCA4VwBxY1xqOGASb0I8vPzlwFNQrEOYX6khMKKzzlNKiq7DsJcDAt9T3dvWpmDiijvcTE++NWmjUqEWt0fk7hPkfXBXm3LWbyVt6fy5R0d+mjfSflfqHmfYlGmTp6MARhWYk4QiQRBMxAL9yPrObs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=P+hVEtjz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=neqG4GzP; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="P+hVEtjz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="neqG4GzP"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 5ACB61140113;
	Fri, 17 Jan 2025 20:12:48 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Fri, 17 Jan 2025 20:12:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1737162768; x=1737249168; bh=+jCLNq6rXM
	Mw4GavAHa9GcPfCRe2l67IepBDU0bZ+pg=; b=P+hVEtjzaJG+urqx5AcL/I3wnl
	umsX1FKRrss/K2N1D0br1zSnvNnlk8/tAjg/1I1cx+JX5liPyzcla3MbBVQ+9b5O
	kLMOjVwteFKvGQ4HG9eBELgk/gDwik9oGQ+Rl1dTzECvpPmsdjbYr9wMC7GZneHC
	ruK1IlhK1SbGhq1mEYqakNj3irNlrJ1XKRW/uIptwcQABJEu0JxgJV/rbYlGTKgF
	gFluhDiBga155xuv9N9J1qPSrxEwyzWWLtANjH9+qA3mujYmbZdYU/hGKqf5Bydz
	gIoK7E/WlArQxJoS+DMGd6Zuaazez2mzzo/+AscoWpVeO7wfNOJVxnJ2mTuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737162768; x=1737249168; bh=+jCLNq6rXMMw4GavAHa9GcPfCRe2l67IepB
	DU0bZ+pg=; b=neqG4GzPfin2yYoYvDQf5euvfvF2s2+MdihHFzSBNmjp/ePgZoz
	h3joCj31QLutUhtNtJYR0KSA9SaTtAAD/iPvOu5G8sGtx7Jt6IHjRBMQDJV1I5V1
	XJEImgMaZ31170GPUjvbQESryoFOjkU0kPD3wz7FYvm+XEcUTD1g6fw6rs+9EPhe
	nMHIt1HhyE5iTfK03l+yaBNBYgmB7ueaWUntBwRFxxPtugMFCn7rfjpuCUbadIPK
	/Ik9zZzCV/JcXOvqdQWhzDOHdfNsQp7gg/Olp3mRyjhqifFTfgBq40BbXhuLmvv9
	lhU7Xc7VqEk7Y28XULywbq2A5KDMrpkQG6g==
X-ME-Sender: <xms:DwCLZ2KQWPNyr-wDL0hvHVxHxyHubNbZoIaY4QrZ7tCy21uFnm9ZKg>
    <xme:DwCLZ-Khu4wqxsFIF7DChmI3J8s0oJ2vgmznst_814Bw-OufSZ9HwJp5vrOQ5uzt3
    hooKolm-9dLh3mAIg>
X-ME-Received: <xmr:DwCLZ2tRDa-7TNaH-B_hQNoMVJTp8qa9DGJi5G24LwbRpmJ4OFQdig2PmOS6LSkjGujUUji8X_ozOV9i79kPP-kQazRlyhIlDtJV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeigedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkh
    hrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghp
    thhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpth
    htohephigvfihonhesrhgvvhhirdgvmhgrihhlpdhrtghpthhtohepshgthhgrtghonhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:DwCLZ7Y4WZ347AC9YY1oAfLiEP9s6KM4fqI4C0bmFr3ZnWnr1iCH8A>
    <xmx:DwCLZ9Zt_H_Ba0OR-IY6hYYnJBLbnEAVpgDiFLwWaqEE-kNMzKPlWw>
    <xmx:DwCLZ3CkV598niducCIn9kdGA1D7X6TkxHL8aC3uZRh6G_qzKa0CIA>
    <xmx:DwCLZzY1678ma_XeXYqEdufiBc3x_qNssNGinDaXZFOM70heHUs0bg>
    <xmx:EACLZ7NqL8ndzUpF9vHehfJqnOebyyVfvVM3HUkB8FiMF8_wgtKj4N-i>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jan 2025 20:12:47 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Scott Chacon via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Yongmin <yewon@revi.email>,  Scott Chacon
 <schacon@gmail.com>
Subject: Re: [PATCH v3] help: interpret boolean string values for
 help.autocorrect
In-Reply-To: <xmqqikqibsbp.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	13 Jan 2025 08:18:34 -0800")
References: <pull.1869.v2.git.git.1736419777235.gitgitgadget@gmail.com>
	<pull.1869.v3.git.git.1736594839527.gitgitgadget@gmail.com>
	<20250113054355.GB767856@coredump.intra.peff.net>
	<xmqqikqibsbp.fsf@gitster.g>
Date: Fri, 17 Jan 2025 17:12:46 -0800
Message-ID: <xmqqed1053ht.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> That's probably OK, though it is a little unlike other bools in that "0"
>> is usually a strict synonym for "false". So we could go the other way,
>> with "0, false, off, no" meaning "show but don't run" and leaving
>> "never" by itself to mean "do nothing".
>
> That's my fault.  Your version makes perfect sense.
>
> Thanks for being extra careful (well, more careful than myself, that
> is).

Now this left the patch in a stuck state, with the latest round v4
still having the "0 and false mean different things" caused by
mistake.  We should do the "0 and usual 'false' all show but don't
run, say 'never' if you want it to be absolute no-op", which is more
natural.

If I find time, I can update further based on v4, but no promises.

Thanks.
