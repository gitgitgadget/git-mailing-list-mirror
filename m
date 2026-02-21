Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7051B2494F0
	for <git@vger.kernel.org>; Sat, 21 Feb 2026 06:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771653744; cv=none; b=g8zsaVS0BbMZxJ3DTcPvy2xvmUjh+K5da14AxTCVaro4qpAe4AWJoqgbqk2D1MBKCynFYZ2b8DFNFFCubwxzHWipGipI+h+5SGqCuRtZZ6hfIPJCC35Q305+ON1FQ8YOkejGzEd7/Vwynu0r0TtW9Kh+PYq7cgIDvvmF+v4AXWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771653744; c=relaxed/simple;
	bh=/u6nBsCHrmlHGfHdWsAIOSZC49EXhjerN5FBD8zqbko=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=US1WCqAIdSttuUWgfJfSh0uCKEHduTF8CQx2WDOH0ZfgbxzOHOIpey0TdS03GJBKI4EetNiwmjtqTPxwfXgC2UVRQp1chAW1jzse9VGL5WkeM34JdqrI9KuMzcjgQVNEs6udgVjgYRAEluthU6jwnaTxgwbB+17JrSvWSSVrv7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=sOcRBehZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rNrwxpmL; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="sOcRBehZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rNrwxpmL"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C380A7A01B0;
	Sat, 21 Feb 2026 01:02:22 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sat, 21 Feb 2026 01:02:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771653742; x=1771740142; bh=eObV5pg1HM
	qCzP7IP+AvmHFQ+g8UbJt0s6y4ySCujU8=; b=sOcRBehZi8aUvaon0cxQy9CUs3
	fbOlmOx+c9r4I3V34lW+i3o0NbktvjWX+ReNdU4+ZAe5eEH0PXfSG84rkwiRcAEn
	rzm7RV+z4Kz5pIvIuqJ1vtT6l1bUullXYy/gP5NxAc2mYxfZeEcOVsRIMZTlatqL
	tGM89/G3c2MomNgSqm9e6wJociwC6d1Opt+r6/yAhbE36aldoaLJ94rJfJZXaWHX
	8wccBedlZZQxFng7Ipvhar/M+S1a3qBZWs3UV0UJZZgqd6jLWAi6opQRtzSa3eZh
	4s/oPgpa9Gc9346t8NDsXFkquPcsIQfgs9JocJbBEhN1BFm1FdmCyI6PNA8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771653742; x=1771740142; bh=eObV5pg1HMqCzP7IP+AvmHFQ+g8UbJt0s6y
	4ySCujU8=; b=rNrwxpmLy4SnGbw2vRFkcWFDlCsmp2gr4iZlJAaK0MdDigAA5d5
	sZRWNsbtVXJ+lMypuz6mMkCWmHYirWKpmGshVb/ZDkCjR6CH4Y/etgON/DVaUHZI
	p5W4F4hfBOqMDfawVwND7WHHa2Wr/59v/J+wQBGonHjrOHLq5HV1WF/a/HQxasgu
	0Px4jD2zxLOhVgMPIQBfDqBNWdQtT4PrHrxitp50czaShRBP61YPimYePnNgJS4I
	jX3jtX/RmmNxEJaR/VvOH2q/kvB9WFp9D4eiSy46BTzSsFyo0UxOMyS8EbLJYVAT
	LvKEzTrjXQB7pKfkg3xBjyC0yGK/QSKQ2bw==
X-ME-Sender: <xms:bkqZaRqI7_EoZB9j9jz9h_HlahPsGgA2Ew5dfwkTOh8_QO3OlwX6VQ>
    <xme:bkqZabFGDu3ToOQAWgVixM5o6mbjfxjiXuBxUTYDUsAF47fZGWQuUYEOpkjwE5gTd
    857BWzh4grEitztVwWF9yzLsmo55xqGpqoUPW7lgSIxzJeaLbQUrd8>
X-ME-Received: <xmr:bkqZabknQaAnIjyXXmeFEgFGPjBSGd-t_CvJm9-n8hNObmH-N-necPRlLNQ_7GAUi22t61zq-0c8hWPdwtKXyk6Ex9FdxwfRoQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfedtheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrhhoihhk
    seguvghlrgihvggurdhsphgrtggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:bkqZaWmjxLohN8HRizrzGeU2RAkjfIczJs4KBunl3dg89imDJaA2DA>
    <xmx:bkqZaUtlt01_0tscUQUrMBk9bvm_q414kD6PSGwCA4sMLvXg52Rp_A>
    <xmx:bkqZaRkEzVGPM5UDmXQNMLpU0baDos0FOxQV9y5pJvqhyS6KOqGcrw>
    <xmx:bkqZaXs-2Ohf0p6fObUGG4cGikY_vuNIFOKieKPjancBD-BwULliwg>
    <xmx:bkqZaWRRNoxniJcRfDw-o-Hox7WPVO8yVbTtphOR3Gffftd6olY50fih>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Feb 2026 01:02:22 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH] format-patch: better commit list for cover letter
In-Reply-To: <xmqqh5ratzc6.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	20 Feb 2026 21:55:37 -0800")
References: <20260220230633.132213-1-mroik@delayed.space>
	<xmqqldgmu25h.fsf@gitster.g> <aZk9QlH2PDugXKrh@exploit>
	<xmqqh5ratzc6.fsf@gitster.g>
Date: Fri, 20 Feb 2026 22:02:21 -0800
Message-ID: <xmqqcy1ytz0y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

>> Maybe the "--cover-letter" option can take an argument like
>> "--cover-letter=<shortlog | commitlist>". ...
>
> Just off the top of my head...
>
> Perhaps with
>
>     [format]
> 	commitListFormat ;# true
>
> we use
>
> 	[1/1] format-patch: better commit list for cover letter
>
> and with
>
>     [format]
> 	commitListFormat="%s (%an)"
>
> we use
>
> 	[1/1] format-patch: better commit list for cover letter	(Mirko Faina)
>
> instead.  IOW, the value of the configuration variable is used as
> the format argument "log --format=...", and appended to the fixed
> [n/m] that gives the numbers.
>
> Without format.commitListFormat defined, or when it is defined to
> false, we'd use the traditional "shortlog" format.
>
> Hmm?

And the corresponding command line option can look like

	--cover-letter=(shortlog | log:<log format spec>)

e.g.,

	--cover-letter=log:"%s (%an)"

to override configured value per invocation basis.
