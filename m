Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B502AEEC
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 05:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728538129; cv=none; b=KARV97JaUgAoESEQPW0ihtkjJiUV/02Y+AHDENWFJJ1Yjm3zTU9V6Am3db1WWcHs2VmJFVsvQuqT2F+dAQMX6PXXrPvlw0+N/2/q66wBPaZQ7+dglyZLechS7N1Flw7sMGmef0tm0roFxajKTIwfC766dR5AoX1M3jmYiqEdaXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728538129; c=relaxed/simple;
	bh=Nyj0+bhgXNrnWswUDUJBOlUVh0oMTI4QXO4kdhwIDhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zrcus3WXQW77UBjxOxOHzFmvb4FcTBhT1gxoyIWDlo6z8tWi+yHHiu86MT8QRHUvfdzvbROG/5Vq3pARyyluEq/QSTehMzFK94m+Gcewj42GDhs9lEph5wNA/0gAplSwq36aepouv8ijj1pK131yVIPcEoUz1DLr+C8l3uQoSfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dmpk1Ode; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o1khicib; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dmpk1Ode";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o1khicib"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 865861140110;
	Thu, 10 Oct 2024 01:28:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 10 Oct 2024 01:28:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728538126; x=1728624526; bh=30h6Trkwv3
	7Gm7OewilAZlh6n8p/L9NqcJyNS97z/Ds=; b=dmpk1OdefHDNingaiCQEie98uI
	jeaslNoRDIq+1Lbsob7G4xeGT1OBOz5ecCl5dffT7zl4w+DWinDoPKOSdoIT40C7
	f90Z+PU2Sc/j4y+N/OvkvBEmfrhNKt1G3bKNopal/LwJKkaxMKvD8KU5Jum70rpL
	k5e6fqPwALpwMAk9MiKSTa3ljr7hkSSrdaavBEKj1sy7Ufo07bZ6Tn62pslcSHmS
	sYrSzQrw8vgyrsULvcNKS0a9fDM8+jwHymZhycd0PECZMjFIIBSnJ1X89zkRL/xK
	50yAjLVXxsfREdq588+uISrKozKGoCRiTeheD1cqe43Day/Nvj1cJYom3dGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728538126; x=1728624526; bh=30h6Trkwv37Gm7OewilAZlh6n8p/
	L9NqcJyNS97z/Ds=; b=o1khicibBQrel7bK23on4b4hVjZobxl0J30xOryoygJG
	q40vko6UTdF11F1FFLswPo+g9wQUi2gg9YkajorO+3aJujqxytxKELC0TKpKbUOv
	86lXpVYh6DduezZe6jARfL5nwaQm50z/19+t/BS9/J2JU3vdADltSYugl13ULRgj
	K8a3/vDLLHcJn3TNKtCpXSUJOmjCwcibWq+TAhc6W+8PfaqzirpsP8h/evfBG5Xd
	A1/PX3kO2zh2wX3Ofd57l7s24O06hCLAB4aBfmfLxEI6jZ6tF7XKXjtyFcCjDHz8
	rCJoKemGgQ5LAE4+dIrIi+5yB0Jt6KwnEBYg7xrjhA==
X-ME-Sender: <xms:DmYHZ2oTMk6d_d86D7UKyuo_f6iAUQROzFFgvEBED8NJrKBFdEKSVA>
    <xme:DmYHZ0qccWIbcanLMt2a7P5qHOOlng-pOdq7dyEBwYseVHnBK5akGvHLQgFXrYxz8
    NlgfDUSIaKGEz4Rgw>
X-ME-Received: <xmr:DmYHZ7NfYjTatqPmnqXFmMMMi87QPg0vBVQsDXh7h6KprorKROyntSbSua74e2RBPcfBWW2JdzRX846yP70fneQHADvwlECwR2IVathY5vMXY4JF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefgedgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthht
    ohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepphhhihhllh
    hiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:DmYHZ179xGe5-3yKgXy2ibdkrqaqFakcKXTItq0i98ADkMwh20SFqQ>
    <xmx:DmYHZ14Zbn0z104baJgvKSu38YB3-QVBzWWk5GaSWmGH9VOppJZ69g>
    <xmx:DmYHZ1jdObrqAIWj6BldbT2SUWk36FMejXXcd526zjsOiyGlhPkO0g>
    <xmx:DmYHZ_7fPRffN9b4qzf8G5Ot6yyvvwT_32OnL_IdabxT_n9AJuIEgw>
    <xmx:DmYHZzRQuOBTcWo98UVlCxwen21LDewragZ68vsocB__EE40LS1b9ijx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Oct 2024 01:28:45 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1cd7aabe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 10 Oct 2024 05:27:39 +0000 (UTC)
Date: Thu, 10 Oct 2024 07:28:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [RFC PATCH v2 00/24] Modernize our build system
Message-ID: <ZwdmBxnhoWWXKU3O@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1728485139.git.ps@pks.im>
 <xmqqzfncmstp.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzfncmstp.fsf@gitster.g>

On Wed, Oct 09, 2024 at 10:26:42PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> >   - Patches 12 to 22 refactor parts of our build system to make proper
> >     out-of-tree builds a reality.
> 
> Oooooh.

I hope I didn't get you too exited: not wired up in Makefiles! I was
being a bit unclear here, it basically lands all the pieces required to
make that happen, but the bits only get properly wired up by Meson.
There is no reasony why we cannot have it in our Makefile, too, though.

Patrick
