Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267F933E4
	for <git@vger.kernel.org>; Sun,  4 May 2025 08:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746345622; cv=none; b=PT2+Bj0ViwDF3aBMDSVmnr9NbiuyAaxAzmt33Lpice5LP0fmWhoOKtWiLPIcVKHU1yqCT8Urdg1dEUa/JhkuMyXGN5H+PsneA/wYIAxhK7fd910wVSyJ7+6xkm2xUFYN3i3PckRu+j1cFHWfQJzXL9Q2NpXtxjBvx8rLOCDQyho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746345622; c=relaxed/simple;
	bh=mL3HqXr/sIe+6g4tZwCEyR4arlSBqF8E9s/cW/hz9Cg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B/U2mWN7ZwyJLs6at87OP4ItCg064J2cXSySAdPYMOC+dVXrUCfrnuNouIowRjXn+0c1QvOeVdoQwlr7faOi6oq9/lNJFb59opJPhKYTaXNbIknvTxJbuRSfzVxFcyJ54z5O1ic0mTTauBEj2++EZniCTW6g9gHSBYWtZDS6/WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Km4j5cvA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pLZATiVb; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Km4j5cvA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pLZATiVb"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 07D3125401CF;
	Sun,  4 May 2025 04:00:18 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Sun, 04 May 2025 04:00:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1746345617; x=1746432017; bh=kl8NfLFh92zVBJyCb3kxcZd1kw/o9Q3U
	oI5bsYTtld0=; b=Km4j5cvAPy9FsTu0jZ4xkYjifwEaWotG7UV7/PjnZQBnBnUl
	Gi33RxEM1Np1eknR8VkVmWEvt7MaeiJUhG+G1p0bubvRzoyIjidI36Sv30/e1AcY
	9tNcaZGKLNPLXszUc7Rn4sVHfHLYFlqoUSVAFCr+UhiQF/yJAg2dYRv3CpOHoChL
	CNSVS3pRzNn/159c99EtHMZocSQc0m0Lr104dsnda3Ci0cmArNHthJvTTKkv2UQP
	mJAsOg7PfOmrY3Pc3YES/YCwkUjaFgvDt+huTs/1cbwFvsus3FHlNOibe1r8STNh
	Dy/DLv64li6921KDgLeNOCdTjaIP80vPBzyvDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746345617; x=
	1746432017; bh=kl8NfLFh92zVBJyCb3kxcZd1kw/o9Q3UoI5bsYTtld0=; b=p
	LZATiVb5AfYATJvBEDmnLMi2wgK3ME0OaDojyN5UzJiixVUUvSbZ4fovcf55KRsw
	Q4sXv1DaCDsZ7BGNEKkKZ2YzKkP/XOJvasb+Oyqfl880aHTBxdqS9FDTHNY1dLfO
	bqHgsyDMme1gZCwYAr8mYWaN2GhP62vlZ0tnz4bGdM1u/aQpZYfksxiYhvVxjhu1
	r2NiAY3ueRetJ1yPNkRkXuUr0WP9SRpLrHe70ny1rgl+KxygzUq7u9VWzgaWWwux
	b/sydAfy3VHeXmwTRs+IpNIQCmoEEzq49cD2sG6WWQDpPlUFkv09egAKT4f941BG
	5RPSrF+Xja/bcxPltstVw==
X-ME-Sender: <xms:kR4XaNbG4XohbTcNNbs8uYqnYR5fZ4aKfvoEZVGHIZnrX_p7m_U72Q>
    <xme:kR4XaEYJBFTvIn7UFOkEHwFXwIYG8qDjsq3ZnpTmMX6xqR2SitpOhqgZNfnnJGFyo
    6LzXn1y4OGoHEOU6Q>
X-ME-Received: <xmr:kR4XaP8u9Z0ZVlrtG-LbFUpESo4cDZLLMgLdkknXkEuYsnIf2AZNB4D-d9dVCJcRfCmDsAefB5LewlxyEPMKyvGurMf12lZ2gV9K>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeejieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhho
    uceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepledvfe
    dtfedtkeefueevlefgleetieeuffffkefhgfekveehkefhgfetjefhffegnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesph
    hosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:kR4XaLqIlUMcTPQkqwvn4LiSGeyCM-Zc2qO9zCGNwGGRJH4vaR50Qg>
    <xmx:kR4XaIoXPrMeveku6cCLy7durrBshpGc1_svnwXrL257_TMglUyPMg>
    <xmx:kR4XaBSetPoEuqCeQbBsF88t670ZALmmVQlHYXm-H1ymOAHjD8tRkA>
    <xmx:kR4XaArY-olsbHef7LRfCvkL0yQDODanhTOGLuuYdyGLEUmyGiCkUQ>
    <xmx:kR4XaBYEYQvK5OE6DS90E8lfY5m-QSbMCyRmT8uXBAGhwTwtQKVYwKmj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 May 2025 04:00:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [Bug?] "git show -s" still worries about renameLimit?
Date: Sun, 04 May 2025 01:00:16 -0700
Message-ID: <xmqq8qncst4f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

$ git show -s | cat
warning: exhaustive rename detection was skipped due to too many files.
warning: you may want to set your diff.renameLimit variable to at least 6123 and retry the command.
commit a3a9dd8be6b8767e690b014715aefa2ba39672e2 (HEAD -> master)
Author: Junio C Hamano <gitster@pobox.com>
Date:   Sat Apr 19 14:27:03 2025 -0700

    Something something something

As we have -M (rename detection) on by default these days, and this
particular commit has very many deletions and creations, if we were
asking to show some diff (not necessarily patch text output, but
just "--stat" or even "--raw") it is fair to warn about rename
detection being limited by diff.renameLimit.

But the command knows that with "-s" the user declined to show any
diff computation, so it feels wrong to even _count_ how many
diff_filepairs there are and comparing with the renameLimit, in
order to warn about busting the limit.

