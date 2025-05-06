Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA4A280324
	for <git@vger.kernel.org>; Tue,  6 May 2025 12:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746534585; cv=none; b=UqBubXY/kJ77/WZ71raVEzljowbEp60JnaAEFmq22wSOTnKSVr19QbX9eL9rJfQuuABuXTUD1+Jygk7eC9KhxSEhTL0dOl0LcOB1oTtPfMSsjK9aJxEDB4R6GgOTj4NkmfYI6gD1Ma1W7YPCK1sDdBZ9gHbJnrnB97IEYlO7xqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746534585; c=relaxed/simple;
	bh=Vs0zKwdTN9sN/hJrbrHLu9nSIo5vgmtzfx00hSnpdhc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dtQ64dClPcARB78tWFZLRM9MGy4mf7gM/QfUrC3M0d18tUK6XoWc6y57KLkxZo3Xq/MOshVPNG5Uz0lsUoFU5zWWfbkoeVzBHMo/UJ52j7O16vOi9Bw00P72BmnsuAsBsdjp6nh9ataVWK7/2htRalm1Y90Gxxc3uJ+xsxuCvrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=syfDuvf4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WQHGfOc9; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="syfDuvf4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WQHGfOc9"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 8D0BA1380516
	for <git@vger.kernel.org>; Tue,  6 May 2025 08:29:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 06 May 2025 08:29:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746534582; x=1746620982; bh=CtlIewhA8m
	jats9fn3SPKz0UwCLpaXaWLFERdIXhTqs=; b=syfDuvf4wRPoPXmE5Cv3IWnu9R
	iCS0Epdu/R7E6sNUL4gCeg05Qng+++FzKh6zQizPvagHvvuHRIiipM9YltU4kbOW
	XfsDT0csLH8ClK4tIf0bYIsFeXvNs1XA8nODaeucuHAXgxhozwHpsT/XVUNCeGe/
	Pj/kQEPh2GfRVI4VYCp7AJbiyJWMvKvG34MIZh+Mcze7NgZu9pB/BfoHxNqrI+UM
	8bzU1cZQmVhJ+LKdICpP1YWjMjWT8tcf//bzwbZbAwm+JO9ulSZkOy7C8MhqMHkN
	/2kPR5cpaT6xGWRjkYnDUY6BiE0h8qx9afsU9R9C+AsfRZdWk9Vd7abblEgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746534582; x=1746620982; bh=CtlIewhA8mjats9fn3SPKz0UwCLpaXaWLFE
	RdIXhTqs=; b=WQHGfOc9b9aYtfYNP3HPVLsPfjSor7MwTjxOp9c1Waw+69tlH5y
	bZn8WiR2dAe2eqeKGBegPzQqqW7+dDLsX+27oK0bdbM8Byt4AybJZ+6V/U3jq8g6
	B3AQQb06YN9JTnFWDEQ1GbfkHY7w7+ryJDhsFssdWAZr83RgqJKjNRNjgT6GZh4k
	Vxo9McdPrkJHKZtLCmGuS/nwEQ3M5jMiCb5rV7s+8O9uYSXUgG1JS/qBM0y0svYF
	mcg8d7ATH+C26p8LrQbidVzBs2Vqo0+P6AEXJCdomqv9ZrnXuc9vAsp5ZSsh7oOi
	Oo/IVvyUfasK4TuJ7U0WEdG004QnyGoMg+A==
X-ME-Sender: <xms:tgAaaEAWGRZ6i9L9chOqMLVrLnunJJKoqr9F9s4pOgidThIpVnzLdA>
    <xme:tgAaaGgVoj2NF2GPYQC7fb9PmwZo6K68wF0CfaLvkfKKEyUKEYs9bulXOftMHjXS1
    TE6beXj1cD7r4NJCg>
X-ME-Received: <xmr:tgAaaHnlfsD98bBPkQyyFuXGry1j91yeS-2qxKAg4gDaIj8ki8cmfTA-XefqTrMwJaIGc_I-A8-6qYOihFTcxd6t6UdHTG2LK4yyH99n>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeefleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefge
    egvdegvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:tgAaaKzWobYBstJ7c9FKdqV4UqtC8CZ_J1CGvg-kT3K8aO92QHRUUw>
    <xmx:tgAaaJSzmnTZOImNXBSOstordacnQ5Ce06NbxLcWxS12WmsVGVxHCg>
    <xmx:tgAaaFYKjAjND93xwuHEylyiHjwczM0xLjT6HTEPHFWqVUfk6b4J0A>
    <xmx:tgAaaCQ8zwJ719sI-kHuR7Hd9vWdRIBdYP2VZULK6XvkiB2BdOHo7A>
    <xmx:tgAaaG_6yYXFYh5J1qoVMQSYs2JQQ9Qyzh2XnNldO1ueP9I5GsHzv5Ac>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 6 May 2025 08:29:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d6e85e29 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 6 May 2025 12:29:40 +0000 (UTC)
Date: Tue, 6 May 2025 14:29:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: Re: [PATCH 0/4] meson: parse TAP output generated by our tests
Message-ID: <aBoAr6ABSFiJPGgu@pks.im>
References: <20250506-pks-meson-tap-v1-0-5aaab2942a4c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506-pks-meson-tap-v1-0-5aaab2942a4c@pks.im>

On Tue, May 06, 2025 at 12:59:49PM +0200, Patrick Steinhardt wrote:
> Hi,
> 
> this patch series starts to parse TAP output generated by our tests when
> executing them via Meson. This has the benefit that Meson starts to
> understand skipped tests and reports how many subtests have been
> executed:
> 
>     ```
>     $ meson test t002*
>     ninja: Entering directory `/home/pks/Development/git/build'
>      1/10 t0024-crlf-archive                  OK              0.17s   2 subtests passed
>      2/10 t0022-crlf-rename                   OK              0.18s   2 subtests passed
>      3/10 t0029-core-unsetenvvars             SKIP            0.15s
>      4/10 t0023-crlf-am                       OK              0.18s   2 subtests passed
>      5/10 t0025-crlf-renormalize              OK              0.21s   3 subtests passed
>      6/10 t0026-eol-config                    OK              0.25s   5 subtests passed
>      7/10 t0020-crlf                          OK              0.81s   36 subtests passed
>      8/10 t0028-working-tree-encoding         OK              0.85s   22 subtests passed
>      9/10 t0021-conversion                    OK              3.45s   38 subtests passed
>     10/10 t0027-auto-crlf                     OK             26.35s   2600 subtests passed
>     
>     Ok:                9
>     Fail:              0
>     Skipped:           1
>     ```
> 
> This new feature is only enabled with Meson 1.8 and newer, which
> contains a bugfix that we have upstreamed [1] to make the TAP parser
> work in `meson test --interactive` mode.
> 
> Despite the changes to Meson itself, this patch series also contains a
> couple of fixes for our test suite that caused us to not generate proper
> TAP output.

Please hold off with merging this to "seen" just yet. I have missed that
this introduces issues with MinGW, which I want to have a look at first
before resubmitting. I didn't see those issues in a previous iteration,
so I'm not sure whether it was introduced by this series or not.

Patrick
