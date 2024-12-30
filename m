Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BAC19EED7
	for <git@vger.kernel.org>; Mon, 30 Dec 2024 07:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735543527; cv=none; b=fj+s/GLZ5XaxLoAqxKqLKz5ZDP/eOpJFDW3Ce82FSzSgHxwJH8ZD4mQAI2Tf1V6RCvVs5iPs0V4Zv6HUFfWw0Eh1uiUBWUMcCyxQGGciWiBCwbEjQ72Xmpex2Kyr1TM4srdWRnjO3oMtvzhi+y64TmXdVTCZyP1FhoYe6YBo73g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735543527; c=relaxed/simple;
	bh=VVpxiumPvEXfuufcK0maEqnunatjJjQP5xeAtn1PrY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/K92TJ0V5TNLVnwxZ863kMMI6Oht0Vg/ABvz/I3DYN86q9D53Df3liA4Hkt1laEZYJnwlrAFFkrGpuEGEnqXDBocFaHyT9WaS2wVtwJZODTfyc3CWSLI6MvoBCudY2aJCk5Q0gkvKZvdlZ+CHuIFLfTgVGJbA95mgeJK/xQdxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GOA24DOn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r2cMn2S8; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GOA24DOn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r2cMn2S8"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id AFE3B13801DE;
	Mon, 30 Dec 2024 02:25:24 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 30 Dec 2024 02:25:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735543524;
	 x=1735629924; bh=KgmfOzU2wqWyacU8wuUfZoNTgXdoA2rzc5wJ0gfdxtA=; b=
	GOA24DOnfIhea9uk0TlL8OoYByvKOo6pNnq6GT9CXAtb0vbm+551iKWNuLtTddc2
	9HPi2C4AroORZZ8pW5vuMfaSp7+b4ZQPDp//S5LYA+3b8HcT2giUokKWbMAwigql
	MOv+wzxhLdq+8ieZNHizrX/Qhc3IzbBETKkdRf4v45QbD/JFJf0JxMVG6pH5u39b
	bhq5OTfNI0N6hXHYhdcXUXqHzixzoJcUMrRVGDs3vlxETVkd7cVCSwAMXj+zShAI
	oZY5Pc/040iFoVs6YwoQzWY7Q8S95BwLR1UYJm2Wbe1MMHSI8/sYPWCLvWuXWzPo
	v0wCcmc72uB9T06iFkl8dQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735543524; x=
	1735629924; bh=KgmfOzU2wqWyacU8wuUfZoNTgXdoA2rzc5wJ0gfdxtA=; b=r
	2cMn2S8i29vL7Ctk2OVMpuEZMumkdV6Ocz/TOLTzvKbzE4B+4DGl1uGlQzaxwNqt
	ejYXDSYSQtGIyx1B6znTUF5FKRhaeZjp6rvgXSaM+sfBwk8HV6Ggx3+bZQU7IEOa
	h79vHR3P4B89vKKucrsRW8d4f7zFDy51+6Pb1gknePIEErAYlsYAGS1RSC2xT2Xi
	XF+SZ4nYZ9HZmwsqlhXsMG/BNILClGSte1tuMHpqn0MZMKKnIJEv8cgnlcf1rVSN
	B8lprTo5QET7mItZT9gF6vD73abe4QoSrJiO46F/JQNSlxCeAEpLohhhzEgHIXj4
	NYwOw/PeFSVhTjz8MDSqA==
X-ME-Sender: <xms:5EpyZ7SrdxS4uhpQJRliy9EV5Zo5QenimqQZV8l1tVhRBVU0GK6wnw>
    <xme:5EpyZ8zvHeWksG7TF_3AKZtzG7ZBHGqBcxqN1LQqiKwXfstC4AkOGCY5huaWslq5U
    To9FEhfx-cBasCWXw>
X-ME-Received: <xmr:5EpyZw26oGJU5PfsrpfyKn22zThDlXmZz1WHFQLcg0CUtQDnbeEwJSpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvhedguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpedvfeejie
    dtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomhdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvg
X-ME-Proxy: <xmx:5EpyZ7BRdnTPo55R8piR3rIXFt80n8SXeak3OUTXAilM2TlSixtq_g>
    <xmx:5EpyZ0isSA5fwr_DiyrGKgo7Mm1UCfjZbAMdjFmOFnVCRoz8I9dAFw>
    <xmx:5EpyZ_qmACN4XNOSr2DXwEffS5fzd1fvPgU7eWtilgS9Cg8Flp2RcQ>
    <xmx:5EpyZ_hFYaoXh-0zjc-pz17thBY1Yw3cSH-fjPW1aEMjGRwRV41L9w>
    <xmx:5EpyZ9sxlThPjt3lZdt9PfEtSDcWQFPwluQo0VBzJKZ11xA30viFzoyW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Dec 2024 02:25:23 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 616e318d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Dec 2024 07:25:23 +0000 (UTC)
Date: Mon, 30 Dec 2024 08:25:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/4] reftable: fix realloc error handling
Message-ID: <Z3JK4lW4REYqBK9I@pks.im>
References: <2b9fba8d-be63-4145-9d25-a2151e422cfa@web.de>
 <f4677194-0a3a-4f07-b003-c0295b51c100@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f4677194-0a3a-4f07-b003-c0295b51c100@web.de>

On Sat, Dec 28, 2024 at 10:43:41AM +0100, René Scharfe wrote:
> Changes since v1:
> - added unit tests
> - explicitly set pointer to NULL on REFTABLE_ALLOC_GROW_OR_NULL failure
>   in patch 2; omission found by unit test
> 
>   reftable: avoid leaks on realloc error
>   reftable: fix allocation count on realloc error
>   reftable: handle realloc error in parse_names()
>   t-reftable-merged: handle realloc errors

I think this version is good enough for now. I'm not particularly happy
about the split we have with the reftable reallocators now, but don't
think that the series really is to blame for that as it simply fixes a
preexisting issue. We can iterate on this in the future.

Thanks!

Patrick
