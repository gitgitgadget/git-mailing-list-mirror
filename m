Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A391822422A
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 21:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757538791; cv=none; b=GwQzTVb0MF6CJtT1mnlviV7h625jYOFbbAzfuQNh+tuARb8Ex2Sr5JaYRtI74Q9SZPCxQEMfvSNXPiRFXYFHI/heVIRVa5u9hlKzN8GwhwOy04GPMdlCYJN+442Y+An6Jl5chparYkAd5gIUTun0fnaaZgsn5aUYvzUe1EaCOh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757538791; c=relaxed/simple;
	bh=+UeO4f4V+qS+jyGHxCr/ILzgjDfadpWwFCqHK/hKA3c=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=m2yTuQmLG5gaBOwVM6uduGBa1GkmdFflEyVN5z4RM5vYf1J29LkVEBg3g8wVvGwOVZvQx+MxPebJ8F5T8Ce60BaO/8JLQJJA8/rP9kpEzPZIsoNqOSg6c2bkUcbZpkM/PRhpjK38IT8ATxBhU9CZ9hsGZJu7peWABDfNzylgMXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=FcZfF1mu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LM2UqGDJ; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="FcZfF1mu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LM2UqGDJ"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id B16F71D0018D;
	Wed, 10 Sep 2025 17:13:08 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Wed, 10 Sep 2025 17:13:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757538788;
	 x=1757625188; bh=NzScJUD7T8oTHxdYdbB/crQ6NtwGnKhoxsglhnmSWRo=; b=
	FcZfF1mu5/xsisuLME+TyrbkuuLM6ZMv6XGD8j7/K8Wm37321BsqoAwpfcGpJbka
	NnBSVUSxeM84ECflih/ZT7Huve5iVYG9c03kS8+8VrvE2sBzwad597LzWLimQzXC
	8N2Cqvatg1ESWmkfPt+EBPadQZorq7pzam73TSYwecDHR5UCvPg8TfBdS3RUqb2P
	Dy53JN476rjYmrRG3kgXvJe/YoWzzBzR9kSbTvyD2bfFezb4fbEm0QC8ZGVzXyYW
	0pQ5hKksl2uEPARy0tvXaVni1aIl5axI3DNWzckp/IUqk739pVT6k91wjS8wtF8b
	XHLmX5zalYeqEO3zfLVS6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757538788; x=1757625188; bh=N
	zScJUD7T8oTHxdYdbB/crQ6NtwGnKhoxsglhnmSWRo=; b=LM2UqGDJkbQ8uvhuE
	lBTy4O2rTfEIhlyc1hPqZ3fYpjgWzMTRIFqUKt/wM89k/HNzh81G1654hx2ecunU
	zIa2oesPH9YCtL5jrxkZ2LSAH4OxR5Sn6maT7uJdabrTQoR6ug1G2cqCmBQXtM6o
	ejKNuM1S/lzr+7///ha2aLxUpX1j9it2bJJRNL0jM5zjrA6jIVNpmuqOAhae7eR+
	qybv2AEFTje638txGdryciT3ffq6M2AxvEi1vv7bBzzCLDMfn6whPmoIFsWvgQFU
	vHFmFKaWbDxyUyWgTldat5HsayptVDKrxYXVBmEiuyK3iWFu10I5mZL9VQaVDuH2
	GkhJQ==
X-ME-Sender: <xms:5OnBaO2VUSnply-5SFt6PjSTVCv8yJE4Iz22ErdfwkQDRge-EeVfKmg>
    <xme:5OnBaBHg4ehZOksCVNM-qdOAnQxiBZgsV3obubAbBTKW1OeiDLUXuXBcW7CHHLgxr
    jcnVoVvSyeD6OKWzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofggfffhvffkjghfufgtgfesthejredtre
    dttdenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhr
    ihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtf
    frrghtthgvrhhnpedvieegtdfgteeghfffteetleduveehteefkeffheehfeeihedukeev
    leevfffhjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdp
    nhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:5OnBaG5QtJuvGSmH-BIrlyQsgjBRtv7u8La65JVvjM7ZWUQflNShPg>
    <xmx:5OnBaI2QN79LhCUPkbD6K1weQKx3GeQ_1l6EDqrIaoXLrbKBghHjeQ>
    <xmx:5OnBaHYlG3yKFtfOnOw7yI2BzFDD2f2tIoy_crvHzuudOc-BSZ1p-A>
    <xmx:5OnBaACqk_MSBRner9_5cKUYo1hqEpWyzRtJMvyB5EOkBvW7ZrPidQ>
    <xmx:5OnBaEYVmCP3K1LttduUHF0QA6J-rXPRDtENALKgECPbHKa1k7Aojc4_>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4143D1EA006B; Wed, 10 Sep 2025 17:13:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AbxT4xouOep7
Date: Wed, 10 Sep 2025 23:12:24 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Message-Id: <ef86dd0f-f581-49d8-97e4-d20aed50d671@app.fastmail.com>
In-Reply-To: <xmqqwm66qauy.fsf@gitster.g>
References: <xmqqwm66qauy.fsf@gitster.g>
Subject: Re: What's cooking in git.git (Sep 2025, #04; Wed, 10)
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Sep 10, 2025, at 23:03, Junio C Hamano wrote:
> * kh/you-still-use-whatchanged-fix (2025-09-09) 7 commits
>  - BreakingChanges: remove claim about whatchanged reports
>  - whatchanged: remove not-even-shorter clause
>  - whatchanged: tell users the git-log(1) equivalent
>  - you-still-use-that??: help the user help themselves
>  - t0014: test shadowing of aliases for a sample of builtins
>  - git: allow alias-shadowing deprecated builtins
>  - git: add `deprecated` category to --list-cmds
>
>  Update "do you still use it?" message given by a command that is
>  deeply deprecated and allow us to suggest alternatives.
>
>  Will merge to 'next'?
>  source: <cover.1757446619.git.code@khaugsbakk.name>

I need to follow up on the leak that Peff found.

Thanks

-- 
Kristoffer Haugsbakk
