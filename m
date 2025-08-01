Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC81229B1F
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 23:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754089748; cv=none; b=ke5JX/VeQgj+Z7ljNqVSd1p66zgXGl/N9JKg0r8urU6LIxz+Ff9bMvFFzKR19HQoPDQf/yZajQR8cj9OsrIIBQvsTlAfM0Sp0FQC2FJNNKeSsPtswFYLTY232Y3Rsfyl40eFB1RK6xgyrYuQyl2zCoh4/3jPvOyYK/8mLkVWxQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754089748; c=relaxed/simple;
	bh=GC87yh1kBj6lpzczTJOYcxfYeJlKIbWGLhbt8VtgvTs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KoOKcN1dF+ZZnv4UGjpSZPnELwJApYDBqlBWZThTUq42rr4KM73iC9CNURBNx0+4gnu4OtWZ07AEboFfG4tPWL9kflci9bISXfQZvxLAdY8yFOa1qfbSRhVWsvhHGc8AQ4Vi7nya5US8pmPcG8PyXhHOs138rDldeG+djLiGs+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fBr80I4x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=daSZFgc0; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fBr80I4x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="daSZFgc0"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 32931EC15B9;
	Fri,  1 Aug 2025 19:09:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 01 Aug 2025 19:09:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754089744; x=1754176144; bh=HdThsxpOP2
	0+P+ziouMsqru1MNu5T0rbxIALP4ZJHDo=; b=fBr80I4xI7SRdsFosT2gBFY/0B
	me473jJpsoxI10EHbDSafMfR9VaIhGih44HMMKBkBa0s2gIdlchMrTYYFSsiPdz9
	7GDsY0MC55+otQFjYuWEX3Qa89kRbmp9lOXBKPp0eMMrQYZWkLxXmOt2HDmGxefn
	/dLqqXZfOy/p8j3FzTxnqIQVJQHpvqN7PGXv3769jMzkv0UvnMq9BY8DlMiPxWfw
	g61PKBfG1h+P8WTFlr/nWxA62WMGhqp8Xq440lKOCF5xb/z9GxqCwzj5fIRMpMxr
	exC7opL8ANB8s4R7419DsR1wbMs8HsWFBbprpF7mOhwn/t+D6zCDB7dLkMSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754089744; x=1754176144; bh=HdThsxpOP20+P+ziouMsqru1MNu5T0rbxIA
	LP4ZJHDo=; b=daSZFgc0oPtDaNqjuigPTOmgUjWbJ1uL6cWGZ+J4NNTkbWz8XlS
	Z0AtSdD1QeJ1w3eAP7vgtBRM9gI3F9qGjYrX7LxLIuyK2jtwLpmX2OoimAOgXipE
	CrSOK+uZ8l7o2vknf/Dluq5unscLxKOuadbvNF4ZZFCYWWGQLCtVgLN/a0kfpBLw
	S80YcDMSSbsZ77STFa/yKumw7gSxtoiCAsqHgHHvlGhZ0JtJe6sWAjTssjBGyT10
	7rIWA7uym3YrSJfLLpidM9/Mj5/o7/lfHv67T4050rB+n15cQubfg3Q/VN+uhnOL
	BeEi+9RL3MjBChDLE4U7d2bCRY1I92Ifkig==
X-ME-Sender: <xms:EEmNaKFxacBd5MM5EIwQgyLOMNHoqpOL_S_1obqDAoRXp3yutnS0eg>
    <xme:EEmNaOkP5jvGvQXI61Ir3rjN9HhLEKU421aVQB9edhaZ2-A8n-CoIkiB8AvxlPjPb
    eoU8SAnvbFqHplqjQ>
X-ME-Received: <xmr:EEmNaNmf1tTpz8nBTlfM4QZWx9UJKSkmc6V_OXLsxYxF6SeR4jpjQDozUu_vIacNuCfz2h044K4EYC9phBEE4THpy5BRgOjlLjMrXeg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdegleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhgvjhhi
    rghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:EEmNaPuAbGf8q5JYG7ELK4oMXkisYkvfbtF29jQ0WmQi07QDd-WmrQ>
    <xmx:EEmNaAnuCSFJORYPX1L2qOI4g-R7qxeYYq3Nm3hna75gIDRa-y3UnQ>
    <xmx:EEmNaKt5Nak44qWT3horg2pE6eKkIq6Jn5wdRBKF24ZYnLEIdwDqww>
    <xmx:EEmNaGcw5-2SzDI0aU6oep0JjviYkMT_Bj119MIdPtVwTouIf6kA2w>
    <xmx:EEmNaLMhTa9NxZdPkI7kSxhBoD_qCAKa8g9MQ0Lwe4RUTfEKn1MZld_Q>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Aug 2025 19:09:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 4/7] string-list: optionally trim string pieces split
 by string_list_split*()
In-Reply-To: <aIw85gIurfEhvuPC@mbp> (shejialuo@gmail.com's message of "Fri, 1
	Aug 2025 12:04:54 +0800")
References: <20250731063949.1601669-1-gitster@pobox.com>
	<20250731224607.3942417-1-gitster@pobox.com>
	<20250731224607.3942417-5-gitster@pobox.com> <aIwyIJqEIdSdKINz@mbp>
	<xmqqcy9fog8x.fsf@gitster.g> <aIw85gIurfEhvuPC@mbp>
Date: Fri, 01 Aug 2025 16:09:02 -0700
Message-ID: <xmqqa54iljw1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

shejialuo <shejialuo@gmail.com> writes:

> I agree with you that we would introduce another variable. However, the
> thing I quite dislike is that we do ltrim inside the current function
> and we do rtrim inside `append_one`.

Your "quite dislike" does not matter unless backed by a reason why
it is not good, and for that, you need to think a bit deeper.  Then
you will hopefully appreciate why the current arrangement is more
optimal ;-)

There is a clear separation of tasks between this caller-callee
pair.  The caller is responsible for finding where the current token
ends, and the callee is responsible for massaging the current token
into the resulting list.

But ltrim needs to be done in the caller for this to be efficient.

Imagine the case where you want to allow both non-empty and trim
behaviour at the same time, and use a whitespace character as
delimiter.  If your token has leading whitespaces, instead of
chopping them into zero-length ranges and feeding it to append_one()
one by one, only to have them discarded (due to non-empty being
set), ltrimming in the caller before it decides where the next token
(i.e. "end") starts is far more efficient.  It may be more
conceptually cleaner, but cleanliness is more subjective ;-)

> My thinking is that we should handle the [p, end) string in the same
> place.

Again this sounds no more than a subjective "quite dislike".  Is
there a reason why anybody would want to insist these two things be
done at the same location?

You could satisfy the subjective "same place requirement" by
inlining the helper function into its sole caller and still keep the
current arrangement to ltrim before finding "end", of course.  But
at that point, I would have to say that it is a tail wagging the
dog.  You are making the code worse by destroying the caller-callee
division of responsibilities, only to satisfy a subjetive "quite
dislike" criteria.

