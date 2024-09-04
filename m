Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD08148314
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 07:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725434067; cv=none; b=pFW0o52S2Ytadoe4vUsBedRBiCDg45GFgD2fDkBG8X8C+KK7PUtYRQHaqg8XneJqO5QLAigsufFS4QgbAK9Em4edak1s0MXQ4L6+EB/flob8IbZggtGXTF5JXXhEEpDqwQ8Xxc79kiLHQrZjs1lPovhDppmQOCD9NDIv+9nIGfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725434067; c=relaxed/simple;
	bh=IrtL0MxWAQYBgTzDV0vfJl1WzxUJoKFFQoOFthhK/is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNyVZmv9p2OyPO1OgpLoJjo5RXw5NBp1LANqkLWZ5A9a2lQa777ma2sJO1LSDIg6sEQp1yKYHL9UeghkUQ7/YYWPHkBhAYwJI1i+NTAtgAzeDyAVcY43GFecGU5QJrGyrkFLQDrhKTk1gqGdP+X2RtJoBOBUCnGjjZc2YnBdgMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nK/O0D6J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F+3EcsQo; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nK/O0D6J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F+3EcsQo"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 5B0E813802AB;
	Wed,  4 Sep 2024 03:14:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 04 Sep 2024 03:14:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725434064; x=1725520464; bh=KWYTxCuJdx
	EJh6/XgDenWhzpvSj5nwz7vaEheEFcqtw=; b=nK/O0D6JOvUq5tB2rCaXSF70f2
	8oaBl7VezmmV2xFRWLeooxU4Pqn5blt208RIY2Xw/F8pOHxvu9tHZjrQTEnVlMdc
	yfOY2DKRJLjj73JquFrvRaqIbtCk5HVlkuQxdh2yMvy/mT5qqIcgFQorzMvrHEb9
	lpRq9wEvtZWx26bWZ+C1VfHV1kYc7/t8BJde+RjYAQI9VZ1msiI1h+HjCVY2B2ui
	cZXEIny9rbWW1suDpC51HtXXjx5JFbthEAJIQuqm9UHWezvexQqFvAb+ldziZ/3i
	AUl751lZJcUr774FhLJ4wbsZ9YEhcLDtHYuM4csZwcYZotyasBzWhRMJPzoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725434064; x=1725520464; bh=KWYTxCuJdxEJh6/XgDenWhzpvSj5
	nwz7vaEheEFcqtw=; b=F+3EcsQoeJHxq7CTWA8r7cPHRpQQR1UGHtcIlIjC7jHK
	ZOstfAoYaETEtdK99qEFFeYbuATpxc4d2uZmDAWxXkYwyTy/fAQxCoXbAdSOQRta
	SIlftNN6UHMJlRWGaS9cxVpJ1HNBEfq4ZszMdtKjaZ6XtQ647TDwcmLSLxeL2KTy
	rkpE7dT+T1GaZUGdumxKMZY4xwZW6vtmRjP4Y9f1x9BZ+CqaR852i3r/iSYkt2TA
	ipGPQwQYlx+dnCu/+TzPPgT/Fw1SebfF+byaoX79bjiC1mO02tAH0iU4SrlX+7xa
	gz8X5GFUFCfGCSvLaghsTe+rggKdFQdvhGBS9eX6Ng==
X-ME-Sender: <xms:0AjYZpnO8rxKi6nEt2Gm2t7Hu1lX_6j0UUNxQnCc4MkpW_1aWZUZ2Q>
    <xme:0AjYZk2JAQS203v7eOE2yUqoZwL858H7ww8BafJ9qPMxDtLVT7TpR_kGPQhVu9J8r
    rjYRFizZc0JcQVF7Q>
X-ME-Received: <xmr:0AjYZvr7XmY_dtMqIJS3uiP7XpqCzhLNlQEr4oyAsO4vOVUdVZCqOhCD1jZCKR6bNTKuoTCRCvHqQ39KPhgEEqhtwAmU-15QR7XaP79n0PEb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehiedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdortddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeejtddtgeffkedujeejgeduhefghedtgfdtieduleeu
    lefgueetheeludegueeuveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheptggrlhhvihhnfigrnhesghhoohhglhgvrdgtohhmpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehjrghmvghssehjrghmvghslhhiuhdrihho
X-ME-Proxy: <xmx:0AjYZplRL0iSff7GUsvWemhQEOiKR8AlFVMn2g1w8wdjq7ZGL3odng>
    <xmx:0AjYZn34xGLQiQj00O7FBtPzYLSwh7J-goTqSj7tC5alSeO531D6Yw>
    <xmx:0AjYZou3QP8Mp5q_3pVz3hv0C41iAyriDhoPo2CqfFrAMWwUtf1y5w>
    <xmx:0AjYZrWZNgSKCzCXc2bPv_dUYKilhMd9fCPN6W_yZnaI4ibMI8sLgw>
    <xmx:0AjYZn9fao7u2ah7MTLRC4EgT5k_IQpojv3PxJ6yEGA6I4u9FlQT8NmW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Sep 2024 03:14:23 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4ea73d16 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Sep 2024 07:14:14 +0000 (UTC)
Date: Wed, 4 Sep 2024 09:14:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: James Liu <james@jamesliu.io>
Cc: git@vger.kernel.org, Calvin Wan <calvinwan@google.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/21] environment: guard reliance on `the_repository`
Message-ID: <ZtgIzZlyOkgtXjnC@pks.im>
References: <cover.1724923648.git.ps@pks.im>
 <cover.1725008897.git.ps@pks.im>
 <D3X4X0B5P0WG.1WHNSQNIRDHYW@jamesliu.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D3X4X0B5P0WG.1WHNSQNIRDHYW@jamesliu.io>

On Wed, Sep 04, 2024 at 12:12:54PM +1000, James Liu wrote:
> On Fri Aug 30, 2024 at 7:08 PM AEST, Patrick Steinhardt wrote:
> > Hi,
> >
> > this is the second version of my patch series which guards functions and
> > variables in the environment subsystem that rely on `the_repository`
> > with the `USE_THE_REPOSITORY_VARIABLE` define.
> >
> > Changes compared to v1:
> >
> >   - Clean up now-unnecessary and add newly-necessary includes.
> >
> >   - Stop reordering includes in "setup.c".
> >
> >   - Fix missing `USE_THE_REPOSITORY_VARIABLE` defines in Win32 code.
> >
> > Thanks!
> >
> > Patrick
> 
> Thanks Patrick, this is a nice series of cleanups! I've left a few
> comments.
> 
> Apologies that I haven't been able to review these changes until now --
> I've had to take some time off in the past week.

No worries, thanks for your review!

Patrick
