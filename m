Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0DA1A6826
	for <git@vger.kernel.org>; Sat,  7 Mar 2026 01:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772846128; cv=none; b=NGvVP/AH9IdRby+OuvvRkrDzQrJba1CHFAECejYMXzbs+2woZo+1RsRq1snk7DxKA3pnlG+F/JivOxtL18b8tZsPFCeInd7zUQyc3nNuUczfV19bK297uLIxhIvqqRRtU4MPU5rKf98Byw+DFZympPDfCmlmbFAvWWq6sNz5PA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772846128; c=relaxed/simple;
	bh=t8hZUH08107d7PeRkDa93ngFSfKwYxJiU1YJioKMt/g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fmdVr+PlEih0oAAIWfTuSz0GICowkqDMjNFy+pOiAJhH9KFSCZwiDLZFCQbSr/580NpVcCmsKuBC8UlHzrXxIv5kn2Dip6AwNXQIcFCp/GPuZngCPbUGfefuf90buzpQ3C1w2LmHcIsz1yHH+sxQ9gtJG438Qi5gYew0yiJN1NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bt58i93g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b2s3AkA3; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bt58i93g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b2s3AkA3"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 545D6EC08E0;
	Fri,  6 Mar 2026 20:15:26 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 06 Mar 2026 20:15:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772846126; x=1772932526; bh=1TFxBTs093
	Ka5Vuu6nt23W/yPRlf+CekBkQor1x1qmU=; b=bt58i93g27iE68DOQxUOUMtlQP
	3ny/Y0ElIvpfPFdaroyxCHglh9wByfQSjdnMHc/YS1rnGvQomxM3pP4j3kTXnixl
	84qdnfTpB0N0t+OhG3FvAqSxdmrCWPx3VQ62wSgaWhbVbf56v3V6naGu6fZUUGs7
	hXG60yg9eLgSlRsjtdjMa1XjXDLNHDggSH2cLjraVYzoHM/i3N5OCS81c0Lnsazi
	JK642l6zgCyXvaAVnKWoU8Q1lAvi0OweieTiJrPJEnj/iaGdi0aJvBhkfA2GOYTJ
	oVBSTieowRPedzayBDLUZk3s7ruvSymrtmKW/CnrGzHl0mYNJtw+hMS1VUpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772846126; x=1772932526; bh=1TFxBTs093Ka5Vuu6nt23W/yPRlf+CekBkQ
	or1x1qmU=; b=b2s3AkA3VvYgUYsJF7iscc5t9aysD056OVqu5yzPhlIEEV5aPYx
	Pddrpr9e3gi42xKPCLFjwSfAZ+0z7oxPBKxzL+NZwfSbk7jcihdHlYInvJk4QM+F
	hkWE4Tgo36WA44RuegDn4N3aaGynn/qV6NtpGYDU1uiOJO8/Ie37o42re7080ioc
	SM5eUalVeILTVpgaArvq49NDMmwnQ6IcFDHIwKZI0ixUweCfk0VAV7M8W3XlHU6w
	PDUTvM9Hc812qjLPjYY4acPJXA5JsKBo3cbiK0MF8SJCqtRgEx74Tpkoe3YZ6Zok
	tpXfGaMCaca+X1ZL3uJjMD8TzqS3VLTIt7g==
X-ME-Sender: <xms:LXyraZY_7J9T3NiQs5qAkkrRfMhQV0epVwgHDzSCsg2T-e60LHjkjg>
    <xme:LXyraePkH-Syt0dESM7kPVv_9haKVhskrNXyvXo2xFvHlyT6zy5QCX0DWD8_8g64f
    rvFTkukPS9Bki5g1RaCStWiL81oXMrmvpvvGVKNWcvu2C92smnG8g>
X-ME-Received: <xmr:LXyraWacvVEUsD8Ng5nMY5DvJqK_vEESMZDY8O7WJvnyi_nvGRmOr3qOPgd-s_1p3syhC5GByAs7Zw1RRyBi8uBwUXDvdIGDCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedtkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplh
    hushdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:LXyraU2J3RiOWXGBiIMQMFdI_Nufxov3F274tdnxfyBdJSlq1WJHBw>
    <xmx:LXyraUe3lYCf1OuAHXYHWWpflb3fOYNRrVZ4MwRCLdP3QBB9r5MYoA>
    <xmx:LXyradG5CeWotnN-124wp1nk1k-izXQFLljhxuxFeue6_wkv4zMrSA>
    <xmx:LXyrad121G_UASyx5Ap4npU1h2v8XDgLex0Ivbkc2qT6kfWtX1Xjyw>
    <xmx:LnyrafWPcSpYLZpLExW3zV6GQ_bK7Wks1qF7laERD8B2IBsHoMcWT9qr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Mar 2026 20:15:25 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: [PATCH 0/4] plugging some mmap() leaks
In-Reply-To: <c3ae9ff6-8577-48de-8473-9ec8d22ebc71@ramsayjones.plus.com>
	(Ramsay Jones's message of "Fri, 6 Mar 2026 23:25:03 +0000")
References: <b9fa930e-7d5e-47f1-8896-1997cf7c0cdb@intel.com>
	<20260305220214.GB736322@coredump.intra.peff.net>
	<20260305230315.GA2354983@coredump.intra.peff.net>
	<9137fd66-9ac3-42ff-a892-1b6f20b49972@ramsayjones.plus.com>
	<xmqq5x78249v.fsf@gitster.g>
	<c3e66e36-cba0-49d3-b2a6-d65367f4be0f@ramsayjones.plus.com>
	<xmqqjyvoy5p2.fsf@gitster.g>
	<c3ae9ff6-8577-48de-8473-9ec8d22ebc71@ramsayjones.plus.com>
Date: Fri, 06 Mar 2026 17:15:24 -0800
Message-ID: <xmqqms0kv3rn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> If you look at the (currently 31) calls to munmap(), only one seems to look
> at the return (in refs/packed-backend.c:183). So, calling munmap() twice
> on the same memory region will probably go unnoticed when NO_MMAP is not
> set. I have no idea why munmap() was called twice on the same memory region,
> since I didn't track down the code responsible.
>
> It was just an FYI about a _potential_ lurking bug when using the mmap compat
> routines.
>
> Have I cleared that up, or confused you more. :)

Oh, absolutely.  Thanks.
