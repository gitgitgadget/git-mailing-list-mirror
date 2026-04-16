Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7816A346777
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 16:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776355753; cv=none; b=nBdcmTpX8hWcIMhfihRz1FRZacXBIvMZRhE1ElzEGATtDj+VcrWth+oRkGIIQMwFDR7grqydh2pPl2TYrLMnnwYHKMbs0bvURakjMNOJ9bhEwJNZBdesWCDkoWhRENDR/mNbl18rCYKujbKHATqRE3TSedqYiHsiWD2apMEH2xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776355753; c=relaxed/simple;
	bh=Ff5JPIpaiMnDX/4E9Qxm7YbCwja2NOnz0KDkrBIfG/s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=douOOL8Y/ZDVtlpsLlg9da2mhYty63Xp1RY754eUYP3eADUjRwgsTtBpuNksUS5hzD+hlgKKiFtl7V+2CzF08f/PhUXfHqa1a7qUznFjtDJCTH/DxyFGGtLaZH0aZTBEH96VcyyFW+Ubdfb/SgmB+xeDiGYBMaWtflli9JigIjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TGXJvjrU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oIEV/w8O; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TGXJvjrU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oIEV/w8O"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AB8117A02A8;
	Thu, 16 Apr 2026 12:09:11 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 16 Apr 2026 12:09:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776355751; x=1776442151; bh=dq7MWCpa7d
	V3bFTsPFSlaUDtoS59rGs7kd9x6JxcRO4=; b=TGXJvjrU8uEHA3flbSrmREJ+Sy
	DOY5hE7HU4aWZsOtUzuchRSS7nXEyFxqLz1KaUcmXf/fkdz9edh2piGMF0ipIda5
	x8IOpBHEeimpmk0D+Zw9RHm7dkDGiLCMt0mK/LK7LgfIlKz88V1NYtOxYEBq+UKL
	I62zTVxsWpMq9gLp7frBdpCfjaL6TZ4eEvMPayK9CSyRDyLk811433WP+Hy0Nlpd
	3MF006IlWTyJFidkp2niF4zg5z/wAs3XYCLSXopeMuO3qqO7bQgAm9b0QFXT91wv
	Dzg9DfvhqcwkB/LB2YZ4H7evtHe+SGkjBtACw2Y3yQTpyhnq+qRjwcCM+uAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776355751; x=1776442151; bh=dq7MWCpa7dV3bFTsPFSlaUDtoS59rGs7kd9
	x6JxcRO4=; b=oIEV/w8O6WMJBrA6KtIyav4k2rVNM0dTveXPKpgVO0+mUIbmCQf
	0j8CNaLs3xJ5mdBHlIyZM7FZd2x3ryTnrTitUsQHrShT6odlC4YDbn4cIqaOeAru
	fVgt9AZH/f94WRiXYlNOvVAQ15OIL5xq3yX954Oqo+PyclUrgsz+zRLe/V8lYErZ
	wdiyaqwgb+mUPqTfEIsZhY5mk7s1Ws8OipIpZZf9CETbKH0eXMEqKa/Q3+GLLIfs
	LAc1HRVZYMUpzIAUYbCvkQMk/OwJOSpGfcADSoVPLtMV8s7u43ozrPhYSz4ULFN+
	QMiB2Ku3sJ4L6I2MUCoEZbMa7ZoSoqSYkgQ==
X-ME-Sender: <xms:pwnhaVmxcBsrOmoiz4CpzKM9mSdioW3OObfyc_nNtsfJeZNK257DYA>
    <xme:pwnhaUi6zpGvAGFMOpbamXI28bNt02EV7e4FPVeS_4_lUGc-LmjrIxFU3N_hIBMXY
    uESpHtHYPPUS1mWLUR3EZoDSDUUxy5KZfcZspbvdgxwsJObl8gR>
X-ME-Received: <xmr:pwnhaVdbhUO-aqXOe10o206rRz5qnWfzCBUQnyAHSIrGZmPccXpX1SML5Oc56E2_6KW1SMLnobHNnFgUYrYdwAs3ZuxTTuSP9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegjeeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtth
    hopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:pwnhach9-RnuwflFvzGDLyjVqEuZ__a31Xyr9nelAZmv-nFkm9iTvA>
    <xmx:pwnhaVwNEgErXfhgz00D9gBjvpGc3iSriwi4Y5V-VgJalNml6gvyXg>
    <xmx:pwnhaQN3sFTLoYSAiaA6VokJ3NUqWckVZTTICApuMo1hvIuhcd7WrQ>
    <xmx:pwnhaeXU2_hUKYWYpuLMB_gWeLmjU6dCIBMcMLg8u5kvTJ82m_FfEw>
    <xmx:pwnhaQyN-8albCj-oUOPurKKwaiYl0AKrIpZ-2R0ih2FxLqKYHrdKx2I>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Apr 2026 12:09:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Jeff King <peff@peff.net>,  Taylor Blau <me@ttaylorr.com>,
  git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: MIDX woes, was Re: [ANNOUNCE] Git v2.54.0-rc2
In-Reply-To: <621c9da9-2ec0-462d-ae51-0be5e0ca6ab2@gmail.com> (Derrick
	Stolee's message of "Thu, 16 Apr 2026 09:24:31 -0400")
References: <xmqqqzohd0sh.fsf@gitster.g>
	<8c1def10-9039-aecd-4ce4-fb4676b47e9b@gmx.de>
	<xmqq5x5s540j.fsf@gitster.g>
	<20260416051732.GA48541@coredump.intra.peff.net>
	<20260416053435.GA646718@coredump.intra.peff.net>
	<621c9da9-2ec0-462d-ae51-0be5e0ca6ab2@gmail.com>
Date: Thu, 16 Apr 2026 09:09:10 -0700
Message-ID: <xmqqik9q3n15.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

>> I think doing so is just this one-liner:
> ...
>> and then here we need to use v2 for the new compaction feature:
> ...
> I think this is a good change to make. This fits with the standard
> approach of not making breaking file changes by default, but letting
> users opt-in to new versions (at least for a few major releases).

Yes.

Is anybody volunteering to put the patches together?

> The part that is striking about Johannes' report is that this happens
> on a fetch, so it is being written automatically by normal maintenance
> activities in that case. Without downgrading the default version back
> to a compatible version, deleting the multi-pack-index(es) will not
> keep the repo in a good state.

I am not sure what you mean by "deleting will not keep the
repository in a good state".  Isn't multi-pack-index totall
optional?

> As for the multi-pack-index being optional, I agree that we _could_
> have a more graceful fallback to the pack-indexes when we don't
> recognize the file format version. This should still be a very visible
> warning as it can be an important performance feature, so users should
> be notified when it isn't working as they expect. (This can be done
> separately from this late-in-rc change for the default version.)

True.

Thanks.
