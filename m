Received: from flow-a5-smtp.messagingengine.com (flow-a5-smtp.messagingengine.com [103.168.172.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C2033CEB5
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 09:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761817856; cv=none; b=OCoxfujwpUmozz+bIQa+hhWShQjUl+BuAhWJabsib2yASrf6gDqyww8e82OfBEqvUcn6hbXjBGG3O5I0tjqeCwYkfKL0p8BhG0mUCrb1qYrZd2bEEcdfdSSRLI2oYjMRi6vrHzDL5ZPFvr/y28kqEivMfZZ8y9hK4kFyWQLihCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761817856; c=relaxed/simple;
	bh=eKjSgyu7B71IlJueKV1GgZvguD9JTn409iitb9pX5JQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXDjbLf32zQpKO5fMKl5AOU7yWeqk29n2qQQkMiH29MbMMPgZgGLr3/rimXFg/jJT6tVFyLJiUPlw3qtfQwCWQvGRrh9ofwOrmTmNUyKvN2hCMMw/nf+53BKGfcPHnT35wAgvKA35mfXLAQhyQpZPl8fkbd1seghqak2zgztecc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BlOgVQY5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uWKzNX2o; arc=none smtp.client-ip=103.168.172.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BlOgVQY5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uWKzNX2o"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailflow.phl.internal (Postfix) with ESMTP id 846731380595;
	Thu, 30 Oct 2025 05:50:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 30 Oct 2025 05:50:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761817853;
	 x=1761825053; bh=8CGqB5jAyuZ4LVthvlTRTCd4GlrZWQUj+Cmk+6ps2Ck=; b=
	BlOgVQY5e2E6ywwyEF4jAaC/R1/L4vcHUtIcI+pzkSYS7sLKB0vZDn5izP0dpcN9
	wFhcrMeymdgDqycxEXJ85EtVVZWBY+kyuaOwwhdgf6n/J+3sRMbXaAIgRqSc2dLx
	cQQ7Zu+vX1+vesE5/z0qssGjNU191OAtJO9DGl4AYTGY+QnmfkugTf9kC5AeosT1
	QyPcLtRWfbxhOKvcBMG4qtg04gRqWRQ6v0nfBkTNepg6Jyiw70h3lR37NzBiIajz
	L6+6cJY9ttWUdSDpjJXVEREczWlHSgaJLAewh+Nt1QTZ6FgkWhugg/OSPLndXO8B
	d+kuH6IEjXHb8+cvAZFg2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761817853; x=
	1761825053; bh=8CGqB5jAyuZ4LVthvlTRTCd4GlrZWQUj+Cmk+6ps2Ck=; b=u
	WKzNX2oRjTavL1OHHAxu0wWhWu7rZHWUzDZLKowj6As2Z2yFDwX4AHMNN5zD12tY
	KInY+fm/hnHx6BjbX3++gqM70xOTYsCkLn3d5kQnZ1AuGzt6dMItP0u04S6NlFw6
	SLzOKPEJnZnqaSJDjXBAZ/auA2JQMwcOxU+DLDCVvT51z1fOr2gA+YwpzyEAN9/c
	G38Vnn1wlQguI7osj6uwYlYTPdcOmvDUJ9EnGRdOPhEt3Pjdu1MsTH0RezsyRHep
	N7j7QYTcBseB6lJuK4yQx1NSagTJWCA1QL5nBMfnlxQOFoWtmVyzP7kTbyIJXz8F
	t56kXuEO6tj0UsQcQP5PQ==
X-ME-Sender: <xms:_TQDaSnhKxuRGRq8iARE3hoTeNvoiowSIfKuyiqIVaUoG-MtjVE1Ow>
    <xme:_TQDaQ119IBo5Bh1__07_xG_5Rwd0D4HdHlpf591hORBiVzcOE8oRI9jaf7DgVRu8
    WZ2kjMe1MzGFVswmsp570qw_p8d1vI_9Njmk6IF7A9FOTd9DTT98Q>
X-ME-Received: <xmr:_TQDaVqSJSV3I15QA4gtUa8IjwpO1ZvoJsHR3tngv74f3qvjcy-FwIxqeRysNO_zLykZdd9q1rGYm0DBq7zKIkchzYUUy_vop-_JjcbIBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeivdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucfrhhhishhhihhnghdqkffkrfgprhhtucdliedtjedmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeetheffvddtleettdetueeukedugeettedutdegueeukeetheefueevvdeitddt
    veenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthht
    ohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtth
    hopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:_TQDaVc6lGLTKYHVK6z_rFgGNc5N0uTAU_WRsuHjYw-uE5des_sSIg>
    <xmx:_TQDaco2_AzJefoWTlnz6ahkOm5W36aLFalPlfly5i7wCZBbn4ytRw>
    <xmx:_TQDaeEdax30l_A2OEQkcqHmp_TOMIuIG37dC7TA9UuDU4WABl4S9A>
    <xmx:_TQDaUvyyvQX7dJqQVTQWHfvh89Vx94iNajsFCMOmXuRn5wrpTJTSw>
    <xmx:_TQDaQ2noP9B42PZDVrms_VhsUsaCyfI52RW0Km7VWWedRdBxrDa7B9Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 05:50:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 51d10a6d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 30 Oct 2025 09:50:52 +0000 (UTC)
Date: Thu, 30 Oct 2025 10:50:48 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/5] rust: generate bindings via cbindgen
Message-ID: <aQM0-IwB3e4t7YKE@pks.im>
References: <20251023-b4-pks-rust-cbindgen-v1-0-c19b61b03127@pks.im>
 <20251024-b4-pks-rust-cbindgen-v2-0-4b4bd4f18490@pks.im>
 <CAH=ZcbAC_u88_cD33bRxAuAPhJh02zNOHAVnkhxthncDFdZOOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH=ZcbAC_u88_cD33bRxAuAPhJh02zNOHAVnkhxthncDFdZOOA@mail.gmail.com>

On Tue, Oct 28, 2025 at 01:37:00PM -0600, Ezekiel Newren wrote:
> On Fri, Oct 24, 2025 at 3:51 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > Hi,
> >
> > this small patch series introduces support for cbindgen(1). This tool is
> > used to generate C headers from `extern "C"` blocks so that Rust code
> > can easily be called from C code.
> >
> > For now, the only use case is to verify that our varint reimplementation
> > matches the C implementation. But later on this can and will be used to
> > call Rust-specific features from C, as well.
> >
> > The topic is built on top of c54a18ef67 (The twenty-second batch,
> > 2025-10-22) with ps/ci-rust at e509b5b8be (rust: support for Windows,
> > 2025-10-15) merged into it.
> >
> > Changes in v2:
> >   - Take some of the pieces from Ezekiel's "cbindgen.toml" file. I have
> >     not yet taken `usize_is_size_t`, as that option requires cbindgen
> >     v0.16.0, which is not available on Ubuntu 20.04.
> >   - Backfill missing jobs for GitLab CI.
> >   - Fix CI failures on Alma Linux 8 because cbindgen isn't available
> >     there.
> >   - Link to v1: https://lore.kernel.org/r/20251023-b4-pks-rust-cbindgen-v1-0-c19b61b03127@pks.im
> 
> I really think that this patch series should include migrating to a
> Cargo Workspace. That'll mean moving /Cargo.toml and /src into
> gitcore/ and creating a new top-level /Cargo.toml with the following
> content:
> [workspace]
> members = [
>     "gitcore",
> ]
> resolver = "2"
> 
> Along with the other cascading refactor changes needed to make this
> work. Let's do this now while it's still easy.

I simply think that cbindgen and workspaces are quite unrelated to one
another for now. So an alternate suggestion: once this patch series here
lands we could introduce workspaces in the subsequent patch series. I
think that's still early enough, and this patch series here shouldn't
cause significant additional churn.

In any case, I'd prefer if you wrote that patch series to introduce
workspaces. I don't feel like I have enough experience with them to be
able to argue properly why we want to have them.

Does that work for you?

Thanks!

Patrick
