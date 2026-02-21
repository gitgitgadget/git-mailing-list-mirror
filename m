Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E3D1DF25C
	for <git@vger.kernel.org>; Sat, 21 Feb 2026 17:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771695184; cv=none; b=bDu9KxKjYQoTUtEcZUt3M4KPa820BsTHdU+jbXKIKJqeU5XM0w6rrOx2XEibVKWv08uWxIuAYswsGP13Cu0cFtz31DV6I+I1wJZDHajK2AkJHoSs69VnFYrIfMIeQZsYiK686QQhge2TvIHkyenxdWM1+nCZrMzYHZ0so5eyLy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771695184; c=relaxed/simple;
	bh=9wfWwbBTd+tEEzDT8ieha57qQCh4/2bwPzMY3gqb81Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UWHGmgGMtWukjUinjXNa5gC6IulO4zPJYSNuLJpX/1DXSAhLpanXaf4ff+52eohfJDW+8p9s1sF33dS3KIyV2Hc2sxlrUnxRzKsN03DUsxR1aOPaaDATCwQc1V9ZPmD2zdmi6Yupi6f9Kls+iCwJKetfPPdOWoc63avb6irBLGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=b61KlV9H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pN4pPERH; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="b61KlV9H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pN4pPERH"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 793E51D000AC;
	Sat, 21 Feb 2026 12:33:02 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sat, 21 Feb 2026 12:33:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771695182; x=1771781582; bh=wXUT4JTC2m
	Wi6IulPQJM4g3ozOqYz6weV8TKtbUERPM=; b=b61KlV9HV68i5xrYjGxLe0FS0d
	tVRvgYIr1sJdnaMfRxsRgb02I7x6RdrGW82UlgkUb8Dsks5ehiW4XWQoeQpOkqtK
	zWmymGkdSktDfB3q4Zr5dKG6VmNy/BsDcuHcQBUjIItvD3XoY6hcur1WE9Lv7vR9
	GbbiP2cedwX2KEIOK3NFHi1gG4OuA/QdgDKHRkW0lMNNtbVLm7GwUmXi595ow034
	LFIPZ3UFGw7/crwDNWy/Y+tUBqQdT+pDNHD/s4RTsn8mi3GCXhpdNR95OIdiJjPq
	RfNYxwBH8ZKUMuP3LEMp+btvlETUgdtvMRJ9udeMpcjAOdqhGqBQ/GebpzKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771695182; x=1771781582; bh=wXUT4JTC2mWi6IulPQJM4g3ozOqYz6weV8T
	KtbUERPM=; b=pN4pPERHTnrYmx8B369y2dQUWrTHCN+Ksxqa6uhIfw1Cu18g65l
	rWiSyMZ4JtzpG6YNT3X4zl7qTiBO+yl9jnMJDSyjt+48cxj3oBTnRZDp4wyv+l4o
	YJmBcnDjJhZjr5GA0z6sI1GJzY+YsFloGBQJSjYQ8e2seuGkFWX6+lVX7FDyBtGI
	fAecGC+YYL38jZHzSWMZzFa3LZ/DBV0d+8qgkkk6O1J6bCYOs3XWJQNF1boZGVMf
	eooAuF7YHpchd2W6HEyUSW5NCmHV9Y46qaYjRyjWg9a2/yeTPYKrTGS9BKfUiXt0
	BxTjhB5yqrtvejN3fLNmDdwgW7iA5AWejXA==
X-ME-Sender: <xms:TuyZaYsOE8apYh-cr3IVi9mReTYik-CvAFCya2jReL4LXMPDcWa3dQ>
    <xme:TuyZac4KJBlvoLRF3WIydaWdSU6Ux0Dmnb1L1KkZqGGooH-AgGwv4_hTOrboNcBc1
    p1GZ8EiJNfKzjD2_emoz8inOtKTTFT86gCD4aITjz05xVXfaBsPXA>
X-ME-Received: <xmr:TuyZaRK2c-Qgt7ISWsfIJUWmm-MuMay9f_LMgJ3HYcGseoz4N4fm1Ipwc5Vp24MFUlKbl2lTMNS9VK-4GAK7NyZIejFQZKmzwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeduleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrhhoihhk
    seguvghlrgihvggurdhsphgrtggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:TuyZaU41O5houYJ3Hihex7ggTbPLfeHX_S-5HJVgcT5reRkBSxNrpQ>
    <xmx:TuyZacxBYzVSc1I0evZ9QpEU0QVUxfEH1JVR4RT8WRji0VGFpEmkSQ>
    <xmx:TuyZaQbNAYOdFkO6WblclYFyNMCb1-HG3IG3sn1Mp2ecrUBQ_JVE3g>
    <xmx:TuyZaWS5UglJb1NF-Dksrr_GtEJHSzMSDaF_kl0vGdoZgk5ffRWInA>
    <xmx:TuyZaRm73EKvFzU7QP_RTGQtCXwQjcwCimCn05eqz9EZzG8RT71diCNV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Feb 2026 12:33:01 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH] format-patch: better commit list for cover letter
In-Reply-To: <aZnOyYGzOByayPFK@exploit> (Mirko Faina's message of "Sat, 21 Feb
	2026 16:59:06 +0100")
References: <20260220230633.132213-1-mroik@delayed.space>
	<xmqqldgmu25h.fsf@gitster.g> <aZk9QlH2PDugXKrh@exploit>
	<xmqqh5ratzc6.fsf@gitster.g> <xmqqcy1ytz0y.fsf@gitster.g>
	<aZnOyYGzOByayPFK@exploit>
Date: Sat, 21 Feb 2026 09:33:00 -0800
Message-ID: <xmqqh5rarohf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

> On Fri, Feb 20, 2026 at 10:02:21PM -0800, Junio C Hamano wrote:
>>
>> Just off the top of my head...
>>
>> Perhaps with
>>
>>     [format]
>> 	commitListFormat ;# true
>>
>> we use
>>
>> 	[1/1] format-patch: better commit list for cover letter
>>
>> and with
>>
>>     [format]
>> 	commitListFormat="%s (%an)"
>>
>> we use
>>
>> 	[1/1] format-patch: better commit list for cover letter	(Mirko Faina)
>>
>> instead.  IOW, the value of the configuration variable is used as
>> the format argument "log --format=...", and appended to the fixed
>> [n/m] that gives the numbers.
>>
>> Without format.commitListFormat defined, or when it is defined to
>> false, we'd use the traditional "shortlog" format.
>>
>> Hmm?
>
> Yes, sounds good.
>
>> And the corresponding command line option can look like
>> 
>> 	--cover-letter=(shortlog | log:<log format spec>)
>> 
>> e.g.,
>> 
>> 	--cover-letter=log:"%s (%an)"
>> 
>> to override configured value per invocation basis.
>
> Not too sure about this one. The point was to have a useful default for
> the cover letter template. If users have to pass a format spec through
> the command line it kinda defeates the purpose.

When adding a configuration, never assume that the setting the user
chooses is good for that user 100% of the time.  You'd need a way
from the command line to override a configured value.

Not having a command line option does defeat the point of adding a
configuration, which can even be used for a setting that is good for
the user only 80% of the time.
