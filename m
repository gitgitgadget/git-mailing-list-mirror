Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AFF2EA16D
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 14:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753193764; cv=none; b=Rn5pCYZrT7KVGQhOOi3HkK4XT93WcG0MFXNkJSGvvCmLfeiZmNjk6ZfCiZbRZpJtwN8usmRq85vZBSEP08t+OlCVJvI3yjOxctY+R/7kATXb8JnVmhq026l9kdioOJFC8Tc2GQAIOaGAjgZfP2nHehedMtR6Gl0SbVm5MJqCRm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753193764; c=relaxed/simple;
	bh=0FxoWPi3gj9Tqtl9I2ClDFEgO6ZnrgQp28csmc0a8n0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H7QHqUITtPnCVncECmpXeOBc7AziWSoODdDHdaazL0zIzz4n5lSRLm0+bgLrjlCTS5Pqfs6qfceSoyFnDYriygP54GJbQVKoVrk+x4BtgUQHLhYW1X+Jz36S88QLxJ8R3XSYFvslHMXJks/Kg01YPfUqouJdvBFrNPqWJVf73Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WHLKY3Bz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GJ0xRNsA; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WHLKY3Bz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GJ0xRNsA"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 77F90EC01CB;
	Tue, 22 Jul 2025 10:16:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 22 Jul 2025 10:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753193761; x=1753280161; bh=4U8NRa6axb
	Z0GEji3IXzuQCIGUCh1wbhwuPHu5bPYqY=; b=WHLKY3BzDSn2FiR5ZpYlh6yont
	QPS4nU1xLN87ZYbyosFh5WsJ98tVKs4CzJxW2QZt1dEZj7KFJJQaQmxeWcnEvi19
	bgA1L5LsGasb2Apx2tyRl7N3DUVi+FhT8EedmIOTyvpdo8w4kqYJX7qnwNS0nZvG
	snB4cuKjg7y86n01SzSyq4E04GEj6J7wiWW5IjDWBeprgnmt7lDwDDywytX//Te2
	rvsHxOp3GzQW2503NlvYbEWmcrRGHM6073Jfgy+YKCqTOonuNC0J2cSu3RB0FoI0
	ivrybUtu3ngJcLwugFFq8IAY92/yfIFJ+gKToqUQ1EBCyyHoRtFmHeiZcVsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753193761; x=1753280161; bh=4U8NRa6axbZ0GEji3IXzuQCIGUCh1wbhwuP
	Hu5bPYqY=; b=GJ0xRNsAFrbOlPGMVcRBA9JP6pTvMoOP769myNsmBIoy8ZNxWgN
	wEuvX938EphAFuHijSj+Utv8PJg79KG+RoTN8G82oUh83NIEiXzNiMp33uMqjsB2
	HSchiddmrWSAUiEV9wtqGmBQVd8QklI8/vyP6E5IFVjzJLq/UQZ9qrJwSGLjDEAM
	qgXPtZrmVwocehbGu5bfmVVPEo9briba2rfDfWoTEp2IW/vyg2L2tcDBFno797Js
	D0Qgoyx1/U8GdcxlTz6tVUg9GfSJKUk5b98UGGkiwA+1NvAmcNPAM0LC4vkFXTS7
	lZowtrEvmbI34sq/9CcJdpl6Q0+RkkldMrQ==
X-ME-Sender: <xms:IJ1_aGMn71i8cLEVdO_SWTAMPoeMdnqk25EwMxWjY0xr1AEgXzjJog>
    <xme:IJ1_aIO_-Bg8hR-z0kz8TU-DrM0KaSnnYdnskAS2koM02sdLrHwdQTnc6bBYKrqkx
    YL_d3gYhbCqFzw7Mw>
X-ME-Received: <xmr:IJ1_aGvAhy0DMsu5sL4nF2f-ZzVDmK7Bd_fUHBkmze1gQyBW_y0ozNJi7y0wZ5ss73wQ9mn-uZa-FDN4z4SAXRYDf19iejkYfTPHmH9Rkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejheduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohephhgrnhihrghnghdrthhonhihsegshihtvggu
    rghntggvrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:IJ1_aCWLsvD2KxjgjGnrL15Xm1D3_AfdLtuMjRiIgekE3C3WnZLqXQ>
    <xmx:IJ1_aOv9tUtRDbCTpXaTQeMCxx_uTNLJnQzu-f-JgQuzdpawzbN6fw>
    <xmx:IJ1_aOVIFQvBc0LFedTz6vkCXzn_EdM9FAvZEbPdfb5-GYeB_E82dg>
    <xmx:IJ1_aBmI2AN9oGNe5GVGSyu9a_5kdcU29tFI6Q4l1RgnvqwdIFJBmg>
    <xmx:IZ1_aOW5sBMegxHAfcA3jjrx8Cfu3_CerQsJ9hHvnL9hdczf62I3IhgS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Jul 2025 10:15:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 49abdc99 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 22 Jul 2025 14:15:58 +0000 (UTC)
Date: Tue, 22 Jul 2025 16:15:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Han Young <hanyang.tony@bytedance.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] blame: only parse detailed commit info if needed
Message-ID: <aH-dGhHm2xuY4yT3@pks.im>
References: <20250722114220.87570-1-hanyang.tony@bytedance.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722114220.87570-1-hanyang.tony@bytedance.com>

On Tue, Jul 22, 2025 at 07:42:20PM +0800, Han Young wrote:
> In commit cee7f245d (git-pickaxe: blame rewritten., 2006-10-19),
> The function get_commit_info can terminate commit parsing early if only
> the author information is needed. This ability is not used by callers
> who do not require detailed commit information. Stop requesting detailed
> commit information for these callers.

Okay. I think there's two important pieces of information missing here:

  - What does this buy us? I guess the answer is performance, but it
    would be sure to quantify in which scenarios and how much of a
    speedup this buys us.

  - Any reasoning why those two callers don't need the information.
    Reviewers can try to piece it together manually, but it would be
    nice to hold their hand and lead them through the change.

Thanks!

Patrick
