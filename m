Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFE5212568
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 21:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760045718; cv=none; b=cNsxUbMmwaPvzpjGSbP8a0VEXFZmw2NnBS4trSf2HzGTXUZEyMlkvs3fWdd5kObwvbynC9zFhuJhtuZUjKPHraEfliuS7yWp7IlsRc+G65GoBekTtRtgsQVVyXB5xP1PYQIJfJRMgYcVDKwYR3VvYbxzHC6KPnEyNRI8ai0or8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760045718; c=relaxed/simple;
	bh=rnOCL0zEpQEVcKjRBO9MdQbDHMX48yGe5j/QoG5TuoE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eAqkSKDs6lLZPDnyFubn6mnxidNav28yP2uP5NTtZqtxwQ6Wanbq+hwSP+3fHhnofHq5HB7D5h0J6fbwYmy+e/GO1nGgTghMMTncEVtfdUxmg4GjwawHdjXzQt45O6Z8LCwPDOkOxaM45AtFAm9kHqcTIQ0x6PfwpKiNE+kjftI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=I14zsyZM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gs1JyDT4; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="I14zsyZM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gs1JyDT4"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D73A614001D3;
	Thu,  9 Oct 2025 17:35:14 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 09 Oct 2025 17:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760045714; x=1760132114; bh=B5GRwKmG5c
	Zs4BZLABmsQiiD5WpI1VjD7onghaAs40o=; b=I14zsyZMxPFK3aYCdP8uh9HMZU
	8/a6iShAQoTlLKryn2HNXPk5J5cS7sWDCcItOuDpDBigQJQioNvH/0sK6PqV7Pq7
	ujviPbUlKNOlJDPb6JbeUOC4Ts0YhPfTWZeCerFeMjnV3fE2OwSfvELyWrCwQlWC
	bNtKNAwB3K8r3VU38Dxh1i9MbchSx+loU0Kv0oOwP9RzP7Ircd0LzNmSiCAPCPUd
	4jMam9UJzbq4pFaXQNL1Y7LZ2FVciRspgKO6eJJYUpAKThIYOWGW23Dhe7cJ5MnL
	N5EeYZkIzFGr+mBD20lDC11w+ciimkq/nqFAAC3JdHlPEWbcAULTliM1my1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760045714; x=1760132114; bh=B5GRwKmG5cZs4BZLABmsQiiD5WpI1VjD7on
	ghaAs40o=; b=gs1JyDT43Gu6nBWtCR9RF10eXsKCtC/mFkxB1uumV3/k7oFFze4
	wTipNx728/EjoNDUj8quXj55nwyJiXE6wMKpcO3lq2WrV4na/jOpLuxRnH81iU33
	5wMR26hK78aSeNBuFvnlAKTmI5gdUyZNmtIlguaZ6a97LqO8x/NfdbJz80jG3Rob
	g90U+gvjjj1ZdTgBMMylSTh60S5Ni9OFgWrCNPRiFb5KOwSHCDD0+CfjqNYr9xhw
	41DZuNdZoupPjLi903vZZCo6X41gUDt4CC64MnysWQDwlonlywJFJR523PC9Gnau
	RbQ64caX8euG7IHnNzTuuteYVVQEjxyzppg==
X-ME-Sender: <xms:kiroaL-yeqIu7VZHonfR4I5E1IvjUIE4FQxNu20IpxgPrapxi-rOxw>
    <xme:kiroaESctUw32RQCm8QiQLo_LO-BCw7H8MNK7sN0L1X128fIIS19-Q_vMXfbQYUI_
    r5Xs1WGhzQjjSPa2gZ8Zr9Mp1lbZWRA78uK6mzFcXBx4zNiFl_EpQ>
X-ME-Received: <xmr:kiroaNfZDk4ocvM_EI7thS_PIdvCHavfr7Jjf-_miSfVyp2mH5T3WYuXBmJ4IR2HJWRspQti9YP78HTS1Va9AgW6DffkJICAnQm2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdejvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepgfetjeegudevueetieduhffhgedutdejhfejvdffleetlefhtdevjeeuhedu
    ffeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptg
    hhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpd
    hrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhf
    sehpvghffhdrnhgvthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhoth
    hhphgrshhtvgdrnhgvthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghl
    ihhnsehgmhigrdguvgdprhgtphhtthhopehtmhiisehpohgsohigrdgtohhmpdhrtghpth
    htoheptgholhhlihhnrdhfuhhnkhdusehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:kiroaOTrsgiLF2AxMkZ0OqQZwYQHQF67BR83USpppaJWFkj9oB0s9A>
    <xmx:kiroaBIga_7Wk-mnzae0ksxxgCCvpvjM4MAmGjpbV4vYEiO3YnOXKQ>
    <xmx:kiroaDJLB5hYetrxL51mcA7f8COvxZBZFoigo20jYX8T-DAqylWJfA>
    <xmx:kiroaEhZgopcsejTKhgu6CGxQ4z6ebU3NLmeBkcwYdXFPJeYlkX-zA>
    <xmx:kiroaOmi6cpVsgoCkCiuWm_GD8aW0W_JAqy2RU7hOMIL6xj-lTBLJRfZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Oct 2025 17:35:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Elijah Newren
 <newren@gmail.com>,  Jeff King <peff@peff.net>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Todd Zullinger <tmz@pobox.com>,  Collin
 Funk <collin.funk1@gmail.com>
Subject: Re: [PATCH v2 0/5] fast-import: start controlling how tag
 signatures are handled
In-Reply-To: <20251009122457.1273701-1-christian.couder@gmail.com> (Christian
	Couder's message of "Thu, 9 Oct 2025 14:24:52 +0200")
References: <20251007122958.1089680-1-christian.couder@gmail.com>
	<20251009122457.1273701-1-christian.couder@gmail.com>
Date: Thu, 09 Oct 2025 14:35:07 -0700
Message-ID: <xmqqsefrdaic.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> Changes since v1
> ----------------
>
> Thanks to Patrick Steinhardt, Todd Zullinger and Collin Funk who
> reviewed or commented on the v1.
>
> - In patch 1/5, in the commit message:
>
>   - "focussing" and "focussed" have been replaced with "focusing" and
>     "focused" respectively as the former is UK Eglish while the latter
>     is US English,
>
>   - the missing "section" word has been added.
>
> - In patch 1/5, in the git-tag doc:
>
>   - "cryptographic" or "cryptographically" has been added to number of
>     places,
>
>   - the changes to the CONFIGURATION section have been shortened by
>     not mentioning the supported signing backend (X.509 and SSH) other
>     than OpenPGP, and by referring to git-config(1) more.
>
> - In patch 2/5, the approach taken is now the one previously used by
>   Todd Zullinger in:
>
>   https://lore.kernel.org/git/20240703153738.916469-2-tmz@pobox.com/
>
>   so this patch looks like a completely different patch in the range
>   diff.
>
> - In patch 3/5, in the commit message:
>
>   - t9350-fast-export.sh has been quoted,
>
>   - some explanations about alternative solutions that have been
>     considered have been added.
>
> - In patch 4/5, the added tests are now written in a modern style,
>   instead of the old style used elsewhere in the script.
>
> - In patch 5/5, a die() message has been marked for translation and
>   some "/* fallthru */" comments have been properly indented.

Looking good.  Thanks, will queue.
