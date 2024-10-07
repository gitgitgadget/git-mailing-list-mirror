Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBCD189BBD
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 21:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728335298; cv=none; b=Qj/4+Xgrl9RZmz5bJKCGMrlXhvsbmej71UaUwvhHXY0nS+L3kSjpUvtYod/JpgyJiaVohXGrzSpMUHG1ViN8sT3V2i0JsWnfcRx9XNQ+fuLkAMn96JdYJW9nEPRfZEY8+2enBP1fAaIdrO3RVK0lbNgLW50SnJRfwdVWZRoZfII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728335298; c=relaxed/simple;
	bh=wZdv3M+QxssZIwyqvjyF+ZgTUzrOMiz2GNk+oO7O43o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CEbiLN38cxQOlkgTL8pkz7UE1FtFkNqjw1RPfQKsfqRI+JxGvgyYWyRDm4cPzcDlso8xClRjOkPUKliCET9V75v0+UU5LPcK1j6IO3YqkvkvDRqRH6UeOytUHO4Q/ml3WEXlB/kyLInVxo5bDdtd5xnGvRfo8i6ynGjaVDxiUNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gHbhXYd2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oHo0w+Lm; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gHbhXYd2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oHo0w+Lm"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 6877413803A0;
	Mon,  7 Oct 2024 17:08:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 07 Oct 2024 17:08:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728335296; x=1728421696; bh=3czzPtbs1/
	kL6tuUgOdvKNhemXJHPifWvYOlVRjmW+s=; b=gHbhXYd25kg8LH6nIoaeNNxfZL
	sLkYapjw76Dk3v31rV+gexiuANx0hJCMV+dPjck+yOl2s0OmY8Wvr8yuj9VCnJ0u
	ug/X+Vv4OiEPLG+XQItj1ME7gZkYrRfH2qiShDnY4KK1wXkYze4SldHHveQWreuH
	o5pbYkSuyDEOYKvrfGN7tNcIDUn3W39PqOewfW75D/kcyrrcUvTxixZ9DFPkMY3u
	JaPvbaFdz8Bi3/qek3zr8u6gRUYAstbwv4tBs4eH59Ow+i7HB618YOslR2a8G58Z
	lD9LgdOomGLTURrNhZ9g83555qclTYAHQuIQtTCpMngtA99eWFJp1Us+HF3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728335296; x=1728421696; bh=3czzPtbs1/kL6tuUgOdvKNhemXJH
	PifWvYOlVRjmW+s=; b=oHo0w+Lmukfyc9YhM0FPbw/NEXNAsZ9nCZOPxNjUw33U
	M0KpuAmVHY5n0uB/CBkhyDnGCTqOcYWrv1cDwWsOeGY0l5tCzBmatzJRYnygs2KN
	tTOgY9n9plC2Zo/fzZO2KPvoHiHc2nbIoe1BXZN/G21fC/0zu/wzGIQYqXop6Obc
	WQofWvPcTRBC/hdpfdgW1ShfJxhXECgRPQ2V+HP+d4f3oL4R7DCsqUky0H9JVoUV
	6c+seyneP+dJ/T2VpCo/A2h0lx8l+dk9reBrOYndem0Ndrjvz4neDNF7ZkmRh3bV
	8NAEKTMPTh3lqMiVZL+SBzfPqkBGzM0o1GUsaxtdYA==
X-ME-Sender: <xms:wE0EZ0S6ZhyNX0xx9tNPKGCjFfSXJIJfXKeWnhRkwetd4Wh2YEApRQ>
    <xme:wE0EZxyDvFkutpmpt0-w_mU_Oo5ChoBGTMFOaLOM0_XJSRG0S-dVGLF5TzAUdBhlv
    xr85J2cCUI8ptpV5g>
X-ME-Received: <xmr:wE0EZx1TP7BhOdr4VZ237Oxjmb2WBBwAr7-464XJoLV0gx7uaPFaP_xggNYQSBd2yYt9Jx6BgPMRW5eg9Hvh-h8URnqJLDu0ppHlCHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledgudehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:wE0EZ4DdQfn43ZZ4quQZMmOhUOkT7tlh6sTQopEfVJbjwbHltS8wqQ>
    <xmx:wE0EZ9gTULwmA_kmiNeII4dBQWn2q1g3YKTiKyud76OM9V89iEfVGQ>
    <xmx:wE0EZ0of8ztgUtz6k0RcXinG-Czj59aGJjJpWG7UU1TMGp3c3H-yWw>
    <xmx:wE0EZwhgdmseW4IrH9qSnbmU7l1qSgal61FjU4OJdNfSKYpTmMUmRQ>
    <xmx:wE0EZ9fnAI4uovNEBKiZrfL6akPBm0_VWboGZH1FuTNcpVCj0iUIGyjT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 17:08:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Eli Schwartz <eschwartz@gentoo.org>
Subject: Re: [RFC PATCH 01/21] Documentation: add comparison of build systems
In-Reply-To: <ZwO1WlBDABVs0CRU@pks.im> (Patrick Steinhardt's message of "Mon,
	7 Oct 2024 12:18:02 +0200")
References: <cover.1727881164.git.ps@pks.im>
	<508e3783d284fd2d3bd4840907ed0bdc20bc1b23.1727881164.git.ps@pks.im>
	<xmqqjzeqmkwz.fsf@gitster.g> <ZwO1WlBDABVs0CRU@pks.im>
Date: Mon, 07 Oct 2024 14:08:14 -0700
Message-ID: <xmqqbjzv8vup.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> Are there other things we use Makefile for in our current system
>> that we are forgetting in this requirements section, like "running
>> lint" or "running tests"?
>
> I was a bit torn on whether or not to add "running tests", mostly
> because it was supported by all of the proposed build systems. But
> that's probably not a good reason to not make this requirement explicit.

If a magic build system can omit tests that it can prove (by looking
at dependency graph) that they will not be affected with the change
I made to this single source file "builtin/cat-file.c", that would
certainly be welcome.

We can dream for build system that specifically cater to and know
intricate details of a language.  We should also be able to dream of
such a thing ;-)

Thanks.
