Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCAD25A357
	for <git@vger.kernel.org>; Fri,  8 May 2026 02:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778208983; cv=none; b=ZytTjLrY7KD6+x+E2SKvOaL4ydOXVg3xJpy8c9Ff2cJkonLD/2EcgoVgvhrUftrrAbvJOmzf7KFfLgb5TYs/mQ2bEThHLyccvpEu5P5yJeDgQamFR31dVktfPMVz17z+5b1k/dGaBR5BM+bpfPUV88CfLh6Ske/SIfOBhxyEWPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778208983; c=relaxed/simple;
	bh=6ZfEXXX+Wf+XiVUO57Su92HU5q0jR21MYCxEfmxS0ck=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WhJBwiqwMRI3SEoaTwbbOZy3HoHPuk8Om/XreeWB7cPUuy3RAgBkTdwmarvXdNdzAStVwR5LoNy+BeSoejZxmbzgQTVnhVfxHy5W0uTXZ/c9Mdce0iaT6XX4qr6aumB55wWazT7EgTbmXzqqLUa1PnYpnlpNYgn9nKjkLIz8lwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gh7NipYA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pCveRTL4; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gh7NipYA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pCveRTL4"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 009AF1D00074;
	Thu,  7 May 2026 22:56:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Thu, 07 May 2026 22:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778208980; x=1778295380; bh=C/mbLTVEny
	p8VzRoX5bFUcuQM6iCdizuZbEhI6MiFwQ=; b=gh7NipYAg2lRPkvC1BRk9PuljV
	86Pq3fDznu4dMvWo9fQ8MNLPyneCZuEsRZXxbJBIFJBNnUp/IInqFNCe8XZRxmn6
	An8qt1/oNOqy9Nx+3EfDDMS+zR1SiaHvzN+BIedInY8FnZ4Jp9Jh/41XvrGd6jrs
	BhnhZRHkybxcv88rZqWQ7+2jy1gm70tTAbkBWNdCYASGHY2+5IAyz6wo8nXzV4Zz
	u97U1hGyGxMSsK/NtGMyLd4IG8ISOOEGpP4TTuS5O2JRAY8luPLYygZcJxV1kY/4
	B3Eu+nmnMyn3H2tn4lG5nNBzvPvSdIbEkGFGAoJepMH/MQqIJ78WUZOg17Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778208980; x=1778295380; bh=C/mbLTVEnyp8VzRoX5bFUcuQM6iCdizuZbE
	hI6MiFwQ=; b=pCveRTL49462/c66Z4/I7/EEmToPbyEDIBzQK5rvsGE2s7aj4ug
	37YMP3Mrb5hRaEHZwccESxtHbtDXasvomFiCJeJp5lXC2e+tJtV6Pu/or4JcG/Ka
	My/0UvqTYnUWhrjkQbMC9PAQTUinC438GILUAVqKNcVlZ4teU5Wz+Enq6uOhkc+d
	Puky7ShCpyG1DKNIMoDhPj08m465s1Kqkcp/fPcz1lxDB6vdjMiw4RuXb836MKSP
	Tn4XeUjx452NTIWQXf70vjFwMLDtKqbHXr42KemL0RwbL9AjceN/3Dcz98qrIqZD
	bJgMQA/hnsKImb8i6TSqsR8GUtS0BUhTwDA==
X-ME-Sender: <xms:1FD9aVr1V_brRbnJI4sL67YDCysP_j6zdGQFPSVuASaQMDWuPS02jA>
    <xme:1FD9aeg5B0BWphORekV0LInmfTLKJzE3VAN3HTdabCzFUe1ntML-b8IkQBLrhfiK9
    0cKnkWiaLMbqPNGDoFKyrexTc-5Hz9wTlPUxevkiWjwDrufww7hGw>
X-ME-Received: <xmr:1FD9aaiqDPbVmXbOJhSoODiH6a5zScZLqlXu_MUSHPZ1M_VkHx8fmSj7a76tfiHaKCiJbxVjpfyEf-Wpuqq6ZXWRRLLq-EbxPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdelvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehpshesphhkshdrihhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlh
    hinhesghhmgidruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:1FD9acjDOK0usPyFaUyXnV0xoqbbtE8FHlNLT3AoDzZam7VLvPiLMQ>
    <xmx:1FD9aSLJhuKSvGgSs63cSs0nZnFtZdUGnlcO6yBUv8Kxy9p2QHRcCg>
    <xmx:1FD9aTGJbHcEi6nRvC9IC01u8cuB8B6K9MM38n5QcZQ7vmO2HkUpPg>
    <xmx:1FD9aeS33am5DE39q97q7boB1U-0pd2mz5QZgXnaN5IfJa_Jw0Xsjg>
    <xmx:1FD9aS4677y3g-XeVZVMrIa5gLVNIk7hFPtBi-Tk17dX-_P9jb1Nf4FR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 May 2026 22:56:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Johannes
 Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 0/6] mingw: stop using nedmalloc
In-Reply-To: <pull.2104.v2.git.1778169613.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Thu, 07 May 2026 16:00:07
	+0000")
References: <pull.2104.git.1777811392756.gitgitgadget@gmail.com>
	<pull.2104.v2.git.1778169613.gitgitgadget@gmail.com>
Date: Fri, 08 May 2026 11:56:19 +0900
Message-ID: <xmqqfr42fw30.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> The patches that remove the vendored sources have a slightly unusual shape:
> the Git mailing list rejects messages over 100kB and
> compat/nedmalloc/malloc.c.h alone is ~196kB of source, so the deletion of
> that file is split at section boundaries into three commits, each
> comfortably under the cap.

The history made strange only by the limitation of the tool (i.e.,
mailing list) we use is like the tail wagging the dog.  Could you
give a commit log message that describes droppage of everything done
in the "artificially stepwise only due to mailing list limitation,
but we wish we could do in a single step because the separation is
not logical at all" in the later steps, to the first of such steps
([2/6], I presume), and give each remaining patch a single liner "to
be squashed into [2/6]" log message, or something?  Then I can
squash them on my end.  Alternatively for this one only after we get
favourable reviews on the early two steps to drop the use of the
library, I can pull a single "discard everything" patch that builds
on these two from your repository.

Thanks.
