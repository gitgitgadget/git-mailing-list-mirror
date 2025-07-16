Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9EB20C00C
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 05:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752644315; cv=none; b=IqKBzZ+HCdcOjGTYQV8reKWJOMJZs3bwHbDQr9e2/ZOLs7jIZFA8VXcA2+3q/RAsfb0kdNMNBEFtq5YXqMxR7QufU3qKZ0daWd6o4A2xFK5hJ/Ww7EVFH22t1C6gKRHvzeXAACJ0kUy40sHe9MivflRzJyoOquEkze82u6+Wpk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752644315; c=relaxed/simple;
	bh=aUkM2r2BklPIjLQJZUEZ2qmdqqSKG7DYKQebNw3uOYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQFdIQC7dzuKdsmfVPV2FsisAvZ6byhR0RFkq9z/QhlAWXDW1NDC21UTfv8bkurpKbORNikC+p2OFDNLKQ1tyvNOmJmeHLTMzsaz8ORSJu5rwzD4+koK1p7cRGgaHC4mi/mVXcKoxL+/h5pb9t4/tZDa0BTU5qQhDN9Z1agil+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FpBuQgKQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SrIHCdoE; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FpBuQgKQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SrIHCdoE"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E97C314000C5;
	Wed, 16 Jul 2025 01:38:30 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 16 Jul 2025 01:38:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1752644310; x=1752730710; bh=/HV42vZL1a
	8s/NXY7xxKFRav1Nq7JeKMipEGJ/VdPPk=; b=FpBuQgKQvJMO/b5RW76uh4ROMV
	wq5nLKwqBQS1hcqf0NZBXEoRGkmevOKBEuaewWGEp12dUVH2bXLrJtIQyV7NcC7K
	iJXPe7Cdu6foJe9vSOulPRuqS9ZmEvDJkxt5/KGz4+sbP2Gh/znX9HDOMFlbQ6U9
	6NvVnnOnuf3bErEMrF4biiZ0w3xCecFs0U4CXkqI2ba9Hc2Wq9IRXuYxaZewIdim
	3P2q11WbwaunCf58BL12vkSnyGERako7G//bWFSAVebRxRUsCD1m0WT2K7MXxTsr
	WQg553jqdI1yn5rAxfyYsd78ijXOXWuR3VjcPKzSEmoUpAMr/hTFyE/rna/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752644310; x=1752730710; bh=/HV42vZL1a8s/NXY7xxKFRav1Nq7JeKMipE
	GJ/VdPPk=; b=SrIHCdoEZZ8pdB0LFTcvW6qmhjhLxHYL/ckepNIqK/dJRDzXYTa
	rv+HvlGtfBBnU897FOEIs9rBJ6w7Uts0HHo981dYPeaMGJWIMoDjGI82qEnFvM1h
	4g/Us2KMhBX5klI6W6r5nC5alHn84bLz/GnMxytNTxeAbDLdarvbjLzuIrfmpShR
	+7ZMrfQ5zVpYKUZMSflObjF2g5Ho9f+BOspHaqckKd2uyGfcJdqLWsk3SgBrAZaP
	yEYVX1yv2/rFr1kgvMTi0STWxXTRi+Z8lsWUdPOTnCgnpR+n+AwGvU3+iKFYvP9/
	GMqNrFISy5gT5oLWLVyp5uYd/R9f5N0fO/Q==
X-ME-Sender: <xms:1jp3aJdV0upglsfmwpIWl6KNnIQBrc9JUFhQLHjpkPsB9B2hyXeD0A>
    <xme:1jp3aLDvXBVLrOTzkcYo0jZar9lRnnvfjXdQGejNDRoDFrnNTIK0Sg9xuLarEkHIa
    3bGk6hikbCMX7-vcQ>
X-ME-Received: <xmr:1jp3aLmNd4CNCxzLC8R4bqepYpnsHf3RR6XO6STpm2hi_n_Qj9xzJTLGO7w7jHO2HK9TXDCRlySaiXN-WXgkZ_rFyc0FeP5IryKSxWQtNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehieeklecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhutggrshhsvg
    hikhhiohhshhhirhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgs
    lhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghp
    thhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpth
    htohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:1jp3aGfpoaS4jKDMCLIueRinxnMcub6N4QuCIojleeZa0Ksfh4L3mw>
    <xmx:1jp3aPTl_5swcGfkzwDmTHGLeuzrEURQ6A2mUK6k-jLpp0G74RqaPQ>
    <xmx:1jp3aNveCn1TFa1nn-biVddW9KLx4Ko3ydsZ6xkuNxo7nRUxtEXmjQ>
    <xmx:1jp3aAfDptLVtoogPXzrtWzFBEayfffojVHpHQq2BE17qNbhjW4KSw>
    <xmx:1jp3aDyjNGtfmcU6KrXAbdBs68giLSYDYf5CouvFrVsuyjft2duCX9Zz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Jul 2025 01:38:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 462ffd18 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 16 Jul 2025 05:38:27 +0000 (UTC)
Date: Wed, 16 Jul 2025 07:38:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org,
	karthik.188@gmail.com, ben.knoble@gmail.com, gitster@pobox.com,
	phillip.wood@dunelm.org.uk
Subject: Re: [GSoC RFC PATCH v4 2/4] repo: add the field references.format
Message-ID: <aHc6y9FGFXjowkU1@pks.im>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250714235231.10137-1-lucasseikioshiro@gmail.com>
 <20250714235231.10137-3-lucasseikioshiro@gmail.com>
 <mgdervgp34m6ipfbodsfn7cztcl7gdeggzemfgivzvuyk7qtba@wdijebkuioxg>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mgdervgp34m6ipfbodsfn7cztcl7gdeggzemfgivzvuyk7qtba@wdijebkuioxg>

On Tue, Jul 15, 2025 at 02:15:07PM -0500, Justin Tobler wrote:
> On 25/07/14 08:52PM, Lucas Seiki Oshiro wrote:
> > diff --git a/builtin/repo.c b/builtin/repo.c
> > index a1787a3cc5..dcda0d6d61 100644
> > --- a/builtin/repo.c
> > +++ b/builtin/repo.c
> > @@ -1,11 +1,95 @@
> >  #include "builtin.h"
> >  #include "parse-options.h"
> > +#include "strbuf.h"
> > +#include "refs.h"
> >  
> > -static int repo_info(int argc UNUSED,
> > -		     const char **argv UNUSED,
> > +typedef void add_field_fn(struct strbuf *buf, struct repository *repo);
> > +
> > +struct field {
> > +	const char *key;
> > +	add_field_fn *add_field_callback;
> > +};
> > +
> > +static void add_string(struct strbuf *buf,
> > +		       const char *key, const char *value)
> > +{
> > +	strbuf_addf(buf, "%s\n%s%c", key, value, '\0');
> > +}
> 
> Any reason we add each key/value pair to a buffer instead of just
> printing it?
> 
> Also, as mentioned in a comment for the previous patch, maybe we should
> support printing two output modes. For the default output, maybe a
> simple `<key>=<value>\n` where the any value containing special
> characters is quoted via `quote_c_style()`.
> 
> A null-terminated output, such as the one proposed in this patch, could
> be enabled via a `-z` flag similar to how its done in other commands.

Agreed in general, but instead of using `-z` I wonder whether it would
make sense to use something like `--format=key-value` and `--format=nul`
instead. This gives us more room to introduce additional formats in the
future, like for example the JSON format that was scrapped for now.

Patrick
