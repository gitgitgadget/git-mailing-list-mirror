Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186A73603EC
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 22:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772231872; cv=none; b=t3ZIzEW0Bj3tfmBe8iyx7B0AqUNqE3eQjKBul6Y6irHd706e5/i4YIIEKEBIZzIOT7LBqT1K3BA4CfVuqLGUuA8cv9qVr7v4JSmfJGo9jWd1sec4zRtJA5DVTt60ODd9n2a15LJcrXla3IUKHVmdteutDcIZRzAp4COoc0G1tqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772231872; c=relaxed/simple;
	bh=xOANeNXcDERRHM2Dbl1RVXFiIuFmdxUnrk7iuALjS8E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HUwqxc+dl+BQqQHtfXdeP57zQAG78RqogGohvy92uGYg7wzzbFvHUzDpeDSxH5LpFG51kyjXC0P6afbCLjC4tbcP+JEk3NmtYui4LUGX2E8m61G0j44xQ3VMe1UPJaFcd2wSWektfV8eHghr/CvFxRcl//2gquk08H0mv2YZMCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=uBK28tTX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jaqyjCWx; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="uBK28tTX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jaqyjCWx"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4ED2A7A0123;
	Fri, 27 Feb 2026 17:37:50 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 27 Feb 2026 17:37:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772231870; x=1772318270; bh=R5+L/xb5T5
	M8THTWbZAiPmTD5zbyI4SXETYHki62c2o=; b=uBK28tTXyyUIRTGrin2E0HA1Pa
	ZNcIFBXBxc6TqD3m4PJcm/ZtqHFMhXblE3N0UsVT1f/YUUrzuvv2wqBG640mZ904
	ZPOivgdCoCymH5Zwr5ebGu9i5UKKlcE+Hfn9YrO/qw2OuLs6UCre9UsisZNbAHzg
	mIFLugddy5dlMlpKLb/7IxnYWnGVWY1EgZhWduVJ8YrDvPXMc+FdahPY/lIScbWF
	gTovZC73FCchAgtOhIfs9Io8il5/Q+DQiaIe/tlcyb0HfGpiE4JJWYLKpFuBRqgH
	I7uqO1BITN30+4In2OgmWM6LbI2SnUUdC9Q0Pc7OugUTgmsP7UJx9lXWRc2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772231870; x=1772318270; bh=R5+L/xb5T5M8THTWbZAiPmTD5zbyI4SXETY
	Hki62c2o=; b=jaqyjCWxgPGoZjObxHXfDAWcB7I5Vo9txk0KQUeEJrKH9OKVzvK
	Ch3hcEscwOl9qd9zLudPNgFD+p0kS4yobgqUXMzKAIdL3ui3TvcLjU9MeUSfloqW
	5I4L5FE6yrRvZRPZ8x11e5pAKN98fvQFncjkdwTOCKuBiZo0AqAkl7uRXPmhM8aL
	qmXl84/EOnNIlYdO69wNbuzWeyfINnSaH2fx0ZTLzABIlnQcI2aabrA9h0X0g3cs
	AQiXzoH3+1j1BTWA3Dg0Joz93CazB5u8kL/kS7sb4/r7kXSAl4LDkZh17mbdNlTS
	0vrSFDmdy4ccuvW33bwqMyS+de9jCiq/5Bg==
X-ME-Sender: <xms:vhyiaR8eQP46C2H_7EaqJerE9-GCNj3wFdFD9IXW0rKf38JdkFP4CQ>
    <xme:vhyiacttH-bp6d0TQlV4fWVDJvPejW1DqEcU42mkt3l2lxWeT9a3kn_pz9tBxCmiW
    FB2ELrYAu5ZZ8Es7Kdjij0lTM7wex17CVHGQgkiErgqGybApb32DA>
X-ME-Received: <xmr:vhyiaUAvFOdDgh5_WgRoPG9AkZgSZX8d9uaJUjinFWCMeG3mwdCi13IOQSRTOLzJyKyLAFwjZdrYS6Zf-liLJUxNMNKAlrPInw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvhedtvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurhhonhgr
    rhgrjhhghigrfigrlhhisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggv
    rhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:vhyiaUWsK27gNsaOb4G2jx3T99mPH5bHZ5bVGqhWMs41jdXMN6Ln0g>
    <xmx:vhyiaSCNO3gQtl0IL2D5-z2XvHH8zRI3KjTZ2N62A7Oo0rK052RfOw>
    <xmx:vhyiaX8kPNp5qTTXUk1hidr3JLU9PWHKI5cfyu-3PKkKJZaG8Mdk-Q>
    <xmx:vhyiaZG3ZEN2RMBUqWqwlo6fO72cY779ZEUWIPxb-e_jry576OhY6Q>
    <xmx:vhyiaXjl0htTL7Fs9v7EYMkxPCRXiu15uSScdTPDEMqYJKJZaLXmghnx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Feb 2026 17:37:49 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: drona <dronarajgyawali@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com
Subject: Re: [PATCH] repo-settings: move warn_on_object_refname_ambiguity to
 repo_settings
In-Reply-To: <20260227125654.249676-1-dronarajgyawali@gmail.com> (drona's
	message of "Fri, 27 Feb 2026 18:41:52 +0545")
References: <20260227125654.249676-1-dronarajgyawali@gmail.com>
Date: Fri, 27 Feb 2026 14:37:48 -0800
Message-ID: <xmqqtsv1ols3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

drona <dronarajgyawali@gmail.com> writes:

> From: Dorna Raj Gyawali <dronarajgyawali@gmail.com>
>
> This flag (default: true) controls whether warnings are printed when
> disambiguating object names that match multiple refname prefixes.
> Move it from a global variable in environment.c to struct repo_settings
> to reduce global state.

I am not sure why this needs to be per-repository, though.  It is
very understandable if this were a per-user preference coming from
the ~/.gitconfig file, and then it makes a lot more sense to keep it
a process-wide global.

>  builtin/cat-file.c     |  6 +++---
>  builtin/pack-objects.c |  6 +++---
>  environment.c          |  1 -
>  environment.h          |  1 -
>  object-name.c          |  2 +-
>  repo-settings.c        | 10 ++++++++++
>  repo-settings.h        |  7 ++++++-
>  revision.c             |  6 +++---
>  submodule.c            |  6 +++---
>  9 files changed, 29 insertions(+), 16 deletions(-)

Even in a distant future where these files are used to implement a
long running multi-user multi-repository "git server", we would
probably want to create a per-user structure that holds personal
preference items and throw this variable in there, not in the
per-repository repo_settings struct.

So,... I dunno.
