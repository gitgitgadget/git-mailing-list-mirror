Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F8445BE3
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 21:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764191088; cv=none; b=fjFfV9QdTcPADFbdoXZYVkRp7gX7naAydAPpETXw0Fw4Z2RWf6X4K+MkxCysUOoT57vVZSuQoNSsMntb8/Djjw4NOYQpex5aOjtuIJP0sT7D1mmK63AHa9jIElzfHvCZ9kqqnZWQKoKeEOabHGWMIL142RMWHd0xuUgAQEpe7ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764191088; c=relaxed/simple;
	bh=pcV2D40XNGoejOhneDSW3DOIfyCRtnoJ7yhHmBa/Ob0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HAJ8yB2bqfMZ8MJhEg/eItNVyfoEBdmKfg38Mg8Bq4IEP9ALlnCcuuYSdJiTwsxGOD2EiBER6BX3Tzxz6YPBrWlCWZgBVe4cv/pT5tDkYvNzUogfhHUUOq1cAS4KLnvGwLsOm3Zr8c/uEyBQpnDt6NCKENfDbEz7o8KkLD0hRnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cRxINe1v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GY7gU/Ey; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cRxINe1v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GY7gU/Ey"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A12197A0074;
	Wed, 26 Nov 2025 16:04:44 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 26 Nov 2025 16:04:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1764191084; x=1764277484; bh=2V2O0IWySJ
	M8m1JLoB8EXaHnA0zhKuaY3KWD6uaS0Eo=; b=cRxINe1vQ2ZDFZXHPpqfWrZEGY
	/TJCZN2LluZ2c0A8rLlhg/7ccym0OoUKz3B0fzYrIUFe8QDIp1M6A5zTOeJRG0hx
	wPtZZlsmWKBuwKWhNzzn65hGe+x/fHC5/FLzdfZQDNGoscEBT/Sj0G8NCucYyVHz
	FNmJdpn+0aBBjPQYXHMJI3b9egVoTncXKWNnjy9iHI8hf7CJ81m7osbIPegE5dN5
	yysQDjATTA7ma92910fuMwuP3S2E5CWpnCLJBwPKj17dNZRJqvhYHScuAmFJ5W1/
	G6Wyd9x8xWyDXEO8VxRS9vOkaEGTg8gKpi7ckfjB/cOu5qSw/blzp1aCgh2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1764191084; x=1764277484; bh=2V2O0IWySJM8m1JLoB8EXaHnA0zhKuaY3KW
	D6uaS0Eo=; b=GY7gU/EyO5Vqy+XplYj3IclRuMVT9sORUvP6aHkAPqlqVCO6gZ/
	qMr6MW+xd3Jk8gIe4cCuElcvxTCwZu3aRJ5uvaxUpNKL0q1XLWVqrzAuARZ0FyIX
	bZ/5T75gxwG2O0yBygVEw9tCYKJvHNoonR6TYfqRLXjWjoSmbTddO1R4fzYq/1ve
	Nw1xExCm+JEKflBaqfYAFWd29vs1DQXPo2JfzwWMERxpXRIMd3uxPuzCCUh3Dse6
	4COaN0q/c4kE4swYi33gzVDvxnk2g5BfbBZ6134njAkjFCU7RBpJXTarwxm7IrmQ
	OW2cTjZDzjUEK3pljsFVXJB2j3Hd0ysz7tg==
X-ME-Sender: <xms:a2snaao6ZNoD9AYYQHUdeutgJ6FwFp8zsINxwnd4RuItrguIHrnJOA>
    <xme:a2snaTDLThH2HcR5fc_HD5Eu1jfJNR_H_IOHXrOJTlJWvRnr7DjLjU1bALJrP08F_
    Z19Q9PLBwwDkhA05DO_NFdL7RP57Bn2MNpfbbT--Oi258sT9357CA>
X-ME-Received: <xmr:a2snaVVDIMbWIQWOyaGFYO3wqw5nIqNeyLVaQcTZ7ddZNYiO1sIHSD2fva5st5YifyOv_C7ZJTQf0zMr87buixRTGRYPzu5GA-47>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeehfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepudehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsihguughhrghrthhhrghsthhhrghnrgefudesgh
    hmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhn
    sehgmhigrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilh
    drtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruh
    hkpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:a2snaVAt_jvvmVtL3x3I-S7illl17Ar5KcokEihmbusFhY7_mN46vA>
    <xmx:a2snaScw2qGXX4Yoc0c6vP-7h0WcIowTws3Zhaz0eTkNKM4tZFqnfQ>
    <xmx:a2snacr9x1rjSHsKBxgsfd6QEDnmHM9n2XxF1W7GGcOTK6Inwb8VpA>
    <xmx:a2snaTT7RdjQLcR1RdN-6MOFtfyQFj500Xj2C7DQOJkgDqrDT0qZWg>
    <xmx:bGsnaeFfpcij9XKWD77Z7KaO5iRbPQvg85o_eIXtYWWh4yBxNViN3Diq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Nov 2025 16:04:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,  git@vger.kernel.org,
  christian.couder@gmail.com,  ps@pks.im,  newren@gmail.com,
  phillip.wood123@gmail.com,  phillip.wood@dunelm.org.uk,
  karthik.188@gmail.com,  code@khaugsbakk.name,  rybak.a.v@gmail.com,
  jltobler@gmail.com,  toon@iotcl.com,  johncai86@gmail.com
Subject: Re: [PATCH 0/1] replay: add --revert option to reverse commit changes
In-Reply-To: <27fef9e1-bf26-48af-b3df-35948937c891@gmail.com> (Siddharth
	Asthana's message of "Thu, 27 Nov 2025 00:48:53 +0530")
References: <20251125170056.34489-1-siddharthasthana31@gmail.com>
	<4d75da90-7e85-573a-bb10-0c63a02b076c@gmx.de>
	<27fef9e1-bf26-48af-b3df-35948937c891@gmail.com>
Date: Wed, 26 Nov 2025 13:04:41 -0800
Message-ID: <xmqqcy54mro6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Siddharth Asthana <siddharthasthana31@gmail.com> writes:

> 1. For quick undoing an entire MR, the `merge-tree` approach you 
> suggest is indeed more efficient and avoids unnecessary intermediate 
> conflicts.
>
> 2. For commit-by-commit reverts, we need individual revert commits with 
> proper attribution (which commit is being reverted) for auditability and 
> history clarity. This is particularly useful when only specific commits 
> from a merged branch need to be reverted.

These are both good workflows with appropriate uses.  To make the
tool useful for #2, it needs to be able to allow "I have merged a
topic with 7 commits, but the first commit and the fourth commit are
faulty and I need to revert them", i.e., not just a range (like
"rebase" and "cherry-pick" workflows take), but a set of commits
that are potentially disconnected.  The current command line
arguments "git replay" supports, or "git revert A..B" for that
matter, are not exactly a good fit for such a use case, although the
user can of course run two single-commit revert operations in a row.

