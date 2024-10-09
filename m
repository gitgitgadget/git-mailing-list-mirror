Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCAC3207
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 03:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728445051; cv=none; b=FAMEW9ghKSXr1YmXJr9If2ueEuBDi9gigvFMOjqHHWm7Bvob+8tRiitD3N6Rem1UPnBvZUojw7s7jLs2kJEsMpfEMer6bY8UZVksX9F8NrWU76h0SqULRMO0LrjMXW3scFpkvM6QDwJvfXmOYdlowp6iQtsxhCgohaAPt+SL0Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728445051; c=relaxed/simple;
	bh=uaA9ykOdzr+uGB5iNfLgfZe6554507UYlLTtoDqhRK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h657SH+bYQU5he1CI+Up0G4uWH/LgT913WwuFtMpkDMSStkNu/+SJ0TUpUlZmHSveoydiZHbe7AMAy6Sj7VCE5Ti5Q1anmTmUgJk7Ge+YhvitZMqmabC9mXzn9mz7l6gnQdpi+fs+WtpSi0r7J8SZ0Po+YP5EiRE253HnG1GvI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PHbx3a+n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LNm9bC4C; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PHbx3a+n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LNm9bC4C"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 3DB7B13802B2;
	Tue,  8 Oct 2024 23:37:26 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 08 Oct 2024 23:37:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728445046; x=1728531446; bh=AkZMkqhUWe
	fOWlB936U2fR9nErz7YxJiNLf54YkTDS8=; b=PHbx3a+nQC6pcUuf/+N6WcKI5A
	4tHSnvcyPuAKATsZfF110HJmTaLjX2P5QGf9IvSdfgSrGrGS5NBxQpTZOJlS7CVJ
	SNvmcEN29fHfUtlio8eHjJsPnxFeiTlLiLtiQ3vMuY/t3hISMgTfH054C1ThmNop
	HialYDYlu79ii+ikI27T6j8MkvdRN5CIMR7l69zO9ETxy2BJEoepvFR19kEEPHfF
	RW2zFpfqeDO5KzzomwtqCtb5ITwwXon/1U3hDM9KdGPwWgsJf2647OkGAgOKgZwo
	7/rLBFQ7ERKCKgfBdbAl4qNyVIDGdZ5ZQUnlrnDN3a6CcD/jCWeIOtZhv8VQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728445046; x=1728531446; bh=AkZMkqhUWefOWlB936U2fR9nErz7
	YxJiNLf54YkTDS8=; b=LNm9bC4CsnKR6paEb+Su+oWRtqtsy4GOJRWQd/nF/P4B
	OHzirfVKCI01BwHlqxa65yg09Ld2sQ79htGvwqkH3YIkuQa10of+/XEKzJ+Wrc1f
	kNPoA9lT1zth2+hy0eyDr2mVNVBRBLmzDfn9SdYdLSVXNCEv7Z8XXrj/Z/8lp1v4
	fm54bMEikdht8S7Ph2NTq7XnYpjScRDDmWw3IQRkuzbnO6iFktsTJPz/p4OT6ykL
	jD47pzgOX5IC5M2kCHjsfV01/3vzCEUPh1hPzOJeWn/iIGP8T7+xvwpdmLXPFMB1
	WDdVjDTJWg0VWXhLhp6LCsPzrJ+WNdBWTKZmj8P+sw==
X-ME-Sender: <xms:dvoFZxDVqX05CAVrrGgVMEf8uqR56xUqs1p9lJDcQJBvnMvSNge-uA>
    <xme:dvoFZ_gzcqmC7DcgzhOLm26puDkcHL8tLVF_DdRz2ZufP9uYIF6bhDglcOrmYXk7i
    p3Zgj-Obkkm708CJA>
X-ME-Received: <xmr:dvoFZ8lIUbBf6rnpfZMLFrAaC32-64piOKREp1aBTqMZ7nFFcAP6gWkvlxogjNG-Cy85AaxpRxWcLqolyn9k8yipJIJkWwjcvxXGM8OSMGMBQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefvddgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhoshhh
    ihhhvghinhhrihgthhhssehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:dvoFZ7z_L8YDfFt3BPRBgg7fn5F9eKjEFmOuNltdQRiLTZRLze3Egw>
    <xmx:dvoFZ2SPxodWhxfAQDAW-32ZEWmQE26rH_UA8E4s9OH32d748pYl8g>
    <xmx:dvoFZ-aBdZ3BxWLXLVIl25U9gO52NEE_H5mOdzPGfrGH28KiTLyw-Q>
    <xmx:dvoFZ3SEYkTY5RZ5mhRcFlZd9fBzmphilP6oPZa1SK0TSscaWLaT1Q>
    <xmx:dvoFZ0f-uc3zSwhxciwxwje-uEicZJ2D5CiicyzbSG4aBHW25xPRxfcS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Oct 2024 23:37:25 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7ca8c572 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Oct 2024 03:36:21 +0000 (UTC)
Date: Wed, 9 Oct 2024 05:37:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Josh Heinrichs <joshiheinrichs@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] git-config.1: remove value from positional args
 in unset usage
Message-ID: <ZwX6byY2IVFvKezP@pks.im>
References: <20241008040749.69801-1-joshiheinrichs@gmail.com>
 <20241008142920.570244-1-joshiheinrichs@gmail.com>
 <20241008142920.570244-2-joshiheinrichs@gmail.com>
 <xmqqfrp61mnz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfrp61mnz.fsf@gitster.g>

On Tue, Oct 08, 2024 at 11:20:48AM -0700, Junio C Hamano wrote:
> Josh Heinrichs <joshiheinrichs@gmail.com> writes:
> 
> > The synopsis for `git config unset` mentions two positional arguments:
> > `<name>` and `<value>`. While the first argument is correct, the second
> > is not. Users are expected to provide the value via `--value=<value>`.
> >
> > Remove the positional argument. The `--value=<value>` option is already
> > documented correctly, so this is all we need to do to fix the
> > documentation.
> >
> > Signed-off-by: Josh Heinrichs <joshiheinrichs@gmail.com>
> > ---
> >  Documentation/git-config.txt | 2 +-
> >  builtin/config.c             | 4 ++--
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> Patrick, do you mind to forge your Reviewed-by for this one?
> 
> Will queue.  Thanks, both.

No, please feel free to add it.

    Reviewed-by: Patrick Steinhardt <ps@pks.im>

Patrick
