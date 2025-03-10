Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E98E22B8D1
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 15:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741622400; cv=none; b=UOt3A1ffjWcBOmAeBeMFB2Op/qBpRYv/KAwYxFlNDsOXK/RneelnnOzhSVts70PoDJLmdt4lIWi9Q5Alh+piibsgC75Gr/5o3LtnCRvL8/WRJMihBgFMgb9iFufij11MxsG0/N5/xF5vklRcIiQz2slFQLza1WtsmQLM5QdVEn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741622400; c=relaxed/simple;
	bh=LdJkAvL3vG4HNm4TKKinFZTl4gMoQVm7sd+MQfMuCYI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IVObWruktpXTbPsfbVce+DJ8U86h6Y9+a2clgEvAdzsR9py3vKLefQ8+WicTU8WyfnE8b7WdderV/sRg9u8T0a5N49Vfj9NmQIh6ZdrTcXF2OR4Ki/5DADfROQtJBFAL2aN3nF9n+kPJDOCqtdRSZjGCYutciUsHhR6LJ4r+z68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qaOZw1/C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1/ylUHTO; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qaOZw1/C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1/ylUHTO"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 517A6254017D;
	Mon, 10 Mar 2025 11:59:57 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Mon, 10 Mar 2025 11:59:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741622397; x=1741708797; bh=Q0a0yAWxv1
	YJl1nBi6ButPUwESmN2gX4jRNlO6uzjC0=; b=qaOZw1/CRCzX6ZDc63GikVwevM
	dkp0MMgdrwRBUhNT1hdIq3mpngJXboX4VO8I7DDo6PcuRdv5LHJjXzk50tav0mZ7
	yeXSfxwME4jHobBUHVvSHUSe6z3KD57ZAXj7XA7ZUqQQgASqEt/pmo+aXwubNUgr
	cJaSnVVf6zPHPyYqFp9ec4pjgSiDqJJD4x38CxnOfAUlW4Kbxc/GaoLbua9rzzfO
	HuZkOt8008hsHYS2Ul+ESKNsQtNNevGHrfFmWPXegjnzm2p5pHHDwxnGD1v/a7tz
	NRv6YPdXNDGnRETPQMQHDLXmENJVdN+q6YbmY5Q2Dya2r+PwLUprh9lW0oEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741622397; x=1741708797; bh=Q0a0yAWxv1YJl1nBi6ButPUwESmN2gX4jRN
	lO6uzjC0=; b=1/ylUHTOh0Y+1bUkHeuSCwo52XWxZe6Nl0u6OnlfajJ4w46+S0C
	+RN+RvzrZS6noUk3edxvfX5CEMsgXjWOHA7LWIfL6FE2/K/PBGNxO9GHTRNI7pcr
	8ZFQlUSsL+eWV2MW12E2rusG5BGhfXByGu0kJsuKVW1NySoH8D/O93Hag2wn+s4B
	KA409ZXKufoLi+fmBBbAHE+ifklAsnqY+Dw5XEdj1ko6xsLBw9eH3E/8JvTawBDX
	qECsnH/+08TssrwZ2O5+hDVco9sKHtU5W7UQ9PPx03/SEeYH1cbmBtxSdOvHh7vl
	s+3kHhYEuRriVbA5xo00keOOYLOuuAIgyqQ==
X-ME-Sender: <xms:fAzPZ9PztJwCVjnKSnG7Kji_gVtq8n53y-3roaeiWKCWxdl81DlVAQ>
    <xme:fAzPZ_9-lVSu_7ThZiet9n5OvMjYg_oNHboZpAYr7ZD6wEAXMJIiAoWyS61Sggu8H
    L9oz01rjTLO7u0_8Q>
X-ME-Received: <xmr:fAzPZ8SENIB3rWHrm8Wwes-18UKj6ntozYweEad51aSGAETu7tk3aLL1sESafQKPyvPaydwhnwfOZPzCN7T8Ii_aa77LTXtVUWl3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudeljeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghmih
    hlhiihhiihlhhimhgvodhgihhtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:fAzPZ5sLOGeboviw-91aJOLdQ3BLabjYsyA0OqqX9NOFQpTBDRMCng>
    <xmx:fAzPZ1f3caadm3g_SicTrDm6TqRlxGmOwm3owGq4cq2v29SgsNb1rg>
    <xmx:fAzPZ10W2TkMfg4qTJlM30LmkmICK99JLaGWpEvswkNq4fN5zN7AxA>
    <xmx:fAzPZx-l32FMXxn8hSN_Xplrqajh_mkHlQa2rK_ey9Yq6FArx2z-9Q>
    <xmx:fQzPZ-GZp7Z8-C5tlHfMdZ0zFMtt2axBqdXWzQt8oE_jOLXS2n6baSkN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 11:59:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: emilylime via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  emilylime <emilyyyylime+git@gmail.com>
Subject: Re: [PATCH] archive: error instead of triggering a segfault in `git
 archive --remote=""`
In-Reply-To: <Z86WtQ-3Rk9OSmn_@pks.im> (Patrick Steinhardt's message of "Mon,
	10 Mar 2025 08:37:25 +0100")
References: <pull.1877.git.1741515155475.gitgitgadget@gmail.com>
	<Z86WtQ-3Rk9OSmn_@pks.im>
Date: Mon, 10 Mar 2025 08:59:55 -0700
Message-ID: <xmqq7c4wanb8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> +	if (remote && !remote[0]) {
>
> Okay, so this triggers in case the user passes "--remote ''"?
> I see that we ultimately pass the string to `remote_get()`, so does that
> function segfault? If so, can other callers of that function segfault in
> a similar way? In that case, we should probably address the issue deeper
> down in the call stack.

A good thing to point out.  If remote_get() segfaults, that is a
grave bug.  If remote_get() returns a NULL for such a non-existent
remote, the code should be able to cope with it, or you found a bug.

In short, I agree with you that this may merely be sweeping a
problem under a rug, not addressing a real problem.

run_remote_archiver() seems to run remote_get() and use the returned
value (which could be NULL, if you named a remote nickname that you
do not even have) without validating when it calls transport_get(),
so that is probably where the problem lies.  If I were writing this
code path, I would probably make run_remote_archiver() take a pointer
to an instance of "struct remote", moving the call to remote_get()
to the caller's side, and deal with an error inside cmd_archive().

Thanks.


