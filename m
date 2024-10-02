Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C34C1DB52A
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 18:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727892894; cv=none; b=DkCEBEErOjPdgPrHFqc/ialCvlVC/2FVGvugo5MTrC589d4WM9Vw/pezWrbwPueMt1mVm9mMrZJQkooKkMR6jvyqDunekZPugpZQlOCoN4lEAu5XMw1qrkYehiaNkg+xdKN6fUJuXqhYND39FVUoDA+loBZcWgB3lJWv3I6aPQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727892894; c=relaxed/simple;
	bh=rr0hEUc6A5r2n0n5PSF4ZPL+NfpidbukEHym+RkytgI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fjFS/3VGoryMPySMhsYejAyZv83mGGpYNTTIgNFT3ha6+bf/mm2D1n+eT9y5QegEjmcZm0QWkcX6hyomjW9tAlQDX1FZvoinAnSv3ZX9TqzF2sX2wZfnLmpos1pBMHxpYj6HniQCPPtmrfjwrumHAOH2J0UI4AGJja5jzimNL8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=l+6WeQws; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WDDAyVWK; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="l+6WeQws";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WDDAyVWK"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 1C96C138016E;
	Wed,  2 Oct 2024 14:14:52 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Wed, 02 Oct 2024 14:14:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727892892; x=1727979292; bh=lJYJRK8qaR
	3e3xgR17XIdxXGPOE5G+cUNQnJOQninoA=; b=l+6WeQwseQ9uzmlCdVNvNEhJW5
	nR9bGO07+3Bs3jAQBAooqSXJFlYgonHc39pR8GoZ9dzVEla6aSWr4Kbk11nPS3mx
	xENLOD+dvMh4UAGBkkJewycz9VKyG3MYzauWy/lE+vCSDPDU0/gZYGrC1frAeKzt
	JQBN+1i4FMEf+MA9JyqRkSNGV52WAu/fBsChiLmSqVJbakX/3Nfl3snNcheW0eAq
	uaestWfALs1oxNI+gKdcfVa6dnbyuisUUIEQOgeNYlzVsdMz9bYEt3TB9Xma+Ms9
	lABor9BlxwWrQTAoZTc8l4ucM5LfUZG4G67JmjfKBnQTceXgCeGbzpzw7wiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727892892; x=1727979292; bh=lJYJRK8qaR3e3xgR17XIdxXGPOE5
	G+cUNQnJOQninoA=; b=WDDAyVWKnIcjL+kjcViq+LfLaAIaUTPVhWs+1Lv6CFfU
	a/SLNIKzk3kyUsQtBF64/1zX8W7kFjpK6HOPFwizsnjbP03q+DmvwTsaXMX9YOq9
	mtemMmsatkNEgWC99VnJMhCTBupiXeimeOXKQ/gV4nCmilIoAIqN8jTF0SQElegP
	HfiVuHquXWQ/NB5lg3pBfyxHY3ly6cd3BQIw43uUojfaPWi+9Q6It96vWZQmko6x
	beauV5/9euTaI0ojtABzRJdx6WOuBd4RCMZ1bfM12MscROjaOBLXyQspNhLmWP6/
	2ILJhineQMW13YlLzWmIYfp2fLxZB326y2pPDEbbZA==
X-ME-Sender: <xms:m439ZiCUEfA2aJN4w8hSA0a02ruzLvvVvjfzti4G7u2BS5lnO1BrfQ>
    <xme:m439ZsjtBph7Q1ch8qdAN_AhhBi0sdkRMLsBjdf9PSnKr8aylDYIVu-WoyyPZ0Uqs
    rfbqMmbZ_dt5rQRhg>
X-ME-Received: <xmr:m439ZllGVZD2BeQ5cI1axj-a-fShlmxljmhz_I796Ik7pmrf4TxfcAEdkaSLA5nYmuR7eLCb1bwGyE8J2X-k3dU8jnewTVjG-276_KI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkohhjihdrnhgrkh
    grmhgrrhhusehgrhgvvgdrnhgvthdprhgtphhtthhopehgihhtghhithhgrggughgvthes
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:m439ZgxWcl5YdfTMtTtHrQ_xS-ncrkP7FomgzmF0FnjTvbsS6EGF_A>
    <xmx:m439ZnQvUedaRtWnGTAECrDHmwG5DOL80jhRas6U7DaONngSS6Aq9A>
    <xmx:m439ZrYICka42zbikGZf6cbYt0d4DNgb-TrEjtA4YGyuNgnUoSJr_g>
    <xmx:m439ZgTLfiSaCLOqN-Lc4_9mNcUZj_tLszukMwH9aSN6h7KakZIy8w>
    <xmx:nI39ZlM29ZwiuYtmOsFnWxwXyXLInXU1YqJXU7g8jrxqWy9OIoWKFi4n>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 14:14:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Koji Nakamaru <koji.nakamaru@gree.net>
Cc: Koji Nakamaru via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH v2] fsmonitor OSX: fix hangs for submodules
In-Reply-To: <CAOTNsDygwBkNdFX4K_ixL5kP-AvDxWWVXkvfkmV4Kh04ozdYkA@mail.gmail.com>
	(Koji Nakamaru's message of "Wed, 2 Oct 2024 15:58:29 +0900")
References: <pull.1802.git.1727577690390.gitgitgadget@gmail.com>
	<pull.1802.v2.git.1727759371110.gitgitgadget@gmail.com>
	<xmqqwmis11f7.fsf@gitster.g>
	<CAOTNsDyg2SB-wd+a7vrctXck46jyfqV4uME6nf4YQZEafWbxMw@mail.gmail.com>
	<xmqqmsjnya1c.fsf@gitster.g>
	<CAOTNsDz=gV1TQ=N+8V+CdhWkPSogNM-42B+vzhDNWdM-Wz9CfQ@mail.gmail.com>
	<CAOTNsDygwBkNdFX4K_ixL5kP-AvDxWWVXkvfkmV4Kh04ozdYkA@mail.gmail.com>
Date: Wed, 02 Oct 2024 11:14:50 -0700
Message-ID: <xmqqploimkx1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Koji Nakamaru <koji.nakamaru@gree.net> writes:

> On windows, there is no process group so the test cannot run
> correctly. As hangs corrected with the patch occur only for darwin, I
> would like to skip MINGW in the test. Is it okay?

Surely.  But can we do so without spelling MINGW or WINDOWS out?

That is, if your test requires process group features available, can
we come up with a lazy prerequisite and use that to decide if we
skip the test?

Earlier in the discussion, you said who are left behind if we did so
on systems with process groups, but I wonder what happens when we
throw a signal at the top-level "git" process on Windows, and if it
behaves better, perhaps we can implement stop_git differently where
process groups are not available, instead of skipping the tests
altogether?

Thanks.

