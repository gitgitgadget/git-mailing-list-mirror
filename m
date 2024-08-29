Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E57181328
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 08:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724920905; cv=none; b=NHxXyLxuxbrGqsvJcvI+lHJnClGaAo7HN2hj/lxQcnD/Z2W+n2Fi0aOLpcAUNaEPDzXDOxVuPHOgrJIEr/sI+EE2ChUjE/o2AnjQrdAIZimoePpXCdU3lBErgIZR9b4QbAW6EaI4BAx0rtTvxMbus+dVg2qWhNyBeRYtL1Qqd6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724920905; c=relaxed/simple;
	bh=P8ZhIhsIztFNTr6y1fkP5/RKmtM7mh8EY+LwhAPp5Kc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQG6z5QhHidKfpMhX3cCy1VUWjukKfauUxQ9kg8evo5mFIilleakjYgK+gj/4R2HjEHI9qIUkeNY9xicxhNlsUoWBJd+n9gcoosIgtTSXtIydztfQAdcuP+oKI4T8pHuepTmmWVfV39DH3dN9qpRYCp2X05usQcEtfR39unUaFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=me6hAuTP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NSoYOyD0; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="me6hAuTP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NSoYOyD0"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2A16D1151C3E;
	Thu, 29 Aug 2024 04:41:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 29 Aug 2024 04:41:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724920902; x=1725007302; bh=aaDGfmcikE
	ILHXh2/Gf/LA9Vl+nmnOEzHlSjxFihceA=; b=me6hAuTPyqY7c5sgl1IjJlWZIF
	SRC1bRoLp5CNzC8PpJwOt2dBob3PzaFgUKuj+aylu3Z2LW+C26FVOONScrPZ74R1
	1gxjnf2W/phBt7XQCgfmb46CrNvFd4U97WrOu6BKPBc5rZ1oMxydNO3OZGCV9mz9
	P2dF9LoHM4eBLTmX5JDzz/jpxhiwSKonJk+Gz2RFgtAwmaHsvve9prGGYDJsOSvs
	EDx0GBq/dajFJkNcZWEnZ6GjezPMgL1kiWGC6JonEmbZg3TWTp78P7FySr/kC/+s
	BWshHciyP+aS3qtXMzuENVBqtBlJMBUFPhcxTxz62Mdk4V0dpC7pP9OsmW3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724920902; x=1725007302; bh=aaDGfmcikEILHXh2/Gf/LA9Vl+nm
	nOEzHlSjxFihceA=; b=NSoYOyD0K/2Fgm8Do2j5968hz9WEvOL7ARedCO6Y+U50
	GpNvIOZG9YIoEA5gzITKYbCWKEQ+OKSdBUAIMMNASWGLd37I0DJlgrOIV7U/NZaN
	4aw+8Z0HNiYLswu1GehN6DCEIhZjQmVtCyzOKtqfN/0cy3yFezIevuZOxo1mUOx3
	gXEI9hAbCK1zYRPwJRjOSlF0SPwYMA5ZacSQUuu70n3GMEHe5s2eMpw2LjYM8Acc
	uQ3s6HGOrW3PAzCJqJKJB65pX7n7FfiAsSwwIrtHfZ4dYbINam+tLgLwDUmoQG8W
	+RIR9ntkQ1EW9qpZUsjXLimIUB2i3kMY7hva2n8Iqg==
X-ME-Sender: <xms:RTTQZgIzZYBFEZJTLmhLuWew70iRGtrb1yNP8ZiDAaL-3GHOGY7kAg>
    <xme:RTTQZgKguKAVw-IvDUnCsfO0SM6N1eog9GcJ2NjrbWu6On3C6D6iW2Pks5wPAEGzR
    SwDPF_G3HCoTQBKJw>
X-ME-Received: <xmr:RTTQZgtFloPrEOHz-SAPq6V0LA8zM1TnyNEvEJkvHufcyuAI4m6CjWCQDkJfP98uDojGFyHCd7odbxe1QnDsHlXtj4SjRRQCR6S7t2L1ooYe63o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefgedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeehkeeffeeggedvgedvfeefheettddtffejuefflefggfeh
    feelffeljedvfeehieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegtrghlvhhinhifrghnsehgohhoghhlvgdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshht
    vggrughmohhnsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:RTTQZtazCn72T3EFKZxGa4WK-kZ5IOd_5iJ6Wp2ZQQJV4DzeEcoRLg>
    <xmx:RTTQZnaarOEzCNRFJ6RU1MVuL-KIU3In6Id8onVM4uE_Sfntzrjb-A>
    <xmx:RTTQZpBk8mIqPaT4zaIMGJvVafzA1JtG07BmO_Mqh53m91LxuR37WQ>
    <xmx:RTTQZtbC6-44k5sFwO3vJMG8I3VLNt7LJf3Yimy6cJXxiYN17TnpVA>
    <xmx:RjTQZjHMLCwti1OCNjtEW0qz5MSvmuABuFW3QGbaRbTyEwGULgoBD2Ai>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Aug 2024 04:41:40 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d149083d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Aug 2024 08:41:30 +0000 (UTC)
Date: Thu, 29 Aug 2024 10:41:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Josh Steadmon <steadmon@google.com>, Calvin Wan <calvinwan@google.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 15/22] negotiator/skipping: fix leaking commit entries
Message-ID: <ZtA0Oj0o3UXmSIDP@tanuki>
References: <920db3a2912c609d4ac1fca2fc6b137513c8eceb.1724656120.git.ps@pks.im>
 <20240828202902.4156688-1-calvinwan@google.com>
 <fazvh3gejzofti6ii4x2fkoh66hni6lcc6axc7w4tspte4lioy@hgnvhue2pm26>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fazvh3gejzofti6ii4x2fkoh66hni6lcc6axc7w4tspte4lioy@hgnvhue2pm26>

On Wed, Aug 28, 2024 at 03:19:10PM -0700, Josh Steadmon wrote:
> On 2024.08.28 20:29, Calvin Wan wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> > > When releasing the skipping negotiator we free its priority queue, but
> > > not the contained entries. Fix this to plug a memory leak.
> > > 
> > > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > > ---
> > >  negotiator/skipping.c                | 7 +++++--
> > >  t/t5552-skipping-fetch-negotiator.sh | 2 ++
> > >  2 files changed, 7 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/negotiator/skipping.c b/negotiator/skipping.c
> > > index f65d47858b4..b738fe4faef 100644
> > > --- a/negotiator/skipping.c
> > > +++ b/negotiator/skipping.c
> > > @@ -247,8 +247,11 @@ static int ack(struct fetch_negotiator *n, struct commit *c)
> > >  
> > >  static void release(struct fetch_negotiator *n)
> > >  {
> > > -	clear_prio_queue(&((struct data *)n->data)->rev_list);
> > > -	FREE_AND_NULL(n->data);
> > > +	struct data *data = n->data;
> > > +	for (int i = 0; i < data->rev_list.nr; i++)
> > > +		free(data->rev_list.array[i].data);
> > > +	clear_prio_queue(&data->rev_list);
> > > +	FREE_AND_NULL(data);
> > >  }
> > >  
> > 
> > It seems unintuitive that clear_prio_queue() doesn't also free the data
> > underneath and that a caller would have to know to free that as well to
> > avoid leaking memory. Would it make more sense to add this change to
> > clear_prio_queue() instead? Patch 14 has that pattern already.
> 
> I'm assuming the reasoning is that clear_prio_queue() can't know if its
> items need more complicated cleanup of their own, so if the caller
> (potentially) needs to clean up items individually anyway, the caller
> can also free them at the same time?

Yeah, that's mostly the reason. We have e.g. `string_list_clear_func()`
that works around this issue by making the caller provide the cleanup
function, and we could use the same pattern here. But it seems as if
most of the callers of `clear_prio_queue()` don't need this because they
already drain the queue during normal operations anyway.

With patch 14 you probably refer to `clear_shallow_info()`? We're not
using a priority queue there, so it is not quite related to the prio
queue we have here. So I'm inclined to leave this as-is, and if we ever
see that we have more callsites that want to clean up the prio queue and
its contents we can introduce `prio_queue_clear_func()`. Does that work
for you?

> > Thanks again for the cleanups -- I'm tempted to take a stab at some of
> > the other memory leaks you mentioned during our biweekly hackathon. All
> > of the other patches look reasonable to me.

I'd certainly be happy to shed some of the load here. If you do, please
give me a quick ping so that we don't duplicate any work by accident.

> The series also looks good to me, thanks!
> 
> Reviewed-by: Josh Steadmon <steadmon@google.com>

Thanks!

Patrick
