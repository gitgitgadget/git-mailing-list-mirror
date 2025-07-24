Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA3819882B
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 07:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753342959; cv=none; b=gm7lk9fNEfOwDVZNxuFmDEtJxCqVFeNh2E4dTsVChWK0CvtBgVdmeYHgriyRG4SqbL2y1O3QNaL5GH7croY8/A3BZ8CVQElTD+T6h7t9RVAPQjb2WU+B7q+ThcSwXgH3cEuo+XdhBHqs2KehqKt84dgx3L+Abk4jLBqznf0NZT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753342959; c=relaxed/simple;
	bh=mZUjHQxpuXE4LgeskCVfyCgFAzV3ZfqbhxBKWH1IExM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pPoBpmNlsPj2IzUKt+/BH1FsR4o4K441svQzo2MQAagfEU2Umnn34tvVfC4xzVWz279kvLOcIM3qduSxB06uvS2d/X5Vokdp6RoRGfl9G3P60JXlyKaw5xHJLTGz0B5CtJfuEesQxaNUSftUniDvIC/6qJPkwo16VCqINnB1oFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Dlp7unE8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MihQOBI9; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Dlp7unE8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MihQOBI9"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1C7267A0116;
	Thu, 24 Jul 2025 03:42:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 24 Jul 2025 03:42:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753342955; x=1753429355; bh=5XxYphH+4P
	erw9Y2z5YXakVnsV5lOw8RM/eTWm56Mvk=; b=Dlp7unE8PKxpvECfyZ9zGOuCda
	WbFjVs3xJxngH2ZxCyOArQqvMTb+X8ozZ2zfLs1bgKKBV82kodM/S0OLMPi0UQwB
	lqU6DYZCEeDG/y93Fh5C5V2iP9VLqI+nDz59JjOWZIrnCEr6ePMCCO7ac+QBN6AR
	ZQXs7prTxPNthwRgeftz3hZdZ8IEzXdq7dTQsd9oQ8IXuSywNgU1FnyCjPj0c5h/
	8qCwPVBXgrcw+G+G4aRtW2AbSk+7LNFNTqidD8vFI89nmU168Ouhtyrq+c5tvLgh
	6CIDQtWHfPPRnubCYnMRK+AssW8Ex/yNq21rwWiuAv+X/NpbqKSm2VWFST8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753342955; x=1753429355; bh=5XxYphH+4Perw9Y2z5YXakVnsV5lOw8RM/e
	TWm56Mvk=; b=MihQOBI9xbVr4an6IRzoenO5X/FMbmZUAHJflbOreih8yVqywAW
	KD3xr4R39SKmWP6xbGXrWSejKjzKsH5V3pi+6Ltb+XL/eDHOllSHA9VOMFrLxiOq
	Hd05pRxOH+CG8w5fd3pFlWbboVZQogUcow2qatBMKMfaxEdiyc3BvlBGzYKvBwdJ
	I+z9K0XZsZBjQwOusxLSLjcl1X1Ixt/2RUi1nCwbGzoOI7AZRLcZ9pl4+AOwZ9Hd
	ExuuvfUmQIPdH0AWMcBhSA9cvPT6A0wrpBmtgDI060THDAUI9HSUnGSobmUrlR38
	Vik58n/LSexMXMxnDw8xVU9nwXnkG6Q2goQ==
X-ME-Sender: <xms:6-OBaBroclBdf075S60B7DrZbr2ZeLRfjzGjm205mFIWg7hJthmu9g>
    <xme:6-OBaG436jU96Z9cjjud-_H44lozLlxFQhaC5X-iFlqiT1RU9tamjJ4bKCLVrQYcU
    917aB1PaGXy0WjYhw>
X-ME-Received: <xmr:6-OBaHrxuMjVLjdiJWU7HMrA2JfX91-HhYdqPZHVC3gbfP4z8ha6H8Pi3HDpfJgG1i82RLtJo6vPE6DFlnKmDtkPgA3K6lIe3XBZ3Q7q1mo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdektddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghi
    lhdrtghomh
X-ME-Proxy: <xmx:6-OBaIjoi3JExyXabFntWtYQCCTtAUTGEPO5F3hxKHIe3-QnrvzVWw>
    <xmx:6-OBaBKzbdBbFZUs0kV1UQyHTXMjVApnpCMUKF8qy_w1y1Apc-Bobg>
    <xmx:6-OBaIB0Amwoj4oF1J0_XB_PjbjvWYFCzfNLsq9R3_jU52PmG-wYbw>
    <xmx:6-OBaBhb5fo0GMBnwNbOmJzMG5y4qx-zLoExX5xkQDySXQr5iWUxGA>
    <xmx:6-OBaH242vpr1_MMF_W1l4SmLQWuUT2AjFG6sRFKeNBO_yKMrNNl7Bye>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Jul 2025 03:42:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 433f3906 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 24 Jul 2025 07:42:33 +0000 (UTC)
Date: Thu, 24 Jul 2025 09:42:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 2/8] builtin/reflog: improve grouping of subcommands
Message-ID: <aIHj4NWr3M5lXLtD@pks.im>
References: <20250722-pks-reflog-append-v1-0-183e5949de16@pks.im>
 <20250722-pks-reflog-append-v1-2-183e5949de16@pks.im>
 <32gvkjmjz6otqwpaxafmz5xuznowhn4iwcdyn52qhbvzohyih4@oeimg3xvqj5u>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32gvkjmjz6otqwpaxafmz5xuznowhn4iwcdyn52qhbvzohyih4@oeimg3xvqj5u>

On Wed, Jul 23, 2025 at 01:14:19PM -0500, Justin Tobler wrote:
> > @@ -404,10 +404,10 @@ int cmd_reflog(int argc,
> >  	struct option options[] = {
> >  		OPT_SUBCOMMAND("show", &fn, cmd_reflog_show),
> >  		OPT_SUBCOMMAND("list", &fn, cmd_reflog_list),
> > -		OPT_SUBCOMMAND("expire", &fn, cmd_reflog_expire),
> > -		OPT_SUBCOMMAND("delete", &fn, cmd_reflog_delete),
> >  		OPT_SUBCOMMAND("exists", &fn, cmd_reflog_exists),
> > +		OPT_SUBCOMMAND("delete", &fn, cmd_reflog_delete),
> >  		OPT_SUBCOMMAND("drop", &fn, cmd_reflog_drop),
> > +		OPT_SUBCOMMAND("expire", &fn, cmd_reflog_expire),
> >  		OPT_END()
> >  	};
> 
> Structing the subcommands order in such a manner seems sensible, but I'm
> not sure the pattern will be recognized by others that may add
> subcommands in the future. Maybe we could leave a comment that mentions
> the order?

Hm, dunno. I feel like it's subjective where to add a command anyway, so
I'm not sure that a comment would be allt hat helpful.

Patrick
