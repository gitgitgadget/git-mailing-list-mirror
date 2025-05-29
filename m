Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902C7EAD7
	for <git@vger.kernel.org>; Thu, 29 May 2025 22:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748556291; cv=none; b=DM9B8J+rQbsMUscrYCrN3D95p0DX7XygdaMprXhh/0lCgw5srNZEEwkTYuuRggt4/NCmWc/Ga3e6iBCPL6/JzrPYVko8FMKizD/8aBnVvVJlM+DzmmCwk1u+b91WaOKDQNEqHydOZlCJsJYj9c+ucucZJw7Z2dxNKjEhi4GHNVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748556291; c=relaxed/simple;
	bh=Dyx/eGyiOd1zzNWDT13NdumBiXOFngmUIvXbNd2/L88=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JPz5IsABBYsxuQnCxlgNZ6PDk9OpDujb7t77f4SNXIzPzKDgQWNpM5cBhqM+8EcniS5U0cgtgrTM57OTfRvEKRoGteml8VqVwYw9v1Ew+m7dE4lXwX13Pb8CgrIhVkLPlxo1w15vxwZiZ6zNBoXKmF3xvU+H3IBSsU+NzXLNBn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=tV6nLR4g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L8HNHN3a; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="tV6nLR4g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L8HNHN3a"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 846C61380335;
	Thu, 29 May 2025 18:04:48 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 29 May 2025 18:04:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748556288; x=1748642688; bh=PAe1GSqB+L
	uzKOk0XZRiezpb+yJtQOu5+ZU49WGPzX8=; b=tV6nLR4gQKMHuazq0Z9Nxp0IBz
	het4N/R/yqVZjQDu5mPscy4t17fcoYC3vE2zoV9ToyXnRrTPHcnnW8/5eyyX3Aw+
	QTImz88dblELYbiKIoAA7C07fx/CkPpnDCWXRK2Bg7CnhHTH3FQjDZy3QIivwHOJ
	srKpq//kok9Ba40ClDVjugrLoWOewkC/LczOGtQMA/KQuuoyYX5MictkTzoa1LZG
	PrNVC8EX1VY5D77nsoMz1rvkW/RVphe64Bln88COVoU3ebXCbY1IC1RnqhfI7eZf
	J3D0cTL0Jfp2dQ+adfKBB4sFjLHiJqfSGIcB+ovNCwzo45EZR4RnZM8uomBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748556288; x=1748642688; bh=PAe1GSqB+LuzKOk0XZRiezpb+yJtQOu5+ZU
	49WGPzX8=; b=L8HNHN3a501YgVRvVa7qTxQVSvJ2VLZF0aSBBZcDxU1CsePCOa2
	3WU/2etiLW3VLjTHZ54D79MkskIFz2NRzJGs/zetG6sm1J1D6gssaacR3E3OmVvY
	t9v+cJ8TavfseG3u1vRKL/Z91PvqEZknc6p8oGD5rwpGpzbutYFiTpsDHPsigSlS
	delhzCE7vUM2MLnYqU1LV1Oik/SDqYfHPf0pJZxVKv66M1HDGEGrlnBdVMRFAHhm
	KKy6RofX+5G9LmaFMwKF3O8TbOWkDCwd7q6FEYzqB84QPeX0ZKGfzGauCpKCam8z
	qzJ1RWhdjHXSIbvJfI1BWa0HPrsg3bgLd+Q==
X-ME-Sender: <xms:_9k4aBJEPCIyUYeSlBee2u53gtuQi7SrVKXDETCLZBUY_oduoNga6Q>
    <xme:_9k4aNJDX10VtA8uPOU5ulcnKnMQJizxHDDNocU5uppBOnpxn_3-fI5CG2g3eIwlZ
    ajFGuomorgrFTv54w>
X-ME-Received: <xmr:_9k4aJvkdvGqFOfkGg-Q3mD4f5JeNcmJq-64rLNfFNy0IDA2U5Ramdoyk2Lu-feYy4EcOOej06ipjMibu-EoyKekGQdpjp8R0GPwWnM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvjedvkeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteej
    heeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithhgihhtghgr
    ughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohep
    hedtvddtvdegfeeftddtheeisehsmhgrihhlrdhnjhhurdgvughurdgtnhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:_9k4aCYEyg692fdue3aC8RzMrGbmNvrhW-81-t6ASkFkzYwUHdSeKg>
    <xmx:_9k4aIasCc8JHo-fusJJNuQC-aKGzCl9mE1UmJ6NLt8R7B9fFVLo_g>
    <xmx:_9k4aGB1jZg_NYjwQ9YSBSUo99GiNzOL-PiWrJ54fUCzwd4z4klBvA>
    <xmx:_9k4aGbLzPJkXDp8W7Bvw0Hl6x3sYQlyQT0sinmuX1qVBzCgfXy3Rg>
    <xmx:ANo4aAiX7ULtDqQsnpB_Jt8fWGTzi88gkaG21dstXuvNMTx8G-WDDhko>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 May 2025 18:04:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Taylor Blau via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Jeff King <peff@peff.net>,  Lidong Yan
 <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH v4 1/2] pack-bitmap: fix memory leak if load_bitmap()
 failed
In-Reply-To: <aDi8OD08I6+6BLja@nand.local> (Taylor Blau's message of "Thu, 29
	May 2025 15:57:44 -0400")
References: <pull.1962.v3.git.git.1748138764.gitgitgadget@gmail.com>
	<pull.1962.v4.git.git.1748140983.gitgitgadget@gmail.com>
	<b6b3a83a22486d0c104c494d1950fdaa2f2a658c.1748140983.git.gitgitgadget@gmail.com>
	<xmqqjz5zmnxy.fsf@gitster.g> <aDi8OD08I6+6BLja@nand.local>
Date: Thu, 29 May 2025 15:04:45 -0700
Message-ID: <xmqqjz5zhy4i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> In c11c3b5681 (Documentation/SubmittingPatches: What's Acked-by and
> Tested-by?, 2008-02-03) you added:
>
>     Notice that you can place your own Signed-off-by: line when
>     forwarding somebody else's patch [...]. Indeed you are encouraged
>     to do so.  [...]
>
> and that text survives into the current version of SubmittingPatches.
> So I think that while our documentation encourages people to add their
> own S-o-b to others' patches sent on their behalf, it doesn't
> explicitly require it.

It would not hurt that much if I pretended that I ignored what
Lidong forwarded and picked up your patch directly from the list,
only because what was forwarded was public.  If it were a privately
shared patch, sign-off is required, so we'd need to tighten the
language in the SubmittingPatches document, I think.

Thanks.
