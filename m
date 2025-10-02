Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A07186284
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 16:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759423789; cv=none; b=mULijuJU6nyPjmOP3MmSh9loLe6hXVZTL1GPwQ9PP60qbKvFMbVEbfoKKZZk4pilL5W65f3SQ9JMuFEk/IBUhtK9zCVmxFTQXXSspww3xdezmRjpJpGwcA5Zl/9HehaJXcVDaPXBnG+QYdEAdnInhQDpqTTTzjJntri4RuTtquU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759423789; c=relaxed/simple;
	bh=oJgp1Tq+tqsHAJN8Z8gyOkv/3GYT3Q5OBRZ/YexWBa8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sVVcxvjbf64dFO6R+zFdk2MPjXf/XbpOIJt0uYjQjMDwSEje7kbwC9b0u8KQHmH3l8rTrFmhDbzas2aY3BA6RUIuhbjfVWT0ktGO3r/StI82FF1Pp8L0toLQFugXIfX3QA49ro6x2m6Nppo2nAyKXgdg2EY2InQAoGMX4mxIwZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=amCRiQo3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OS22dQ6D; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="amCRiQo3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OS22dQ6D"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 90FCF1D0023D;
	Thu,  2 Oct 2025 12:49:45 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 02 Oct 2025 12:49:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759423785; x=1759510185; bh=C78+0HPObs
	wHBVVJAJos3dfLP+KPxOm4kplvwqVsR58=; b=amCRiQo3XCtU28cCTgEGv0qtas
	jhdXEX2SpC38xFkV2SPIX25ErFAA2/OqH2MKM1ZXifCnqB+BnoS/9HS+y8CdUxBD
	Bvv7WcZBVeN9+u4yIaSu1rz9nAau3d7IiczlzTHFxuJH6bwq9UMD2NhzxvjNZyGv
	AtzQvykBP5/draCfwyDoh5QGFUemwj+4gtBSM35QNBkrgvQQU18UMekK3yfqIv0+
	Ro6tetF7fmA3p0qELiDNkLNW0ZSa4e5ws5U8kN+nTaaVYPrf4woj+JdiQkcOYw0U
	UI9qp2gDAIfQbWi6kwEbkchdFrSCu5g5CSvDtmSOu7aWdj5JIvhKz40H/DAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759423785; x=1759510185; bh=C78+0HPObswHBVVJAJos3dfLP+KPxOm4kpl
	vwqVsR58=; b=OS22dQ6DBJN5FxwmgJ/IKVzB1k3sv/y/coFo4XEOSVxOJP1NuGZ
	0l6j1trW6Ge76kYfXayfba+mblWNQbA37ljC7tzAtlYVIrRyIrM6myJ0vcB2zfMG
	BPFuATPZe9vjIjEVGmvvVuh0CSYWbXWZtaM1c8ajRzdFexLB87HAvQtLl7aotf7O
	6a6+sDfqrCB54EYuLuXpRXvbiN3V3/TiNv1OwkxgVC8cS0N7ksLQLwOqQ61gkiEb
	gxJ+GBCn/r7ju2b+lavw0GP0Vm2uPJxm6AnZHu2y5+PA2WVxkm6Aqnun2rUH//yb
	Y+Dd2zQpJqs0uiCSAp1D4bo3X8avedGkflg==
X-ME-Sender: <xms:Ka3eaD4rfxUvWmHFe3mKyCwR4xUg7GiWzp2AjSJkK__WQGWCDhRMjw>
    <xme:Ka3eaPwDVCSSuKMojfd7MadUPtifM3mQgULpUZTp4Acoc5BxP7126BysN4Dw6lu8x
    aClAuEplCjojT4ajB8l_peK0VVYW1zvUdtNjjq31Xs07qSHWSJeNo0>
X-ME-Received: <xmr:Ka3eaCytvMrHufneYFyHbjdfDvvxVhN4FY_e45j2U_GVTD6Zx2X8LRU7L6HmI7pPY4ggeh9pJG7CMnZW61_E5HOofo1Tc6RfzFEb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekieehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepshhtohhlvg
    gvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Ka3eaPxtHCiTs2Vk4hg7PYxKVSUlpFvMQT9yvlIGZ0n3Agf95iindQ>
    <xmx:Ka3eaEb5UMBMock7dhhmEf2Pnz_jDjdSOngdiPYl0WGV7CKifdESNg>
    <xmx:Ka3eaIVg8yb4rBdqiph77uy5IminMrHkC7ahtjFaPrRiWfh_Xp-Vcw>
    <xmx:Ka3eaKjeLOUO1kvFJAF17GKDslK5Mta4HOwhFoPam1v_h9H01btLSg>
    <xmx:Ka3eaMU-7RtiGrTqawAYDxnsnBrtm-atSBR4fHPJH-A6SOynVax3ne36>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Oct 2025 12:49:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Derrick Stolee <stolee@gmail.com>,  git@vger.kernel.org,  Taylor Blau
 <me@ttaylorr.com>
Subject: Re: [PATCH 0/6] odb: track commit graphs via object source
In-Reply-To: <aN5gPoPC4WEYw9CF@pks.im> (Patrick Steinhardt's message of "Thu,
	2 Oct 2025 13:21:34 +0200")
References: <20250904-b4-pks-commit-graph-via-source-v1-0-d932c2481e1a@pks.im>
	<xmqq5xdx7qx4.fsf@gitster.g>
	<cf7aeda1-297a-4805-b0ae-e379ce11bbcf@gmail.com>
	<aL67U0-tw7O-y6_X@pks.im>
	<4e67fb02-bbbb-4cd8-9892-6f65b4f82b26@gmail.com>
	<aMFjGoPhGsRCTihO@pks.im> <xmqqo6qyfijl.fsf@gitster.g>
	<aN5gPoPC4WEYw9CF@pks.im>
Date: Thu, 02 Oct 2025 09:49:43 -0700
Message-ID: <xmqqy0ptw8ns.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> My intent here is mostly to allow us to swap out how exactly the data is
> being cached. During the Git Merge I heard from some JJ developer (I
> think) that they also have a pluggable cache, but they approach the
> issue differently: instead of making the cache a property of the object
> backend, they instead make the cache itself pluggable.
>
> I think that's a worthwhile angle to explore. The cache would still sit
> on the repository level, and it wouldn't have to care at all whether we
> use loose objects/packfiles or any other backend. But in theory, we can
> still swap it out for a different representation as desired.

The idea to allow these "caches" being pluggable to the system
independently from object store or reference store backends does
make quite a lot of sense.  If there is only one that is plugged,
that degenerates into the "side data like commit-graph and
reachability bitmaps do not belong to a specific object store
backend, but are defined over the objects known to the repository" I
was talking about in the message you are replying to, I think.

> Which overall means that we can defer this to a later point in time, as
> we can make it pluggable independent from making the object database
> itself pluggable.
>
> So I'd propose to merge the first six patches, as everyone seemed to
> agree that they improve the status quo, but drop the last patch that
> moves the commit-graph into the ODB sources.
>
> Does that seem reasonable to everyone? If so, I don't really see a
> reason to reroll at this point. But please let me know in case I miss
> anything that needs addressing.

I am fine with that, but let's hear from everyone ;-).

Thanks.
