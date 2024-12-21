Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992B513B288
	for <git@vger.kernel.org>; Sat, 21 Dec 2024 16:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734799943; cv=none; b=qCcugGaUQp5xAsgNn7FqQeFmlEBSJZYlL0sKklOtaJgZcu0JAcGa2qv7LR0bGxeML7t4ajnFvF0pAEQbXt0JlBbBRwM6y3rNqISGsaEXvT6TGn/5s6/oFdGsKqAdU1BV1736yuOGupdQFP44V4Cnduw//C9aIprctFQAreNyAAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734799943; c=relaxed/simple;
	bh=5Lrj2hR6Nf+kaV9xIAaUW9fjQM7K/tLdKAcRp5GnE7Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZR9Xt5PPvv/sZqe3nXjMc+N/3mu4l5cY0Yooh+eXiHtyvQQf07XYKNb2neRjUbnmoLXOaOzOlESb7KuK9dK72vpzL3nDzrnGcCnmnOZtqqsbRgFA8Vksgbr1T0B5E1Pg61UujCT3jp55q6SPshU3hfWxTOzCv76IXIrjTmQaD78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=khXBi6Sa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MBrPJWVZ; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="khXBi6Sa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MBrPJWVZ"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A12E811400A0;
	Sat, 21 Dec 2024 11:52:19 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Sat, 21 Dec 2024 11:52:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1734799939; x=1734886339; bh=eRT09I+NFV
	1Vw71MMJeJpBNgbYp3WHTZlcisH57tcq4=; b=khXBi6SaI71sx4n0Y/Ci5LNroF
	U+rgGrDQ8uvFDbEqMoVPAwIt9K2N/YYqDwHNbHtts/ii8DdwLUc8jWmZQoHzK2hc
	rCf86oTxccMHGfsNjLC9d60j7RqyrWuSBWBV5BF8ZfDsZiwSTJcaRj2a0VEcVhLz
	eHHKaYWcS7BQnmCdyUp3b3YXYuCbBhbQ8YKKW+u1NTahSZxk83y4B610TrG7//RM
	8WzxY6uLPpa7/2uDw9SH5PuDKccVZPTE8V53V/0k9bEBaH2N0D3U0LdgJvlzb4yp
	EbKxISsslLXHAXpzbx0OYvrgPvB1u7hKuiiJ7mOpo5Dw1GoDaS5usHN6lbxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1734799939; x=1734886339; bh=eRT09I+NFV1Vw71MMJeJpBNgbYp3WHTZlci
	sH57tcq4=; b=MBrPJWVZCHkZnhTYtX7+1sNG6SHux7MzsRbu7KSbSRBfZICPSst
	m3ZW4c9NDwbN1VEB4fH92Eu0rwwilOJcMRb2prTg3EXtAHvndmRiODAYEvtOSLmo
	Z2kgk2xMa9aVzTBJZ5Cqk/w4jBlVpdzXHns8AAwfydvkMhmnUgbZOJ8LEgevzKWb
	5gLsFkTsWJ11+EKR6o/apy4Wo0GIXqprtrMoCBIPkHGZGX43MEk91Cuw7L7B9TdE
	BAHChKqjPbmzqNhOF0oQk0UYLmfPfk4htdM5mwWDEjY0ukMv0HpNiEIAQO61vZWa
	ESXnyWiz+cBeKdOxUfyx00E/Sty0O4KLneA==
X-ME-Sender: <xms:Q_JmZ0Kj1YNoskGUE6b8ToukX8PcgR1srKU-mLLrNyjnH8ntfaL7FQ>
    <xme:Q_JmZ0LrcRed4LWUCGYgjnzh7gttBTFjIN7y9l9vEdK9rGYsgijzLnWHD5eIs6ksK
    kC7S69TZkIBa5hWkQ>
X-ME-Received: <xmr:Q_JmZ0vPFmlE-qafu-COyNtHzM17LyaBUvyZc7CfMKoOJl0DHrVw5dtD_j4CWyV7JeB-15MNhvrYv5O_oCvw3cNFcu31me6QkA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddthedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    rhgrnhgurghllhdrsggvtghkvghrsehnvgigsghrihgughgvrdgtrgdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Q_JmZxYR-6T0A4c0EqEmj_uIrnrRs4Brpc-Lx4m8ON9XK0zl7Efv-w>
    <xmx:Q_JmZ7bOy-BMGv3iIHHBsme4_x4kxNV8II_sesNY56kznc5FDPsumQ>
    <xmx:Q_JmZ9AjLbdzUJOQGDzOD9EhvJ8XQMgTa7UDTcTA2YA1dAYXqUYzUw>
    <xmx:Q_JmZxaxwmK2I6oGsM31o2OEATcVIThvrpwcnaRU6LZjb5yYPPGPQA>
    <xmx:Q_JmZ6UMNT5drobNaOUfzI4ZOyUjt1SMAm4QnPbmVjWudDDhOg_MYfNq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Dec 2024 11:52:19 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "Randall S. Becker" <randall.becker@nexbridge.ca>
Subject: Re: [PATCH 0/4] reftable: fix out-of-memory errors on NonStop
In-Reply-To: <20241221-b4-pks-reftable-oom-fix-without-readers-v1-0-12db83a3267c@pks.im>
	(Patrick Steinhardt's message of "Sat, 21 Dec 2024 12:50:06 +0100")
References: <20241221-b4-pks-reftable-oom-fix-without-readers-v1-0-12db83a3267c@pks.im>
Date: Sat, 21 Dec 2024 08:52:17 -0800
Message-ID: <xmqqv7vdc726.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> this small patch series fixes out-of-memory errors on NonStop with the
> reftable backend. These errors are caused by zero-sized allocations,
> which return `NULL` pointers on NonStop.

Interesting.  Git side has long been aware of this issue, but
because being able to get something out of zero-byte allocation was
somehow deemed so useful (and I do not either remember the reasons,
nor if I were asked today, I do not know if I agree), our xmalloc()
and friends ensure that we never return NULL for 0-sized allocation.

I looked at the patches the places they touch and they are sensible
changes to avoid asking 0-sized allocations.  Which is the opposite
approach from what Git takes *and* which may be more sensible.  The
callers should know better what they want to do when they have zero
sized request.  E.g., if they have 0 records to write to in a format
that has num-records followed by an array of entries, they may want
to make it a no-op, or they may want to explicitly write 0 followed
by no entries, to record the fact that such a request was made.

One possible downside of the approach is that all API functions must
be vetted for their response to a request that might end up leading
to a zero-sized allocation and told to special case such a request,
but that is something better donw sooner rather than later.

Will queue.  Thanks.



