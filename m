Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF6535E1D5
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 05:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788412554; cv=none; b=Qb6pPFYcjmlwYkcZE6ozcTKqp5hiIkPISY/2UH5mvzBFlxVJA9twQZ/Ryv7FADymdVvfAyir1I/yMUWgVMUIM43WmLQHJdzsSVi9JP0RZQ/KU/mXosQkC73cCWHw7jEDguIB6CAw3W2erLXE9/0uU6ki3dKVJKe5BFgkTE0YB5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788412554; c=relaxed/simple;
	bh=x3Z0oYr6EjOfrnoNxHIfoifW2WgZlEEe9yJAPLRdejA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRYc+lyHVN9HSeNvseANniF6PjPFnaG2+HWg8hdF9nFgbiq7uG+7f2CcTgYl1zwxlY1ll8DdoySDlZNA7HFcqTGJM2B+iTqb4Yj0CPTtYeQdfhYuT/vYvqVZZAG8KyvvYHqnM4EGwlwsJykYhctqVnS5LxgB8WxQcmcIUkTxi90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fHLO7ujf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VWHmrB7C; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fHLO7ujf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VWHmrB7C"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id DFFC31D000CC;
	Thu,  3 Sep 2026 01:15:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 03 Sep 2026 01:15:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788412551; x=1788498951; bh=A6UVcErF0z
	sJzsWaxDnqRgS4tFpObQXn/h3yDN5oKLo=; b=fHLO7ujfVLSC+LhZbtdNVUKda1
	rJ02razmbXYfV1Vd90qj7ShBcK7MRyGA0MWGmekiTr1lPlja0um7hE/+zGBnAAVx
	hUiLOaXAtBA36zeNO0oT4+Qs17LMKaWxGHato6IbiVBogL0mrTk65UzhuRwYX+vd
	D9Z7nfaCTT03lo1GTWCEeziZcj38Uiup36qctrw+ynuf7K475IN6BP43+bnY6lRr
	Q2zw377FwyJq0gkxmzYbkMydgq25tfDoiuenG3Ea2pTdd8hTq0cHv7R1yPYDhX6m
	mfZnwegtmI6ShCJzaC1IOBRSqwclTTTdvHxGcGLZYtizDRnvhtpBZLIjBvPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788412551; x=1788498951; bh=A6UVcErF0zsJzsWaxDnqRgS4tFpObQXn/h3
	yDN5oKLo=; b=VWHmrB7CWFWjfQKFH6o0ArSIJeefejz3BDlt85iimu4/kDMyrZ7
	oGKDW4tX8bB9cSDr7Hiv6hs3yxHFvKNlKhE0hVL9hRbECVoQxPQsQpKHc4o6POsL
	+aSvmJpKACSy7DwGq5p35kELA/3nKObm/BZ9t29gNeyei8Sw10/ACubR3yNZ5Jja
	uH48YnpLLwUzonPOmnlB4wvO5fwFtwSH/4nrOiX0XG6YzmzlQ+iYE4UtMTHGB3Iv
	ap41X/5zA3RTrr2fKW2+TF2SBHQ45HVruNXhIre0eRAIzkobKLHmepJS4ejq1cmQ
	DH69j6/NhiOsuj0mWwlBZWJcRt6g6+pFecg==
X-ME-Sender: <xms:hwKZah27gCs-lWiLFGteBviJzTMHiEKlnotVLVbR1Bep6W2SHfxiLw>
    <xme:hwKZaviweYSdKnA4XoWn80nvKAghbkpE-ned6UVn5iClhyk5whCK7Hl5BUSinM-1u
    rVI1VSSz8ib3EyYcSivhzBgYuXIz7IORqm3hi4bSdXdeFdI5y3bP54>
X-ME-Received: <xmr:hwKZavQx7SUg1BWsWkseV6WQpHq3_8uA8VeyNYLVv-hVzf11Isljnw>
X-ME-Proxy-Cause: dmFkZTEd7h9nGMRUh8DS44pl1oqfNjWPOv8x0SKKQxY4nHdTldzbhF5eRl28paT1yzD+JP
    HsVR7zGvVfm7e5SgWkBTbgmo79WcvV/z9ZO+xI8MtTDZLt8R3DIjwwLImDw0hlHkn70HlF
    iywB5JXhcPS1QRpb9KAmuTqRVz8loMcyAVqDttHMxZTCG5X1V5EbIRxG9A/kQphTInwDum
    Qx2twqZ+m5i95+G9gN1QWJud9BfZ4lrdlUVRdPGGUpkR3bIfWpP7SLY5RI8EJGJST2vfCO
    tDM2LHPOlq/yDpJkbhVOX8ygT2ZDf7m/V5SlYHTbPaFfzNM+t2GCNl6H1eLGYRfcdYGdMg
    i5VF4UB08o/M7rUO2vfcmzBe4ZmNOh0kqEEpNfgF4V43U2/+8boitQK7X9e20JnBpVKWKU
    hEhVrTuwBT+YdoXHcOCm3H/PwdM6hzEAYfoh04ZnY5qwXabWcXymGvmO08JbvkFlucdIzx
    kYAYc4bcI7v4TuMba/jOIkln/6MS0uHA+F5As5Qn1PhhBRHzzAK7KKeXNiXfYH78SEOa2b
    zI/uhWFhd/dqCnF5AE/qu5QZv9Fk4VZ7dClWy80hb5Qiwia2oMTaAJTtweKEAxC2XgX2P0
    reReGouZkr0O9kZ0jU1fbMVLbtDILknQvabIFwld7W5FqLYifaKXIqXNLJIQ
X-ME-Proxy: <xmx:hwKZaogAms5VmJlIhLuwCpTiY9OBJ3fqd2vcDf8ll-SPTSp3rK03GQ>
    <xmx:hwKZan7lzSuO9KTOXO6bgMYrkHrhrCnkuyQ_d4W7iFNKZlTdqV5eMw>
    <xmx:hwKZatBrk4FO-gQsAx5hZR_yrh7oRIWLBBGGDeR2B6DY9OFj84gNgQ>
    <xmx:hwKZambRNNBRQa3_zm5uxJsWbp5uKhyzM1GVustYgaQbOp1NjQSOhw>
    <xmx:hwKZakT0y2JFjWk8nXqz3UW3rSSNXTCGDUy5kFHfVZimlq9zgV11YCUb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Sep 2026 01:15:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 10a2c508 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 3 Sep 2026 05:15:52 +0000 (UTC)
Date: Thu, 3 Sep 2026 07:15:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] repository: make repo_clear() idempotent
Message-ID: <apkCe9CKvYvM6Hy9@pks.im>
References: <20260902055117.GA41587@coredump.intra.peff.net>
 <20260902055526.GA41747@coredump.intra.peff.net>
 <20260902062940.GA47676@coredump.intra.peff.net>
 <20260902064907.GB47676@coredump.intra.peff.net>
 <apfoNaZL8dg9OpbL@pks.im>
 <xmqqpkyvk45f.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpkyvk45f.fsf@gitster.g>

On Wed, Sep 02, 2026 at 09:29:48AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > I was at one point wondering whether the parsed object pool should
> > really be an implementation detail of the object database -- parsing
> > objects should not have to depend on the repository, ...
> 
> We need to be a bit careful here, as the above directly contradicts
> our earlier design choice to have things like hash algorithm as
> properties of a repository instance.

Yeah, true. The question though is whether it really makes sense to
always propagate down the full repository, or whether we should instead
propagate only what matters. We do of course require the hash algorithm
(and potentially the compatibility hash algorithm) in these subsystems,
but propagating these two pieces of information might be the saner
approach compared to always making the full repository available.

In any case, I eventually discarded the above idea anyway.

Patrick
