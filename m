Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6582DBF48
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 19:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764703360; cv=none; b=NRHx/fPow6BZxt1/Flb5EQASFwIBlSJWiuVSQYVzFx4Ydy1cHYLIFaL0cS7+SkfIC9LUu6cOeNHX4H+DOX0KsWKvrSXhJmL9CrVc5YgaWDwNAp38RJ2qUDdFdXSHgNwex1tT949ZWHWvHf2IqHbFBg3SY6/B66fTotsxu60BLgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764703360; c=relaxed/simple;
	bh=mvlI/WFupLK5YGMFdKw5iyaP7wRJfBaUUQsdr3HdSiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oe7K3nVLCJHS8Uoj5zoWDjr3A/A3V3vXVAf5Ac3/On+fmO77Hfifon/CF+AJ4FI+HUsUXX8Rrun0YCgadn3/FlVARnnh2t2lBo1snrd7EZnmietuotcucpq+ANZQ10bhkDikDZcMBQXUdoville4LYJcdjmuGW2NHSLFH9GF4EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vk5Keuud; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yIk+8f78; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vk5Keuud";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yIk+8f78"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 188DE1400082;
	Tue,  2 Dec 2025 14:22:37 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 02 Dec 2025 14:22:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1764703357; x=1764789757; bh=zVj6mn8XUG
	fyUzr8oPW/o6Mz/xlKj7KfpAfX6LhWbpo=; b=vk5Keuud2yjzjrEpPDXIngRPl+
	1r8Mr0yjXGTEBMYR+Ej2DVONc6w6hSM6t4Ts09ddLhgFna7e0dphGkAACd+hEQgH
	LGwPfePYEAAa9XeMCL3Elb4O8OhbeNG/YfJikrKLid72oMha0DXDfHZOOJhN3JFP
	bLiCKNOD4kju5rfCC2o8ztMoj6WA+Iia3uW5D7xh0ThTZLaQiQtK9BBUtM/SAyuS
	CDsHDOjzXTgpemLw4quVeIIodspretxQFMoFIujz61J6S3IDRcYFFlAB+4gR82GC
	F0OwiJs4K9Msznz09r/WzZqJge14f5LBjmY8oO6KpZ+5bkvywgtpB1L/E5OQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764703357; x=1764789757; bh=zVj6mn8XUGfyUzr8oPW/o6Mz/xlKj7KfpAf
	X6LhWbpo=; b=yIk+8f78VQs62PeSz1X/7shm8AsPqmKNmjZFQ+YqWEb9aVumtX3
	kK+SlyIsgpeIE5VCVQZS+ZIoZ8iGWmU0MIIwr1uY95dEG1P8Gx5KQC8W90PVEqKe
	VaQ0tRI+PmiIbx+YDZ11eP7T4qqb+tiZJymcJAiDylLH80FaMaE2RgVX/iKu76/m
	H4ww94FHnIL/l1xtv5G3+dJutYzhhLkW4jOMGim5vgkS+TzT2VYGgI40dZpoE1vb
	RJXAay8+qJnhhb9mAzjILR/aC4NzgHrTHY9bX2/5b4grnY5iWT16IxvvUipOXXk5
	3uvxGVImnuCYsP5QBACMJt8sGFHJGeFMl2w==
X-ME-Sender: <xms:fDwvaeWiXN2CJAkXNi1qzvZKX16zoiBDwT4KJ9qs5n5zUjcvVBEVhg>
    <xme:fDwvac0dtTqXpk2Jx1o-g4m137XyxVA_WPf1mLf-7q-aXOalDDzmP_zE2y5XnVOab
    QQ1PEq3ZbuqPuIwGMFVNNmws0vKEY33clYM5hl1hnPi2aGrdwZeCQ>
X-ME-Received: <xmr:fDwvaUq6I-K6Te-zjOccMLMlr_XoMo0akqYe_0MhhLOKacvnVtggRci-6VfO2U9OuT7P7F2Dah1Indyz2oS7cbkGPE_JoE6XkrtpA9A1flU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    ffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfu
    thgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevke
    ekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrih
    hmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehm
    rghtthhhvgifhhhughhhvghsleefgeesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homhdprhgtphhtthhopegrthhthhgvfihhuhhghhgvshelfeegsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpd
    hrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:fDwvabU7fNkBaBkzRVpQpb9nOG4Jwj_hHpxGroCcMIewrS1MPAiDsQ>
    <xmx:fDwvaXbeGoBWKL95fR0nY4UAJ1ljuj4f_oNCbYe-CJCjpfLmelETCQ>
    <xmx:fDwvaQccZGoMQ5zsmXx1wVXa51-qmvMp-kE4j5YDrXIewOkCN-1meA>
    <xmx:fDwvaZ2UHJo7qGKDsX_woFYUCJin-eupWflUSWtPYOu9R1-3OvYLVA>
    <xmx:fTwvaXdl5iaotZTmxrCIN0lmU8oF2NcacWU8H0JS8tesptlIb7BfD_ZZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Dec 2025 14:22:35 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f23e21a2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Dec 2025 19:22:34 +0000 (UTC)
Date: Tue, 2 Dec 2025 20:22:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Matthew Hughes <matthewhughes934@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com, atthewhughes934@gmail.com,
	johannes.schindelin@gmx.de, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 3/5] scalar: remove stale config values
Message-ID: <aS88bnmZXMZCV5oS@pks.im>
References: <pull.2010.git.1764195516.gitgitgadget@gmail.com>
 <pull.2010.v2.git.1764607847.gitgitgadget@gmail.com>
 <8783db6153875deb52aaa354da189ae611de1057.1764607847.git.gitgitgadget@gmail.com>
 <ciegbs72xbepxawuf42pne7eu354ntbok5e3p6jxcuyddvaea2@6ykt3iej32xt>
 <aS6bCU19x-QM84tp@pks.im>
 <zbmzxqckpmf3h2sc7g3zvrhcyur2kmanv5uz6nyd2lgmi2it3b@i65jeyvcvqqy>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zbmzxqckpmf3h2sc7g3zvrhcyur2kmanv5uz6nyd2lgmi2it3b@i65jeyvcvqqy>

On Tue, Dec 02, 2025 at 07:04:24PM +0000, Matthew Hughes wrote:
> On Tue, Dec 02, 2025 at 08:53:45AM +0100, Patrick Steinhardt wrote:
> > Wait. Are you saying that "index.recordOffsetTable" behaves differently
> > based on whether "index.threads" is implicitly enabled due to the
> > default value or explicitly enabled via the configuration?
> 
> That was my understanding from a cursory read of the results of searching for
> 'index.threads' in git-config:
> 
> > index.recordEndOfIndexEntries
> > ...
> > Defaults to true if index.threads has been explicitly enabled, false
> > otherwise

Hm, true. At least that's a concious decision then.

The logic around this was introduced in 2a9dedef2e (index: make
index.threads=true enable ieot and eoie, 2018-11-19), and the ultimate
reason for it seems to be backwards compatibility:

    index.threads and index.recordOffsetTable unspecified: do not write
    the offset table yet (to avoid alarming the user with "ignoring IEOT
    extension" messages when an older version of Git accesses the
    repository) but do make use of multiple threads to read the index if
    the supporting offset table is present.

Older versions of Git complained when they see unknown extensions, and
we didn't want to expose users to such warnings. That makes me wonder
whether it's time now to revisit that decision -- it's been 7 years
since then, I guess that many clients nowadays would understand the
extension. 

The only (documented) downside should thus not be that important
anymore, but the upside is that reading the index would be faster if we
default-enable writing the extension.

Patrick
