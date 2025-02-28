Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6449F1C5F18
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 23:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740784898; cv=none; b=BsU5L1QWdU6ypNr65/0OAGGc8pBMEptFEH6osm9eZ0EgXX5nbQA2+yRC3VzcYoqZvNvQAuSA4+ESCJT1UdkBLdvXxAgKL52SgBsvVlWrOIPBX7n2JwmhEaYImDL0ltgtvE7PZsg4rBykCLwpEfnEzpyf8FH5AJ82G3LMs+nQ7VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740784898; c=relaxed/simple;
	bh=7Smp6cYl7FI/FJmYZi2+A9GfvlResocch+38P7o4bLo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Cuv1uJ9cQMpfwdms4vzEElyik1UOMm8w0Cp6WMvjje16KIlzVaR+C16Ri35qEZgqSu0EqathvyMiXjtHrgYVTouTBttFFzMNZR9HnFsVUl9ASLQYHP1u1MOs9jfThDAp2e9rMZQf3tkJbySSkdFXjjkP3zsho+4IVZFbc891lJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=d9ka5ACG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pvOCEnkx; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="d9ka5ACG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pvOCEnkx"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 42E1225400EE;
	Fri, 28 Feb 2025 18:21:35 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 28 Feb 2025 18:21:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740784895; x=1740871295; bh=X03JHSoVZK
	BnG3fxHY1IBlHN0DXZX+5iDyAlCeozlxc=; b=d9ka5ACGhDcXTMuU73LYYn84YP
	rp0pWjnwCc8cSONDqAPVYaE0hVAAXL2aP3uvOmPvqlLIu/Lbntt/e48wcPhIOA6m
	zyalqHw346CV5clYveOkGwZJRGPJ72mRb11WqHrs/RthHFm/Zdhiw2LY+8yg4If0
	0brFm3dEp2HTzKbtlFcgN4O17rGcSw8u91ftNRN+sXllic1BrBH+WQFfe7bPzZrA
	FqBJgqD7C/lV7HrkXjUXPdMMqrh+N0N8U/acrilo0JQCMYMIcYsMm/2ddfOC8PVn
	QWIdItKiA0YVhhwj1F67msnEGAgSfnahJ4g7Aoqa02NXMOUk+W4FoHYt0x4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740784895; x=1740871295; bh=X03JHSoVZKBnG3fxHY1IBlHN0DXZX+5iDyA
	lCeozlxc=; b=pvOCEnkxklgTJ9Qag5Zrd8p7qDHxWvSlz1s0+ocKjzsYIniy+sR
	wmiWi+1lgHtjN5/Ts7o7ith7dg0eyLMk7i93EC23xmpCf06de5PiNPZoj2lj/Bp4
	qlUretzceCt1t6W3Y+cj0ceVvJXI9Ne1CztDVYAKuOxkaPh2n/ZVdSXg/JOY3xsF
	//goWqXfFj8sV6S7L/jMIEqVyftK/xvrYfhwKEWMEy5DhTgX6eQ3ndeEjV6n/3RJ
	Rx4QcwCnHMcsnrYZs682go0dCU4oyf0DEDRe50b0khFFu2VZG08VIxZiszThOheJ
	hb0vDNGygor3avbpGNi6SJ39pLcgS0E66HQ==
X-ME-Sender: <xms:_kTCZ2Krow2tfWgbA7oSo-biQftyIYHlVSVonvqbGsvguH4z3vyy8w>
    <xme:_kTCZ-Ig-BwI7YelUknyJjgwybou5SOyuQvuN2zyTWewM2an8Njyv6GJoVIKl_DPz
    9VaMG30-tdN9fD9cw>
X-ME-Received: <xmr:_kTCZ2tk6YbecCNl6fF_r6_6AKsB9bZiHgBpUNBh_loFjxJu6266gksM7zBNnD7p4xn92dNvdoaZpxIAfRtFuK3YEBhpBUkvi9kk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeludejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnrghsrghmuhhffh
    hinhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehgihhtqdhmvghnthhorhhinhhgsehgohhoghhlvghgrh
    houhhpshdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhn
    sehgmhigrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:_kTCZ7ZPH8O590uCRMLZV17n7x_SbpYk-RR1nHKhEMs9ZN07ECsiHg>
    <xmx:_kTCZ9Y4_sFNHC-QxErRV_0q1Atic4BlSqQUQb8GmesntTy2ZGkGLg>
    <xmx:_kTCZ3ATfXrKrTebvZhKxbOCgBhs0W4CYz5gBtuoS-EkuCJuI0CVWg>
    <xmx:_kTCZzZ4lQTsllr4lO8WsdOJy-cEJiCoQxTfhDLAB3bMHwpybcI7Vw>
    <xmx:_0TCZwyTKQP5lcMbDYreaXjN5PlwXnXx2r5EFcm0RJiuyPeR2y5_wHOK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 18:21:34 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Emily Shaffer <nasamuffin@google.com>
Cc: Git List <git@vger.kernel.org>,  git-mentoring
 <git-mentoring@googlegroups.com>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>
Subject: Re: git-mentoring Google group replacement?
In-Reply-To: <CAJoAoZnk88ZFZFdEtUxMnUa1OZiXYOgcw8DSbB+A0LzyCPFugg@mail.gmail.com>
	(Emily Shaffer's message of "Fri, 28 Feb 2025 14:42:43 -0800")
References: <CAJoAoZnk88ZFZFdEtUxMnUa1OZiXYOgcw8DSbB+A0LzyCPFugg@mail.gmail.com>
Date: Fri, 28 Feb 2025 15:21:33 -0800
Message-ID: <xmqqcyf11wqq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Emily Shaffer <nasamuffin@google.com> writes:

> Thoughts? Alternate suggestions? I'd also be happy to host a list with
> some other service, but I don't have any personal experience on which
> services are good to use or not.

I am perfectly fine to close the unusable list, and suggest folks to
redirect to discord or other services.  If the discord channel is
already found to be useful by those new folks who have been helped
there, that would be excellent, and then the question would become

 - what other avenues to ask for help, other than this list, are
   there that community members are willing to support by visiting
   there frequently and help out?  can we compile a list?  I am
   perfectly fine we start with a list with one entry in it.

 - where do we want to advertise such a list?
   Documentation/Contributing?  todo:MaintNotes (aka "A note from
   the Maintainer")?

 - how would we maintain such a list to keep it up-to-date?

