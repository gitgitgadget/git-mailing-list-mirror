Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C0E2FF643
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 11:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756900285; cv=none; b=lrGVKaEj3lqxjdHrOYDJ9KkE3o0+Fy5GOZ2HXYSsFnVN7k8ltvRtCfetOFckJcuzzpxsyS8Il05UIRU63O0RdB1eKXqQjZTTPNDyqhz1pV5XilkdhRWzh3o0A5tzV+2teluLA2jTQjg+caBKkW20sRedekj3u/pwBRvd5/95Va0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756900285; c=relaxed/simple;
	bh=v/81gzzGavvEI2dPfRpnVvkphOc8XynqshTR2J4chg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BUTdzfyaz+u1/2a1hNosSNNi0+/SapjNHfJ/WkZQcgYwbyH4z7YkyABL0MqQJcfyFx2EqW2ykbMfCsthSCv/OXLtcOGFCKU3HaiapWY9SaYkEqUmSf5QxxxOBF3++kcrvNXrAzO+lPR6B5mL+/NN3orTjuDW+2iZ8Pwq2WHsJcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Xes1gHyg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nMva2rxS; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Xes1gHyg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nMva2rxS"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 14E7914003EA;
	Wed,  3 Sep 2025 07:51:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 03 Sep 2025 07:51:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1756900283; x=1756986683; bh=MBLe9txQbc
	0afi3kglZFkWkCpNKFmMDKawFRgm95hKQ=; b=Xes1gHyg6QriSwHaMsyOTXyVA2
	nyilSMvwxZUNclAoBpiUZW/Q4n6Ux8iE2/4HdRRrJUV/R/qJrzECY6buAsASuu8Y
	Y6Hl9aiwr0yG5lPorE1Ji+JwPWPgo3shKfYlrGX7b78RV3yP1OfqmznPxX3CiBTn
	3Jv+UfsjKSmnQyn0O9K2i01Pvnpv6+LMWt937mCoPC+yjwxnTwbD0rPk0cElV6eb
	Z8CjRyP5vEYeZkG2M8bDzb3jG3OqgISlKMQhSGv7EFkSpO2HQMq2te6ujn8fW14z
	j8lphN4wgLN9d8wphiMVh7/1ZcM567F6UTKC5WRdeMiIzA/AHyAF0hc3sK7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756900283; x=1756986683; bh=MBLe9txQbc0afi3kglZFkWkCpNKFmMDKawF
	Rgm95hKQ=; b=nMva2rxSXX4+gkDLDpbU74VsvrcU4XMRSA4L0kv29FNkUT1zLSc
	FGnI8RQZ8ifhP5+hmfxK060SRBISZKwpOHvJmpIfBsVIwc5W84fY3LYhsP3ANVQC
	Mi4jSDDTIjXGlTz42B1v38J4VfrrCs3uWXzheuOu3+Tif8Dg92GfBiEd+xyz4ATY
	JJPxlC6O5x+7kWu/C8G4deKUUN16VBwQvbodDcDQX6m/SNcEO2MI5omMX2VCI7qQ
	bjyBZnqxfnSAYmNOHZaf5AC3CcaQEZ71apjipmVvHGxd/Yh0VGi1l3crZdqDsnBG
	BsAVZSVunGYKiQWDIizJ8Yb+kBiZgZM3thw==
X-ME-Sender: <xms:uSu4aCf3Fq9Hpi-9-oE_i_SfRZIEUJJitAqYI778vvbqczbNNpOVHA>
    <xme:uSu4aFp7CYYrn-YvEgVYTIWcnIUmmio-sTUve94kVZhFJnyt1PnXjICPlHwYaLsSn
    h76EcaQSUVeEOBUcg>
X-ME-Received: <xmr:uSu4aDGvaqikYGFdSk2X-qwkv8vKISHMGGxGhK7JA5E5K_LN-POn1y_v6hEFk50Gc272SYmhFZBhJLb3leW4y_DhafbYWW9GCW_Ix7k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeftdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepje
    dttdegffekudejjeegudehgfehtdfgtdeiudelueelgfeuteehledugeeuueevnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhuhgrnhhgshgvnh
    efieehsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhn
    uggvlhhinhesghhmgidruggvpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuh
    hnvghlmhdrohhrghdruhhk
X-ME-Proxy: <xmx:uSu4aFux6RUSsY0J1tjhcgnWSvy2gZDnzQ-_Yob8rysNNeUdv6FLLA>
    <xmx:uSu4aFUs6c4OJ2ka7ndUzVDbENl1AuQ7FBEqDZ3XE_l42E_uFe1Buw>
    <xmx:uSu4aBHRis5nifI-0yZPh9fMGJvW7iYq6Vx8dBcYJzc0fGv5V3oRog>
    <xmx:uSu4aH10PajAkms4jxJkOGpKM6vLtkORNijPoFt518cqwgVFENff7g>
    <xmx:uyu4aOncvY3XM7nWUwSjlmfyjayMnmOGGnzQxCsMg4pJll-wt3h0MWL3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 07:51:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e2746372 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 3 Sep 2025 11:51:20 +0000 (UTC)
Date: Wed, 3 Sep 2025 13:51:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Wing Huang <huangsen365@gmail.com>
Subject: Re: [PATCH 6/6] breaking-changes: switch default branch to main
Message-ID: <aLgrtLtqTnSOatTD@pks.im>
References: <cover.1756308283.git.phillip.wood@dunelm.org.uk>
 <487d1a33130cb2fafadcf98da00a332a7408a0e8.1756308283.git.phillip.wood@dunelm.org.uk>
 <aLbWuGQhriQCMFbO@pks.im>
 <96e128d9-e5e3-4bfc-9e33-3caa75cacfe6@gmail.com>
 <aLfHvl5JuttXrI0y@pks.im>
 <9d52f24e-d495-44d4-b122-7d80d1f4b77f@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d52f24e-d495-44d4-b122-7d80d1f4b77f@gmail.com>

On Wed, Sep 03, 2025 at 10:54:06AM +0100, Phillip Wood wrote:
> On 03/09/2025 05:44, Patrick Steinhardt wrote:
> > Tests should be agnostic of that name and use e.g. git-symbolic-ref(1)
> > to figure out what HEAD points to. So maybe we should follow through
> > with that idea and start refactoring tests into this direction so that
> > they never set or read the variable in the first place.
> 
> That might be a good direction for the future. The test suite could set
> TEST_DEFAULT_BRANCH to the default name and tests could use that rather
> setting GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME and hard coding the expected
> name or running 'git symbolic-ref'.
> 
> I'll drop the removal of GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME but I'd like
> to keep the patches that switch the tests from using "master" to "main".
> We've converted nearly all of the tests already so it seems a shame to leave
> a handful unconverted.

Fair enough.

Patrick
