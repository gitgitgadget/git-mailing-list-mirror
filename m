Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7296519882B
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 07:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753342965; cv=none; b=AZqZ1p7dmlbnyV81JIQvCJGu2QuLTrZfoljh/7Oi6UB4JRZDYUzO6PuXZrtAf9fWD21W5ryyJejKf62d45GBGO1Lgg1ly1H8ai1Hmm6MJddQc4YyUaseCCMt0kX+YTs2MKSt0/Vi+xdhD7yJJP/qK/3F1fTrg3EHL6Ezk1cNqMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753342965; c=relaxed/simple;
	bh=v6wKAj2LqS/aiNwWNXAtii5g5nAXdjaQvg+fqLK5360=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+qqxsJsaYytJRuSxuRoMq0d6l+hiZRDewESmgmACdtTP4qzu2DvISnELj6S00ae1gv8uccm5ma4svaSoFCy6S+JtnzrocGWoTvquhaVydtavhZSnjxYCDkNnCl80c7VRMHGsXCFtEcWKnQpNow1z9fipo1vhYV6TH/rhmwzPkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QgRUCCPw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UiXv3U7q; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QgRUCCPw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UiXv3U7q"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6492E7A0129;
	Thu, 24 Jul 2025 03:42:41 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 24 Jul 2025 03:42:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753342961; x=1753429361; bh=JtiJO/qiL3
	e1KbUUeLvmESS7ucseSSJZqflnXrKf/2I=; b=QgRUCCPwxFZp+MWWe7DdxdBRpa
	1NHtWhSNfXiqQg3Sn0SI/Q+vRKzHfFwuP83t/DutwZHdvpFogDJhYwVBSOWndvSE
	khMXGAkEFaz+RSfgzuwglxWqWjdFv6rsaslg+XMZm27HYYA/ALCWtnHgIB5aP5yU
	YJdhrjOQJx238DxKvKqUr8lcrOyBwyhLqapDZnFP0PS24rk43tM35T6FeWhnt6AH
	N1epG+qpM0eSVSYpCtgcNHMcjWTw8/tLmhqoFOugSYq7qof21TIlWzp2RHHyGAYV
	Jx2BCOfKxyHXF3hPjsQi5HVsj75NU23J12y5EMabBjwnNCk9H40pOXsFG68w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753342961; x=1753429361; bh=JtiJO/qiL3e1KbUUeLvmESS7ucseSSJZqfl
	nXrKf/2I=; b=UiXv3U7q/E99tCDc72+z1kjJKHq7LHUcJ52vV1Iu+OlP696skqb
	fFF6jWtn9ldfC77xX/y67VHtkwdsJhgQlvPXmEnallOw56MqhB7Mv7xcmr+vRiyc
	ER994CMVcjaSYhbZtfLpxMWMmEDhnvClHnLesvDt83PrJB0R9QH3KM1tsRoeIw/F
	UDnWlUwz/uEC/jKaf5dakhwRIXR767wlIS3aKcRLAdp34+G3CW71rcZMs4exFjeO
	QX1Oe0uCJBe/U88GPgu3pKxHXoER4EWpKLTiaG7EEKUvYWLGiLqkmx8CitsRjSvT
	I8++e9Pp3U06r/y/F3Blk5/osNw1rKygg1g==
X-ME-Sender: <xms:8eOBaDw2PRsbfb6Zk7pKh02j546sr2wYvAiPG1acSTouHhPyaOMjNQ>
    <xme:8eOBaOgHmNOCM6RwvLdRSOgTgu3G9bheSI5teFzaoalpA_8DZE3V3wjzJBMZS4mKB
    KgdlF7ulsn202mnhA>
X-ME-Received: <xmr:8eOBaGxRgBE_KoWpVJdeRxn3UoNUCUdosXrcBKOGxqn_nQOBuX5x77wa4aSRAdqwyML9RMLYwmfuoe-gO-j2tSHZ3iH-qtcXDwMt7CgJEAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdektddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghi
    lhdrtghomh
X-ME-Proxy: <xmx:8eOBaJIuu94oH1hNmxf-ZsP2R2dNyGdUANqijz8iZOWcIWgaw9WiUg>
    <xmx:8eOBaFSBs5Y1CVLR06zzEmXMc6g57fuuY9bcEtTik-iz5SFrv0QRtg>
    <xmx:8eOBaJqS4u8oYHqPiLqnVksBcy42RpdTmd27Kml5zk99y-9686zLng>
    <xmx:8eOBaCqIVchaEc7J4jZtGukMK0_i4l-cZ0_V_FThuMGtWw3I7WJfBQ>
    <xmx:8eOBaJeA33OXrD9ePz4JtsiZzmTbcER7ipCWb0lTI8GE95WAaxX9Nbpp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Jul 2025 03:42:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5afe9e08 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 24 Jul 2025 07:42:39 +0000 (UTC)
Date: Thu, 24 Jul 2025 09:42:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 4/8] builtin/reflog: implement subcommand to write new
 entries
Message-ID: <aIHj7M5fzYSpqSKJ@pks.im>
References: <20250722-pks-reflog-append-v1-0-183e5949de16@pks.im>
 <20250722-pks-reflog-append-v1-4-183e5949de16@pks.im>
 <mkqjim46zv4sfhzjjee2tcxwj23esfrupp5byienju5qlwvlht@r2gxnybioukw>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mkqjim46zv4sfhzjjee2tcxwj23esfrupp5byienju5qlwvlht@r2gxnybioukw>

On Wed, Jul 23, 2025 at 02:00:10PM -0500, Justin Tobler wrote:
> On 25/07/22 01:20PM, Patrick Steinhardt wrote:
> > diff --git a/Documentation/git-reflog.adoc b/Documentation/git-reflog.adoc
> > index 6ae13e772b8..798dbc0a00a 100644
> > --- a/Documentation/git-reflog.adoc
> > +++ b/Documentation/git-reflog.adoc
> > @@ -12,6 +12,7 @@ SYNOPSIS
> >  git reflog [show] [<log-options>] [<ref>]
> >  git reflog list
> >  git reflog exists <ref>
> > +git reflog write <ref> <old-oid> <new-oid> <message>
> 
> The other subcommands each have an entry in the description. Do we want
> to also add something for the "write" subcommand?

Yeah, let's.

> Also, if we want to be consistent, I noticed the order of the
> subcommands listed in the description was not changed either. 

True, I'll fix that.

Patrick
