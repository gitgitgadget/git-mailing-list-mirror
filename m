Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FE838F23D
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 22:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774995678; cv=none; b=AKeRw4deSAqjRWzCMgKEy3aaL68TrXhr/VBsnAy88X9/BUN5E1LKxUriSS67piztoie89S0ta5xFqNmhn3FkgX0mNbHabrwVlGpUTt9QBUZKHc84FMQ3WYXG7mMsQEHoxpq2JZFdrTv4AAFKFS7NRZf0EbnD5MiLpxrIP3iDmC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774995678; c=relaxed/simple;
	bh=aHzK9/7TVlafhWYEcjg3G4GiBGNsA99a6WIWF+eOTbI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DVnjo5Bm3tinx/uHL4tlA4nqfqZ6Ynq51KIinljtlo5K+sc29K2I1EM+i4SqN/LpOuXNPtNR7WOUh885lr6Wab9EzfgLd5gwcrex+eXmzoMjYMXFuqi+XgG3mc9yD00BtQXvQCCiZZOEiKKk1zycKYn5eNi7C8AG2GgHUXZmK98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ppMiqXFv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v5agNzMm; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ppMiqXFv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v5agNzMm"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3E8A17A019F;
	Tue, 31 Mar 2026 18:21:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 31 Mar 2026 18:21:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774995676; x=1775082076; bh=bOWQxBe4rS
	Mxuscu/mGcted1JYYhqsa2qWkGmvp+9TM=; b=ppMiqXFvGmEhFsKZZ3OuClMvDf
	tF7UOzCOSlqQZLV+xLUEIiqdPuJimjemKDDIozJHGJSmKsyypnISbwPge/tkyVfE
	zZr/qGV5LCuZpFCzDLIIR50Fbp9bsQT4eATpVEVQy0DJ6oUDwlNX96W/sj6Z45JC
	UZP3zfm8CnQxhubjCJFB7cbym2QPsxSJsjIjYkhoyXlzd+ykd+I3ysrnwCUDJj+O
	yC/3S+1fkCc4NhSxGwFToq5wnAy6r55gaRNbycX9F4NG4w98n156j14cOCWQGYLs
	YdQ89Ub+UwtD+kY2BdXCmp8BEDfjjDjaA18fXt83KeVWLqSSOMLagZQOhAMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1774995676; x=1775082076; bh=bOWQxBe4rSMxuscu/mGcted1JYYhqsa2qWk
	Gmvp+9TM=; b=v5agNzMm5c9XAbv/ExYB4vBniEs/oQdeIRaAxAP2KvRS/xuwggi
	2KQfaAY2T76eATpNLJXGzEZ0aKxkcY5hVlJZGKmVOhbdnwEBXg1nxE5bFhRA7qKh
	zQFnK7dJUkmp6qIWDUm6rMhVfYHyvRWlhtOFTlkGCpZTzXQAwxwdeukclQVeCkzI
	X7blVLHPRbwtBz5elQZs2fHVm2xbZ2YGvOKqyqj2bsjg4HkrOg941zE62/2vaex/
	QngchNTigIU62SwDmVxCd+BEyBU309E9vnfT3w6zhdyNOPHYfuzAUdwlkrAU13Ck
	l5ZgWpARyC+qiWleX3S8aQmtvX6lI1A6SGA==
X-ME-Sender: <xms:20jMaf0T9g1_DegFoMsWSPnTbr2DsKOPKuCTocvu3Kkvb-KxJMkbMw>
    <xme:20jMaaq3w1KsbrdMEzm7SMP6KBmntpuwGaRcOADdPf_HpFBC6ki3w9XaFu7yp-RYg
    NokCtrxV2b-kBCLDRQ_kN-Y2MApB9MxRgF63wdPJR33ICZd7fn1rA>
X-ME-Received: <xmr:20jMaUUotkRfmOKB_CMVu5praTKZaYT4kXXmJBbTzydaOJ8favn16oADvL_p8LQrlpTopTpTAZEni8KgGi_wkFxLXIhuVNT69A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtre
    dtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgs
    ohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffue
    efjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprh
    gtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgrsghlohho
    shgrsggrthgvrhhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesrhhunhigihihuhdrohhrghdprhgt
    phhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtph
    htthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhl
    thhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprgihuhdrtghhrghnuggvkh
    grrhesghhmrghilhdrtghomhdprhgtphhtthhopehsihguughhrghrthhhrghsthhhrghn
    rgefudesghhmrghilhdrtghomhdprhgtphhtthhopegthhgrnhgurhgrphhrrghtrghpfe
    ehudelsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:20jMabokzg9La1kotsbin5SjKmgd9ov8u_C4SUhRFCXVj8OTDV2FEQ>
    <xmx:20jMaTCXWnOVlhO0eOMQkLq80pBjIjfAGXoGEKXESIKncz3IISKi9w>
    <xmx:20jMafj2qVoH2Dr48pWbgVwuemrbWPmXwaVV_5ifv_vfn1gatpriHg>
    <xmx:20jMaZZgoZ4Bg7t0_0IJLaiewGIDDOW7g-BYYfrGl3lg8o9kPIYBnQ>
    <xmx:3EjMacuNDg3lqaErXalW3-qAQ6fKk3DI_pTE7E1V7cqoYM_y-23uS6gt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 18:21:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org,  me@runxiyu.org,  christian.couder@gmail.com,
  karthik.188@gmail.com,  jltobler@gmail.com,  ayu.chandekar@gmail.com,
  siddharthasthana31@gmail.com,  chandrapratap3519@gmail.com
Subject: Re: [GSoC PATCH 0/3] receive-pack: fix HEAD check for updateInstead
In-Reply-To: <20260330111822.165188-1-pabloosabaterr@gmail.com> (Pablo
	Sabater's message of "Mon, 30 Mar 2026 13:18:19 +0200")
References: <20260223141236.22476-1-me@runxiyu.org>
	<20260330111822.165188-1-pabloosabaterr@gmail.com>
Date: Tue, 31 Mar 2026 15:21:14 -0700
Message-ID: <xmqqldf7wsh1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> This series includes Runxi's test, a cleanup of a test that messes with Runxi's
> test and the fix for the issue.
>
> Pablo Sabater (2):
>   t5516: clean up cloned and new-wt in denyCurrentBranch and worktrees
>     test
>   receive-pack: use worktree HEAD for updateInstead

I re-read the main patch [3/3]; we used to check "HEAD" in
the_repository but now we pass the worktree object (not just its
"path" member) down the callchain, and that allows us to check if
the worktree's HEAD is unborn.  Which makes sense and is a
surprisingly small fix.

Let me mark the topic for 'next'.  Thanks.




>
> Runxi Yu (1):
>   t5516: test updateInstead with worktree and unborn bare HEAD
>
>  builtin/receive-pack.c | 39 +++++++++++++++------------------------
>  t/t5516-fetch-push.sh  | 15 +++++++++++++++
>  2 files changed, 30 insertions(+), 24 deletions(-)
>
>
> base-commit: ca1db8a0f7dc0dbea892e99f5b37c5fe5861be71
