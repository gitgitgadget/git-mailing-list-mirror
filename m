Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C860D31B833
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 05:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786424573; cv=none; b=IY4X3K/fXMyhJkiJq+nrF2HmhES2TNkvRD2qsUP3CfqARu4p3y9qnSFHBlZoyXMvr3t+4hmksNe8EpnXuK34PowdfFAIZMz7sJU3q1rm6D2iO5au56Z1PG/nutvygEFnNcsv0YWaKArzk2ac//zLMebYPCR5TGF8qcBjcGHuoJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786424573; c=relaxed/simple;
	bh=r7YqCUm/cPtA/0hBOsHJeSPvoDiMeBxybi3yTuXygvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FNxyb++K6R8PTb1h4BQzeJp3PztiOG44+4GPoc7Yxz0F48NwsxlgAcLblzWXtMB4lAKt0YyiRRnbOoAqf3gEFVl28NA5QtrQHInOj3g/ALE8XB5zjZC2Jxa6xiyTnj2rHzlKK5zVqWWnU8eRUFJKnLqmkHdvbFixyBxXGcy8sA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ReWgc2dH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V+dTSFAt; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ReWgc2dH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V+dTSFAt"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D9F03140013E;
	Tue, 11 Aug 2026 01:02:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 11 Aug 2026 01:02:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786424569; x=1786510969; bh=GX2fFtABEx
	w62xdo99A3SNYsOJNwTPyMrJUM7xWy/m0=; b=ReWgc2dHymMUitpz060DYQxmD6
	q66e/eGTd/iiZzsxbwk30B2cG4RjA319ksB/3dy6DI7y0Py0n1izN2KUpeDamGsA
	htEqekkkVZqLXTaMmFdgZI+BZreTOOfLzi01XEHFBRWsujw34DFZf3IAcYFbm0Hn
	864mWrU7X7YC8ouHyQ8DUrn2gZ5ba3GvK7QogaKaYl3TqS92YTzt39kzqUFO9EVo
	aqGJR/dGL8Runqmhxy7xj/5O/PCJo16iBmEShHUvH+XuK49o5ZwIo/lQcUG0JaXA
	cUC0g0mkDZcx8ejSVW2gQWGyqEraBEaOJEvxX9sbUokk+Bo7f9KrNKjaZIqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786424569; x=1786510969; bh=GX2fFtABExw62xdo99A3SNYsOJNwTPyMrJU
	M7xWy/m0=; b=V+dTSFAtW+KzXvcQaFy/T6fWz4ksgqHvpwTV601Tp4Zyk0/jpWf
	+NjQ0ievNeD7zA8xxwujqjiv7W+xu8uDjwVRUsxCMi/ydhJKkkcNTJY/gxEnfx+z
	bmk43wYbpSnjnhUANy5mzGHT5M9XFWDYaSrzfQFbxGPTW8k3pu838T1Yo3HqYRgr
	4MGDXVUA9LDIzGdKhOIOSksiUxL68rYJA5AecfzePf2fqZgPmXTsUZNuvG5jZubS
	jN2LCzl8Ah+tBcAbFRuNbIQpcCfRsbZeQ46s0/WFXMXpCdXG4lNtKqwj1Ab3oUXD
	8I1DYt6vk37dhxdW4UJNe2GixX9DsxhkwRw==
X-ME-Sender: <xms:-ax6anMWLSoaA6BL-lvKWu7L4TeGoe47xpXiWmXiiDGwcEqGoMWiOg>
    <xme:-ax6aloi09oxW89shq0XQmVdaD16691JAqeg29jRbvogIxJaZXFZLBZ4twG7HK8JX
    mXjZ38EIQBUvH7Mnx4W-svu-lBT3KzQVNIoRFbkk-X4iEg86lnG>
X-ME-Received: <xmr:-ax6agHXfdzOH_klBTebyTFX5bAgAiOrbiTozrWfEk5Cwpim_Sks5QSzUDlbFlGuyDznA8fqQQTy21ocGNum9hVX2D6bapxS-7y3RAcMQA>
X-ME-Proxy-Cause: dmFkZTFy7aZTn5T4H+8dH1YbzKKILX4MvboJafoj72t0y0hbmYU15Saw6CF6ZQASQmzdvL
    cQtIhVGOyAuTlgEAfjiZQBzMXnXOoed8POogYpm4FK2kZbwQeLZlEhdkGo7/hYWtR6sDwv
    nGzkJFCqLsMKoO/LhAsY3DtDWeR8cIQp9xas2gMrehy0Jlvl65LA1TnpjAsj4kPUhxv3Ss
    SSJgxYr2j+zGSzgrYM5ZjFom/bMOi1C9OcMMD/2fDknp2BuOBDwr55D1WU64ducQGxnedt
    vqcKOdmjDkgfsVFOvufETMj7gT2m/ya69Y7Mu3lClnAxRzOr/cUH1PyaBLNEI8Y1HwU1df
    aktCHv70nDLdKypSR4FtHUgoXEtEr6HSwsI6XcSbKZw2dUmS3nB5kVOnJX33mqVpmhSsKr
    KJCvw6jbKb3vJJhvRU5Rvzy7DaCSCq8L2hlVIuT1+2mYoczcwUJII35NQ4IXgVkMGqzqmt
    9Y0BQEGwoQtjZNfudG0wjdv+2ByXCMrBH+xWA73wdJuaOC6mTg3K1aj23TUG34bYtzqo7A
    r6JjHzzjbJBh7RDYWVEDQWnaDly+9bTea/1aYAfS6+wcmF6Gh65nZnM1je5uDAlbQthHsV
    R6SyIoPtwJ5NS3LqBaJUfwLq3i3KBwe0x8I5IWjQvJ/aSe7IaeAiGaM+Vn7g
X-ME-Proxy: <xmx:-ax6airhmOfmU8sftrEnRhrx77vmZ0DRKWUcEngtDw5stWKLdsCPPg>
    <xmx:-ax6ahZqkVt2dT_QAg_7d4-R9vq4pPKjZTb6G3JLSMkoxRlAKjxrxA>
    <xmx:-ax6ajUOshGf07pWCab7VQ9Tl0z-SU5tevOfWga4Nu9KarjLaoOvMw>
    <xmx:-ax6ai8heJ7leJJ7PYUwhhio7WG-kl5JYMfEvwzPKLkhur8E11CMWw>
    <xmx:-ax6auEnc44izQgd6fIh7QkJ8UbXFek33monoCS48wsd-4TaMI47ZWKJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 01:02:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7dec2f31 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Aug 2026 05:02:46 +0000 (UTC)
Date: Tue, 11 Aug 2026 07:02:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, tnyman@openai.com,
	Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/2] ci: bump ubuntu image version for static-analysis job
Message-ID: <anqs8mT78znJmUwJ@pks.im>
References: <20260726083254.GA3528497@coredump.intra.peff.net>
 <20260726083905.GB3529069@coredump.intra.peff.net>
 <anWyV9Q4Cmsa5AoT@pks.im>
 <xmqq8q6hgb2m.fsf@gitster.g>
 <anlj3kdAfOh8OnNR@pks.im>
 <xmqq7blx7tii.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7blx7tii.fsf@gitster.g>

On Mon, Aug 10, 2026 at 10:52:21AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Taking a step back, I do have to wonder whether the Cocci files have
> > been adding any kind of value in the first place. I myself introduced
> > some of them in contexts where I made sweeping changes to our APIs, so
> > that any in-flight topics can be trivially adjusted via Coccinelle. But
> > I very much doubt that anyone ever used those to adapt their in-flight
> > patch series at all.
> >
> > So maybe we should just not do that anymore?
> 
> We still do catch when somebody writes "if (a == NULL)", no?

Yes! What I was trying to say is that we maybe shouldn't add Cocci files
for temporary migrations anymore, but still keep (and extend) them for
evertyhing where we want to consistently catch antipatterns going
forward.

Overall I have a feeling that I'm overthinking this though :) Maybe it
ultimately doesn't matter too much and we just continue what we're doing
and then clean up every once in a while when too much cruft has
accumulated.

Patrick
