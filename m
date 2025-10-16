Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AE52DA746
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 19:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760642787; cv=none; b=Zsb9XT30+MRrb0lZ/R5j9t6wdSy7L1gO5mmQkbuM8EocAl+o3sc7JQoysoBMKmp5H7LyvN0EzuKr0KU119Ud1WBGQj6ZJmUMEK5gAKDmsHyI9fTR1qOXEoKSEOnO6E3/LvSWn6OP3Bgson87CfP00/ioaM5m1RuuahnUehavpAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760642787; c=relaxed/simple;
	bh=FyTpcyuwE1TlQeWqkCbo+5AlZCdELCyL3emJoLC9l8U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ohDFr2tN9U5W2yjCZULfh8Sn0A4+y22fWYQLGoC40ZmsZpGZgqNYzQrKZwqyQfb5EcrEhqIRKRIY+9l3p4PG+37YO/rOJ2ZKVLmlDXjy4IO8ccMkt+rOJDxxxcR0n8n/Rsby4CwoK9tXL5xgn+SS1Xfca3dm6bJij+zAtXT5tUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Jk828en8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IZGcf8br; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Jk828en8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IZGcf8br"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id CBC6CEC0053;
	Thu, 16 Oct 2025 15:26:23 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 16 Oct 2025 15:26:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760642783; x=1760729183; bh=GVv+awtMqi
	U5hkIYguUpNN+2YN9Zfdfnr7PxBGBi+jM=; b=Jk828en87FzL3SF1H8yRzwpxDi
	u9OBYQdMRbMcBJiv6rrv2Gc4I/+KbVClP51pL7VEEXNnBxZuLYyCQxRQahJ0a4OF
	poSbujgbI0u5LFYxv+hXYknJoNSljRwMr3ji98bfHl8ckNcqopg3GoG7/SWNHLfT
	PIzhCG2iEbKc1QSfFsi0Ze5NJp5dHvbTxoh336mMyVg51prhUrGlaUZH2dl3Oq7j
	r20P6ASE6wDijVo6Kzo/Vq+6lWRnK5+jB4yqt4ALW/ClHge2zFOS+6cTPq7kuQFE
	G1TlVcHrGeaPxSROoYZFrtJXCzwnVJYxV8CLRnU1tR/oDhdF1wZXRzTYq7ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760642783; x=1760729183; bh=GVv+awtMqiU5hkIYguUpNN+2YN9Zfdfnr7P
	xBGBi+jM=; b=IZGcf8brQX1/8J9LXuEbSTGt5C6HHbY9nVNN+rHPt03grUz6I4Q
	bCi9G2xB8bLi0wM86VdezvrFkOa4zPXe8ByXH9J8060UIxgl5C/AiFXKUMhU83wH
	e3Xrtb67xcRkFEdqL9x7eirJ2QK0iIGpiZMuTvA36HpUwwu4iYsgF6CUG7w0zx1/
	zCTAxwpKLQUnYBlUmYVcj/YXjjl0slMHhDHbcwIL5xuhtDiJkTQYXplVz2QhwqCz
	Yo1iNJoINqaeD/8RiD2jPblvVnREA12N9XB6yXf7xnIZ6CKoC8BLnNJnzIx56pDc
	OEhMkwL+/QRvYs6xcwQTPePmSiGyVq3A1LQ==
X-ME-Sender: <xms:30bxaNHYE9m4OjD5QBinX5KIOFLcopawtfSCw1KV4awrq8LFwI2Gsw>
    <xme:30bxaJwOvRL6350i0TlJiuoCGZLf0_1skUXijyF8XReLNO3Fsd3aLT_l7TovrH1VB
    bikTUd77c5_ueSPRa5V18dQsqgvDY-XmFOsNnyq88dZQugSy8S44Q>
X-ME-Received: <xmr:30bxaMho7ckw-t_Uuwfh_wMeVS7am3HmIIT9LG7E1BdjoQsaNO62w-h3MfzWRQV45XOJuH-Q-l_lpLYWSIHnz1rVB-VNPjhkItHl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdejuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehl
    ohhhmhgrnhhnrdhshhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:30bxaMzQYzfo6ggdSdkGEY9wRnFHmNeh_5RwgZ5vrf6n58vkn9jBVQ>
    <xmx:30bxaHKqiBFM3JDSt9oskAo5gA4ytNV_9h7kC3M2K5p61wQC26TiYw>
    <xmx:30bxaLR__EeJWffNsXknFO0pT-i_ZkvVpkNlG0YyDf5YPem03XEZ9A>
    <xmx:30bxaHohAcE4N5wtS5B95KcaWAFkOu2FMgzUjyHTht-QQ9Mekglvjg>
    <xmx:30bxaHfXpsbmAHEY8mH6UjI3sJDhQjgNRBcWPJOuRjZXkCrmhO0TTfN1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 15:26:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Michael Lohmann <git@lohmann.sh>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 4/5] setup: allow temporary bypass of
 `ensure_safe_repository()` checks
In-Reply-To: <20251016053322.44495-5-git@lohmann.sh> (Michael Lohmann's
	message of "Thu, 16 Oct 2025 07:33:21 +0200")
References: <20251013094152.23597-1-git@lohmann.sh>
	<20251016053322.44495-1-git@lohmann.sh>
	<20251016053322.44495-5-git@lohmann.sh>
Date: Thu, 16 Oct 2025 12:26:21 -0700
Message-ID: <xmqqv7ke3axu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Michael Lohmann <git@lohmann.sh> writes:

> So far, the only option to allow executing git in what it considers to
> be an "unsafe context" is to set this repository as "safe.directory". If
> a user only wants to temporarily execute one command, they would need to
> set the path as safe, execute the command and then remove the path
> again. Forgetting to do the latter would make the user vulnerable if
> this repo was changed afterwards in a malicious way.

If you want to do a one-shot thing, wouldn't ...

	$ cd $there
	$ GIT_DIR=$(pwd)/.git GIT_WORK_TREE=$(pwd) git ...

... be more or less the standard practice?  If you are at the top
level of the working tree (which is why the above example uses
$(pwd)/.git for GIT_DIR), you do not even have to specify
GIT_WORK_TREE and get away with

	$ GIT_DIR=.git git ...

In other words, the above argument does not sound like a very strong
justification.

> +--allow-unsafe::
> +	Temporarily trust the repository regardless of "safe.directory"
> +	configuration or ownership, potentially resulting in arbitrary code
> +	execution by hooks or configuration settings.

As the only justification for this new feature to exist that was
explained in the proposed log message was "one shot execution", this
command line option does look justifiable.  Even though with the
current system, you do not have to muck with configuration files and
only have to set the GIT_DIR environment variable, passing this
command line option that does not take a value may still be slightly
easier.

> + Equivalent to setting
> +	the environment variable `GIT_ALLOW_UNSAFE=1`.

But such an enviornment variable is not justified.  Setting an
engironment variable would last until you unset it, and it implies
that it is no longer a single shot use case that this new feature
targets.

> +`GIT_ALLOW_UNSAFE`::
> +	This Boolean environment variable can be set to true to skip the
> +	safety checks of "safe.directory" configuration and if the user
> +	owns the repository before potentially executing arbitrary code
> +	from hooks or config.

Please don't add this.  It has the same "Forgetting to unset the
environment variable will make the user vulnerable" downside as
temporarily editing your configuration file.

Not convinced why this feature must exist, at least not yet.
