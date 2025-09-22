Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA693192B7D
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 16:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758558271; cv=none; b=Rln8NcavTWvYGEqKDg/f4mEmCzzmVhuSUPxYY6rhoEo1a/vyQmEmZcFm0DIjuzb8999wmvHUrGl8e1ExVGMATlBsUMFCgA5J//y8gUOXnFHG1lYAOt4IAlZ9PHx46dMuwmSlTOshtIdivaC1yt8A1E7R6KSITvJSGMZyQOuHLKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758558271; c=relaxed/simple;
	bh=4Sz2YDAIRee6c8R1cKZ4LwL5cxEakBHx4ISkHhEPyBQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KfXZUTq/QLhGkSAmkQ4YIchVpnphNjkCp7uWTiB7K8APJ4zZwOQRpAuhC/g29ot47BuszKuHsybVkNa/2NlrSqzIycFxojw7Jz1ZkB/jJI7Ihiapvpoto1vwgxu76rqf9t/0inyJBDAUrGQbglFsr6k0uFZNPkFelGce6J6jtBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IwABacQt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ftuyXn5I; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IwABacQt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ftuyXn5I"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D8C64140019C;
	Mon, 22 Sep 2025 12:24:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Mon, 22 Sep 2025 12:24:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758558268; x=1758644668; bh=gPFLmF5WCo
	FVSExI7TCOq4R+/Lf7XwLEcBIkZxGId6g=; b=IwABacQtftDJxpm8Rbw9pVr0yh
	KFkiC48vvJV1CLQuZrk2UzYxMTcmZE8P+V6Os4Heod3w5MSrSuo1XVpsUHO9p2z/
	wqPIHvAYy/1fIQnjwHHE/WDGqJulw3+nsKIrJd2b+BcG2PVME0klwUfTJGtVf/sZ
	jU+WW56CiHV3niBQztH5OKiC3mxdDbHIdY2WibvwD+JfUUFmNOH2FvLamJyxKVYp
	08khpBcGBHTP6edFoXsYonbM2wVqMPOb38da6d97W8oIBJG630T/7+UU0RG27+6K
	TSaZ195XtL4qGOHFkUThyG4MyU5VMRei8GGZm0mHnbot2P0grdtNMPHNmHug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758558268; x=1758644668; bh=gPFLmF5WCoFVSExI7TCOq4R+/Lf7XwLEcBI
	kZxGId6g=; b=ftuyXn5IhqVeUkg58dGQaFW64BaFVUxfie0fwBsI+rCau15kA0a
	/BIVzmhs3EL6Ebw2Yap369XCD/SxU16us/lhob+sPFEsywrsozlkZMZ/DrwIu/bE
	nD4wZD1BTdq7os7L+GISjEYxfvkZOTndFH+O4utpFaoTUfm33syijAA8HRoPpeg6
	qlbFXO7YdXFqggslvmzkmrk8iqX84FZmGvfw95ZyjX+ywUH9QOkBZr8afyYsisxf
	fHneHgVIWFFQ7B7nBjP/oJYt/ExcWtFYfY9uwUo4Baxju7pWUsBwUK6s7TjmdKvm
	e6KlaaqQ/mjcWLt+e2ajNyhK46uVdJ/Q32A==
X-ME-Sender: <xms:PHjRaD1379sUqOCTLPdAXzVhf5RwBEYd2qIb-opW6tXcT8hC_ykrLw>
    <xme:PHjRaCgG_c8AzuD8VlUuhNgko_6htbrOwW0YPqPzyQ-qxTQRKt6TLWiZo1gWZJ_sD
    NsOYQD3FZ9Tr3yVMlIlFR6c4HgHlOVQT54sc_cJYJUck0MdR4oF6g>
X-ME-Received: <xmr:PHjRaDr_BqCSu7VGNtvqP96F3WWSY_-4qp09V8_-aeDLrI9k6oBgopG5R4bCD3y6T6xszOc7OQ8ZvqjjkSPyd734QR1VtGzlA3PF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehkeefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeduiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhtrggttheshhgrtghk
    thhivhhishdrmhgvpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthh
    hprghsthgvrdhnvghtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtoheptggssedvheeisghithdrohhrghdprhgtphhtthhopegtohhllh
    hinhdrfhhunhhkudesghhmrghilhdrtghomhdprhgtphhtthhopegvshgthhifrghrthii
    sehgvghnthhoohdrohhrghdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:PHjRaFOXUlidWLnSbfz5MV7Inx045PcUJ0Wwzaedg1YGK_exWR6eFA>
    <xmx:PHjRaP0KTmSifykuhazO6FeDpU15J3sfbLxrmUOClq5G_l16p-KJkA>
    <xmx:PHjRaDpbCQ58cjzrHfVcLcyFRVuKWgrqisV7ECL3RuVGLoN6hRie1Q>
    <xmx:PHjRaJd7u9uA2dUtzmFr_5z9QlMIuDLS9dfcDE4MyI-Xz6sQ-4EOgQ>
    <xmx:PHjRaCuu3_n-3h8nRCo9kRi4q1Lb8ngGJeCNNGPvMwvVZvzt1GdUYCt1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 12:24:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "Haelwenn (lanodan) Monnier"
 <contact@hacktivis.me>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Ben Knoble <ben.knoble@gmail.com>,
  Christian Brabandt <cb@256bit.org>,  Collin Funk
 <collin.funk1@gmail.com>,  Eli Schwartz <eschwartz@gentoo.org>,  Elijah
 Newren <newren@gmail.com>,  Ezekiel Newren <ezekielnewren@gmail.com>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Pierre-Emmanuel Patry
 <pierre-emmanuel.patry@embecosm.com>,  Sam James <sam@gentoo.org>,  Taylor
 Blau <me@ttaylorr.com>
Subject: Re: [PATCH RFC v4 7/9] BreakingChanges: announce Rust becoming
 mandatory
In-Reply-To: <aMfwGHL7dh8dk2cQ@pks.im> (Patrick Steinhardt's message of "Mon,
	15 Sep 2025 12:53:12 +0200")
References: <20250910-b4-pks-rust-breaking-change-v4-0-4a63fc69278d@pks.im>
	<20250910-b4-pks-rust-breaking-change-v4-7-4a63fc69278d@pks.im>
	<xmqqldmmqa1z.fsf@gitster.g> <aMfwGHL7dh8dk2cQ@pks.im>
Date: Mon, 22 Sep 2025 09:24:26 -0700
Message-ID: <xmqqsegev4jp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> I am having a hard time imagining the practicality of this "hand
>> over but we still review" arrangement.  Some of the security fixes
>> are embargoed, and the reason why we are jetissoning the stale
>> codebase is presumably because nobody is willing to work on it other
>> than the "community support" folks.  I can imagine that we would
>> qualify them into the git-security cabal and let them use the forum
>> to coordinate among themselves, but then to what degree in the
>> "community support themselves" process is our involvement expected?
>> As long as we can make sure that they do not leak before the
>> official embargoed release, they do not need an official stamp of
>> approval from the project or by the Git maintainer---that is what it
>> means to "hand over maintainer ship", at least to me.
>> 
>> In other words, I like what I see in this paragraph, but I do not
>> think we can practically live with the part of the sentence after
>> the last ", but".
>
> I think the most important part here is that this community-supported
> LTS release should still live in the canonical repositories. We should
> avoid the situation where we hand over maintainership to such a degree
> that the end result (the tagged LTS release) lives somewhere else.

Why is it a bad thing?  The official repository can have a README.md
with a single entry "maintenance releases for Git 2.98 LTS (most
notably with no Rust requirements) are found at this separate site".

> Otherwise we risk chaos and a plethora of different LTS releases, which
> would be harmful both for us and those that rely on the LTS releases.

No risk for that as long as we have a single "go there" pointer, right?

> And yes, that probably means that a trusted LTS maintainer should be on
> git-security@ so that they are aware of upcoming security releases.

Absolutely.

And there should be a community of those who are working on helping
the backporting effort around that LTS maintainer that ensures there
is no "chaos and a plethora of different LTS releases".

We might occasionally update what is listed in "git ls-remote --tags"
from our repository by syncing with them only for convenience, but
the important point is that the community supported LTS should have
its own official site, which is different from the cutting/bleeding
edge.  Most importantly, a coordinated disclosure would say that the
update to versions of

 - Git 3.0 to Git 3.4 are found $HERE, 
 - Git for Windows 3.0, 3.2, and 3.4 are found $THERE
 - Git 2.98 are found $COMMUNITY_LTS

to make sure that people know where to find their updates.

So, no, I do not think we should unnecessarily mix community LTS and
the main project.



