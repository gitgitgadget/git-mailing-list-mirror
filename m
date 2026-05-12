Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CE347CC85
	for <git@vger.kernel.org>; Tue, 12 May 2026 07:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778570053; cv=none; b=Cgx1kfDsBl+nl27ZeglTkf5JtV6DoMqpp9SjP0xo/kADQpB0QrM3kLh2NcFrpVqrIunXIyRXVCC4yO1vVlrL5xl57/XXfunNXFGDmbZdWp7ZTEKT0inIWN3ZETzxj6wPB3m2EP2tIHNeUZwGM3Unbi8mhT6ZkuGP3juQNiSrKc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778570053; c=relaxed/simple;
	bh=Vbjl/Ce6Y4l1sa6x/lDBp2FzOW4NiHJtVdk3OAKx8+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TkuxuI0qmz+SNW25C4fSJieY0molkcyWIcbnN11D92TtdCeOKNoShcthlpj0nMt7JuWmUQnp4TSMS4t9DIIDrdaFUPdAHyYDUQ2NZStmm98DTLGE+ZvYT7jTKnhQEsGumtT8aia40XDEienzjMgnk2SMOOI0VYyz8liRnM0Vyrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MM1YsLO3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BAfAMNUE; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MM1YsLO3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BAfAMNUE"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 071AC14000B3;
	Tue, 12 May 2026 03:14:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 12 May 2026 03:14:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1778570043; x=1778656443; bh=R4FPjV50lv
	4BuEXv+DbNE4U+AmTJkLjC2QBXi1JncaM=; b=MM1YsLO3i+oUfLMKc1Tyey0480
	5WAtnAc2Ih5xEHyeY2lbNoD4J9bdU3OGLYWUpKVD7JjmAXm/X3Ii0phHJ+FMYSZ8
	SUQXKxn7ZbO597rGtg+QaAtzzbOFeV4b0c8sYenokIS/sqchYfMK//N0Qe4xPlqr
	Vz6QTp5MmTd3qIEP9K2GCFDrBZNsgFpdEON5rrQ6Lapv6eNL5a+ud6cxq4/GYWI7
	T2bzVK2MODDteI7yhV7DN3pgTh/+esXi+swaUTazU132xZs3+m76yfbMJRkPJ6/T
	M757RMjrQdDgr1PS8RD0cjOXnvWmmE8c2+XnOoZsrFpKbfgwwU0F3AxwcAMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778570043; x=1778656443; bh=R4FPjV50lv4BuEXv+DbNE4U+AmTJkLjC2QB
	Xi1JncaM=; b=BAfAMNUEMRI0wJtHofyUolfchiaZn6Iwnpagc8wYYcQG5bZp3/S
	7+qBBqSNTAVpqOqZfMG8GRMxMkfGPqMlVX4ugFsUo4H3EJQNF+nYNdyMpeGoeUFi
	mwG031z2+RPE4krpdOh5Dn+g1nDnkrg4qePkTp/3iBkpB2qqYPBy6N+fxd8QDVUq
	6g/QvqCcrd6MO+shWdO4rOCx5clrNNVBJz/UquSny3DRgj4oSvnO8GjbMU2sB20k
	Pu0QtZYnlAzlBkVuk/zAC7QwJ/pPbTSNlWTaGXVhJFYjoHfhdiOe/0kXt5N0ahJI
	Gs0Dp5nby9R+E5ihWrJQXr8RhtGTnblFr9Q==
X-ME-Sender: <xms:OtMCat8OcEnDdwJDVOe6AecLUf4jmtFnYkwMRbsXZZpj4Y3GkmLi6w>
    <xme:OtMCaotv1Wwitcl5V5dsZzH9IhMisZWWEsUSsjwgoY2CxFJ4ZesV_S05Pdmi0Jsz6
    oOOWqM27mF7fRjVqVHDIi1OTLqvpWwHo3G-dIpdbGUgV_3wKGf_>
X-ME-Received: <xmr:OtMCagBuJeUN6b8J9aLPvhl8_OBqc2bU1ZT02Dc03fPbyRSOC225jPeLp29sPNLRfCcU1sI3OfOJrINs9yAgoLmaD0t93NXDhExiT2xnG-0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdduudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjedttdegffekudejjeegudehgfehtdfgtdeiudelueelgfeuteehledugeeuueevnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehkrhhishhtohhffh
    gvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehmvges
    sghlrggtkhdquggvshhkrdgtnhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:OtMCagXk43LyJCsryXWoI2X9AaIm0oWH83DIfrYAwig8xeT2NoscAw>
    <xmx:OtMCauDJweHo7YNlrkReZXJeTclkkxCbgnFpQYzpQAaqWDd9ffL9RQ>
    <xmx:OtMCaj-C-OMXoqCVBegT_nL1v9MW9x6a9QiL0CC-QeTDhof9SSnR3A>
    <xmx:OtMCalEi05F4zjk2h7rLfpMDUGH3muZqJQJwH6R5WL5yg2jxU_9jTA>
    <xmx:O9MCaqN7o_l8iE73IffqItlloKRCn84FUClG8RGONhDIbiByIGVlasnF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 May 2026 03:14:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1f82234e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 12 May 2026 07:14:00 +0000 (UTC)
Date: Tue, 12 May 2026 09:13:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: me@black-desk.cn
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2] config: refactor include_by_gitdir() into
 include_by_path()
Message-ID: <agLTNbrXvwLifhYi@pks.im>
References: <20260403-includeif-worktree-v3-0-109ce5782b03@black-desk.cn>
 <20260403-includeif-worktree-v3-1-109ce5782b03@black-desk.cn>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403-includeif-worktree-v3-1-109ce5782b03@black-desk.cn>

On Fri, Apr 03, 2026 at 03:02:28PM +0800, Chen Linxuan via B4 Relay wrote:
> From: Chen Linxuan <me@black-desk.cn>
> 
> The include_by_gitdir() function matches the realpath of a given
> path against a glob pattern, but its interface is tightly coupled to
> the gitdir condition: it takes a struct config_options *opts and
> extracts opts->git_dir internally.
> 
> Refactor it into a more generic include_by_path() helper that takes
> a const char *path parameter directly, and update the gitdir and
> gitdir/i callers to pass opts->git_dir explicitly.  No behavior
> change, just preparing for the addition of a new worktree condition
> that will reuse the same path-matching logic with a different path.

Good preparatory step.

Patrick
