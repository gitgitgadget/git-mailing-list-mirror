Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157F83233E8
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 22:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770159253; cv=none; b=sUTBTYipILApkZP7N2N28upIO2/ArPcmvCEkC9sI1angUHuvEczGRQIgbUE30ZEpN7XGXtqQbCF3D71MD0GkN9wfkfBDGlnVzjfBg8mgpW8+5N3/+FRxk+1vkztMmMSkR0dV4N//SUJTRZRuGhiDCPv4iSHw2z/ujv+8Odvf8xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770159253; c=relaxed/simple;
	bh=lFb7EE5fr/LNydzKJbdVASbbjgaZZu8/DdyJudzrvs0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=li9fq/38I8ql2NZ+/ZoWVjq8dk+zfBemyqrjzKUG0F7tTzQ/hKtlq2odEWULTZWe6XWfNr1+foAxeouNPg7QffJ61ROMaq6LkYV5ofGZQDy4BFyJ9mbIKRlicaJB0Kgq0XvKSIo+AgEEugts96UJqlo2agdNKLF5m5YTHNf5cdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LRWL+foa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tOX85YDH; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LRWL+foa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tOX85YDH"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C2D717A0193;
	Tue,  3 Feb 2026 17:54:10 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 03 Feb 2026 17:54:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770159250; x=1770245650; bh=libCZb7a0N
	e8pxuhKSu07x4eXvmESKjGaHapUev0mUM=; b=LRWL+foaTOgLptWQOGE0iQJStm
	y1Jun6Swm0wMsjJ3AgE+1mo+jzGLmM7XuDse2slEIhSasNVI9BXvRQAFCXSlWht+
	JZM6cvdZmIlQ3kx+hJEQFb+OcCXesKgkCGVYzx6NXZq6Hsab20liRfyS06Lq+f7a
	V5Fu1qc3bgGb/ewQbv+P8T+TCcxzh5Wwel92l3gjQS+68vXrn7FLGOZOP/ej0G4n
	n47VtsEH3649I9Bz1VfkDCzB5Q822A0vY2iya65Dd7rz1VhWB1XgG3hWC4vTaPzT
	bqxA+Nmw7unMLf2mpZKe0UqGx/wwhJtDSdaVFevqPhF7GCxHcnmqYrcKZ0vQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770159250; x=1770245650; bh=libCZb7a0Ne8pxuhKSu07x4eXvmESKjGaHa
	pUev0mUM=; b=tOX85YDH+qGUQaCJQBO1Z3LLm3N7e3U223bnFwtMVKLsVqCqPtL
	fK6lZEnzM5lzi31VLC/EKvFh81ULJRN+qGfnGMwNG7jPvdxdOUra0qbuLacbIfxC
	37EZWBvWOG67qO3TysbpxiUDPKa2uA4x4BPxaEu501xI2uiROqtWt8CiDb+I0abh
	SHLxlwaSeKWdQfLlXHbV9MEzj/BB57rUKjpudrcliqj94UnrmcATyaQzEhWMYyTk
	/737Od26aNGKG+enQnf6WlI9bhUHhE/tDhzqZInzz74FFyVJtPiFFEc8VcPbmjsz
	Y2pzbrQZC7Is/unvhFIpP45BWWT+eE1zj6Q==
X-ME-Sender: <xms:knyCaSYQAjshS1YKVQn_PnfEq7kKqVbH5OEBNN75wg5oEY3ajGuOdA>
    <xme:knyCacTql-x6FN7aNeAvsF3qB7tjS4k64AmcWimImJBQpgKl672hDZyxlzRfSbQe6
    F667DaaZd2YeVyxIoPa_lw4jpEG4swQnFXzeyIKnIh_s_qwLgCE7w>
X-ME-Received: <xmr:knyCaVSgXUHsfZwV2XNVwmL1Q15apolbkyMmGLbOc98Y3nJQgIShLtZJfNbEuLfb_tJTcVVNxlJSmEtbPfa8Xj3Ri-Vkx3EaLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeduvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:knyCaQTm-R32drnjdEECGhM0hXjAHD3Pb4py6o3yzJPBYAXM_ig0dA>
    <xmx:knyCaa5E1ABP4rVuhkL8sat4rkYz8HzA8FSlJlO8dxgrnAG8zOy8tQ>
    <xmx:knyCac3reUiQfgKI0JsbHWHY07akBncXjlrSqWjjUxjPKvYFyeszfQ>
    <xmx:knyCaVDc-OIkoyGaBIF45mfIKuXVWTCOzgkOmWDsip3MdCVg2-VQ_g>
    <xmx:knyCabu_ClRe1vQVL0o4oTL43nKqgvTDlH5RoxloUjgdsnhCOOpWHWKk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Feb 2026 17:54:10 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: Toon Claes <toon@iotcl.com>,  git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v2 3/4] odb: prepare `struct odb_transaction` to become
 generic
In-Reply-To: <aYIirIQveQiNWzsx@denethor> (Justin Tobler's message of "Tue, 3
	Feb 2026 10:46:22 -0600")
References: <20260128234519.2721179-1-jltobler@gmail.com>
	<20260203001002.2500198-1-jltobler@gmail.com>
	<20260203001002.2500198-4-jltobler@gmail.com>
	<87o6m5rff8.fsf@iotcl.com> <aYIirIQveQiNWzsx@denethor>
Date: Tue, 03 Feb 2026 14:54:08 -0800
Message-ID: <xmqqfr7hqvzj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> So long as `struct odb_transaction` remains the first member of `struct
> odb_transaction_files`, using `container_of()` is functionally the same
> thing as casting. This is also how we do things for `odb_read_stream`
> and `odb_loose_read_stream` so I don't think it is too big of a deal
> either way.

It would be a good theme to clean them all up, together with
existing ones, in a separate topic.  Code hygiene matters.
