Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685BB17D2
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 05:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752644855; cv=none; b=O/QyIcIWol164MIjTxa3gdc+EtJ8RCFP2KQKc0sqWgYl8O4sGwAxg66tDqItklN3hnRA2u6snnYcs2S8VQbVEpNBz5ndtB+SXpOC8QXp5JPMnmskAGH1dP367bXPmcy3n+am6rayAMB2sFKLK6lUkwokWeF2ovB68bjrBb0c2Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752644855; c=relaxed/simple;
	bh=2Fzs5IIXLHX/NiSb8blmv+GKMrmzeyiyT64IxW50UIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=anqkWGxziR2ce94NP7jSQp5xJPpHc6JL0d9X1JkKmy4H8yjndkTzmDryQsbvIvrcjbNq/dMstqSQ8MVj775HTosq+pIU1ZbCoTwSkdzOZMSYAzQjcwPtjm9sK7rxJ3isHk6avBnzbeQCgIWoHozhXiLXhinInii79/yTmroOyAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ggC3mEuh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SvpOctwv; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ggC3mEuh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SvpOctwv"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 53FB8EC00C7;
	Wed, 16 Jul 2025 01:47:32 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 16 Jul 2025 01:47:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1752644852; x=1752731252; bh=AZ9VJvewkE
	N1fFjegfCZS31wdglXtdgo94WeYxz4jo8=; b=ggC3mEuhkVAqVEPdOuhFgAoffY
	Y3IKKkjMQCNRrsgu/ZbLhSuRHVOcSJ5NEitf/NlcuiPL52eWBehGZTIasLa8oIiO
	yxveaTEWG8n9Ig/CdAcgbje9dc4zzcTCjv8Ae8zZl9oGggZ1jtLpMevYYTxOu4zK
	539XwNWkAgqKRySk1Q0LA/M5C4AysFtJjsob4ep4fokQpoBQOA11Qh7z5CWWyyFY
	Or0Q/PtNk4fSruI8ii8V6uK0kI1tebYaBrq+/ExbVFkkAR1J0bAfeE0vLimBMaq/
	tYhYJ9MaxZOYEssrlIOwQ+3uY0JEjLliC8sY9kR/ceUAY32Tt46v5vEcj8lQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752644852; x=1752731252; bh=AZ9VJvewkEN1fFjegfCZS31wdglXtdgo94W
	eYxz4jo8=; b=SvpOctwvuVf9KvSye7JcNhIYqeBO2WDGISyVUPGC2Js/DVJT7YO
	ikQ7gI1oT/IvKrVYa8pin4FRppJoO4/i4sD4ke4De2/wi1oFar/NW/5kIsCvP3Zx
	GHrEPDrlOxUJqw+gF3kg6frM2PrKgglsggXHQ3daUmk/NF+xbcU3k9xPBKEE9AEB
	CGfI9n0Ol3rxmTkngnqwJ7vMSjgAYKv8WqvwmqB79Z80CDxX+UiSOb+H5ASz6W5/
	z1yR/830COExEsUN4wdq9LWjHFXksVSON7y7rSVAHXkUj8sf0TneanJjONF3x+zd
	IOQkxa1H6i//HIxQ7lhK15/crC5P7FBDT3Q==
X-ME-Sender: <xms:8zx3aHkLy3KxKCTDl7BgQ6FOqm967Y7qpNSJYe49MEVSQokw5KfTVw>
    <xme:8zx3aHxW22E9VVAM4SM8d6y7x2XZCMq91ebDYml-lz1l7wDQmu-KwS3SJoTCXp6Ix
    eXNtJuGbHy1GrC85g>
X-ME-Received: <xmr:8zx3aJRYUHEHoK5zbkcunMixF9xXImVJsUn4Ycrrk0LBBLzpySt5D2MLj6RjS0UCya8rzB3hi6gBYDVlcUOHp6JhLelcAu5e9tty7-fB6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehieeludcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehrvgguohhsthgvsehrvgguohhsthgvrdighiiipdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghp
    thhtohepmhgrrhhtihhnrdgrghhrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjh
    grtghosgdrkhgvlhhlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghl
    shestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepphhhihhllh
    hiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:8zx3aH89eZdBzTEZdblcaqZ3lowVjqPjjx4EDCGz24lZ-EPE682fZA>
    <xmx:8zx3aPtGqx-v4M2jiiKqvL2xKmwP2GY7S-lfrjbVdCHOQqryupvhmA>
    <xmx:8zx3aHML2vn6QYhxUM6BRpPCjiThsF74PyGyZF8xGHUnslnlDY8GtA>
    <xmx:8zx3aEgS2MIJPS3h8LBWy6EkUZYwqbsg1X67br6j-x0SG0GNAYpHjQ>
    <xmx:9Dx3aGq2g40Mf0YyA_TUcmGHa0q8ipjywg7czoKYKwAPVjOtAVmVSxrY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Jul 2025 01:47:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4a3e6878 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 16 Jul 2025 05:47:28 +0000 (UTC)
Date: Wed, 16 Jul 2025 07:47:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, redoste <redoste@redoste.xyz>,
	Jacob Keller <jacob.keller@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Subject: Re: [PATCH v2] SubmittingPatches: allow non-real name contributions
Message-ID: <aHc87TA7Jq9c4SW3@pks.im>
References: <20250706163009.335780-1-sandals@crustytoothpaste.net>
 <20250716002523.1392423-1-sandals@crustytoothpaste.net>
 <20250716044457.GA1395735@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716044457.GA1395735@coredump.intra.peff.net>

On Wed, Jul 16, 2025 at 12:44:57AM -0400, Jeff King wrote:
> On Wed, Jul 16, 2025 at 12:25:23AM +0000, brian m. carlson wrote:
> 
> > -Also notice that a real name is used in the `Signed-off-by` trailer. Please
> > -don't hide your real name.
> > +Please use a known identity in the `Signed-off-by` trailer, since we cannot
> > +accept anonymous contributions. It is common, but not required, to use some form
> > +of your real name. We realize that some contributors are not comfortable doing
> > +so or prefer to contribute under a pseudonym or preferred name and we can accept
> > +your patch either way, as long as the name and email you use are distinctive,
> > +identifying, and not misleading.
> > +
> > +The goal of this policy is to allow us to have sufficient information to contact
> > +you if questions arise about your contribution.
> 
> Thanks for updating. I think this reads very well, and you included all
> of the citations I asked for in the commit message. So this looks good
> to me!

Seconded, I'm also very much supportive of this change and like this
version. Thanks!

Patrick
