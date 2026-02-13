Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75947125D0
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 05:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770961859; cv=none; b=Weu0uzaZgPCzmrZToYkfVx7hRiGKwEt4j3nmug2ELkYi7Ut8hgJNSmmJsM+0rX0E3wfGtXLd7u1B0UyQvxuISTixTZCbnb2dRT6wEnM/g/w9mh3rgwCV6EDQZA4z7WQbSl84FWdb5RcFPSXVrvE+lIjg4aJy62w+PL7ShPUr4Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770961859; c=relaxed/simple;
	bh=BhsRxQSurd2QpWrbcURqPZQCo1hkqLyQX64KfGy6yMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ls1GV+8Ij3Yh/G9kiMKKdLuRc1yfEBdNal/1n83t9lGqq9WLrp7b1iK3BVbL/z5gJSbJP+p9MtGcv01+cS8HA4LZ6koubx/E+LTRQJ4LJ/JxMtQFophDt4KIKuUbcDFWJVRLOItcGKBMz9Yk0HSLLPJvjBM1Ao4Ae96WyHXbJak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MjIaHg7A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cakc8O51; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MjIaHg7A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cakc8O51"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 986A67A01B0;
	Fri, 13 Feb 2026 00:50:56 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 13 Feb 2026 00:50:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770961856;
	 x=1771048256; bh=BuwonMUzTDcGIuAWQDBt7yw80EsAfObzHMu+/nCrVrE=; b=
	MjIaHg7AVzHrVZVGe6En7IQzjR09JfgAOxdf+hY7PNzqR7dHh3kqGboLSHPCMDhS
	q4CUzzWTvQdHtK2Cvt2AxVBZ+VmMa83QMjdo7MboPgqkaEi2rcwLP58alipKh0g5
	lVwdP2XYuKcSv/tbaPOd17s3dYQnmT59AR6FKrVGv1pqlllnkM36wnWFOODl4uuv
	LVGdCStA1U3vpOQrxG0uJKocbOm/OP/73ZIVruC9oFscH3KNgFLlQdf+pUi75kmE
	4b2mFl6FxNuexQmEkHKHOZAkrZJyZKxQr0jLWzGYmqvcsHpEjuwr7D1LCKWC7OHm
	aX6uh/giKZKDlnhMjsBaCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770961856; x=
	1771048256; bh=BuwonMUzTDcGIuAWQDBt7yw80EsAfObzHMu+/nCrVrE=; b=C
	akc8O51SkSwpZdTK4a2Zqy/w7dVXP2UvIbGg4sYuRNaJRbt6EATATKtPC+2vP3+e
	8ae764DTVLGNQ8WZ1And78a+kifzG/AgX5Nlnx063lC8ykBlxo57xNep44on97sM
	3e0+6eh+H5VGzTYczqW1KUNuFbfjGWwwzZVlhwdu38A6gr7toay7EtwLAFVMYUZW
	K9M7GPgUQa39nyaqKjShuJeIbbGa0axMYPoIRwpG7TUq/T5/yum3qHFsrhiaqn8b
	27N3u4pgHQwsCufFnxsp+NW3RC7hC8fsXO3xo9fJC9bXH6d01bmwW18wXvzCfX05
	NfgdbADdbc2K37k7bKHVg==
X-ME-Sender: <xms:wLuOaQjBerLS_QZIOHZ-20DiUYeyMwY7zqe47BPhyMb10XReoWHP8g>
    <xme:wLuOafD_pAO_JruhdgtxkJXBmP2WhVXJgvlh-YR424UQDUlkzJiWBpOdut6pgw0zy
    L6mloXPotqdIrTg0dMwTToQzJm6aEyeL1tS_2WJUxHDQmFu88sujg>
X-ME-Received: <xmr:wLuOaVuPuxB4w-9vfTFako6UBMhZEqr0d26BU2WeuGCXZoVC7cHPsNRCs8B8rBFMIQSmFqDD5gEXjcN0vtXJAzDGKeg1o693JTiVr53swwc_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdejgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnhdrkh
    hnohgslhgvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:wLuOacYUZtzbQmYYBAjuey_LVbGshljsGNbFETxgTMEq2CNmtqLISg>
    <xmx:wLuOaQU6b1JOFb6rGF61RUL18zj4yI4fCehwgqWJvMSX6livYd-TPQ>
    <xmx:wLuOaY4dsHdl25iVUnl3o28BMLUtj56CPeyCnPfSSBBEo4Ug35zVDg>
    <xmx:wLuOaTjcBm_MLpMNDqR-TkyE44cW1lsOFYzqqx63NP1pcvJ6NGzVMQ>
    <xmx:wLuOaYSM2KPm_wZ-1UAeZRP38gATVnmN8A19p7EZMp5_Z3ES-GMQGmHK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Feb 2026 00:50:55 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c5914ba7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Feb 2026 05:50:54 +0000 (UTC)
Date: Fri, 13 Feb 2026 06:50:51 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/4] builtin/history: replace "--ref-action=print" with
 "--dry-run"
Message-ID: <aY67u1Iks4iPBMgl@pks.im>
References: <20260212-b4-pks-history-dry-run-v1-0-1ce03d631c1b@pks.im>
 <20260212-b4-pks-history-dry-run-v1-3-1ce03d631c1b@pks.im>
 <CALnO6CBterXWjecpRG7jTc4PaHDJLuY_FyrA0URC0TXBWSXgHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALnO6CBterXWjecpRG7jTc4PaHDJLuY_FyrA0URC0TXBWSXgHQ@mail.gmail.com>

On Thu, Feb 12, 2026 at 05:20:13PM -0500, D. Ben Knoble wrote:
> On Thu, Feb 12, 2026 at 7:45 AM Patrick Steinhardt <ps@pks.im> wrote:
> > diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
> > index 154e262b76..33353815cb 100644
> > --- a/Documentation/git-history.adoc
> > +++ b/Documentation/git-history.adoc
> > @@ -60,13 +60,15 @@ The following commands are available to rewrite history in different ways:
> >  OPTIONS
> >  -------
> >
> > -`--ref-action=(branches|head|print)`::
> > +`--dry-run`::
> > +       Do not update any references, but instead print any ref updates in a
> > +       format that can be consumed by linkgit:git-update-ref[1].
> > +
> > +`--ref-action=(branches|head)`::
> >         Control which references will be updated by the command, if any. With
> >         `branches`, all local branches that point to commits which are
> >         descendants of the original commit will be rewritten. With `head`, only
> > -       the current `HEAD` reference will be rewritten. With `print`, all
> > -       updates as they would be performed with `branches` are printed in a
> > -       format that can be consumed by linkgit:git-update-ref[1].
> > +       the current `HEAD` reference will be rewritten.
> 
> Unrelated to this series, I've just realized I can't tell from these
> docs what the default --ref-action is. The code says "branches."

Good point indeed. I'll add another patch on top, thanks!

Patrick
