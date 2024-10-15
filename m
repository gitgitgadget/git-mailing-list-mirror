Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D7F1741D4
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 09:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728983343; cv=none; b=bp+h5kVO9N30/VtejKVrIRGwV7ml+BLuwZn6Yeigh5AUXofch8cHKcJLzjzrYEixR55W0PbNZjMKTqx86C/hGy/3orgczMYGgRqrtr98F7Y2THM1YbXGg8bGIOJ/SfPlaJz2HT5qrH7mdPK8oi8ROGeMM3hY2xe5OAwWYr5RwDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728983343; c=relaxed/simple;
	bh=MyI7dYgxNwi0QFjFasP72Y/pPDpAhw14zuXFQmXrSVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AkC2IZ7vrPYfA6r+dfr2pVYS2RZZnNBWdQeD7eH+EnWq6Ym5wW+0Pr0kmFDabzGcFlKw8lsDlZQBDleSwACVTFlNWNawBYXNkbkUJruyU1nerrLJpnO4f7G+lajCIUsHhdueLkidHEr4l/9nYFMDCmwBwE6qg944mMCULMW81kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kXpJ33Zi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EEX3VznI; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kXpJ33Zi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EEX3VznI"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 7E9B511400B1;
	Tue, 15 Oct 2024 05:08:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 15 Oct 2024 05:08:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728983339; x=1729069739; bh=R2/AFihqYz
	EM81ADrX20LlYOqLc3csxOzTSU+44akK8=; b=kXpJ33ZiprFbFAzZTvH1FjGNWT
	cdpSKVU+5SxL3M0b/RCqSlHVt5ZB7PyNYmdiDDgtKpVwoMdwYZsiVTlJ5cf3Kztd
	B0T8tATEI25EJUDF039/fDxf3w2+HztKHHLvc23/1ndMffxIPI6zSq0XPQHXHvTN
	oTgksUW9aZMHezrqaICfb0pRgPHTzoRgOsGyKjp5n3/vL8upllKUnoqbJgtnpVGh
	qtzgxMs0Q5ODbUWF+q8RvCXJ3THU+vGFK/8eUVEn7lTkuNCKrctZkahDCq7wLi3I
	mvT1tPhVvUbFTVvyiVolqnIx8lwveiD8mLmZe2Y5GXCtv3qb9QF70xLpkSuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728983339; x=1729069739; bh=R2/AFihqYzEM81ADrX20LlYOqLc3
	csxOzTSU+44akK8=; b=EEX3VznIgXvACHycfPX9vVixbKHoFhi0mScXAOXoMQ+f
	qC/QPAZPjUjkmmmGy9t60tiDyCEQPR8QAJ8gEpUeqUztjFOonRrzLCMFW8jWkCJY
	8Z5Xc6EZ4i+/MXPXPNtvNXc57yeQ3J8FEhvxlsHkI5d/a3cLnd+uSHeVBHBD9jar
	/p3PYcI+Wsg+2lTqI2WbS7kpoXtCX+N7j7kC1gC5bmlPabFLHz5jna71ez30h8kL
	vXY65T0Fk0ZOBIamqIprKMiX17unFg6NpbVDHDPpKrSGD5lm3V3hRWSAIwDxo23u
	5MpScXtvSBEIB1RpcC7NbEHNE73ZLi/OAHcrjeMOpQ==
X-ME-Sender: <xms:KzEOZ9GCUe22AkvDnYuF_6Tb1evytuLRupRNSwcIMETBhrtR-q3dBg>
    <xme:KzEOZyWV3mV31nBwHPgrHQvolS7RVbWQMEU73tvkIbUeuDyhtzWd2ccigw-tLYE0f
    TSNZQgP7C3EEQaz6g>
X-ME-Received: <xmr:KzEOZ_IWQeWMOqRHT1Eibus0B9Q5DfoiYj4wCKc_VGpLBaeNDTw9aZMZWTRYdNmijePcm5K_7OPNyHSQMomK8UkOrJLpH3DN-sULGcN3KMccyw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegjedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvggurhgvvghlsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:KzEOZzGdT19n-yMhnGO5w84JNet-PErWvlsvGYLeiGDxK2eh2Tv_FQ>
    <xmx:KzEOZzW4j79NUIUflPUP07UPWVhZsd2SpeC0y_LuKCMmmU9pZLCqEQ>
    <xmx:KzEOZ-Ooc_c8sOxdEq8MNKqQIR6-pAY7NwYU8QU79Ozb1vOTirNV5Q>
    <xmx:KzEOZy1s3ENBPY3VQRuxpytF4Is-u2kmgM-UUpBJ2n0mkLoRNv-Wfg>
    <xmx:KzEOZ5xzDJHQwXZN-FG0czQhR-H22mg9L-Ex6g0LW6i_ZFatDnpCU0bS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Oct 2024 05:08:58 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a942f5bb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 15 Oct 2024 09:07:40 +0000 (UTC)
Date: Tue, 15 Oct 2024 11:08:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Ed Reel <edreel@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] Makefile: extract script to generate clar
 declarations
Message-ID: <Zw4w9o_YQy4quegm@pks.im>
References: <CAGjHeYfyH+cOMYYYHnFR+Vu9T+RbmzO1SpB_-kbmBSf1DitJhA@mail.gmail.com>
 <cover.1728914219.git.ps@pks.im>
 <346aa2f08307fb9c501a4b9ac3322beb44dc9d5d.1728914219.git.ps@pks.im>
 <Zw2QT/Kx6IoPhJtT@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw2QT/Kx6IoPhJtT@nand.local>

On Mon, Oct 14, 2024 at 05:42:39PM -0400, Taylor Blau wrote:
> On Mon, Oct 14, 2024 at 04:06:41PM +0200, Patrick Steinhardt wrote:
> > +while test "$#" -ne 0
> > +do
> > +	suite="$1"
> > +	shift
> 
> I'm perhaps nit-picking here, but I find:
> 
>     for suite in "$@"
>     do
>         ...
>     done
> 
> to be much more readable than 'while test "$#" -ne 0' and 'shift'
> above, since the for-loop variant does not need to mangle its arguments
> with shift.

It certainly is, yeah. I know that there was a reason to write it in
this convoluted way... was it compatibility with non-Bash shells when
there were spaces in the paths? I don't know, and I cannot find a case
right now where it breaks.

Will adapt accordingly.

Patrick
