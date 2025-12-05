Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D9840855
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 22:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764975137; cv=none; b=ft6B214cUH5vEgBunYukQGsh57uArUWKAdRRFw2GBK+kKBhqujiIqwcwbyuz7evpnUWfTnkC8ubA/sf00J4QejlCgfYlK0BY+hjjC78H74i8uWGrW4wanp7HJaYZaH5eNSWDqMQRKdPjqEGXlxlzgojaOreoTUREkGfhmIxgEVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764975137; c=relaxed/simple;
	bh=UvvQtKs02k4HZRxzywRcu4UjgEyNqZj0mgtL0C3/ddY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GR736vyqNfIfazIV5cMcQ20wUdAZcqxQL/bTg/gfJLJJL9XyuXBheaM1hjDW9EWIKJA1dLuNzLTgotxY6uv5rfg2NgEfVWE/oiuGbE+St3ffJ3Y+eA+dEknIeQDUNYsFMS3VWZqT//nEaOtfYIFu+eIIr49+31kX7xULuUXbvbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aX3P81bm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nz5UUGF6; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aX3P81bm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nz5UUGF6"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id E1D291D0010A;
	Fri,  5 Dec 2025 17:52:14 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 05 Dec 2025 17:52:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1764975134; x=1765061534; bh=UvvQtKs02k
	4HZRxzywRcu4UjgEyNqZj0mgtL0C3/ddY=; b=aX3P81bmMi03v9T2ocfTG8w0eX
	+uzWqIFGAVHnTjSuKhL1sp+8Ckrh2+JqwbiaIe3oo/+sjMOOiJjfYD5NVJ1iS8OI
	FyzUX18uFQxkCvJ6l+gQl8APvi0v5EX742Xe07UWSTFXuaptRpwAIDlRfhkbG+HE
	+hn0dyIwLm0KO3YAZmQz3kEad/LaFlhKgiuuuqt3fJka0syfXHwQZ4h98Xy0digo
	tvfeAyXTX3mZd/hVAU3IBZbx33Ho6n26TeMm54l2L8qKcLAkFEOIcRe2oJT/YTV/
	4nJj8zYlIGSjIEWnw8ZZVzZ0gwce00BBHVJHFT/HiUILVbaqXkosDOnTdprw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764975134; x=1765061534; bh=UvvQtKs02k4HZRxzywRcu4UjgEyNqZj0mgt
	L0C3/ddY=; b=nz5UUGF6GvMB7MFs6rRSMWtSuT18W1YgVFd+A926/ddPxWc9HTa
	PjsGAPqmkziI//tNAqFXxSW4Cjee1tUqt0grPBoZETx4NyYbYneXHWrF9k4HmuPj
	le6B9UXdityVBW+cIiZ7xp9mq64uEMmB2NhC6Mwo7JGnC2eT424bZjTQHr1ogUCY
	RU3n0TFaxYZzj8VlQ4HWmF6tJEl+fwbrW4Y0Tj0US9R3pwEgCCIVu39XADkdCzau
	zUrtuo7RNYj7tbu19+a+gh+OwuLvaX29UtpzIfORx21HP6vjD+O9fYRJ1I/807yN
	L7iD7166wzXUC5J3xGgCOW6IB8xyp5TbJ8w==
X-ME-Sender: <xms:HmIzaXOI38m7M-bXcsNxay5VbHt-2uvGChJcl1hbI-LrbtMRk6YO_A>
    <xme:HmIzadzV-QkSKbBpO-BT_nYnvFzTcFWESTRro4qITqXKfkZchfYf53Iyirqp-XqOM
    yxmmN_sxTtMQ1D0_ujUxRNB2AgH-NmJAPT_pJG-uoIcydtJ008cAQ>
X-ME-Received: <xmr:HmIzaRrwpGwKrLKLJzOOzXiyvlhLIhlWj8bu4wzzWp71C-RC3eX5MO6c2ktdXbHr7FfbP_x99IWC_qFU4M5v3AtxzvtWPo971bHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegrughrihgrnhdrrhgrthhiuhestgholhhlrggsohhrrg
    drtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvmhhilhihshhhrghffhgvrhesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtoheprhgurghmrgiiihhosehgohhoghhlvgdrtgho
    mhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoheprggrrhhonh
    esshgthhhrrggsrdgtohhmpdhrtghpthhtohepjhhrnhhivgguvghrsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:HmIzaVPUl4iF033oobwPJQy406gStj_RLhYWfQG4yBE61DzKEHeqgw>
    <xmx:HmIzadePdo7jZUQUeOnUQM73oFy1WxCz2WYSQd46TAQ70Qf9kK-M1Q>
    <xmx:HmIzaTU66WTQCMNQqbes7QIv5vjYtdWEsKVUgx0UA1Q75SHTVeuFeg>
    <xmx:HmIzaWB0DurqpF4YOR6mXxzDuBiPUjDBXu2XaAnwCdKfNue8Loam0w>
    <xmx:HmIzaco88Nk2ou07BvciNIOFp3b4ae6o-hywkZhN5wwFODsoOeYIeo_f>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Dec 2025 17:52:14 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Emily Shaffer
 <emilyshaffer@google.com>,  Rodrigo Damazio Bovendorp
 <rdamazio@google.com>,  Jeff King <peff@peff.net>,  Aaron Schrab
 <aaron@schrab.com>,  Jonathan Nieder <jrnieder@gmail.com>,  Josh Steadmon
 <steadmon@google.com>,  Ben Knoble <ben.knoble@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5 7/7] meson/Makefile: allow setting submodule encoding
 at build time
In-Reply-To: <87sedoemvr.fsf@collabora.com> (Adrian Ratiu's message of "Fri,
	05 Dec 2025 21:42:32 +0200")
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
	<20251119211030.2008441-1-adrian.ratiu@collabora.com>
	<20251119211030.2008441-8-adrian.ratiu@collabora.com>
	<aTLNxlKh02T_1PYB@pks.im> <87sedoemvr.fsf@collabora.com>
Date: Sat, 06 Dec 2025 07:52:13 +0900
Message-ID: <xmqqms3w7d9e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> On Fri, 05 Dec 2025, Patrick Steinhardt <ps@pks.im> wrote:
>> On Wed, Nov 19, 2025 at 11:10:30PM +0200, Adrian Ratiu wrote:
>>> Some users find it difficult to distribute repo config changes for
>>> enabling extensions.submoduleEncoding, or to enable it by passing
>>> the config via cmdline, so we add a build-time option which can
>>> enable the extension for convenience.
>>
>> Wouldn't it be more sensible to make this a runtime configuration key
>> that users can configure in their gitconfig?
>
> The request I got from a combination of feedback from Junio, Aaron and
> Josh is to avoid any kind of required user intervention or manual
> migration, to find ways to automate the transition as much as possible.

How would that lead to build-time behaviour change, though?

Users in managed environments like $CORP can rely on /etc/gitconfig
or equivalents managed by their corp-eng, so I am having a hard time
imagining why we need anything more than an configuration variable
looked at runtime.
