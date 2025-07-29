Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BAA7483
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 02:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753754750; cv=none; b=dO2QkZqE4d7osUKe2r3t17cf/tt0gAw71ggJtowXOTt0TVwWyT6JvS6Im1B9qLU8owbAANZaUeoheg5404BbcPbiycpw8DRF1rMpjZeavexyzcU/lPq1ubpPYdEfzswHqobOCgMO2tqzFlrjpGwAmpMb2zrV6h1txqkOipbtrzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753754750; c=relaxed/simple;
	bh=h0GoM1Ncy8DI5rdPDCt4mdSuesga5vxx4HRnY7nKZL8=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MlzgxtZ9S7Mtc/SHzj44bUuvk8Bq/mrJmfXmTZ4LNmlxwueMPTcUU873ULLgmy6ORfooN5QC73T1qNC8K2dmLVCZ9NNx6x3HAsQwVskH0l0n5yooQHaG8fDxjpWN7tR5LgIPlWg+2fCZZEoq0uxWUoP36DTtDFsc3cgcMLJ3d2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ExLOHpKJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PUb4mtov; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ExLOHpKJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PUb4mtov"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B4B71140011B;
	Mon, 28 Jul 2025 22:05:47 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Mon, 28 Jul 2025 22:05:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753754747; x=1753841147; bh=oqACun1vwQ
	kXl7QvPvD7QeLXtgaYlRMf43iUINXXpGo=; b=ExLOHpKJ2amajww5pQE5sNKbGG
	Q1Amb3de8tGOvol0y6x2X1laXWO9WRoXoN2vLBHgXfM2USOlxEBW7SqF+5QpzDtJ
	Z/50aveUOmI4VmMu0xHeoDFyfXmiSXjcFygDDFVQYDC38Nm8xQQAbtGCm7D/wlh3
	IKzDsO6/FIDZonUnDMSwRozV04ZR3YE6je7Hil1K2QUfxcL60XZLWVEawV/ZjgLV
	UiP6ALAog4ewBtQZ9+H6ErtNt7NVvWsv7ZVNjdFFaUjMc0x0ewf+hYgEYvwm+dRs
	AlDrqLKq/9PMNeBjK7SQ1gxE0cJl0ICvck9+CoDfj+w9EABDqCJrNETyr/7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753754747; x=1753841147; bh=oqACun1vwQkXl7QvPvD7QeLXtgaYlRMf43i
	UINXXpGo=; b=PUb4mtovUY4X4bWRMw0SpY6c84HvhHDf4bYnMOlXt9MCQ2Chipz
	zpWPpI5uNHEcb4a3xI9XBVTpEPGyaL/32f8CrpOvY6akhXPr143501MzoztOR4Oi
	AWBK+ThaCoPZ4aD/VAOEoWVSIkdRDgMp/cKEoettaLXxM1hLTBIZKmHrjuRI312q
	5Wk49C5wRT3kjM7WikRAcHLsIE1q7urYN/stB/s6tnZEncdXZ9HqZvBWncXk9VYo
	ghGDPcolove1dGGpJpsOfu9/pT312oW3wj3QHi4NmBQCI/ZKAo+FoONCVUB1srnH
	YUp5lMOptM0yrZcgntmKhVxsX+d8VuPC12Q==
X-ME-Sender: <xms:eyyIaOhDQK7YXsfLYjeMqdE03AzaR-XFIQ78HYHLQJQLNEt5kkEvMA>
    <xme:eyyIaPNPiOyvE6CJL1X_YqT6wtFGUu0sWLBXe0u5mnKLSiL5JJ-nlhChuKsiaXKYY
    M4_zAaJ1n6jaSqfDw>
X-ME-Received: <xmr:eyyIaH6lvMPtaMx_Jv9xo6RovVKPHVpPRaJwsr2ThwWBAp13XWEdW1u-DOh2Y4YHce_fDsVIArAgP0C3I-3FhJjFBv9IiSsr6_oIG7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelfeektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvufgjfhffkfgfgggtsehttdertddtre
    dtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgs
    ohigrdgtohhmqeenucggtffrrghtthgvrhhnpeffleefgfehgfejveetueefvedvhefhve
    ehgfeiheetgfdvtdekffdttddukeekheenucffohhmrghinhepghhithhhuhgsrdgtohhm
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:eyyIaF0o8JGMmxPje5AgC0DtJLy85AGvgICE7yMjRL6__YY71FBr3w>
    <xmx:eyyIaAap2GDR7Z6JR71TFV_HmcNDQa4bO09KhvCrXte97eg6Cq6P4A>
    <xmx:eyyIaFAOOMWVI-MQxn6CavHMR-ohEJO0S4DvksKqQ3o8LrmtT7Ffnw>
    <xmx:eyyIaK_vS5kKPTJs-tQi20PL-a0FEr3dQWRZclDXIjEiZKB5KrDkEg>
    <xmx:eyyIaJFTKc9piAcOVDHSVkj7XPror6pnUIsCOLkbQ6vlXCxzBkFL2Lvo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jul 2025 22:05:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2025, #08; Mon, 28)
In-Reply-To: <xmqqo6t3sqrc.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	28 Jul 2025 18:57:27 -0700")
References: <xmqqo6t3sqrc.fsf@gitster.g>
Date: Mon, 28 Jul 2025 19:05:45 -0700
Message-ID: <xmqq5xfbsqdi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> * lo/repo-info (2025-07-21) 5 commits
>  . repo: add the --format flag
>  . repo: add field layout.shallow
>  . repo: add field layout.bare
>  . repo: add the field references.format
>  . repo: declare the repo command
>
>  A new subcommand "git repo" gives users a way to grab various
>  repository characteristics.
>
>  Expecting a reroll.
>  Ejected as it seems to break CI when merged to 'seen'.
>  source: <20250722002835.33428-1-lucasseikioshiro@gmail.com>

Sorry for a false alarm.

cf. https://github.com/git/git/actions/runs/16584268807

All topics in flight including this one, when excluding the
tc/last-modified topic, seems to be fine in 'seen'.
