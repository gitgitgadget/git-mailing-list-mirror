Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99182D73BB
	for <git@vger.kernel.org>; Sun, 24 Aug 2025 17:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756056337; cv=none; b=e6wVpHor4pTSOSS649KdR/6mYK1nln8v5rf6hkfoT0FGWj3gJxDtK0o4zlXjJeHRqiEOSj/0rfoB+aitzk7bY8Bu28UOcSDP8k4kT4dojH8nrIV8NJu0quAv5Ty1pbBhtIBrj1yR6HTyheG60Y0uoI0lNLNLFzjv9oV6tssqRJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756056337; c=relaxed/simple;
	bh=Tsul5Ncj/ftUh2x+g70BaJSu3odE0UQaR0Dz7ivNzH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dgnAJJ8O4/QTqPWop75LWdCglDBUeDLQ2VJvBNSDgxLWbLDTCf37eNDi/vXxMF3U2Mk9qkZ2NNBdMY8tmbRr6jTh6JMfid3MF2CMzo7zmJjt4Hccr8fZxteWGVJ11TBxr9G3+aM2oLlQ396IWhk3aIjH1B2V6B5ogONhUuu0hG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AJNEbEy/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OPIhgkDD; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AJNEbEy/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OPIhgkDD"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 0E0951D00110;
	Sun, 24 Aug 2025 13:25:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Sun, 24 Aug 2025 13:25:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756056334; x=1756142734; bh=8n7E9TafwA
	LS2oKXNaBOJGo9nHXi/ykca57/Kubg51k=; b=AJNEbEy/X9oYDl5cDpok5FUClF
	rsF7dNRuQ5RtoiMfomdwkHg1BkT/EKhvDDCLfrLL3RbIa7E/usicHIE80bLJbWmW
	bgd6wyhXv0wTE4hHspCeKvtWrm+/5haWNcBrVwioyZcJ4/BJQuoB9njdlYbQmxbV
	4cWqjrl39gA/0Dwpod4L06dHeM3XUlIelMZ0zrmaaazihdJsmxgpkmMUcqjzE4Dw
	vKEq5Gi8r3UlOdIx7qYsZ3fnbOIoqU0jeUkREy/mbTeZcjEKfmn0H2XWsFVbN5Fx
	3pnCyo/EMz1by3wxGDMSd48uMer0Mh3idxxvlHZMktWsT40sxMBiIBvHP6ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1756056334; x=1756142734; bh=8n7E9TafwALS2oKXNaBOJGo9nHXi/ykca57
	/Kubg51k=; b=OPIhgkDDiLWe9s9fXpxmSA98srlcIbOgc+XCjlNnCbxZBIxqYjI
	mVv5q5Rbwj0pcK9VeUXH0ieLM17gxvNcp57S2eSaAku8o5GGqbsaWgePebCUNAYO
	CTNIO8+OXP90edx6HFkYqo2jVBg8h3AXhM6VoFd3oWA0at9RQzai6Ya9zkfgVdLq
	Vs4zlooMZHBcaoOoVG7Gv3oe7cigGEd3JigASiTa1Jatr8CErz3cPccG4AvGjllP
	c6xT16PhukDDvnF5gy7+D+Mp6vp0qEcUkdp9sbmyU+4wLJ+G7Z2O2xNd/p+UUfTK
	wjtS7XUyu9/4E5QFoEm7VkrB/sePWPzuJhA==
X-ME-Sender: <xms:DkuraGoTX8zs4l0URJQIiJfCTS-2UzUqdmVwsVIqaBZvYhL7n0GHtw>
    <xme:DkuraH6IInYsN0XmyWzqM67SSZDk_QXcI7TlmI3Q_uNCkX6eriHHg6jkY5GJCpCH4
    a6m9bxa8USeocFcfw>
X-ME-Received: <xmr:DkuraErVR1SkYVb3Cddb6mWXSh-v9xOBYMxk8ocVSRYSMjSUHhUsuWN_tq8EsWxnAlEpSuPurTtyR0KUNV7VBW75haDHUU_Wk2dFZmew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedtuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhope
    hjiehtsehkuggsghdrohhrgh
X-ME-Proxy: <xmx:DkuraBjIz6J10tfkHsC83RNxzoHhkH5fdijLkT4BxaV1gnJYolBO2Q>
    <xmx:DkuraGJD71CQiV9ujohLcW7tItqgVelq83TnorS-IwyCOzEMPGWQyQ>
    <xmx:DkuraJDGlPQ5W39FU_DV6i5zZWF_lO1TneFezFXxIXLYOCg8bV7m2Q>
    <xmx:DkuraOirrB0oJRgPYiPkG5dxYTEVT4wXe_rTeIXmVr30yvRb1Ht4kg>
    <xmx:DkuraIPk00eXI-WbSkqyTIY7Dj6LovD553fWt3zIHN_BRxZkNXgieNR4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Aug 2025 13:25:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 655fb7b6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Sun, 24 Aug 2025 17:25:33 +0000 (UTC)
Date: Sun, 24 Aug 2025 19:25:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 0/3] meson: wire up gitk and git-gui
Message-ID: <aKtLCAq9Y-59cIbc@pks.im>
References: <20250819-b4-pks-meson-tcl-tk-v1-0-6bcaff0bc0a0@pks.im>
 <xmqq7byzfh0w.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7byzfh0w.fsf@gitster.g>

On Tue, Aug 19, 2025 at 08:49:35AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> Having said that, I somehow feel that ...
> 
> >  {git-gui => subprojects/git-gui}/.gitattributes       |   0
> > ...
> >  {gitk-git => subprojects/gitk}/.gitignore             |   0
> 
> ... a move like this is bending the source to match the limitation
> of the tool, making the people who use (write, read, and build from)
> the source to pay for the price, which is backwards.  The tool, be
> it Meson or Make or CMake, should be serving the project, not the
> other way around.  In our current build system, we don't have to
> have borrowed code (from gitk, git-gui, sha1dc, or xdiff) inside a
> specific subdirectory.
> 
> But I may change my mind while reading the real patches, not the
> diffstat.

I'm not much of a fan of these changes either, and agree that this is a
limitation of the tool. I think it isn't _too_ bad, but I would've
preferred to not require this step.

If this is proving to be a blocker we can also change upstream to not be
a separate project. That'd have the downside that it cannot be used
standalone, but the upside that we can just put these directories
wherever we want and then include them via `subdir()`.

I think taking the pain once though and renaming is preferred so that
both gitk and git-gui can also be used with Meson standalone.

Patrick
