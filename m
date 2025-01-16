Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF17142E7C
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 10:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737023048; cv=none; b=U/Pgaanq5f8SxZjt7yEENQiKqgh7TABb9d0+JaJoOLRrGPB08WSM/4iF0OHo42EYdv6Vj0PLlsYq7BIpnC5+eVJY4jrp5WQ/XSWbpGunThtRsXJ4gpAaCf9bM+dm2GdD7uhkRdKqphgK6yPUenFVPxEzXwKIvBy138h6DZK3s10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737023048; c=relaxed/simple;
	bh=S2Kv/UqXP+M9H0RnTUQyMkd9HJ4FYCrzS7eo71w1wAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/VVSu6vUf9i1D2UZ+pwOgj9beRbYUl79gU3LQZnPpeQYTLVFIln6ex5/2co9/VcZtEAXhwAaGyYQpoaWlMfthsnVb1bcQOqZ3E/+9uM3W2JMWdkq8NKWoixRZ1rlF1B2tj4KerPVNkupMunAWhtt9U713TvPXzwaoKUAHeW75I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MohhLUiJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tFcA7kix; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MohhLUiJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tFcA7kix"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id AF02F1140182;
	Thu, 16 Jan 2025 05:24:05 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 16 Jan 2025 05:24:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737023045; x=1737109445; bh=LQjtkMxHs3
	v+1jXc1ntLx8V0E3uHsHAPyEvQKCR4ix0=; b=MohhLUiJ1+Sc4dwhxku4hFGlrK
	GrWFWdnq1EeN0jlRbxB6I0L/ZqaGwGckHFTAvdNQRsBsJgT5J9f0XAlybmgkWXx+
	hNkooPrA9xDfo6nbumAlE+YFtK0JqQRi4oAMkWzRxakDbO7Bvo1a+7iuzhmVINWR
	jBeY7Kpvuv1sM4SuHDBnBTLby5MyLx/0yy5mfdc4JDIz1JNQCfaIeTw33spzVjec
	ZPWf7N553osuYTAP5TJun4BzPTgx5Qh5N59KKcg2e3n+Iic9avTYudvxpnSgme5p
	wJLwAu5KpjkvV8nn3C4+0BSRnvmFG4IuNIQ0yeWyS1iBaFNcxcCjkGHygjVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737023045; x=1737109445; bh=LQjtkMxHs3v+1jXc1ntLx8V0E3uHsHAPyEv
	QKCR4ix0=; b=tFcA7kixSOQ2NyqwCQPRF8yLBMogL0pJLoObdF3YhxJDGgzPhmP
	J3m8wZXhfFyyl7NXDtaz3FlsloeGdupdN5A2nxzJBrYPvdjNPuQI6BWMPPbbYtH/
	ITQ39PBZIraFzNE223PSlvNEjnRcuj/pRmwOiI/fScgkMVOEX3gdOaLjGWkCyW6u
	U6RINrr2LTakBuKLgfA3+GMpCuoLfYehB7U3vkE02wZ+s/1HfQ7mRkf5daF7wDIW
	wsNaYyPeShgjUE8xpdUMC6et0Lv5AHr+1N1VZic7bv4o+soHa1ujx4gYbr8Bdpqm
	4PvQ0uDok8mvs6tzy+aB8AJJcbovL0BRnkw==
X-ME-Sender: <xms:Rd6IZy2nCtX2CTj6M28mGobrIH-goaj7wmpgD9Vd1H1N7CKYMxrZ9g>
    <xme:Rd6IZ1G4LbMOKzbH8PrvQUu1jaNhIFBYg0_zolmDkKLdvRRon-8A-AJcr8Y7GP6XN
    qwLEe66fFebrV2D6g>
X-ME-Received: <xmr:Rd6IZ66YHH4qcfQLixmd6PGzKY4EppEhlgTeagjGqXG5pswNMhUq-hw-zZfUl0UWjkH7mMJqfXxEwGhOyr8IQPEGjIgWYf9QyebYa70XY-ThoGKBHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhtohhl
    vggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:Rd6IZz3CpEz5KoWFaMFiUT1XMs8IiDxI2uB4zY4gpnCSOQFsxGwa1A>
    <xmx:Rd6IZ1FGKdtDxEKKpgU90rpgdf1r1ZI5kpfnw4SG-3neKl-xViJL3w>
    <xmx:Rd6IZ89SUvffmkXP1jDEx7LIaeE9NyoCm0ZdLWzjqXoLpr17TTjhwQ>
    <xmx:Rd6IZ6nN5I-Slq2wdnNKn8rKdayBWgDhfPk7ThOw5NxVakLlVuoKaQ>
    <xmx:Rd6IZ5gIma29Va_PXswG9_c26lNhFtR9F26kfyEVwuXscwG3nPj9uXhq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 05:24:04 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d8202b0c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Jan 2025 10:24:02 +0000 (UTC)
Date: Thu, 16 Jan 2025 11:24:01 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
	shejialuo <shejialuo@gmail.com>
Subject: Re: What's cooking in git.git (Jan 2025, #04; Tue, 14)
Message-ID: <Z4jeQSLmARruE5l3@pks.im>
References: <xmqqzfjt2qye.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzfjt2qye.fsf@gitster.g>

On Tue, Jan 14, 2025 at 10:25:13AM -0800, Junio C Hamano wrote:
> * sj/ref-consistency-checks-more (2025-01-06) 10 commits
>  - builtin/fsck: add `git refs verify` child process
>  - packed-backend: check whether the "packed-refs" is sorted
>  - packed-backend: add check for object consistency
>  - packed-backend: create "fsck_packed_ref_entry" to store parsing info
>  - packed-backend: add "packed-refs" entry consistency check
>  - packed-backend: check whether the refname contains NULL binaries
>  - packed-backend: add "packed-refs" header consistency check
>  - packed-backend: check whether the "packed-refs" is regular
>  - builtin/refs.h: get worktrees without reading head info
>  - files-backend: add object check for regular ref
> 
>  "git fsck" becomes more careful when checking the refs.
>  source: <Z3qNUizvHJLgMx1y@ArchLinux>

I haven't yet found the time to have a look, but hope to do so tomorrow.

> * ds/backfill (2024-12-20) 6 commits
>  - backfill: assume --sparse when sparse-checkout is enabled
>  - backfill: add --sparse option
>  - backfill: add --min-batch-size=<n> option
>  - backfill: basic functionality and tests
>  - backfill: add builtin boilerplate
>  - Merge branch 'ds/path-walk-1' into ds/backfill
>  (this branch uses ds/path-walk-1.)
> 
>  Lazy-loading missing files in a blobless clone on demand is costly
>  as it tends to be one-blob-at-a-time.  "git backfill" is introduced
>  to help bulk-download necessary files beforehand.
> 
>  Comments?
>  source: <pull.1820.v2.git.1734712193.gitgitgadget@gmail.com>

I had a couple of nits and expect another reroll, but think it's close
to being ready.

> * ds/path-walk-1 (2024-12-20) 7 commits
>  - path-walk: reorder object visits
>  - path-walk: mark trees and blobs as UNINTERESTING
>  - path-walk: visit tags and cached objects
>  - path-walk: allow consumer to specify object types
>  - t6601: add helper for testing path-walk API
>  - test-lib-functions: add test_cmp_sorted
>  - path-walk: introduce an object walk by path
>  (this branch is used by ds/backfill.)
> 
>  Introduce a new API to visit objects in batches based on a common
>  path, or by type.
> 
>  Comments?
>  source: <pull.1818.v4.git.1734711675.gitgitgadget@gmail.com>

I had a single nit, but don't necessarily think that it needs to be
addressed.

Patrick
