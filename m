Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D551366541
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 21:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785877960; cv=none; b=qGC5scT7quZ5Cgl80kgGVrleJhD5L2ikAATEliDMZMCJuEXDIC9EpR3hPg67c6q6fSwTaXDUcaYKhYSQdWCnRACOgY/IMmPhfCU6RmutexTKqusm9dzYhNklI73L+naU6ph4X/J2BAOeHbmc1nMqpCWwrygVZZpV7EN9NCxnjLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785877960; c=relaxed/simple;
	bh=/PByDulRQf8pU8gE26a49LrcnejxGsefcsbW1TMT0cs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YUB/w9ePtx17jJjJE8FZuNx/8QE337q0eg9LwQoRDe//cXimhdjNlb7rVSJamxT3vG0LhpMjlO5sl+6mqNj3fBQ+xIymOD0F3QAEXTu/duayjvXq1mNnjEMtWk3nQ0hR3/aMGDp0cQoXapktX32VoadD0Oa9LVEgOF7Mipy2eYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=l3OpbMu2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HK52kP1K; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="l3OpbMu2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HK52kP1K"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 97BC8EC011A;
	Tue,  4 Aug 2026 17:12:38 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 04 Aug 2026 17:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785877958;
	 x=1785964358; bh=1mUT0v8WYBRIY9OSjQBFCbaEv2gtFsa1yaTvCc+EfsU=; b=
	l3OpbMu2LjzZ7RIj4x6pc9LsBB3KJOil4gWwC5hcgIIcNKuPHyoQ+kilupHaS+Lz
	HQvHBKpU/FckmBlbYkGr7rMW2JlrjwQ6pYQdv67R7A09p+WAQaR7fZLNUYaQ1W40
	SIXORPbwSJM3vZO4wwDIKp7KEpRu8b9ocEDFvS81qc8M6lQKvlYizXTXQuJHLQMv
	DSiAc76gOQ9YAYUVMzNgB+1avpvNS6R5qP+xh59+Un0pVDLtkLeizGkp23DJv7r7
	Upd6wL7U65qdNvQfstLLIQYhLBktO6KTdko2YjWgDbU3YKBdIE4AiKk0E6qw0gJ0
	QGxnK3NoNB3KGMTLIFDGRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785877958; x=
	1785964358; bh=1mUT0v8WYBRIY9OSjQBFCbaEv2gtFsa1yaTvCc+EfsU=; b=H
	K52kP1KKkuAK5HgMtT6S/m4fYV9AY6msbWRGuD81DJd/XlC93KndZwdepllxxNWh
	+lEHRkimzKEASixPtfPjDhvDauQjI+NiaVHBJfrIggp4RM/kIoZIKkPFvzuoH2WV
	u0dtjyz/4AHAdyXktUEb92homUrP9lhypBI+CRz89Y0mQHNC025gtTa9gUmk29C7
	4OJJMXcyAiHitkbEZoQ3Wui/0Znr0ZQ2mbgpGABj1dGqvRb0kUuiiI2oRGxCEEcE
	R981VH6wdvdazkNwaICXHwdTDaIzhYfWgmRV9oOMy3eHsTtfgpIQVmb6F4fmneAo
	iP1hZioRP8cbASu10XJBQ==
X-ME-Sender: <xms:xlVyajZG0E_R8bhI2pKYeqokIWUlBmOYSskCafctX1sNqbzmhHRCVA>
    <xme:xlVyauZmQonj9ym6tMOgbmc6Vz7qtdvjxMrpQlPl3DUy4_qQAAA3JH0u0CKt4RzQG
    iQSbCniCQohqeEZ6dRDJpiBfGu7zSFd0-W2Z9pbGHC9jslWkUUo5_k>
X-ME-Received: <xmr:xlVyaoLEg-xhEoN1-2PMlLvzi_qe7tL-m3ZCdw8_WJmXcPAtMv0qajEJbghe1fBtQJu0FOhci93WGnotRZJzE7TPurnZzsIfDA>
X-ME-Proxy-Cause: dmFkZTGD2TFMJI4OOC24bslYvUAJrTMPbG6EQtXe6rhsij2QqcPx7zoOUGVBEoHORWXLMk
    w04jf+Z3uZWo3tSAPZtq2waryq59zm27Y2SHRDuCz6tHl6C8y9Q86guY9oEDit/PmL9PkF
    y3NjXWR/w7dGfM5n48n5OtrIUXEZeAaQGqSivkVkP+1iHgy3sgVrZ7zR2BESUVFjinSiqT
    wvYbxeQjpEHtr7EQDL4uasJojctZILIlBDaaNYFntiLKPoGaHGkrous+NKK9Ah2AHt9Uy+
    i7dpozfvWux3RV5SUKMXyGJ4kmpP2ccgUusPzFdH/rLVJQ9k3i79tJWxXTpE0YRaWmceov
    1yy6diqX7d70ztxnSLx0gcFkEm6yl5Z+LzmxXJ81Zm6rlMkeQBpLikkWxQ/nCsabl5ccEC
    3PldyW904ZhupNepiP68xhR9mLxeENHGYP6qXNXbsMoRaltFjt1fvH5VCJA1/K3HZWC5tY
    JKOQ8n3ayuxzRTW3gPQC59NNn8cG5upey8NcMRnIa3LcJZH7ajuxnlunXhzV5cJmmdD5rD
    TOJkmBFQ1XvT6UGcl8mQKqw9V7QKD9t6AWjV/HuMny4FVqxdsDik5aB8CcDIPmOMnARWTD
    xe9JpE7Hi3ttinzpxnvYSTmZUU4IQduy4TN9rlxqH34c2BVanlnD04cSN4tA
X-ME-Proxy: <xmx:xlVyaqtXMy3rqXPJqe1iTFJCsU2JH2eGdbrdjhAAPiWyrGWb6R1XlQ>
    <xmx:xlVyasXKYQJJMVG0fGHQHfbyuIvdfjTUfT2DMLFpZ7f9bPTS1FIcog>
    <xmx:xlVyalgJ-bCyatZhxh_V7DP3SB3bSfXdOqsyjWLe0uG6pHR7Acmu9Q>
    <xmx:xlVyako6DofJgFRNuh_Sbezyo_Wkwc9sL8MUIkxma8-pIwYPh_vS-A>
    <xmx:xlVyagrs-k9wn9vrqJP1UUhYXu5OsjFdHkedDLhHb-iA6ZCg-IB8KVty>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Aug 2026 17:12:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Phillip Wood <phillip.wood@dunlem.org.uk>,  git@vger.kernel.org,
  Phillip Wood <phillip.wood@dunelm.org.uk>,  Matt Hunter <m@lfurio.us>,
  Patrick Steinhardt <ps@pks.im>,  "D . Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v10 3/5] history: add squash subcommand to fold a range
In-Reply-To: <CAHwyqnXJLQ_naFb1RRQWS3eft0FXL7ripviSA15Zy5D6nvHGAQ@mail.gmail.com>
	(Harald Nordgren's message of "Tue, 4 Aug 2026 22:41:42 +0200")
References: <6b5b2c93f2e3e55bf456b86a8be61f5f85137a2c.1784536024.git.gitgitgadget@gmail.com>
	<cover.1785750108.git.phillip.wood@dunelm.org.uk>
	<CAHwyqnX8Api2VWqaDt4vgnG5P9RHGkK2Bhhi4dVAu7Qrh908rw@mail.gmail.com>
	<xmqqqzkevx62.fsf@gitster.g>
	<CAHwyqnXJLQ_naFb1RRQWS3eft0FXL7ripviSA15Zy5D6nvHGAQ@mail.gmail.com>
Date: Tue, 04 Aug 2026 14:12:36 -0700
Message-ID: <xmqq8q6ltwsb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Harald Nordgren <haraldnordgren@gmail.com> writes:

> Hi Phillip and Junio!
>
> I admit I’m trying to expedite the process. Especially given what
> feels like endless review cycles, and some frustration that this topic
> was queued for ’master’ and now it feels like we’re miles away again.
> I recognize that this mindset is not a good collaborative attitude, so
> I’ll try to step back and re-adjust my mindset.
>
> I am used to a work process where moving fast is paramount, and good
> enough is good enough in terms of code quality. I’m not seeing a
> healthy code review process here — any feedback halts the process
> completely. Should it really take months to merge a topic?

When you reroll too fast without waiting for reviewers, it
invalidates almost-done-but-yet-unpublished reviews.  If you
repeatedly do so, it exacerbates the problem by discouraging
reviewers from even looking at your topic, as they wonder if a
rapid reroll will invalidate their reviews yet again.

If it is taking months, I suspect that half of that is due to your
rapid rerolls, which have discouraged people from engaging, as they
cannot make a time commitment to a bottomless time sink.  The summer
being a relatively slow season certainly has played a role, too.

Thanks.
