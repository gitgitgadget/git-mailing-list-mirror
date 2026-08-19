Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DF523A564
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 10:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787133705; cv=none; b=giiqQy/eykDomf9PVgGAOxSXlLPmZOhzd4f5h4y61dDLBaSUY7MRMxPiE4rPwMBERS+uQmCvCzqTF9Pg38m5XJv3R9GuqZWWKrTljBho4iniHN5u0+HMcdfhTZkDb0Fc70bYXdYS/Jg3VG7YFhQq7DdZScejkzr9L1+Uly9MTlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787133705; c=relaxed/simple;
	bh=9vi+oIT4bNEsZaH7ozB+INaQHBdOAN0yDMB2UtTyrMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nrA5T5sb2p0lRxvimgm2t2ViZVRjp+JepEOw6+26Db+5fW094CA46SA2OdAYcgI97mpS1asK+DYjt8Mxy1kYd7sKuNDJJt0LRvKqv2R4/12NWrsfcyRYYWWUmnEv5HdExePdCJWuBu4wrfmM3pNS5DCbYmKUw1KOFJ69sNLJTXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=T5ChTd/X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lJGXruze; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="T5ChTd/X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lJGXruze"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 38FE51D00073;
	Wed, 19 Aug 2026 06:01:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 19 Aug 2026 06:01:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1787133701; x=1787220101; bh=GeaDg8gLfd
	Q6rD8ItlviajRD6huulIBT6i9XtbLkUrA=; b=T5ChTd/XI2rApAAVji9LujHyKf
	0lmZDcB14idM6yg5TG/gyTO4QTcXGPGH0MaalISNh6UlVZ+BuKBgQEJYdPzV8dVN
	W8bTis4rnwmDjIwh5ho7iNF6DQA3NzEfk+Wxp3U19TFWaYTjG2TUyewWWtgwWlYy
	Ha6F7nnBmbkiPviIbdlgMvkmsXKxka0Pj+zAwf0B4c5CgOnl493wtsjzJhqCnkGr
	PcPu13BI/AJv2w7mNAEG57du1aBHVjUPq4jyfv8P+3kA1YDDV6SZkOWM5TKEygaP
	PMx7EcUc5CUUPs/E5UnlJNWPXcSlLZl75hk8M+xynylgTUIawIgVIattQIGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787133701; x=1787220101; bh=GeaDg8gLfdQ6rD8ItlviajRD6huulIBT6i9
	XtbLkUrA=; b=lJGXruzeYd7Ogm7vFfphNoZe+II82YIuD0p1IKHEYahsp5JWbrd
	uTCvxiX05MZthVQXjn18S+UMwxDRTz/IjpoHF2x3UYs3tKt+oThDO0oi0ahv9KPE
	jFJmalf+Kuctap5SlMZvjj1iZ/T/25ru4uQ4/FgYkJiuWFzu1o9eTmCnVf229j0R
	bu1x4/Y1aXTXGeVqYwN/xC98JewtVdavkJbNcHF2xN0GODYnl+akcGt47tui54B8
	OWadnwVweI/O0FTalynfIPD5dqW/kyxprlzkx3FHgnVSLFe26xU8khr5aMGLQdPA
	4PjJP1yPVO4/NAMBLApGIEjTWcDSJ/zaxwQ==
X-ME-Sender: <xms:BX-Fasc075mIq-Iy9oTmshMil1jrAAyR9nGCEstU4X15FnCN25WBTA>
    <xme:BX-FakPiS4a7NAMWBxp_43MhTVF_1ghO9x-rjzZ0bc8JGHcS1d8HKKvN6hBw9Yqi4
    sj8yCDuaFx4NQBwhH_Xber4aol6yRemFnWPEM3d-DDG6ZOUmDvz>
X-ME-Received: <xmr:BX-FarJ-pD8U7KdVKAuqgOy9lxFiV6aGnuEGplWKQ-e0DW2PtAsISgDzgpdnfJLpSqvJn2bRT5i7WKsH0fWKH5G0euRzW87hIUcWYEjS>
X-ME-Proxy-Cause: dmFkZTEcxJxqjgnIJCOyLYkUaCbpc/O5ez8LaS1o30Qh5o4JHFJUN+/XKwdNadb6xFH2Pd
    ma7WnBaw+91Eh72CiQkykj1LoSg2N9lOD2FdA8fSXK+d1NZpXPhrSulO08mK2irqGeir5Z
    R0m/XzoLFgXo4cnXuIV5foeyTHuulNwnkU4JZ6haUqu/rnDlMwtkIWCTKrkcmo/1+TZTn+
    ZBzRoZlnq8mMyrSyvj4l6tkRSpbfhRYtSmU6Q3chmHFKHMXIZCdauaOosRSVVy9zhzEey1
    gjw8ZU2w3OW5jYW9bXr+EqNddz9BMb/07NqOBw7bwZEgRlzIqxiX6GahkJnDni7s1T5CpY
    8TdszfAMcAJZG7EeT1tO4QJeHCWcJu1bBwhKNMeTYJSiIVWGOC5jY8dgfinJQxjKy+3cD6
    Gp+tNJF+ZqSWeb59KRi3iRQMU+/dMQ3haA5tOlCSZLQCmUzb9sSflc0jARi2YZc2eYuvHF
    RLQ1n7KJ0V4E9X6kaYkk+fTY/Xd/Pe/E0DzJ/i/zx5wBRWn61KhcJ38am1dGsNs8SZVv5o
    azS0PjFIO++X7bsFvMwtBDnb63K2Gqy84ZouB2BMnaP0A++M9uaQfTxU9xxURw69NJ+7n2
    3xDyTIzKmIM+rtDrOuyIApdJ7+N+amrC427agnIvK/itORp8m0LVR3Av2rBw
X-ME-Proxy: <xmx:BX-FatEm0DJCboCRgdHkb0-UcKlUR3bHzSCNjTrSjavPALZqx2PjGg>
    <xmx:BX-FarTK8pVtqqHcseZM5PQNLAmEa_NI48DPtb2CCg_2U9vGG3odUw>
    <xmx:BX-FahHyBY6AbwPtTw4I69dX0P3MCCh814_XYJU67gIF_aiZJjyAQg>
    <xmx:BX-Fav8JRJFUVbojIEMdeNRq6_MIFwnibmELuw-PyrbrtEDeGeyyjQ>
    <xmx:BX-Fan0yOcpxm4A433C0i8XoIO0yqYA1fzutyLY-yKBwAsuwBRgN5qiB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Aug 2026 06:01:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4f45aa42 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Aug 2026 10:01:39 +0000 (UTC)
Date: Wed, 19 Aug 2026 12:01:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/7] odb/source-files: signal mark objects via positive
 return
Message-ID: <aoV_AEqPDiEwNLZO@pks.im>
References: <20260818-pks-odb-generic-corrupt-objects-v1-0-ec234567510f@pks.im>
 <20260818-pks-odb-generic-corrupt-objects-v1-5-ec234567510f@pks.im>
 <xmqq8q63xnl2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8q63xnl2.fsf@gitster.g>

On Tue, Aug 18, 2026 at 11:58:33AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Subject: Re: [PATCH 5/7] odb/source-files: signal mark objects via positive return
> 
> "missing" is what you meant intead of "mark".

D'oh, obviously. I've massaged this specific subject probably half a
dozen times because I couldn't find a nice summary, and this here is the
result. Will fix.

Patrick
