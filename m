Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C634343147
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 13:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710202; cv=none; b=Z1ZJHFO8GPAzYjGzUciI18etHY/3J6bKtzncQMSwgpb/2FmieE9DG7XJ4w9E4EVXGIwIqKqEpIjQIWHKJoF1mxQhiAQWel/gZiLJz/xkH4YGsXAveDUNLH+2HY+3zbRW5uapS38bsEfijYq8Q+lD7dAfS1/o732FtW1BVGPiFM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710202; c=relaxed/simple;
	bh=GDd0uzuQQbd9JHExj+TNJ+f31qXZeAGiYs5bZOidkVs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WqUa6hAj1alSDaT5P9Io28olE+trRnMo8Xzyt9mb5tTjYdcUn1g6KlxOOFOBcT1JQoEJ0f+La1SNWeDbLRnl3g3uqp88Ga1Tngms0s5fjcFCk/ZElAv9jwEfpYVU+64caMcJdmAm/ijGT6ZY86FYkJbCTjPo5ogzT5gUiEsRVd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=G7XDVhTv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W7F9sC4V; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="G7XDVhTv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W7F9sC4V"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BD4A314000E7;
	Mon, 28 Jul 2025 09:43:18 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Mon, 28 Jul 2025 09:43:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753710198; x=1753796598; bh=cwqUtUeosO
	2v+p+xD1dJBJb5chDXnJktYf+fX7OEdZY=; b=G7XDVhTvmiik32BFwrw7R8RsjD
	zCZsv+2hHUrw6dryS6+l9vk23bAMInOUETDqlw9xqL6xrz8fOFRFb7N3YtYyZa04
	vd+EakGJsnIZTfd/HYzjlx0e8v2eJQNYRtJmd3feLx26AqpQXloDBhhJdl1L2Ppr
	bKZdq4cpcpfitYuRfXZZ+8TJbVWzbz+tOv/ttMQMndb4VS9GkTWNqhlVbnq1NHOQ
	knpBP3/llhki7CrANNx2LUaN8TmqfVXCqQM1b3dyVzJB3uNBmAHSdKwSP0AgqIVU
	D9PIy7YEBSzYtQGsbGRe3kdgcls3Qs+tyeUjzEXLv36h/NCp2BEPgICpuepA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753710198; x=1753796598; bh=cwqUtUeosO2v+p+xD1dJBJb5chDXnJktYf+
	fX7OEdZY=; b=W7F9sC4VgnQE4KPZ+ivzxRh6uZHQN+WYZN9ghREWe7V4XqbYCFM
	auBk7fUnzxknyRAT60oR/91StBU7q6ZnGsNOKhh644T31qJpXhcIBrL1coLPS8oH
	kqPLgumbBgjRiQYlU/9Sayjblhz/x7umTOPiwMXwvSgvqtV+E9OYlHHAbkWo04kg
	8YROEvu9Qs4OSpLtn85VLlYYxy0K7jLjTNKHSrGpH43Qkjnt4EMpAe/tsx6ElSjf
	A6wNfX+V8/tafIJc5vdZuE3LJnQQ+IaRCsA1FfQJwtO6HsPZBnTuS81PkvldvItI
	0knmNltE9w1JksL0sozJqwG97nvS/i+MmkA==
X-ME-Sender: <xms:dn6HaMd9i7YJdrED1cI8GQuHz9qelX7HecEmPud2wJukooQBJMZZGQ>
    <xme:dn6HaGqynNoe0Tas2xPuDeMHvCMrTgbH1R73VWbezMF8WTzRC6pYS3fqbABudkfgZ
    OupwkBsjG3KjweL-A>
X-ME-Received: <xmr:dn6HaN-iqCYUaKw5XgOQNnLgUX7usDZaYfPbP4p8UQrE6NGYoesHZ5wxDaf-mU3sKCueH2darH6e5ggkJQWnWBDXyN51jhwnle6rZfI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelvdefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoheplh
    drshdrrhesfigvsgdruggvpdhrtghpthhtohepkhgvvhhinhdrsghrohgushhkhiesrghr
    mhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheprhgrvhhisehprhgvvhgrshdrughkpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:dn6HaCeCK-ZgFiAaFWpHDj3Mtbmf0WHH0oP8R7r4_4FyTYoCC3Sk2Q>
    <xmx:dn6HaHKTmXQG1QuhBfbfP60eOpk9VG-1vn5bADEQ91ZfiAGuDp6k1g>
    <xmx:dn6HaCiq_HZFi3dr10g44B3zBcEWB84pxeet4ap6ETXOc2e12T8qxQ>
    <xmx:dn6HaFRnIjaxsV-yZRc6eJiVIkYmDsnKKF-khQt_7wZWh3CLAlo7uw>
    <xmx:dn6HaCi2fuxdvdf_yNuqd1aC8gkqZhx9OVlBV0T9cYjohXTCy0jhgo8A>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jul 2025 09:43:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Kevin Brodsky
 <kevin.brodsky@arm.com>,
  git@vger.kernel.org,  Rasmus Villemoes <ravi@prevas.dk>
Subject: Re: [PATCH] git: show alias info only with lone -h
In-Reply-To: <20250726081254.GA3042329@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 26 Jul 2025 04:12:54 -0400")
References: <1c3a0463-36ee-4a2d-92e0-fac9c0bf77da@arm.com>
	<a35dc2bf-015c-472d-9528-6763f7aac180@web.de>
	<xmqqqzy33k1j.fsf@gitster.g>
	<20250726081254.GA3042329@coredump.intra.peff.net>
Date: Mon, 28 Jul 2025 06:43:16 -0700
Message-ID: <xmqqfregzb0r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Another interesting case: even for our own commands, the alias itself
> may add extra arguments, which confuses things further. So:
>
>   $ git -c alias.gi='grep --cached' gi -h
>   'gi' is aliased to 'grep --cached'
>   fatal: no pattern given
>
> runs git-grep, but even though the user said only "-h" the alias added
> another option which prevents the help-mode from activating.
>
> In this case it is not too harmful, but you can come up with
> pathological cases where it actually runs a real command:
>
>   git -c alias.grep-for-foo='grep -e foo' grep-for-foo -h
>
> which runs a real grep.

Yes, that is an excellent point to further argue that we should fix
the help-alias case to stop there after describing the alias.  The
user can choose to do "git grep -h" and look for "--cached" after
learning that their 'git gi' is a shorthand for 'git grep --cached",
but we shouldn't be doing so.

> I guess one way to deal with it would be if the user runs "foo -h", and
> alias.foo is "bar --other arguments", then we run just "bar -h",
> dropping the extra arguments provided by the alias.

It is much simpler and saner to just stop after giving the alias
expansion, isn't it?  Nobody can get hurt if we did so; doing
anything else would be driving us into further corner cases that
would either confuse or harm the users.

> So IMHO the patch under discussion is a strict improvement, even though
> it leaves many other questionable cases unsolved.

That part I 100% agree with.  Let's accept the change, and then give
further fixes in related areas.

> I'd also be happy if on top we did:
>
>   1. When alias.foo="bar --options", turn "git foo -h" into "git bar
>      -h", dropping "--options".

This smells like piling more voodoo magic on top, which I am not
enthused.

>   2. When alias.foo="!bar", report only the alias and do not run "bar"
>      at all. The collateral damage here would be:
>
>         !git bar $(some_shell_magic_we_need)
>
>      but IMHO that is not all that bad. If we report the alias content,
>      the user can probably figure out which "git help" to run next.

This I very much like, and further, I would prefer to do this for
all aliases.

Thanks.
