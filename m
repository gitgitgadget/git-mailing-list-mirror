Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C614176FB1
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 18:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776104493; cv=none; b=u/9QKW5cqeyzYcjtSRd80Tx5vRQVkaqWqGtil0nKfPCUBgQwMseZ2bY6hOn5R6HKoDKOeODAqTLRsE5qX7SMOR7G5MpIVHrzJx1QsJF2a7PB+h5xUZNCybXrwZ6MDvtAwZ/rB76iFFw7fMF066QaATiO51FDlz96AVEnoSuh4BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776104493; c=relaxed/simple;
	bh=a4i659t5yaOpkb2PBxzSa5uxeqAaMhkdSvjwO1wJEJo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mx8ni/K7jetJ/eMJh1y5CHZnxb/sXn2uxbs8U8bDGCKHCWZZ2wFQeLA3vSzN6MG3Zc5I8+hntjFqEkQzmPjk6SiTSrs8sFCWzc7SDxE4GXRBqyg7M65bLpkAa4mXwXH5ddsskO01388FlLYgTS45s8qqxdHZKA4fJf0r5YucjSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xwPmbQQh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TR3IqNkh; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xwPmbQQh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TR3IqNkh"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6A45014001E0;
	Mon, 13 Apr 2026 14:21:31 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 13 Apr 2026 14:21:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776104491; x=1776190891; bh=Q2zcK1o7VJ
	r+3MhCzcuXLERudl7lhDRZ7EWmce2hZyg=; b=xwPmbQQhXia6qP/7CdotkrE+qA
	g3SccL32xucL5ScL3W8vJlbeMd0SHcg+hekc1MX6zYcXXq7mzGUWWkt67JeXItFF
	Kou/piiEaW/tIJkkl+CMly5cZk3l+K4O7GGGoV42aotdmIpinMIeaaawd6woWAsa
	iS3qUd4YZjNf1ve5R392TK8NPzZC94mtxMzv1fLwQdQSL/WfF2yhgLEmbAeoO/6L
	k5J0kDFmMgPJvD6BQP9rm9/LqUW+Ke8Hu6stto31pkaguHQelEWUr58+ajhqWvBI
	OuhdBg5OJNfUwP5Z8YCG69xxVm7KZJDX//xYXO/QmKhW6JZDTzBl4RKdT5Kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776104491; x=1776190891; bh=Q2zcK1o7VJr+3MhCzcuXLERudl7lhDRZ7EW
	mce2hZyg=; b=TR3IqNkhE5Drq0xQ/MHIPMxWqYQudJ+w2yuOg8zVAAOr/v0hv5k
	50o83crBi5J8baQ5XBqL555Hzlld1fGo9VIrIu3ezL09ZUxxCkSYiBOnRK0zmMiy
	/uZx5JBoblk2Ghy5TIoWBLcPGJN32c2+V+fQxBcU+dnJmgmozY2D/o0syZoOFfZ2
	kOFGjbyYZac/cgCPlwhygUaCejr3qEvHj2VXZU3lNe8LgVhKGcPO13TO0a7VBOMh
	bLiQw/cIIEKM1mNwZmZzP/B2NrYP7httEOasJfynwPesJOuWaPTJMEcybkR9NP7k
	r30j493xRX5OiOUYsDQDpqp2D+V9L9Cmaeg==
X-ME-Sender: <xms:KzTdabB-YucjlhrV8m9O7qREuItsPHfulbAfGeamxeupuz8wRDnf0A>
    <xme:KzTdaYb3Lohdvo0Iyz99CsnbG5vmmC3t4Vr-YHrFKR8iSZmuQxYfu4q1Lnt6WEhpa
    is6NZz8wRgm6lQ_k1_RqTmAWzCSHA-M9hf8VhnyVerafNa4m4fA>
X-ME-Received: <xmr:KzTdae5a_DTkATNnq7kRQKuYPamx-3ej2L8tyQYheuCYneqHOkAWujQjZjNrBnGsUZ_7zFM1ws2Bc3aKiakYOtg1hLTmKbActg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefkeelgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeejvdekfeevgffgfeefffejleekleeufedthfeugfevueeuhfefleeijedvhfeg
    teenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhrvghlvggrshgvshdrmhgunecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgv
    rhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhm
    gidruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:KzTdaZa1LQZ8p9O3yEBVIOpxF6FjBY71FMh11DsSA_2XUddAhMr_iQ>
    <xmx:KzTdadjR-GGP72cO8eF9tybmL5cDVahKCddNDRzI84Ir8H95wluTQw>
    <xmx:KzTdaa_ClQrsiStLc1Kz-yHScXJleQh1PNYtuS1zMJ8IbvMCbfj-Sg>
    <xmx:KzTdaYpmOqCuL4bLcfvdvQ56FNdY1cLKdo6lmGlNHW7xR9sXLekWPQ>
    <xmx:KzTdafyoH4qDEuO-n1HmWQj3sbFKnh0-8_dLaU1dKPNYzySROzFaZWf6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 14:21:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>,
    Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] codeql: bump actions/cache from 4 to 5
In-Reply-To: <xmqq7bqaiwm3.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	13 Apr 2026 10:44:04 -0700")
References: <pull.2086.git.1776097457136.gitgitgadget@gmail.com>
	<xmqq7bqaiwm3.fsf@gitster.g>
Date: Mon, 13 Apr 2026 11:21:29 -0700
Message-ID: <xmqqpl42hgba.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>
>> Bumps [actions/cache](https://github.com/actions/cache) from 4 to 5.
>> - [Release notes](https://github.com/actions/cache/releases)
>> - [Changelog](https://github.com/actions/cache/blob/main/RELEASES.md)
>> - [Commits](https://github.com/actions/cache/compare/v4...v5)
>>
>> ---
>>     codeql: bump actions/cache from 4 to 5
>>     
>>     Just a regular GitHub Actions bump
>>
>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2086%2Fgit-for-windows%2Fdependabot%2Fgithub_actions%2Factions%2Fcache-5-v1
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2086/git-for-windows/dependabot/github_actions/actions/cache-5-v1
>> Pull-Request: https://github.com/gitgitgadget/git/pull/2086
>>
>> updated-dependencies:
>> - dependency-name: actions/cache
>>   dependency-version: '5'
>>   dependency-type: direct:production
>>   update-type: version-update:semver-major
>> ...
>>
>> Originally-authored-by: dependabot[bot] <support@github.com>
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> ---
>
> You should not need to be reminded on how our log messages should
> look like.  Also your sign-off must come before the three-dash line.
>
> Thanks.

A tangent, but I probably should mention that I didn't even notice
the last time we got identically malformatted patch submission in
October,

<2443e519f0ff6160e058d391495dd51256595a48.1760629692.git.gitgitgadget@gmail.com>

which resulted in 63541ed9 (build(deps): bump actions/checkout from
4 to 5, 2025-10-16) that you meant to sign off but ended up
committed without one due to the premature three-dash line.



It seems that GitHub Actions started complaining about use of
Node.js 20 and I was wondering why only one job uses
actions/checkout@v4, and it turns out that it is a semantic mismerge
between e75cd059 (ci: check formatting of our Rust code, 2025-10-15)
that added a new use of actions/checkout@v4 that happened very close
to another change 63541ed9 (build(deps): bump actions/checkout from
4 to 5, 2025-10-16) that updated all uses of actions/checkout@v4 to
use actions/checkout@v5.


