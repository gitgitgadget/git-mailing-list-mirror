Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8B21A2643
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 22:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748988461; cv=none; b=gH/otF4x2RXQjLu8Qm+JKXGM1xXhIfG9RrFqkFlSO+XZeqQJh9hRMtoGvdTdehxGEsEcTQM+9OzO+sieBmLVncfPHVNgmxO7818AI4RQtgHKEVbWcPTISd6vf/eBavrLPkZGIt4fbybprHeTd+QP/n3dkSjZYBKPI7pev6gTvSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748988461; c=relaxed/simple;
	bh=X8S6G3ZqefE6XBDUwYt6piYQTBdofX0pj9DmonoYPKo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aCgijosiuy3+9aF4dMCHiZLYxyXg1iYBXmYLY0IkBt3aRvQgWQsGwNyiD2CpuKudOjPOpmLv3+/frELk4exxaEyVVbdMQdPgCm9KloKJ5D1th6369mhxTFH+X1ZHHrHfLykGHhCh/Unj/NRUDk5JVuZNu4cbRJbbAXuyUxgR0Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=2H4KoA5Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rJMSPzAH; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="2H4KoA5Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rJMSPzAH"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4BB0E1140178;
	Tue,  3 Jun 2025 18:07:38 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 03 Jun 2025 18:07:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748988458; x=1749074858; bh=byXr3+/ABQ
	l6AvdlaktBvvt/uE9TSGjDATHWN10ld7M=; b=2H4KoA5QjLM0DGhD4Ak1WeF4SB
	w8LPxkROPGihxndUaDNNTnlGKjFapv1dr7DOsnPFsyJNVYUgTZnsIi2ZlXb9TRmO
	rZzKy/HkUBoAs1O2jdDVhuxajWqEvNYAQ2////fFhGlC3wu38/0+j72riQY6XU3l
	fXMm4ktEqxNFk6Pwv4WkGsWpgTYs+/y/sBKuR39YihmmCfyP3cPRVf7Tht/uSVlh
	7Tx95A4AxPZPnsShT/nn3SP8ISJgyvtmALCK7YQKgYiSqsDjKYPSvA4hr5V7NWri
	+ojPD0xDcuDgeQ7r3C1AadlBG8k4zwe1QQ3jdRn7p+YRxic2jfA93whotEqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748988458; x=1749074858; bh=byXr3+/ABQl6AvdlaktBvvt/uE9TSGjDATH
	WN10ld7M=; b=rJMSPzAHEWVEqZvWnB9YsZbGn64nJkUBVzgN6zsGu7YSJwxlIQA
	7z4jUP+Zm1qd5sJzbpgMDQWBYHwtS6/96XjtFPg9sCQ58ec9kNl1+dIJvHguB0gi
	OC7F8pZFBNci8aLvRf3pTpY8mAOi8/wWEIAOKmpfYKUGGboUcsAkvC5WLoyIWUOn
	f+7eLIUsTMUOfHpTFAoTPOBXthvN/EkaOd0si29xnchFA7sy148Z2vKO8acKfm9h
	UjYPOMMK5L/pGXIfZ2zWWgjcn9nWqRRZVmlOrkwfXZwvGA+lmQV2HAtGhoFFktMl
	JtOKwIzdNCuNkjc3qLlKQ88L1PT+r2tjBOA==
X-ME-Sender: <xms:KXI_aF9Fpiquh0bsoX09YmQrHiAipioyPJub5Ibq2MJ39SC-kYcVaw>
    <xme:KXI_aJv_qCiKPhVwVKv1LsQOvSkS1qTuhCcWAi91MhuPdWekGZaHGnMfA0c1q_66c
    jMYuOU25eJqVjoXBg>
X-ME-Received: <xmr:KXI_aDBv3imOOqvWayRxC92DHut88A5FIygpTnKfdhRRqqtpErFrj6W0Y3VfZ8Kudd1zb8bD_-wCzISYXUx9AIMveUwVejTW8WkM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfefgvdefudetudekteetveehiefgvddtjeff
    tdekfeejffeghffggfeggeeffeetnecuffhomhgrihhnpehmrghkrdguvghvnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhes
    phhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohepmhhhsehglhgrnhguihhumhdrohhrghdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepphhssehpkhhsrdhimhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtg
    homhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:KXI_aJfjvRAcRMCicpRSnfrM4OnTTRzS_ZoPT-bX6ndqAlUumXokSg>
    <xmx:KXI_aKNVy7gJ4Pq_L4nShN-pmS5atfSVj49ie_g96wks5AO9MDyz-w>
    <xmx:KXI_aLmEriqYv0_SresyWf3SyFMk1t_Ugp0sgThnhH49DBVwrbRIng>
    <xmx:KXI_aEtKtjKCf2d6Y1LKP99UCvb-nvLXAQi17y12HZ3HhQa6-oY-jQ>
    <xmx:KnI_aDEoCBeBBiS5XcLzPT8oi8CjEmDPaFufyHKTw1GeVVJ0xldiqGYi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 18:07:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mike Hommey <mh@glandium.org>
Cc: Jeff King <peff@peff.net>,  Karthik Nayak <karthik.188@gmail.com>,
  git@vger.kernel.org,  ps@pks.im,  jltobler@gmail.com,
  phillip.wood123@gmail.com
Subject: Re: [PATCH] config.mak.dev: enable -Wunreachable-code
In-Reply-To: <20250603212934.uojo22zjcuf6yfic@glandium.org> (Mike Hommey's
	message of "Wed, 4 Jun 2025 06:29:34 +0900")
References: <20250305-245-partially-atomic-ref-updates-v3-0-0c64e3052354@gmail.com>
	<20250305-245-partially-atomic-ref-updates-v3-6-0c64e3052354@gmail.com>
	<20250307195057.GA3675279@coredump.intra.peff.net>
	<xmqq34foefh8.fsf@gitster.g>
	<20250307225444.GA42758@coredump.intra.peff.net>
	<20250308032309.GA584028@coredump.intra.peff.net>
	<20250603212934.uojo22zjcuf6yfic@glandium.org>
Date: Tue, 03 Jun 2025 15:07:36 -0700
Message-ID: <xmqqh60wh42f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mike Hommey <mh@glandium.org> writes:

> There is a similar problem with this code in refs/files-backend.c:
>
> 			if (!create_ref_symlink(lock, update->new_target))
> 				continue;
>
> Where create_ref_symlink is defined as such:
>
> #ifdef NO_SYMLINK_HEAD
> #define create_ref_symlink(a, b) (-1)
> #else
> static int create_ref_symlink(struct ref_lock *lock, const char *target)
> {
> ...
> #endif
>
> And NO_SYMLINK_HEAD is defined on Windows.

Would the NOT_CONSTANT() trick we ended up using for the original
"sigfillset" thing solve your issue as well?

