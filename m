Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25E220E6E2
	for <git@vger.kernel.org>; Fri, 24 Apr 2026 22:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777069284; cv=none; b=E3lbxSgByBrtk8wqNom2QllJdLX8LSo7/+qOgoOYO+uKWKfMth8WBScTgSvu+rEux/9zESIsv/dS/RLrB2JmoZOR/qFnDa83yTBnS80yDCuObwfzfYF+abZQV06SiDFlIVitM6/7pbaqOkcE+6/80u/XY+ybk0lLqV3ZxMEqynk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777069284; c=relaxed/simple;
	bh=1YkIXODcSlwBpOgiVcFxbO9wEIPMFQJEDuro6r7rgMg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TfZ/98osc3OAN5CqQp8iYf7Q0kDc0TCsLddsIRAVrgIWifA6Ye7ecLeVIRJU1HKwhH+Xg/0/nAOtG03p+yB+kN9g0l+XoxkBwrLlytSd7hV+jJrnnJDSUW6wUJ8TlUDE+WPRLem24B0NSTX5fbLiFNqc923GCON2AniIAD4kpv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AqzSqc3o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DILE7lxl; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AqzSqc3o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DILE7lxl"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 08D8DEC0588;
	Fri, 24 Apr 2026 18:21:22 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 24 Apr 2026 18:21:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1777069282; x=1777155682; bh=zL2qaEjyzy
	2ncNVkAja7UaFBj9P1ooBGjqXlBEtKGt0=; b=AqzSqc3o4Y8eNW7jjvQoumJcr2
	1S55YlBkiQ38MzNHreEFdDHzVLBnuLINCD91Ca6DOMJLKGGBW7XEIon3D79qQmqk
	UbSxrzBagxSqy7vLEPU1PUmxf2Da4bTYhMdppJIyx5YqbN1m7djMTxjwFy8cq9wA
	xyvHfTrokZKx+T55rZTn07XRj6lav05u87/cqQyyALb0oLoVjIXP7x3FbbBINpxJ
	gtnAe+LG6d0+I1INfKCu9v3ScHwfZrs0iQkPUC+mveQAXcFORZv+mrzk1OYy5GQI
	Q5VSnY7BFgZmfFfeBSkyHAi3OnC7pplYfyzyYt9SBsno3MgNEBipc1mpQCnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1777069282; x=1777155682; bh=zL2qaEjyzy2ncNVkAja7UaFBj9P1ooBGjqX
	lBEtKGt0=; b=DILE7lxlYaQISKxuX7JAk5kPF9E1HgkNqQOj59HHLdThuJXYapw
	mfAKiMsDWoHePr075Yz+tYRFEGy+oPytyfVU3f79Cs5OUh/zmx3BoIZG7Gbu5XkB
	DXctUa77uGPbo+Vf8vUKeHpLWtgwanVuN4satTQ7x/Xb3wAOvbn+v2lzeQ4JwbZ6
	PS9Q26OcWYXPhgQIT33FdaK3O7ZiLh8oIY+3VuDwUqvpK3zGTPnPopR+FQMZDX42
	ZSOJa6c2U3dQZElivE8zzKsPuy2tT7vYm+2zY2A6m085haMK8LIxsYbOzWVChfx2
	pm6c5uO+e0g/HMmI2DA3SGU40bWRIT/mHxQ==
X-ME-Sender: <xms:4ezraTVLprn04oqiugh81L-5ssNPvM9BKbrWA1Llg_6gkBsGqn5aMw>
    <xme:4ezraSlkaiG6z5bP95RtG6J9_lozAXN4CnPLkopvswujBPxT9CxQl1bJmp0VOuoPq
    YV74hI592G-8D3RrrqF4V0TeqlrLw6H8e4t0E4JqV59rjgc4OdiEA>
X-ME-Received: <xmr:4ezraUaJ_yHUn5Z_TDlGUwLlUcJYFvP8mVMdTSa4d6Ho-Bw-iGYZHKrwf783urPDvW_D2FcBYt5xrZ2JV3KiUPa94YS3z1-Y6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejuddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    hhgrrhgrlhgunhhorhgughhrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:4ezradNkyiiyesnihmbW6wTddpuqKJGxB-QAurdjWiV6T4gdkdIn2A>
    <xmx:4ezraZa1h86f_daKPLOadLJxK18e1M37VbXuNxpbtLd3YauQVXlLsw>
    <xmx:4ezrab1iy6V4Ya_l-OK-aJjw-9rzbm1HQ2ygVT7hzJ4ECA6nE5WAfw>
    <xmx:4ezraffrdcbpbpL7kvWtrilsOEGExOw8TMA_WvVs4-ReUMzZwmooHA>
    <xmx:4uzraf7C6gKO36mkgjghhqInD11Slgpefi8eduMly6QTaRwjTNs_dKhO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Apr 2026 18:21:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH] checkout: add --fetch to fetch remote before resolving
 start-point
In-Reply-To: <pull.2281.git.git.1777024991531.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Fri, 24 Apr 2026 10:03:11
	+0000")
References: <pull.2281.git.git.1777024991531.gitgitgadget@gmail.com>
Date: Sat, 25 Apr 2026 07:21:20 +0900
Message-ID: <xmqqeck4xan3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> Add a --fetch option to git checkout and git switch, plus a
> checkout.autoFetch config to enable it by default. When set and the
> start-point argument names a configured remote (either bare, like
> "origin", or prefixed, like "origin/foo"), fetch that remote before
> resolving the ref. Aborts the checkout if the fetch fails.
>
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---

It is true that "checkout" does funny things to special case the
remote-tracking branches, like setting up the branch.<name>.merge
configuration or even inferring the name of the local branch to be
created.  

But I have to say that this one, especially the configuration
variable, goes way too far.  The usual uses of remote-tracking
branch names, e.g.,

    git log -1 origin/master
    git grep frotz origin/master
    git rev-list --count origin/maint..origin/master

to name a specific object all assume and rely on the stability of
them.  Should the configuration cause a fetch to happen before any
of these uses of remote-tracking branches for consistency?
