Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20262750E6
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 14:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648955; cv=none; b=Q6Bv8w8sg3330i/jW53c/E0BM2TUXh6/mSRGhM1ynp8g7esHbIGzlsOk2IMMRbq1Cvf9yvrnmDnzVigZAbFw39MaoCIyeOfkX9vp5uFlr9N2fY/55v77vO9J5QEM4hpks4prHW//+rdIeRcKcA1BEolPpOpnY0wJ+XHlnADQG4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648955; c=relaxed/simple;
	bh=yTKCgQbwbu+S6N11IBs44XFWcQo3hBJyMWctuRPwXYk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o6UQRN6FxZSGCG6ASI/tmnaP/s7e/Vpita51BnKTRLchUlI4/eUR4ZBbXdiB1TCtfvp0inPHOpIn3W00WWVnbmPycS8Ne1uZdm7iyhHuMaV0UHCN5Am6pJJJ3fpQ+j96FJlvqHnWK7C9CRyhlH5rGZf4G9h1lw2m59HKD+z6Cjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=k/kGw3CS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sZbgWRxB; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="k/kGw3CS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sZbgWRxB"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id E10F11D00127;
	Mon,  9 Feb 2026 09:55:53 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 09 Feb 2026 09:55:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770648953; x=1770735353; bh=LTbB0LsN8r
	IAwE09Vs7NZm0AI+lKRVFhgkQUGm1oE3w=; b=k/kGw3CSaYxqkW0CavKE6WyhEn
	BRHwtjtVR96VgKQjtM/jppBEHyYkv4JOAros0ErbkZ/WrHLpZdFU3buQOXfVg8us
	RerDCw/PI5nouERYNIwlspNWh/bmLkKylxWvMJbfHyZRv3T1Mq3W0Pt202jg2bqr
	0G1eX7saxgQOYVT3IcZ00Nj3epI1HAAWFgSj7gpF4aB9P9s5vfavrtV0XCRe4EwN
	VVTX19XgMtqP3YXnqvRO/OyxhZJPx3lIR/xb8ZrFYTlvIkdepsMZb/UujSK2GkBy
	Flzp1YM4BWuYZKH+Z8sgQhOIOmZ/ysgZbj5G6Mn2BgKC3qOBsEDXiStHS2HQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770648953; x=1770735353; bh=LTbB0LsN8rIAwE09Vs7NZm0AI+lKRVFhgkQ
	UGm1oE3w=; b=sZbgWRxBFiLRhS31MiZWw76HIalV8WL1zhLYajonBzi8MH7N5wl
	/dFP7A7bspT4VNoTvwvSQ/XnDqHlpe/vzhdBCjSxZzYNOg0u1Qs0P0VVi5/XSx0P
	QLWCJIDi5mgzK5GzlyG8HnUB4pwabJtRKPYYgCAcEQGdcfrtlqO6YCnzYYntarbv
	IMWqTSVDOBtJIfmltvIF3F1jTxh/Ds5NuTAJkMVGkv7PyydxRAWWP2ekdhAA1ALd
	mbiqos5sAHwscnEcxob8+HLVwVI146g1mgR83E7lnbLwfaAavlJrxWP4lw+4pGFm
	VHm1n8ChoXhWkAdvcL2+wqwwyEbzrjXmWGg==
X-ME-Sender: <xms:efWJaaywQ8hceslYLxy-3SoQMdYI1vxmegGNaZP_EL29L60of8wdew>
    <xme:efWJadSBS38eCBixRdmwUHxd-hf3PcPmL0EDLymOADt7hJ6gtB_EzIbtmsMqDMUVl
    bFmoKzYazc3TZZB-I052hnfcMtzjFuM86N1GYmvtULtRUqgW1Ms_A>
X-ME-Received: <xmr:efWJaRXNJP9sJGU50E1whGsD570xvXiLmQrsIU3OJZYrpwzOc_JLlOZaIo8JvgW--p1Ldf9a3frtfaoLMek3_3wHkBWIDT_acw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleejuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprg
    hsthgvrdhnvghtpdhrtghpthhtohepjhhonhgrthgrnhesjhhonhhtvghsrdhprghgvgdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:efWJafY9aNHGr9EcFUIWnbp2Too56y1KihiOELBPGjU9ZrgGZenMdA>
    <xmx:efWJaX2bFvG76yUgacgqjhoqzftmbQtANaU4gb_XuzLM-qrSyvLz7A>
    <xmx:efWJaRjQJAL4C8ipM1NVUD6cswyj4J5gsNpEf0IsgOXUyFVMf_-NdA>
    <xmx:efWJabY9rSpW5htOJrQ6g4FSjRVD_lOvS6MWufF8RLaqcyw0Px2hAQ>
    <xmx:efWJadRhvqmUzh3ZcWtAdEm6H7kxZraxHP4ak-c9y8je6xMtt-fl_-w4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 09:55:53 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Jonatan Holmgren <jonatan@jontes.page>,  git@vger.kernel.org
Subject: Re: [RFC] Support UTF-8 characters in Git alias names
In-Reply-To: <aYkaepCu4lwT3xNl@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Sun, 8 Feb 2026 23:21:30 +0000")
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
	<aYkaepCu4lwT3xNl@fruit.crustytoothpaste.net>
Date: Mon, 09 Feb 2026 06:55:51 -0800
Message-ID: <xmqqikc66k5k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I don't think we have any Unicode normalization code at all in Git,
> though, so if you want a quality implementation, that may be a thing we
> need.

Isn't NKC/NKD a macOS-only issue in practice?  Anything on the
command line "git" potty and "git-blah" built-in commands receive
goes through precompose_argv_prefix() to be normalized on that
platform.

>> Before implementing this, I'd like to hear:
>> 
>> 1. Is this a feature the project would like?
>
> I think this would be useful.  I don't personally plan to use it, but I
> can imagine a lot of other people would, and in general I'm in favour of
> better i18n and l10n support.

I am not fundamentally against this, as long as such an addition
does not introduce unnecessary bugs and ambiguities.  IOW, do not
force me to read bug reports in this area after it is done.

>> 2. Is my implementation approach reasonable?
>> 3. What concerns should be addressed in said design?
>
> As I said, Unicode normalization may be a thing you want to support
> here.  Not having it isn't a complete dealbreaker, but it would prevent
> hard-to-debug breakage.

A buggy normalization implementation would be also a source of
unnecessary bugs.  We cannot have and eat that cake so easily ;-).
