Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBD22AD05
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 11:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728300249; cv=none; b=qS1clmJ/vzEL+tcTMKhR92XDHMFzifDyedOp3E8bueSqubfhRSelQRFQnOL23m6NHIGunWrwMEa5LsjZGLi00P71UtveCCVrd+BVr5AbOZ+TRZJBYybwsNza2oXZDbUA2ROfWHeliByv3XyNXqzGAPQW0gJQlJnCYtjgqRiJQlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728300249; c=relaxed/simple;
	bh=+6cM7cWYYWvcEg7/di2LkHLHMOD603ur0ftyt9H0hJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULz9VrsfEtfVD8kWtrd97OpGGOMZhNWoNgKzntryDzhsdBiZl2qM7SyObZZVN6ktI4vvSC5gapJx1cmGkR9eYUFhgtssQSWynB3c7nolscHf/vgrhOLs6oabNDV1MJkglUxV8gqp44W7+cG+Yqf1bgy7N7yy+re5xldorL53yeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lmw6PLd5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e6HtMtJp; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lmw6PLd5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e6HtMtJp"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 96AA311400CE;
	Mon,  7 Oct 2024 07:24:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 07 Oct 2024 07:24:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728300246;
	 x=1728386646; bh=DyyVoyw9RRqvh8wfqBNgw5zepv9vm5ixSlxtlE0yUVA=; b=
	lmw6PLd5EsINwTz4nWpavnfiiPkOuLwEKpCc2ec701let+/RRhCvLyeZQtRoH++o
	xM4nHuP5UVOBLIfb0Cn7hC49gtznj5Bs5P5mINxri07IK2w5M4FETuOsSsTo0LPS
	xakZUOt8mr5ZhSLt4Uxgc8d2oJqMIt+uAUwWaLGk1b7jrt303lHA+xzwGsn7mCui
	oiGGpqeBvd5/o6WZ+ngpBth+k9NCT4/ojUi5Vf+gupF3J5D2mB1fC+V10QpeiY0W
	5eKvtcoTm8t5UYzGu5UYtLQDAM07xz117xjuBujEwcz9x1kAAfB/hXRDKQ7Pu+7y
	XthDR8YUP914OUflBSo6uQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728300246; x=
	1728386646; bh=DyyVoyw9RRqvh8wfqBNgw5zepv9vm5ixSlxtlE0yUVA=; b=e
	6HtMtJphSrrHlkEH2kvMEYYPKZ5sC+YIA7lHGfqziphvwrEy6IpGnFJ2dVj13MHi
	Fsni1kolccOTpIU98NNroeTKcrdEMdG4MlNuqu+MckP1WtAQ0arTCGqyq/6Gr+EE
	xiN1zf7ozRt1Cs60naXj7lYrgxxhEDGhKdtQaIE0P/LBXTSXqmR6+8Mjr9jbBLLw
	N3TaQ6DWu0IBEwhlLf2pw2tPorpiKvI21mu2XHaRD61u8gogJwXKlLN8ioeGydL2
	bQC3uP1YNkEmsY0WWIX/68oLPcbLDxWxfiAGCdxa1URxaTKo3oghGUpvf81RABIF
	wv4Um7RxGXHNNspzd/AgA==
X-ME-Sender: <xms:1sQDZyuaxUXo3ZfunYEQtVEDElrEs8iOwWH8qq9KO_wiyzkKfQg_4A>
    <xme:1sQDZ3diP-8sHTGoP2KCHxZV_-EvpraUxWcIsadBf3hb428R300IZRzRQqNcuxXpT
    ff-lrK8XCRQWXcWMw>
X-ME-Received: <xmr:1sQDZ9wuiL-Dho9OL34fJWMYTjVSZsqNkZZBRpXxrqoT7yuiTqCkDaaNbjlSK8SnzhdQTPmlyiTkPyU62gFV5SV-ITEfvhyCNqU1Fybe4fjDgSK3vw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgnhhuvghtiihisehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:1sQDZ9MHySZIOCh9OjIxeKiEqvAhPkw2Kth_4wpkjKyTPrZn_VQETw>
    <xmx:1sQDZy-rZ41WhnjFMiMebFdo8vhl2jahGltA5M2KkMMe445MqMvoiw>
    <xmx:1sQDZ1W5Kmui4vuWIBEv0tr7aUjpD4_WVbRC6NUkRX5311DL77B7wA>
    <xmx:1sQDZ7fYrAaA5qpwNvoKL3HpufieOGybAHos2ribQGwy7Qt4NcTsxQ>
    <xmx:1sQDZ5YUj9N_qHL56DGcQGh0cA8UfEwH8l-WP5tbLcNIDdE63aFXk0Bl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 07:24:05 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 504461f2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Oct 2024 11:23:04 +0000 (UTC)
Date: Mon, 7 Oct 2024 13:24:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Gabriel =?utf-8?B?TsO8dHpp?= <gnuetzi@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: Bug: `git init` with hook `reference-transaction` running `git
 rev-parse --git-dir` fails
Message-ID: <ZwPEwL-fKHBkUOcm@pks.im>
References: <0084cc18b6d90ba14849a7f788939f4a1d0d61c9.camel@gmail.com>
 <ZwOVy4FltrEjxHn_@pks.im>
 <867f42bea10de470532d2f30eacceafa2b03d8de.camel@gmail.com>
 <ZwO-j0C59vuYsEnt@pks.im>
 <a8807b44026458097267932f429ef61d5b77aa4c.camel@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a8807b44026458097267932f429ef61d5b77aa4c.camel@gmail.com>

On Mon, Oct 07, 2024 at 01:02:56PM +0200, Gabriel Nützi wrote:
> Ah, jeah thats true:
> 
> The command in question which is `git rev-parse --git-dir` to find the actual GIT_DIR is actually the issue here:
> It relies on having a proper HEAD despite the docs saying it only reports GIT_DIR if set etc...

That's not quite true. The second paragraph for the `--git-dir` option
in git-rev-parse(1) has this to say:

    If $GIT_DIR is not defined and the current directory is not detected to lie in a Git
    repository or work tree print a message to stderr and exit with nonzero status.

But in our case you're correct: `$GIT_DIR` _is_ defined during hook
execution. So in theory, if git-rev-parse(1) behaved exactly as
documented, it shouldn't even care whether or not it is executing in a
repository.

> Could we maybe make these commands more agnostic? 

So this could indeed be a viable fix, but I guess we'd rather play
whack-a-mole because other Git commands that one may want to execute in
this repository would also be broken.

> Making an empty HEAD probably directly also resolves these commands to work correctly.

So agreed, creating a stub HEAD is the most sensible option we have. I'd
like to wait a bit for more feedback from other contributors before we
do so though.

Patrick
