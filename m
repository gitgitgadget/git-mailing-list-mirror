Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4F5E573
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 09:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731575448; cv=none; b=QQEkpPiipQp0LaZ8gXPTtXX2b+OAdHFWMmZsbbQOisko3uEfZDvXF3LFWWzv0v9A2SfiagKcQ3WuQqB/sOU8Zp3DWfRsHFvGcD6BXhkxxJkGixLJ9DlzUxBZhtV4jTB47USV/xUfA61S1OxXgLxZ+qyO0RHrRa1SeT/6Hook7Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731575448; c=relaxed/simple;
	bh=HOq96fOtJOCQEkk12izwuC26q1xa/jfLinmCFb5vcJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FMxgaRfD7EU1fSBsrB2i2MjThplCyJ0benuhvkpXUcg7zSbIPQWQ6X4yI0oSvLq6CiiBQYJGDNaKmUHRkWQIKbNFjSAxqu94Y/qUmZBE4FD9LyhV/jhov1ea7vlc3NuL4Paf0VwJQIhzKCdtWr15hSPnyQ1Yaa1DGhk0zZmU2cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=F4fzEM2A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZhybLUI6; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="F4fzEM2A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZhybLUI6"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 631F62540261;
	Thu, 14 Nov 2024 04:10:45 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 14 Nov 2024 04:10:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731575445; x=1731661845; bh=jFvf13A6Y/
	8bVfvCKE6yk2UYbbvomIsJTZWtocpc1AA=; b=F4fzEM2AfxW+81oQaBT7c1xwER
	7oKyy6IsKyGhgwkQAf6q5YFlpvN689OanspRVhh5BwQzs+3v8C0iNF6w+xXznOcm
	46jHB6nDE2DY/MDm9tE+f2jvY1Vu58P0J711tsRjesr4wc6imauh/poJ8ypzIL9e
	BJUzJIIODbgT/A4xxirrVD8io12dj4JIBE9El5qHaXJbQ7v/AL+7uRzmbJzdpv8i
	WaOFZuAzwdKYBBKweYJla+fGW20CxtyUvbtixM0Py5/NUhf8BmpTV+oK9zxB6C0m
	Pz/tJO2xn1ZBig/AZhpTLBZaGRhdl/+6KmmmCcfiqTFzWR5G0X05JH3oVSOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731575445; x=1731661845; bh=jFvf13A6Y/8bVfvCKE6yk2UYbbvomIsJTZW
	tocpc1AA=; b=ZhybLUI67cWwFReM2zXx2Uqx8rah7HvSQPLvTgfWnl0tDEmEdzh
	Hzqzxhvj1v+G/dR5tNFwv9K/Dz662bQ/JCiTGig+tTwjxDallgjesOW2UD+dVkod
	S8AjLS8e0oIjxh7U3TK9jUdNdtoc3PmZeMqIQWe24YIVr5wywRldGrm3fQRYggyN
	7PtKWDXZQKAUEGz9QFtCD9prMFFBzRMA0EcIwS53sshNc3NfDzUwMGUe9fe3axDK
	3cjA+RdUp9aUQc3O8Q1PRVFlr8L94ibwi5gwGreTFKWhF1k1+dj24PZbDZ9cwZa8
	x05Q+pSArGdsvydPwtjaanMBaR2L3SyJFfA==
X-ME-Sender: <xms:lL41Z1PQfByrXGwIQ546Fuuq_2fJ_7Zb-jC_Ba-o6Yl_J6auhaTKAg>
    <xme:lL41Z39hyZJP0wfSWg1q4bMnIJZ5W1fr5DvsvIsfAfBgAEkvTyFqgxkmw6NvMLWW6
    LwkjJRi1vAtghQ3HA>
X-ME-Received: <xmr:lL41Z0T1ymclE5g8L1nNirkvuaANvY0t5BCwur3R8rXOdGJmlw4s1VWTeKn6ENawP2NFiYO0wLLaJ5zt2DNtCqwYTi8zjdlo8beqnq3mDbWM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddvucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfurfetoffk
    rfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculd
    dquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhho
    mheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecugg
    ftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeu
    kefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtg
    homhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhu
    khdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhi
    nhgvtghordgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtph
    htthhopegurghvvhhiugesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtoh
    hordhorhhg
X-ME-Proxy: <xmx:lL41ZxvyWOFW-Y6jwVxaiVsTTVi5hXdYoO534Bl9A3M_10XO777xDA>
    <xmx:lL41Z9cbi7OlIg4fcrY0PeqYFAhudU8nGZgTG1r8He5puGpYMZWUhQ>
    <xmx:lL41Z92gWAqAbJJZpXW8bz0nmjIoiSROMedsturRbN5WN_Hvw12oEQ>
    <xmx:lL41Z5-dnGx2LV1ktVzbHszjFy6bRSGmxnMoT5XEhcKPMLX95vUG2A>
    <xmx:lb41Z57PytrIXgWYjG1jTql7tA3aTMH-Xs2bT7n976jXy4mN0O8zRlWv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Nov 2024 04:10:42 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e49673f2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 14 Nov 2024 09:10:00 +0000 (UTC)
Date: Thu, 14 Nov 2024 10:10:31 +0100
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Taylor Blau <me@ttaylorr.com>, David Aguilar <davvid@gmail.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH RFC v6 08/19] Makefile: refactor GIT-VERSION-GEN to be
 reusable
Message-ID: <ZzW-h-g5CiLgCsCo@pks.im>
References: <20241112-pks-meson-v6-0-648b30996827@pks.im>
 <20241112-pks-meson-v6-8-648b30996827@pks.im>
 <c0474637-3923-4e4c-a90b-e86d5f37a366@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0474637-3923-4e4c-a90b-e86d5f37a366@gmail.com>

On Wed, Nov 13, 2024 at 04:30:33PM +0000, Phillip Wood wrote:
> Hi Patrick
> 
> On 12/11/2024 17:02, Patrick Steinhardt wrote:
> > Our "GIT-VERSION-GEN" script always writes the "GIT-VERSION-FILE" into
> > the current directory, where the expectation is that it should exist in
> > the source directory. But other build systems that support out-of-tree
> > builds may not want to do that to keep the source directory pristine,
> > even though CMake currently doesn't care.
> > 
> > Refactor the script such that it doesn't write output to a file anymore
> > but so that it instead writes the version to stdout. This makes it
> > easier to compute the same version as our Makefile would without having
> > to write the "GIT-VERSION-FILE".
> 
> This patch moves the logic that only updates GIT-VERSION-FILE if the
> version has changed from the script into the Makefile. As we really want
> the CMake and meson builds to set the string at build time which
> probably means extending GIT-VERSION-GEN to write a header file that
> defines GIT_VERSION etc. I'm not sure this is a good direction. In the
> long run I think we'd be better off with something like the patch below.

Yes, I fully agree that using a version header would make more sense. I
had the intent to do this as a follow-up, but I'll have a look at your
patch and maybe do it now already.

Thanks!

Patrick
