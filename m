Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F033E315A
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 17:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775755953; cv=none; b=EN4lUEeL6rhk+XKFXlC3wpOULwDAZ9COilkL7ic0LtLdB0OzvbCfIKXuFDO0nQgu6vz0yBm32YlUVMd/aV9Z7OFazM3wynr8BAhhNnt0FSoVQgPG5ytMFKPej9zvifWXkz0UCQtUXau4aOSoLxF+DVnEIcK5KJcUua0NfjuWw84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775755953; c=relaxed/simple;
	bh=6LwOX0CZ8pLf3UFG8EeVCpaCkmc0Yvdr5PK/XQyVIwA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gPkknKhmafbwTGMDdRVPW1/8gcIql0FzWsC8b7FgRpzfxcWaYLzUGnI3MIXOEP3j6Fy5O6Pgy8zdP6lRzEzc3LGsTaFV+qmFf0WV5cOQZTdcfWDsP/3uk8NH8/m2gUs0OpEWluBDqyCZZQaa3yNWXf2Mpiwloyns7952/te6qwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ksSF8Trm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mEz47EVz; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ksSF8Trm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mEz47EVz"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 973211400183;
	Thu,  9 Apr 2026 13:32:22 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 09 Apr 2026 13:32:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775755942; x=1775842342; bh=WcuEsjezXj
	lboePJ6HmEJCzt8tdhJ4BQGsGPimEs2BM=; b=ksSF8Trmt9kQsBbGF1Ir5amw3V
	9/YFrYIhDXJw5rquiPCXT/ISOhuMeLN89UkAao34N9j4zipKwCpMmCfDGNniOOKs
	7QeEisxXiuTEHbtIodeOoypuulK7O44Qb+Z1ZKseg6Wu13BpR9r9izjURlr4m1zd
	euF4jEoacnLWLbnpx45Dr6CNUrOUfcpk0VZ2rIGsNmd7+Ys2sqLsdeLo2zqNjZ8H
	EJQ8xXNfeTt3bF2rI/FCY44GPBzw6T+hUv+zXZAKQGUFpwcVhmLzpKhX5uccdsKh
	x7LSYdEPgg6XwyYwbExPq4jbQnLIBc3Y/8cWfgmEmXBcgoaJ7jGg31QvRncA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775755942; x=1775842342; bh=WcuEsjezXjlboePJ6HmEJCzt8tdhJ4BQGsG
	PimEs2BM=; b=mEz47EVzCQe5G73Jl08ijDN5zreGFndT6AUIQLqgR2dTK/p33gv
	1R+6XMa9EGQep1kRYeHZSBoF5SXwUuyJf7DNIDhF6fBD5yoSZtk/QF25Rmqjs85R
	mDd1wZ3r8+fW6FR3fNRTR7Cdlz59ayU101wCBuLSRk0HtwJEFM18GWQAFuGceRsd
	MxE4nIDMmADIeqpUaKjLrntzlYR8tymsQgLc2cM7dgyUVl2eedosweGjO2lep4Xf
	8u7sfkwt2vTqLA4yDELyhD9nI4y8BpLboI0LZWerjKfCnMTtKQpovdWvNBfFtLLg
	fCtWLZYYskQdfvmbaJwN7tkP3JMAmo00iCw==
X-ME-Sender: <xms:puLXaYtEKQSmUe-NRCkpUUjVTo8xPSRidj9H5GZoTh0ENaEV_dx0gA>
    <xme:puLXacX3d65u4JSE-UXsIQWeefeFcLyHvg8ddoWfAQ7HXVxJ-9PbmHqyuf74E_GL3
    OZfHfzQTbOeBPTdriX4Mxq14gokZvd0OW91clQSR2uO_1FDd60xDg>
X-ME-Received: <xmr:puLXacEPXvQ-IPiZ3Jx63w4HAEth9PwdI620rAR2LbJoDiOAyO2kjxESRNnLW_cKLsNsLztRefnHkKuhGysobJmLw8GggzSeug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvjedutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehhrg
    hrrghlughnohhrughgrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:puLXaW1FwfdRVL5v9NgTuBgfLGZIUoocTg6vAG75zAaDxC5KlDY_RQ>
    <xmx:puLXaWM6PN3JMl-y8qAKD8RidbkXQ_8PiGfZ3KpJ209An78xYQFVOQ>
    <xmx:puLXad4nWgDtNNkQ7EfpAUTmSXBDWXVtXRWlVei6SdrMJSXpGmYeYw>
    <xmx:puLXaY21FcGQUy92t_T_H5knKzyAOcpQvXnssm1bYZ9zLtBzXWjY4w>
    <xmx:puLXaeHRlhMailn4k2KwWqDXnZhfunaij77YdgYwna-er3dLjrx4XFC_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 13:32:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  Harald
 Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v7 3/4] sequencer: teach autostash apply to take
 optional conflict marker labels
In-Reply-To: <c0d6b4b4c0a53af2fd76d23e04c540418ddd086d.1775741265.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Thu, 09 Apr 2026
	13:27:44 +0000")
References: <pull.2234.v6.git.git.1773740139.gitgitgadget@gmail.com>
	<pull.2234.v7.git.git.1775741265.gitgitgadget@gmail.com>
	<c0d6b4b4c0a53af2fd76d23e04c540418ddd086d.1775741265.git.gitgitgadget@gmail.com>
Date: Thu, 09 Apr 2026 10:32:20 -0700
Message-ID: <xmqq1pgoujiz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> Add label1, label2, and label_ancestor parameters to the autostash
> apply machinery so callers can pass custom conflict marker labels
> through to "git stash apply --ours-label/--theirs-label/--base-label".
> Introduce apply_autostash_ref_with_labels() for callers that want
> to pass labels.

It is just a naming thing, but the contrast between label[12] vs
label_ancestor feel a bit uneven.  Wouldn't it make it easier to
grok a hunk like this, if you stick to ours/theirs/base terminlogy?

> +		if (label1)
> +			strvec_pushf(&child.args, "--ours-label=%s", label1);
> +		if (label2)
> +			strvec_pushf(&child.args, "--theirs-label=%s", label2);
> +		if (label_ancestor)
> +			strvec_pushf(&child.args, "--base-label=%s", label_ancestor);

Alternatively, if you prefer a conciseness of numbered names, it is
customary to use "1" for the common ancestor, "2" for ours, and "3"
for theirs, following the same model after how higher stage index
entries are used during a conflicting merge.

Other than that, this step is quite straight-forward and looking
good.
