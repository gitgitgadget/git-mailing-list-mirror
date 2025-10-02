Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46471221555
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 15:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759419163; cv=none; b=gNdzXU84jAfoAo4svUv1kw5Hd8XUDhTBLSyiQuuy7snfxH4m2XXM17j2ZjUuJSkiegdhIvZyZVjKjzyLYQV7xN3IjO6EAtYmr98Tv44LF7KksTEXjsgr9weDKNgNkVaenyv8KdOiGtH9JGp/VIyttAxGqM/24+2UFOSrsFPDjiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759419163; c=relaxed/simple;
	bh=ROq9LwF9GNcq85+TrPf1Gvkn+9Fy+bgcM7fZQatHPpQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FtfF9HB6Tfm1tCl1Lf3Ri7hBw+yTpAqSFqGmOgR5I9TvjCU+yLNUZYSdf6MgHaCj+n/2iy25AGl2hE9AVhSeBbZajBnY00ag2wPauDHg9gb6aER8ByRR7zV7KveCTFMljXR0cVtrMNYfKmqXnaHPj2QIESXAEBFI1OfQ+Ec4WE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eWWGp3LA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EcgFqtmX; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eWWGp3LA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EcgFqtmX"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 68C421D00082;
	Thu,  2 Oct 2025 11:32:40 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 02 Oct 2025 11:32:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759419160; x=1759505560; bh=AlxMEL5qD5
	d/UHcPG6uI2yOTOTMVIUMxS3sOk/lt9jE=; b=eWWGp3LAWcjWtGieIFJI4RTdWM
	mEKpE3aP8bfk/ZVH/1jhbLSECY97yS7T8UUMQZWODQUiDf7HmK83fCM33UBk6/1R
	HcGOGyoEKYA98YPs7xrC3xcQftMWj8XKYmP1b6EDQvscWFtwQLXldcpdYFAPh+fW
	zifNrf8wThOxfZboD2LvWP47Fk0XBQ5SFJiNXBYOiPWoWPmH0ywLe+J+MMuz1mWz
	xXqP+GATOX8YOCBzY8wUzYm3nTGPrRWYkxzEJeYqS+K7aExU/RiDxT2EWxORvUyl
	B+bQL1OUOM87JiwmQ5U2eMC6PtUwnfLyvof+p0IWLM2797hRsmvIoGbXoGFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759419160; x=1759505560; bh=AlxMEL5qD5d/UHcPG6uI2yOTOTMVIUMxS3s
	Ok/lt9jE=; b=EcgFqtmX5XlhQBNJDZpIGPDzbnw6YA+nyKasGfdfBx7y7x4wxwp
	0bWLHkd0tuSFTnaFSSFoigYWZGIhyY1xYu2CMnCXtxlKrLkTbUBbdYhF/NCINAFn
	oqUh7g4nu6EhLy4rINeRr+A7s0rJa2MzLqBVD6VUXMHS0CbLFiPAfkeZ8yZKqdv+
	TFQ9wDjH/BzrUfwQZymFgIoNEMPLM8cJPcgzq07JvOCi4uI2vGc6DGdmG+WBA6aY
	BZ/12R2kBLOT4oP67hvlKDdgaKbPg3fQIE0e3ynI0BLba76r7ClWtpmQU88lIxLB
	w7PZxj5MTaojHJdW+APlByX58UEra46fCTg==
X-ME-Sender: <xms:F5veaEIk1mdcHdDcMs0CXlF1EEizshJlWKjR4Wd4S89HnnlAMm-PXA>
    <xme:F5veaLCixV4gMWfqAaxH85I_xhumkSqy4_dlxEEV7DM3ML_Fixfc4k3uEGfJHcFiQ
    FKXoFeCnCHThyH7kse44_Fe6Q0XkAAp4_5jqLDFObI6QtVUqaOLZA>
X-ME-Received: <xmr:F5veaND3oifj3Y3BzdqPvvldEZ2hFFScE0yr8JniXu7MWNnviEp0DNoouh5A4WygMFUvIEl8f1cZsijjBBuJj9sTuBeAadOj4NXm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekieeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepmhgvsehtth
    grhihlohhrrhdrtghomhdprhgtphhtthhopehluhgtrgdrmhhilhgrnhgvshhiohesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:GJveaNCNaaQ7x-Jh_SCLDXs8-THjcEESrnbmmwle-JkFhK28cBAo8Q>
    <xmx:GJveaIr-LycerXGO7J8namtRO61NWZPihSpoYDHN1ZFpOaDUaOe0pg>
    <xmx:GJveaHm2UyVzlfnBqeUx48gCfPO-0XMDYFHWwgvhq15ctkubNe9P7w>
    <xmx:GJveaIyvWpYAhfaeiN6SPXHI-HbI50gmCZJNnKm7cT5tcX04Yt_lYg>
    <xmx:GJveaJbFpFcTek9G8jPAFTUsgA8E00nv0Ybtvg0B5KLU2mmUFYPhYtly>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Oct 2025 11:32:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Taylor Blau <me@ttaylorr.com>,  Luca Milanesio
 <luca.milanesio@gmail.com>,  git@vger.kernel.org
Subject: Re: When should we release Git 3.0?
In-Reply-To: <aN5-n_ArhQqaQZgt@pks.im> (Patrick Steinhardt's message of "Thu,
	2 Oct 2025 15:31:11 +0200")
References: <aNxivuJEnSHbQNdr@fruit.crustytoothpaste.net>
	<E03F997F-1738-4CF6-B7D5-206183FA5BD1@gmail.com>
	<aN1RFvz7uGPnepxe@nand.local> <aN5-n_ArhQqaQZgt@pks.im>
Date: Thu, 02 Oct 2025 08:32:38 -0700
Message-ID: <xmqqfrc1xqsp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Once we have roadmaps, we should set a strict deadline that takes them
> into account. Any hosting provider or implementation of Git that doesn't
> provide a roadmap will not be taken into account in our planning.

Works fine as long as we assume everybody that matters will
eventually want to move away from SHA-1.

 - If a stakeholder gives a roadmap that has no SHA-256 in their
   future, in other words, if they are content to serve only the
   SHA-1 projects, what's the impact to them?  We are not dropping
   the support for SHA-1 in the sense that if you clone from an
   existing SHA-1 repository you'll get an SHA-1 repository and you
   can push and fetch between them just fine, so presumably that is
   fine as well.

 - If a stakeholder gives a roadmap with SHA-256 so far into the
   future that we cannot wait, what's the impact to them?  Their
   customers that want SHA-256 earlier than they can supply could
   move to other hosting or implementation, but not really.  Both
   hosting providers and Git implementations have components that
   are move than Git that are hard to migrate, like issue trackers,
   CI services, workflow tools, etc., that make their customers
   captive audience [*].

 - If a stakeholder has a roadmap with SHA-256 in line with our
   timeframe, do we still need to assess the impact to them, or as
   long as we and they work hard to stick to the plan, we all will
   be happy?

> We should of course actively reach out to the projects that we're aware
> of so that they have a chance to provide such a roadmap in the first
> place.


[Footnote]

 * Issue trackers and review logs that are federated, possibly using
   Git database for storage and transfer, may allow projects and
   users to freely roam across hosting sites, but there is no strong
   incentive for the hosting sites to fund such an effort X-<.
