Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8403118A931
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 07:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729754403; cv=none; b=YuLA6Jp+WdhiktNG8Ik8WtXoetr2PcM7pTGs3PVvsiufpw8FiSyE0DT0w+0x1hYZ2KrkLcgA/0RtEjN8gfiP5uWod2L5YPxEjG1R/B0Nr3/CcjZriz5V4CH2Qb1zvSjpKTdPeSMp1WzQq9qNVCdr1BJELIXOKOrqJ5H1sEGNjKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729754403; c=relaxed/simple;
	bh=y7lgej0PiiUXPeEdQXCWNOiLwTOtDkFix0RAMbic5JI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YhEb86CbUmcGPg/N47o+EJWRLMGKXmBxrB2j6WWeMcQFwxc/aP00vPE0hh3RhSc14JF+2H7PiOtXuCCt+kHnbW53KQxCDD9F0rjw+LN/Qf4YNiiSNCKxSod/6JsI/2+j6m8zuUpre3S7XNudoGNEJf+OlQRvb5OuxjTwLDzMGJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kupQ/j/N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UGVi8LUM; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kupQ/j/N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UGVi8LUM"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 86DBF1380662;
	Thu, 24 Oct 2024 03:20:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 24 Oct 2024 03:20:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729754400; x=1729840800; bh=l/pLQtbiK6
	S8ySfhTwM9+9LVLwAFzxBkqdkFik12HtE=; b=kupQ/j/NZNEvxR4Z97hqVCHPtk
	qdiTufdquCufC+rGanD9G8gVvLAn0lQjQORICcfKdlOocTVkvQWntp6B365Vhe4P
	z2uyVaFqjN9TaK41DOvEFSLM3CAyGEvhSwqentxaZvSDX6vcvqR/f+jl9EuBZTJS
	sF1Cm7ikgsEQyf1m1ojJL5VZLRemo1MwVwMInxiLWPxV9Br0Ke8A5V0JUGK/A3JA
	LluSi7PTPL3RSz9FFVua7AThpH/3mNfOpMgqW5MnOSrsDoTPxYg94M8RvZ4cWk0H
	cErhN/owLdHtuonzmFsGZ4KXjGcgTojWF1xRL/s3/T9gPDchscVOiGj0T7Ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729754400; x=1729840800; bh=l/pLQtbiK6S8ySfhTwM9+9LVLwAF
	zxBkqdkFik12HtE=; b=UGVi8LUM9PcjTRFKzYjHrpHRDQFn+WRyQDXbhaPVeiXx
	O6BWC5P8dY7W+BkL78PYVb5tAfOKrgSidGEeV/mjiu2+JoOjDlhHNvpcoLoIGzm5
	doqdqYdckWSWWJgkIFUIdrp8kQX1SmfWnTp7Xz94dv5ss9w8rpRNhq30o7n5pXSM
	7c1zc8n6r49gWiakYtNPg1Ia7dpunS1q150KMqFs875KX4bIR2GHmaisP4xf3sUR
	5HEUngENwfEA21jQOQDJ6AIHeZVAreolAcdf2UPRXAXco7oHuII8F+icdkOGDue5
	ELxpr5ocI5ej6cuX0v1qMLnr8UJszl/9KRzkAozWVg==
X-ME-Sender: <xms:IPUZZ7XfYQHrmmXD9oKLew_MCyj2RNvdJHd-EbYPjHK32LD9TRpgvQ>
    <xme:IPUZZzn6ev7QkgOQOth__e8W9675jtsZ1TuLujEq0IOCkNIO6JgoS3cMWY_OSq6lF
    QxLRRgBBu9DsWV_gA>
X-ME-Received: <xmr:IPUZZ3YYGOlaDKWE1q8dCFHmsfwIjUtLEHf26ocWWpOfDjVjcgCXcOGROxXxGIccwiCjELBg_8PetMtEjyvOETLwtVuwVmJbElklwvMqYHkQt6j5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeikedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrph
    hluhhsrdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhg
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehsuh
    hnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougduvd
    efsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:IPUZZ2Xa5wrTIYxKsZVL4yPtapaiXk4URcjSsvJR_AFV-FZ708QgTg>
    <xmx:IPUZZ1l_ThprBcisiRMVHnjPmZSUoMeyv783z90zTyi0k-r6NeqHMQ>
    <xmx:IPUZZzfLyM7Kzqu0yIxMcGydh5cp-pe3pr6oX4_dq_Npy_k6AKd_fQ>
    <xmx:IPUZZ_GBY-0d-_Ng0_au2AyS2rOUe5oIzCoUbzlWhHUzFgYuh_stGQ>
    <xmx:IPUZZzacCgebRfodnOefWjylYLvP5tgi2QVstxkZUfbSG9uDlqTSJMOn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Oct 2024 03:19:59 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 03bd90c0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 24 Oct 2024 07:20:02 +0000 (UTC)
Date: Thu, 24 Oct 2024 09:19:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Eli Schwartz <eschwartz@gentoo.org>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v3 00/15] Modernize the build system
Message-ID: <Zxn1HWg7KxZwBy9h@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1729254070.git.ps@pks.im>
 <86de131b-bdea-4c37-b512-68b8378f4343@ramsayjones.plus.com>
 <361e69ee-4491-4e2b-8edc-fdf4bcbb8532@gentoo.org>
 <b35b6f10-ebb5-4266-ab95-aafb67cfad22@ramsayjones.plus.com>
 <ZxjmTbATU7usHcqQ@pks.im>
 <c32a7dc3-cf9f-4d42-98da-80009f9df847@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c32a7dc3-cf9f-4d42-98da-80009f9df847@ramsayjones.plus.com>

On Wed, Oct 23, 2024 at 03:38:18PM +0100, Ramsay Jones wrote:
> > Do any of the versions used maybe differ?
> 
> Ah, yes, I should have noted the versions:
> 
>   $ uname -a
>   CYGWIN_NT-10.0-19045 satellite 3.5.4-1.x86_64 2024-08-25 16:52 UTC x86_64 Cygwin

I'm on basically the same system:

    CYGWIN_NT-10.0-19045 DESKTOP-OLQRBOP 3.5.4-1.x86_64 2024-08-25 16:52 UTC x86_64 Cygwin

Which makes this even weirder.

>   $ 
> 
>   $ which meson ninja python
>   /usr/bin/meson
>   /usr/bin/ninja
>   /usr/bin/python
>   $ 
> 
>   $ meson --version
>   1.3.2
>   $ 
> 
>   $ ninja --version
>   1.12.0
>   $ 
> 
>   $ python --version
>   Python 3.9.18
>   $ 

Let me try to update Cygwin to the latest versions... huh. Why is your
Python version newer than mine? I cannot seem to find this version of
Python in any of the mirrors.

Oh, wait! I can see that there's a "python3" 3.9.18 available as a
testing version. I don't quite understand how this works though, because
when I install it I still have Python 3.9.16. Seems like there are two
Python packages: "python3", which has the 3.9.18 test version, and then
there's "python39", which only has 3.9.16. The first one just seems to
be a meta package, so it doesn't contain anything.

So... where did you get Python 3.9.18 from? You mentioned that it also
hogs all CPU, so could it be that this is basically a broken Python
installation?

Patrick
