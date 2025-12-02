Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C5E2BDC13
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 17:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764695688; cv=none; b=TKrnTPtJ7Pcb+O64JQuaIf71ehn9YHoyJ9LrXwUM+7iFDZ7rBsD2w818X3sY/BApzyEKPrVR3/V60pyQr08ChWk1xAC1WzrqoJN7dE/qY+E376xVSwx2l14Asnk9ASp4DOxCUjK+nWwEgd5VR1JjLBxsQu+ckqYQSf+0ZxghrEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764695688; c=relaxed/simple;
	bh=GGtWkmFJUz1Z6bEgmC+BjEPNuI/3nfDBwmWyRVks2FA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kkyEEkBfOdB+s3nfTsqiDsKrrIRJiCG33kgBPyYhZF6I5finRA+JA7hlzsJ2MjtTLd3XWiiLwoUslOtBRrzm7RofXD3OQ0LDKe3c0C7mHspR6d0oi28hGEuk4nzAgsO0jQMW6cWZuyaMpUK1ybJ0+W1GKn+wehaGX6TTIHkpTc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gg1BcfA7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bnco5M0V; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gg1BcfA7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bnco5M0V"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 53C397A0097;
	Tue,  2 Dec 2025 12:14:44 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 02 Dec 2025 12:14:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1764695684; x=1764782084; bh=RxH7niWR5h
	qFZQfletAheQY8mwQXljkQyB1XchiK+Bo=; b=gg1BcfA7Vd5YbEP3kO0K4f6I7o
	7k9tkVOd7Lk8Z6CxcQPDBaWtQ7X6sdduNsOsJVyfCh2lM/6ARsByXgdOjgshDeFY
	fGF+APodqjCrt9t6T5aEul0BKhn1/LMpeVXSXNVANWy2aW1hQy3LtYaT40S1sCeU
	dOEFNIPMojOW2ugCValPOUl7TwdNWU8+5eGvarD49I/SwMt0QKkzBRR678lvwP6S
	vj2zUKSbCpOCNgaDeOVb68/ohdkeNuGYKfYZNCiAPEzOlG5dRPvTV815/tCr6Nt+
	ywY57PS2nbkkNaJV3sxNcg0sVCfZrInGV4oyPCMXzl71bZiMw9j/DANYN2Nw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764695684; x=1764782084; bh=RxH7niWR5hqFZQfletAheQY8mwQXljkQyB1
	XchiK+Bo=; b=Bnco5M0VxNrHB9+uMJPO6QY+o9RTsvZ5bW90CMfdWXKKY57J0Mh
	8gos38WUDKhBuPssuPrKWFhIHGO+4HfJlzsgQtFMQnf1F2Th/1zM6uEN/rt7aMOd
	bx7gF4wcgNpXkVm5aU9ykBOISf66o5ITrG+6Y5ms9zRdzhmJbF2Qrw/KFSc3WIyK
	AyXjujfr/s/RPUM3zttPka290ipEfVunbcX2OcVkLPzZSXFkFnPZmUqGI3aAytCY
	cyx7sT1Q8bK1FLgN69hbNpuBBTp8sIIhfNL1wOL9ko4Sk69G3uAifB6/hyv/Q8rF
	i8JT4i74c0iQX51H9RTlrbKZEWrzkbY29Nw==
X-ME-Sender: <xms:gx4vafBnaI8xmOEvStGUg5dQUf35P79NXXChCu5GKISplj3q4hXBWg>
    <xme:gx4vac_Y539c_SQhxir6ybCaOBBF0GxVInpG910Yu4xYFlcKwscg9Zl9y4G-4gdfy
    crU-1P4mfAGhcIhVTjqSN2RADBvvgq1X-LehBVJlLWgII7foG1ZKQ>
X-ME-Received: <xmr:gx4vaX9S01fGay_3rg1kOJl6Gw9eIaphX9iHlWjpv6aE-IVYBEoJENI46pGyrPj1dJsoLx_eWo8UmMCvZgHx5T5XBoKEqpFmrbW2OliG6xU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeilecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    ffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfu
    thgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevke
    ekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrih
    hmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeht
    ohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:gx4vabe99lj1iEOhZptry2v3TFE9QSJVt4IzpFtsnVdxGcQW6_YW7A>
    <xmx:gx4vaYGslpApVU2mUJwtCvP2XE-BNccUlMgd9hBFm7ohzX6ob674Cg>
    <xmx:gx4vaRfaoN7ts3u0jMiJt0DX5tKKpC0aoyYQXNPLbUhGc1V7o7Jp7g>
    <xmx:gx4vaaGPdLsTYepm0wTK4UEeJ1zafEog6rNI2cfSaoTn51u1eSDudQ>
    <xmx:hB4vaUpvntpQI_QqrIHVIafUHWMxzTz-Aq8KEiuH2ZYwW_Gz_MZEL1G_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Dec 2025 12:14:42 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 52719c0f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Dec 2025 17:14:41 +0000 (UTC)
Date: Tue, 2 Dec 2025 18:14:34 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] last-modified: better document how depth in handled
Message-ID: <aS8eesW53ks_4BSt@pks.im>
References: <20251126-toon-last-modified-zzzz-v1-0-608350df0caa@iotcl.com>
 <20251126-toon-last-modified-zzzz-v1-3-608350df0caa@iotcl.com>
 <aS1uz6mc0WW9kjzN@pks.im>
 <87tsy9w3k1.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tsy9w3k1.fsf@iotcl.com>

On Tue, Dec 02, 2025 at 12:01:18PM +0100, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Hm, that's confusing indeed. Is it possible for git-last-modified(1) to
> > do the "right thing" automatically? That is, given "sub/file", show when
> > that specific file has been last modified? Or is there a good
> > (non-technical) reason it behaves the way it does?
> 
> You bring up a good point. In the version of git-blame-tree(1) that
> GitHub did share, the `--recursive` flag is enabled by default. So if
> you pass a file path to the command, you'll get the "right thing". But
> as I am pointing out in this patch, if you pass a subtree, everything in
> that subtree is shown too. You could argue this is the "right thing".
> 
> Anyhow, in the version of git-last-modified(1) I submitted upstream,
> recursive is not enabled by default. My reason, at the time option
> --max-depth wasn't implemented yet. I submitted those changes in a
> separate series (these patches also originate from GitHub by the way).
> If those patches wouldn't land, I think always-on recursive behavior for
> git-last-modified(1) would be quite annoying.
> 
> So long story short, as git-last-modified(1) is still marked as
> "EXPERIMENTAL", shall we make recursive always-on?

I think that is a good idea, as it sounds like it would make common use
cases way more intuitive.

An alternative would be to default to a max-depth of 0 and stick to the
non-recursive default. In that case, the command would work intuitively
to the user, right? At least it would work intuitively if the user
doesn't want a recursive listing.

So maybe we should combine these two improvements. That is, we use:

  - An infinite max-depth by default with the recursive bahviour.

  - A max-depth of 0 in the non-recursive case.

In this case, we'd always recursively list all entries by default, but
in case the user explicitly doesn't want recursive behaviour we'd know
to show the last modification date of all provided files.

I was briefly thinking that a max-depth of 1 might be a more obvious
default for the non-recursive case. In that case, doing e.g. `git
last-modified --no-recursive t` would list the contents of "t/", but
nothing more. I'm a bit torn there though whether that really is a
sufficient improvement over a max-depth of 0.

Patrick
