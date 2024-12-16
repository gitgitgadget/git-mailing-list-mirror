Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAE329CA
	for <git@vger.kernel.org>; Mon, 16 Dec 2024 08:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734336702; cv=none; b=JYpedpg8Csg4ErSe18uClJDgND7dqqWWEutoHi6tYEJG5ThChycUe+fEoSAyZueRSxau0UlBGAOutSrue/MElqci0umqeveE4X7Hh1D5EhnJbyo65jq0Cw9JLlwFTCm0SLfeYkkqVDw/6svIa5YHcYwjHOGmx85GhiiEpZ4t/Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734336702; c=relaxed/simple;
	bh=TIShCOheqIVRUdmT+ut1gGtTYBdm4Djg5Ke+ScR0n3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ID0dTPG3IHRWeFcQ74+gjhd+LL/eaV6+796xRJfyJq1lh/Wh7mm8nH15SuQNZeRF/8eRPXeCAAJQcwPzGTqf5ZHlMP9BuT5K/7PIv2fqV7mA0bMEivUV8bQfSGrVuZI97s3evLuSFX/pGOGY3vI2Oxkxb1QowEHUMm1mnJnGIrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eBypY3gX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KHe9Lhzl; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eBypY3gX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KHe9Lhzl"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7E13825400B3;
	Mon, 16 Dec 2024 03:11:39 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 16 Dec 2024 03:11:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1734336699; x=1734423099; bh=0EI+vRgqZT
	haFxJUCrAK3J2clObO5n+JzQ6JlsAvqL4=; b=eBypY3gXopqTm8Al/eBvgMBK9p
	0IFivfwND+TDS1p4Tpqs4GXrtFx9+IcNjgoGFrUNnQS5ORCwElHKQPvsD7gJQx0L
	emGek+cAiS+DV1sgrBjv2pWOP1NyefBB+gI/cbA2O8b77z83iDD+4wp1uhQtZKKY
	4YdhymMbiDWTcDBEm1p9TzTZrOZQE0W7HhjmShUTuXgiQP3H0Wh/2DsjEy4jetPV
	xQxlxyB6ojhxjfqBdczswl+dONnq4i+Vxscm0D+HXH5TUsI5QhtX8eun+H5xvmrq
	OQ34rkmeMck0gUGJ5RACBwmdYSUyE6o6tfjWJUx2enZnMZsXrgS9OC7KcaPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734336699; x=1734423099; bh=0EI+vRgqZThaFxJUCrAK3J2clObO5n+JzQ6
	JlsAvqL4=; b=KHe9LhzlphPQmXfxSGn+rOhpMkxz5iP0aJqv5WmkBYaaae9UD3C
	mmMCiiTHBr1TRO/ydhw9QMvXPnVOXkjgeeQemM+JhIVPiQcH8trHE3gqSCwdWyB0
	J+vjhaEj4S4yzYzRV5AN3YyHnkb+7K0TMLn1RPMSEqcsWIC4uWu1V/irHHgkQL8n
	iG1jwq5jmKOpnCWwyc9ZNk90+U+938D/YuiW9BcSEu9pncfV/ZQwCXgqNJY6jMZl
	Oh5sa2R+Xc2dGdTYU8DkOpD0+uV8uJSwqKiRNLhDLiZGhWMEnna83dp40PQBIZXc
	ua4WMBAGdqDmU9XJwabpqW8imxmCrBawxlw==
X-ME-Sender: <xms:u-BfZxp80bwqJRDbyPgu2nEQSMM0O6MnAXzzYITF-rFYU3SEo6xfkg>
    <xme:u-BfZzpPn9ZoZMLZU8U-NmqGkn-F3ekT7FskTPR7Mk5hCw0axSPsetMwMnMvAsjoZ
    4O7VsBpyU2xgtRcCw>
X-ME-Received: <xmr:u-BfZ-Mv28-Q3_USHR_zFy0kDxyn9hHRgZKo66RBqUI_vAMZ8Z29fh_b6Xa9N_L-qCibWl-EYx_xMmHy-BGj8Dp87_C0KOzTW7ZtZEPVwOOitg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrledvgdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpefgieeiteefgf
    efuedvueffteelveekteffgeevjeelffehgfffkeegueefkeelueenucffohhmrghinhep
    mhgrkhdruggvvhdphigvshdrphhspdgruggurhgvshhsrdgrshenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggp
    rhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:u-BfZ87BgLH-JFC4WV7s7oLAWV7lBD7P2pBhmvZd5-_GLqhoD5lUMA>
    <xmx:u-BfZw5dHcxHuPYI7YxLLerIJx1lpWxVrgmFAJCHShKKUga-j-pCfg>
    <xmx:u-BfZ0jP6bckK9RoV8tgGN9Xd4KH3kxkbSVERWXkdBVMmY3Os1Gwsw>
    <xmx:u-BfZy6DxVeDf-PZDQx3zlyo_USdj3Pgd2BM1sr4ZuP27iY9iwRKbQ>
    <xmx:u-BfZwG-ZW6zbVTf8INF9P2ZGQX1SYfw6Ef86hTcRXtfCXLQxvWYD36r>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Dec 2024 03:11:38 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a50dcd6b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Dec 2024 08:09:55 +0000 (UTC)
Date: Mon, 16 Dec 2024 09:11:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2024, #05; Thu, 12)
Message-ID: <Z1_gqiCuTZOdRVO0@pks.im>
References: <xmqq8qslf5h1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8qslf5h1.fsf@gitster.g>

On Thu, Dec 12, 2024 at 09:31:06PM +0900, Junio C Hamano wrote:
> * ps/build-sign-compare (2024-12-06) 16 commits
>  - t/helper: don't depend on implicit wraparound
>  - scalar: address -Wsign-compare warnings
>  - builtin/patch-id: fix type of `get_one_patchid()`
>  - builtin/blame: fix type of `length` variable when emitting object ID
>  - gpg-interface: address -Wsign-comparison warnings
>  - daemon: fix type of `max_connections`
>  - daemon: fix loops that have mismatching integer types
>  - global: trivial conversions to fix `-Wsign-compare` warnings
>  - pkt-line: fix -Wsign-compare warning on 32 bit platform
>  - csum-file: fix -Wsign-compare warning on 32-bit platform
>  - diff.h: fix index used to loop through unsigned integer
>  - config.mak.dev: drop `-Wno-sign-compare`
>  - global: mark code units that generate warnings with `-Wsign-compare`
>  - compat/win32: fix -Wsign-compare warning in "wWinMain()"
>  - compat/regex: explicitly ignore "-Wsign-compare" warnings
>  - git-compat-util: introduce macros to disable "-Wsign-compare" warnings
> 
>  Start working to make the codebase buildable with -Wsign-compare.
> 
>  Will merge to 'next'?
>  source: <20241206-pks-sign-compare-v4-0-0344c6dfb219@pks.im>

I think this series should be ready to go, yes.

> * ps/send-pack-unhide-error-in-atomic-push (2024-11-14) 2 commits
>  - transport: don't ignore git-receive-pack(1) exit code on atomic push
>  - t5504: modernize test by moving heredocs into test bodies
> 
>  "git push --atomic --porcelain" used to ignore failures from the
>  other side, losing the error status from the child process, which
>  has been corrected.
> 
>  Needs review.
>  source: <20241113-pks-push-atomic-respect-exit-code-v1-0-7965f01e7f4e@pks.im>

There was a newer version of this series again sent by Jiang Xin. I'll
try to have a look today.

> * ds/path-walk-1 (2024-12-07) 7 commits
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
>  Will merge to 'next'?
>  source: <pull.1818.v3.git.1733514358.gitgitgadget@gmail.com>

I was a bit late to the party, but have sent a couple of review comments
to the mailing list late last week that Derrick may want to address.

> * as/show-index-uninitialized-hash (2024-11-11) 2 commits
>  - t5300: add test for 'show-index --object-format'
>  - show-index: fix uninitialized hash function
> 
>  Regression fix for 'show-index' when run outside of a repository.
> 
>  Comments?
>  source: <20241109092739.14276-1-abhijeet.nkt@gmail.com>

I've just had a look at it, looks good to me.

Thanks!

Patrick
