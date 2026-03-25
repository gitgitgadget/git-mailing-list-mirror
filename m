Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D3C3845B6
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 21:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774473452; cv=none; b=RbCsXcyO+MJ2+4VUHt7ukt+qaJiQmII1NTbdTyBBir2Tg5DbozWUdUrT/EolbpguNCqakq0FUQPtQ18/tU273ABZAibQMbqrcG8niadBJXPdL3iPLut0ImoopDJQTQHi2bpvnSC/HHHOLO4THpfs0scVfvfXjGgg98DshTzTXdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774473452; c=relaxed/simple;
	bh=03VgbjND21sktXbb1PR67glBvaV1F7/nrcmn32fMKhE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s08UG6PlLZwr9zd4ejgkUjwf08MPEnljJGJEoe9g1V99lp5wi1aD8Zlw1ImFGCecWeGDkHHGZrneE4079XRxhk81UmXZbKYnuzypoEFfPlXgtUbM9lcOTGrzHuYNJt6FZ3QZvpuuLLWwrZYXOWEbIl3sRQ8vGLLnds70MCoa4/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ug9i8yb0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mlVQIVL0; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ug9i8yb0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mlVQIVL0"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 6C709EC0279;
	Wed, 25 Mar 2026 17:17:29 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 25 Mar 2026 17:17:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774473449; x=1774559849; bh=esapJwgbCW
	rmerEuHcm71Jbuiun7pHBIvET/rVXzyVQ=; b=Ug9i8yb0TSAwg2HxJLrm+Lyp7x
	8F4DMnD4ElavKFKwGklLYA9EtPpbk+K8IDVhUAbxiA0zsdbwq3owYMoGvnmiCcXY
	GGk6qZo7RAr8kOu17PbOIzXjRRkR/CXHXKhtvvbbD2XllkTXPbBqW+70AqpoS6wZ
	aCQexPRQ/T+IxQWa6mgbcJdYsxa/3+z7kqLvcV1x1mq5u9Xf5h6DbVGEgPKaMOMr
	j0SfJ8YFhz80D7c6uNMlD6/RGM2tGfcp//DUX9FB4WBQP92r8AHadZon82hR7Y3F
	jKoASiSmJd7ApqIL3TMCuF6ndGM1vh6Xt8D9GPAGWH+3rQqwfbgQliAdKgDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774473449; x=1774559849; bh=esapJwgbCWrmerEuHcm71Jbuiun7pHBIvET
	/rVXzyVQ=; b=mlVQIVL0mWnYiDf6KQsqitkgg3BwF2gqykWMZz1HC5Gr27hsrwr
	rBSIbbm2I/leFZIbDNWM7GCKSh6l8EgfFSuOKXUnTJt7cjFeesy986l/Y9LUYag0
	pIfaontj2kg9cO1WkEhzqf0UGm90hCQ9R9BXwyItTHMuBxPbizlssWeriw2yKmSx
	aV9Q1q3+ekdsCFiFfzXci96e9ymi5TK8d8wu7Hg0szXPK0DNxHmwajOtcIR5NMGC
	quG4KC8/8mNRqVa8FCLUIOC+/QKxrwkR6OLD/HXrmidTcvTGzvHkv2ZMx2UGfDZb
	fFqpLMk9K7vYiHSYToN3FHhB7Pf5MOq42PA==
X-ME-Sender: <xms:6VDEadyuAxbXF2qrhMvZIgIsUGeh0YzDD3d0M1bNrHHDe4fj5pci-w>
    <xme:6VDEaQ9d7KDAxViBVb4G5Z990vGFRrru4oiu3hKq5emupknaLcHWGntoS8m4uSnoZ
    y0dq9yylyjWMu3ZcNfXe3as-VUsDnkyAbpzm1un8Jdyetfe90RBouA>
X-ME-Received: <xmr:6VDEaRJ01vRKRXh8lciJQFP65Fpy97Yn0p4u5HqvdESe-8EZekJsgWYScfCkwjcmOlrCpn1BfgueLMO_NjXLOLvyxopmpbep1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdehheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorh
    grrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegvmhhilhihshhhrghffhgvrhesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    epphhssehpkhhsrdhimhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohho
    thhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:6VDEaWcHHWyhbCxpU0g_JMNz99DwpU2uEfkP7LoHs03DGtNZj9cv-g>
    <xmx:6VDEaQ-AbKiVhONDllVNuKRxEfOpcqhvUCDlwUYO46bPNAT0xHNerQ>
    <xmx:6VDEaTofRNCaz2ohv-J779Mm0fK4-_7cjrmnpWI1-YSab9qNUvWZSw>
    <xmx:6VDEaVDejwQAcCLQ8rW7zByGtmZSv4Y1BxViok0IJBh6HFyMP63S0w>
    <xmx:6VDEaTKWGjsK73yTQa9FbpihbInMBMlMj92Q5sAb8T4Nuq3lcYnWKprO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 17:17:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Emily Shaffer <emilyshaffer@google.com>,  Patrick
 Steinhardt <ps@pks.im>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 00/12] config-hook cleanups and three small git-hook
 features
In-Reply-To: <20260325195503.1139418-1-adrian.ratiu@collabora.com> (Adrian
	Ratiu's message of "Wed, 25 Mar 2026 21:54:51 +0200")
References: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
	<20260325195503.1139418-1-adrian.ratiu@collabora.com>
Date: Wed, 25 Mar 2026 14:17:27 -0700
Message-ID: <xmqqse9nsj6g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> Hello everyone,
>
> v3 addresses all the feedback and requests received in v2, many thanks to all
> who contributed.
>
> Let's please stop adding features since this is getting rather big again. :)
> New features can be added in subsequent patches.
>
> This series is mostly for minor cleanups, bug fixes and refactorings + three
> minor feature additions to git-hook, which resulted from review discussions:
>
> 1. The ability to show the config scope (--show-scope).
> 2. The ability to show which hooks are disabled.
> 3. The ability reject unknown hook names with "--allow-unknown-hook-name" as
>    an escape hatch.
>
> The series is based on the master branch.

Replaced the old one, and then rebuilt ar/parallel-hooks on top.
Please sanity-check the latter when I later push out the result of
today's integration.

One thing I noticed a bit annoying was that we have "event_disabled"
boolean in "struct hook", plus a string-list of the same name in
"struct repository", which means "git grep event_disabled" hits
both.  Perhaps the caching "struct string_list event_disabled" can
be renamed to reflect what it is a bit better, like "disabled_events"?

