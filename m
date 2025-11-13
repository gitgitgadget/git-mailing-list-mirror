Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2374F2F99A5
	for <git@vger.kernel.org>; Thu, 13 Nov 2025 20:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763066144; cv=none; b=syclH1h19Ud989PfH41ds2PZlP0OVzm5nbTW5QqNnvYFj8gjzGrDe3/sSqNABfjC9RMDT7fjegp7gzxTik43jO3NCFcqT+tErhAv8GvPDP1+00Q3OEDl8BxKM06J1C/bGHKewCVYZNWe5qqVt8Z9fp7nc3iR/U45yxyfWL5pyLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763066144; c=relaxed/simple;
	bh=yS6Mv807vw6ecdH978KU4H1LRGXwx0ifC6CgxAwfcvM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KP3XJ6Ji1MJwE3dZf3kDzGAduHGZQ5XZyJpvCzDFuwrhAO/BR9n9FZ4EIV4oHIuiiO7VZu8YOMJVlTEPgg8vIzaMHrfcUyT48GY0j9g2NFgPDfZCpQH/n3Vz/HrtorszWbS42mahxm4angwqHTlybhR2+TrJMvjR4jFD1vcWCj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LIqRPvHg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nRBav5t+; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LIqRPvHg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nRBav5t+"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 40A50140015E;
	Thu, 13 Nov 2025 15:35:42 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 13 Nov 2025 15:35:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763066142; x=1763152542; bh=yRXnia5FmP
	NewhxX72uAyzPhbUC57KUSdrZWrWvok1U=; b=LIqRPvHgoIHCNmP+OnMp5a1cp0
	TSos1nzkdzFaM82DwYTzMLWXxsbGLGC7lioL4syGFhqAMp8ox9T91bsVFEkJR1KT
	34Z6oQ520YxnBtheHxerCLpuvWDmfv6e8bmyRHd9G55X6LZsg6Il8UlqhC1Elxk6
	wff3Zvz2wvyMP862tVQq74oLvyAvq8fd+b7xZbrJ0VT+yQDUBq1uEd1+0C2iS1IB
	20YfDfpl3tG3vL+mPScwRHQyG+BEvU4eWncfJrgNNMUGMaW1mHSPjnhyZCnktH+L
	ToYqJQ30ZMk+6oQchiflFrfUcqxv+DjOdk4b1LE51/Dj8HVSHDVuh5ntU6RA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763066142; x=1763152542; bh=yRXnia5FmPNewhxX72uAyzPhbUC57KUSdrZ
	WrWvok1U=; b=nRBav5t+2Cj/3/uzy17tElf6Ah4UFgnwg9PMpj/V+DK9SPnp8g8
	JvhaaB78Vx55wfhP6UIRYlOutOorteiXiDaeLIJGbtfFiKWpkoJmTBH6P0xTVsOQ
	GtJEObj6mTz/F8Vi3Zkk2VJKNwsCpeTcK98Sb985M49SyrzdWr8Nx6j68FWnvNln
	P8+JM/tU7pzfiilIP0UhCvXvn6tRXz9covhLxWYl3Jg//aIuIKuixx94+Dr2lgTg
	OkWVp24qII86H+nIk7mfftyUR53x67YlH5FmlBex/qS+JUUkAfyWmSUZtHnFkyso
	5GC965dFptmTkDTmqIUH0uJeOergfRkeVaw==
X-ME-Sender: <xms:HUEWaey0YxL175SpbJbDGgBdoG7UNdADOHJre4RA9kVDA6PmGY9WIA>
    <xme:HUEWaRTRvj0IoixwNCIi80AF0c--p4hIIvY88ckNI_U983I-3Ck8rQEZQsfgbt4vJ
    Op-BwKpCxnne08xnwZagYxD-Va-5UWImXygFmLlfblHJ71iV3-z>
X-ME-Received: <xmr:HUEWaVULcT60eCED060SAQLa8s-5Sacf4LcEootxPatEZWy3jY1umcJZoZFxfhQhNJ63pguy6XzUtEtgNHZRszo0ZJzWVe9N6sGI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdejleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehkohhjihdrnhgrkhgrmhgrrhhusehgrhgvvgdrnhgvthdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:HUEWaTY_zCc6y836jTuUAge_vWnORWMnOcLxWb88yDe-rCTWfpStNA>
    <xmx:HUEWab2jyjn2uKokeLnyQcxtEppmfpwLU-IvaHC3SsKbdVH2iYGT5A>
    <xmx:HUEWaVjTNdFv-FHC3MdBecjUROqaPlub7Qz9PPaCufQhgpcfYrh4Tw>
    <xmx:HUEWafYf1xzMN_uyGbNwKWP-CsKFSYyb2e3_2hCJ_sRRGrTmVi1IxQ>
    <xmx:HkEWaSsfMAudDNGxtvIptaT0Knak2Vxh_JwjcMtSi7KstVDoi6hoKGa8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Nov 2025 15:35:41 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Koji Nakamaru via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Koji Nakamaru <koji.nakamaru@gree.net>
Subject: Re: [PATCH] osxkeychain: avoid incorrectly skipping store operation
In-Reply-To: <xmqqo6p5llsw.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	13 Nov 2025 12:28:15 -0800")
References: <pull.1999.git.1763047599254.gitgitgadget@gmail.com>
	<xmqqo6p5llsw.fsf@gitster.g>
Date: Thu, 13 Nov 2025 12:35:40 -0800
Message-ID: <xmqqecq1llgj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> "Koji Nakamaru via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> +/*
>> + * NOTE: We could use functions in strbuf.h and/or wrapper.h, but those
>> + * introduce significant dependencies. Therefore, we define simplified
>> + * versions here to keep this code self-contained.
>> + */
>
> Sorry, but I do not quite understand this comment.  The program is
> shipped as a part of Git, and using these functions and linking with
> libgit.a may pull strbuf.o and some other *.o files out of libgit.a
> to link with git-credential-osxkeychain.o to produce the executable,
> but how can that be "significant dependencies"?  For anybody who is
> building git-credential-osxkeychain, the necessary sources come for
> free.
>
> It is not like we are forcing git-credential-osxkeychain to link
> with a shared object libgit.so and making git-credential-osxkeychain
> depend on it, or anything like that, which may require consumers of
> binary distribution of git-credential-osxkeychain to also install
> another package that has libgit.so in it (which is likely to be the
> "git" package).  Even if it were the case (which is not), what good
> would it be to have git-credential-osxkeychain on your system
> without having git on the same system?

The rest of the patch, excluding the poor-man's reimplementation of
helper functions, looked like they match what the proposed log
message described.

It seems that credential material like username and password are
included in plaintext as part of the state[], but is this a safe
thing to do?  The keychain will give out the credential material in
a way the requestor with sufficient priviledges can read, and this
state[] is stored in the same place, so I am guessing that this is
not adding any extra security concerns, but I just wanted to make
sure you've considered any security implications.

Thanks.
