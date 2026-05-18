Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA93C278156
	for <git@vger.kernel.org>; Mon, 18 May 2026 02:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779070266; cv=none; b=Zp7gJQ6TlfuY4CTNFXM+UE8bMA/sYY+pwYdBYYiHrQc4WM7SYK5Kc04awI5EOLdwJIUHQ1786+1ddD03bRAtL5kxGkaEMfrTL1JUDPe5kd6kQ7ybL7NkJNiYHpXiCd9yyurvZJOqRKavT2LWKDpTsThRGkLooMaw2eDYI3Ur5H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779070266; c=relaxed/simple;
	bh=clFyR7mRGfNZs3JLRlGeT60lYdCPX9Ihym43ZO/1vls=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=jntu7OoSyQb4ei5dUe/hUJBIyKJ2R3UkelyQTJaAt4WbsYvJLqN+aecUQFIs/wc5j0pq08hzD5OSMvNqv4g/S2e4zpwWjXq4zJi+q6MkX986QWs2W95+aliqtNukvm7KdZuj67/PBJPJ+ejGQw04cdYf6sJVbkG/objn0/Js79w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Vq367naD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tWztYp32; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Vq367naD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tWztYp32"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 44B7B14000F1;
	Sun, 17 May 2026 22:11:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sun, 17 May 2026 22:11:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779070264; x=1779156664; bh=4U18bY/540
	aR12R9ZKxRsT1OBsHYIVyoU4iyOojvYSc=; b=Vq367naDfmJyeu+MIslpxjij6z
	C2z/+JqB7Oo8I7ySfhR+X8yJ0l2xnYYedpdlrOCKujI8RSti+i+ELuC12OAGeHyE
	U84Xpe6ptLcUouyHDggoyqYoecucYMbXTzxxFnTS9VT3tvgrSE/iyI85znUot/Qm
	7BPrzjMjz/bu17IcpxDT4S3qqivPzlxIiY1oaIfxETaZ5x5Vb8B8hf4ZPwyW2wSc
	AnTU5HY8Asj3fUqBiD7vhKLrNlXEDmiMajYbGlksoV5NsuhOMDxgg3KlB7MKHtY0
	pcWPsMTchaQPbUZNgU9N5fY8JjMoQfiBwiZWfk82HfRISyagf//1yGu3PW+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779070264; x=1779156664; bh=4U18bY/540aR12R9ZKxRsT1OBsHYIVyoU4i
	yOojvYSc=; b=tWztYp32kES4g72ucwhe5wOyWownk0h3OX1422o92pKRvFkDs+W
	fH0AuKzeAo2NnH44hIg92U9yvroEZX5OHS8aI6rCCiK0s3kCVncP9CiRzW7dL0RP
	PESKuDaVG/V/V4RjZLM+mCaMieWt8zI/jbcMjNADALrXgCtJ11ud1UcL9kX7xjB6
	g6HSfVMv55kH/qxDmz2AxiIhfuaauauKedzS5SryUT6OYxS4BI5qTCHnrs84P9Up
	nHQbHP3dU9WiRST7oi5G/iwIUi8tfbTdNMZZhom4CuYtE8V8T2RkdY/FqjK6AXCz
	vVL1XEWnQuZaDFmORAdncLtty/z8lOaCLgg==
X-ME-Sender: <xms:OHUKamGihBCQyVWwyV0Qq67BOzidPXOkgUY8UQYWtNtjHeeDDNVdHg>
    <xme:OHUKauUJ92QF7N9fczR0BgNlR4aHcHZWBtds0rUCOaNUdbw1UQOXT-Dc1arJlg6Ia
    mhSlHyQBYblU_eBfE1wUlHDfJVa0yLnNQRMdzwh9Cq5EqD6ZH2F0Q>
X-ME-Received: <xmr:OHUKalICGROACWtZjOpm2lhsM14zepSA3z1ptgiE3qjyHj7as6EOtPUWPEO7BT4UgvBoVC0SE1gQGAsVGsAorvb4umbbgZM9XZLeCCHJnBgF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeejieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufhffjgfkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepvdfgfefhjeejveefhefftdffteefudeuhfekjeeffeffueehudelueetgfei
    tefhnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfh
    hrpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:OHUKau-2c7IxTPAad3ovQRpo-MuzNO2hZyZNNDn-9tgDpyUQtV6iCA>
    <xmx:OHUKaoLTNIXT2foQJZn-jJXu2roPmyp4Ax4MxzxzFRt_RsvQjXLxgg>
    <xmx:OHUKajko8zMKEPO7mYyUBIj4LhSnbp7y7ZTgp8XjF-Y-OJQteLSRmA>
    <xmx:OHUKasNpIp88F67RSq-aN-q--ZaAvmJ9fI0vQmmMZmRa76XEjaGIng>
    <xmx:OHUKavIKpgjVq2Av1iTMo5Irxk6y-MO1IpZYy9u7uEwgx8hRGxT5odFa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 17 May 2026 22:11:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH 1/5] doc: convert git-bisect to synopsis style
References: <pull.2117.git.1779049615.gitgitgadget@gmail.com>
	<dca7f192f1e5cdfb57682feace0a4b3a10204376.1779049615.git.gitgitgadget@gmail.com>
	<xmqq4ik5d0le.fsf@gitster.g>
Date: Mon, 18 May 2026 11:10:58 +0900
In-Reply-To: <xmqq4ik5d0le.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	18 May 2026 09:26:37 +0900")
Message-ID: <87tss5wjpp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

>> +[synopsis]
>>  ------------------------------------------------
>>  $ git bisect reset <commit>
>>  ------------------------------------------------
>
> and
>
>> +[synopsis]
>>  ------------------------------------------------
>>  git bisect old [<rev>]
>>  ------------------------------------------------
>
> were a bit surprising and confusing.  They are not exactly command
> syntax definitions (which is the SYNOPSIS section is about), but
> examples of usage.  The one with '$' command line prompt feels
> particularly confusing, as the prompt is not something that the
> end-user gives, unlike what we write in the synopsis section.
>
> Other than that, this is quite exciting.

Well, my local test with asciidoctor did not barf, but it seems that
the documentation pipeline run in GitHub Actions CI is unhappy.

https://github.com/git/git/actions/runs/26008649802/job/76444895183#step:4:4846

I do not know what the differences among the three environments
(counting your development environment---only one of which fails)
are offhand.

