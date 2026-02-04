Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC25309F09
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 06:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770186368; cv=none; b=gRtoD18ufuczJFs816BnkzUW1dRqIk3LYJKmSyjHby5pu8nGQvIsnsZVs0pKyPiffuC545BD2VgoWIlis+RgQ1phTIk/UoMq4AK/Jw7yojArEqztb1DYJ/XJgMs5QdmI8BLZWTMarprxboXXusr4L8qoH4kax9l7gDsYzSXBJRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770186368; c=relaxed/simple;
	bh=HNYoJ9YArT3+VebtgVfK3Xnf4qAQecz7Z/JmcR/jOkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wlg8VzeTg7nbvKUs3WPxw7/ebiEfle14TaUhIUITYHeidaHe298GlZcpjdWHWpPmGh8/ikVz+jd6l/x4chWcZszjOKQ73PuwOC33GJeBrdQoZVUHPeF8rGfDcXTjZpMGfvvcJPUDGvU9UBd9ZYz1fyGsrwVOojq4feNqbMV9uwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bunHFZEO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R1hEWpLy; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bunHFZEO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R1hEWpLy"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 56DFB1D00163;
	Wed,  4 Feb 2026 01:26:07 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 04 Feb 2026 01:26:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770186367; x=1770272767; bh=l4c9swWXqn
	hfrMU/bs7IvLl9ouMYpCGTw5YHvQCmiM8=; b=bunHFZEOkB5eu9mPALoW8X3oXv
	jhaxAIxWbHyeJJ9tGnd5GJ8ZOHAGUn4zsvxg5ASSBLK6SqISN17f7xxH6tlRoRLB
	mxKly+pE+opZUdlNZ7NdYuW4K9v7WH6Q6bT1+lwyK0MAyYJV+prnMZuq1TbsJ02x
	70JOjNRhZGUpdlSGj6hJbsR2UHdgFVbbu9NaZznC7KSTVnWF78/Z25WLoEmpBQu7
	hMv1BwkUxLq6Id24XQueBka8PrghnRNZvSL1R8xza9RAv0K0Y/jNTmfdC7k+MKkT
	RGWfJnZLubHRz4PsJTrD4tYcBm9/KZJYwBdiOS+qgOBbp0PN9NxYeO7c6kYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770186367; x=1770272767; bh=l4c9swWXqnhfrMU/bs7IvLl9ouMYpCGTw5Y
	HvQCmiM8=; b=R1hEWpLyuz1tbGy4QhLj2ORw1pbozFI255W5Qv2eZ5kMZIKMktf
	P9Md6p/eUn3UFRbYK/nSBWP7yVYYC+p+kmrXb6KOgmBWgt67oxR6bWaEMrB2e0m3
	MNd/1UCfKGtIlul0jWWNEhtM6c9ePmlh0kZ3MmhJoYo8/Ni/PVYxKqsPDDVogs1V
	IjrM0MaQrH6nPgC+656B1/RuRmcMqfXL0CDodJzp3S6DmcWYoZZaL/r9nmjrKJkQ
	mxMA1tgXH84S5pUoHqa5gqj28vlYKbS7EOhijc3AZru95AI0Kpf0eqZFaZSxygTa
	6Q7hmJeKKLeqf9F3AAZCkCxcERJvETnIpfQ==
X-ME-Sender: <xms:fuaCaS8OL_eSZ72v9KZ6eVBEKES3Jwj0WumtCnLr7rpkNZsRRTyRPg>
    <xme:fuaCaZsESr7ZuSMhbFTrbhs9Z2R0bL1FOaVEPNqj5QNoXQwQrinrhyyezes4mh0Eh
    TgaLwZqF24GauGKTqPBKfpjbRxm1LFNtQzgHpjlPgxCzK-tPRTu2w>
X-ME-Received: <xmr:fuaCadBFdZwryB6pxY3rbVO2pj3YlUAdzI2sziG75Ow-V5rQyw-2sHmmNO6gVx7yzs4SqUaEcecce2A0iKXcCVeLeyy7HhVNQr5vAXGrCntm2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeduleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhr
    tghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:fuaCaZWnh49H8IWMK_IdcZRhVZqK61ldUcJ-9JAyT1dDdsLA1wdvpQ>
    <xmx:fuaCaTBu711t8YKju3wJ_yjHsRs44F81ZkDidKVKlAJWw4FYh5QcZw>
    <xmx:fuaCaU9Yx56b6NMV6krNG9iQ0JTT_A4kbFb4Z89Pt5uVjiQGkoahQA>
    <xmx:fuaCaSGn9iYLy-TI_K2Hwqg2Qfgq_99wUZclVZLogoqKNxywpFe0Tg>
    <xmx:f-aCaZAnuRMtrlKf6lXRzBFVDUrYxczxw3HGck57mIa2BQ54mpAC9veI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Feb 2026 01:26:05 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7568f7fb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Feb 2026 06:26:05 +0000 (UTC)
Date: Wed, 4 Feb 2026 07:26:02 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Justin Tobler <jltobler@gmail.com>, Toon Claes <toon@iotcl.com>,
	git@vger.kernel.org
Subject: Re: [PATCH v2 3/4] odb: prepare `struct odb_transaction` to become
 generic
Message-ID: <aYLmel06ANrskuG5@pks.im>
References: <20260128234519.2721179-1-jltobler@gmail.com>
 <20260203001002.2500198-1-jltobler@gmail.com>
 <20260203001002.2500198-4-jltobler@gmail.com>
 <87o6m5rff8.fsf@iotcl.com>
 <aYIirIQveQiNWzsx@denethor>
 <xmqqfr7hqvzj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfr7hqvzj.fsf@gitster.g>

On Tue, Feb 03, 2026 at 02:54:08PM -0800, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > So long as `struct odb_transaction` remains the first member of `struct
> > odb_transaction_files`, using `container_of()` is functionally the same
> > thing as casting. This is also how we do things for `odb_read_stream`
> > and `odb_loose_read_stream` so I don't think it is too big of a deal
> > either way.
> 
> It would be a good theme to clean them all up, together with
> existing ones, in a separate topic.  Code hygiene matters.

Fair indeed. Justin, will you handle this cleanup once this topic here
is merged or shall I do it?

Patrick
