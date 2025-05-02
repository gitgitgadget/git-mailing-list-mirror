Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14144267B86
	for <git@vger.kernel.org>; Fri,  2 May 2025 16:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746204789; cv=none; b=uPfi3QgigJDU/q3xXy9Lpu+x47AgAjd6SdShPAYRB7On/drFkj96sABiKJ5oCtCmB+ZaP8u5OXBbsucGq5CUdXZe3XvmePrbDKjrtyaaqnpN7CQ8sW6Hm7WVKCRawSDEV0MDbFn0m6Wee8vh4lYZS8xtDJJwesbD8VsXSA9iKsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746204789; c=relaxed/simple;
	bh=G75Eih7veLgudVRcbzMfLDCs0LVVhMP/IUlm5fQrWBE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K3P/y0JqjYMBEwBGLbi4WPkPXUz42fo69MGREKBYP4wjnEszQQMvZ6oFFMUYhDc9lW+sezG8NGYBxXRCJC0//9UdPnKbrDKL69WGvbZXFVxAyB/j/VImXJFcI3W5fXeCXqlNNt2YG2Q6aYDWueiqPDqKNvkVgzaQutft1S1pcQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=K8+x9Wzz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Th1dHqa1; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="K8+x9Wzz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Th1dHqa1"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0571325400CF;
	Fri,  2 May 2025 12:53:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 02 May 2025 12:53:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746204785; x=1746291185; bh=VZpKTX+pI/
	xHVZrEKOgzPQ1DlmORtK+8/yDYcg2qHJs=; b=K8+x9WzzNbqEQ0o9tUWsN/mdV7
	t2D1oUnpUsE7qanXyWZMJAZXXe+M/zkh6GolBrMENmi+X7ha2bxzffQ67l4QTduB
	B577uxN5cJSLCRMwM57R46tJ4Knr6WSgeHSmI9tjIcuppI/QKZV7l6bpCz7z8AwA
	kTC8VWuuM17eZKI0JphU0Q9ybM52rz5yIqqOhSIb4Me2qoxh/RkHb3rXJ322cr9p
	5qwenj52BzRNIobCVDmL3as8CJEOm8yMiqZOYy0YoVwB562pGqYmcEjXT77JKrtY
	bnJ8aaQ/yd5PlreTwHjgl2Vn8R2hilZ1uQr7rxUlZzlIZw7tmyp49EKhVtoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746204785; x=1746291185; bh=VZpKTX+pI/xHVZrEKOgzPQ1DlmORtK+8/yD
	Ycg2qHJs=; b=Th1dHqa1CA/HBCtJftkVOXuscvQfgD24kGKtI2N76A7mBW5QcX3
	q6m3oTx14bPPt9ZliY6o+kZOhP/D6kW2pe1lWO3CphE1RRtr3bmvmGYFMVILnuqu
	c+1FSTMb1OIMxNRrxjz+L6+jTGWaVCsewXI6V7w+merPOao0XnZ7w06YJksfIPKB
	XrsHrLU2BYmNydWjkZqA4jKfqhJ35EbG1ExvspTIdG6VgB+VD8PrGypFDyv0p3Ya
	mDC3VcIp/BmxO6ZscKWmYPBhdcpRzV4ljD6DtvxxwNtm3VphGp4/zWJ4LZLnpYgQ
	dY1wo+4Hu+NYKfZc7gCpBYQgZ5tzD+Z5znA==
X-ME-Sender: <xms:cfgUaDVtp6vMugHzw1vKhHPTHML2ZeQqr6ZnyN7GyjA9ibh8EO6B6Q>
    <xme:cfgUaLk5OW1uwmzBRGlZH-8hxZG3pILzadXZ78bqmaq5GHOw_OCFsqFDY8dsIIrX7
    kr3iN5oKfyN5gfCVw>
X-ME-Received: <xmr:cfgUaPYhJoeNQ7RV5A3l1olGODXvGBrN3_9txaxu5Tb2KHBE0kTMvhJ_ojVEQxB2VpUqhyL1dQg7zuoFp1EpFnjcjXusmNd_YrvV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedvleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvg
    hsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepphhssehpkhhsrdhi
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:cfgUaOXlarXEkSfmrhWPweLqN-aVYyPgNZuIKs1N90ZJ2cKApAicBg>
    <xmx:cfgUaNlkbwoOv6nKdLV2vPwUamaFQlRfKRGGkg9_RQFe25KA8fu84A>
    <xmx:cfgUaLeC-yzIbhC5otR_Y6w7N9eQJTLORS04W7Cv9fVgZD7EPD1N4A>
    <xmx:cfgUaHGj2MN7lgLEgOH115ToGDhxq1WUiFY2UfuSnxJ5iYdzchjtOA>
    <xmx:cfgUaAXL-cqdIwKcOpkBA5IwSwBkcEWC91svd2ybso9Js5LlK9zQRQvq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 May 2025 12:53:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Kristoffer
 Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH 2/2] builtin/mv: convert assert(3p) into `BUG()`
In-Reply-To: <38cc3249-3de2-5ed0-7ca8-bad6d4a5bea8@gmx.de> (Johannes
	Schindelin's message of "Fri, 2 May 2025 11:44:36 +0200 (CEST)")
References: <20250430-pks-mv-parent-child-conflict-v1-0-11a87c55ffb9@pks.im>
	<20250430-pks-mv-parent-child-conflict-v1-2-11a87c55ffb9@pks.im>
	<xmqqr0191oaz.fsf@gitster.g> <xmqqecx9z1n6.fsf@gitster.g>
	<aBR86Ct8mMUN_tzk@pks.im>
	<38cc3249-3de2-5ed0-7ca8-bad6d4a5bea8@gmx.de>
Date: Fri, 02 May 2025 09:53:03 -0700
Message-ID: <xmqqjz6zuf80.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The fact of the matter is that the Visual C-built CI (first the Azure
> Pipeline, then GitHub Actions) have built the artifacts in release mode
> since forever. And the Meson addition simply made a mistake by _not
> specifying_ release mode (and hence defaulting to debug mode).

OK, so this is needed for _different_ reason; it is no longer about
working around a stuck CI due to misguided test.  The artifacts
should be built in a particular way to be consistent with the other
build pipelines (presumably they are used in production later, or
something?).

If explained that way in the updated log message, I would be very
happy to take the patch and merge it down, even fast-tracking down
to 'maint'.

Thanks.
