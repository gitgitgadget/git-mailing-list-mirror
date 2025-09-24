Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A1A1DA23
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 04:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758689340; cv=none; b=Ggbtx2uw6k+PVOmmWQRU4/BNKTlddLSgERBbooJ6rJib96KDueLkH5gFdpi5I1YUSdGd1rWR1t8c3F7nprlgguYikAZZCVkRlz4NCxfT6vXUnRMI89tBZ9WK4WavkbnZUOdZpTA8rtsW2Ft6KX5LguU/y4oCFm4lWLmvgpxjdcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758689340; c=relaxed/simple;
	bh=zsEGQMirPO6o3iylQR9jofoQMUbgwpIuan3TBECngv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qio20RATqbYCJN/AkgjN1ZyTS9bhkIbkSLHh9aZwu31ytB3CfBs1sJ7/OQfp0jREdYsFyN8YE9i9ziLCpggOXcLAXVoad16Y7K3dh52QNy3G08ySbLyUgnKb37bQ8RvSHEo2GkH744OHfjUGSO9yNUZKPa/3rysWen65H/U4M6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=O6AbNskM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h4G/cSrO; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="O6AbNskM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h4G/cSrO"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 8097BEC009B;
	Wed, 24 Sep 2025 00:48:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 24 Sep 2025 00:48:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758689336; x=1758775736; bh=YqHEQ67PMF
	NBspCMIv2Di9Udch5SxHvKLKGfs9fVJTM=; b=O6AbNskM5+eDNig0+vZtA3RX1m
	Ev+lNrPfeNe1EsmDKAxk3YbU/49aDYR71FzJhtDTkKzRl/9rpGC/0kalQoecLrIP
	ZEWkZkTS/6HOCcSfVa+fphS+rsOH6i7Y1iZKJq1ou7f1fwgw77tOWDdB4tMAOvi8
	X3NBi9dAaBIyoAGuUY/qlPYVILNyhLH8ZBUD4ooZgr1VkgSDZR01Sht9rtiIeXL5
	l0PXkt9bEElvsN6UAOy2Wiqc6b1k1RkEltOlrrDSyUgFGQzG5mk4FTKqOhKDlhzs
	8z9DVdIzmDZfDYDeD2p2jVgQMiu8pV9Cx3UjmO8nseqAgrvqBpyfTvYQQxkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758689336; x=1758775736; bh=YqHEQ67PMFNBspCMIv2Di9Udch5SxHvKLKG
	fs9fVJTM=; b=h4G/cSrOQkshrUSPNoIXwzgqRIRzltM4gP8w17T8n78w1wCNbra
	TUQiHFYjCoBSn7RgFwhkU6xULABrXYYR3HLgYeEuhZP3mOKSAVoP+YLq0yUCl3aJ
	8CctJgbNrxwE+HQ56ffrl7GTQoL6I8/aMnLY2cRixMOf7LApCo+iJD+NibJBKu3M
	hOxMsTiwDB9FapmDrHJ9C+SL1AOXguw6zuChEASzkrP13Rx6CA9noXO3v+XJMRZP
	QrxYVhMZCrmfgergcx/K0VO1MlcojUWU7YMyqZtF2SlJ63lWch08G7dnZzn5LVFn
	BdwzG//VbVoVgBQanOCHs5B5DadBQDvDhVg==
X-ME-Sender: <xms:OHjTaPR5eGRYJCHzT4Sw2oGY1s100LBT2NUR2HwhKJkU1dtcJO_W0w>
    <xme:OHjTaIMcn7tOJS3m5npS_JCvFTJY9aPgw8K_bC9uEiSxqi6VHc2UE_oa0ZbX5FiQE
    9JQESiTAk3Jy6QUNDaaZR81G5hi6voB7bIj0jziYed1rkI743P6og>
X-ME-Received: <xmr:OHjTaCPenu0DtgIyDx1aaJ5lo02gj4ThfviVa2ShPr6_Pk6QxoE0p1RxmyrCgkreKdifiMVOT5K_c1REi8dM919rHR0SqGhx0femW8ZziQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeivdeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghi
    lhdrtghomh
X-ME-Proxy: <xmx:OHjTaIuKRvPzrLPUJryN_N-otjEEuNQML8f97heN5XSM5Fnwl-Yw2A>
    <xmx:OHjTaMVaB6Lw7U0mCbkB4oRdn4wg4TwaoN4vTR973tgr14rwD9jHjQ>
    <xmx:OHjTaAsl3CYy3SERIyRDsNZrqbhEwZqCL_cK0Z9a_W96rBnqdam2KQ>
    <xmx:OHjTaIWx-nKP5K8umpw8hzm-zBLgrjo_M1bU4y6UTZ6Pp96_2B1Yyg>
    <xmx:OHjTaPrEBfSM3S4wnKqrKml2C2p1m0Nzko_SvqDqhlpIYJqtPS2XsdHz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 00:48:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dcc4d935 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 24 Sep 2025 04:48:53 +0000 (UTC)
Date: Wed, 24 Sep 2025 06:48:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com
Subject: Re: [PATCH 4/4] builtin/repo: add nul format for stats
Message-ID: <aNN4Mk9Nh_mF1dJ6@pks.im>
References: <20250923025700.3046260-1-jltobler@gmail.com>
 <20250923025700.3046260-5-jltobler@gmail.com>
 <aNJ8EUT_QVCqfFo7@pks.im>
 <r2rt5aq64x232gmpj5wzzchut2w2axnkyfzg7wpthwuf2w3j4f@teydueqvon5d>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <r2rt5aq64x232gmpj5wzzchut2w2axnkyfzg7wpthwuf2w3j4f@teydueqvon5d>

On Tue, Sep 23, 2025 at 10:33:45AM -0500, Justin Tobler wrote:
> On 25/09/23 12:53PM, Patrick Steinhardt wrote:
> > On Mon, Sep 22, 2025 at 09:57:00PM -0500, Justin Tobler wrote:
> > > diff --git a/builtin/repo.c b/builtin/repo.c
> > > index 4c16a68e4e..37034e6347 100644
> > > --- a/builtin/repo.c
> > > +++ b/builtin/repo.c
> > > @@ -291,27 +291,31 @@ static void stats_table_print(struct stats_table *table)
> > >  	strbuf_release(&buf);
> > >  }
> > >  
> > > -static void stats_print(struct stats *stats)
> > > +static void stats_print(struct stats *stats, int nul_delim)
> > 
> > Instead of passing a boolean-style option, can't we pass the expected
> > delimiter directly? Makes the callsite a bit more obvious.
> 
> Ya, we could do that here instead. Something I just noticed is that the
> NUL format in `git repo info` also replaces the '=' delimiter with a
> newline. I'm not sure if it would be best to match the same behavior
> here?
> 
> If so, we would have to either pass both delimiters as arguments to the
> function, or just keep the boolean toggle for the mode.

I think being consistent would be nice, yes. I'd personally lean towards
passing both delimiters as arguments in that case. Makes the callsites
way easier to read.

Patrick
