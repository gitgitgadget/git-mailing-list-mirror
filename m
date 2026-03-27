Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11822E9ED6
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 07:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774597820; cv=none; b=MCwTBnD9Z+XtIjqzwPvexeGE6XApC/xiTsmeNC8qw5B7P/NpoMyKYRzl+hLbKGnE3Dli7CmypqWRQaVzoxnjn/4UMFoYVMB/ZBLNBr7iP7+PtOsUzY8LX9fOJyPJQqF+Zjwv1XbbjguwC0j1f/4sEPI1RgGcF36LlYCL+XpGnuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774597820; c=relaxed/simple;
	bh=llYfupxheZybYSUfPsmXU93x+5gAY5vlA7APhaff+kM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhhZsG8kg80MvKw+TPeA4xR5kWfduUQLP31FH9aYhKzIMQq6ttgQUf/hPd0Lkt9RWRZSPKGg6DwdFEjynCnK2iNPNXLpMxig/t+OEI2znT391+rQHNxR9vx9in0H9acl3UnSWFDzZymWno+xaLduWNxgws3QTmc4jaOqWrjjFnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KpJCcWDU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s44q6xYo; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KpJCcWDU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s44q6xYo"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 87CF1EC0267;
	Fri, 27 Mar 2026 03:50:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 27 Mar 2026 03:50:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774597814; x=1774684214; bh=zeCyxvEO8K
	nX7zbTLOWpMs0ZDiwBKJ0bwrr9iAQrWzA=; b=KpJCcWDUsO9GhuGFhq9MLYUjze
	Us5tE6+x18kbFNfqcLjyHEMzG1P2uLHAYeFOrygsBPvmRapSeZ1HH2MFaPWUx70l
	fNDR2K1Cthg3lcMVnXDtVARU6VnBzJe03KLSB5SHv/vIECtrbCyyn71m0FrPmqIf
	OQX3iXWWrH2kjf/x6GYHEK2F+3daokoQ6SNuegPzbJeRCH8RJeSCIZwLQQ74ojfP
	xUEYB1ckql/BjUUxXYe+Ti7tnQEs2ecjEZbUmJm5aXj8C9GvP8UuhPs67wLHiTBE
	B27pno7Lyv+PCmSnVvWkKKhYgPLPfMgJ8/82+9oh0/lbXzU5pCRiXd4Zqo4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774597814; x=1774684214; bh=zeCyxvEO8KnX7zbTLOWpMs0ZDiwBKJ0bwrr
	9iAQrWzA=; b=s44q6xYoa9VMkmPfJ0PFB1Eedt/Vd1Ru5EfEK6XlfjD6htoBe5A
	oY7oWBngG8qaIpBuZxPN5YwgYSK+1X9diQiEbv9uVBVMfyY4zPqC7SNIAOCn/tyb
	LsTzWxN2iybOsXr9UEFZQ/4hsW7FA8rBLDu2HQGJE7xFst2YoI+cLVAtRQUTNNgI
	cbQbJ66CmwHSGTZNMYI/Fn152rCzmTT5V4rmSKo8I3sqh+kf+HSO87mGQAR0yWcy
	hU34VYUN5zfA6+fGDeBEz1OuN09rLxLPDb4txZoZJ8d/v5M98owrSumdVLZ3yHT/
	pUQjRPd/IDBU+YKhQtR741jzrCynpHsIgGQ==
X-ME-Sender: <xms:tjbGaZEtxSVffsBm1D7HgOxhd1sj88rRgab89X8qEaNGdD3jH16aqw>
    <xme:tjbGaUVMJNT7nMrv4eLjmWtvaUUzjssViiDtUeZzR4YnCuen3s4zw0PBziIPwyfCq
    aPKY__g0bKz0tRjim3AeNtw0XDiCxPVLHamOpG6FAS8-uG6z3MRkQ>
X-ME-Received: <xmr:tjbGaYxt30mrRekI19LwaIBvYWRmRPytFaVLJGaK3fxa_EK5-6LK8Q8G3LfNSHibOQPqSPLTMJ4tXgRI6NRmNC-JHAH31eEV32xZAQHRfg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdeljedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepshhhrhgvhigrnhhshhhprghlihifrghltghmshhmnhesghhmrg
    hilhdrtghomh
X-ME-Proxy: <xmx:tjbGaaO1d73VXvlmnuPWKdJMIUpMaWEKBvefBblK4s3Ve09UxlwCsw>
    <xmx:tjbGaR5GM-9MD9zSYs54vQSsCZxpcFnFRBUL4LShQdxO5spjTr7PEQ>
    <xmx:tjbGaTO6Ey9aA2ma6tIPxJKuW-n03kwrPVE7Rco1O4KdD4FF5rlt1Q>
    <xmx:tjbGaXnMSIGc1kHEo8XKTybaB4iiDn7Ty2qlt_G3f8yfSNnOUS-dWA>
    <xmx:tjbGaZ3Z4Elw-L-O-VfjVf7cPHcZSfsBL6hEGYN1QUVkHSVypgwvHk9F>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Mar 2026 03:50:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c5f3e0f4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Mar 2026 07:50:13 +0000 (UTC)
Date: Fri, 27 Mar 2026 08:50:10 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/5] refs/reftable-backend: drop uses of the_repository
Message-ID: <acY2suRJ4OlNHYu7@pks.im>
References: <20260325164833.1216577-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260325164833.1216577-5-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325164833.1216577-5-shreyanshpaliwalcmsmn@gmail.com>

On Wed, Mar 25, 2026 at 10:14:21PM +0530, Shreyansh Paliwal wrote:
> reftable_be_init() and reftable_be_create_on_disk() use the_repository even
> though a repository instance is already available, either directly or via
> struct ref_store.
> 
> Replace these uses with the appropriate local repository instance (repo or
> ref_store->repo) to avoid relying on global state.
> 
> Note that USE_THE_REPOSITORY_VARIABLE cannot be removed yet, as
> is_bare_repository() is still there in the file.

Yeah, `is_bare_repository()` is a blocker in many files :(

Patrick
