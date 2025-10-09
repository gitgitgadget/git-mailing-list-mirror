Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5452D17A2EB
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 06:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759990202; cv=none; b=YKoa9swFWGXQ8N8YwHZNCOkyYqRZYyjFqkq9fViqOs158MlNXj1ne3pxjFKs9CXzzvU1BZv8s4+0mUWu+qfS77vIWAyBuxvOisiMxkprZQGxIGmBH6dpUHSdxFk3k5QniJrXYlZTr4vqIHe4IyKLdmoZW7FXUgKiPEu7qTKoUMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759990202; c=relaxed/simple;
	bh=vz+kZevn85TFbjkfG9ItasJ0sDUW9yySinyl4hA9el8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k1dNHEBCxEsqLa+EIGMsiEW4k73tzKOK7yPGjDBtlIIyw+d8F01fipXYN9T2FqN2/ilBzdCNALbclIiN90jrqxYb3rxX29m2l2XnzO4s0mXuALUyQSwAzj7YzDIRN7LksTn2kbVnrxs7b276yspgni1HEqwUsfH79AX/CwMhWjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jFPCu+W3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kyqvdcmh; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jFPCu+W3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kyqvdcmh"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 66C731D00132;
	Thu,  9 Oct 2025 02:10:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 09 Oct 2025 02:10:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759990200; x=1760076600; bh=airNIFoYcj
	ZH7YLSiLHtzbF5Ux+sZsj5/hkSVvMzymw=; b=jFPCu+W3DLRZodaQoHi+DeRYgO
	6j62zSI4VREAUfRp7ZqIip4SIrX7m4b1awL8r+HXnSuJVvwz7MNtzOO9k03ZEVn7
	TcRGXfvHR3Tct8UsQfdPoCvat1IIC9srpud9sKEDyz9l9uIP/orpnP/EYWNppMyM
	6SSEKmWUWmP3qEL6Jb7zr63qDD+NenGG9+8CRy9/OYHaKN0Cw2ug3LfW2iS7EAlX
	KwH6qCG5xP4+9fPkL6JNZ5NEnEe5DUGf/1T6rBG7QaYFMs0aJfE7x7xO9SFp0m5i
	AI2CuYphy2qZM8TnLnTjFUsqGxeb/Wo6UpfZBFI05d9aLF32tKwACO5JgsYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759990200; x=1760076600; bh=airNIFoYcjZH7YLSiLHtzbF5Ux+sZsj5/hk
	SVvMzymw=; b=kyqvdcmh0vmpIuUHZe8/YjPojyDdJoJw2syzZPPOqagXOcoRDSk
	rldFU1fMVP+1h8UJVPbCHXpv8bhPM5FBQTIAsflKEk3fzGuOA0G+PX6dthnS53GP
	5AKU/2YtWp6rmLMEmAR8Z3gKoidQg62QYqIWjgiGTcY9gyWCNhesHvetiM1LVMHH
	r/whUOUcJvR1FzJEXQvRaZHV/1W962gRlsUzVvJpC1M96jx5WjosPPBKktgVhX7H
	OnrPBqGal5Mn55uTJc1hjcMbyRLIUPW21n+E6GplsEl3CmWaOr0c2Q7aFulKo6qz
	UQsQdNVc4Ivoh3P5Ie7nN3GicI+cq4GXspg==
X-ME-Sender: <xms:t1HnaEz20Npq0TmydCnWCb8JqFQhAM-oOe_2HNPEM2kQgbSePfcRXw>
    <xme:t1HnaKgqH92y3UH48P8lae84T3PcRol_IcfHOlpZnAbTc7PVmZ-ZY1J4A_aL6q3Vb
    RGd0G7WHIkB_NHjvjPxvDbHFtR4jbpBxIW_ox9zk02MoOA6FLukxqA>
X-ME-Received: <xmr:t1HnaIn1uxS4jdwEA7Eyp3VByd0KEkZXEEPhlK9rOONxW1D9_8DlpEgD_KcKDZ3MC3iFPwkAQXWewNK4c9K2aYR0nPkqTfm1w3azBbu03W0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdehgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrg
    hughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgih
    lhhorhhrrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhl
    thhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekke
    esghhmrghilhdrtghomh
X-ME-Proxy: <xmx:t1HnaIgPnGnh1MixdfklUNAsuKapmHSaC7B3TvbTsei6B5dl4uFwWw>
    <xmx:t1HnaE2he7bSTUcj2yoE6CIpEhVxvNo2qzS0H-MV_YVcaIbrAP8tmw>
    <xmx:t1HnaJI72JDE313aFNiziWcfBT9V2edKRhRHX-opvqT3rUAm1w6aJg>
    <xmx:t1HnaMzkCOyn9itnkebGSnOi2hlpyGhSMWAy4yhppIyU1fdncAkCxA>
    <xmx:uFHnaHhOxCVc_CkSRVuC8mqsLoHYlVN3GkC0s35_z5Ur4P_OiMr1LKuk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Oct 2025 02:09:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5c833923 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 9 Oct 2025 06:09:56 +0000 (UTC)
Date: Thu, 9 Oct 2025 08:09:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 00/14] refs: improvements and fixes for peeling tags
Message-ID: <aOdRsR-k77uTWJRb@pks.im>
References: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
 <20251008-b4-pks-ref-filter-skip-parsing-objects-v2-0-76e30d5c9542@pks.im>
 <20251009053825.GB1614343@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009053825.GB1614343@coredump.intra.peff.net>

On Thu, Oct 09, 2025 at 01:38:25AM -0400, Jeff King wrote:
> On Wed, Oct 08, 2025 at 05:50:15PM +0200, Patrick Steinhardt wrote:
> 
> >   - Patches 1 to 8 refactor our codebase so that we don't have the
> >     `peel_iterated_object()` hack anymore. I just found it hard to
> >     follow and thought it shouldn't be too hard to get rid of it.
> 
> I'm really happy to see this hack go away. I've wanted to fix it for
> ages, but didn't want to bite the bullet on changing all of the
> each_ref_fn callbacks. The approach you used here to pass through a
> struct looks good to me.
> 
> I do have one minor complaint, though: the name of that struct. I have a
> feeling that the name "struct reference" may cause confusion down the
> road because it's so generic, and because "references" and "refs" are so
> common in the code. From the names, when would I know when to use
> "struct reference" and when "struct ref"?
> 
> Could we give it a name that ties it to the iteration interface?
> Something like iterated_ref, each_ref_data, etc?
> 
> I know this is minor (and will be annoying to adjust your series), but
> I'd rather raise the point now than realize later that it's confusing
> and try to change it then.

It is puzzling indeed. I would claim that in this case it is not `struct
reference` that is misnamed: what it contains is as close as you get to
a representation of a reference. It's rather `struct ref` that is
misnamed, as it carries a lot of data that is only valid in the context
of a remote.

Another approach could thus be to rename `struct ref` to `struct
remote_ref`, which I would claim would be a clear win for better semantics.
It's used in lots of places though, which is a valid counter argument.

WDYT?

Patrick
