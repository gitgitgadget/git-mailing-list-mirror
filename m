Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667EC425866
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 11:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787138012; cv=none; b=l/pV1VNOENG69ceXBXebkOFhG50hvubnthKAGhhcNxLElDfxZGcjDNvAgmFmkfOXzkZC5eUBmm/TztGjEnb+y2f22szr+XYozdFs5TrKA6MOPAmr3FB7UV5imq7rwbptT/xRi2FFLPctURZc6NIQRoO1M7hLTgSCs+/qSNFQ+sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787138012; c=relaxed/simple;
	bh=vR5q1ps+Kk2iCBlSke5Gea/M/JOrW88cMnr9l4NRwgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mg2Eeij68H4KsmoPBbpe0EuTDP2aQYVu9wSOYJ3mz0zn4EQTlQrQzGF860K3eCZr+sFmEUlEQw7SXD/tYtiG2Is6J+yyDXnWONWLBYd/4q8TT9FYYoeDfM7If64pOdESDh01KOc8Uo+l6l0fK4MHy3kLb381lyBawk23XAX2Cw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LApy4ufR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PRfbXRiP; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LApy4ufR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PRfbXRiP"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 5C0171D0012D;
	Wed, 19 Aug 2026 07:13:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 19 Aug 2026 07:13:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1787138010; x=1787224410; bh=1q02wSHkby
	g+cqvVX0fHr3T/FRttbOle24+zxXiinMo=; b=LApy4ufRVytSmslJAIAbRUV1mr
	MbMnRazzB0SqDv0R7Pte/qvMTrV+cfaVUGCgdiN8z9XIO9xcAIsW+HCDa09idYtF
	FAPZNwZUdZK4dbEbnsVVNFmN8h6yGTlB9jGI+FYuCnUmffCJ+FkcdiQOdOixzdlg
	+BrFP7SxWR2UsELiGY/dFdsOC+TnrHQ6EYb+XAKKylHxrAZaVlUr6cU/YcJ6DfFK
	TmcoWxMfhsoyyxQcvS6OUDSsvkxDjIWKiajt036qEzE/akrfduYYAI87kJx8rzgW
	0Kp+S4gih5utbZRgmUUGZhdyZiho8W+RwDT/1ktdBsPXu0F3wgAk/XACyrCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787138010; x=1787224410; bh=1q02wSHkbyg+cqvVX0fHr3T/FRttbOle24+
	zxXiinMo=; b=PRfbXRiPVtssMdkIx3d5/ppSoyq+qRq0fx6Aqz47i/NmXkJsben
	q6VVbwTmLpkYTxFP9shnhICe2JRaGn39TG1R4cqthRv8g3vC+Dpkxf7aYsvx5cp6
	4wHk0/vJgVPQvfrxlZrESA4/xGIg9+IiewpuMQ6K12DsCbbBEbAB9DT9f5PK76xl
	83StIgDgS2QmjA8CC9UIQnRiTbO0WYXtD6bC4oxslqf1mgwnC3wHROcUwpjCwJkd
	VUM/cqKScu1rZ72Lcmnck1619blLJu3NfqKR5dCQt/QxWu47ZolX5ZoLtR3mBvfM
	NLl9ZgAMpNF5L7Dk4r3endmLK+z4WyvcChg==
X-ME-Sender: <xms:2o-Fakh2Sr0b9r5-Wbv2x9NC3iZMtt_-a0KG57uTVnwdnTH94ZaTPQ>
    <xme:2o-Faj7zhRQvV0Bj_GdKW8Vvl685IzD214Ch7uDFgZ5rhWaJi-EtplDZ6VAFRL9LP
    2pmdPLUjpZRjl8oZed4NWsqlQS-mvj_i5bXC6npli2sNXRAduO7>
X-ME-Received: <xmr:2o-FakbYzLl9UiaXC21HPjXq_kWIN3wWEhIju4zsWVDJTlBkWEuYI5iEc9dWsaA9CRjcfUUHwc8YrKFUhUTd8OOC0ru3j2fQMvlasQ9F>
X-ME-Proxy-Cause: dmFkZTG0GEY6axZ+Wn4O6te2LRprKx+5AO1GpxasARdSbtSSbCuxSzf7eLahirAFwGnGh2
    lqan/ye8fHcr4XDzWztY2fPWUPgeWlCWKAB8/+JBdPnXRDyUxYHtbEx3/sozzPHgFGC6Lk
    ozMy9UecR1xlVpfnkDA+DS3hL8Alml0BXz/+BZ3ZnuCvaLF2quc/BTppB4muLg951W+3UD
    rstbVTzgggmjeignE7uQ/dAI5rdnFO+1Ypv8fqk8GRrvXvIqLtb9HU2YHDF426s3kK/5iH
    Yq1Fwt4NQigpR3pvZJcyKy1WIv56F2C6z0QIAjm4NwMifROWLF3rhjWMW3Hg9KyQ11O8Fv
    q5fuYXaVdsQDGRTDJPPMEZlKQJZFtOIgY9p7DhxfPmQWrkDrJsVM+2lwASaFTDxVAdd6Kb
    U678KWRnfNTUidhE80oKp8R40Am68umfrIR8fNPQaad9uNtX3MjqU0QKnS5QXQEMmOkCt1
    tn+w3fAz1Xd8+JkNd3u2+rim3Slz851r7sZ6EiAS8UXIkw/IuYJ0haI1lgVvcvAv+lwqtj
    rnLljjY8+O1/D9C46iwSa1zfk1R+9zNnjlqBuUPAVUvHaxizTKMBLD0+g0w8f7Sp2dAyCZ
    yj6GE53dOoLd3Jc7oca44HRnpKGPsZuHqV4un4n880KSmxy8E9THr5oOyngQ
X-ME-Proxy: <xmx:2o-Fag4ksMBYgTCWDy1gLwLPUR_fgoTpV7WtEhaBWxN4ZKZoexJfOA>
    <xmx:2o-FavCqYeGnrd5dYsLfJ1Q5wUnVkbJZHKx6STalfEaeX4Ap9rRFew>
    <xmx:2o-FaufBZW9hnU_tE37FWtbaMvZOMVjcYyMy5qlvjia8EHbG9eQIrA>
    <xmx:2o-FamJhtkPwEBn04dCAlWtgHxVNPepe1xxmg0zJzEEnu6rihRiyBw>
    <xmx:2o-FanQpfs_LuojfK408bJaIAO9qU9oo8D5bVJC18V1-7vcI8pGOFJax>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Aug 2026 07:13:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 88d65c89 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Aug 2026 11:13:25 +0000 (UTC)
Date: Wed, 19 Aug 2026 13:13:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Philippe Blain <levraiphilippeblain@gmail.com>,
	Ben Knoble <ben.knoble@gmail.com>
Subject: Re: [PATCH v3 1/4] completion: add 'git history' subcommands
Message-ID: <aoWPzTx0OUgg0mzH@pks.im>
References: <20260813-history_autocompletion-v3-0-69eed1cea93a@kernel.org>
 <20260813-history_autocompletion-v3-1-69eed1cea93a@kernel.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813-history_autocompletion-v3-1-69eed1cea93a@kernel.org>

On Thu, Aug 13, 2026 at 09:05:02PM +0200, Vincent Mailhol wrote:
> Changes in v3:
> 
>   - Ignore the split "<option> <value>" syntax for options that take
>     arguments. This simplifies revision detection and avoids hard-coding
>     option names.
>   - Test that options are not completed before a subcommand.

Yeah, this version is a lot more maintainable. It will have false
positives, but I think we shouldn't let perfect be the enemy of good.

Patrick
