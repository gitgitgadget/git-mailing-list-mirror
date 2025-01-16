Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB78F13B58C
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 22:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737066408; cv=none; b=lpCAydH3y2HnSqHreTbm2ay3rQgmBtJ1ndvN9arcxwWeL3ew3LU23pBdQi6ANhZlIDlbnUC5JJvBbigt3U3jkKAFmfqAxThp9Afuuw5Nh7GcFbe5gWsIqCiYbcyNh5/qcbTe36uGACSDEindxdl9aDU4gUmIZJv/YiEAJc1k4WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737066408; c=relaxed/simple;
	bh=SEZRy2udfIp9dv8mKRJyRYkGgLK50WntkaMo8oTLMww=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KEMwgFi0uCRDroreZv7OntJrkYYmtJCXHO0Ur50NT2I1jTejwd/y2ZtHpqfHu/WDqexchHUCyuoDcV/AtWi7gjj709Hr8Kc9p+cDnDiTgGJiSHenozvMgNtvSxcGvzt4Os/sSXvvNJDFhTyTgjhOHF/d1fy4KYspHVDrN2rE7mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=C9OePrlT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a+gMVs0l; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="C9OePrlT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a+gMVs0l"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BC2A911401E2;
	Thu, 16 Jan 2025 17:26:45 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 16 Jan 2025 17:26:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1737066405; x=1737152805; bh=4asijRFDRV
	fFIsQcdVTfqS++9IkNIY4sPYTy2rc6ppA=; b=C9OePrlTiitWOvkD73EmoRG7AV
	9LQJw2Y+ir2cHa6PwI9CufwE9NLopVKHqqmhtO2ZFlXEGi9tNkTZ6emD9Z8ZqRYg
	uM5rRSFPYjKccUryspUKp6r0NcO55ONqfG04knuw46iCkY8AIJ2LPK9pkbtbtlSh
	jXpAm9VmTFrP74oWZ1fVJLa4d5z+4I4nM4G+Bwr1Dgm8SP/cQP0V9nRXLJcHnmpD
	Cl1384uOV1m7bv9jEAXOURbQNxYWFkMFmKRDsX48xPpEDMFiUVu03RFoGUDfo/CA
	MDts5oUGvSPcNXv9IJGfKAEVdsFZB0ItoSEeQCTj3kJoEAfWcBEnPg3OOsiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737066405; x=1737152805; bh=4asijRFDRVfFIsQcdVTfqS++9IkNIY4sPYT
	y2rc6ppA=; b=a+gMVs0lhV6nKLZdy2BE8ynhT3+D6Zu+9jcjfM57jKPKusJamnx
	WpmFOFosF0HkgRwrxaNQPROZnHpchUuxH/31SAY7T38rJq+jgqvrn+qbSu0/SPb9
	foaKs+OoWtMFZpY44xn2aqHz/0zeUgruOijplJCRT96G94zJhd7n080fNFBfddep
	ZUgc43Wj0DwFvgb6x3mYwVKL7ypV1ANaKg3UAbmmgI/OYuPUQ1TfoqCfESlqgvoc
	2/cUShz6pzarD2l45tLYhMvrsQoxP8barnUIUe9Wktuof2w2AXpEc5XGeOXog7Q+
	3EXZJHO3rutVSynYaBCrpMamerQ5+nILgzA==
X-ME-Sender: <xms:pYeJZxszdJe5rqpM1UDj4QIFZIUITCgdO6FudbZSnsvTfL0_4Sqh6A>
    <xme:pYeJZ6cgPrHiaT6HuliUvU6wft-iAdAzaLGckCZO4qYA-D8kZdTZktuB23I_RBkVO
    WAhixmOzjyJ5AvT4A>
X-ME-Received: <xmr:pYeJZ0xJHixTgnKAMn6h1cK7b8JV5eaK7XapfrtXaWVE1S5JKufbG7kUs4dDoOLFBkYq0SM8t3Pt3BaGT25dwJ7vSrp4irJTRo2_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddgudehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfe
    evteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:pYeJZ4Ppsr0H72IZL8JzYXo6TRKxvCG_dbll3L0bXqJNNeB7zV9w4w>
    <xmx:pYeJZx_jAJ65pxY15LemXzO7TfmAtNLAomkC4KViWl2FXpCVv-BPsw>
    <xmx:pYeJZ4Uq6dWks4PHb40rcL4Q8DvfvifC47Mu8g2SPkH-4a3LSmtAXQ>
    <xmx:pYeJZycqtIuSMhMUlb1VwGVFhxApSRilLWPD1OxdKgIOjd948Q9lTA>
    <xmx:pYeJZ8Z7WAobVQM3Y2X5FitbQiicgzTiECSyiqQxCfWi4lzUoyTzWgc1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 17:26:45 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 4/6] usage: add show_usage_and_exit_if_asked()
In-Reply-To: <20250116215431.GA2338133@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 16 Jan 2025 16:54:31 -0500")
References: <20250116012524.1557441-1-gitster@pobox.com>
	<20250116012524.1557441-5-gitster@pobox.com>
	<20250116103620.GB773990@coredump.intra.peff.net>
	<xmqqbjw6u101.fsf@gitster.g>
	<20250116215431.GA2338133@coredump.intra.peff.net>
Date: Thu, 16 Jan 2025 14:26:44 -0800
Message-ID: <xmqqfrlipf8b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> You said "may become a bit tricky" above, but unless I'm missing
> something, it's just:

I didn't mean "tricky to write".  I meant it would become tricky to
reason about while reading the resulting code why we flush only when
fh is stderr.

> I think the flush _is_ about earlier stdio calls in the process; that's
> what 116d1fa6c6 (vreportf(): avoid relying on stdio buffering,
> 2019-10-30) says.

But as vreportf() has always been about stderr, when that old commit
talks about "stdio", it is talking about stderr, isn't it?

> I do think it's unlikely for the process to write to
> stdout() before processing "-h", but it seems like we should do the
> safer thing as a general principle, unless it ends up hard to do so.

We are going to exit immediately at the end of this function, so
there is no point in avoiding an fflush() call that may not be
needed.  So I am not fundamentally opposed to unconditionally
flushing before doing the write().

Thanks.

