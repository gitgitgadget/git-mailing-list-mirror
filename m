Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1394472F69
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 09:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932239; cv=none; b=F3dybgFXYjjgtnjXLwrc/k4rKgnDPGlmWVX9BfUndg00Ge6+ypzghLd8+OHIfeqmVpjv7U1ceZkKj1aDuAwBEDI/AX2hGiZ43Lmz24V8OszJ34gnJk2fzTqravuy9C39WDHMGnrSDLW0lntac6Ek3KMbScyYQ9IJsQigHeWbK20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932239; c=relaxed/simple;
	bh=aywY5UUfBV9iaIah2/tA9YQTFEu6QTFCPrBViQ5qqlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X46+rT980t6Qsa0tDyaZIJ3+AtQEwtQ/IgIUIjQKxWCl8F6wMGzkEmCAlu5AxXU2rLqq8Sp968ss05nTgUidSVaKAKl2dseKgYVjMzgc4H50sgAMXGS52vnu9IMY3pG3hVkjTaAvrvhEX2+vOp4kNVmQl9WXCdDuaxVZpmYm+zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NDw6yQNM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ENOFjb1q; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NDw6yQNM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ENOFjb1q"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id A9B17EC027F
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 05:10:36 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 02 Oct 2026 05:10:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790932236; x=1791018636; bh=1cdpv5BSBl
	iDirNcKAjujir0jbTjEZfTcEDFRCHq8no=; b=NDw6yQNM5rVANZpmvQ9nYXYFT0
	jdbzPDwaQwD2zPikbS100iusbAAny6WjFsuIY3syqEX64V3mrqTwolFxwpK0/CJM
	MufQyliyk9sm05CaXYqXMi00Q4V0RvHg0Fjaai09VkAcAfUfT8/qVWsbdk0KVhGi
	RcWQxz5Nlv+21EqGcVHvxQGxTzHj/y5dC2lYT7h3E8Efb0EToPHq8+zaKGLtOeb7
	uM27YkhMPaNPOs5i9kFuFYPOSd0TYpbGA9WSTyikUUdWSz7bwlCDuX7QecPWuwzO
	ZE8UuMbS3wWkLy/ryeedrxFMfhkmExdZGCiiU3OvWKCno2nLIka3+Gv3t9Rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790932236; x=1791018636; bh=1cdpv5BSBliDirNcKAjujir0jbTjEZfTcED
	FRCHq8no=; b=ENOFjb1q9j+Qq6/nq6DdqVJ0DX6+SMszrjkWMMIdh9u/q+C/6pF
	gxP1NY33CWZ/31/goOuXzco3mFxY2R3urv65OyQj5GSl90YeshV4QSftSXTfE4o8
	3okHKQK3sdI1QkmYRRO49cfj7Gr88FbstnjR+fzU41DmwPcV1erCybyH6canmD0I
	E2oSyvHI77zQGaaUjoqSWHj1/LLueLSXShMz//RD5pS9VAA0ybqhoKAcWcTcwiuB
	fMrtADANHvOfjU1vMVX2ZFOvCQrA4SmLzgohrhZMbLYfah8FH0edfmoJjbzq5RJV
	E7InVXQhAnTfysO9vI1oLP33+LfrshQSxiA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790932236; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:jeKluyuXwbNVe8XX3eacZeNvf24inHY7xXu3lz8K8DBsl0H
	b31YMiW70gXytUTUSGL62D+eM9RERPrN4Z41Ew3dbGmGwYRnDKVLt/kn/yGnnvc4
	J+MiNygL34ZrMyQqAgyfo9CluWlB9iIVDVKBARVt9QNjOGcLBHSAlzg0CMKzqFnU
	qhICItERc5og8bBBugz5OoVc4UNQjH2ZV7M/1WOA3w1SIqH2bRiUKSeR3l3CTSz8
	qMTSFJapwiZRf/Y7uRQjIyBNpAgWF+yrT3wQZkQzKOv5whV+gAT2F+ewKzaCPzjj
	gsWwHZmhKFWynjV6lnRIOPUrT4wUvp5uP7Te9aA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Y43yIYwgMGJxRxutR1IauDZ2cmcjxHX8UaRFtBatf5U=:aywY5UUfBV9iaIah2/tA9YQTFEu6QTFCPrBViQ5qqlA=;
X-ME-Sender: <xms:DHW_atT9vRf3JEBdS6QG3M4Kz8qNQfOCHmS1WD6Fj7ZpE8r7bREMYQ>
    <xme:DHW_aswq9X3Glg0imN9LdosZoKFch12P02sGVlo34cOK0Cq_8AXiE-YpLAXN9SYdX
    knDSSuGi6SH-BnHu0W63gBls5Pyf7PmPanSV8Wa9_nGkyHHWpY_0g>
X-ME-Received: <xmr:DHW_agd3L3b-6kspyJNQECOcwJ873U1c4hWtQN6yZb3jwp-wpHY5sg>
X-ME-Proxy-Cause: dmFkZTEuHObYeQF/Y6KzlEzBgd/Kjet4OOL64hMUsLPJ4h36sMEBjnegNal3VOvYZN92r2
    S7RIiWck3UCwoRa/dm+fdOro6VIbIL5afu/p3JDkaSHUcKCEZ62DCJqWICM0YtGPj7m4YN
    yxSZzfouz/8ctmG8jJE/8YNieUrOlR+gTUFT4t9EAWG9dkHbYscJ/7TfZt9RNBtajrYJpQ
    4KdcsECJk/bVfOjLY70MLN8rCP5TLiLqgP5nt5tvTjBqiihhJo/7ksUUwQDU3FYQBqnu1M
    ScSAUdZVqsfvw8zi71Rk4IiVsb+77lnOEcttgOKwELaXd17VibFMOGCxha8pDORWiRz+qw
    ozqoYIaaas4j11dPN/wFzls1zpDavEXFFe3rswQHnEKLAA9yY8TuxaZeWlKm5IxQKwiSjt
    3pVhSOj0oq+cFqOZhBwvuArwP2iWI16t3sQreWvazdYTnadpDjurv+SaK9amaVnUcM6z3y
    4+4yvAwdwzqLLq9twRiWjhhQsRmNpqWN9F/jhLb9ZVuZr1uQUcQ9n6DyikBpevrFOim/NO
    xhRQAzAIj7bmLfjW5ISNIgCK7A8XhHORANieiOQx3cB/tu5D/y9NoJhMDY3Lpw2IUxCEwW
    V3pcCZB0OKSPJMZZ0vE0VubBEqq0F+L+PUh43wSF/XHMzLvZpD+meKMxNRUA
X-ME-Proxy: <xmx:DHW_agJBdOvkfGbeeN63_7s8BGnm2nzIdVKtO_idxBUxGhoGkbKl4w>
    <xmx:DHW_apH3hUY5XwKiHhPkCF2dxU0E182BV_fm7pX-xBE7PHfM_3lskQ>
    <xmx:DHW_aiqauvhQ9m2VoAnBtTbX_jxwOmDcmwe0OOj1MMmI13-Bzayqdg>
    <xmx:DHW_aqQSQvQ07Xbx-BSTBQibt6yt-DQ5djh0JHP_WVMKGB9nL2Vcog>
    <xmx:DHW_agqGKro5ev4m2utf0j8GOpX8q6SKpImqzANakP_j9Pxyohf_RsGC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 05:10:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3bd9059f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 2 Oct 2026 09:10:33 +0000 (UTC)
Date: Fri, 2 Oct 2026 11:10:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2026, #01)
Message-ID: <ar91BoTedI3gHntX@pks.im>
References: <xmqqv77l2g2e.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv77l2g2e.fsf@gitster.g>

On Thu, Oct 01, 2026 at 03:48:09PM -0700, Junio C Hamano wrote:
> * ps/reftable-reflog-timezone (2026-09-30) 3 commits
>  - refs/reftable: fix on-disk representation of reflog timezones
>  - t/helper: fix segfault in "dump-reftable -t"
>  - date: add helpers to convert between "+HHMM" timezones and minutes
> 
>  The internal representation of timezones in the reflog for the
>  reftable format has been fixed to match the specification, which
>  dictates an offset in minutes rather than the parsed "+HHMM" integer
>  representation.
> 
>  Will merge to 'next'?
>  cf. <CAOLa=ZRVt=e3MqjLY=UkitfSg_YjpsfFjeDsEmqJQm-5YhopxA@mail.gmail.com>
>  cf. <xmqq33up73dm.fsf@gitster.g>
>  source: <20261001-pks-reftables-fix-timezone-format-v2-0-a4fd1f7cd21a@pks.im>

Yeah, this one should be ready.

> * mc/refs-rename-transaction (2026-09-23) 1 commit
>  - refs: run copy and rename through transactions
> 
>  Both reference rename and copy operations have been refactored to
>  use the generic reference transaction API, ensuring that hooks
>  observe the updates as unified logical operations rather than
>  piece-meal internal deletions and additions.
> 
>  Needs review.
>  source: <20260923133651.74120-1-maciej.ciemborowicz@gmail.com>

Oh, I completely missed this series. I'll have a look.

> * td/ci-large-test-resources (2026-09-30) 2 commits
>  - ci: use twice the CPU count on both providers
>  - t4205: compare huge output without diff
> 
>  CI resource exhaustion during test runs on GitHub Actions has been
>  mitigated by switching a comparison of a huge output to use a binary
>  comparison, and by capping the parallel jobs on Linux to the number
>  of available CPUs.
> 
>  Will merge to 'next'?
>  cf. <ar0gon2VE0RlG_cC@pks.im>
>  source: <20260930-ci-large-test-resources-v3-0-d65ac7c21b5f@gmail.com>

I'm happy with this series.

> * mc/refs-hook-report-old-values (2026-09-24) 1 commit
>  - refs: report old values to transaction hooks
> 
>  The 'reference-transaction' hook has been updated to report the
>  observed old object IDs and symref targets for unconditional ref
>  updates and deletions, instead of reporting the null object ID.
> 
>  Needs review.
>  source: <2af3eeadd18806c5298d53072428656885cff89d.1790269745.git.maciej.ciemborowicz@gmail.com>

Yeah, this is in my backlog to review.

> * ps/meson-improvements (2026-09-24) 7 commits
>  - gitlab-ci: fix hanging MSVC jobs
>  - meson: update wrappers
>  - meson: fix outdated completion helpers
>  - meson: use precompiled headers for unit tests
>  - meson: use precompiled headers for our test-helper
>  - meson: don't recompile git-remote-http(1) multiple times for tests
>  - meson: avoid recompiling HTTP sources several times
> 
>  The build configurations for Meson have been optimized to avoid
>  recompiling HTTP sources multiple times and to utilize precompiled
>  headers for test-helpers and unit tests, reducing clean build times.
>  Additionally, the shell completion tests and GitLab CI MSVC runner
>  jobs have been fixed.
> 
>  Will merge to 'next'?
>  cf. <CAOLa=ZS8Exa_WkMLiFNspeYaKFf40eOM19ZgecC=yTnFEAhMzQ@mail.gmail.com>
>  source: <20260924-pks-meson-improvements-v1-0-90b7f79f1c4e@pks.im>

Yup, I'd be happy to have this merged so that our pipelines are finally
green again :)

> * ps/setup-enforce-repo-passed-to-create-repository-has-no-state (2026-09-28) 7 commits
>  - setup: enforce that passed-in repo does not carry relevant state
>  - repository: adapt `repo_clear()` to fully reset the repository
>  - builtin/clone: don't apply "core.sharedRepository" to leading dirs
>  - builtin/init: move handling of "core.sharedRepository" into "setup.c"
>  - builtin/init: refactor messy creation of leading directories
>  - path: introduce `safe_create_leading_directories_no_share_const()`
>  - path: drop useless `safe_create_leading_directories_1()`
>  - Merge branch 'ps/odb-alternates-at-creation' into ps/setup-enforce-repo-passed-to-create-repository-has-no-state
> 
>  The repository initialization sequence has been refactored to treat
>  the repository object passed to create_repository() purely as an
>  out-parameter.
> 
>  Waiting for response.
>  cf. <b0ec2ef9-7aef-4f7d-b31b-7141b39c2d24@gmail.com>
>  cf. <xmqqtsn9mkog.fsf@gitster.g>
>  cf. <CAOLa=ZSX0e25wK5qQwznXN9rVM+WHn8631pkTEN9Zm-BrXfEsg@mail.gmail.com>
>  source: <20260928-pks-create-repository-stateless-v2-0-a03612f703fa@pks.im>

Hm. All I can see is the discussion around free(3) vs free(3p). Is the
expectation to do a reroll with s/free(3p)/free(3)?

Patrick
