Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6962C339B4E
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 05:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768888155; cv=none; b=Zbw1L78xlGBSGfLZUk9OvagXo2qMezTiA1uSfL8Iz8UMAxW8vrFN3Nbe+K0wn94E/MsnWZLqT0Bs/pP6VKuED7h0m1FQtn8EnHPllVONPPuo7Rf5EL14pnfVqnZNr0JdmUDzIMG/pP+STLlS+HMM8wLNXcd8u2gNf0Q2kcPBGbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768888155; c=relaxed/simple;
	bh=KJmHdBKrmpMS5F8S2rjnmaD/UoPTETiJoJhWX89XIyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HuqB2IVPXpEJr4Ype59tYyNpkEL0sQGiq1UXxXhTHxZuYXZlKPog97a4pp8S0BJ3QCEBxBNjApAWoapV5u/kokVzKO8gQsJBq6N2mfGZy7GI3iJSHxTINLqAfuwYqBOH1o3R0uwvuM8PJDfHSGpBpOR/kSsjZnFdBcDooIOG+us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iqGK1JAq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bom+wmIU; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iqGK1JAq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bom+wmIU"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7064D7A0560;
	Tue, 20 Jan 2026 00:49:12 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 20 Jan 2026 00:49:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768888152; x=1768974552; bh=wcjF3ertgt
	DqC9o5PtKLaVsz//qSrO7O1iKNXMB3Z9M=; b=iqGK1JAq05vdwGTXWrBkTGU+Ix
	J8AN+vjNCVOBmq8qtQGPcYrfjNBPC8+L2wFvW6G207xGFbiBYbElb3KlbCWxIeP+
	Qj0GJGq+Rens09dKvmJVKujILEDsyAiGLOvQ/iXb/b1tDglUoa3cOLrP9DY1Rp1p
	31+//JlW/wUG9avNhNwFIbCIskTJwMYO87fp8aQ3R8omTbg6PrmUkUiAiBXaRwlA
	wRuybxX8k2IeQq2Vo0poMe1ZpGM+RUrHK0W8+HRA9Wo/Q5imKMakklCdsa2uzXE8
	s2DIrcq+6xFyq3RBS4vNZBHxit2MgjgF63UPTwpNRSwhJGqUGeoaJN1fPzbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768888152; x=1768974552; bh=wcjF3ertgtDqC9o5PtKLaVsz//qSrO7O1iK
	NXMB3Z9M=; b=bom+wmIUCQBHrwkUYWvvind0m7mRpoEzO8deAA6bz+S1xk+LYHO
	OrHuot2/SCZBOofMiL7ciR2XNOqykIK+BBWbX5862wY9Bc9dZMaW3HXN5roqIJ0L
	t0TtPkuJiKwaMiwwv9Ggz9rncqqJ8bHMnyagfc9qfGV7kRn5QGorDvSGi0Yt6N7y
	16VQiapPsvvRl/9XTZU6YUnckwDw1gdaJRdvTL+zyBbSbC901TqvOxh9Gnw5UvXO
	+GCx7ROTZQt/gQfDhzFE4qCgdDTu3mIARUbA1wYjEwQ19zJG/00aWhnQi40mQ/HO
	7soALXheDlqTtwep3VCmXaxkzY4ygPfSvdA==
X-ME-Sender: <xms:VxdvaSpjpyPHymEVLXiyTJTQydA3D7FzCdMWhvfOJ7H6vgBQhtjPEQ>
    <xme:VxdvaecCNUFTydKL68u0RiUMv6SABsx2OsLetOeALZXGiXrglV9ZxKpFRvCm4vs30
    RI4GPHorPqkhFmh9iLF2Pket3HTVVzLvKWkvBN5DFCHqvkRP4crrA>
X-ME-Received: <xmr:VxdvaRr8YhCKjUymoCt6ueEx5fRWuv7AQIDNa88T_qQnaz9to6nJ__gWhM_XfHyW7hP2hukcuju_gBRnn0pp1JNOQECh6NZ9E7L_auO28Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeeliedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjeevudeggfffffeigeethffgieekveeffeehvedvgeeiteegueejleeihfeitdeunecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjh
    honhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:VxdvafEAMyusVZa5XT3h6PGgWO7wWKwM_O9CpSP81b1auy94QgW5iA>
    <xmx:VxdvaRsAp5v7mfaZrkOA70mHhmd-kobf86ulK8aD3FWltT-UVHaShg>
    <xmx:VxdvaRU0RO6ZAof3Miw_TcRFi2S7otumkP6b_CZ7wkuR-81ZK582pg>
    <xmx:VxdvadGdQ5YHeQYuMOL4rCNWRp3uLmUVnnk9tZH6n4h020oLGC16Qw>
    <xmx:WBdvaY3Xa1_279-gOzudhuMunx58zYg-gCIuhmtligb16eImQfhZfHIN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 00:49:11 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 21d5429e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Jan 2026 05:49:10 +0000 (UTC)
Date: Tue, 20 Jan 2026 06:49:06 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] t0610-reftable-basics: mitigate a flaky test on
 cygwin
Message-ID: <aW8XUqlbiJgr8Eib@pks.im>
References: <f46e023b-1925-41b2-9842-42e7cb727056@ramsayjones.plus.com>
 <aW3UO3ff9aNc7HQz@pks.im>
 <f4599b1e-78df-44f3-a9b8-ed28411e169c@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4599b1e-78df-44f3-a9b8-ed28411e169c@ramsayjones.plus.com>

On Mon, Jan 19, 2026 at 05:10:46PM +0000, Ramsay Jones wrote:
> On 19/01/2026 6:50 am, Patrick Steinhardt wrote:
> > On Fri, Jan 16, 2026 at 08:39:56PM +0000, Ramsay Jones wrote:
> >> In order to fix this flaky test on cygwin, despite not knowing why it
> >> works, replace the shell redirection with the above 'test-tool truncate'
> >> invocation.
> >>
> >> Helped-by: Patrick Steinhardt <ps@pks.im>
> > 
> > Oh, so is this the exact case that we were talking about? If so, it
> > might make sense to link to the mail thread so that folks can also read
> > a bit into our discussion around this.
> 
> Indeed! I thought about referencing the email thread, but I decided that it
> didn't really offer any more supporting evidence than the commit message
> (in fact less - it doesn't mention the 'strace' scan).
> 
> I can add that (again [1]), if you think it's worth it, but I just re-read
> the email thread and I'm not convinced it offers much extra value. So, I would
> rather not re-roll, but I will if you think it worth it. Let me know.
> 
> [1] https://lore.kernel.org/git/f22c95ad-43c8-41de-8315-e707224e830b@ramsayjones.plus.com/

Fair enough, let's just keep it as-is. Thanks!

Patrick
