Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5324E204C3B
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 18:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775759709; cv=none; b=bHh3wn9k6kj8D5Nn4B7hCAZq9DD1cgvEGCw4AcRG//3UflAJgiuk7y5/imTvtgaCELgk7EZcn1WB978cpdMdq52hFGnQyMn6ocymong205iPvMjVAUm6IGfG9xa8qx8ntKLmsZbVogYizE6r5xe37vBTK6sSEE8sOyrmkhDD3JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775759709; c=relaxed/simple;
	bh=Hj6IWGq4pPK9ouuMfjmzCBl1jSsiaNiDro2W9utJ00c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o1ir8MPY+P3vJqsTAYW/RR4yCgZCfwcuHTj6YcjTi/S6PUqR5IjY38JMmKxG85fhwQCU0QUz2V7wrmAWacCm4Bvuo3L8h25BGJ7F51XIaTJeUFSsIQnFhzGhpruCA079GdUe3RQYIpD4B+iT4CXU8P+wyn49XfeJc4puRDfWptA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CbT5oDUz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iHkUmNRZ; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CbT5oDUz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iHkUmNRZ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 2496C1D0021D;
	Thu,  9 Apr 2026 14:35:07 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 09 Apr 2026 14:35:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775759707; x=1775846107; bh=YCbony8iwW
	A9B9GyKfNfzadVxCAl/qNnLX7D6P+gnY8=; b=CbT5oDUzhUDi+K04z7pCVy0jGY
	j0h2bRwHUbNsXe4OoHIxnjMoR+nB2mYm3BhlF5r9M9I6vTq6YogRJ4GANqGv5ypt
	hzkiPVE5ob6TtDMMwMbizn278iUtTuhtdhJp+8vq0VKNqah1f6YWhJf4bVOvjGW+
	3ICvnFPpYmPIiIosq1FXKxSJUSlnPkk6Gtet0Vu3WUZCd34Egn3hbTg/1fXz/U6/
	Fw8sP7vNOwRWrNeLE35LURWjZwUde0p7w+pWDol0Y8ga+StzfaQ9wa8uoTvRwl4d
	ACq61iIGc00Rh4IQFPOIsZFVMas/2XqVTG33XHQDu3opStkYlPBPXRQ4zj0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775759707; x=1775846107; bh=YCbony8iwWA9B9GyKfNfzadVxCAl/qNnLX7
	D6P+gnY8=; b=iHkUmNRZtuYo3KJVoJWE4TvYvnBWU5VQpSkLIxrYO2XAMnwc6hM
	T7rWiEGOd1no3kkRjHGdahvBXYmV1NGtdvFYVGfmzPnUhb7hMGyJdUw4vguc7UYr
	2NtHA9NvodFqOi8HlfQJStSrGmXaHXFW4cfa0S7oU3xTDxYh2rTGDpv7LYZHtHsI
	IyHc53qKDqG3lMqcBFOQMBYUBWyLD6xHDcBnqYPZ4PYx5m99Vxmlz4mC/gP/Mjc4
	SKqtH9mxEwfNU7aoo6/bTVAHgEZeDsWiAQdKDj5tLaHj5Xv05LSdhzUAk1hXN1Vv
	TZ+M0XgkVgk27REoqiA3dPyu4tRYIIZoUHg==
X-ME-Sender: <xms:WvHXaaHbrCJo6znYBgWvQJtsLu4HDQpkk_4yBz7CogKvbauiC5w8CA>
    <xme:WvHXaSMQhUK78wM5lrSlW_GJ984rjiqM09zJCmuZrpCkbl_cEo-mg4dr3_zuXl6CZ
    zOI-PGRdbYGyBwZC3aKHDc1zP0JxLSdsORdJ9wnxHTPB3d2twAw-g>
X-ME-Received: <xmr:WvHXacfjfbwcA-wUfPOCJSjS8ymYnZZotFXghAe68hKVkeYGoLZF-0yI-bu0vTu0xO3UcUlliHqTpxhVktORqv9oI5mRNOQalw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvjedvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeffieetueejveefheduvdejudffieejgeefhfdtvdekfeejjeehtdegfefgieej
    tdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephhgrrh
    grlhgunhhorhgughhrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtghhithhgrggughgvthesgh
    hmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:WvHXafvvU28avYenn306nDOoUnyejlGSPm7hZOzKsAGxthUw-K_TxA>
    <xmx:WvHXadls0uq1KHrLsjiwVxFEJrTvjdurOuq2jw7El9lyEqVtGcIu8Q>
    <xmx:WvHXaRyoa5N8hkJeyKN18KjtLc7tx2BDY5cfknqgrvqxmNtxcX_xtw>
    <xmx:WvHXafMD6RU46jk9PQaDXfzeqrf8y6owTK-ow2-rkt64JRGyp2ljrw>
    <xmx:W_HXae_55B1R8sly_z_uZ3ctgIHMFg2yLlf1ms_Q2jGIHgMhiZnCYlTN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 14:35:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org,  gitgitgadget@gmail.com,  phillip.wood123@gmail.com
Subject: Re: [PATCH] checkout: add --autostash option for branch switching
In-Reply-To: <20260409120631.12207-1-haraldnordgren@gmail.com> (Harald
	Nordgren's message of "Thu, 9 Apr 2026 14:06:31 +0200")
References: <20260331121633.14907-1-haraldnordgren@gmail.com>
	<20260409120631.12207-1-haraldnordgren@gmail.com>
Date: Thu, 09 Apr 2026 11:35:05 -0700
Message-ID: <xmqqbjfst21y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

> Update on this: I realized that the issues I ran into was happening
> because of a sub-shell, so it's resolved by running like this:
>
>     export GIT_EXEC_PATH=/Users/Harald/git-repos/github.com/git/git && \
>       /Users/Harald/git-repos/github.com/git/git/git checkout -m -
>
> So thus, it's not a real problem.

In other words, you were not consistently trying the version of Git
you just built?

Thanks for a good news.
