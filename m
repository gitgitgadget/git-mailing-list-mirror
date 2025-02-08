Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1DB1F3BAF
	for <git@vger.kernel.org>; Sat,  8 Feb 2025 21:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739051671; cv=none; b=Nt/5TtxaqlucL7J+aheezfuc3jyN6WnVgnLrqgeVlUU1s7E3xHjYPy+3QjfX0Pot/IbrNdwIIJxbc6CNCEKJCOhXAhWptasA0QExBGtZG0XCyBahJEOf+9rATQ6cEdSR22+w/YlxE5q8TJMM/rhhjBCa3DrS4cYd636W561JmJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739051671; c=relaxed/simple;
	bh=sOQDfgXZ+Hbex7jBH0tTTdzwLTbJUyPbIUFkRkx2mQQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O5avJ6m8oxBt9Tr8op6c+2rhgbRHQtA21ZCjs33fjTfpmATOJfxDx89hLGtiFL7DE4rLQ4OZes8mHnDoIR6id7uY2Gwge4+3NlRLtTT4W57lQU9P3WiZNkQ0dzr/QixtpFm84rsA8thEg4cdcKRjPdHAc3HqFCeW/VQMA3JGvvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=c2/nwYGL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=feTBUOyJ; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="c2/nwYGL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="feTBUOyJ"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9C8942540103;
	Sat,  8 Feb 2025 16:54:28 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Sat, 08 Feb 2025 16:54:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739051668; x=1739138068; bh=m1i0yQNfhL
	HaYCvaVLvoYFaF2y6OoowNM/wnnLbZiCo=; b=c2/nwYGLX1ELVQFcHouBfZQWdB
	Sv9tg0dGvdQT0Nmg9q0tyDysMMxjrftCJ2Rsfq03m0xEpnGbeBIaxhsHoUXjA1Ji
	LKu31E5S0tdbaa9VQr93H62Jg0M/GKkqAfFxnN8Zx+LUxKtzqxuCnh3PaphKzQ/q
	CLZ8P9oHfwlVo8/mx6Gksr5bLirdj04c2DVyokxBFploOdRPDmTR9VjnbjkswoXO
	TJEw35MAgkgyxUFlXn6YL+CfilKlG/zvJkFQyS3teSDydDn2HqX4b7xIr+jx9oay
	89A4+iVldD8qBljf7gQdHFtAopyYQ6xZrmnqxvHq0XsvtX0lUrwdOM2SCEww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739051668; x=1739138068; bh=m1i0yQNfhLHaYCvaVLvoYFaF2y6OoowNM/w
	nnLbZiCo=; b=feTBUOyJiB2V8nZ+/T4vZRIi4trX88U1qYrmNBV01gqLYQPcViK
	W0JVxzmk7ogi7962P+oy7/48m1Zr9k5FVTubh1tpzQFKAX/2sfAVAVM8pc7k1WCf
	smHdbhK5j6azLExLgkJb0ur3u6il8RJaK4ozKza1ZS/DiXLQvBv2eVU0HbT5WOOA
	R8r2yKjj6iWfh64J8f1lZI/pE5EjWdkmZaSssNuLCFLzzpd7btTuirnMXyjqagBc
	j4EqGxUIyz/ox8Vxmgwjy2IHbiLOSYy1dPxUp6G/gaflZJB+kQzHnDtoifya1nDR
	9cADcfAWmjzGiRCzt8tb6sBgPXNlvIHMmMQ==
X-ME-Sender: <xms:lNKnZ9kljt9M8VAAVOoZKbJKWNJInpKue1ZgzfQUYxWYo0C_3t41Rg>
    <xme:lNKnZ40viT8WcRyuK3zh7RADLFiJOaUJ9b5CX7oVCCKZbuE6X8zHizoXBchShUlBt
    dPrlvp_GiIbMAlLCw>
X-ME-Received: <xmr:lNKnZzpFfmHga9Ml5xa1gvLN0_GM-4PxSteymTg9nBjua0_AFt1RDnBdY5cwbiaGkkczfBOk6FaT4gw8dQWz0AIY-7ljkZwA0COr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeffeefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfef
    iedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehstghhfigrsgeslh
    hinhhugidqmheikehkrdhorhhgpdhrtghpthhtohepuggvvhhsthgvmhgrihhlsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:lNKnZ9kBUVclyHjEWX9TqhrjpZ1Fl8txZOFS61gvqiPTK9sb-5MMoA>
    <xmx:lNKnZ72DdhMUVIFLWugdIELRd2xpxtjfNa4wyUTyj_gm_BB5AGZ9Kg>
    <xmx:lNKnZ8uB9JxhKPX4GLsdbK2Qp42bbUTwQMzUclXf0x6n_vtQ77sN9w>
    <xmx:lNKnZ_U2eaRTVkMHBnHE1o9BWYbaeZ8wEwqf1Xu6sYNm37wHqsDkWg>
    <xmx:lNKnZ2TPHO5ytY3EQjdPAIJKvL3tGMxL5XshXRafE0t9ECc2eo0ZjBuD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 8 Feb 2025 16:54:27 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Devste Devste <devstemail@gmail.com>,  git@vger.kernel.org
Subject: Re: Config timezone to prevent chaos when DST/changing timezone
In-Reply-To: <87seooss2u.fsf@linux-m68k.org> (Andreas Schwab's message of
	"Sat, 08 Feb 2025 10:28:57 +0100")
References: <CANM0SV3DXQeNinmy1Spj7n6G=5s3jMcFrAb0Ayun6ago7F3qWw@mail.gmail.com>
	<87seooss2u.fsf@linux-m68k.org>
Date: Sat, 08 Feb 2025 13:54:26 -0800
Message-ID: <xmqqfrkodrvx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andreas Schwab <schwab@linux-m68k.org> writes:

> On Feb 07 2025, Devste Devste wrote:
>
>> With DST or manual timezone changes (e.g. travelling) you can end up
>> with commits that are illogically sorted - newer commits have an
>> author/committer date that is older than older commits.
>
> The time stamps in commits are recorded in Universal Time, so neither
> DST nor timezone changes (both are essentially equivalent) have an
> influence on how the time stamp is interpreted as a point in time.

The commits will be sorted correctly according to time, regardless
of the recorded timezone.  Thanks for pointing it out.
