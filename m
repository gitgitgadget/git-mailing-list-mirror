Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33281C5F13
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 17:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762192655; cv=none; b=PekKdMzWCh1jO2dm0iCJQm6r/FNWVIXYtlxd9M/+1iNBCgQKlejBPuQ5nTBJdH9PzQFest303/rZroExbLn5/0T0/Y+GAtSnsn6sSpasFFIDAYcaccC2iCCqjX1vdxNakQNwUTwcFnAnnF/3lMtivJhbi9FeTmHUioIUHCDW10g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762192655; c=relaxed/simple;
	bh=u7TZuZoPeU/DZj/LnrU77SOjjkGnuR7Arr1zg/rc1G0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rDgo2xMB7EOvf1/2GUjPCgRTrUIKtleB/UKZnpkHuaFunA5tIo6VUW9bg3DpqHSfZVYBiweunrxI1yRZMp56IILJEYEyM/YuRW9KQS95V9pag7mDqZstnt1GZa+u4ItEEhCFhUECqOIsowkg5rIOflmBf987I4RK4Jx3disNqNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=izroleJ1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J4ahm474; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="izroleJ1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J4ahm474"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E100B7A0339;
	Mon,  3 Nov 2025 12:57:30 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 03 Nov 2025 12:57:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762192650; x=1762279050; bh=q/XFRBZqbT
	1nhiwygiP3noAlhjLaWNfCQ6C0kPSRDSI=; b=izroleJ1IycHXhzWEoy3n1LPFW
	hpl+hcZ2OUBTRjE23WxfnmJIBvuJr3Bay7Ix8dGawS/ZtOUe4+Z2SrjjEQ1Sts1z
	LyFwehrFLgcFUb17qZLIsnImabjnOZ4EeeU3onJjmljwd743sxU57nbDP1vRUET0
	50y9jDRc5WiD0osCeH0FcpiEJ386szQWQyw8BakK9ut5+LS4z19+eanalCquDRMY
	uaOlTGlIwlWfb5t4ujla65RqzQ7RMMUuI/sC0w9qkMN7+s+rG5K3iT6AM7CbzHss
	bNEHGtjAHYTcL7KNA0uiw5NdidN94MUuXjfbbyjOW1JECAIZqRwagLGdS4Hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762192650; x=1762279050; bh=q/XFRBZqbT1nhiwygiP3noAlhjLaWNfCQ6C
	0kPSRDSI=; b=J4ahm474+ToAD0obKwxIU1kdLbo2Oop+RZikwqwvOfjHsAuGAuN
	CRVxzWLB7xwi3hbhGa+DvXKSh8hkxxUNhdzEbWBL9xt1izZzFKlQqVo5jtKTaLeY
	5yLquoJOttb6Ma81TDzJnl+uE0hr4stQVEDhRgDfwQs/bLpkab6lopubrj/GGqvo
	Et+HIWvk4dCgI8DHF0GO8Djq7npbqwRYksR4o+8xoOli1kryujOpGjzrAxorq7/l
	D4Q0nsR3YnBht3Jvi5KkW9SafPmIomQxLJeu+8xHMxAFaJpMHHYGjZffUQWdvpFO
	lGd45240Tjn8BElF4YskjeXWlsxllvbJeQQ==
X-ME-Sender: <xms:Cu0IabEZbO3IbeOfaqMANfqnMHklI6NDliCj7gsAdVyQbl7w64setg>
    <xme:Cu0IafztGRVQAOnM6o4HNL2pljjTMG37FH4kJLVszpIJS9XWlU6snpTh-NTxMNvgA
    yvrEbqw7qWtqWSD0nfDmnm2_J3gtcB3_bRuHZtu7elduyr35lsRwPU>
X-ME-Received: <xmr:Cu0IaajEqGgXa5ojqTcWVWPHvKaU-ipepIOYXIP6TUBaC3TKFrAGXnc7hAj2xvyL2VQRPKNg4tJri99ihSCtJt4v42NxTzXp7rVi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeekjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:Cu0IaSwvNRSV6op5j-IRS55r4jkQT7RZqUhPM0_vFviRYzTmvUcnOw>
    <xmx:Cu0IaVIZ-HG0bbaQjaPrH-oBayuxJKhZ5c1sCp9Z6d0HLRjGU60JGg>
    <xmx:Cu0IaRT1i-tMD0pKI1ITeLfI3JyUy9Kyy3ZQPDwsqzILwC9RObpcvQ>
    <xmx:Cu0IaVpbCr1HV7D9BOeTDDoIHbLtdmOcBBaec-RAw5onVCX_6em04g>
    <xmx:Cu0Iaf4JMHfxIUFV145o83_DdNcnVu2RlxvlUAtL2HYijG2FRzXt5b_5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 12:57:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2025, #12; Thu, 30)
In-Reply-To: <aQRaRuBtt_r7SamL@pks.im> (Patrick Steinhardt's message of "Fri,
	31 Oct 2025 07:42:14 +0100")
References: <xmqqpla43wcp.fsf@gitster.g> <aQRaRuBtt_r7SamL@pks.im>
Date: Mon, 03 Nov 2025 09:57:28 -0800
Message-ID: <xmqqo6pjt2wn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> * ps/ref-peeled-tags (2025-10-23) 16 commits
>>  - ref-filter: parse objects on demand
>> ...
>>  - Merge branch 'jt/repo-structure' into ps/ref-peeled-tags
>>  - Merge branch 'tb/incremental-midx-part-3.1' into ps/ref-peeled-tags
>>  (this branch is used by kn/refs-optim-cleanup; uses jt/repo-structure.)
>> 
>>  Some ref backend storage can hold not just the object name of an
>>  annotated tag, but the object name of the object the tag points at.
>>  The code to handle this information has been streamlined.
>> 
>>  Will merge to 'next' after base topics are merged.
>>  source: <20251023-b4-pks-ref-filter-skip-parsing-objects-v4-0-2be68ce82c9a@pks.im>
>
> Both dependencies have landed, so this should be ready to be merged now.

The tip of 'next' as of today after merging this topic, it seems.

    $ git tag --list --sort=version:tag 'v*.0'

no longer works correctly and shows ascii sort.

    v1.0.0
    v1.1.0
    ...
    v2.0.0
    v2.1.0
    v2.10.0
    v2.11.0
    ...
    v2.19.0
    v2.2.0
    v2.20.0
    v2.21.0
    ...
    v2.49.0
    v2.5.0
    v2.50.0
    v2.51.0
    v2.6.0
    v2.7.0
    v2.8.0
    v2.9.0

The merge on 'next' immediately before this topic got merged, i.e.,
9ab444ed (Merge branch 'tc/last-modified-active-paths-optimization'
into next, 2025-11-03), is the last commit on the 'next'
first-parent chain with which the above command works correctly.

I haven't dug it further yet.
