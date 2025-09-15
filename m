Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300CA2FF144
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 11:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757936491; cv=none; b=ktyvZcIYOle1fbzX3RqEKyAcyMx8e7h8uDIY5CpESZ5YFyD4fs8lVN8kPp1kTigRJQAzaopIpgeoreoHEuYSFn9/C6rsYFJHATXu0FwYNAGRLWs+qWTy4tw0kiLktwpjiOJMvCU3niPTXZPxv3TUfn2fg61GByw8J1++vNSuQsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757936491; c=relaxed/simple;
	bh=xTglWyodVnzbAGVHBFkCiS8GOd/AxrkJvIqxsvzqA+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XU1qbo7LBuqynZg/ZnM6URXfbq+Y9tUwGEnB5f1ayQuMZKxgxlolZ0nNMmxbUusOxUdkt3KkilBP4tREd86lroWhq067URmp6ZKWbn5qKPc4XZ284m9YYvfKHAjSq+KRzsgpLl2Zle8yIseQqvyvTet4O5ALl8MVbR6zNGciBIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BnXjXeUa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CS37Kdqc; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BnXjXeUa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CS37Kdqc"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 60655EC021E;
	Mon, 15 Sep 2025 07:41:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 15 Sep 2025 07:41:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757936489;
	 x=1758022889; bh=DAnd7T+15w4OYeS2EboH5sbzeNPbwGR8oLm6GwqckCk=; b=
	BnXjXeUakZUbqOF81ef8FbCUl79R3GxjbC2glbfl6ckfBQk12XcjCLaoITzUVWEf
	BXWrviu3ZDyS+SJOkXyRwdI6c2NohHY27a8wz5Nt6buG8InHIrNlMjdOWPDFlbta
	F39YOPjgnpMNNgjnZ5VG7zg7TlPl0LRevlhw6NFkJfKh7WBTS4acV9Q+a7u8OBsk
	cOxgLFI/Xe550oVqBsx3bR5VscUfi7YT5BstWBM1UktsKX1JBFZtXXglEj1J/Kvc
	DAYt0UeXxxXpCSSaIHNnxwDL1OMICF74P6ofE8NEXhozT+1Utb/14RmulTKZ8g6i
	i6kPZ8aErILeslCojPnjfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757936489; x=
	1758022889; bh=DAnd7T+15w4OYeS2EboH5sbzeNPbwGR8oLm6GwqckCk=; b=C
	S37Kdqck5S4o5iNT4YLY32dPmpO6JnMojfAUad3Y+Bn4qThDUhO3dXvhvbQtmXFV
	XKNs71hyITp7zuR+oT+DfKoCNAl4X/IoGgEoCMComIV5OgaUb9Syd1PwGo0bJGeg
	CgdHBnqTZL3FiQaLXgcE6pVIn3/moKmphNhZQTGMZYpy5ipG45d8ql21XKBWtBMg
	Dd3clN4c5wiPMNtbO7lozJLLcaWUtkUdVJ/2QE+7yUA9IoXTfumom1OswaHeXqps
	C9fI09y/4tbm/OgVEMZ0XjNy6jmPYQdMT4yv5QFcXZFrYewMbZCXKCuuLL5qiKK2
	NsGWUpdjDVPiQOTIerUxg==
X-ME-Sender: <xms:afvHaAf2FtU8fNhPheeIhBuNGle3NiagV0CLxT39_V3rFqjK617gyQ>
    <xme:afvHaMwYL6pYQHwqEzAtnayUxhe7g6XN3811P0KuVX6NcMhQ1bep-B8B-mlyMyZRL
    qCJD4izGhYkov6Tig>
X-ME-Received: <xmr:afvHaOHkhGPl_oxORXXMq6Lqrz8RKr3N0DzXdnwZAnPqUL7u-WXV5Geizi6jf1mDcsqm6_vCH4SJqPBVYRIhxbJQ_G6GVu-QaBOLP7ue-sfbpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjeeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epudfhfeejkeffudfgvdeileegudeutedvffegieetgffftedttefhvedvteefgfefnecu
    ffhomhgrihhnpeifihhkihhpvgguihgrrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthht
    ohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshiivgguvghrrdguvghvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghk
    khesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:afvHaIzP5I_MPFbWoensIqAEffqcHOzNtNVRImfjsbdHc7-fp0ylkA>
    <xmx:afvHaHt0iuJwHxhtOQ5kJvoLvbo9ZGAgGY7OyO3iHta6b4W-bJm71Q>
    <xmx:afvHaN0t6Wyn9pOowU0k9KxmXsNUP6JWR0gz1PZYghaBrEMx4yUaXA>
    <xmx:afvHaK_7ZefVAIIsPdiij-GFOtA5Mxdtn5Vh5kXj8A6HKohUKZGDwQ>
    <xmx:afvHaOuVjYNTdHDUhva4b7pi1NYKflE9PHsEpX_tnuGpKJWJX3Ce8NES>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 07:41:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ee97e212 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 15 Sep 2025 11:41:27 +0000 (UTC)
Date: Mon, 15 Sep 2025 13:41:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] builtin/config: special-case retrieving colors
 without a key
Message-ID: <aMf7ZCtK1vr9Djo7@pks.im>
References: <20250911-pks-config-color-v1-0-3a7c79df65b1@pks.im>
 <20250911-pks-config-color-v1-4-3a7c79df65b1@pks.im>
 <365d19ca-0a61-44f1-ab31-7e87f47d55e6@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <365d19ca-0a61-44f1-ab31-7e87f47d55e6@app.fastmail.com>

On Thu, Sep 11, 2025 at 06:48:45PM +0200, Kristoffer Haugsbakk wrote:
> On Thu, Sep 11, 2025, at 15:24, Patrick Steinhardt wrote:
> > This use case is really quite specific to parsing colors, as it wouldn't
> 
> s/use case/use-case/

I used to say "usecase", but eventually got corrected by one of our
technical writers at GitLab that this is "use case". Wikipedia seems to
agree [1].

[1]: https://en.wikipedia.org/wiki/Use_case

> > make sense to give git-config(1) a default value and an empty config key
> > only to return that default value unmodified. But with `--type=color` we
> > don't return the value directly, but we instead parse the value into an
> > ANSI escape sequence.
> 
> Two “but”?  Maybe
> 
>     But with `--type=color` we don't return the value directly; we
>     instead parse the value into an ANSI escape sequence.

That reads nicer, yup.

> > As such, we can easily special-case this one use case: if the provided
> > config key is empty, the user is asking for a color code and the user
> > has provided a value, then we call `get_color()` directly. Do so to
> > make the documented command work as expected.
> 
> In my opinion this is more difficult to read without an Oxford comma.
> A bullet list could break up the serial comma and the comma used to
> separate the “then” subclause.
> 
>     use-case:
> 
>     - if the provided config key is empty;
> 
>     - the user is asking for a color code; and
> 
>     - the user has provided a value,
> 
>     then we ...
> 
> In any case: I think a colon generally means that semicolon will be used
> instead of serial comma.

Yup, good suggestion.

Patrick
