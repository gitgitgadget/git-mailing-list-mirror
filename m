Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A498314B8F
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 18:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774463664; cv=none; b=M6HVJDBISwsxHgMAqqXAkUkGxFqLFWoyAdaQ7Dq6CMBdAzbQ4IzwzAcNtw/rrAvBgDzU5o+UD3I6GL3V8ewRLF/Q1QJU3VqOgl9+QVyI2FfYo985gqZgAgDM2AF379KoUC69W2WDv/JK5XhIfGzhp7ewHZtuaJu/tnUb1gQVVzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774463664; c=relaxed/simple;
	bh=k0We7F814zAKWh+5jsTGvDuIzpRxa2s+Tp4w2tOVoTc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hWjA1yPuD4XPRnzeUyz3mWJGsmLkbUZDZZFWlOubVykOQbrIzAsRoFoEqOJ5TkiATXjQqaT0wff1FugLBsSY6OWQuXlrCBDBVEmKAScfTAgAojiG05R/R3G/1vTM0ebYlf+LAFrwf427z168t97q4IFA5M/I1Y6RkuykX/rdExE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GycuiqpN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EAt/4I+d; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GycuiqpN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EAt/4I+d"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BC68B14002AB;
	Wed, 25 Mar 2026 14:34:22 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 25 Mar 2026 14:34:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774463662; x=1774550062; bh=k0We7F814z
	AKWh+5jsTGvDuIzpRxa2s+Tp4w2tOVoTc=; b=GycuiqpNRJINW6Q5+Vc/8sLD5E
	v4IZB7Hlgem1Uh31Q7kZ2Hw+85qt7g6GLDUu6p/7irGlIpi7HJ+KPx0ndXxj0JTZ
	pGuaDI6qXscaegsUkGMku32+tLKdZR1GmX83P8QCPVGhMogIzD/vM8OuAJR9kmk7
	BzjDcqSkjf7LvJiNujj9KdGrMmePTiLl12L3tt/9/dIBeFt9bWKN396pX+3Chj88
	U/74UoyYJ2bV5QlicsgfOMyusS0cQrAjK/sQcc1vYgLH+XuXlxLxndPse1q2kIwr
	RzS/i3KEg5c6y50zroFvMEQPeWr4eeNlSVAGrYPAKDGYtENYX5MUW64nmhzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774463662; x=1774550062; bh=k0We7F814zAKWh+5jsTGvDuIzpRxa2s+Tp4
	w2tOVoTc=; b=EAt/4I+dokJh1Wx3Z9nAfoZWMkdCK+Zh7EJU4V0PPlWg8goVCRr
	ouRL+crctZwHZQOQOvIMBR04M41hXxO/IRPyMr8CTQwzfks/PfbhlrOHVTfY3pOA
	S1NY7yIHZJ8n4iMNfjvVwVaL+NV++eNZCiyhLb2JBqSqEaeIq4S4UzEAthY5sgTX
	/TxAtwMX6TT0+srV//msH5D2/XNIOMikAt7OmIobjQMad+F1lUIeTp9CyW4yXlnz
	Pq9XjFsZxD+famW0IaxlqotHktycKjPvY8lGnanOfQcKu2z6NYO9bMQnig3/TNpQ
	N8P/rzTloEyU9tXyQ/GGFV+Usn47l2/l7RQ==
X-ME-Sender: <xms:rirEaerelM-QFbCiICPd5OnC6PpFs3oRlSdkMuAgAYOHpiJNSLyTdg>
    <xme:rirEaQVn0oW6YfP30haG_zZZwQJ2QwXBkpgHoZPdc8b0t2SWZ0xD2dvUlyTZqbxiW
    E-Nq8KWMNuiyfuuN8FLOs-opDOh5OkSCh_EJa-4dqWviMNgfq3WuPU>
X-ME-Received: <xmr:rirEadC1g5rr3jtz2y25cpxGxh0lsZfPHKYDnPazIzWpDTCp9lV-QlxIOnu-QiU2twwhyAKXEffVQhePWP8R4vW-2YXk_aO6bQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdehudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgv
    rhesghhmrghilhdrtghomhdprhgtphhtthhopehsihguughhrghrthhhrghsthhhrghnrg
    efudesghhmrghilhdrtghomhdprhgtphhtthhopeihvggvtghhvghnghdrtghhihhnsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:rirEaU25Gv9XmVyiftNCbtId-zxDlC7joqol1iR6df0p6GOTK_DBqg>
    <xmx:rirEaf3iTaDW0m85cxeAp3t8H9tS4hkCD4Puxmd8JgNOKETJ9dA8pA>
    <xmx:rirEaZAShXHKUPFxtW3upp--crPFNDYRgdOe2zR4BOG3gJSUnx11LA>
    <xmx:rirEae69Hu8ZUQGK_2E4ySVYkKvM3EHe3rItKe-SVwuFsvGwx7PndQ>
    <xmx:rirEaXup9DYiWPzrFBq6p37istJRzfVfd76Uf_X1gGlATOkzckK4qZkH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 14:34:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Justin Tobler <jltobler@gmail.com>,  Siddharth
 Asthana <siddharthasthana31@gmail.com>,  Yee Cheng Chin
 <yeecheng.chin@gmail.com>
Subject: Re: [PATCH v2 0/3] Add option --ref to git-replay(1)
In-Reply-To: <20260325-toon-replay-arbitrary-ref-v2-0-553038702c9c@iotcl.com>
	(Toon Claes's message of "Wed, 25 Mar 2026 16:59:28 +0100")
References: <20260323-toon-replay-arbitrary-ref-v1-0-5c7172f675ec@iotcl.com>
	<20260325-toon-replay-arbitrary-ref-v2-0-553038702c9c@iotcl.com>
Date: Wed, 25 Mar 2026 11:34:20 -0700
Message-ID: <xmqq8qbfvjv7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> In a previous RFC[1] I suggested to implement subcommands into
> git-replay(1). While it would be arguable nice to have subcommands for
> the different modes, because git-replay(1) is a plumbing commands, it's
> fine to keep a status quo.
>
> This series takes one thing for that RFC though: adding option --ref.
> This new option is useful if you want to have full control over which
> ref is being updated, and not want to rely on the refs that are using
> in the <revision-range> or as the value for --advance and --revert.
>
> These changes answer the needs expressed in[2].
>
> This series is based on Siddharth's series[3] to add '--revert' to
> git-replay(1) (sa/replay-revert @ ba5c0d03d3).

Which unfortunately got updated just 20 hours ago X-<.

Will try to wriggle it in, but please double check when I push the
integration result of today.

