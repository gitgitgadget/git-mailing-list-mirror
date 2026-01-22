Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C543E37474F
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 17:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769102468; cv=none; b=pyPYErGZQ/Oe0zfjN0xL5aIxpN/bSFu2QAO8MrSzrMs6o3O3jnMLoilruEjDMVXVdRAWmpZRVeLX5Oi6Pbbz9MWxH8kfBliYCqGuUQUl5bxQjlhuVtv8oozuwldTpLu+BAEJxDka+m25RO5OsjoESSzJnF78DsDM6j+BqD5TG/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769102468; c=relaxed/simple;
	bh=zw8eb1eR9vvivIdzEDOidEASkgCEZnw8Z5bd/OnYOok=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bj5bgOnYv06pY96MCGxwedQUWQwy10vAllAczyQ7RV36LAd/qJBGDiyJQqg7ISu3rFOpstdrCz+BiwzZggYem4kP+tnPVTCZOmD+dY1TnV1e1KTrn2jCmc/5Xja5cFRWZmzI+bjPYc2GqQ+WsWmxzQTah9VP/WwgENjBb7fnW8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HtaOHpSs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dKX47cjm; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HtaOHpSs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dKX47cjm"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7F2831400197;
	Thu, 22 Jan 2026 12:21:01 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 22 Jan 2026 12:21:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769102461; x=1769188861; bh=6FMQxNLsE+
	1nvnyGkX6mYmRZrwzr9Hi0HRr6Z/Ips74=; b=HtaOHpSsJCLvTVwmo0hhNoWF80
	2Xedj2mfk2SHu3eVxZ4yNZgczmxUM1ZNhZTHlqa7gItA4Kr2SkQQ7e/PLglfHuh+
	X93dD3bn0k3ata5xyz4xjMREAbQF77F9VXVDBfT2Um4e7S1xRJwVEcwb60Xsn58b
	Ay+yiKtPow3f350Qp2tADlrXYUjSVL2fmMYbNHyqq0SPWVQV252MBeRZ4sNEMypE
	vBTvCeR6PsDCFjLLStYv1H1eg8zFiPP3NamlWz6l4112JMxm8WnWDgO/ZHkJKDZr
	znC4eMdX3pG6hrlaAm3XJ31XMKHZud5M9kohXBb+FcEUMlMoYhwqqq+fTw5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769102461; x=1769188861; bh=6FMQxNLsE+1nvnyGkX6mYmRZrwzr9Hi0HRr
	6Z/Ips74=; b=dKX47cjm1EXtya/j4yKeXf2XGPfHh43O9BDoWRPKRmGI7Ibn255
	JUFwM3BvQIn0Tl9u+XcmCN8jCtIcTuSiZgi7h/+SNpQSZfsytMt7XBZZKRX5mokB
	EEDPF5wtYzeTeNqssAkSLCyHRNaB//AI0Vu6VrySc/n89h+Y/QRvG07By8cwu0up
	VDrRWsmo/fwrrG54gorCQdL+PtQY+eL6FdJ93zHRs12OiUuDog7qAS2QVwEu7uYt
	4RAATjSshVpCToFDaD4scftPLNbnrzYz54Di69YERoPCiGtAY/Rdp2tfNzjz5sFV
	9+TcfRfF0u7auWr5mox6OzGggMXg4QQhNVQ==
X-ME-Sender: <xms:fVxyab_dgUogKnRqiT-jvhgqu27Abfl-XDdYeR50k-S-WSr5joYbxg>
    <xme:fVxyaWz_AQOomUo9Kjx0i2Dfmtq-CPmU3-s7d3E9fUVhdlJMCQ3udv1RibbkCyfp-
    AVM6JBCRbIKTFv9AosnfnaqT9Gn0I-XTHAp9y8lTGZwiXz4QF_rBA>
X-ME-Received: <xmr:fVxyafOGccaEBitSjcpFAONphP73vi63jtmzlIRRYBln53RkaBFdFnw76oMHb8BADyAfJ1fa9Cel_hjXSiOxX86-wCH3inDkXxzNiNs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeeijeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorh
    grrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepvghmihhlhihshhgrfh
    hfvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghp
    thhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:fVxyaT_lgRQOSHb96kKQiqWn41JLhzCY-TvRB0ZthZxLtnqLUUoGOA>
    <xmx:fVxyaU7El49Mzva4ZO6bIx5-3lLpaCbUEep8CQkBDfjBxWeFCUcodg>
    <xmx:fVxyaR6nnPosniMJzBkOZthumt7iJBKiS1MhVEwdY1bz7W_0oqh3Rg>
    <xmx:fVxyaVpsQwmmOffXIAEqOUQfzLfD1d0PZZ5DYIwTuLRVRCGt7Jg3tA>
    <xmx:fVxyaXjuG4pyhi9pQtzNyY1HgeXAV-hwU8YjYUaBtL_d4XahaXCb6mv2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Jan 2026 12:21:00 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Emily Shaffer
 <emilyshaffer@google.com>,  Patrick Steinhardt <ps@pks.im>,  Josh Steadmon
 <steadmon@google.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v7 10/12] run-command: poll child stdin in addition to
 stdout
In-Reply-To: <877bt9rk0f.fsf@collabora.com> (Adrian Ratiu's message of "Thu,
	22 Jan 2026 12:58:56 +0200")
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
	<20260121215436.1473800-1-adrian.ratiu@collabora.com>
	<20260121215436.1473800-11-adrian.ratiu@collabora.com>
	<xmqqzf66pnmz.fsf@gitster.g> <877bt9rk0f.fsf@collabora.com>
Date: Thu, 22 Jan 2026 09:20:59 -0800
Message-ID: <xmqqv7gto96s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> Yes, it is odd and it's a weirdness of the run-command.c child fd
> handling logic where .in, .out and .err are initialized to 0.
>
> Patrick raised this up as well in one of the previous patches, however
> reworking run-command to not use 0 sentinel values for fd's is quite the
> big unrelated patch (I gave up after spending about 1.5 days on it at
> the time).

Thanks.  I didn't realize that this was already discussed.

> Maybe one day we can also fix this weird aspect of the run-command API.

At least a comment somewhere would be sufficient to avoid others
waste (your) time like I just did, wondering why fd=0 is special,
even they know that it is unlikely to get fd=0 from a fresh new
open()/dup() etc. in our codebase.

Thanks.
