Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3BE33987E
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 05:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790660748; cv=none; b=EQhuRSlCdT877n9D3YDDUN3W8vhYtTwOx92svGN0xfVKGQ5jQVgVOhAK5QBYC07b9seJ6jedwusgw9tugyGZrD5/pHYIF8ptIusQLcuODiQzXSLHB5GvQuAFaUVj2Ih0G4kl1NLQ4b0WH5WA6yICzO32EZb5a7c0JwXvA6qt2+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790660748; c=relaxed/simple;
	bh=MowQgbqWDvELk2vOoO6iT9ScOzJr0PDISDC9im3/SJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NyPeXvzdXPrM9dKqeo6uuzBy8ywIlkCFAurQRdFdKZcDNiB5rnag8w/eu7LKQEoKaVbXkkZ2zah9S9QKCB5hanLiBP2GSOuS2SUxYobBnl5jaz+dvBJmblSugPLBgeRpgT02/+/VnwF4t65YvgeTBEgsnJtrbvChb5yp+MARUNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JbSROfRX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MtktLrmw; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JbSROfRX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MtktLrmw"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 668397A0113;
	Tue, 29 Sep 2026 01:45:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 29 Sep 2026 01:45:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790660746; x=1790747146; bh=HMwLYmwewm
	cKYXGUAhsYZ1FN62jRSB6d11BwsHGrbpk=; b=JbSROfRXqJnMbDXaICLR9i4fb2
	hFHyxJ6E5Blu6gM18JoMYw98JgAQcoR3MV3Dobe3R1Z02iUfikgpniDsYThq702v
	ryewY5iySS7aoLVO9B6daSVAeEqDulquUVIaVLrb82F++ht5x9A/I+ldJc+aQ7gT
	pdGy7YQqW8DhWv2SjjALKInRQpOPrUICR3Ou9oR0zxNnHWeYHdiU8x+Ye38DYfZo
	xgys68wT2wQvxfZKGdr2zncT5m09sYsYywMHDIjDtx4oiSHg82dPgeHhpy0fWXZH
	PB6j28frntu2qKf/Ja1xf9MvG/um35VntOi8+mLgeAR0l6SwKKexzzlTMhKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790660746; x=1790747146; bh=HMwLYmwewmcKYXGUAhsYZ1FN62jRSB6d11B
	wsHGrbpk=; b=MtktLrmwO6hG4gmZNhtq0dBMt59ZZkDm11Ak77kO1LlCoLuAE6t
	VArEOz1eJ9fyV0N93PwqZyP+EtJY9JBw6MP3PkqNFHtKar3mXjudc4oVGHioHO48
	W2Piwq2/96txCx7DMbmoouT3D20Ehyp9BpBcpsu/n1793p/iSOivxhNAvp8WIL1z
	A3ZurN+ia9byH2OUMVcy/nbbmNV9exVWPv9x7WY3HwBGY0bxqBzvWUUTPR9b02Qe
	3qsQRw/lIKSwEt0QRTt6DwCOCcpq89Wy+41Cis/w6reDrDSqSK8VbeGZHYFtCsct
	SajyZ6wTJcang4MNE9X/SERX7lRIXhq9chA==
X-ME-Sender: <xms:ilC7akH2X0FdUOR8ZsU99I98VKAOZnQ-D4Kp6TyvPyT_vtmgInUbtA>
    <xme:ilC7akMmM4pzTJpuxBbzHSRTLxlZ9iq_5b_TKiDXkt4hn1H0gWI2vEwiqNzXEvIOo
    27fLMYxkfl4wmnEfJvCPW8Plx6sr9dmaSDVWymw21ialU7wODQdGYU>
X-ME-Received: <xmr:ilC7amcP_s67ZithpcD8_BmDv5d655_-NdPJCzqvJ0L5EyA4a534Nw>
X-ME-Proxy-Cause: dmFkZTEZZ3hbM2N2fUBSzi/Eab1KOT2cL4hnYLOqDl3c6QKIkMM8UhATkKjaA2bTsLhL9N
    yLEloME+ZXQcoA8TtCsEizMlu3cYWatL3mv+kNwQWiQBRaVL1tuA58kPLQ6GQrzLuWRwDK
    oELgoH0SkpQ9nKa+eJQXKydzM7mvmCSBJDTc48OwkFCPQFZbDqFgo6CIiWBdhVHKCqKAVo
    ctaniQnci7YGK7Lyuj59H03QTunMzKu9SRoCrUaNOaMRJo7VFq2qVZGATq1i+E7omSlwKk
    GETqtj4z1J/rXu8ZEpAe7OeG2lNYr1ExnDEaXoT1ETt9frgbdM1M6Q8rPvLP3IcJ/z2fCG
    qf2DKNuoSEQWprOtjd/CVjWX3EINHqzUwigjP1qGyVKOlU7RVG9Kyut10tZOwRKwSL15Wt
    snH1KxlfLqSBCBtEOrGAnxxpye7b7005WbgRDQY99fDV3h0yvSJOiq3kwgbEN7kGRiRECR
    QW2wTBMhTJQ5sih8L5qJjXhb3scjnU+Kc+L77whyEBdCjP6+MtH4OzpwRFMV3CXckSmg1Q
    emrr+BKJEiNxvkBKFlOmeZaYwJ3hCD5SeLnRpoCLyozu0S73G8tIobdRR7T4pevVTKLvFa
    bYl9iDuVzo4wtzPObpPrP6x+XGHnKVPr1OzQa6ykpflXr3HIJPtnEgqQwSfQ
X-ME-Proxy: <xmx:ilC7ahtDmG7cuZ6KdPpF82m17cbPoNyuu28e_KY-dbhVHelrDI4JRw>
    <xmx:ilC7anmRGF_HjHI5ZCP9HX5p_n9or342V3S7HrBgXJTaZS7v_VumQA>
    <xmx:ilC7ajwAsZ0mJ63HhoUg9ICN1H6q0AncyYaPo908YPlCPmgvfE6bjg>
    <xmx:ilC7apNJHMCGaZG9Pk5mu2YGNbHjH1kyiozsbeMC2OF41KXf3gpG2Q>
    <xmx:ilC7agK7b0YPMtPl7dBNOtJ2oCGNXDOrGX3VXBseAeIsADCdrw8WWK-u>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Sep 2026 01:45:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id abe37686 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 29 Sep 2026 05:45:44 +0000 (UTC)
Date: Tue, 29 Sep 2026 07:45:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Pushkar Singh <pushkarkumarsingh1970@gmail.com>, git@vger.kernel.org,
	peff@peff.net, r.norouzi@proton.me
Subject: Re: [PATCH v3] reflog: fix default expiry periods
Message-ID: <artQhZKf6JuRhmRl@pks.im>
References: <20260923102140.25475-2-pushkarkumarsingh1970@gmail.com>
 <20260924175843.8383-2-pushkarkumarsingh1970@gmail.com>
 <aroQ_zZvUXKKK7--@pks.im>
 <xmqqy0clo2em.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy0clo2em.fsf@gitster.g>

On Mon, Sep 28, 2026 at 07:50:57AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > On Thu, Sep 24, 2026 at 05:58:44PM +0000, Pushkar Singh wrote:
> >> diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
> >> index 8f78cf4b01..93b5b49e1d 100755
> >> --- a/t/t1410-reflog.sh
> >> +++ b/t/t1410-reflog.sh
> >> @@ -153,6 +153,72 @@ test_expect_success 'reflog expire should not barf on an annotated tag' '
> >>  	test_grep ! "error: [Oo]bject .* not a commit" err
> >>  '
> >>  
> >> +test_expect_success 'reflog expire keeps reachable entries for 90 days' '
> >> +	test_when_finished "rm -rf reachable-keep" &&
> >> +	git init reachable-keep &&
> >> +	(
> >> +		cd reachable-keep &&
> >> +		timestamp=$(test-tool date timestamp "60.days.ago") &&
> >
> > Nit: I would've preferred to make this 89 days...
> 
> Dates calculated as 89 days ago from the beginning of today, from
> the end of today, and from this very minute can differ by almost 24
> hours.  Because we are not interested in testing what semantics
> approxidate() implements in test-tool date timestamp, but are
> testing what expiry period reflog expire implements between 30 and
> 90 days, using numbers that are not too close to the edge spares us
> from having to worry about boundary cases we do not care about.
> 
> So I wouldn't have preferred using 89 days there.

Fair enough. I just find it a bit fishy to assert that we "[keep]
reachable entries for 90 days" by checking that we keep it for 60 days
but throw it away after 100 days. THat allows for a very wide range of
values that aren't 90 days.

So even if it shouldn't be 89 days, it could very well have been 88 days
without any risk for test flakiness.

Patrick
