Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE69165F18
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 10:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726567539; cv=none; b=KR3YmnT4TpuFFIpWSYoptHLPtRgp+H1oDKClgYfHnKl4pdtLCSM8bcMhbGi06m4uK/QRb8kQTLbwoZdp0ejOFbzAdGxYoIN031sSeAou0afznyaNbnCOMjyHcllj+fWFLRDBi4w0+2TUlBev+kKZnqvyENqcM31vy0M78T3FBWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726567539; c=relaxed/simple;
	bh=17cEx0V44CO9cwhP5FqzoMDL0r1FbyBEoPnZukXz0ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bOolomRoZfUA2RxJt6rO3MxEa/Fe3Ow4e9Lcug5KEZdwsPVYnH8eyPWQuq+W/X3y59whH/JAjCheV6DS3t6jScmUEqqrwy4NzrMwe9+XUHdzhRYoiyl0NjfBovANluzXOdJRjTSSgqqDxdi2+GbBvhFWjEqpW2DYL2gHTmVDwJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aqBhP7ev; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B43EBg9D; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aqBhP7ev";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B43EBg9D"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 81E66138024F;
	Tue, 17 Sep 2024 06:05:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 17 Sep 2024 06:05:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726567536; x=1726653936; bh=hN+x0HCUHx
	e8Fc6Z038flfm3v9r8k5MRBEJWTQ2BFzM=; b=aqBhP7evDusovU/JRGvqmh7g2T
	mkMR98k2A7OcyMSA8c5j+KAtYA3Xs6Oob4cwPZAKrm85V/g/fmw4ZLcQaBC7rJcM
	2C5eFOp6plQkzId7qEcfOupOENK1+d2FvpXvDVO0WoleeVMcr0j7D0VLJ+tmY4Qt
	CbzYB2kmCl0tiTCeB9vwPPE6pAhT1WwGvMAycNcV5N0WOMgfn1pCgNbPHyMV0FOl
	G1PnpfCJObM86esMtOkEFURUPR97jzspdnHfgUrRsfmDkrNo7CUGWW9m/FhKA4pc
	c4cT2B72i3hoDkLU4agrwJ70T4lWc8QDYJGMqvdP9ToLs3SCURWtOoxqW+BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726567536; x=1726653936; bh=hN+x0HCUHxe8Fc6Z038flfm3v9r8
	k5MRBEJWTQ2BFzM=; b=B43EBg9DIV4hKvwZchxISEc3sqTTbQ9f+xkYk2W9lUP7
	Mh8Fx3Ii935BAiEEttbBkz+uOa0TNOIWoBvJB5Kr/PI1/sgETsraB7Ii/uXLHX7V
	/FCregzcBeFce10e7/LiGbQqcsGiadNzrT8jD09FqgA5gWGn8PpAeElNewBSVxXB
	yNwg9kAeKXJYox9xZgpFEjY5hzWk+RkDeSitJtOuH6JiBOPyYnt7KJfs4AuyWG1J
	wH2OMak/XxYv2UVqFBgzqQ/3XJQTRoIrLkBjCwnNEs8Kbk7crMHAKsf7fgsacJ7Q
	W+Cqvo4dJE1uZR0Xa96ELxkdhAa2ZAD9NmaNd8XszA==
X-ME-Sender: <xms:cFTpZsUiPEbnLuaQQTd12k4WkU8B4aog9_Hw09vmQtLnCHHmHEvVQg>
    <xme:cFTpZgnoaRqCLy8kcQQgrNyfNzw5f62W_v9xlmSmwA7b93TLin84JWzlAIw3Kt2zO
    iGEpflhS2gZZuPIUA>
X-ME-Received: <xmr:cFTpZgY6PBOqD9_VDbGFaZst9QZ7Nitu9jGtgF4GbfpqxKkQK5LDtGASHDdNPQCasfhpJ7q6laPy9faqvakht-Uwx5w1AJvdNBF6rh8uETiL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekjedgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeejffffveehte
    dukeegjedtuefhjeeghedtffetgfegfeeljeefhffgueehjefhvdenucffohhmrghinhep
    phhkshdrihhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhope
    hmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:cFTpZrWEMUPtCKoesGvPzTOUiwXJA4SP75sRAOrHnjfJxifWFxqyWg>
    <xmx:cFTpZmnjb6LZwkAT8Ir6OozJOtOv_t8zbVljL5oxVk_xf4uUBFIt6A>
    <xmx:cFTpZgfGpuMspXAUV_AvF7KrPvZ9Gwc8nwDtPgWAdNZTEDxUu_3gbg>
    <xmx:cFTpZoEs_tal0dldlWIFSsPc7AbWibNe2mhbT7xth-cTSFH7CWJtTg>
    <xmx:cFTpZohFKcs9fDY7F5xyDUpHXKDXtDVRVf62OlG776ZXvY1NdMaShLPA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Sep 2024 06:05:35 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7e99c473 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 17 Sep 2024 10:05:14 +0000 (UTC)
Date: Tue, 17 Sep 2024 12:05:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: What's cooking in git.git (Sep 2024, #06; Mon, 16)
Message-ID: <ZulUa3PL9zh6AqmR@pks.im>
References: <xmqqmsk7kpfe.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmsk7kpfe.fsf@gitster.g>

On Mon, Sep 16, 2024 at 07:02:45PM -0700, Junio C Hamano wrote:
> * ps/reftable-exclude (2024-09-16) 7 commits
>  - refs/reftable: wire up support for exclude patterns
>  - reftable/reader: make table iterator reseekable
>  - t/unit-tests: introduce reftable library
>  - Makefile: stop listing test library objects twice
>  - builtin/receive-pack: fix exclude patterns when announcing refs
>  - refs: properly apply exclude patterns to namespaced refs
>  - Merge branch 'cp/unit-test-reftable-stack' into ps/reftable-exclude
>  (this branch is used by ps/reftable-alloc-failures.)
> 
>  The reftable backend learned to more efficiently handle exclude
>  patterns while enumerating the refs.
> 
>  Will merge to 'next'?
>  source: <cover.1726476401.git.ps@pks.im>

I was waiting for Taylor's review as he has written the original logic
for the "files" backend. It came in this morning, and after some back
and forth on the second version he agreed that the current version looks
good, so this is ready to be merged from my point of view.

Patrick
