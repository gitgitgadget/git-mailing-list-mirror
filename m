Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29C8157480
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 14:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758639023; cv=none; b=f3/FcHiS6EryZSuN24hhksZV1WHOYCrNKDgAJ/VnBYTaLozmKE1cgLvGK/e1wK02NZLFYta4mQyP+c01VA2Y0/vVIKKOmAXXbRGEGujENTBFI4BX/30adO7PWuXo7fRFRw/JX4PHs2YapTO1buo4jVosZST5rjN2xfgXMBt0oPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758639023; c=relaxed/simple;
	bh=6q0YwlSsYephmdj46twuFTxHeFBU+/ahRj03yNM381Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BxxPuYm8ZGtZdPgOCu/Zr/W4OJDJ/M4r3euE8hznYH3hAkbworBq0I2/ihGyRhYeJNjPDWuiZLG1rgL+3bcF3w6l3jQubLb8zKpIiZ/eoyiZcnrrxFNKV+kdwu+IJmnisd6NlDDUslGQYHMg5t32AwYC3M4QscnHHuqM4FkpbhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OctHiUn2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wen/JnXj; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OctHiUn2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wen/JnXj"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id AFDC61D0029F;
	Tue, 23 Sep 2025 10:50:20 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 23 Sep 2025 10:50:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758639020; x=1758725420; bh=AcF4V6GSbb
	68Nc7Yvv9c8nG3DtSEY3g1gJifqD0srmc=; b=OctHiUn2LO5hOvEINWSbhxeeNp
	J4K181T8kFckmSYjmpxQqe2xj4ebRPzV+FgkWTifR8iGgGrK32Qa5BF/tu2ki7nE
	vRl5xH2HILmwULFzmq8l0byBgH0eZCM9G93C++C1sT6gtmzjc3LFG6rQ3OSjaUZS
	e5UV4eTH3B5G9yGzyffpP200rnsmkvIpMy+2R/GaRMorvFB3I02pt1BSh+zXbV+V
	GZTyzMccUfJQO3Nv82hOMXl385bULHUPbH0mqkkPX19ww6o4rg+n17RRfMRpTyIw
	X+yY5e0dbBC8nuqcYHLuYBc8KWssxAagmcyzHBAPAEbexSrtaD6TAahyfHbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758639020; x=1758725420; bh=AcF4V6GSbb68Nc7Yvv9c8nG3DtSEY3g1gJi
	fqD0srmc=; b=Wen/JnXjGLVk1sfejuGJUnAm6LCfoPin1Yj/YbeN/S6yW6u6isO
	1wWNM2wkc4fWrzNZRGG9jt2TvJmTYbZRzaEoqRg2cB3SuixNNx4qrxCBZrglAE4w
	4MykcBArhzxTrYQpf7GqmdsR8tMLoPCEQARAjWXTTmnZOfkvWb9DQuuZ1Gw2UdeU
	Mc43UVKYlrwOAKYDf94m9LvKHx6fPzGa7hojEaLVdI0Z9tE1LAyBS8cvyL0qlXQH
	HikSSZSKjwA9Th6ln5LxCulyFaQKGYe7uaoQS2arYOjSxR2Kc5Bwk7VXLSxOuXFJ
	AcUgirqwYjtk6WT3MRWm5m5cI+T+4+3LkPw==
X-ME-Sender: <xms:rLPSaHiP2fLTvmLat1WOjokJFzdA6-9EOwCjD2oCBplfioKiCVRi6w>
    <xme:rLPSaKCFuwgWhha_ajqEpDg5j5QRH31k_5WeNx2x30W9vKBV4mR-yb41iW9qqX_MX
    _XLf4aDalvTZ0EHrhpoczCI_j8s4E27H0qRs3Z_NxLbXwGquWmc>
X-ME-Received: <xmr:rLPSaEubrlWyhmQfC3Yhvkj-IE_AsJoAUw7DS0_2eu67b7jRFOvOUSssRPRZvzrsrPm_90C-DabqcVve6rDqg_ZtsttBKXM8_6uiqUhu3yAO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiuddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:rLPSaPbJ27WrXaN45HLeFYUSSB0G96vZ6qSoc7IhpeD_GPf-GmpsQg>
    <xmx:rLPSaHV_llLd9QpOOJ0Ex3T-cfYBuqoXrEs_hM8EOOLz_DgKfsxkRw>
    <xmx:rLPSaD5OC_T4-bkcglnnWRgokIcS8s2x1epiN5utPiUpEcMYz3DqsA>
    <xmx:rLPSaCi32NHBxFsA4eYOelnxK90xzVZJSYo40c5M11a7ox3gr0GYEQ>
    <xmx:rLPSaK65Q4eqwQ8iKO5tRPqXpgsWJ1C0ldrO6woUnFQkCx1p1aZd2IkN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 10:50:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e832f0cc (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 23 Sep 2025 14:50:18 +0000 (UTC)
Date: Tue, 23 Sep 2025 16:50:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC] doc: check-docs and WITH_BREAKING_CHANGES
Message-ID: <aNKzp598Wr0Ut8yC@pks.im>
References: <xmqqjz1u161e.fsf@gitster.g>
 <aNJUUxfhM7QYDQGj@pks.im>
 <xmqqikh9p6ub.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqikh9p6ub.fsf@gitster.g>

On Tue, Sep 23, 2025 at 07:43:40AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > I think this change makes sense indeed. It means that we stop linting
> > the docs, which is a bit of a weird side effect that may or may not be
> > sensible. But in any case, we should probably stop installing these man
> > pages.
> >
> > I say "probably" because this got me thinking: we could keep the man
> > page for a while, but completely replace their its with a notice saying
> > that the command got removed. Even better, we could even tell users what
> > the replacement is.
> 
> That is true but requires a much larger change.
> 
> There is an assumption that programs whose binaries we are not
> installing should not get manual pages, which is what allows us to
> throw git-http-fetch and git-whatchanged to EXCLUDED_PROGRAMS and
> cause (1) them from getting built and installed, and (2) cause their
> manual pages not built and not installed, and (3) tell doc-lint that
> it is OK to have .adoc for these programs' documentation, even
> though they are not listed in the command-list.txt file.  You'd need
> to start from disentangling that.

Fair. I'm completely fine with doing this one step at a time, where the
first step would be to not install manpages that don't make any sense
anymore. Let's see, maybe someone wants to pick up what I propose.

Patrick
