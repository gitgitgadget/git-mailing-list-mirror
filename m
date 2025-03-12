Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D077180C02
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 07:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741762872; cv=none; b=ZEH9rdnas0Rja9QQoiXb1VALFM3MaE6zkzjFpfr+i3M7ivV5ZLWQedXsnkVuoZ9uhn73u+qXmUADV7AsgcST3ROrmuB9g7u/WuBE+LaiQW9lgng/E4fmCCBb+dWrIuOId2RI9uKyBcA9nXp1YR0YymYhb30URbuRTTcyiX6SSi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741762872; c=relaxed/simple;
	bh=nkp5pKNdY/+CEeOs46QGiVAMcEsXT9DkNOaP1mPKUkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2fadM8RCogA4HN/sbAPni0uOQJkQ/2e6t19fhSzPSTHVD/lxyRHnU+unMvDR9N6oOkNQIF/X2s8kV+r0CF/UC9jW91sGeDimTPvT5FsMdODt+MArBDi6nicIVrDnaa7xcG/O8PKB1NFMtM6K1B5xDfyam9rpsqW+FOpFxVURDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=al1G4uEA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uCpXAZq7; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="al1G4uEA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uCpXAZq7"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id C20781140296;
	Wed, 12 Mar 2025 03:01:09 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 12 Mar 2025 03:01:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1741762869; x=1741849269; bh=YjfQ3f/vAP
	faXiXX7vMhV5DtYakWuckoaTJIWcaNvNs=; b=al1G4uEApf0efW/hnqlO8nfpgQ
	0hs6H5EDvl2EvpqdJcQMN+tpKnQ+98yi2vqdg4DrpbOFqsS8XwtkXlE5uIfmwjiz
	V8qhRue5RkJkBk01RkmAMoEJMWYjBqlHbdnJrAAkq+dQETixhx57cPuj1CKGTUCO
	GY3HhQ335ADG+5j0aUWH954oaI08lfj4fVRnBHzNe0RvdRUvneiLqFmv0iv0hLdB
	PWg0FjVYSd6fUMAnrCwSP9qrsg1UUEvsh2A49inlZ/XskxuBAmsk/BUrTfJFKGQ5
	tf2xCkQAwJvtpJ6lpTeZ7iFocVFja7Sa+NI5ShIme6to2SzIFZbpu2QC6m1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741762869; x=1741849269; bh=YjfQ3f/vAPfaXiXX7vMhV5DtYakWuckoaTJ
	IWcaNvNs=; b=uCpXAZq7W3yRB85DKXMcAR1Fjq7uYZAfJxxasQyVRPapGEV7BKi
	cUxYeLJA7eNeeZfCbKyl83i8gGH+LHijVQwefy9FsGfA1pyoYUb/P///TlGcma/R
	J1v/D8/48qLDzD2p94JVMe/ioxAP4Y6KEugFLX041N0SBDnFuvEx1WYnYi7JJlae
	81CRG+wQGU8fyLv+Vd1N1CEzdPdFFrKqx8f6Smp51wJLywslqNJzeWs5DZ1BTVD2
	cvXukmAmw8FCYtsZojdDTESLtmdTRd95YL1i/uMwBfkAfSCBKI3xEKKKTshzo3ma
	Q7OAspOiNgI/6RO8ruZTQUFe2mpKSrEcnfg==
X-ME-Sender: <xms:NTHRZ5YDkw8AT338f7_aT_h0hT7EVd7ckYGP4sjSIkYeJyAfDh34PQ>
    <xme:NTHRZwZnD2HX2kVtFPs9kOtQBXPWVV1jrtQQ65M4GvAGK8aCQgaA_-kyL6xYi8zxG
    lf0HGrrh8Mbo0wzNQ>
X-ME-Received: <xmr:NTHRZ7-ZBk_-N3UrN22l5TM0QsJXQ2pEzSRxNoStsgvMDxg14BDy9bNIDe98vBV25w74M1qIQ7_qGk0DJdkHc2hH63g2y6Pb-DcOaEmAsGz7ttTpTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdeggeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekff
    fhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:NTHRZ3p86DY-HdMaRe1jGVKhBKZdIR9x6vG31j7z5AcoT2ye4_wxpw>
    <xmx:NTHRZ0pgjgnq8Qi6cSZpIJRk-CHT1-S6LL4g6SQq1cRDJ1WaiuXTNA>
    <xmx:NTHRZ9QXQG0nzFdVcspoayIzH3eF-Tg4QiAiVJl2jpgC6BzB0WqkPg>
    <xmx:NTHRZ8ouwFtRP3oicQ6tblsQ1352oBGPq5_X_tKfL2auVo0aXy7vmw>
    <xmx:NTHRZ71spUYItfxq5dfDY1aCQ8pJRLifq83nB63uI79JUUfcMH-exLll>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Mar 2025 03:01:08 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e3818e26 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Mar 2025 07:01:08 +0000 (UTC)
Date: Wed, 12 Mar 2025 08:01:07 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 3/6] t: introduce WITH_BREAKING_CHANGES prerequisite
Message-ID: <Z9ExM8cyOvVHHIjR@pks.im>
References: <20250310231652.3742490-1-gitster@pobox.com>
 <20250311212505.2920181-1-gitster@pobox.com>
 <20250311212505.2920181-4-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311212505.2920181-4-gitster@pobox.com>

On Tue, Mar 11, 2025 at 02:25:02PM -0700, Junio C Hamano wrote:
> Earlier c5bc9a7f (Makefile: wire up build option for deprecated
> features, 2025-01-22) made an unfortunate decision to introduce the
> WITHOUT_BREAKING_CHANGES prerequisite to perform tests that ensure
> the historical behaviour that may be different from what we will
> have in the future.  It would inevitably invite double-negation when
> we need to add tests to ensure the behaviour we want to have in the
> future.
> 
> Introduce WITH_BREAKING_CHANGES prerequisite and replace the
> existing uses of WITHOUT_BREAKING_CHANGES prerequisite.  To catch
> any future topics that add more uses of WITHOUT_BREAKING_CHANGES,
> introduce a mechanism to mark a prerequisite not to be used, and
> use it to mark the removed prerequisite as such.

Nit: the mechanism has already been introduced in the preceding commit.

Patrick
