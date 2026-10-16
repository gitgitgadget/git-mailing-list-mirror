Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A291FCFFC
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 21:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792185052; cv=none; b=u6LsFoQrgGEEdrm8UZ6aRbOF7+2yC/pHhIweIfve6/AwjsfMhrky2YyZUZ/kVcFYqaSayBooKXLld3Laj/b6oX/eUsVhb/A9NbHIM5STGTjTaUFJwQGB/KNrJ74PmgWT+SiAMPahq+N5pU9CzJzTwe1mhU+vZRN86z+WPC+GJJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792185052; c=relaxed/simple;
	bh=JjQiJVUurs10zA1fylbjxBFfV3/kBM2FQaVslAlUPic=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T0PfwXSYB4yJU7e45a15F05RK1bunDt8ydRDaL6+0/NzbQcCZFfo3+2mquKDWXrl8X+dzRP/bGNgcSl+76i5uCbYMO3sBJ6/JwTZGyvG4hn9xg1Lyp7+dHO2mX1Iqt4uZRyH2fa3KSrNNgJWUgZnjc0rjetXMn4pajuD4I303yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dk6n4GRu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pjHMiHuH; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dk6n4GRu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pjHMiHuH"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 973141400133
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 17:10:49 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 16 Oct 2026 17:10:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792185049; x=1792271449; bh=oKUAuEzFGt
	YXE5wl2d3F/u6EgMg1PztPj7H6zMD4LNs=; b=dk6n4GRuR6QTTaBAHcZzvTRtfi
	CTM2Zow5LU2GRR2YXZwQWQeNHN6hDVRWQRQ+ObQi69+IxnCqA7HhZFzsC1LcyTdT
	sdpPp1fOUXrtpaCkxXdIou6kC+wQ2s29PMfi/LlANTPG9/Y7T7Tbey98rQrefVbC
	ID3963qp5JzEkrouEOFd+N82RMrXimvM+juvRm6t+fePd57UmkZmq6tGsaLrLlwe
	Z2BhQl3e/LYrZWvlc0T2o1/+TJVbuxoJaSQJp83zS/muCOMkuL3qoGD1NKxn45Ba
	VFZCQYJi9fKW3wAvQgjon3L/3NIPhdI9jmt1iG5VyEaOjB+L2qMwilaFbing==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792185049; x=1792271449; bh=oKUAuEzFGtYXE5wl2d3F/u6EgMg1PztPj7H
	6zMD4LNs=; b=pjHMiHuHjG0J0xuR8dbzFPe9PE6yYqOwl4+NyVCeT+8lvOZxUCI
	SawxhXo+sp+wiwiUOjv7h6KQiOVVwikxIFEdJhTKyGpEUss1qO6edYByn6/AVs0V
	2PDTL1KCzsA0z+Q3m+Mb6dwxm3/kKEsmXDcvdCyA9sMJkWpkAat21WCWwc5nCCBc
	dUIT+xrn51pxNg87bnC1ouKzPu0OOEqqfx1o4FFQYu82tmUwwvBbLelg6tL1J8Bn
	f2JZdsdJsixVr/ZRMs459KlJ6/T/aX4jpB58KOJhTThFvHJUnytNlZUaV/N8wmyD
	yqkGFDDOdwr37Uwo62zt0DsbrJ71O8sR84w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792185049; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:k4ufmpUJsWYovwHbKnkMa8HWuce06X46l78o+VlVyhqQ+Q7
	v5Jdcx7025LfBuXeAa7InRX32cZYXjBQoW+9lSQ2gd0B3JjxS8/XunsOvRHBJY6i
	7arU/qvzayvJeaH7Bb3CY+aQXB+qxul9jT0W9Xw68R+d2ZgHkp13GK+Qpcvv6xiF
	ZIO+NxxOfR+UaPIK03QvudVxj3eSjInoGv0d0Qy0HX+2bRZV5hWvxLf+ILRtrX/G
	SExCTM0yhWTmnhZitjBbe4JO/23+krNtOGdOZx+zUjRE5ulAKVyoLiLFiZR8F/B4
	FI3b+l1bd6ptBRnj3SyGpDoTucNNY9U/1Z0Nr5A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:p5isSvFVAdbUQreI1oEl+dhSV5XQllzJYyo/xxddBgc=:JjQiJVUurs10zA1fylbjxBFfV3/kBM2FQaVslAlUPic=;
X-ME-Sender: <xms:2ZLSahv9l68_H_VPOQ9-ahDEddpv2_1i5Lv1Fp21lwzYz4sq8mi-KQ>
    <xme:2ZLSahXtLSui0icA4wdq0rjAdyQlIYMdjTRfB1ITFIDLLgSZJckMOISbT7PMFAYfQ
    X4qtZ6OHU5d1dk0PJTrvtqJHz7pm0dazeXXLQkhlQUY_GNjBck4O8I>
X-ME-Received: <xmr:2ZLSatFi_Q342qmg4YaiLfCP_r6BewYFFFeRx4LBF1boIYUgofhSH9B6TthhOHp1ms28TLvNjYuSkuxl3axi1-uql7FMdSOlHcoq>
X-ME-Proxy-Cause: dmFkZTGxv6O5vj16zbhbfwSRYL1OJU6N6nQEaRkpXnUNC7IUiSPGtfGG1sVi96vK2Tj2/9
    mFcG7iXoXfEaGmR0HsWagQkCJb5/LJ4peqZMia+312FGjdCkxDIW6Pa2kLP+tAujZXiEQJ
    LGhi3hRAKTwzMChv5nRE2yAz35XnpSs1bebWRcj/g0Eiai39+c9nnv3OkpwagAxiKAt4Fz
    /NMONt+fImNBG2OHIItwdmqb1rToPl4/PyLGKM7tQLUA1YtOirot/oLBqZDQpM6a2cer9G
    +kwUPTfKTLgRMDTbn2iPZt3xDsJls4/ukPF/RfY+kTUbZLjaB5nDnKqzJ2x8NEszLyHfjB
    81yMbuxi3tj39oa6HcODDMCHqxF5liUg6yh75Fj3DqRCmEe/ZoRWXfzl/vn8n3qD4tU3uY
    z/Q3Tg07ThvqoW5UMRzPWheMVrUWo/cGcWtz/XITD+jmjZ45nSSPKE+5NLocwwfVf/BBOT
    xj7RUYZ1IXLX+Hqz8lFHR00yaqG/w6Avasfwl2h4WWYpFWdNcy+1IdRIwX5z4M9EMVZVAe
    93btzP8okf6Pz1kM3vrK8hcH7nSL2WuQpu3LFkmLf5ATHLWBq+P1t4Wj/mjvGqDLHOgqjX
    nIINAoZ5jMn0hh5jnY+J75x+XbnCmCjFVSZFyZeJPewq4jZBPz2LAt/Ikp8A
X-ME-Proxy: <xmx:2ZLSaj0D-HfBJH3f-qcdi8IsFt644qBjKNMfn_bM2Z4Zmr4vjhOe_g>
    <xmx:2ZLSavPr0_6pSESslMns9eSk3pRF9wv96uDOwg232skP5C5We4JZhQ>
    <xmx:2ZLSai4iOCiJ5AFQXSwcOFqbwcG-2GlSOelAPqXKWRFNrslIkpFfdw>
    <xmx:2ZLSap0pPUsPIQfOFhM3opNm2mu2YF7QB4ijkeQXrqB-WBEbc2Yg5w>
    <xmx:2ZLSarHzpnRR5UQ0B0gc44LcrvWsODB_ltHbedekfdNqZC9udh0QlPP1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Oct 2026 17:10:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v4] doc: checkout: rewrite detached HEAD state explanation
In-Reply-To: <pull.2250.v4.git.1792177409868.gitgitgadget@gmail.com> (Julia
	Evans via GitGitGadget's message of "Fri, 16 Oct 2026 19:03:29 +0000")
References: <pull.2250.git.1791384721919.gitgitgadget@gmail.com>
	<pull.2250.v4.git.1792177409868.gitgitgadget@gmail.com>
Date: Fri, 16 Oct 2026 14:10:47 -0700
Message-ID: <xmqqh5ile4h4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

>     This is a pretty quick rewrite where we didn't get any user feedback. If
>     we really want to make sure it's clear to users as possible, we should
>     IMO do a second stage later where we ask users which parts are unclear.

OK.

>      * It's probably possible to explain HEAD better. That seems like a big
>        project to me since HEAD in Git is a very tricky topic. I think it
>        would be better to address in a separate patch series to have more
>        time to think it through. Or if we think it's not possible to merge
>        this without explaining HEAD better then I guess it shouldn't be
>        merged.

I do not understand why you need to draw a "take it or leave it"
with this topic here.  If you feel that the explanation of HEAD is
iffy, you know what we have here will not be the final version, and
you think we lack the capacity to reach the best possible
description with the usual review exchange, then I do not see why
you have to insist keeping what you initially have written.  You can
replace it with anything that is better than your initial version
and then still record that we will further polish it later in the
proposed log message and we will be in a better place, no?

Just to leave a record, so that we have better chance remembering
the suggested improved text, here are what I think the first two
paragraphs should be replaced with.

    HEAD records the state from which your current changes started.
    This can be a branch (the "current branch"), or it be a commit,
    (in which case HEAD is "detached").

    In the detached HEAD state, you can safely build, run, and
    experiment with any historical version of your codebase, without
    having to worry about clobbering your branches, and you do not
    have to clutter your repository with temporary branches.

Having said all that, the changes between v3 and v4 look OK to me,
so let me update the previous copy I have with this version.
