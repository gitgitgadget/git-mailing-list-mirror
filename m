Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1EEA32
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 20:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741985190; cv=none; b=gvx7z/CpVcfbIpLsUMOEj1hQSgl6chzZHLXU3df0HQnFI9KulT6bbADU1+L8Y8/9B33rwlQ42mPEnp97kQzgoaQaC03sJI7o+dRknSdMrgpc45ThvYpNs5zRRSnlFHqbVoxXcwJfklGu16nHo+nXmlrQOj7YzgqPEe5596DX2MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741985190; c=relaxed/simple;
	bh=KgxCvA2AuYW/evqY/6aT4DbQJ5u3Ex/rsYtE68jM53E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jhltaE7zhGx/uAf8rDYkTFufrUdV3f358lA/gm39QZ5k1D+5e5TWmanwfLEXdr9B96VTlVsgfrktK/H1z0ye8At9EmFMMtBBBbO/yONGJ4f4OC4Wdf0wuY0qjemdtypT1kTJWYZINVoN6wh7RlHYl4vg7xMPutB7OueTMCUoXWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MjHvmNN4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yG8flmqY; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MjHvmNN4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yG8flmqY"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 43C9F2540109;
	Fri, 14 Mar 2025 16:46:27 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Fri, 14 Mar 2025 16:46:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741985187; x=1742071587; bh=CfBv75VwtR
	PygMyZs86goO6xkGLGRjfjL6yqQfvL8fo=; b=MjHvmNN4LcPUz5/dvOfXAkDH9z
	+sFx81r4aABPEvQO/M252BpLGVfdnAxNB2QCN2eyS4L2GDfgMEQvZ6Q06pZ8b3dK
	1L2jCAGyVfu7CUPOB9lwuBAPlquLF0UDdG7uBUe+eEXECYyAsMAlJFyI7j4/5b1G
	d25NAkOXtgw0v/kWABtxNxr2VsGwLR9viSKu6tDFHze0Bn2POjcw76R2+kArq20g
	IPw2J8Sr0aRPG0jjVqToUiIZDZ7SYraqVdB2MsrKgzOuaKKmmPxJIMVNPavunS9Q
	glZ4Z8LOiUXcIolQdRyyozkLc207UrX1D7BONwZ8DEwOv6/naZzrr3DlRrZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741985187; x=1742071587; bh=CfBv75VwtRPygMyZs86goO6xkGLGRjfjL6y
	qQfvL8fo=; b=yG8flmqYQ2eryPaN9lRPT+9Jl5L+wZN/XKszlV9PNuMA7f+9Zan
	2v2qKhyoR1RgiTCJco6VDO3ENDa6K9yIdgQSqmyd3X9vSQB667HmPsglrYRZd9dj
	6F3RkZpgegwKtWrekrxsBCywnW+mVYuV54ez5DNR6pWqvvbY+lETw1acq17mqg3N
	K3CjiF4e47VcMXKfOPfvgCBZi2f3ItGszN6lSYBAOXy+Bgw6Lfm6ylYTyaLl6Ekg
	6yNBMfTGEVKM6zVq5rNODV3QHuLGOoG3RBfVVHSc/TG1RQfujZDfjxEOP3rbS55H
	b7Ah9ulqASOgq7Pd8zDMptzvGK4Lw5E6LFw==
X-ME-Sender: <xms:opXUZ_BEgC0wppJLek9jROj2t32FprISbPvRII_5IuPYJoYF7v1ngg>
    <xme:opXUZ1gWw5LWbW6_KPoY0gQZ6kq_27PlIpKbYfHGQjMq41KbSmvYxfH-VtLa5pf1_
    Y0IBtl5OMAnDtk4DQ>
X-ME-Received: <xmr:opXUZ6nro6N8kZZpVoN6_ByoboMHutpP5pPUNzEnGJc6htFCKxgR0pwoXVh0RsvSM0HjqG9PScFAL6OnSWOzkaCB7Qpo136iUaHV3lI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedukedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtvggrughmoh
    hnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepghhithdqphgrtghkrghgvghrshesghhoohhglhgvghhroh
    huphhsrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhp
    rghsthgvrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:opXUZxyZNAU2wsIQ8JtC5vHSjklwkjhl8QUDp9vLi-KeQGUargHuyw>
    <xmx:opXUZ0QdCCNaUxHm6rwmplshdT9WQ2ztPArSLEAxKEZiu4MXgRdTDg>
    <xmx:opXUZ0YqVqgUezSf_hTUxdrKUXaICzXsN8y2kgxHRB2pyZRwVIk-VA>
    <xmx:opXUZ1R10DWLk-j-0cAzsON9ppQrYOQGod00PLDCi40mzrlBCfmnIQ>
    <xmx:o5XUZ5J_L1M2H4KI3RcZ_enePkhOdZj_AvYaLtAP7KOSnNeY3jhFVMkt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Mar 2025 16:46:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  git-packagers@googlegroups.com,  "brian m.
 carlson" <sandals@crustytoothpaste.net>
Subject: Re: Problems publishing Rust crates
In-Reply-To: <4zi3re4viluih7qwvwlu7mp3j6e6gjexz2bppa5am45nnqkezz@7vtwmyrfdwvi>
	(Josh Steadmon's message of "Fri, 14 Mar 2025 12:43:32 -0700")
References: <xmqqfrjfilc8.fsf@gitster.g>
	<4zi3re4viluih7qwvwlu7mp3j6e6gjexz2bppa5am45nnqkezz@7vtwmyrfdwvi>
Date: Fri, 14 Mar 2025 13:46:25 -0700
Message-ID: <xmqq34fffihq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Josh Steadmon <steadmon@google.com> writes:

> To prevent squatters from stealing the libgit* crate names, I've
> published placeholder crates, which we can replace once we've fixed the
> build issues.

Thanks for being proactive.  Very much appreciated.
