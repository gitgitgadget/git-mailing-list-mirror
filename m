Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B72F63B9
	for <git@vger.kernel.org>; Thu, 19 Jun 2025 17:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750353489; cv=none; b=WcXWeKIc8Ojf1K4HRHlxhPv+VCBjPYyfGevlQXARJ7ctaMtOrzcFWiWGR3f9QPwCP+DHpYV1kaGLideGwljh0czMuoqlZahhp08mUNWkAQixVvtzMdqdAietYTu9aWDH94awcsMOBNRGCXwVpYXuul32riystbXaWCFzy5EBWrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750353489; c=relaxed/simple;
	bh=MOk+HgZD6TOUeNXNrMB9bOEL9VpuLALAQAxEX04TI6o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WLvlFN/K5f/uPo1sg7vtw9S9U5tSCv/JVfnKYhXjFfPsAiH07cEOmE3KYDe7QxlMZj79UzTKGG7K+cWms/u0poGJwD0omVva1miDzgYWCcGDfZd7cZql877WPlVcIX+RfA70Y6qoVFE2uExi0ol48qA6uFVjpo6GrXiv7CeHyCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bXHUtmAK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DKJVGEag; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bXHUtmAK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DKJVGEag"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 04AD511400CC;
	Thu, 19 Jun 2025 13:18:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 19 Jun 2025 13:18:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750353485; x=1750439885; bh=k/wxzoneeg
	cF3ivu/VAIDc5oufPMEEYD15rpdfhb+Ho=; b=bXHUtmAKQlbeWXV4reppGhuMUF
	A9zAguJBtlSvFaD3GXU1gtcHfQGz/hwxYHBGyy9ovY9ig4JZ9EVS6WE3ShlEYmM9
	d36ERT43vF5QLeTzguQriCivRIwC7Wf1um2mrI7vU8dEzAZc4WZ+8ZCtoUjL5YoG
	DPWPIeHs9ot5ORGzFleSAYrJ3XUQ1smUYtC1FoOdqUlZgUXBqRwSphH1ofrbnVZf
	fmLZ6TCkESqEsYlOGhWz4SvtK7f7hrk1kmZs0eherpQpG2Nvmi/hWDW5+4jCQsVn
	eqjFU94ThIm87QmpnkZ4pTHbc9zBnc2AyoomU0xdLvXWDBc1p+D924+ZV3rQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750353485; x=1750439885; bh=k/wxzoneegcF3ivu/VAIDc5oufPMEEYD15r
	pdfhb+Ho=; b=DKJVGEagNJfytwR+k3MriEAQ9UugbBqZ/L5i0dxTd4IGFN/K4Tx
	YQy3XTfRmSD9nUOJ9ARykCT4NW1IFdM5/abgxeSdweFHoV42NAR0VwPXj73QYYJ2
	fPTtGUbRyYzGLJErBLiL3S65jS1wrHh+jQiBTLtKDnYgpKEL9ZLmD5LUuFgF/DBm
	gwLIzl6htQGNAWRVMeOBfjHWlaEM1q1Jpr/XM9UQcpFtl3cHKLioeuYyuAA4YFYJ
	zVEUitncDs6qZ887qBaU/m/j6a8JfcrBe5uj9cKdLRQdQYGpuDSNViUo6lwyUEVZ
	P3HY0UlxdKh9DO3rFMwBJIWajEWIN7S4PaA==
X-ME-Sender: <xms:TUZUaPVLwrCE3jRNqPhVOoKLlC4SFTvHYGNIimzyPE8-QyLRqjuIVQ>
    <xme:TUZUaHmRypY5WrjIoHFYYQFu5Bb1DoCgLeFR4UfEAh-j-qlpp7sN3_M9v_1WaerQj
    6tjaY1LuXVGRcLxAw>
X-ME-Received: <xmr:TUZUaLb-3jMvVrVUpIJTNk9jDli8q4VaBNG5ni4vmhPc10q663-xXpvX5z0_z-2siMSs0OJNStTFqMOx515Lan_trxnOxROnTtyJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdeiuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehjrg
    gtohgsrdgvrdhkvghllhgvrhesihhnthgvlhdrtghomhdprhgtphhtthhopehphhhilhdr
    hhhorhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:TUZUaKVjdVdn2ii7yRTuc9F96aWgDxe01gGkkNGmr2hEQIKXhlwJCw>
    <xmx:TUZUaJlv4eIrHnelvL3cCzEM3QOGVM15v_nkOcpj8Vt_eWZHFjHoGw>
    <xmx:TUZUaHeWMjRW-kob5lhkcekY09PMupLxmNu16y5L4ypelVFV2HJr7A>
    <xmx:TUZUaDGMCgfloyt8v-DvTiyhTN44ad92TsJjLc3RGPIWeQk4I0RTgg>
    <xmx:TUZUaN79AgM9-EA5OIvPnfEme0GVNwhz9A1r4J8NnIymzRJWCU8jHL9u>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Jun 2025 13:18:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Jacob Keller <jacob.e.keller@intel.com>,  Phil Hord
 <phil.hord@gmail.com>,  git@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] fetch --prune performance problem
In-Reply-To: <20250619033746.GA1801319@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 18 Jun 2025 23:37:46 -0400")
References: <20250618211024.2332525-1-phil.hord@gmail.com>
	<9cc42f04-856b-4967-8668-a47271af061c@intel.com>
	<20250619033746.GA1801319@coredump.intra.peff.net>
Date: Thu, 19 Jun 2025 10:18:03 -0700
Message-ID: <xmqq7c17abw4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> The final fetch output looks like:
>
>    - [deleted]         (none)     -> origin/branches
>    - [deleted]         (none)     -> origin/main
>      (refs/remotes/origin/HEAD has become dangling)
>    - [deleted]         (none)     -> origin/other
>
> and we can see that the deletion of "main" is what caused the dangling.
>
> That said, I'm not sure I care that much. I didn't even know we had this
> dangling message, and it's been around for over 15 years!

Same here.  I agree that the new output, while it may look prettier,
loses information.  I agree with your conclusion that the user who
really cares can check with symbolic-ref themselves.
