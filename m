Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A253DC4B1
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 09:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786093836; cv=none; b=pQ8CowFUeW8MINk0iXfXtakMwwoVAmCEc0XUorFGZzuc5HmX39kC0N2L+QI2svBgSCwoj4d4LOTjSvJFRa6fW4laY7fQubJMHI3nIaOk2Px5m3ZfjqxfTo0MEt47QuIoewJ28XRnANy+NYR0JMddj3OaG4tA9/R/scROEaykndg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786093836; c=relaxed/simple;
	bh=BS1QtDzzJ81zV96O26yVOwjk/q2mnmYkRB67QxPxa4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhTtEJyzqRI+zLDvao2a9Tf3dhZQsKijW9QoycZ+o6mkzz2doSBF1VxNmSoD0fd7F29ExqFI4wM6chQqpOWxK1bqIwj+uB6vEwoUmmBIu3CyTMdmDJsX6fPABpXjoTQXDIZ2j1oKxbUr2rBkBUzOYiQfG59ydb0LTomtMzmHdsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hsdZdc2G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NCmVVWJh; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hsdZdc2G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NCmVVWJh"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1EACD14000F4;
	Fri,  7 Aug 2026 05:10:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 07 Aug 2026 05:10:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786093834; x=1786180234; bh=C7yGYEynBG
	LDfsLUMpAbkAH3dMnk6VGBFQDMufqovzs=; b=hsdZdc2GXZYtymik4leovjVf+p
	vHYg8br4NjV87wcvAF8jZtR2TaIivqkuJQk1GOALj5ADQDcpUmTWuGbS6ec5yqEx
	mTclUFRYds25AX0GXP5EkbRicFjZ4Z4vjKnKJmCgujHOq71DGrfF7gcCM+Of+46w
	yeJfzTb/9Yvne7uHzq20sbj0zQIWPPQO7DRrkl2e7ZdyMYLDwCPLoWM/A/hYgWBT
	xL13q9YHWwtL4fY6ehs+NS5m7fZsUF6xp80B1zyahFMzoxSsEfwn56WeWLchDUTY
	5gihY6ecIqFLA7fVPhM330etY8Cl2MTJOJ6RfuqhswpUtJ70eWVns00IoZQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786093834; x=1786180234; bh=C7yGYEynBGLDfsLUMpAbkAH3dMnk6VGBFQD
	Mufqovzs=; b=NCmVVWJhd4SKa+L6nV60ChgcPtqDvYLta9LcbOiviEYeKbMmSfQ
	9eePbuoZPMUJc+tfRb0D7BTSAUTJCElF6rvZD5Zr+LKvRrKUdITGfIjaFlERL6rj
	KM7kZKlwxHmJxrHEvZNGsWB2I7B/BZkrznz8HkNX/ScD9nq1vqHLx97mD6vEjpDM
	4oI8gQFtQ1BuuHiI7fMnXaoqacN14Bi5I7Uq8IG1cNmKJMOCwFy9UsR2GNgmylxB
	EukZ3qpr1IQtAnxEss8uSnXIb9SUQ60UezE0zBdOP+XV79VzU2I4byepJPzgx83k
	1IV4m7aBe715SpZf8ZaWS3sLdvzIAkOzdWQ==
X-ME-Sender: <xms:CaF1ajnoYQXmYR4JinLhDhulc_IyGw_xKA8vRr_Mh3RlQ9Ab2yLOdQ>
    <xme:CaF1at3WDSeDMYWOdmcjF3bVEP_i9pGTaQ_7zv_0Wzw3dg0UYrKB49P5OUpsdSjXk
    Uak_INDayfL1SdpN8GSHEkAHzUI4L5Zg60YCpeHwUtplfg99jX3Q1c>
X-ME-Received: <xmr:CaF1auoXlTdqb7mQwm-JrYS0nU8FXvglf7CkJbZ-qaYtRt5TykDrMTJFDotKJCHwiGiSISxZkjuiTLDNftcP2yJmAvwbmAC6zSy9MrF94xk_oQ>
X-ME-Proxy-Cause: dmFkZTEgYY+G5Q9KCBDGtpR0G8gtA2xXWypLvWtGeT2+VwRQFw48A8z1ilA5DYUcF7qwI9
    AE9zsbVGkmxTZlC8grL4e5l7FF4TfUbJm/LnhpU3t1AhvODOVM7dr3wbG6IgLN8lNaxIaM
    ufAvyUHe/G8z5x98WT1ViXPpu2nQPbaWzDETCBlJmHOOYUTk8emm8ug87QWI3woYM2O7FM
    A20D/Byit6Bw1EE/FHzM2Iovw3MMT/znhMT4aasMwt5wcUv2d95oC2l2V4+rTniLKkxNBW
    TmQlg/yRA9YguvIyUS5NgfBeik1gUPhOuQ6KS2h8GM86rrBaQDHz9vIr+HhRGvWs7FWhnN
    23byv2WVxx5+tLJOp6F8Lnn7ODbHO+FoQdvthoN+Sgpv60mWzgvpFgvz4oqEgHcGnHYkdV
    plqcY4krVaIBuuvxs8+ZmgjJ5pVLAxBQ2Jh96gqz9bkuCkdGL00YrZDT8xz8yKBAaxJ7mI
    rh5fTgvHZq3/XVIa0Do0V9Px7YNYZ1DzTryXureeSkwBRk5UM5dTuxyavR5qufkkg5DqAH
    xwr/M5lAfqSdDALfZmrRBTcIvJ8xGWhmIjS1iomICNjKzDc0YLsyzV13s4SEgMKD8/ondt
    fcLVbwbWHN0frHP1JaLZPJHlNPjfvnaTj0mkHUImjelJMhUpqZZMJxnbQgWw
X-ME-Proxy: <xmx:CaF1aqd4z24sgk0g82AovFTQt60dS_LLj81kNubz7UPi-bppv53_wQ>
    <xmx:CaF1atqe8U3aeBd-OqgfXWl7JUvZ_NoeInLuJxoRcZbVWLUYplEzaw>
    <xmx:CaF1arHMJhBH94qVq4OKCGkXtik40Ehr8mTrOS87e46x88flTd1IyQ>
    <xmx:CaF1attAg3XwkhqvY19QRmT7aBtdrz3liX6M8tV6BN_OuHgxzzyiug>
    <xmx:CqF1ago7MPSY-L1Akp4zs918Uhx-2l2OrZMZh9UYQht8ghvn2k9AU3cm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Aug 2026 05:10:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 464ed380 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Aug 2026 09:10:30 +0000 (UTC)
Date: Fri, 7 Aug 2026 11:10:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v5 0/6] odb: make creation of object database pluggable
Message-ID: <anWhA5zZK2eg1h47@pks.im>
References: <20260724-pks-odb-create-on-disk-v1-0-3b3d265d979b@pks.im>
 <20260807-pks-odb-create-on-disk-v5-0-399da0b0b140@pks.im>
 <87jyq24cxm.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jyq24cxm.fsf@emacs.iotcl.com>

On Fri, Aug 07, 2026 at 09:17:25AM +0200, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Hi,
> >
> > when creating a new repository we create a couple of on-disk data
> > structures for the object database. This includes the "objects/"
> > directory hierarchy with "objects/info" and "objects/pack", which are
> > specific to the backend.
> >
> > This patch series makes the creation of the on-disk data structures
> > pluggable. While we continue to always create "objects/" regardless of
> > the backend (it's required for a repository to be recognized as such),
> > the other subdirectories are now created by the backend. This will allow
> > other backends to plug in their own logic.
> >
> > The series starts with a small detour into the loose-object map. This
> > detour is required so that we can defer initialization of the object
> > database itself to a later point in time.
> >
> > The series is based on 9a0c4701dc (The 7th batch, 2026-07-22).
> >
> > Changes in v5:
> >   - Remove a leftover formatting change.
> >   - Fix a stale comment.
> >   - Link to v4: https://patch.msgid.link/20260806-pks-odb-create-on-disk-v4-0-ba8b4fdd2e3c@pks.im
> 
> I'm completely happy with this version, thanks for bearing with me.

Thanks for your reviews!

Patrick
