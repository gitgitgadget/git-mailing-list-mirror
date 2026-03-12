Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769563242C8
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 06:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773298536; cv=none; b=Xe67QUu42XjBkbrT7ugsVbn4OIynL5B3pQfLQ1aLEKFCk6/UA65lj1+4t6/NN8jZTJi4eM3HYwNiRmOJBcEZId8v1HO3enRlPN31PfjWln7HnCQPq2NCE3631cjiUEcx0uGp3OtcYFGqsdzxEbUbCGcBBQXaSHmiIyE/EBUbq2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773298536; c=relaxed/simple;
	bh=gePsJ9X6BaJRSi/KIDZeoB/VCilW4RuXdQ2cGagUuLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sTAN0geXE3l4cqT7k37rDGGhaJYgBSHF0BJhhEYFtOQmzVAMd+y7Dm7TEyRAYgcqXfUBl35qIcJ88My4f0V23OP/MCtY/x8HFkZxKgFi0OdyUeFjXO/zYQ5tGRvQxjTMZMF/wGWpX2nd4o7LIW2BU5jHAQ5kCrtnYBSqqzFJMS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=W3ub+FiZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lHIfEW3c; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="W3ub+FiZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lHIfEW3c"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id BBD72EC0BAC;
	Thu, 12 Mar 2026 02:55:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 12 Mar 2026 02:55:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773298534; x=1773384934; bh=W3k36lxXQJ
	L9nXJ5b5uP176Uk18KeoujzgGDBy1Um7M=; b=W3ub+FiZYVsrJPzSsan8ShF50U
	ie1Cmvva370iGVY128BSCJxlLFHCGfTHCtluoQtWZTeh7YvG22DGVbuY/+q32i+M
	z/YXnIbR+/b82uEp41uI1fu88n0J0rxLIoC49h1zy72eWdYfa0rLjGncjPHaPaqm
	yv14Mtq/Y39Oc+opWmvwv7fdmXFePQ9n9y3uDsaaALTuNO3QaeA5cPJNLF8Hlckn
	9ZrAxjHY3tZy5nrUW2qkSAxxt6xW1X6yANWn1TMAYBnpfkv3uIL1XHltcuP37g+S
	nl77FVcCdCpdQrRSTaYETsnlKH3SdiKNLylsy1HD4lm9aOwaFnJNuYGSgkwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773298534; x=1773384934; bh=W3k36lxXQJL9nXJ5b5uP176Uk18KeoujzgG
	DBy1Um7M=; b=lHIfEW3cKbvSA1iYWbX49X6/r8EfVnt7cCxVkzuiX9WCcxcWw2d
	2cVpPEKGzn+bacl5pCEcFOgaXk3nwnhs4sgaoxyUkFl4zBOWjAUf20pp/CJf6UWM
	Weq2wnW6hK79pdUzTF+Y/DosKuyKpdvyKnm1QhfttZaBYmlHN8oT8b50JkxzEMdF
	vNU0MJBsRAgDnR8romUhwrri2skBQisBCz0vVIhkCuDkBuh06ktOqUoWmXnhQo3Y
	CNIE79a12O+DYMhQaXpUmiWBZ8+CpWqd/fgk2RfaTFXLOOFzjVzcog3Zp7lNFYFr
	6vqFm+l9atgkbh1B5wvwwCvDn30/W9TKaeA==
X-ME-Sender: <xms:ZmOyacX_qq2-BFMMItUC9HPrHpxmUGPqFM_90aIenQumi0dHOHGrHw>
    <xme:ZmOyaZ5UIxc82g7Tmp-dXMUGnXFV0e4BzHocn-mnu09yCrv3shF5TFAD6vyuTLAZY
    -9GvEb76812gt3lbMa1rarIGxKAFTmgdSzASax0DKrIIs9Uzqyjgw>
X-ME-Received: <xmr:ZmOyaXrKLgTH6AfYYLasYEZOXgxTLxJdjD6xxVnSpxIybNDL1T0wXbKkGkP423jj8o1JEiuiujz_pMDBvI42haWvuY__LizPrE1p58uFy-hqjg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeeiudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegtrghtsehmrghlohhnrdguvghvpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprh
    gtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukh
X-ME-Proxy: <xmx:ZmOyacnwfdV-V90L7a6o3ddb1yIiANX47yOnrbbjTkY-eDsU112R3A>
    <xmx:ZmOyaTOSSGKvaGIxgRBsywh3E4Hz1srtSvUnq93sk1Sm9Qo2xAzyLA>
    <xmx:ZmOyaQMWEgyFypLTcJtgh9GGhGiR3m7ASZNS-iJEZ-fAgSctr14ndA>
    <xmx:ZmOyaUjtgTNHxDPWv59DkERDO8BJpfI9ZMIvPcqh1E64SWS0dKb8CQ>
    <xmx:ZmOyaewh3wIZr0ZlPxXiP15Ql9QFSW8jImprMab2U5DDp-QoR85YTljy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 02:55:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cea5d081 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Mar 2026 06:55:31 +0000 (UTC)
Date: Thu, 12 Mar 2026 07:55:28 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org, gitster@pobox.com, karthik.188@gmail.com,
	phillip.wood@dunelm.org.uk, jltobler@gmail.com
Subject: Re: [PATCH v1] builtin/mktree: remove USE_THE_REPOSITORY_VARIABLE
Message-ID: <abJjYNq_sxeH8yLQ@pks.im>
References: <20260311181704.958509-1-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311181704.958509-1-cat@malon.dev>

On Thu, Mar 12, 2026 at 02:17:03AM +0800, Tian Yuchen wrote:
> The 'cmd_mktree' already receives a 'struct repository *repo' but was
> previously marked as UNUSED.
> 
> Pass the 'repo' down the 'mktree-line()' and 'write_tree()'.

I guess s/the/to/? Also, it's `mktree_line()`, not `mktree-line()`.

One thing that commit messages should also explain is why a certain
refactoring is safe to do. That is, can `repo` ever be `NULL`? For that
you have to look at "git.c" and figure out whether or not the command
requires a repository to exist.

> The 'oid_to_hex' function appears to use 'the_hash_algo' internally.
> Seems that it also implicitly relying on global state. Is there
> anything we should be aware of?

`oid_to_hex()` falls back to using `the_hash_algo` in case the object ID
you have doesn't have a proper hash specified. So this depends on how
exactly you construct the object IDs: if you parse them with a proper
hash algorithm, then you're fine.

> I've always been unsure about who to CC on domain-specific patches,
> so I've only been sending them to Junio and the mailing list. Could
> this be why my previous patch for a global variable refactor didn't
> receive any review feedback? Here is the link:

It's typically fine to just send to the mailing list, so you wouldn't
even Cc Junio. Sometimes it's just a matter of capacity, and it's fine
to eventually send a ping after a week or two have passed without any
feedback.

The patch itself looks good to me, thanks!

Patrick
