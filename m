Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8A03B3BE2
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 21:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784235603; cv=none; b=eFwf42EUbuy8m+HW0Ri2CuHxgEQ0IzHjB8eh29OMkhz/mhIV3CSfn29K0cJSlHC5FlaIElwz5sT7jCyovGU7ZtnTlP4kcElbm8owM4vdcXcNv44ke9tOr42auxEAnn9deAj9GnFinOQ/7y7k/d6njXovoE2O6Sb2lJpffhD7Xj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784235603; c=relaxed/simple;
	bh=bNqx9K/Hh8dui7O9NXAEzoIyCtxkz1uGsoc7LogR3bA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f1ocdlS5uMTJxhmeDQOtt6irSUgat2Gb95QE1sUAYa5KlrPiVHGAQNU1/cc7G2jlVZOlgF73cSZXxSqwlHa7rrafKqIYk5l+W2G/0N/i9Vvcm4zkRtFPkgErHR7d0jBg3K+PTC+JKnJJ6a/2cXxbdNjcV568P+1jeA00hrtb0Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=drA2ka4q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X8df0k/n; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="drA2ka4q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X8df0k/n"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 7F0EBEC013B;
	Thu, 16 Jul 2026 17:00:01 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 16 Jul 2026 17:00:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784235601; x=1784322001; bh=//sIXk/qrC
	0GKCHD++6MjO+RCzqTWbMFpC9gfzD6YhE=; b=drA2ka4qOHsOV8AN2BIeiZbf4z
	V0Hx7yEaoHL7kgC/Aax+qr8563NIOY/32CnUy/lyyhf0lfByB7o1WB18mIiwFxz/
	hhHcZJ7Cqrm+2ksn4YIho7XdwVTzWz9BFEVaPuZpES1BBLTw2NX0+32atjDOUhPU
	Y4TBLlGeUSOEVc1PxltfNyAvfkHdB4kuT5L/nzsmdJn2V5OTIOnUf3w9ZrjgcoYp
	7h4/9fHB1Bl4887Xyn6hTVC+5EuJSOU3cdQ0ZT5NGRI000/CT/DIJ/I7XDxH3UHW
	1oMiUYiC6oOlICa8C7j03p/i61ITvi2n1b98vYQoYDlRplhZ717qh/RNPEXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784235601; x=1784322001; bh=//sIXk/qrC0GKCHD++6MjO+RCzqTWbMFpC9
	gfzD6YhE=; b=X8df0k/nL38rN5ZFrWx8RzGtmw0UGqTmYpyKATAxV8WrhKnLUl0
	A7X7ieYAAhlvV+W7zduTygU7AIxN2aRHb+7h/Dx3pjzE7KovdV+sMQMIR0UgXsVX
	XNGUmK64aMDBkqhmhidJwkDNL+P6YeeGGd9OCYrtsjhYmLpYmupR5AJtWvVYGE82
	2GehcaUsm6b/jet9vna7K4CG+nDuJdNcViP3bFfwKalueAj/DDZGRRaEtKMTsCrQ
	HBAbiUPAU23DN24WmwvHC1HfFGIAFb/a224IaKgy+0ViIgQd6mruF4j9NeLgQScb
	nZWPeXRXljD6sumeADOi7k6FEh0WyXIopCw==
X-ME-Sender: <xms:UUZZajsivEGoJRk3_d1LSqROd_eydFyo8Fzbodr3vbB4Z-gjEY5ywA>
    <xme:UUZZar6MEW5CpNA-pKHvZJnBBrxvkS_GNWpwHs2IbPMr7o68IIKqdJOEM8FsYSfcX
    FxC7_afTlaseBYhF3ty652fYpfLJcmygjozU4WbyRHYccfK0et0-A>
X-ME-Received: <xmr:UUZZakKpkVnA6eHFbTSoPeehB3WepUtq-m6yAjzfmDdXTyJprdzxeyQdPpRATUyHEmc9aPOwb4XX9_fh5SuoQWLzmiDSPakAtohZNrc>
X-ME-Proxy-Cause: dmFkZTE3v2EipdAO0E1sfUmXFtb2PVztX+m7BDNhnWuwvyw9BuAv3xNpDJcLr+bZhVj2ut
    znykrPGapjMyxQvp1sc78aKEmtkDAZ5uZzP//Zv7/p6hk87ViUi/fjwykyA8eWKmB4JA60
    FEJMJjAdixeP1yPCX7wkMAeRtuOst0I2Z3Z1zGJepBytigR37fu5MuFjJwIfprfZvq2igf
    szlh1AIu7/t1DVHVPFNpNBVwCTyLZ8jRyqlTvrVeQvxKc1j3K1JLghLbKyk2hE9MDbtYfH
    VUCj2p8Lj51MMT3t4BUcv+qTBLfPGwUWdoK8sK9XqPzOfvxH/u95TYSNK1kDxXN5tf9rDj
    YMM86mCFK/SFIQZvbN1tT1iIUfT3AL26zIGeuODaWJ0yu5K17aQEyeDhTtIXckl1/7gay1
    FN7NBKQP9nfr0s9jfPD/VlB9G7pXEh1cJZMXkPojxEMdtGjm4k9bgCX8pNObLFX0L/SBCq
    Se5JWwrRpTY5AN6UT7DNvn5ouRi1Ct6cYvZB7zzbq2XXJ8+ya97xDJvCqccLOEcugncVDN
    VsEYJ6L0Mz0/ZqBBLQxf4L/eGpfu6qtFRoejNaJEgDrUmokgEZcO9f1yg1gZZen8JM3fzP
    RrDJAgoYNVTtLjKF2L8uCD4xvJcrXsIhJ4F6Tj+ogsrfD0QZTAruJxLad2VA
X-ME-Proxy: <xmx:UUZZar7guC6dxICPiXnkg1FduoG8y1su2uKb5nYqD9OUM5WquUMwRg>
    <xmx:UUZZanzgK1x_Er17VRfLY2KmTEz8po5Kr8BwPC8y5dV0wCwvX3deqg>
    <xmx:UUZZavZ9Py-PgPWP-5uEaKUYAQ_XzghOt0whdflK17-g3e2NkNjf9g>
    <xmx:UUZZapSvzgna4_8Xp76dn-B0dCEdXKmQV15IX-Coo9ysbuEom_fiNA>
    <xmx:UUZZasAx-LE6pnDZUYtay5V2gSitQsNqPck7Srk5XQjjz296R08gtXPx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 17:00:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/3] refspec: stop depending on `the_repository`
In-Reply-To: <20260716-pks-refspec-wo-the-repository-v1-3-aa40844d067f@pks.im>
	(Patrick Steinhardt's message of "Thu, 16 Jul 2026 14:38:04 +0200")
References: <20260716-pks-refspec-wo-the-repository-v1-0-aa40844d067f@pks.im>
	<20260716-pks-refspec-wo-the-repository-v1-3-aa40844d067f@pks.im>
Date: Thu, 16 Jul 2026 13:59:59 -0700
Message-ID: <xmqqpl0mejlc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The only remaining user of `the_hash_algo` in "refspec.c" is
> `refspec_append()`, which needs to know the hash algorithm so that it
> can parse the appended refspec item. In contrast to the functions
> adapted in the preceding commit, this function always operates on a
> `struct refspec`. As that structure is expected to only ever contain
> refspecs that all use the same hash function it doesn't make sense
> though to adapt each caller.
>
> Instead, adapt the structure itself so that it gets initialized with a
> hash function and use that hash function to parse new refspec items.
> Adapt callers accordingly.
>
> This removes the final dependency on the global repository variable in
> "refspec.c", so we can drop `USE_THE_REPOSITORY_VARIABLE`.

While we lost some references to the_repository, we gained
more references to the_hash_algo in exchange.  Because
the_hash_algo is defined in terms of the_repository->hash_algo,
it is only available when the_repository is still in use.
So these changes do not really help callers, and only leave
more for them to clean up later.

Which is probably fine.  We have to start somewhere, and
refspec parsing is a fairly well-isolated corner of the
universe that serves as a good starting point.

Thanks.
