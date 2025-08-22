Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCC97262F
	for <git@vger.kernel.org>; Fri, 22 Aug 2025 06:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755843235; cv=none; b=jgYK9agMdiVA5wweapFhqfdqnAsGEA7yNsuSfX5XmHSSFuj0Ipw5pANGxuwUSkgI/5fqFqZBYpQMCaq/iNyaokJ24/HzaNcubjmwQldYbWRS7I+9XYNOzFDRin96/UDe9Gq+9k3A2yMbbn77hg4ydXzwBgiCK26Yg1S9Z/Bs6VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755843235; c=relaxed/simple;
	bh=fCkY066KrKqrgq1hQHh1v/yEmaUsi/0zJVJ+Evbj2Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/Od+HWg/6sU/Bd9z40y2vc9xnDQ3kt8GVAU9UeLznd4ccUIZlRNq43cShwuwUEjng0B1tBOuUcANRTPbFMRt2QiIg/du3NlQC+aeeyi60GT1cQw9V5MfX07bRu3gUgRzvMN4BrtCdK3t2s68gmc3IWbgTrMmwj6x0o4EkDetQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FOR7AMJJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E0j/3/hK; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FOR7AMJJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E0j/3/hK"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B6E3E7A012E;
	Fri, 22 Aug 2025 02:13:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 22 Aug 2025 02:13:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1755843231; x=1755929631; bh=c0GGNipVzi
	oJnLJhPRPamfx1pLXwYcFbK8nFU4/R8QQ=; b=FOR7AMJJoPfnvxBDd+Sf6AkuWP
	WheOFKB4e7NiDIZVcYu76rmasvVrvABxYsTfijDteC0CQFtIAfuosM0DckUbrViT
	h2dUD13cWe/sZFPPYFCWEnodtmmmLvoNkW1d1ItZZa7NvUapqUZLwhidiyH6W2Qb
	Y61q+KboCjbxaqEr1xTfNmUoEErvoGDR3NYlxC9FqZFbKSxlnz7LeR3jCH9/Xtfp
	TLCKJH2r3OAGRQNJrDJIpJIUYFmItkClTT9mw3WcExkSabh9xGxJQwcvTNqCw+s/
	0NaHdGH2nteKA5g0PcamFrfsCm0S4Og/SJEL1em7uA9CFXPvKFFX25Erdacw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755843231; x=1755929631; bh=c0GGNipVzioJnLJhPRPamfx1pLXwYcFbK8n
	FU4/R8QQ=; b=E0j/3/hKApHO08BSwOsJiNzKHMACbYIGLDVcViDXPCbkh1xf7+r
	ClumsaLjTGKqAeQFL+p4ERTyY+N4I2d7URQEKB3LcXpxfJb7LmJS1ZEv0ZyJcqlu
	bffqGCYIshK7M/SZOw0UNE3NKl1Bux/7Ftf5AI/9qVcVVINZJEtmTsrIVUa/FHdO
	n6rPHI9GWW80hMCmHZZD16kH0s/phQoLsTZyze74u+8DERRtbC62kEVu/M2EXzZg
	K+7Z+1QIMmOAQfHkn59UBozoxG3ts4VMEDkoZn34OYkQ8UbAr2RE7mfDaWSNAgfB
	JYcf+G3gLf24TkVqrvbR3/gkOc+z04PvBUw==
X-ME-Sender: <xms:nwqoaEbLPIOgWXzBdf1LkcU3LAHJLH55U1mBYnd-KeD9rEGZ23sMZA>
    <xme:nwqoaK4DHjs_UTiMOaSCfBxQu5kRLnWyZsrnS_5ddgSHtEr1D9FEtfTdvMfb9vtpU
    1AaTX_U5O-mizP0Cw>
X-ME-Received: <xmr:nwqoaFYPH_HYgRfWQaeXyQk21BDjKv0KWI2Q2JtKSs-ZuUvPnirKVIdSLgZlTSPzNLIX4oTonrlTfBBdN88nr79LGaXawy-WKuACWxC9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieeftdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjedttdegffekudejjeegudehgfehtdfgtdeiudelueelgfeuteehledugeeuueevnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehjohgvrdgurhgvfiesihhnuggvgigvgigthhgrnhhgvgdrtghomhdprhgtph
    htthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:nwqoaJiIXn724pmecKVeZZzI_usOPOEFHxviJS_gLUdoTN_hJtdy-g>
    <xmx:nwqoaG8SFX3KZHIDhufcEYqi-rHOWbW2fKDsEGRMHH7P0TjLtJloXQ>
    <xmx:nwqoaErbFcfEeZ0Zzm3Lr4J6r7Nh6Z6ajY1WQXdHm13XrQLjNR0NSg>
    <xmx:nwqoaOUb_LJw1JFPt1TaIHX2JQe_3qrXzhFnt2GYr01MRPa3OBxvSA>
    <xmx:nwqoaNu1fosvUxD8AHrEHLDfhTLnoYpUEwFhUuNGLNQPV6eguMN_-CCY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Aug 2025 02:13:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 20868abd (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 22 Aug 2025 06:13:48 +0000 (UTC)
Date: Fri, 22 Aug 2025 08:13:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Joe Drew <joe.drew@indexexchange.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: "lock file exists" when fetching in bare clone of repository
Message-ID: <aKgKmLvaHAuueJeb@pks.im>
References: <YQXPR01MB3046197EF39296549EE6DD669A33A@YQXPR01MB3046.CANPRD01.PROD.OUTLOOK.COM>
 <20250820213323.GA1667633@coredump.intra.peff.net>
 <aKbHozlmDIqfgkg4@pks.im>
 <20250821072706.GA2390046@coredump.intra.peff.net>
 <aKbwabLZiWasYoBC@pks.im>
 <xmqqwm6w3bjp.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwm6w3bjp.fsf@gitster.g>

On Thu, Aug 21, 2025 at 09:05:30AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> >     You're on a case-insensitive filesystem, and the remote you are
> >     trying to fetch from has references that only differ in casing. It
> >     is impossible to store such references with the "files" backend. You
> 
> "backend." -> "backend on your system."
> 
> >     can either accept this as-is, in which case you won't be able to
> >     store all remote references on disk. Or you can alternatively
> 
> I do not see the former as a viable choice, though.  When this
> happens, the clone or fetch fails and the user cannot catch up to
> the upstream development, no?  You have to futz with the fetch
> refspec to cause refs your filesystem cannot store ignored in order
> to make progress on other refs, but that is making the user do more
> than accepting this as-is.

Oh, yes, right now it's too involved. What I'm proposing is to mark the
transaction as allowed-to-fail, and in that case we'd be able to fetch
and store refs in this case again. The result would still be broken, but
it would be broken in a similar way as before. There's one difference
though: we'd accept the _first_ conflicting ref now, whereas before we
accepted the _last_ conflicting ref.

In any case, I very much feel like we should know to warn about this
case and guide readers towards a proper solution.

Patrick
