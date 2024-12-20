Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B36F18EAB
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 07:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734678515; cv=none; b=QL7IM0udcAbw1YBGANUGMuBedO5sKl/2q9g7Z3d4DceWtzKHyQ400HdgJ0jNIwtJLEmZoNmaNmK1yHB39Tkx4MPwi6894EmnD5yvMWCPGPTjzF3PKW10sgrt0XIJop7LqEYEnbknRW4WDRFo3wZlJu2lO6ugLOIAeDPiiR8riZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734678515; c=relaxed/simple;
	bh=zcxyWAMxUzr1mz0J6y+bY5HlfZ5fxqdwLY4o7Co+5sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XTXbRfKJ4YmWDOzQptuDsjB9K9uBlo1gIHm0LQnDRhAs70XlDkxYLKLs5Dq3gcUSHoCdyqmMP/+SaNu0dMGYY8lSshJqQYG46F/tidKZiwgtP70zpjvrzKzicu4qstt0QAmxfPmlIKvu10nXYC/Aq9tDLAf4+WOKQrUcEedX9W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ReHWJgmq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iFuEntjc; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ReHWJgmq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iFuEntjc"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 16A381380199;
	Fri, 20 Dec 2024 02:08:31 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 20 Dec 2024 02:08:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1734678511; x=1734764911; bh=OhbQ6xCPQg
	CjLAkpBs0aR8/N5TLXURFRokVwXRmkTOQ=; b=ReHWJgmqJDxYtaW0IFsVyeBoEo
	+ef6ISzJnC6pAWW41FuacPeIolz7WqvBRd3vAgF62DtGx0nWsU86Wnf8Vx6EiS4P
	2f5QO2FKIfcu8JPlK2o3zjf4WoXkCNKVKe6gNvInT0FJkIQ6fbufsQk/bOmilGjn
	VhK1NYWUdy00ki0bAJxuRz4CdgTdx7ULcVxPmzoNkEIm3rS5laFowzLZP+xW/nCb
	XsqZwCEUUKAVL4h2QvmdXNN9KOg4wzhmSvQv8QI4PLGWCJxYwoNNkcby53iePGsz
	b5GYCuDpCm4SLmo408qH0LqawilLiGY02EV4AsSwPFQE9AgouZM8J0CADUYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734678511; x=1734764911; bh=OhbQ6xCPQgCjLAkpBs0aR8/N5TLXURFRokV
	wXRmkTOQ=; b=iFuEntjceLFddIgSkZHw8bBSFT2uboZHnj1IgaSFQedqHkkmFM3
	4v62IJXyqoudr6r/PL+I3b5aA1CuHr0izmyluvBWtCKdnbu1TFklBBOtlTO9xNbg
	An6TbSb42nT9p5VchOiEmrZanIuANU8gX/FK46mbZNjyJJLeRKl5y1C11ymqk+PY
	roSZpAV10quQJXM/VErxqHB54RI3/qikb5cNGHruP7ZIcAmgthccJNiPujtj0tOT
	VgLDn/5qFWhbLNH+CW0BRZAGEucSrc49WEMb+8bCY19v4l+X8qIOW76VRpt50nTH
	mV1lb9fPqOw1L78nZc2htaO2dV72wrwWDzw==
X-ME-Sender: <xms:7hdlZ7MLUPFrUXA9wqpg-mAqV0OsuRvpUWv1HT8zw09yTC7d62MlFg>
    <xme:7hdlZ1_pkfRKJjGBBFWFli0ZK19xH3oiRaoH8idhr6vr7FpNXRBJoHBhnO3GTY4EW
    VZ31NCBBN7DzSurlQ>
X-ME-Received: <xmr:7hdlZ6QPwLZBto_WEjQIWlWr7mh7XNTx8_sIIfcoBNEwCs0TkqrxEcjTDfeAOSr2D3zSgAHMZuuZUCVl0-90CpZ7xyBOS3hDLWuAWpcTjLSXZEE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtuddguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhssggv
    tghkvghrsehnvgigsghrihgughgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:7hdlZ_ts50Un8SIj21NkiJJllG-pOXgEQ3F8D9e2W7Ak_J_ZIThvPg>
    <xmx:7hdlZzetGg3u82nFD9Yj5oedXuAvc5GWkqJ67fV8VvXd1YiDqp6ILw>
    <xmx:7hdlZ73GlW2c0XrMcqDEwCDqEoSCnZ2dOhQyN_Aqc1H4FJyupv9wQw>
    <xmx:7hdlZ__9LMgu54k_txPC5_z1jbOnl4xDFKZdFuDxqFntzDF2r0l1wA>
    <xmx:7xdlZ_5mtyjSNKIN4ob_Cf1p8i9OiaLdceuTmCxzGAcZtHQKDUsez8yZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Dec 2024 02:08:29 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bc773ade (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Dec 2024 07:06:37 +0000 (UTC)
Date: Fri, 20 Dec 2024 08:08:10 +0100
From: Patrick Steinhardt <ps@pks.im>
To: rsbecker@nexbridge.com
Cc: 'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.48.0-rc0
Message-ID: <Z2UX2v8sc-DELaVm@pks.im>
References: <xmqqfrmn4hr9.fsf@gitster.g>
 <00ad01db5017$aa9ce340$ffd6a9c0$@nexbridge.com>
 <Z2EC9rq3F0rTljff@pks.im>
 <010a01db508a$4544d750$cfce85f0$@nexbridge.com>
 <015901db50b5$e3a7f6e0$aaf7e4a0$@nexbridge.com>
 <Z2JyFB3CddYM_LP4@pks.im>
 <00ca01db5257$12708d00$3751a700$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00ca01db5257$12708d00$3751a700$@nexbridge.com>

On Thu, Dec 19, 2024 at 03:46:20PM -0500, rsbecker@nexbridge.com wrote:
> On December 18, 2024 11:07 AM, I wrote:
> >All tests, actually.
> >
> >$ GIT_TEST_DEFAULT_REF_FORMAT=reftable GIT_TEST_CLONE_2GB=true sh t0000-
> >basic.sh --verbose -i -x
> >error: reftable: transaction prepare: out of memory
> >error: cannot run git init
> 
> Any updates or hypothesis on this? Our test system has loads of memory
> - I cannot figure out where the allocation failure takes place. There
> is a limit to how much memory can be allocated, but it is very high
> and our virtual memory is extensive, but this is a 32-bit build.

My hypothesis is that this is caused by ps/reftable-alloc-failures, but
I am unable to tell where exactly the error comes from. So I'm dependent
on your input.

Could you please bisect the error? Finding out where the error is raised
would also be quite helpful. It has to be one of the reftable functions
that returns REFTABLE_OUT_OF_MEMORY_ERROR, but other than that I do not
have any more gut feeling right now.

Patrick
