Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1E523C503
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 01:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765848010; cv=none; b=CrGUcynaF/z+Ki/J/sHEKsZ98tV0E5wYE1KohuP09MC4EGhjcomhhodo8VBLZLx/Q+M2juggByp9ISiUOpL8pMidxbZ/R1WYqXu6SvQTapsKDZVhukHPNSdZMmMUEsI+v/yDtd4No8Avyb83MIo/vAlPBbvYCBmPPv/5eJoZoNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765848010; c=relaxed/simple;
	bh=QPZqQ6pQxG/uh45R7u623hA8JUAPYet+3B3rGR5Usgo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DPN1UEMWKvGXjptqxqUshvFAjo/V/13LkQ6McwpN+moXOLxJ7I0P/MVPdjgpnY8YHN7SLmRDgMYf1wC88Od6wfbBN80VuoAHjrfVWVsq1kW2ifyY5xRYmK3GgQV8fBp46IiH3vSmFTQMnwLqfCaYEtOxh9I62jz6cjNm3fdebVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Lobw/l5m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gStEgYX8; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Lobw/l5m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gStEgYX8"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CD3557A0183;
	Mon, 15 Dec 2025 20:20:06 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 15 Dec 2025 20:20:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765848006; x=1765934406; bh=64byxyMi33
	6KnjCy+FV6muXEQfXyOxSaI988A3YUNbM=; b=Lobw/l5m+FG7B2ismjYsR7R3Xc
	C9EY1YIjOl7WXEhpRGMqWpvX/iS1FyHafHNvwTkc0955g7V3mcvvOFfz0NXt4dR3
	QQJwzEeYlK2TROX6ZtJMZX7Tzy3C3mg+EiaRZoyPHdAU2WmiUDfSGaF3bB9ImoRT
	2d4nw7xevHLAxemUoL3xXcTvkkJ3DYL5k6xf97O0QMddmXJNjRIAT5jmInqCxXU+
	Ds/xTx6o90k1wI+ULs+6hisx0MCMBPduSdi4hc9tEL3jP9EqGBCuHcXYYFTKrnfa
	POBB7GpGuBliE80/p6QHmWZldxIECZwXnvBwy4Z1g85q53NopK47+11ZLhtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765848006; x=1765934406; bh=64byxyMi336KnjCy+FV6muXEQfXyOxSaI98
	8A3YUNbM=; b=gStEgYX8t+LWXwP1wosOBxV+2GazkYH3t26nNb1zIXQWVz5cyN4
	iUQiX4ocVatd00ZtNlJgFSQovQxIquKUIZDPyA978wybRcfg5yn1nrSfF68tg+Jm
	DNuw+znyu7igfNz3zr7DEn1k370KlHWB8f/cAZzVmwLZPDFYmCQ6shnjHlxlfWL0
	wa0viYKriW+usT7ZBoUutHoIBdPjSU5SEFzN7IFpz/AyxbwormuRbXXiG/GzVbfy
	6MIhnojbh2OKA5eY5R4TLHCPSVLXGMRT9pYGT7Kx4qnRFEqYGLR2ZI80QN/YmXHa
	2nNicxTo9yEmn0EFB9MaUP6jbRJM4mNXNyQ==
X-ME-Sender: <xms:xrNAaarL2wAKHaZ-QK2VOlym8kNu4TwOsfWTj5_3Wwg9AundPVu7HA>
    <xme:xrNAafhZdR73q2Atr6MeS5jRjt0TLWQ4MX0gFi1MFWB5L4NzuHefxuZKkvMmnTHsq
    EwSgoOvCalQuWnDPBkQBXemLUXPncmQ8YN3VaBkpc-qy-ehAhQ1WA>
X-ME-Received: <xmr:xrNAaXixfgpb8pYTcWISyOlgwAl-qdPRyx1-70kTa3S3iVpMMo9O8WRCGHqZcPiyZyaaQ9UPUZdubRMke18PEarJVfSly-xJ8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefkeefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrsh
    htvgdrnhgvthdprhgtphhtthhopegtrghrvghnrghssehgmhgrihhlrdgtohhmpdhrtghp
    thhtoheplhhishhtsheshhgrlhhlvghrqdgsvghrlhhinhdruggvpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:xrNAaViKpHvZg6woRsD_YG8k96aNjIai-gn9LYrhga_8ZPQqSdt2LA>
    <xmx:xrNAaXK0j4eeVBGicFWvw6U0s5Zp2TZOmLOif6594C1l5HqGhTv59A>
    <xmx:xrNAaUGaYg0a5Wk7IqcvqDF3F99ZHysO7cmrRsQKpliU0VnosicktQ>
    <xmx:xrNAabRbtzE4swDsWq4Q3I76IB6hSosC7buyf9lgENllSD3hxpGdWw>
    <xmx:xrNAac_UpqcO1m6Ph7pCDtyWaWT7zy3FAqjkO-hNjNKapaGhULL0pOzm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Dec 2025 20:20:05 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,  Stefan
 Haller
 <lists@haller-berlin.de>,  Git <git@vger.kernel.org>
Subject: Re: Would it make sense to add a commit.signOff config?
In-Reply-To: <aUCLz1wTOwilflAD@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Mon, 15 Dec 2025 22:29:35 +0000")
References: <86c5d40d-5a06-4a69-90d8-a737685b0536@haller-berlin.de>
	<aT7lkXl65-TBIsRS@Carlos-MacBook-Air.local>
	<xmqqsedc8w7k.fsf@gitster.g>
	<aT9iu9He3yJ3npWX@fruit.crustytoothpaste.net>
	<xmqqldj48pyl.fsf@gitster.g>
	<aUCLz1wTOwilflAD@fruit.crustytoothpaste.net>
Date: Tue, 16 Dec 2025 10:20:04 +0900
Message-ID: <xmqqike75ikb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2025-12-15 at 01:59:46, Junio C Hamano wrote:
>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>> 
>> > I think this would be a fine approach or we could add an entry in the
>> > Git FAQ (or both).  I agree that this is something that comes up
>> > frequently and writing it down in a more visible way would be kinder to
>> > users and mailing list participants.
>> 
>> Something like this, then?
>
> Yup, that looks good to me.

Thanks.
