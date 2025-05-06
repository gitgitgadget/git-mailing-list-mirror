Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BFF286422
	for <git@vger.kernel.org>; Tue,  6 May 2025 18:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746557528; cv=none; b=RzY3jBP48/VSm9jvEhbexKilewJ/A5SfWj25rkGkqlbAZPXgGakT8lZEuguvw8NK8mgIYCwep/FL0hBv3Zc8iTuEdb2T/g4MJ134CYzdkyCbWexEaJmaZ0UMkkYfaIf4ejbHtHyHlmf8ZfFFaFacV6U+id087lOtvT772RxLIZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746557528; c=relaxed/simple;
	bh=JPAuqR5NITOj8tkpoYRECFzUTXR35Rt/OSR9qRiOMJA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YhMUOpJ1ZRZTRJ6/Jb3GsADxYzTeVT9QAPP8VY8UiS0gQhsJnZOLlWxDmXCPORnR5OTfHkGlhKrsP2OwON7QngwrsG0mUtKhQLKXssjh+0I91Zkt68yNFUiXEvvX8cSDsmMcLfA9hmB4kdvCBnl5j8w2mz8kD0+4a7DHNu01yQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UPDep8VH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WWDx5zwb; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UPDep8VH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WWDx5zwb"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 1D347114021E;
	Tue,  6 May 2025 14:52:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Tue, 06 May 2025 14:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746557524; x=1746643924; bh=DZzeWYyNsR
	aoo81hrFLzuI8O4O2t/37T6IF6Eye5Iaw=; b=UPDep8VHrRpULinPs9W+GDMefT
	z8nPwf207SgXGfvJlK6U8yctQcEq5p/xv0LavEF6J1knlVpawt9XnG2+ZJpAFbe5
	iZo5Hk0rLSlcUy1S9o8eaAzEGDLzE6uHMk2fBn1JAB+yz3PyTb/TtRDG7pYzX9i6
	ZR+hE3ZYCvg+h2v39nR70uLDsQL9JSafb1v6PJsazKRfE/nOZ1IrW73JnJFZPBBx
	kw/NwRS9BOnk2kIHXdUGZImLZl3J2me1psXFYDPaU+dT7erNjkbQfNKUqJzrqwRA
	HiUPhiLT356Y+H7Pyot4SoFMWxxomGOAk+e3WF9nnd27mv3FQT1HmykCyvOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746557524; x=1746643924; bh=DZzeWYyNsRaoo81hrFLzuI8O4O2t/37T6IF
	6Eye5Iaw=; b=WWDx5zwbYKCqNZO2piQm6aksqV3QUqBprX6jf8PPDFr2s39bJpn
	0VI+LpHYyXR8Izdw/SQB1wFAHOpG9OeaSwyipNdRbCKQG9HzioYQZ73saUisVM4E
	UG0e2AgPYQnUsShOG/Fgev7a6JhmPZmEquFl1ozvWN8rJtDsltoldW7DQgcWDMyu
	lPPhuHLHRRX3jyvHNA7ZKMqerrpSd0hFbzie0jW9f1sSXGqmVnj2fqTFSc6Qj0mL
	9KAxATjM26TzEl9JjOBX4rHMiplh+sxF2iwdzOkM9Kc+nlB/cPZ9w66b8IaNDInh
	qo85ntvdm/VjNXWaqAuQYeL+zuJlaVJK9Rw==
X-ME-Sender: <xms:VFoaaErX5N8II3cuS0dutbne2E9OCGvoDrdO0KdOF8Fn_cAJ6_cMkw>
    <xme:VFoaaKpCCtoc_wSqT05fIXET6wNA3qe89zhXHxgz7fQuljhQgMdad1xBENyFnsx0R
    Fucv-DwYUzWNS48OQ>
X-ME-Received: <xmr:VFoaaJN2W-aTgbNT61hojs85vCiQ3j2ZeI506t90Bs3hRzz2FX7I_uCkGc1ETPFsXLwiHYG0qAC9Aem40FJx2v6cdQufMIVlk0Fx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeegjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhhvghjihgrlh
    huohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:VFoaaL764E-IfSMwMYOpcWSWtnbUW69S9pqCHhzHIKmq7AexDiPrCg>
    <xmx:VFoaaD47fUtbUpZKa1yfr0iItVqWJkedwgYL0LRoUXk1Iyj0qdd3nA>
    <xmx:VFoaaLiJmomUFFMRJUSt_MaN0nFodsCZGkdT8-XqT4mUKa5jVQALbQ>
    <xmx:VFoaaN6ExWZ1F329yrGWajY_FeEfAPYD9tnLGjkKPwrTWLCbyGffyw>
    <xmx:VFoaaH2sv_zeeaNrlnlFrOtyO5vsGp6PE68K5puTpm6T2hbfCoBtkIDk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 May 2025 14:52:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH 3/4] packed-backend: extract munmap operation for
 `MMAP_TEMPORARY`
In-Reply-To: <aBo7rXx46_jQhTGA@ArchLinux> (shejialuo@gmail.com's message of
	"Wed, 7 May 2025 00:41:17 +0800")
References: <aBo7OiCKHTyT4DzH@ArchLinux> <aBo7rXx46_jQhTGA@ArchLinux>
Date: Tue, 06 May 2025 11:52:02 -0700
Message-ID: <xmqqldr9k1wt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

shejialuo <shejialuo@gmail.com> writes:

> +static void munmap_snapshot_if_temporary(struct snapshot *snapshot)
> +{
> +	if (mmap_strategy != MMAP_OK && snapshot->mmapped) {

In general, a refactoring tomove conditionals like this to the
callee and make the callers unconditionally call the helper is an
antipattern from maintainability's point of view.

Imagine what would happen when we acquire a different mmap_strategy
in the future, and by that time, there are callers in the codebase
other than what we currently have (which is just one below after
this patch).  Do you have to verify if all existing callers that
trusted "if_temporary" really meant MMAP_TEMPORARY, as the name of
the helper function suggested, or do some of the callers meant "any
strategy other than MMAP_OK"?  What if some callers want the former
and others want the latter semantics?

Without even talking about longer term maintainability, at the
callsite, _if_temporary in the name is a much weaker sign than an
explicit if() condition that says what is going on.

I'd prefer the caller to be more like

	if (mmap_strategy == MMAP_TEMPORARY)
		munmap_temporary_stapshot(snapshot)

and make the caller to return immediately when !snapshot, i.e.

	static void munmap_temporary_stapshot(struct snapshot *snapshot
	{
		if (!snapshot)
			return;
		... the rest of the helper function ...
	}

Thanks.
