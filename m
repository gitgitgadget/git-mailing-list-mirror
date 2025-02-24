Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2592571B6
	for <git@vger.kernel.org>; Mon, 24 Feb 2025 12:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740401596; cv=none; b=DSBzpvU/4hXauyYe68iNqPh5ntyXllJ5MCjIO+han8e6BFbDw2Up+1g9NzxdZaT95x10TXRJb7K2EI5gPLpo1P9aKerFmZYPSI3VB+kF2v/jWlsMcTGDU+kYqGbjoL6ORYRYYsDvhLZsXWQSPNXbe5GB5B0Lrx9ngC9UlO+5Qss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740401596; c=relaxed/simple;
	bh=YJN4KtY5bfhJFpLojiESTemsU7r4PgkTTHSU3YG0UwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBMSIM1NUSJkEyV2K2YQ085Qt3ne+iGbFkJj5gXi/0L5XAaA55VwXHvasZzMaOmo0LrFo5PMdamS+xMyAst3cfVyF3P8xJJmJymcdfgUX3g0KzFAocMXcW75zDCSOYbFcruFOQIdNQXc8RXqfbCF+VnKwt2MXDsPseXb//gBx/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=X5JhYSM9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2a+ygGRD; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="X5JhYSM9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2a+ygGRD"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 3920411400F0;
	Mon, 24 Feb 2025 07:53:13 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 24 Feb 2025 07:53:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740401593; x=1740487993; bh=ucPqDtHUdI
	OQ+mavINULsmoeKf296EcH1sdXnYysfww=; b=X5JhYSM9iJuts8wFLDD9U7sttX
	FbvOMAu8VmeztLdDAWl217CX29vULBl9rj8R1FG+OqisIx2RVBP8M8cFfRkmdHUg
	zaKbgoNAHyOo3DhFbqkZGsCT2Z8YZQduGwgMSuv9W++UTEi3lUw9kSlh/vnOTzv3
	jY+NvfvnY5aNDmVZ/kYq2DvJV0WL/0/kWn4lRcz5TMQ2ARU1nSSPd+Zsck/dP62m
	CozC1LMae23iXY7kBY/rJVRIvoML+qcYmY5eVhfI+ijxX5IrauJJWC+j0aPe2g7m
	KwJQM1r1aYYB0LVbNExSJ845UIP3mfWHXXS7l/Ppa4gaFFHtPEOvLZG+B9hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740401593; x=1740487993; bh=ucPqDtHUdIOQ+mavINULsmoeKf296EcH1sd
	XnYysfww=; b=2a+ygGRDmeprO++hEAgNuHzPWWAqBKmSXw9Vf/p1BwQMQFj47UD
	tnyiaVU8y/WKw41MfM05xS4w9G6KWMkrD4JxAsnpmswCL5EcpJ6OxzhPaV/R7GiB
	BFQUYyaCQCD6AeDxwsRL9hI+dC51U9EAF8e2T3cp7IhYv27266qtiNDqHKt3unHg
	8CsjAUPfR5SuAqKqSVgX+RTjsGGnifxnDgmLeBITphjYv6McFsaeWXjWsr1oRhWg
	Cl0f+Dc/dNXyoGAO9F0vbcrezXXrJl6GG1fvvlo5F2jF8Y61NTY2RkYy0NQWQbF5
	5gRK+hOVmZ9nZoyEKfQalDXUa9KPJ/dbOdQ==
X-ME-Sender: <xms:uGu8ZwcXxw0r4yTrikRK1UgsOJ3z8N1F8CpwZyKA7dO-mGlQhzvSmg>
    <xme:uGu8ZyM031AU5LUboShMCmVWaeBQBfJpDQns_hrKhn7A6YAlfnP97PASp0OcaX1Ut
    Gjby7xixTEu8DpZ0A>
X-ME-Received: <xmr:uGu8Zxj9hFlzP788UmQcI4r2MS08SP2bKuTTuv5rRb2u59V_h1T6jfsfiltq9xkrR2ob1MgpVHYgz5G3W08h0Wfxp8kadEMEXjCYdYwnHpS0rydi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejkeekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeejvedugefgffffieegtefhgfeikeevfeefheevvdeg
    ieetgeeujeeliefhiedtueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjh
    hohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghrkhhfvghlihhnvg
    esfhgvlhgvshgrthhrrgdrmhhovg
X-ME-Proxy: <xmx:uGu8Z1-_BgAola356L8_1dEfg3WFT9mNfdpcJxTAFcqPsjY0STlzow>
    <xmx:uGu8Z8uZphwtxvyr2lnezg-3_7NJjbDOHDsRMTHQLdLliLbbEXhVfw>
    <xmx:uGu8Z8F5JjOTNdmRZN1n4viXdW1WgpPfJKRglU6wfwNYUzcKA1tkkQ>
    <xmx:uGu8Z7POTmewmhRkVKQfT92H75jHZk-d21RP7cN1OFyFe1bDzw8gcw>
    <xmx:uWu8Z4L2IduOogoJcjrYhR8iYJ-BaeQiVvIVklCdbN_wfGgL_QGQa-6G>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 07:53:12 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1faca94a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 24 Feb 2025 12:53:09 +0000 (UTC)
Date: Mon, 24 Feb 2025 13:53:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Allen Li <darkfeline@felesatra.moe>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Unknown error with concurrent config read/write on Windows
Message-ID: <Z7xrr-O1QdhXWftj@pks.im>
References: <CADbSrJzNCOP0t=Vsdopa2+GFth_J84E8SEvpRJYfg8uxYnH3ng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADbSrJzNCOP0t=Vsdopa2+GFth_J84E8SEvpRJYfg8uxYnH3ng@mail.gmail.com>

On Thu, Feb 06, 2025 at 06:44:33PM -0800, Allen Li wrote:
> On Windows, Git encounters fatal errors (that do not happen on Linux)
> when reading and writing the Git config in parallel processes.
> 
> I and some peers can relatively easily reproduce this by running in
> parallel (e.g., in two separate terminal/PowerShell windows):
> 
> for (;;) {git rev-parse HEAD}
> for (;;) {git config --local user.name foo}
> 
> The rev-parse "thread" will spew messages like:
> 
> f100762176b7b085e81cafe261a049d809772ace
> f100762176b7b085e81cafe261a049d809772ace
> f100762176b7b085e81cafe261a049d809772ace
> warning: unable to access '.git/config': Permission denied
> fatal: unknown error occurred while reading the configuration files
> f100762176b7b085e81cafe261a049d809772ace
> 
> This affects any command that reads the Git config (which is all/most
> of them); rev-parse is just a convenient stand-in.
> 
> I have seen the work to make lockfile renames (and thus config edits I
> believe) more atomic in
> https://lore.kernel.org/all/cover.1729695349.git.ps@pks.im/T/ which
> should be in 28.0 IIUC.
> 
> However, the above issue can still be reproduced with an RC build of
> 28.0 (of the Git for Windows distribution).

I'm not quite sure which version you're referring to here. 28.0 is not a
version released by either GIt nor Git for Windows. You probably meant
to refer to v2.48.0?

In any case, it's not entirely surprising that this may still cause
issues in some code paths. Support for POSIX-style renames requires two
different bits:

  - The `rename()` implementation needs to know to allow POSIX-style
    renames even when the target file is currently held open.

  - All code paths that open a file need to be taught to open them with
    `FILE_SHARE_DELETE`. This flag allows the file to be deleted while
    the file handle remains open.

The first part has been implemented by the mentioned patch series, and
some code paths have been adapted to also do the second part. But not
all code paths do this yet, and those that don't will not be able to use
atomic renames when the file is open.

One important omission in your context is that fopen(3p) does not yet
know to set `FILE_SHARE_DELETE`. It uses `_wfopen()` right now, which
does not set this flag. In the best case we'd convert the code to use
`_wfsopen()` instead, which allows us to control the sharing mode. But
unfortunately, it only allows us to control `FILe_SHARE_WRITE` as well
as `FILE_SHARE_READ`, but not `FILE_SHARE_DELETE`.

So to the best of my knowledge, we'd have to reimplement the function on
top of `CreateFileW()` so that we can fully control the file sharing
mode.

Patrick
