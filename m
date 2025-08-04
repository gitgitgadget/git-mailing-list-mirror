Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AE32288CB
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 06:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754290488; cv=none; b=iTEi+LvYmV3/P4ZSdOsjaJsU1eC+hjGxFqyV+yjg/AsVsXfInd2VSxsFi5Xzrp0/2hrf4s99E5lYIeL8AyJXkEQ3ior2RR5g3156SrdJt4TRby10QaKZbTAFO6kZUz8uGRQUQsLu9mGdUa3Iiuw+9UMGoBQADCBcQhj7DT56OVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754290488; c=relaxed/simple;
	bh=fD7vzLSM8YG6A7iVBl673Jm1lR3tRHMKiwUzpjnRjGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NXYTHpjMODMqVraPJ1r6YoZLQaZXI6oCA409mGdRkAW8tOOQwYOysx1tCW82yPoHpO5gxzu7hqt1UcVWULTrejcoKe2e9IfaVXf5hZQ+WFuKrqcmXkpqIg+Va91j/f1zzRrq9gfCUYm5KHHq6gJeA6nfKA3IkiFHb52prdkKmFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MxwIYniF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WS6tT/d/; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MxwIYniF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WS6tT/d/"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 936A67A00DE;
	Mon,  4 Aug 2025 02:54:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 04 Aug 2025 02:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754290485; x=1754376885; bh=ZsfCJCcma6
	Xvir5bQqNvFEgcwkCAf0OfVw1vvDTX/qo=; b=MxwIYniFZgk5hj1HyzpO3tzLLh
	EZkHUgm6eIUUsn++gjWViuJNo+T50KOqH51NP33juwoXi1aKOgCArgdqjStpJYmv
	A0V8qUWa0S69/0h5GnuqQiqu9BVYEOVmG7LRLNkUR5HAyFAdOeLifO0Dv5ecKCmG
	FswaoELNL7QnRjD48YE+9qn6WZR6D3S/baGZN0zQoqsmrN8JX9q6+gFSds4Mzn/q
	vYQgx5t3n20txv40/IstkXmVheZXrZcfUmI2x2b0OJ+XC/hAsihbww5C1chDJgEr
	+hBOo+hoIMqcn+4JkUI5RbmIYRLhNDNSj0L9zaZZJxmEUzeAQtyPkTfnXNuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754290485; x=1754376885; bh=ZsfCJCcma6Xvir5bQqNvFEgcwkCAf0OfVw1
	vvDTX/qo=; b=WS6tT/d/hCGJizEm3yv5Q6fYnDoU1x6bC37xug3JbEF2ojeis+g
	OgX6wu24AdlJ2D6CrCXtqjvOX4lg1Q5pbn+j7VJ7tlmgZGyaJQGlLHOn8NzRft07
	/Cw+SCU3dxqEqIEzJclyqqJqUQh1iLZV590S7OMoZpbknHLq8sOdEem8T2SNBALk
	Qtu4YUji4tOXNYwVUYqIAWS38n6xMba3lqaSOXwtzpD18aS3h5GIxalSY+yTFOIn
	gI1bvae/xK1/T3XNyY89Q7SuTFsrKSImsN4s6G6O9rRfUPjlFuIJTtdwGbVkF0Zl
	M9lwZvdTWxhHbWka9EClhLIw0vdhJ9u9JLw==
X-ME-Sender: <xms:NVmQaD5frUqjM7SlJQE4t2lZtm7ZHnfGSzBu4oOjpprXArl8X8JquQ>
    <xme:NVmQaBWcTmlxQ1QMJrXHMQ0KP6wm4KhzhiRJnlIun8g5SSIbsLtxtuLqJVwxLTGhe
    qNc58kxZwbX_d7R2Q>
X-ME-Received: <xmr:NVmQaK7C_HPy1vTbeFkbbPkk51qrxY7JSpCZ1foJOz1vBaIaiAB-2gWQpYgF4Qqi-2Wu3yqmJTi8XebdBGDecXFocBn0R-sYMItxrk4i3p4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudduiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhhtggrrhhltd
    ekudegsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdp
    rhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:NVmQaEoHZTzIn26vpBogMUB0m2YvIsQO2toO0hgZrcyFNkOXju0CsQ>
    <xmx:NVmQaFm1-O4DErOc4LtRqCPZ4YZjBLBC6ql0i3NTnKFIUZUtXRZHpw>
    <xmx:NVmQaIOj55zFpNzX45NI3uuceNeB3DaCKZrXRIky1I9-Ytev23EEVA>
    <xmx:NVmQaBNVGkE6TtZCk2sIxK4Y51EM6V0VNKSKKgUJhF8IKbTW06qWWQ>
    <xmx:NVmQaAXca4SLAtpfpowubYtYNmsfxBNR5yQ5C9b0QMP--Mdy9nPMVUWD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 02:54:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id df8dbfad (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 4 Aug 2025 06:54:43 +0000 (UTC)
Date: Mon, 4 Aug 2025 08:54:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Han Jiang <jhcarl0814@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 5/6] builtin/remote: rework how remote refs get renamed
Message-ID: <aJBZL9B4foXZW-ix@pks.im>
References: <20250731-pks-remote-rename-improvements-v2-0-dda6f083674d@pks.im>
 <20250731-pks-remote-rename-improvements-v2-5-dda6f083674d@pks.im>
 <20250802104533.GA1180347@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250802104533.GA1180347@coredump.intra.peff.net>

On Sat, Aug 02, 2025 at 06:45:33AM -0400, Jeff King wrote:
> On Thu, Jul 31, 2025 at 04:56:53PM +0200, Patrick Steinhardt wrote:
> 
> > There is one issue though with using atomic transactions: when nesting a
> > remote into itself it can happen that renamed references conflict with
> > the old referencse. For example, when we have a reference
> > "refs/remotes/origin/foo" and we rename "origin" to "origin/foo", then
> > we'll end up with an F/D conflict when we try to create the renamed
> > reference "refs/remotes/origin/foo/foo".
> 
> I think that was true even in the old code. E.g., if I do:
> 
>   git init server
>   git -C server commit --allow-empty -m foo
>   git -C server branch a
>   git -C server branch b
> 
>   git init
>   git remote add foo/b server
>   git fetch
>   git remote rename foo/b foo
> 
> then I get (before your patches):
> 
>   error: 'refs/remotes/foo/b/main' exists; cannot create 'refs/remotes/foo/b'
>   fatal: renaming 'refs/remotes/foo/b/b' failed

The test case I have added for this conflicting case only fails with the
postimage of this series. So we hit some _new_ edge cases now that
didn't exist before, but I think that's acceptable.

> Worse, we moved "a" but not "b" (nor "main"/"master", which are
> important because they are what's blocking the rename of "b"). So we are
> left with a broken half-moved state.

Yes, this half-applied state is quite awful.

> After your patches we get a nicer hint message, and of course we retain
> the unbroken state from prior to the rename. So IMHO it is strictly
> better.

Patrick
