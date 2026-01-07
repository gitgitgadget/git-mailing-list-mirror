Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02C72D29B7
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 03:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767757893; cv=none; b=HapX4DZwzfbXQAWKtH990XMWa4tj2xZWf3whTdqIqRTK/OqblULoPgj5xcdfk3R1xf9CphRNFMVtIPeOlDna22qdZvxG0tvULZ9ejFP8a7CtZB8mYh4qncgfAcLUhJ9UsbfbwWj6BD5yqEFy8BQ28BRN6O7iVhjnre85/S7xfd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767757893; c=relaxed/simple;
	bh=mIrIkloxzNFBmmcH5dPH5V0XGiZtxwSNZTSmWxnltxA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VOnalPqyc4PwgKylsqF3QoB/ePF6A1FEes4xp1CR8ECME9E764aAdXIOIzc9JKgDdc7BWWGzRhtmdkQBiKEb0wseW4m5YjlULULO4cb5vSjDtx/WfG74rYyCL1cPA112PhNGDiDVIeoNzcQdW8ehNH2kSywviJsXW+O3SAYsgc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ipEUN7QG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sNDl0/nY; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ipEUN7QG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sNDl0/nY"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EAA5B7A0079;
	Tue,  6 Jan 2026 22:51:29 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 06 Jan 2026 22:51:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1767757888; x=1767844288; bh=mGr/ACIqoT
	PSkJAMm16yiKQeSwKhjEuaVjV1NjCWLVk=; b=ipEUN7QGTB+9nDSLu+mAxeFQJO
	zkUrgJNtkz58rglEgSN8SMNU0eSdg4wwDfQPuQFp6Dr9tnixm+K0irVkVj+YvEnK
	7tuxgdAq9XlXKbzVYs9LuwI6JI+65IxNtqvSDWnaw6/UbD4rUD+onk9hHK6l4GRW
	9EBM0U7V3dlblFVr7Z0Nk6e7wHVq6WwXTjAz+iqqb0FQP/dvRISY/O4vwITJwXjh
	mgcg2YsXya9TSeGeJosrIVZR/fD60ecRxdLTJO7VQC97VvH6ebfEwDlaKUcYacIr
	nPBwwehGyvNLrzZxA5KR5plbAxRm1aiB7uf36ux9McdqQ8TIy/hUEGXz2j1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767757888; x=1767844288; bh=mGr/ACIqoTPSkJAMm16yiKQeSwKhjEuaVjV
	1NjCWLVk=; b=sNDl0/nYxeFx4VaqXHXkRxSOAYj1zed3zofTMsapHwkrNyT8kgM
	4ueKM/FZwslKmhlgVgisY8BrcZzzaeATgCKp5AYp+n6I/AKhOOmqP77/rCE0+30h
	RgYkKxiWoue3wSNMxHpS4MQEvWV0ZhhwXhmEkVA7nzaL+3uU+l5SPcBW8eAXfCLa
	bvXgn6HpotkCfXI0x3TdPcd8vN0FxqMnVUwFEer7IQsVTeG8T83I5YkE6zF5e89r
	sVkX5/C3V6wgZs8u/EKuJzB4AttBSVwwYc29Fm/e3/IBd8+hITaCw7ScfwzPBDGk
	k7wMSUHbfjyY74G5OJTvq3reveQ8j1cnA5g==
X-ME-Sender: <xms:QNhdabkpvqG8CpVCU-cyD_MbEjc5TVtNBMg4ooaRKXtrUqotQeN2Xw>
    <xme:QNhdaSg7cZMeGiAb7lGaHyurtBIXcGaFqZrQNQWvRCKnMsmLCUeoO88Z33ggGSAsB
    VcJvz3EKYkDTNfB69xhSGOzZywsBvlz4PyboIhAKu1WWBz0WNA9Rg>
X-ME-Received: <xmr:QNhdabd6_wN7FuaVEdlnXSx1Zyd4ZqjJs7llI9itQJ2_TZcPrqadysDr_G-HmMidYUlg7ijcwHIwtor9o2Sh49zPv9ZElOtNhaIl31Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddvtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
    dprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:QNhdaagZqfLwir_8ZLQo789qaI_Wm6ojYH1kdyCWniW8id-k-UaK3g>
    <xmx:QNhdabyrYvwzr36kBkiXxLL30_CdTiEPArGnJRUCABaAkzzLurjQJg>
    <xmx:QNhdaeMlzgTfkeOg_9-E1SvahpzKpPlgwFvCXE2M27LVBX1rAjjBnQ>
    <xmx:QNhdaUWKHBeaVAyJZ36CivAWAxyC3qIMKbBPpncAaZjD8hYvglj29Q>
    <xmx:QNhdacruTtpV5y2mS33HERrTvgRe7jjuxPm7aqWgKYuabf6OiTDnGnu_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 22:51:28 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Justin Tobler
 <jltobler@gmail.com>,  Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 0/2] Some random object database related fixes
In-Reply-To: <CAOLa=ZT8_vij=2TU3GNZSST0N8Oj1CmaOd0ZzBcp32N8Aze0WQ@mail.gmail.com>
	(Karthik Nayak's message of "Tue, 6 Jan 2026 08:30:16 -0800")
References: <20251205-odb-related-fixes-v1-0-ef4250abb584@pks.im>
	<20260106-odb-related-fixes-v3-0-7ac157207b20@pks.im>
	<CAOLa=ZT8_vij=2TU3GNZSST0N8Oj1CmaOd0ZzBcp32N8Aze0WQ@mail.gmail.com>
Date: Wed, 07 Jan 2026 12:51:26 +0900
Message-ID: <xmqqo6n6hygx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> base-commit: 2797238193944b52d12624a04a962f40b9bcad69
>> change-id: 20251205-odb-related-fixes-5f48a0993ef7
>
> The changes in this version looks good to me! :)

Thanks, both.  Let's mark it for 'next'.
