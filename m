Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5324E1D2B34
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 09:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733391913; cv=none; b=K5aNqEgryGOfMnn3tbafpHjITpeHNgYFzYhbDwMtgs3jU1pi54ds4cEM/c7qQ0t44vbCxy3N9Dk9Nne+iCjJlfw90ufi4H5WIOHbvmupFEry8bhVYZWPSxZI4Yk1F+ZZsUCzmKcxa/tEKuGvzExYJ6dIa9JqCDCr9CFsH0GbTV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733391913; c=relaxed/simple;
	bh=jgEliDqxnaKdCSaafoObPdsRTaYjU7VgBPYkuncdVQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LiCmVsc5iMveqwj9Z0FIy0O4pqARdeO+MkDH3eprvrWnGKWw0S2F9a1AFtSZt3eBSc8HydH5rrjumM2iKZCN2seTQQUvC3JNMwYswO8n5N1JQ/SWqlEPJvHf8wD+30rexbwQGBFVUikXoNqVbNBXRbaWe4s7yOBI5W9HvEynPMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eic5SzyD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LsPN2Wog; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eic5SzyD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LsPN2Wog"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 646411140196;
	Thu,  5 Dec 2024 04:45:11 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 05 Dec 2024 04:45:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1733391911; x=1733478311; bh=bZXj/kMfj3
	UIczDdsDfrtQvmJo6exXk4Zd7yEid48Lw=; b=eic5SzyDV8XlFoJY/4UvFrj6cI
	W+TKp9J7WRZs+j8/LCZsmR5mytT+Drn1P9BoMbWkz9jey8N0G8ef4JM4GKpfgRTe
	tx66Dh+LRe7CyKobjVQn/pu9qJD6BU4NMXuEH68YQmOL6ziqkZ/d4zvhCwTpRoQH
	riqvhhOwTL97gkVb324xOK02knrYt12bPv2tfXQ0lnTu69sM3sFQqrHehM391gtB
	K99zKrM5IuVQSFNtyQ5BFgfjm1bGpXEfVg5GuVxOmaNEXFi5WvjmagC1qt6EFsE3
	0iPKFs1vG6aHsPcFfCx90+iVzrqkxilO72yWBZuhbww3s2XiY1zGnrUugGJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733391911; x=1733478311; bh=bZXj/kMfj3UIczDdsDfrtQvmJo6exXk4Zd7
	yEid48Lw=; b=LsPN2WogV45rJVCBXYaKdObpkhpNS21wMPOsvjK63UYgneR9mZI
	SvXkgo6xzujeakBZox4RYcbf/htBmPerrDrV2foMGP4AjXfR8FVa9UGcf4bWtip8
	eyUwD77BHdq+4NeJZEQtbbQpS0PL+ikt86CEk/sC+qAznyRpv+5BS5gkhqpw4m/0
	mbUYJUPX8Vb2pC6NlUDbhfXcc9lt4Z7o8M5xdwU33tQ0+FSazeqH1jk0NbjB0cX2
	RtyYDPVIUp1DrWgYrs+xOEFAqUWPcgmIpVGd75HKtz5KfWgKPf20Xn6+JFwSWwUP
	qsicIgcSj+cWRjfLN+5hFdYbXWCfSKlatUw==
X-ME-Sender: <xms:J3ZRZ_TIl4rMqZmnDQorfyi2FsTudQpcF7N0CDPPHc5Lnq9QQvbakQ>
    <xme:J3ZRZwzkEYLw2rXfdBBqI_ry3IfsmK8vF4RPbWCGfJsnErLjZOeU_Yg3-5ZfaKKku
    dzU22cAn1YsBl2e1Q>
X-ME-Received: <xmr:J3ZRZ0058Q5tJjM1HK9Vge827sS-B11evy1CXIoRLmwp3F-rF8YWl9FfwLF71rR5d5sbI6a74OMFJ1czqi5WWyaSwivS-6tsqwa9YR9BLhKHyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieejgddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitd
    eludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehiugesjhhovgihhhdrnhgrmhgv
X-ME-Proxy: <xmx:J3ZRZ_D_D_Sf8HNhkyWrdcdRl88nmGOyyULT3Cuv_soEl7dq5hPbmA>
    <xmx:J3ZRZ4hdRZgclYTYX5206iPPZCDdf_pZYnTUVaBpIRapzTWiqJoK3g>
    <xmx:J3ZRZzqf19HwkjUTGh0Uwgw6mOI5d3hh-O6w893L9W0id8C3uWRjYw>
    <xmx:J3ZRZzh58plpT3pmZCu3kUa3dhTzcEtao_Ve_ZkUmj2K9Q-LTtfs7g>
    <xmx:J3ZRZ7uTe28iQJJFT0ynz3zYcC-ZhDOtYDcwSi72N-wv1h-eiuxJOFSF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Dec 2024 04:45:10 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6732897c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Dec 2024 09:43:47 +0000 (UTC)
Date: Thu, 5 Dec 2024 10:44:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Joey Hess <id@joeyh.name>
Cc: git@vger.kernel.org
Subject: Re: infelicities in git hash-object --stdin-paths with special
 characters
Message-ID: <Z1F2F58coUV7hpak@pks.im>
References: <Z03xM9AvbUpqXpkI@kitenet.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z03xM9AvbUpqXpkI@kitenet.net>

On Mon, Dec 02, 2024 at 01:41:07PM -0400, Joey Hess wrote:
> Apparently "Icon\r" is a common filename on OSX, anyway it's a legal
> unix filename. It seems that sending a line containing that filename to
> git hash-object --stdin-paths triggers some DOS-style CRLF handling.
> Here I am running git version 2.45.2 on Linux.
> 
> $ touch Icon^M
> $ printf 'Icon\r\n' | git hash-object --stdin-paths
> fatal: could not open 'Icon' for reading: No such file or directory
> 
> $ echo 'wrong file!' > Icon
> $ printf 'Icon\r\n' | git hash-object --stdin-paths
> 1c43b74a7787621318ee7442eb5a36e32476f326
> 
> While looking at builtin/hash-object.c to see why it might do this, I quickly
> noticed another odd behavior:
> 
> $ touch '"foo"'
> $ printf '"foo"\n' | git hash-object --stdin-paths
> fatal: could not open 'foo' for reading: No such file or directory
> 
> $ touch '"foo'
> $ printf '"foo\n' | git hash-object --stdin-paths
> fatal: line is badly quoted
> 
> The documentation does not seem to mention that quoted lines in
> --stdin-paths are at all special. Of course, quoting would be one way to
> work around the CRLF problem, if it were documented.

Indeed -- the documentation does not meniton quoting at all, but we do
use `unquote_c_style()` to parse paths. So the following works:

    $ echo foobar >"$(printf 'something\n\rsomething')"
    $ printf 'something\n\rsomething' | git hash-object --stdin-paths
    fatal: could not open 'something' for reading: No such file or directory
    $ printf '"something\\n\\rsomething"' | git hash-object --stdin-paths
    323fae03f4606ea9991df8befbb2fca795e648fa

Note that you have to escape both "\n" and "\r", and then Git handles
unquoting for you. This really needs documentation though.

> It seems that some parts of git that read filenames from stdin use
> strbuf_getline_lf and others use strbuf_getdelim_strip_crlf. There does
> not seem to be any consistency, and my impression is any user is best
> off using -z, when the command supports it, to avoid the mess.
> 
> Given all that, maybe adding -z to hash-object would be a good "fix".

I think this is a good idea regardless of whether we document the
quoting behaviour or not. It is way easier for programs to embed NUL
characters than having to handle the quoting rules implemented by Git.

Patrick
