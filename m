Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF10723A561
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 00:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791765006; cv=none; b=Qvzw/FP77leTolc6/Hb1nL596ktN9bECzBG0g+tS6xmZKoGNyf+lYplpYW0IF20fe2PlNisuMK0TCYt2vRbdgmelG/mPSBh2PPP1VPZF2uqB7pmruUYkNuG8yzqv4W7LWity5Ar/ibpgRY33i5AxoK6iPOIEJyM5gvod9oWt4Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791765006; c=relaxed/simple;
	bh=ZzCepFLwv48tii+ckxNQ1DlHLLVVKgwQy/l/JeBzjm0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y1KrDPl2L3NkWICxLVJo0qp0WXp2jrNe62JTAmB3zrlHj0aocPpebrx2UO00XOAaZ+5g0n6KxNTvqAzyZShm2kjd+ERK/Z3weT13B1y14HdQM5TMMXWLs5behYYbhe2Y1sc4cZnM7gXFfGC4sECrUH3xzHJu4C8SZjKCJs4f+K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kfKO8Vuu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ptbJHRH3; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kfKO8Vuu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ptbJHRH3"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id E988B1D0006C
	for <git@vger.kernel.org>; Sun, 11 Oct 2026 20:30:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sun, 11 Oct 2026 20:30:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791765003; x=1791851403; bh=5lUDRg2jK4
	uPqkEdI8gYWYka0/iNKIgGVYpnSSrCeS4=; b=kfKO8VuuKXVTLezyXWt20df24p
	Zq1XREs118DslPgQj+bkSCAnSMk/82jufQ85eTJ6rug+4jYCtGn4L0JpEVi26WWg
	7Xv0dOlIgTZMhC60+zZH4boFgQSRU8hy2U9RQU1id3xaUmGJ/x8LFq3C7jdP3izx
	LA9dMU1pQTib4d2edLdvNi6ogOlOYG5dJNnQscQ7yg0XGSIcxJeCTasBvi0hS2n6
	HDbTQeO1DYMBWheBI+u5V3FEPFTbwb3sDwrTRuG9nfCu86csU/ggjQ4mlZATQ5pu
	AhD/HNqmcQaRCrZuaYJy10exQLgVzO99qRJ99Q6oPkeE3V5As/5Pz9DnX3AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791765003; x=1791851403; bh=5lUDRg2jK4uPqkEdI8gYWYka0/iNKIgGVYp
	nSSrCeS4=; b=ptbJHRH3btQkJhXLPxU+OiYWCxIHI/XK6fhXq+GJcdc8oTCWfeq
	WJ2wD3+XGW7cB4VlAfLkqdlDNPDSjZDLk6EE3gCI+WT/6Xx9lqUV+1JwQH7vLz1w
	vafXpzCkH7Y330kiAGNu55In764stozGRwy7xtSSYGXCjCKaAtBnYOE3QfxMqv0y
	huJoSIhXzJK+6H3IygtHkR2iSjstMnMZm8eHK6t4KICJqGU+P+CvP8VokJ6Vjfs9
	sSrAKRbaM8HO+5F+UoBYbUlurk6dXuAPD4ESUtGFLxPcEMlUQibpTDPMafeDQ7z1
	HSYCljZ8qd4zLZ9lOjEG5HMtZKmbAc1DFpw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791765003; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:KktfnZasYMd86CK6kZW3FrKeiRx0cb6KKeFoJ8oCTvR2Il8
	1M5MhOCvOPuenmvwttufa+EnTR0UT3eeGC5uvdbuSVhvSZKbGCTBwIwCvXgQu2co
	ph3OTbA6K/pDhiwlkBqulTkPTVZFbakxSjpMaQLrrjbtxrWb74kgZhrR8U2kBKbf
	5NkvEwIV1TY1M2EtrOfgaT/rgcWh3icS8PU5NuVeNNvDhPuLFoRJkvyhRJRxVSFV
	ouQWSmH5G2ZirldRAyRRsRIQ+9S3jBGdo3/xRLjKwve4o3ywACT1lfYRxoD5zLSO
	nK8JIdAb9EejYRjDsE7TNpQUk7JPBQUTnpM7c8w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:nKv6iNLy9f46OzTBWzZ/1BYIDRytIL5RqVD2E35z154=:ZzCepFLwv48tii+ckxNQ1DlHLLVVKgwQy/l/JeBzjm0=;
X-ME-Sender: <xms:CyrMaljkDqvCiUX6c4XCtwYQnkdz7M6K1Ym8tvPTD7wPpK58HyBNug>
    <xme:CyrMasRNbAYM4yCMjTzcEdyiVO4Evwa9OgK2D5_buxpG2Gzs8824jzB6sMWXvh2Zl
    NzSC5BHc-EkW0XTloBAMV4TzS_M9Iu-gu1fkLNGdUxROgN8o7iteT4>
X-ME-Received: <xmr:CyrManUQ752hj75XHHRF54bk1u9fD7ha1qZtijNMnsOFTniS9GSC0yPLadVaLMCgBZBDB8ta24X3Vv4eXbwCy_mo_yYmdk2ujlgd>
X-ME-Proxy-Cause: dmFkZTEoknTvPCiLlAly4pPctjTCMUcp4PZEgXLKdfJ9LY/R4z2uMBazNGiG9hzziJlNC0
    POzOfUiwoHAFPkbNsZk4mkikCrqs1LTlzJuF0pVXojZxF3fMHApu7ypjnK7QcN1c2sYrXJ
    Ebt+pVf3uO7wtKwu5501WAY6AGiSbe5mIrFnDk7cWbtmdbYoFMAntX9ZBh5IBblC3k3p+J
    iBICi4duy2CEjvDa0pEjesk4ez/M1ndFSe3D4yR82bEYHB2bVFpSJ8xEsV0srnsFC/PQRV
    EpEikqM/Qvh7pusardRxfjuOoSAfwZtl7+SmivT+rWZwxEE2O5ATCBx3LlpFrolQpBdARy
    kxopsGiYdSS4BjkKNFDf58Rd2r2yxGUa2r5Fk9yBbqX9zWAwfjPf0RFwkKvRlQvS2mAx9U
    sbriGM2MLDi+LxR/0c1MYXE+gc4OBmYsYhAA73JuvVPmZrOsePlK7OfdA4Bp6ujg5FSa79
    ckk1+MLWr4CvR4IpjP6NS8fn7ujzc8jvfcv2uVX7F0Durg/9PnbvjuyV1/dziu2meNyN08
    sEDX2XlrlJ/4A9p96OwGReU4ITLDj42NMuqPUpevmWXF+YbUif6SKbec77LftNrVPaC9Sv
    RKqR2HgDzHYwhZKxfxIFh0Jl0BdkhF7QCPkvwffuh2STVzneLFzq0Ryh8bQQ
X-ME-Proxy: <xmx:CyrMagSOHjjRAJwa9Hgs49tc2CVUuTqCZ933O6_Kjvr3mwjplo6avQ>
    <xmx:CyrMahnk_gMOCPtgF-fZWa2K45r5EO3DoGQyvuQOWPs9YkemeizRZA>
    <xmx:CyrMam70zvtHgI4VYrGUBRC_9Pz5W1CpqdsgcVP-S6f3CiaTm83gFw>
    <xmx:CyrManhC-1O1yOs1EjbUCdAal38QC8Mkw4XNsese8nA_9NPZ37Dp8w>
    <xmx:CyrMajE-gH9owmH0XVX1-gdRcaYV5E0ru2hjPwymNJ4EBnMV-ECChj05>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 11 Oct 2026 20:30:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>,  Harald
 Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v2 0/2] branch: let --delete-merged find squash merged
 branches
In-Reply-To: <pull.2425.v2.git.git.1791711665.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Sun, 11 Oct 2026 09:41:03
	+0000")
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
	<pull.2425.v2.git.git.1791711665.gitgitgadget@gmail.com>
Date: Sun, 11 Oct 2026 17:30:00 -0700
Message-ID: <xmqq1p9vdalz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Branches merged on GitHub with "Squash and merge" or "Rebase and merge" are
> never deleted by git branch --delete-merged, because their tips are not
> reachable from the upstream. This treats such a branch as merged when some
> upstream commit contains all of its changes, and names that commit in the
> output:
>
> Deleted branch topic (was 1a2b3c4, landed as 9f8e7d6).

Interesting.

After rebasing, you probably can (re)use the same algorithm as used
in range-diff to match the commits and their rewritten counterparts,
but I wonder how "squash" would go.  Presumably you can locally make
a trial squash merge and probe for a similar commit on the upstream
commit.

On the other hand, unlike deliberate rebasing done during a patch
iteration, rebase done on the upstream to integrate your changes
would not rewrite the log messages, so matching the commits based on
the log message may work better than a range-diff between iteration
vN and v(N+1) in the submitted patches.

>  * Diff each upstream commit once and share the result between all branches,
>    faster than v1.
>  * Fix a branch merged with a merge commit being reported as "landed as" the
>    merge when another branch was searched first, and add a test for it. Show
>    the topic commit itself in "landed as" for work that arrived through a
>    merge.
>  * Use git merge --squash as the example in the commit message and mention
>    GitHub's squash and rebase buttons.
>  * Add --no-squashed to skip the squash search.
>
> Harald Nordgren (2):
>   branch: let --delete-merged find squash merged branches
>   branch: add --no-squashed to skip the squash search

This a bit unexpected two-patch organization; I would have expected
that the cases where our side and upstream side should correspond
one-to-one (i.e., what you call rebase-and-merge) and other cases
(i.e., squash merge) to require very different matching algorithm,
which would lead to two-patch organization where one adds support
for rebase and the other adds support for squash.

