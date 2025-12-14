Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED3A30BB84
	for <git@vger.kernel.org>; Sun, 14 Dec 2025 23:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765754836; cv=none; b=VbgcFlFZvh0S1bHj4Q6SebhxnopaFKMTki7OA2YlKY/HYtA0Ih9Z5+wCLgstHQ5eGGhPWZ4rhQydWlcVed3a7oDKuPstaeqIDYJ74mPiYsUj9xsbLIuxamh9tw7sf4b5SEBfZWQjNp3xZJkPqyWynupAsv+l4aOaFtwx+y53p48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765754836; c=relaxed/simple;
	bh=Ak6eJ6Mfyc4KGqmuiYyPRUJjQwJMFb0RkBRbPb3EwOQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k2x8hFy4spsOQ3IE9wtDM6znV6gt50IRDZA7btvU0JSAJ2OVDNvvS2Sebt8rFEY6u6e7qnKUGia0gsvSVnEmrT/QBa34M4nDvHWyQYruO7f6GlVivf7du1p/llj95hxp61P5HsKfqYOFk6hoh95Z0DF2Tu5nGHPfj1Lz8T3qrW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Id38epe/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=igDys4yF; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Id38epe/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="igDys4yF"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 0D01C1D00017;
	Sun, 14 Dec 2025 18:27:14 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sun, 14 Dec 2025 18:27:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765754833; x=1765841233; bh=+Q344E0KEh
	I+bvFMOJeCK1Ml+RqX+91HlyNc4Z4nshA=; b=Id38epe/DQIV42xMz3JtSsJDNU
	LScj9c3suW28/Wq+x1Wx33eeQ4lytBzrXaB4qKxqrRNdiYmIjL873+1HU9/U4Pxc
	NxKsj31d0sWpkxCz9gSm8kasTIXXzODjb34CTeTZZ86buNXhe0eLxajeyB0g8r+x
	DBYyDnINH3136Zm/xLK2UKeCtHGp3BY580AMRuuAbWbwDglRsJfTfx/aI6L0qoOc
	YfFuvMlgZSRQkIVKCS9srOhBr+5YqxAvK2CKNnPepNwoWCs09Sx4Y2jxAU8qRqBf
	2DuDCry3JhadO530XGBYXC2TqvulIURvoHZ5cytcAF03frX4tPshjmv/50Ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765754833; x=1765841233; bh=+Q344E0KEhI+bvFMOJeCK1Ml+RqX+91HlyN
	c4Z4nshA=; b=igDys4yFtS4vMrFaYaGpuNog7tCAYwHQXWCmGAaP/wX+B9wvsVT
	b1gu+z3EBQivPq6SDOzCsTfAkiwzo43EwUynLTiRNxc3n27JzbcdtNcx7NwO/Ywy
	hSaww6cytPRtPAcgro7XWbyjSbUY/H2nTW29KvufD92rLp/+OriJg22FDZ400TZQ
	txhkzYqGk6uUApld9ZMO4+4bE2kesGwLKqd03hoTSaeSBGfGmsx2k1eSoDwDD7Me
	5B0B1syPy9VI4waVIFVkAc1eC48MMyrcsjdjKnnkMVCVSoTO19FCFzn8hNZNXg3d
	1Jn/F2v+VRqNs8mKuQafTBg3EiDGiZIavng==
X-ME-Sender: <xms:0Uc_aTJ647H9rk4eJQd-RvcLO-B36qu0sCWqZggeC55urIDz-eJG2w>
    <xme:0Uc_aeKz6oIpVhslLs6olTrAoHD4uAjjJJYqHF76pI6VsoW-cJZgEtYro7TYSMqoZ
    RqVz88WHSvJ2tMG2pH7H5075dsyQtS405u-TfxDxwHn-Q2Si_LwTQ>
X-ME-Received: <xmr:0Uc_aQuxzdlB50fChJYXjNdhKSjhcW92UmuSS7Jj29610QNJVenFgCow9ORBEAsO85ykGvnBsSaZ-bSaJ_wXFsxnUsfgTdSCMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefhedvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkohhuthhsohhufhhlrghkihhsrdhsthgvfhgrnhhosh
    esphhrohhtohhnrdhmvgdprhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:0Uc_abRR6CI3y3XE580g9hS8PRAnEBvqP1Y0vOkBw8tNCC6DM1fhWw>
    <xmx:0Uc_aWO3g61MZYnkUCfqOtqCOJcPf9ED7GNUwdISCfUlJqNwIEJBJA>
    <xmx:0Uc_aQZVsm_IDN8DkWA_3BKML3gr1lH6T_YhuxnrtqB8tULlTjaB4A>
    <xmx:0Uc_aQyrxOTW759Bbx3QE2_-7IWRaCxxLDz9ziEIYMcGsA8EXBStzw>
    <xmx:0Uc_aWdlYQIsq7ltH01yOTtDaJcDogfZzkIDv2YSnx4vC2WlJlwMCeK6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Dec 2025 18:27:13 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Koutsouflakis Stefanos <koutsouflakis.stefanos@proton.me>
Cc: Johannes Sixt <j6t@kdbg.org>,  "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC] reset --hard: warn before discarding staged content with
 no commit history
In-Reply-To: <Ai2bA2Zt8bsexgQEIKg1vK7-SNNhTlsmmFp_gOJp8IKX9dJME7UC97EtqRhAUfD00sFmqRdHg9xgGW82rikrLIDUIswrUPr3RKm-LQgGuNY=@proton.me>
	(Koutsouflakis Stefanos's message of "Sun, 14 Dec 2025 13:29:54
	+0000")
References: <a5wKtD6Tn0gzcba1IEUhukYnXPHxMwPq6puQKIPywmjNufi5vc6vX-v5BpPJ7qj_zZsuXF5FiS2gbpsurWmVjoWHtMm8A-kAbaZyjMfrTcs=@proton.me>
	<xmqqldj9g0pj.fsf@gitster.g>
	<0lbeTWjDGq8hINMi-lj65HLgAIlUNZe_tzANStd9xxHQqAyZaEnaA0yPzVeY_VcReQIKNjY7eBEUGwMGvlbZ-0W0QZpux22cIHnosa0eX_k=@proton.me>
	<d318c46c-fbc3-4e47-8c3f-165ca9a26225@kdbg.org>
	<xmqqzf7ocrhk.fsf@gitster.g>
	<Ai2bA2Zt8bsexgQEIKg1vK7-SNNhTlsmmFp_gOJp8IKX9dJME7UC97EtqRhAUfD00sFmqRdHg9xgGW82rikrLIDUIswrUPr3RKm-LQgGuNY=@proton.me>
Date: Mon, 15 Dec 2025 08:27:12 +0900
Message-ID: <xmqqwm2o8x0v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Koutsouflakis Stefanos <koutsouflakis.stefanos@proton.me> writes:

> On Friday, December 12th, 2025 at 05:25, Junio C Hamano <gitster@pobox.com> wrote:
>
>> I doubt that special casing an empty tree would fly well.
>
> I might be missing something, could you say more about 
> what makes this problematic? 

Inconsistency.

Treating "newly added files" specifically is making the behaviour
inconsistent with others already, but doing so only when you haven't
created a commit or after doing "checkout/switch --orphan", which is
essentially what special-casing an empty tree case is about, makes
it even more inconsistent.

> If it is about breaking existing workflows: any script that 
> automates either of the two use-cases discussed would be relying 
> on behavior that is almost certainly unintended.

I do not think that is the reason for "special casing an empty tree
would not fly well", but I have to say your view is too narow.  I do
rely on "reset --hard && clean -f -x" working in order to make the
working tree spiffy clean, and I somehow doubt I am in the minority.
And "reset --hard" MUST not fail in such a case.

> Such scripts 
> would fail, but without data loss, and give authors a clear 
> signal to fix a likely bug. 

And most authors will consider the "bug" to be fixed is in the
degraded behaviour of "reset --hard". that does not do what is
written on the label  Then what?

