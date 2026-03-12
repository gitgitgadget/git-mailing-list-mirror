Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0469A3AD528
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 22:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773353025; cv=none; b=pKdbxjuwxKITMzUi4N1a8M0qoTA3OErCNIgXP4YeQ7sMf76KkHv7dAq1wnOnCBq0zF2XEvdajIg51cjAYMF5VFTB4VOq8IGabd0G2IHsotvpf4LGFzUHcq1bdHA8vgevwVa340ajlq99xkR7A/p5cKTH+gyugNfHLDQlUu1mF4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773353025; c=relaxed/simple;
	bh=4PiFwDMiTb0p0fAocYX+YddBOpiiHdPRlKcjVA63+Oo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sYUC4J12AprxG/Q30aOJovBz5tFiHe+tCwpJbSTByaqEVQ/Itf7ZpKkzYh1Ngok+zPYRpqjncnyFm/TfQ8U2gWCzvMmjvecZqp53Zl16T3rOrJG77qe38tVLqTWVMi1wOBCFSnK12PdXEtw64Zx0NuM1XGqWKycegJ45OYcIlxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=j531uVqu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MmnpXFEy; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="j531uVqu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MmnpXFEy"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 410E8EC0AFB;
	Thu, 12 Mar 2026 18:03:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 12 Mar 2026 18:03:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773353023; x=1773439423; bh=lzBo132ws9
	Lv56zuHh6Je2mCi5PRZNbHbIaKqrf4KAk=; b=j531uVquX4O6HuKZMx7nIwbFcL
	HfLq7L1popFEPemA84EzX5wyDUbUM9mc0iFJbhTmdD7D/Dibsn1PE3k/sWHYXWt5
	9rEHn1L6FfRd/wld6/fqFy1jZHfijFz/HlFU/N/yJ1btuL2viLcs7rY2ahZvvtge
	I4O3iKa60Mlo4ZAGD7oP5k6E1kUhDBUj69kdcI1OESkqpFtfU1WwHKXvir4uM96L
	Z61ldtgNJ6fBgf0ffZoj80RIM+mf0Vpuq8n5t0te4dDUdCDDvRuWl8f9l67EIK7T
	VxwU2g8qlRUU3mf386I968TD+da4l4V6saC5iZtcENYYcqGLI9YrWCfvdjiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773353023; x=1773439423; bh=lzBo132ws9Lv56zuHh6Je2mCi5PRZNbHbIa
	Kqrf4KAk=; b=MmnpXFEy49E14jCZKFyWAwXL/+2ozk7TV6RAZ2gnO3AdafbkOeC
	6Yjh97cHuy/nl2Jl4X0r+EiAcMKBFFRaWZy1gPXWv1pectwXKDxmbKUwRau6/Ovb
	lSQZr21VaQ49R5KAE1OV90FJ/RITdazHi7Ii9Aa+qihPzowkeHKoEGNmH6weJJzd
	QsGnBEfo6yRJPiCLsKI63ZOeh9POj4awCaQonojVN/fSzmJUpxR0yxoFX8eRStj4
	j0spqrsJl64uRwJg/C7em1kn6z6tNXa0UEVPwI9ti6nbfkBFATkq6pxUpnCeNxxH
	JD5jk0IdF4nlYX+zfUbkxjXrzsafvkDPqDA==
X-ME-Sender: <xms:Pzizad04tXVEWvm3emUFAE2dbx-MgRWDEy0G3qUBbKZ0R3cDpyjdow>
    <xme:PzizaWXIyf9plmlgZKCnRNVc6yig1mKaMwriXsPtDMiqBtoaUz920Z0wqJfTIfW3P
    cuJeQ7el2tMaUQkiYCQNRYAa4iDurnxi-Xq7Mw68dj-5AQVfRe3Yg>
X-ME-Received: <xmr:PzizaQLtVHECrtrG1eovidrsFkKoJA2TpO6RkTmS2QL440dTYubePuj4UCKdKAPlarw5v__pdNCr8ayINFODDNvy1tMA3YaV1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hrrdhsihguughhrghrthhhrdhshhhrihhmrghlihesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhonhgrth
    hhrghnthgrnhhmhiesghhoohhglhgvrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgr
    nhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrud
    ekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:PzizaQ0koFaySqH5bz4wE-Rx6hxVM7-ZtVQUIW_gKxw5ehZWoSBC-g>
    <xmx:Pzizae7bQ4wEtxh3QLV3eLbNBr5b5yGj-GSxY0MofkK8QOC9H4FQmg>
    <xmx:PzizaR_YMSZ6uzixwIW-XM9Xyp-WseI9mOz3BXkafH6eUCRnGjGnDA>
    <xmx:PzizadU6051zaayjVTnF-MzegYP00JXTEXuNh0gu2FGn34zRLGrw0A>
    <xmx:PzizaVvyUhiIPc7w-FEQgponzbr0arBfuYcqGZ9HQRHTrwaDNZqQRaze>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 18:03:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>,
  git@vger.kernel.org,  jonathantanmy@google.com,
  christian.couder@gmail.com,  karthik.188@gmail.com
Subject: Re: [PATCH] t0410: modernize delete_object helper
In-Reply-To: <20260312203337.GA2552877@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 12 Mar 2026 16:33:37 -0400")
References: <20260312125030.7799-1-r.siddharth.shrimali@gmail.com>
	<20260312203337.GA2552877@coredump.intra.peff.net>
Date: Thu, 12 Mar 2026 15:03:41 -0700
Message-ID: <xmqqwlzgaeo2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Thu, Mar 12, 2026 at 06:20:30PM +0530, Siddharth Shrimali wrote:
>
>>  delete_object () {
>> -	rm $1/.git/objects/$(echo $2 | sed -e 's|^..|&/|')
>> +	repo=$1
>> +	obj=$2
>> +	path="$repo/.git/objects/$(test_oid_to_path $obj)" &&
>> +	test_path_is_file "$path" &&
>> +	rm "$path"
>>  }
>
> It might worth marking these new variables with "local". They are not
> used elsewhere by the script currently, but they are common enough names
> that a collision in the future doesn't seem that unlikely.

Yes, and another thing that was pointed out is it is dubious to use
test_path_is_file here, as "rm" would be loud enough when it fails.
