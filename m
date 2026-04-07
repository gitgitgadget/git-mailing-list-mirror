Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CFF33CE80
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 19:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775588975; cv=none; b=DTnPwiKwzzMGnVTe+ML+D6uM81UrJuk3cNkJwEvACiZAUXVgFJdHz00Fwk4mi/ajvpGDWvo1S+3Fg3HDgOlrR2sYPcz5aqqp7MV3J8jlkLLKJZC2Uy2jbnY2w8cz/ptWHBma7YnLPX34JMNW9CA5zzV8RicOS0Te11jsS/cgtQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775588975; c=relaxed/simple;
	bh=qLbDDbsA6x6Bxx1fiWe+4+FDmpg+sHVl5wRzAlNfLKU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s802U9j7a6CDC19NLjD3dB7xxJQjRJhO520HYzAi94u9UlI71JHEqMOzh5Y64ZnXIsMX8SM6UCoY01ojDE2hLgZDLFvlEimYez+WlzmZum88UBVBH5eQIQztRwVgc4pC/zJIv6hKkGfAQDFnIA3lJoiaK3G0EuZ4/5Au+SDnTHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qyV6Yc5g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AQiQ3npz; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qyV6Yc5g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AQiQ3npz"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 640D3140015A;
	Tue,  7 Apr 2026 15:09:33 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 07 Apr 2026 15:09:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775588973; x=1775675373; bh=qzW3lkimz3
	mfa3sFaBMAExDNDKGm1x+Oaei5F/g8dvY=; b=qyV6Yc5grMFYIZKLV6xcATJ9rS
	/VBose+aChfMMymhuxzQx0H/EbOtH+5IJqtG4SqTS3v/mMujOW+vGjUNaOBxwwXh
	+JFcgYaAMWFiPIKbEqjo9b6gCQ63Kua6KSTTsM5cWhvt0qmHsq1l+0+2aEnlAAJZ
	AliwgoU//3sMdxDs82ISXYS5aqmX2Ayhg2xdF+5XKDQnN0LFqh+H3R8PFe3YfgyL
	N/10WFj9LNYpIQm+8wQEPe1JhXJ5l9eUx2V8bmQOU3OIdHRRIwf8c8QGqBm28NHS
	FI6Thj4nnI8uv9ZMlz1ae0Cc/sd72NlFzAYhBHSUfKaFkwYiOoNyDBuLEsug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775588973; x=1775675373; bh=qzW3lkimz3mfa3sFaBMAExDNDKGm1x+Oaei
	5F/g8dvY=; b=AQiQ3npzgWIBLGj7bHQvbcr/JrGGsVltxw6ePcSeI0Lvc0M57pQ
	OO9V69yTYsCAZg0snIlnzMVxb6MORDWusLoueIrAmp5YXw0IBWUAdVCTc5+M7zYx
	Wqd2s9CgcBBkC/uKFIDI5IB+tdDnMqQ24sVeQa1ia02PUOXTxKTJLRALoBq0IuQm
	OeTL7P7WdV/QYuvurOpsEEPXLRcMRcYMf07gRXlgtS5WpvYVfqyPSd5cpEhogdYx
	xIm/ZGAIRlTw9d9s3kdMoW6htcxoraf99widyEnfX3WIhJ3bY+fzkAmUXcqXmAgM
	KRqueZpwk7qIODNnYVSVaVayIYTSdue7MKw==
X-ME-Sender: <xms:bVbVaeHLcSa5SRlxKXra0nheWhdZH51V-2UFIesPHfklsvZGLOLlhw>
    <xme:bVbVaTA2faR1CBPUr7iEKQS9Eikr-cB-mw2dwvwDkKUvK0PqNdv5hGaX8c6omYSLh
    gBcuI48OFz6DlHOtiT7ZHFE5VQAmEWUFsmwIc5X8xwfw2un5tVI>
X-ME-Received: <xmr:bVbVaR-NAmXWMd-x4JAeX5QmVFQyX4aWnrplLRSakddRc3AN8neD0GO_4yGLpp1qcfRALwuVIQkcNoIo1fgFCq2ZqmlHSkyIPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvudegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeffieetueejveefheduvdejudffieejgeefhfdtvdekfeejjeehtdegfefgieej
    tdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhith
    hgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoh
    epphgruhhlsehprghulhhtrghrjhgrnhdrtghomhdprhgtphhtthhopehgihhthhhusges
    phgruhhlihhsrghgvggvkhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:bVbVafBfYSvdpat3dOUQmJmYJPg_fVJsyguo2s0vpYKK-cQOJZRKHw>
    <xmx:bVbVaWRIXexZ86rIWGHMi9Wudd7lZmtfCMIoYUqSUjP9uLK8jWewnw>
    <xmx:bVbVaWvJIXZM7aUgmJn-6fOrUvuU5hXaZpTUKP8fYF-XaUAHygUKuw>
    <xmx:bVbVaS1bBS5hXwh3nkgE_QEipEf60bR_xK17jNe3flDmQFDTISybfg>
    <xmx:bVbVaRMlqy_q8LqOKz1fMbVVvSG5GR-HKa1usY4956o5FtSuNCdSQZ23>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Apr 2026 15:09:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Paul Tarjan
 <paul@paultarjan.com>,  Paul Tarjan <github@paulisageek.com>
Subject: Re: [PATCH v13 01/13] t9210: disable GIT_TEST_SPLIT_INDEX for
 scalar clone tests
In-Reply-To: <xmqqika24mj0.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	07 Apr 2026 12:07:31 -0700")
References: <pull.2147.v12.git.git.1774937958.gitgitgadget@gmail.com>
	<pull.2147.v13.git.git.1775498098.gitgitgadget@gmail.com>
	<28c5aca413dc0966df62a3d04f8ed76bdd9a5bf1.1775498098.git.gitgitgadget@gmail.com>
	<xmqqika24mj0.fsf@gitster.g>
Date: Tue, 07 Apr 2026 12:09:31 -0700
Message-ID: <xmqqeckq4mfo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Paul Tarjan <github@paulisageek.com>
>>
>> index.skipHash (Scalar default) and split-index are incompatible:
>> the shared index gets a null OID when skipHash skips computing the
>> hash, and the null OID causes the shared index to not be loaded on
>> re-read.  This triggers a BUG assertion in fsmonitor when the
>> fsmonitor_dirty bitmap references more entries than the (now empty)
>> index has.
>>
>> Disable GIT_TEST_SPLIT_INDEX in the scalar clone tests that hit
>> this, matching the existing workaround in test 16.
>>
>> Signed-off-by: Paul Tarjan <github@paulisageek.com>
>> ---
>>  t/t9210-scalar.sh | 6 ++++++
>>  1 file changed, 6 insertions(+)
>
> The same treatment is needed for t9211, I suspect.

Not just "suspect", but it does break exactly at t9211.

  https://github.com/git/git/actions/runs/24060447371/job/70175464363

>
> --- >8 ---
> #!/bin/sh
>
> export OPENSSL_SHA1_UNSAFE=YesPlease
> export GIT_TEST_SPLIT_INDEX=yes
> export GIT_TEST_FULL_IN_PACK_ARRAY=true
> export GIT_TEST_OE_SIZE=10
> export GIT_TEST_OE_DELTA_SIZE=5
> export GIT_TEST_COMMIT_GRAPH=1
> export GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1
> export GIT_TEST_MULTI_PACK_INDEX=1
> export GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL=1
> export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
> export GIT_TEST_NO_WRITE_REV_INDEX=1
> export GIT_TEST_CHECKOUT_WORKERS=2
> export GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=1
>
> make && cd t && sh t9211-*.sh
> --- 8< ---
