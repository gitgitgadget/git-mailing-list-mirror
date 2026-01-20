Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026B138BDA9
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 20:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768942792; cv=none; b=LqdNDf2HujqfKX4yiKDX6Rj93mq8OEpN1A9SK2qxkPcbW7cxlEvruxIjscTTBgfbC155pEilR4AlUhfPIw0UGlv9iv7N1KJBjmWcd0E4ix/HkJTDfoXkcsC1TMXdaKm0cCBCt7cZ7AbchQWFikMDrOocrR3xsVywen9hhF2dxLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768942792; c=relaxed/simple;
	bh=whEF5h0Ip2hj7eHo9ECR4Dlt70nbHBiptT3IPB5VGM4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hLIqE+XXm9I4wMtrF5mRyW98vmfYD+jumHKwvoAhGUMPwC3G9Dt0f/ED56uChkLyeUMUz05/32cPbVgIyrk/ufchZ3pgdQ+4J1SBeylTgoKfStgRiT9cbmQvXWO0NGlOMpUWZSPnl3Af1KwVhnqnNeTKwOQ/msjVBZ9Ku1ucItw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Nk43kJXe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LJvMgPyB; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Nk43kJXe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LJvMgPyB"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EAC3E7A0113;
	Tue, 20 Jan 2026 15:59:48 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 20 Jan 2026 15:59:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768942788; x=1769029188; bh=DLhcN3lhU7
	p1E4oJ2WAoaek4a3r8W/aX483EfB7P1AM=; b=Nk43kJXeaUEQrJRZHe+cv8l03o
	AAbqjfeRF9tLITE6Ya5WyDSBpxB7Md/W/A4icjYrud2Sm3NaCSX1YmT8LmreM54k
	j/kM2yj3fAemWMRN0g8F0XWQsLQyY/M56m3uvluKBcpOqfUmhCnvg2ERXM9dYUAN
	NJPlio8ewewCtctzWyblWzPWvXO6ESf/eUvxH5HnnO/gg8kKuU7Ka6xizhGmjwit
	5jZNa3VfS6All2wbhYSB2Q8Il23nH55G/2PloNrBSx+SOuttf1157cezFibm3s08
	yaUyZ3TDwodCdD3k91xPYDuywZWUpRHiL4KD8Qyeyckagbjm/tyyLZlzdOkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768942788; x=1769029188; bh=DLhcN3lhU7p1E4oJ2WAoaek4a3r8W/aX483
	EfB7P1AM=; b=LJvMgPyBg8X0B8DKcxnoaHSJdF4Bu84VJuGPbSpt/oRFlCYVn1p
	Jo0Z61lEuLwmBuuw8vrFadrwHALRZIfEvd4vefETaqiHmKlLInyph+WjHrokhR7w
	CcRUKZo3S/8QFAtjknPUhq1v2aI3WQF5g4SOJVNEi7licBvW5p2V1UQUFvOdHKnq
	aN8edSpj1pED6zb2lxe7aryuN5Y+p6+r3j6WKXsfNOtyJ60JzoRiVVP8VKZzuzoj
	non6+73awtDQZydxRx8Pwc/g1ycf3GRBEbezRLaSYmgWqEFDawQa1vnfcTB7P7Sd
	/Ts2qiLbYfnFXkIPqM+yw4qwx3N2yuAUUeQ==
X-ME-Sender: <xms:xOxvae1pQkTZbHUyxjmxBiK9r3w03A2Dw10l3Lp5gMrQrHbryo-ERg>
    <xme:xOxvaTUMvObee7Ah4Y6mtLz5eQ9MRP7lbsrHdxS3B9yoP_hz2l0qSUskZo19cprs9
    izA29UoIA02oic1Q-Rw93DKbc9VqpLJd0WD3Pbh5WmZ4hl0OHQvdg>
X-ME-Received: <xmr:xOxvaZKsKFPxnGneunQEPKZgY10XiZLRt3RDZlWvfZEn7zr47ynDqb-kg86dwoZZzFaukDAR4JLHTytwm2KPKY3HleeoX8gI-xlJ4Jg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedugeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthho
    pehsrghmohgpphhoghgrtghnihhksehtqddvrdhnvghtpdhrtghpthhtohepphhssehpkh
    hsrdhimhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohep
    jhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:xOxvaV0UpDT-1LTkTUmizgSaN10zlX5909OMTlIhILqWA45tcwZfLQ>
    <xmx:xOxvaf4NmYd_rN2jKUcN2JXRJaOvuV97TTqjTpJSsC3K3UAc4XyNsg>
    <xmx:xOxvae-IMrtQbGEiJDUQPTxIXJTjzR9nb7R-YrL6CP_NOJBhamm5dA>
    <xmx:xOxvaWVjuQ18Pi1054YcUlw0KY1YG1_HF9VwjDCTbB6xUSMmUTMWLA>
    <xmx:xOxvaS7BcAw8rqxbiuG1zNHauVxHa5FOLc9enk8MjZfCB3xi9AFtt3Tk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 15:59:47 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Samo =?utf-8?Q?Poga=C4=8Dnik?= via GitGitGadget
 <gitgitgadget@gmail.com>,
    Samo =?utf-8?Q?Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>,
    Patrick Steinhardt <ps@pks.im>,
    Taylor Blau <me@ttaylorr.com>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] shallow: set borders which are all reachable after
 clone shallow since
In-Reply-To: <xmqqh5ujuekq.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	24 Nov 2025 16:43:33 -0800")
References: <pull.2107.git.git.1763807914242.gitgitgadget@gmail.com>
	<pull.2107.v2.git.git.1763926552033.gitgitgadget@gmail.com>
	<xmqqh5ujuekq.fsf@gitster.g>
Date: Tue, 20 Jan 2026 12:59:46 -0800
Message-ID: <xmqqfr80xanx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

>> ...
>> The modified implementation of a generic shallow boundary finder
>> based on rev-list ensures that all shallow border commits are reachable
>> also after being grafted. This is achieved by inspecting all parents
>> of each initial border commit candidate. The border commit candidate
>> is set border only when all its parents wern't on the initial list of
>> candidates. Otherwise the border commit candidate is not set as border
>> however its parents that weren't on the list of candidates are set as
>> borders.
>
> It is a minor point, but there are "boundary" and "border" used more
> or less interchangeably in the proposed commit log message, and
> would make the readers wonder if there are differences (I do not
> think we use the word "border" anywhere in our documentation).  It
> is minor as we do not have such mixture in the end-user facing part
> of the documentation with this patch.
>
> I'll let those (cc'ed) who may be more familiar with, or, at least
> have more code than I have in, the shallow infrastructure to comment
> on the way the updated code uses the revision machinery.

After this exchange, the topic has been dormant for almost full two
months.  As I do not deal with shallow clones myself, even though I
understand that some folks rely on it working, I'd really prefer to
see somebody who are familiar with the underlying logic to review
this patch if we were to move forward with it.

Thanks.


