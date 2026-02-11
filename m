Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCE96BFCE
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 22:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770850621; cv=none; b=gkkhYCoLoMrip7/tmkiGhScLYTGb3xwHntGJQMcuGieey0FtiwCQwtT/h8WhQVkcOAzzk0yLBdzB8TIxY9Yx8Zwbo7InJvDgutCVhXz0uv6BcIOc4a4ncF8OzVvRc64tK8pnN7ntA3o02ZqhXSbpsvCAF7ZwOQIRlMkgVLVZChQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770850621; c=relaxed/simple;
	bh=iceyVeXA8ebZTSm9fh+KwLvd1GEEHlDR+Z4t1wk9GRM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mf3ajWxoYOekzOy/DmQi74xreeeleZlEJf/hHyl+LSw+9bkle1L8MGmxtOLmfehQxyo+KPQzJceqzzLKHQ7c365xT/RW3cLFYEfMIz1p/WRItevhUJXPb4FZRrtDElddMzyXk5T1oHHLg4+ssCC/J2zlB/S1H9Z/bGJuGNriJJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oZ4FQEn2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d787yRUY; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oZ4FQEn2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d787yRUY"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 659757A0036;
	Wed, 11 Feb 2026 17:56:59 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 11 Feb 2026 17:56:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770850619; x=1770937019; bh=HvWRM5FPE4
	5AXN5wdmYn8FpekT3ETDeYw6l35cWsE/s=; b=oZ4FQEn20EyPAPcc9CLdnFC0Qp
	+K+/F3fSa3WyZsxdM6YkzfvUAXYRLG95JNy5RHC8SwtuKYsAdPRfmlcHqnEM90Xl
	Ic/ZHfm470L7xuH7y2GVI1bsRU+u7e8/+t+tUqLOg1GsW4PUR+rWVwYh5hOWhqSK
	LGNd9uj88XUhW/KqT4tqElvhBp+vnpdvhB1JgXUkk5e9diUhGs+8gM1NHRrj7h6F
	nohv/DPoBWIyLqJrUdHbFO4cXPTW4wZJurq8M83/u+ee3h1g41tDniLiNJyWGvUm
	HuE22gHo9Sh0cR1Ylts5JFljeZVlbYEyMZfoEKARxny2jrOqcpncoUoCa1XQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770850619; x=1770937019; bh=HvWRM5FPE45AXN5wdmYn8FpekT3ETDeYw6l
	35cWsE/s=; b=d787yRUYzzg1/qbbJqdgh+ywAYOz72s63AZFSg74h5WM9uxboLG
	9HiCXVe5MKRqqnCbNn5kddQjumZUoPsaP/T/XDadWCVj3aT8K/2taoqgGZ0xnclM
	pQF6aNk7n2QC8LuYilKlU7QzY1hFMT6zQyHdfZrGA4F4uw/bjhQHKhrwc1r0cSqu
	u0hzqPd/AORl3gpsWz2ENF18GkZnY/dISfjYE5gyxCuAIVZgViYnvB+H589qAnxN
	qtmiJ4TBLD8AIJDqPLFBpN4BawxE49G8r+9waIlkXeNqWLG+aSK5NG8LkqFi8Omt
	GQdT9MC+xYx5Dsz3/6QIKynJwMg80yfF+BA==
X-ME-Sender: <xms:OwmNaf2i-62hiFsB1-NeDmPxWcOW39fDn1i8JohoXUDaK5MXD67hcw>
    <xme:OwmNaU-a_OrTk11-MS4_Dl6qFltM-gUy68Guqfjl8fF8IyY-3iILDd307zxg6WVaJ
    dUfZ_ZbckcXDUx-gZ5QWdXXio03ZJHGeZ9go8ZDL96oYuUwtxV1>
X-ME-Received: <xmr:OwmNaYNAF2b5vQ8YG8mN0wYktH4Q_UO0hBN7X5d4nejRQUg8xBG7s6pnFjqxQXmx8I0nLYZtG42Meirte3Lo1-o7jMUUBh78Sw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdefjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjie
    htsehkuggsghdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesph
    hkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:OwmNaQdUQfSiDoz86aLvL5KzaIs6fqVV8uYdA_RePlsAad0awn7ePQ>
    <xmx:OwmNafXN2G4mDwNfzZXRprb9WA4uBmxtIJJfx_xvJ6Hji64ZkDBPKA>
    <xmx:OwmNaQgpMlOX7mtZfMAVHAM4WiIm7XBho5uXnWS9MVL9NUous9ptZA>
    <xmx:OwmNaW_w0ZY3zs6mgQzUKAsnrvKQd7Wg03aDl9lWpZc5kgxOL0JfGQ>
    <xmx:OwmNaZt1oWoYekBY73IfOX09id8iwzYMN_bfq851D5hOu1e6nRLX5cjx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 17:56:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH v2] meson: wire up gitk and git-gui
In-Reply-To: <5975950d-873c-4bc9-90b6-e062021ab5de@kdbg.org> (Johannes Sixt's
	message of "Wed, 11 Feb 2026 23:41:33 +0100")
References: <20250819-b4-pks-meson-tcl-tk-v1-0-6bcaff0bc0a0@pks.im>
	<20260204-b4-pks-meson-tcl-tk-v2-1-5bc3ccf3a8ce@pks.im>
	<20260205093748.GA2177239@coredump.intra.peff.net>
	<aYSFGG7lCg6Sw8vy@pks.im> <aYYLLI2Gb7YlBtKt@pks.im>
	<xmqqjywjrnx6.fsf@gitster.g>
	<5975950d-873c-4bc9-90b6-e062021ab5de@kdbg.org>
Date: Wed, 11 Feb 2026 14:56:57 -0800
Message-ID: <xmqqh5rmrirq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> Am 11.02.26 um 22:05 schrieb Junio C Hamano:
>> Patrick Steinhardt <ps@pks.im> writes:
>>> On Thu, Feb 05, 2026 at 12:55:04PM +0100, Patrick Steinhardt wrote:
>>> The fix has been merged upstream. I've created [1] to verify that the CI
>>> now succeeds.
>> 
>> Hannes, I see that in your tree
>> 
>>   https://github.com/j6t/gitk/commit/ddae547e3775638c238c11f30120f1e7e763fba8 
>> 
>> has Patrick's fix.  Is it a good time for me to pull from you, or do
>> you want/need to finish any housekeeping tasks like tagging before I
>> do?
>> 
>> This will hopefully help us unblock one of in-flight topics.
> Please feel free to pull this commit (it's today's master).
>
> I was pondering whether I want to include more topics in the next pull
> request, but I didn't find the time to make up my mind. So, let's take
> the fast route for now.
>
> -- Hannes

Thanks!
