Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE869287278
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 22:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751928197; cv=none; b=LHhRFBZ3CecL7Uw8oEZUd7Kwov2ARe3Sex7jsiZ2Jgmulbh2R3KGkHUbg2b01G6MfksUccv97icMM/V6mvXRv8fH1npHR4dyQvFlo1B2xrKymNgGEx5dL0EBDeC2a0S63hb0tBSL/qXh4RJiz3YtlpXPlYd98pZKZ8bj1Y+Ap0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751928197; c=relaxed/simple;
	bh=AUAMuhERURjgxUwKIEyw2Q7qpFhRpx3arVFUIo4ZFIM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DplB0Dq6rSgX2R7XCvHxDnQOysyH9rPykTkE4gwrCwE5fS7UnJlb43Uz8yXNoccA9sOplB0qjj07jN5aiKwlNlrQoNqxWHF6/l6+uKQl6NpFb6x73Llplc/48vhNFoXVjAszW+XUv4OkbpBvitc+5mLONxb2dZxRamqIBknRlsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=T9I36srf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JIE0YmVP; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="T9I36srf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JIE0YmVP"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EC58014001EE;
	Mon,  7 Jul 2025 18:43:14 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 07 Jul 2025 18:43:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1751928194; x=1752014594; bh=tjBoLc+j64
	vMlI+oHmj6YRCHttYOFIYDytqoMFQhF40=; b=T9I36srfN0XoEnbtT7G0wFPVr/
	pA6vNrrhxWVlfTWthuYJWXie45wK1S37igUgbPI/j3ADXa/ENmJoLe4c+jgy5/mu
	V6QbUaZY7d2Xf7aAhCJxZLrm4dTFAbn//AfljS2J4ri2oUMRdf2GJWTyxKpnQgsC
	VL+7g9JXw3oS97Hpgx4AM3XOrUY9cnlpACHe4+kQJSKD0mE7xEJPKntQoXdGI49e
	jGV7ngqNqZ0vmLh4czCg7rhz6+Nv+bpT3xwvAxIfZdK6RYvVPBqqW366cADxk8fm
	ookoxmKAfNmH9VB7iuYiFXXxSr78pWx6hWKiScuisNvuZ3A0qfbnUwCK5qwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751928194; x=1752014594; bh=tjBoLc+j64vMlI+oHmj6YRCHttYOFIYDytq
	oMFQhF40=; b=JIE0YmVP/8wajhczeuiVqUpTDOfKmrL4YH3VKH2se2wkMjGMiJ2
	Q92dCPhOGgQeQ+DPmHTpqe2s/p17a4zm13pR+RBOhwcPyKffXqQkBCAxGf7XKZ3H
	PcE78LKBH3lsayII2w9AbaGiPNwG/NhU6K7010OSFHNeqgCVBue2QZuK46UoCETQ
	rWxH9OC1q+OFuY0MYuqd8JGSM21pdA4VdNk8rrt+0lEU1ei2+J+L50NkBdmPMdu2
	kyaCsLsAXilLciPq/Wi36AFfO8UBWAMOwmLVdmO1HsGKphQkey5JfGxbE+GVXyPw
	izqG1V8+SRkDMX2FNg0htoyS3IW8uEKbo7g==
X-ME-Sender: <xms:gk1saPGdKiqoEV46M4QwU9GoVRGyOgi2__J5NoFGAihmJtvdyJJkKw>
    <xme:gk1saH1YSnmxFjR3oaNHdmDULgOTAsKGG1USBF7ALg6iJ3FRxpBtZ5wdRPrgrEet6
    KYXlNdOOgJXzlk7zA>
X-ME-Received: <xmr:gk1saHklBe_u_hyAYW54-oYNabcasA7VNVqylOtCoBgusZTBMlheUt9_bjGnJVZMI4bkHy-1xi46MNfsxZjE-aFUFM98H6NJ7IIEArY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeffedtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhdrhhhorhgusehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgrtghosgdrvgdrkhgvlhhlvghrsehinh
    htvghlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:gk1saH9nfROZBCVGwu3khUNoYAI8KVXQqynBUF-ZD3UjHvy41A6xgQ>
    <xmx:gk1saMqEcYaKcGTqmhzC6chbHZIz_mUxFpJT0_KGA7N75YTfI_U6Gg>
    <xmx:gk1saAlOFCjAp39Mql7LLmgaC0km1RD1hN8-xlHhfpLbv11cc49ewg>
    <xmx:gk1saDiRfgQvqB3s7_1853EJ4L9BlQ4nAQc8_csuudyqDDdbFFIakQ>
    <xmx:gk1saHaIY27KT3kb6Prap2AfbxiyEwh7vW7vi-6uyPi0z7RktOWM8JE2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Jul 2025 18:43:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phil Hord <phil.hord@gmail.com>
Cc: peff@peff.net,  git@vger.kernel.org,  Jacob Keller
 <jacob.e.keller@intel.com>
Subject: Re: [PATCH v4 0/3] fetch --prune performance problem
In-Reply-To: <20250702011214.2835529-2-phil.hord@gmail.com> (Phil Hord's
	message of "Tue, 1 Jul 2025 18:12:12 -0700")
References: <20250702011214.2835529-2-phil.hord@gmail.com>
Date: Mon, 07 Jul 2025 15:43:12 -0700
Message-ID: <xmqqtt3n1v27.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phil Hord <phil.hord@gmail.com> writes:

> From: Phil Hord <phil.hord@gmail.com>
>
> `git fetch --prune` runs in O(N^2) time normally. This happens because the code
> iterates over each ref to be pruned to display its status. In a repo with
> 174,000 refs, where I was pruning 15,000 refs, the current code made 2.6 billion
> calls to strcmp and consumed 470 seconds of CPU. After this change, the same
> operation completes in under 1 second.
> ...
> V3 forgot to include the first commit in the series (I forgot it grew).
> So here's V4.
>
> Phil Hord (3):
>   fetch-prune: optimize dangling-ref reporting
>   refs: remove old refs_warn_dangling_symref
>   clean up interface for refs_warn_dangling_symrefs

It seems that the thread has gone quiet.  What's the status of this
topic?

Thanks.

