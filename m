Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8932BEC5A
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 15:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768230058; cv=none; b=jnYN2xJmmc5mH6/6CrTozIwOtqVJlZQJnIUXb8KdhxWvKYSCmDETBANWAdMga2TGEqPkl9Lbhz3G4z9hRGyqOv1H3x8Hyu7iD7QZI7MLjET5srWUYzAKKyCxGFPgJL/h/9q3NO4W6yXm/ynl+r4jF5EOL2HrL0RYDWklfUJIxFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768230058; c=relaxed/simple;
	bh=HVb8F46IpXfffk5JHDe45X93/LAeznzDyKqMbeEPjG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GyiJY92TV/zaCrY9fSKYWj1Uieb50JWxBLeqWka2yOnf+eQymflOmpafoomwiRf3EvA2XqU+7Vws1B+ew5QMXy0GZfN8A/H5styv5KtlwaNMajtmyD9k40stNO1tshcebNuG1HoPy14J4wBkNMOPtexTwhRFENB4irHd8nGTsdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e7RtkqxG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qx7dHEx2; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e7RtkqxG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qx7dHEx2"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id C99B3EC062D;
	Mon, 12 Jan 2026 10:00:56 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 12 Jan 2026 10:00:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768230056;
	 x=1768316456; bh=EjuVjIGpmcXqe9d5r4e4xuM//9yI7GUybp48rqCH144=; b=
	e7RtkqxGfwlfajijvzy8w+TSSQrmeQGnPYkmWPtt8gw8YvDMg0Pvs30qnrr+v+5/
	eRxxGAVxBSBf/gRe3HXea84jCLj131iQE3wctPx6f4zalcO9RsKPg43c5avCxt1b
	vA3ub9bJke467FL7/iXNWhXZ3ErEb4dTHA9Jjxh3ZYK9h6fVY6Ed/kvvMwE555SH
	fp6dDhAA88cN4/qV/3mRtzKRz/C3DuSrOD3PIKtuX6wU03XUXPJWbLg4Dw2uFZhe
	EJ0kX/LZQk6bHsb8hvTW4mkTQUMSyDlQ9WyKMnWDaH5YtEN4IrcrU3KKzKQCY66/
	YgI3J4BRTewXOHOY7N5AFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768230056; x=
	1768316456; bh=EjuVjIGpmcXqe9d5r4e4xuM//9yI7GUybp48rqCH144=; b=Q
	x7dHEx27Eq5BGunCC0/DApVFZn6L8EItbJJYld4dyz0PeiqhVzbaVw2O/D/NyQv+
	Q/fjTiox2JQILo5yEH58fwtkWeB2962cXCDaX9DNusMZaVYArl5WqPvKF+8SdKs6
	MBHAMihwydg8Ezhf8z46Kspnlp+XrF/DrXTo/+palMe6nOHiDx0Vs8+l47GYCa37
	1SXbAWb0HsvhKXcRGysyHIOcrhePIg+x85tkeu2QptjOZaLr/9ek0gfWfca2zDas
	UNqXNpVmtcwVVbFEbvpHduh0kXWcgwxvFMJbeus2cKiThYrbpECOsZhSMQRHvWFI
	NMjPmJD96KRM9FAmEgkFg==
X-ME-Sender: <xms:qAxlaXhqf32ZREA-pziB_P6wpkAvtCZQFZp_4-Rn0ZwhYhg4ce8o0A>
    <xme:qAxlabccWtG_rpYHwdDUETBnhvLJi3sTR3DVOLL9mrD65N5RtBxCjB6_pAGWrGssn
    AI-G0G0Dqop_F_KlyDYaBM4anX_Yycotoz9K8kPVaHXSGjmSoVXhKM>
X-ME-Received: <xmr:qAxlaUesXHhcs_fNsGTkp9UMA6_-kkNK9R6cgFMbOEi-JPx2XlkmcbYsHK_zZRioiZ2_T1I4QPo8D6FjLZiqSVRD8kfYtBFRi6zE8okCpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtugfgjgesthekre
    dttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepvdefjeeitdetleehieetkeevfedtfedvhe
    ekvdevteffvdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhdrshdrrhesfigvsgdruggv
X-ME-Proxy: <xmx:qAxlad-ne869cQvmUb4sGTClao-8RIY2ZAviaXiK9djIRaAY_NxGrg>
    <xmx:qAxlaYlPbpEFWbYp9Ueb06wn4YCVOrd1gfqROGIcf1nvOqkaJ14IHw>
    <xmx:qAxlaX90SjKv-SLkGmCYbxEevV-Q-QJEjcLq68O8jP0SdsXTxiCBeA>
    <xmx:qAxlaem9RENdWopIL3Xaemy2DLVLe4XNLuKEYLIr-t_tVZpuPcNxCg>
    <xmx:qAxlaWGk6IfCXqQ6tzVv2Il7AGv9EF1K2mJZB5514MyXpQ4iQ4djEpKH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 10:00:55 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d207c73b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 15:00:54 +0000 (UTC)
Date: Mon, 12 Jan 2026 16:00:47 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
Subject: Re: [PATCH 09/10] tree: stop using the_repository
Message-ID: <aWUMn6G0C1cHA4qY@pks.im>
References: <20260109213021.2546-1-l.s.r@web.de>
 <20260109213021.2546-10-l.s.r@web.de>
 <aWS9Ll8CQ3eILx3z@pks.im>
 <xmqqh5sqoqr0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqh5sqoqr0.fsf@gitster.g>

On Mon, Jan 12, 2026 at 06:22:11AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > On Fri, Jan 09, 2026 at 10:30:20PM +0100, René Scharfe wrote:
> >> Push the use of the_repository to the remaining callers by turning the
> >> compatibility wrappers into macros, whose use still requires
> >> USE_THE_REPOSITORY_VARIABLE to be defined.
> >
> > Can't we make this step a bit more explicit by adapting all callers to
> > parse `repo_parse_tree()` with `the_repository`? That makes it way more
> > obvious that we rely on the global repository.
> >
> > Edit: I see that you _do_ edit all callsites in the next commit, nice.
> >
> > In any case, I'd propose to move the compatibility macros into a section
> > that says something like:
> >
> >     /* Deprecated wrappers that will be removed once Git 2.53 is released. */
> 
> Please do not take release schedule hostage to one particular fix-up
> series of patches.  Thanks.

The intent isn't really to take anything hostage. It's rather intended
as a hint that once a specific event has happened, we should take
another look at removing these wrappers.

We regularly have the case that we add compatibility wrappers to not
break in-flight patch series. We then have to wait a bit before we can
remove those wrappers, which makes it likely that we forget doing so. By
having the above marker we basically crowdsource their removal as
everyone passing by the comment will now wonder "Wait, we already have
Git 2.67, why do these wrappers still exist?".

Patrick
