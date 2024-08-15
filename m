Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2842EAE5
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 05:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723699854; cv=none; b=Mz9RYDJHQseqa7bbfVcdQn/bM+gKFTdB7RmDZZVGzM+nZE0zRVDjuXoV2v4q7jTI+P0QCULdijZeJwbKC9Q8O3cb09zhJn0edYryVtEVfiDoymMcfqdepPtnUlHr+LG5rrBuiI/GWlOPBMPgR49eNRS52nPqK39MSjoEwNZRCe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723699854; c=relaxed/simple;
	bh=yHvNofUdkoADsuJpaLUpl3dVAR2+ygj2ktdvll/q3r8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/njYcX9QO5aGxHe4qmhPqhZcWkPOmNVemfatl494eQAd5XGjFIgkSEqi0taHZNGr9ODnO6jVRM5mDG7NITY6ETfdTjOpa7KWBSPNz13MY3NleXZJ9k2wOyvgsO3YWz0wNxYQHkXXhHRFVsGvVvFNiI5MsMBeVgdJ1+gRKgUlSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=p5qZB2Hw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J/h1Pirv; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="p5qZB2Hw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J/h1Pirv"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 42FA71151C5E;
	Thu, 15 Aug 2024 01:30:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 15 Aug 2024 01:30:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723699852; x=1723786252; bh=J5qbDXyBx9
	/JMcC1WXF+zCvBcTcbZl1XjT4F0Kkp1T8=; b=p5qZB2Hwbapf48vFCz3TTzvdp0
	x8MUeOF5l5QlWRjHulwaMXr9Q6cLNcV0ihTaeSyik6KVGL+tST/vgOTBujRoKG8A
	Vj4q9Xmp41YElteorHcJLc3AQr0qUGtDPZzKW21xZ1whJBEwe0sYIZS3yBylCjaM
	WMM0rbsPZVUHz7RW2pmHSGr2FexEscAnkfjmewz+uSfsJCGSx5PKFsFHaEvMZCAi
	iFcOYgkg+CbW9kpSK3V0p8L8QGsdsiHTf1ZtovbzGqD2lArd83kZxZGdEnUzu9Ca
	acndP4J0TyPvMdW3cL2mJEU2pCU8O1eSAQpaB/OQoZdT3670p5kFi7N47QEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723699852; x=1723786252; bh=J5qbDXyBx9/JMcC1WXF+zCvBcTcb
	Zl1XjT4F0Kkp1T8=; b=J/h1Pirvk7/NqjAvV8RO4D0cqwqQT80rWtmrMHpkqD+0
	9RbN4yowfUPJ79nU6LJgIIfsL5zlMDzobcyMIWiwyK0D2qZVOoXUCPXMVly0FGwQ
	otBILVXtWlixMeUnGuNZ7Ou4qnAgrKGH0M3OPGxadLrkjMVFEod/QqmVztSlcSJv
	UZG4iGyXny4lIjHZlRsvgAKUDUT78vjgpwngU6gRDQ0aRAxUb/82o+Fq8L9pYbzT
	cNYOhUKVu6IPN+OmMIh0TLG43Xm0uSBTdsM72ENH0rAmS+MvVD24iWscp/+fOymj
	sKhas2PywS+fx9+UB9q941KFHcpTlqSCSNLuA1JiSg==
X-ME-Sender: <xms:i5K9ZsD7mpH4A3emX_mHCsE2YkJRioHQe4VUtMIIZTbx42us8bccCA>
    <xme:i5K9ZujMIRrep3ecA7lA7psOXAaZZPYyo51DutbtnC8VqJzBM5STeLAGsoy3BQRHg
    QfFRWdO_BRu3iaazw>
X-ME-Received: <xmr:i5K9ZvkGvYsfx4xu7uwnUP8wOZMOQ_uWPwLu8dyqdO_lnASsR2EqOLHWG8xgVkKn_4jFoB6DQk56v6u2WrXDi9ahjNd6isSDIs7No_-lUl1pnw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddthedgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguse
    guuhhnvghlmhdrohhrghdruhhk
X-ME-Proxy: <xmx:i5K9ZiwaL_Qi4EO1-imVsspxc1FCNA9Q1IQuOjdonSZTTax3P4gQAA>
    <xmx:i5K9ZhRxZc4C7k0277uafDN81vQe98C-9vBk3cIO0OFDoQDnUIKHeQ>
    <xmx:i5K9Zta5Hxy9QMAuyV8-_l04omE7MqTJkF9M8kXis7nbckNi-GHaMw>
    <xmx:i5K9ZqT1XdJsSqd30sEf2FLoChCp-QZDDR2nLB3nJ_thT84G3dAxKA>
    <xmx:jJK9ZscM_hzXRNZOgei-HpQTf8ejPlO_vwDMIecXtNwddvUFaGxhtYDz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Aug 2024 01:30:50 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 00d548ba (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Aug 2024 05:30:30 +0000 (UTC)
Date: Thu, 15 Aug 2024 07:30:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org
Subject: Re: [PATCH 7/7] builtin/maintenance: fix auto-detach with
 non-standard tasks
Message-ID: <Zr2SiGOuPcBWS9Fh@tanuki>
References: <cover.1723533091.git.ps@pks.im>
 <8d6cbae951177718b49d5cfbbeca2d5b0073e266.1723533091.git.ps@pks.im>
 <779795d2-eefd-4fac-b29f-9943f98bc83b@gmail.com>
 <ZrtKoVFci6cdvMS_@tanuki>
 <a02e21f1-b2a4-499a-b767-3426876d31be@gmail.com>
 <ZrwvWIhjZuFkRNgl@tanuki>
 <a3e9a4f9-baef-4c11-9f38-f30ff333e87a@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3e9a4f9-baef-4c11-9f38-f30ff333e87a@gmail.com>

On Wed, Aug 14, 2024 at 04:13:05PM +0100, Phillip Wood wrote:
> On 14/08/2024 05:15, Patrick Steinhardt wrote:
> > On Tue, Aug 13, 2024 at 02:19:20PM +0100, Phillip Wood wrote:
> > > On 13/08/2024 12:59, Patrick Steinhardt wrote:
> > > 
> > > Oh, I  misunderstood what this patch is changing. So despite being tagged
> > > builtin/maintenance and talking about "git maintenance" it does not actually
> > > touch builtin/maintenance.c or change its behavior. What it is actually
> > > doing is changing how other git commands run "git maintenance --auto" so
> > > that it is always run in the background unless the user configures
> > > maintenance.autoDetach=false. That sounds like a good change.
> > > 
> > > Thanks for clarifying
> 
> Sorry my message sounds grumpier than I intended.

No worries, I didn't receive it as grumpy.

> > Yes. I should've probably prefixed this with "run-command:", not with
> > "builtin/maintenance".
> 
> That's a good idea, I think the important thing we want to convey is that
> we're changing the way we run "git maintenance --auto", not the behavior of
> "git maintenance" itself.

I'll have a look in case I need to reroll this series.

Patrick
