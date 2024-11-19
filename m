Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9579A1940A2
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 07:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732001186; cv=none; b=uNv5kkPeld4vHdjmHU7SJhI29tMdBdNKTb98V7Lf1mMMRH9HcpSYxtXAVzKI8FBxX4Ny7SDqwAL6a54AKNIaMFsjliqsXtJar4xEJh7+I4ZPmDI7kUFU4aI7LqalZkrFCXuJHErIAjtDb9RwoALglK7BJqvSmjVERLvo78g/kTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732001186; c=relaxed/simple;
	bh=QQYO9MMwSUoNTZL0JebLfY0TrM6BeXEjh4oWv3Apwqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJpAXjWbi0jhfnpR/4L1gZClKWB/QKGgyQD4zJ/ZthsJRKvr+Bedd/4WsHBdfxh3Z7gHBxA3P8AgEBz10UCODESBeKHdHw9pdurw8GlutCeV6cDvJCBmYZBys7hOeCxPpggu83WHnV9/+/SXhHnRpl2WDS2szhdfs/DAnCDDHwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qiPfm8yV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X3aPAvUa; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qiPfm8yV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X3aPAvUa"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7773D1140196;
	Tue, 19 Nov 2024 02:26:23 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 19 Nov 2024 02:26:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1732001183; x=1732087583; bh=ZAcnY2HUN2
	e50yhQC2E+UmU+2F4vGtUwkLA+k6KAPMs=; b=qiPfm8yVWu+NgReLLlqvRzZp/K
	Pr3d7VJEiQ82VjUYLCQ20+N1NrGVv678gwt6IARSDe7s2gC4+pky0Gyh5M0jR/8s
	KJVSTLupzDpEhsGfOhV9kooR+1HBj2LcfWcy54CLoYi+ZQD5pBezFeKyQlBswAdC
	goM4ukKK5/PZzGgYA/LE2mQGtlFGe1x7ueVOhOQpYkZuts4e4c4jZopX+jHRBusp
	5LC0ZQ2nl2g5hqaY0GSAI9fkg3U55SyYQ9YwqC3YUC70k1v9a5S9jaYWH++dI9VG
	7zHGeQnDnEs11KnXnSuVt3278ar2a7+nyTA4/h3bNutYkXiQWIkqfCGVXe6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1732001183; x=1732087583; bh=ZAcnY2HUN2e50yhQC2E+UmU+2F4vGtUwkLA
	+k6KAPMs=; b=X3aPAvUaSKo9RXcEQSAL1NMok1LOYdFujQFaQdweRPfU3h97cWc
	rhSYKkE8kNFEsRW+7yC0W8MKyN7YUSynhKpH1cNWh4u/qCe06+gBtK1o/h9hQVM6
	BpBcXK5Ben+Sx1EHSr6iQxOjhKSgv3BOot8FPaJaJcm48cJy04ZEJN5TwyA65TXa
	byZgBwukL+hzlXGvcpk7iHutMHovzmsX66SsQ50J8zCzFc6N/0T7SBn53Re5DxoW
	jOEobdpUnhmNrjDFpkj58knwdK+qQPj7zkM7Mp+97hrw3QxuEmyZ/YpBOp/dYG46
	h5WiyiIK9lwqUGxGhP5bIbnQgxzrkhPACOA==
X-ME-Sender: <xms:nj08Z20VKGfwm-BESZwwDfNqRBtCVb0DGMNL2Pq7A0kkVGH6cmf-7Q>
    <xme:nj08Z5Epw30h6A2HJQbsyL4GLp_jXcaT2_mPqMxG3OYOPiR9vqskvMUkJnJ8SjGsY
    2aJRb27GQenPJMFHQ>
X-ME-Received: <xmr:nj08Z-5QfeoGZ3QJooyF0KeriDT7RUw09fTfru4-VsbmkhE8oDhbK9esKuGNXaK0-V50Hu8CA9jdhT3vT2CmLMoF_LYQf-TNN6e9mDs1HIHd2HI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedugddutdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthho
    pegsvghntggvsehfvghrughinhgrnhguhidrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghi
    lhdrtghomhdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfiho
    ohguseguuhhnvghlmhdrohhrghdruhhk
X-ME-Proxy: <xmx:nj08Z321XLI6zCtrvuqR_Z6f2TUU8iw7oDqAOcz0ZkuGcv4TOIGx5Q>
    <xmx:nj08Z5FYBy6-J0dnZV4CekGP3tuwvN2mb5mdZ2_fCgW0pbRDctSFtw>
    <xmx:nj08Zw-YRRcKECTPoduPxmd9oXUCMXDbJOJssMigH34EMUGyVosVgg>
    <xmx:nj08Z-nJsBG5TTe_VdFB3j8FZIcsnO9sM7M8KUGa5jCiZ4BV-_vo7w>
    <xmx:nz08Z_ZQ-qdAIiy8Oxr-rsLJapqr8Besup4sMo5eJ1HxC7hw2Vcu6317>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Nov 2024 02:26:21 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a6411f75 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 19 Nov 2024 07:25:29 +0000 (UTC)
Date: Tue, 19 Nov 2024 08:26:08 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Bence Ferdinandy <bence@ferdinandy.com>, git@vger.kernel.org,
	phillip.wood@dunelm.org.uk,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	karthik.188@gmail.com, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v13 2/9] refs: standardize output of
 refs_read_symbolic_ref
Message-ID: <Zzw9iqf5bcj5_lV8@pks.im>
References: <20241023153736.257733-1-bence@ferdinandy.com>
 <20241118151755.756265-1-bence@ferdinandy.com>
 <20241118151755.756265-3-bence@ferdinandy.com>
 <xmqq4j44ggq0.fsf@gitster.g>
 <ZzwzrI6wJjY2dpp0@pks.im>
 <xmqqr077d88i.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr077d88i.fsf@gitster.g>

On Tue, Nov 19, 2024 at 03:54:05PM +0900, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > The reason why I've been proposing to return negative is because we have
> > the idiom of checking `err < 0` in many places, so a function that
> > returns a positive value in the case where it didn't return the expected
> > result can easily lead to bugs.
> 
> I agree with the general reasoning.  I am saying this may or may not
> be an error, and if it turns out that it is not an error but is just
> one of the generally expected outcome, treating it as an error and
> having "if (status < 0)" to lump the case together with other error
> cases may not be nice to the callers.

The question to me is whether the function returns something sensible in
all non-error cases that a caller can use properly without having to
explicitly check for the value. And I'd say that this is not the case
with `refs_read_symbolic_ref()`, which wouldn't end up setting the value
of `referent`.

So regardless of whether we define this as error or non-error, the
caller would have to exlicitly handle the case where it's not a symref
in order to make sense of it because the result is not well-defined.

Patrick
