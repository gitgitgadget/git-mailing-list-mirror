Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376B72EB5BF
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 21:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756934931; cv=none; b=O3pwqjo3Vjebhw2WPrtRx0+GgZt6HmUzsY7xQ0Jeb/VUN431EUPALqvKIEZNylDZZhynca0xlZnyWz7whqITq2C2boSL6ufcr5xNMD/KnBWn4oaS6pnyBEF8O1xKIDn/g7pl4KnKGdcGnbNH0qbrKRlN7q1C0E5mzx22xlzcjjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756934931; c=relaxed/simple;
	bh=okipzJux//nZXiLV132D3W5C7YIFNDoIna6+VQPjEQg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=XKQ+t4O064NYnHrviSb5WeWx+pGp1aD5y8shks1ZcJDnAxdAsVluWVJG5q61zWz9cMu76SoEmDWGqlTjfvH958nIuddPh2Q71dhpNt1hmc+AYa6cvzyJ6CnnLLbBeg9PVwsYtwxX5OWpJd0urxobr4vq0gewLBE8auiAuAysVDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=jUeMzF9p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UtuYTLsv; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="jUeMzF9p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UtuYTLsv"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 55CA1EC01FF;
	Wed,  3 Sep 2025 17:28:48 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Wed, 03 Sep 2025 17:28:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756934928;
	 x=1757021328; bh=/eCzIM8iS7xAVb4D7IYRupdr0MCrKG94M4xjHfnCpBY=; b=
	jUeMzF9pxCUMRtj/TUr4BcsA/BR0q+cTp8D6BqLKJBeVnSF2bUWfC4pmKdov+Ux7
	0cABHfjb+YOy2TFcB+wmFv7T1p9kT3nbXP8h7H2ZBms3Jl3gGA0R2eF8Op94/EjK
	AAuVBwqvS1ZLgddaPuTZcVTEjW8gg4TUA54CY/oYntvqYvs5LW9ntR7YRvhj1XPf
	koboHfU5si6LdB3SJLRy4pZhkuTaltQSKkHLYrkw07poDy4zxm0TpJ8cTEWc5SJI
	yq2G/jaSJ5HAAr2u2Vujb/di8hcep97ym3QNFkb9xBJY5eBMq9aBP1pZu47Z+pTE
	FR44/Pz3oajmwRvh4QhXZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756934928; x=
	1757021328; bh=/eCzIM8iS7xAVb4D7IYRupdr0MCrKG94M4xjHfnCpBY=; b=U
	tuYTLsvqx3PNB0mqnkGgk+3qDCwjJNVJoXrOcQ7ilNRYu7+VIDUgpi0mawM4bIGy
	hh7kioRdAcG65Cv/fo20PneVhrwlg/W2eJgAr5j+GqM0yUyq5faNvF0Gyz05kX80
	Fty0xXu17ITjbbixW/fSXicVG+pre+pn+pSIk0rOE4FIz/7vEAC95ocIM+/Ql+uJ
	MkOrZtrnsYr2EsLAJzRXx1dULnGpt5UzlqDivHlJPbOXkytozk1K68pjg9tQ/nZh
	p2j5MaIWkCP7p3h/M3d19FOFCVHV5JYV8NW89eG5e5stytCzNbN7oPTbecTPToei
	eWZpWjmx/GiqJYWJkKqGA==
X-ME-Sender: <xms:ELO4aGE2gaJrul-ePa4UrTRta--2M5yTF_uUh1d8lW9whKZ5RQzcHw>
    <xme:ELO4aHVpQc_Zu1g_Sx_SEn-8lBBKzg-EndiUIkx9TA25Nxtqk4KqL3QHVSEX9pntJ
    xbM_l5sFNMBQDVOnm0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedflfhulhhirgcu
    gfhvrghnshdfuceojhhulhhirgesjhhvnhhsrdgtrgeqnecuggftrfgrthhtvghrnhepgf
    evkeduveeivdevueehhfdvteeggfffudefgedutdekgedtledtvefhtddutddtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhulhhirgesjh
    hvnhhsrdgtrgdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:ELO4aDMr2LQ5sbFwqz-48Vx1cq7zdjuFl1Nk41_G5yvTLsmmD3Pk0w>
    <xmx:ELO4aHZsH_GFq7hQhHZEJtZ8Pm-uPKKBFX3SbMkmLEWXtnPVkmyRLw>
    <xmx:ELO4aB2AMYWshzyvPYlfSRD0a4TSn9im3XSrxLdtrijdPuyBNtCxiw>
    <xmx:ELO4aNet1PctgoO_wbQ9aG2xFXS3EO_Ssv3ddbC9jjDz7YKMWrO7fg>
    <xmx:ELO4aN6-QnGteIeCAcrAZwecY6Sh3ofzq1vX91bG_Kg8uA4NaIITIY2p>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 19FC3780070; Wed,  3 Sep 2025 17:28:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AJ8O7vPh7Xgs
Date: Wed, 03 Sep 2025 17:28:27 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <07e52117-96da-4443-8974-08a22516ed75@app.fastmail.com>
In-Reply-To: <xmqqikhzdz0k.fsf@gitster.g>
References: <pull.1962.v2.git.1756467934.gitgitgadget@gmail.com>
 <pull.1962.v3.git.1756918202.gitgitgadget@gmail.com>
 <xmqqikhzdz0k.fsf@gitster.g>
Subject: Re: [PATCH v3 0/6] doc: git-checkout: clarify DESCRIPTION section
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> Not just you repeat having bulleted list in your proposed log
> messages (which I already said something about, remember?), now you
> have them in your cover letter, too?  You must be so fond of
> bulletted list X-<.

It's true, I do really love bulleted lists. I see now that I misunderstood
your previous comment about this: I'll avoid using bulleted lists in
commit messages and emails in the future.

>>      ++	Switch to _<branch>_. This sets the current branch to _<branch>_ and
>>      ++	updates the files in your working directory. Files which are
>>      ++	identical in _<branch>_ and your current commit are left unchanged
>>      ++	so that you can keep your uncommitted changes to those files.
>
> Here "left unchanged" is technically correct, but somehow it gives
> me a (n incorrect) connotation that they are not modified since
> HEAD, which is not what you wanted to say at all.  I recall that we
> once explained this not as "left unchanged", but as "changes follow
> you", and I found the explanation easier to absorb.

I like the idea of "changes follow you". Will work on making this clearer.

> OK.  Do people understand "making a(ny) changes" refers to creation
> of the new branch, I have to wonder, but if so, the above is much
> much nicer than the original text.
>
>     This fails without doing anything and without creating a new
>     branch, if checking out the <start-point> has to overwrite your
>     uncommitted changes.
>
> might be slightly better?  I dunno.

Makes sense. I'll be more explicit.
