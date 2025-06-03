Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01FB4A1E
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 06:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748932499; cv=none; b=OS5wJAEJkZr9a2w6kXowaSU0L9l4DhQrLC9BwsQuhVvlNqVUcIU2O1/pYw6D54FDpJeifMi2oOFJmfx02jeZQ4ZrgqjPnWrcnrjtMvK4WDfJYU8x5+GQNl75hAbPyqJt52eCnBP5a2kvb7RkBfvviW3g4kgZ7Kg2HUQwXBHbqp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748932499; c=relaxed/simple;
	bh=jjtp13TPHDWH1ueQ234Hog2trasoGLnIM7Ut7XNwzMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDFSlz4ntLFoqLVtYkciO6+6B0tvE6+0B8Do9nCeHxWX5syovZB7vju65eb7pm8I9dzqCBcfT1oKcjs6ooj8vdLJ4LInuvis4w6+sQINdfGJNQW+Wf56SN6Sp3jYQ+zLWY03M4QJMDrKxVsRdrcdyDkr2Hh4XNFKwgl3GKSbr4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=c1s9CBTh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DZU8GEte; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="c1s9CBTh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DZU8GEte"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6541E254018B;
	Tue,  3 Jun 2025 02:34:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 03 Jun 2025 02:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748932496;
	 x=1749018896; bh=3IMkMeFRLdifasYv3j9q7YkL5w1e+zkSMRXkNF2ch98=; b=
	c1s9CBTh8JCedeeTPDh+P8eS/wi1+mZdegQCjA+hJMOKKFNBOnkzWlS8E8FUWk8T
	Xm8b6QjDNqlmnQjR7mYqYc+8opf1wqKCWIKcpRzi0/cLUJtCsx0sq3/4R+U9MOvq
	DE4x5g5N7Bpa8HujIH6NRFxGyqjkmAXGNEVsWtOzFHlSMhcKXauxfuUPMgP30eu8
	XClIPqtzFyqD0SFmMXptEuXFShh+IK9yI3N+VL28O2KUufg5R2WEHsE5+tGDqWBd
	Tn1vlZ9l/H0q6O5OoA+6fTRTPH5Kfsj2N63z7HxmW08s8ejW6kSokX/3A9rZfKlc
	ZgWxV+QCeKHEecIz6ZGnqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748932496; x=
	1749018896; bh=3IMkMeFRLdifasYv3j9q7YkL5w1e+zkSMRXkNF2ch98=; b=D
	ZU8GEteCCn+wXOM7Q4jH/W8J0l8TUTa+3wSJgVE5FhyGcYJY44tQ9zbOjciuehuQ
	ox2gATWnTGaLDqNaBT3A/YaBjmPyHaDTc+R2HLVXwkcBuo06DD0sXPheaH+yXndz
	udUTzHAKjiOcQm1iwLj0o/u7nG6yfqcaib7VfFch1zsIVyFlq477ZL8RU/HEPyEh
	mmRtec6+Aa0fOiUQTIm4p7b7VGtHcfPowfIq1aWrz6B6us6l9WoBJS5pVAYMI9BK
	VoiTQ/yx3Bpexp8iILLNvSVdX7hNOmA7mRkndiTgi2PfIjSGFBTa4tF254zW1rIe
	05DlBf85JAiLIKEFLmKKQ==
X-ME-Sender: <xms:j5c-aBfEZH3Tqd7nQ_etXJFK7FYJDLKaKRhbIP8kqk-7rASXDkMUkg>
    <xme:j5c-aPNDPutOask9873Lm2dmWKIMBtPr696QbTh9onzMpG8-mkILrCK6dCbszq-0q
    4qW6ozJH-wXhnNK2g>
X-ME-Received: <xmr:j5c-aKiY82-V4Wc-BfNkxcmVP6f89oqySmOHlHgvVYmsptYS7CltoL7XqKFeEv-XN8iFzEtu_FBHWv6iLRN7u6Q5HUagZsz9WgOqUZVgJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefleekgeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhf
    gggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvdefjeeitdetleeh
    ieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgrmhhsrgihse
    hrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehkrhhishhtohhf
    fhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehnrg
    hsrghmuhhffhhinhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeihrhhothhhsehprghlohgrlhhtohhnvg
    htfihorhhkshdrtghomhdprhgtphhtthhopegurghsrhgrfhelsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:j5c-aK9bojUgSQNR7A5LgL2LMeYg81kTBEhxc_TZepfR-c68Bva1mw>
    <xmx:j5c-aNsHGDiQ582CUvnBhs4dyYxN1GraXly2aJyUqKrLKPbrJsJD-g>
    <xmx:j5c-aJG2FCKjrmXQGiL9WsqWMwH7jO_gbYWN-1ZPxg7yNCXVJvRjdg>
    <xmx:j5c-aEOTIZ3fIvDueNuUX-4F_kR7D6CDo-rxr4MTC_sE9hZiuwCYpg>
    <xmx:kJc-aNNM9EIsoHQYCgjUFk7zuHfs-ED8zfU-WloVviM3El5K3YCSm1Mo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 02:34:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b61d4859 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 3 Jun 2025 06:34:52 +0000 (UTC)
Date: Tue, 3 Jun 2025 08:34:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, Yonatan Roth <yroth@paloaltonetworks.com>,
	david asraf <dasraf9@gmail.com>,
	Emily Shaffer <nasamuffin@google.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v3 09/12] builtin/maintenance: fix locking race when
 packing refs and reflogs
Message-ID: <aD6Xh8kKUu0Y7sr-@pks.im>
References: <20250602-b4-pks-maintenance-ref-lock-race-v3-0-587d44252dcb@pks.im>
 <20250602-b4-pks-maintenance-ref-lock-race-v3-9-587d44252dcb@pks.im>
 <cab8e175-e977-41b1-b53d-6b9170c9e416@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cab8e175-e977-41b1-b53d-6b9170c9e416@app.fastmail.com>

On Mon, Jun 02, 2025 at 12:03:21PM +0200, Kristoffer Haugsbakk wrote:
> On Mon, Jun 2, 2025, at 09:17, Patrick Steinhardt wrote:
> > As explained in the preceding commit, git-gc(1) knows to detach only
> > after it has already packed references and reflogs. This is done to
> 
> I’m a naïve reader.  When I read this I immediately thought that reflogs
> can be packed now.  But going by the last paragraph it is packed
> references and expired reflogs?

Yeah, I see how this is misleading. But indeed, it is packing refs and
expiring reflogs. I've rephrased this locally, but if that's okay with
you I'll hold off sending a new version for just this change.

Thanks!

Patrick
