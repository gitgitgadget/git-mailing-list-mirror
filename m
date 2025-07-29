Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC49026A1B8
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 08:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753776279; cv=none; b=Nc4yEhqa/kV6Glq9dOxTGnh9DKiogTuOTI+oewKWN6JIIHeKRxQjYb+2LzAHYNki0HTuLFecuOTeDvs8JpMIuvaQQSmIu7GQQ3zw6LbjVC/20Rjq5CPlZVBxrJTLmumI+DE8gxqPLNWVlxUhMmQPNDKJY4BJcIuGdy2QR+4Ecug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753776279; c=relaxed/simple;
	bh=esRad3RwDtdHAyxnjFk+REpnuApM7JE75n8h2oYStzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYaHgXb3smyF/AtZM4WcN/BFdyP3sgfVk3qasYhkn9ab5MDiOL9VzFKV/YsDDfkbm5OWmTxgIUSa8cqNN5XQz9SsYSQ5ctQBTBez5B0ADmlvNXRx+XovaP/RjGT035JGmVPawcOWWrsw3pjeAw9c22T+fRFE6unGajcnjyOXwRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gDiaN/Iy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=anYskRD7; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gDiaN/Iy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="anYskRD7"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id DFCB51D0009E;
	Tue, 29 Jul 2025 04:04:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 29 Jul 2025 04:04:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1753776276; x=1753862676; bh=cjQvVJsTXk
	6bQ7SSS7Dag914ubGrneFDcRfpSbP1/a0=; b=gDiaN/Iy3g4SHH3SjluLzVcgSg
	H1wkl/PwARDDNrwncokTeTq1oeYycxzNW5APvO15CZCknUiUX8XOexODPpS2FJ9T
	Yc9cdlw6HzMjslun5rFk3CE7RapGpCSlztg7Y7GdvzjxbiPqO5Aec2yBguf9DUl6
	/CEAq14dueYhHTRHkCXs8/Ms0JgWNHGJbbwcZ412UYfgqHziyaizI4i9TugoeZfW
	JmRIzcjR0dxNFpyXi7W46L9eBcopzTLEySx92uaT17e24LC3aVHl3Bktxl8RlYsL
	sMAAemiHRAdaUqkLG2ZyxYKrgBM3iMPWOtHo2935Oa63Muq0DBuJxMQPGP2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753776276; x=1753862676; bh=cjQvVJsTXk6bQ7SSS7Dag914ubGrneFDcRf
	pSbP1/a0=; b=anYskRD7DvA8w5wGtHVJ4AG7A0yHDgh5g2NkeSGQvt1D6n/DgYw
	EqKg+gYK+hL49vDS1Zd3ccvkbM74M9KcUBzWEeiT6Yl3+3jnzTYjWrcM+pL3s+AD
	7jpan8ojr/15I7zKOnTRTJ/OG+BAlh7w1Wb1pJS/MxccvlTKpVic11HHzE69kCr/
	RUMZmU+e8LI601y3EdPnyoPj0Q5Wgc3hKiNC7tPPR+Usxa6z2Hv7XljDfSOH1F9C
	p9ZjRV3ENyvpPRTLvRjGLBkzOIdqOCcK9xOOP9pfEm8J+0+CTz8p550QCEb6gcke
	iuL3kPuw1gxhUMctdF+N1YUqmVA+c68Tm7g==
X-ME-Sender: <xms:lICIaLkee1z_lxrrpzx2EhWNRCZwDTS8Qg1SeAw4i9r577ligwAkTw>
    <xme:lICIaCFTEPMLl8sjAaUOB6TI6MH3kzTcvVmS6mT2zwXoAkPSs1JUV-ktrp8WIskXI
    D0HhaBDb9KjedsGRQ>
X-ME-Received: <xmr:lICIaLGO2VHDcthcALvDO0XDt_oGuEvOtIR-UTppsTBpT0v69xY3H6nztacJZWpkj9t0wX1b-LbNRmEfSa2Pv2pciecTTrOPLXznZWHZoes>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelgeehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ejvedugefgffffieegtefhgfeikeevfeefheevvdegieetgeeujeeliefhiedtueenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:lICIaPNCYsOBs7UYqDVTzg3fwsEBjz3la2vaPPssY7xdOUxEtWLuEg>
    <xmx:lICIaKFUkvUaRGF321pqXgZ30kdKB7XjbFvfeU49QHxGzOp3HbfBzA>
    <xmx:lICIaGO4lRceGw8bq2aTKmjpcoAEOI0YeOEmqiPsQO_EIlHD2qqMqw>
    <xmx:lICIaL8028aAq88rmp5JMEqDThTiw73Vn7HUS0Eg5oLsCjd718b3-Q>
    <xmx:lICIaOuafnJImaVkkUSDPL7YCwLW0czuhR7eMcxOEeZm5kUxIUN0ozwi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Jul 2025 04:04:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7260193c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 29 Jul 2025 08:04:34 +0000 (UTC)
Date: Tue, 29 Jul 2025 10:04:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 0/5] ref-filter: small cleanups and fixes
Message-ID: <aIiAj8COJOAXv-xe@pks.im>
References: <20250724-kn-small-cleanups-v1-0-0c70f591de3e@gmail.com>
 <20250728-kn-small-cleanups-v2-0-d3021c8bf471@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728-kn-small-cleanups-v2-0-d3021c8bf471@gmail.com>

On Mon, Jul 28, 2025 at 10:20:45PM +0200, Karthik Nayak wrote:
> This series contains a few of the small fixes and comments which I've
> gathered from reviews of my earlier series [1] to add the
> '--start-after' flag to 'git-for-each-ref(1)'.
> 
> Individually each patch doesn't hold too much weight on its own, but
> together these small improvements add up. That said, if these patches
> are too small for the noise generated, we could simply drop it or
> combine some commits together.
> 
> This is based on top of 3f2a94875d (The twelfth batch, 2025-07-21) with
> 'kn/for-each-ref-skip' merged in.
> 
> [1]: https://lore.kernel.org/r/20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com
> 
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> Changes in v2:
> - In Patch 2/5, fix a whitespace issue and convert 'git-for-each-ref(1)'
>   documentation to use the new synopsis block.
> - Link to v1: https://lore.kernel.org/r/20250724-kn-small-cleanups-v1-0-0c70f591de3e@gmail.com

Thanks, this version looks good to me.

Patrick
