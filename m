Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EF428D83E
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 16:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761927423; cv=none; b=JoLAvR9+OkVx0BzO7VQOGvJDiiITpc6hPK2bziR7x9EgRMb6eSMwzrW5fLT5xsdMJ3OnWo0tVocBmsB62qSmm3wpXADaKu0rpZhwzLaVV1VTn76+7NQ9nchZKRzOlC/ZrwuoRfnD49uCx+/w4uV50cwjvcANS0zFu9CFDuDj8rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761927423; c=relaxed/simple;
	bh=4Y5lD8KPmibR3oUD/Th4x1nO2bPaaXgashLHzUCP2pU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JggUYsNiNfPwPbjnk/Y+4kqMY+xtzLhmQNNbBm6cSkjtNDQtmc1jtnzrbN+3k2sJlk0BxRp9saLObUrjn1C0ZZKwfWnVIFhI+c6C2Ph6tbwgrSOiWfvKcUw7lbcRyebBCXx+22fhKlcuiaEfGzbpNVqM/NmEvp6KQ6ROm9Cy8Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Mflf9+Pi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=niqLfrGw; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Mflf9+Pi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="niqLfrGw"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3B9647A0158;
	Fri, 31 Oct 2025 12:17:00 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 31 Oct 2025 12:17:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761927420; x=1762013820; bh=82F0D0Biel
	NRi63+fEKnTWZhriswFJqTeGkcJqTGN8M=; b=Mflf9+Pi7pupx0GIXY8qt5p6uY
	8LZI2aqiuFD0nWMbBL30uJyR2bAMB1nk89yK0Yo8sSP25pOj2Ap1zTM+DB8PRO2N
	vmasz4LCZgazjixN/urP34i+UuYuuPV2GosSs+tgNLFjhcSIjhXon1i4CB9POOOt
	zVzlo7PzOJ0nC+MrHeaIp9X2oSvtm56JqNd4Rk5fj6o6SWATTUouYt3y++foK5ec
	6/P0n9IChNbPejkl8p1gulNjfXpzOfBn2eYTBEaoElnzLyZ71Kj53FyYZlhneRK0
	6iYXVp26DJ5HKLn7iDrOfOvKXtwJOmuQ0ZTdTfDXiO5XMoR/W9zlglV0W4nA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761927420; x=1762013820; bh=82F0D0BielNRi63+fEKnTWZhriswFJqTeGk
	cJqTGN8M=; b=niqLfrGwuhMfMNHYRtyrPJAvXZWoH0PFp1XfHrZVGaONyzz1n+s
	cCAqKzlacQQoN6JIltBZ3ccHrkMQISZOz5zHRaBPwfb4f1/QGCF/W+zxIZ0WaQAU
	XMESbgCSjFJBsZEYVeDiuAjEN2Z/eRWXLpnhDfkWxo2FQBFNcR69jSaf4+xJ91mW
	UdMyLQKTwdUG+BQhPGyFY55VewA3I0IQE+ja7iKW8om5mYsfJ6PvIGoruu567gG5
	rPkqcbcj270fRnB9MFOb+ZxsdxeWoar4rVKig7HizurvbhHfwQXThgjvfYGv/cwf
	AXLIDd/1XK3zH4ROY9DI1vlGaxHDftPc6nA==
X-ME-Sender: <xms:--AEadfpvrOsPofVoyA2gipw5rIRWdVBkNfa3W2RZGmEO57RH5oE6w>
    <xme:--AEaSN7w3UJPZD3KfUM7NcxLp43BB_KYUQIdTg3a5fAfJpJZlDokTrAAYS4C-ugy
    2-NW3V3bKovtEwhzKlofS6AN7J5HZT67g3M--BrOLNCBLIYr3xFig>
X-ME-Received: <xmr:--AEabjtChHZM4HJv7D08R9lZTgcIEX8kcegkWNED7v6sY_Guj0u3Fz8jhFZo4WovScfw35lc3slVwrNfNGmBEu78mklD23IxS_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieelleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehkrghrth
    hhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:--AEaV2V-qH1x76ia5IIJSRr6aBFpEfWIOQjU0FkQHuSWW_Vh1PAPQ>
    <xmx:--AEaVhc4B701a0G7b_Kr4OQdsjZw8jUVuLBROXjcwVKV5AbUx8-hQ>
    <xmx:--AEaVevNHhHqdvIVw3HTOJWZaG2sDqj0y41TEO3aL-qA8uIC4g52A>
    <xmx:--AEaYnlFSIsxTx7dwkdSFNZYB-WPEtbF2f68j8FomJmDzMG88FgRA>
    <xmx:_OAEafBpwxy9Eh4A2c3WQSj2IcGPHB8rS4ejgyt_8nLTwjaKkSX2AZIP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Oct 2025 12:16:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 05/13] object-file: introduce `struct odb_loose_source`
In-Reply-To: <aQRS-KcNLD9prRYa@pks.im> (Patrick Steinhardt's message of "Fri,
	31 Oct 2025 07:11:04 +0100")
References: <20251024-b4-pks-odb-loose-backend-v1-0-1a4202273c38@pks.im>
	<20251024-b4-pks-odb-loose-backend-v1-5-1a4202273c38@pks.im>
	<CAOLa=ZQdit7N0aQWyqYHAoO6nuXaU3QqZbQmsbp52jW8C-zbzA@mail.gmail.com>
	<aQNMwve9sUP-QDN6@pks.im> <aQRS-KcNLD9prRYa@pks.im>
Date: Fri, 31 Oct 2025 09:16:58 -0700
Message-ID: <xmqqwm4b11xh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> Hm, I see your point. I think that "loose source" flows a bit more
>> natural, but I agree that the above is more accessible in code.
>> 
>> Before I change this: does anybody else have an opinion here?
>
> I think for now I'll stick to the current naming. This is due to two
> reasons:

Ah, I should have scanned my mailbox down to the end before starting
to respond.

>
>   - As said, I think this flows more naturally in language. When talking
>     about this you'll say "I'm using the files source" or "I'm using the
>     whatever source".

I do not happen to agree with this, although my preference is minor.

>   - It somewhat matches the naming we have in the reference backends,
>     where we have `struct reftable_backend` and `struct files_backend`.

loose_source (without odb) may mirror calling "ref backend that uses
files" files_backend, because "ref" is redundant in the context of
talking about ref backends.  "odb" is redundant when talking about
odb sources.  But we are not calling them loose_odb_source,
hbase_odb_source, etc. and instead saying "odb_loose_source", which
I find is a bit strange order.

> That being said I don't feel very strong about this.

Neither do I.

