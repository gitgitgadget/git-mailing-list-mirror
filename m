Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A356287247
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 09:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753781745; cv=none; b=jjhg9LJLu6NHsCzYZq3DjZzGD1ioPQJa/3aWnRm+SkylSJe9acPMNWbdtBCZbjMXHA2RMH8+rI97CBPAKv7tXf8efPnsGdZlPYpkve2hN0f4/kJeKbAWHobkzqDjsVkr4arZIEVsqPxZEeNodeQJ0kkoU9uSZ5eJweP4cKDyNaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753781745; c=relaxed/simple;
	bh=Eugxh9Ph1paPy9MLhMSAuVvYM96gHXyQLEDAZtRwTy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfB1W5hg1OXgAMU2+YmEGRiYNgCay88RX/y4eakHQU8mhAIDYYpZTWoTD04hHJvZmXLgYhK5RvsAG1Ue26iB4snHIAQBoV9bAYcR2JXRS0gSaNbLxe51MDskwCZIf5XictGXm/GYADUaNtG7R5ikTgdHFsiETWcz3TLt4fUaHY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XVk5/QYY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FyzeYILv; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XVk5/QYY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FyzeYILv"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 4AEBA1D0086D;
	Tue, 29 Jul 2025 05:35:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 29 Jul 2025 05:35:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1753781742;
	 x=1753868142; bh=UWs7B5CG59ZVpyy+WkSTUSfeAJT1QWG/qC46sW8rrdI=; b=
	XVk5/QYYdWk20zng+ANn7251Su5vaoTRSuta9P2JnMNUTrU+tSxdixkNEv3BBpMB
	0YsWrj8tR6wL56WwYIlmuklietx9qjZkHtxiSeiJbJuSDw/ljCThNl9wWhm9UGbI
	AXDtZRir4z2vCYfnYjuYtMKoOWr8Y+8bLDy3rVAj4Qq3JmR9a4cZUUQgmHF+yc4L
	3bdM4a2SjZ9E5v9szyMy7WiOSDysvGmI+u4DlM6TypRxsEhtbMpqGQImn3rLWR2a
	J+KZ+JxzZal6OVwlwYpkrDoC6mrFzwvE6rGXnZiKojseJxfuBzjTLHPaJdDXmuvH
	oqZXGQhreWAdx5GiTvbi7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753781742; x=
	1753868142; bh=UWs7B5CG59ZVpyy+WkSTUSfeAJT1QWG/qC46sW8rrdI=; b=F
	yzeYILvxfGxFvy6L3QUWs1LVT+V1qSeRIXHgEzd+BC9acIjEiqk8XfSnCIeBtR5a
	qfg/iw4w3mZskwMoqCfKTeKRLz0m0c0N6MkkxC+jLFRqhcKd+1EZr6rrR0eYSEqW
	xe3FAI9AKWaww2F3XCzzjN7PFl+HUj9okr6RTAI4lOnQ2qjfcTJpb999/FRlyc0u
	N6/SAuoDcdBPmSqOltjITbmsXy8Pwerjag9QA4nr57oK8lc5O/tgQ4ZJvZBsuYN7
	l5elDMM053+J0aSbV5CnYrtzhzjZpxlAC0UaJx1UjRp71AYqEV5WmU4CoFKKl/RO
	afl5IntgCj/DLLbGSac+A==
X-ME-Sender: <xms:7ZWIaFxXlYp6Qwji8UpPQfgPEAkujmCNbvxb1w9EWkvx88SznxEPaQ>
    <xme:7ZWIaCqyANvLQSZ6VKFMYhnqOj4RpnT4BUa0OW1AgpVClcsdejZIIN2Brr_F_KRh5
    ygr7plPcrh2po2lPg>
X-ME-Received: <xmr:7ZWIaGoPGGNorz35IKDhVLG2MxhbTTSxYFAnKe6wwndc9jZdTU6c0TlmTT7OSj-vnspdVgbPth0m7ZR_OFiUea8hc1olVw5rL1Q_OwDFbww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelgeejudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvdefjeeitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepoh
    hsfigrlhgurdgsuhguuggvnhhhrghgvghnsehgmhigrdguvgdprhgtphhtthhopehjlhht
    ohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesgh
    hmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhm
    rdhorhhgrdhukhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghr
    thhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrse
    hfrhgvvgdrfhhr
X-ME-Proxy: <xmx:7ZWIaCA1kITI0emmiBbLcVPbjfoG7WYAqfDdkiiwkRfdXDkZms4jLQ>
    <xmx:7ZWIaEtvE32synxP3c4A2AgBhSNcVWuMdYR4_bTBvlFbLq43FpozSA>
    <xmx:7ZWIaBKH4uNPaw_xvcuxY0VX6YPB7H_YTIFZMFA2nYdU2qWl0_AP3w>
    <xmx:7ZWIaLY03g9TsSjmrBhMkT37MNbRgnEVwf9fhC4XMC3J3CBp7vOzYQ>
    <xmx:7pWIaHCkUUiym8t7M0JXQwvc1npglnwEqr4YlQUcwNDPXtd6aJzajHPD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Jul 2025 05:35:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e87519d2 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 29 Jul 2025 09:35:37 +0000 (UTC)
Date: Tue, 29 Jul 2025 11:35:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org,
	oswald.buddenhagen@gmx.de, karthik.188@gmail.com,
	ben.knoble@gmail.com, gitster@pobox.com, phillip.wood@dunelm.org.uk,
	jltobler@gmail.com, jn.avila@free.fr
Subject: Re: [GSoC PATCH v5 0/5] repo: add new command for retrieving
 repository info
Message-ID: <aIiV4tuKg953QGGE@pks.im>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250727175110.84770-1-lucasseikioshiro@gmail.com>
 <CAPig+cSBj+kSmzKUarNPQt4qk5p9vjHFGFrJVYmT6TrWHACcEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cSBj+kSmzKUarNPQt4qk5p9vjHFGFrJVYmT6TrWHACcEg@mail.gmail.com>

On Sun, Jul 27, 2025 at 04:11:57PM -0400, Eric Sunshine wrote:
> On Sun, Jul 27, 2025 at 1:51 PM Lucas Seiki Oshiro
> <lucasseikioshiro@gmail.com> wrote:
> > This v6 contains small fixes pointed in v5.
> >
> > In v5, Patrick and Junio were discussing about quoting the values in the
> > key=value format using `quote_c_style` [1]. Given that it wouldn't affect
> > this patchset and it's a simple change that can be done later, I didn't
> > change it and I'll leave for further discussion when I start to deal
> > with paths.
> 
> The counterargument to this stance is that if you employ
> `quote_c_style` from the onset and document it, then if a future
> version of Git does start outputting values containing "funny"
> characters for properties which previously did not emit such values
> (this isn't limited to paths), then consumers who heeded the
> documentation won't find their tooling breaking suddenly. Tooling may
> break for consumers who did not heed the documentation, but that will
> be due to their own shortsightedness, not due to the Git project
> failing to care about compatibility between versions. For this reason,
> I'm of the opinion that `quote_c_style` should be used and documented
> even at this very early stage.

Likewise, I think we should do it now already. In general I don't think
it should matter much given that tooling should use NUL-terminated modes
anyway. But it's a rather simple change, so I don't see a strong reason
to push it into the future.

Patrick
