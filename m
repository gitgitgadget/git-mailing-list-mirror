Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9C1230BD9
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 16:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757953405; cv=none; b=IVovQzDY7f0WMawfc2bPCVg8LUpLcYoiLOSfmTEHv7kdaPT/cLV85KMZ2o7QoZRv4LkVv7ylF6ANYJBD/e20tKW1xbx6TivvXbg+JIgoRCymZQsZjwEOBlhNLCBadOwdn8M3VstPGBKhL+f7QahocPev9brAV35EVyBdU3H7MGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757953405; c=relaxed/simple;
	bh=FIIdxIFkb6iGKBbO1hvrSzsPkH9iRaAs4iGjHrArlco=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FyB8nt/cujHoR2IOP8jeno8T7ea0DIcQqrUV3RTIDQhWXpGH+eVRXelCtCQw3C6Ay4iNRMrW457dc3Rs2WzN0ndFuyRNN1GtAoqdRKATm6AQ5QCyJv+MZZUU5QnSri1Mlt/ryQES1f+SgzBns3DN+sygAgBAOE9DerXRigy+E3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qK1NrmFU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AsnTD48n; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qK1NrmFU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AsnTD48n"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5059914000E4;
	Mon, 15 Sep 2025 12:23:22 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 15 Sep 2025 12:23:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757953402; x=1758039802; bh=WukRmRSHre
	vy2mOkKhy7fsgYU+Z7JR1UKhLX9pT8+7U=; b=qK1NrmFUa0mwVK/25Y/apOuSxo
	FCWbM4h6Q16ZMvkbnBqjax1CrtlFwmHQEEo5WFyKH6jstO4s7tUQwjCeE1DKcuTq
	ThvzNh3V/BC+wLvbd6gKb9UgfKhAlqoVML66NunyMDWpWiFVM5Wo4LK1+VFvciZI
	NPFu9f7DRiq3ToLt/8rPyBCLtLtQpEIUcQURzROpuyh6CDR1dqCAryr8uoYtpDxV
	Nq6IP93wvD3Tp24zVT9sIb9OTqh+Rp9PfYMUkZuRRDb/ZgQmTjcI8qdLHZXBwaOg
	hvBNuv58wdaW6fAOXgWhzy0+hJJgFa0dkjMhRi5JztdyE9QnaDNMgNBm3Lqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757953402; x=1758039802; bh=WukRmRSHrevy2mOkKhy7fsgYU+Z7JR1UKhL
	X9pT8+7U=; b=AsnTD48nBO6ieGvjtfDaRSKQCPSGOrVYLcmlTdKJXADG5d+89h1
	gPsZTJCepmMTtVXm3+s9GIMJt08Kqh85mw80ovg3SK2GcHEPE+PkRbrC68RthnFX
	+OtQ8ERC0oDfgzbcVkcXDegN/inAueD70Z4fH4yaKUmIjMeLx4z3m+oIDAsdgXVf
	q2tkGs5e0FyQJu7aauxdMqbWnEcditXqSdrK5Cj5asYffAllRJWjRk6qhrgiy5rr
	B3yT2dn7Tutj/F6HG0UVrnjO68A9EbZrMVE6vyoBhHbRI479EnzDHYirmL09vsoT
	pHqzKOqfwrmjdY5i55chmx+KRE9gj/JChQg==
X-ME-Sender: <xms:eT3IaNJxSofx-P7QGYLncP9f5FJsGJm0UWVTwotaxr5hsRVloCcGnA>
    <xme:eT3IaJ7xAu1ZagYehKOVBvCxIYumncUfpU8o_wGDfUHhoF7ZGGgvXQztHj7Re7IUC
    79rI6HPSqQiUX30NQ>
X-ME-Received: <xmr:eT3IaB3zLOCplsyk1ampz91Poly1HVoR3Wsa8xVtujM6qhTkw1r-yORtVoVmcZ7fbKtEcd29Q2F5RGmQt7ct9_Vln1wO1-Pfnacs9X0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefkeduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghgrsghrihgvlhdrshgthhgvrhgvrhesihhnrhhirgdrfhhr
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    gsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhp
    rdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:eT3IaPcHVCh3WTXb2J9HW8lDk8n45EBOEHr1aHU-t93osN7-_avgEA>
    <xmx:eT3IaHdScTOfTz-_9opFfjGGkGn2zVP1CDo2ELLvCILrf_3cCZpy5A>
    <xmx:eT3IaKziTtrf36kXmxaSlC_K6djLn7ZLAEz9Lh9n6eOnsyYW4W45Gw>
    <xmx:eT3IaG95fIBwD4mpGfR1hdiAqtr2hQPlp3ZBBIMdf5phRo42swK-WQ>
    <xmx:ej3IaLXBtCs2sq_pEagupygnp4VpK5t9wLzXtVDThXaOHR3sAJI3tgIr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 12:23:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Gabriel Scherer <gabriel.scherer@inria.fr>,  git@vger.kernel.org,  "D.
 Ben Knoble" <ben.knoble@gmail.com>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/3] rebase: support --ignore-other-worktrees
In-Reply-To: <779ec8b7-9939-4860-bdc2-6d620ecfad24@gmail.com> (Phillip Wood's
	message of "Mon, 15 Sep 2025 11:09:48 +0100")
References: <20250913141327.2775228-1-gabriel.scherer@inria.fr>
	<20250913141327.2775228-3-gabriel.scherer@inria.fr>
	<779ec8b7-9939-4860-bdc2-6d620ecfad24@gmail.com>
Date: Mon, 15 Sep 2025 09:23:19 -0700
Message-ID: <xmqq8qifit1k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Gabriel
>
> On 13/09/2025 15:13, Gabriel Scherer wrote:
>> From: "Gabriel.Scherer" <gabriel.scherer@inria.fr>
>> rebase can currently fail if the branch to rebase is checked out in
>> another worktree, and there is no way for users to override this
>> error. We add support for the '--ignore-other-worktrees' option of
>> 'checkout'.
>
> I'm not sure we want to be encouraging users to rebase a branch that
> is already checked out in another worktree. Unlike the checkout case
> where they maybe just reading the code and not updating the branch,
> rebase will update the branch which is going to be confusing. We
> could, perhaps, add a hint suggesting that if they are making
> experimental changes, they might want to rebase a detached HEAD
> instead with
>
>     git rebase <upstream> <branch>^0
>
> but I'm not sure if that is helpful or if using a detached HEAD will
> just confuse users.

The risk of confusion is real in a workflow like this.  Hinting them
to go to that existing worktree that is used to checkout that branch
and rebasing it there might be less risky.

But stepping back a bit, if the user reader wants to rebase the
branch in this worktree, instead of in the other worktree, is
because they has uncommitted changes in the worktree that already
checks out the branch, the branch may not even be ready to be
rebased?

Thanks.
