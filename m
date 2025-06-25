Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141297D3F4
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 17:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750871593; cv=none; b=kEwfGBH7QCGlPzqSK+6DPq2pcb6cewtlxukSC8RVNHqIEMwe+M93ORevZuAa+Awfz6LgViiPjlqEdYGbFXizEWncYy/Rf2MX5w3nyEK/Xfjii0qtL31EEKOH9mFQfHZ2ScprYkHEOgTn6FJ2KB4O0hB+9VOJYgEwU2D8mnwHS5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750871593; c=relaxed/simple;
	bh=s9Gdoit/v+53X31C0w+aQwJP/ma+0zcx4qp67wIIP+o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SAwFAAUI+haVJ9LStgGl+8xE8GTNPmqH/8GanBUuEKabw4wfr+NFgP1l4s6MPv9N1pbIb5LoX7CQ6eyBi8izT82J/Odxnq1H7ViQtIENQHmmOFdVPTVLUwVz/dZgOGlq7vLltjRca7rnXVhI1rtfhoSnORpcRvi+uOYbEapfnKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eVqIgDwh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CkB3UJ8Q; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eVqIgDwh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CkB3UJ8Q"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7BA1214000C4;
	Wed, 25 Jun 2025 13:13:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 25 Jun 2025 13:13:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1750871588; x=1750957988; bh=LX9r2RwnrY
	5P+lB6Ullk73vDR/9WO/BF83waw3P3V4E=; b=eVqIgDwhoqEA3QcSBhY7bIWJ38
	v2N3FnwtPeRAuTtH9FKTdhjQmvxxlKWLriYp4GGOvx6BEq9Y4nzGNgVBN+3GTRiO
	tXhwCpVRGg3XqcI5DFi8sSClQh9iIwNiAe9ka4dY6R8JrzatgbeqaP5il0Ozr0NO
	a5ouAki/yeUB9FoxGfDWkH4wMkaz1Oi2vl0KxoxR4XJ3VpDSsfIyEfJ3+gIjE9Ow
	LF/4LjvAnHAAdTv3beJsyXbGVmQF7vETBoT+kCY3iRM3B/WCRR3YU0x0rnOmK3yD
	XkO/GCZKT8JgAtytIRB0bfd761z9XqTWsn1kztQLScFvolDyDhlPUinPSNRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1750871588; x=1750957988; bh=LX9r2RwnrY5P+lB6Ullk73vDR/9WO/BF83w
	aw3P3V4E=; b=CkB3UJ8QK75huq+tq+s5KqLl9V875/lK0iUDOEPB7TlfQJK7FJQ
	zpnuQglZ107p5YQ7vtBm6Jgid0dZE2Z/u4uqsV6MEwDK9Ncwi0bL4+f8/60QecoF
	gbNfph2iFIQSytRIX3+Kkoe55LPVvyAGK4QliL3lMQUmmGa9p4Ct42OGXkeJRwsq
	sZgQsvvKo9O/qKmcln2bo8fvZ0tAu5waVvXYvSqOX7icEUBw2oZ0oUKECOuQLcxJ
	KAoE5Lrq7nwHh8GW8C1SgXPMG6dEzHuJugZHTIrYXjSgig4UpXGP5HpMUjzbHdhy
	0H8wk0KcKMVNZK27peS0wdPYaErelaQioBg==
X-ME-Sender: <xms:JC5caL8tmp8jzFsi2xBygZC8iak9qmjn8PZXoM4RzvVw-YM8nvNqpw>
    <xme:JC5caHswyY-9WiktWnUHDEXj2SqiXx0wFlS6wl-RF-LQwslAgNvmDaLJAZgGcMHvt
    W_I1Zgn789hHzKHWg>
X-ME-Received: <xmr:JC5caJB-_ExSDhOuxgrX9sV4CjxGNh20HPTazXCFYvYHBdQSp0mNN7r4VY1_WB7wohWhurdyUHD6A622eYgna36zBrzE0HuLngxRgPI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvfeeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevff
    eufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephhgrshhsrghn
    khhhrghllhhoohhfvddtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:JC5caHev2nJ9hiaNoux0WJS85XWr_rwzM4nxBIgt0NphYeV3NWc2Mg>
    <xmx:JC5caANkuZBKYbIrMyj9TP9wi6pSkmJQP1B3udXcSAslp8iORVuG9Q>
    <xmx:JC5caJnjdHwRh1VLY4OBObwyIf16DDQI48mvQWd6t8WITWs9WKwt0w>
    <xmx:JC5caKvv6fP4FXhB4tGubHQF7x6Yygsbc-3F3ABJneSlOdkrXCU5Bw>
    <xmx:JC5caPbjbJ_HS6ABwIOHTG8gCsjl1uaqp5y-xlhKG4gVAWXNM-e2at-7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jun 2025 13:13:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: hassankhalloof20@gmail.com
Cc: git@vger.kernel.org
Subject: Re: gpg signature missing from commit f0135a9047
In-Reply-To: <1678ec18cbd52b8714034cd86a44d17c84eeee0e.camel@gmail.com>
	(hassankhalloof's message of "Wed, 25 Jun 2025 18:41:52 +0400")
References: <1678ec18cbd52b8714034cd86a44d17c84eeee0e.camel@gmail.com>
Date: Wed, 25 Jun 2025 10:13:06 -0700
Message-ID: <xmqqqzz7vj6l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

This is totally expected, as I do not sign each and every commit.
The complaint here ...

> $ git pull  
> fatal: Commit f0135a9047 does not have a GPG signature.

... is purely local one, triggered by your repository (or per-user)
configuration.
