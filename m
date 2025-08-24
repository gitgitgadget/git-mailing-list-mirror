Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86D1393DC5
	for <git@vger.kernel.org>; Sun, 24 Aug 2025 16:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756054705; cv=none; b=Jm8pcAvlvcUtrV18brCx8c+WdQHBZLOATVmL2QmB0qUvNurIbAkZcoyFWDQY0PP7Xq5bNCIgqwLSqugIMNFXl+695zWmgNXkkU5DNkebKusVAN1SeuVB31AJt9YtEiGzPiFMFpFaB+G3DpitMIXPT7fBfFAc3DIUvUYR2ARkPow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756054705; c=relaxed/simple;
	bh=+xpvK3qUS7u8VbxmHov7pecW+icxPWKtH1Eh3MWoynU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pVFqopJvNNeyEdUHPDZRsAhHicupxWFthFPiD7+D0D0qJhKb4AhHIR4poMFO/WezPp1xMkuV5hBK1l0IG9reoYe5bWJem6kL2rWR/lAnwWGQGEG/f9tiFHjo0L6cRmR+FV5rS+4kQ+EF5bU6jRVs2hYiKw90pHZKJ0U0Otrg0tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NlWdnr/k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AKFGR5pt; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NlWdnr/k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AKFGR5pt"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id DE5E51D000BD;
	Sun, 24 Aug 2025 12:58:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 24 Aug 2025 12:58:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756054702; x=1756141102; bh=aNNjNT3Vj4
	dF0MfRbKPPDIs6cHf3+fD3uVA2JwnCtpI=; b=NlWdnr/kklyzB4MMTDE+2k0dwN
	ITp14tPd83EvcSm2a3FA9DujnpRYWzuENv8NVyq2c5NTJa9OasmoGcnYNHbTyCzh
	lAKQy47N6fth0q76O9Ypd2eA+mOkdJmaFQKI5feuIvz+nCsZKcNOUpAEhGT2zPjI
	FBfHx4nInp8yyIJQcFcQ4RFGcs/7uYfqvAEu7wTf4LmN3RFtNnHf04AB71ISUp5I
	TF+xplfeX58zkJBxEoHT3q7ya+t/yMOsaWgLa32iBxTYe744xRpOdjjcULL7YP/o
	fvPLAUALZt9UZi/EX981+XT48r8vBBB029/FAGSg8c8Vnxv3VT3y61H/kqHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1756054702; x=1756141102; bh=aNNjNT3Vj4dF0MfRbKPPDIs6cHf3+fD3uVA
	2JwnCtpI=; b=AKFGR5pt9fiJcEtuD/onCbGsGZu+Arq1R7fyKIrdcOppxjuqxXy
	gLZEHSmYw4fn/e7YRPV/Ik95EBqnboNrtrB5GalRGr0FOG6f4AQrq7yPXk8QG3Dt
	DU4ofjgjyuk9eMJ1nxPnF/dsAbd83NTUa5FpNf2O0Sz1F5P0xkF82X2PQ5yU7A0p
	6p5Lyuf438CMhW1R34592uVe7kDPkmC+U1xD46mJNX9NsmZGS0bOuc3SGBBet1Fx
	v8oyytm/9JxRpNPHxNLj20xE7K5B+rFtXdPU4xOLh1tZacYCd06mHmrGcgCm+X9p
	OCfqupSMKQ97TO7yJWpFr6p2pzB3gLiU0Qg==
X-ME-Sender: <xms:rkSraEP3s7eknfUFXBmNNenYzW3BPujpzB85_OTVRg6RQWkELp1Ikw>
    <xme:rkSraFiHdGEhgaGJqXis936RulPkBXCGt7g2XekTvdIgoa7j4QJoJcxatumxVLkPR
    Mxk4sstdSin3smIHA>
X-ME-Received: <xmr:rkSraH2-dh7Vw_0wpwPuHBT9ywyaNsjnivX6xON71unJ_Dtdp13jGjdXfFGag14tmqSTSKTZ3zqC7AeJUP-xkftQTlUUbKBQnjUBnTEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedttdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvvghtshhonhhifedtudejsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:rkSraPieMFYvcAAMbGzEDdm2NlcRvnD-XlUYb5nBce-EbE_C8UoX8w>
    <xmx:rkSraHfNvEzkSSCxKwBvulFUUqh5lpGrPi58-qL1RHaazB9-CvgClw>
    <xmx:rkSraCl5m3CwR3X8jQ0pRLySeQRVX2M72j67aNttZLM5dLkaRsT36w>
    <xmx:rkSraAtTBvxhVpkcO_Nbt69ziwyD-PYTwYaR5k-534zY0zNKIWjpkA>
    <xmx:rkSraIcKmRoKp2ACPndBm6S8h8TcW29U3ohxJmsOK_2QndBCiWKA6FRd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Aug 2025 12:58:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7d160f34 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Sun, 24 Aug 2025 16:58:20 +0000 (UTC)
Date: Sun, 24 Aug 2025 18:58:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org, shejialuo@gmail.com, gitster@pobox.com
Subject: Re: [GSoC][PATCH v2 0/4] Add refs exists subcommand
Message-ID: <aKtEp7OyTXFdDPH0@pks.im>
References: <20250821085246.929307-1-meetsoni3017@gmail.com>
 <20250823060012.540433-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250823060012.540433-1-meetsoni3017@gmail.com>

On Sat, Aug 23, 2025 at 11:30:08AM +0530, Meet Soni wrote:
> This series introduces `git refs exists` as a modern replacement for
> `git show-ref --exists`, continuing the effort to consolidate commands
> under the `git refs` namespace.
> 
> Changes in v2:
>   - v1 was based on the "next" branch as this series required a couple
>     of commits merged in it, but as those commits are now completely
>     merged into the master branch, I've rebased the v2 onto master
>     branch.

Good.

>   - split the test commit to make the setup shareable.

Good, as well.

>     @@ Commit message
>          builtin/refs: add 'exists' subcommand
>      
>          As part of the ongoing effort to consolidate reference handling,
>     -    introduce a new `exists` subcommand. This command provides the same
>     +    introduce `exists` subcommand. This command provides the same
>          functionality and exit-code behavior as `git show-ref --exists`, serving
>          as its modern replacement.

This reads a bit funny now -- I think the previous version was
preferable.

Patrick
