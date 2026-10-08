Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2418547066
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 04:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791435465; cv=none; b=uDjzPUEp1kVPrJV2lbOVLVW9fEyZo8XpYWot1kpOCUpV6qnrALR4y2v6oIy/nFPOQq+O4FBocybw1izbZ9DZ73MTCoR7peDSZ8O/09KwgDovAJkaCO3+xYaWjmav4xAepgrEdXzEFmdlOgoRjbdHjXhRFOcSfkcK1IZWqKFwpro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791435465; c=relaxed/simple;
	bh=2ulXXvXpRT+xV3OmyezoSB96g73ivSAZArrJ7gr+V6A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cPlwXVuwooCm4tSeOvgUIda8rt+yVy4p7wvhCEHWULqVpMhHhB0mhck/R1NKmvaqkTnOgHuzE4+0llMYjfsfkzGX1SJu9+ILEao+wChgroEzygcgI8+oCwRvzhPoS9qA34JFZNIBkk/WDF4qvZu9txYOC34UgwK+JLtT/rhJDhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=C6ZlgU2a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Tn+BIMx9; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="C6ZlgU2a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tn+BIMx9"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id EDCB91D000B7
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 00:57:41 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 08 Oct 2026 00:57:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791435461; x=1791521861; bh=TFyhMA/C9m
	VUIhYqppPZSnr57K/Uq+zjCt/Lo2DZUnw=; b=C6ZlgU2a4B74AktfQhgRgf0eMb
	Bu/2yoRb+xpzv3XQHyk5Ok6RV6R0exQZbop+4iBHlPMOaybFZIgFc8lruBjTvRbR
	LbiEPJ2GYhQB2WbZ6eb1qVlLCbOqadDdvZJre30UEcW2SM8NvJdzsPp6VensSG4Z
	s25qH+0wN1hdzx3+nWjf+uh1pYvmuE76LtUVXJ3IekXA6eJ7+aYhwCgJyHKr2b1Q
	McglMP628rgZgzVZZTVWeNIT0yQ5Y4Q1oLQs8/9DY3CgNVyYdEljyg0ra5p2qRoH
	t1yXgJPz5YnfIR+p516symXYdMdTvzEcX84TkyrUqMZ14Ds6uvVajTFTXVRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791435461; x=1791521861; bh=TFyhMA/C9mVUIhYqppPZSnr57K/Uq+zjCt/
	Lo2DZUnw=; b=Tn+BIMx9rEyNnMOYPdqZSQMcrmYR0/t0pbtMA/V7tw8utC/pNlU
	U0LatpdpybeC4b+DuLchDqMKmBjLSaiB6uQwY5MRmmBWQpN/DQ+UaN7Q3RcP8VZX
	kkHHVi1U1z1H0gY0sw+Fqm/fVz4Jbxm26iJBXFzHTRhQXbPqqptvX4l5i334kjO6
	QmDBQXxRtf/PKnoxyao28mLpSq4ug05Y1PA+vKd4p7UTtNAGnZl7+QkQvPYf0gj/
	qaG57po+bwRvLgIBnWtL8P4MnDu75O7b2FsUChgqO4b46fnVu/Zsz8tssHsWdyDe
	witlvpIafEtTZKU9cmjs6UDAdS9fYHx1ghA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791435461; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:mpygD4tw/b0YUSkJ22+rRqqiK5ulPpLFi9hYg7J91NzlvJC
	gdPj0oScuaGv677MtIvHmo06NPCXJm155o1oj0BScllVgjq0RQ/i8r8E0rtPEuHf
	Z329X6b58WBq9DL0V5dsJGWCqJUEboYVAdNHrdphp0Ygmb8i/9qbUy9et1SaeHFE
	vCatA5++rDcCRsjwMLydnbflPyOAw/IzFEFs9XMDwkTCOQwP+SzDqYOuUpkZ15PZ
	CM6hXe4crJzMVVGimSmzrU/e8muKrNxHXW8y61Zs+lGE+w5mNjqlz5mVUxEIumi/
	sVAX7Hgg2hzYiWWM5itFzrnjbofGamMLOiTzyxA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:7OfcDrCXcjx5hQ5P3nCJVsnAWGWo3HGiR6/34dpCP/g=:2ulXXvXpRT+xV3OmyezoSB96g73ivSAZArrJ7gr+V6A=;
X-ME-Sender: <xms:xSLHah6LFMCpN7Lej80N0FbimDqTM2gZ0Y-P2h1uRKC3kLresi_JWg>
    <xme:xSLHahI0MoBAIcK8ob_q7NHxJ15kO41G4ZR9U8w8qSHwMqnpL2uCdD8JNXwfCx0yT
    fGrO7GoupRe3flhYiC1oIqVkcpg8nkDLeZncNzAiscNUoTRnJQCvcY>
X-ME-Received: <xmr:xSLHaqszBDgwOsTROE32QdeMw4vzQncK_MEwo3vasUlUZ_zt07GozoKBJuVXFHKx2r1F6LhNHs2P5nUqhYGnxeap1bBoGD3QsFMu>
X-ME-Proxy-Cause: dmFkZTGas/kGfrT9A7WSqR4UJXAeUBk6Pi3+eAtiKM0INTPa1d6TK9Ap+zgEk25ibJ2qWb
    7VV376pBpKHoJtLlshaer0j35gUciGL0t6Ve/6+R3Rs/1+vHnm8mdf6PYeOqLM/D9UYJXV
    YhejVIXnVQkbaAeUdvzCEkYXCH4EXVUaWNDwpTGEm/m+yx8NvuCzq/b0N3n9NCQKqMhKGu
    Bj1b/eLdT4KcbslyMNRIQaQCuhYk6a3htcpzAoMD/XvLUZe2YGSIncYS5wloW+m5hRo/Um
    gf/VL64dr4BNPwid2QRumUWN5x1hztM8cCY6XwGFXZnWYc3Fb2OUKlL/obDG7hO/ZqaZbV
    1eawB/cH/Pgw4/c6J8r4iuwRySDUHwUHrN5luU+IQueFHN43iJCxug508OapdOCokr7McZ
    zl2pbQFCkg0gTFX8B6JpFIRk7epyeJ1rrK26EIX0porUZbWH+xHoguvs0unx5hBvXZH8SK
    2+BSi6vp95MJPSdZc6EUqnJBAkPcy06YfLsPkjGwykxFn4lcd5gDZjOKAF9dPOhOMMLeqG
    c+KLyxhrLQcJCQac0+LOcxfMard6anoqj+X8OPMSkPRN+mZTut1gLkLiX1JS6Aa8rPoOpB
    lKom/F5X5HK0h0Q6XPuo9iyeqDGsYwR8AJqK4oVKrSaP36xRzAaNzAY2/9Aw
X-ME-Proxy: <xmx:xSLHagIQiRpKxcsj1h7Lx3c64vH3DG19m3VPCJbSp4HUsK9GDs0uJQ>
    <xmx:xSLHaj9xSjZMueagNj954B9TOmb_rc9U_nrP1-JxkKqMfqGwfTokmA>
    <xmx:xSLHapwx0lk0hp6gzRjORShc0uKiQh9wCRa1pDuNHVfgOm89sL15SA>
    <xmx:xSLHag6ju4560ysxd-VQAG6No_nsu0HdcdKT2XeAjbMjGHISR8QDww>
    <xmx:xSLHapNGyXR_LQTAkN345Vp9XSisN7scc5DcxhgwsSmvvHX1IBYwodwT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Oct 2026 00:57:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: graysongordon-gl <graysongordon1@gmail.com>,  ps@pks.im,
  git@vger.kernel.org,  peff@peff.net,  avarab@gmail.com
Subject: Re: [PATCH v7] http: add http.sslVerifyStatus to check stapled OCSP
 responses
In-Reply-To: <xmqq33uh8jcv.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	07 Oct 2026 11:18:40 -0700")
References: <xmqqecfez7ie.fsf@gitster.g>
	<20260915162348.97792-1-ggordon@gitlab.com>
	<arQ/nOH+o3XwQFD/@szeder.dev> <xmqqwlsb63o9.fsf@gitster.g>
	<arTUNYVvCNwX1pDp@szeder.dev> <xmqq33uh8jcv.fsf@gitster.g>
Date: Wed, 07 Oct 2026 21:57:39 -0700
Message-ID: <xmqq1pa04wn0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Well, I was bisecting between jch..seen, making a wishful assumption
> that there is only one topic to blame the recent CI timeouts (see
> [*1*] and [*2*] for examples) that many linux-* jobs spin forever
> and time out after 6 hours, for the past few days.  I finally found
> out that 'seen' with this topic ejected, even though it seems to
> fail jobs that depend on older version of Ubuntu, does not exhibit
> the time-out-after-spinning-for-6-hours symptom ([*3*]).
>
> So tentatively I am ejecting it out of 'seen'.  It might be some
> funny interactions with other topics; I haven't tried to push it
> alone to see what happens there at CI to test.

Now I have tried the topic in isolation, just to double check.

[*4*] is the CI run of the topic alone, queued directly on top of
Git 2.56, that timed out many linux-* jobs after 6 hours, which was
exactly the breakage I was chasing.

The reason why linux-TEST-vars and linux32 failed is unrelated; they
are failing to download long deprecated Ubuntu 20.04 and CI jobs on
other branches often fail the same way.


> [References]
>
> *1* https://github.com/git/git/actions/runs/37377476653
> *2* https://github.com/git/git/actions/runs/37568540157
> *3* https://github.com/git/git/actions/runs/37662034989

*4* https://github.com/git/git/actions/runs/37673759531
