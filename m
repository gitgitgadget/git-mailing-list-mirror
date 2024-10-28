Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6ED4685
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 05:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730094208; cv=none; b=NPBA1uTbuvJaiHNkiXiKhQGW8wd5i3q18VHolK9EdoYtwgprypW9XBPUHjwFR2cYS/XKVWAwwL0mK/ST8GRznxaU+idpFPTFtk1qu3oSxM88FZra+8vac2G6AIVRn8s/ur+urADTH/oMFg1CYjrzxYQmxux7ezYa0B2ZIX1/nGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730094208; c=relaxed/simple;
	bh=ruHMb87a/tzd8CRzrOwERNf44GqNexbI7TKFFg5wP9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rkaHz+lBF3Yj4lQKCDU9AvkX+3aaApP12kYmosU5FjAHsHRUdyiFWNiVHhKjUbVa9EOBOgUegLxZR5efnupWUMWorXF9CC4rliT4lLSB5w/ZZVRniftyJx4JOfpbAd3d65KMJ86xjjNNT63BDCPZg0xMmXuzROFwD+q/JzSF/mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=f14qzQLK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VPwRUNzY; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="f14qzQLK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VPwRUNzY"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id F3543114009F;
	Mon, 28 Oct 2024 01:43:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 28 Oct 2024 01:43:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730094204; x=1730180604; bh=ijAwB4uFw1
	Bzit2Q2y4PKdxRAMiWdnZwTmXyHEhlBI4=; b=f14qzQLKYmhq3krXH6+S2mXrNP
	X5npSnLX/zz2j9zFE5GIgqcYrc0M+mvQPWCf5DWhHpPyHLwdTMcBrjEzi8FGjlNs
	sZTYHSLCND40lMzb6SbfcIONaNBjhqCjml5e8bobZz/nk/CInz2b22SJC5ohJJNS
	sJrPj2u/qyfLJr6UldS6ApDNexWSdAqDIDrX+2WMQbUQf5OgvQWVDaLYH/kev/na
	A6sboDIon5dx/pZFIFOHnyb9nJG6yLY6CuQ8rywsCv7ijP2RO87ipaKDyqfMwkgm
	O0ViXvSQtG5Y/cQxw3ugQotls+R01bYQFd7qKgPPPWEJhEOEY+8huGlzRUbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1730094204; x=1730180604; bh=ijAwB4uFw1Bzit2Q2y4PKdxRAMiW
	dnZwTmXyHEhlBI4=; b=VPwRUNzYXRySoUt7TUJjr/blVibnIDSH9hThQP0Mx7bo
	BLEyH8Kh7HPMz4sfLpt85nmcIz/OTrwk/jwi3TNy4eahRmtMwMjvVr/irhkKyYdx
	AFNrIGJVj85Lsxg1BIP0876suHpWCmrcY3Mk4WuiJ7Zmb0G62QlboT570OFLxnxT
	Hs8LUSzOJUY8KKWxJ24LPC4OWazaWET+SDJpI6cLlkJ+EE+IOyE/e46gzaykWf7u
	S/0z1/J0mm6bbcNmj5Ip7tuVR1vCUGFmvkBcif9NUW9gmQ2N2PUUFBt/pCOcpVzi
	Kl+wVLt2bs+yZRcKjR9sUrnSGf1aOL/XBexSRxLAYg==
X-ME-Sender: <xms:fCQfZ4jCEFi0CwHQf1w32oHfKVky5WN96V09jcPOaeUvVv8eZt4amA>
    <xme:fCQfZxAgPxscVVZ-46jJylZP6dce-Pgq6lPj4OedtFH4FOkKAKGNCBg5fOxwfka9s
    NhNjsy5ekU1YxxfUQ>
X-ME-Received: <xmr:fCQfZwFfz7YsALpNZS5gylgof-oQuTUO86TkDnci5cfYiUGZWfum-4tGKADmP6_RwDcMB33E3sI__Vg8HtpEDXkEYSWfdXVLigefFiGgZXdU-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejjedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpefhfefhfeehje
    eivddvgeetfedtkeetlefggedvteelleehgfeffedvteetveegfeenucffohhmrghinhep
    phhkshdrihhmpdihvghsthgvrhgurgihrdhpshenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthho
    pedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:fCQfZ5TFdd0SNxrTDqnpgR0Qppag5jpcww3JU3PaDVIyDNcyhWBsJQ>
    <xmx:fCQfZ1zcW9NrefKEP7ieq8cd4DimFbNLyddnGHbOJbSKPw1T5EoxmQ>
    <xmx:fCQfZ34XzvNhd5RZ27ZWcOYoI8wsf_8YnI45tKRMfPk592vU9k6Zcg>
    <xmx:fCQfZyzGoFYg4g7hCraUNABDziKQ_gQG0gZ8ntV-sPlRXKm80YMfHg>
    <xmx:fCQfZw-ZywbwpYYj5ky5ROh0HAvYwBpY2er2h2S96mwLXWjczblLPZ-J>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Oct 2024 01:43:23 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5f7f1524 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 28 Oct 2024 05:43:16 +0000 (UTC)
Date: Mon, 28 Oct 2024 06:43:16 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2024, #11; Fri, 25)
Message-ID: <Zx8kbrQVmMyLV0-w@pks.im>
References: <Zxv0SgY0oajpst8s@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zxv0SgY0oajpst8s@nand.local>

On Fri, Oct 25, 2024 at 03:40:58PM -0400, Taylor Blau wrote:
> * ps/mingw-rename (2024-10-24) 3 commits
>  - compat/mingw: support POSIX semantics for atomic renames
>  - compat/mingw: allow deletion of most opened files
>  - compat/mingw: share file handles created via `CreateFileW()`
> 
>  Teaches the MinGW compatibility layer to support POSIX semantics for
>  atomic renames when other process(es) have a file opened at the
>  destination path.
> 
>  Will merge to 'next'?
>  source: <cover.1729770140.git.ps@pks.im>

I'd wait a couple of days for reviews on v3, which I have sent out
yesterday.

> * ps/leakfixes-part-9 (2024-10-21) 22 commits
>  - list-objects-filter-options: work around reported leak on error
>  - builtin/merge: release outbut buffer after performing merge
>  - dir: fix leak when parsing "status.showUntrackedFiles"
>  - t/helper: fix leaking buffer in "dump-untracked-cache"
>  - t/helper: stop re-initialization of `the_repository`
>  - sparse-index: correctly free EWAH contents
>  - dir: release untracked cache data
>  - combine-diff: fix leaking lost lines
>  - builtin/tag: fix leaking key ID on failure to sign
>  - transport-helper: fix leaking import/export marks
>  - builtin/commit: fix leaking cleanup config
>  - trailer: fix leaking strbufs when formatting trailers
>  - trailer: fix leaking trailer values
>  - builtin/commit: fix leaking change data contents
>  - upload-pack: fix leaking URI protocols
>  - pretty: clear signature check
>  - diff-lib: fix leaking diffopts in `do_diff_cache()`
>  - revision: fix leaking bloom filters
>  - builtin/grep: fix leak with `--max-count=0`
>  - grep: fix leak in `grep_splice_or()`
>  - t/helper: fix leaks in "reach" test tool
>  - builtin/ls-remote: plug leaking server options
> 
>  More leakfixes.
> 
>  Needs review.
>  source: <cover.1729502823.git.ps@pks.im>

I'd be happy to get some eyes on this series. It's the second-last step
to make Git leak-free, so there's only going to be one more such tedious
series. And the last step is already waiting to be sent out :)

> * ps/platform-compat-fixes (2024-10-16) 10 commits
>  (merged to 'next' on 2024-10-22 at 46b99d8301)
>  + http: fix build error on FreeBSD
>  + builtin/credential-cache: fix missing parameter for stub function
>  + t7300: work around platform-specific behaviour with long paths on MinGW
>  + t5500, t5601: skip tests which exercise paths with '[::1]' on Cygwin
>  + t3404: work around platform-specific behaviour on macOS 10.15
>  + t1401: make invocation of tar(1) work with Win32-provided one
>  + t/lib-gpg: fix setup of GNUPGHOME in MinGW
>  + t/lib-gitweb: test against the build version of gitweb
>  + t/test-lib: wire up NO_ICONV prerequisite
>  + t/test-lib: fix quoting of TEST_RESULTS_SAN_FILE
>  (this branch is used by ps/build.)
> 
>  Various platform compatibility fixes split out of the larger effort
>  to use Meson as the primary build tool.
> 
>  Will merge to 'master'.
>  source: <cover.1729060405.git.ps@pks.im>

I've sent a fixup commit for t6006, which got subtly broken [1]. So
let's first add that fixup and then continue merging down.

[1]: <ccb2d7cf817a181fab8fb083bdc9f1fed4671749.1730092261.git.ps@pks.im>

> * ps/upgrade-clar (2024-10-21) 5 commits
>  - cmake: set up proper dependencies for generated clar headers
>  - cmake: fix compilation of clar-based unit tests
>  - Makefile: extract script to generate clar declarations
>  - Makefile: adjust sed command for generating "clar-decls.h"
>  - t/unit-tests: update clar to 206accb
>  (this branch is used by ps/build.)
> 
>  Buildfix and upgrade of Clar to a newer version.
> 
>  Needs review.
>  source: <cover.1729506329.git.ps@pks.im>

Bagas has tested this series on the previously-broken platform [2] and I've
got a review from Karthik [3]. So I'd think that it's mostly ready to go by
now.

[2]: <Zxx3nmfp61DR6vvB@archie.me>
[3]: <CAOLa=ZR6cnhxy7K7TChxLafm7Ep0XUVFSK+LgNPtNX8yVLyWtA@mail.gmail.com>

Patrick
