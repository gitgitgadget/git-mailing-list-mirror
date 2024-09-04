Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB5519750B
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 08:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725439789; cv=none; b=iKcCSKZBiwVYcS9B5A/SSa1wcDNUWiyIFaGk2htsq+zWMoo6GG2Ys2WEwksBZpyy/MSh5mkBc9pxuZwu6U5/bupXLIzdbdWGeUZdbEb6qd1nVYpMPfEFJtErwV5YW5R2bWJWf7/wCN8cDTtj9WaZbbHAYQhiegeKuZcSIiTLmEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725439789; c=relaxed/simple;
	bh=vTtvN7SRiFx/GzG2P7a1BrMMKKHgr4vZN75sbgrZYT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqSDMjR6wJTTmXQ8q5eENgbGdc2788MAKlWoRYRopC6Oi3hd8PGyPi97UaLMCvxrcq7M1YtxaltFMjhscvfntwpJ8Bikytc8Z4pHQD1ooBvS0XcLMkFAe3qKZp56CzgCaOlEV5CO5Z+pDXPXsR7zkzmH03KgVL44NxEGZbkpMgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=P7viLkQq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XE9XPP02; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="P7viLkQq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XE9XPP02"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id C69991380295;
	Wed,  4 Sep 2024 04:49:46 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 04 Sep 2024 04:49:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725439786; x=1725526186; bh=9pHKdenU5h
	mqq5o7Jd6pXW7iiesDBSp0d4j0Aiggd7c=; b=P7viLkQqIIW0FBD8FNE9Qq4hzn
	4miZEwjDZ0/4HAJOJYarLHExh7sqEMqqdkJ2O9t4us/UsKlKFVAhzt84t+YBqa2w
	fCPMXUgMKPojqyMNvj84UeAyqOcUMVad7PDbBnzhP29I+F7rVwIqPAFCaFhKDd0H
	vhd8Cbm9IJmtoUVgkYhjDpJvmEoNmeO+uA5hSi4cOU/+GvCgvMHGnVCNFIj9yFU2
	APMgau0U6sM6HWxwTQiJ0iVFOBsOAYrxSYiiv0FSSWg1ckg9ZsW7naulhACfrGHE
	XZKya6rk09oCa9wPz654YX9N7ElMM2dsHKw4m+i399qsQFQP0gAzhM7Ff0nQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725439786; x=1725526186; bh=9pHKdenU5hmqq5o7Jd6pXW7iiesD
	BSp0d4j0Aiggd7c=; b=XE9XPP02L3ZzZrQ8KpqfPOY/2hqw+AzdQ6Gs0/SR1Z9h
	8c0QVJode929vSO1M2TDk8NSN2pfzCPW73CUDGxwUB2JSA2SfRw13akHUs1qSCdg
	VM54hZTz4GLx//ekx/5fL9ibft75mBFsziYLz1i7wlPG5L5w44kHaEAN4Vwv9dkQ
	Y+qndfdGgQ1epUmXyW7EvuJhYycIKzhdHOr1kASK0rqMqD5Y9Yh1Lo2gqyDZsyQX
	dM5MmdQZOlt+fzdSwgGnhNnyKkVlHE2gfU4eK3QDXFVf65UZNKw8AVXBdJGlb1Yz
	2zEksbV+79bBBxsqsvTl1z4DGObIzbBzZFYsmHozFQ==
X-ME-Sender: <xms:Kh_YZu494YqoSqBLzygr3LHxw2xIR9Z5hF3gsMhLd-8A1wfEd9rPig>
    <xme:Kh_YZn5O6UKi4bnDz3tMnk25ULxIqCq4-sMBjHEk0cnmrxMmveQ7H_A6KYpsfGt0c
    H7qiQ1c_IFFhRKEhA>
X-ME-Received: <xmr:Kh_YZtf3Y7G03_2DuVd8XpnwJPjamJwZV_EjrOqFdJ2a630IsJkJb-ONbC4J4p_h1YjG2qlNXu4NYnjpjMvTLSj0H6I0bDVm5lwMdZK6--as>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehjedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Kh_YZrIcU4kn4SM2PY8V-l53GbFJaAaQ41Y36eOcm8RNB6vIil00BA>
    <xmx:Kh_YZiLohjBlFADJ-CfPPh7l-OHL3VMpy77J1ogkyI54n2SatAPytQ>
    <xmx:Kh_YZsz-PdoJfy_ftx1MjekP3dS7MFNxGtpk7EbLUuT70IEtvGUc4A>
    <xmx:Kh_YZmJW_t0WBt9Wk8bwlAs7DoCAOvPK7fqGQ9bTpMh6EA_nB4phYQ>
    <xmx:Kh_YZpUXRnNoexQFuf8qz2KXDSYkf3L6tlVZ3tBbKh8AzFieljBiWmpB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Sep 2024 04:49:45 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8be67946 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Sep 2024 08:49:35 +0000 (UTC)
Date: Wed, 4 Sep 2024 10:49:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: karthik nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] refs/files: use heuristic to decide whether to
 repack with `--auto`
Message-ID: <ZtgfIPOZO1p4_ExF@pks.im>
References: <cover.1725280479.git.ps@pks.im>
 <9a63abfe3b812a32d69c7393004bea4f88971559.1725280479.git.ps@pks.im>
 <CAOLa=ZRGvU4LvX9kjvF3dJCTvKR6CC1CwPTp515c3Wt5M8a5vA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZRGvU4LvX9kjvF3dJCTvKR6CC1CwPTp515c3Wt5M8a5vA@mail.gmail.com>

On Tue, Sep 03, 2024 at 02:00:16AM -0700, karthik nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The `--auto` flag for git-pack-refs(1) allows the ref backend to decide
> > whether or not a repack is in order. This switch has been introduced
> > mostly with the "reftable" backend in mind, which already knows to
> > auto-compact its tables during normal operations. When the flag is set,
> > then it will use the same auto-compaction mechanism and thus end up
> > doing nothing in most cases.
> >
> > The "files" backend does not have any such heuristic yet and instead
> 
> Nit: s/instead/will instead/
> 
> > packs any loose references unconditionally. So we rewrite the complete
> > "packed-refs" file even if there's only a single loose reference to be
> > packed.

Revisiting this: isn't the current version of this sentence correct?
Replacing it with "will instead" certainly makes it incorrect without
also changing "packs" to "pack".

Patrick
