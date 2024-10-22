Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6FF199938
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 12:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729599004; cv=none; b=MG2VaZqBrW/+pSlQ12oNv6aVIArKT3524jJVVo511FSCl3Z/VxVNZRTNW5Q7X9+uEwq8kaBrSn4Qpll35xasaJrrCUPnH5czAJTV6nx6vtM3wb9RNHDfpyMKQKkSzdOp1LaKpjN3qM999gMwxCE5FoH+HTx0OkC5/qdMU+WHyTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729599004; c=relaxed/simple;
	bh=nwEXADnkFnrynafa5meWkZS9WXtqMfxdfQDGJLiymss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDYkGJLj5NHL53iAGYo8uLYHJyfNSvEsiBB5qllpjAzejQIe6qmW8wLVFM7u7/u2RBJ3fFasqdW6QWqtIk6KpQBLehgLhXbN9qxpWcRDy50cR+83wFS2/cZ7fsg4A6RUgEiatkE1f/maDd8rrAhmVfe+7aBwNH8xPtDI1jgfYTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dQNXTdNl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JjXhlYgL; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dQNXTdNl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JjXhlYgL"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id A859D13801E5;
	Tue, 22 Oct 2024 08:10:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 22 Oct 2024 08:10:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729599000; x=1729685400; bh=kcRTvEStnU
	c3dwHSRI6bwcYuF1s6rAj4iIFjBq6cxOg=; b=dQNXTdNlq8X8MMTEQfxCjnJfWC
	eIegwnHnC2rmSnToCuHjCCzUlaXNMBkxN/r0f6z9OSrJaWZOAQK3H/jRLjREQtt+
	VTMPmU0pV2zH0Nm6sYMQyQoiCpsIrRBEz/I/gpP/vjOQuNEtI35jh+qBSzjY4e39
	VeAWgo/wXwMHyeQ6M9HP8pjEQ5A8iTfEtdwH5aFIQkJl4LIhJRdhWvOkaH51qi9E
	9AQOR4e7GjeSydaj3P2U2HXHn9lSaLkrtM9Hpo1bDwuL2jrCceiFjdADzmLDphfg
	oHxnM/0YQT5lCOpXFiAzXIdM34LZj2CtfKsMg3YVXvj07JWfgbMgqMD2tL6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729599000; x=1729685400; bh=kcRTvEStnUc3dwHSRI6bwcYuF1s6
	rAj4iIFjBq6cxOg=; b=JjXhlYgLcsdaQ65V73w32rSZRka5zW5qbtGHmSqLQabt
	ocaDxIpnKi4dvOa9fOCBE7F5Vl/q++HSy1CZfO0rFUk1c6DQqqHdkxHQNjwhDRKO
	AKHHr937dW3it0Bk6Omy+30ae8Jhzo0uqwQIJmvowHQDg03qY/mZ3aBnv6gipdYA
	E/nhbxq8rzcOCSqx69uaIQAGhfDaNHsDfsEXym2/mkaegoG/rb5//P10CiEu4Znh
	YGonCaXiXS5YgzyzWh+kIOOYiRLvM/667XgA0hhh8jpzNvfnHhR043uGoYLJPXDP
	NXIBCXG1HtJZ2bBQ8J/PDFfxOnngSp45zQo0E/rAFw==
X-ME-Sender: <xms:GJYXZ5mbEjbYgU8dojBmJ-hQeX0H3Xe3yTfttEmBkvTg3u3JB1Qlnw>
    <xme:GJYXZ03SuSSonm9ACHjW-AcRTgb8FrokajpoeGqrvQnkiLo-1PLAjoGts4no-pMr7
    89sm76iWwVSDc5xFA>
X-ME-Received: <xmr:GJYXZ_oQbDJIS3K9bNgw2cmwzzGsPs5YGuvTJY09O3EZ8ZMbu0uKIG6S7Mvr-xa1mC4U1uAaVJzQoKMOJ4OSn7Sg22uI7W5urwvNJGsYSEhq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeihedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegoufhushhpvggtthffohhmrghinhculdegledmnecujfgurhep
    fffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomheprfgrthhrihgtkhcuuf
    htvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepuddv
    ffetvedvgedvheejhfdtveeiffeihfelhfefjeehveegtdeludejffdvffelnecuffhomh
    grihhnpehgihhthhhusgdrihhonecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomh
    dprhgtphhtthhopehushhmrghnrghkihhnhigvmhhivddtvdesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:GJYXZ5lCn0bwjCMSI0P9upZMNVk01qfP_OMjCCO6U5tLrEYpUZM_Eg>
    <xmx:GJYXZ32V9HaMQooutnkb9SMLPI5G6j19lrCjH2BDWBmOvIC6CPvAFw>
    <xmx:GJYXZ4uQlBpdkocJGVfAIV0IBRxNwFioNSI3zdNi4i8r1y3YsFJblg>
    <xmx:GJYXZ7X-3wcs8evdq1XzXd68CFD6FjkoDRKzTIGwExp8bko7z7WOdQ>
    <xmx:GJYXZ4xcrNHKgfx_ltRSbabJiCW8qHZdrJXqYj8DoHMnEhK__tdALwba>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Oct 2024 08:09:59 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 56a1b75b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 22 Oct 2024 12:08:27 +0000 (UTC)
Date: Tue, 22 Oct 2024 14:09:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [Outreachy][RFC]: Final Applications expectations.
Message-ID: <ZxeWDTFHpHmVePdF@pks.im>
References: <CAPSxiM-kf8U=vzp5MoD3tUuOtnNjcCgPhLdriyeQo5CGf=EhyQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPSxiM-kf8U=vzp5MoD3tUuOtnNjcCgPhLdriyeQo5CGf=EhyQ@mail.gmail.com>

On Tue, Oct 22, 2024 at 11:45:14AM +0000, Usman Akinyemi wrote:
> Hello,
> 
> I hope you're doing well. As the deadline for the final Outreachy
> application is approaching (Oct 29), I had a few questions regarding
> submitting the final application, specifically for Git projects:
> 
> Is there a specific way we should record our contributions? For
> example, should we include a link to the public mailing list
> discussion of a patch?

Yes. In order to make it as easy as possible for us mentors I'd suggest
to provide a link to every patch series you have sent to the mailing
list in the context of Outreachy. It would also help us if you included
the current status, e.g. whether it has been merged to `master` or
`next`, as well as the commit ID with which things have been merged.

> Are there any community-specific questions or expectations we should
> be aware of?

We outline the details that should be included in your application at
[1]. The most important things are:

  - Your self-presentation.

  - An explanation of the project you want to tackle as well as a
    rough timeline of how you want to tackle it.

  - Links to the microprojects / other projects you have done during the
    initial Outreachy phase.

It is encouraged that you send the proposal/application to the Git
mailing list so that we can provide feedback on it, which also allows
you to iterate on it before the deadline. You can search our mailing
list for examples -- most of the recent proposals in the context of GSoC
for example had a "[GSOC][PROPOSAL]" tag.

[1]: https://git.github.io/General-Application-Information/

> How should we go about detailing the project timeline in our application?

We only expect a very rough timeline here. It should give you enough
ramp-up time to learn about the code area you'll be working in and then
give a rough idea for how things will be progressing. I'd recommend to
not be overeager -- it is fine if things take time, and Git is not the
fastest-moving project. Also, account for the time it will take you to
get knowledgeable in the area.

Of course, that timeline isn't binding at all. It rather serves as a
demonstration to us that you understand the project and what subtasks it
can be split into.

> Is there anything specific that mentors are looking for in the final
> application that we should take note of?

It would be nice if you mentioned anything that could conflict with the
internship up front. This includes things like you picking up a new job
during the internship, which may limit the time you have available to
work on projects.

Anything else should be mentioned in the link provided above, I guess.

> Thank you for your time and guidance!

Thanks, and please let me know in case you have further questions!

Patrick
