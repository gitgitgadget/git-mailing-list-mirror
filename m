Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E2F258CFB
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 09:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740561358; cv=none; b=HUj6ivbpkByLQS3vhfxDAdENxT+f5FdZIO2LH4A5alq1AL26WtQfivl/QxrzfYDy15eiMyl8WTU3ePPk2ZuhZoArGt4GPPR9FUpcesxvYOPJHDqSWLDmk/rYOyZQj7cPGlvNCFB5BNpXEzl4QYrLPSeCcAnOK7M5SlTAMZskAQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740561358; c=relaxed/simple;
	bh=aKMXKLJlumINy7rBoIBN8Rx2wM8ZNH+HsoVyaW1IynE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXfJHq8Ab7I+wPyAWLjjDFlIk4LfsC1xAlQwCUrBd85/YCf1+3aBe7LyKpTqP4nRLKqE21Q8085L7Nb3CO6XAvvwO+SHk/h6Zc1O615T8OsmmKGU9VZwd+7wFeoUgiosoEPiOhCbrl6/3/yx1jE4BMhWpBjk7VVhgz5mLxSrR2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cNeKIdyu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NwGzIOQ7; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cNeKIdyu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NwGzIOQ7"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id F3E941380F14;
	Wed, 26 Feb 2025 04:15:54 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 26 Feb 2025 04:15:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740561354; x=1740647754; bh=4CC9FChdCy
	C2stwFzccPIx33bvz0x3GB0Az3kFzHZGM=; b=cNeKIdyu0TctbP3maPCQJiVWC0
	syy3Sxa7KyZPxrMcXOO2yxNQpcPx83uy96+4cMMzswvsyrk+FrL5MPun+3oFmzBB
	P6FX5b5QhERTbdCvJKDrebgyUB2mE7I0qAOpSyDfrOojk3suBuUIfyq09GnIaV4Z
	Y9GXQnLdA+28vijX3ope41kq5yp31yCBY7OX3+bNmgBN47poxiED7816juWk2Qpd
	PSvUoR1oZFKks/qV5eLBito/Sc16WNIoXEJFA3701jbOnsw8JbDgD2UjBy/hnHpL
	UymUGx/Zjmh2G73FHYrC8ypO+6oLr5KAmkL8XuZxnAP4T0lfh7mkBruteRgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740561354; x=1740647754; bh=4CC9FChdCyC2stwFzccPIx33bvz0x3GB0Az
	3kFzHZGM=; b=NwGzIOQ7o5ZkWz1Ru4daozuflEOJF7DooruFcnw22X6FibmQoxA
	T2QL/FxEjZNXPbJxexGa1QmFMmN0glIBBmoZpdvLnEtI52SOOF+AQxHaJZos1ovQ
	TP3iIi+YX2sPqJ1VG/G2wp+0BCd6BEVUbo8Wol/Z8LVtvo0rJn1mR1uhJDkJlQk3
	5SWqlR5O6rsPnhpOXIVvuoSnWE8+V1NsuaqkCWCyMJXKIDTLvwblbnF7JTWWT3Ek
	kD5nKhLnTsMd4+Z9QcATVYX5+i3KcqoZB/FjKsJ7syMQL+xC7qJWz3pR70+oJw7S
	UxpeHqo1C5cV+skovGD3yT5An+OLSGgnpaA==
X-ME-Sender: <xms:ytu-Z6VvJ0YVz_OviUkXihjeDEC5TWvMlDevfj5PTYHzc93KD0x94g>
    <xme:ytu-Z2njKpceBzY_FXQz1MO1Jtbmmg0ra7jNi-kQRR6iyXY5j-FFsRrrBiBFS__oc
    rE7oaNdLeWn0ucerQ>
X-ME-Received: <xmr:ytu-Z-aBv498dHurNsS6Z0IA2-rukijoBULzvc1fOZrnv4VZ2ReX61HaekWNWd8sz66JIapjB5l7LFhkEPonySCiNZ6hQ5Em3u3NaYBlpxufKuRT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekgedvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhf
    sehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ytu-ZxVfKrwSWe0LMWDjLxXmbHsFCPsx49jQQmclcZUq7qixh9Y9Lg>
    <xmx:ytu-Z0keF0kaA3T7n-3SHwjm77GcNC9qFcUb3iq_mRaccYyaFFHA9Q>
    <xmx:ytu-Z2cXQJ6hVef3iq94jVdZPLhmThWU5U4auq-XzrJlj14VVrkZlw>
    <xmx:ytu-Z2ES4k3PptTBTXDRXmue4Irt7MIsrXOuMG8iNc8eQOSPjmR3dg>
    <xmx:ytu-Z-hiV3XWTzox_6WwtJ_7v6EUn9b5qL2Na4JlrHDHJ-7DHZd103pp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 04:15:53 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3e14ad0e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 26 Feb 2025 09:15:51 +0000 (UTC)
Date: Wed, 26 Feb 2025 10:15:50 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: win+Meson test failures due to ps/build-meson-fixes-0130 topic?
Message-ID: <Z77bxuad7pFsz7ow@pks.im>
References: <xmqqo6ypiz9w.fsf@gitster.g>
 <Z76qYgV7B2eUJHiP@pks.im>
 <Z77EJRJwPDGUglLk@pks.im>
 <20250226074653.GA27455@coredump.intra.peff.net>
 <20250226082002.GA30633@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226082002.GA30633@coredump.intra.peff.net>

On Wed, Feb 26, 2025 at 03:20:02AM -0500, Jeff King wrote:
> On Wed, Feb 26, 2025 at 02:46:53AM -0500, Jeff King wrote:
> 
> > I'd imagine that if I did a complete "rm -rf build && meson setup build"
> > it would work. But it's pretty lousy to have to do that preemptively
> > during a bisection.
> 
> Looks like this runs even deeper. On my Linux machine:
> 
>   $ git checkout origin/next
>   $ meson setup build
>   [...ok...]
>   $ meson compile -C build
>   [...ok...]
> 
>   $ git checkout origin/master
>   $ meson compile -C build
>   [...]
>   ../meson.build:215:35: ERROR: The `!=` operator of array does not accept objects of type str ()
>   FAILED: build.ninja
>   /usr/bin/meson --internal regenerate /home/peff/compile/git .
>   ninja: error: rebuilding 'build.ninja': subcommand failed
> 
>   $ rm -rf build
>   $ meson setup build
>   $ meson compile -C build
>   [...ok again...]
> 
> I'm hoping you can tell me I'm holding it wrong, and there's some way to
> do an incremental build when crossing these sorts of boundaries (without
> blowing away all of the build products).
> 
> I do at least use ccache which makes the "rm -rf" case a little less
> painful.

You're not holding it wrong. The problem is that this patch series
introduces a backwards-incompatible change to the "sane_tools_path"
option as it changes it from a string to an array, which makes Meson
hiccup. Once Meson is not considered to be experimental anymore we
should refrain from changing option types going forward, but until then
I consider it to be okayish to break things like this.

From my point of view we can treat Meson as stable as soon as Git v2.49
is out. So from thereon, I will make sure to not include backwards
incompatible changes anymore.

Patrick
