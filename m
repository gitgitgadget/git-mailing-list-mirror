Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81201FF1A2
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 07:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737963022; cv=none; b=W1TqaMq+9e5FFs+NeJXm3k9gjr2B6K2U8vguKWBzNDJpj9JBSQARXEzV4Vh2lneg7gCSEWDI7Kmp//uiGo2UPOgJ5FANk5ugG6jeK8Z8fNnPR6WzVNDKviqXG3EZB2yIABWWgJNw8XuvcVybSRAdJpVIxRWuqSl7gMijzCcnqhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737963022; c=relaxed/simple;
	bh=KZuf5ppuQloJT1FEhxTTlGXUv3Gb4iJ7LMT0clnCzXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWSXfgg8f/A7rpM93cNVtcVH1nzB4FEJE14aUCHcSRrgzgi0NvKtIJesImPpGTGvW1JP0FZkVlMlfTZUoZSpjYcK6/5WQl0x8iylkTSFWt94i1PCCHfYVbnb/nGUF7J1fFBB2LzXZIQ1zfmMysMWFaN1W+htSkWGKzaB77WarEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ql06W0jF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cW+9AUuZ; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ql06W0jF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cW+9AUuZ"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EF95F254016F;
	Mon, 27 Jan 2025 02:30:19 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 27 Jan 2025 02:30:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1737963019; x=1738049419; bh=BLpBRYKM/C
	Q/WwmxlfjYs+mLCJIP2Lorn4IbGfgQCXA=; b=Ql06W0jFMe4dCZ0PZzrLhuyISd
	6xMyuxbqtcpc8fERVO7CQE3UnS60NWA+vxCGVRHt1zmVmySy20+fEzMuo8y5aCVo
	dW0Moe+jlRbTEj8cOcLBT4flHnhqQVM9vxTQMbL+H/sBXENztYNcvT+Ol7+DBELF
	Yco96eI/Rg7qisQyychD9TC4+paQZA1Bw6y6qwQo3gb1l12Bard1DXI63bD9IzyE
	K6gP0eMZV7yPzYpL1oxQF6C1UMs0dZenhDg1GGfdqMH5fMpYpTmjq6KyCoVoB/Hz
	0JAYirxeSStLXuRGzIxWl6nVPvC1AIYjulcFLdgWeeFmyAj156+eEqwUlFNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737963019; x=1738049419; bh=BLpBRYKM/CQ/WwmxlfjYs+mLCJIP2Lorn4I
	bGfgQCXA=; b=cW+9AUuZw0D2W9m7eflo3TwAEPjEWMXpf6Q9r/a4DmzWHvfHbUG
	5DaN/nxH47ktxXZG8euEM31UDnYu+0XcQZ+jHyKNOMwI3fmpsKap3q0vmWuf/TAP
	4hLWCGzb3UQNpPbU2udvJUXBvtCRJg+WqZpsEjnrTSlO9pQBra7QoOnhv0LV+78T
	DjTMslPMSjezwKB+TWSghaduK/wMznmev6KdzAuwff6MphVIjibQ6hu9PwFyz/3O
	gjvOORQfK323T5RKK3M5b1d7jjBYD4iAfQtQHnVlN1xwr1bV8pGXMbnVc5F5GTda
	Ig1/QAjrV1b3vZ4q+6p9+gfXTSZ++LrL82g==
X-ME-Sender: <xms:CzaXZ0UMQPpYzMAlIRM8MHIA3DLbMI-7viD_cSyOzgUwYm7BDAqykA>
    <xme:CzaXZ4lT3YV5cqKs7oIixTihc3EieCT6Os3j4S-skN6Qp7_xrwgz7PPmpJhorCRJW
    qoIn7wSwkB91Wotog>
X-ME-Received: <xmr:CzaXZ4b_9Z_0G0TiYR0-0LCSd6oOmqjwHR_y1EVbCxHPxK8hM6JYy4TEhRo2OJn-2X5lWmhEl23eTNdRLgcm-hYnhphQryLOIDnFjMuiQloz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedguddvheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehmrghilhesvgifohhrmhdruggvpdhrtghpthhtoheplhhishhtsegv
    fihorhhmrdguvgdprhgtphhtthhopegsvghntggvsehfvghrughinhgrnhguhidrtghomh
X-ME-Proxy: <xmx:CzaXZzWcuyeMoi13QB92P831HiOY2ag5XVbJzgpfEoDvXLv3E7L42w>
    <xmx:CzaXZ-nkWKwrxFYNKSC0S67ov8ipwgAZGiQymNqBnEQZmOnPxyntYw>
    <xmx:CzaXZ4dpNdVYHhJ9euhpS2V5pMhL3oTPKy27ofI4RfEll6Z5szDCIw>
    <xmx:CzaXZwHKnpEHHaokYhMLtl9RZjB2Ikp7owIm4o6SahP1nTGc2B8Kgw>
    <xmx:CzaXZ_A3BYv7UeQKQHJ8ywS1uphVt81Vaph60sy3sP192t4G-JiZCzDl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jan 2025 02:30:18 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 226c2785 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 Jan 2025 07:30:17 +0000 (UTC)
Date: Mon, 27 Jan 2025 08:30:16 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: git@vger.kernel.org, Christian Hesse <mail@eworm.de>,
	Christian Hesse <list@eworm.de>
Subject: Re: [PATCH v2 2/2] fetch set_head: fix non-mirror remotes in bare
 repositories
Message-ID: <Z5c2CKpYM3KevMyD@pks.im>
References: <Z5Mrk02wMdABtrVZ@pks.im>
 <20250126220403.289742-1-bence@ferdinandy.com>
 <20250126220403.289742-2-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250126220403.289742-2-bence@ferdinandy.com>

On Sun, Jan 26, 2025 at 11:02:11PM +0100, Bence Ferdinandy wrote:
> In b1b713f722 (fetch set_head: handle mirrored bare repositories,
> 2024-11-22) it was implicitly assumed that all remotes will be mirrors
> in a bare repository, thus fetching a non-mirrored remote could lead to
> HEAD pointing to a non-existent reference. Make sure we only overwrite
> HEAD if we are in a bare repository and fetching from a mirror.
> Otherwise, proceed as normally, and create
> refs/remotes/<nonmirrorremote>/HEAD instead.
> 
> Reported-by: Christian Hesse <list@eworm.de>
> Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>

Thanks, both of these patches look sensible to me.

Patrick
