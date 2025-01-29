Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2500C1D90D7
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 15:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738163021; cv=none; b=WPOENErxA2NpmgAj2XDtjcjOT6SWkHQSoHtnYgGIllSdQ0tQJvYyYBtJ/EGOHzDcDx1DAGGjE6vYzRkrsA5u3vETIr1N6rNrE8sL5gu7WXPNj5YtYNrSMJ2jD1m6pjUJww08Mb5JkmDr1D7TKcmaJ3gJHRD3rS8/OKeXKf3HIIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738163021; c=relaxed/simple;
	bh=71KUd84q/3aaQUMJRBqP1xRbDQUuP1hkDXimKx6909w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WgWyhbkpNFmvEVdBlvHsawTVCCHfPWf5wnXeNRMq8vi+Bgl7xRrEepZQZmaLfvhhb5XKQCIH5pTT/S1BmFm8bLOIbOpKkAm40RQAMPEka+Qmf3mj0o3Jkcpp1Clc976WffQpItzYdnfplEn6k5aLZ4XBDMbwHCc1+38/U2j8hPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=n9Qgy8sx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ij2cp/3w; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="n9Qgy8sx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ij2cp/3w"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 131CB2540200;
	Wed, 29 Jan 2025 10:03:38 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 29 Jan 2025 10:03:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738163017; x=1738249417; bh=iWpytfMmQC
	ZSZClFPpjQlSi+DF1zrKocxSxAnid23go=; b=n9Qgy8sxiyQ2uYu716/9E4LpIz
	cJ6wF2B8SmnY2bsXjcTQSRoNDQF4HLRVr9P3HWzGKubyURbVCDE+d5j4uX4WYk9o
	AUood+NOnDrzC5/SkY3fO7FvUuGqtVZ1io4sMf0lTKDNjZk67hrjtdzq42Ij2sHu
	gLbD7Um0L5T6IIwBHLjF5utBscLAG75hbqsI2fg8qZQpHBFJKvJDCdWgbNBb1rVu
	57TI46KY6p3qAnV0qSWyySbKwLatK8Ndyik3XpY0OOhYVM/InX5j6f3Je8erZ00z
	+pSg1g8k81xMnk1sqYZv+z3D/8EE8GIfYLe/gkBPRFYwGQJifmD81CTryWWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738163017; x=1738249417; bh=iWpytfMmQCZSZClFPpjQlSi+DF1zrKocxSx
	Anid23go=; b=Ij2cp/3wZwNwoZYrxc4AQB5VfoY0bG8qOfm+zC/SBHzSRdqyG58
	XvS+xiYlqzAUVXqDRGsPT9mjpElHPPd6v4dXfEWV+Jo660mLh4NNNmCuMWzP6lZf
	CG7sKmTzW1y9U5+RktDR3RQFf5/xppBcY4gxrRIUhDcLmetjeUeEHZH/EUN36wBI
	8QhM9dUeXwrqHs5w+FW3jGNZm4JqSg5IB3duHFaDW2xNwXL30+c5V/57Iu+QoZ1h
	LkHNgm+nnBJXv3OwIYpOjJBc8NAnYPJ7rYkgAp0Jxsua31JTDyGVvn4iApYaumYH
	8oFyBD3ME54m5MzoOsry8jtUqUfm3PVxaKA==
X-ME-Sender: <xms:SUOaZyY4mg3Ypk8Yjv1Tp2vgNjsJSnrhI58t3TEWuwXHR09O5Owd_A>
    <xme:SUOaZ1YoGliPf283tfzSgmSwkqu1ZoHfVlN3sPGLShU12p-i3s65IdBlL84bBZ_Rb
    MLdHRgq9ITLrq1bCw>
X-ME-Received: <xmr:SUOaZ8_ICL4cok-j5QgmELyW39GJ6KkKx0X5V3qyjnI5cVGfVxcfqAa278gghFYSofrkz5ne9NaglyglwNIL7P_MXW1stOPSrvGd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeffeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:SUOaZ0rm3rPfcRdNkKaHqmSyMahIkZyZRVgrnP9DnkOyA65GGtnUaQ>
    <xmx:SUOaZ9pNSo0WqRhxWXfcN3IAJw2z0jODSW-5hZaV3wvGJ1bikQlboQ>
    <xmx:SUOaZySeczxiEryxyTt6Hz0PqODQCfvNxIMEaM9YTIOH2mzjW3vs1Q>
    <xmx:SUOaZ9o-HBFgOc5Gtt_bpKbT6wZhtr4So-Y6TTMr7xypnyPPhkP8TA>
    <xmx:SUOaZ0Uk_LYWzxCeYFino230BCj510uK5UtThMdZWuUDr4O_Kaqf7D8c>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jan 2025 10:03:37 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2025, #07; Fri, 24)
In-Reply-To: <8ddc3313-9d66-433e-847f-0330fd1d5e17@gmail.com> (Derrick
	Stolee's message of "Wed, 29 Jan 2025 08:40:34 -0500")
References: <xmqqwmekvubv.fsf@gitster.g>
	<8ddc3313-9d66-433e-847f-0330fd1d5e17@gmail.com>
Date: Wed, 29 Jan 2025 07:03:36 -0800
Message-ID: <xmqqfrl1k6gn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> On 1/24/25 3:19 PM, Junio C Hamano wrote:
>
>
>> * ds/name-hash-tweaks (2024-12-20) 8 commits
> ...
> After Taylor's review, I believe the latest version is ready
> for 'next'.
>
>
>> * ds/backfill (2025-01-23) 6 commits
>> ...
> I plan to reroll this in a week or so. I wanted to focus on the
> other series for a bit and will bring this back up (and may submit
> the 'git-survey' series as well).

Excellent.  Thanks.
