Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CC6A32
	for <git@vger.kernel.org>; Sat, 21 Dec 2024 10:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734777067; cv=none; b=D4Za28bPnp6MUZZ+CyaajYIsxLjfamJ8u8jLujm+6dWwqno7qogfvv+GCRSqb47w2ByvNdvIvwCS1iWPAo0Gkdm2xQ6VzbkFm7LRa4hQlxLQTRC1NlTvGZgTzisMN27uxDhlzA+KAIJjCXkjwlaTILWi4idOuvZv9zh1imedZ8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734777067; c=relaxed/simple;
	bh=RWTYghWIzNqHgWCXWfsfOh9B2DHk0WYr3BxzhS5SHxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2byPejd8p6Qg9L4Rp2mi6kbycwCnKVDl1GWuICOpgC8xXpdFqQdWizDUHL4bqTQvniH2I3fcPWI5j00HkEi5eQ0Yklud56MvMza5P1+bGZ1P3A80IMwJuTy53nD2ZG7GidSW0F7k5GAIC/fqAqetZkDzB67KBBtVYR2IA+r/pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ac2ulCFg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ctQEJfCK; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ac2ulCFg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ctQEJfCK"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DF6B411401B8;
	Sat, 21 Dec 2024 05:30:59 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Sat, 21 Dec 2024 05:30:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1734777059; x=1734863459; bh=wi6y7rX4Se
	eMDBRQDR59GkCRsIQfBgj9iCf6F3xHRKM=; b=Ac2ulCFg7LihNYMegHOFyL4kkW
	3Qkf/fdBSWRfjYFiMKS/bvWBk6adKrcgNSinGU2g+iUqxK+XFNNrbGhMiImScJa1
	ncB/LR5HFFydD6xc8KFXFvQYFtb45Ndje7jxfSf7iz8OEYlHR8c1v8hGHB8CacPp
	+Ng2Cbwq1pGNBy0YGoRciS36ScMHf1nY+YyJlQpIHbVwBIpGPi2OvPiY8jbndIFg
	Tdf68a+HQPsMXwtVKhWo8GS7sFb29wrmsypPasjBQP0kcWjJdkLjtqr65HJnFlVn
	Mrob5bPKtWmwICZpQTphP56ELHl5DtZebbbYUuIq4Z8LztO1mWIlv7pfk6qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1734777059; x=1734863459; bh=wi6y7rX4SeeMDBRQDR59GkCRsIQfBgj9iCf
	6F3xHRKM=; b=ctQEJfCKFtexYbBBELvCM6Wd5gUGmjqddApLLVjSkjxbzTfDMPM
	ej7yuh8kiQ/Hr4mZZcFgzJL544wlYzu04GryEBpxB8UDNvic25o0GzcylTf0S25H
	uWF2zo9Gys+EgVmAw+74Xf2peG/cnuuBkiLGjth5gHgXie6kr3/ld21CG/8fue/T
	pHQ11F7DOg4ESFeNAhIO4PbtAd+YwamvK4hxRSUT5M6QpcPeoqQxOMjK8eebsl5D
	jCo0h7EhYnoZp9V9/3br76de07x/LZZLRZ7ILzdfccK6mNXG1cBmNtPijhe5Uruz
	qGCs3VvZhyRBorRInfWDbN5iOYgX1Y4avtA==
X-ME-Sender: <xms:45hmZytgHqvawurb25rMydUYu2t486ArFF0ztG7QS4plSXnDPiHDKQ>
    <xme:45hmZ3ew719RS3Q-pgbUe49_r-HFjPCOPjFqwy7ycfFT_h2g4zFyMmQi0ZkOCLPjm
    r167PfdtSEpnFO1tg>
X-ME-Received: <xmr:45hmZ9xkrQik5O_D4NDLSamldVaOi6BExHeuwUr8SOoJWqRzswPmyUdQnBDBcbjiNXZDmaduroOej8c2E8VmGnRMUpKjrq_nlwesYRmQQ2TMYPCpJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtgedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepshhpvggtthhrrghlsehgohhoghhlvgdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:45hmZ9MFJYKl9oKaP8UcfCwm9i4bqGlIF65-zFHzyau9ZybzkAjazw>
    <xmx:45hmZy_RxkEr11Jm7wNwkZhRPiMZP9mYz2auKwbw4Jy9E8au4uLZaQ>
    <xmx:45hmZ1Xn0btMGPgGWHhvaHDkuuv7rs6q8R9xLsbXhHnP2jKGQunIog>
    <xmx:45hmZ7duL_mQosipjosHRolEcHUxMOwq5s3nTLBcmRfH6GJQWcj5uw>
    <xmx:45hmZ2Z9RZP4R_SAWDe9w_BsA9K2lSCfDDmFngjUTR9X160-Xig3gOwC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Dec 2024 05:30:58 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9773ba7f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 21 Dec 2024 10:29:01 +0000 (UTC)
Date: Sat, 21 Dec 2024 11:30:39 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Kyle Lippincott <spectral@google.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 4/6] GIT-VERSION-GEN: fix overriding GIT_VERSION
Message-ID: <Z2aYx608clVG_sAF@pks.im>
References: <20241220-b4-pks-git-version-via-environment-v3-0-1fd79b52a5fb@pks.im>
 <20241220-b4-pks-git-version-via-environment-v3-4-1fd79b52a5fb@pks.im>
 <xmqq4j2ydnxa.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4j2ydnxa.fsf@gitster.g>

On Fri, Dec 20, 2024 at 01:50:25PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > diff --git a/Documentation/Makefile b/Documentation/Makefile
> > index ff30ab6c4295525757f6a150ec4ff0c72487f440..a89823e1d1ee5042367bdcca6ed426196d49ce89 100644
> > --- a/Documentation/Makefile
> > +++ b/Documentation/Makefile
> > @@ -181,6 +181,10 @@ endif
> >  -include ../config.mak.autogen
> >  -include ../config.mak
> >  
> > +# Set GIT_VERSION_OVERRIDE such that version_gen knows to substitute
> > +# GIT_VERSION in case it was set by the user.
> > +GIT_VERSION_OVERRIDE := $(GIT_VERSION)
> > +
> >  ifndef NO_MAN_BOLD_LITERAL
> >  XMLTO_EXTRA += -m manpage-bold-literal.xsl
> >  endif
> 
> So the idea is that those targets and scripts may have their own
> GIT_VERION value when they run GIT-VERSION-GEN to cause GIT_VERSION
> to computed, and in such a case, they should pass the GIT_VERSION
> they have in GIT_VERSION_OVERRIDE, and thanks to the version_gen
> thing, this value in GIT_VERSION_OVERRIDE is passed in the
> environment as GIT_VERSION when GIT-VERSION-GEN is run, and the
> value in turn is passed intact.  Somehow this makes my head spin, as
> it looks quite convoluted, but the overall flow should yield the
> desired value.

Agreed, it makes mine spin, as well. Next release cycle I'll have a look
at whether I can get rid of the include of "GIT-VERSION-FILE" altogether
to make the logic simpler.

Patrick
