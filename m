Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAD42356BD
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 15:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752680396; cv=none; b=j+m4s7KEODVYlKdNYOojD4jvUORFRLWCOk/d0j9mqpFpg+tCdZUxZXKB+JVgjjHldynfk1s399lgM1QIPgb/ENtwaeL4JHPMnvnRATRAQPLgsj2XUswl6rvubsVqvkcCUWLI5O/bFYj+EGjiMpR41lBCxS0nwMbGHKCgrlorDoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752680396; c=relaxed/simple;
	bh=DVdE1DdchEqCaNdLZ5XgKIMk0TpOI5slqcSWK/9fJbs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YS78W9JD7Vn6C0tZNtHLaoW9Ps/55qpt/T5cqtumwimqYGp+eWbz/X/eGhnvgBMs50I5JwE3op6LB7a9KR2ZE7y4CmqbXNzMX7ccwci4nz+1dWhI4L9DdzB+KZF61/z+fLfjFvabteOxj9oUCb6xI2HYvih8vR2Xfhu3OS/U6lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=c2pHXhBt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nLJjpk4k; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="c2pHXhBt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nLJjpk4k"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 77EAE1D00044;
	Wed, 16 Jul 2025 11:39:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Wed, 16 Jul 2025 11:39:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752680394; x=1752766794; bh=DVdE1DdchE
	qCaNdLZ5XgKIMk0TpOI5slqcSWK/9fJbs=; b=c2pHXhBtYnA1xc/Vsm9SIoNOQD
	1DYQRkM9Uv3+jeXlLME9HyqtShANZ/mAiMUw7B/QctrEQDBmTnLR4MC2rF/xAjYg
	DFlnBeZ9Oe7UZE3pzFTB0ACx4ecFIOVEuSpQJfW+Qj01Lr44MyoiIzYiUbMU0TCc
	lcFnatXPr2tUOt1Apo2eG/zXxcVWvs5K3EErzMDn5HxD3sBAK7S4dWefixabhtpx
	nSRlUB9//a9TWExmj+Zp1A1mK8jlIexpYXgK3mXIOFfxMNLCTG5wCKcHdEVG/fGH
	AcD8xu5AvECGkms2I9iSjmFfyTWjQSl2ZNzucHtCo7k7p2DIqZyfUYwoP53w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752680394; x=1752766794; bh=DVdE1DdchEqCaNdLZ5XgKIMk0TpOI5slqcS
	WK/9fJbs=; b=nLJjpk4kEe+92Zm8VuG4eY7ELAeLQwC9wqhCX+/LJJ0NTmB3Z98
	n0a59GmbZDtN37XsNJiMyXuSe/DK5RknKmQcBMi+z1Iu5ygwVdu7ABTczr9kGDjQ
	jDYvEYfOBGuEwIoHPE8HZXO73aWjKa5GD6XTcgAfHFb/nO9SiWYr4kiDrAL3cBiL
	AKqb/r/p5Nu2iyXMGp6lTXqyka6Kxe/fNkTC3HvF1ZJ3RMzKeWsulOi/4yterowh
	PQY22TeOaFkR8kicTiCvvaetzRRDlDE/4gVXUaLuZ61UwhnqgI6/1L6zL/sAh7D2
	smOhxzrR7KypbKeo8AeaWtT727phWzSIjWA==
X-ME-Sender: <xms:ycd3aHiVHZV5_K5airqR2dGF2eH-q2VGSEkJGXWOubNsBQ7pV_JDqQ>
    <xme:ycd3aMfORTVWr-hAodhqqGWyy8kLhfzIRu0alFF3jMXeTRaeVk3w9vyEHCAmBnKD3
    Ahi8lykhj1jalPRcg>
X-ME-Received: <xmr:ycd3aHhE4XvBOmfqzh2aPMyk1KMABZD--0U9IDTySbirEP2hrsIyw8kkuEHXWKYQPP7m4cZpFphnPDs9auQpk3lLCSjFQOhp94iNqDs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehkedtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepshgthhifrggssehlihhnuhigqdhmieekkhdroh
    hrghdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ycd3aEzGg7ckNNFsF2eQh_sipbqWePFoWosa3cgdg8c25ILDkSnfeg>
    <xmx:ycd3aDPVg8xUMDiPzO6D9zdWvlfXavcAmrU6U4eb0_ixS9jaCpqMqA>
    <xmx:ycd3aFUPulifWkq52EaFomQvvCNGIP7fo0N8oxfTe2EaQGnhxF0kPw>
    <xmx:ycd3aH3pKMjNeVaSX2sVE4EZx4nJEtG6jvzAeR3vXKTvndHEzxedVw>
    <xmx:ysd3aBDC1f9GQ45RZAeU6irIOxc62xQEgpmCGGHuZzVeabSQQPXZo071>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Jul 2025 11:39:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,
  schwab@linux-m68k.org,  phillip.wood123@gmail.com
Subject: Re: [PATCH v3 3/4] refs: selectively set prefix in the seek functions
In-Reply-To: <CAOLa=ZTc2_g3+8MM8whW+eZAj-+36HNsnUFDoLgnN42ytFLwAw@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 16 Jul 2025 07:40:30 -0700")
References: <20250708-306-git-for-each-ref-pagination-v3-0-8cfba1080be4@gmail.com>
	<20250708-306-git-for-each-ref-pagination-v3-3-8cfba1080be4@gmail.com>
	<aG9hMP9gEFLhVgJL@pks.im> <xmqq8qkqvjnu.fsf@gitster.g>
	<CAOLa=ZS6ASf1+nbUnCTeeH1Di=kgmhQUEQ5UXPZu051rfqx9Pw@mail.gmail.com>
	<xmqqms95if8e.fsf@gitster.g>
	<CAOLa=ZTc2_g3+8MM8whW+eZAj-+36HNsnUFDoLgnN42ytFLwAw@mail.gmail.com>
Date: Wed, 16 Jul 2025 08:39:52 -0700
Message-ID: <xmqqjz48cfg7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Let's say a user is iterating with a prefix set to 'refs/heads/', this
> would iterate over all the refs with that prefix. But mid-way the user
> realizes that they only care about 'refs/heads/feature/' prefix and they
> ask the iterator to set that as the prefix.

But is that user who changes their mind in the middle "seeking"?

It is more like "I am abandoning the enumeration I started earlier
over refs/heads/, and I want a different enumeration over
refs/heads/feature/, but because I know the implementation detail
that abandoning an iterator and creating another is more expensive,
let me reuse the one in use to repurpose it".

I wouldn't call it "seeking"; it sounds more like "resetting".
