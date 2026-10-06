Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C79C3DDDDD
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 14:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791297451; cv=none; b=llxiP4QxTQ+JyxsYY3+Jd60/IlTItHpQpbBSOMMoGp8E6rOGPCMkGI7IYBddykgLV8BarxQM9zL3VfTUQe2orMGGpJKjxnGPPQoJ+XCu8dQG2+W+n91Hv27wqPZp2EDYkYN4yFd6XsrgBHF4fc+5TqG6YMf/a6dlv+gu5rvlz3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791297451; c=relaxed/simple;
	bh=wybbCgzqo1vjG5kZ6z7iepIYlIzN4C9klfgveTbOyQw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ESK3MnnhWJeHQjAJEoXX83sCZ4gLVvCXY3I0p/efGpEIulko9Z8el8JsQj05aEtBcLEbdBJ58knCqOJnRWwyyotNK8yJqJzcar221bCq7rdpRimTcd/kRRsyx7zpteFasM6BvYsDZouuWN3FbGhNSjdPf/S6huTeO+vkezXzO2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kQH+pmib; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r4qgBmK6; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kQH+pmib";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r4qgBmK6"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 29A5DEC15EC
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 10:37:29 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 06 Oct 2026 10:37:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791297449; x=1791383849; bh=2M0KWfpBxh
	xyxVqNowJq1MIffBlE412DwvybP3eSM6U=; b=kQH+pmib7u6xLUnUETTuNaMQ9O
	pLBO9FgBSnZ93cJxJneyuW6Jf6NYyUl6B/dp1GPApEKkjxia1eIdjRq+6TtqIP5Z
	JPqqHt2KfGCzzoGQHWcUH++5v+OY3iwVQX278x9h/YWtWWcsWJBKjO2LVmeN+Q0L
	WoH9PO6belfS7PJFcHuvPU2259ncjvV+UTddmLaPaYyGwnv832Iu5BwpwmYms3Kn
	uhcvkiC/j7TzSmbzOwrWYZLTKFwJsp2LIOq8RW1JKQUBAEdOQA2WtInFwTMKBAUN
	omXOArpCFjHlmg7irLrby0C/qZa5PIQgino/C6croTQyNQEfyen+JlRYhIxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791297449; x=1791383849; bh=2M0KWfpBxhxyxVqNowJq1MIffBlE412Dwvy
	bP3eSM6U=; b=r4qgBmK6mSsJ9dyV0MdPmXoNRkS3GYXKOtyAMtODmBrJLaVMeJi
	M8W79xeRurbk69PzSIdsORoHyqKiecC4j5RDQbKwALo1KawoThHPrXifMR+hl5Jw
	j0IBquVODXSU2m0STWp9aL/EarOXt2Uau7lKDIJoj9QwllGlhs/aD8rMAd68LOip
	tD776npcth2w8CACwkXfB4FyAnZ2R94sPwamWVC8T2eh4PUzi6FLUCRkAtOqpv2u
	qdJJdX6CLRFdPfJvgUQ+jSM0ZK3iC1z7yHxUHGhfTLbx8I3tGe9ljzBjtO6cn3Gn
	TWEJj+1HyKrUjm2Ro6E1VppqBPLwHYSZd1A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791297449; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:X2w/ZByYyNP0eVUagM61D2tG152vVEXyaLS452UbJUmaH1k
	44NXr1VGGIOIYfcB6WglZmxUmaXGoGfWm3qRq2O5owvZCv78XmOuowKsiE15tR4/
	wj4hZH2Kp3dryqq5x55A3pEmZhUW3TVgvZCU2iQlsIb76Q6f3BZt1t5tNKGK1Eb8
	gueQ9wogjrQZPbGE7KKdE2pyqUmlqMnQ9SKAb/o9hOinexwvafrIQQlNTmoRfyq/
	D3m/cCqGbFTuQERRTteWgTMzp+U1gmXhfE/yR1HtNpfx4909/kCfB18mEXEQ7uYQ
	j0K4BER4jbWsDuy0nV5a6vzasBYOPgrfINOyrag==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:SCgcCQ7A6rRdlIqWkuuJ8uQbmnydlPzlXG9ns1+T+DA=:wybbCgzqo1vjG5kZ6z7iepIYlIzN4C9klfgveTbOyQw=;
X-ME-Sender: <xms:qQfFagHanLmf1tzbHiQA6Bkepll6XVw_ccVAmFvc3P63RzlKs4QDUQ>
    <xme:qQfFagV5wC2YH08hxAwxnfmd4zX8IE5Q1U6QV-YURq5gFEpuTry5UXkjMXcWns9Gd
    c7akZ3eKF-Zdg7NNHWBirK-DeMR_8tfxu1UzvPwi2ufVAHFnlvzyzVp>
X-ME-Received: <xmr:qQfFavISNLy13-8NK7XHTecWcv7uGlhZZUKVtpN36kW6tV5YaUbKzPkozHK1pZGQNjkyltteoEKWPw14Ox3BKRJYwPLOcIQ4NbHC>
X-ME-Proxy-Cause: dmFkZTEbtuWvgvB0IpktlQB6QXrliY75bXIgfDnjBjujZqer4xwvtUkx0XpMLLy1cxf1sS
    a8PxPHFJImRC9rdC0Rm7NxL/ZqK8AKXQqlS41ny8Aex6bbsATanqm2prhWa9eHyImyF/aR
    Aps2h9+05vD47eySlHv9+HioVGU9Y+nxFeTMU9kYoYGpO2Ky2XLFvUxwBIUqGBOZH/SBpr
    /zh/idhsMsVtB9MBWV+8rYmt/MwRMkKRV/VfjcCo5ZVZtCBmoPz9GeaGoTbcdzfFSJYvTH
    Ve/pzkQH37+0po/e9mT5bGZc+4h1tCUhINoZ6pXjtO8/KPatBPxAeIbQ8vhBDG4ad150Yu
    R9u81b26SqyP9YLm46Wz3Ircp1BhEcTTLr2qzgrOVyY2yNm57KW7hn1lN/w6n7fGA3MOEa
    1wmayZNyaE7bJqmBvoq8fN9XPlKc3tqgkRvyyFJ5KKLuht10awmKnDMZwYq/fCbbq8wf+u
    wiEYJJKrf54ohWH1nRQQxfGV+bLh/mrD3p84xzhbsk+bzokwM69wgy1MWrJEtK/zLTtYmS
    Xv9mhwVOQsaLPNXVIc0RpLdj/Vlrvn+Bf5Yfdmw9JIqJRy0a8zUkI6LUxRnsgK6jJvh/lE
    QEJWHZ49jcHvqQtmY3oxt+e9cb1Eu2Pu0p2wldjDsm4ztIiR/R+Gh2m9eSoA
X-ME-Proxy: <xmx:qQfFag-LaReTs4vQ5EjgKcDwgoIolIf-4aIHn6B9NkJVHp7pCvrXfw>
    <xmx:qQfFaiLl9KtB6oGT5oq9tSZBJM8LHO-7I-7QC_sKZi9vrL0TzIhNSQ>
    <xmx:qQfFallpEENU8LKAO5OYmR1aYlA5RPfBGU4AAlFuoSCnQD_PAHq5JQ>
    <xmx:qQfFamPkmSDUba80C9Pml8NlpxP71HLxoLm03-dh1OpQXXS9nJLSvg>
    <xmx:qQfFaqqbX0swPie7iQGQhJcS_tgswOPczVg0ctZeKrOWcQ08PZ7jkRMt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Oct 2026 10:37:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Devi Srinivas Vasamsetti via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Devi Srinivas Vasamsetti
 <devisrinivas.vasamsetti@gmail.com>
Subject: Re: [PATCH] commit: warn when a new commit is dated before its parent
In-Reply-To: <pull.2235.git.1791212998072.gitgitgadget@gmail.com> (Devi
	Srinivas Vasamsetti via GitGitGadget's message of "Mon, 05 Oct 2026
	15:09:58 +0000")
References: <pull.2235.git.1791212998072.gitgitgadget@gmail.com>
Date: Tue, 06 Oct 2026 07:37:27 -0700
Message-ID: <xmqqld8agajc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Devi Srinivas Vasamsetti via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Devi Srinivas Vasamsetti <devisrinivas.vasamsetti@gmail.com>
>
> Git writes whatever the clock says into the commit object. This can
> be problematic because history traversal assumes commit dates are
> non-decreasing. For example, "git log --since" stops walking at the
> first commit older than the cutoff, so an out-of-order date hides
> the commits behind it.

It might be annoying, but the value of such a warning is unclear.
If you clone from an upstream repository, you might find that the
commit at the tip was made on a machine with a clock set far in the
future.  When you try to make a commit on top of it, what are you
supposed to do?  Wait for a year so your commit is newer than the
tip?  Ask the committer to correct their clock, redo the commit, and
force-push?

It also does not help if the commit at the tip of the cloned branch
has a timestamp in the past, but is a child of a commit with an
incorrect timestamp.  Nobody would receive a warning, yet --since
may still stop prematurely.

Stepping back a bit, suppose you clone from upstream and obtain a
HEAD dated 24 hours ago, HEAD~1 dated 72 hours ago, and HEAD~2 dated
48 hours ago.  A command like git log --since=50.hours may stop
without showing HEAD~2, but if you suspect that some clocks are
skewed, there is no way to determine the correct output from these
timestamps anyway.  It is possible that HEAD~1 has an incorrect
timestamp and was actually written 30 hours ago, meaning all three
commits should be shown.  Alternatively, HEAD~2 might have an
incorrect timestamp and was written 80 hours ago, in which case
showing neither HEAD~1 nor HEAD~2 is correct.

The moral of the story is that --since or any other time-based
option cannot be fully reliable, as you cannot force everyone to
run with a correctly synchronized clock.  If you truly need to
know the ancestral relationship between commits, you should avoid
these options and use topology-based ones instead.
