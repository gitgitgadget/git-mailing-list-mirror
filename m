Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDBD2E03EF
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 11:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761823947; cv=none; b=IgXbLFrZXAJZ8mxsfBhZZllilLJGdX6Okumoq0i6fEQikn1rd9QQxvzqMa8xrCMZi9F8c0qev7aGpx7s3ZS5GPgC/ZBYjuFCf2DRL6CpCHN4Bhfq+jLG+CHeRi02JSJ/dghrVahCi4QTKkN/nM0nmTtgZxzF7Vf9r0RiwHXnFjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761823947; c=relaxed/simple;
	bh=zQdYyrnE7tagUDGyGHRQDI8i7aNK2pzF5HS/qG8mC+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uaqUDfmJTHmlb+pFsjvEl1rv/j6+paGcrB6azUGk9pS0sioDM+lNeeHS0VpcKjBQ+eiJ1vHI9+V1DuWDGXB4JS/OMqV7aTPlOFrwjBKBSNYA++QwSXy4pDFbas/S5d1M51FDhWlKTuqNAj0e9Io+KVumJKpWqZwa2s0O2BtQ3PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aipcwp5p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CFng7GEX; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aipcwp5p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CFng7GEX"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E89FD14000BE;
	Thu, 30 Oct 2025 07:32:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 30 Oct 2025 07:32:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761823943; x=1761910343; bh=lhH+d/TSHx
	RzYF5UkN3bFi7AYGXIF8sQwzYCFw9O00U=; b=aipcwp5pqauj1BThXK5QAzkldh
	dyCbE/apOlltdATTfTASjnxgbQuDHmwfFZGy2H9k7H2ExdLHdPAJonSBUX+3VWKW
	zHNxACl3zQOaxsfw9vc5wLIwnlUROaibKp1jlojHjbRME5tJp/8IliGl9Zuhl0xI
	jkJnyK64GszhhGdncI8oBh3HYKB5uXlL+Ju69WZ+M8uIcjuSHUgNEmArjpCXrPBY
	+GZhK9jsuH8+rGU3mEkXMDPNeaaEzDWhukwD9z1Yn+tJh9J0r6QC0a7uQ/uV6HxR
	ucBldrMCn2QTrUAI3JTjtvTwi1D9hQlMu6BqS3XB1I2r5OdpV2nxSFVIFIFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761823943; x=1761910343; bh=lhH+d/TSHxRzYF5UkN3bFi7AYGXIF8sQwzY
	CFw9O00U=; b=CFng7GEXmcr6mPZNMHZ4bntHdGrr8qhcgudcN9TWHM4DYC1h5lQ
	yz0CLxerx6fo9630ow5ZQt1Sek9a1PXdOv+lBhLdx5YtqJ1ChxxKgHgnpKtUGEmM
	dmgoGxEKzFjQL7yZNTuBFXSRMpdZeEe4XhHvckJxLF8fJdJwkkdgLz9Qi7MVNvtY
	X66YkG07up5Nxx4x8fVOetwwvcYHuIARAmh6nSC3Iv/P2DofoFRVzbIb1bbt80KV
	qqBNg9mgjlFG6OEUun1LnZkN9kk8uXlR9xw/f2A+rHcP9/uIFT70jzl8dl/XEETq
	JI9sHzH9brkmYZizWphZdAVxSAPsyZuSRrg==
X-ME-Sender: <xms:x0wDaU9uTsJOot7bwCtRqM846PCz23yUQRUmpRRMw0-9YYqe-cE8GA>
    <xme:x0wDaSuR5z0wNNjVurL0Fg8aS9JgLJLF-rUgz8omD72gCVlTbGWsIwcC99UbbXdWk
    aNYtiQQcUzdBaAfcGp_HruhaJ7QsbKKV6S-M4j9epReHF4sZsqNwQ>
X-ME-Received: <xmr:x0wDaXpn8rkqPaQypHCwD5yVIV9rO5NO2TAzmvuHd-YpQjpVpKScBe8mroXllZ0ZjmX-Ukzs_YsDQNfJMp9AxJEtO95O2J28P1OfFA3eZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeihedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:x0wDafnzf01j_rvBMM25AkzV2jTBvUZT_nlymQnSXyOhzl8OvtUoew>
    <xmx:x0wDabwU_7WkmvQqx7hBuRlPqRcGAEhUFq5_R6BECaYu2lUOHPWSpw>
    <xmx:x0wDaXmnJG2gymVsffmk06AHc8mq6nsuTJ-Vbsbl1wrCloB7Cfyzlw>
    <xmx:x0wDaUe3MpSHmeO1jO5nPRCJud_cPJBsNoOHDb2U_SNzkMNCLfPf0A>
    <xmx:x0wDaTt2L8I1txT1jbLiyEZpLxuYFzSTfwDaaUFyp0oGLsh-4DI6LaJz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 07:32:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6636e9f0 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 30 Oct 2025 11:32:21 +0000 (UTC)
Date: Thu, 30 Oct 2025 12:32:18 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 05/13] object-file: introduce `struct odb_loose_source`
Message-ID: <aQNMwve9sUP-QDN6@pks.im>
References: <20251024-b4-pks-odb-loose-backend-v1-0-1a4202273c38@pks.im>
 <20251024-b4-pks-odb-loose-backend-v1-5-1a4202273c38@pks.im>
 <CAOLa=ZQdit7N0aQWyqYHAoO6nuXaU3QqZbQmsbp52jW8C-zbzA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQdit7N0aQWyqYHAoO6nuXaU3QqZbQmsbp52jW8C-zbzA@mail.gmail.com>

On Thu, Oct 30, 2025 at 03:47:58AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Currently, all state that relates to loose objects is held directly by
> > the `struct odb_source`. Introduce a new `struct odb_loose_source` to
> > hold the state instead so that it is entirely self-contained.
> >
> 
> I wonder if the naming should instead be `struct obd_source_loose` that
> way other backends (if added) would be something like:
> 
>     struct obd_source_loose
>     struct obd_source_postgres
>     struct obd_source_mongo
> 
> This is easier to read and also for autocompletion it leads nicely into
> the 'obd_source_...' namespace.

Hm, I see your point. I think that "loose source" flows a bit more
natural, but I agree that the above is more accessible in code.

Before I change this: does anybody else have an opinion here?

Thanks!

Patrick
