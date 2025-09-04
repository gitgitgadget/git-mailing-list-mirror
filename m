Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744CF27713
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 16:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757004854; cv=none; b=K4RMb7hfaKztMzsXnSAuqQWhfE4L74gRclQF9j26tr9h6qjPT+pYyInHyBZujU7+8kEuuXtcF6ZLOJv/5+VCzpsEgyS+PyPnhNQ3fFlBIBbTvRDGDpYDjqEdAU6Uz2QjEumuXz2jQZqrJqhllukAvqW+aR7D2YWB/LzIcqW6GRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757004854; c=relaxed/simple;
	bh=wrbtnv8OpT1QdJ5d6CePgJMOfAa8Ec+KphTzLSSNw2A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cgbC5g0kjqKgBuJbOjYhp8l1ptQ7THfECDj4d4KnGvLuf6F6zaWnyEGZigFgMC6/mmysje5Cbh1yg1YBqYo/KeYYAT2U6GsyMrR8mNwnRZUGJnB2CqgsRVj/xMI8A7cUwaQcE/hGnioY9CV5fhXAoSZQBeIQ28MOCx8k/9VW388=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RPGad9EY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lUtkN+vi; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RPGad9EY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lUtkN+vi"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 9094BEC02F3;
	Thu,  4 Sep 2025 12:54:11 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 04 Sep 2025 12:54:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757004851; x=1757091251; bh=Bn0MB4czV3
	PMogBL0g6d8bdrmq+7+xixV3l05WcOx84=; b=RPGad9EY4TydzAgxO2tIAOqOcO
	lxJeztJZ3U3OYUVd/Aqo/j8BPnmU2GYulI9NwaHghIXCU4z1N+dWkPpReW983j1I
	ZsCdcsA6tPHmhfiDGwdZON40BVVJ6SYX95dl76HTCe7Cb47DRQnllHFOC9UYAEwX
	ajwVliGR49mPRuBcwOxARHAf9YC+Lg7Jlu4nsj/hnCYTHrJjTZciwxYNaSPzYveX
	tvwjOmsfynnwFJQkau4vM9WJt3uxS6us1DWMOAiOAlSvyoCAlPNU4Yf7B61tn6Hn
	EAHRBXdBNhTxw45sEhIqUuL97SDaP8pZDGhOxMYMQroZPpXrlHZTUsOTLZsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757004851; x=1757091251; bh=Bn0MB4czV3PMogBL0g6d8bdrmq+7+xixV3l
	05WcOx84=; b=lUtkN+viffVHqhGqPrVoGmJAd8at8FzDkIV+msKnXGRwzOGC3mJ
	eOoxh3+RlsI7btTcQUlnpwhm837lR16Qs1nFy/PSbuNc22tpt7oexz+aD3/RNLkP
	Uqhj73LFlFEeEjdjTwjXMSQhuO/aylcZmcZ7+LDJrymqmwOfwnwBfXP5itAAxmY3
	kXmTzex7o2Jx5cse7cNEH/yzbcg+OWsjaQ6poX9qqsdNvzRK1bGSn6eEHEeKeGkz
	FzckEPHY+LhMJ4zq/IYU8y4etPNo8R+7EoZQbqvZIDEVyTYcAJBjb5aG6vZ/S7bM
	GUfHW1Emhah6Oxa9WTloeyrRGv4Z3jumHvw==
X-ME-Sender: <xms:M8S5aNPXA2kxIbj5SQp7fZHcM1ZO39veuUOioYHWKmcxVhA-7kKXyA>
    <xme:M8S5aKiE-IhB93Y8VGsLh_CPyHoZ2amDRDhTJNp9fWCcbHy6FGL3zriFmo1kzFTAz
    wKyh_eQ-R138POllw>
X-ME-Received: <xmr:M8S5aI15_2xKslEZeJg2T-ZH-mM46KrX2hA1YMF6pz6khGF5EwxnszjtyGlEr3cGLwD9yJFzcKtQwxjdbHSryEDG2Nq6QWkxREK5Hq8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:M8S5aMikOPEXcNQcrVB3I5n_7Inc4FapdrbrVvZsqXBZBQzakvSGLA>
    <xmx:M8S5aAcnIEDe_xTPbCIIVr42MXvT3ykhAEwvCyH7aZc3szUl-bU0Gg>
    <xmx:M8S5aHn7H8WtalA_h5jUGMhqiAUwiFecKVod7faEOMVYx6UL8CtOkw>
    <xmx:M8S5aBuvRYcUpimzGy38ju9QgSlIDtUWHd5jbLhQdc9jC634ZVXVEA>
    <xmx:M8S5aJEJ8wi_9aYSQu5btx0ZXH-6Pcdi-Wt-ehsIFWkZA2COEf7ZHkTd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 12:54:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] combine-diff: don't override recursive flag
In-Reply-To: <20250904-toon-fix-last-modified-v1-1-91bf87ddf62b@iotcl.com>
	(Toon Claes's message of "Thu, 04 Sep 2025 13:53:40 +0200")
References: <20250904-toon-fix-last-modified-v1-1-91bf87ddf62b@iotcl.com>
Date: Thu, 04 Sep 2025 09:54:09 -0700
Message-ID: <xmqqecsm9n0u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> Because internally diff-tree no longer runs recursive, this results in a
> nice speedup when running `git last-modified` on git.git:

And users of "git diff-tree -c" now needs to pass "-r" themselves to
obtain the result they expect to see?

Do we need to retian backward compatibility there?  As things like this ...

> diff --git a/t/t4013/diff.diff-tree_-c_master b/t/t4013/diff.diff-tree_-c_master
> index e2d2bb26114ac886fbf2467dc7a33ec8cfab5daf..1ecc2cfc6c50e923a671fba29a6a395f4240e0ff 100644
> --- a/t/t4013/diff.diff-tree_-c_master
> +++ b/t/t4013/diff.diff-tree_-c_master
> @@ -1,5 +1,5 @@
>  $ git diff-tree -c master
>  59d314ad6f356dd08601a4cd5e530381da3e3c64
> -::100644 100644 100644 cead32e925b1420c84c14cbf7cf755e7e45af8ad 7289e35bff32727c08dda207511bec138fdb9ea5 992913c5aa0a5476d10c49ed0f21fc0c6d1aedf3 MM	dir/sub
> +::040000 040000 040000 65f5c9dd60ce3b2b3324b618ac7accf8d912c113 f977ed46ae6873c1c30ab878e15a4accedc3618b 0564e026437809817a64fff393079714b6dd4628 MM	dir
>  ::100644 100644 100644 b414108e81e5091fe0974a1858b4d0d22b107f70 f4615da674c09df322d6ba8d6b21ecfb1b1ba510 10a8a9f3657f91a156b9f0184ed79a20adef9f7f MM	file0
>  $

... is a clear regression of age old expectation.

I do not mind too much if you did want to make a breaking change and
be honest about it, but then I would expect you would be adding "-r"
on the command line without changing the expected output in a test
like the above one, i.e. I would expect that the above should look
more like this:

> -$ git diff-tree -c master
> +$ git diff-tree -r -c master
>  59d314ad6f356dd08601a4cd5e530381da3e3c64
>  ::100644 100644 100644 cead32e925b1420c84c14cbf7cf755e7e45af8ad 7289e35bff32727c08dda207511bec138fdb9ea5 992913c5aa0a5476d10c49ed0f21fc0c6d1aedf3 MM	dir/sub
>  ::100644 100644 100644 b414108e81e5091fe0974a1858b4d0d22b107f70 f4615da674c09df322d6ba8d6b21ecfb1b1ba510 10a8a9f3657f91a156b9f0184ed79a20adef9f7f MM	file0

