Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8941EF093
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 19:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738264729; cv=none; b=MI8oVzhc6td3zjzW8Fq0+8fVhxcAno5C6rFe8YjhwgLJhxk9mVD59AJGi4qztGEq+nFZZv/V8oyywlUdzPykDvc9DOvOl6iKrSDrS6KvwFV/c/iNHtR28y2HfRw76WkEWRo6aY0v6mcbry2S+T1Ay6LKqK/1rKp4BBDEaX92574=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738264729; c=relaxed/simple;
	bh=HYfGWIiQYA07ChR+no9rMXglnXYIytNIhzd1Gco0TKE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=euLagu030iKmpqgNEgaBboF71s6wp1lUu6AndKSsAcvviT32qcuQ3RsyzZjJoLxtyzOyzVD7q4Zv2cFRkSwtq7YqynEBz3bv4/XT4wXlLHbnSqt3vY8zTTO9Y8i4DY2gbVguwH7wGJH7elBH7wTjQ8AR8JaH2magcFNkfPh1WwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KZ2J1n93; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iijV1+AN; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KZ2J1n93";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iijV1+AN"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5996B1140092;
	Thu, 30 Jan 2025 14:18:46 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Thu, 30 Jan 2025 14:18:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738264726; x=1738351126; bh=0WNQrA++L2
	IpWSySH9uagqUvX9fY3/Pza6pEp/+Gz+A=; b=KZ2J1n93OFy6V7hymDkwCIXAMW
	5SlBxZQ5Mmfe/PoAPKxAnqqfZOfWN6ZJIo3kYfmgVgLotlJu2bVLPTU1vFGn3eOd
	3Jp/qbUbvuK7aRlMEciVOg7QbAH5CTwIdIBzTff8ABxLfdZ+0iBIuBCGaA6nGCiv
	dXkp24BXucNpguKILGZ2BuXGl7TBarSi/39sbxX6R1VcSNpsZT0jqmXkuCw87fbR
	S91gjyzDl1xTdkCBmad7cHLst98F9hTk3VSKsL+5QQ89v/wPxU7ovrgC+iYEffXg
	IoNqN6apQZCMuaUrCI1RXgm23DAN90PEaOmigDbNPpwZoqvaLG5nPpF7TJ4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738264726; x=1738351126; bh=0WNQrA++L2IpWSySH9uagqUvX9fY3/Pza6p
	Ep/+Gz+A=; b=iijV1+AN1SzbBicJ5pd2AWMsJCqFsoEebq3DYt7XA4FTGQ9j6Vm
	9zJ1Q37beji8ChY0EunPErqWaR1ZQpd7YNN9NS54NMCricR5SOH+BOG7ci/35PrF
	4PkYETo+lyhP8APF+VIQATxyX5cgCuMxA+cqMt1HL70SC3FKYoY1TrQmR0tV3XrR
	lrHOktIs2REunXK5SurQClbzW8Dv8NMypzzPI12PX961gyZkH8OJ050F+VQQqAu9
	uMNgPkj6tvMUVsQN33edNrvFLBP3Fqs04+iJtMulLE9LW9Ak0bOczEzxN8TMp9Lk
	YwHca+lC7EbW0IF+gz7xdE0nJp1/NMmI4Tw==
X-ME-Sender: <xms:ltCbZzZe7eRIkP5ubX7c_S1VBBtlObnxSbjbMLd8vSLL9wiEm-Uimg>
    <xme:ltCbZya9c7EcsPjhp6WNHkPMjiY9idDMsHmOPF8YOXX2YUzArAH-vtBMzYNk8t7-i
    yDdkxevOm6Oq2latw>
X-ME-Received: <xmr:ltCbZ18FoNT9_Pa_APrylHnvje15fN7fvnCO-OWE8DiFzlVr2fDgis6LSQyi8B38-xHDKUqPSq0TQbwZyj-pO827CQXXZ8Ru27TU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeei
    vddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehkrggrrhhtihgtrdhsihhvrghrrggrmhesghhmrghilhdrtghomhdp
    rhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ltCbZ5oPbec0tkj-KHK_AYjAx1T5z8-ccXX1eX27ZDIf1J_MqqTlzw>
    <xmx:ltCbZ-rEr6-y-1ijZ7OrirIvLFyJc_sQGRouclSs-d_fEU_y7ZQeRw>
    <xmx:ltCbZ_SvX624ZwD4dSfQpfSlITZFn06xOLkcZbNprbG8fVrDBBlXsg>
    <xmx:ltCbZ2q0YAmk5LmucevDPFFQ0u9GeOaoBPrO8im_dRNsXLVCiJ4A4Q>
    <xmx:ltCbZ7CN1PtLqeUWftHcZPwl4SwNUhEVmKCIccZ9nVlz6B8tJOcU5tT2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jan 2025 14:18:45 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,  Christian Couder
 <christian.couder@gmail.com>,  Git Mailing List <git@vger.kernel.org>
Subject: Re: Git in GSoC 2025
In-Reply-To: <Z5srHBSPKQlsuH53@pks.im> (Patrick Steinhardt's message of "Thu,
	30 Jan 2025 08:32:44 +0100")
References: <8c8e8797-8de9-4684-94a0-f6c17a592dc5@gmail.com>
	<CAP8UFD3PkyaQBLYPryePk=e54VtsQwjbyvvTsKEBFJnns_jZyg@mail.gmail.com>
	<Z44u7od-mDiKcKVZ@pks.im> <xmqqr04vzyz9.fsf@gitster.g>
	<b784f612-4b6b-414a-9742-86611c50c55f@gmail.com>
	<Z5srHBSPKQlsuH53@pks.im>
Date: Thu, 30 Jan 2025 11:18:44 -0800
Message-ID: <xmqqjzaccdpn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>     It is the responsibility of the owner of the topic to determine
>     whether it is still accurate. This check should happen close to the
>     noted best-before date and come in the form of a patch that either
>     bumps the date in case it _is_ accurate, or alternatively removes
>     the topic from the list in case it is _not_ accurate anymore.
>
>     In case the topic owner does not send such a patch, contributors
>     other than the owner are encouraged to send a patch that removes the
>     topic, putting the owner into Cc.
>
> Well... maybe it _is_ an expiration date. I dunno, I don't mind which
> exact term we use for it.

I do not mind either word, either, but I have two small issues to
raise:

 - Is each topic "owned" by some specific person?  Would an owner
   retires from the project, would the leftover bits go away with
   the owner?

 - "relevant" may be a more appropriate adjective than "accurate".
   An item in the list may still accurately expresses somebody's
   wish, but because a better alternative has been implemented in
   the meantime, the feature-wish may no longer relevant.

>>   - Fix Sign Comparison Warnings in Git's Codebase

This one I am not sure if it is even something we want more of; a
careless "-Wsign-compare" squelching often makes the resulting code
worse.

>>   - Add more builtin patterns for userdiff
>
> This one doesn't feel like a sensible addition to me as it is
> open-ended.

If you add a list of missing types of documents and curate that
list, then it can evolve over time.  Cobol may be on that list
forever, while other minor languages may come and go.

>>   - Replace a run_command*() call by direct calls to C functions
>
> This one, too.

This one, too.
