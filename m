Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14C2214A93
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 05:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758174739; cv=none; b=P+gw62WMiaW14roi4TM629c59TjOuyMJHcDM8R2hK2JD+M1JUfT9IDk1+kJqlbxndPwIku1MUauYL0k/B1QR2FLZpyzUU7f0YmzCpE4rmtNHfqM0cmSBf+SzsIeGSlny1iqvZHJT8nYC/dwIrf4Hef43UDPAReiJ8brtcPcIlQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758174739; c=relaxed/simple;
	bh=fskVEYQyRV6VgwHW45fQETC6ij3/k+90cAmYyEVcpg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YfscXxW9noHf1BBEEu2U1Py8DvYmGHnHBDJZp4IzZ9IQxdDS9N7+3bLVGELUYDZ+f6wwx3nRy8wB9MHDlLmuaFkY+PVc2iQ2z0vfoFmguwqVQKgc5D0yd+skPhL8qMyhCBCr2o0V56Q3DcUBOm20HYYBasxIUjSUNsNzwQfCWaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VCDuCoEz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hfv26Sv7; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VCDuCoEz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hfv26Sv7"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 91F311400276;
	Thu, 18 Sep 2025 01:52:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 18 Sep 2025 01:52:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758174736; x=1758261136; bh=+Y4QgRQJcM
	a51JHapOlyRVrfjlt7bSsyIjAGf3OqXgw=; b=VCDuCoEz/BO8vYaqPzruOuFkWL
	TfRpfIbra0RTxwd3ZgmSdnljH5kH/DnzahTvQfSWKPmJrW+DvsxRih0T01oOYaqx
	2gKM8uyNz3AtBbVrMGfzefYmSW/JXO3xaX5Ii3j1bYmQcj/0vldvHKZzw+LOEEC+
	YRnHXoyuzL+WxtujyBWQS8jOinrvOKzlENdaF9Ut8QawjQSg9xZLzVsE03bH6amZ
	Hn4i8oG+4F0ff+bOQzBDTAEo0Th5cS+/qgZIx3hi+bvz8BmGcE4KXiBUuU2fxYQl
	A7z5ubvpLBSRcok08OaM9XMARp7v9JyCiFkrqfXiuQXOmU3GVY8FRWzFwn5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758174736; x=1758261136; bh=+Y4QgRQJcMa51JHapOlyRVrfjlt7bSsyIjA
	Gf3OqXgw=; b=hfv26Sv7TeJcsaX6a7Psi6uYObyAonqqmiFy7t1bquCMAwWsrzA
	eMf3xW8gA/h0yK+O9URtl/K4SFVKXdcWYH9M4np85zYXHr6qR3aDBx/q0FQap2Cu
	k+5hV68tPynjNVJtS/KT7chKu55lJplJaI8xc+k7jbZwD7LVWcpdYNPD/OPyb3H5
	hltpXxFrhkXwm3TmBObqh5b50LSc6tA/B4b1DCwmIVjdOwymqHOYA9B0HddzQQoa
	3vUJGEnW1FaXHClYG76kOnH8if9OoC4eNo7m0rOcVwNLXjWmJkAwKpnzL3IiwG1q
	JoobFBKblkvJ0zC9Ykg7wOUVpO3MqPmgDlg==
X-ME-Sender: <xms:EJ7LaHhgM8xrFKJfQGA98rTdO9xOG9JtzfNC0XN611Y_GrlVzyJ5Rw>
    <xme:EJ7LaHTrqU22LEFu3D0fXRD0w2B6eZDb-cRQRFNcJenGoRDOZX-qIrkXEYf8SKjnB
    NEXgv2nYs-L21jBsw>
X-ME-Received: <xmr:EJ7LaAj8nUpzLGc_35dvEQcblxdv993CbkhTeHd3dx5ynY-xzsVW4AlQwGJxN3KjLGeY5r-GbtVEF00QtOsZfO1lOjsar3PfX9UIvllTJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegheehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepph
    gvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:EJ7LaP76dGe8ETakk21T2_jwFB2xpv3BRfrR7P33soAkSsQacFLO8w>
    <xmx:EJ7LaFCTCNfL58Zzxh-6PEtwxMNb8Y9bZmpH0yrr8HRX8slmc7Ipbg>
    <xmx:EJ7LaOaik95G5wtJmIEyPmTyWR5WMd0GCpV9-2sb4AGa1nYRjDNGAg>
    <xmx:EJ7LaIbAbWzo6zOu8hbBawmHqQEfccxXQ_jbd5plDiP3m3F7QikuFQ>
    <xmx:EJ7LaLU-AGUOhK6J1VaB6eXIXyeeCGVdg3J4KS4CmFc9Nzrc1bcQrXkY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 01:52:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0732d02d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 18 Sep 2025 05:52:14 +0000 (UTC)
Date: Thu, 18 Sep 2025 07:52:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2025, #06; Mon, 15)
Message-ID: <aMueCwl6hfZRJ_qN@pks.im>
References: <xmqqtt13frqm.fsf@gitster.g>
 <aMkJVMbSmeA4cIAy@pks.im>
 <xmqqzfaunzjo.fsf@gitster.g>
 <20250916164912.GA15474@coredump.intra.peff.net>
 <xmqqv7limi1b.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv7limi1b.fsf@gitster.g>

On Tue, Sep 16, 2025 at 10:19:44AM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > That said, it is not really that big an issue and I am fine with any
> > fix. If you want to document how the history unfolded, then I think an
> > evil merge shows that (neither topic had a problem on its own, but when
> > merged we needed to adjust the result). And it is probably the least
> > amount of work. ;)
> 
> That's also fine, too.  Let me try that ;-)

Yeah, an evil merge probably is the easiest way, and I see that's what
you did in b501ac6a85 (Merge branch 'ps/odb-clean-stale-wrappers' into
seen, 2025-09-17) now. Thanks!

Patrick
