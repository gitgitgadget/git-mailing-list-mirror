Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BB416132F
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 11:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743765337; cv=none; b=DjAarxNhsCuyLGByYlZxWHlyqGAtIIJDSUz2kMiLTOYzlHRE0I9AAK73xbxZzM4iHK1ui2StyIvW196VcSpLjS6lznig3ZhGxc0Q8Qf8vTt18/2TiIroE321IhIyaH69qwo0GsRpahZqYtEKQlYwPojvlxOPWU3xiJ8hBGbDQnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743765337; c=relaxed/simple;
	bh=KpXIO6HUPVTlCXgSbuazlH1h6LBmX/5Us4lnuooApn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBd76ABZ2ShCTPI8czImVK16o0QIM78Rb/pjfmTPYAYaUyEbtg2dmJTNyWfH5/4tKGH7Y7Jke6QUKS6qIKaJjwWIt2F7PGSxcbRGemB5I3WilL3SbRKNZ2HvuZvEh89pR/c5aakcvAZHfWrtyLbsvuHACAiwdWsHC3wfQjvp6Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HOOyvscE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Oi2t6e8P; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HOOyvscE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Oi2t6e8P"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 5602111400D6;
	Fri,  4 Apr 2025 07:15:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 04 Apr 2025 07:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743765333;
	 x=1743851733; bh=0RZfkVnufGdyPKtCCuplM00KXsyp3VqUOGEJIHxSqEs=; b=
	HOOyvscE95GqEBYDUF6tpM8c3AzkncpHGtGCNk9/FbMeYzlIPHBgVixnRF/LK3qw
	rnewhqWxrMSxWXlzdbOcxKvstq4wg2ZbzIlkkZGaFuG6aryDPaQuOBRGo9IxlBB5
	0NxoV4cG8vgRISNkSRC/dHzvPAAd0q/Hch7Ydf6Vy8bRidpo6/UpOgR7d4jLt5MW
	OTlXCKqabIw09v43wF9a5orYoLBbghn8LOljY/yoD7Mr14swSH2e6GPYZEh/Ogqm
	NU9zCB+wQgiaQnC4IRqaG0LwjLMcHubqk8swFOLcneNGWMjm5Qpr4qyj7qmhvjen
	BxIxAiHrXQ8Q++Ag89EBCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743765333; x=
	1743851733; bh=0RZfkVnufGdyPKtCCuplM00KXsyp3VqUOGEJIHxSqEs=; b=O
	i2t6e8PruEwH6J3raNTS62oDIPlFPrwxwtzOfmSqvQBZFe7C015fN3baCrs26Czc
	wH2jZGuOcM9ZY8G0zrEsouVsrdUVcH9BkyW+1xDtX4tTRwuWou9kYUtYW8/845T8
	mdFe8+usg4477qBi2mF55eRxI+ooe5rQM1BpbdrmEjPBFR1Sq7gn+8tZ+BvywDT9
	M0pW/zaNUJMXkbjqNTfDX8AJu/MrSNQG6bs7PYU2BqaJGAwU1In7ZsLC1ptv80TO
	/urb7+QA74BpMou9MKN3N/vhzX8kR6g8JijusU4yAtYkYKc0CjJ7qP6fg1WMF0/O
	PqgwrfOQCxbEViWds0iIw==
X-ME-Sender: <xms:Vb_vZ5jtTLUYx8JOBvX9TwjAGCeIIat3zPnbU71uz-Oc7SUJIReisQ>
    <xme:Vb_vZ-DVTW8ftSEu2JYK-cMrGIUb4-ScJD4o3b6zloS0OKZNTMbL1KTAytTaPuyJO
    hNYWylWWaGckjFpjw>
X-ME-Received: <xmr:Vb_vZ5GoK7RDvwcrZeqROswisnhLxf388rm-n3vGffRuS5Kozlkt3MZzvLnUgKB0Ydt-VoEO3mY8AwpyLUJFRHxft4Byk-zTs8B1rxp-JUG1luk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduleduvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvdefje
    eitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptdeh
    iiihtheftdesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:Vb_vZ-R3mFiRedkJ1M5oLFnB5DVAtxMmSJVEBwx2xsphjP2Uef9qbg>
    <xmx:Vb_vZ2yoFS-Egxjwgd5mV1H8eSyrfQU_FU5DsIp_abS6lUsjknSmkQ>
    <xmx:Vb_vZ05aAO5r1ucIgyaE9k_qrjpuqfDEbh9EDSXCbUm9N3Vl0dPCUg>
    <xmx:Vb_vZ7wYzv1yVsUoJtU0WTDXjhlYE0PiMsGagT3ighyKsaHUJYUTpg>
    <xmx:Vb_vZ-PcqXPacr7FYUef32kaI4zzyW8aas46EpU2rE4TERmZIsVGTn_j>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Apr 2025 07:15:32 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8f199800 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 4 Apr 2025 11:15:30 +0000 (UTC)
Date: Fri, 4 Apr 2025 13:15:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Zheng Yuting <05zyt30@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Discussion on git-refs list Implementation and Possible
 Approaches
Message-ID: <Z--_TvQ9MXgjxqOV@pks.im>
References: <20250329150248.2274482-1-05ZYT30@gmail.com>
 <20250403154404.3459805-1-05ZYT30@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250403154404.3459805-1-05ZYT30@gmail.com>

On Thu, Apr 03, 2025 at 11:44:04PM +0800, Zheng Yuting wrote:
> After an initial review of the code and documentation for `git-show-ref`
> and `git-for-each-ref`, I believe the functionality of the `git-refs list`
> subcommand can be categorized into two major types:
> 
> 1. **Filtering options**
>    - In `git-for-each-ref`:
>      - `--count`
>      - `--sort=<key>`
>      - `--points-at=<object>`
>      - `--merged[=<object>]`
>      - `--no-merged[=<object>]`
>      - `--contains[=<object>]`
>      - `--no-contains[=<object>]`
>      - `--omit-empty`
>      - `--exclude=<pattern>`
>      - `--include-root-refs`
>    - In `git-show-ref`:
>      - `--head`
>      - `--branches`
>      - `--tags`
>      - `--exclude-existing[=<pattern>]`
> 
> 2. **Formatting options**
>    - In `git-for-each-ref`:
>      - `--format=<format>`
>      - `--color[=<when>]`
>      - `--tcl`
>      - `--shell`
>      - `--perl`
>    - In `git-show-ref`:
>      - `--dereference`
>      - `--hash`
> 
> Additionally, for filtering functionality, the `--ignore-case` option
> from `git-for-each-ref` should be supported across the board.
> 
> **Note**: The `--verify`, `--quiet` and `--exist` options in
> `git-show-ref` are intended to be implemented as separate
> `git-refs` subcommands and are not within the scope of this
> discussion.

Yup, makes sense.

Another factor is the default format that these two commands use which
differs. I would heavily lean towards using the format exposed by `git
show-ref` because it doesn't require us to hit the ODB, and thus it is
way more efficient. This has bitten me quite often already.

> ## Implementation Considerations
> 
> At this point, I haven't come up with a perfect implementation
> plan, as each approach has some issues:
> 
> ### Approach 1:
> `git-refs list` would support both filtering and formatting options,
> meaning it could provide:
> - Filtered output
> - Formatted output
> - Combined filter + format output
> 
> However, I see two potential problems with this approach:
> 1. Would it make the `list` subcommand too complex?

I don't think it would, both are orthogonal to one another. I don't
think people _only_ want to format or _only_ want to filter. Quite
often, they'll want to do both at the same time.

> 2. The performance could be worse than `git-for-each-ref`.

Why is that? git-for-each-ref(1) already knows to filter and format, so
I'd expect the performance to be roughly the same. In fact, I think we
would be able to improve performance if we changed the default format as
mentioned above.

> ### Approach 2:
> Split the functionality into two separate subcommands:
> - `git-refs filter`: Handles filtering and filter + format output
> - `git-refs show`: Supports formatting options
> 
> For implementation, my initial thought is that `git-refs filter` could
> reuse the formatting options from `git-refs show`. Perhaps this could
> work similarly to how `git-add --patch` and `git-restore --patch`
> share logic, though I haven’t thoroughly reviewed that part of the
> code yet. Would this be a reasonable approach?

I don't think this plan would make sense as it would mean that current
users of git-for-each-ref(1) wouldn't be able to migrate.

Patrick
