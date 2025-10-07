Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D8B2E8B71
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 17:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759857089; cv=none; b=K+AzcDwjmNn0ahEGGqDJRZlhnteCA0MoThY4Tik3a9ysAV7CzY54TTYU07QQVJo+TQYLbF+pQa571XNDu8Sx2KXtDTwEeLRRSrhVTP53hCkA1GIR8qylNp7d7F4clhu9rAgr1XD8IV91pSfVwcljALMcfbd/Y5pSi8lkxDrQmCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759857089; c=relaxed/simple;
	bh=aoWWh7DG6NUP0jIxgVYsdjXRWV5xGBAsowIv7ZZt8vE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t9k2aBZ31e+3NcPjsXO3fvtGKMmVIl/PdwYEMiEUM2m7OsvAGYDib9fMA9gHGxYw9qlhrpR+RvPFTCAGiHKdR4aRqX28osfMoR49sHonqFtZ7fM8yP73R+rt+t7+8A7nl7APuLEPH7W/QtvudaE4eJ+39e4tj+5T/RbByZ1erd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CxVWEu9w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KEvxMRRy; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CxVWEu9w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KEvxMRRy"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6C7767A013B;
	Tue,  7 Oct 2025 13:11:26 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Tue, 07 Oct 2025 13:11:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1759857086;
	 x=1759943486; bh=nZl7u98zzMXCcU/I+41a138ilVKnPLrtrC3xDDxji10=; b=
	CxVWEu9wmD2t8BpCtqwNJXJwui0poGYLhzY09Fa1WBgv9TNBbUGOlIKy8BiwrrKj
	hNeDOcFgKH0Zu659swdhhRY8U4t7iZrZZsF8MSb4jq75PhEEUzlGooR3X1pscNOn
	CeblPT/HRML2Oh2grN7/QHeb0d9Bb2NRG40zbmEpsJYkOGcVd2hXsARizdIbqr/D
	ouxVwDERYYqZEpv9gb0L1lTw8CIQp9fnA014FAP/OPz5raWIDgPVppNHya5lmdiK
	KHYJg2r3HhXw6xUP3w1KK9i/oKhWqaxcRDz8bp6IpcNT/miKiB0DaPBcU7RRZrJY
	TUiZSWRDKxrvaD/3tWNglA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759857086; x=
	1759943486; bh=nZl7u98zzMXCcU/I+41a138ilVKnPLrtrC3xDDxji10=; b=K
	EvxMRRyc1dAn7zQeVQzuMh2hHJyh1jWZ+MxOjj53tZ1e2jBPx+iU4kWPrbSA95vw
	bRjfsx8zwD1Orj4fSNM+GPE9jNNYW/Ve8ENRHtI9dF0880UU8CeBkBq2VOXZWxQP
	/Ma6QsP6yqhLDB+QDWpLLerLDWJgPIZqJXqV5YVDRV5zWNmWpO/geW2dnpXFzOGP
	6qFgl48Ms0FztW6W1yVqq9hOVM7Zup9lbXOpfehBojLszajYiHpeYB13Um0i3su2
	DJ3oJArCufFEBTEemgmCIWV1gZx2mtR5AyPKgj80X6eDVEoEsjWWT7jhXrgthV+z
	T3BqwhXiKrufXuvLrLR1w==
X-ME-Sender: <xms:vUnlaNasTmzJP5MpvUgB4C4vq3yOUaOrg6b72IJetuSGJZ7p79lX2g>
    <xme:vUnlaIEcga2Ubs6sd5pbV5a0wvNFAG_yvBVwuGKlGcUEqh4CpZ5zkt5Yz1NHa5lyJ
    F_DdvfagUGMLlSjxG_Bt1Ih85y2UMiX8-b-_s3JKFEz0ievECKf>
X-ME-Received: <xmr:vUnlaJxjRE1fdUZgpvp8wePy95nSQ8lA2L5iLh-yp9NFaMv_3eIkgI8ZZaT1g33Bc28Nn3qC0IwsfNoEQya8BQUGTzSrtd7KQfSP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddtleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepmhhsuh
    gthhgrnhgvkhesshhushgvrdguvgdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgt
    ohhmpdhrtghpthhtoheplhhutggrrdhmihhlrghnvghsihhosehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:vUnlaCkBWlfhAPFb5CdMPBZ1LfOkY8bYtVIzvOxxbvRv5hh8sg691w>
    <xmx:vUnlaKkjnxQJhq3lkJbAJ-iwQ48I_rhooilcwBNVYV-mRsRpsQwrbA>
    <xmx:vUnlaMwjyL4Ym1PXz4mAly8bMAq4kj2IoyOTGr-DxuIttydDV_Dt3Q>
    <xmx:vUnlaHr8eAFlDAFBMssQzW8hpnqkbUyPiYEdEfXxTuwMElVa2GYZeg>
    <xmx:vknlaNJb9NSYX87j6w9V6jyWdJSDf8fgeWzIguXiQJ0ZdOY61OM9TIu1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Oct 2025 13:11:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,  Taylor Blau
 <me@ttaylorr.com>,
  Luca Milanesio <luca.milanesio@gmail.com>,  git@vger.kernel.org
Subject: Re: When should we release Git 3.0?
In-Reply-To: <aOUT2Phklc_ZDhy9@pks.im> (Patrick Steinhardt's message of "Tue,
	7 Oct 2025 15:21:28 +0200")
References: <aNxivuJEnSHbQNdr@fruit.crustytoothpaste.net>
	<E03F997F-1738-4CF6-B7D5-206183FA5BD1@gmail.com>
	<aN1RFvz7uGPnepxe@nand.local> <aN5-n_ArhQqaQZgt@pks.im>
	<xmqqfrc1xqsp.fsf@gitster.g> <aN6j7giOosGreKUW@kitsune.suse.cz>
	<aOTrC8CRZm5hERgr@pks.im> <aOTtPxsdzJLPCruk@kitsune.suse.cz>
	<aOUT2Phklc_ZDhy9@pks.im>
Date: Tue, 07 Oct 2025 10:11:24 -0700
Message-ID: <xmqqv7kqk56r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Oct 07, 2025 at 12:36:47PM +0200, Michal Suchánek wrote:
>> On Tue, Oct 07, 2025 at 12:27:23PM +0200, Patrick Steinhardt wrote:
>> > The question of course is how to get such roadmaps. The easiest way to
>> > do it is probably to gather a list of known projects that would be
>> > impacted and just shoot maintainers or representatives of those an
>> > email? From the top of my head, that would include:
>> > 
>> >   - Implementations
>> >       - libgit2
>>           - pygit2
>> >       - JGit
>> >       - Gitoxide
>> >       - go-git
>
> pygit2 is merely a binding for libgit2, so I didn't include it in this
> list. Same for other bindings like git2go or git2-rs.

Is dulwich still alive?

>
>> >   - Forges
>> >       - GitHub
>> >       - GitLab
>> >       - Bitbucket
>> >       - Forgejo
>>         - Gitea
>> >       - SourceHut
>
> Yup, this one should be included here indeed.
>
> Thanks!
>
> Patrick
