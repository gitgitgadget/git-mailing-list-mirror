Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16813911C9
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 15:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781276739; cv=none; b=W8tMkdChZ4wmPHX9vXcTEE4br2oUjAPmZmU+HfLHx/sIC7YDAM3lH16uvf9O3RdNKDY3Wy+DNceiWiw6Se8hfAooMZyGaF0x2OESPA2lRNVkTJYUjbDBpahRTqHcCfq5u1YAbKklU0zsnqwpaSv2ce4RFFoFArzvr0qHBuyfKyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781276739; c=relaxed/simple;
	bh=t9JqVfEPgBS+NknnEFy7RPjWLNRd1XIr9y/rU15LP18=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=McKRDtvcDg2/mNwdr8yEAzjFWLuvfkQQ/rH43DxHS1GuGmbRwkET6QgI3r/2PoY9rRBSmbYWKC3ivJ7dyg5rqKS8o3Pr3FJqEmZ7f3Wn2uNzzsaF16JRvFb44kGD2EOHbiE8GmImtPZighpGz19pOKtnIWfor0mHLHoNDkg3pyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JYXSoGu9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=glfyJj9v; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JYXSoGu9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="glfyJj9v"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DF3CB7A0158;
	Fri, 12 Jun 2026 11:05:36 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 12 Jun 2026 11:05:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781276736; x=1781363136; bh=LgOmjCPwfw
	HUEktoiPPlj1tPVPIQQqm1mHCODRgXWG0=; b=JYXSoGu9YHm68xN5gH2bdGTD7F
	gSlTKjHLCfBpkbwfbJvtzlAcJo3OeQDbLPuJrvB2DFbY1BiM7SX0A2HobA3kH0rP
	LAHajUW5YF9I+wNiy8J5NgQrP8oIcRIR1TdfLLT6kY1YmUkxFOhekqJTJbXNbRvc
	PJLo7pjSdgNAUeXr6WV4xcP3p06Co6Lp4eOKFTn5tYVYcztMaEgOZOpnOpRLt3m4
	AD2JrMM/TQfHcixG3b0NuM6Op9KLCKfMCC6krnGI1Pn0GKxE/judRFoepMiZhlVa
	O2Xpxy4yccnZ0BfxaxsejDNwlT6JnK+/p1RHHkPrf2gYWFOPMuFo4P69CAuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781276736; x=1781363136; bh=LgOmjCPwfwHUEktoiPPlj1tPVPIQQqm1mHC
	ODRgXWG0=; b=glfyJj9vIYmjx3CWD+w6fRCbxllmZHjeB2ukzhOuG9dcujidTZa
	sEuGiEm1KyyjvEvXYdTMkHMFiq0ADPgOViyLAhHZ9Dm2SG8hQ0z9Ho/QPAf4Ivjb
	nmqwzpmXDvljaC/knAyZc2jkuVKTJniqN2dlnYrb5lAKbxoNnJ/mZnVGpQQeIzMd
	6xd1ENz6sTUe8OG2LTFrdFaLQjimkRmzIDrQGmu+4OcfLidIZEmliUh0PTO1FCIn
	aUTd+HIm2DihLuru2zeIktok7xPrEjF3GhmF0AVuMDycXkz0263aktAiRN6B9vhG
	iBelLmKTsKC6PwCquk4cd9kx3N6jUSy9y5Q==
X-ME-Sender: <xms:QCAsar0eYtLyIY7e7CXgYlzNPYzZCjg8CsfGeOPGqeypgCc_q79Fsg>
    <xme:QCAsatwlEu-8TX12drCqOSvcz7hDHk6X83gR24cR3DfPsYQE8WuP7ezxRf2k3xtfH
    KFN6_nNT02UtG7K8hiOrEb0qHe6WfSVCxW1rHebTuQz2_cwbugjwA>
X-ME-Received: <xmr:QCAsalshURBObqeKmMc9FeaaVgqqd0MAOyycmzs1JAC-mMaBjrTupaU1DALk8xzY9kI6TBqZDmudeCnXDAd1MAYKLyIdJC5yOR2c>
X-ME-Proxy-Cause: dmFkZTFx198mpAGfHRAU/0PzaJCSOEVT2KVT0qO6InRG2a78OV53mhSFjGsxqT9F47jufT
    YlQEGdapQ67GcQTNYRUsHqavqfdPVgJ6dovGJTYSIa/dEcdDV6qszJ9O8na4OGyvQ1HFZN
    nBbi84Te9sOZHRXcWCWJCol7n1azgPlyI5y90gxQWL4Cu3Jau4bU4BiWigr2CvOtg0w9P0
    hSdQFrjZXfSetPqr/LAy08MBMcaT4/i2ex65de5dyvR6wCsEMSMhDd6pnuyzJ5XkvWVipc
    Q56Rl3rlewNQuYzSB51CsMykQAZo6+XP2cuf1bsvo4nnEh0smNxQSO4JGmvElIzBOuaUbT
    A/6wFZ4qYhGmAtcoUigejnMQXknBUTEYF07zmvuXiP72oytH29mROfPbDd6fWbEag3a76o
    OMW26glpyR4STlgitubuvDtNIwgLljisLdxjrXOd/YSbrSAOcaY2KS5pQi51rKLEJdqidS
    jLwKF+wP53rV9v8s+Dqdw1qyXGcJ+NN34pTg80NLGxIiaNLfJIzM0A4nWwQqjcY0ngAHVl
    mGpq3TUTu/E765U3S05Pq5NEo8GIfeJ8L8d1C1JieGW7vJWQhg3VMFXXj4BR+yool+e8T2
    5KVWSPIbm6SYQikkFxNuR1+XfNVbXW70Lnqp87YLjfjmPZBjbPup7xBgRFqw
X-ME-Proxy: <xmx:QCAsanxlVGQzbw79RH-AutwX233i5vyXcRIb7sNGOQjGeACpIedCBA>
    <xmx:QCAsagBt4gelFHGpr7FNfsKzXVlLCJUAKljEv1073tl8_BA93RUMHQ>
    <xmx:QCAsateHhtSCWLPogMJbuw2qMjZKNYxSm0NfpX1onQkAJ0KW2bZG2w>
    <xmx:QCAsail3jxVHgW_LONf40sX4bjUnON5cwoQjxJyQ1yuWuFcHY-C2jw>
    <xmx:QCAsat6xG-JM1dUHiyfnZt_8IxJWkw1V3_GjrNRXPkWAc8PHg_23sRZk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 11:05:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Tuomas Ahola <taahol@utu.fi>,  git@vger.kernel.org,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>,  =?utf-8?Q?Jean-No=C3=ABl?=
 Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH v3 0/3] doc: config: fix AsciiDoc glitches
In-Reply-To: <20260612045329.GA593075@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 12 Jun 2026 00:53:29 -0400")
References: <20260610185148.23920-1-taahol@utu.fi>
	<20260611161946.12166-1-taahol@utu.fi>
	<20260612045329.GA593075@coredump.intra.peff.net>
Date: Fri, 12 Jun 2026 08:05:34 -0700
Message-ID: <xmqqa4sziytd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Thu, Jun 11, 2026 at 07:19:43PM +0300, Tuomas Ahola wrote:
>
>> Tuomas Ahola (3):
>>   doc: config: terminate runaway lists
>>   doc: config/sideband: fix description list delimiter
>>   doc: git-config: escape erroneous highlight markup
>
> Thanks, this v3 looks good to me.

Yup this one nicely sidesteps the yucky \# thing, which is very
good.

Thanks.
