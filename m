Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3340E139D1B
	for <git@vger.kernel.org>; Thu, 14 Aug 2025 22:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755211892; cv=none; b=A5IMEyEp+Q2X0+bD+L1v/Gt6CpvqjcoJTaFBYuY6lX5qu7+1c/BME0FhdHVHCg+TPKhokNkm6laVs+BxvN8wOsEHvd/cuVbC/zAhYwztAYBBIr0F5+5NJsiC70QZF09YV581ygv/l1zNpxgiRrWoRiPqQFrqlRmjWZDTgl2PgQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755211892; c=relaxed/simple;
	bh=aQHyQUgjR02Wn8+m7MsrMPLlH6LW+xoOeRflhyUrYzM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UsvBkhSk2pd2+y4dA8D9BcchCBkfHYlf7vY8KDktuSFRVbnGOFTZkTG5kve4SpQRS7wuxQ4+XKbf5bb3TQJYCypMNXDCqTzj7rVyJeUJr9hOjY+6ebgoiiFSQBJtOh6xbRWyHGmENXgDQ3rMceBfvrZz/EdvrcOYDxTdFnKHnCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dqcqyyf1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I5bf3S0b; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dqcqyyf1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I5bf3S0b"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 2DACFEC0198;
	Thu, 14 Aug 2025 18:51:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Thu, 14 Aug 2025 18:51:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755211890; x=1755298290; bh=KcIRSmPH9F
	+0e9dRccAouvPlp8DKBv7asjzpkgfO7U0=; b=dqcqyyf11/1M7e/wcsHne7SEfk
	hIGNmyTn9HdSsgSotIcTNfUmzsCU/n+tfji61umE8y1Ul0HfwAaGCLH3rUr2Qx3J
	yHdRh5vI9WG7FS7wjrP25hHDS/ngLsbizCJzL+4IS07jsM3j6JZD0l1mEKfJcaSN
	psu1t6oxtO8tV50C9jlFlyXeIu+m0PG4188z1oOYnqMbBUdy/9wdpmJi2sWmjtuX
	f+Ew/UMsV39emsbuLIlsYE6ztP5vsJhhTLzw6PuAQtQuQrAHmemTzsIY3DXYLBmN
	rq2rc4Hp+xHulQLbUXy7n2B6765Wvnb5zbSqL28OgmV6VZ74U0O844ZQ/CDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755211890; x=1755298290; bh=KcIRSmPH9F+0e9dRccAouvPlp8DKBv7asjz
	pkgfO7U0=; b=I5bf3S0b15/pdae5DRGJ0/4I9CKFbaXFeuZaPoTyFgoXLegd1cd
	fhH7yUWaS22LrvMpsG0XAM1UXZb/Y7H8dVV92/zthMsvVwjK9VcR8hUSY5na+ihJ
	CRYzFTtvAaHuPxZlE5n2PxznHXQpCC0r9TsruOY6UvSbI9Z1W2YBLMHjK3t/vxhP
	Ipyc6i/TX222Z7WAEkeS2XKn+nrbKijrSe8IaYYxVhINf2kd5amSTM/pjvixxvc8
	kxZ7USOGvTm26SIWDDFP9+UzHOKZkI6Mza1uHP/6ms8ruiB8ZM3jVfLujnvEFDOH
	/5EKVA4WVmta3sMq+uX6ivv/fi4V0eJDEHw==
X-ME-Sender: <xms:cWieaCFeegSzGHaqA1_LfaJKPU6pUJ8Wj5kyY-PhYAKSRTJG6fXFFA>
    <xme:cWieaAR4pNCRaRC07-GoM3A2jp9ecBRWK8QcKVGtyTo7o_IPql9xLve7x9a-xIdQG
    7SeJoI_fS6zd8QRVA>
X-ME-Received: <xmr:cWieaHzPcypoPc2o8r3pFJom0upuw7nPqHRcE5MMq70EyaqGjPQVeVSWMZ4PNxYLC6eIhreVkKLs_FZWNIbignmBGZFhe0WtQAUiEBY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugedvfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepgfetheeukeejkeffheduhffglefgvdevhfelleduudduffejjefgteeltdei
    ueeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprg
    hsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepmhgvsehtthgrhi
    hlohhrrhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgt
    phhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepjhhrnhhivgguvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:cWieaEdORxb2i84A3MN-FEeaQzl3Z5D1jdFRCVQDP04u8tXfEPkbgg>
    <xmx:cWieaCMc3CipXxuJW1xOfIH9jm8lM5cT5H7NThFzb52uXlVz3uF_aw>
    <xmx:cWieaHu9BvRWnEJ4nkiYSvFuPEcWN6atFf3sRY8tEhGJj1D9HeOKYg>
    <xmx:cWieaLAPM39HLID70R6VqC-TANnlTbLChDrdjKbaWtZL69Iyppr7GA>
    <xmx:cmieaJHImBAToAB26HVxuoC2M3pqN91KFZNTJQOBV_l_j-iISZvNJzg6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Aug 2025 18:51:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Taylor Blau
 <me@ttaylorr.com>,  Derrick Stolee <stolee@gmail.com>,  Patrick Steinhardt
 <ps@pks.im>,  Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Efficiently storing SHA-1 =?utf-8?Q?=E2=86=94?= SHA-256
 mappings in compatibility mode
In-Reply-To: <aJ5d3tvrm2S1ZTR9@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Thu, 14 Aug 2025 22:06:22 +0000")
References: <aJ03RTHaE_JvHA1t@fruit.crustytoothpaste.net>
	<xmqq1ppe9e5h.fsf@gitster.g>
	<aJ5d3tvrm2S1ZTR9@fruit.crustytoothpaste.net>
Date: Thu, 14 Aug 2025 15:51:28 -0700
Message-ID: <xmqqh5y9wm8f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> As there are some objects for which we need to carry dynamic
>> information, e.g. "we expect not to have this in our object store
>> and that is fine", which may be set for objects immediately behind
>> the shallow-clone boundary, may need to be cleared when the depth of
>> shallowness changes.  Would it make sense to store these auxiliary
>> pieces of information in separate place(s)?  I suspect that the
>> objects that need these extra bits of information form a small
>> subset of all objects that we need to have the conversion data, so a
>> separate table that is indexed into using the order in the main
>> table may not be a bad way to go.
>
> My plan is to just wire this up to `git gc`.  We'd know what entries are
> potentially disposable (such as shallows) and omit the unneeded entries
> when repacking.

I wasn't talking about when the information is (gathered|consumed),
though.  In response to the request for comments on file format, I
was suggesting to have at least two separte files, one for static
part, and the other for dynamic part, so that the former does not
have to be rewritten all the time.
