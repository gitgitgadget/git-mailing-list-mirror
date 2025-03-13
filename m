Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B952A35966
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 15:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741880044; cv=none; b=j5Qb+MM2y7UjpvhT6FegINlYehk3IovS/ZqTkpWgw3UMxeaAFw/P2G2tgwFQCEEQ/3fxdsjFL3JFoeuC0TcH7tP6kxEf7KIrApts1ZRKiBPq4BedsU31kodcAnc0fhqCxet67+O2uvpRO1zrsMuDOEb5JrqVK8Gnf9wf1cRBhwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741880044; c=relaxed/simple;
	bh=bCFN5N5Aig++ivje+i+PPUog7/LOSM1mD0cHmZj5LxQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D8G+iAC0k6hB8R2REEt5L05ePfXKqTZ1+BAi8vep8D2dPtauAtDDzBCce+RnzYJTwMrw2pLRvAQ/eoogYsAksMNG/4j0JL6an020w1dZhYvpF2X6GrLheFvG/LezLo/a+o9CWo01gyU8lD0O2g0T/PAjqZ00FaKRWLZj7YmAvbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MTZbpDxp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HMBSpwVd; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MTZbpDxp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HMBSpwVd"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A4DD5114021E;
	Thu, 13 Mar 2025 11:34:01 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 13 Mar 2025 11:34:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741880041; x=1741966441; bh=qSB9NhSHtg
	Ngly+3zbOOJW2vkpx03kDPYfktVqLrNao=; b=MTZbpDxp7jRoglTLNWxnYaUse6
	nSA5Vp9QE5p2JBKyJvzjJOAsi4bt+4Sk6jkTl62VyDoGxPGpytvMZU1veT6pHlOE
	5rfVfIGQrTTbAn1aybpsIg0KC/rt4zD192o0+zmKNQjXR4qXTnAa7sXpQU5lH6Dv
	/jZDyBOkLO6s8d1sbrc0JZ4UOfmgqXXzzVscxcpSuDgTNoJyLNqWIYFgb+w+1snE
	zJEni35gQY/sAlmLOJPbiUY+zPJJ+82/2bDWGrX6KInlGQoI5pwIu1V8tyfFGGTg
	h4ust96ZwFAmh2BAK49IUuRq6+grSJF1/x+MwZ4ja3oO28Cm0USkc9CuZTXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741880041; x=1741966441; bh=qSB9NhSHtgNgly+3zbOOJW2vkpx03kDPYfk
	tVqLrNao=; b=HMBSpwVd87pEtMJilVNPkiniNfFI2+2sn2+kuFBOWC/mOPERWkh
	LGzu2sALyVHHNWhjt2SnWkiKfiYl+QuIzpW9nHd5D57s/hrYSIXKHGhUcdMNkqv3
	VvWcD3bXGjCnBAjg2I1VCxdcQHqjnjYJ0SjBrR/DCmkdnbpdK1z6WdP01dLehcZH
	b5jRVya1QmwcBugXwQ1mgoY1DK3TPNUEYcL5HBKiskWeMeQydh9Xos0/EcnP3hfB
	HaiS25ekEhr2nOHMMAh0XPn0a3RHp3W6JojBSqbxKFtnt9HMzJrmNgm8b/8EzxxL
	j/BZKwtVbzEFcWtEvHWOnTbcei64lUT+0FA==
X-ME-Sender: <xms:6frSZ5t2cPbd1FyjcFLLqLjc2Wozxq7zV_pHO4I8A9Ewcz4UA-ZJrA>
    <xme:6frSZyfeSwGjEVXgcRF4XXBAEUmqjmxBcxkT8HLRzZ2q2sSbw2Lmr2en1MitnUZf2
    dCHbq2hVHCVjBfGCw>
X-ME-Received: <xmr:6frSZ8z4OEyGf1fOmItjOVGTDtzOaejl6Sl4qYisvyPVWSjYw75taIl9ewjSyD3fmZ4xAL6eGxABbfI1ZMdkqOVoFRAe4gUnwvJOwM0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdekfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopegshhgrthgvrghrnhgrvhesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:6frSZwOjvCxaduecJCKYmnEAl4pCDGGxN5bjKsNjtQB2WQDYmha-og>
    <xmx:6frSZ5_ezaOxp2dZLFbdAs8YzE0BL2G-qa9yrPP2tIivY-iU59qHeQ>
    <xmx:6frSZwVAJVKhSJb6BX6ozGBLMT15BevtcM-QlxFzfn_SgFatgzQJmA>
    <xmx:6frSZ6dRmj7lXaX-y3ncvUxKSlCzx0pJoQLggZnyVXsPl8gqe_rGhQ>
    <xmx:6frSZ1bOr8Ugh0NEYFzdcfSgtQFP31xM7sLpigBkVStnWUZrThtXTlCm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Mar 2025 11:34:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Arnav Bhate <bhatearnav@gmail.com>,  git@vger.kernel.org
Subject: Re: [GSoC PATCH] pathspec: fix sign comparison warnings
In-Reply-To: <CAOLa=ZRNJD7NqceGQ4B8ox+50m2q1nU1t29x7O0roc=-_4ww0w@mail.gmail.com>
	(Karthik Nayak's message of "Thu, 13 Mar 2025 08:52:58 -0400")
References: <a3aa5f99-63ce-4be5-8d64-fb6e226b3bf9@gmail.com>
	<CAOLa=ZRNJD7NqceGQ4B8ox+50m2q1nU1t29x7O0roc=-_4ww0w@mail.gmail.com>
Date: Thu, 13 Mar 2025 08:33:59 -0700
Message-ID: <xmqqcyelq714.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Also a bigger question is, shouldn't the type of `pathspec.nr` and
> 'istate.cache_nr' be the actual change required? Shouldn't they be set
> to 'size_t'?

Please do not blindly advocate the idea that size_t is always the
right type for any countables.  It is not.  

Platform natural way to count things is either "unsigned int", if
you are only counting, or "int", if you need to be able to signal an
unusual state other than "here is now many we have in the set", like
how index related functions uses (-pos-1) to signal a location in
the same range with different meanings.
