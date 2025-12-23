Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6527C34CDD
	for <git@vger.kernel.org>; Tue, 23 Dec 2025 00:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766451098; cv=none; b=R1JKLItjZXBZMqMnyXsCbOntJRZ+V1l13XszKKyuaYIsD3dvKnUwAojM4lhbmF6SXy5CnQkJsCoPIXeUHg6LQ+9H9flMI/JR/jOTbEbMJWfyDkxIGKTkSlTX26mEpyPMtpHq4MRjgJlfOHu+OSM23fwRhi0TJxCF5sFk35RC8AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766451098; c=relaxed/simple;
	bh=MXaLQ9ZIbR/XhIOYFL0zYnKlxNRj5r4RbXNYfzjya34=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WJms8UzAnZK9hKG+7OB5GjhU4l3fbhHLld+CJA/H17O8SnbeA8ghubKGMNrZKaGndCzyalxGjEHBA2YbtDOpdF4kMw+HnO0K6vdD0I4ikm/JIvLRmxu3lKudh3u1WLuHsmcxFBTL/lU/aFDRATk/cr0wLfmW+JnfEfgvuUnEPIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZBOfzkpm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=toC2ZtT2; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZBOfzkpm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="toC2ZtT2"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 7A9C01D0004B;
	Mon, 22 Dec 2025 19:51:24 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 22 Dec 2025 19:51:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1766451084;
	 x=1766537484; bh=TGzOxeW/w8uhi77DXsuMr+WwTf5pKdSF3sUv7zfAMSs=; b=
	ZBOfzkpmKB9AbW3E82NyvjggISka6M+tCAXX13z4h+vLmmVWI+S/fSGGQbDySreM
	nrlM5ytrayEzmU10qlNCY5FKM4o7uG/IW4s/GqJFKgXzzNSi1I1ouK1sYuYirxTh
	Ulvvfqd4z7diNQ0S9GDH05eoD+nevF7HYm5x6cB+U5SFO+42GkvGVOCLwMPeVEfT
	nrrKrdKGg9l7hNbpgnar3K4jOMrIf6Su3fwjoUHyT4+dowg2wCD2bJLw2tJmHrt7
	3f7y6vU/uncXq+oD2CMUxlet9r28hCSgRB8DbpoGWzA+woqeMvJr0QwoIz0x24Sq
	BcXRk6cjaxEDMXaaUNBc0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766451084; x=
	1766537484; bh=TGzOxeW/w8uhi77DXsuMr+WwTf5pKdSF3sUv7zfAMSs=; b=t
	oC2ZtT2jVLrWciZ9E/uGjhJWjLdoJ9FWLu6pF5+UPj8D78d9Qq3CgWcOJ0WPvDcf
	vM4YQ7HV4zsh0eBf3l3pBA3UTvWZALhwE0dCgga3ddNDqw/vt0pFipvTUuDiLhwx
	dQeCq/T4kPHI+9ddvkAKTs+4U7jMQIj21Ty/PC+i+rVSQoGurCLftBKHfHIWmGaf
	a4fHj4DjCRy/4eTXfJl4nDOmedhosfGM6Jkw8mlpXyh6khC59AXuv3YB/t4N/uFS
	0JfLxJW46kjZApzp8xraoWt/jPKaNRdIHmapJqVunPpptHaDk3Vhmw00KogiPYHL
	jFYIXuykwBt1znfQETQ4g==
X-ME-Sender: <xms:jOdJabkSowandOSKX8lRHCAjgzPG6X8biZd4J2dP20Qo531_UOKhWA>
    <xme:jOdJaV3v-2ktT9OChi7OfnkCUaag3IS4zxdbhM7Ycvy1DBhs4YGOvdFYa9eGwzXp-
    qRdJv2H8Pe_hSsivKImWM8Oo3qrJaNsSzW_II2okf9owJZkXxyK>
X-ME-Received: <xmr:jOdJaWqG-DbA6qktLXREzosP89fnpISN-twL_G8ycQbUENzbgVOSxpamvlUFnt7wcCcLs1ml3hW-QHoch_9c21FK0ffE3pxG_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehkeegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptggvrghsvggsvghinhhgsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:jOdJaSeFbF92__ZbAi2aIY6ctxthErFR3Dh75A7Euqx_aYtH6C-xxw>
    <xmx:jOdJaVrxCmCVwRNdvlJgg9jrJNKHLiuhmuncJQgbfpdFaaVoDqPkcg>
    <xmx:jOdJaTHtDZM2WG9GFHvok1b3XT4sC2clfrOjD4XrnVNxQg-6js4gYA>
    <xmx:jOdJaVsXH88qpk_dypS2PNtq-joU5CVvB3LkYQdKWAAXv6du7vw7pA>
    <xmx:jOdJaSIVcq6kZuCh0k3SK4ZpkOHDGZZRbMXivJxq54TTZCZAOeFiXt19>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Dec 2025 19:51:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: pasteley <ceasebeing@gmail.com>
Cc: Pasteley Absurda via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] checkout: add remoteBranchTemplate config for DWIM
 branch names
In-Reply-To: <7246f693-2047-4218-8103-8143e01032f0@gmail.com> (pasteley's
	message of "Mon, 22 Dec 2025 19:27:44 +0100")
References: <pull.2136.git.git.1766332796836.gitgitgadget@gmail.com>
	<xmqqtsxjruwi.fsf@gitster.g>
	<7246f693-2047-4218-8103-8143e01032f0@gmail.com>
Date: Tue, 23 Dec 2025 09:51:22 +0900
Message-ID: <xmqqy0muqaut.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

pasteley <ceasebeing@gmail.com> writes:

> 1. Server-side policies/hooks that require a namespace on the remote
>     (e.g. `team/*`, `users/<id>/*`, `release/*`).
> 2. Hosting / mirroring setups where remote branches live under a fixed
>     prefix for organizational or access-control reasons.
> 3. Migrations where the remote branch layout is constrained by the
>     target system, while local developer workflows assume short names.
>
> In these scenarios developers do not create the problem, they inherit it.

Nobody stops you from interacting with projects like the above, and
locally name branches you store your work in users/pasteley/topic-1
instead of topic-1, no?

> While `push.default=matching` has been deprecated since Git 2.0 (~ 2014),
> we still can handle this corner case by detecting the incompatibility
> and providing a clear error message.

I do not know if you are confused, or if you are citing somebody
else's description that is confused, but the word "deprecated" in
the above statement is misused.  So is "corner case".

When we talk about deprecation, the deprecated feature is something
that is not useful for anybody to adopt because there are better
alternatives available, we wish there is no need to support the
users, and we hope we can remove it eventually someday.  The
matching push does not fall into that category at all.

What we did in Git 2.0 was to change the default from matching to
simple, because the matching is the most useful for those who
publish their changes, and for those who are merely participating
somebody else's project, it is not suited.  The matching push is
also harder to use properly if a project has multiple people who
push to a single repository (i.e., central repository approach).
The default was switched to make life easier for more people.  It
did not diminish the usefulness of the matching mode for the
developers for whom the matching was the most useful mode.
