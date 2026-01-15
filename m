Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086AF21C17D
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 13:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768485314; cv=none; b=pOaY8E6iHnnLSmHMnMR2q4E8iQ9Flzpgv7K/3z4/5ZickXAy2yi3yCwqU0zKa8HJBthzaR3Q3052CIREB1YrDiR0tTTCGu02LnEXyQV1bkM/4Rxk8IU19eovyOvJMMQM4tMkcEdMtd1KMm73ZyIszFvCyElIkLB5GIXQy1H35bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768485314; c=relaxed/simple;
	bh=lrg367wuAK35dlcqZzdMG3pS0Uv92Zn6SgfcX3rVuPQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O4i2AJbxUG3cGbGXZ/mQTmDyd5ihKI1v3kY6gYXW2TzmbAHcaxramZ35yJQv4wOopW5FMsGJ3VRC/3QAZsjGo5qcXWdN2T/ZjGDHhyWUSrSPRvFl8r48F3byR8ZO70PLhhSlx2ppb1T1mo9b2w6ezuhGeFJHiXuDd2drs1gHQFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JXRKWb5t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RjyFFS16; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JXRKWb5t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RjyFFS16"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 4332D1D00056;
	Thu, 15 Jan 2026 08:55:12 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 15 Jan 2026 08:55:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768485312; x=1768571712; bh=7J+637fn9a
	GED9vcPZQfb/f0cZs3BUi6wZIzI1hljGQ=; b=JXRKWb5tsLfgzAkuvM21/ulM1+
	NJnuJ9o1Y5uu9F9sG1boynVeixFT8083ZfSgXz6SpO1Y0Pirr67yzEbZ7sUVfxdE
	PQ4cSF0GrbPXcBHoSLjhUrsJvWpv+8Lk3ZIylMblsW30K6DgOOzqmFwDh4KFsXvH
	l9ues689TdYaARjATiACvbtS7iQKfShTdskOY+XfKX+ea4+n2kVUqjxaFFRUnNJV
	prtjQBRtdjRiYQUGi0wnGjOsQ8YePiNfehx9EKCsyvkaKn1IaqihvsqRvcMS3it/
	/tmh0/XlS5lJVNaCkwCllHr28GBoueP6lcR4JLokAdG3WyRBDiJiAc8LjzQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768485312; x=1768571712; bh=7J+637fn9aGED9vcPZQfb/f0cZs3BUi6wZI
	zI1hljGQ=; b=RjyFFS16fCuFbNTsAu4L+Wsl7EbBipcqbcVS22EfaJH9pn8RVn7
	sJ39K4otSWEUcacIrDL7s64enrX3qvfJzTETOgnFEeY+M992ujnQnKoT2UW/Y+S3
	IEhhNNWHoUtXIf/K3dHNjCaCu2d2Bye32Ju6IjN7hEZwHBJJxMDSnLfD4Qh0TD4d
	rEPJhl6/4SthXfGOv+W5qPCUWzWFpcuG5xCmTohTEzfOhPBgvkww15VaKcExlQD1
	cTMLq09DiROw9Oq/xGO7rNjQdkAc21mYZQbGZAj++3y/Xm5xbvdpRVMJc1/MqjbG
	/hpK7vEZnqLCTUGfharUlZ+N1Ycsn040waw==
X-ME-Sender: <xms:v_FoaRUyxo5aMdOudyZkVqnl6EmRoi52nJ3PXDcERfWsS_lIMMTcsg>
    <xme:v_FoaVRyLzT2-cqlrsvYFY8-P6W7u8y2jgZGr9bjP6aOHcL_4M8OioZNS0C5IV7zh
    McLC7r9gIAHLZtxuq0phn32VNKAs-vyiEHB0kU_lH7uX34zyrjrkw>
X-ME-Received: <xmr:v_FoaXOAHl832O6D3Ah3e-VDb_8qxjCPP-HFZwEe_FIS8MIuczDvtkqPA5kSWmFJW30vq8UCCSfHDJX6rSrJ8VGMG-17J2_WqNR3gV8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdeivdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrmhhishhh
    hhhhrggrrggrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgt
    phhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesph
    gvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:v_FoabRyVe-COZGjTRywKw_OFSG4IPX6RwBQJ3JweYanhHkmkur6UA>
    <xmx:v_Foadhd1eiu3GvBiMkpaOvKUasq4W5QpQ2JXiy9yLqVZZivSAmOpg>
    <xmx:v_Foac8jeTduFqoGl4UBvNBhkR4Z9j6ACcfSAVnM8u5FejcouXvdjQ>
    <xmx:v_FoacGvnAemREAuu3tjXYrK8fNxfoz55ILbtRwQrF_DH4JXYSapWg>
    <xmx:wPFoaUHTmdmt24-csP6MPu1RTa-fBRK7YfSZ2hVN6xXmSjZM7FlqnB6H>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jan 2026 08:55:11 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: amisha <amishhhaaaa@gmail.com>
Cc: git@vger.kernel.org,  stolee@gmail.com,  newren@gmail.com,  peff@peff.net
Subject: Re: [PATCH v3] sparse-checkout: optimize string_list construction
In-Reply-To: <20260115130935.93526-1-amishhhaaaa@gmail.com> (amisha's message
	of "Thu, 15 Jan 2026 18:39:35 +0530")
References: <20260114192803.4852-1-amishhhaaaa@gmail.com>
	<20260115130935.93526-1-amishhhaaaa@gmail.com>
Date: Thu, 15 Jan 2026 05:55:10 -0800
Message-ID: <xmqqtswnc75t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

amisha <amishhhaaaa@gmail.com> writes:

> Improve O(n^2) complexity to O(n log n) while building a sorted 'string_list'
> by constructing it unsorted and sorting it afterwards.
>
> Signed-off-by: Amisha Chhajed <amishhhaaaa@gmail.com>
> ---

Because your e-mail client claims that the messages is from "amisha
<amishhhaaaa@gmail.com>" in its "From:" header line, you'd need to
insert an extra "in-body header" line, which is separate by a blank
line from the rest of the message body, to override it as the first
line in the message, making the body of the message begin like this.

    From: Amisha Chhajed <amishhhaaaa@gmail.com>

    Improve O(n^2) complexity to O(n log n) while building a sorted 'string_list'
    by constructing it unsorted and sorting it afterwards.

    Signed-off-by: Amisha Chhajed <amishhhaaaa@gmail.com>

I've tweaked the message I retrieved from the mailing list before
applying, so no need to resend this message, but in your future
contributions please keep this in mind.

Thanks.

