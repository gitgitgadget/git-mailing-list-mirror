Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10BD32F77A
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 21:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756850064; cv=none; b=NBzTM99Nx7P+7qYzZpq6VM9m0hD7wYF+/+mz0aYPxtLoB6DQgBt81sv8+7LG8CPgIE06NGs7f/Y3YzQV0fX6YrISaDCqQtXBeWXmcySZklR3yq+dgPq+HeESVm2YYvVEvMF+B7OMxMUbS7v1pJ0KGZb5IbEeakQUGRz5snVZjHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756850064; c=relaxed/simple;
	bh=4sSmeWksIxjaSPEmSeAzfsqUxvmZpygJIvI55XfvDqg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qep3yAhrKUxxVnYf7MDOPtn811imSnm/5rISg5DyY8gU6SGF5m5JHH4peUvOBsnglu+aCfXD8eQMamYBNKfkgWdVlw3Vpw/q7JOFEug+6W/WgH01fFCh7l2Lryp3Y8pbn/KhSDw/M/TJXa9gLyAw4Jte4py27uJqXKkz+/MnkkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xwHybpJI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JV+OupCV; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xwHybpJI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JV+OupCV"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B29D91400155;
	Tue,  2 Sep 2025 17:54:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 02 Sep 2025 17:54:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756850060; x=1756936460; bh=NP42qBRGjs
	MoZ6lDgTWKEDQkMIY6KeOTAc6BOibHz2g=; b=xwHybpJIocCBc4TfGvk0S2CLcQ
	6lUCYNPefcbfC9S6rKOARzZJRKIyHyBizu4efy+AGWAcozz7BeSP1tg6dYySaoda
	aKmRP9BFERFigk+W44Gxh+6v8Gbw5pB9VcUb9S804eM13F+12fU/hEST8veK+0Jn
	/kMcohMNChdbodlTF5txIqhsIwHjhlL5Rsf8DpX4p3FX9+qJDMZwGojMw2O/mRUN
	D89/95z4XNXIF2nhlqH0pHEXUtNemy0odZrurvVgF+r1cAD8TZW0K01n8flII8uP
	ozJYWY6290iEGKbnESBqFNtxf6X3iUERi0nxVrs/F2mQ3f7nnzjO8QGz98Zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756850060; x=1756936460; bh=NP42qBRGjsMoZ6lDgTWKEDQkMIY6KeOTAc6
	BOibHz2g=; b=JV+OupCVmeJ4UtHc6+Nq7wvVynONQHKdzyNmnnAAuZKAodYrVWX
	RQ9Pe/0yRsdbQ+bjelmsf64saVc+AfxtfJS5Z4V8svt4HhftSHWgFK0TB8F4ssFp
	vhDJ3VfESXF+MZHnRW3xaCaGChEeu1lTCuVY1pqWB1Qnp5SfuS0Npw7VpFflP+4R
	92vQ3W6woHF56XV5vcwtG59me68u7qWD3BdvDmuyawcTooQZ8Y8a0wnYkPKMufIX
	/+bcJ0NqFI5AE8Dc+V0i2Ott4xzDUMTNWV0PGOeKZLS8pblJEhDIw42AEZa+5gIH
	eMGDmIL5IW8jUy5xHqvmGS5H+L2DWOuppjg==
X-ME-Sender: <xms:jGe3aHfdOZU0R1pamkkP6Nvu3lMVixsp9zDDDHsCqPegTxI6zH0-Lw>
    <xme:jGe3aHxDOlDtDNCET6AixODYKM1_p630Jk5rR6TRHDmhkNGmKr_QM8xMHcqPOv8r1
    VdSp6mShlfsTVexKQ>
X-ME-Received: <xmr:jGe3aNEx4BgkCxe1Kvjs4SHG7CNjBqNBhqn9qVOtnuS9Uoi06V3AMgwVPpiJd6fnvvlCUC9ydhhrAeM74zCfGWbJH670eaa_F0gGCsE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtre
    dtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgs
    ohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffue
    efjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprh
    gtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhf
    fhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhg
    shgsrghkkhdrnhgrmhgvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:jGe3aLwxJNwg04dim7nf1FkOsJHV-wMDf3Q4vWhfw4CEEfefq808Sw>
    <xmx:jGe3aOti_m89Z5cFpucMf_I3jbAxv9YOJlXWmNjfqM2v1ZwTJSvdjw>
    <xmx:jGe3aI1Tvr5hJNfjv5ZBtOIuo90Z47jCd2Nt4WSWtSQsP1hZYVWVsg>
    <xmx:jGe3aJ8nQ53LoUHoal4SeNs8_E2KAESsV-r6tldSL_AZiWAk-SwjOw>
    <xmx:jGe3aB19tbv7Hrc2FlghtZVYEFEc2x61V9mGyIUb5O_iEo-jsX7NDZfY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 17:54:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH 0/2] doc: add/remove backticks for inline-verbatim markup
In-Reply-To: <cover.1756845314.git.code@khaugsbakk.name>
	(kristofferhaugsbakk@fastmail.com's message of "Tue, 2 Sep 2025
	22:35:45 +0200")
References: <cover.1756845314.git.code@khaugsbakk.name>
Date: Tue, 02 Sep 2025 14:54:18 -0700
Message-ID: <xmqq1pooikqd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> Fix markup where either a backtick (for inline-verbatim) was missed or
> one too many was used.
>
> Ignores the one in `Documentation/config/alias.adoc` because [1] already
> covers that one.

The places these patches address are clearly broken.  Thanks for
noticing and fixing them.

Will queue.

Thanks.
