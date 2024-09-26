Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11BD53368
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 13:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727358845; cv=none; b=iCh7MV/LK4DzQhk5PlfqPn2eL2L4M3cqXQVD2xqK8JJMaFAb75nNfO1nLyczuiBRU2KfRt8f1uhtbmB4s77pPUR7KjZwDNTWHdzXeinvZ1wC/P8aDXNYkw/Z9nGCoWo6aXzzJBhzXSFwvsdKxlp6NEONp4ImA5zdtblha4AmM1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727358845; c=relaxed/simple;
	bh=9ZcDSZ+Wy+xNn7LOS9BUvXIXuiS46uw+6dycY0Jdy2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pkdok2XuC7kA9/ecTb8UOPUDzlsATujLVRgO5+KyUvJlYe69imXvYX/rvP2n5nICfWoxYxr6pWFqyCcwpFS7cK5YID3OoqYCCoP5Qy5d7M4TREtMs+NRoEbBDL8Oi7B85DgRCXOs3gn1SGEKsc1VpzQHeahduj9PwUNtyR0BUAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UJOfzF17; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M6pdFN3z; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UJOfzF17";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M6pdFN3z"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CDF5B11400B4;
	Thu, 26 Sep 2024 09:54:02 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 26 Sep 2024 09:54:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727358842; x=1727445242; bh=Ah4Z+TosU4
	3N6lxCu522IRlDXOEylQqw5TGqJs52XKQ=; b=UJOfzF17iHaKom/cekHiWSHpMe
	jwvFSZasQaRHhZ0o/QJbVTOc5qTaQhhNNx48o7MkcdKi+va/DEJwl/RlgrvLQCRb
	VRgYd5f1zEf0jJlI43ULiV1uQC+ZDe8fzKgqbmM1lvr0tD3JibjSSHmKKSNHe7xI
	4vaf8e8AuMllGnvkIP2yyoJwoy/fC+MZhUepd+IDGkF5c6sUPhDKgIHBJP030lvE
	cRfGnKEp3m49SyUbuKL4i7tKr68ZRD/4BRGLlxJPuBXuBm3IhB7U3MgXVEZbVRkW
	nY+Z9gRD+vT6Twu1jof6RQvrQYBjiwBHzfYSPtps+gnwyJ8q1HKHUTGo0L0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727358842; x=1727445242; bh=Ah4Z+TosU43N6lxCu522IRlDXOEy
	lQqw5TGqJs52XKQ=; b=M6pdFN3zMzaHrjat0hlq4d4PxgEqmQEbZuq9x5onG61o
	PYP9p0+ZTdYFa74TvaavVqX+1JST92KbB2O0e5L4CdWG5cpJQ+TguvMCTTIOREFG
	a8wjFnuHxc7Yfme26Fj7zU/Acs+/zYGyBFvHFonAl0xGYDMlifE8/Q046cgvEmiw
	q03ApBs1r9my7JTpPef+CypphaOOuIW5NlIhcOe0otplnZukmW/ryWfbipjaQToG
	JmcSH73DDQ3/trK+WKFoyzsuKHGyDt126OvKlQyTFuv+IEk2rviYsFFPdqujifu9
	2GuZY+q2iWPZPtJRqX6+bCyyJHj3Uc5mOBCWUrapng==
X-ME-Sender: <xms:emf1ZtnxZqkI0TF1cavw9XIOF8XKxinXnvl-x5hWrnFIazIyMFqljA>
    <xme:emf1Zo0LIAhk3k52CNSi1inDRyTrz6aydAm9DES3kHJGXA80fHoeTziZ9T5u6M6h_
    11WuecVFj-2lMFcyg>
X-ME-Received: <xmr:emf1ZjrxYSPf7sxYDlgEJlM1VzdeESfGdaYwil4b6ornQ9p_H62BKMbqSnIyQnoOCGHIz97uyioIXmmvaJ4qCGMq_T_TRG-96bWOYEQYA3IPmw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepudevgeehheehleevvedvheekkeehteekledtgeeiveel
    geeifeegfffhheekvddvnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpghhithdqsh
    gtmhdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepshhprhgrihhnthhssehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepkhgrrghrthhitgdrshhivhgrrhgrrghmsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epjheitheskhgusghgrdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtoh
    epvhguhigvsehgihhthhhusgdrtghomhdprhgtphhtthhopehtmhiisehpohgsohigrdgt
    ohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidrug
    gvpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhm
X-ME-Proxy: <xmx:emf1Ztk9yQHVaqWdCV0bX-x7vRW0NsvFAYINAAfP5negHuZ780Rbfg>
    <xmx:emf1Zr0PkP6N8bKRFJsJ61RsNpAgiQGsuPE5JpL4M18iRteJPZy4Dg>
    <xmx:emf1ZssdnbqUEoPWn0Ann-EGEApSDPQqyV6D8sP9YwNc9msV2Iwfxw>
    <xmx:emf1ZvWia5GTShDxwCmcPgqrSSmrKYfbtEcxqA7taJ6fmnirhr0QZA>
    <xmx:emf1ZksLvlQ_m_O0z52YkwV9P2AbiIQTl5aiGqSowCYGuutu3Zk2A3Ho>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 09:54:00 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b683e0e8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Sep 2024 13:53:21 +0000 (UTC)
Date: Thu, 26 Sep 2024 15:53:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org, Matt Burke <spraints@gmail.com>,
	Victoria Dye <vdye@github.com>,
	Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
	Todd Zullinger <tmz@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Toon Claes <toon@iotcl.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: git-scm.com is now a static website
Message-ID: <ZvVncnF8A-zZLJ-q@pks.im>
References: <c3e372f6-3035-9e6b-f464-f1feceacaa4b@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3e372f6-3035-9e6b-f464-f1feceacaa4b@gmx.de>

On Wed, Sep 25, 2024 at 12:07:05AM +0200, Johannes Schindelin wrote:
> Hi all,
> 
> almost 400 weeks after Matt Burke started the process with
> https://github.com/spraints/git-scm.com/commit/60af4ed3bc60 of migrating
> Git's home page away from being a Rails app to being a static website that
> is hosted on GitHub pages instead, today marks the day when Git's home
> page at https://git-scm.com/ has finally moved. Or actually: yesterday
> (because I took so long writing this email that I ended up sending it
> after midnight).
> 
> This was truly a team effort, and I would like to celebrate everyone who
> contributed:

Thanks to all of you, and you specifically, Johannes! The new website
certainly feels pleasingly fast. And other than that I wouldn't really
be able to tell that anything changed -- awesome job!

Patrick
