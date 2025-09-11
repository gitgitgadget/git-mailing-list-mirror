Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5598350D53
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 16:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757608196; cv=none; b=HATfpQdktcqp+PjeAKYdM20nesczbNoC2sJ14FfgsCj7j0yNPnTPsew/Gl5cvVO5fwM4YClS/6s4wbu3pAUB3eBRQX8bamLNRBcVcrsb8V5l1M5PVXW9XgceKqiQCQuxj5OqYNUvFHb3IhKJQKQSQZV1CPtQ2izlkDg7tPbpZEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757608196; c=relaxed/simple;
	bh=3ObGAAc+8ujEzU7+3NHeEFbzDHtC+/+n2LS7Wy96Gpk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WtQVUyl0n7TsNQ5/Ib/OHnu34cCkvr+TTSiSni5abkAL6l9jMjS1LeAJyDIexpQku+Xe+Fa/rkMUE0Qyc8ttdnECUahGmXWSRMotSsjHtzCEZ3beZvHOOVHZ8t3aZ4Usfa+TmL/1sS9mzgxNsbN1lrLn5ic5iGY09Ub0S52vsJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YsGiMjhu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mMxyv1uj; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YsGiMjhu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mMxyv1uj"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 9F6641D00408;
	Thu, 11 Sep 2025 12:29:53 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 11 Sep 2025 12:29:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757608193; x=1757694593; bh=Sp9aIS77K/
	2bcLEpKaNYA1RtRxtuZoPVmfiBU/7GSWk=; b=YsGiMjhuf2e8jTCwTp+APNGSsy
	38FDpr3tinqi4SZ05cqIuSTO1IHQ09Z0Zhl8+6V/M1lbH66Om+gZSlQG9+ZjDZ3K
	JvJFWWZ0cV1y7RiG8e64qiKDLo7CJqJnh6hRI8SSmTfTbr98ducXQiKj50DcsR0j
	GqTV5hvjr8IOKyLBipduifxnzCWIB1DUQ10DyYqrDq5pu/obzaqgCe3AWeoqF1KP
	ANjDuKlk8Bh6NQoFD0d0ELZmzOCObppb0tAjNRaogwJP58R03G7lCo/zgP5UncS9
	hKUdPLdFJYhZ40YGKIzA9PqdZN0Hna9zbl4w7ZtsuHflYg8t3i7tBbtlugmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757608193; x=1757694593; bh=Sp9aIS77K/2bcLEpKaNYA1RtRxtuZoPVmfi
	BU/7GSWk=; b=mMxyv1ujNY2w/LwZNpW7KLeS4RIyHw4IcCDL+xGpTHgt+Rimxhm
	DKABFALt0TH/53Ea7aepyo3WznFD8ha2krm1ZNTJRbxh9PRsIvUiB/U3pR1oBUft
	iIpfbycWrIknpmlJVP1Ue39SUW0+vxU5ltDs0kEcp9ltvk5/9hjWwPaM9qTooV4S
	Mhh6OQTTK4dRV/9ryrKzdCXWYS+Jrh4jUpesSDrNCdwAwXq25y4GqDhxc0chX3S6
	luLf+HYfNLHvJ2UDP+kjO73ZYDZRG4Sk4vPn8PzC7ojg94+u7zsPIzlwWgmWCCY2
	KqnRUBS5eJ7GVkfx7vJTBgBM7B/0FtczEjg==
X-ME-Sender: <xms:AfnCaIoRnzsKTvmYUeSfalj17bwvwQaTCaJQ36ZbJNtCQEtMp2_uag>
    <xme:AfnCaLhI0qq_yKmhUmh9ZiYuMVm0iZi7C0QNREtK-9dLpLRB_UcYAHQ1FdZJsMqSR
    rfee47zc1lmtPBQwQ>
X-ME-Received: <xmr:AfnCaM_7ClDpPz6GgeT_97D8DRYPCAhBV2P0uQTRQfMTHbSQebpgUNpqWjiPnsKuEXUeI7sE-P6C7QujXKkwtBqGX-BwJbfMWBSJmEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvieeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoheptghhrhhish
    htihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshgrnhgu
    rghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepjhhohh
    grnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtoheptghhrhhi
    shgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:AfnCaPVgPRm9nJTah67TYH4QH2ghZF97uzBa6RThrqBwQ-7pHuN8tA>
    <xmx:AfnCaIAcvM1PjBYLDNmb8odfEU8jaTCJzaDBnPP_pRjHtGZroUjZ5g>
    <xmx:AfnCaMEeuqn4nCWG2dyXbYUDMQTLVWz0lSJ1rx18zBYcqOfNlppe1A>
    <xmx:AfnCaB5lmKvl8HFPf9vwqneu1_vRgICtVedLb4l-nNO7p7ls5H9pCQ>
    <xmx:AfnCaMl2IKa2XzbS7asCjcb5VJEy8o_BU8k6edZMD2vNv5gxC5jiinSM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Sep 2025 12:29:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Christian Couder <christian.couder@gmail.com>,  git@vger.kernel.org,
  Elijah Newren <newren@gmail.com>,  Jeff King <peff@peff.net>,  "brian m .
 carlson" <sandals@crustytoothpaste.net>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/2] gpg-interface: refactor 'enum sign_mode' parsing
In-Reply-To: <aMJm57VmWb3h167z@pks.im> (Patrick Steinhardt's message of "Thu,
	11 Sep 2025 08:06:31 +0200")
References: <20250910080839.2142651-1-christian.couder@gmail.com>
	<20250910080839.2142651-2-christian.couder@gmail.com>
	<aMJm57VmWb3h167z@pks.im>
Date: Thu, 11 Sep 2025 09:29:51 -0700
Message-ID: <xmqqcy7xosu8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> +	if (!parse_sign_mode(arg, val))
>> +		return 0;
>> +
>> +	return error("Unknown %s mode: %s", opt->long_name, arg);
>
> Would it make sense to maybe reverse the error handling and say
> something like:
>
>     if (parse_sign_mode(arg, val) < 0)
>         return error("Unknown %s mode: %s", opt->long_name, arg);
>
>     return 0;
>
> That reads a bit more natural to me at least.

I also thought that the original had a "Huh?" factor, but my
reaction was more like "wouldn't it be easier to see if these are
both sides of if/else?", i.e.

	if (parse_sign_mode(...))
		return error(...);
	else
		return 0;

which made me think that the differences were mostly subjective and
refrained from commenting.

But after I see your version, I tend to agree that it is easier to
see the flow if the most-straightforward success case ran through to
the end, while exceptional cases (i.e. an error return, or the
initial "unset" case) did early returns.  I have to add, however,
that I feel that this is mostly subjective and falls into "once it
is in the tree, it's not really worth the patch noise to go and fix
it up" category.  If we will have v2 of this series, I do prefer to
see it written more in your way, though.

Thanks.

