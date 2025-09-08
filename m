Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C92235BE8
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 14:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757340439; cv=none; b=spTD6/rnlZsq+1BdjJ0TN1WYoXyf6CP0Ynpq9Grf6srTUvn0BbBgu27HlsQx4H+c8KYOKKnzVuXBhULkAiOu5hZkJ+0KTU1YJnd76a+0S221iXWu9IGpgZ8shc8gNbju28VDZjWLWZ7SUsn15P7a2OuGWJMhB/NcjQL0hlZCjP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757340439; c=relaxed/simple;
	bh=926/kRne4sQjZskYspJFXHUZfVJ1djLfTZLI9p3409Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BvrmoQJu7gutgx0VMi+p0JrsW2P+eN/iU8fP5Va9/Eb8SmxeVf6z6oRRKNwsGVuEuZGBWG0ceREqP9SST6EGEFZDSjRchJ53/a38yziDF0pa1OxPuxqFcO6MJ0RnrGxuWhKyKXNRqwsFkEMs7DGA5mBTXDH5deon5ykqM46Dz+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=c/QxWQV9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fPRD9s0t; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="c/QxWQV9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fPRD9s0t"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 5FF531D00105;
	Mon,  8 Sep 2025 10:07:15 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Mon, 08 Sep 2025 10:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757340435; x=1757426835; bh=HLcT8EPKFY
	oa71AKOB9BoN+k7+FTJQhSpbbJ9GJx5+o=; b=c/QxWQV9CpuhfOK63aOCkxl3yZ
	nJZIvQrlPVgZYa1zVnV9YwiziY6Hv8RDrlr1QGhXnMOV1akW8c3Gab1zjSd/LWDo
	YYiGAdYRLIZEvrzsATzkbBY/Foq7fvysn/mHqI+MHjTtLzIUEMNmVON5nWkBy6ig
	Bxa1h51pGk9+0O+jzzhn7wW2to0ydjkUMoN2wX7sCSUe2zTVST03mCUm3xggiOV/
	I4neiHsbUU23VkB20AA9QstC3QXIprRtEJhZFgrPMjiUhvxI1DhH0dturJ+CDw0n
	/Mnwt2ZXsOwh8x9ojHLkgchZW1+ge1DrzX4R4LFg5c2O3IruRt4R3u+lF5dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757340435; x=1757426835; bh=HLcT8EPKFYoa71AKOB9BoN+k7+FTJQhSpbb
	J9GJx5+o=; b=fPRD9s0tvhfilfpI158I/L55E2+zV0/VC+NN+rKX3eS8T0PH8Gc
	KXf3YOv6EgLtv48rygYT9wTslOUB/o068Tj3XEd0xcAp7RXa4Q99J9zk77m2P9Rn
	UsLJbFjRss6mCw1ouz1tQjAFEsk23PebK8Y/JFEkZaEDPk69NCIP0kZhaxKttg/Q
	r1bE10OzTbXWXooASjULKn1fT4zkCx/rgwxObAW+inLHD5pnkJB9zN9leKLHsrwW
	CGAE8pn3NthfO/WJ/iVM/t+PzK+JWtTc0m82SWJ/cL5KhWkZGGiqQNjATHHT6RAW
	aQi2h3Pmca3VpMOCrn+sO47wty5raPP2UCQ==
X-ME-Sender: <xms:EuO-aCL5VpvCTdTNBjnB9FXbbHlr4u_PsJ90naEBgAUUPLJmEbFzAw>
    <xme:EuO-aFoyRxK6MdplkqgnsuTSG4d5DsZkXY8jIRFlzG8HOnRgcv3y34Rq47TiHlAzb
    sVycp1rVR71QEQg2Q>
X-ME-Received: <xmr:EuO-aJJ2JrxAIXOSyaeD-yChiGyMn2tZgc-oARhYzuFAwjMxEQRfGwYKjRvswpsMIn4Qq8FbnSBwU3dfcu_jmNsqHAs4-F9WK5SDtW0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeejfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehmvggvthhsohhniheftddujeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phhssehpkhhsrdhimhdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:EuO-aCRllcqxO9EkG9tII6k0KGebg_vDHKPfmIA2hDpUjDEyDtitHQ>
    <xmx:EuO-aAvCpvOxora33cMt4Vf3B4S2sItMive0U9elR4MeG7tIfIIUkg>
    <xmx:EuO-aLbIs1Ls3dNlZC4pJtL8OZJXVZ_oyIBoULUPK4FKeLogbjiNYw>
    <xmx:EuO-aOE6GZCNXxmzunvjGEADH4KXgbHvMXd1TVthTpw9XqF6i0AhWg>
    <xmx:E-O-aJr7A2F5Hz-AQERwoBfaB5xn82mAjPb4I02m-DBY0BZps9QuLfEW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 10:07:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  shejialuo@gmail.com
Subject: Re: [GSoC][PATCH v2 0/5] Add refs optimize subcommand
In-Reply-To: <20250906075147.1076656-1-meetsoni3017@gmail.com> (Meet Soni's
	message of "Sat, 6 Sep 2025 13:21:42 +0530")
References: <20250906075147.1076656-1-meetsoni3017@gmail.com>
Date: Mon, 08 Sep 2025 07:07:12 -0700
Message-ID: <xmqq348xyr5b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Meet Soni <meetsoni3017@gmail.com> writes:

> This series introduces `git refs optimize` as a modern replacement for
> `git pack-refs`, continuing the effort to consolidate commands
> under the `git refs` namespace.

Sorry, but I do not quite see the point of this change.  Is it your
goal to eventually remove "git pack-refs"?

I would very much understand if this were:

    "git pack-refs" is a command that is very specific to the files
    backend to optimize the way refs are stored in that backend.  It
    does not do anything to other backends.

    Introduce "git refs optimize" as the end-user facing front-end
    so that later different backends, including reftable backend,
    can define their own way to optimize the way refs are stored in
    them.  As the first step, switch on what backend is in use in
    the repository, and invoke "git pack-refs" if the repository
    uses the files backend.

And when framed this way, I am not sure it is a good direction
forward to have pack-refs.[ch] top-level files.  I have to wonder if
the approach should be more along this line?

 - Define the "optimize" action in the refs API.  What it really
   means to "optimize" may differ from backend to backend.  There
   may be refs_optimize(struct ref_store *refs) API entry point.

 - Add the new action to the vtable for refs backends.  There may be
   no action defined for reftable backend for now, or you may find
   there already are reftable specific optimizations you want to
   trigger from there.

 - Figure out how this interacts with existing refs_pack_refs();
   most likely it as the backend specific option, should go away,
   and its implementation would move to the "optimize" action driven
   from the vtable for files backend.

Once it is done, you do not necessarily need "git refs optimize",
but the "git pack-refs" could be the front-end to trigger the more
generic "optimize" action.  In other words, in a repository whose
refs are stored in reftable, "git pack-refs" would cease to be a
no-op but can perform optimizations suitable in that repository.

That way, users do not need to learn a new command, which may be
also an advantage over what is being proposed here.

Thanks.
