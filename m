Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21682F8E81
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 03:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788839228; cv=none; b=EUJenlif7xE9MUGy0HcaSPsAQ/PxWYoxVBclpcgi8uG65UzakqOdA5Llza3N3kNSrQCyKU5c0fA/3s7/eqVdQjtTQhNUYWGChn9QVR5PJr8mI+nsuiY22WozrivINpQ86Y/qog8q2Otuv26oZ/3XY6bXAgUQF/drxjCqKl0W6D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788839228; c=relaxed/simple;
	bh=KcjBlLPVNSbtIC4XxwIHJEk/0hszm8EHIIyvngZPsvE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LXMhlRN9rjCzogSPjomCAi7EI1QL3qicfHGZFTM+WezgAzg4sW/5FqZVSL9IhWnI8eNzUOr3P4P3+nf04pEgk2omco7xQCVFn1XludlpZ3Yxbp7CiFPbpcGYwVJeCNY/KeCovupKIG/0L8N97gWHg8FM7UPrZ9rfUR6loHFnAxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hEdJGY2a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AQimISYJ; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hEdJGY2a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AQimISYJ"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 307847A0047;
	Mon,  7 Sep 2026 23:47:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 07 Sep 2026 23:47:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788839223; x=1788925623; bh=XgR0uWeDsp
	bd6uDNZD5m0oVks1ROKi2Us6jjes1Gf5g=; b=hEdJGY2aefCrg0XhUuORnqKl74
	kyp9E19TXg23BuH7NC14x1PGBpWechqhm2ktR8umKnzKtIA2SFnMuXostIckKBap
	wFLRdwcRjgHPf8eSEw5LRMYy9wrGzOq8GzbpjIWbmqvLQqDTXa2Ggdd1Zo56Uzc4
	hfgQsMoIb9QvO9Rb0b7TkNjmFRIz+FiPQ9GUOSDWpXfn3oAMfmHLOGWhwZdUxbc/
	0yZhRgg325k4nU/pLeK3rwuxEwoEvPBt3TljHX32xqgz+1HbuEi4yNkGbZtSi4Sr
	pa/zstdvCxAwwkz0LuOe1YlanVFpAb+OQNxagKI3Lt99mohyi3X6NPq+s9ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788839223; x=1788925623; bh=XgR0uWeDspbd6uDNZD5m0oVks1ROKi2Us6j
	jes1Gf5g=; b=AQimISYJILx+ZECdqiAUroDt41AQoR5PTzy7UJlZDP/8NYQtet5
	GBnRL8aEMyXoC7XX9lQZ9mgPyixFc2vBaIoJFADl1ncTYsL/7pl8Kpojsfyb/ygk
	e4nSnhD+tlMOsA2atswy+k+4uOiPWGuRNiD3c6FPpkyrQPcl2ZRqW1ffL76A2BQd
	UHWA1vBvAow08GOS7npZFGoG9KPPIUCj0mAwrKDD2gBevavmUELGpswc7WDqmv4H
	AkC44bAtbQg57yD4k/E8Dxp9QPBBjUfRt0PfOB1b9OJP1uCFNk88cKwkfZYOq0Ni
	KfYz8IEgKP4HZYViFBoNk2ZUiaIwxHy2XxA==
X-ME-Sender: <xms:N4Wfao6KOJ5tY_yQeNV1Y63R3qvzWZQLWk_vaOJYSAbmopfHi1za-g>
    <xme:N4WfahWKSLsVDbTlEmsWrbJcXL8W0zbDbCnLAvd_YWyv4r7tE1wf2tmz1DXOhOrOf
    0ca-TftQj36zkkYQ57peMSUoOe9Lu1wZyvqzZAV6hRU4vN8d4pd8g>
X-ME-Received: <xmr:N4Wfak2xy58hJ4Ca0kN5BwhI6FofgVh5wHnHiAFpHnMF6jCsALqqn_FHURRvegZINhu3rDZWxd9wW-_pbV7WL4t5ZvVCHrR4EyDu>
X-ME-Proxy-Cause: dmFkZTFgbuRmi9K8/f7MHUE1WD1KLa9CP7dzPPA+P2LfhSQFklayLDaJOcrfNIQwxIHco4
    XMNiuRZ7iu15W7+mglESE/OekPrUh4zhriXc2zhXi/V9L0TraMQR84vmrkKaYNWgHGelU8
    tEXGgehtTh83JV6+yczvAJLholN4cU7cSolrZwhSK7LXMT0bhTkFAPPARrGaa74VWF4WlN
    B47EOjIGPZv1JQiN3hOkKQCWG+dV01L7k6ASrEwXLRw55QvqhsF7W6Cxc/nbVFJeMl55yP
    KpezEsQMa+y8UrsM/Vv3lUdfXlVg3xxS0z8sP9oVcRWynlIG3FobqZngZH6ffnFH/Z2hJP
    rULDc9SmMRQE22l+Ql5Lod3dA8GX9SkbmYkPGuIqw4H0H6bnnfl+JI+1kofyahd5PmBQ/J
    kB2iQ5ZQ9c/jc5pHNq4xtqZAkI1T0IxdtIwN5e51DUh3hvyKnXeH4/6tVXTJSK+S2XFXcy
    8k+U/EhRCvoVJKzXuzgbszyqzwezuWVaYDK3kC+CXiyeZqShQQyd2Nf+La5rM1Tc/PuRIi
    mj3MF1Ry0zF88kPSCdEQO/2Z1ZRWOqz3QlTR3e1nk5JTvxb9ErkH1/Oa/ShHXKxx9QZZ0B
    vSldhlnl1IvyyX2bhs97lbGp6iFWdulwfuDAQEGGnahWMCfFz0IbFK+NLgpA
X-ME-Proxy: <xmx:N4Wfam0vzCw2ckc9gaZMMNzEzkkABANurbsWYqTdgHz604xnCHn6DA>
    <xmx:N4Wfav-aaS48sAMO9KnhBF_0R7w4NS8d5eoLG7GYggG_RltOs5o4-g>
    <xmx:N4Wfar2Z3bOIZT-5mPKZ76dT9ZzPTBRTAKM4bgFt1oEj0j7Umr3rrg>
    <xmx:N4Wfak9Nibuz4XWcg8STTqZQVqewgfZ8GLK55smafoQjJmgOGDUTsw>
    <xmx:N4WfapXAimhgifhtcYjZO6McS_9I-pY9bYr6pNvEe9Yu4I7dL7XCbTTn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Sep 2026 23:47:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aleksei Sviridkin <f@lex.la>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] push: fix --force-if-includes when remote-tracking
 ref has no reflog
In-Reply-To: <20260906165052.21780-1-f@lex.la> (Aleksei Sviridkin's message of
	"Sun, 6 Sep 2026 19:50:52 +0300")
References: <20260903010547.85469-1-f@lex.la> <xmqq5x0mfgyh.fsf@gitster.g>
	<20260904124433.12840-1-f@lex.la> <xmqqzexx58hc.fsf@gitster.g>
	<xmqq33vn5hsq.fsf@gitster.g> <20260906165052.21780-1-f@lex.la>
Date: Mon, 07 Sep 2026 20:47:01 -0700
Message-ID: <xmqqjyowz9oq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aleksei Sviridkin <f@lex.la> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>> Which suggests to me that gc.reflogExpire or 90 days ago would be a
>> lot more reasonable than year 1970 to use as a fallback cutoff date.
>
> Entries older than 90 days do survive. The reflog expires when gc or
> "git reflog expire" runs, not on its own, so I could build a branch
> whose matching reflog entry is 200 days old and still sitting there.

It is only true for those who conciously disable the gc, isn't it?

It all depends on how hard it is to recover from such a failure, and
it may not even matter in practice what value we set, as it will
become a non-issue once they pull from there or push into there even
once.

But in the context of discussing what the fallback default ought to
be, I somehow sounds more like a poor excuse rather than a sensible
argument.  Doesn't it force a behaviour that would happen only to
those people who deliberately choose to ignore cutoff and who are
willing to spend cycles to go back to the beginning of history, to
all users, including those who do not make such customization, no?

