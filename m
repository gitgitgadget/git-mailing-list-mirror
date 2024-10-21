Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433B1946C
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 11:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729510439; cv=none; b=uLrPLVW4qtC7DnYMwsJgk+Aif5cG2vGRtQ6LtCEpWubWpqJDMBS/y5oawKPU4UM3JJTMtxwsOo1MEfW8FUaUq09FiMSy3QMbic8Q5WroXxT5aE/czdCywxHe0wecHdI/QcMBvGbv7VMTkas2fiULwn4Xd/17QLXE/u2xknmrriU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729510439; c=relaxed/simple;
	bh=ExqldO2wKXYTr/Gr6ec7OR1oLeTIj0iggV+GANEZ8hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OWBfYdmQWnMNVw7AA07ZTULndaKRH42YcJXsKk5U9cqUQQDJexyE15KPQs1xoQq7FPXbq6ARPP0DEkn8IFrsCm1nRPUc8ymjc4XxTcIUG5yrBziaaGIfVIfGOVGzeOiEVm5BMYJXTHhslbOvmDaz+IHXuRjYnlmg7bKcGHAvKkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Oc2AHdNt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A8x7A+uq; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Oc2AHdNt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A8x7A+uq"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4978B11401C6;
	Mon, 21 Oct 2024 07:33:56 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 21 Oct 2024 07:33:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729510436; x=1729596836; bh=64nLfr5BMZ
	NTGnx1UsrueL5A0WQpKGyxDc7y+kBNdIk=; b=Oc2AHdNtNfOQcQFPJMadZsuGHO
	bKIXxob8HqnJP99c0QkI3+qIJugq7q9gL44YuWVLqHzAuQ62wVeVAU/VMIJdKzQk
	pbgEotlKpQfAzSOylENGyKcJxSSmPDvLVB9N1XHah3TqBRGU4nLQKMCfc94RvPfo
	LSVODARVs6rB8QuNCXE6eCV0erwRRT860zzTzUy7fT+ZjYvp0gM3F+NevefW89tV
	jMWJGxbck645NqsZ55/LieT0dLhiqDHuvJH7RhI4a+q6ABp0chx3Th48531F1iQw
	L8hiIIJ+HtlQl1Sps+CX8cQkzoxBvFUAVLmSx8nB4Ee10w2xBGaRrEsD2RtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729510436; x=1729596836; bh=64nLfr5BMZNTGnx1UsrueL5A0WQp
	KGyxDc7y+kBNdIk=; b=A8x7A+uqFnxcKzdUkYHZe3s4Yb/iESEH+G6tyLfTKo1n
	ATAkcuu2m5oE0IAFcNB7sm81cBhz5FMXcrRBaHCTVqe475EafZcM4RWMn/sWvK0p
	AU1dcyRcmRRF7MTnmFNbdXLe1W5caDU5DrWOXxSi71vM2x2owFieWLosxdPSWwkL
	fWEJA61xBLaUSaM4dyMXW8HttZ/xZWewYdrIFMxyxjz0X2kn6RVTEjjfdtUOc5uI
	VbsVvYCWNWBO02ISYLwvVbL36dbvzTnSO8et8L+5a+wki/4GHjP7Zz+WCpwOlcQD
	OjKdB/rpSe8pNAUt9e/yqLbuwGX3yjH7+MxbZ+HoFQ==
X-ME-Sender: <xms:JDwWZ-lDUHw1dGeQLrkS_-auaMqOfILjsdgSL9mv-x7bJxOOx5Rltg>
    <xme:JDwWZ11c8vsS5K5MLEAyAP70-y1XSKhrJxSjAapY7g02GQgPz6NLYVk5PJulO2xcB
    3AP_CAVxAtOjz_ZOg>
X-ME-Received: <xmr:JDwWZ8o5SchKMaEygv5TRvq3cxZLz3V2iyU7N0McEBYr0kFdbIDr8IvkKZGaiqsv-7Q3AEqDIppyG-sKmtPm-HZkvt5hLKmcZtCwfL5EmUe->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:JDwWZymDNMi1tuX44Z-iamljxJDS2cqGYi8rwFz0lKvh9-FCaub9wA>
    <xmx:JDwWZ81yQiB69lPirwR5DCWZaj4_5zjHnqzRdft8-RhxCqRqUHt4KA>
    <xmx:JDwWZ5urUYsUng1fJuDXDypjJABSRHC6P-9zY770QuCCHUgmH50G5w>
    <xmx:JDwWZ4XkdMFEcLPYQlquBEFWSeDeBDIwJaV5yqdJ2JLAl7OIJEtNzQ>
    <xmx:JDwWZ_SeKoGSK6fXt7e2NXuj2HnipA0XYu2oU9kUe7Ftwb1NBzAEFlrk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 07:33:55 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5dd4d0b0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 21 Oct 2024 11:32:27 +0000 (UTC)
Date: Mon, 21 Oct 2024 13:33:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] ref-filter: format iteratively with lexicographic
 refname sorting
Message-ID: <ZxY7_mNriWFzaDQr@pks.im>
References: <a873ed828ccae426214cc8f87610df97ff9a269e.1729055871.git.ps@pks.im>
 <e0daa6a2eac97c2b18a53399b7c124fc8d3d238d.1729141657.git.ps@pks.im>
 <87ttd5btjf.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ttd5btjf.fsf@iotcl.com>

On Mon, Oct 21, 2024 at 01:10:44PM +0200, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > @@ -3258,7 +3279,6 @@ static inline int can_do_iterative_format(struct ref_filter *filter,
> >  	 */
> >  	return !(filter->reachable_from ||
> >  		 filter->unreachable_from ||
> > -		 sorting ||
> 
> Just a small nit, because we remove `sorting` from this condition, I
> suggest to also remove the following comment above it:
> 
> 	 * - sorting the filtered results
> 
> 
> Otherwise no comments from my side.

Ah, true. Will fix in v3, thanks!

Patrick
