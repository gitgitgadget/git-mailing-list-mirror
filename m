Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9B8179A3
	for <git@vger.kernel.org>; Fri, 22 May 2026 06:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779429977; cv=none; b=Oa67hv0jPRJ4lVphet6myKtzj5o6V/5zZLzcG5yKKHErjBCeyRofCc+a0iMq/gFflaXZTk6oIiMF0X4ojWcwmI8gBMq5gWXxbNMqt9eiGCQfAu4YSje3oQh6EA1aoBNjOgQX7pumK6KJUf7PMWbQBIgXlukw6mHQWbfyuHGab5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779429977; c=relaxed/simple;
	bh=qE4REs1P0Z2hYrEae2pkTnVeFdHqiBij1pHqN/CWtKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X992j5zy61Z6fl/fOGU37sbojA02R52DMs6zwjiJOVbbTiO4SYnQWs6mVKw3JzGhF6CfdrAeoylobixB0oPSFYsevtzzlNAuInRx1A6AyrR8FUFvfdeaSACvpHnXTB4W+WSgl4258w/aeNGrBvWxB3CP4Vcl9fTHzxurjobolec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SLCWHBNJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KCRWKnva; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SLCWHBNJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KCRWKnva"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 60CF67A0073;
	Fri, 22 May 2026 02:06:15 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 22 May 2026 02:06:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779429975;
	 x=1779516375; bh=xZAZLTCLQOaHUPiV/85C+WcfO/Gek/a2mRM7t0pob+8=; b=
	SLCWHBNJCIqqKAhPVmvYXEV4YCWoZmjuX4xfZh1zQanO3ybe/FvJ2HTurvJxVnz9
	N1GBYKBijXxGGio+6rlxNixdCnT5Jl79poLCzPPoHitDFX+YMZx77eA9/Dt1t5Sy
	eX6V9lvgDjKf/j70lIN2hHcP6OL/BA/GvmazbkoV4Y7Zisu+w+CSB4f6ZN/qin72
	uyPr7U+sugiRN0Q6/GsskoW9R3zu1iYplrkyRX5VZvX6W2tZxBXl53LoItlYv05S
	wdisq2boTxAVUgDz1oj+u2Tt68xtD9vwrzFMnwZNYfr4iBF0cdCxtkwaxCiVGWBL
	1uw/C/jvTW40fWkGNhzgJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779429975; x=
	1779516375; bh=xZAZLTCLQOaHUPiV/85C+WcfO/Gek/a2mRM7t0pob+8=; b=K
	CRWKnvaPiMPnQYnE5GKQrJRYfiN/4fuVa/q1vK7jatVehp118YxczXOzdJ2ZFhkH
	r/wum9BWNUf3MACGo3KHMOmEur1Hn1x/hFihLo8klGQNGqsOrzuzqVjgM6ZWwGwI
	d5im/Q0c8aloYubYML7qfeD/uMi0XPgHspRRuRFcZkxpF/k2onB4fJCNJfGrebED
	tc30t2uYJ83GsknhQvqAIB6lp09i0mJq4Ew+VZUP05NhjJtdQWOlAiMuKaJ/GZTm
	0i9jyxPmyPJYrEprOib5DtOs1CMOA+w7g0muE+vib/N5ADiF0ygAZlpNdSF6XriO
	0Z7c5/HzMdSYILosqY2qA==
X-ME-Sender: <xms:V_IPauT1DodfaYWZMryj_oW5ykTgDwX2YpKms0Wjcg9D_8lJ2c5Gow>
    <xme:V_IPapwpDTF2Qg0HvSkR0tOWOK6h3GSGw-YrOCGQfC6Qb4CrVsfoi2XO6VJquzvvs
    kaDBS6jrFVPLLvrkXyza5CebdFA-0k42l7Ji9jTrTQw0i9IM-HJhw>
X-ME-Received: <xmr:V_IPapfVFY7hRlBUG9zHC0CqvQpdcU_fMdtfrt9jOlEOtP08zizH2-m0CyrHN-kNz9KZ3kq6tfFCvJYc8445V1P1Dmvgc_PulETiCI07zw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeelheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsth
    hofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:V_IPalLkPx4Nw1RIbZBn4juhl-hej--xTSTldMjOcgBb0kJpgwgGRg>
    <xmx:V_IPaqFgtMnoHViCA1M_Jj9Q27Q9-jZvLRNCcOm3UsqaCy_MH8sFEg>
    <xmx:V_IPavq1oUA319VRSO9NNAYnUHaoJOa_wALEG4QDNuFkQkFnIN6pZA>
    <xmx:V_IPajTKZTi9RsOvK9RH3BLDnwkb6JspKZnJE_ASlsqondq8VQHnZA>
    <xmx:V_IPahrGKGzIc_XWXrN7K9XlMUvbbljaRs22RxeU6JxrQL__HLQjVe_9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 May 2026 02:06:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fe764af3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 22 May 2026 06:06:13 +0000 (UTC)
Date: Fri, 22 May 2026 08:06:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/8] t0001: plug test gaps for git-init(1) with
 GIT_OBJECT_DIRECTORY
Message-ID: <ag_yUsOEO6AjT4Ky@pks.im>
References: <20260521-b4-pks-setup-centralize-odb-creation-v1-0-f130d2a7e8ae@pks.im>
 <20260521-b4-pks-setup-centralize-odb-creation-v1-1-f130d2a7e8ae@pks.im>
 <741c2a26-7380-4d8e-aa91-fb237e9f10dc@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <741c2a26-7380-4d8e-aa91-fb237e9f10dc@app.fastmail.com>

On Thu, May 21, 2026 at 07:51:59PM +0200, Kristoffer Haugsbakk wrote:
> On Thu, May 21, 2026, at 09:42, Patrick Steinhardt wrote:
> > In subsequent commits we'll rework how we set up the repository. This is
> > a somewhat intricate and thus fragile sequence, there's many things that
> 
> Should this be s/, there/; there/ ? Depends on if this is a list of
> three items or if “This is” is a subclause that is supposed to point at
> “there's many”.

That reads a bit better.

> > can go subtly wrong, and there are lots of interesting interactions that
> > one can discover.
> >
> > One such discovered edge case was the interaction between git-init(1)
> > and the "GIT_OBJECT_DIRECTORY" enviroment variable. When set, the
> > behaviour is that the object directory should be created at the path
> > that the variable points to. This behaviour is documented as such in
> > its man page:
> >
> >   If the object storage directory is specified via the
> >   GIT_OBJECT_DIRECTORY environment variable then the sha1 directories
> >   are created underneath; otherwise, the default $GIT_DIR/objects
> >   directory is used.
> >
> > Curiously enough though we don't seem to have any tests that exercise
> > this directly, and thus a subsequent commit inadvertently broke this
> > expectation.
> 
> Isn’t it more that “the upcoming changes *would have* broken” them if
> not for this change? This seems to refer to a an alternative commit
> history where this change does not exist?

Grammar is hard :) But yeah, this of course refers to an alternative
commit history I had at one point in time that did break this.

Fixed locally, will wait a bit before sending out the next version.

Patrick
