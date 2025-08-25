Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC362FE58F
	for <git@vger.kernel.org>; Mon, 25 Aug 2025 15:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756137567; cv=none; b=QRUovHgofAl3Y0QZBPVFtfpen4NR488h/UPOhvzKz77aovs/pkZTdUsSq5O69kTP+/1LOfZKDceX6NWxrkBAi6LCN6bSxwRDf/sEh2NPHHPdZyZA40TYybACLIZWUMir8sUaojclwf6Txy7cjD6pdZLRArkPBXtl/He03MNJmq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756137567; c=relaxed/simple;
	bh=ZDdF23FY4rIP1RbsjZc/ANItYg9zU3oBismOpT0OXrs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q7c3Xiikc8dueMwYW9LNkMJctlPqT1wp0kTz9FSgyolekeYj10R/sTtkvXui49bAbrNxRlkIs6DXHV/39ALzaKqmlVEC2mbE6TP7gayntQiWeUBBiaqm80pmNRQxJpEohK4YGunmgTkgKfThcfbrYEzXj/oaauejWfb+JxN6SOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GfkUQAxn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RWiRMKgJ; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GfkUQAxn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RWiRMKgJ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 116F61D000F4;
	Mon, 25 Aug 2025 11:59:24 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 25 Aug 2025 11:59:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1756137563; x=1756223963; bh=7FEvXFSrCz
	UmaWgUwRAObIgmRdTEwcoh7W3fHekw3V4=; b=GfkUQAxnPVV5KI605QUMsiCJph
	1zYF353YEkqk28N3JpZpblVQbObR5Yis40rhDk6Q3S+00B+1ToEF0NzXN+uRBoem
	U4wO9c6qtA/6HoFs9PkuczehttRy3u3Or9NZWhBdBoXq6/IWakaRtSyUeRGhBGFC
	PGezPWe/wupWk2RVtyMGTTX23FM95lTAkhx9p27zWuTYaMyyCbUjs0QfIEMUzBxw
	Q1P+kOFEJLRbGFWpfg5ikuOHgUcwXdp7QqqtkjlshgEJch6sFyafEad0AxgHGA2s
	+4Ib7fEAFhJsf5wZ4cwoUEt7KZM+rTkwauQ/z4b94oulf7fwJ9r3Yv2K1SOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1756137563; x=1756223963; bh=7FEvXFSrCzUmaWgUwRAObIgmRdTEwcoh7W3
	fHekw3V4=; b=RWiRMKgJfDHqGfxzoM3KmEIjMCoMYL2Rvi3C2UsqSPNCUMEOMA9
	F01BuTK07gLJHrecuelYup9kGjkmWy2ig6iFGqPFQPJ5+hrvH/Prczketif3LrcQ
	7BQtVAvpR74jWDNaSuf9wStBLtWgLhRLEMsYjhuJVRiSgx74SWL19/QRaof2oVcJ
	D07EusbXnwEEE+2gxOZUVWhw63toU0kNRsXoewcyFp+wttRD1EeWrBZoUvwvRGUf
	Qa+lp/+p3DYrqw7Q718jynXyIXdD4wFVD+6GfRRJahzYy8XpupKNpwvSHbXhg2De
	p96kFHqaHwKesIwXMxFr9upxt7YYByvrsQA==
X-ME-Sender: <xms:W4isaHQk76VmT8pb89yAd3auWnyRh4v3fZ0uDUviGi-K9ODoj-j0Bg>
    <xme:W4isaERQlVdHo_DpRKD9tQKxTiK61Nr-mfcfBU07T0XL8uPIXRuMrqFeGhglIz-UA
    Iy7Z4ijqWqhccLThA>
X-ME-Received: <xmr:W4isaDRvAe1cAVyxR4wo7LtwTBOyrRHiwi4XK9IueA9SNVKf4bcPT8B3ZRb5tc4qO32bVsLV8DF5Co5qYAU5IPqvIAxosavX_cOX2Vo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedvkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    gsiigrnhhinhesghhmrghilhdrtghomhdprhgtphhtthhopegurghnrghllhgvnhegiees
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:W4isaB7OigRq0n9vVUOuf8K2iOkXERvOXV5DDaZa-T557UFDWaVcZQ>
    <xmx:W4isaH0Q7a8rx4hJvHhOTykwMKJnEln5euKZ7OeYDe-BBbrYn-s8tg>
    <xmx:W4isaECbNdSS1yVJeojwWHPM_H7sEusxtL3bnkIw-Zu5ZYZvtLaEow>
    <xmx:W4isaKPbvxpHzkuyyqf3Uw3iND7jcBBCBInJKPJ3_baugL_L4-jDhA>
    <xmx:W4isaEu-yALOu8tLzo-IGfbTUjuoWdo7qlwShkWLeJASeN8rAVhBAxhB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Aug 2025 11:59:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Ben Zanin <bzanin@gmail.com>,  Dan Allen <danallen46@gmail.com>,
  git@vger.kernel.org
Subject: Re: I use whatchanged!
In-Reply-To: <20250825085428.GA367101@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 25 Aug 2025 04:54:28 -0400")
References: <83241BDE-1E0D-489A-9181-C608E9FCC17B@gmail.com>
	<877byxbtiw.fsf@gmail.com>
	<20250825085428.GA367101@coredump.intra.peff.net>
Date: Mon, 25 Aug 2025 08:59:22 -0700
Message-ID: <xmqq5xebtmsl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> The culprit is the revs.always_show_header flag, which git-log sets but
> git-whatchanged does not. I don't think there is a way to influence it
> with an option, though. You can simplify history by giving a pathspec,
> but that can have broader changes (e.g., it may also simplify away side
> branches).
>
> I don't know if that's an option that should be added before declaring
> whatchanged dead. Arguably the git-log behavior is much more reasonable,
> but I don't know if anybody cares about being byte-for-byte identical to
> whatchanged behavior.

"git log" behaviour of showing the presence of empty commits is
reasonable in the context of "showing the log".  "git whatchanged"
bbehaviour of reporting which commits changed things (either in the
whole tree, or limited by pathspec) and omitting is reasonable in
the context of "showing what commit changed these things".

I do not think byte-for-byte identical output is a requirement, but
I of course am biased ;-)
