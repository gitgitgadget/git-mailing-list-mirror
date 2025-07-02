Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039FA1BEF74
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 02:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751423035; cv=none; b=Zw98JqWELc7RlKWklp9LGWZAPPZC/1gbY5Trv5nq602zSbcMQa2JXF1HYyf+TBPBEca9J1z4z1lyi9/Ri/oia9Z9q+bXw4f0RoVrXuOzvnyDAmRbL5GjCQd9w8cny1pk7ZNC20FQ6Hr/WRqZeHnqthqnFxD7zQpFjfAHseiR3vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751423035; c=relaxed/simple;
	bh=h8EsGOrFkZ06esX+ZoBeziuljFyZWshh71KlNZhN6Cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTUZe1n+D8MO2yvPjtGYvRrYlswMju3YN4Iv/WrhAkp7sVwHBZJ6UDJI7tll+XEHgnndR9vDUX3QFlz6bmTs6pNpNLMftu9Icn1qYXeGdOBkaV4/z+zoFlupWLYhRQdUXF5IZhMsLZ2YeQmvev5vTg36znksGyQnz6xq9ACIqOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Guif/FHp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bvCdsOVZ; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Guif/FHp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bvCdsOVZ"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ECD0E14002E3;
	Tue,  1 Jul 2025 22:23:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 01 Jul 2025 22:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751423031;
	 x=1751509431; bh=Xj7w+NidUcWUlH9hea2WYU4vmxudTX/fOdwWWcd+euk=; b=
	Guif/FHpcrzAHT8/mteDOQPJLbpi1rCU1getenrqI3JmwyONa7AM7CPOrzbBrV5g
	+KZShzJDG8rs/JWDw3XAMhdp9tWwDubkdnGCi10b439wAI+NZfFxkqpSRfmJf5e6
	UzEw2wUOmziitVcclaoCrWhkzm9S7/2t84f0PjvO0pN8l/gVqeObiNQBpxFnmc5r
	k4DNtj85QsVaSEtD3ebKje5KdpOjXRIUR1Uy7Jut6FTUoTMW2GhmIOAlN7XGbPU8
	2qe4UyxLC3dM9THc/BaXPAHTPjSdPxefTeAAdfCy+3qJiyNEAH9IvD9VjeexZAKi
	Vp5PsRV10oCxjtd0JqzNeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751423031; x=
	1751509431; bh=Xj7w+NidUcWUlH9hea2WYU4vmxudTX/fOdwWWcd+euk=; b=b
	vCdsOVZ6rEAGtLikGQc8TzMtNkG0GG4Lr7trADC4VIpvg+CV3Py8CfePFvfmL0Dr
	Rb2pQKiF7dzvE0+Ma7Ejb2qFtbTixWI4VC6igIn57dXSs8hioeBZt5d0/XzxdjUL
	hCk6Mc6SOijrKLTrKRMNyVAl3GInhiycvWiBkY70pYoivuqWwQS9Hdi7bKHwz6Ye
	WWOtj5Ti9O3P++HYvsHwx4yTxr8W2Cs0/1Y03r8u4Dhx1Mmsk7vbkZ5/IXfbsBMX
	afYU7mcM1prjo+SCsH2VDRofSKFC6Aya6eV8w9gf9JwFGF7avLYQbKzmMfT8QNHC
	NGZX2UO/27v9Fz5Ax5ccA==
X-ME-Sender: <xms:N5hkaNt4C91WKSckO3RJAQOcixp3AH_7Ic4mdSmUTCyqnTH_cNPrOw>
    <xme:N5hkaGdTUQgNM-3Qy_XTBjlDnfdIrppVX7e7m5T7_3NF1-DPCb4V2G9VBD5v6E78O
    6kgWrewGrbNLqYXHQ>
X-ME-Received: <xmr:N5hkaAxl48c1IBYKQXXoqZX0E0ntYIjo3dfRau10RXiLXAN-81PGwB_yks8fOzc2bvIf3zRrB4WnWiB0XDB56KdV3cXZ_9GPHaAokmFpdQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvdefjeeitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshhhhigrmhhthhgrkhhkrghrtddtudesghhmrghilhdrtghomhdprhgtphhtthhope
    hshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgr
    nhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprgihuhdrtghhrghnug
    gvkhgrrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:N5hkaEM6jjz0OmTjU4vHxh9KMulaPF4fn4DEGrB9h4XgaY0pyY7m_w>
    <xmx:N5hkaN_E7pzrVYZAF8h-JSSTboYrxcosQZdCpzJ0OBiGWilfR6iM_g>
    <xmx:N5hkaEXJBLfUetuDDeqjxeTTH85OPy7vnUTYHkzn3_hrWG_xHQ3bWQ>
    <xmx:N5hkaOdBFw4lQMD_YQHP0bkc3bmtYgJNTVEW9HxkkBdNNcOzlUmUgA>
    <xmx:N5hkaPel3OyIl4mHL057zArLUsLSCG9vwUo1ACbYuvxwH51cB1mSn3uL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Jul 2025 22:23:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ed03cdf0 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 2 Jul 2025 02:23:50 +0000 (UTC)
Date: Wed, 2 Jul 2025 04:23:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: christian.couder@gmail.com, git@vger.kernel.org,
	shyamthakkar001@gmail.com, shejialuo@gmail.com
Subject: Re: [GSOC PATCH v2 1/2] repository: move
 'repository_format_precious_objects' to repo scope
Message-ID: <aGSYM9W_41w8ImIx@pks.im>
References: <cover.1751296633.git.ayu.chandekar@gmail.com>
 <995389d6229df0c2a76ee4ba57e663a43abb4540.1751296633.git.ayu.chandekar@gmail.com>
 <aGPcJMfBCJuQLdtu@pks.im>
 <CAE7as+aVrZZtu7goaMC2W9dEc4xsqOT7RRxPZ6Dmvu=cm8h1vw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE7as+aVrZZtu7goaMC2W9dEc4xsqOT7RRxPZ6Dmvu=cm8h1vw@mail.gmail.com>

On Tue, Jul 01, 2025 at 11:54:02PM +0530, Ayush Chandekar wrote:
> On Tue, Jul 1, 2025 at 6:31 PM Patrick Steinhardt <ps@pks.im> wrote:
> > On Mon, Jun 30, 2025 at 10:11:04PM +0530, Ayush Chandekar wrote:
> > > diff --git a/repository.c b/repository.c
> > > index 9b3d6665fc..62709d1c91 100644
> > > --- a/repository.c
> > > +++ b/repository.c
> > > @@ -284,6 +284,7 @@ int repo_init(struct repository *repo,
> > >       repo_set_ref_storage_format(repo, format.ref_storage_format);
> > >       repo->repository_format_worktree_config = format.worktree_config;
> > >       repo->repository_format_relative_worktrees = format.relative_worktrees;
> > > +     repo->repository_format_precious_objects = format.precious_objects;
> > >
> > >       /* take ownership of format.partial_clone */
> > >       repo->repository_format_partial_clone = format.partial_clone;
> >
> > The list of variables that we copy from `format` grows longer and
> > longer. I wonder whether it would make sense to embed a `struct
> > repository_format` in the repository and then copy over the whole
> > structure?
> >
> > Patrick
> 
> Yeah, I suggested this in a discussion with my mentors and was
> expecting comments regarding the same. I can create a new patch for
> this change if there's consensus on this.

You could also do it as a follow-up change after this series has landed.
That would be perfectly fine with me.

Patrick
