Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D32D1DB375
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 10:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729162747; cv=none; b=U9mAXinVTQ0JiKPcCuTe09ROgUA47p2YbRmbR8b9UzNt7/S3eJVAV+ny5pZbLRzdL9Nb/0xBQV/B4xqb7wOCFfzjZMi8PgJvJiEBzDvWAWOokFQuPPIrMU2HjkvhNzdOGTnNF1euD1i70Mn+xneofFmWY0FoaTw18qUWYzIhvII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729162747; c=relaxed/simple;
	bh=ZdgAiKm6j+R4ve6ufSsSlzLNv8eCadQI0KkmbP+8ZUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nz2o306lo9/M4AfJpYHzEjTZ+m7gWdZDEFThpJMmXnh70ZjeOdyAR/0CuwGnJHEaeqbB10wNpbqPm9CFFWcOAAweXKU8PjlMm7P1HLq3213uVeL6KYP0BmMEFgbJGL4JvrkZ0f7+MJbZ0TfhD/MNXe9KasWiA3pMa2AdzQpZEyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JH+FXxSB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JbhCF+LS; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JH+FXxSB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JbhCF+LS"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 613B12540072;
	Thu, 17 Oct 2024 06:59:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 17 Oct 2024 06:59:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1729162743; x=1729249143; bh=SaFxC9/Tst
	9MzLybjeEKh6xFkMHN7qNkhNLklpnbBBs=; b=JH+FXxSBrU80SHTP5lSmoCqm9o
	UhyYW0JcwOvRvFmO7TLZTe3GKCA3W/LXhd5bJc5asLDDg6qqIPvlmEY7rSIW5tS/
	R52aBtTWWbplh57idJwedGSUsYxRBTq3YO/eC6Seha34gztGB+SIN7V+UJU3bYy3
	m+AxCWmZlytp/vp8oIAr1raQR/24AH4ro/xPmUmsWtJPNkb80cBKpIG8bZqsNoUS
	1b8iUEUXkiJkcp7Qd0IQGeinTsqjAILggkYTxExnGbPF6DTBE4GNUjL9Rpn2TAbX
	wPjOHrWyqvlAXNe6pd4it6CDSSN8R2NgF4iEpMNtCT6915BeY2hkOA84qm0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729162743; x=1729249143; bh=SaFxC9/Tst9MzLybjeEKh6xFkMHN
	7qNkhNLklpnbBBs=; b=JbhCF+LSoKJS4d2dpmhg3m2UC+Smatdu+HxWVLao+kmc
	AIRFeDLwH4D1ZoL4IYaB2MUlpRWAakoPLJUhyje3BnrZTZIfUGZHuUN2RcfoLJSs
	VUdLl9gVnDEoNsvGq8Pn8ifJw8NIHqrCg+aP/zRQ/98QncVo4L0aiLOUB9itpDsr
	A9W7D1uSd2tTa48/p5BNhc+cK/JswJeCmasxhzBBaATtRYj5GYhIZAL6JWtjwqI5
	wSfP85UiKIaks/3kfVky1ozsZbswYMr5v2p0fNvkU+BwrSTRkaaLVnRQfHb467Ol
	FpBsgidYxZZdXLMnvS3xrjHuPybvRE65gUMSDojHzQ==
X-ME-Sender: <xms:9u0QZ84PzRZXQz6sWkmdXkXF5a7YlfUHl9ZdQq_AKEkP8GVY8wMoJA>
    <xme:9u0QZ97qYG-l4pbMDyvCu-2LA2GwNTSnNr2lvdYegeUo9urloQi8lNGFrpWbDO19H
    nuGeWbll8wzFR3GOQ>
X-ME-Received: <xmr:9u0QZ7fMT3_DnbfxfeFYO1B8qsuVlTyipaQUfFarDXwpjFWdtJwr8hbH1BbYGCc7kjfMJcDpDiKMwGwBeyMG-BUGd4YAGpPcbTU83SBm2j61RQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehuddgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehphhhi
    lhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehsuhhnsh
    hhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:9u0QZxIAfpaSqdYkuVQI-Wrq3-UJEFOPdLnUu2NRS2NLHaWtvZAmVA>
    <xmx:9u0QZwL4kTA0ZUHhG47Qq9ImlZlCmW2XHzLRPG2oxcpaVg5cTVKuHA>
    <xmx:9u0QZywBt7EGw1FIGUpS1CCov9T-p6bcEHAQy5aoVMnJUq6_BU8jhw>
    <xmx:9u0QZ0KZJsVaHNfQ9owNCQwRc97mVk9COG5cj1Vkjo_jvKY9wwfLOQ>
    <xmx:9-0QZ6gUtBtA3NaIP_qDnNkvXLFc2Rkfk3q4UHGZgz0DAaqiBLSceGYI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Oct 2024 06:59:01 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 77481a7c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 17 Oct 2024 10:57:39 +0000 (UTC)
Date: Thu, 17 Oct 2024 12:58:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v2 23/24] Documentation: add comparison of build
 systems
Message-ID: <ZxDt7DT9x6tl74e9@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1728485139.git.ps@pks.im>
 <afa2f79d46cb9b2e25cd31b622d5f547e2746f2e.1728485139.git.ps@pks.im>
 <72da40d7-2570-456c-966d-cd09579edd22@gmail.com>
 <Zw5cMv_fyctQsyT8@pks.im>
 <f68685c4-c8c8-45ac-a34c-1cff30cc11f5@gmail.com>
 <ZxDak17cinw2ySKD@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxDak17cinw2ySKD@pks.im>

On Thu, Oct 17, 2024 at 11:36:25AM +0200, Patrick Steinhardt wrote:
> On Wed, Oct 16, 2024 at 02:36:54PM +0100, phillip.wood123@gmail.com wrote:
> > > I'm mostly there by now with the subprojects added in this version of
> > > the patch series, which make it way easier to use MSVC without all deps
> > > having been installed. But I still have to port over the SANE_TOOL_PATH
> > > hack that we have in CMake.
> > > 
> > > I do understand that just clicking a button to import a CMakeLists.txt
> > > is easier. It's mostly that I personally value the sanity that Meson
> > > brings with it higher, which is of course a subjective opinion.
> > 
> > Right, I suspect the people who added support for building git in Visual
> > Studio with CMake have different priorities. It's a real shame the meson
> > there isn't a meson plugin for Visual Studio.
> 
> It certainly would be great to have such a plugin. There is one for
> Visual Studio Code, but of course MSVC and VSC aren't the same. Which
> reminds me, I should give that plugin a try.
> 
> In any case, my hope would be that eventually such a plugin does show
> up. My gut feeling tells me that Meson has been picking up quite a bit
> of steam over the last couple years, and more and more projects are
> picking it up. And that makes me hopeful that we would eventually get
> such a plugin.
> 
> It's of course wishful thinking, but as said, meanwhile we do have a way
> for MSVC by generating the solution manually. So I'd already see it as a
> net win if the official build system supports MSVC, even though not as
> easily as with the click of a button.

So I've had a look at Visual Studio Code now. Things didn't work as-is
yet, but I've made some changes and now things work out of the box. You
install the Meson plugin, clone the Git project, and Meson configures
automatically. The only requirement is that you've got Git for Windows
installed, which provides all the build tools and which gets picked up
by Meson automatically now.

Afterwards you can just click on any build and/or test target and then
VS Code builds dependencies, including subprojects like curl, zlib,
openssl and the like, and executes the tests for you.

Patrick
