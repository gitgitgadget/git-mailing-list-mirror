Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A7B320CB6
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 09:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768209716; cv=none; b=A88Znnx+PVO7I6xKwHiGM0hCVjr89xtUdm15BvT0eSZ50/GgwHDj8NZbDhwSOxNxnGQ9yMEzd1+/cNitkbDJuqoC7MSyRGOY/zHWJaW+H/+xbliTCrvXY4Q/RIqUloF1f1tmedSphFDkeagdQO5iwiaK7p5DBvJOBa+LIlvdF1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768209716; c=relaxed/simple;
	bh=jqSLefbc+xFuNkappmVgDsrAqpmnlSxymKqbOg17ATw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8ffPBnlCAN3yA9pxCFbabgeuNCBHgPiYP0knqDel8yGoqzVRVSnIrPIh+KOBnOE/ctfvp5gKRzcggBpw8DAOXgjCfEs7R6WhWm/0xcs4HrbIk3hfrvDFyA4GqVc+Q8zbOoLptLLqI9g3/XUumoKPwbJhupJRu4xpGIqr7lvgyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=J8iUlpBi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HGvCB9J6; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="J8iUlpBi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HGvCB9J6"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id B490D1D0005A;
	Mon, 12 Jan 2026 04:21:54 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 12 Jan 2026 04:21:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768209714;
	 x=1768296114; bh=MmtNKPFIfZBfd0dMqj2drc4I5EF76Z9up6v9Q8NdleU=; b=
	J8iUlpBi9MSualCjeltuud+YeWyUK/Ungl1Atdu6XFcNbghRsf529jqKmVMi5jdY
	NEr+Vk8GLktB0xanBB40edRZzl8ZIgneFcM/VzdJYxWKv9HMqXn4PWszo5pdxlNH
	hKqPVlHdnr02ICzAvuIsvIl7Cv9B1fKXIs2RjImtKE3GzTedPjQOQbLJfzh8+QWt
	gwDOFkB6Vv2CymycEFzb21E7Z6e5V4w8ghdxvmyZrS7/DxMcf83RZvku3cu8+YXQ
	ueBCXguAgyJaRXF9ocF1t0u0snvgyl9HuU/M4hmPCfJZGnwrs17oNR4MSycM6YOL
	O2LUxsJ/dotBNIwUMTLjQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768209714; x=
	1768296114; bh=MmtNKPFIfZBfd0dMqj2drc4I5EF76Z9up6v9Q8NdleU=; b=H
	GvCB9J6l4e2sJ0YMheC1Tc2TFqEU6TB+66SFVnvj6/uJNi6Qbo8oCBO3qNfDcuBA
	cNouRTSy3NEQqlJAkNTZ/4KxN90+WvoZVEVAPu2CY2lFdY7z/1LM9up/9DDJehkl
	zbGpvWLjAf0UY4UByTxtHsVJJ/01FgSwxTtp/KfUYMucrpHtEsge8ZnJ25E0nwUc
	SMHAemTdw4s2b+sIE0b5a8Nl2yY7RjZ1EBGfFyPi4bRITm6EiY/7ZWSFD2merHos
	jTHmhfv6XRLrqUsV734UPqlQLVu6ycAKaYRHjPR32X6SResA5QKsuuIo6j77eLO3
	1KOaClMQ8PNNLpUkbYLRw==
X-ME-Sender: <xms:Mr1kaYT9JOmp6cqAjTjR8PglFLZZl7CW3Hr9OxJicbZUzJvPnaptrA>
    <xme:Mr1kabwoyIaZj_BD3Ly-zbCLWNUmB9SMS172sXxfSibkDX5GJt590cBkuqaBDZZx3
    xrphbn7fTRCwoJgZRkXP1yssRVFNbLbV8xIZgRYhrG8VtEivxxODQ>
X-ME-Received: <xmr:Mr1kaTc2awEXjjsu03g5QoOJC6JPWYpUSrsM7a7IKsvOixcXGV6e-nhjodYu8gBqgcY8gHz-6yNqpO8MYYPtKet8u9iEKyCE6jau3t7a6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejtdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtugfgjgesthekre
    dttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepvdefjeeitdetleehieetkeevfedtfedvhe
    ekvdevteffvdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvg
X-ME-Proxy: <xmx:Mr1kaXLI6cF3ZgfS9PEXQ3gfQpG_VMeeDSjMtWufURQAJvq4iPB5_w>
    <xmx:Mr1kaUFCfynQkqiQ8MpXOZ61pZzfcDSq2I-B6seidsJwQJM0zlrInw>
    <xmx:Mr1kaRqHORAb61Or8eto8zS06RIxLedVQgeV_ACPUpW3I6_p6IK46w>
    <xmx:Mr1kadSUbIvoXW1vlXVpUgCdNoTQqxOGDpFVFgYKFh81T8ZYmsIPuw>
    <xmx:Mr1kabod--A358RT449TTqHJafI9agJbdyYkrDZwrzX38b2toMz_QRA2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 04:21:53 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 682a18a2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 09:21:53 +0000 (UTC)
Date: Mon, 12 Jan 2026 10:21:50 +0100
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 09/10] tree: stop using the_repository
Message-ID: <aWS9Ll8CQ3eILx3z@pks.im>
References: <20260109213021.2546-1-l.s.r@web.de>
 <20260109213021.2546-10-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260109213021.2546-10-l.s.r@web.de>

On Fri, Jan 09, 2026 at 10:30:20PM +0100, René Scharfe wrote:
> Push the use of the_repository to the remaining callers by turning the
> compatibility wrappers into macros, whose use still requires
> USE_THE_REPOSITORY_VARIABLE to be defined.

Can't we make this step a bit more explicit by adapting all callers to
parse `repo_parse_tree()` with `the_repository`? That makes it way more
obvious that we rely on the global repository.

Edit: I see that you _do_ edit all callsites in the next commit, nice.

In any case, I'd propose to move the compatibility macros into a section
that says something like:

    /* Deprecated wrappers that will be removed once Git 2.53 is released. */

We can then have a follow-up patch in a couple weeks to convert any new
callsites that were added meanwhile and then purge the compatibility
wrappers.

Thanks!

Patrick
