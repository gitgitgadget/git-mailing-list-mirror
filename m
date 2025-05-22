Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFE225FA26
	for <git@vger.kernel.org>; Thu, 22 May 2025 22:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747951453; cv=none; b=cCh0ucdyFMLpQ4mecAIGTKimzez5RQ7M69nXNeiGysyV4i8rJd0ojoliSgGkGmFZNM/sT/WBzVNul9gtgMniHYZecyhgec1WkeiDUVUt/dpyrW38jt24ZLsG1nRF7yydB+omrLfxbOtP+ISEnNtFF9Yy1g1RFEeXLGYzRWvbKLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747951453; c=relaxed/simple;
	bh=BIWwI1yozkm2dDMGFkfXjLeI+2YBYvXw4Sg2BBOU0cc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g/o1fOZ43N811ZPcx9rvP1CsoYXPUpswHNKGZZ1p5EbJzaQr/pI+duZnNr47LelOOuEzSQZSivWCvkNSnByumWHe23myRi0qTyHxj50joI7wKShx2OArLlY+FfRfb9CQxe7CLTtittS9LHHvhukX6uDb/SjYck2XAdwE85u0iCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=P6aLsBQo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=agpoaXMW; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="P6aLsBQo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="agpoaXMW"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6191B2540105;
	Thu, 22 May 2025 18:04:09 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 22 May 2025 18:04:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747951449; x=1748037849; bh=gYaMERS16W
	XPMZNtAC6/rUv2fKT/qr17lWMkJcgI8AM=; b=P6aLsBQoEAxmgr84eFE2fWarMX
	3C3wFAVsCR9QtnaKD7e+SrpdloNFRXJSjCPiupfaXE/L8CapghcMEWEU2Bm1PjrW
	3+Yik9PyQ99/AttD0n5lr6E9pgsWeMe8/zg3nZ8I35dJMUgu+qoqnIbIO5sHrANC
	LKb4QUUqO5E0cnaC2kaEGKLkP6GgKkqPBOH94huXkzNwIhvKym6gE+yZKYUnT2gF
	MqiDjAE0pAlZPNNJ8usGV+NtdpM032pDtJ0JshImVVu7zvZ9ITsTBgr0oWnJf8jz
	zHbI0zxpK991btW+vyuMkrh7/nlqNhgor515qVaZ9dl94GC8zBIntQp0RU2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747951449; x=1748037849; bh=gYaMERS16WXPMZNtAC6/rUv2fKT/qr17lWM
	kJcgI8AM=; b=agpoaXMWnTSIR7rnaFiLS5MBYlBCGU4lcN++uQrwFgCACEFYxJK
	vEfpfnwP2mnHFr/oNfGfOpdClx6LchPhQMSoliFTuq7LGp+ZobTHejmpzeTZR8P6
	4a9bcx02aE+WjZzl6RqbKMJ1ZyuHGMzdy5Zx99TMV3ddid820Tz6lGh2xufxbbUN
	/9j5gneUzqzLRisj9d0CKNhMzChzwjemf1P7AqHM+WYpqXXTr9BWIEQJaYpbq2TZ
	FqM9Y5Loia9lyUBVK1WgUpcKB26sG9rH4iJXBG0sdU5BDavGHVmA23LCl0FejTfI
	Cc6w+YgvN+ZlsoRLc2R7S7TmVR/L1oAk//g==
X-ME-Sender: <xms:WZ8vaNoTZVANAxFn1OXVY9mDu659Rlha7BzjJf5NqR_S5jLAo1Wn0Q>
    <xme:WZ8vaPprzavNHb1TbnCNw_-5Zg_8oZizJhck3Ua3kZJdFMMahGud0HeN-BmRfTtOM
    8BySrvweOlAXlhM7A>
X-ME-Received: <xmr:WZ8vaKPtUQOa8oJZ2Ab6cbN1hTalZmMZ0OlIG5KGpAOmX8dnng3_1vdpkxAu-Oi94DO80Ro_qtQ-lgKypfAnuz8aJRVPh21KhzhtS4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdejudduucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceogh
    hithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeeh
    ueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosgho
    gidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepjhgrtghosgdrvgdrkhgvlhhlvghrsehinhhtvghlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjrggtohgsrdhkvg
    hllhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:WZ8vaI4MirY1ou7XG01Vyy-37D8cjyBF1oRhBLGwoCkqbgqsnaXeDg>
    <xmx:WZ8vaM6wOrMge6Xxx0csnTFFzaxwUfvre8LLhK52cS0I7pD0xw39EQ>
    <xmx:WZ8vaAj4pC00oko2CC-qIj8PjHS4ISMFKu-O7pf4NIzRH7P5V4L7Jw>
    <xmx:WZ8vaO5cErDU1L8JyOhNiPubcsLYOqAruIBV1u2v2vGuScRykAH4-w>
    <xmx:WZ8vaE0MnorUWp74l94T0k3C9donLXszWskKqFLlwO9156EBA4QVVbT2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 May 2025 18:04:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: <git@vger.kernel.org>,  Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v4 0/3] diff: add pathspec support to --no-index
In-Reply-To: <4d0366fa-3584-4d6d-810e-855b9ec23121@intel.com> (Jacob Keller's
	message of "Thu, 22 May 2025 14:50:04 -0700")
References: <20250521232917.2333291-1-jacob.e.keller@intel.com>
	<xmqqzff42uod.fsf@gitster.g>
	<4d0366fa-3584-4d6d-810e-855b9ec23121@intel.com>
Date: Thu, 22 May 2025 15:04:07 -0700
Message-ID: <xmqqv7ps2tgo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jacob Keller <jacob.e.keller@intel.com> writes:

>> Nice.  I kept the previous iteration out of 'seen' primarily because
>> it seemed to break the tests (even though it passed standalone).
>> Let me see how well we do with this iteration.
>> 
>> Will queue.  Thanks.
>
> The tests all passed for me on their own, but maybe something is flaky?

Do not recall the details, but it is possible there were some
interactions with topics in flight.  I am in the middle of day's
second integration cycles, so we'll see how it goes soon.
