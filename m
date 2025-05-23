Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D553D225792
	for <git@vger.kernel.org>; Fri, 23 May 2025 09:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747993218; cv=none; b=tGmdXCXgmhjxwrhtf4xvZKazhSofIbeIbw49aWJfrZdbbGfVQ8SoyfejaynGn3PfaL7QmhBkAXbO3L0eOh0tv1sNWwKaiGUy9ugDlPiVY7ibUbtrsd6MUtwxjau7s+DiVEbx5/2qgOwcqDeOB+4QLaWsvJ/CG6aM9pZqIRRlyRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747993218; c=relaxed/simple;
	bh=YuiCDm8fqrV8rDsOhXRgGpFEXaMhxGbpTrrAUV70+w8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2Fws030zd1HZ4aQeAn6BYx+WaJP8Ogb4WWQoRegUwmFD/kv19pZUrhiczjv26o/e1cO/0qHcYDYaKz1NIVE4tqkvrvbj8C+3DbL+BLqVQYmKaq3qQQuWrAEV/nWOGP1mDTz6xU5qF4+8pwYIsrmaD8RK1N5zos/nTv7bbZIFgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vWU9FCFL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f8qQbXZB; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vWU9FCFL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f8qQbXZB"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 790482540118;
	Fri, 23 May 2025 05:40:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 23 May 2025 05:40:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747993214; x=1748079614; bh=noSnz00ioc
	zSKthYpfI8FJN3uuIR17YGI1t28eYrlFY=; b=vWU9FCFLIhcM6MaXejtVuKVBam
	8aAcS0O93N8qwZhoDhJzeB8ot2rbi4U3HhuOyzb2a75cwkVTWlNwjOqBdY7YDLam
	FttWPB7h2s/Xwz1+8wV4DAMfLnHoGogBov4Qa8b1npKIX+bRE0Dr8En/VyyfFGIQ
	vj0N5UdYhEm5KYbeShGzcLWspPzZeVwow3Ifzk9T2mqnQd/sr89+xaWIg9ajYldv
	4La8NJkL+CPYNo+HdREsNCD71HM7QZbMqbLb2gxr+ZSsup1OykHUTe/gqM5fiGJP
	DlNUEIC3ha0yTTvS7NCwL+BFtEIy/6iTYyzc8ETk6eYKIAZRPqsPTxg4sSRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747993214; x=1748079614; bh=noSnz00ioczSKthYpfI8FJN3uuIR17YGI1t
	28eYrlFY=; b=f8qQbXZBxoUVq0GcBMTrv1CIovaKRI0U+7ByDd2MFGdgjxRigjr
	099uoQwbtUgCiqLIN5Nlc7rrIivbu+QNKhbQ0Y52BILjd1c2tDwGL0sGqQN7HDs2
	UsvmcJzdf+XTIVqJpmL6H8S2kccJXCaI/JgzDKKi+f8YFcKsxsa4lgKnJ1IxNGuL
	vNyBAujNbrrFemlQbnH1DFIbn/oMtpCOLhU0LkHOeA9mShtOa1C8V3rZTQI16kK2
	0bx8LxucOAU4+JnvROXMr6ti9IS2dnXPjsZZuqc4PJ8ewPZpfJiuWHAtngZ9dctV
	jifuqz9260AkKIhKzmoHFywbv11TXtNB8Aw==
X-ME-Sender: <xms:fUIwaISuksiou2v9P7n1NudLgWDakzJspe5qPEeUZAICgRL7vbHRiA>
    <xme:fUIwaFwC5dAWj2lepFSzKjXWXwMLvruFKVdXh2L1jbhPOzZJvM9d8o8T9RTbfINkm
    IC_ZFrsxYm6x7xJdA>
X-ME-Received: <xmr:fUIwaF0B0Z1eqM4I5UqM2N_E5DT-y_JdDDhFN7vq12D6iPNAYEnkKAyXolhyxTq285NwIY9aZaLNrzKuh2KtEwGKSbiCwf4qYMeAHJLXUYRm-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdekhedvucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefr
    rghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrg
    htthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfej
    vdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepph
    gvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:fkIwaMCO1iWoGsV6Lmd-GsYONBIlBuWVp0vLFpaPVSvFcRh0kmPUiw>
    <xmx:fkIwaBgM3zX7lspgtctW2fYUTcBvfVnOwZxDCIYrANXvisJ0ogAm-Q>
    <xmx:fkIwaIpS3Ms0LFbUqFPMJerrWI44f6PldKZSAiB7ZpRYsfOWNlLhXQ>
    <xmx:fkIwaEiyzPRECXnGmAj_hXEo0J4M9V5W2LaKFA4LmejCxR4w2X6R5A>
    <xmx:fkIwaEZQscyKIl3ekEKAiNzWqRjwlVvi6r2Wsu_U_Riz5gEPDy3Boij2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 May 2025 05:40:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7b32f252 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 23 May 2025 09:40:11 +0000 (UTC)
Date: Fri, 23 May 2025 11:40:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, shejialuo <shejialuo@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH v5 0/3] align the behavior when opening "packed-refs"
Message-ID: <aDBCdoNPkTq0xzOP@pks.im>
References: <aCMnrwkoJ2WyqGZT@ArchLinux>
 <aCS7O8tNekg_u9Wp@ArchLinux>
 <xmqq7c2aapte.fsf@gitster.g>
 <20250522055006.GA1135327@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522055006.GA1135327@coredump.intra.peff.net>

On Thu, May 22, 2025 at 01:50:06AM -0400, Jeff King wrote:
> On Wed, May 21, 2025 at 09:31:09AM -0700, Junio C Hamano wrote:
> 
> > > Change in v5:
> > >
> > > 1. Improve the commit message in the first patch to be more clear:
> > >     1. Talk about the current behavior, what error we would report if
> > >        "packed-refs" is empty.
> > >     2. To align with the runtime behavior, we should skip checking the
> > >        content of "packed-refs".
> > >     3. Why do we need to report to the user when the "packed-refs" is
> > >        empty
> > > 2. Fix grammar issue in the last patch.
> > 
> > The thread has gone quiet on this topic.  Is everybody happy with
> > this version?
> 
> Yep, it looks good to me. Thanks.

Didn't have anything else to add, either. Thanks!

Patrick
