Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3C03033CF
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 15:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771861745; cv=none; b=b7iz8SCGL7A6YCulvRH6nrTcA/dRGRaoMwe/x1t/S3uSRn/4YQUFmQO8m4NXjpRoik9U0abmxpEto1dvy33WH53vC/u/cDfnWqAdbeO2GphayPy3acS53wyjJQE5CMPLyIr9r99AM2YAuBgFsh8HK598mPdZbpq7UjV73zIxdLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771861745; c=relaxed/simple;
	bh=3PZWRKdSf/6QM3G6EiY50GN6LmrqFBI+fgqgI85Py4s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bu/IQS9Nv++1MtsXNSvaJzYzuRApW7krL7KVnzUxT3Ms/2TpncUZ8+lPeu/wfvpYqNYbtXpyXNj3O2TuhzfRjM0KEI7Qo023thaA2UhwRlFcy6zIM/Xnh22fglbMXjCpYLSZD3jn7xxpIOhckbuek9VDFFJzUGu4I/AwLHQ1Npo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=S6i3vFFu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NnIS+H9M; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="S6i3vFFu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NnIS+H9M"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4F80F14001D6;
	Mon, 23 Feb 2026 10:49:02 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 23 Feb 2026 10:49:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771861742; x=1771948142; bh=pBlCE0lQUx
	gKqnlAHJ3XTkPBZY4Mmf0XGRirVdXSLEk=; b=S6i3vFFuZ0WOeBwlyVA6tBhv+f
	0w+1qiIBTp75mHF7QkE4A65Z8frxe0OilScFyWbdTYZ4/OGxjOiXnvFlZ5vZecsP
	m5dhuu31Z1ByiDJGehE5X+e4YsWul4KuJJbwsH0jNRuqDaDJUjj8j4QVVt80VcPW
	vPgSw/rlswCocvg2aTJwuSyVrJqZb8xj4n9LAsRlmbiQwxfIYFKGBgXWcGOFp/6O
	bepSoG2tnk3eZPwtOLJHszlPeCK8bgA2uRCP52ow3pEs7Qth914X6c3zEkOOph7z
	6gugFNAfJSgD60xBkMEFWvJsT9pnCP7Ocqti1QOKU2j6ZRvJ0q2/YUPm/khA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771861742; x=1771948142; bh=pBlCE0lQUxgKqnlAHJ3XTkPBZY4Mmf0XGRi
	rVdXSLEk=; b=NnIS+H9M51+fqiM8PZSI0CQeWlojlnrvg/PThNsxIwQB3nTSssn
	XOkMB+g2hWSHB4oeq2Yacxi1GQ/zXacoSefQ6c8PEalhgJ4V8ZbAF1g5cf/nEVne
	S/5CjXbFTAuxBaZjWFg+shX0rFGMPZW7pHy257xZn/a7O5Ouvvx/YWgrj75Rk0Ug
	qFYU9iI0YcHQKwoxWVPj1EZshAJ9ZdEM/vDp68lsTj6dIemISEZGxDfEqKvuBpxf
	N4iwXr5l5H2/RfIKcTf9y7TkIz4yJoOc6BToiFjSoAuGYn+yoCeM9oGZyHsZYTW9
	XorN7Jkcv7aptFK+NgnkQYbdZ/rYdmyRIgg==
X-ME-Sender: <xms:7nacaYh_sHwnYyWKPkSF8LOhhDrOslg5RGOlWkeK43KZLgG9Qy5azQ>
    <xme:7nacaX5jR0YDHrtGvdt_fpTKkyUriTF3Okk7nALCbtrwSJvAJHMk3TmThm1uhyqaX
    xUzSz_V8tE5SLsR-AVLc8M5VjMzlns8sVTtacPSWGBYNZcEFJEXng>
X-ME-Received: <xmr:7nacaYYjA6_F2S4s1TRl0eH5jmndiMudsoSLIBbWpDhVOvUwOfb41cgr5ladZKpnu6-kCmCpPa_Gaa8MY2SBfgyLKr6Rs2uqYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:7nacaU6uac9b9XoaIJTCIXc5CZ2w8KwPbMwN-OovZpVa1eXV7FNkfQ>
    <xmx:7nacaTAIl8tJSFaGnPoMAOf9-d9t90ZjS0lVi6wmZ1ZYVgesCa3WcA>
    <xmx:7nacaSf25ZB1maNSrMnVtJwl94_Zi0bGkae4550ZRrDclvy0caJGMw>
    <xmx:7nacaaIgPmGiJcKpjGbuHRBAtxGxlSA_08OipfosK09lIl23LAWpmg>
    <xmx:7nacaQoMdIfjnkZcjSxD0UO0suyqLiqcgALxDZkBzU4Qo-uJcagilteu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 10:49:01 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org,
  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] fsck: do not loop infinitely when processing packs
In-Reply-To: <20260223071215.GA136463@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 23 Feb 2026 02:12:15 -0500")
References: <20260222183710.2963424-1-sandals@crustytoothpaste.net>
	<xmqqv7fopflu.fsf@gitster.g>
	<aZuMPcMYwFi4Sch5@fruit.crustytoothpaste.net>
	<20260223071215.GA136463@coredump.intra.peff.net>
Date: Mon, 23 Feb 2026 07:49:00 -0800
Message-ID: <xmqqy0kjo3yr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Having to identify each potential spot and set a "btw, don't switch the
> pack list order!" flag seems error-prone. And also loses efficiency when
> you are iterating a pack and accessing objects in it (since we can't
> push that pack to the front of the MRU then, even though we'd expect
> there to be high locality with our iteration).

Ah, you said so clearly what I was feeling but I couldn't form into
words.  Using a stable second list to stably iterate over it for a
codepath like the fsck does sound a lot less error prone.
