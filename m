Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F07232860B
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 12:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771589122; cv=none; b=A83voiMYAwMXeQXmJCP+p8VkG+uP4xlB5tqa9E7GGMEYyE+T4TT0RvusI51NQWTcN1xifmU+zpKv0xQF0C5SZNrjEoXr7VSFzjUXiLAtaIHWgp6VpLGMfoFEzEjOIXlhZWmBfJSAW/j+hRh5BdXbYf0W9knxFk39yT7gz7vA94w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771589122; c=relaxed/simple;
	bh=niO59gvLgQtmpZpJxqllcHOQDty12uUxr33SVPorXiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4XjxWmpDRcZ4YbzEkheJOafS5viDzXPA+ygqspybh+wi5xXXxwVncPMEZ9/4YrGcxeGS9ZAPuKXk+qk8PMVlJPd/hMhQdh+rezZD3zLEeuqhCK/rdv6gYwCMJ7PYwNvBV1oogYL5neOCpkv04hN9DN/ZUfvN3ihqiJ/wGtVdHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Gvj5V17t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bStLsvil; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Gvj5V17t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bStLsvil"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 35F4E1D001C6;
	Fri, 20 Feb 2026 07:05:18 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 20 Feb 2026 07:05:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771589117; x=1771675517; bh=P6fqm9VZSF
	hm3trPM89rPz+lBRx/Ge3IMeEaXLMAyrE=; b=Gvj5V17t3sJAdrfQ2B+75B43/l
	HQiAKIrKWpKXWaIPvftrN+hsBddYqo8/BhoPbEIJnDYatfvDpxVQu6mzcRMHhCsb
	cD9xd34iizyXyw7ZUMPr/pRt8iDdzoy0YzDjrc3/NQ/s0cGQ3nULlAPU5ceCbhjR
	QYhR4cfTRbMdhThfybOWIbNWWZfpmSS3wV6qvYJf11szVThXJ6FnPrZdib7Zkm3I
	Rqr8woVXeDKTcskMPPaLONWEv3XJh2bG3FsoNg8VzpbjNy6omtLPv8paikaCkQcN
	jQEV+acwWjQG6hhszbYZvTMzLIHwK/NZR3uQaEMEjckWGFcP9xJCAGCmfovw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771589117; x=1771675517; bh=P6fqm9VZSFhm3trPM89rPz+lBRx/Ge3IMeE
	aXLMAyrE=; b=bStLsvilO9VJ+D2ojMUeL99YrrYw6EJZyVfVpTo+e8OLcQtZEXW
	NBUCoPSFq8AUP98GcQZ0fFD76sFe6KUro/q4KI8jXihkwjKKwjAGcAd7oJlxhi7v
	XtEI5pJF2lkUU/dUdyJ1DM/NLD1D23yCErWi2tko0pLFYnIKkwitIJmu9YISQrRQ
	0leBbHrTV6lTUUKNfnr+fzhS3B7uvLA9oheJ9qSwJoZy/3lTbUcedntzsoz30Q4y
	ljweVizNG2kcKoDWV5mpU9UA65I3XmjlDJtZn5Ifne2HJtWwwcGEtAFvDvozh1w7
	mZoROmWCbWsAvRxbTMenvNodRM6p7qEuQtg==
X-ME-Sender: <xms:_U2YaVuP8xsQSXfv4LaGeLxIqSewXy7YSPmAYVo2VCXK1kKZJzjOyw>
    <xme:_U2YaRvU4f-fIoSVu4gg3RzQLHRoHAPv2ZMzG3vFGqCoxqpoUFIDdjB4xdh83oOfd
    HRJ5wRgeXy645zIaoVQGIinEVNaUIfip-mk0UxWmhiD1pVccSl7Zlc>
X-ME-Received: <xmr:_U2YaSMVZrOuuCloIKjKnFVIH3cWfGXJY7pq1tkC4Hq_CUSEc_Bh-n_HMNuYj-pERDidLmkTFVBmHeD9Q6kOIMoJ8lCEGnl7qp-rbaG6iv4D>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdekfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepohhsfigrlhgurdgsuhguuggvnhhhrghgvghnsehgmhigrdguvgdprhgtphhtthhope
    hkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:_U2YaX3tGVplZt-59acQvdeSN-IO1rMYjPBkaYS8OT326icMsFV4zA>
    <xmx:_U2YaWPtNQiqycqmrDT6tEPeVW9M-G12BAcngE6uQIhdx4j4XSH1LA>
    <xmx:_U2Yaf0OVBGmux2SgtSP5nB_HhZ4GRnAgcPLpPUHPQQtD-gZHvMt9Q>
    <xmx:_U2YaVFwrIC31Z0nHELi_1eE6zhOm6-a8KfzohrZ1j-gGhFMZ95wXw>
    <xmx:_U2YaX07RG0-Q791nm23kZ54Tkezkvl8YoPn1c7B-mW3Sc3SUleVS93O>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 07:05:16 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 340bbd11 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Feb 2026 12:05:14 +0000 (UTC)
Date: Fri, 20 Feb 2026 13:05:11 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 05/17] refs: remove unused
 `refs_for_each_include_root_ref()`
Message-ID: <aZhN934uXU_eGydk@pks.im>
References: <20260220-pks-refs-for-each-unification-v1-0-17170bd99de1@pks.im>
 <20260220-pks-refs-for-each-unification-v1-5-17170bd99de1@pks.im>
 <aZg3krJEqj3Vs76p@ugly.lan>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZg3krJEqj3Vs76p@ugly.lan>

On Fri, Feb 20, 2026 at 11:29:38AM +0100, Oswald Buddenhagen wrote:
> On Fri, Feb 20, 2026 at 09:24:09AM +0100, Patrick Steinhardt wrote:
> > Remove the unused `refs_for_each_include_root_ref()` function.
> > 
> at first sight it would seem sensible to move this to the start of the
> series to reduce churn.

Right, that makes sense indeed. I've queued that change locally and will
send it out with the next version, thanks!

Patrick
