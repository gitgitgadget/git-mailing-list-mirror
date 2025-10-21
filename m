Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AB234E747
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 18:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761072810; cv=none; b=TpA5L7yVBFyXSfMxXovvD104GaPinTdpJZgWCu2xx0eSNLniuYNAIMMuefnQToC5+jDVkmwQzOUT1z6wj407mG7p+i3XU2zmjcIXGmof/G7rs55zCj7NKGXidABL9AqainBuoK/Fm5uxrPnJ9r47gk5E2WiPmYRLDjEK9QJTS14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761072810; c=relaxed/simple;
	bh=jtoYDiDX3PxRG/bjxI9a3QWwbTErFYes+/LH0dBMiz0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QU7GNblOwEUX35cwWmdj8NXLsWgF9/mTu3OWrSmgd31OLj6zwJcQQk+HoYquEqlcP82pQhlhMHtG/aHncMFGYsr+ZKkNaCG+7avnZK7jqK4IVvEVP+Mmu52c4tkenv8L2DHsFzBuCfXYhNdUP5+TnxpH0ZljsYV+Qcm+PdWH/kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=H7+inwXk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k85RIf69; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="H7+inwXk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k85RIf69"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6027C7A0124;
	Tue, 21 Oct 2025 14:53:27 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 21 Oct 2025 14:53:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761072807; x=1761159207; bh=u1hmoNg16o
	ZeL/qLC68BU2bB5chleURsyoIbMLrw7KE=; b=H7+inwXkCRPc3TWEpUBrEcgYch
	8HhNJq2wNbzoZryhphA4uJWItEYffc46Q9ICM1crnmLJCwihGZrjD1xmz31KQ1FD
	JLsl6VxjiY3cKSBRZMP/vVPrfUcYLUSNi2v/h45GFyJsIaRaFoxwD5vKmqdk7cgJ
	7ZQJS9cPxqL1+TOE7PTcbZu412dmxQmUg1zLZt//9/OBxW07h8eoGkEQ87gfcsQw
	lLAksqISEpVXD0B3U10qp06Er/N7OWsQ5cmalqeiFR8ysIHRspvjWHflWC2TP+3w
	HlD5LDwCRSRQpczho09GK88vQ6FEFM+jyrY8PvV9uqLSLOVSXSslCWnrdd5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761072807; x=1761159207; bh=u1hmoNg16oZeL/qLC68BU2bB5chleURsyoI
	bMLrw7KE=; b=k85RIf69ClTJA8F1lS6xqWa2Y+qLkCiev6qqORwQUKj9BOos+YG
	5WVplhORtZQk93l2vN8pDptqmIrXFV/yTlv4pnK7U1RSVQdXQdPqPxA2PT0SAg9n
	wwUB8znp2RP+vErG0tZ2jBytgMtlow2wVvdcUNR4NhbEcO7fRPkYMgjxgaQBd8yw
	4flnmpz26nv/Bs62Z2prbIwE1HXQy0mghv2fG5zdGT9XWQnRmH8aZgLMxWRkC9Cs
	RcTZxoTUrI84vM3Kq8S+OfTqD0KxKznAdn+CW4KojyvzgZbdikSLeXpt9yVu69q9
	dsRbUSJdetFqIP9/4ta3ZXkuxr6d934IWxg==
X-ME-Sender: <xms:p9b3aFJloyzjNA6S7IBMAroIk1bEUXFDEax1qK96OL0LPTtJCUeRHw>
    <xme:p9b3aNu2_cmhdYXrYNVbFJhMeJ4NmzV-qQ0rEhvv4uBl32dtmQKDY1ud7wwA04RcM
    AhzATsGQyCmN8e0a9iqlNvAJZuiOB_VYkZqlDW-349fKWye0RytlQ>
X-ME-Received: <xmr:p9b3aCLW2eKuZj30y-vB8g7FRvNAkKsisRwLQEYtDOzOhG_w6ZgR4Oi_c26NrV0CFfYTLq3jmY-QShtP3e0GvzDddAIgmQeCrRkf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedugeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnrdhknhhosghlvges
    ghhmrghilhdrtghomhdprhgtphhtthhopehsohhrghgrnhhovhesghhmrghilhdrtghomh
    dprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehmrghr
    thhinhhvohhniiesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrh
    hhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgv
    nhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrih
    hlrdgtohhm
X-ME-Proxy: <xmx:p9b3aNO572Ar36jCdI0A0u7za8JCn-e35CZTRg_nkDTZBw52QdCPwQ>
    <xmx:p9b3aNWIp0tCI1PSJFQHlWgO1t1bXUQVfdzIMIiMog7RQI7DQxWGWA>
    <xmx:p9b3aDkYo25scK03X_Mpf6TPhgCeu4TbgGJyuxXs1kThjjs8zTAdog>
    <xmx:p9b3aEPvgPkH4N5JMZgcVSLu6XymJpfbgWFxAKjSI3F5n1ioBIcRLA>
    <xmx:p9b3aPZ8bCHQ8Ea_7Gsje-BH20eXHXDun0DwrB0z6f4yI-bHFHhVjJNg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 14:53:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Sergey
 Organov <sorganov@gmail.com>,  =?utf-8?Q?Jean-No=C3=ABl?= AVILA
 <jn.avila@free.fr>,  Martin
 von Zweigbergk <martinvonz@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Elijah Newren <newren@gmail.com>,
  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v5 00/12] Introduce git-history(1) command for easy
 history editing
In-Reply-To: <20251021-b4-pks-history-builtin-v5-0-78d23f578fe6@pks.im>
	(Patrick Steinhardt's message of "Tue, 21 Oct 2025 16:15:48 +0200")
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
	<20251021-b4-pks-history-builtin-v5-0-78d23f578fe6@pks.im>
Date: Tue, 21 Oct 2025 11:53:25 -0700
Message-ID: <xmqqh5vsulwa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> A copule of these features relate to history editing. Most importantly,
> I really dig the following commands:
>
>   - jj-abandon(1) to drop a specific commit from your history.
>
>   - jj-absorb(1) to take some changes and automatically apply them to
>     commits in your history that last modified the respective hunks.
>
>   - jj-split(1) to split a commit into two.
>
>   - jj-new(1) to insert a new commit after or before a specific other
>     commit.
>
> Not all of these commands can be ported directly into Git. jj-new(1) for
> example doesn't really make a ton of sense for us, I'd claim. But some
> of these commands _do_ make sense.
>
> This patch series is a starting point for such a command. I've
> significantly slimmed it down from the first couple revisions now
> following the discussions at the Contributor's Summit yesterday. This
> was my intent anyway, as I already mentioned on the last iteration.

Will replace.  The other topic this depends on seems to be almost
ready, hopefully, and the part this series depends on should not
change much, even though what is remaining may be a bit more than
finding where to squash the tip "SQUASH" fixup in.

Thanks.

