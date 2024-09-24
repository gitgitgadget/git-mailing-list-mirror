Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D260845C1C
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 05:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727156031; cv=none; b=DuLsAD/pMyol3490qKlrHmyz2k506S0Vr/6+66DBRuN+ojxMB8xLhigIZz54CEG10v/HxxLoSVQjJ6TrLocBUqiJqrrwYL+iUG/QbEVXCgkTQMBjWQi9kZ8MiJ3DvUyDk7KIr60PTo7wMEEUJPMTyyM2MvsxD7n4B5ZlkxJZ4kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727156031; c=relaxed/simple;
	bh=J+hhJOISw0rwIhLMcTaY5aH1sL84Ga9Zl8+XMnlw+nE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=llzqFBkPJo2nrZC1Rq+GmbWR2oqB/D/H7NA/QkzsVLbiI1s/w03Uk4yQ+xUkSQrJCa9DYwW3WidZSXboum2ZIrKjlUbRKnFiCZbd37BhiSBoEDr/Jb2OsAY14N/3z7STzSoQW9tVNAAV0QmaOt+w9JLb/p7BLNNz2MmKFI9nxwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R84Opujp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TFM9oYvy; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R84Opujp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TFM9oYvy"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DF2EF114032B;
	Tue, 24 Sep 2024 01:33:48 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 24 Sep 2024 01:33:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727156028; x=1727242428; bh=U7QR93xisy
	siZ2h9MSCn45rV8iQv0HvIsBuSFXgVAQE=; b=R84OpujpueVyA0qkamtFR8NYwg
	l16GKIW8VdH/0zSsj7ionbilSsL9Gnrunsz1FLttsHqZ2Nji7zEyAAmorIag1OdB
	RIFWRkGdkFvxLfSqEH6A3tfoQE40dtx/oaxtzJd0aBuHiX1o5NYGTGfszkPeCVim
	aX9hzWm6+VZmWnsxSI0VH9av3LQytsciiMkk4KjiBzdIUyaSU1zyN1y4JzQUO+nq
	9+WdpnkF/kItRzjPFJvBi5vOAyqj3CMeGRTcIdhXxWihDo3L+O50Fq5lsCk4FEXO
	4BieuMYsZKgB+wF8PzVDNsjG/56ngueIbtJVkiYxvLmD6l8auBmcRHLA6ikw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727156028; x=1727242428; bh=U7QR93xisysiZ2h9MSCn45rV8iQv
	0HvIsBuSFXgVAQE=; b=TFM9oYvyNezp1CZ7cUecz5l9ySCvRxUo34596sMgw6xU
	y4AFI8qeDgpFWNkf4IR+RBX9Jztwmsjvw7lzWAZe/hDO1gYEi2+RggnsMDR6v1Ci
	UI8gCUMjaHVyuRROzvg+jftYkMtjy77wJ2P4qFo0szPSvz2HxrjOgJ3yZ2D28Svm
	qvu2GAPR2Z9QUfwEK7Pt+n783fUgDOfHeo8lmVLgmbdEUtb6s9fxh7PvnR7UoV8x
	aKEXRYJ6SPA2nsEBe334SEaHvk308nTHSiOWWsvmv01kAd0kig/dKPNT8loAlK3Y
	DuS6TzzAuONhUT4DWcDZFFjKu1v0y/TPF+uolHBjfA==
X-ME-Sender: <xms:PE_yZr4Nc131HZA0cARuLmAq6CVqfP7lOMs1KgB_4uSsgtdA-WZgWg>
    <xme:PE_yZg6qc99etlWzsFOxkK4m0E51iBPtEVABQTuVHFsKLN094gjch_hYtgB8tOMSk
    wsc-CnUxV6rmSn66A>
X-ME-Received: <xmr:PE_yZidUUO8VFnXdyJFYby71kGOrUGmL4ed-VXax8A_pMIXD9b7BGF4Sw2UuBmKqh8MG3sk_Gn76CHJec8tu4sR4yAEDLg-KSGifx7mihkPU9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtuddgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhgrmhgvshesjhgrmhgvshhlihhurdhiohdprhgtph
    htthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuhhnshhhihhnvgessh
    hunhhshhhinhgvtghordgtohhm
X-ME-Proxy: <xmx:PE_yZsJKprsGrQakxpSjKABHF3Vryd3_qyTyUst1oPwAyfDHkEDO3A>
    <xmx:PE_yZvLkE7BxdcjMCN3FOOIoujfAFiiHCNz4HU4TGyfJ0LMVJv6h0w>
    <xmx:PE_yZlyDKESM0_ItR57grKyutHfnbA34RuIkMFYzGogOdJAQd-M8BA>
    <xmx:PE_yZrInsr7uafD1l0a29qWSJ04PBjMsBvZ6rsn4xnXFCnvdOsZw3Q>
    <xmx:PE_yZsE6StvZ8cGsSQjnkiGZGBBDwWMxzCLLgeqWOb5j8Azi8ApUvcg9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Sep 2024 01:33:47 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 640e44e0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Sep 2024 05:33:14 +0000 (UTC)
Date: Tue, 24 Sep 2024 07:33:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: James Liu <james@jamesliu.io>
Cc: git@vger.kernel.org, karthik nayak <karthik.188@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 0/3] reftable: graceful concurrent writes
Message-ID: <ZvJPOJKx8tR3KdgQ@pks.im>
References: <cover.1726578382.git.ps@pks.im>
 <cover.1726653185.git.ps@pks.im>
 <D49SPD0WS6X4.20XXOKHPNQNH6@jamesliu.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D49SPD0WS6X4.20XXOKHPNQNH6@jamesliu.io>

On Thu, Sep 19, 2024 at 09:23:21AM +1000, James Liu wrote:
> On Wed Sep 18, 2024 at 7:59 PM AEST, Patrick Steinhardt wrote:
> > Hi,
> >
> > this is the third version of my patch series that implements support for
> > graceful concurrent writes with the reftable backend.
> >
> > There is only a single change compared to v2, namely that we handle `0`
> > and `-1` for the lock timeout config. With `0` we fail immediately, with
> > `-1` we lock indefinitely. This matches semantics of loose and packed
> > ref locking.
> 
> I guess you meant "we retry indefinitely" here :D

Oops, yes :)

> >
> > Thanks!
> >
> > Patrick
> 
> Thanks Patrick, no more comments from me!

Thanks for your review!

Patrick
