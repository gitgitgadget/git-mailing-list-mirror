Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2491426560B
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 08:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773648568; cv=none; b=h5daNp/5dVUVdcih6ogv0uqWt9+1OuNFzihheeRHIc66iwxivI48AiYRpX0kG9RPCcOjmo7xfYeFUkVSOmbJHmlVSV5eUxhZbaUdRT8ZydukAIlLUMeY8/THc4WjwGGJ7x7qukw8kcUfb/xcjyW0gQtkfWGQsFa8TgMz4fxxtbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773648568; c=relaxed/simple;
	bh=cVPSc+R15zKsyeiE6jKUnOJbqKNx4waV/qhN+GmvUEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cz/m8RuSKom/7TnlWLGyE2hYEcKVT+mEPhJ1qaIMbz5xNZKDjigkvuA4vwyx+OhV87YFI1T3MfXF8qBiLUxL7lLtZtLi+SaakjXg/Kpm2KpCPy/gckTOslQzn7syR+mwKkJShbeqpEQE8nNqzKYqPW8jCfmYkcVeXR60hJ+Ua5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=i6tdVQRf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iB3UGzuu; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="i6tdVQRf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iB3UGzuu"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 7392BEC0322;
	Mon, 16 Mar 2026 04:09:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 16 Mar 2026 04:09:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773648566; x=1773734966; bh=VpczY1I2te
	M1dbdeRBWhDBkaBF3CHHP0N9kTgIbQvLA=; b=i6tdVQRfQDEV//cZcai0af0XNw
	oIm9U82y55rCewnbdBL2pYTZzhk6T8uF4gqzIMqvZnUQ+NcD79HozpkTFMl8dxQM
	gznUbSU7ZZ1bnkNgdIqFF2lT2w8uFo8FNwCgwi0QtsCf1KiH2mt+jWfs1kHE1s71
	bMfr6kWtIXyEPPyZjeaqdS6wPOYyHf4Z9FBb7PUjBH+/PheJRfsEo5rk/T875AzK
	oA4f4KZcWbSB8mJo63K32EKzVz2YfzOBsuAZCcND2rG8Eyy+1I6HFKa0ljHjRkD1
	wuxPmGdbhltKes9hGKDpbpk2JbaDxB9YPiUSi9dh6HisveZXRwY/S47h0NmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773648566; x=1773734966; bh=VpczY1I2teM1dbdeRBWhDBkaBF3CHHP0N9k
	TgIbQvLA=; b=iB3UGzuu93lx82YOy5zTXwzFlX0fvCwlDUQij2KfGQyHGwtWuRg
	1f456HaK+GhuHj6QvuQ4hhLcUojpSOXb1ywn1mYmdzQ9YRL/kYowTKviabTWwr4L
	+YKLQqvRwuBA0VojuOxvXkfBhgJLuQIbQlOkdTLLL1iabQv1MpRlv6WSBypixYLC
	nCF/kf0wD2NTFQS40RIDLfwpDT95KT7wlmC2OxBfVoIRLroE9ZZlCVEU+yYxObXv
	7UpMcSPRx64EZb2UvSXQH9PPqDQEwh1qtdbqYlUo8rSV8S1V7HFXW6/Np8JEhGlt
	PY2cktH17qg79Mzzl5SMx6PEpHz+AP9l+tg==
X-ME-Sender: <xms:trq3aW2GR1BNmhBzrLoxglBU6KU1CcEMfNsxfF0jABtwfbDZxP7GAg>
    <xme:trq3aW441rxd4X8riFtWyI1OvWjw_HW_ztVrWPRtnxaHnha2M_nWp41UyU5Ql0Tg4
    4rK_Os6kaCqRf6HynSLG748IaP1fokO789X_nXUHT6AORiq-o3o>
X-ME-Received: <xmr:trq3aZUQkvQLOHYVeSkLMFtfiAu4fR4qksFvKFbzkNmho-4RQtbJrjL-3whKXNgBo4sYg9s-938NP-EE50vLfD4VxF1WPaxgY26oQkwE7SQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleejkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllh
    hiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:trq3aVA7CSud2RFnNQTHJOpwL20wh3JPVBUBYm48tbqe2AiWmOSTDg>
    <xmx:trq3aY404zOMZ9I0vsXRWsdvn6a0p0HEm2pgaBavbqMvk1qJawgtkg>
    <xmx:trq3aQzbCeshSFrylztNOUDtf15yLpE_YvStvOcQPWdhwVyH0FdN0A>
    <xmx:trq3afyeIehhByEMG4aPzXuV-Ky1MYIIX0S6oO_4gkxrKFIcJ_b2qQ>
    <xmx:trq3afQeoPADgPApvA56X6WowLnJx_LwLWHx9Ez6Re78ftBF-XYlCKxv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Mar 2026 04:09:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1f9bc121 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Mar 2026 08:09:24 +0000 (UTC)
Date: Mon, 16 Mar 2026 09:09:21 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 0/8] Some build system improvements
Message-ID: <abe6sUIlk7IuV42s@pks.im>
References: <20260310-b4-pks-build-infra-improvements-v1-0-ec75d0710d6a@pks.im>
 <xmqq34232wwu.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq34232wwu.fsf@gitster.g>

On Fri, Mar 13, 2026 at 03:21:21PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Hi,
> >
> > this patch series contains a small set of build system improvements:
> >
> >   - The first couple patches introduce a new "tools/" directory that
> >     contains items related to our build infrastructure and to our
> >     developer tooling. This finally follows up on my promise to do this
> >     back when I did the spring clean of "contrib/". [1]
> >
> >   - The last couple patches introduce precompiled headers into Meson for
> >     a nice compilation speedup of ~30%. It's 
> >
> > The two topics are not really related with one another other than being
> > related to build systems. I decided to throw them in the same patch
> > series though so that I can introduce "precompiled.h" in "tools/".
> 
> We saw a handful of exchanges a few days ago, but are there any more
> comments?  Is the topic ready to advance?

I'll send a v2 with some minor adjustments in a bit. Thanks!

Patrick
