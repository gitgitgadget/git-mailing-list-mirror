Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E47D2BEC4E
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 20:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787256647; cv=none; b=ReAmUXCvsUSXQ+SyFyfLA2RwBLlV+2ieQrwJbGvrovtK0L8RkqUIkOc64GJGw3SVtG1FEe6Uqck+POKhBocKrb4gVQ5wqq64JqtrXKC6bY+oFb67gA3BuE8PFgZCYC59cyi4qtdrF8IBdRtIXMOd1fe73W93rcRZv6eeBiP3frw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787256647; c=relaxed/simple;
	bh=n4zJXxtwEeeVL3i+e48EPJFCd9g1WGV0srjwr9ci5pE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JnzjsQDWkjj2+kqH9ClEg8wqweS2d3vXoPSzPz7//phQzQiGfXuwvQTnEMlDBx0tsQFiUISrC2E0KNf7JIy69RydqIqB9hKr7bMNprsJ5K4Hi3YdVQNIz0oB8m8/ZWQGw0GBBdcS236jZ3n6ntIcEwx6VDTbPQ6Zd7LcwyRpPQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=O5Of35ZB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LjoqLLY6; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="O5Of35ZB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LjoqLLY6"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 7723FEC03A9;
	Thu, 20 Aug 2026 16:10:44 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 20 Aug 2026 16:10:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787256644; x=1787343044; bh=M4xU9eYMAJ
	k+pg/8NQd9ceoeRlMdCJdfDnloLRuS/E0=; b=O5Of35ZB2gfqyCQSDR3oINLeDm
	NBVcMw46lOW+4f9Qge6V7S3+gsBiV6C09N5bmAxu5p3XgUPqR0wQDHAsbiCdl6H2
	zF+6m7y9hZEqpa9HbVIzlOe8uUm0IxnZlamhyXq7LZiL+XuTtbW17hGYkwbcVKz1
	NyQ/oR5BhQuaKVMI0JNprfdM+iqkt3CjYSO0o7WoVQ9KpqiLYmT8urZkeaws6Chg
	z3gjdlDCQt3kbkMiVzBIxUm3PRWVlv0kkER0TfgdYW2oLEtvRd3f+t3UdtytTPnU
	afUrMumCqndKWn6XBgGGOrhDyljMBwDsBFE9SgvEuEHIEpjg1ZZB5so6HvRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787256644; x=1787343044; bh=M4xU9eYMAJk+pg/8NQd9ceoeRlMdCJdfDnl
	oLRuS/E0=; b=LjoqLLY6B3+hnoTFcb5KLq2uNEhd37y+Sil2htUg4o0xY62fU7P
	iu0wk50R1QNCnS/uWGRrD8vM8/npltajJiLLIN3K39Ov/DkAPZ/V55gfbDMOwo9z
	jki574ntV1UouB8qIpn7fGzhFnwZudUNkg4PyNo++TbckSnTcHAKqlZJkcJ8VT+z
	F5NlYS8MY69tV421gBVTiBTvSYe1uLXcutbo5gj7BkIZ594TK1hexqL9gErth0Yc
	Ci2lBvKLH1+mIL7jF/7SuAFaaZttBk2/EEqpF43Gq2jMhwbawyF09Un0H/nI1561
	jOjkFSiyOI5n7QOdqhHBIE7qphXXzW/ryJg==
X-ME-Sender: <xms:RF-Hatr-o1CDgS7oAMniPJmUBY59A1ynL4ARYuJMSXJ_0HWdmcPkGg>
    <xme:RF-HasNFjyHoFqE1JN4NKMnry7BQYdGz2NoWjj5pA-l1zJ5KA1bI2qxbV5ZK5xfgu
    1cDYX1KuyEWqKcoWvwvEl0wdipxdm50a9b_Y1ihj9oqbiZfQFhJesw>
X-ME-Received: <xmr:RF-HauoeGOD1r8mV1FjQ_SgIXyGcJ862Zgz_Jc8HS-T3ArGf8rDkCdmPaxksCNdZ7SrxRFjNW4eTyzlDQrYivCW_u_MINCiWdw>
X-ME-Proxy-Cause: dmFkZTFB1Trfo9wiRxp/sV/4XO1WRAyqt3rsQ3+i9YcMHN3rL0rT05kh1hc10bV1srjXsm
    8kkM1p3xS1pXtCdDh1CBpxZsojkfl7N6kdTRDUi0eXImXiHJxgDYQX3iJAZdHjb+uRr3fi
    aPo7VzspNDTVQta+CV5SwZeyPwVUDR/DXPAy6T5yayRwRNMBJh8LzCsVi+mBoeB28PAEqh
    JF9yDjjV9DEhA07hnMauqx5UWq+lPChnKpf1jbTHSLM8Z/albfiRoFzVj7ky9TK17sJmYt
    91OyBJeaYejZfgDzaAtlzfiebXRqUP493qO+udDkhNP958LABSz5bfjCHTuieepBLElUoZ
    UXIk54ly6u3dmLCHmTiU5WxuTI6WTxpVoSxUWGJfWT/M37EbaRSesqCG34qIlo8UehUPMl
    AhfCDYeZ4IoTbZIttPl+EPCMA0Uli8N9ID+4MG7p/hSSgOBoNTVxJd0QybvpQ9J0IuYms6
    gnVpzFsxBA2ZevUH+WLIfyFm4oAkWnzKPiJCR44Rdmca4RL9xUa+FJmj0cXn2u9AHsi1px
    bYQySdnV2O1C587EmXRpFLhGOazTEk6ls9ZvV26OLFkguEq8vfwRpcdYPfcKcpWar7bkj0
    wudmE8Ol74Fx0y0OcgF8c31nzw2t21hN5Xe08NcDZJ7EzgNRqHQIKozF1EJg
X-ME-Proxy: <xmx:RF-HavtmOLKRU_sBOu3vEB2VlXSdKtGaNjFTrnJrxFvn93YI5eNBiw>
    <xmx:RF-Hat0yC4SyTR6xEjcJ-TJPqQezizaoquDc3JSo7QLp-arNsXeIkw>
    <xmx:RF-HaqGtNasTH59AucbxDwpcXcDI08ZLGUulZSQxOxxFl3Y0WL27og>
    <xmx:RF-Haov8BWJYSfR3Fesngl608XRh5rqLm32PXpO2NjxkBrZ1rdaAiw>
    <xmx:RF-Hav4SR4dDO-4D2owum64-Dt2y22N8Fiqq_fdWaxB8324CewPwmVOt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 16:10:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  Patrick Steinhardt <ps@pks.im>,  Matt
 Hunter <m@lfurio.us>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Tuomas Ahola <taahol@utu.fi>,  Harald
 Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v14 7/8] history: create squashed commits without editing
In-Reply-To: <03528d3b34c202b990cc42865a009a5786255b7c.1787249432.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Thu, 20 Aug 2026
	18:10:31 +0000")
References: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com>
	<pull.2337.v14.git.git.1787249432.gitgitgadget@gmail.com>
	<03528d3b34c202b990cc42865a009a5786255b7c.1787249432.git.gitgitgadget@gmail.com>
Date: Thu, 20 Aug 2026 13:10:42 -0700
Message-ID: <xmqq4igov9h9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +	/*
> +	 * Allow "fixup! <hex object id>", but not "fixup! HEAD^" or
> +	 * "fixup! main". If the target is not being squshed check the subject
> +	 * to allow "fixup! abc123" and "fixup! <subject of abc123>" to be
> +	 * squashed together.
> +	 */
> +	target = lookup_commit_reference_by_name(s);
> +	if (target && istarts_with(oid_to_hex(&target->object.oid), s)) {

Why istarts_with()?  "fixup! ABCdef" should not be accepted, should it?
