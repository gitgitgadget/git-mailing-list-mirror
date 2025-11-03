Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252F829B775
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 07:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762154409; cv=none; b=Cl4HwIcK+0ciSFOfDDNUOpvWGvtKUGWd/Duqifu0Zbm5bkgffadzC0r/O/+FiF40dOWoxl0aQBilRyER5bf2TyIi0Ruqw1/OH6gRhdXfEQJqNOWEJMp58xHOX0qPSnohLeVCRnsoYJJfNo5dRhVjI9xRIQHWu1bt2SvberUUv50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762154409; c=relaxed/simple;
	bh=egUz8k/yoroW7J8NUZpOcR/1D2KJejT3lpBScyPJeJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRFyV46Lad9ah9x5ywuKx+/cmtbNNtOaomnwHfKhachEpbNScvBbJL8lEFr0J8WRMvU5LqoNRmv4sO9IuDvzb1V/AAYXFynKTFBqTEjEgXRUy1hez8UhlkMAmzwVTaD8sC5dhyejd8Ua6IgLyzVb0y3XmYqK32PenQAS7BNIDbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JcHx7PfL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FFLlBB+T; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JcHx7PfL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FFLlBB+T"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 41C3E7A0194;
	Mon,  3 Nov 2025 02:20:06 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 03 Nov 2025 02:20:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1762154406; x=1762240806; bh=vd47xfQurA
	q0KCwfRFnVP4XXFxFyLGsHemcleb49oIc=; b=JcHx7PfLK3kYoJTGJesfdSv3gL
	IFTO7sxa+o2FxySa0NvmNNZskwPw7xq34zgwWb/WOIRAp0lzu6xptct5BgjaidvF
	X8j701FD4LJ2ayln9xhI0+ASFcEj4hZhEeR4FPsI5raSD44hvHZvBwUekx013sQQ
	0x5zzyy8NBvQABW01nVo3AjF73JXa6qp1v6BABSGHekdke6N4t9kYYh0ashO6SaV
	XtpyUxLAAEabgxRA7RL24wrj2PSQuE/NQrC/3hHtbR0NtsHE91jwXs3E7AXm0o5h
	iOZuX8Mf4CHDOr8Cxn0mYjSFHSkkHwHwHrajFRB0EPBcxNVv4flPACO2upXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762154406; x=1762240806; bh=vd47xfQurAq0KCwfRFnVP4XXFxFyLGsHemc
	leb49oIc=; b=FFLlBB+TVwnd+tY1DzdmQRpIzWDXqGmoUUrYWaCz1QJxh4cxy7E
	ROEMCNx5JIj3XrZ0oILChIdtqYcPQsI3JqgnMCSqHekXjLzQwNjweUD/rCJwCLVs
	jcJzwOwrRvOC1e0NwZ93z6zVxDcDTi/mq7sZbWL0SueTNpe0gbkaC/y8Zt/G9P4i
	1FW72dfEuK2KaUzsO1hfkidHsWRgFpvCnDqHnKe+MeB1rBqQCTvBJtyt0QvHgDFP
	Wh9kn0V9LjvQRlX7bYC6wQCL0yViGCXW5Uejd/rf65WIOGIKEMJoUErGh6tXCvTp
	NJZMFdGg8rhUFfm8MZ2ug0Y5EDgevcoShkQ==
X-ME-Sender: <xms:pVcIadjGBQG0FsjxokHTg8eKNklhSeUICsw_rbuxtE74mvaB5cSq9w>
    <xme:pVcIaZexDfEKwgHZwoZhX2B5kDJKx4SzX7ZWObGOZ5JEvNxR5Q2EFSCvgLfjYlQhU
    i8awEdu0BxXBe_REeed4FxVj1PSbRf4L8RmP55CTqncP17jCDSW>
X-ME-Received: <xmr:pVcIaadPFM7ohd55rT4N7ZYvHVfrKihWiXNfD3VFrY5Z3NYN6CVpZEw7K08combcUrqFrXRms9AYDQThjLiHNTJ5PJD2dXvfW5S_PDdPzhDK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeejheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:pVcIab939CaC2kyC5ltStDWkpipE6OHjDeB54GZHXqwPuHpAj1RXWw>
    <xmx:pVcIaekRIqr3_7mGA7g3PCZ72od-Wog-JSBL9q7fcDc0z-aBxytmEw>
    <xmx:pVcIaV939qdg1h9nO40FaHia9NY2mzpgjZFiyVq7sMwnBOqZR7UP3g>
    <xmx:pVcIaUk3l85pM34o5_LG5s4BnB2dp2FY4OruHa_EELmigzhauqiqKQ>
    <xmx:plcIaZeeufxBfEyKDQmPGyv3K7EhwpdEP_P6ipJivQokwWXMVsGntQVU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 02:20:04 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 08013d64 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 3 Nov 2025 07:20:03 +0000 (UTC)
Date: Mon, 3 Nov 2025 08:19:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 05/13] object-file: introduce `struct odb_loose_source`
Message-ID: <aQhXm1uQlP3wYfgX@pks.im>
References: <20251024-b4-pks-odb-loose-backend-v1-0-1a4202273c38@pks.im>
 <20251024-b4-pks-odb-loose-backend-v1-5-1a4202273c38@pks.im>
 <CAOLa=ZQdit7N0aQWyqYHAoO6nuXaU3QqZbQmsbp52jW8C-zbzA@mail.gmail.com>
 <aQNMwve9sUP-QDN6@pks.im>
 <aQRS-KcNLD9prRYa@pks.im>
 <xmqqwm4b11xh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwm4b11xh.fsf@gitster.g>

On Fri, Oct 31, 2025 at 09:16:58AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> >> Hm, I see your point. I think that "loose source" flows a bit more
> >> natural, but I agree that the above is more accessible in code.
> >> 
> >> Before I change this: does anybody else have an opinion here?
> >
> > I think for now I'll stick to the current naming. This is due to two
> > reasons:
> 
> Ah, I should have scanned my mailbox down to the end before starting
> to respond.
> 
> >
> >   - As said, I think this flows more naturally in language. When talking
> >     about this you'll say "I'm using the files source" or "I'm using the
> >     whatever source".
> 
> I do not happen to agree with this, although my preference is minor.
> 
> >   - It somewhat matches the naming we have in the reference backends,
> >     where we have `struct reftable_backend` and `struct files_backend`.
> 
> loose_source (without odb) may mirror calling "ref backend that uses
> files" files_backend, because "ref" is redundant in the context of
> talking about ref backends.  "odb" is redundant when talking about
> odb sources.  But we are not calling them loose_odb_source,
> hbase_odb_source, etc. and instead saying "odb_loose_source", which
> I find is a bit strange order.
> 
> > That being said I don't feel very strong about this.
> 
> Neither do I.

Okay, this makes one in favor favor of `odb_source_loose`, one slightly
in favor, and me slightly in favor of `odb_loose_source`. I'll rename,
thanks both for your input!

Patrick
