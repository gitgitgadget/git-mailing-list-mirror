Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9F01547C5
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 21:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736975644; cv=none; b=r1c3SRGH0AU6EsAnLSYJi0+AOeOa94ojC5tLfbFQw6pZMPNmOtRjEviB4ERQYHxUffrBlvoMdjvjdfeWl8xJqb9iGRfCqeEuKVqVQp9aV7gr508UwVd1jFKOiJnfa8I9QrCLMlA0La3SeYjLOkcQ/IvSLHl8q0hjoOrXgJdsGVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736975644; c=relaxed/simple;
	bh=tOgqLtff0CTn9kefeTnoM4ZM79s3nukQyZMfFeZBBD0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HWyx2F+k2V2ZPS9o8kp+OCIhWdKsutHtgGKyldTYab+WyhFVdFWEVjU0jsRQUn1n2am+jD02Y5I+eNsH61WAUdvu0nth4NEyVPaGMrZpR/89Upt8qZPFFDkU05ClGG0+X28YQ5mkfBUycKFneKd3Muwi/9+DU5aJ+pxArXAGgYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lEvphjWV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aHxOHDNn; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lEvphjWV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aHxOHDNn"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CB2EC2540188;
	Wed, 15 Jan 2025 16:14:00 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 15 Jan 2025 16:14:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736975640; x=1737062040; bh=T9NlsdI8T7
	uR6V1lc4CBevvZo9alov046YfD0/IMeMI=; b=lEvphjWVhBdfTPPsPLzojIiYBk
	a2m/E/mukzLcgoVClL41SkrlLOYeJbbVqalirOlluYAecp740nAHgBkbT3AUPbz7
	Ql/WxrOqScgy4i8S+u48fD4p+FYV+qbCI1fu3FSg8yUnorEFdPwmiU2COIIXuKcj
	PNtdJqbZPc34YhRIoMded8rehQ8W489gXHYhXkiTW2OJzCLDl0XMS5eUyq7eI7NZ
	Ad/aTsRvVby+dB8x4oPfbbWuRgtoR3VFkqQa6HFmP3kxzwXki/WThTPzSBirskof
	vf8BsdWfdKGDmwxHL8/gj/gFTqrkpzQIOcod7l825A0E7aJPzEVC0RWnbv8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736975640; x=1737062040; bh=T9NlsdI8T7uR6V1lc4CBevvZo9alov046Yf
	D0/IMeMI=; b=aHxOHDNnOd3sMTPcoYXYMK5pS65/32lO00R2359ca1xqKTcsK5t
	0bpoQNrWU99eoD889EfpPB5+9e+l/n97d2ld5eHU+aVlbr65r0QjmGz1qgWYqm0v
	ac93nkmyBBiPybXrHEx4XdDdOKhuZZLGLOTstGLFGzP2W36dDZSixlgl+17QPGuM
	ZiOK1MjUe9tDVgMN4bVOZ5KR4S3FnfPkkwvdS9vmgrPQuSHVStmkQfgoj8MSb4Y7
	AckIthnhoBSNVzK3tcHMsAY8B3FzIuTNjDNp7UHbqGJyPF1CpakUxBlppQzAcrc5
	X0Q5neEzDfAy747cjsC85W6DMy0bMI4kgFQ==
X-ME-Sender: <xms:GCWIZ8LKX5I_m2X4bJsiGYexcOf8dVLgqqKbq435Q5umzlBhpKZsNA>
    <xme:GCWIZ8K8wdEVtTWlS-zoCUyXRSK_H9rWdMhXt5t_1Nxt13jthxUq5otNj6O7e0dwk
    Bw5q-I0WYhCKmqlJg>
X-ME-Received: <xmr:GCWIZ8sCTJUtuepKvIC86vN_NSRyqQ55MfAXtJgUCqQEpU3u2ressOHwUh6Gw5NjvKBoZwmISDR84kNtfrYcWQW7kP3Y2oIRenJS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehledguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffh
    gvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehpvghf
    fhesphgvfhhfrdhnvghtpdhrtghpthhtohepmhgtvghplhestggvphhlrdgvuhdprhgtph
    htthhopehjohhnrghsrdhkohhnrhgrugesuhhnihdqmhhuvghnshhtvghrrdguvgdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:GCWIZ5b-5r02Tsebyvxc9rM8xByIn8JQbr1lfBjgNQRRlVUdZmTZzQ>
    <xmx:GCWIZzbuoGYPShdxL6Pg9UgxmPUcazHTbXyfJb3KeoKBUmj5uxRZGg>
    <xmx:GCWIZ1CNODegXfvtR8avIDBhC6zvdHM69TBcqZDXceCx8j3dLTI6vA>
    <xmx:GCWIZ5acZ2pvzVZcertF_0STUHQxaWgm3BG4NxN4z1AQXNB0chB1Ng>
    <xmx:GCWIZ4NkPTXopp9vWqOQI3aemSTJSvQu0A8kIY1kfdyYtKyvsctxRGVu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jan 2025 16:13:59 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Jeff King" <peff@peff.net>,  =?utf-8?Q?Mat=C4=9Bj?= Cepl
 <mcepl@cepl.eu>,  "Jonas
 Konrad" <jonas.konrad@uni-muenster.de>,  git@vger.kernel.org
Subject: Re: Git branch outputs usage message on stderr
In-Reply-To: <a543c92d-215a-4cc1-a7a3-bcb34c62f33d@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Wed, 15 Jan 2025 19:33:46 +0100")
References: <04cfaa3b-847f-4850-9dd6-c1cf9f72807f@uni-muenster.de>
	<D72M6S9O1E9F.WVEBV7ZJ1JTC@cepl.eu> <xmqqed1414gt.fsf@gitster.g>
	<c92e7b16-b70d-46f3-9858-2be805c5285f@app.fastmail.com>
	<20250115171423.GB57018@coredump.intra.peff.net>
	<xmqqmsfsx8oo.fsf@gitster.g> <xmqqikqgx74o.fsf@gitster.g>
	<a543c92d-215a-4cc1-a7a3-bcb34c62f33d@app.fastmail.com>
Date: Wed, 15 Jan 2025 13:13:58 -0800
Message-ID: <xmqqed13ye3t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

>> and replaces it with
>>
>> 	show_usage_help(argc, argv, usage, options);
>>
>> to help correct code paths (there are 40 or so of them).
>>
>> Suggested-by: Jeff King <peff@peff.net>
>
> +Reported-by: Jonas Konrad <jonas.konrad@uni-muenster.de>

Not on this patch, but it would be a good addition to a follow-up
patch that uses this new API function to update builtin/branch.c
(which I do not plan to do myself).

Thanks.
