Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9F42135B9
	for <git@vger.kernel.org>; Fri, 21 Mar 2025 10:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742553387; cv=none; b=uwTqKASY/72SVjoaCU8qLqJ/vJZ5Fvg8h1lZMQllrhMVtNw0GsCdjVoN37/QxFVd05d5ORNoYzqZI/LMTDlb/d/p0fP5th3Sy7mixvyCm8BmrdhaqJOBLYdj97+7A9j0ZZnIW7Mte6dMK6J8UD30lms7vzd5aeM8cuWOODSvLu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742553387; c=relaxed/simple;
	bh=Vm1DLK5YjjPCSZVzeMMxX2r4puGeq/Vq0rTLfwFf7ls=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ct8VZHEJEVztCeR9s3lc1scRInkwslAHRDtFsFqRHavtXWOSERn3CSQAy+s6SaaCMt3+j1UyhhugC2Bi5RIW8l2uExfa7HncHwZGatP7Gr7m9omxSVP7nkxiCCa01lU0lLaJy7z8JCQ+n7VL+OHJcyb+h0A3shbHXyvA0UTBYMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KhUOC+Vs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VFYNIJdp; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KhUOC+Vs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VFYNIJdp"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 905AB2540169;
	Fri, 21 Mar 2025 06:36:24 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Fri, 21 Mar 2025 06:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1742553384; x=1742639784; bh=7w5awLxysJ
	zPNDszHgnGJedX7lpDfLtBlHTFs7InhDk=; b=KhUOC+VsuHGtastqBhDaMCYf4p
	cyABFcs4kVHF/2CjOXk9iWu+wiNm5xwNaVbSo9Ynz+pI6QrQV3fEWAIu/zfbR7gs
	2l4/LmrY9Bpcr0vsgtPH3e0hd6RHHWzoo2u9O4+724YlGHVS4pN5WPDOmxPlhiGC
	QVG0QquzA5BiEfwctZGrAMNCdkr1mjezmcDzNU7qUNfKvvTYzOv7D+AhCjQjRrYF
	NcAFjcDqV6JGPQSbTaq8eweiSli1W67HHAE0bvOBFKqNIFNsc4aebd6zyYG1M12p
	BuM2fBPDqhl+i5m4zZVDXPPq3D9Xel76dhFYQFQmnoV98D8Oy11oabZJGBbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742553384; x=1742639784; bh=7w5awLxysJzPNDszHgnGJedX7lpDfLtBlHT
	Fs7InhDk=; b=VFYNIJdpzPmnxN2wzOIbPCAqoyF9zyu9BNn60OX/lkhHFOY41G1
	aekZULselkxeqtoa3zNbiq0KGkUK0Itl+zRVkbbBvWrBRoj6R1GKVp+ix4qw5z8Q
	zBQgRiexXHr/f0hdYj/8H6j69CzmDvNZxxsbj1x1N00bt7d577SPWE6KlBZFfiyK
	NfO9wKcqQ3+dkuCZVQjptyqGID3BEbr09eUGhzEdQGIO+gOrMmdGVXYhXnRNYqHp
	Ovry3r+2uBayspPvBOGgHqPKI299bty/SVDYecgSbnrar+HNcnxpEbQsVfWoCf2q
	YOOp3O8ka+LlqUyTWQphZ993I42sPe+M2TA==
X-ME-Sender: <xms:KEHdZ3vrHqkCZ9tQ2RjYLKw6j3oSIYP1iuwtpkKICoYTEdONPeRpMA>
    <xme:KEHdZ4fhFNHNKSM7tXLqh1wdML0JeI86sjCm1GRLFHJfylY2tobqrD9cD4iTl0I1d
    ho0ecHNGLXJ6SmI4Q>
X-ME-Received: <xmr:KEHdZ6yoV7oG8qEOaLmu5NUSsBUuAIyKvDbfuebp7NsxUoCU6vQTfDMMeIocAzttTfAorVyLLf-hwTYQHpLFZzG1s-qdmEvWPgU3aIU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduhedtkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhgrhigrthhhvg
    gvrhhthhhkuhhlkhgrrhhnihdvtddtheesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnhdrkhhnohgslh
    gvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:KEHdZ2PFUASCCa65yKqXCSt9JuNy3Prfkp9KTgerx50ayrolJrADbg>
    <xmx:KEHdZ3_BQnUn5qckY8U2uomYqCNv53_nSMbLFTgpqUPvh7m3JI0VQQ>
    <xmx:KEHdZ2UZP-uL4Z5JQVBU3TyUUwoDQpAApMZDhBwovt-wgk9jzI8-xQ>
    <xmx:KEHdZ4cfaExzhisF7o1xDoHu3P2lIX6Ku08FzbImSY9xxVDgctONMQ>
    <xmx:KEHdZzZ4dUHQXipge9cO5Y6pHAA6DQ8PeOAqJbIPnY8q0Oq4099j75t0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Mar 2025 06:36:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org,  ben.knoble@gmail.com
Subject: Re: [GSOC][PATCH v2] Remove outdated mentoring mailing list reference
In-Reply-To: <20250319170244.32912-1-jayatheerthkulkarni2005@gmail.com>
	(K. Jayatheerth's message of "Wed, 19 Mar 2025 22:32:44 +0530")
References: <xmqqa59j8gml.fsf@gitster.g>
	<20250319170244.32912-1-jayatheerthkulkarni2005@gmail.com>
Date: Fri, 21 Mar 2025 03:36:22 -0700
Message-ID: <xmqqa59evffd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

> Subject: Re: [GSOC][PATCH v2] Remove outdated mentoring mailing list reference

[Documentation/SubmittingPatches]

    The first line of the commit message should be a short description (50
    characters is the soft limit, see DISCUSSION in linkgit:git-commit[1]),
    and should skip the full stop.  It is also conventional in most cases to
    prefix the first line with "area: " where the area is a filename or
    identifier for the general area of the code being modified, e.g.

    * doc: clarify distinction between sign-off and pgp-signing
    * githooks.txt: improve the intro section

    If in doubt which identifier to use, run `git log --no-merges` on the
    files you are modifying to see the current conventions.

> and clarify tutorial prerequisites

Do not do this.  What you have on the e-mail "Subject:" line is the
first paragraph (whose definition is block of text delineated by
blank lines) of the commit log message, and the first paratraph in
the body of a patch e-mail is the second paragraph.  You do not
start your second paragraph at half-sentence, as if it were a
continuation of an incomplete previous sentence.

