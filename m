Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E5552F88
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 10:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762251846; cv=none; b=aKLCPDLpDxXzPCZJscBOi6fxNeSvUr6YLwBiqkY5jRi1knY3fmpPCVBxzknUMXQIZotEWH3e96p6wU54eVUMTULXjT8U63Mx39y/pPkHHZj+sjZjBxtft0uwtzWuvw1tmHXWZaOnjLRMnlP6U8wqpS68d2RjQ09Thb7ddGIypRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762251846; c=relaxed/simple;
	bh=xZf4z51zzpu5xXCXRyeRLX1AJ+IzNw02zDsKt+AJNFs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IUvAVuIy7De1LnDHmpEhq9yaVvlmzMwkjDCBxCxE9OyxkL39nA4ssTVLtcEeSHHR/tIB3gQR6N9fFVvO5G2FLKECh5g9CU0AfCnPHbYmS2tr9nHq8oTuyvhaq2217IDUz1WJjNQDbx+VeFi2TwBqFBqYfYbt65T6s1YPFRIzPl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XFQoTWqE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wG7o798K; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XFQoTWqE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wG7o798K"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 941C51D00300;
	Tue,  4 Nov 2025 05:24:02 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Tue, 04 Nov 2025 05:24:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762251842; x=1762338242; bh=HF6x4ruSXi
	tZNktjFgL2zXCudT1fAMuEwz8/DI860Y4=; b=XFQoTWqEolTnwxXeDOlNyKN85l
	fN7WWvBulll7jQST2eUilaD9uEvqzuQgx7EHOaQ1mxnuqTNCs4bX7RzMQIm1DN3w
	lBxQ8C3ILFWOdUPmL/OXHxI6y6wacN9V0Th+TiUc16Sa7Xl69RgCmrK9MoEoSZJz
	7+JOyjwwD/4oC/dap3jfdIwk78A4evHJ0hcaEQkw1xBfC9VFkb/jGZtY/lXiLj6r
	o4W4RfMPeDV2Nydt50R+Zu2xiCofEgiKgFjrdIvJ0A6/I/SHRbMqPBXjMVbbxtke
	PrIv6QgEUbXsQwSnzyMKrZJRKeXhmCDKMUcvOVNbZerT3UzIzJIJ/b/cCcrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762251842; x=1762338242; bh=HF6x4ruSXitZNktjFgL2zXCudT1fAMuEwz8
	/DI860Y4=; b=wG7o798KqxeQZk6Sh2mWAqJINl/JukE5xkq1pqhHyICcpYQP4YD
	FSEk6IYP8yV35Lr2enfoZ4vYSkkkaTnuow1lMGK4WGfByGIz2zEcua6Px9OAf6p+
	eRYyzPv5e201+KPqjKEqTArp6BF1fbg0NbQ2RTge6vVrUfRowHhRQjXcme0UwH8G
	qtTeLJTFe5rxzI5Y1//+IydH0QLMK8Rnkvcn2OHOlH0MBTDBtWQJmC64nCmEquIk
	pA6BXXCFUUXbGrlHH8GcO1R7LM7LJy5d0dBMsp0MCs7DivVmV+eGcu5YnmYzcpfV
	mfd22YvqWXfuG9uj+kyb3IhmpiVIbIy2wDQ==
X-ME-Sender: <xms:QdQJaXx5EI1SDC_OaTS9vBzT-pXa2MZi5mTTDii4SFE6apqsrZTujg>
    <xme:QdQJaWIIpn53cV_vmaBnENb7FfGoifeKAjqwpeSa6by8eMiQMw2BePOJC4BA33VEI
    TTNR9CB8hmXRq2-OMKcfcKflz730KY2VsmBsev3CptaNKkFWMsbqZQ>
X-ME-Received: <xmr:QdQJaZowpHEuTTvdjBSmlKbOM2B8bl4M67lHSadMgP9PPreTEx80tncP_zzhfjfBVgKc18m4ZPfqkPyza9RBFsDrHV6L3WifvVAb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukedtjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprg
    hsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepvgiivghkihgvlhhnvgifrh
    gvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:QtQJadI3LMbFQfsyo-8LAMpodiEaG7UXvVCMIKjt1K5bezOCtWnt_A>
    <xmx:QtQJaWQtqOGb18urf0CD2N04bfyvZ3nm7DrfkVbRFS0jplcPlYCV9g>
    <xmx:QtQJaUuFj8Gh9tc7sV_m8XUZn_QtvDNTxhT3bASFdN6DEaV0-9yAbQ>
    <xmx:QtQJafZqOp0O_B3mOrf30naclKOvJhl9iZt_ADOJZE4jSXKiv_eF6w>
    <xmx:QtQJaVZXeoZd_tsgJsorPrFsPCWkXFU5h13jCiBwaCFGY9Y6aXmQSRuQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Nov 2025 05:24:01 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Ezekiel Newren
 <ezekielnewren@gmail.com>
Subject: Re: [PATCH 06/14] hash: add a function to look up hash algo structs
In-Reply-To: <aQlbZRAKq9RwYnqe@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Tue, 4 Nov 2025 01:48:21 +0000")
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
	<20251027004404.2152927-7-sandals@crustytoothpaste.net>
	<xmqqwm4ebxap.fsf@gitster.g>
	<aQlbZRAKq9RwYnqe@fruit.crustytoothpaste.net>
Date: Tue, 04 Nov 2025 02:24:00 -0800
Message-ID: <xmqqv7jqqenz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> > +const struct git_hash_algo *hash_algo_ptr_by_offset(uint32_t algo)
>> > +{
>> > +	return &hash_algos[algo];
>> > +}
>> 
>> Hmph, technically "algo" may be an "offset" into the array, but I'd
>> consider it an implementation detail.  We have hash_algo instances
>> floating somewhere in-core, and have a way to obtain a pointer to
>> one of these instances by "algorithm number".  For the user of the
>> API, the fact that these instances are stored in contiguous pieces
>> of memory as an array of struct is totally irrelevant.  For that
>> reason, I was somewhat repelled by the "by-offset" part of the
>> function name.
>
> I fear I don't have a better name.  "by_id" is the format ID.  I could
> write "hash_algo_ptr_by_hash_algo" but that seems slightly bizarre and
> difficult to type.  I could do "by_index", but you might have the same
> objection to that name.  Would you like to propose a nicer alternative?

const struct git_hash_algo *hash_algo_ptr_by_algo_number(uint32_t algo_num)
{
	return &hash_algos[algo_num];
}

Then, ...

>> The next function ...
>> 
>> >  uint32_t hash_algo_by_name(const char *name)
>> 
>> ... calls what it returns "hash_algo", but the "hash_algo" returned
>> by this new function is quite different.  One is just the "algorithm
>> number", while the other is "algorithm instance".  Perhaps calling
>> both with the same name "hash algo" is the true source of confusing
>> naming of this new function?

... would become

uint32_t hash_algo_num_by_name(const char *name)

perhaps.
