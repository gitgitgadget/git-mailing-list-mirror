Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDBE13BAD7
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 07:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732607012; cv=none; b=JrYo54O8KgKy5yLmfJQmbeStoI534TvaMaJAvOuUEom/ZcwBl5LhhB9SpRFsXKsQyp7koZOJWC/Ig2ilCXKukynrGQY6AYASgnDgpqc4wDdaFQcS1m3je5L3GYfCO2IvFHv0B8PgDwlBA7j8j6JWmtyIMMip1G9b89Lla30PeF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732607012; c=relaxed/simple;
	bh=GepvrGUdOnxp9bv9TTX/LKYHu/9aayXjOlzoA7WrMis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uHyiC2/QNpcDRlo57CthJo35KLyEq770qt4oPPcgzk4OzkGP7lhIJQr5fZMkie1Fbni3ftswfuaUkPLaL4aeVSkxtAMgGJeS5byOUhHNSRcMwrBzo+UudpP6+4hUD0PC/J/i20SVbElG0sZXBYrLje/May4bcW8UqJFQzKDvqH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LwGSn60T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ucGLkkZc; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LwGSn60T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ucGLkkZc"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E54A311401A2;
	Tue, 26 Nov 2024 02:43:28 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 26 Nov 2024 02:43:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1732607008; x=1732693408; bh=KjHJttSwFJ
	bgDjdtDUQAI3cUIq0pjjSI2sY1UUcqo3s=; b=LwGSn60TVXaWjsjVC1HPpKE1OC
	QL0qvGNuGrXNvFqdIpsyuofQoxRimMfe7bJ37DRPzZmOL0nq2T3yiYmmmsFw9m/h
	WXwCYgcuBzlWPrusWoam+v+x+3ER80WZLrkHhCKQqloVdQiRvXdOZKeg8A5LaCFD
	96WuJOyI3l9vYVxJ96GR9lSA4xgTdI5aRFhk8pTxO481E9YuuCC5kbNYs4sKVtj3
	qXYfeOCUkpiOuaLDEw2azzcUjnGXoeo3oVRUPiY2pNrnKYpZw5Qq2JOvbvrFdC7P
	t7BcHeivRSn4A303MOldCia3Y/3JKO0uUFg7BtRTPgWLy/RKzwsGbH0CQvLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732607008; x=1732693408; bh=KjHJttSwFJbgDjdtDUQAI3cUIq0pjjSI2sY
	1UUcqo3s=; b=ucGLkkZckL/t05IIvHbo+1U5GlagvWLfcwaDMFGeLO5dfDJygmY
	T5yjyZuWsPMCnpmly2+ynYPFwjeNXAcPXAgkWr6Zx9gFYCPbE0iQ25gvY1lo/8Ws
	n5Clc1cuoA36XGrAwJgCadITd09TwtZRhIL00x1cSxpddNJl+EuyPphMJsV121/n
	4zC3T/VUp2PbXI72VOqdYUpG2VCCisf/k/EAvDQcF/JL3/6tYbxuy6dYQdATq/v3
	qE2anlM5S1KrgGRao4AoO9bZR2+MC+rcdlGRuysjvZCHEY/ESJQUJ/8RFF2GQ3Ps
	e/AjHcarm7PVSS/qj5srDZWrvzMrl71PFnQ==
X-ME-Sender: <xms:IHxFZ_D2uaRbuzCKfuOqYu3zQzfVRw-4bEfUNeZom7eKL1n99PumpA>
    <xme:IHxFZ1jgP0SZe-9RaM2sOraF0BxF3kRwqat6Dl3GonfrdNcocvrRfrq2JppXDgBQb
    Cmcx7CCGJHrwH_8gg>
X-ME-Received: <xmr:IHxFZ6ntQYsbqUxKU5DV1h4n8ozetDM-tgOT5VZeefwQsP8M_Tpf2XWcOUIoTjWCsJyn4oynQspOwKQgLDtgV4sIWjh1NV1yyb0dUJRDFw3zpN5l>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeigddutdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepudefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepmhgvsehtthgr
    hihlohhrrhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    jhhonhgrthhhrghnthgrnhhmhiesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhhishhtohhffhgvrhhh
    rghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesph
    gvfhhfrdhnvght
X-ME-Proxy: <xmx:IHxFZxxzR3HKUW5SJ3YdjX8ZXsnOfUIDvHgHku2OO38XVBs3m92V5w>
    <xmx:IHxFZ0Tv6g7d66rdPjX-lBxC-3GnCWkNpjmkxBoXNuc8RDKlhdy2zQ>
    <xmx:IHxFZ0aUlXiSo-fJcMEKnbM5tRec6R4NjnMUV6kuPfPtVYwJqSA-bQ>
    <xmx:IHxFZ1SXDJJkWE3DWGgfzRR7rKn0Vhp80JHKJsEBPsae6j9-JViI9A>
    <xmx:IHxFZ2A3c2LXAIL0V5UQ7Vxaf60b77mAEcbW0PmjL8ufT9kK1xrVxWst>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Nov 2024 02:43:26 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5335b005 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 26 Nov 2024 07:42:21 +0000 (UTC)
Date: Tue, 26 Nov 2024 08:43:11 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>,
	Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, johannes.schindelin@gmx.de, peff@peff.net,
	johncai86@gmail.com, newren@gmail.com, christian.couder@gmail.com,
	kristofferhaugsbakk@fastmail.com, jonathantanmy@google.com,
	karthik nayak <karthik.188@gmail.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 0/6] PATH WALK I: The path-walk API
Message-ID: <Z0V8D4r5YbxjNvPs@pks.im>
References: <pull.1818.git.1730356023.gitgitgadget@gmail.com>
 <pull.1818.v2.git.1731181272.gitgitgadget@gmail.com>
 <Zz+61fat+vGgb+xL@nand.local>
 <Z0Q7oGF6Q5U-f4VX@pks.im>
 <xmqqa5dmzboa.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa5dmzboa.fsf@gitster.g>

On Tue, Nov 26, 2024 at 04:39:17PM +0900, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The question of course is whether these tools require the path-walk API,
> > or whether they could be built on top of existing functionality. But if
> > there are good reasons why the existing functionality is insufficient
> > then I'd be all for having the path-walk API, even if it doesn't help us
> > with repo size reductions as we initially thought.
> 
> Is the implied statement that we didn't quite see sufficient rationale
> to convince ourselves that a new path-walk machinery is needed?

No, it's rather that I didn't find the time yet to have a deeper look at
the patch series to figure out for myself whether the path-walk API is
needed for them. So I was trying to prompt Derrick with the above to
find out whether he thinks that it is needed for both of these features
and if so why the existing APIs are insufficient.

I'm already sold on the idea of git-survey(1) and git-backfill(1), so if
there are two use cases where the API makes sense I'm happy to have the
additional complexity even if it's not needed anymore for the repo size
reduction.

Patrick
