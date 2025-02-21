Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659351FE470
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 08:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740126971; cv=none; b=ue8p8FFNW5H/UJOWPfW7r0MlD2jkP+KzylTCaDIN3V+9yglOq0lDoMSmZRg9/Q+AI/q3Q5Ej88i9rTL6f4nYJj9xDc4gRHjNQoQn9lGLEnZrddMcbnDjD9svuw0TEB9GpYmuZqItLkrXzjsSW4HOlvrZI0+WBF5L7GElYgyyFz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740126971; c=relaxed/simple;
	bh=BKCH0q34jHMrt/DjfgqfikmXrDou03Y+agxilhX+vM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IURfqwo5nVFVb6d8k+tbb1H9BQoBcqbiAs9U9jOGa6jXOmasOicVhIL7nURYlW3mubEVDslkOQSuFY8Wptgr/ZP2lshNwjHtn0kwrvWtoCuCGm7BSMZLx2sv0nHerwt2MrEzIWl8UVfQUiZAaVpknciAxrUo/Y8kYqS3XkgxdaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RDPpUeV5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jfijmHlE; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RDPpUeV5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jfijmHlE"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5436D254024F;
	Fri, 21 Feb 2025 03:36:08 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 21 Feb 2025 03:36:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740126968; x=1740213368; bh=/7oLn8kFPe
	3vOcgYl0hO4ibCZ6Pht+CdpSGKQqpyxSY=; b=RDPpUeV5mXwP9kMOndEKw604Tu
	r7rUBBiPvxw0TUq2EFmhzqq5k2ECHWH0dKaJ4TWdFnjObI0wZpqTCUDxGDdo5MNM
	qYcONrHVxst2R09m2nEkIDYhgkAXENdK6KR4v0U30LJwLkXqLkAxMWB36BlhlfO8
	yCI/rsOjmmclCM1vevPT1WmB/hQ5aVeoF2eN9kHMQHb1yx5HsOkGnHWFePUnkE2l
	rakwyPHlHGElEEviUiDR4K1tfVAmw+6n9EZVpa+VnAngizefjaNU1LE15NtBU1s+
	pOxdRhQuG5IH/KFUQfHLOAhBTbi4DU6Qz8URhLlk+R9XqtdIj9eoZRZyyEUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740126968; x=1740213368; bh=/7oLn8kFPe3vOcgYl0hO4ibCZ6Pht+CdpSG
	KQqpyxSY=; b=jfijmHlEH/ZFpne1XIdhVbzYcM0ute/MF/iIcogilSI5LleU8hj
	XpHM6m+f4EgcdmQzmiAXzQGV0tqGXAyaC03ASd9aWFNQPhjyl7YztedS/A3RqiVq
	l3Q3rbI7OTW3FAZwl3+lMtZs1D+OUa/8zujOeD7I/1ZJW0r1riP2oJEj2s+o4bsx
	hsmlFN8USuf9mNuzzHNBxygoaZV+YrMFvx5E8siMHGO6I1PJZHesNyb51CT5wYZM
	tYQV//cJwUzmxsBzYNSlfXLPfiaWHpElVyWJCd/6NNJ6pdZHQ/lFcCgJZzjT0x88
	voWNXoKDjD7JXt8nGsWudcqOhzk9dXxfKIA==
X-ME-Sender: <xms:9zq4ZzoJWvJMsSG8P3Mlgy3_7VDqNwb9RkVlUHLNC1Shx-G4gTTNiA>
    <xme:9zq4Z9olDionMq_C51fr3Az8lxRlp83uUIStiuS_U0vLeHNgASONSJl3sISUEzQRy
    NgLx0xXHt8u4RMz3g>
X-ME-Received: <xmr:9zq4ZwNSYIY9nB7dY5lL6hE6LD9YO83me_W3KwDudLCxED7xr9RTbG9JVjRCSsqV8WSe2vZijTxQHxnP8tZzrVFsKUWOtZqGP2qfMW3LHCXHMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeileehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehsrghn
    uggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdr
    nhgvthdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpd
    hrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:9zq4Z24JWTrRNKbFKsWIxQtLBTh0ihqmfcydBafwIoyfgWRXMQIavw>
    <xmx:-Dq4Zy6cDSiHlFAgA5Ly_g8bW6S91gM8A-Y12ipt8dXlGSLp9N7AWw>
    <xmx:-Dq4Z-hva6edWYNJDlmugAcXSlbcj6paHYpXPhEZYgeitRn7y6bvqQ>
    <xmx:-Dq4Z06nxptu2iMs5BSqIddUeJsp2x1W9jU4GjApolZW16LCthdANw>
    <xmx:-Dq4Z5baFKNMNOHtN_R3bhMnYSnoJNlI-_x18ZqCpks3RnveyYdRNTXS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Feb 2025 03:36:06 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9da7557b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 21 Feb 2025 08:36:05 +0000 (UTC)
Date: Fri, 21 Feb 2025 09:36:04 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, shejialuo <shejialuo@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 02/16] object-name: allow skipping ambiguity checks in
 `get_oid()` family
Message-ID: <Z7g69C7Y-CXIUrRn@pks.im>
References: <20250219-pks-update-ref-optimization-v2-0-e696e7220b22@pks.im>
 <20250219-pks-update-ref-optimization-v2-2-e696e7220b22@pks.im>
 <20250221080003.GD1988395@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221080003.GD1988395@coredump.intra.peff.net>

On Fri, Feb 21, 2025 at 03:00:03AM -0500, Jeff King wrote:
> On Wed, Feb 19, 2025 at 02:23:29PM +0100, Patrick Steinhardt wrote:
> 
> > When reading an object ID via `get_oid_basic()` or any of its related
> > functions we perform a check whether the object ID is ambiguous, which
> > can be the case when a reference with the same name exists. While the
> > check is generally helpful, there are cases where it only adds to the
> > runtime overhead without providing much of a benefit.
> > 
> > Add a new flag that allows us to disable the check. The flag will be
> > used in a subsequent commit.
> 
> If we are going to switch to this and get rid of the global
> warn_on_object_refname_ambiguity flag, I could see it being worth it.
> 
> But when I looked into doing that, it did not make much sense (there are
> too many code paths that share the same get_oid calls, and you'd have to
> plumb the flags through the stack).
> 
> So if we are going to leave the global flag anyway, and if your patch 3
> is just changing all of update-ref to pass the per-call flag in every
> call, why don't we just skip this new mechanism and have update-ref
> unset the warn_on_object_refname_ambiguity flag?
> 
> That makes patch 3 a one-liner, and patches 1 and 2 can go away.
> 
> -Peff
> 
> PS Sorry, I haven't looked carefully at the rest of the series. I've
>    been moving houses and am way back-logged on Git stuff, so don't
>    count on me reviewing it anytime soon.

Spoiler alert: I do have a patch series locally that gets rid of the
global variable completely, and that series builds on top of the new
flag I'm introducing here. So I'd prefer to keep it so that we can
eventually have less callsites that rely on global state.

Patrick
