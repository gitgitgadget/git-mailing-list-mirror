Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2952253A1
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 06:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780553332; cv=none; b=ipwQDetr5Co2bjc6gYPQcOVjOukIlepXl/sHd25SordYuR+hRwQ1ntzh0+uLf6/zLFb4Nr8nd5k9LKUPjIsgzdUdnm7UAx5mq5vok7KYP2bshpb5HmMFfGzfiYta+lyubvy7KxSifByImCneeYffS5AsUyucwdiRBE0fGdQKNbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780553332; c=relaxed/simple;
	bh=noYCnnomjC7JmtILqkDezBjbXyc2kErQzoekL0tWsk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNOl392nGXz0mIgILr5uvnPqoz2sKIG430kUPGmvYFMGUvoKHBlkiBOM5zx1Av7+Et1T3rdnyJg6cM60RTc5AGkKfIz6ZE15cqQVBLPhjeW4nkp8SLkscnXY/4Zq0zzRdhvqrXoghaNggRMdijNIgHj+8AR6p7PE5wNiPpJ5r1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uM90pNBR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HmD5AU2f; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uM90pNBR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HmD5AU2f"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 945B914000B5;
	Thu,  4 Jun 2026 02:08:50 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 04 Jun 2026 02:08:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780553330; x=1780639730; bh=b6qKE65P8/
	+ytoqVs5Qbqs2K/ZpFNl8hCd1eLq0to6w=; b=uM90pNBRPd5Z2Qm8org7ukxta3
	tT9AFVYyTsKNl0IWS7ZNo7SmEHgFhraBwYzCc8mUw9yXgl05bfW/hIDGyCkE9kH1
	9ONdbVmImYI5COzeNFp5D8k7n9/QgoGl+jqa+bFt9v22whJYv1KhBnu1zBKG7PxM
	rmXWbzYCinLfKXqyly0YxluXZ/78k0b4sK6RKaoeuRhOiW5NQZZubjtuJYthWO+2
	DhI/V+9xuIJJ+mKXbdKC3eNm3jgpjv3MuiuDD1adiG7HR3+uWmWEPvoQLokiXB7G
	dkmukVZCUvF3G9t2xGriq9/PKbbbBEa+ClhnOavcuoTKd4WTQwpHIzdSBEOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780553330; x=1780639730; bh=b6qKE65P8/+ytoqVs5Qbqs2K/ZpFNl8hCd1
	eLq0to6w=; b=HmD5AU2fLUQeagH41DUH5lrVHVJOp4fBWCCzcEMPmAowZDvkzF9
	sxMhEggNwLotD5/P1GL1OfBW0A7mirO+xpTAE2sfOIj/hTyW/cKah/oAT8b/H8q6
	v1DVFzLFqva9pQy441Sw88Zc7PJXsB8Myzj6Obzmb106ZaIKbT20ieN5iP0FKIXL
	q0MPVsTSTLRaFZwKWyqjaBJlnbN6YyKpLJoWyCywEeo0/akerQbkjmsvUdCfWmGX
	iralJBSS6KmBDs16qHInrvUuAdLbiJc11LdyuBSXs0wfPX2ZS6AcnIfEH20I9MOU
	0fQMGaicNTdsUzK7+GWbnvNN+6wgCMKsiqQ==
X-ME-Sender: <xms:chYhakPShvy8vqwIWbYLgNHGirU-9eUb2kVi_qjpnsfkBrqMe_HNXg>
    <xme:chYhah95Qvnp2kgVE0JrxMZomVMO5CwevEh3jwshEMnX48GIl1B3RrdYuvcCkPBlE
    UM6AuxrFCt05MJYHKVHdE56XVzmuhKkeZR4IPn2brtdvFjWEwlklw>
X-ME-Received: <xmr:chYhagR6ndICE825IApo-OsMrIsQl0u0e0NJXbztRMvnnGI88xZxIuRf8NC6UWiDCJo0mO8AiKSM6A2fZNoKXIgRSgzD2_3nv3uGWHFWXTE>
X-ME-Proxy-Cause: dmFkZTEWa4bkDooe2fPCI9HdwP6T79yj9fzYT46vmRc/PDlPgyVxd1UkTGYdvnQU6rbNfT
    DoXsufeKSFObrnNvAes453ZwcYFDcLtIqJACThi/3B6xAkAz9VoaCfK3jSg+uAoL9Z7OIo
    6nfPY9VwpMq7Q6YZlgOtx/uZ1JiEt2JthLf9LB2VE6wYfI9FOYLcc+qa552nI8aZlwuT92
    MYBiXtq0oc9TrlqsTX6VQEPfuxAb51FHRww0cgXw5DUElTNtS/YCleMBnFywlvoYyHfJdp
    1YJVFVI8ouHtkrMU7hJ9G3D8mhWb1FjHXBDr/2WPopvnVPz4RtlQfxIbYLoDiFlu84Knsx
    SGC4wqb7UWQ0ZIm0SodDzLn4okussqEbbTzaNS9s1d9nbnlKkL7SPgIRsdo/LW1NXKEllO
    /E7KaCup6se+maHj953k7RCjmtD54Qs3DnFu1OiCRmA8FdrWPsRCToMoHvb0f/lY9FVcM5
    SJ14INyzwSXabWULSHYaxU9wxqu0QRm3r69+tojBQWqpe7xcNKP06Bo+fu/0VgCPq/e/3V
    /qmcIcLBb8h45gXKqvO/3kBvfIHBq5DymEzvKPeW1gUz/FoHqoxjL4xsFxciGrdhhZuAVA
    5Svd4N15WxSM0RlXG4Q9PPVL3aWsv7C9GGx+5EpiqGX/Gux20VGnl9Vl5ThQ
X-ME-Proxy: <xmx:chYharmZfPWyzDn6vSynJf3BstB1gbD6nozrdncntjxMVOjKy483Zw>
    <xmx:chYhaoTf9knEOtE0zRtoHeY0DvazY76uiADNZtjkRrS88w5Fc2yDmQ>
    <xmx:chYhahMRNB-K2qA9v_BYKcOXNldQwABCBvXRboJULUpXmJ-aOPydrQ>
    <xmx:chYhapVq8c9_GgQR-pvW_Yl0o9lH847evdGFFfiDXh9KxVUd0bioQQ>
    <xmx:chYhajzNl0Z6X-Absa3KmkXjfDlcmGgOilnXq8gShSicia3cd0RKmgrT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 02:08:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bd3a15a5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Jun 2026 06:08:49 +0000 (UTC)
Date: Thu, 4 Jun 2026 08:08:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/8] setup: centralize object database creation
Message-ID: <aiEWbsdXu_ft2XtB@pks.im>
References: <20260521-b4-pks-setup-centralize-odb-creation-v1-0-f130d2a7e8ae@pks.im>
 <20260526-b4-pks-setup-centralize-odb-creation-v2-0-2fa5b385c13e@pks.im>
 <CAOLa=ZS4mSHEThYD0GKFXxqDf1Yz9U7pQkXYQJ+54V5C2FPBOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZS4mSHEThYD0GKFXxqDf1Yz9U7pQkXYQJ+54V5C2FPBOg@mail.gmail.com>

On Wed, Jun 03, 2026 at 06:04:01AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Hi,
> >
> > this small patch series refactors the logic for how we discover and
> > configure repositories. Most importantly, this involves the following
> > two steps:
> >
> >   1. We unify the logic to apply the repository format, which is
> >      currently open-coded across multiple sites. These sites have
> >      already diverged, where some repository extensions are not
> >      consistently applied.
> >
> >   2. We then centralize creation of the object database to happen at the
> >      same time we apply the repository format.
> >
> > The end result is that we apply the repository format exactly once, and
> > that's also the point in time where we can finalize the setup of the
> > repo's data structures as we know about all details of the repo at that
> > time. Ultimately, this makes it trivial to introduce the "objectStorage"
> > extension, even though that's not part of this patch series.
> >
> > The series is built on top of aec3f58750 (Sync with 'maint', 2026-05-21)
> > with ps/setup-wo-the-repository at df69f40c34 (setup: stop using
> > `the_repository` in `init_db()`, 2026-05-19) merged into it.
> >
> 
> Apart from some questions/comments, the series looks good. Thanks

Thanks for your review! Will send v3 in a bit.

Patrick
