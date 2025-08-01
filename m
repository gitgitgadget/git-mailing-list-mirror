Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0EA4A04
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 19:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754076362; cv=none; b=F46jyfmY9vZU/FTqSKAK8u0dc3F0slMv8bdkVdQGE3oyXLj5iS/r9xHcQ5olDm5TLhJHFuHu6Rp9R+oveTw6rqcPeEvFc2/FA7F1DiYKINcusJRDmBMPsw76c5VpZtTZK9F/lAmlpUbjvgGdCTqaMmE2s+hktL8aAjC4m0tNMuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754076362; c=relaxed/simple;
	bh=8JP3BYd/XZVKn3CFSbrJuinjpyCTs7CBqC4uD2NdvUo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OTLA6aVYgPnI1uTH0Po6CpxnLxmoAC55OgRDuQNf1YJaaVhfe4Z+LMIQ5lH1NpB0kx7LRMSGiZOr5THjo2Zc6Cztno+SwJdcy8pNZ3jCYAfx0equu+GFaGbrV1jfNvVY92vN7vPK6NnayDmiWpz4CICHfWaajYrCxwqW2cZL4kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZubKlKbo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cy0IAvhx; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZubKlKbo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cy0IAvhx"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 43DCEEC0FB2;
	Fri,  1 Aug 2025 15:25:59 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 01 Aug 2025 15:25:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754076359; x=1754162759; bh=+cLcXszdVe
	kiaPe4Pq8RQwdDgAcn0eDx2xK8NV+0qNI=; b=ZubKlKbojoaNnVkZHFkUAy1+xS
	m7Z62apH1zbhwiS+Z90FeV/dHoJ+WApzT0c7+KTfyP5KH8TguWSA4HoPfPQ00eG1
	l5micz7dmyZMhyZJRHrrHwaRuSo5se8ni+wRL2cf518Kmf/v9iIwC8t7/XLy6gTM
	BdKebjz2D8MYres2/vH0HBHN4NCHozJWJ6L/rBDzgiiKwg8IS0zNso6yM9bKimmZ
	XDIMi5Sw8Il6mWM5liSJKuB3WrkhUjBCVAnlIxJgtpvt4wKEudXbCqZOGqpy6CT3
	LuK3XOY8lTTwPT4Priwb2yt/dPZ/PlHKTAmR9YvAiZXeGRMPTek8qt2XO9Wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754076359; x=1754162759; bh=+cLcXszdVekiaPe4Pq8RQwdDgAcn0eDx2xK
	8NV+0qNI=; b=cy0IAvhxmhqmCBjPrrjFFu4EBfsKTfRYlXw7cCwwcZUmapws+g/
	27Y2zpdjzE1J7OTQca51YspSyzGXZSBW/DNDa8xqWWm/6RSAEpXC3osQOziu/RzL
	9NzdtL8pRA98O/mrAZyvn5VUfZb0ri5qap+kjmtkiZPvsjYSTw3fwo+0qHA9hcyT
	PDPDreYVqBKR1106YjdnsOTuB9u1fZNHO5k5/YmU7p+U4iIZ1h2JolPbAAIkwtWe
	D9OS8j7bTb2ZCxtFy9D1nOOZwg3cu0GC7HunKPQJrGWnc6WAxTZc/IhoUiCvGdj/
	e8OGzKBstuCpuGLDqwmNSWhO+7/e+ivodGg==
X-ME-Sender: <xms:xhSNaNC2U3sSYLvpfI-AzU1c59xSdJUN1UZJmicOh2qaZ-KrCeRuRQ>
    <xme:xhSNaEL68Ze79W7ux-irupUhcWh04Tl_k9DHxq_akzosyfGXduvLleD1ckZbiuN6Q
    YcMiMgGD5290gnmxg>
X-ME-Received: <xmr:xhSNaACtmwBGlyJUzrfzf9FZZK1ItTGw9Gw8b3gIFouuDHeHZqIrz37EDNLYOm6IJo0lBXT7cv8ecR_33PgAuG6kpp0ejJZeLVQbN2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdegheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehluhgtrghsshgvihhkihhoshhhihhrohesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepohhsfigrlhgurdgsuhguuggvnhhhrghgvghnsehgmhigrdguvgdprhgtph
    htthhopehpshesphhkshdrihhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhm
    rghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomh
    dprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdp
    rhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehjnh
    drrghvihhlrgesfhhrvggvrdhfrh
X-ME-Proxy: <xmx:xhSNaBvEgWsFOIjBDf7zxVUQf_HZJQEdacp2Xu8bM8eaXigt57s9hQ>
    <xmx:xhSNaGQshkxxSJ7Hfn47uYm5wCeS0_kHzH_NyAu-MBbiPWnTDPVqWA>
    <xmx:xhSNaAL4g4286duhK0HLjorv9mw3uCw6gTo6vFxDxY46srDG-6v6Hw>
    <xmx:xhSNaBuiiGKhZZ0jfi1EIgndM5NK26ZpoUhZVHlPDazhbbRWm9n5EA>
    <xmx:xxSNaO8wrSgWNcdaA5aZiUWQydm6bnY6alGCIUxKxnXtYtCCe5mG1qAH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Aug 2025 15:25:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org,  oswald.buddenhagen@gmx.de,  ps@pks.im,
  karthik.188@gmail.com,  ben.knoble@gmail.com,
  phillip.wood@dunelm.org.uk,  jltobler@gmail.com,  jn.avila@free.fr,
  sunshine@sunshineco.com
Subject: Re: [GSoC PATCH v7 5/5] repo: add the --format flag
In-Reply-To: <20250801131111.8115-6-lucasseikioshiro@gmail.com> (Lucas Seiki
	Oshiro's message of "Fri, 1 Aug 2025 10:11:10 -0300")
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
	<20250801131111.8115-1-lucasseikioshiro@gmail.com>
	<20250801131111.8115-6-lucasseikioshiro@gmail.com>
Date: Fri, 01 Aug 2025 12:25:57 -0700
Message-ID: <xmqqldo2lu7u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> Add the --format flag to git-repo-info. By using this flag, the users
> can choose the format for obtaining the data they requested.
>
> Given that this command can be used for generating input for other
> applications and for being read by end users, it requires at least two
> formats: one for being read by humans and other for being read by
> machines. Some other Git commands also have two output formats, notably
> git-config which was the inspiration for the two formats that were
> chosen here:
>
> - keyvalue, where the retrieved data is printed one per line, using =
>   for delimiting the key and the value. This is the default format,
>   targeted for end users.
> - nul, where the retrieved data is separated by null characters, using
>   the newline character for delimiting the key and the value. This
>   format is targeted for being read by machines.
>
> Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Justin Tobler <jltobler@gmail.com>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> ---
>  Documentation/git-repo.adoc | 31 +++++++++++++++++++-
>  builtin/repo.c              | 58 +++++++++++++++++++++++++++++++------
>  t/t1900-repo.sh             | 21 ++++++++++++--
>  3 files changed, 97 insertions(+), 13 deletions(-)

This will break t0450, won't it?
