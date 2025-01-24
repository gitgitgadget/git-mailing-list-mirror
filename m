Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF85715CD79
	for <git@vger.kernel.org>; Fri, 24 Jan 2025 17:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737739551; cv=none; b=gVKMplrdnh4Ke3DzKNDlRXWDV+bbu0HTeBq8zqYeLkJqf4Bnkk0UYKA7tj9J3/Pjp9h8NmtVVHuDRovhiYg844hprRbOlxxruMEqg7iTeYXhHADd56bVrO+KamFyocyLZYvsu8F4bbwZoh+h6e5ryR1cNL9m10WKo3rfkrxWu4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737739551; c=relaxed/simple;
	bh=rjgE3ONDmK3jBIjV/JQ2GDVVp0f4/dorLpGtXeO5Iv4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZpxvwPh/AocpBFx4edSfJFPZiIbTX0v5H40nP1S7PbHXVGyprjRkb433qp8NnljUfry/VT/bgOCz9J87B4Djc4QF1GJlQo9oHkm1eK0ckjtlcgfiTaoVgvyG1ZiPWnwuzy1Q7w0nTvdDm5/StpZzkJNLZiPuy/4lpqWWXx+pK/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WnlzMl8J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DcE9FY2A; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WnlzMl8J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DcE9FY2A"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 9252B11400AC;
	Fri, 24 Jan 2025 12:25:48 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Fri, 24 Jan 2025 12:25:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737739548; x=1737825948; bh=qZZIaHAY6c
	u2esMSoBjv73bwbjkYUAMFDy9TSgzRI0U=; b=WnlzMl8Jg6mV7h6NjhvTQ05oIs
	rfOjTbQioXrp9VQpoihoRmXAKVP800AO03R9xLUOl+kr1+mZFicP/NL/qkxMBKRt
	LVNxBH9o8MELc3hllRlaLnGNjk7vn+Amm+xawjDKQR7pl9sBuIuIt7a6WVqZlbav
	w/TktozO+k6/T2/1TvU1ykv3mHt1abDZBI4EjpdSph7v6B7Au4B8YUcWv1vnS+23
	UATfj6wDABbZR/5oNIyxeYSGq/WRw3SxdVA/TfnXUtNNNkshMwW/b3khJYvqtlQK
	s8zZW+GKHJtEZJYV9kvtgaNlG+p8VnlfRZqt93bxiiypnikL1FiqjtzcTfNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737739548; x=1737825948; bh=qZZIaHAY6cu2esMSoBjv73bwbjkYUAMFDy9
	TSgzRI0U=; b=DcE9FY2AgxUUPvQy6w4Pdwejcm5v9GUQAOoaCVmnOLVbczfDcNE
	M1csKNT5PdD6Ppa3j3Slfcr9YIxe8dWT262K83We+7RbATTBcQt9RGZdHOnvGafE
	/xu3wm6bYwmrSYKTz3PLPspHmgnfuPJzjqWh8GNu74Ey2Q5ZCeLycCDb62c/p8R0
	WZBu5MasnV6JQVx1w7UMgHWT3vLJtCI+71+LCyWJ7KbvB2ubR2WhiDS/b7xCizxI
	DYKeenJFcqdy+BlL0GErpv2WdCq5DjmjOSiJHaZ4TT0LTTCMlVCLVFq0PSokJuhr
	zaNHSJtBv+DjOqU+5eoY1hND8WkmG52MY2g==
X-ME-Sender: <xms:HM2TZ0duuPvL6DJ68C2ywx7VRUIkzKHUqa9dqP56AmJsnFSxZxmXVQ>
    <xme:HM2TZ2PaBGTkRbX9jSG0nM3sUzg2pKEb0x9JZFY4GxPTLgI0nhtS2PRxPCgf9vW53
    gTYAqXw8kmlnTnRFg>
X-ME-Received: <xmr:HM2TZ1hG6hYJ2vNPGZvxEUWZ78GfxtHQwtP5f9qoMDENPWrC0nQHL8WXggVzFW5GUXwM4vhiMla0nstWwKEBfdyBZwqjyNxf051->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedghedutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigfefkeev
    teevveeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhs
    thgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehmvggvthhsohhn
    iheftddujeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepshhhuhgshhgrmhdrkhgrnhhoughirgdutdesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:HM2TZ59v9qrenqfuOsvgTQ6xN6DtDzIZnTb43waOvH6tYGK4xY5JNw>
    <xmx:HM2TZwslDjgX-Ouh3eP0oLvsVJTI-X2vjzJhGsafx_4ohVScV-031Q>
    <xmx:HM2TZwFEWMS5lgOXe45wJK7frQMjvebuOp5n2kLHXkn3w82AjKMK2Q>
    <xmx:HM2TZ_NrN-gCFHozydg_LQdpLkmCjuSngX1UwGENvA0gdMIOM2fEfQ>
    <xmx:HM2TZ6X-OyAM9JhPDAwlcWavAp4AvCTWhnAJ5M07kPpY3PqDPrYjPN5p>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jan 2025 12:25:47 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Meet Soni <meetsoni3017@gmail.com>,  git@vger.kernel.org,
  shubham.kanodia10@gmail.com
Subject: Re: [RFC PATCH 0/3] refspec: centralize refspec-related logic
In-Reply-To: <Z5NI4uUaeHknckJY@pks.im> (Patrick Steinhardt's message of "Fri,
	24 Jan 2025 09:01:38 +0100")
References: <20250122075154.5697-1-meetsoni3017@gmail.com>
	<Z5NI4uUaeHknckJY@pks.im>
Date: Fri, 24 Jan 2025 09:25:46 -0800
Message-ID: <xmqq1pws15ut.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Jan 22, 2025 at 01:21:51PM +0530, Meet Soni wrote:
>> As Patrick pointed out in [1], the logic related to refspec is currently
>> split across multiple headers. This patch series addresses that by
>> relocating refspec-related logic from remote to refspec for improved
>> cohesion.
>> 
>> There are a few functions that seem to be on the borderline. They seem
>> to have refspec-related logic, but also contain some elements related
>> to remote logic, so I'm unsure whether they should be moved.
>> Specifically:
>> 
>>     * get_fetch_map()
>>     * count_refspec_match()
>>     * check_push_refs()
>>     * match_push_refs()
>> 
>> [1]: https://lore.kernel.org/git/ZysQvUyxgdRqjvj2@pks.im/
>
> Thanks for this series! A couple comments from my side, but I think that
> the overall goal of this series is sensible (well, I seemingly proposed
> it at one point, so no surprise there).

;-).  Nicely done.
