Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4345832F757
	for <git@vger.kernel.org>; Fri, 21 Nov 2025 06:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763706729; cv=none; b=KMx/NGSgQl/GaP9W7WMqylbVoYgDEMx/iEiJsOn8P4VrIcaUJHIoB+weNY7qYU3QASZAZN2UTkZi6haQTSYeq7rl9wOKEiDWA5EVJTfg0ebTWoA+GMHrqZcniuck/wd/EtOf217f/a8gkw2EpCS0Iy2NgaXNWrMOqy+duWVculk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763706729; c=relaxed/simple;
	bh=ACJ77+BW6g+TluzEvWU+O6oyParewmvPxQWRRasa1PU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3HCEL+/hd/+FAN53bx3lAn7SbMCbsU4ExpU29ZeP903ZYjXwmmZHPNcl7WAZIUggP3eXYi0BPfXo5K/wqDzTj6r0ffw7LsZIO11hrdjLHuItGASs7OIwhsshb2X4VItJtw6NMhSJgvenIGc8ofPd2TSEOqR0NqLex9SEqftkUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ni5ahpiE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IynrC6oJ; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ni5ahpiE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IynrC6oJ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 5B3951D0021C;
	Fri, 21 Nov 2025 01:32:05 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 21 Nov 2025 01:32:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1763706725; x=1763793125; bh=47yXKRKfpe
	rn4a4aAap2+qTskiuam5UVpeL23owUk+M=; b=ni5ahpiEugNxctwz7jyu9Ft1my
	ckHaJTDhZ7wxSvVYq+2r4aro0MDnEPgPOLft3itCTZ24WhWk499oMfTESMcdUNdh
	D+jt1tBUQIaFWaWLHLUBLoqeOB7ALMvSi2eu/cFHnPgT6sMgIwiJ2HKvzLhY9B+L
	+sEoo5F2P6U9jWR+dJoFAeCvvCiproQCu6NkSYXzoINyg+4jNSet0Waegx+x4wgN
	mCm5r+MQpU3sOhI1QZobE0L58KRDeNCvy/3MxbXiFP+KVUecA7cNVbFLs5kQDdiD
	yMFUM3WrKaVL1XB9JqSOAnkGuUyuftG4PcIV8zgLGlTGZggINKjrh/9aeECw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763706725; x=1763793125; bh=47yXKRKfpern4a4aAap2+qTskiuam5UVpeL
	23owUk+M=; b=IynrC6oJfmvTXis3DbDZz2Krg+KzZZsN/gndLXRcJFPByUVys1l
	f/dgDXUi36VNRL9shJIDCV+aOuroKa2wioVilL4FNbIkD4XQx0B7sphi5tTox669
	MKZ4vrRF0O/No54ycDwzJHTWu8G6PpD7tFvZFnsfmJAFAFRNtmnfYeAhTaoxC+Ev
	ANMV6zAhJAtsoKD6eXfbUcP6BSh8l3EA35ovplaEIn6ORD8eBfmEgL8IIziLXddT
	kFVnlKzqIr3wHf63XajNHzZ5m/UItIl1WXHJDAkkE+DuFwdmNd9v3SLB5R3XrTZW
	FCkYSZNFG9PSFDGSwV2qxiypr2inZsvnIXQ==
X-ME-Sender: <xms:ZQcgae8IuwVFkqEhA7oHvcIaiGJ98plP13cn-02QpYd33y9_Qn_rWA>
    <xme:ZQcgaUsnkdGKdNu-rVPPVOG6I6EllnafPBl2boFoAqSEiK56S7EOK3Hy9rPEQfFjc
    utrGR2BwF5R3ioqUKF-nr2mM-QGqHhJL39M5lnhhiNW694ThX7w1Q>
X-ME-Received: <xmr:ZQcgaRoTiBvwZQR5dLAqvRLkTfd0wS_3MLXuRTD6XYW8yqnXdT58Ed66gtE3ABKUCI7uKWlcfZzdl6BbvARGNTurVJOS8EaNiUmKvmujo1Q9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdelvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjedttdegffekudejjeegudehgfehtdfgtdeiudelueelgfeuteehledugeeuueevnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ZQcgaRnH60notjEnp3k3Bcl-PA2kzbz5OEdQEXwZeKtnNn7kYb3N-g>
    <xmx:ZQcgaVy5FnGfloW824MXzX7wbDy7qTC9cU8PwXxw7jF-gUbDH_zrtA>
    <xmx:ZQcgaZl_ndf2P6gy3OrLHTZifglZKovvbmGDCrEOWlx-wZuuBsU8Vw>
    <xmx:ZQcgaed8U3lDTEd8NBuloLFWavQ8QVlcxh9qBAG9kpj0tWdgvFM-RA>
    <xmx:ZQcgadu6jLaJ-z5yHBAb3GQTgrTblNr-JXUFV5js8E7fVSOrw5HS9b-->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 01:32:04 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bc919f28 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 21 Nov 2025 06:32:03 +0000 (UTC)
Date: Fri, 21 Nov 2025 07:32:00 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 02/18] streaming: drop the `open()` callback function
Message-ID: <aSAHYNBCMwYsFMYM@pks.im>
References: <20251119-b4-pks-odb-read-stream-v1-0-adacf03c2ccf@pks.im>
 <20251119-b4-pks-odb-read-stream-v1-2-adacf03c2ccf@pks.im>
 <g74hupkwedtclb3gxomhxj6w4rqqzn3tsostdriauvn3gu2cw2@wxgwulitxbtq>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <g74hupkwedtclb3gxomhxj6w4rqqzn3tsostdriauvn3gu2cw2@wxgwulitxbtq>

On Wed, Nov 19, 2025 at 01:01:03PM -0600, Justin Tobler wrote:
> On 25/11/19 08:47AM, Patrick Steinhardt wrote:
> > Instead, drop the callback entirely and refactor `istream_source()` so
> > that we open the streams immediately. This unblocks a subsequent step,
> > where we'll also start to allocate the structure in the source-specific
> > logic.
> 
> Out of curiousity, is there any reason we would ever want to delay
> opening the source read stream? If not, then I agree it makes more sense
> to just open the stream at time of its initialization.

I could not find any reason -- it's not used anywhere in our tree, and I
couldn't think about why one would want this, either.

Patrick
