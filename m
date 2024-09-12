Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F6C19F429
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 10:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726135506; cv=none; b=QdmXwt4PMpT9PDMM/bNsx5eJhMNljK0GyhupHkvPLCHQXJQkhUCcJ2A48o0AfErJMwMXzbgB5jYaQuVnXKly9D1OZQy9kq1uGwDElbLSKr6Tk2XBFEdB66XFmSj+m/8LEt66VVhZZwdXeWkt+09RxGs+O7xPBcB9J5ptRoyWqUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726135506; c=relaxed/simple;
	bh=HqxG1Hrx12hKPsXix2Riv3LEez/jbZDObYwY31QQExg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RC8F1Q9Mi96ooZu82eOVrZ2om5AKtLuJ+Phttik7qpCItZZxPY+a/pAC9l4CVUee/oyD4JXFmfFiirBMYTToGZO5pqNvSlIfP/Fn7vZEC7b6BjfC2BXZepmdbHYrN7PQlrqrbbPey5gMuTWFYGc7Fja2ynedlF4AGdm6ogZikZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gBONglNS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gN55fAFZ; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gBONglNS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gN55fAFZ"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 12C7B114043A;
	Thu, 12 Sep 2024 06:05:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 12 Sep 2024 06:05:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1726135504;
	 x=1726221904; bh=Nsr5WVqrJ1yfFUacL/eMivJBq4MLIK18Zh9phrbhfgs=; b=
	gBONglNSoqXeJhsxfss2hTgP+d+Fn7qUOmCsq+4bawDtGPPUZ96+das+4nLSRGqT
	/eBkl3FxEmL+ZjNg5F1TU9n0th21EgIGZ2INEhkIMVF6CecStK1MTrQD4bvE9hpu
	DXH7zkWkY7GvNjUWc7Hgzg2r1IdOxiLTJdcG3VgRIfDTVZxBzes4+4wE85v/mWi4
	Oiv/6z0hDUtinDYntX5p5KACgn44mGWbGR+LLNUlswAAk+RiDTFyh5Do2qgQMJXu
	rP+ZZAo1ZDodXVfmcGfypsk42ZGxYb7MRVRukMzbcZVBf0SrwhFXmAE97e6K6q1i
	Hv1Nrskw8Yu22XACzqVT7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726135504; x=
	1726221904; bh=Nsr5WVqrJ1yfFUacL/eMivJBq4MLIK18Zh9phrbhfgs=; b=g
	N55fAFZybSAvl4Tw/MqqUPipIyuD/jFOcNfPVwSlKOiWmt50fjeYXySHJDu2qOM7
	pg3njwDvFeCPAxOcWJ/2drEfFnXiVOg/Y9Om97xSAcc7FD4l0oiYe70x3SCls931
	p5FPNIjwl9C6PkJoMaH9jz6FMsrqMPXEwYBmhPIM8bFCJESwu5e0Ys2FOogubPTk
	xD9uQh0y3CZ41uwHVmixiZPHy8tv6tJaqPj14+EOFuxFC0bpy6LOzJzgGcQC4afE
	4p+Q8NLhDISXQEl6OIQa9GMqGS2ZqnVKVbZrgHFYpZk2s6BHn6G8o5JUN8KHwQHT
	v6fbbU1FKHiSnvZETzJUA==
X-ME-Sender: <xms:z7ziZh69WCuegdKiX_F4bVzFa4X0bji2MuLDrPckycXmt9aTKeHT6A>
    <xme:z7ziZu6VT9IqUhPFqCUwxwY-3WjK4tFtYLOP9IxpdX6fAjG4ZuelnSoAZgIK_PD4z
    gGxt7ThKQ9BcdIhgQ>
X-ME-Received: <xmr:z7ziZocCX58K5I1ClGdztA8RfygEyJN_Ibd1qbL_x__xyQ1c6G9jDs4oEIA2P4goJo7INOAYFuf9m95CbyUaixhPudb-7ruffrzqG17Okvk4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejfedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtg
    homhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhu
    khdprhgtphhtthhopehjhhgtrghrlhdtkedugeesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:z7ziZqLJEONXJI_sxSyM3W6Y26arSVK9ByyMuNUrvpdquhMx6XJhkQ>
    <xmx:z7ziZlIq6VwEnZgd6lp9JCibS6O2OuJaft88oL8wYf57z0lf2S8_RA>
    <xmx:z7ziZjxNy6uNRRLDk6rrLHvEfRaBSDUKW7SSsEWAqy9qzVPoFJ-ViQ>
    <xmx:z7ziZhJc4XoriHk6YM5CUxxBSjiyGBxmtaiuOafZkRToahCkYPkf1Q>
    <xmx:0LziZiGbx6CIcB3j6aOZqJ3n6ENHfUv26YHe_0NbdIUyxnhePy7PFhTv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Sep 2024 06:05:02 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5dd4d13b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Sep 2024 10:04:54 +0000 (UTC)
Date: Thu, 12 Sep 2024 12:05:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Han Jiang <jhcarl0814@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 3/4] remote add: use strvec to store tracking branches
Message-ID: <ZuK8zjWyvMc77eQH@pks.im>
References: <pull.1789.git.1726067917.gitgitgadget@gmail.com>
 <f30c77bc36072df57662cac0cb7bf1bbea378062.1726067917.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f30c77bc36072df57662cac0cb7bf1bbea378062.1726067917.git.gitgitgadget@gmail.com>

On Wed, Sep 11, 2024 at 03:18:36PM +0000, Phillip Wood via GitGitGadget wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> Store the list of branches to track in a ’struct strvec' instead of a
> 'struct string_list'. This in preparation for the next commit where it

s/in/is &/

> will be convenient to have them stored in a NULL terminated array. This
> means that we now duplicate the strings when storing them but the
> overhead is not significant.

Yup. Micro-optimizations like this typically don't really have any real
world effect anyway.

Patrick
