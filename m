Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19B42B9A9
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 10:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731321400; cv=none; b=qy/7FoAcS9G0UeHhZwJ4+kbUncF9zSHWuGcjda2xgkLh/KvaNlqlUVFbbSqdOzdB9iF6O2O3GfTG1FVfXPB1CH1yUZvlGM6CjBwl1HZrp0O3DOJKSIB1Hr6jyTIUmIt9qtq07O5fSSENADd44h321I/AZYUlRaUoTRtUdwSiE9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731321400; c=relaxed/simple;
	bh=B1mPiuXF/JjTKBtxDlz5+IpEN03FhWoFdISWwKcnddc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpSyLWSFfjk7NvY4FvE0znV39NIFgjwpCiRCmHXjzUUrMr+R0A+5E56VWxNS6t11GzvSA8PpDhFwWEVIyNvz2vvE8cTJvm1VIF5wQUI/L/aQ3uJyTsZznGzson1o/wx8Atsrrh26uudQcc83bKHPUjd+N2mfpdOCnxnsukM/OGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=zQdzJq92; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q6dvR9T4; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="zQdzJq92";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q6dvR9T4"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D86AA1140156;
	Mon, 11 Nov 2024 05:36:36 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 11 Nov 2024 05:36:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731321396; x=1731407796; bh=LkNvXtgG8r
	/+AQEFXFmV/Pdmc0NO9Rf+sSPuAGwjfUg=; b=zQdzJq921TThSEdOA6SotMk3SK
	7p3PTjLQF6ggQrNk+yRozasH59rqiVRwQHP+AlsnvXN5T5P0OqKSsHoyo+6pDv+s
	EMLe7EDiXkSNs4oMBl/ZTDvk4yMTXXybulJpYPiQYZCJj/gOczcGRdYuKprvFg5T
	GwnI0DHRs0w00dxhXR8LzT0r8PwWTUDjTqyFGUfNfs7TaKxmC5Tce6CCbL0hcc17
	/rCgcY1u3EtOJGnp8AkZH/GkGKiY1iv/F1RADUr3o4TGJb3W+acXToRAWV0nYP+o
	gM/9hbbneKAJK0jCKvLUdBVvuasRJrLSN2nDRlppqfwSfcNuve/4MlB+MSJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731321396; x=1731407796; bh=LkNvXtgG8r/+AQEFXFmV/Pdmc0NO9Rf+sSP
	uAGwjfUg=; b=Q6dvR9T4k2JHEX4SniTmolXfFqxUbS72pabHMI6gxNzM1VseziN
	QtdmoVN8D2sYQ8jtUtvEJyQ3eNGF+kOHJKURo92SbQ40PtkORD21pTw5cJFLcciG
	8BcuLFWD2SsIRScEap0WCk5ftBIFtOMXZFh3kMdGLrcauO33fwswdfW+3VGMUH5D
	QrWK1tvTYY9SRTDIAozs2wDR04S9BM+bf2bcg51dLx9ANorZr2slX8MYyZik8bJp
	GwnwqIgBmgp1Pu/+CGtBi7iiOoNTcPw9F/IQGa59eUraLWfChztxpju6KhWGN6vS
	gP4YWnq5R+gjl3ecRz6AaBcl99n2eJaOl1g==
X-ME-Sender: <xms:M94xZ-uNy6UdfUBVhtYPd2sVFlKIw04H3tMhir8Ewkm0oKzsToT-Lw>
    <xme:M94xZzerxl9yHY4A5Tf1YVI83pYq9JRBBf1hoEjI_zRMtwBiJp3MYHnqPSDxKwgv1
    hpW4ueEr_z_EjNMWQ>
X-ME-Received: <xmr:M94xZ5yofsW5vyl7qedOQ4CC8kpjJoYQpi08-tFUYOotGyLAgF10yE8xN38iv4VowzJvnyc-I12ObHbiv_fC3aFATrLk5CYNXLSML4GYV7baMqKc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluh
    hsrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphht
    thhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepph
    hhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepmhgv
    sehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopegvshgthhifrghrthiisehgvghnth
    hoohdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:M94xZ5NeHd8zceX2gVb6ketiRwhMcyoTqmoPxNtzoOTFuVCu0kK5vQ>
    <xmx:M94xZ-8aQUjNPfkmjrtzpBUaXEsa-iqLpYA2QA3AeBiCo21X_6id7Q>
    <xmx:M94xZxXOJdnn6QjjjOMkyRrhN_uR_57CDLOgyIs4cAF8W2lWUVZHcA>
    <xmx:M94xZ3cuORD-sQqWUULUYzN3aoULEISjAbEZgu6WgfDN7EQdCvqwmg>
    <xmx:NN4xZzNxHQYyCuafuktawX3jsX0_taM2lFmcpAyM80XuO-a8K8v6UuqV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 05:36:34 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1f25544d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 10:35:57 +0000 (UTC)
Date: Mon, 11 Nov 2024 11:36:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [RFC PATCH v4 04/19] Makefile: extract script to massage Perl
 scripts
Message-ID: <ZzHeHk8alk4xVyQe@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1729771605.git.ps@pks.im>
 <50b607a412afea051a7839b9f3f1b4519b58721a.1729771605.git.ps@pks.im>
 <c2508eef-bedb-43dd-9d4b-7e980d4ade37@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2508eef-bedb-43dd-9d4b-7e980d4ade37@gmail.com>

On Sun, Nov 10, 2024 at 02:36:49PM +0000, Phillip Wood wrote:
> Hi Patrick
> 
> On 24/10/2024 13:39, Patrick Steinhardt wrote:
> > 
> > +	add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/${perl_gen_path}
> > +		COMMAND ${CMAKE_SOURCE_DIR}/generate-perl.sh
> 
> This is missing ${SH_EXE} in order to work with cmd.exe on windows when
> running the build from Visual Studio. Also do we want to quote the command
> arguments in case there is a ';' in the path - we seem to be a bit
> inconsistant in about that in CMakeLists.txt. Also we should add VERBATIM so
> that special characters in the arguments are quoted when generating the
> build rules.

Indeed, I also had it in my mind to revisit these patches and fix them
up based on Dscho's findings in the other thread. Thanks for being
proactive and pointing them out!

Patrick
