Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAA0372EEF
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 23:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772581816; cv=none; b=O8hfIYo5St9j8sZKWFhdreauoe73FrCjfgjxg0Jr/QEcR70TDfgtRBwAsfxPrBSOcAlQetctBGslTDA8NOHl8+JAHkPzOhE7lpO9F2KcAw9wl0XmymDlNvaUoF1FeLwTQPNRe1MXUTBi1gyJe9zF9vaji8wLBoBpDP/T/E8jwHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772581816; c=relaxed/simple;
	bh=o4o0kEvH3pm9Pl+BXAdjI5yRcJ8ydpWwGiOuYNCpmrk=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=kfhn5+YLovJo1PeNVP9hdY3elLFdPdG6OZW9WZ21Ax8VeRW1C18BAIk6DmhZSCMTvacAkZeqbxyKNf0LGxfr+r85PpmJvNHS7CmUPj/4LU3QnGOShTJ77YjXce78JAo+pO/shTZRrMu7oB7fSlRU2Ch429ijxmI5UdrnMZqTrEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Oa0ep3bV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sOti3VZn; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Oa0ep3bV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sOti3VZn"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C8C0B7A0047;
	Tue,  3 Mar 2026 18:50:13 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Tue, 03 Mar 2026 18:50:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772581813;
	 x=1772668213; bh=Emp079wDGGK4L9BsLQ0SLmHi5Baw1znfSzCYuVQEtoc=; b=
	Oa0ep3bVhB2ruqY1T2PAAsyV0Cijt5ne4gWzMnODNZGIP/T0ucZDP5imhibcnk1M
	7aZrA5PF6xlVkqlGcF2CbZ81Yr+QIHDO3w/Ni6YBXu4/ImqCvra/WN0JmJU/Xwdc
	UuWInad6wOkXt0KNg/cyROKoMOo1nE6MKgZ/z6NP5Q0IxfaPSSroksMZL2NNpuZB
	iB+qbTFrhNz0kxY9rolC6Rvhb2O66SQokDLbUZS1KkfVZEgWa5Z4obJQMiUk4LLo
	y5imdRiJqBT9pCzKBEFs/eAFoEdr0JHYUQqLqE/V3RcyEycKwBZv6uZwj1Cg0CU8
	oYSpMZcKGHSImJkSAO+6gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1772581813; x=1772668213; bh=E
	mp079wDGGK4L9BsLQ0SLmHi5Baw1znfSzCYuVQEtoc=; b=sOti3VZnaiTlTQCOR
	Id4iT3kFCMZZQffyYdpt74qm3nOgZQ9ku7zkSzrlx3m/wpLpJGUOuBLZZ99Vg9Pb
	oV1Z0MBCMQe9Asx2AInwkpOfSYYT2wO7InC03WLBSPdF8+dy1choGHM2U4aS21GT
	VxVKYxhb/p8GLU/Du5zukwkLgiEDOaMZOyUEpRH6xyC24RlBu8EoTLx/XX9R0txH
	Boj6Ymd7nkIpMtpH4oiilKoVAIP7i1EotDtns26vl54FwsbFa0ulCGpkwH2TtE+A
	ddTxEeMax2+fbiwDPj12TX6zNfQZpzV859y5nOanN/wicfanCgcavRIMh1B1M+dF
	YzADQ==
X-ME-Sender: <xms:tXOnaZZRenJqxCOxg3Vt9slCDMG6ZDI2QOCc4GMd-5eejIP-HcBCl3I>
    <xme:tXOnabNUOMkmA-H4s4nMQDKmhDyw4SU6h1ZTo-FFSMh83RTUELa_9vQB_iKXapTtF
    CmMLOokI3BHa1-n-JMp6-6GgQutJfSVetuudkeuVMxwUbm1urM8Dg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieduleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeffjeekvdejgeei
    geefjeekgeelveehieettedtvddvgefhgeehgeelleelveffudenucffohhmrghinhepgh
    hithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehmrghtthhhvgifhhhughhhvghsleefgeesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:tXOnaUFK9Di8I3kBrlBIlT2QkVk0EjdclHadY8czO5-zaO97DiviIw>
    <xmx:tXOnabRMgLSQi7dWdvuz7y_-A3Ik10W1L23pXFzoPKX6qEYyBEPCZQ>
    <xmx:tXOnaVveQNdCasp0sfu7QETJ9OOY7RDqJ6kKtri0k8eSOKibjsTF0A>
    <xmx:tXOnaSxa4HHjYRW8PPswq3hr8BA2ZB-Jc1lJhoNe7CbW6fV2PjCHpA>
    <xmx:tXOnab_ScKdBe6XKQEjcfNh4P1KLJEkuECVn3p_hScUlICY1tHyD04t8>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 84C401EA006B; Tue,  3 Mar 2026 18:50:13 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AZiI0CRBRzfN
Date: Wed, 04 Mar 2026 00:49:53 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Matthew Hughes" <matthewhughes934@gmail.com>, git@vger.kernel.org
Message-Id: <54a45011-c0f5-4852-b344-b81c36ed8924@app.fastmail.com>
In-Reply-To: <aac-QdjY1ohAqgw_@desktop>
References: <aac-QdjY1ohAqgw_@desktop>
Subject: Re: Crash on git log with -L and -G on file rename
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026, at 21:42, Matthew Hughes wrote:
> Hi,
>
> I hit a crash (assertion error) running `git log` with both `-L` and `=
-G` under
> certain conditions. I've created script to reproduce the behaviour in =
a fresh
> git repo:
>
>     #!/usr/bin/env bash
>
>     set -o errexit
>
>     git init .
>     # Note: example is .rs file, but it should work with anything that
> -L understands
>     echo "fn my_func() {}" > file.rs
>     # 1. file named 'file.rs'
>     git add file.rs
>     git commit --message 'Add the file'
>
>     # 2. separate branch with the file renamed
>     git checkout -b some-branch
>     git mv file.rs new_file.rs
>     git commit --message 'Move the file'
>
>     git checkout -
>     git commit --allow-empty --message 'Some extra commit so we get a
> merge commit'
>     # 3. merge: one parent has file.rs, the other has new_file.rs
>     git merge --no-edit some-branch
>
>     # 4. post merge, move the file back
>     git mv new_file.rs file.rs
>     git commit --message 'Move the file back'
>
>     # 5. things go BOOM
>     git log -L:my_func:file.rs -G '.'
>
> I'm not sure if _every_ step in that script is necessary, but it's the=
 simplest
> setup I could figure out to trigger the crash. Running that script I h=
it the
> error:
>
>     git: line-log.c:1056: process_diff_filepair: Assertion
> `pair->two->oid_valid' failed.
>     Aborted                    (core dumped) git log -L:my_func:file.rs
> -G '.'
>
> The backtrace shows that the failed assertion occurs under
> `process_ranges_merge_commit`, so maybe there's an issue with the file=
 being
> renamed on both sides of the merge?
>
> The crash requires both flags to trigger, remove either and it will ru=
n fine.
>
> I've tested the above on the `git` from my system package manager on A=
rch
> Linux: git version 2.53.0, and one built from source at
> 2cc71917514657b93014134350864f4849edfc83 (the version of 'master' chec=
ked out
> on my machine at the time). I don't think reproduction relies on any s=
pecific
> config since I've had it trigger with both `GIT_CONFIG_GLOBAL` and
> `GIT_CONFIG_SYSTEM` set to `/dev/null`
>
> Just for reference, I originally triggered the bug in the `rustfmt` re=
po[1]
> (checked-out at cebab3e99259be82ff069e5ae89e91855d79e534) running:
>
>     git log -G offset_left -L:format_trait:src/items.rs
>
> Link: github.com/rust-lang/rustfmt [1]

I was able to reproduce this on `master`, `next`, and `seen`.

=E2=80=A2 master: 50d063e3 (The 10th batch, 2026-03-03)
=E2=80=A2 seen: 62670724 (Merge branch 'ng/submodule-default-remote' int=
o seen,
  2026-03-03)
=E2=80=A2 87284122 (Sync with 'master', 2026-03-03)
