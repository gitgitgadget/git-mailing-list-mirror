Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FF04A02
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 16:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774627906; cv=none; b=B4PnLSzreLLeDnso5cO3R3Vh53kDaLtJfLNOBAnaHzchD+kTzWnAa290lJR5qJCztcr4nQzLXPM5OgT78gUzwT6XUxQj0D9Pf0eFu+rMald3ooGclSbgqHAEfqLH17nypCJZkeMoQVpYD8yD99Gq3cHk+KQfD5fhxMR7ZrVlE24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774627906; c=relaxed/simple;
	bh=Xe3FK+YLAye5GZjO29jgLOxLqFx2LDhlYgQcrXb5r9I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bVcyJ4eQKf5h8MdGzS6gfecA1g4MmzNwJS434+iz5Hsfm5QioH3Mei9HmY4hgBR/s6o8eQEgXH9WTUA8Nb2sfYsxCXhsHMDmTAfIWoyy3mK0YG4SrDx3VFVIhcWj6N2gZWPMGaG07iczGn6yCVToakQcUT1AzqS+ZvL1VjCykIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LYKo/+CM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cLHpCUUl; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LYKo/+CM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cLHpCUUl"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6607E7A0070;
	Fri, 27 Mar 2026 12:11:44 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 27 Mar 2026 12:11:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774627904; x=1774714304; bh=Xe3FK+YLAy
	e5GZjO29jgLOxLqFx2LDhlYgQcrXb5r9I=; b=LYKo/+CMxdQxHX9t6zoXgf4Kaw
	g36BTKNA/wR2DxqwE/3TXYvK0hRt15YYeQwhmrVmgLHpfrwrQGbeLDerHjxBJVe+
	dIhCoia9/yf9jgBLkb7YoSioAvtrAJDoDKTQt7QQlMP5wGvaipKW/4P0CgDOIvCR
	O2wOQvDdfAltclASJ756Dh8AwrpJjJrPGwAHD05P+iRqKe6jl4BWTS/ztrPlU24a
	cR13oL74hmNsyi0U01LBIhFGfmMXUyVyrIrETVa2elbUefMUqEw4G5VW6rvMnl5l
	t6/dGZ2dVmNigX644w/s7UYphyFZCdvS+KmGnd5huoOjbuLOoymc/7XXy1ZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774627904; x=1774714304; bh=Xe3FK+YLAye5GZjO29jgLOxLqFx2LDhlYgQ
	crXb5r9I=; b=cLHpCUUlyNLspUGf0zfbFCIhdg7UGLxeDPGCkWOcPHZ+KjG/sUM
	PGxhpHBnmUVezMo4lta6qu8sWXO/WpPMg23SLb+XvRuZb3EbF4IZ7TebwWf2LJSX
	dHr3uPIG88f1dS7y7Tm7X808HzcBXB+/3UMkwCMKH6uRYom5NVP9snw7uo7UjlRY
	RKsn8iKoKRSPIA8dRK270Joez0WyNxD+ZTI4dSlhXxSDQd8BSVEygC25EJNAeihb
	m3NAgAFR8ymQIVfqvIN3bZLaHqiC/dmI7du5KaawzpWpdp6Wq7XJBZY5BhlHX2C0
	SGdDrFAR9J+BaLcZii+UKAI0j74ER/0Nf2Q==
X-ME-Sender: <xms:P6zGaav9GmGxMG0SsmJyrjSYpWsXSUMNGhIWk70NVvPKoGMJuLFugw>
    <xme:P6zGaTLlerNW_rR986pnJq2Pqz9g0L6k993R1hPASeJxNMFFiRq38VrvglGi2NMz_
    BpddhTvYtFC7aHLYoTTHCd5iPNZz8IVYgZ_huNWOsHm4PaAPH4cXA>
X-ME-Received: <xmr:P6zGafncGcTac-0RUB8b1lO83gEnEiQu-hZGNB1QY2YIh1b2I3wznCUD_QmZKVx2GL6ul5Jl3VCHS4k3byoN1frzogGJWEGEOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffedtjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopegrughrih
    grnhdrrhgrthhiuhestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghmihhlhihshhgrfhhfvghrse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohho
    thhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:P6zGacI7BEOC2-pXqTBKu7UntxMcf8c5QksWH58s8H2rNFP0jjdZ4A>
    <xmx:P6zGac6Myw86ZyYcXU8M7RkqwsuSBL7nY10RiB6jS0A01oYcQTzkSQ>
    <xmx:P6zGaY0mRJuzdXJc5ZotUhDOL_Umj4HRIW4WXdYuOAwDadDUNXPq5w>
    <xmx:P6zGaaeOqzSXKxvZPe8amizr7mcI0MbQFvYZELl0_FN1WchnL9EyKw>
    <xmx:QKzGaRm-FqYkZZJcGk9TKxuYSJaJLXv0vwxSrMg7OczL9XxR7h4hZfDE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Mar 2026 12:11:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>,  git@vger.kernel.org,  Emily
 Shaffer <emilyshaffer@google.com>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 00/12] config-hook cleanups and three small git-hook
 features
In-Reply-To: <acY6KtREkGcf6dyp@pks.im> (Patrick Steinhardt's message of "Fri,
	27 Mar 2026 09:04:58 +0100")
References: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
	<20260325195503.1139418-1-adrian.ratiu@collabora.com>
	<acY6KtREkGcf6dyp@pks.im>
Date: Fri, 27 Mar 2026 09:11:42 -0700
Message-ID: <xmqq7bqxmev5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Mar 25, 2026 at 09:54:51PM +0200, Adrian Ratiu wrote:
>> Changes in v3:
>> * New commit: properly initialize strbuf in receive-pack.c (Patrick)
>> * New commit: add a check which prevents unknown hooks with git-hook(1) (Patrick)
>> * Removed duplicated function doc comment between .h and .c files (Patrick)
>> * Extended `git hook list` test to also include a hook from the hookdir (Patrick)
>> * Converted unsigned int disabled:1 to proper bool (Patrick)
>> * Minor commit rewording, header sorting, blank line fixes (Patrick)
>
> Thanks, I'm happy with this version!
>
> Patrick

Thanks, both.
