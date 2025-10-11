Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A41F33D8
	for <git@vger.kernel.org>; Sat, 11 Oct 2025 11:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760180430; cv=none; b=honCwUQMXkwhyMUV65wq7NWsNlf6xn3gfcxa6xwige0KZO7lNvrhv5e4hf2p8oJEGsjRzdgnj0pVGjKBIajULe/CTWYBREMm1hbi9MNni6108+0sTcYyEMJSWVNupsyIDnH/Nu8kZCql67jr/o+lppE7LQGEEKE5qGKaogfh2P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760180430; c=relaxed/simple;
	bh=EZDrd9Gq7PSPQ+51FJ91vvqEPWGHfpNqAyKDm8tK6DU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADHzMeW5FOEOkKsLw39JJw0UyvCIAb/WPWiw6yiOWTXDbH0CAhYe0wGvUWLaAmtRurixpCgeMQ+vEaZrdCGCHvzhJ6h0p50gGHOQhK+NCkA1JPh5p3zY0PePWfpoaqfAw+EB9+MXch7iYWEIfdotxCJlHZndpK2v6FYND7fOpt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cjN/949m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ykBtyMA/; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cjN/949m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ykBtyMA/"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 13366EC01E2;
	Sat, 11 Oct 2025 07:00:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Sat, 11 Oct 2025 07:00:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1760180424; x=1760266824; bh=Zp9GX9Q3Fn
	wYlPCelhQHQGc9xGp5YeflhZmPaeKO5DA=; b=cjN/949mtVG0sZeCFp0J/8jT/d
	Z3d5ZBzReM2EHxyeSftp5RBDki6D0NTs8QCwQp1LX293Ox2F5ZS0AQjpsMpyroX/
	g8iuoCqCyDrerlwYLBeGiZEqD+ySma5zPFHJPP2CJJC4GRQSmW7HuDB0naOCUg5v
	Wi+oOOud2bxza4OnNIeGMB4fz0bqD+D1bgV6PptBWcE1IFaz04kaTddC/tV38HR2
	/Gc+11tVGYJAqx/X9nAl7GC6CA/qXFWQJllOyX+yCAtnZEi4Gi2EMy78T/pqmmvp
	Eq09fCg8nXK7a3iVGXZ+K+fPUv09hsm4VLxIuDMKSF5YanFj0QnDQ8k6Q8Gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760180424; x=1760266824; bh=Zp9GX9Q3FnwYlPCelhQHQGc9xGp5YeflhZm
	PaeKO5DA=; b=ykBtyMA/u8dieJ2N0FAh3x9EDG+4a8TKG6Ws2H1dcFbcuWyLtbl
	Zq112cwjl+/2D0y083hTX5HdK948okFEbcbTVIxatX4sBokntYHwd4CJSS5/elbs
	gVvhTruLFd3PozUgchcnSvUP9FRUZPPJORKPg7AUUBa37AwU7rV5fz8sGAanW+ht
	w3wlY0U1XaGprJekg4ZU5kUIWYfzQVmSpBctx+au722Hfo6ChKibC3U1MmAaX150
	zXM1/KEGRz3A8svwQn1758ckEenguZ/xUsVBMvTLtKrLUHjYl0tbIbSG08MAgcbF
	/OB7d5L1zLgqlBzqoPZSs55BeQMrEzN4mRg==
X-ME-Sender: <xms:xzjqaPyLAbIEuQUywYX6O08Ek3s7VZ4UT5JWzsenpGzOpZcXOjhetg>
    <xme:xzjqaNShUJvIXxOIFExjTcnR8BvNFDiWrOLJagZwLwEnU9y8xL5ieFrRLuTPYiyHk
    _GiZ6-BBbfWGtfYsAH8AdJ4Sw0U8EE1V7ZhziOqmmsTLUhhi-xwZQ>
X-ME-Received: <xmr:xzjqaG9Vcs5pe6unZPmsKwG1gHG9Jl8MgwsYItE-N32R67DtUEjv8OSPPGiCAM68fiX3RAgEYzPxf50zkRk1xn9z3eLLHxrM8dqzr3o8kA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduuddujeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:xzjqaEpjnssaFsEJHISo3zoKlSUTvLsvbeT_-Su_Z9F3TGzdWQApKA>
    <xmx:xzjqaDlAo52m70An3IGX1oCfjqqZ-a8CabuNmJ7swtWp6dFgwP2wTQ>
    <xmx:xzjqaLJ5WQpjrGU4MvnktTxUo0UCs2Ca2FfpFWWheSuwvZzy3Qw_LA>
    <xmx:xzjqaIxvGzO31TGHlw6fYmBRLbKDpOhBLWmpW2WMKoEX_QFFnj3y6A>
    <xmx:yDjqaDJIWOjyhecI7TmP4iHicavQCQr9FAv3WZCQL1zKmqoZDu_j_GjH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Oct 2025 07:00:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 74969e8c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Sat, 11 Oct 2025 11:00:21 +0000 (UTC)
Date: Sat, 11 Oct 2025 13:00:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2025, #04; Fri, 10)
Message-ID: <aOo4xWp2Sx-4QUUI@pks.im>
References: <xmqqecra71ec.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqecra71ec.fsf@gitster.g>

On Fri, Oct 10, 2025 at 05:00:43PM -0700, Junio C Hamano wrote:
> * ps/ci-rust (2025-10-07) 8 commits
>  - rust: support for Windows
>  - ci: verify minimum supported Rust version
>  - ci: check for common Rust mistakes via Clippy
>  - rust/varint: add safety comments
>  - ci: check formatting of our Rust code
>  - ci: deduplicate calls to `apt-get update`
>  - Merge branch 'ps/gitlab-ci-windows-improvements' into ps/ci-rust
>  - Merge branch 'ps/rust-balloon' into ps/ci-rust
> 
>  CI improvements to handle the recent Rust integration better.
> 
>  Expecting an update.
>  cf. <aOdIRnB-SGQwj935@pks.im>
>  source: <20251008-b4-pks-ci-rust-v2-0-d556ee83c381@pks.im>

I think this status is stale, right? v2 didn't have review feedback that
would require changes as far as I can see.

Thanks!

Patrick
