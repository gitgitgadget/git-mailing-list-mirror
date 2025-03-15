Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A22166F29
	for <git@vger.kernel.org>; Sat, 15 Mar 2025 01:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742001769; cv=none; b=oLiM24d2XZr1rruaI8HCuwC4fbw1fLyl6VXnmVhX+wuKH2YUNStsmZj6algCNXlDwfP43/2bH5CKuwHZxIGVv5dNXjokqhub+pjqhyiI/j7ayK7brzQUutGHNWgsKtQHbtzzyehDl0zKySw/G7W0pdLT4MDO8l3SQoLJ71iw6sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742001769; c=relaxed/simple;
	bh=MLpQPvx/2SAdzBjSqEl2UaZWxUefeea14u24hlNgakY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MRQ0adcRjve0IzlSV9lY12nSLri8vYwSsEAazsX9JxsNDc7V0R1CssejiccGwEGtCveHbrSPvplwLdhzHSyJ+97uwPM/BpgDnclqqMRQIpuiWEokmvArqvJyYqDH4zXbQuIVMllXRsphNMLo4Pqhqf8XWCMYE0kEACuQP1yodOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=B5nyHF8N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b7+2ZGSE; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="B5nyHF8N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b7+2ZGSE"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 095281382D07;
	Fri, 14 Mar 2025 21:22:40 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 14 Mar 2025 21:22:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1742001760; x=1742088160; bh=LqV6tV3o5p
	gLlfzntTOHJrikKovb60/SMfKdqX/cU2s=; b=B5nyHF8Nzt+JCS6wzT+t+s9xZA
	lIPR1zYMvoPNJFc/G1NAaGlIKAESjObTrbnXqkLJ2kFiOA1L4GJMgR/cbLe3gn57
	8fzJUIu3/M96zVaTEewSX5TmqcAT+x2P3DqT/XsHsL6Isr7SQINabFIUDToSt7Qf
	Z3Hzxyt+jBW0HDdRDRLfXmPrADZN4aF+g79yBSTObayeFmeja5989Cpj39OXkSOX
	9WI4ghmXJOD1ir6It7L8ytnxnnzo/vu8QLp1FoB6Ma4k76vzwYO3J+1espO5sidz
	BYrH71d/u7gkRsQHv0yerwAmvaOWFftzT2SOgNDUYxuqOcg4Q6aRrDusEvEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742001760; x=1742088160; bh=LqV6tV3o5pgLlfzntTOHJrikKovb60/SMfK
	dqX/cU2s=; b=b7+2ZGSE7XtAvQ0Tw5iKfLv1SiIRRlFNuG6uTjsaJKgZBbWZOxJ
	nb5Gl1uGWrojsTwsETKKBZq0i4T6jCWhriGK6KH1pEf9i+P44K3LIYx8mBRdTyxZ
	XG4aPYgaoRWDz7FVpCiRW/nji+PflUHleJwRXerb7zvs29H8b/urOoC+kfKgy4HP
	39++X7XmK0KFNczeXlIfGHK0QFz1P8HyGr1AJvXr7Fe8BTOZpktwhVAXPEThmacU
	lf9xrO6wykM82I5KhYfQZIit4GPbnPZ3nmBp2bCNZF1xeEzKedUvYJIqNRzDi4hu
	nVeHKh5d7swuk8P7JdtJNFA7sy58UGZrOFQ==
X-ME-Sender: <xms:XtbUZ8AlU61ivrg59byCZ-PqML3ubZHdF8nM7DeEcSpvKRTuNK1-iw>
    <xme:XtbUZ-iuRxVoZrO9RhqaN2f2L8ZzTFiwaYKdLxLbkwNPclBGJB9ati2Ux6M_pegzH
    umKeV8PsxEU4Ierbg>
X-ME-Received: <xmr:XtbUZ_lA6tttqnjLH2dwWJc557n4nuEMGhPvomf5LZ5suK9KdRXn13hA5T_4_wkapWfWUmipFkSs-7wGBmKk4VgNOEoVZ1mC160V20E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedvfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvfihrvghnse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:XtbUZyzMjDGdqm6x1hpHKISX5zj1PDuzEOlBAz3QIHn0_fhDgprvKw>
    <xmx:XtbUZxQ7NjVI4GgBukfTLJrzQ9Ap9hBLFB89KWZnGy8TUZTHmhPDxQ>
    <xmx:XtbUZ9a7gbBoiafZSDXYd-eJ1Zm6gHyzUAps86pDH9ABcei4dv2m2Q>
    <xmx:XtbUZ6TP5OUoqyoY77WDXD8lkdUGS8kKbPz27dGcTqezY7WLKKrxJQ>
    <xmx:YNbUZzeG-Ukld_ElOfZ0h4YHhXBA40PBbesrJTFsCltI71GYI3N32a9e>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Mar 2025 21:22:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Re: en/diff-rename-follow-fix
In-Reply-To: <CABPp-BFZkiJgdMqTJCxAMkbA7c_S8Qx3aSRqiLAfqrY1Y3es2w@mail.gmail.com>
	(Elijah Newren's message of "Fri, 14 Mar 2025 17:32:59 -0700")
References: <xmqqv7sbfra0.fsf@gitster.g>
	<CABPp-BFZkiJgdMqTJCxAMkbA7c_S8Qx3aSRqiLAfqrY1Y3es2w@mail.gmail.com>
Date: Fri, 14 Mar 2025 18:22:35 -0700
Message-ID: <xmqqtt7vcckk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

> message to try to help answer his questions.  Could you wait to merge
> until I send out v2?

Thanks for stopping me.  No problem.
