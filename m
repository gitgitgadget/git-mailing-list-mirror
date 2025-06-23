Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90497227EB9
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 23:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750722093; cv=none; b=QsWbwpIod8rINbeW4cp1hB1HCihlzEn3upXZ+vqeBHEtBEaiTtEnQkvUSSoFZYqFQUbsZYEfWgzHRCcMzY+5ci8+AkMiXcbkwCQmzC9wtliB5xlGP1rPBT/YrwHMDxTpFfxM0AY1M3p0ZJjHxRh0hwNKm+QcytUdIFrYI4YKc7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750722093; c=relaxed/simple;
	bh=63pABfyMVuwriuIoRmzsKOzqJQxOFlh1tuyT+09uRaw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k9Jpcon12AY83t5MmfVpMphM+07kYnwWmWfrgXU2W7OUzAefhC3UDhDgJmofkZAJ5edcnNZrfFD4sFz5VLExqQbLnHsRWmXb+iKVfOfc/qZMp6B4N4+S1vhX1PpAHwpe0JLuoLa19nOcTEvF6mRP2om3ullV8FA6CfGxxOoqBQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XHlrDxfF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QXloij75; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XHlrDxfF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QXloij75"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BFF79114013A;
	Mon, 23 Jun 2025 19:41:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 23 Jun 2025 19:41:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750722090; x=1750808490; bh=29YSqHiwMX
	QVC1VU64rEStWsZYIfOtznRdHydBAEnC8=; b=XHlrDxfFPojcHbePPpRrd5y6cH
	NZhs8xhMckF9tpIRFVb7mT1qyk2wJE6s3hOXUM6I/6Q+gDZlRSA3NIz8dLYl98z2
	+8lEV6LLAYmsvoZteIZ0Jbybl1hrdYOUqzW+qIS5dA7DtWEx55NjCXT1KaIlEUwr
	8yuzLk6s1CewoSB03QlquHJ0aZZxeQKltVQdD1zBpuvH2vpoAc1goFEVPPVU8zk3
	oFuN88oBpYwzxtVSlLuAXuU7XjtkzOYOPWe542+qWJU6KPxvnjL4hl5b7Vrdgv8L
	2rH7fQkCg+SEH64ZIuen4ydrtkgxABY/m4d2YKHCxjtwz5T8PIB7jxGQ4KFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750722090; x=1750808490; bh=29YSqHiwMXQVC1VU64rEStWsZYIfOtznRdH
	ydBAEnC8=; b=QXloij75GWvJAF6LIAFDpvZkNH4p2bbYjBvDOgt/DWwmxcQ+5bu
	YRsjgxLRmAQRZGJzfjfgVoqhYUIbN66YTOizxSyUJKD3BCNf+yaEqakP/ANl6IJU
	fLew781Y4wM6ghNZ6zOTiIghOmZ83pYIZYKZuhlnZZBEmKay4FD6kAGLFgv0wepa
	953Pjw12Dh6c9AVYnrOdbgoZIT17OnlxlwiIWs5aIuYwpanm4zxsdlQ5T3vlqGcc
	MEdKBOmBMdrijcqb20oDtpt/XCZR0ykETLpongnpoHikukkpCmZkLPaKiHt0PKdB
	cfMFxRCqyZIdQgwC1xTMggkp3I38b86uWpQ==
X-ME-Sender: <xms:KuZZaObDSYkTWQwDuv95ylf183lsNzrgn8GEr35zezR3doVFCjtchw>
    <xme:KuZZaBYpZw4fFE_Z7LRotmhgEojUtZHL-SYmKWitudDzyQFmPd41OZZRBkMgcC94i
    -vbSQV5c6urU3wcUQ>
X-ME-Received: <xmr:KuZZaI-afrxiB0UJN6DnKYkhfQ3ENNloM8AYXWqHlp2eqMZu_hLqlCbFdUXBT1vahbrW_ifVy2MQv173IP5iV84m95y9QgQsjVN0rjk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddukeefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjrggtohgsrdgvrdhkvghllhgvrhesihhnthgvlhdrtg
    homhdprhgtphhtthhopehphhhilhdrhhhorhgusehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:KuZZaAq1e8NZ6RYmtGaYcumbw8Is_eT-pE1Xn7Z6Ol2KWqf9FHaMCA>
    <xmx:KuZZaJrVzi07fEXsh6qKhEOh-FzDcqLUler-zt-LQbB8ERcTswjJcQ>
    <xmx:KuZZaOTq10s2Qp64tFlpw4-uoQLgRxVjdkkbVPLOju4nJFiPbM4H8Q>
    <xmx:KuZZaJpsxfwZq_ARziS6JaO63HvyPXtRaAgR9U0_saz1AvTBh3v3-Q>
    <xmx:KuZZaMPS4T0w-AHcj0igtlu_CPei6CyLKEn0oi9PFTWn3TMFTk8hNtAZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Jun 2025 19:41:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Phil Hord <phil.hord@gmail.com>,  Jeff King <peff@peff.net>,
  <git@vger.kernel.org>
Subject: Re: [RFC PATCH 0/2] fetch --prune performance problem
In-Reply-To: <f11bf463-0005-43d2-b642-ede130d1f44c@intel.com> (Jacob Keller's
	message of "Mon, 23 Jun 2025 16:32:35 -0700")
References: <20250618211024.2332525-1-phil.hord@gmail.com>
	<9cc42f04-856b-4967-8668-a47271af061c@intel.com>
	<20250619033746.GA1801319@coredump.intra.peff.net>
	<CABURp0p4d0JPg=-cW1OZdFQJ+vNT_0PDd9Rv3oz6toFGqGv5=g@mail.gmail.com>
	<f11bf463-0005-43d2-b642-ede130d1f44c@intel.com>
Date: Mon, 23 Jun 2025 16:41:29 -0700
Message-ID: <xmqq4iw63u1i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jacob Keller <jacob.e.keller@intel.com> writes:

>>> Alternatively, the dangling message could just mention where it the
>>> now-dangling symref points at, something like:
>>>
>>>    - [deleted]         (none)     -> origin/branches
>>>    - [deleted]         (none)     -> origin/main
>>>    - [deleted]         (none)     -> origin/other
>>>      (refs/remotes/origin/HEAD points to the now-deleted origin/main)
>> 
>> I have a new patch that produces this:
>> 
>>     + git fetch --prune --dry-run
>>     From /tmp/repo/.
>>      - [deleted]                   (none)     -> origin/branches
>>      - [deleted]                   (none)     -> origin/master
>>      - [deleted]                   (none)     -> origin/other
>>        origin/HEAD will become dangling after origin/master is deleted
>> 
>
>
> It is a bit weird that this says "will become dangling after <ref> is
> deleted" because the deletion already happened.

But that is with "--dry-run".  Without it, presumably 

    origin/HEAD is now dangling since origin/master was deleted

or something, probably.
