Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE153126B1
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 15:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774626922; cv=none; b=TIFLxpix/6CUBHqwrqyALbor+jphIM4dRC/NWY/wR8OEInJXXCgOAZeHrRbGiBAUGtJV08oLoY/JNO4H7F2SNGiQvkAtOGuE6EdUpAsCpn25Ezhw7WmFe81PUXvskGCTPOeEJdH0RcnJHvhAYVxTPCo2QMp+uqioobFiFBq40QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774626922; c=relaxed/simple;
	bh=GwmWy3ByJB5kojMr4dO4KyONdVg2ObzDu4aV1/RONl0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dKXmCEwv4LUIlYOpUyIf1RzgWUs4IQf/Rhs/6a/NFwOjae/ZR777qwoeydu0rZyeG01BMe1LzqAser1JuxZwWJnXp/zfcUnqOup5w/ZIIgsqB2Qxg9LBsDPOnjKYLw396UrQa4TMEEsHSiGWW6xkBW38RzmisnGBrhBmF66L6lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UBvAcPAF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O8fleEdY; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UBvAcPAF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O8fleEdY"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id F02F21D00289;
	Fri, 27 Mar 2026 11:55:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Fri, 27 Mar 2026 11:55:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774626919; x=1774713319; bh=GwmWy3ByJB
	5kojMr4dO4KyONdVg2ObzDu4aV1/RONl0=; b=UBvAcPAFeJ0qFQRDN7Wg0upQ9d
	4PJhvhEwW309T7QisR09/SvUDkCfO2SLH+U+DzbgKUtGCTBpXCbUXg1T2wCRJDUO
	qLSuRUl+QGf+T58GXdp/YHjyZLhHY7NTt8Ht3C5ZR0djq/4l5+30ERnZqVF5Aegn
	tZvVxn0oF+/BkAqyKbvoyUcuRYstLrPhT4dFuzp3kKSCywRnuI1hK4Arm18dDeiJ
	e+2xnFwLZR+U/U18d1kRC07Bf1Ct5Yzre0YR03kWLHJ+Yjp2kEJq/tc4eL/9C5SC
	MlLu99hUQlJ6/evW8OCdd/Y0D6nzCLNj3wzG+DVQ3YYd/SHAtfP6lKd187oQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774626919; x=1774713319; bh=GwmWy3ByJB5kojMr4dO4KyONdVg2ObzDu4a
	V1/RONl0=; b=O8fleEdYqcKu72UrIh0rD7ceq1LJS4FxVbttvg3QuHwV+BYaMTv
	wZogjSPmEfdHwMdkmRqqQCkfrEHDb/I0pNAurzV+5C79vKRhXy37txAzfmc+ZxI8
	F5MkEgMhtOzHnHS0/f65zZtEzpVXhhZLca4a5BBi0mQX3ZEqs7kffheVYOzBanow
	6XUy+IQHNyAneTodj9OIkJ+gDrr2yAypsAB7zM6SHNQujx7DgKqjYKb+oSH97y6K
	3EUZ/Vk9jhnYVcmjlblKAWUThj1l0V/BBrQBjDjYsdnWkCTWxJGQ5cb1u2sF1j1Z
	h6rTgG2clS7u9VckkDxXXQWvQIAosgI8/fA==
X-ME-Sender: <xms:Z6jGabxQDmSY85v8-2n0NLfDxK051RQoTbhGxvEudd-0yNyXUgxEcw>
    <xme:Z6jGaaQIIE_RoZkpmn1-tLDu-2J9vT03m6zsi1HcSkO2GP2uomuvY8eO4-KHxs9_J
    Uj83i69CpIb7tAv5HH3vPt8CLS8dDx14STQyTZEY1WN4t6OJYEO4Q>
X-ME-Received: <xmr:Z6jGaaUTgRWI9OzPktfEuGQr4Bh_t8GXfJzm0mWQVoWA77I84E8wGAqjjx8tj2j89OSjojnF42bFjJdQCWH5TBdcEzmLg6clyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffedtieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithesghhruhgsihigrdgvuhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Z6jGaUap1yos-OFrxFYOUlSb0p9Lb_vYcezpXPCXwDIWBLlmpXuwbA>
    <xmx:Z6jGaY0ssW37RlpAqStVJhhQw7aJAcTVvr469IGsLq_6ObDK_7AjFg>
    <xmx:Z6jGaejzCIm0y4Ceuzepv0uuf3HVG6C-wrMQNVTtKdJFQragdkbCNw>
    <xmx:Z6jGaUZdvfUNJSdmhHHX69qiT1EdKNkdGG3TirogQunNN353lcNiPA>
    <xmx:Z6jGaUSZgUJ_LQSPDuTQDQ3PAB3z3b_7GhyqPec1MfNrlkLE3QbNFURl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Mar 2026 11:55:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Michael J Gruber <git@grubix.eu>,  git@vger.kernel.org
Subject: Re: [PATCH 1/4] revision: make handle_dotdot() interface less
 confusing
In-Reply-To: <20260326231415.GA420281@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 26 Mar 2026 19:14:15 -0400")
References: <20260326190243.GA412983@coredump.intra.peff.net>
	<20260326190444.GA415796@coredump.intra.peff.net>
	<xmqqikaipf00.fsf@gitster.g>
	<20260326231415.GA420281@coredump.intra.peff.net>
Date: Fri, 27 Mar 2026 08:55:18 -0700
Message-ID: <xmqqv7ehmfmh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

>> And once we accept that it is inevitable to make a copy, everything
>> else falls into the right place.
>
> Yeah, I don't think there is another good option. We can drop the
> "const" from the interface, which would be more honest, but then callers
> that use string literals have to either make their own copy, or cast
> away the constness and pray.
>
> The only "right" solution that avoids copying is if all of the
> lower-level functions learned to work with ptr/len pairs instead of
> NUL-terminated strings. But having done that sort of conversion before,
> it ends up quite messy and is prone to errors. Somebody is welcome to
> try tackling that if they want, but I don't. :)

We would need to call out to a library function or system call
eventually down the callchain, at which point you'd need to somehow
come up with a NUL-terminated equivalent of that <ptr, len> pair.

So I would avoid going down that path, unless the language itself
has already abstracted that difference away, and C is not among
those languages.
