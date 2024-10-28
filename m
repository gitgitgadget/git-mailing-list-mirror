Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB29018D63F
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 05:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730094781; cv=none; b=n/3xYtUn+zQ95E2PcpgcFXe93F2BFB80QO9hrfkLM49WVdXoLgZNz635esm8smVXCPm1QLgBpBpBVjizfWYxz6ZvIuiZ4Lm2I9eIl73mxYsShaX1U4MGWzbeDdH3qoDsg+Xq0zHKjGFSm7Bp50O404/ZumakqLjPFR2s5T0S7BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730094781; c=relaxed/simple;
	bh=8BZ/DjNcY3wTI9zvj+sLq7UYHYOTVRqjXxlO//l1qdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIl1czbn5lHrzxSd4RI/hDwm2gO+eFcyCFsQ6O2wzZbqG7A8DLFl4xkYruHgupYbTTi+Q2GSgXeWRK3FPewfKCTYb8XGZP8yVgXcgoCtgoONlIEVOsoxTTmXPokCzR4d04L5DRT2SKXAlxWB9xS7SnfLjDSXMW2HgM1U5KUScdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OKX2s7aT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LWuHhShs; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OKX2s7aT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LWuHhShs"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id BA9FE11400A0;
	Mon, 28 Oct 2024 01:52:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 28 Oct 2024 01:52:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1730094777;
	 x=1730181177; bh=nikuJnBf/N28o0gREn4OBPuQys6YnpYgOG3j8gqEk3o=; b=
	OKX2s7aTeMbUycD+OLRBBR5NB5JC8DkO8ho7owxfzfnqsPWY4sOXTX8J7RzyAfX3
	0jlGsK1hZLeCTyp35Q7EezqvaO8P6XoGB0hzcXLDDVXUX3ULtX0I5oQ4fjca9Fas
	DhPd8SmZXjwj0qIbJ+ovVWvHUbQINgmRyuSCzsVZUQFnWQ6B16xpv7BdGwCFLKGt
	QLIciJc7FIhMlAsl5Efd3Vu0Hl27FGX0uniizJBacPbL3OzfL3TgiSx4epyBSFKS
	ojSHuBmctbw7LI5bBNJSkxkNNbt+7Cql48cWFO2pz9f0Hyk9y9gNaIAkPjErl5hl
	JFPLpYUzSK7wjGpMBbKevA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730094777; x=
	1730181177; bh=nikuJnBf/N28o0gREn4OBPuQys6YnpYgOG3j8gqEk3o=; b=L
	WuHhShsKUUpfQWDJQvFNBnW1pe13dog/+0E+w3yWhEsv+iwZ02jA7zhtk/nwGu4O
	J1bS8DZuuN1m4YJ9kGmpYb50y589rOcDE5KK1Txbj486vIf98OsxMKTQXqHKV7mb
	wNAoU1le2dinKPmHkgtXAcXMGhTyl+c4wZJ20bNoq0vSpq5xjx6DtB6xrr5NATEv
	R86cY+BnLhQ2XKR5+WsvL/nL8rEg1HqdVs6YWT7Rqw3ch0/hcnJeXRuKYFB7xuUE
	Tn0jCfLL2Mv85qcjRoPXo2Fp3AKiKjx/4/Pv9eyhS/BSACBabQxShANPViEhGQMD
	XA1a/FaVGc0QO2QT1qUmQ==
X-ME-Sender: <xms:uSYfZ5P5NnYA7rrA-CAf9ak1ulk1m-APY8X81OEzkHIDh1Is5mLyfg>
    <xme:uSYfZ79xHI_NN-barkeyI9psSw8LfatIEMWdoOpxlZYi41mT2uGQVVmZNDl5kef0x
    qjOJUeyF2k80mdS4A>
X-ME-Received: <xmr:uSYfZ4RgwvKDWDExCC_4e1d0DiuxNHm6e-buk9E8gDVdkx_T4V2bNOaDDdw_Tkq22_5LssF3sJy5rtuHU7-ZwuZWwcGu3uJ038X49yjF0PAiug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejjedgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrsghrrg
    hhrghmrgguvghkuhhnlhgvhedtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhl
    lhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhk
X-ME-Proxy: <xmx:uSYfZ1scDbYlLrMQPPW4TdVeJ3d_FkEjKMi_oN1ssinS-qNcrct7Dg>
    <xmx:uSYfZxeZNpUvK9xG5iNNR8ZDfyZkqVNf1VyxA3R0uWYNQIWPSYCbuA>
    <xmx:uSYfZx115CkljAZHrs2eK7mKQ3h6o5jqXI0rwqIWNVnvdQuQ60xAuA>
    <xmx:uSYfZ99816YUPON6OAACRaOz9zypfBSQySazt_6Ld7ENr0vglytP0g>
    <xmx:uSYfZ6HOC5XlroN6jRwereUzgh6j6NqIxWSHvoEgEhGydI-Ehm6U3qeS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Oct 2024 01:52:55 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d28904c3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 28 Oct 2024 05:52:48 +0000 (UTC)
Date: Mon, 28 Oct 2024 06:52:48 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Samuel Abraham <abrahamadekunle50@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	christian.couder@gmail.com
Subject: Re: [Outreachy][proposal]: Convert unit tests to use the Clar
 testing framwork
Message-ID: <Zx8mqmzN2d3pU0zC@pks.im>
References: <CADYq+fZBGZiTQduQ+4KcQ7H2Hysb04pg8YR++8PWAkQOM76OPg@mail.gmail.com>
 <ZxttGFtt5nnc7g9Z@pks.im>
 <CADYq+fZeTDnpsvBenLV6GHz5vBRW0nwcmWqQ4kvpNd5LocPRow@mail.gmail.com>
 <CADYq+faOBCRMS3GiQMuACJ2pLdirnODJBxuJTsR=2QPPpzwo2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADYq+faOBCRMS3GiQMuACJ2pLdirnODJBxuJTsR=2QPPpzwo2A@mail.gmail.com>

On Fri, Oct 25, 2024 at 07:56:05PM +0100, Samuel Abraham wrote:
> Hello Git Community,
> 
> I hope this mail finds you well.
> 
> I am Abraham Samuel, participating in the Outreachy internship program
> and I write to express my delight, enthusiasm and interest in working
> on the project “Convert unit test to use the Clar testing framework”.
> 
> My first exposure to Git started with the book “Learn Enough Git to Be
> Dangerous” which taught me the basics of using Git for version control
> and collaborations and I felt truly dangerous :-).
> 
> 
> I am passionate about FOSS and now that I am presented with the
> opportunity to contribute to Git, It is indeed a great opportunity to
> understand what happens under the hood and I have never been happier.

Thanks, this version reads good to me overall. Please don't forget to
enter all of this online with Outreachy if you haven't already done so
:)

Patrick
