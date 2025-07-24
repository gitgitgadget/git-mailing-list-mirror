Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4B026772D
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 10:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753353770; cv=none; b=NQqodqqSv68bTfaZAVsB2OFjW4n1kuYbNpzQ4CivzGbQmKwvVOmboJM7oiUWiQW/2ouktBhvx1RrJ+BYsIaUis9GIR2MoHqEyyV06aqZV0u8pJ1sVg4Vak1LN88/5WN/+0v/Ob4Mnpwho+eYuDxE+5Gqqmv3qopPiMIU2lKjg94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753353770; c=relaxed/simple;
	bh=V+bTs652sQjkCGJKfMv+epSY8j6YwbcFtPzbdc1ScYM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLpw/lyHfqHPXvD2HSAQLPn685xf3+ftNzLepivUYO9Gn0JGAVTn0pKqraikh2Z0MJ12CudW6u7yaZcvkAFQ/+5IJTBGw8ITO9jsUkPwolJCHFk3TyWolvAW+D0E0pOSYT5JGLabXusbvPwdi6l9r5MchSQOl87pDDVn7VxvKrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZBbAakFk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DqmwWHKC; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZBbAakFk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DqmwWHKC"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id E5A981D003B0
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 06:42:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 24 Jul 2025 06:42:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753353767; x=1753440167; bh=cABggX0mob
	jtw6fNdzp8z1GD/5algyt+pNxhrVSUZQs=; b=ZBbAakFkVW/YSC6A8/W/PjqBMf
	mcUIjz6mI8bUAg6JqiDdVvExuXBF2cEDxxvmYchOlk3ia5urFyrpl0m48rvUZVzs
	99cVSV9n7xwf4jYpOyKxcWzM+9p8triHjT80r4D+mLbP16S5oAB44GLcOmrdPKx8
	2Z2mYGjaK5fx8ayAruwAy4MozET7McNhMy11jxTUuHWSL02Th1JGkW3I3rifG5Bw
	tNAIANe6/Y5sQXdsa5qwOOadNhfJStTOxC011m476jXjdLqN9LXK4Xe9l/FSCLWf
	eFvNe6zdkKNIkcu7Ztdn+vqjCER+3AAGVHeMgmzt129uNidoP5PH2uS1QHQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753353767; x=1753440167; bh=cABggX0mobjtw6fNdzp8z1GD/5algyt+pNx
	hrVSUZQs=; b=DqmwWHKCPmhaS23RHBsK92jI3aYk8xq31Nb/vgJkHrTDFZuDVly
	D8x2GfB1mwCdbMHSImH4lTugl/nOBK9mkTsU4XGkZ4oeNVMs3Ms8VPL+fVmRBxtj
	mUvt7RCCRCzEr8qp5QpMRYqkdQ0pttJ99XIFmeo0J84UmfHckGMJHUO2IBECdTBV
	DCOnV6OONsbFJV4hagPP9KjSsnVSR2e8cKZEKrBCvAx7Mvlz6TrBZuHDvhfzD5E3
	VN+Y+iA+LdzsRAlOW5/l29Qm6AeBbxa/ohdpOLRtD1Umn8OsCPS70oi7lnEQJrgY
	iNhjG/RVLTbXfyjnD8vGYmo/Z1Uz0uDqtxQ==
X-ME-Sender: <xms:Jw6CaH-J8d_zjP92fJSxvY--8UBTGDwUtiyK8usGBET9HNjOZmAr6g>
    <xme:Jw6CaFsQlrrzH9SMPtWCYMapxn8IsDKXi7ysxECnkdezyrZzGvY3iicWzT0LdJA6i
    p5XpnG2XShq9NJNjg>
X-ME-Received: <xmr:Jw6CaOY58Kq7Aw_shQdkTHwsHgR2HlxqnojUilbv8h4AaMgmUDqeBJKUZBv6DYbv92ucEnEDR0C3uwAJ4bIP-pLAEiy4ISl8R1-pmu5STZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdektdeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttdertddttd
    dvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeevteehhefgvdeuhfetgfeljeeftdeiheelgeelhf
    dutdfhgfelgeettdehieeuteenucffohhmrghinheplhhinhhugihfohhunhgurghtihho
    nhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Jw6CaFpAehGgB7EbDvvPNdTIJwPn1z32N0aIMx0ZNTOnfBWOVZ8Qbg>
    <xmx:Jw6CaD8vgWeIuNLyvEOYW2EkCUiQg9jMWLGQl-HO1ehX6AgHq-6rUg>
    <xmx:Jw6CaE_BhmGAHneBEkJcCFZAbcDrcdBgs-_XzTYOU6HKpfTjZdHbJg>
    <xmx:Jw6CaCvodCfnK1C2Kk8d-q-D8RNBeU124GE-QlETmU2ZETmjusB9mQ>
    <xmx:Jw6CaMkvfh9QWKkGk1dL8jk7f5BT2iMGscFHa3myKuH-VuGgim0LlgX4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 24 Jul 2025 06:42:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 110fb78e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Thu, 24 Jul 2025 10:42:45 +0000 (UTC)
Date: Thu, 24 Jul 2025 12:42:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git Mini Summit at Open Source Summit Europe,
 Amsterdam, August 28th
Message-ID: <aIIOHVROv0MwHdv9@pks.im>
References: <aGwHt9HCd86hVuKh@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGwHt9HCd86hVuKh@pks.im>

Hi,

On Mon, Jul 07, 2025 at 07:45:27PM +0200, Patrick Steinhardt wrote:
> Hi,
> 
> I am happy to announce that there will be a Git Mini Summit co-located
> with the Open Source Summit Europe in Amsterdam [1]. The details are as
> follows:
> 
>   Date: August 28th
>   Time: 9:00 - 13:00
>   Location: RAI Amsterdam, Europaplein 24, 1078 GZ Amsterdam
> 
> This event is not intended to be a replacement for the upcoming Git
> Merge 2025 [2]. Rather, it is intended to be a smaller community event
> for those who cannot travel to the Git Merge due to whatever reason, or
> those who are interested in Git and already attend the Open Source
> Summit anyway.
> 
> The event will be structured so that we have a section of lightning
> talks (probably two to three hours) followed by some time for people to
> connect with one another (probably one or two hours).
> 
> The registration is not yet open, but as the date is approaching fast I
> wanted to give the community a heads up so that they can plan. It is
> expected that sign up for this event starts next week. Tickets can be
> either bought as an add-on to your already existing Open Source Summit
> Europe ticket or standalone and will cost 10$. I will send an update as
> response to this announcement once tickets are available.
> 
> If you want to submit a talk, please send a short proposal to me. I will
> vet these proposals together with other involved parties. Deadline is
> July 28th. Furthermore, if you got any other input, please feel free to
> send me an email, too.

A quick status update from my side: the registration is now open [1] for
both attendants of the Open Source Summit Europe and for standalone
registration in case you only want to visit the Mini Summit.

Thanks!

Patrick

[1]: https://events.linuxfoundation.org/open-source-summit-europe/features/co-located-events/#git-mini-summit-2025
