Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FE43368BA
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 11:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775735296; cv=none; b=WtZ47CJlb2nle4by/zVt0Gjk4BYmyn+whqbl0/CgaIbEYNY8HxchqVKTwZntTgWIS8uq2RcIJThagV5RABfiuN7bi2We9Ps4131e3IErZlvzdDNKFk3CPTDM2mXYaC2CL2STca86In05OO8+AI1E0iYD+EOr8LnkmMQLrrgYUmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775735296; c=relaxed/simple;
	bh=R9h9/mCc5e3jog9+DOKGsGhyKVKpaZ4JUnxRm4bJetU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8/l9f97I/4cnmzZ5qpaLSPDR6hzSLsG5eNSGVMnyWVxGkf8ZyOBO5QPK3nUVTMOrV5SS1USkST55i0uuQyU0+/M7c6xLX+y/BMbhwTKMHPs/xNhIvrW6Oj+ds3p2iFt1ujs9jycFyXEX1/5M8DxQnetm1Xr37kmStPt3oTkfew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LopORrDN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=US82mOFI; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LopORrDN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="US82mOFI"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 45BC61400287;
	Thu,  9 Apr 2026 07:48:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 09 Apr 2026 07:48:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1775735294; x=1775821694; bh=mg6ez/Fc4w
	LmT7WmgXzlcXEHA9pWMJhEfnYIzHsa8Bs=; b=LopORrDNeogDjPq5i021G9OUYy
	HErRbwGIw3aFICTxPnzfoqEmeM5SprDdy4bNnwzT+9neWRXAp5SEwfbs4KTchsNs
	Wij04M+HEkK31vPqSFXaVpmtRwQ/nIjjHN3gNk1ZKDP1HV1VpE19PpiC2Y+uPP40
	ac0l2NHwNnTO5rYZkm9HN9nJ+3xNeOXxH9PwIDBeQStu6ZCUFmQrdxkKq7BOsjxz
	8dJ/oExubENwze1IB+0sgXqdhGaHx1C2qSC1Gc3lldFw7oSlb09/UHWuHJ0BKwxR
	RhC9pHNx9y7wauwocgArFgQ9MIgGzu99Z9DssLoP3RW9Kek8iRAMRImOHMMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775735294; x=1775821694; bh=mg6ez/Fc4wLmT7WmgXzlcXEHA9pWMJhEfnY
	IzHsa8Bs=; b=US82mOFI/fb84uQGmcHsUYN+5Hy8j/xRKWCGUvyZcX3de8A9IT6
	Tg9xKLa32PkUdpyQyb0cZr/8hikT6iqfrhH+CYUk7jvJF4egjBGD3Z54piODDL0n
	MDyuF48chVJsnTq4iMxLuvNojC4IDp8nISf5/6/ghFic4x0zJPYjECMkmijJfdBO
	e7EtYJkieWVAJ6CQSxMbEo2v7+3ESf0vET3GagqApF0rVhmdFwIGvRd8nFXMaZvf
	hX7M1x4iMLcXwuMgYS9fFWe89Wpvg27rqMBmOumbtObJ5bkEwueQVmL53GfmmcU6
	fv2cbiEIH6KbbNGmCtjOg/gV+XbAUusLZJQ==
X-ME-Sender: <xms:_pHXaTjtDCKtn5n6ng0___gVkQ3JywFU6dQckuxRSt9mUoYqcIGalw>
    <xme:_pHXaXARcL-MVijdoMvK1YKpIRxvwthDaEUYC18B5Fr4ZI5IU13Al6SdBjSM3zEmV
    I6vVAr2rAPy-Qvixp7jJZPfeE0CgHxIdXE9jiNc2QkRzRw7hZn_ITw>
X-ME-Received: <xmr:_pHXaYEajNNdYLLL04tZeuTSc55mozmn-so_CefZ3D5_DKW2e2x-rSR4WXc4oJVjTiLrF1_NaUt70xFcAiM4cbIcMRkcL8yQLDMYIauDXMY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvieegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:_pHXafI8gxiA5W51FAcQWpVB7ZZ_OSm4hbKfFqjBSLbZct38kYQzHw>
    <xmx:_pHXacmU-xD-W_iIaYK8qgzXtS2x8UIeSyEN7Zwq96we0GQx-dsLDg>
    <xmx:_pHXaXQ9rQggEdMCK-B2MVxfQYj__S5wFQ_rOdVNgSnBZGbt-yhYQw>
    <xmx:_pHXaeJ11B3445l5sIJ5a6N-Nuwyue4634zrPLvxwP7FiqFXDrs2GA>
    <xmx:_pHXafkLSH_91SfD8kFeXgh287fC1awfOXgSwHvIhVaeX3l4QhL8wE8L>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 07:48:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 813f19c3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Apr 2026 11:48:12 +0000 (UTC)
Date: Thu, 9 Apr 2026 13:48:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 00/17] odb: introduce "in-memory" source
Message-ID: <adeR-VSCkH8BrFGE@pks.im>
References: <20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im>
 <20260409-b4-pks-odb-source-inmemory-v2-0-f02b4f1c0f13@pks.im>
 <CAOLa=ZTOOTqNv7j-DFdC2cMje=5MBdNBkqp9PhgUC7dQFKLz3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZTOOTqNv7j-DFdC2cMje=5MBdNBkqp9PhgUC7dQFKLz3A@mail.gmail.com>

On Thu, Apr 09, 2026 at 07:44:17AM -0400, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Hi,
> >
> > this patch series introduces the second object database source type,
> > which is the "in-memory" source.
> >
> > This source may seem somewhat odd at first: it always starts out empty,
> > and any object written into it will only exist in memory until the
> > process exits. But the source already serves a purpose in our codebase,
> > where some commands, for example git-blame(1), write an in-memory
> > worktree commit.
> >
> > Furthermore, I think that going forward it can serve more purposes as we
> > now have an easy way to write and read objects that will not get
> > persisted. I could see that this may be useful when for example
> > re-merging diffs. But eventually, once we have the object storage format
> > extension wired up, callers might even want to manually set up an
> > in-memory database as the primary ODB for write operations so that no
> > data will be persisted in an arbitrary write.
> >
> > Last but not least, this patch series also serves the purpose of
> > eventually getting rid of the `struct object_info::whence` member.
> > Instead, we'll simply yield the ODB source a specific object has been
> > read from, together with some backend-specific data, which gives
> > strictly more information compared to the status quo.
> >
> > The series is based onb15384c06f (A bit more post -rc1, 2026-04-08)
> > with jt/odb-transaction-write at ddf6aee9c6 (odb/transaction: make
> > `write_object_stream()` pluggable, 2026-04-02) merged into it.
> >
> 
> Was a nice read, only a few comments from me. Should be good with a
> re-roll!

Thanks! Will send the new version tomorrow to wait for some more
feedback.

Patrick
