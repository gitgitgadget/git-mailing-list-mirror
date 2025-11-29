Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E741DB34C
	for <git@vger.kernel.org>; Sat, 29 Nov 2025 22:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764454905; cv=none; b=PNyQsAathj73oQaf34Znodw6xpyXhPVbM21f84FZwyTTdVPtxnYR8jLcqMlXNnDfuOrCoWP8uKB45m+FPwK4OeOdo+4QDh1TwL7gMjemOOd5dOPNulG9VvJVksGJpNztm7u4kM4MG6Rd+WyTEoNve++wMGpTeLk/rKI/3K7fvKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764454905; c=relaxed/simple;
	bh=QNye8XO76mIpRCCjYGlqIBPmGzGGgLV/YhNzsYq8o0A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Me6kYzAj+a7PGGJSpN8+BvwkarNL4i1mJrHrsCntJf+pJ5hdBPphq5g21FHB52mthbakg7HhKgYM0L+TgbqKpxNV15eANSnLnmp5TK85XLNim2ObObhq6AhrQHFbJI9npV1y0HxgJx53O644Eq037xrUYufycXaERiVJQOHYpPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gC+QuKe5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lf4LJ4/m; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gC+QuKe5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lf4LJ4/m"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 607CD7A00A3;
	Sat, 29 Nov 2025 17:21:41 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Sat, 29 Nov 2025 17:21:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1764454901; x=1764541301; bh=btWQv+WD2S
	H9TNOT3YEPOKxh+cw7TqCUO+Sy/MHMw9c=; b=gC+QuKe5SjrrVX3MIx5VsOfrz6
	cKhOWXv5IsNSUN2x1oxQ7+Tl11Hci6croBaBsnsXHw6i57z7vd7JBPPbholoTr2j
	2OHowSJAwI0JgYkYLkyKv+VI5RZIWCyn0Piswqe1u7J8wzkiNCH43wDnr4cBCT6h
	9Q3y+s3SkhPFww6utr+nQ9NiKk9nOwKD9627G2hPKNyEHHPZSEHt9+5fF8txY7i8
	Nj2DWiSvNpPx2XjSYBbk9rU5RhXEnqyKClw5C9Y9fW318CKicM9Rz5mDpyPM/ln0
	vc4kpmII32GCEsbZARNhTqv1MNqgfOO3sQRKz4bmzqxM+wg/L5KiXOA+SrHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764454901; x=1764541301; bh=btWQv+WD2SH9TNOT3YEPOKxh+cw7TqCUO+S
	y/MHMw9c=; b=Lf4LJ4/mVSS5T1Z4kfQmcdoxflnpAkbCl/fCKNDswTawCJ8s3+x
	v4kanmuPaN3iMBbMHwcXuvauT47/sZy3h/mUbd0c8TUwp7IH9WYYri7De9uBRI68
	50jqZdiWcubn2KhzSL4CUqBV3NltBe66MTDaaUrKvml1tMpuQqkokO5tzSG0Ep5F
	KeTzpK9lZErbWQ5a0s+TYawUs3RKATGsiTXjOtMNGqy/TRZv4sD/eYrBpiS8bDWw
	c8yCNEC+aOGREEDK1wTGI9H6olAxCxHqapPN230hMJ8dqfj6wSMUN9Ir99ECJHCI
	7JM8yHrwyVvTdtgLUq66818fO+nSKgSCVSA==
X-ME-Sender: <xms:9HEracWhOI48LfwG-TlPZ9HxkVah3EfWTUf66oolpXcAtjjYrLYyBw>
    <xme:9HEraYzvgSkbrtM6i3tlNNL3MRpUlXbYBA__O4e20Ti2h2bn0jxoibXTvcE0r7cBv
    16YofYy5D_TUSVc1mDMRMIZLIIDEJByIWvMiceYptiPs5Z3-Sm0dF8>
X-ME-Received: <xmr:9HErab-IFTC6gAj0d6Gbj7IvpoUcP8e8fr1BFlPDoxLbG5cCWQP4WeshI6aqwz7YTAHpo7K8ISqURQzqkpmm6BHri2wEVJQoEX0l>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheefgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepgfetjeegudevueetieduhffhgedutdejhfejvdffleetlefhtdevjeeuhedu
    ffeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprg
    gurhhirghnrdhrrghtihhusegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvmhhilhihshhhrghffh
    gvrhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprhgurghmrgiiihhosehgohhoghhl
    vgdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepshhtvggrug
    hmohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhm
    rghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgr
    shhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:9HEraV9Zk-ZxKOL5xFMfbJrwpUeSwm6MAivDsyl5eXJKhI6DZE4gCA>
    <xmx:9HEraSWr6kuA3-h5jAI4AYt21cHO9uhIIpZD7pPdn1uut55B9fBNQg>
    <xmx:9HEraafvrvsQnwY1zohVD4y8_oKswliO_8LpDDGC-N_TOrgWUMM5ew>
    <xmx:9HEraTYvi-TZLdlZpiW4_bwkBoOFwQactt63GicG0t2dJ62i-BhEhg>
    <xmx:9XEraWnDXECoXlIlSCA2GyGw4UMU931eW-gB0FmdkpdvyN-uMVYofHCw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 29 Nov 2025 17:21:40 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Emily Shaffer <emilyshaffer@google.com>,  Rodrigo
 Damazio Bovendorp <rdamazio@google.com>,  Patrick Steinhardt <ps@pks.im>,
  Josh Steadmon <steadmon@google.com>,  Ben Knoble <ben.knoble@gmail.com>,
  Phillip Wood <phillip.wood123@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?=
 Bjarmason
 <avarab@gmail.com>
Subject: Re: [PATCH v3 02/10] hook: provide stdin via callback
In-Reply-To: <87iketf0sn.fsf@gentoo.mail-host-address-is-not-set> (Adrian
	Ratiu's message of "Sat, 29 Nov 2025 15:03:52 +0200")
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
	<20251124172043.1650014-1-adrian.ratiu@collabora.com>
	<20251124172043.1650014-3-adrian.ratiu@collabora.com>
	<87iketf0sn.fsf@gentoo.mail-host-address-is-not-set>
Date: Sat, 29 Nov 2025 14:21:38 -0800
Message-ID: <xmqqldjofpjh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> On Mon, 24 Nov 2025, Adrian Ratiu <adrian.ratiu@collabora.com> 
> wrote:
>> From: Emily Shaffer <emilyshaffer@google.com> 
>> 
>> This adds a callback mechanism for feeding stdin to hooks 
>> ...
>> this data.  +	 * Only useful when using 
>> `run_hooks_opt.feed_pipe`, otherwise ignore it.  +	 */ + 
>> void *feed_pipe_ctx; + +	/** +	 * Opaque data pointer 
>> used to keep internal state across callback calls.  +	 * +	 * 
>> It can be accessed via the second callback arg: +	 * 
>> ((struct hook_cb_data *) 
>> pp_cb)->hook_cb->options->feed_pipe_cb_data; 
>
> I just noticed the small inconsistency in this comment (second cb 
> arg vs the actual code example). Will fix in v4.
>
> I also have an idea how to further simplify this API based on the 
> parallel hook execution work I'm doing (that is a separate patch 
> series built upon this one), so I'll see if I can make this 
> simpler, to avoid going through hook_cb->options entirely, similar 
> to what Patrick suggested in v2.

Not about the contents of your message, but I often see in your
replies unintelligible randomly line-wrapped text, and this message
was an example of such.  You can see how it appears to others by
visiting

  https://lore.kernel.org/git/87iketf0sn.fsf@gentoo.mail-host-address-is-not-set/

I _think_ it has to do with your e-mail client, and possibly use of
the flowed format in

    Content-Type: text/plain; charset=utf-8; format=flowed

Please make sure your e-mail client is set up correctly.

Thanks.

