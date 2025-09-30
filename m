Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E67303C93
	for <git@vger.kernel.org>; Tue, 30 Sep 2025 13:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759239405; cv=none; b=VynyRRNjCdcsZGVDLJCtxSSfv2ntk0IyHULnz5spf0pejkXXub82Mc9offdsGpaq2kYTP4TJAyYRGqjV9Asjbd7WoQiQfCpGnk6JckSf5W2tFIxClVGZJPVwaTY9E9+w02Aie+70z9phi6yycE8lnHOxdaBrMa1sFWdP7NeyPNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759239405; c=relaxed/simple;
	bh=2hox59A4JNGIeUyTzVDF4SgZoMJ1PUnZfvZF9vrQV+s=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=LCB6O76SuxId9ty4w47/bpRdRzKo/3Otl08DB/zyjjt1dhLTgwHqVzZ32PzEeZ+ITbjygcPIILdrDL76WLhDa9HVquzqO4g9kODtYb+RSDGynxUE1xKm1ZEZwUfNMBjR3awGdDTApzhbk1pykdvfg9T/dDRg2x9Ms5yPxFNJ2JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=QeGpJgzl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nbG0lMr1; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="QeGpJgzl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nbG0lMr1"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7E16214000CB;
	Tue, 30 Sep 2025 09:36:42 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Tue, 30 Sep 2025 09:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759239402;
	 x=1759325802; bh=2hox59A4JNGIeUyTzVDF4SgZoMJ1PUnZfvZF9vrQV+s=; b=
	QeGpJgzldSFlCU55XkvnikfwT1hnTXh1ZCnnvimGWhrKs4sf8TkRpSO9t2n+3UEJ
	jL2mKEbLlyoOc8Wf7m+Q9oBwIq38g1Qd6fz43+mIwBmSKBr/k4FCuHa6iPcwxnzF
	22RI2GE4IcxDfeP8Ijz4jMw+YIw3l8Skxq23UCQxTKyYqjhZifqJdDrHQK6DtizP
	Iji01iWY9NAhu5Aja3KUHiLMyxTi6azkzP8GQWjDXkE8Ox0Tzcw6fpNBOZMSa/Dz
	IeU7ELBWNQ9OmHiZUAOsylqbs8cpSGJ13R3NAMoEGAqoqXYz6hM1r9yVlooNyqcM
	oww81fzDG2IT7D0sRJwrxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759239402; x=
	1759325802; bh=2hox59A4JNGIeUyTzVDF4SgZoMJ1PUnZfvZF9vrQV+s=; b=n
	bG0lMr1ujGRtdW3fqp/jidfiHCwai7DghqQ5UOgO+PB119ho2medrUCj9KEZIFuw
	ARlPhn2clTpE0SttpUfjhe7aR/dHqO1omCBn7vSuPPL8KRxJEjA0fp/HtmUUNRjN
	EpnDRr6mFpmAL+Y8JS2PD7mzZA4BpgaAo0yGouuYOargpGyLnDiWwUmGGRxUHU/J
	9C3Lh/x9RSDBrYlFE8He+sqQ+vi87FrtfkaqWw16hf7BhtNCTxxo6CssdrZu6xqP
	HwKA0vwPdyqJ4Kx0muFRa3JjA7MWQmZaRU9ZvQ8ioJm9WXi/P1MnA/MeTmfET22t
	MR83c+HDxMGVQ3XkapfeA==
X-ME-Sender: <xms:6dzbaFNERSyrIE5ViNKZESP577phKQ_4hWq1BBHX4O5ffjDcwdAQIpI>
    <xme:6dzbaCx98-aBlcIM3YYPpG_Ar2nvVLrh7dLBD7T5iAysI2wnbJauDTLF7GTsx73w5
    SF_0NlDXWrqWxyjh4321U5WwHapAEEOO9pscUiR-4uJ3xPM_iKfaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekuddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeegtdejieetgefh
    uedtuedttdeigfdvgeetkedtuedtudfgkeeluefgleetffejffenucevlhhushhtvghruf
    hiiigvpeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepuddvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegrughrihgrnhdrrhgrthhiuhestgholhhl
    rggsohhrrgdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtg
    homhdprhgtphhtthhopehjrhhnihgvuggvrhesghhmrghilhdrtghomhdprhgtphhtthho
    pegsmhifihhllhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepvghmihhlhihshhgrfh
    hfvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopehruggrmhgriihiohesghhoohhg
    lhgvrdgtohhmpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprh
    gtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepphhssehpkhhsrdhi
    mh
X-ME-Proxy: <xmx:6tzbaOyLzcBHl4AxBITgKXg5St3iRyamhzdN4iPtEQXU8k8ev2gykQ>
    <xmx:6tzbaL3YeJtKbr2JiN6LcJiZUnbhg282lnqupfGQQa94uNMeLO-g1Q>
    <xmx:6tzbaPms9L90OinwapXBx-B3-QnxU1EWsYi8uDAKExwRJwbujKWlrw>
    <xmx:6tzbaK8tIB0h4EGMWdbRKVd11BeyEZupvTzlnyvLXdzN7dYoxxjD7g>
    <xmx:6tzbaJhtgDixjiZYV-huE1TCmIKVGK82MQzswT9JTEg97rAssJKZg7_P>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DE23C1EA0068; Tue, 30 Sep 2025 09:36:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A5U96pOjIZkV
Date: Tue, 30 Sep 2025 15:36:21 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Adrian Ratiu" <adrian.ratiu@collabora.com>, git@vger.kernel.org
Cc: "Emily Shaffer" <emilyshaffer@google.com>,
 "Rodrigo Damazio Bovendorp" <rdamazio@google.com>,
 "Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>,
 "Aaron Schrab" <aaron@schrab.com>, "Jonathan Nieder" <jrnieder@gmail.com>,
 "Patrick Steinhardt" <ps@pks.im>, "Josh Steadmon" <steadmon@google.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Brandon Williams" <bmwill@google.com>
Message-Id: <03d3cd99-b319-4e9f-8ad8-2c1174efea28@app.fastmail.com>
In-Reply-To: <20250908140117.262205-7-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20250908140117.262205-1-adrian.ratiu@collabora.com>
 <20250908140117.262205-7-adrian.ratiu@collabora.com>
Subject: Re: [PATCH v2 06/10] submodule: encode gitdir paths to avoid conflicts
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Sep 8, 2025, at 16:01, Adrian Ratiu wrote:
> Based on previous work by Brandon & all [1].
>
> This encodes submodule gitdir names to avoid colisions like nested gitdirs

s/colisions/collisions/

> due to names like "foo" and "foo/bar".
>
> A custom encoding can become unnecesarily complex, while url-encoding is

s/unnecesarily/unnecessarily/

> relatively well-known, however it needs some extending to support case
> insensitive filesystems and quirks like Windows reserving "COM1" names.
> Hence why I opted to encode A as _a, B as _b and so on.
>
>[snip]
