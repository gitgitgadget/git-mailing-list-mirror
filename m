Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23DC2877CB
	for <git@vger.kernel.org>; Sun, 12 Oct 2025 15:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760281674; cv=none; b=gRgXuwxsqEvEJG53U2ys6JwS1wX1bdG+9Sc4QhpPk7BI8A/3WhgNrG04t87zTUQjPRQFpn9vOvHIlcyRNC2fJtwkynxBr6n7/kKC4TpuWYRxQhyzOulSJcYyjew/+msRNqMee1gd6L/y0fBb78//CTsXfaA9uE4gIn/TwGTr1kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760281674; c=relaxed/simple;
	bh=AjFrX75DmLOXfmqITt5cARBuQFnCCCua2klBx8x34zc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SNLT6YJi9epoxQZj8FDVws7oB+yFYeG1HXipAm9q3FWLTvhW8SXYOM+spWbjjfikBv9csg7MLNb99uUOGfesD7ecTyRsLLjDtTIwWYgIMuJR+TSQkVrkM1m1Mfl2A8ZqF6D/s8EUdoXXwiDFJC9ok80etNlbTFd9lLynNGFfOEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MSqgmJc4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UOxwAHZI; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MSqgmJc4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UOxwAHZI"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2165F140021C;
	Sun, 12 Oct 2025 11:07:50 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Sun, 12 Oct 2025 11:07:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760281670; x=1760368070; bh=DtKDk/gofi
	ZCCe3HFvhP0q55DZskTW+XBQTOm7f7Epk=; b=MSqgmJc4rHjf6AaUnMfHKbH8nj
	Q2dBUdwEddrlEszxGjaHLFA61vpdIKdAULiR/GAWsGcG6Q5PbQ7OKF5Lhx3gl2si
	Bfyai0QFo/7gPrHKanc+5NQICrapjORcgFCnbnkrJNnAxPOx0iCO6cIPi7venYHc
	+j5OWs4EmH2dMX/vh4etmQUo/altPapkoZ+8DmCgr+d147DWcUpZe4v/2wUuRpcU
	izrDdrA7yoSEfswGtz86aWwAGiL+o3DLXpA4+Nq9YWr/80h6slaLApBlnyqmWCVU
	OvCmYEapCekZLyFj6yp35IXrvF/HoL5kREYqyw9q+LrjY4wfVBEXxsP9IvTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760281670; x=1760368070; bh=DtKDk/gofiZCCe3HFvhP0q55DZskTW+XBQT
	Om7f7Epk=; b=UOxwAHZIXg8OJEiLMNAFqo9lDV/2wZB7OL3eTaYc9A5LY0KD/Jf
	df4IlE7xpQIy2WBIvvtH+gdM6Zhnl/0dFg3BGyr+e0/+HiEyshJUs1Ntg7vsb1Lf
	KRfkmPuYk+Ub6i3jS3CU6mCyaPxp2OnJTsDZ21BL8rJXbuPkSMQFxwAgEheagUeB
	nLq4wJQOO2ROIzGikgdeCEkChxbq8gx4FPf6RDz2m0MLzAbmM+bRP1WD5vSZM7Fp
	ox4e36b9bVQjV2B+HxhmK4e4wK4YPAbRd+i/ki1fp8fFgcBlap5MbXhbEnldW/nT
	KMkP/dcLV81N2PAHKdiD/rnIEvX75+SjCag==
X-ME-Sender: <xms:RcTraOzkRqhghLGAErfxPNmeD9NhOBpMBM2Pi34WgO6qs6vlp4OW4A>
    <xme:RcTraCeR3csqV4UGBPs1-tO7_Sdfk8SHKp6aGNwsIbM86yltdgluzV3lUreAPvEq5
    hG-uIKAjIa1f_3FLs2VK7mf7ESY0n0CuBdbCA3TDMykCmPYykixjcI>
X-ME-Received: <xmr:RcTraL6ZLgmih6Dg9Cojle4Bjjm9-t4_pRH3xJRpkCfckEunCy8-08t6nrWEI-EQ8XlLzlErsioXDIN8roX_sUl62m6eMhuDhw3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudehtdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtph
    htthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgt
    phhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvseht
    thgrhihlohhrrhdrtghomhdprhgtphhtthhopehrihgtkhesshhftghonhhsvghrvhgrnh
    gthidrohhrghdprhgtphhtthhopehgihhtsehsfhgtohhnshgvrhhvrghntgihrdhorhhg
    pdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpd
    hrtghpthhtohepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:RcTraPKvmKhCLQB991z2TK3Hxu920y4vUYol51sCYJ771r7hGFJNtw>
    <xmx:RcTraLyZfP2t0G_v05qLi_Wqyqlqx250s3FgsYkqYUwTGm_AgoSrZQ>
    <xmx:RcTraPIvYZh_FxkZlhjREqN9bk28hvuORzWqhTSuJtHP6pusyQ8p1A>
    <xmx:RcTraCXxVxGxUnH8Sq8UGLXYAn6LCsNMzarRUXg-VW9k_JUZaUqDog>
    <xmx:RsTraJz2rbwjNcLMf25p24VZ3ycD99RrZ1n7OYeXWEzsi3fPgkXLm_Mf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 12 Oct 2025 11:07:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  Christian Couder
 <christian.couder@gmail.com>,  git@vger.kernel.org,  Taylor Blau
 <me@ttaylorr.com>,  Rick Sanders <rick@sfconservancy.org>,  Git at SFC
 <git@sfconservancy.org>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Patrick Steinhardt <ps@pks.im>,  Christian
 Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] SubmittingPatches: add section about AI
In-Reply-To: <CABPp-BFf+_8cUc6sWZci9F0voosOQFWQ3x8dNs0YXEZ-uRvhNg@mail.gmail.com>
	(Elijah Newren's message of "Tue, 7 Oct 2025 21:18:12 -0700")
References: <xmqqcyalm0mh.fsf@gitster.g>
	<20251001140310.527097-1-christian.couder@gmail.com>
	<aN2fG-nS9fE5-2jD@fruit.crustytoothpaste.net>
	<CABPp-BFcg9M=XjqGPd+akrUOqJqREBmE9+NvO1Q05r4pUcOmEQ@mail.gmail.com>
	<aOBMHqLxNd86vgjH@fruit.crustytoothpaste.net>
	<xmqqh5wbq5z8.fsf@gitster.g>
	<CABPp-BFf+_8cUc6sWZci9F0voosOQFWQ3x8dNs0YXEZ-uRvhNg@mail.gmail.com>
Date: Sun, 12 Oct 2025 08:07:47 -0700
Message-ID: <xmqq5xck5fb0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

>> ...
>> This policy may evolve as AI tools mature and the legal situation is
>> clarifed. In the meanwhile, requests for exceptions to this policy will be
>> evaluated by the Git project on a case by case basis. To be granted an
>> exception, a contributor will need to demonstrate clarity of the license and
>> copyright status for the tool's output in relation to its training model and
>> code, to the satisfaction of the project maintainers.
>
> I preferred the version Christian sent, but *if* we end up adopting
> some of the QEMU wording, I've got a logistics question:
>
>     Will we grandfather already accepted series, or proactively revert them?

Stepping back a bit, can we treat this new guideline element just
like any other guidelines in SubmittingPatches and also
CodingGuidelines?

We have certain rules in our SubmittingPatches and CodingGuidelines
to help us not get into trouble in the future.  We require the log
messages to follow certain style to give them uniformity as
otherwise it would become harder to dig the history later to find
cause of an issue we are having today, and more importantly what the
design parameters were back when the change we are having trouble
with was written.  We ask people to follow certain style in the code
as it would make it more work to understand code if different styles
are mixed together without reason.

But we also frown upon churning the codebase for the sake of
strictly match the prescribed coding style.  The rules are mostly to
control newly written things so that they do not make our codebase
into worse shape than it currently is.  When we update a part of our
codebase for some reason, other than "there is no particular reason
but we want to fix them to match guidelines", we would take existing
guideline violations the touched part may have into account, of
course.  And we find no need in our other non-AI guidelines to say
"we grandfather badness that already exists, but we try our best to
enforce the guidelines as strictly as possible", and the reason, I
think, is because that is implicitly what everybody expects.  Should
the "We tell you again not to blindly add things with unknown
origin, given the recent proliferation of AI coding product" rule be
any special and different?

