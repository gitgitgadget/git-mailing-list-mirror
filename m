Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F33D192598
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 12:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728476394; cv=none; b=Uovz9/fc6lwElg+lLFL2QEOyzenCahZnC6m5CBt05HK0jvjaDPDwkyJfisWTOgQmzr655fbnChW2FzO1wbll0mpVaQ5+oKjCilNVCxQK0j34bodGuImr+VYuR0u/J6NUU48R7j+ciYHQMeeJH5Iib7a2ru88TwDnVYkGEN6aEyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728476394; c=relaxed/simple;
	bh=hiTugkvS1hu809Jtrsj26jq9bpF4+ePe9ulQ4Yw/sI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fY5m5RTEOBFf3OgyBsBCnOeerUf/kyBXnAXRUh0KxRhmoVUdoLYkxP7nhgWOBP14KFMwzy3gB93E8OuUaiS3xV1vKxSutWN2H2IfOcUlqR/bGU/cgEk+z/17u0p+ZnXUbajS0St1PTMwn6RVYDxSaOPkZnoe1yy3f39m722qSDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=c9QX8AYL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I/DpPdwR; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="c9QX8AYL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I/DpPdwR"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 6C55413802A6;
	Wed,  9 Oct 2024 08:19:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 09 Oct 2024 08:19:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728476390;
	 x=1728562790; bh=/1W1LW/kBNh4YKQWyR+v8wq/iec0Dn1+9+pkC+X+lzA=; b=
	c9QX8AYLQVcDcUXxwKReTpsjX1sxzMewXzLZimVxMhtngrjkaL6KPMUX7S+71ytL
	2PFMjfrFMOC/KDLKZ5qeQbXjd+AVfgIcRfiFRUuW/16PNB4wHb1xSk3f4pQDua5c
	Cto82akJNawkgq7L0dRnqMKmfCIq/0A7rM2SLNHWBVj3HlO7P3R4SFLCCk3KInGY
	ub5aRMLzKyYJdMPcWaKyuvQbyWSDitxn5EHtGySpXw9KGommK+b9KY78eaMLdB9y
	a8yXHim237o67hhFpc481g13v+3xjBy1Q6td4xMpELfRx1cAv7wa00qE9r0iTIBG
	+tl1TAJTREqAJxkWO29OIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728476390; x=
	1728562790; bh=/1W1LW/kBNh4YKQWyR+v8wq/iec0Dn1+9+pkC+X+lzA=; b=I
	/DpPdwRrFZNUSOef4SSc/E3tbJk794IiVf4x+G7vqHdwi0t5+6AY4GytM7nXcqay
	GeCJD7wqSZJMr6BPK/83yc24zUdegPaSt/7kI/5Bj3IoyjfwsNhbbAMwd/eFyhcD
	GaOgpWKXTxlJ9m6ocdAI48GTK9Zfgjct/qtekv8JhtqAp5AcRaboWqKZ3qMOLzI1
	q/YTzUKuPBb6W/ZnMQM6+MAEH+l7/+pw74225o+U2X5TgOczvMJS/BP9d6ohkh+z
	dwcHCEQ2tHB5KhliAZmA6G97YRHj3Ld7XVwrsGUIVKQ759UQjprL8Im0fFYLB2fP
	0tsch18SwnLpqXyfI7vjA==
X-ME-Sender: <xms:5nQGZ6U0pDSp-BYtUa_h0Kas2MuxODka3jisBmkBri3VD3DI5Eq2dg>
    <xme:5nQGZ2nESNfNNbfmaPYf8p2uF6QFdJm6s5xb31gT3W_ZQmjZdHvM5DohQHTHodxF9
    n8rTD1qDfLXu5TbqQ>
X-ME-Received: <xmr:5nQGZ-ZOniCurF-zZNUAlBHwzkvrOOtJhdaZPlxziY4-R5xeJSBpKYsR9nvvul2T_IcyOdxI3tF6ATeNa7uMXR4vO82f8vhugCaap8psys7TbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepghhnuhgvthiiihesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhh
    ihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:5nQGZxWoNZPMVal7DiFJunqAeqKrW3MYPRYH9dXebE9KGZXnyEnAig>
    <xmx:5nQGZ0kze0gEyDIlWgDzXj1drQ23RMVKqorzVAMaR32i68R_ATEkfQ>
    <xmx:5nQGZ2cIu6K2sJtI1eEKoqOOfZqqzwHwxPutZFmE_gh2bNVLqI4EEQ>
    <xmx:5nQGZ2GvwNbV1XMwffoILTXflMtcRw8L8r8nub_WK-6h95tfXz-erA>
    <xmx:5nQGZ1Bpukg46TT-jwnge7f191YQ2Ewwfl508tmAowDMtvJeqJDaQO5M>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 08:19:49 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 289554c6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Oct 2024 12:18:43 +0000 (UTC)
Date: Wed, 9 Oct 2024 14:19:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Gabriel =?utf-8?B?TsO8dHpp?= <gnuetzi@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: Bug: `git init` with hook `reference-transaction` running `git
 rev-parse --git-dir` fails
Message-ID: <ZwZ01-mtwm9Gcjub@pks.im>
References: <0084cc18b6d90ba14849a7f788939f4a1d0d61c9.camel@gmail.com>
 <ZwOVy4FltrEjxHn_@pks.im>
 <867f42bea10de470532d2f30eacceafa2b03d8de.camel@gmail.com>
 <ZwO-j0C59vuYsEnt@pks.im>
 <a8807b44026458097267932f429ef61d5b77aa4c.camel@gmail.com>
 <ZwPEwL-fKHBkUOcm@pks.im>
 <xmqqiku38w51.fsf@gitster.g>
 <ZwZPSA-J1RFQKYrw@pks.im>
 <5cd07a8d3c554815d4fce20996c018c6294c63e6.camel@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5cd07a8d3c554815d4fce20996c018c6294c63e6.camel@gmail.com>

On Wed, Oct 09, 2024 at 01:53:17PM +0200, Gabriel Nützi wrote:
> 
> > We have another solution that is even simpler: just do nothing. I do not  
> > think that the behaviour we exhibit is wrong. Unwieldy? Maybe. But it is  
> > merely stating facts: we are executing a transaction in a repository  
> > that is not yet fully set up. If you don't want that, either don't set  
> > up a global reference-transaction hook, or alternatively handle that  
> > edge case in your script.
> 
> But then Git should at least give the hooks maintainers a chance to know what it is doing.
> Could we have a new env. variable or mechanism stating that the repository is not yet setup or so?
> The issue here comes from the fact that Githooks is a hooks manager which basically calls `reference-transaction` for you, but before
> it does it calls `git rev-parse --git-dir` to get the correct Git directory, basically not doing env. lookup on GIT_DIR which this command actually does, but that apparently only works on a "initialized" repo, so currently I do a workaround and looking directly at GIT_DIR.
> I would be really happy also if I could somehow know when Git is creating a new repository (clone, or init), that would also improve other scenarios I came across. Basically you cannot react on hook `post-checkout` only when a new repo is created...

Yeah, that's fair indeed, thanks for the background.

In practice you already have a unique way to identify whether the repo
is about to be created or whether you're using "normal" operations,
namely by checking whether the HEAD file exists in the Git directory. Is
that an acceptable workaround for you?

As said, we're currently just exploring options. I'm not yet saying that
this is the way we'll go, even though it seems like the most sensible
solution to me right now. That picture of course changes when there are
valid usecases like what you present here.

Patrick
