Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F9224E016
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 17:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764177764; cv=none; b=aC+R87+azdoyV8bXHWanBM6j8MZGVJ0m3ID9asbqgmc5nyugW0KPVARyMX/RK+yqujrbkZ7UEhs/eYRi/5xuUpwxfuH4YOO1aRy9mIAEJkOD4ecl92jTfBY6TJr4C9iWzdqLOxga5VLzSwRU7/HV7SDnGR9HkHc63JlRW3IDLpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764177764; c=relaxed/simple;
	bh=ZQaN6chMfmh4u2N4X+Jc1Eeg7EMo2IwE67dcpJdDjJE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I8PpMmYW06RpolTdm3iJiJp5DK8fTwYZXied8lztZ83yhKsC7XCTSJVr7TJ/9VnMQKWWQ+Dyq5yGe19TzNefzofIaURyNfsji2Ky0RwULy5iJK3RWtFJWcXCDBa193L2CKJ+/NGw+8pyh4F0md8kTTFPP+Lo/htpDLIIlEq4o4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=COIBlaK5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vHCVQ5WY; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="COIBlaK5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vHCVQ5WY"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9BD191400197;
	Wed, 26 Nov 2025 12:22:40 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Wed, 26 Nov 2025 12:22:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1764177760; x=1764264160; bh=t83XwYBSwS
	9sv7T/xd2QWGQoiZQh2gELnYOHSOJsqHA=; b=COIBlaK5iU2Q/s93PyE2KzUHJ5
	+oz1x6R9nx6klR+7GOGNzmKMQ9YEbo0mMvmMh6iD23Kz8pxBc9OuC3CTNP4BFiUr
	FVZk/qfO6PRBs2r9ecwjYEZIafxt4q3XD7eu7CwbC4AW19EPn4XcY5a1ekFtfRuc
	BKC7G4YPuzoWaK8fNQ8ekBNEYFb431WcK2j77SS4wpoTNefm9s4xPCNVycO0rP3i
	NGaoAo7r4REIon5ABQxWGemEFeGdL4P9CQ9R5d7gHXYUV7YGRv7syNYTdlMJjgMM
	Il0doZCbqDFmFtjrlEavSSeStdxj0I70ou0Po+hlQKFLkcvRmZUmGlBOumag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1764177760; x=1764264160; bh=t83XwYBSwS9sv7T/xd2QWGQoiZQh2gELnYO
	HSOJsqHA=; b=vHCVQ5WYr4RQMoWutd5Y22nZkhegk/+mGCyXRNUyx6fNGdOtwjH
	uNn1AiWSxnbgGn3JT+PG4syToWPYV/ICjCtm2tp2Vw3tobUdi121+UVgRz84ICG6
	byITYAHJq0un44CGMb/MWuSv2jdahrgm+NFnTN04oxdsKUIxxjtQPSD7EmDK8yxI
	tzlrgqlhOnC8lnyhglz3gbepGDKf6/02kmHX62GR+mf4GhOjS9kQD50i8QXoPgP6
	KDjD5xCcT4g5NZvCLKApZQN2SF77+adPX5KCK76lXYql7vdaFjLkucPSZC3BVUS7
	Wdu08C6Riro494PhCF3nHtRvoemzB1qDA8A==
X-ME-Sender: <xms:YDcnaTIXTSZBAz-ijU6SyuHrIN4wpAxuZQHB0Qxqfb1E50zP2-zsCg>
    <xme:YDcnaZbQj07pDj8SiH0LbGg4K5e-vDN-xuuof0MDksF9mHsnAFfzKA7cdfETMsezG
    EKsmmfc9M8KqF5voOZn21hzZO4OHf-Xt-kQ9dO7Aqkw10w0X_rQDZ0>
X-ME-Received: <xmr:YDcnad9vLvJFCSz5w1mdd2DlFvqNdw8iyWLfIIOR-upt4GnpZi848UPbjm_bDodxdIfa5p2foRoOX4NkE9RDFpxcbPhm30YOM3iO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeegleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpd
    hrtghpthhtoheptghmlhhishhtshesshgvnhhtrdgtohhmpdhrtghpthhtohepmhgvseht
    thgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:YDcnaSZqi-jYtaZoQqETGGElRQ-NTBH35AGfgZ3NXdMvBhFhw1OP_g>
    <xmx:YDcnaZMqd1uHiVETSg0tEMs1B6JBxSDrM9aXbU-XPtRzj82rzfCL8A>
    <xmx:YDcnaWCSzg2oSg-cBGF0fJLJxxvU1_sHD6Hyb39tTL1n-ZmFpv4u-A>
    <xmx:YDcnaYLu0BwzTMV8gR6SY-3wO2-VG9hKu2Hc01Y1viK1eQQqpNdHmA>
    <xmx:YDcnaUahZd4WOrVOzB21W-Jw_Sk1AVi4LNW07zydplPD2v3z16QG1Ovh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Nov 2025 12:22:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  git@vger.kernel.org,  Patrick
 Steinhardt <ps@pks.im>,  correctmost <cmlists@sent.com>,  Taylor Blau
 <me@ttaylorr.com>
Subject: Re: [PATCH v2 4/9] cache-tree: avoid strtol() on non-string buffer
In-Reply-To: <20251126150931.GC4143292@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 26 Nov 2025 10:09:31 -0500")
References: <20251118091127.GA4175601@coredump.intra.peff.net>
	<20251118091218.GD529192@coredump.intra.peff.net>
	<ca6d99cc-d05c-49fb-ab3c-d7668077d32b@gmail.com>
	<xmqqtsylz2xh.fsf@gitster.g>
	<20251124223023.GA2051672@coredump.intra.peff.net>
	<xmqqms4buix0.fsf@gitster.g>
	<20251126150931.GC4143292@coredump.intra.peff.net>
Date: Wed, 26 Nov 2025 09:22:38 -0800
Message-ID: <xmqqldjsogip.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Hmm, I thought both of those things were reasonably clever. The other
> obvious way to do it, AFAICT, is to used checked-operation intrinsics or
> add unsigned_add_overflows() before every operation.

Yup, but the thing is, I didn't want something "clever".  I prefer
"clean and obvious" if we add extra code for safety.

> It is true that for the general case of: "x = y + z" or "x = y * z", you
> cannot determine overflow strictly from checking that x < y. But I think
> given that we know "z" must be small, it works in this case.
>
> It looks like you merged what I had into 'next'. Where do you want to go
> from there? I am mostly content to let it be, but we can also try to
> replace with something like your version.

That is my preference.  While the topic is still in 'next', or after
the topic graduates to 'master'.  Either is fine.  And it is fine if
such an update did not come, too.  After all, this is to deal with
contents in a locally generated file (.git/index), so a maliciously
corrupt string that lack the expected whitespace character after the
digit string is a sign that you are trying to burn yourself and you
have only yourself to blame, isn't it?  An attacker that can put
garbage in your .git/index has better ways to fool you by updating
your .git/config file that sits next to it.  Or teach the sanitizer
that this code path is already OK somehow?

> Or even, I guess, work on a
> global strntoi() that could be used everywhere, if we think it is robust
> enough. (Though technically that name is reserved by the standard, which
> is a shame, because that is really what this thing is).

Well, we already use plenty of names beginning with 'str' followed
by a lowercase letter, like strbuf_foo() and string_list_init().
