Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2770AA920
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 15:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752075172; cv=none; b=YBbIyuqlz0PiCiuga64rG81z7KV52DtEDKZ//ZPZmBvFzPr/rOgLR+gNAMCNBsGmHjMWMOCVBk5prIEoY7gA8EXe8RvHaif1Hdn/XL+OWnur1PpE7L8VnUJaD0+m+Tb+r+pA546+UKAQbQxaPQ09DEDPfiWybdOQpy5Al4G1aCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752075172; c=relaxed/simple;
	bh=b6zInezxSZkDmW3qey9CQashlnNZyYK4yejP5E6SWM8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aa8rsn3D+LWlzWm5J6xRppbv6nv9PVybp6HZfxqrqj4zyJFsD7qHaWKjq8Ske+95gcxcpW6mPMtKOQpMVwn3XrJUWgQpbQ+Oyjyn3jRzxTIKhcLdDhSfxyOfdIqqQo7nUDKXYAVBCV1LGEnuwFjt/aguiT/qmla79bMew/tR+pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=h15oG/RD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H4Hd/yuj; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="h15oG/RD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H4Hd/yuj"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4D2DB1400353;
	Wed,  9 Jul 2025 11:32:50 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Wed, 09 Jul 2025 11:32:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752075170; x=1752161570; bh=w3untXEfaR
	O666j/OQOdRFMx+iQ44YMChQmP/jZQ2ks=; b=h15oG/RDh9S9YQm4LZlnPv003T
	1/fii4ZlWwxbtzBKRl22VG6IRbYX1+/ugIhPifnETWJrnIsZPF6nAb0snFxF4K+b
	GrgbRarww/dhYdB3kaTfOpxnR+q9uw8klnz6gRbMqy32nhMaO/dt4VENccTKZrU+
	5w+OC1oheMW/TIUSClU/3OEK++qz5R7xvrm06NrCsrA03SfiLbzXQFv8pk3kW3Ch
	2JRwKUuM8g7wPUL0tA8N42YTBiIaZXIY2+UcEFy1WKglcpZTFWqJ8xdBk9v4xzOW
	BSmb46eB32eo8uRgmdCkWYee+e1vYgSYzqcgPljRlf84qh4bGXfv+Mupc7kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752075170; x=1752161570; bh=w3untXEfaRO666j/OQOdRFMx+iQ44YMChQm
	P/jZQ2ks=; b=H4Hd/yuj1vmnLuWFwp5FNA41pS7i6gB+SJsCwbYlvasI4MUgTYe
	hqANER4tin0EzeezQo/3kLS/izMGBIFIjLgIjuSDd6Zte5VwTe0C/oYGAeg5RnTU
	CcpQTpXm5Wwa1DCYXArWtCUZjGJbW3cb/tOwuM3qCAAZa2WdpYAsktl9NfNAo/QM
	7o4hVt6agZLwUNfXbULDI4eBtnP8kQ1o/wJ8sEZcUIS8IuYOwcbfyhOKlPqAar78
	jJ+cZLsIUYYf3eMNwEwa6ItTcPMAtshsSaPgUElpDwxdFtWXdb6Syp9bO7B0705W
	4hiaMHuCGosZAQMzgv9c6MpN9E0dGyMX5uA==
X-ME-Sender: <xms:oYtuaNHh11kwp8FTJcR6lbe5HotipqBmE9jcGsQqKNcuxK6fHcWHlQ>
    <xme:oYtuaPSpBTQ2LMYIDSW4FOWehuz4NJzZJ3g_Au-UhduYwX6a5PpcNL8bAcyGWQ1A8
    29aiVVTEZUgakblGg>
X-ME-Received: <xmr:oYtuaKyy8_bb8xo-pjCQ9ZdXMcFkWNP8ABidkNRGkPVAYni72aLEnuwPL-DCaFND_EYOxlZZgncEdOLLCxp_Wk1xCZRMNiOohxAc6gM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehlvghonhhmihgthhgrlhgrkheisehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthho
    pehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtoheptghhrh
    hishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhl
    lhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ootuaLcpGB-Rs7TpnSw_GPiv6cxiU75667DCanGF2Y-mvdFC5khKaA>
    <xmx:ootuaNMqMPoI3R6lhg0NqdXuJTicHIIRNoZQXI_gLTiDFfPTt1tbqg>
    <xmx:ootuaGseQ8RpDBAEz7aeGRyEOCQ2xL5WCzu5hZGtf4FH5JyqUpkFMA>
    <xmx:ootuaOD1P-XiShhn6jbfJ8WErjqPpNRuKUfYP2kpLnBYnoZiUk4o9A>
    <xmx:ootuaFnb-e-zknCIPRgJdJu4ocW5kvFIkxvKHsDlQZQLHleVjD_XT09Y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jul 2025 11:32:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Leon Michalak <leonmichalak6@gmail.com>
Cc: Leon Michalak via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Christian Couder <christian.couder@gmail.com>,
  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 0/4] Better support for customising context lines in
 --patch commands
In-Reply-To: <CAP9jKjE0DiZeCB7LG-a7sFP+GXk8WoLy=uZ4qkyCjzYxpPopvQ@mail.gmail.com>
	(Leon Michalak's message of "Wed, 9 Jul 2025 08:57:04 +0100")
References: <pull.1915.v2.git.1746884789.gitgitgadget@gmail.com>
	<pull.1915.v3.git.1751128486.gitgitgadget@gmail.com>
	<xmqqms9eql73.fsf@gitster.g>
	<CAP9jKjE0DiZeCB7LG-a7sFP+GXk8WoLy=uZ4qkyCjzYxpPopvQ@mail.gmail.com>
Date: Wed, 09 Jul 2025 08:32:47 -0700
Message-ID: <xmqq7c0hpeg0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Leon Michalak <leonmichalak6@gmail.com> writes:

> I will respond to everything soon I hope, life has been in the way and
> I didn't anticipate so many comments :-)

Sure, no problem.  

Historically, summer is a slower season and these messages I sent
are primarily for me to keep track of topics on flight.  "No, I am
on vacation for a few more weeks" would have been perfectly fine
response ;-).

> Based on a skim read of the comments, the main thing I'm not sure I
> will be able to achieve is implementing the valid value range that a
> Rene has been working on as I don't have that context, but I'm not
> sure if this is a necessity to add?
