Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B3F1C5F25
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 11:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737371384; cv=none; b=OTeu5pXCz0bdZMRgLLU9D+w1bLzKnY9n4ptEG2IIyqwz7hbxQYvwJGN8pXjP2SF3QvSzi4T9L40YgRxHNExmOINOiIbXBBz2wekpZEbF6RIgjkb0sQlIclqZ6vMp+gIJnn2F5T6XetHplg/qBEqqBoIU5wEb2b4oSbw0k/E3DyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737371384; c=relaxed/simple;
	bh=MdOYh8dOpcS5jNOMgLDok7FALt8v2HWeOm5mn16yId4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMQKR8lfmTrWxe5ulb1XDXoEQgwXG1GcgegffEx054NrjsjtWh1J8vKdxNzdQt+u+eh611vqP1y/tI0BoYRuoOe/m836flIC1fyeyUlnLCYAHPIbrzccFRD3QJR+P4NbQgkqTqsAiSwhOgM+A2nOzumsw6bQW+lxvIN/hchOhys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZZOX0NmN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r1xFq/EG; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZZOX0NmN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r1xFq/EG"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4B76E25400A3;
	Mon, 20 Jan 2025 06:09:40 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 20 Jan 2025 06:09:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737371380; x=1737457780; bh=BrBFvEGJOL
	g2pXhrXltmU73ovGxgGfypmgDV8OIFxME=; b=ZZOX0NmNL9RHriGHq3Yei3XOIs
	CmwrwpGfrEoyX/LSPZn0pXQf1S7IvxxPDDwfVuvdxzwxJHsBSWAVhwk1E63nZJdi
	4ToiPv7pKKAB24Q3G4LtZpecywTUzhjDJos4Xgd5eDuqa0zcfyIs/7iYu0ZP7W16
	vLDjJyqT0BnyKbos+4muYVreiZpA4AXOjr4YCLqEi2TAxt14IXGSaNFw9bGe2P3b
	FhBHIMWnjJ/d/0EAjfqGN3EXa8przwrhOXuD2n1i2KECjm/pIqJ25NFn0CFBOKK0
	ZiDUi/jTNAekBmYKx4fph20shnPV1yzkeNXAz89uAsKeyUrWoEkkNM12Ca3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737371380; x=1737457780; bh=BrBFvEGJOLg2pXhrXltmU73ovGxgGfypmgD
	V8OIFxME=; b=r1xFq/EGnHgmiKAL5VJVseaH7AcvGNmAw/5N0WABYK42u9shuzY
	EVE4/yA3XiZmVeTTgQrSFRwUNjLzWDRLfFM9e3RYHlBOml3XwTN+pbQqwPZglNpC
	YvU1KB6ZfGibAUvN83Hf5nyhFUpz3rgHB5ubSCUIIKwupg+OT75gOiwg1ZhKkbkS
	9A/159Vnr6yG8+eTN3A+r+hn83FBeczKqwug5N7qBdW6qaBwli/vr1JZgnIHe6tr
	HgLLmjkN0TDzBd7gmgVaoaFyQadk66B/IRV0uBvS8M4j2rRjVEPYhHuXVjsnvJD9
	o7gJ4/VFtnrnXDSvYz32dJnkHatDMtuH5YA==
X-ME-Sender: <xms:8y6OZ8VScLYULzH2kyX8YdaAv7VLL97ZC7wwLAF8OIMQhY0BYUZ7mg>
    <xme:8y6OZwlYwgPxJcaeBHyjPF6NsOuCfH8wPZ8fAYt1uSIisLcmuRWb9MvXxsUBjpTpf
    OCO9SPX2QNAHEYOow>
X-ME-Received: <xmr:8y6OZwbqgyKuzjpE6DB7ssRGwpij1bcH15nQukZHYxpoFxJwA_xgvZJm5VqmcLxzkFn5PMpEocIIyT8ILj2xCY3LJWsT5BitPnwUVy7xFP9GZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiledgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegoufhushhpvggtthffohhmrghinhculdegledmnecujfgurhep
    fffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuuf
    htvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvefh
    ffejvdffkeevtdegudelledtvdekudeivdffgfdukeehkeffudfhgeduiefgnecuffhomh
    grihhnpehgihhthhhusgdrihhonecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrghrthhitgdrshhivhgrrhgrrghmsehg
    mhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:8y6OZ7V012z8lw8pNIuGKm7dtpy4ZozRPXp2D6AM4ACa_JOyFc8oVg>
    <xmx:8y6OZ2kTt7PU97dNFHdLhyeejardehXNA2dsmhM_ADsQZ_4LRU5AqQ>
    <xmx:8y6OZwc2FnT3xGMHdZol6G1APKEMeZZ3oWXmEOp4Fh7Yvh6xgMGlYQ>
    <xmx:8y6OZ4HcELVQNCsqCIYU2-nzkQn74QIU_Lg1ngwoB2Ws1szoWlR-tA>
    <xmx:9C6OZ3AatyJkEOqKF_EriUN12ZUPFB4upzoG3vbiFOJDIp94F3c-0d5n>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jan 2025 06:09:38 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 53fa02ce (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Jan 2025 11:09:35 +0000 (UTC)
Date: Mon, 20 Jan 2025 12:09:34 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: Git in GSoC 2025
Message-ID: <Z44u7od-mDiKcKVZ@pks.im>
References: <8c8e8797-8de9-4684-94a0-f6c17a592dc5@gmail.com>
 <CAP8UFD3PkyaQBLYPryePk=e54VtsQwjbyvvTsKEBFJnns_jZyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP8UFD3PkyaQBLYPryePk=e54VtsQwjbyvvTsKEBFJnns_jZyg@mail.gmail.com>

On Mon, Jan 20, 2025 at 09:19:53AM +0100, Christian Couder wrote:
> > As usual,
> > we also need project ideas to refresh our idea page from last year
> > (https://git.github.io/SoC-2024-Ideas/). Feel free to share your
> > thoughts and discuss. It would be great if we could come up with a good
> > mix of small, medium and large projects.
> 
> It might be nice if we could refresh our microproject idea list too.
> Maybe we could add ideas related to removing the_repository or
> compiling with -Wsign-compare?

Yes, agreed, both of these projects make sense to me.

I was wondering whether it might make sense to also move the list of
microprojects into the Git project itself, e.g. as something like
"Documentation/Projects.txt". This would make it easier for us to update
the list of long-running projects whenever a new project is added and
makes it easier for people to discover it.

It would also help to document consensus in the Git project. The file
would likely not always be 100% accurate, but it'd probably be more so
compared to tracking it out of our tree.

Patrick
