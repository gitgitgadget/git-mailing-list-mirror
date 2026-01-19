Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1E925F7A9
	for <git@vger.kernel.org>; Mon, 19 Jan 2026 06:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768804454; cv=none; b=sRT+lCF9UFqSC7QKUGZTtca80eJTZiZJORpcPvHZS7lVyD7+5EizB33b8ISxIQ4Ln8wxgRmVfztd9I1Sn5arphFOvZv0oV1DDeGqTpuDI/Ex0YTzocUb/E773zZkABPYNlSI/BAQ8DvRJb5WNpZbm7qGBp4YQRQlp7/ogkeaWRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768804454; c=relaxed/simple;
	bh=LksSf5gv9OwZ1vfAk3iMk30l8Fdd13xyWbjyDmqgNrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GTgiRjqRlvjKkLqoBA0K0tPlETH+N9ELXPwhnpByZnDU2la5JeCVdSjpj1zCxRvLGaKGZBEOWfDxYpsWn2zG06neOMjD8wTd/fI6OQr/3j4l56w84WQPutQHpBs8rSM3pM9xPUGenKYEz9gX8PlSrwXtuAuYn6cxoJ6ytGpwEjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IVCggdt9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ro/DPkzP; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IVCggdt9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ro/DPkzP"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C4816140061B;
	Mon, 19 Jan 2026 01:34:12 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 19 Jan 2026 01:34:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768804452; x=1768890852; bh=nfhfRUCUi7
	Hsy0MEGWkYrDmfRKDopENiPDL0R2rtUgM=; b=IVCggdt90PP/Cpwg5qv98HF+pq
	vIdBFEcsV6UYQ2sDHWMosJYN7Aq+ijb4/Qpf3WY81PzEpCeuA35JwkGZOYEt5MVT
	gbhhqtdbB9sarXmqNbe6cnFwqJILwyizSAUdy7QK5dcyzMYnso1OCSDdOw8SGYHj
	N5wJlHTcATQx2zlrhvBSE31Hn2DsSY7wC1lV/159qM93dYJoSn0afVV2tMEng0Ud
	Vwza0gvCwLgry6nemdQKgO59vczfV5TNVwa9NOlLOS8Bddy4K1Qna0m+aoN8efJs
	yegJgOMr/Xdy/XmCsXiQARyY8Mw+Mqiiz2k6AQOUHRD5qFZrgJWuKy+4BJ3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768804452; x=1768890852; bh=nfhfRUCUi7Hsy0MEGWkYrDmfRKDopENiPDL
	0R2rtUgM=; b=ro/DPkzPsinUlCYZNVQSNIIz4GjrcPiglVPT/pkI7GI4SP5DR6D
	I5zIWl8f9rX2C1zvxWxOW8MVstb2Zeoc0MOaUV8vzfMYmZ0wUbTVtDHVA66efs8u
	o98mThf13tzj/jwj25tETSoutIhE4UUCBt3+KxVmNqMYHETMOBLC5OipSEJMhm3U
	Jo/7gyVDQxXFdmKX1b9vfYJI8kY+95uiuId+Rwlg4Bw8viFC+eIjjJoqT/iVo8Im
	OjBpcSAVexOOlvml4/ftBkqPRZk3wAfcA+Q7QepG0UQNio7NsvRrYxEX3VpAjKRv
	F2KM41ZEF4V6x4NcglpphSMSgje0Pe0PGOA==
X-ME-Sender: <xms:ZNBtadoCGDGztb4OMta1hZZtDw0EjmdfXO4sohGvzJTvyD82EZtHgw>
    <xme:ZNBtaXEKk9juydK9EilkbDRgBCdUGblL6N14ZwgE7yHQXJv2kvzpMYbm60rHawmUt
    fXS7J-_PWq-GppyDGKblUk6NrxLf_53xfm-ja9hoJTApY79bNgwJw>
X-ME-Received: <xmr:ZNBtaXkApyTILaKNhQf1JzYYImxivLo4X6HEs8uMbuKnV1Dv2vStMEBsAGZ33nw7S67ZCQGBlUSFBV6TQY7Q81Ich8XgwBk7ZwnB7TI_wNc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeeikeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohephhgrrhgrlhgunhhorhgughhrvghnsehgmhgrihhl
    rdgtohhm
X-ME-Proxy: <xmx:ZNBtaSlt3utbykIJaRD4oiX1sidc-mkTNdwdkRAFgaTQjb3VZnvenQ>
    <xmx:ZNBtaQvM9N2oWmRLyATyr2XqT-FclrImGlR7vjyVHG4Yh7wd-QMliA>
    <xmx:ZNBtadlDQh_L4104OP1LkaIWUY042gboYav-NsmHVeruirixgrjZqQ>
    <xmx:ZNBtaTvjCgAFTm9012iQk9A8kdpgtUUaKZtVe2c2qRnzeeMcTVD2tQ>
    <xmx:ZNBtabwhJ6LH7IFJ2E_aXEGWRp0pNfTrnaoECLbes5gWZ0E5CrkZkSOA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jan 2026 01:34:11 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 38028bcd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 19 Jan 2026 06:34:11 +0000 (UTC)
Date: Mon, 19 Jan 2026 07:34:08 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH 3/4] remote: fix leak in branch_get_push_1() with invalid
 "simple" config
Message-ID: <aW3QYPvRUkvwKU1E@pks.im>
References: <20260119051858.GA1991308@coredump.intra.peff.net>
 <20260119052208.GC1991523@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119052208.GC1991523@coredump.intra.peff.net>

On Mon, Jan 19, 2026 at 12:22:08AM -0500, Jeff King wrote:
> diff --git a/remote.c b/remote.c
> index 5de9619bc7..e191b0ff6e 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1938,9 +1938,11 @@ static const char *branch_get_push_1(struct repository *repo,
>  			cur = tracking_for_push_dest(remote, branch->refname, err);
>  			if (!cur)
>  				return NULL;
> -			if (strcmp(cur, up))
> +			if (strcmp(cur, up)) {
> +				free(cur);
>  				return error_buf(err,
>  						 _("cannot resolve 'simple' push to a single destination"));
> +			}

Yup, this memory leak was easy to spot in the preceding commit after
your refactorings.

Patrick
