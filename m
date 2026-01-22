Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B38E3C23B2
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 21:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769117825; cv=none; b=WeouUARQgXCKIBT4GG46NYXLq76USGgTmsVnMQuwMQQH8vm+qx+2d0QbGqujW1bT2j8s+JokH/v3Z8umKlSZU3OVJTEjLIy1SFgWnj9T9cYF84RFDKqFODUesbjzJ3A5WPXo0jxGcHyzHV+QqRwRYO0xItm3Yzrqaw8bWmI7WFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769117825; c=relaxed/simple;
	bh=9IOWc/V3MRiQIaHiBUDcVsRFW6AouwOiWRt308+HYmk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nBudfqPNKJsWBoKRp9K+d4VxJIuVVYdI23/W+jzU9YJUAbVg0yad1FHDNNYiZNDQsc3b+RLdi0MOtsbvZaQB+F7KjKMawYjKeib9iaiNTxPQVzHNBR/kpR5ZixrfDK/6oN0FBXzUI3HDfkm5EZ2/3T+JSgYj+X9/3lyf1DHdaN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LseiuD1h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IqFb49QQ; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LseiuD1h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IqFb49QQ"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 266BBEC0F4A;
	Thu, 22 Jan 2026 16:36:54 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Thu, 22 Jan 2026 16:36:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1769117814;
	 x=1769204214; bh=fYr3oUJ5IlQ16g+0a/0X64iaOwLKbhbZYha9uSCGAWQ=; b=
	LseiuD1hnY56f5I61f1zb+VKisfIe/CDFEbwUgmzwRFIw4F01RjclDomooGhJGuU
	ikERFpO0RtRUfFwSNVorLpjh2PVmSfM31LjLY1XJJLV4My+KRPeQlNbJYiOSYyNc
	+LrI+4UE365C4U51VGLnU6SL6m4JFNVwbOrLgNrq7Wf57bc0iKSF0MvypJfpZ/0u
	pQ9QG4yPNEHwG3BTzp+zJ/CWD8JEi2q0kX6ThmFCmjwYnytCADNAxmYtUdXF03JZ
	VScJv2q514mUsh+aFgS26dA0+BPiaMCju9XSyJvUx+uJZhQFFgbs0BDMZGR0ebUK
	OJICi6FSAHNlUEuZ7tfYKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769117814; x=
	1769204214; bh=fYr3oUJ5IlQ16g+0a/0X64iaOwLKbhbZYha9uSCGAWQ=; b=I
	qFb49QQ/8V6LssUkpyutwEf6hqDika/hcfpGXZbeF5KSo6OZMt+lyLIUPGjtdkBB
	rcsqNdol8suSeymeG+TBJGHD8bMpNq9nqtTJhUbfR1XOsRryz3PSe9b3lSGQiLJU
	SKHpNnAkiISKkgihhMcN5ITIpzjvainn4eqvrmYaCaKWFuqBvMD4ZvtQ2rWntLP4
	boIPdF0efRKqpQUj85aBIJg66zEda7qDyuYO3ijpgLcYxSrJfaJZ6zr+UxTm1jAH
	vJMurRsAia0ABPBeYvPWUwWWLXmJO4YV+uYVYgt1nEV7AOMfIUMWf9Q9VwqDHgXk
	ePNShwnY2WDvVEkhq+zTA==
X-ME-Sender: <xms:dphyafwnylq6Gia4g5EsrEhzmbObywI_iHrK8DiyDws0moShEX4Dwg>
    <xme:dphyaeQufg9QWk5hfP0qSIlp3mb_pUFfZXLWWFyLmOtsUlC7CGmhOwtEzSEvGPspp
    VcOQ6CyeDZChpD4ft4qSfyC_HPVGQPTNpiWzufYB2V3UB7v4UFx1A>
X-ME-Received: <xmr:dphyaeXc9FayFuBkpK7FCKDMSU7B8pt8qFneEn1p8kUbOFOYHiQ-kg9ALFA_f0FSjzvSzuV-nTmdkMrhk6OhyZKP5eaVG9o269i9qgs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeejvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehhrghrrghlughnohhrughgrhgvnhesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:dphyaYbZ8xaN4Y7P9XkFBW2Z0wzI17n_Mc8W_6K-6f2Hsb92n39yDg>
    <xmx:dphyac03C0RPJKlLIP9-woXlncJ2YqmKUByOGvl4fQAvTcOglnBobQ>
    <xmx:dphyaSg-e5KGQRgXnereYpvaEsPfhM1LXh3cTjreNZUoxecp4opkSg>
    <xmx:dphyaYZ6HJ3cKpGn0sKW78ODABeqUPCLlqqm0FZ-qPY67-IMGoz6tg>
    <xmx:dphyaV0zcot1I1jLj88g10WHnjF3QkExgDRFSxOM_k5aPSthiVzXPzc0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Jan 2026 16:36:53 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org,  gitgitgadget@gmail.com
Subject: Re: [PATCH v27 2/2] status: add status.compareBranches config for
 multiple branch comparisons
In-Reply-To: <xmqqwm19l5du.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	22 Jan 2026 13:11:25 -0800")
References: <xmqq5x8tmlj7.fsf@gitster.g>
	<20260122205632.80273-1-haraldnordgren@gmail.com>
	<xmqqwm19l5du.fsf@gitster.g>
Date: Thu, 22 Jan 2026 13:36:52 -0800
Message-ID: <xmqqms25l47f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:

> Harald Nordgren <haraldnordgren@gmail.com> writes:
>
>>> For example, writing "v2.52.0" there to see how far we came since
>>> the last release would become impossible if we always force prepend
>>> "refs/remotes/".  I wonder if we can reuse already existing DWIMmery
>>> that uses refs.c::ref_rev_parse_rules[], which should allow such use
>>> case, while still allowing you to write "origin/master"?
>>
>> Sounds like a follow-up rather of doing now, right? 🤗
>>
>> Since the inteface won't change, just adding more functionality a new
>> feature, we should be able to fix this behind the scenes later.
> ...
> So, no, I wouldn't recommend it as a follow-up.  We should decide to
> do so now or declare that we would never do so.

Alternatively, if we remove the "a string that is not @{upstream} or
@{push} gets refs/remotes/ prefixed" altogether, then "the interface
won't change, just adding more functionality" would become true.

It is not my itch, so I can go either way, but I'd prefer not to see
us take the "declare we will never use the unified ref DIWMmery
rules here" route, if we can.
