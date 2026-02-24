Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F6237418A
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 10:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771927220; cv=none; b=QD9tc5khy27MHjxmeYazv0FiM8AcbhyWmH9CrviOF+MssuthBEeVCVC7Z0oUA01MGmV3k3ivNNcIJr+PGLnXSnMwqaxFJnZQEi8QBM8ZITbpOMJC/L5vhTNFP4tH81GuToLnEYzxxrz1Neu8pABY0aNtwNd0lFt2xxJbZWbmh+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771927220; c=relaxed/simple;
	bh=A2mSiuqvKfCS8vqmjNvy8tF641LAv4UFiqcKeB7a7iI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSXfal4ZcbQrGPT2fLMCnkna5F2VlkNHxvianuU75g233T8m7px6MS0/6Kd/90ttWlL6ZV55bkpcpEuAiaZJHm2zXVHDk6/2+ooFZ3NT6bH4ILueBq58LBjlkEX/Oi7WQCqoGb6GZZMkZcJFWDDXyK+uT1Jj/sRazZm2i8VgR1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bGZFEqHl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OwWv35Qo; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bGZFEqHl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OwWv35Qo"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 83BCDEC05D0;
	Tue, 24 Feb 2026 05:00:18 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 24 Feb 2026 05:00:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771927218; x=1772013618; bh=WWz0nz35Xv
	NjQcrCBxmqnWRDGGgK2AbnuebbrzIWHc4=; b=bGZFEqHla+vOXdrUXz8gT3Sin6
	imM5S80Df6+IPWP+3YWqJLmizTtmeYfku+hjol/1u7dWEBmhfZwLhhBMZvCSQklo
	DihNRHda3CtXEUBN+kxUGr4BWY+WKUGHpmOo6q8XGLs1JWaVOnNBFIKFrq5iFbTw
	OMvHHdifKL57rNXNX6qqA+tY8/IbEEaVNVjRR9wim21CfF+96oMUiXoVoXzpiV85
	50XSflxBtorp+4mw19/QjLRreCD35Fn0/UQL3RHDyiI6sjQOYMIdHFnzEgH+W+E4
	y/lHbiin3QsCHmvXbLR02PZav7/koDpHrWqE38xs2BJ89Kw3kvZRZJJWLwAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771927218; x=1772013618; bh=WWz0nz35XvNjQcrCBxmqnWRDGGgK2Abnueb
	brzIWHc4=; b=OwWv35QodNH3+/Ww99QH157IrcWv9TVPmwwIGAwv75MT2+SPOpz
	jqTcZoegvEZYR920WqP9vYzQwo9O32izuDlOYGtRnNqMJjzE2XMmYa1jlILGmvLZ
	CEKCT0v10X6M4WVLBO8TAK6XX5+7JH0FP6s7sENd5YCLedsa/WoDq+v6O/yeCiTc
	458OxrJa4ymVIu25XZeVJWRKTmHk/v2zMLbANXUCukMYQmRcju2N9n+qn3RRuf8c
	Et5IqFaPVI0PAryYEu+h9xN6BpNViL5L5fmwPjghtp7jY/uvwp2+nFmg+F2FN4FB
	E6FsZ5vg5xZGTpeUCGUmACnilJB0LwC9Gzg==
X-ME-Sender: <xms:snadaV0gIlelQ-jdgeKZ5yA05s-Vg_YdYS6EMUY_1GfvwUVRJwWuOg>
    <xme:snadaS88hFkXg78-gweVc61PHXVK5yUZfeleJ4Xpy0IaJAJ0jc8bR052uH7BVe393
    htYk-j0pwk97w3rjtoXqHzIpb_FHw6EiXTg0rD0SRSZFsmNmOeO5w>
X-ME-Received: <xmr:snadaeNsxsvfoj9rCaUrT13I2P7P0yyc9td75-zKxxHSQIJSe0iifcGQTOse1kAbuN2HWg8bEBAVbg4JKFDCk8cil6YD0e3mpb1-PWrbmgS9Qw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeelkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthht
    ohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:snadaed4NcpS5Mq9qWmg6bftTbQTIFirHj04Ev04a8FUxXx-72iNmw>
    <xmx:snadaVXBbR9L0sow0-LheobtGNKnjUNpFFqkLbNwvA2wz-cFoSJhyg>
    <xmx:snadaegIxvFocI1tpiC3MB0QDa6zTxBs7U-gQnZAWWdhRxq-ZepPlw>
    <xmx:snadac-Ca5mh8hQRuHDneam8_tvkOBROTt1O1g_85KS5yzbZd1A9AA>
    <xmx:snadadthRtpfo6nLhHahHJizQ1U5pebyxViIIDRMkyGvWndb7Pxc-Pnk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 05:00:17 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 57e7b7f4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Feb 2026 10:00:16 +0000 (UTC)
Date: Tue, 24 Feb 2026 11:00:13 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee <stolee@gmail.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 0/6] Avoid the_repository in merge-ort and replay
Message-ID: <aZ12rYYwbh1fvrnE@pks.im>
References: <pull.2048.v2.git.1771552788.gitgitgadget@gmail.com>
 <pull.2048.v3.git.1771718393.gitgitgadget@gmail.com>
 <143ab1c8-9f07-4df7-8200-69b5a78a0351@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <143ab1c8-9f07-4df7-8200-69b5a78a0351@gmail.com>

On Sun, Feb 22, 2026 at 07:42:33PM -0500, Derrick Stolee wrote:
> On 2/21/26 6:59 PM, Elijah Newren via GitGitGadget wrote:
> > Changes since v2:
> > 
> >   * In first patch, actually avoid the_repository when attempting to remove
> >     check against the_repository
> >   * Fix commit message of patch 3 due to the new patch 1.
> >   * Slight tweak to commit message of patch 6.
> > 
> > Changes since v1:
> > 
> >   * Add a preparatory patch removing the_repository check from blob
> >     prefetching in both merge-ort and diff*; it's no longer necessary
> >   * Fix casing mismatch
> >   * Simplify the hammer a bit based on the new first patch, but add some
> >     simple comments explaining it
> > 
> > Remove explicit uses of the_repository and the_hash_algo from merge-ort, and
> > since this has now been done multiple times for both merge-ort and replay,
> > implement a small measure to prevent them from returning to either merge-ort
> > or replay.
> > 
> 
> I reviewed this version (plus patch 6 from v2) and think it is good to go
> as-is. I went back to check the v1 feedback and thought it all valuable and
> resolved by this version.

Likewise. I only had a single comment on v2 that was addressed now.
Thanks!

Patrick
