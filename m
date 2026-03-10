Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F1F30EF6C
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 20:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773175794; cv=none; b=UvXaXmXqxIggSKp/+nRgylLcIKhzLK2tPZwGwhoboqnKRit0/fXz/VtXGkqdyl6ogLTmyGp3e/GFqWhWMWgJI2wVdEASVovXLSSVLh8rsCCNPDIXCL8OAZKSKQ8WF7Kfq5lcFsqmrDMbU/2ZVtrYb+IyIWWlkFSNAjCACQ4JcE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773175794; c=relaxed/simple;
	bh=adRjMr2ki1ihKZ9dNX/dgaO7WqEKOlUTqv9g8ik8frE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sWttHK5VXeOYADvLFXoAoSWzko9IP+mjzpKMtg/jgxScqNO+Pi0VIgrpJFlkcrTNmIJnK7M3iErcNTvsbQcybOtjgd2DNNR3k+T/lrs0EXWcR6JD4YUS+kRSxtU1SBzYOMwYaRM3S7viYe1Vx3X9gCJAuFECIvfI4s/EF39d0Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hAC1IVOt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=biXXP9yh; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hAC1IVOt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="biXXP9yh"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id F3245EC0B0A;
	Tue, 10 Mar 2026 16:49:51 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 10 Mar 2026 16:49:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773175791; x=1773262191; bh=FGT6WAwFtH
	I5/AceXDq5XrjKNckLMX5C7p2NLtCjlqc=; b=hAC1IVOtZDnUn3neiK9GIHfRzX
	JIkw0/HYzkU9rEnDj+2YDU49rAc9MhNJ2eSehMFszg+bOkJXo8dKaNqu/wEc+TCz
	+Qc1KrH9Wx7v2oJzuWITzyKGgze9n9eB4IRyE6/f6L89R1nIlCfZwUR0uHk6cCE8
	qviwZy4AWw4QhCFujos8eJ0HefqNXGLa8FCrEiY/hIHYABQiThJ0lwYSocFLmQwI
	n+z2p6D5muEjZk+rNaac4oEXWqVgSYxzYttfwae3VkR9HM29ujNRuA6jYQg2QK2i
	GR5zUiLR5jNZofb3MbJVy1wUr3ZaZbKIA4PV5/NNZqAVqf64y4tZnyJnZ3OQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773175791; x=1773262191; bh=FGT6WAwFtHI5/AceXDq5XrjKNckLMX5C7p2
	NLtCjlqc=; b=biXXP9yhYVNdI6ysya3B7suibXUURCH56quvooFJAkdzIlvkOtK
	2PIvoGhVQOOLAuJJOviTrVSqKyc7RPm8wESj6Al929q4FGwMjY1cd+iqIZH0bAym
	uFhfEQV8+c6XR16/qGmkofc8o6cQCmXiWmbyHXnrBCZdQ2ek2vyEeBzCYR+i+Qx3
	rhRlwHH/31qUOVLAsJ1CtWcPwflJNxi/gXSJ59QPIqDc7KNkA5PHGfVfIeMahykK
	fAmj5XpXncUP9f3mYFXcff3blzcdQlSDjpY5V7dJozf0UQ1A+WrDy9tBEmjhT41C
	hEpUHIr3pqcVfiOdMvxvj3/fyEe/Y8Q/R/g==
X-ME-Sender: <xms:74OwaXzSldITnzr3z3f-pLpbb_6SLek4mIYclifZaZ0AGDq99pJvtg>
    <xme:74OwaS9Ip86WBqx-Fp7OU0ltoaSQiP8AOQ1xnheL46jfQ0BoaLceaiPHjwI9aweix
    Aggjh5k2zpxBgZ4TFlaiLKaXPD9KYr8E9fhcGlMDtxR1VtBog3xSFk>
X-ME-Received: <xmr:74OwabJQK95_10qSC6z-Ak1SRi0JDa2oJe-MhCYvaUDQIB45iNFStPqumQBXSP8w3-bIk2olqUf50hmzquTDyulz-7svRSfSOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkedvtddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghn
    uggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopegthh
    hrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehpshes
    phhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:74OwaYe39iZBJ_FzEaVosZ5WGLhCLAiGbpbONv0K6Ul0-L-2S4IPzA>
    <xmx:74Owaa892eh-zLidx8pPTHRUM-HNlrsQETRdHhdnwp3rZbicu_nMZQ>
    <xmx:74OwaVqcboDXFo0G4Mushj58jn3Q2Q-Ovc92-wR4NQjh-tYzhrCAeA>
    <xmx:74OwafDkkUxV8rWTCuhZwREyfS3Jd5E90nylkZfTHCAb2MPVP87LYw>
    <xmx:74OwaWnYC3iU1VQQvfFWxHceTyGsb5pZAAPR9-yLM0JxEC7bIlMsjKws>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 16:49:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  sandals@crustytoothpaste.net,
  christian.couder@gmail.com,  ps@pks.im
Subject: Re: [PATCH v3 0/3] fast-import: add mode to re-sign invalid commit
 signatures
In-Reply-To: <20260310201116.1130160-1-jltobler@gmail.com> (Justin Tobler's
	message of "Tue, 10 Mar 2026 15:11:13 -0500")
References: <20260306205359.1723254-1-jltobler@gmail.com>
	<20260310201116.1130160-1-jltobler@gmail.com>
Date: Tue, 10 Mar 2026 13:49:50 -0700
Message-ID: <xmqqv7f3s93l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> With c20f112e51 (fast-import: add 'strip-if-invalid' mode to
> --signed-commits=<mode>, 2025-11-17), it became possible to remove
> invalid signatures from commits via git-fast-import(1) while maintaining
> valid commit signatures. Building upon this functionality, a user may
> want to re-sign these invalid commit signatures. This series introduces
> the `re-sign-if-invalid` mode to do so accordingly.

I know that this "re-sign" used to be "resign", and the update is
indeed a replacement, but I wonder if we can just say "sign"?

When we see a signature on an object we are rewriting, we either
"strip" it, or we "sign" it (afresh).  It is not like we are
retaining the old signature, and signing on top of it.  We are
discarding the old one so there is no difference from signing the
object that never had a signature, no?

