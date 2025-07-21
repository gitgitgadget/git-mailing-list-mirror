Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576BB2D8798
	for <git@vger.kernel.org>; Mon, 21 Jul 2025 13:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753103354; cv=none; b=rKAGZ0IPSAQosc/NwKo6jus5WRKZgISmcsHRLRS/TvYo40tsznqOyYqpEX7FlIc8Lpl3xi5ClTK3H/WnwV7s/kpOvK2bRnqlzC9UCVQkdsbwdQm/W7kNhaXpBunTGzB5YlOncfyEPbJqESDt88w3uJANfJ3t3PUXyrHYgezyqGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753103354; c=relaxed/simple;
	bh=SlsWfcTyhZSmDOAngyQkZAmlfo1SXBp1f5lBz0clb24=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=JsQy9ZOxlegFvV7ET+pPILcbmnX7ew64FP+Fji8rwGvgjhOkg+9ixXyYRlOX0eYD1Aw36p2mHovJta1/Yfbn1Wntj9BCBUn55VbPpU0Czs90rmr4vmDYcMv1BHc/sp6D2sFwCLxb5O+bGUkd0iFtPYpF+Pt1SQz90kdkvVt86A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=EyGXHZcZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qsbf5zUt; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="EyGXHZcZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qsbf5zUt"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 60C9D7A0191;
	Mon, 21 Jul 2025 09:09:10 -0400 (EDT)
Received: from phl-imap-14 ([10.202.2.87])
  by phl-compute-09.internal (MEProxy); Mon, 21 Jul 2025 09:09:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753103350;
	 x=1753189750; bh=VmVLEw6CiIUJD/9x/LNNFCEy/C8Tamqs7R4wM8YYz+Y=; b=
	EyGXHZcZzAo8zz+z4WCd+6Gh+hheTwM0dIOaLIsAhlWuzLtTuSu2Q2xSJp0kNKSq
	68r1p+bjXOSVdEV+CxurrCLzyUOR5lawjW7Yod0rHRC9qanmo0iVt8CCTOOCxdbG
	qaW5tdMV47IUvox0Vspn9JO/NO2uU9DNTNkhFJPllNO9TWrZwTFfRILsqs+py9HJ
	8p43rDVKmM5im02ntv9nfFjCcVeL0UgGztD21IwhiOI3r6JI+dmszNGqVb61hdP/
	jFlzfBFJgxSCcZLs/CrEKG3vRJ788dCPkXR3CfBnJlLx6Yeld4bgFPGYj+uvFAUM
	AF2J+o6FGUaWy8EuY0Chng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753103350; x=
	1753189750; bh=VmVLEw6CiIUJD/9x/LNNFCEy/C8Tamqs7R4wM8YYz+Y=; b=Q
	sbf5zUtHHbZJGaTpV/TGlT/msM6xwgCA5HjVG75NzEWM6Td1/VgHFoMQCIa9O70f
	vWP0Yw/CJKSn1t73WRjWTt/+KWD+6RtuD4AxktkTriSPThNZeSyIgfVEe2nJsEaq
	oS5cUeLb8RVLuvqc5EcWv+TyRaTbOgbtW6Yot8UlpLvp830yeThufeNC8LUrZDto
	9DhKZweIfpRIIW8HbWPEm/Zjl5+d4EqF5MMwtRhMf5RjsYqISP7yDpMkMFeWYFhh
	gIOMKv4SREx5uibVJxx3f0tBu6E/bWtj6++FMZ5Cfcmsdwg6+TbAiyCGwfkUBWPW
	aEh1GOTnWzlbbYJShNcSQ==
X-ME-Sender: <xms:9Tt-aFo5X8u7yOONAd0oiUxKuC1xuDvdqCVZwaQgKurrclc-oWmDdR0>
    <xme:9Tt-aHpjAFiAwXqGiHNWZltiecFy69FIJRyeRDky57b7fSBI13uJkarqkZCXye3FT
    cZUp2jQSy9sv8cdWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejvdduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeehudfgvefgfefg
    ffdvhfffvdevveegheehudetvdfgueffjeevjedugeevfedvfeenucffohhmrghinhepkh
    gvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheprhhhrghnnhgvkhgvnh
    esphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:9jt-aEzOXcJWr8bYxYTmGa5CwpoxlR4rgIze6zCAvdXqKlhoFTyGww>
    <xmx:9jt-aPKZuokay-aOdFUQok4eZewQE6Kb-egtGXRlit3bJJfmLTNRiA>
    <xmx:9jt-aDR5bBz6K9ShZfiKiK9CY_lA0PahbSYoxDgqY9lIlx8u8rdicw>
    <xmx:9jt-aPpc19BJNrhQFXT6bX6pfkA9oniaF64bnA7WYXSq44bvlgnPpA>
    <xmx:9jt-aB4cara1km4a303F0N_3RCjRBROkzuKYoU9JmYk1vWfXyZkjtIu0>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E5962186006D; Mon, 21 Jul 2025 09:09:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tdee25935f5dc9665
Date: Mon, 21 Jul 2025 15:08:49 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Russell Hanneken" <rhanneken@pobox.com>,
 "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org
Message-Id: <2f8ed9f4-5aff-486a-90c2-dce7f7116ae9@app.fastmail.com>
In-Reply-To: <DB8RSNI6D2D8.2OCZSLRSIFP55@pobox.com>
References: <20250708024507.62386-1-rhanneken@pobox.com>
 <20250708024507.62386-2-rhanneken@pobox.com> <xmqqikk3xog6.fsf@gitster.g>
 <DB8RSNI6D2D8.2OCZSLRSIFP55@pobox.com>
Subject: Re: [PATCH 1/1] doc: correct doc for glob pathspec
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025, at 01:39, Russell Hanneken wrote:
> On Tue Jul 8, 2025 at 1:05 AM EDT, Junio C Hamano wrote:
>>
>> Will queue.  Thanks.
>
> Was there something wrong with my patch? I haven't seen my change appe=
ar
> in the repository.

See [here], `rh/doc-glob-pathspec-fix`.  It=E2=80=99s currently on the `=
next`
branch and will be merged to `master` next.

[here]: https://lore.kernel.org/git/xmqqo6ti49fk.fsf@gitster.g/
