Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5454118BC3B
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 16:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772643239; cv=none; b=RAR9LfK2kwGc7Vnb7ILwdD1YkM+dBldu5j86F0/5MLy5T2UEyuDwaC1qKF2M09gVsZWYvnZHcatZFei5OdC7wHuYuyIBHaXFKnZJFogDxBB4wajIRDCE4AK6Gs99//r9flqA9DFPH+YI5f9872YISFwFR5XBdtDiI3WvkesdpXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772643239; c=relaxed/simple;
	bh=U1LZngNjKmHP+s3gLYzfb5/9iuv39FZuMmnzMGY019k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T01YMCt/RTGB6j0lIBDi4q48s9kb4rToDTSUwM+4zWJrlvvl+xyZ+bp8bStm2R9ZBDjhSyZefKom2cdcW/j6tTpm6V/cDkggbQMn86t6ZeNZsppnB2oKHOJwdXYnrGrXdJbiQtiALOvGaJl6o6DglktAqxBYX94ZB1Z/2WE2ROU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HVk+T00I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VaeNckD/; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HVk+T00I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VaeNckD/"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 5E8311D0022E;
	Wed,  4 Mar 2026 11:53:57 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 04 Mar 2026 11:53:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772643236; x=1772729636; bh=YZJ7rIz9yK
	mU9RtgIRJ/dA9ccJsURWJefQK8NMPRgn8=; b=HVk+T00IfhvoOjiHsp8Q/Cw1r7
	TagGcHdNCvxF6yScT72ybvpMHU2xto+uppnRs9gB1qpahPSATv7FrMxn2hcluBP6
	/W2Uxypr5fcpbpCXWIGsquq8Y0h4ed8m9jUnsii1Q2VaVzd1uuvB1v2sb/mMjSRC
	szX3FE3z9BUV1eTCIw5wfDZNc9aDSPV+2mggxNG/c6mIYOPm/ygjX9GWliC0713Q
	UK2LSwcnPcPfjhLBiDqbLWNqGi+a6uEAgztFIbFBY14ovx7eTajIVQAHiXRc94Mu
	huwWGtnE/2NpAOQZDjSolGJgzB9ivDxQ6GXO+gqXSY6//22dFBEfUoguIhOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772643236; x=1772729636; bh=YZJ7rIz9yKmU9RtgIRJ/dA9ccJsURWJefQK
	8NMPRgn8=; b=VaeNckD/ZWJFgY+DcmfFX511O/aK9Rx0wu7vikKS443LNKgFju4
	B3z6Dg97SUQuZENbqc6g590kE7kuK9s331Z4DaOvAQ2oRTTzhXNlfYeDTNkbyDSw
	mx8C9PnLUS3MurW3qhWQDczSKEUnq5s2GGVQbLfa0co+tRIHl97miWfWBO+TTZsL
	Qb33lecI1HRThM4c+6pTNQpf0/cPyBlmtIj9ev37FDknXtVrEsOWx94EyErs3Qp1
	dWSP1JuuRY+/1VDDKUYGD0KIFElbXD2QHPLr+mHWyVybEi5jgpkdilaEc2bEqg/a
	GrcM+K65W/pdRfXCJB24RCEn1GpagnaK/jQ==
X-ME-Sender: <xms:pGOoaViH9pTN-vOVDKhTti5ye08gbI4UyiWG-syJ0KncBbhUT3BYiw>
    <xme:pGOoaScLdEjHVsyP8YxOTYkjFUK8Q5cZs-EAkAT7t-EW0xyCOyP-3LINuf7EYlI-z
    Dm3hVwgzoKx3ipJbtSB2C4opD8ZNuA4NUTd0bfEjrwzInyk-EjyBA>
X-ME-Received: <xmr:pGOoaVg5TxmyXp3YvXyvcX8LPzHcjMumSaD4SAYN7jmJnibfttnZjhk9VlKx4On_LdA4Cuamegb5TiU8kigXwGiVqL_5dZI01w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieegtdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprgefvddtheduheefgeduieesghhmrghilhdrtghomh
    dprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrg
    hrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghs
    rdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:pGOoaaxJ1oday7LXA5aP7RyWUNcyF0kcOncaTFVdt0Zu8XtPiuhtDA>
    <xmx:pGOoaRMFLv6Q8SxczxQFudsvSmX2MokewbI_6Vrkymjc6hix5TNXeg>
    <xmx:pGOoabWxs8fhtb_OYfXbNXfTFSrqXZlHvMGVdUWEistC5w3C2OteHQ>
    <xmx:pGOoaV1M1UCEqK91AkCMHL6m9bC3vXDmbg1BhyLXNYyumuGr9yzcNQ>
    <xmx:pGOoafBBiE0B0Fvh6zuCy-v6OgTy_9ARPXz4R0wRRtSwII2d5JIKzpXv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Mar 2026 11:53:56 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <a3205153416@gmail.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  git@vger.kernel.org,
  karthik.188@gmail.com,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v11] setup: improve error diagnosis for invalid .git files
In-Reply-To: <99c6a437-3fc3-4d9a-9465-4c47a9777776@gmail.com> (Tian Yuchen's
	message of "Wed, 4 Mar 2026 19:03:05 +0800")
References: <20260222102928.377519-1-a3205153416@gmail.com>
	<20260223074410.917523-1-a3205153416@gmail.com>
	<xmqqpl5rumy0.fsf@gitster.g> <xmqqjyvu42pw.fsf@gitster.g>
	<460f00d5-97b4-4a6c-be45-6f60a17cd33e@gmail.com>
	<xmqqo6l49mrt.fsf@gitster.g>
	<99c6a437-3fc3-4d9a-9465-4c47a9777776@gmail.com>
Date: Wed, 04 Mar 2026 08:53:54 -0800
Message-ID: <xmqqfr6fa63h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <a3205153416@gmail.com> writes:

> Hi Junio and Phillip,
>
> Thanks for the detailed reply!
>
> After reading through your discussion, I believe the most crucial point is:
>
>> "We were given an invalid GIT_DIR, we are not doing
>> discovery, hence we are operating without a repository"
>
> If I understand correctly, the expected behavior should be: when a user 
> explicitly passes 'GIT_DIR=/dev/null git diff', Git should no longer 
> need to "search" or "guess" anything. Instead, if it's a trash file (or 
> something similar) rather a repository, Git should simply act as if no 
> repository exists. Is that correct?

That is one of the things.  The broken test highlighted that
GIT_DIR_EXPLICIT case needs more thought than what we have discussed
so far, but there may be other cases that we need to also think
about.  See what different cases are in the big switch statement in
setup_git_directory_gently().

> So what I'm doing next is:
>
>> All calls to read_gitfile_gently(path, NULL) need to be
>> audited and then we need to decide which ones to leave lenient, and
>> which ones are OK to tighten together with the call used during the
>> repository discovery.
>
> Will be working on it in the next few days.

Thanks.
