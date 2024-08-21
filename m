Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A8419258A
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 06:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724223242; cv=none; b=oGXVOqfH5GSMqA8QhONUewaAwJaf+j4cm+gM2Y0zsaXQDynmv1J6MyYe14olKecpJIeOjKwQNrHGNt7xvCIJoFMi10BIEWuBgD1n8KGiRKc+keNBwpljwvpl7r6/p1oLGk2pnaJxtoBgwi3RRsMmZ5reso5rJAY25uOXGq/KVic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724223242; c=relaxed/simple;
	bh=75TvTFb+M+C4zW1Cqq5iUJCOduFtYL7Ule+vgKh9uSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SyJJtiwas4bOdmMeoju/P35yZbTZnt511ykqBx0zMFWUltd+LCmvHE8zDQFa3CeuxKKUMwZCDeJX3Va5tKZmKCaiYKGKJ3fWR+yOXUzvhfMVR6WbFbZA7TBBQCigDhhYJDVZ786Qr+OOvt+gUJ58LfpB7j/O5IsQk7nWK6I9vsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=b+8Zo8Ig; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EuMnQgGm; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="b+8Zo8Ig";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EuMnQgGm"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id AD010138FF53;
	Wed, 21 Aug 2024 02:53:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 21 Aug 2024 02:53:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724223239; x=1724309639; bh=pNab+PpV5W
	qofBqazOXJtWYN2yAqD98ojdeJe2dwsrc=; b=b+8Zo8IgfpcJvbBa9j6B0IAl78
	1FKgszEiEDP5CQUzxgqNNHMQPrPZDj0sgzhr+GsdwRwonfBO0qWW1BgELxwjjhB8
	y1GvODTfu/8DRzGRevTCY3UbCx8S3jze4TSJ7jQ4cMxI4OzfPvdGx/Kbn5MYtyNq
	3bXhaSvgmfACpnug5ng4SjBQRdpoaRlHWBwDZx+cf1vc9OkaVsfMH6AICENxBuMT
	dSCTZHYrgUKyLwarUdQbTFf71Pm9G2AMnA79mCcdqkHiWJ/tIC46w43uPPFm99FG
	ITQOcbsbjTxKqH4CuwnwrAZ2YNUy4Mivp9yaXl0d+iTIDvyBjJpDbWpeJ5Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724223239; x=1724309639; bh=pNab+PpV5WqofBqazOXJtWYN2yAq
	D98ojdeJe2dwsrc=; b=EuMnQgGmJJEtrm+SNaXvTdMRqIZkyXPhbDQUXz8jIR3A
	KF+qhd9HF/I2LAmFcBVyDPt1me5EJxopX1mlb1GXVS4cWs82O9FmrppvcRgIgkqY
	4v6oIrGsW+Fa/KjTGrDshRloOGPy9fMdnmRaYsJmJ98/FDk4NAY/pcIlo6NGU2Km
	UZUlQPJSCFJDrd2FyZAOJGkKhm9t0bkIOnBBrxSg+T8cM9EY81gqPMbJOvfRPm3L
	km37IFZUTfN3++9+T5r+OpLKlc3p+FfJO64yP5WFmFcYiWVTFmU+c9iTGPs9JC6i
	MUsHMmRGnmIjU3mpONEItcvd47rtgmC9Mo2uD6B8Sw==
X-ME-Sender: <xms:B4_FZt50wwRaF4bmjZgAliqwZAqn_ZaXkpM4XeZOrKiFGQlU5uKspg>
    <xme:B4_FZq5S1ird_ckoNHzXM5zShe1gTSfe5XXDovumcyDGzOZYoDcfdxqr8npqIwOwU
    VQAGjZaxYqGeIPVDw>
X-ME-Received: <xmr:B4_FZkfgUd8lKctsol_LgmVjIN-Qplz6e6rRrrZmDDmz5EwStWd1v_YXqzOaAX4K4tu_yYRepBw98VfQgdQ8TSC6cCriSPSReIlFpual_LJLUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddujedguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomhdprhgtphhtthhopehmuhiiihhmuhiihhhisehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:B4_FZmK0sz2lwYo15B5NTsdGiv8ztqtvq8k2CsZj7DJcpuYayggF5g>
    <xmx:B4_FZhKeLzx1YFj7g1SSLybSbY7z1tCySYTxT9bEgj3kqmsymAKswg>
    <xmx:B4_FZvwVyT3tG7576DYLDeMX5bvhsi1zv2sXZsgqHW_xHeNTuDB7YQ>
    <xmx:B4_FZtJVTDdyyprPqyooHl8CfKRJVkGZsgaChuZY8gmG3uhAkowLeQ>
    <xmx:B4_FZh2_p3IO4MKHwZLiTMNYF3l5SjmDKQCfOIt96gKO6eeHKxfuyUkQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Aug 2024 02:53:58 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d085f2dc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Aug 2024 06:53:26 +0000 (UTC)
Date: Wed, 21 Aug 2024 08:53:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Yukai Chou <muzimuzhi@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] doc: add --show-names for git config
Message-ID: <ZsWPBCW-pI4qIykK@tanuki>
References: <CAEg0tHRL9+tqY0k2GiGzhc-VgMVsHqppLRFHbc=M33R6AoLXEg@mail.gmail.com>
 <xmqqcym4fqhp.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqcym4fqhp.fsf@gitster.g>

On Mon, Aug 19, 2024 at 09:04:50AM -0700, Junio C Hamano wrote:
> As to the name, I tend to agree that --show-names is a strange name
> for the option, and I would have even suggest making "--all" to show
> the name by default and give "--hide-name" option to countermand it
> if we were adding this topic afresh today.  But that unfortunately
> is all too late to change without much more effort than just changing
> the name.

Mh. Yeah, that might've been the better default indeed. The new command
is still relatively young, but still, I don't know whether changing this
is in the picture now.

Patrick
