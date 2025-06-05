Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977B01A0BF1
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 23:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749166691; cv=none; b=SeziB/HRRYiOkL+eZEMCUnPGExB2jk881C6LVHAXV9d+kA3hfCMkyTEZmptaIWTIZHBA+HtXViUIGaulSY3vcFo+DxVF6GYumFV8ZnAp81unu4IwnHlK6JKZIeXDK9ZhxxXxvBNmOeBrqIS10hT0n6QnJI8EwUrpdYa/miVl/B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749166691; c=relaxed/simple;
	bh=MjpyD6HLODAyLOAXTbjIIzGPXgbxbd65MjcLhXTxX6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJ5E6Xk6s1GhjKZ6oupeESg3XNpl4bZjhITQ8MkUcZhFD70CaNdrNgGj5wB9k71KvsSFfXL6jlxWUBYrQi6KWjo6o0b8LOZuG2MxPDQxod0YqYshnzDXHxS/P6az+R6XkIYqC1E9KKpj+E6t1D0qE+2OSbcb3sLOobG5tVo8cpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pjnAG2VR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n6o87HTK; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pjnAG2VR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n6o87HTK"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8362725400CF;
	Thu,  5 Jun 2025 19:38:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 05 Jun 2025 19:38:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1749166688;
	 x=1749253088; bh=jqnukGUScMkTe/DuY0/7GgYdRQYVx6eae8bGqIJlkwc=; b=
	pjnAG2VRYD2eScryAos/Cu4zFFN5GmjX4H6YSwanft3HHo65ax4090z1BMHnjWBc
	4K9QlM6IERyl/gDCpmb6hnBOaxpuMeeCBPGPWK8niox7fEDwra1qSiCTTFoACnIL
	NpmeE6Q28tyFuL30+uDKYdjemWz10K394gAA6SirCLI+vGCZYEylyh9no2g0gbDV
	1DtBU7AG3UFIcnnhhztfP+M12uqJcRDT2xOBwzYIBy/Hw/6xIZ46J1PNjI3OicZA
	lD271yLKPBV9fP0PS9+D16aX3bCQlu4BKKbMQ+1PKwI0zuM4hvrDETPi7QdWBoIX
	8YDe1WUFRwObCydeqzbdgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749166688; x=
	1749253088; bh=jqnukGUScMkTe/DuY0/7GgYdRQYVx6eae8bGqIJlkwc=; b=n
	6o87HTKktYnY7nOTkvkyllynbQA1ZImdHPnbbpH+vnksVjAgNL86i4I6KQtp32uo
	x/JDPPXC9rOwIss8ON5QaLGbDz3axViptkFXtDign+JUOF4Xs73gvJtCDYRyDD9K
	VljU3uH3FmUJZmrEzz+80zmk1RlFeOHxRpv9W+FOFXJhHFLCjUnO1tyZeKtuWb+C
	TjjbTw6yxoLLLSpOkpxm7e5IYcpheEs/Jl1l9/TuFp4JX7Xa5VL8miPd8OerTI/N
	7vdx5CRfgPoR2Xlx/rL+2Q+IILynIDgOLsTQillwDoXWFz6Bgszvy4oT2phM2BEL
	DPWYf03YRT4eiPXLMsc5Q==
X-ME-Sender: <xms:YCpCaEbKaG_WKvr6xSgFO2nnYYeUJrVNyFhfCJuvwZM_MX43pOXKcw>
    <xme:YCpCaPYf1wmgSLO7ML925NWRvDnhz219tsbnyjKE-LmYXkN_Sjk_k9JuvokD0nrpK
    qSJYZCwIqUHaiKX5A>
X-ME-Received: <xmr:YCpCaO_3dzl8MiDEF1OE7mQc6MkNQQbmqwGEkTrkMGsGDxL2-rIEOvUe4NwttM5jTZkdk0Tr3L2m_RZJY3K-99U-9qZxCIPD7QAtrL0FrzKXVtKdJTOl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdegfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddu
    necuhfhrohhmpedkvfhougguucgkuhhllhhinhhgvghrkdcuoehtmhiisehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpefgheetleeifeduvdetieejffehteeiiedukeej
    ieehvdeuieeijeeifffgjeeiveenucffohhmrghinhepfhgvughorhgrphhrohhjvggtth
    drohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehtmhiisehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthht
    oheprhhssggvtghkvghrsehnvgigsghrihgughgvrdgtohhmpdhrtghpthhtohepjheith
    eskhgusghgrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:YCpCaOq2DFh1rXaGekq1ePRlq2n-1NXHgkHiSz_y3REV34mGxXgBOQ>
    <xmx:YCpCaPrhu7Gwn2Njmy5odD6-DjTZo4MDJYoGizZxgnO27wmezjNZoA>
    <xmx:YCpCaMRvZBkFYBnOX-3JbiROqjmvs_eLJepNJc_b4-CDt6sNfkL2Gg>
    <xmx:YCpCaPo_e3_QJ1px0bha8nA0kgBC61tCxk1e8m_DpW8kKlPLkeuHyA>
    <xmx:YCpCaK_91bGcMe1ty789sncngg7iR53vg1rwoXDa1iNc0KhJO8BkZnzT>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Jun 2025 19:38:07 -0400 (EDT)
Date: Thu, 5 Jun 2025 19:38:06 -0400
From: 'Todd Zullinger' <tmz@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: rsbecker@nexbridge.com, 'Johannes Sixt' <j6t@kdbg.org>,
	'Patrick Steinhardt' <ps@pks.im>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.50.0-rc1 - Test Failed
Message-ID: <aEIqXphU07pYjFCg@teonanacatl.net>
References: <007d01dbd4d9$356ded70$a049c850$@nexbridge.com>
 <aEBPdFXpIca7lMls@teonanacatl.net>
 <xmqqjz5rcz90.fsf@gitster.g>
 <44fe8627-5680-443d-bf02-a6e85afd46b4@kdbg.org>
 <010b01dbd5f1$3c26ec20$b474c460$@nexbridge.com>
 <aEFb0Sjj0Xuu-t7l@pks.im>
 <014201dbd658$4da75680$e8f60380$@nexbridge.com>
 <f2ed8920-347d-45d3-a0bb-df94ece0d9df@kdbg.org>
 <014f01dbd663$0ef73530$2ce59f90$@nexbridge.com>
 <xmqq7c1p7si3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq7c1p7si3.fsf@gitster.g>

Junio C Hamano wrote:
> <rsbecker@nexbridge.com> writes:
> 
>> Can I pass this in via command line? Instead of modifying config.mak?
> 
>     make NO_TCLTK=NoThanks
> 
> just like you are passing V=1 on the command line of "make" in your
> earlier message.  That would not build or install gitk and git-gui.
> 
> By the way, I do not think writing into config.mak qualifies as
> "modifying", as we do not ship one ourselves.

Indeed, I always considered that the ideal way to set
options.

Another benefit, from the perspective of package builder, is
that you then use the same options for all the invocations
of make.  This avoids things being needlessly rebuilt if you
happen to set them in build and install sections of your
packaging recipes and then let them get out of sync.

In the Fedora builds, we did it like so¹:

# Use these same options for every invocation of 'make'.
# Otherwise it will rebuild in %%install due to flags
# changes.
# Pipe to tee to aid confirmation/verification of settings.
cat << \EOF | tee config.mak
V = 1
CFLAGS = %{build_cflags}
LDFLAGS = %{build_ldflags}
...
EOF

['%{build_*flags}' are rpm macros, not something to be used
 literally, just in case anyone wonders.]

¹ https://src.fedoraproject.org/rpms/git/blob/ee7f0d4/f/git.spec#_545-582

-- 
Todd
