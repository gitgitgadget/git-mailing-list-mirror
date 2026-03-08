Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68B41E260C
	for <git@vger.kernel.org>; Sun,  8 Mar 2026 06:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772949780; cv=none; b=A1alDyL+r93FdbJC+w0XQcQbTfU294cQbGoPpK1AlLFIWP16pgN7/nImbNUqwRzjLCY3GftuL/UNcRmBwWfKqI85svOBEwySwUs/jvV4Z7zseGeY1N5qWkTXmPH476Gaj/7GDV9A/oA/uuwmtEkrnx0Mhzhg7H1mUF+363zgbto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772949780; c=relaxed/simple;
	bh=t80i8cRYR+qtMBoDwEuSQmYuplpDjaG9ReBfPE/bYEI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JaBaFGH87CQG0c/BV4ssZOQwgkBHrMVl0R7RiI0ixczgSP3/0diMYez7K4k2Cfu614h/4Edamflcd8gSZosMvCyKoQkxwnUwg1zrERyj13Y+pvcs7cRb9vasUDHPrM0zfWFho7MZqyBYLAcBtg+8YTpohmYCEG4A5j9pYRA7JH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jmIMzTD4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EdUgcGep; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jmIMzTD4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EdUgcGep"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D98C71400010;
	Sun,  8 Mar 2026 01:02:57 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Sun, 08 Mar 2026 01:02:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772949777; x=1773036177; bh=t80i8cRYR+
	qtMBoDwEuSQmYuplpDjaG9ReBfPE/bYEI=; b=jmIMzTD4qbWE2j6pSPXHYlXm9a
	Mva0WqyqvvxJct+7xOmj8z8ofzEwpKVrXj2HmOqhJYfOsfUd+wGcYc3f4WtbQkeC
	5QRaF3etmypmJSgvpOaDz8s4hFDdyaGHEZOxM3SK5HxvWEZk2u3pvNxiilAhnOA5
	iAoRjlBycl4umv9kFE0Lp6HfIxchDuBImnKH+Q00fJks1qw6AsKzcOEGd6Ob3Gdz
	tapxfZWwpJNR3Yeg7KVllEk/ZdhB+OAkSDku6RukCk2F2en5t2Kh54tgadrUJdNb
	Aoh1E/6NqpSR6KjrNoR4voGKnXjSi8tmMX0/T6vh325xAcWGi+a8iorK9D5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772949777; x=1773036177; bh=t80i8cRYR+qtMBoDwEuSQmYuplpDjaG9ReB
	fPE/bYEI=; b=EdUgcGepKP9nhA8CBSAzDC6gEbASGW0JcYBGd/PkUepaXcWkrsv
	bwSO70GFumyfuioxO8cO+l41xs9MaeAWbGFn0btjQpeWSSzKW5Iz//uFw5bIkWgn
	cLI6NfV8IV0BJ7kj61U+VJrjm/+nVGXZT48FebWTJAMm5tSoCRmYXPzY8LR8bijR
	ouVuLt/qXJicj5PjsUmQDxUZMrNoRhd9oNt+1Y9uwu5zsWxaHDlBR4eTbtvZ3mIR
	kmABPEJwelXuFlQtORt8rFwXqWjaM0FluVG6ll5f3E4if99RtlUdxBa+iC8WkvC+
	YOq+1ipujPEXAWxzFwxF1SKLN5XoKBme4ug==
X-ME-Sender: <xms:ERGtaS7zi919T8dJIGqwDL01NCCvSJP4JjJxu22hXwnfuE-rWQYIMA>
    <xme:ERGtaeLiRyK8HO_GFlAx0OoB8OtZXNHSgB42UWy2ncYKa60H6Iq761MDTpKaOllNa
    uLCntzAV9gPHy3EBocHgJ7nP9I_NuSSabmkEqEk0s-lVQAxdr7tJQ>
X-ME-Received: <xmr:ERGtaTuCDj43ePaP0wMkvXjVbOwWSRVBAwWhOhxlHbdA3Cpfqx5Gv9IWGqCv5BeKfi9zP9-MZfb_0JU2KwZqk18goyQ8pFYdzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeegfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjiehtsehk
    uggsghdrohhrghdprhgtphhtthhopegtohhnthhrihgsqdhgihhtseifohhlfhhgrghngh
    hfrghushhtrdgtohhmpdhrtghpthhtohepsghirhhgvghrrdhsphesghhmrghilhdrtgho
    mhdprhgtphhtthhopehmvgeshigruggrvhhprhgrthihuhhshhdrtghomhdprhgtphhtth
    hopehmrghrtghnrghrtgesgihiphhlihhnkhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:ERGtaVLjQTwiTOvP3ARwNywREXLsFocnA_D_mbjeBYk-6-ZBm5IxXw>
    <xmx:ERGtaU9Kls3lnDLFqfelgLUbrHc0TXkqM7Z8J6HjKA6ZMAAO5VcBOQ>
    <xmx:ERGtaWz94eTOcub1ym-OKoI6l7W0LaQ1guYviLc1OcrnZSCrejZP0A>
    <xmx:ERGtaZ5KUjm08j05jDnY16Q1-s9qkxn62yXANt8rBz2ip2FsUSd1TA>
    <xmx:ERGtaVzKVIVlwVwM45CtivgG-ryZqIQfVqotwmi9OTbgwmBQsRGcaRje>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Mar 2026 01:02:57 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Wolfgang Faust <contrib-git@wolfgangfaust.com>,  Birger Skogeng Pedersen
 <birger.sp@gmail.com>,  Pratyush Yadav <me@yadavpratyush.com>,  Marc
 Branchaud <marcnarc@xiplink.com>,  git@vger.kernel.org
Subject: Re: [PATCH 0/4] run auto maintenance in git-gui
In-Reply-To: <40ccd060-e6f7-4130-a25e-3c2f65df8eb7@kdbg.org> (Johannes Sixt's
	message of "Sat, 7 Mar 2026 23:37:56 +0100")
References: <091e68fa-428d-48b0-bf7d-42b01660d6eb@app.fastmail.com>
	<e17f094f-f869-4cc9-b59c-091b7e61a021@kdbg.org>
	<xmqqms0jti24.fsf@gitster.g>
	<40ccd060-e6f7-4130-a25e-3c2f65df8eb7@kdbg.org>
Date: Sat, 07 Mar 2026 22:02:55 -0800
Message-ID: <xmqqikb6uacw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> The option does not only control whether or not a warning appears, but
> also whether garbage collection happens or not. When it is set to false,
> then in addition to squelching the warning, garbage collection does
> *not* happen.

Ah, OK, now what you said makes perfect sense.

> I think so, too. For this reason, my implied suggestion was to protect
> the new call of `git maintenance` with a check whether gui.gcwarning is
> enabled. Then we don't make anything worse for those who have it disabled.

Good.

Thanks.
