Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07F921765B
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 04:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745555661; cv=none; b=mM1rhZXBBr8abJIB+8+u4epRPmw2Qxgat7mKLIU7gn9qhtbm9CbL53OiVGiQa68K2v0VW6ruxLA6gmc3NZT41AO7kul1W0ad8t461ZzDcOlIwdzkDhfKIshMJyvgbzR/stnph7pczZ5zn5sB7fX7pk79vaeI5t3c+Osi3L279fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745555661; c=relaxed/simple;
	bh=fAt3epmMoQYcYlEWgFNMwEHfWn9MVHUIEhFZf+dqN2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eopo0qGmItHf+j5IjedVcg97NqiriWoKZvlvJLBZO1rPFA01gzLI5W79j6jq9mw3HNzQ4cTw4V4JqsHcm/oQ/rW/ft2KqKdATwupVZKFYg7r+f22Era55G0m/mVMPNTWVj94bVwdCdyMWUAmTEc6rmgMT+cD+lKP3QnKLh0h78E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ad34h5H6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vn+FILh6; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ad34h5H6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vn+FILh6"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BB93C114016D;
	Fri, 25 Apr 2025 00:34:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 25 Apr 2025 00:34:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1745555657; x=1745642057; bh=BnuWVvzIXa
	oc/uc+iPjNHyDPwqILpfc5ote3LK+wvuE=; b=Ad34h5H623ehRSgf3wH30e2X/Q
	bRw1yM0qZhMt6CjitQQ5war7F9BypE+ITJ92NYorz+qkr/HMznt7IRvBhqtdn2V1
	Z49eYB0biNuowDbNj9QDiQuDtXvdVUYcLhf8hnWy+lYRgLtkko20Iiwn4wMbqw8M
	vWwvBlGuXi7erjYL7X5rlJwRSih9lo+KEohNFG22jgmfmUGEYyNgWEvMZoX4PQVa
	26gLgbermTc6yVAN4kXLT0OhEowmOW340mCvIsBvKZ+V0m6zw3i6mDvGo15VyM9O
	QNTim3Tr32RFbl223l54oO4Qbj0KWjHB+pADLNBQfKg/QPRJDu7wEnzUfslw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745555657; x=1745642057; bh=BnuWVvzIXaoc/uc+iPjNHyDPwqILpfc5ote
	3LK+wvuE=; b=Vn+FILh6uKObLEKXEGDIKvzCoPgQiAQgdYMGHVe/qCvwhi5MhQH
	jueYZD+Q4bESPJodnbw3CyDj2fxuRKXqZFj/lEcekOpPk1HKQwe+a5VmIcYYSu9f
	P+J8Ldb9x7XhY641oiLTFNfFb0PsJCupEJU7wzrznwGAAQxhKkBMN0cSyGAmk4zY
	5NUuKDota8z7DRcejc0cDJc+ggetFkZ5CIt43sP5VL+mEzODtOaqBr/JQlJH/Ahv
	n4KjYCQR8JLLinPoDkSVBQuAAtNdTnZK6m/du2UmfuWy/Fe/QIdS2nG+nATqDuhh
	HuCL85ykrQI8ClrzIekMLwrnRnOcH+CtTDQ==
X-ME-Sender: <xms:yRALaOH11c6Z9qU8P7IJ0xlHthQaZkLtgZbbsfZgwBmBVy2gNdrJzQ>
    <xme:yRALaPXyY11ipClmsU67y1YYgJaM7XleRCwiUCEj6TFgqrshuX9q_l2en8_8NwZfv
    9WfFn1odJBVX17W5w>
X-ME-Received: <xmr:yRALaILoEvfFbFswpTot_W8aqNlb6fw7qPIbbWoZLuTYY1uM5iv6YzSu5uEVdLNvW3Yhe7HMYwGHHPiIotEbIXOPg9Pepk49O2v_jbJT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedufeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:yRALaIE3rYhlVkeUBNc8VIm3cw6Ur8UZAuGgNNExGrdUSjAlL4Ncpg>
    <xmx:yRALaEVMzhaI2fyzb3Ix8WMTXxRi81X70jBXmcpnRlnVYgGOlIVppQ>
    <xmx:yRALaLMT37R0guAqa1ogVadPQUP4mrpIIVVZxiKG06IlUwruKSCuRA>
    <xmx:yRALaL3GT0QdZ0pcIQvjfNkDwD-Ozxq9Lb4UmiA8_ydZnzj_iK0utw>
    <xmx:yRALaGCIk3R8RVJlRUCw3xBp7Ql6NPhE98golAt2YKkeQ86T6pl6Jaih>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 00:34:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bb1d87d3 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 25 Apr 2025 04:34:15 +0000 (UTC)
Date: Fri, 25 Apr 2025 06:34:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 1/3] test-tool: add pack-deltas helper
Message-ID: <aAsQwSfr-YvS2Mvh@pks.im>
References: <pull.1906.git.1745430004.gitgitgadget@gmail.com>
 <5d4beb202d6ed842de72928462a10a4f5faa2718.1745430004.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d4beb202d6ed842de72928462a10a4f5faa2718.1745430004.git.gitgitgadget@gmail.com>

On Wed, Apr 23, 2025 at 05:40:02PM +0000, Derrick Stolee via GitGitGadget wrote:
> diff --git a/t/helper/test-pack-deltas.c b/t/helper/test-pack-deltas.c
> new file mode 100644
> index 00000000000..db7d1c3cd1f
> --- /dev/null
> +++ b/t/helper/test-pack-deltas.c
> @@ -0,0 +1,140 @@
[snip]
> +int cmd__pack_deltas(int argc, const char **argv)
> +{
> +	int N;
> +	struct hashfile *f;
> +	struct strbuf line = STRBUF_INIT;
> +
> +	if (argc != 2) {
> +		usage(usage_str);
> +		return -1;
> +	}
> +
> +	N = atoi(argv[1]);

Is there a reason why we don't use `parse_options()` here? It might make
this tool easier to use and extend going forward, and we wouldn't have
to care about invalid arguments. Right now, we silently accept a
non-integer argument and do the wrong thing.

Patrick
