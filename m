Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437D131ED7C
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 18:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791483135; cv=none; b=TUAdLTcM2sW0agCb8nTSxalUnhzTOKoBo9NmBKhSCQml3CYBLM4xB9gBwCsE1z5C437DNb/jdePuBUz1DiJ6lMUzLfxK2oghMbYYlPvfXCN+G7nG+SmWV96ysQ7zlj6yblWHXzzGhQp0rA7JHNMx10p2hmmQZRTsZeO3tJN/cQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791483135; c=relaxed/simple;
	bh=Sldq26vFnDAiWpBFkIUUFlpoIlq88pwqhUMhQvI/u+E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z42531I1FhsJ+Z+3uYsdRtYowM1rc9mZ1Bh+4WuhvzOjR6ic51C/7A8OOaIhrT33so7Co/3KJv5ZePw6ujS88O1PcZgrWY+rireXGStD9mX8b+TOoGaL8u6uEDwpaEZWB7ZiBk3zQJO47T5CEwd+gTH7FP85TMjXacfEouePuOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=S14Tqrw5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LA4IxtIN; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="S14Tqrw5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LA4IxtIN"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 798327A00FE
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 14:12:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 08 Oct 2026 14:12:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791483133; x=1791569533; bh=2web6DBvPg
	+aeWz7XSTHQJwIehZLp6yy3MiIRE8KxZI=; b=S14Tqrw5X22VM+F4yazr3SgtbN
	GaIHR5EHKyiNIDIZ+0289Zk0DAI/1igBevDHmtZSSR+vUcf8ciVt6vuEX95CXtQK
	/9DwvF5QzFep8bqPLH7VBLsntaWDnyoNyjoArQS6Hc7+ggmxdq6veLd2DMscG4rs
	EbNCks6puMer5fPGfvUzYPWVKallvhFaECK5ObmGYDVU3mhWz/D+wHSEbc+GSVOO
	U9+hT0C+jEYa416jEAxfNB99RrEy8nRYA0S6bty2xtonwDPu75Hu4UaPbMLjQa4T
	Lm4oKrhXdsLhvfvOnqrF5+LyuTKp61so+DFx1wN8T36WgZx0TepqX4sZ3WGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791483133; x=1791569533; bh=2web6DBvPg+aeWz7XSTHQJwIehZLp6yy3Mi
	IRE8KxZI=; b=LA4IxtINPhrnR+ru/gGOwzfQwLkeWUd54UkwozyQ7pzZCHHsJeM
	oCdoB+qKhRsHkyMQ+2VVyoTrT39VAEWxWvHyFknlOYC3oxsZJLee16C695Ccou09
	bxjwCobNC8S9FXpCgMV2I3SbD89ZKWN8/0/3oMuKlt1JF4qTcB3lLFU2bO+m6I1C
	xsXqg+FvwRkGH7iB7URDDhO30u08hdR7kHT2crkneNRPxeT2SSPvorb0ZV87EUuG
	GpKQq1Pho1I6NYbIkr04uX0r5JXJxhoeaGjr7/s1WPHbfTLpCRgrfNpVaBPAOPU9
	qnYEm7R+WPb+skbLfI1QtlBSX0KPYRugZxA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791483133; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:mqMxuDGTx78xRrooVCOPUAfQHtXXZO4iGJrnx7NQ9Te49/u
	QXgHk0w6pd7GQpfbwe1qdhX68lpfgkmfv4W7wxWkpkwfCtA2RqDKNOfkh3bdcPPm
	ZwEIy1NUKEKbt6pNuGlRbaaY60q7zg+SzKvQmgeTLzcweVK7mXU8Egy/Sjvxey1m
	qgfIog/JQUbBRUc3dWEfLiFjpVgKDHPSsOln0kKDXB1IIc45aj822bacMFz1dtSL
	i9OWLibWs1PPqJCKzzuHNi1QAhhx2SXwwoA1gV7M4E7AXsHRgB5vYBZMZMfanqfW
	9Gesct99HSAUZ5c/sy0gxl1sfHKX7Y9EkVV8q8A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:jSnOiNmfzaVtbXNV6iDxaSQHcbYtvwxEzZIbfGgTUnY=:Sldq26vFnDAiWpBFkIUUFlpoIlq88pwqhUMhQvI/u+E=;
X-ME-Sender: <xms:_NzHahVN2YgZeMHsNlo6Y-5nAV1D9llXvqu43Hg2TunwvnAYdLrF1Q>
    <xme:_NzHaoeWT-Cm-ZjScGehZfRW65h00rXagPhPjDSojrxKPejsvGOEV_N13f1gRJesY
    GkEXnpdbTzZPa-jqFpWYPxWLccZ2zr9djdst6zamMeMGQ10P6wURgWt>
X-ME-Received: <xmr:_NzHalv0pnxfxS_lvwTNawmllGF0n-v9Xgd0muekVyB59_59RyeWoV65J2Sy7wmkK-cjQY65Yt6B0Aw9zy2PtBvejn1qxpzGHl7V>
X-ME-Proxy-Cause: dmFkZTEEpOPSdr+lZ8kWfItkmF7CsYGtT2XGo+dki53K5vqGC4BD2V/F4iUlzvqSPNm+ge
    3Ck2Aakufhb6odMJOaJ5nCX2mQFffFZ/lfpJpenVmw8ClxhL2wv3/3LfGCwaSbzNV1x69M
    sMrjev1cTOZ20J8ZIgN2AB+8SVWUJWS2osSdwo4bA0PCXes3e/C7iF2XcurOMr42xxV7Mg
    UZHhnHOpYajo9Pskjj2IkqFXZnU9qT+3U6dWrVzbSzr+4mJSPs3n72Cb8WijuFdHZieSam
    J1FiXcf5SnIxBdYRkQpwBZguB9X9wC2FN/89Bq7up0v3blWQj9cx0YgSMT6mB5N4FHs+HN
    iJZU8F0fccPtIIJhYQBEJ3TrJjF/aT6qqvyTKFrm2arjGFiZv+DSMFgcAm4wHNODv9jLHg
    mpoNgX9Jh0Mvg5TrH6hm/u/0nTW5jBPzgoPju4MbbHxXt39JVYRP+ehr6kmHPJ9Mz/1+0D
    IzbOdnHKFK2H6BjR1nPFFuF8f0NdhI+b1gZOGlMC9uHPgBEwk2wjBbpTKfWDeKA1UlJhaW
    FJzI40sVgbHEAIQXkaLytna32uK/XetGQY7nHvtAd2m7yUj1w1Yg3EIkeba0eAnlU4/3jw
    +z6bLzBmV+VyYmVBZG0A0CTeOny0vO10hjoYy9KY83iHwsSNLJH6VtK/agMA
X-ME-Proxy: <xmx:_NzHav_2JMZ-R15kNlKCmJtnVkeu52h7B6LqcqM-MtCzW98wk7WKTA>
    <xmx:_NzHao0B0J0SkbjukRbK9Krcimt_rbEn8Qg_RVils3AT8uqT36TPdg>
    <xmx:_NzHasCw7criIvaqdIUOKUyn8sH2uvxhaInbQlI7hO796LvohbdlXQ>
    <xmx:_NzHascJOruThZ9uYaXb3IeqSgxoCsxY8Ol5rEqpwBijCNZI4HiF2w>
    <xmx:_dzHaqnka2lHQA8LI7El80rlCZhs3Pn2l73f3TP0ja84vs36MrsA1W5Y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Oct 2026 14:12:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Todd Zullinger <tmz@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH 4/8] ci: switch away from unsupported i386/ubuntu image
In-Reply-To: <20261008150336.CzZS-oEZ@teonanacatl.net> (Todd Zullinger's
	message of "Thu, 8 Oct 2026 11:03:36 -0400")
References: <20261008-pks-ci-housekeeping-v1-0-baf015c589c0@pks.im>
	<20261008-pks-ci-housekeeping-v1-4-baf015c589c0@pks.im>
	<20261008150336.CzZS-oEZ@teonanacatl.net>
Date: Thu, 08 Oct 2026 11:12:11 -0700
Message-ID: <xmqq4iew12pw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Todd Zullinger <tmz@pobox.com> writes:

> Patrick Steinhardt wrote:
>> The linux32 job is used to exercise Git on a 32 bit platform. That job
>> uses i386/ubuntu:20.04 though, and that version of Ubuntu is end of life
>> nowadays. Furthermore, Ubuntu has dropped support for 32 bit entirely
>> with the 20.04 release, so we cannot easily upgrade it to a more recent
>> image anymore.
>
> Should "with the 20.04 release" be 22.04 (or whatever
> release dropped i386)?

FWIW, I read the above to mean "32bit support, together with 20.04,
are now gone", and did not feel any need for rephrasing.  But
reading it again, yes, it can be read both ways.

    Ubuntu has dropped support for 32-bit entirely, together with
    20.04 release, so upgrading it to a more recent image would not
    help us keeping 32-bit support.

perhaps?


