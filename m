Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BAB20AF61
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 15:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736782948; cv=none; b=IRND9TXPzLV8mxLdhXRaBf/ig5gWQt3hfvCxGZBT7f2FaoHYH47lGLSBf7T1xeoT8UgGICFTESkK8JDtTw9o4XI2M4QIkgmvmHqdvusDAfvIjynO6MspSz7dP81fRzT1Gg48h2uesV5TEzfYRKMqplSYgUH+vgFlp0gL13bRz7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736782948; c=relaxed/simple;
	bh=SmAS1slvaK7HGDeeHChK/ymYsv64SL10Hl9Jafbb7ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=asVQn6hCmNet5RBYnTCO2N2G/WAWKbXB6o+rwcukvEo9vgQ5Ttv9FLt2g6mW5bQIgCnsOfJ5pzawUZKQkPLHwPQ3qpZsb8Sb33yZeyyMqGoszSqvVtagm9n8IfsmJMs5ujOA+hHiVH9CtZvzOEB++H4fx7xb45AaGr3cHhhZ6M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fu1W2Khv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Li5t7N+p; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fu1W2Khv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Li5t7N+p"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E771E1140133;
	Mon, 13 Jan 2025 10:42:24 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 13 Jan 2025 10:42:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736782944; x=1736869344; bh=K5M3LxneTy
	bXGmcHNNwBPuD4NNAJKhXUVY1GvChjppE=; b=fu1W2KhvS3OViiq6s9SBV/6zF/
	Pjkdt5MoYDyuR7OHh68w7JLtokPS5E+Xn+BhtHeeo9U02CMYOSqr5SYWAlhFrTeF
	fXDoBwPHeiQWbnf03f30dHEhnnuksh0v7HtM332kwWrg0u4Q/uz0dg4xPPoidcbs
	WEgsgyyEyKUySgjGrc35I1ShKVmurgMf6m/snoIIIzsn4BC7B3wDu9L7DxnXd/wa
	Tqx9AZZ7ctLcJocp9nXzFfkuMqMY/OkZZnkELhfgHxqq7wFGyL4cZ1M3l+7hCzmA
	j35EmY9M6+5uCY3W4tNTNfMMw5Otcunq6Wa6XrFRyzs4fERkLftBmb0HGyzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736782944; x=1736869344; bh=K5M3LxneTybXGmcHNNwBPuD4NNAJKhXUVY1
	GvChjppE=; b=Li5t7N+pyZHr7zyLIIq9q+Pm7gG1yRo2bATAJbgnW5Ts9laV2QM
	uXuOKzdw+NRWWYsufyedG/z+Y6Dj6mYZ2dBAd94DvcdzV3qT1MpXybmXSCvJnQxI
	rvgiSlnAZSlVLNsogGrTRysd76dOAWfQnhZl+vakCcszju3j0Iwv4Hc09hqc5+J7
	4gdCyHdFcwJ/xEFbrqOoF2NukQNTpn0lMlVcqMHAS+EwlhaE20zMKw363ebr1T9w
	K5bD9qzRw8sxIiLkpNPw3iE3h2LlwFr+WG7xdMLkbp0kwHZnKMr9uuTFP9ss3Vna
	E78rSj5erVIAAhDNkj0WDb7QVNiCeJ0Kzog==
X-ME-Sender: <xms:YDSFZ4ur3x08ojsJ_vRJus-BlKFTB3rVmqm7g6BhgeRVd8yLM2RYHw>
    <xme:YDSFZ1cIdaKQvAFjUyLceUiK5ixVI7XcQDNb3mc9bb8YFqwLX6y8BPBAAN6DlyNcd
    rAnviFqqAHMDs10Rw>
X-ME-Received: <xmr:YDSFZzwP52oiAVwHYG5OnocfdBCTLbYFoWcGqhgst3cTKXtW-rduIiIKBqhdbbaiQRbvl-FUPF26uyxtnjzw2oGs31-3G5nCm1s-yJWoDkOfSU8B>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehgedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepjeevudeggfffffeigeethffgieekveeffeehvedvgeei
    teegueejleeihfeitdeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrlh
    gvgigphigpgihuseihrghhohhordgtrgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkh
    esfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:YDSFZ7PQRHQ1ADawi9VPE-ho343eVRGB16nLr2upGU4oCV-D2WpgGw>
    <xmx:YDSFZ49yFTAJQd4MZkW3_xaJdWBNg3q-jOAy2FsH_wIX8c5ZVpjMwg>
    <xmx:YDSFZzXdyNw4-wPHyRIq6AyiAZKdyartm5oCJbQpafifOlSUWvSeVw>
    <xmx:YDSFZxdfvc0G1nftnHBI8h4lTVz3An9R5zLON9TeUPzGZaZTVntt6A>
    <xmx:YDSFZ3bUmQCxIAJ0hzoMzYyx1eVsYUDAS6K-yAF3jeIY4z03xdpF_NEC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jan 2025 10:42:23 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b80eb9d5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Jan 2025 15:42:22 +0000 (UTC)
Date: Mon, 13 Jan 2025 16:42:21 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>, git@vger.kernel.org
Subject: Re: [PATCH] meson: move config-list from libgit to builtin
Message-ID: <Z4U0XengqX_a7ywU@pks.im>
References: <20250113134632.21592-1-alex_y_xu.ref@yahoo.ca>
 <20250113134632.21592-1-alex_y_xu@yahoo.ca>
 <efb8b6d1-c06a-4f73-89bb-6d164ab03cfa@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efb8b6d1-c06a-4f73-89bb-6d164ab03cfa@app.fastmail.com>

On Mon, Jan 13, 2025 at 03:17:08PM +0100, Kristoffer Haugsbakk wrote:
> On Mon, Jan 13, 2025, at 14:46, Alex Xu (Hello71) wrote:
> > config-list is used by builtin/help.c, not libgit. this matches Makefile
> > dependencies
> >
> > Signed-off-by: Alex Xu (Hello71) <alex_y_xu@yahoo.ca>
> > ---
> >  meson.build | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/meson.build b/meson.build
> > index 0064eb64f5..ef3604a17f 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -614,7 +614,7 @@ libgit_sources += custom_target(
> >    env: script_environment,
> >  )
> > 
> > -libgit_sources += custom_target(
> > +builtin_sources += custom_target(
> 
> Looks like the same change is in another patch from today
> 
> https://lore.kernel.org/git/20250113-b4-pks-meson-additions-v1-3-97f6a93f691d@pks.im/

Yup, indeed :) I'd prefer to go with my series as it also contains a
couple more additions, and because it also fixes the same issue for
"hook-list.h".

Thanks for your contribution!

Patrick
