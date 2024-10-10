Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDB518C03D
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 05:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728539409; cv=none; b=NvKwY/44RCAYIuiHTsSTabTtQt3XCyA6oNhgT18Y7qY+vIafBz3smnGp0O0g1qoAPl2c9N05HAFVubIvxF9IoAj8dLC07wxGeGIUpC4WjD+l5xhdUtfW5wN7wSMveqLQLVz2DkSl92V+UbbbU5NYgXJ52ICZJ2JknwAWZN1Omvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728539409; c=relaxed/simple;
	bh=NwZyZhRqEfQRAuyja4z6tmxVJaU+cEfvlSFbjiLlqVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCqq6RKy9K/HxbSlmPLQed4sptQ40ZBSWcRE/Lu1yntSV0ThlWwIr1t/pcdhhji8BLfO+9/3j+XY0l4yIOGVyUMVdd6U2xp54X15Vjiattlo4LupsN1ckdwGr+UF0UxkrcJVFF/IpBqxfVRy3v6abqG6bLip+u3AVLsCTpvxe78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=N524K116; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WsPEFhL8; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="N524K116";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WsPEFhL8"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6E4881140116;
	Thu, 10 Oct 2024 01:50:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 10 Oct 2024 01:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728539406; x=1728625806; bh=Vx6+5k/Cs4
	AZaK1KtxOnqSpx+JrhAZLCY0cOrBcWOyk=; b=N524K116T1uLjyR83qBlDgsp1A
	/4oI8Mx5kvry/ioXtlB4lyoUlTrY/6u/2v9BWkYYi5xiwY2VzxmJ8YFsigZggd2B
	5GupWz1Rs5Vvi2hmpUffs7Wk+zjOO3VoXWgUnBcQSeCww2VSLh/UBntAT4+K87XQ
	sYYrZ/mTRaydGPM9Ws7RK+uaU71sJuCr7BpAFJrGa+3TixGt+WgfMWUFA75m087r
	NwG00Mi+ezfVA49NA3A4DebnlGNIr16fdQtJSGT8b23Wyyq367NmdPhWIbMJCEax
	CeV/OQgYxYDqNPNhbmwHFFK5FMYcKRYhXVUrUQ915R59esaYE/IpzUU85xTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728539406; x=1728625806; bh=Vx6+5k/Cs4AZaK1KtxOnqSpx+Jrh
	AZLCY0cOrBcWOyk=; b=WsPEFhL8ZncIsZOG77BsmSTIIIZeeiICb7nxymoUBQ7j
	sHvgvX0LKCqbmCkJW3BLw4JOOoOwUsYp0vrbUNykbub/qubWktSSbyZwZPhVCOsI
	g9LkCHl437LCe3anAP9kW6r5k8nqgN/FMymbiAVPbyt5wGWdl/5YGc+ttI1JPuOh
	Jnb6ZWYCsx1Wc+Nkfeyo02LO4BQ8AAc6dWaDAQ/f4IbnEMu7R8WVb60ivTHoRJCX
	LSjnJYEwypOVBxOYhnIjdgSLpkGhklaqxQDX5DFocqkm5klf/+imSdxunBq75YLI
	dxtM9EOp+fHCJik+NS45seHb4+UKVx5pXcnDphfZGA==
X-ME-Sender: <xms:DmsHZ1jAWjoz3EyN_AjhrO_TsOXXMjXWNFZdrzFM8JaXkls8yt1asg>
    <xme:DmsHZ6ARiUrBQN5Ij2eNNjpEY2dRwxzqhWzzz376evJF6fh4lMDeyndHDADv6-HUD
    v58ljVHDxZL0qt3og>
X-ME-Received: <xmr:DmsHZ1GZEtnLQtc2eZVSt6R1_8Om2zLmk7XYNXaXfKHPZ-Jl-Zmd9gKD4GJ40lccZSJ67GfjN4QiZbhCYsiV5sxnNONQ0FaC254ldMHcf6MDbkd4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefgedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghord
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopegvshgthhifrghrthii
    sehgvghnthhoohdrohhrgh
X-ME-Proxy: <xmx:DmsHZ6R5OfyrOTebWsEa6U7sm_qM55F5dPHJMk_kVUJwYNtDiihamg>
    <xmx:DmsHZyznNZ99yd-7KuNqrQdthUBmgHD0Ye-PFEx2e6IAWbwfBX-Bmg>
    <xmx:DmsHZw6SG_0mG48kayHFNKHAM6o56lYyUWuu_qjntE8edMug8svkOw>
    <xmx:DmsHZ3xVe8X8iDJhNfmIE8lbuyCEsitM4U4njVDWPVE0IFeu7mozQA>
    <xmx:DmsHZ5r5TG8sw9Zrc2Y_C2F68dopsbSpFjh1YomkCClvCHv7PUDR4uGL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Oct 2024 01:50:04 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2b2ea8db (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 10 Oct 2024 05:48:58 +0000 (UTC)
Date: Thu, 10 Oct 2024 07:49:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [RFC PATCH v2 00/24] Modernize our build system
Message-ID: <ZwdrB3blZmd101jx@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1728485139.git.ps@pks.im>
 <xmqqzfncmstp.fsf@gitster.g>
 <ZwdmBxnhoWWXKU3O@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwdmBxnhoWWXKU3O@pks.im>

On Thu, Oct 10, 2024 at 07:28:39AM +0200, Patrick Steinhardt wrote:
> On Wed, Oct 09, 2024 at 10:26:42PM -0700, Junio C Hamano wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> > 
> > >   - Patches 12 to 22 refactor parts of our build system to make proper
> > >     out-of-tree builds a reality.
> > 
> > Oooooh.
> 
> I hope I didn't get you too exited: not wired up in Makefiles! I was
> being a bit unclear here, it basically lands all the pieces required to
> make that happen, but the bits only get properly wired up by Meson.
> There is no reasony why we cannot have it in our Makefile, too, though.

To expand on this a bit: I was wondering whether I should do that
though, as it would make it was easier to split up this whole patch
series into multiple parts that all provide a benefit on their own:

  - Part 1: the platform-specific fixes.

  - Part 2: prepare us for proper (optional) out-of-tree builds, making
    things work with our Makefile. A lot of the parts are a prerequisite
    for Meson anyway.

  - Part 3: the modern build system.

So if people think that this is worth it I'd be happy to do it this way.

Patrick
