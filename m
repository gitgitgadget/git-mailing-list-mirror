Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E41A195811
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 15:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742399345; cv=none; b=Kr9YpM2Vr35ESSrt2a9XZLkDijRXvGGIFUySqXOX0FnHLzhsYEO1TdfKcWa81wZr5QZXwh6Jxns8ok/FWL5JxBqiGF5mmoHFyBr1epUr/i4J7km62d59ME2SPEGz9xd46Eo1BrOscCXTuEYaZ2wM0iglctodnl43MlSogEElb/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742399345; c=relaxed/simple;
	bh=E/DHqyB1iBk2Gl55KtWYcBm/GrksP+P5Qg/x1zwrv94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IH+RbyVoYja61Zryv8Cpzl7z3PQHGkBWigQC/efcBDP+fE+Wx9kuLa+MLdpfpOAc5rHdhyxNfqLaiAzflBuZHYkjzqA9CJgOmSG/wY3D9TyvzWTUV6MichWyFGQnIxD0FwK6dR9ybHLJZRqroS9LefIpKuyYoWaMv+RyY0xyU1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oXhWhudk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u3lsEytC; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oXhWhudk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u3lsEytC"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 07EC911400FC;
	Wed, 19 Mar 2025 11:49:01 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 19 Mar 2025 11:49:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1742399340; x=1742485740; bh=XLkPRJVRp+
	tZNohlfwMawWMDZjc0Pt4xr33B0F1DKsY=; b=oXhWhudkZkyd5yrqQfid/8QPT2
	d2VUE/OwHKNXfq1uy/kXqGlbscOOFCtY4O3t9ezBHFuWeDxcORXf1HcZajue8PL/
	+92iRckbbMGCbumhdeHwNLk9yCWcffEma8I8jSjk8QqVJVKkoMe1lSPZhKoHFyVs
	ge/tJCyzN+0GPdcU5PQT+cyvAnJOzpnuFAEmGXmNhFqERM/3fO00NC3u98+uc15G
	8MkaAXhChT9OKXbKxa0No/ja/QBkBCDpyi0z7kp+fXN7vl1d0PJj6t1S5JSdF6pE
	MXwk5h5GbLsjimMEFkVU6hKw9xLCIBBLq7r2Vu4UPIM6mY+8f6nX0y0kfrdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742399340; x=1742485740; bh=XLkPRJVRp+tZNohlfwMawWMDZjc0Pt4xr33
	B0F1DKsY=; b=u3lsEytC8c5gdx+3fiy1rmOylDvEALiUETJJNTp4CV4cQTZvngB
	MkiSU717xTAkZzJTvXAW/kyUDnPab8VXTqvSrtAFmthc4PtCvsQmIWx8EnSgD7vs
	Ry4iQXHbWIcw5lF3JX6J6hBslXY7RJanKnORYaLtxV6MV7/ezK9zq0wYnq18jAb7
	hkiAJE7DYHZg0XBJwBqfjcdhjtdincMvDr0La9iCzE7AtnFV3+fTKMr/N0MY+RVu
	DhE7h1fF6YjwPwluNhZDhmgPhCT0BWjS9uxyPD4M0ivNvc0cG0F75uHCFPwy9b+P
	ZNy4mhpEXl9P4NA/SO3oW6gKue1gXip6sbg==
X-ME-Sender: <xms:bOfaZ8lpQIadskkPSG8ZOIT-u7mz_XM5wKo1ohJGqu6FyT7Myaek8A>
    <xme:bOfaZ728uSPDX8oQzsqCvvzwizYlpDF00Rcg-7C-DKrDal1f-EkU22Pom6L3IgaOQ
    v1JZvCJD4R-W83n4Q>
X-ME-Received: <xmr:bOfaZ6qCQ_GjcY2EYYUucBf4Xfpqqva6DEKbvWle6ZpJCJWxaRDQAv6rgSthDC6COGiM2BgADkWGIstDDZrgqmRgmJfP4yaM99AxNk1PX4LmVzgX_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeehjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgv
    vghtshhonhhifedtudejsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:bOfaZ4nKvobuuva0ZPO2-CUGdGHWvcc3iU3u-SJV7RISYf97sxdh4w>
    <xmx:bOfaZ60Ww4kiOtxOp3mkLS7vfTHmMvoM6nAp_nI7yBB4h33XoPFhJw>
    <xmx:bOfaZ_ux0lxhTQfQR2LaZLEn5iP4nVyjBAiTRYGQ2jfz09LHcXJUqg>
    <xmx:bOfaZ2XbngELVFz5FBCx01PykWddHCINB2B-XbCDXlL1W7RU1KQDmg>
    <xmx:bOfaZ_w7o1dLB6qV7dW1ap4wDUAkd0_c9FVs51Pp9seKOMZpxDf1KSiw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Mar 2025 11:48:59 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6f3f09c5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Mar 2025 15:48:56 +0000 (UTC)
Date: Wed, 19 Mar 2025 16:48:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [GSoC PATCH v5 0/3] reftable: return proper error codes from
 block_writer_add
Message-ID: <Z9rnZzbEasyRbHIY@pks.im>
References: <20250319075943.28904-1-meetsoni3017@gmail.com>
 <20250319152927.1263033-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319152927.1263033-1-meetsoni3017@gmail.com>

On Wed, Mar 19, 2025 at 08:59:24PM +0530, Meet Soni wrote:
> This patch series attempts to avoid making an assumption regarding error codes
> returned by block_writer_add().
> 
> Changes since v4:
>     - update commit message.
>     - add documentation comment.

One additional change that isn't mentioned here is that we now check for
REFTABLE_ENTRY_TOO_BIG_ERROR the second time we call
`block_writer_add()` when writing object records, which is what my only
concern was. So with that now addressed I'm happy with this patch
series, thanks for working on it!

Patrick
