Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1C0343D9D
	for <git@vger.kernel.org>; Sun, 12 Jul 2026 19:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783885314; cv=none; b=KNDM0r/rIOWfttK0AaCk2jErMl1fbQgs+X5OYVl7v2XW7zndNoWSGuLqLpOadYvm0pVE3AqEnd3elzwypm32n+3odB19D5MUzLoSIFDVfM8uJKw2qPCH/ezmEkzE6NRug8y4N+lCxFMDI39fCwxVQs8P9brw0lQZ+q8hwocc0Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783885314; c=relaxed/simple;
	bh=ESDUx5Dqeu/ozoTksg1SjxI2uMzWqgzW7Rn59ERYG1E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KuvZ/U8JNy1kHqvDG9uf0RGOsYyZAQln5Y0toHKINJq/v0RBzExPTRIEJlqQr+XO4ztTP+YJ+vWGHl09CRsLwUzb6QGBWPzPQIkl1Mb3wsp0z5QuwZCTu0IVqSxYesdHrtZ9hIA4ygYtRTosFgMJtqPcJs82UaUNVrs5pHSldqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hr7jcU2E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i06F/irQ; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hr7jcU2E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i06F/irQ"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6682914000C2;
	Sun, 12 Jul 2026 15:41:52 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Sun, 12 Jul 2026 15:41:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783885312; x=1783971712; bh=ESDUx5Dqeu
	/ozoTksg1SjxI2uMzWqgzW7Rn59ERYG1E=; b=hr7jcU2ELYkAj9vDtayAa2N8L5
	VxSK+vKLcczBOF3JA82//fH2MtPs3iJHs+iDvbBZSzfPpTaUC/MO0ozzGYIC7Tcb
	uk9T3rsiMWrvnjxnj8vla2fVQk5vzrnojBayxn2bKAkEXqTTGjO4LZB8E7hMgCi6
	6KYp545eHelia/YRHFZ54yRdekXvwOd7Ad5XGtEVYuGaZhrSdhfKLRmKDmHtpF7T
	qv3MXWe6gIt1bi3p1WPtR5Ii1B8WImC7ipdJJh2JC3Oxu0GrWbbBk8gjxZKXfu9k
	Lm7RVTm6c5cXgzVLfghHn/XZ+ehwAdRFo34cbeTq0JWPJi8iPTlUbeSq5Qtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783885312; x=1783971712; bh=ESDUx5Dqeu/ozoTksg1SjxI2uMzWqgzW7Rn
	59ERYG1E=; b=i06F/irQwda2N/EVorN4+E6wImqpMg72Opbe49LJShhwbVDC0+A
	/nxFR5SXpOhTwLj0Say+Xnt/ttu4w8zGloQRuzXR/o+FOUXp4bmyxNi+RoJzDSEB
	TGqK1sY4xxllAQiPx6RLRXEwB+03k613suvmGUQBDbUr/R2EKtpGTiTjKp9alMBr
	aPL0i1pljZabztfcnKr/vvDV2TwYQD0SoZuzxoU+qx+ECvug+5cS9h1rA3c9Csil
	+b2PleXEjxhbeuihiSfYWEZHd18riIBavY9A8JlvgF6UnDhwe0T2e08gCKTj52XL
	D3rIXdYnfrA4wL9yAxvBX0p0EVRJ1Y4lpwg==
X-ME-Sender: <xms:AO5TaszdEpKQIv7cpyrzV5V2IHm_pXgHrldDbioJkG9DRxG86eMr9A>
    <xme:AO5TanKeiqD_TvDs1FQ6hmspgWyKCmRHiR1fK7NeSVJ87Nbte0sAY-bwySyja48EO
    7S3raiT1d9pyB--YZj-sjJ4iFxqY4Y0X56rHsfBAtXN1SXBOJc2Dw>
X-ME-Received: <xmr:AO5Tamp1inXJ7FXhTGoJikyryMsyD0Z3b_bNX0WQ-gyzXqTMPLlRHGMVsYHiOnK_j0iDZROzFx9-vnThlHRmputa5_pFXmWVb4plwmg>
X-ME-Proxy-Cause: dmFkZTEW4XfdXZkyErPgfD60WD9rhKySc40qc5up5eNQdKlLrk949hd1oxij6TBkPKDoLd
    CzHnkoLQWWG+3M/Uza8sobyvZnGBYXvcL0d23d+UxkRVFP2epPJCbVSbIbcnEDQ7OmoeEJ
    yG0u8xTSHgYTIyHh82LtWaAd9hjnvA6LAVFY2DO8fUNKps8Rqx19NFlMp1mfjX/BPmhIAn
    x1YL9CxZL3G4OMa4KdTSxwm2ERcT7zfmDIQwn26hNzVdAJJcUQRvG56MY2bFSXbsIP6dW4
    5WyqQ9YNkm7k2/RDHUxUEN4yMjlbjPQeCKBoB1aIqskmU5s4yTaUJspIwC67dRU+2M13Rs
    0ZpXbfzOZ3+q1ZRAJkZMMWkBXaP3vptcGRx6iL5XsvmbGMTQzKxr7yOW3KCtUi6k9p2Bm2
    880QP8Fr2uSxyFziUC23oXC/ZgQwvWbSoW79QRsys6nUPcIUwghN4fOJhyYsQjBJcnEs2r
    Wt69UhEoTDfYolqoiWZ4q2UGBfoSe1FPsaKmHrtbNyBTiyhdsUmzvb/30HolB/yFGE2Jeh
    V4FI0oF0f0IAK+wezhZJwdEqDvB2fWqNh72QVc6hE1YRFmEIaniuTw2DoGhWGlJM67WldB
    3eGqmepZb4jNn8neX5pI+Mr1WofpSaMGKTxMZhuWgzoF79TuXRR0FOb+pumQ
X-ME-Proxy: <xmx:AO5TamJkyiAy3GL8uLl_NEVisb8EWwJEEs6xYE_RFQfN8Wra7a-s8Q>
    <xmx:AO5TarSGyoeR7b8XlQ9lG9lJFVHYPjryQexJcXAPmJ4-SVCZVWcgCA>
    <xmx:AO5TaltsLRBzRZT4eOL6RT4YKEu4AehHCQk8mixLR3IwPonWnwgHUw>
    <xmx:AO5TasYsztYpEa-rWd4lgT23mDcglUD7tSdZAx5g2MpMkbOv-DoEug>
    <xmx:AO5TamZTSpxAQiUAzcshiVrQM9rXIFlWBOt69cVWqcX8gj9_lsOe8zyr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 12 Jul 2026 15:41:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>,  Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren via GitGitGadget
 <gitgitgadget@gmail.com>
Subject: Re: [PATCH v3 0/2] Silence po catalog output under "make -s"
In-Reply-To: <CAHwyqnWsyWcggBBEZTfe5Np=xEAxe6iy+pekvUrsm4RY3VxTHw@mail.gmail.com>
	(Harald Nordgren's message of "Sun, 12 Jul 2026 20:31:03 +0200")
References: <pull.2339.v2.git.git.1781995570677.gitgitgadget@gmail.com>
	<pull.2339.v3.git.git.1782053803.gitgitgadget@gmail.com>
	<d38d233c-a7c9-4457-96c1-bfb75af71ffe@kdbg.org>
	<CAHwyqnX78ePVhiL+_T3FzCSA5oGaU_RPvQj6YP=s1WyULg=tdg@mail.gmail.com>
	<40b7eee4-6b45-449f-a3a0-0ae415097041@kdbg.org>
	<xmqqh5mn4eyp.fsf@gitster.g>
	<CAHwyqnWsyWcggBBEZTfe5Np=xEAxe6iy+pekvUrsm4RY3VxTHw@mail.gmail.com>
Date: Sun, 12 Jul 2026 12:41:50 -0700
Message-ID: <xmqqjyr02dxd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

> Hi!
>
> What is the status here?
>
> Harald

If I understand correctly, J6t told me to expect a pull request in
https://lore.kernel.org/git/40b7eee4-6b45-449f-a3a0-0ae415097041@kdbg.org/
but it will happen after v2.55 is tagged.

And in response I said "Thanks."

I think that is where we stand right now.

Thanks.

